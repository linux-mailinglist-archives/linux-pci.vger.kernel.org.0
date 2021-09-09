Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D53405C6A
	for <lists+linux-pci@lfdr.de>; Thu,  9 Sep 2021 19:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbhIIR5c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Sep 2021 13:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237205AbhIIR5b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Sep 2021 13:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631210181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yd9GwlQVH+G/gix2nbfQntZRetIqh99M2bEqNfUhY1E=;
        b=VeXPYIfXoVpC10Tg3Gl7MGwNslIPadQdf9BJYLbA0QIxJPkVGYp46foHteB62oyulaZCBc
        KAWmHMnM6uAuXUnkIiC+yWboHj6maVmFU8W9GuwiqiCy3ei3k9le6XUXqBnMScDtYwQ9g9
        57JT2fnvKTJA9i7jrQo+32Y6Aj13qQI=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-Vaq2FiOPOiqO_eW88j6fCA-1; Thu, 09 Sep 2021 13:56:20 -0400
X-MC-Unique: Vaq2FiOPOiqO_eW88j6fCA-1
Received: by mail-oi1-f199.google.com with SMTP id bd4-20020a056808220400b00268fe826fffso1536205oib.13
        for <linux-pci@vger.kernel.org>; Thu, 09 Sep 2021 10:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yd9GwlQVH+G/gix2nbfQntZRetIqh99M2bEqNfUhY1E=;
        b=4QC5C6UcWSD/n0eaAvHx2wQ20W3GkDkeKD2fvjtqJJOk5rsQolICqsNEDfwltRnHk1
         D2tdKFiUpyNz7Czb0cqERaq43y8UAzt598RqZN74oq7w5j3BJuyhZDPm6I3MJeRJ/DN8
         z8u+mQQ09zdDVTpQsxfVpvXoLM425J30uyxgAIqJiOBtO00DkyiVdzdNIIcTymHk/fvS
         PfR4+Gx1R3jqp56ZIG48UZG1pR52J7PVRzW9M0acHN4UJSErQBHIYE3ryPY87LslFRdF
         wodzQ4O03BGrw3u2GT5JvpHTe7uKsXz8snWpKM8C1jPGsp4BQHqs/cFgwk1Krrom283B
         ETVA==
X-Gm-Message-State: AOAM5301F2zcdgbODudGZJKFSyPg/XqfuG3W4JWIo0eTDk+d0QIhliTF
        4sTJW+U3g77+rmB6tD3kJVrvMiEbC0Z5me7YGWA4rNqjR5IaA/BbKH5wI2XqaStE7abaNP3hp0w
        mWTxDTTVkDnHGQleWaxmg
X-Received: by 2002:a05:6808:690:: with SMTP id k16mr874197oig.43.1631210179945;
        Thu, 09 Sep 2021 10:56:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxn93e0iq/HIVIALPPNXOFtdoS2YpAm/171PM3C7CPLfmAGJMYN9aAf3jNx9dwX2h3Vd133zQ==
X-Received: by 2002:a05:6808:690:: with SMTP id k16mr874189oig.43.1631210179706;
        Thu, 09 Sep 2021 10:56:19 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id s17sm607840otr.51.2021.09.09.10.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 10:56:19 -0700 (PDT)
Date:   Thu, 9 Sep 2021 11:56:18 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     linux-pci@vger.kernel.org, Nathan Rossi <nathan.rossi@digi.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: Add ACS errata for Pericom PI7C9X2G404 switch
Message-ID: <20210909115618.53a4da68.alex.williamson@redhat.com>
In-Reply-To: <20210909093911.03952664.alex.williamson@redhat.com>
References: <20210909080927.164709-1-nathan@nathanrossi.com>
        <20210909093911.03952664.alex.williamson@redhat.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 9 Sep 2021 09:39:11 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 09 Sep 2021 08:09:27 +0000
