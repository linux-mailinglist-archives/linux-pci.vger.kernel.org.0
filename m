Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A5D3503E0
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 17:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbhCaPzX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 11:55:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:47227 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235420AbhCaPzT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Mar 2021 11:55:19 -0400
IronPort-SDR: L5jsaMFXn6dsX5ft3xEkyqmpXC09OyvnnZ0D+WHC9TvsuJ0C7wCbAiIkPKid+5Yd4Eet0T/HR3
 CILnTiwUgLLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="172066831"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="172066831"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 08:55:15 -0700
IronPort-SDR: 1gs2iwEQ81BKIm8hX2KQBV5VrMdvf/QA6g+pQjH405jIVgm2VsMNlJhuTYFFAvCtoFTCqi1E9I
 rdbdX3Rg+2pg==
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="418734698"
Received: from yijiazho-mobl.ccr.corp.intel.com ([10.249.174.198])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 08:55:11 -0700
Message-ID: <e0d626837e577e60f226b8bbf354bd8cbb1fe40a.camel@intel.com>
Subject: Re: [PATCH v2 04/15] ACPI: table: replace __attribute__((packed))
 by __packed
From:   Zhang Rui <rui.zhang@intel.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Date:   Wed, 31 Mar 2021 23:55:08 +0800
In-Reply-To: <6df8e01e2e9e4906be5ceaea72c61c0f@AcuMS.aculab.com>
References: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
         <1616831193-17920-5-git-send-email-tanxiaofei@huawei.com>
         <6df04be78e544e17b3b57f159312541f@AcuMS.aculab.com>
         <34dd3de8-644d-6e44-965a-0991b7027cae@huawei.com>
         <b5ad5909f3fb14b46d6ff0f81c10e42507a60c74.camel@intel.com>
         <af3fd5adb62dcac93f2ff4ea7b6aff74d0106ac5.camel@intel.com>
         <6df8e01e2e9e4906be5ceaea72c61c0f@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2021-03-30 at 08:14 +0000, David Laight wrote:
> From: Zhang Rui
> > Sent: 30 March 2021 09:00
> > To: Xiaofei Tan <tanxiaofei@huawei.com>; David Laight <
> > David.Laight@ACULAB.COM>; rjw@rjwysocki.net;
> > lenb@kernel.org; bhelgaas@google.com
> > Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; 
> > linux-pci@vger.kernel.org;
> > linuxarm@openeuler.org
> > Subject: Re: [PATCH v2 04/15] ACPI: table: replace
> > __attribute__((packed)) by __packed
> > 
> > On Tue, 2021-03-30 at 15:31 +0800, Zhang Rui wrote:
> > > On Tue, 2021-03-30 at 10:23 +0800, Xiaofei Tan wrote:
> > > > Hi David,
> > > > 
> > > > On 2021/3/29 18:09, David Laight wrote:
> > > > > From: Xiaofei Tan
> > > > > > Sent: 27 March 2021 07:46
> > > > > > 
> > > > > > Replace __attribute__((packed)) by __packed following the
> > > > > > advice of checkpatch.pl.
> > > > > > 
> > > > > > Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> > > > > > ---
> > > > > >  drivers/acpi/acpi_fpdt.c | 6 +++---
> > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/acpi/acpi_fpdt.c
> > > > > > b/drivers/acpi/acpi_fpdt.c
> > > > > > index a89a806..690a88a 100644
> > > > > > --- a/drivers/acpi/acpi_fpdt.c
> > > > > > +++ b/drivers/acpi/acpi_fpdt.c
> > > > > > @@ -53,7 +53,7 @@ struct resume_performance_record {
> > > > > >  	u32 resume_count;
> > > > > >  	u64 resume_prev;
> > > > > >  	u64 resume_avg;
> > > > > > -} __attribute__((packed));
> > > > > > +} __packed;
> > > > > > 
> > > > > >  struct boot_performance_record {
> > > > > >  	struct fpdt_record_header header;
> > > > > > @@ -63,13 +63,13 @@ struct boot_performance_record {
> > > > > >  	u64 bootloader_launch;
> > > > > >  	u64 exitbootservice_start;
> > > > > >  	u64 exitbootservice_end;
> > > > > > -} __attribute__((packed));
> > > > > > +} __packed;
> > > > > > 
> > > > > >  struct suspend_performance_record {
> > > > > >  	struct fpdt_record_header header;
> > > > > >  	u64 suspend_start;
> > > > > >  	u64 suspend_end;
> > > > > > -} __attribute__((packed));
> > > > > > +} __packed;
> > > > > 
> > > > > My standard question about 'packed' is whether it is actually
> > > > > needed.
> > > > > It should only be used if the structures might be misaligned
> > > > > in
> > > > > memory.
> > > > > If the only problem is that a 64bit item needs to be 32bit
> > > > > aligned
> > > > > then a suitable type should be used for those specific
> > > > > fields.
> > > > > 
> > > > > Those all look very dubious - the standard header isn't
> > > > > packed
> > > > > so everything must eb assumed to be at least 32bit aligned.
> > > > > 
> > > > > There are also other sub-structures that contain 64bit
> > > > > values.
> > > > > These don't contain padding - but that requires 64bit
> > > > > alignement.
> > > > > 
> > > > > The only problematic structure is the last one - which would
> > > > > have
> > > > > a 32bit pad after the header.
> > > > > Is this even right given than there are explicit alignment
> > > > > pads
> > > > > in some of the other structures.
> > > > > 
> > > > > If 64bit alignment isn't guaranteed then a '64bit aligned to
> > > > > 32bit'
> > > > > type should be used for the u64 fields.
> > > > > 
> > > > 
> > > > Yes, some of them has been aligned already, then nothing
> > > > changed
> > > > when
> > > > add this "packed ". Maybe the purpose of the original author is
> > > > for
> > > > extension, and can tell others that this struct need be packed.
> > > > 
> > > 
> > > The patch is upstreamed recently but it was made long time ago.
> > > I think the original problem is that one of the address, probably
> > > the
> > > suspend_performance record, is not 64bit aligned, thus we can not
> > > read
> > > the proper content of suspend_start and suspend_end, mapped from
> > > physical memory.
> > > 
> > > I will try to find a machine to reproduce the problem with all
> > > __attribute__((packed)) removed to double confirm this.
> > > 
> > 
> > So here is the problem, without __attribute__((packed))
> > 
> > [    0.858442] suspend_record: 0xffffaad500175020
> > /sys/firmware/acpi/fpdt/suspend/suspend_end_ns:addr:
> > 0xffffaad500175030, 15998179292659843072
> > /sys/firmware/acpi/fpdt/suspend/suspend_start_ns:addr:
> > 0xffffaad500175028, 0
> > 
> > suspend_record is mapped to 0xffffaad500175020, and it is combined
> > with
> > one 32bit header and two 64bit fields (suspend_start and
> > suspend_end),
> > this is how it is located in physical memory.
> > So the addresses of the two 64bit fields are actually not 64bit
> > aligned.
> > 
> > David,
> > Is this the "a 64bit item needs to be 32bit aligned" problem you
> > referred?
> > If yes, what is the proper fix? should I used two 32bits for each
> > of
> > the field instead?
> 
> Define something like:
> typedef u64 __attribute__((aligned(4))) u64_align32;
> and then use it for the 64bit structure members.
> 
Hi, David,

