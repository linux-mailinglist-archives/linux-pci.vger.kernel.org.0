Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D4B30CF61
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 23:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhBBWup (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 17:50:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:9189 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233342AbhBBWup (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 17:50:45 -0500
IronPort-SDR: ZpBs0GNs6lLulBoEEVLxsFEHMQLUq1yCgermTx9vkklQCL08uRacQ3qEFHpdksqknuAksVjkjk
 3z+JbVEqigdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160112463"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="160112463"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 14:50:04 -0800
IronPort-SDR: EtegBuP+CZTsw6EElKMgS1btKjGjw5XViFBdsBaf35t1H+QRu8YiUxA5MWiNlkXSKxdt+SiD/P
 22BjzP3Qndjw==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="370992203"
Received: from aisallax-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.131.184])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 14:50:02 -0800
Date:   Tue, 2 Feb 2021 14:50:01 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 04/14] cxl/mem: Implement polled mode mailbox
Message-ID: <20210202225001.qgzwz53b2uhkseto@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-5-ben.widawsky@intel.com>
 <5986abe5-1248-30b2-5f53-fa7013baafad@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5986abe5-1248-30b2-5f53-fa7013baafad@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-01-30 15:51:57, David Rientjes wrote:
> On Fri, 29 Jan 2021, Ben Widawsky wrote:
> 

[snip]

> > +/**
> > + * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
> > + * @cxlm: The CXL memory device to communicate with.
> > + * @mbox_cmd: Command to send to the memory device.
> > + *
> > + * Context: Any context. Expects mbox_lock to be held.
> > + * Return: -ETIMEDOUT if timeout occurred waiting for completion. 0 on success.
> > + *         Caller should check the return code in @mbox_cmd to make sure it
> > + *         succeeded.
> > + *
> > + * This is a generic form of the CXL mailbox send command, thus the only I/O
> > + * operations used are cxl_read_mbox_reg(). Memory devices, and perhaps other
> > + * types of CXL devices may have further information available upon error
> > + * conditions.
> > + *
> > + * The CXL spec allows for up to two mailboxes. The intention is for the primary
> > + * mailbox to be OS controlled and the secondary mailbox to be used by system
> > + * firmware. This allows the OS and firmware to communicate with the device and
> > + * not need to coordinate with each other. The driver only uses the primary
> > + * mailbox.
> > + */
> > +static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
> > +				 struct mbox_cmd *mbox_cmd)
> > +{
> > +	void __iomem *payload = cxlm->mbox.regs + CXLDEV_MB_PAYLOAD_OFFSET;
> 
> Do you need to verify the payload is non-empty per 8.2.8.4?
> 

What do you mean exactly? Emptiness or lack thereof is what determines the size
parameter of the mailbox interface (if we want to input data, we need to write
size, if we got output data, we have to read size bytes out of the payload
registers).

Perhaps I miss the point though, could you elaborate?

[snip]

