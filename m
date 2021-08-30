Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D223FB943
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 17:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbhH3PvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 11:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhH3PvX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Aug 2021 11:51:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315CBC061575;
        Mon, 30 Aug 2021 08:50:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id e21so32062510ejz.12;
        Mon, 30 Aug 2021 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZdQ2NYONUh/Mlj0X5zIsPhWrX6XBgDUXmU/jErZJywo=;
        b=FJ6u+7ZmqzdbI/gyHRn72MAMt7fXnzhi32/cwtuYJ4y45E80lvafD0QAHLIWsE0AsB
         vbH3nG8xMYE3rYDcNcCqI/ARxt5efWvfhJhhRwgvURvvHv1qsuPJ86PBf2NuyFWAFPSG
         aXfpF64sSzKew+B8jhZiS5GgR3a3mGdBsr5DREG+exF17jVqcBTNX1zw8LRm/1/26Mne
         xaFEPQQZUhlwkOGIxxVkLom0q/20yKjrqh08dZ+Qq2vwbh6B1HAclNGTBg07GsOLtu4e
         okSSK4+c2tB3RQHMAiIVfLk8jYNYEAtNDWfkeUbRvE3OBn3RksYk5bPzVaDPdBWHScE9
         Ixzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZdQ2NYONUh/Mlj0X5zIsPhWrX6XBgDUXmU/jErZJywo=;
        b=apKP7CHy8BM6XHMtBx1rEjm2tZdkM8hPQbF0dHGvz0zYv4e/FoFGUq8nka8qRqprsM
         ZzVxUBxyuDdH5QIUOnOhdSOr8JYVXv23BvlWZ2kaniie+O80FYFD/F6gInC4zcQ2Rxqm
         BAUDdQByKXbGS2hnbGTWI1VPP5qiZ7Rtu7a+R+OhveRwNDHSa9lOe30GMLZN5G+GTk5B
         VSgdZDavFnBR3/p3ekOHmqlQc5BGfG1VFBRsCx3XLxk8roxojupoyxr0Y7rFa/J8QViQ
         GhtkdPIf3DWmSsuva3gI6AkmdDsX8LGjoDncbh8uElDx6IH0BBzm3eCwncaOxJfcOiL8
         nrFA==
X-Gm-Message-State: AOAM530dwTiprYvF22x4m7ZbTJgpKasbMNgJ4IFpRZ9Z7Z1S0nimGw7w
        lP4VcYABefBL11EHG9u0U4M=
X-Google-Smtp-Source: ABdhPJxzjhjWEcACIkXAOsASCgygWfARaMnw76vGOM8bIFhahPxmhp1H0I810MbvFr0ZdMuQBSl7Mg==
X-Received: by 2002:a17:907:2677:: with SMTP id ci23mr25654080ejc.429.1630338627699;
        Mon, 30 Aug 2021 08:50:27 -0700 (PDT)
Received: from localhost (host-79-37-188-60.retail.telecomitalia.it. [79.37.188.60])
        by smtp.gmail.com with ESMTPSA id n18sm6773671ejg.36.2021.08.30.08.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 08:50:27 -0700 (PDT)
Date:   Mon, 30 Aug 2021 19:50:20 +0200
From:   Sergio =?utf-8?Q?Migu=C3=A9ns?= Iglesias <lonyelon@gmail.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        sstabellini@kernel.org, bhelgaas@google.com,
        xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergio =?utf-8?Q?Migu=C3=A9ns?= Iglesias <sergio@lony.xyz>
Subject: Re: [PATCH] xen/pcifront: Removed unnecessary __ref annotation
Message-ID: <20210830175020.jymnt6uwhgmjlwyz@archlap>
References: <20210829221415.647744-1-sergio@lony.xyz>
 <2df006a3-d232-c356-3402-888739835967@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2df006a3-d232-c356-3402-888739835967@suse.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks a lot for your reply! I am sending a v2 patch to fix all the
issues.

Sergio M. Iglesias.

