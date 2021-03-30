Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5868234E23A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 09:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhC3Hb2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 03:31:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:24226 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231133AbhC3HbZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Mar 2021 03:31:25 -0400
IronPort-SDR: KWqsCyN/90bAP5BNkm4Jmscn4o3JGQsraffZ6MYHlxxwPAjzxD3lJcZnE0lGlflqWj3BiOojeb
 TtY17eMkB/Hg==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="255703138"
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="255703138"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 00:31:24 -0700
IronPort-SDR: c7x/pcWzvq34dYDlYvECbGrDbjnhbf9hSYAEqk3fSTk7qhunnERbK/71WLnzFAGkwgTmXbiO6x
 8Smkuo2gSr7g==
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="418045968"
Received: from xguo30-mobl.ccr.corp.intel.com ([10.249.174.220])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 00:31:22 -0700
Message-ID: <b5ad5909f3fb14b46d6ff0f81c10e42507a60c74.camel@intel.com>
Subject: Re: [PATCH v2 04/15] ACPI: table: replace __attribute__((packed))
 by __packed
From:   Zhang Rui <rui.zhang@intel.com>
To:     Xiaofei Tan <tanxiaofei@huawei.com>,
        David Laight <David.Laight@ACULAB.COM>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Date:   Tue, 30 Mar 2021 15:31:19 +0800
In-Reply-To: <34dd3de8-644d-6e44-965a-0991b7027cae@huawei.com>
References: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
         <1616831193-17920-5-git-send-email-tanxiaofei@huawei.com>
         <6df04be78e544e17b3b57f159312541f@AcuMS.aculab.com>
         <34dd3de8-644d-6e44-965a-0991b7027cae@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2021-03-30 at 10:23 +0800, Xiaofei Tan wrote:
> Hi David,
> 
> On 2021/3/29 18:09, David Laight wrote:
> > From: Xiaofei Tan
> > > Sent: 27 March 2021 07:46
> > > 
> > > Replace __attribute__((packed)) by __packed following the
> > > advice of checkpatch.pl.
> > > 
> > > Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> > > ---
> > >  drivers/acpi/acpi_fpdt.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> > > index a89a806..690a88a 100644
> > > --- a/drivers/acpi/acpi_fpdt.c
> > > +++ b/drivers/acpi/acpi_fpdt.c
> > > @@ -53,7 +53,7 @@ struct resume_performance_record {
> > >  	u32 resume_count;
> > >  	u64 resume_prev;
> > >  	u64 resume_avg;
> > > -} __attribute__((packed));
> > > +} __packed;
> > > 
> > >  struct boot_performance_record {
> > >  	struct fpdt_record_header header;
> > > @@ -63,13 +63,13 @@ struct boot_performance_record {
> > >  	u64 bootloader_launch;
> > >  	u64 exitbootservice_start;
> > >  	u64 exitbootservice_end;
> > > -} __attribute__((packed));
> > > +} __packed;
> > > 
> > >  struct suspend_performance_record {
> > >  	struct fpdt_record_header header;
> > >  	u64 suspend_start;
> > >  	u64 suspend_end;
> > > -} __attribute__((packed));
> > > +} __packed;
> > 
> > My standard question about 'packed' is whether it is actually
> > needed.
> > It should only be used if the structures might be misaligned in
> > memory.
> > If the only problem is that a 64bit item needs to be 32bit aligned
> > then a suitable type should be used for those specific fields.
> > 
> > Those all look very dubious - the standard header isn't packed
> > so everything must eb assumed to be at least 32bit aligned.
> > 
> > There are also other sub-structures that contain 64bit values.
> > These don't contain padding - but that requires 64bit alignement.
> > 
> > The only problematic structure is the last one - which would have
> > a 32bit pad after the header.
> > Is this even right given than there are explicit alignment pads
> > in some of the other structures.
> > 
> > If 64bit alignment isn't guaranteed then a '64bit aligned to 32bit'
> > type should be used for the u64 fields.
> > 
> 
> Yes, some of them has been aligned already, then nothing changed
> when 
> add this "packed ". Maybe the purpose of the original author is for 
> extension, and can tell others that this struct need be packed.
> 

The patch is upstreamed recently but it was made long time ago.
I think the original problem is that one of the address, probably the
suspend_performance record, is not 64bit aligned, thus we can not read
the proper content of suspend_start and suspend_end, mapped from
physical memory.

I will try to find a machine to reproduce the problem with all
__attribute__((packed)) removed to double confirm this.

thanks,
rui
> > 	David
> > 
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton
> > Keynes, MK1 1PT, UK
> > Registration No: 1397386 (Wales)
> > 
> > 
> > .
> > 
> 
> 

