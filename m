Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634C635FB1A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 20:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhDNSvY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 14:51:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:4142 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229726AbhDNSvY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Apr 2021 14:51:24 -0400
IronPort-SDR: F+nQzQcD4ibIUb8q0AQ5clb36Ve8rL6WxO/uxe0HmTASRhJNQ3CjyI3zsCJVAq4lQYD/QqU4UR
 p7g/1M19lJYQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="174814928"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="174814928"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 11:51:02 -0700
IronPort-SDR: N/Z7uWTWG25GI+a+l6wf/ZDt4RIRT12XOx7/5znwZdooN2gaSxlnO5PLHeSXra9NOy4vGOf4XQ
 6F6+UgCMYXTQ==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="418434379"
Received: from ljiang2-mobl3.amr.corp.intel.com (HELO intel.com) ([10.252.134.220])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 11:51:00 -0700
Date:   Wed, 14 Apr 2021 11:50:58 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Chris Browy <cbrowy@avery-design.com>,
        linux-acpi@vger.kernel.org, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, linuxarm@huawei.com,
        Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH v2 3/4] cxl/mem: Add CDAT table reading from DOE
Message-ID: <20210414185058.ls5sbp3cow7synqe@intel.com>
References: <20210413160159.935663-1-Jonathan.Cameron@huawei.com>
 <20210413160159.935663-4-Jonathan.Cameron@huawei.com>
 <YHcxChBDpxoopJT8@dhcp-10-154-113-106.vpn.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHcxChBDpxoopJT8@dhcp-10-154-113-106.vpn.oracle.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-04-14 14:14:34, Konrad Rzeszutek Wilk wrote:
> > +static int cdat_to_buffer(struct pcie_doe *doe, u32 *buffer, size_t length)
> > +{
> > +	int entry_handle = 0;
> > +	int rc;
> > +
> > +	do {
> > +		u32 cdat_request_pl = CDAT_DOE_REQ(entry_handle);
> > +		u32 cdat_response_pl[32];
> > +		struct pcie_doe_exchange ex = {
> > +			.vid = PCI_DVSEC_VENDOR_ID_CXL,
> > +			.protocol = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> > +			.request_pl = &cdat_request_pl,
> > +			.request_pl_sz = sizeof(cdat_request_pl),
> > +			.response_pl = cdat_response_pl,
> > +			.response_pl_sz = sizeof(cdat_response_pl),
> > +		};
> > +		size_t entry_dw;
> > +		u32 *entry;
> > +
> > +		rc = pcie_doe_sync(doe, &ex);
> > +		if (rc < 0)
> > +			return rc;
> > +
> > +		entry = cdat_response_pl + 1;
> > +		entry_dw = rc / sizeof(u32);
> 
> Could you >> 2?

What's the reasoning for >> 2? As someone who regularly does this because of
habit, using divide is generally a lot more implicitly descriptive.

> > +		/* Skip Header */
> > +		entry_dw -= 1;
> > +		entry_dw = min(length / 4, entry_dw);
> 
> Ditto here on length?
> 
> Also should you double check that length is not greater than
> sizeof(cdat_respone_pl)?
> 
> > +		memcpy(buffer, entry, entry_dw * sizeof(u32));
> > +		length -= entry_dw * sizeof(u32);
> 
> Would it be just easier to convert length at the start to be >> 2
> instead of this * and / ?
> 

Same as above. Assuming the compiler isn't braindead, I think it reads better as
it is.

> 
> > +		buffer += entry_dw;
> > +		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, cdat_response_pl[0]);
> > +
> > +	} while (entry_handle != 0xFFFF);
> > +
> > +	return 0;
> > +}
> > +
