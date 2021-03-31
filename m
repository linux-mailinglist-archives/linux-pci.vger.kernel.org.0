Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1D135055C
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 19:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhCaRWQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 13:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233900AbhCaRWN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Mar 2021 13:22:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B721961041;
        Wed, 31 Mar 2021 17:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617211332;
        bh=UNNvx8KRbir/+SlHakk0v0B4spVKeTNYcTv3zPs9JaY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Y+w6NTt0eiDQrd/3cvK6U8FxlBYYQDStYl+pTMOrnYv5SRqR9ou5//rEZoXqXa6iA
         bqZXtWIHoGkR6BCUqOR+xkJxAtrXK6++GFvEVtTQLuuQz8rb/G424ffNkHN3OFDU5j
         T87XdnLPLslscLynwtM+aQU2UKqpAJyG/rBkXwzmCXyJFkgjalwgzG2a5UVkBb1/bG
         0dMtuuEOkTsb1YIEuAQURB9HE++Xu9K14sG2y+EXAGYNlXPGZ8f0qnlI/kFYmSbViT
         V8qFnLiFWMgqdtxbciYGFSLK1MYyb9yBFezmbQLzjhb+3F292NIj0dXTbiCSJZlm1t
         DeUVdbnQRnPYw==
Date:   Wed, 31 Mar 2021 12:22:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH v2 04/15] ACPI: table: replace __attribute__((packed)) by
 __packed
Message-ID: <20210331172210.GA1397554@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0d626837e577e60f226b8bbf354bd8cbb1fe40a.camel@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 31, 2021 at 11:55:08PM +0800, Zhang Rui wrote:
> ...

> From e18c942855e2f51e814d057fff4dd951cd0d0907 Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Wed, 31 Mar 2021 20:34:13 +0800
> Subject: [PATCH] ACPI: tables: FPDT: Fix 64bit alignment issue
> 
> Some of the 64bit items in FPDT table may be 32bit aligned.
> Using __attribute__((packed)) is not needed in this case, fixing it by
> allowing 32bit alignment for these 64bit items.

1) Can you please add a spec reference for this?  I think it's ACPI
   v6.3, sec 5.2.23.5, or something close to that.

2) The exact layout in memory is prescribed by the spec.  I think
   that's basically what "packed" accomplishes.  I don't understand
   why using "aligned" would be preferable.  Using "aligned" means
   things can be at different offsets depending on the starting
   address of the structure.  We always want the identical layout, no
   matter what the starting address is.

> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/acpi_fpdt.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> index a89a806a7a2a..94e107b9a114 100644
> --- a/drivers/acpi/acpi_fpdt.c
> +++ b/drivers/acpi/acpi_fpdt.c
> @@ -23,12 +23,14 @@ enum fpdt_subtable_type {
>  	SUBTABLE_S3PT,
>  };
>  
> +typedef u64 __attribute__((aligned(4))) u64_align32;
> +
>  struct fpdt_subtable_entry {
>  	u16 type;		/* refer to enum fpdt_subtable_type */
>  	u8 length;
>  	u8 revision;
>  	u32 reserved;
> -	u64 address;		/* physical address of the S3PT/FBPT table */
> +	u64_align32 address;		/* physical address of the S3PT/FBPT table */
>  };
>  
>  struct fpdt_subtable_header {
> @@ -51,25 +53,25 @@ struct fpdt_record_header {
>  struct resume_performance_record {
>  	struct fpdt_record_header header;
>  	u32 resume_count;
> -	u64 resume_prev;
> -	u64 resume_avg;
> -} __attribute__((packed));
> +	u64_align32 resume_prev;
> +	u64_align32 resume_avg;
> +};
>  
>  struct boot_performance_record {
>  	struct fpdt_record_header header;
>  	u32 reserved;
> -	u64 firmware_start;
> -	u64 bootloader_load;
> -	u64 bootloader_launch;
> -	u64 exitbootservice_start;
> -	u64 exitbootservice_end;
> -} __attribute__((packed));
> +	u64_align32 firmware_start;
> +	u64_align32 bootloader_load;
> +	u64_align32 bootloader_launch;
> +	u64_align32 exitbootservice_start;
> +	u64_align32 exitbootservice_end;
> +};
>  
>  struct suspend_performance_record {
>  	struct fpdt_record_header header;
> -	u64 suspend_start;
> -	u64 suspend_end;
> -} __attribute__((packed));
> +	u64_align32 suspend_start;
> +	u64_align32 suspend_end;
> +};
>  
>  
>  static struct resume_performance_record *record_resume;
> -- 
> 2.17.1
> 
> 
