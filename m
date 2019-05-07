Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7718716DAE
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2019 00:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfEGW66 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 18:58:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfEGW66 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 May 2019 18:58:58 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92BFF20C01;
        Tue,  7 May 2019 22:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557269937;
        bh=Tj5Q0Ke18ZiAG809phpWz1PZjfv+/GavCDBL/qrjEP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJd7XCKRajBZyjxoZQQgJ+8JkJQO4CN0JGNgd8h1XwWX0I+hdjJXyH1Z7n/ImocX/
         +TwR8dtgikiJhuLezT9O+4Sv/iKTu24sWL9Awt4ira9hSdRSbYA6KQCQfT83pY/y3s
         Uio7qKjJ2DJ7MdzvEOjCHGNNyyBEm8/3haVdb47U=
Date:   Tue, 7 May 2019 17:58:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mohan Kumar <mohankumar718@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: Define pr_fmt() and use pr_*() instead of
 printk()
Message-ID: <20190507225850.GG156478@google.com>
References: <1555733130-19804-1-git-send-email-mohankumar718@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555733130-19804-1-git-send-email-mohankumar718@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mohan,

On Sat, Apr 20, 2019 at 07:05:30AM +0300, Mohan Kumar wrote:
> Define a pr_fmt() macro that convert all of the explicit printk() calls
> into corresponding pr_*().

I dropped the pr_fmt() parts of this because there's really no
benefit: we move the prefix from the actual printk() to the pr_fmt
definition, which is a little bit harder to understand for the reader,
and it makes the string harder to find, e.g., if you see "PCI: can't
add host bridge window" in the dmesg log and search for it in the
kernel source, you'll no longer find it.

I think pr_fmt does make sense if the prefix is used many times, but
for these cases, where it's only used once or twice, it doesn't seem
worthwhile.

> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> ---
>  drivers/pci/bus.c       |  5 ++++-
>  drivers/pci/pci-stub.c  | 11 +++++------
>  drivers/pci/pci-sysfs.c |  3 ++-
>  drivers/pci/pci.c       |  5 +++--
>  drivers/pci/quirks.c    |  9 +++++----
>  drivers/pci/setup-bus.c |  5 +++--
>  drivers/pci/slot.c      |  4 +++-
>  7 files changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 5cb40b2..a742ef5 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -6,6 +6,9 @@
>   *	David Miller (davem@redhat.com)
>   *	Ivan Kokshaysky (ink@jurassic.park.msu.ru)
>   */
> +
> +#define pr_fmt(fmt) "PCI: " fmt
> +
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
> @@ -23,7 +26,7 @@ void pci_add_resource_offset(struct list_head *resources, struct resource *res,
>  
>  	entry = resource_list_create_entry(res, 0);
>  	if (!entry) {
> -		printk(KERN_ERR "PCI: can't add host bridge window %pR\n", res);
> +		pr_err("can't add host bridge window %pR\n", res);

This is an example of doing two changes at once:

  1) Converting "printk(KERN_ERR)" to "pr_err()"
  2) Factoring out the "PCI: " prefix with pr_fmt()

The first change is worthwhile and I pulled that out and squashed it
into your first patch.

This patch (if we were going to do it) should contain *only* the
pr_fmt() factoring.  So the first patch would look like this:

  - printk(KERN_ERR "PCI: can't add host bridge window %pR\n", res);
  + pr_err("PCI: can't add host bridge window %pR\n", res);

and the second patch would look like this:

  +#define pr_fmt(fmt) "PCI: " fmt
  - pr_err("PCI: can't add host bridge window %pR\n", res);
  + pr_err("can't add host bridge window %pR\n", res);

> @@ -159,8 +161,7 @@ static int __init pci_apply_final_quirks(void)
>  	u8 tmp;
>  
>  	if (pci_cache_line_size)
> -		printk(KERN_DEBUG "PCI: CLS %u bytes\n",
> -		       pci_cache_line_size << 2);
> +		pr_info("CLS %u bytes\n", pci_cache_line_size << 2);
>  
>  	pci_apply_fixup_final_quirks = true;
>  	for_each_pci_dev(dev) {
> @@ -177,7 +178,7 @@ static int __init pci_apply_final_quirks(void)
>  			if (!tmp || cls == tmp)
>  				continue;
>  
> -			printk(KERN_DEBUG "PCI: CLS mismatch (%u != %u), using %u bytes\n",
> +			pr_info("CLS mismatch (%u != %u), using %u bytes\n",
>  			       cls << 2, tmp << 2,
>  			       pci_dfl_cache_line_size << 2);

Here's a case where we should actually be using pci_printk() since
this message is related to a specific device.

I added a new patch before your first patch to do this:

  - printk(KERN_DEBUG "PCI: CLS mismatch ..."
  + pci_printk(KERN_DEBUG, dev, "CLS mismatch ..."

There's a similar case in pci_create_legacy_files(), so the new patch
converts both of those.

Bjorn
