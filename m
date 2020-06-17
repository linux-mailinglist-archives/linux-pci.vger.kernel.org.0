Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5704F1FC961
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 11:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgFQJBO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 05:01:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:29411 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgFQJBO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jun 2020 05:01:14 -0400
IronPort-SDR: gx/nfCAFI5A7yr97/E4VC+Lza9Unxfmd/LJ16odFuY/OhuPPDtf7aSDnHbXFNzN5Z+FBF+Tg65
 lJ4sgFpAa8Dw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 02:01:13 -0700
IronPort-SDR: 1EHO5A9ZzltPr6eUbyfMxiVDw5XQvHbkIJrhUmlOcYEY2ZpTZfSsRcFaOjpKCrk/N8UQUga00W
 QewxJ2djxM2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,522,1583222400"; 
   d="scan'208";a="383134636"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jun 2020 02:01:09 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jlTwV-00E1Aj-KM; Wed, 17 Jun 2020 12:01:11 +0300
Date:   Wed, 17 Jun 2020 12:01:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Shiju Jose <shiju.jose@huawei.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, bp@alien8.de, james.morse@arm.com,
        lenb@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com,
        zhangliguang@linux.alibaba.com, wangkefeng.wang@huawei.com,
        jroedel@suse.de, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com
Subject: Re: [PATCH v9 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe
 controller errors
Message-ID: <20200617090111.GC2428291@smile.fi.intel.com>
References: <20200615101552.802-3-shiju.jose@huawei.com>
 <20200616232019.GA1987909@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616232019.GA1987909@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 16, 2020 at 06:20:19PM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 15, 2020 at 11:15:52AM +0100, Shiju Jose wrote:
> > From: Yicong Yang <yangyicong@hisilicon.com>

> > +	if (!guid_equal((guid_t *)gdata->section_type, &hisi_pcie_sec_type) ||
> > +	    error_data->socket_id != socket)
> > +		return NOTIFY_DONE;
> 
> I think you have to verify the GUID first before you can even safely
> extract a struct hisi_pcie_error_private from the payload:
> 
>   if (!guid_equal(...))
>     return NOTIFY_DONE;

I just also noticed the ugly cast there.

So, please import GUID first (import_guid() I think is what you need).

-- 
With Best Regards,
Andy Shevchenko


