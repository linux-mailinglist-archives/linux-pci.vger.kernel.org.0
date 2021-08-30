Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B353FBA2F
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 18:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbhH3QaS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 12:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237589AbhH3QaS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Aug 2021 12:30:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3CCF60F5B;
        Mon, 30 Aug 2021 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630340964;
        bh=KIS38HSL5S324U+X4e+2rl9sJee9NgV2uUMLDx/vPS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vF6Zy+cQLDdsvo1Nzrc+HB4djdR6og6ujIwvlfsUvb2P88VivxohcYNSHMXAri1uN
         dWsiI2v/kcq5X61RUyujFcxKVk5li57qUE7SYagOiCaY8qREyyLKG0kFM/gbLoP3qs
         xvpBAmhek5sfwwKTB415K179ClqtniTFKytPMse3FOlGiQIIZpAnwfOdQRs8Pi9bSE
         0bmmeHYra8f0Sj5leEafVCV6d8dmh+3Y4u33zh/Mvwxj9I44l9UAPprvBgeEr3WIiG
         ktVj4sudusIKVET26uBwZNkSnek40WwFrj4PNWkgrln8Ys8shwKQ7Q5JQoo/2a5Qy/
         6QCuAlLqxpmeQ==
Date:   Mon, 30 Aug 2021 11:29:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio =?iso-8859-1?Q?Migu=E9ns?= Iglesias <lonyelon@gmail.com>
Cc:     konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, bhelgaas@google.com,
        xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergio =?iso-8859-1?Q?Migu=E9ns?= Iglesias <sergio@lony.xyz>
Subject: Re: [PATCH v2] xen/pcifront: Removed unnecessary __ref annotation
Message-ID: <20210830162922.GA4188989@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210830175305.13370-1-sergio@lony.xyz>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 30, 2021 at 07:53:05PM +0200, Sergio Miguéns Iglesias wrote:
> An unnecessary "__ref" annotation was removed from the
> "drivers/pci/xen_pcifront.c" file. The function where the annotation
> was used was "pcifront_backend_changed()", which does not call any
> functions annotated as "__*init" nor "__*exit". This makes "__ref"
> unnecessary since this annotation is used to make the compiler ignore
> section miss-matches when they are not happening here in the first
> place.
> 
> In addition to the aforementioned change, some code style issues were
> fixed in the same file.

One of the Xen folks may apply this, and they may not be as nit-picky
as I am :)