> Nathan Rossi <nathan@nathanrossi.com> wrote:
> 
> > From: Nathan Rossi <nathan.rossi@digi.com>
> > 
> > The Pericom PI7C9X2G404 PCIe switch has an errata for ACS P2P Request
> > Redirect behaviour when used in the cut-through forwarding mode. The
> > recommended work around for this issue is to use the switch in store and
> > forward mode. The errata results in packets being queued and not being
> > delivered upstream, this can be observed as very poor downstream device
> > performance and/or dropped device generated data/interrupts.
> > 
> > This change adds a fixup specific to this switch that when enabling or
> > resuming the downstream port it checks if it has enabled ACS P2P Request
> > Redirect, and if so changes the device (via the upstream port) to use
> > the store and forward operating mode.
> > 
> > Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>  
> 
> 
> Thanks for pursuing this!  I took a stab at it[1] some time ago but I
> tried to pursue link balancing, I didn't have the datasheet to realize
> we could simply put the device in a different mode and blindly assumed
> the mode was inherit to the unbalanced link config.  Link balancing
> turned out to be more complicated than I cared or had time to pursue.
> 
> Also related to this device, there is a kernel bz for this issue that
> might provide more details[2], Bjorn will probably want to add that
> reference to the commit log.
> 
> I'll see if I can find the card from that bz to test here.  Thanks,

Tested against the troublesome dual-port NIC mentioned in the bz
below[2].  With VT-d enabled the NIC reports netdev timeouts, fails to
DHCP an IP for some time.  With this patch I see the info message in
dmesg reporting store-forward mode is enabled and both ports appear to
work normally with no netdev timeouts.

Tested-by: Alex Williamson <alex.williamson@redhat.com>

Thanks!
Alex

 
> [1]https://lore.kernel.org/all/20161026175156.23495.12980.stgit@gimli.home/
> [2]https://bugzilla.kernel.org/show_bug.cgi?id=177471
> 
> > ---
> > Changes in v2:
> > - Added DECLARE_PCI_FIXUP_RESUME to handle applying fixup upon resume as
> >   switch operation may have been reset or ACS configuration may have
> >   changed
> > ---
> >  drivers/pci/quirks.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index e5089af8ad..5849b7046b 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5790,3 +5790,51 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
> >  }
> >  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
> >  			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> > +
> > +/*
> > + * Pericom PI7C9X2G404 switch errata E5 - ACS P2P Request Redirect is not
> > + * functional
> > + *
> > + * When ACS P2P Request Redirect is enabled and bandwidth is not balanced
> > + * between upstream and downstream ports, packets are queued in an internal
> > + * buffer until CPLD packet. The workaround is to use the switch in store and
> > + * forward mode.
> > + */
> > +#define PI7C9X2G404_MODE_REG		0x74
> > +#define PI7C9X2G404_STORE_FORWARD_MODE	BIT(0)
> > +static void pci_fixup_pericom_acs_store_forward(struct pci_dev *pdev)
> > +{
> > +	struct pci_dev *upstream;
> > +	u16 val;
> > +
> > +	/* Downstream ports only */
> > +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
> > +		return;
> > +
> > +	/* Check for ACS P2P Request Redirect use */
> > +	if (!pdev->acs_cap)
> > +		return;
> > +	pci_read_config_word(pdev, pdev->acs_cap + PCI_ACS_CTRL, &val);
> > +	if (!(val & PCI_ACS_RR))
> > +		return;
> > +
> > +	upstream = pci_upstream_bridge(pdev);
> > +	if (!upstream)
> > +		return;
> > +
> > +	pci_read_config_word(upstream, PI7C9X2G404_MODE_REG, &val);
> > +	if (!(val & PI7C9X2G404_STORE_FORWARD_MODE)) {
> > +		pci_info(upstream, "Setting PI7C9X2G404 store-forward mode\n");
> > +		/* Enable store-foward mode */
> > +		pci_write_config_word(upstream, PI7C9X2G404_MODE_REG, val |
> > +				      PI7C9X2G404_STORE_FORWARD_MODE);
> > +	}
> > +}
> > +/*
> > + * Apply fixup on enable and on resume, in order to apply the fix up whenever
> > + * ACS configuration changes or switch mode is reset
> > + */
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2404,
> > +			 pci_fixup_pericom_acs_store_forward);
> > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2404,
> > +			 pci_fixup_pericom_acs_store_forward);
> > ---
> > 2.33.0
> >   
> 