Please kindly help check if the following patch is the right fix or
not. I've verified it to work on my test box.

The reason I use this typedef for all the u64 items because there is no
guarantee that the suspend_performance record is in the end of the
memory, thus it may pollute the others.

From e18c942855e2f51e814d057fff4dd951cd0d0907 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Wed, 31 Mar 2021 20:34:13 +0800
Subject: [PATCH] ACPI: tables: FPDT: Fix 64bit alignment issue

Some of the 64bit items in FPDT table may be 32bit aligned.
Using __attribute__((packed)) is not needed in this case, fixing it by
allowing 32bit alignment for these 64bit items.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/acpi_fpdt.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
index a89a806a7a2a..94e107b9a114 100644
--- a/drivers/acpi/acpi_fpdt.c
+++ b/drivers/acpi/acpi_fpdt.c
@@ -23,12 +23,14 @@ enum fpdt_subtable_type {
 	SUBTABLE_S3PT,
 };
 
+typedef u64 __attribute__((aligned(4))) u64_align32;
+
 struct fpdt_subtable_entry {
 	u16 type;		/* refer to enum fpdt_subtable_type */
 	u8 length;
 	u8 revision;
 	u32 reserved;
-	u64 address;		/* physical address of the S3PT/FBPT table */
+	u64_align32 address;		/* physical address of the S3PT/FBPT table */
 };
 
 struct fpdt_subtable_header {
@@ -51,25 +53,25 @@ struct fpdt_record_header {
 struct resume_performance_record {
 	struct fpdt_record_header header;
 	u32 resume_count;
-	u64 resume_prev;
-	u64 resume_avg;
-} __attribute__((packed));
+	u64_align32 resume_prev;
+	u64_align32 resume_avg;
+};
 
 struct boot_performance_record {
 	struct fpdt_record_header header;
 	u32 reserved;
-	u64 firmware_start;
-	u64 bootloader_load;
-	u64 bootloader_launch;
-	u64 exitbootservice_start;
-	u64 exitbootservice_end;
-} __attribute__((packed));
+	u64_align32 firmware_start;
+	u64_align32 bootloader_load;
+	u64_align32 bootloader_launch;
+	u64_align32 exitbootservice_start;
+	u64_align32 exitbootservice_end;
+};
 
 struct suspend_performance_record {
 	struct fpdt_record_header header;
-	u64 suspend_start;
-	u64 suspend_end;
-} __attribute__((packed));
+	u64_align32 suspend_start;
+	u64_align32 suspend_end;
+};
 
 
 static struct resume_performance_record *record_resume;
-- 
2.17.1