If I were to apply this, I would suggest:

  - Write subject line and commit message in imperative mood.  This is
    a really good guide to this and other commit message this:
    https://chris.beams.io/posts/git-commit/

    For example, in the subject, say "Remove" (not "Removed").  Same
    in the body.  In the body, I would mention the function but not
    the filename since that's obvious from the diff.

  - Split the __ref change into a separate patch from the style
    changes.  The __ref removal should come first and be the absolute
    minimal patch.  That makes it much easier to review, backport, and
    revert if necessary.  And, if the maintainer isn't wild about
    style patches, it's trivial to just ignore that patch.

    Commit logs that say "Also, ..." or "In addition, ..." are always
    red flags to me because they usually indicate the patch could be
    split into two or more simpler patches.

  - When reviewing changes like this, I assume __ref was added in the
    first place for some good reason, so I want to know why, and I
    want to know when that reason changed.  So I would look for the
    commit that *introduced* __ref and for the commit that removed the
    need for it.  It would save me time if the log said something
    like:

      956a9202cd12 ("xen-pcifront: Xen PCI frontend driver.") added
      __initrefok because pcifront_backend_changed() called
      pcifront_try_connect() and pcifront_attach_devices(), which were
      both __devinit.

      The __devinit annotations were removed by 15856ad50bf5 ("PCI:
      Remove __dev* markings"), which made __initrefok unnecessary.

      Finally, bd721ea73e1f ("treewide: replace obsolete _refok by
      __ref") replaced __initrefok with __ref.

    That might be too much for a commit log, but it shows that you've
    done your homework and makes it easier to review (and helps people
    make similar fixes elsewhere).  If it *is* too much, it's trivial
    for a maintainer to cut it out.

More notes about my idiosyncracies:
https://lore.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com

> Signed-off-by: Sergio Miguéns Iglesias <sergio@lony.xyz>
> ---
>  drivers/pci/xen-pcifront.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> index b7a8f3a1921f..427041c1e408 100644
> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c
> @@ -115,7 +115,7 @@ static int do_pci_op(struct pcifront_device *pdev, struct xen_pci_op *op)
>  	struct xen_pci_op *active_op = &pdev->sh_info->op;
>  	unsigned long irq_flags;
>  	evtchn_port_t port = pdev->evtchn;
> -	unsigned irq = pdev->irq;
> +	unsigned int irq = pdev->irq;
>  	s64 ns, ns_timeout;
>  
>  	spin_lock_irqsave(&pdev->sh_info_lock, irq_flags);
> @@ -153,10 +153,10 @@ static int do_pci_op(struct pcifront_device *pdev, struct xen_pci_op *op)
>  	}
>  
>  	/*
> -	* We might lose backend service request since we
> -	* reuse same evtchn with pci_conf backend response. So re-schedule
> -	* aer pcifront service.
> -	*/
> +	 * We might lose backend service request since we
> +	 * reuse same evtchn with pci_conf backend response. So re-schedule
> +	 * aer pcifront service.
> +	 */
>  	if (test_bit(_XEN_PCIB_active,
>  			(unsigned long *)&pdev->sh_info->flags)) {
>  		dev_err(&pdev->xdev->dev,
> @@ -414,7 +414,8 @@ static int pcifront_scan_bus(struct pcifront_device *pdev,
>  	struct pci_dev *d;
>  	unsigned int devfn;
>  
> -	/* Scan the bus for functions and add.
> +	/*
> +	 * Scan the bus for functions and add.
>  	 * We omit handling of PCI bridge attachment because pciback prevents
>  	 * bridges from being exported.
>  	 */
> @@ -492,8 +493,10 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
>  
>  	list_add(&bus_entry->list, &pdev->root_buses);
>  
> -	/* pci_scan_root_bus skips devices which do not have a
> -	* devfn==0. The pcifront_scan_bus enumerates all devfn. */
> +	/*
> +	 * pci_scan_root_bus skips devices which do not have a
> +	 * devfn==0. The pcifront_scan_bus enumerates all devfn.
> +	 */
>  	err = pcifront_scan_bus(pdev, domain, bus, b);
>  
>  	/* Claim resources before going "live" with our devices */
> @@ -651,8 +654,10 @@ static void pcifront_do_aer(struct work_struct *data)
>  	pci_channel_state_t state =
>  		(pci_channel_state_t)pdev->sh_info->aer_op.err;
>  
> -	/*If a pci_conf op is in progress,
> -		we have to wait until it is done before service aer op*/
> +	/*
> +	 * If a pci_conf op is in progress, we have to wait until it is done
> +	 * before service aer op
> +	 */
>  	dev_dbg(&pdev->xdev->dev,
>  		"pcifront service aer bus %x devfn %x\n",
>  		pdev->sh_info->aer_op.bus, pdev->sh_info->aer_op.devfn);
> @@ -676,6 +681,7 @@ static void pcifront_do_aer(struct work_struct *data)
>  static irqreturn_t pcifront_handler_aer(int irq, void *dev)
>  {
>  	struct pcifront_device *pdev = dev;
> +
>  	schedule_pcifront_aer_op(pdev);
>  	return IRQ_HANDLED;
>  }
> @@ -1027,6 +1033,7 @@ static int pcifront_detach_devices(struct pcifront_device *pdev)
>  	/* Find devices being detached and remove them. */
>  	for (i = 0; i < num_devs; i++) {
>  		int l, state;
> +
>  		l = snprintf(str, sizeof(str), "state-%d", i);
>  		if (unlikely(l >= (sizeof(str) - 1))) {
>  			err = -ENOMEM;
> @@ -1078,7 +1085,7 @@ static int pcifront_detach_devices(struct pcifront_device *pdev)
>  	return err;
>  }
>  
> -static void __ref pcifront_backend_changed(struct xenbus_device *xdev,
> +static void pcifront_backend_changed(struct xenbus_device *xdev,
>  						  enum xenbus_state be_state)
>  {
>  	struct pcifront_device *pdev = dev_get_drvdata(&xdev->dev);
> @@ -1137,6 +1144,7 @@ static int pcifront_xenbus_probe(struct xenbus_device *xdev,
>  static int pcifront_xenbus_remove(struct xenbus_device *xdev)
>  {
>  	struct pcifront_device *pdev = dev_get_drvdata(&xdev->dev);
> +
>  	if (pdev)
>  		free_pdev(pdev);
>  
> -- 
> 2.33.0
> 