On 21/08/30 06:55, Juergen Gross wrote:
> On 30.08.21 00:14, Sergio Miguéns Iglesias wrote:
> > An unnecessary "__ref" annotation was removed from the
> > "drivers/pci/xen_pcifront.c" file. The function where the annotation
> > was used was "pcifront_backend_changed()", which does not call any
> > functions annotated as "__*init" nor "__*exit". This makes "__ref"
> > unnecessary since this annotation is used to make the compiler ignore
> > section miss-matches when they are not happening here in the first
> > place.
> > 
> > In addition to the aforementioned change, some code style issues were
> > fixed in the same file.
> > 
> > Signed-off-by: Sergio Miguéns Iglesias <sergio@lony.xyz>
> > ---
> >   drivers/pci/xen-pcifront.c | 24 ++++++++++++++----------
> >   1 file changed, 14 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> > index b7a8f3a1921f..f06661704f3a 100644
> > --- a/drivers/pci/xen-pcifront.c
> > +++ b/drivers/pci/xen-pcifront.c
> > @@ -115,7 +115,7 @@ static int do_pci_op(struct pcifront_device *pdev, struct xen_pci_op *op)
> >   	struct xen_pci_op *active_op = &pdev->sh_info->op;
> >   	unsigned long irq_flags;
> >   	evtchn_port_t port = pdev->evtchn;
> > -	unsigned irq = pdev->irq;
> > +	unsigned int irq = pdev->irq;
> >   	s64 ns, ns_timeout;
> >   	spin_lock_irqsave(&pdev->sh_info_lock, irq_flags);
> > @@ -152,11 +152,10 @@ static int do_pci_op(struct pcifront_device *pdev, struct xen_pci_op *op)
> >   		}
> >   	}
> > -	/*
> > -	* We might lose backend service request since we
> > -	* reuse same evtchn with pci_conf backend response. So re-schedule
> > -	* aer pcifront service.
> > -	*/
> > +	/* We might lose backend service request since we
> 
> This is no net or drivers/net file, so please keep the initial "/*"
> line and fixup the other multi-line comments accordingly.
> 
> > +	 * reuse same evtchn with pci_conf backend response. So re-schedule
> > +	 * aer pcifront service.
> > +	 */
> >   	if (test_bit(_XEN_PCIB_active,
> >   			(unsigned long *)&pdev->sh_info->flags)) {
> >   		dev_err(&pdev->xdev->dev,
> > @@ -493,7 +492,8 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
> >   	list_add(&bus_entry->list, &pdev->root_buses);
> >   	/* pci_scan_root_bus skips devices which do not have a
> > -	* devfn==0. The pcifront_scan_bus enumerates all devfn. */
> > +	 * devfn==0. The pcifront_scan_bus enumerates all devfn.
> > +	 */
> >   	err = pcifront_scan_bus(pdev, domain, bus, b);
> >   	/* Claim resources before going "live" with our devices */
> > @@ -651,8 +651,9 @@ static void pcifront_do_aer(struct work_struct *data)
> >   	pci_channel_state_t state =
> >   		(pci_channel_state_t)pdev->sh_info->aer_op.err;
> > -	/*If a pci_conf op is in progress,
> > -		we have to wait until it is done before service aer op*/
> > +	/* If a pci_conf op is in progress, we have to wait until it is done
> > +	 * before service aer op
> > +	 */
> >   	dev_dbg(&pdev->xdev->dev,
> >   		"pcifront service aer bus %x devfn %x\n",
> >   		pdev->sh_info->aer_op.bus, pdev->sh_info->aer_op.devfn);
> > @@ -676,6 +677,7 @@ static void pcifront_do_aer(struct work_struct *data)
> >   static irqreturn_t pcifront_handler_aer(int irq, void *dev)
> >   {
> >   	struct pcifront_device *pdev = dev;
> > +
> >   	schedule_pcifront_aer_op(pdev);
> >   	return IRQ_HANDLED;
> >   }
> > @@ -1027,6 +1029,7 @@ static int pcifront_detach_devices(struct pcifront_device *pdev)
> >   	/* Find devices being detached and remove them. */
> >   	for (i = 0; i < num_devs; i++) {
> >   		int l, state;
> > +
> >   		l = snprintf(str, sizeof(str), "state-%d", i);
> >   		if (unlikely(l >= (sizeof(str) - 1))) {
> >   			err = -ENOMEM;
> > @@ -1078,7 +1081,7 @@ static int pcifront_detach_devices(struct pcifront_device *pdev)
> >   	return err;
> >   }
> > -static void __ref pcifront_backend_changed(struct xenbus_device *xdev,
> > +static void pcifront_backend_changed(struct xenbus_device *xdev,
> >   						  enum xenbus_state be_state)
> >   {
> >   	struct pcifront_device *pdev = dev_get_drvdata(&xdev->dev);
> > @@ -1137,6 +1140,7 @@ static int pcifront_xenbus_probe(struct xenbus_device *xdev,
> >   static int pcifront_xenbus_remove(struct xenbus_device *xdev)
> >   {
> >   	struct pcifront_device *pdev = dev_get_drvdata(&xdev->dev);
> > +
> >   	if (pdev)
> >   		free_pdev(pdev);
> > 
> 
> Juergen





