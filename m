Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B08B253724
	for <lists+linux-pci@lfdr.de>; Wed, 26 Aug 2020 20:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHZSaS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Aug 2020 14:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZSaQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Aug 2020 14:30:16 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BD7C061574
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2020 11:30:16 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id n3so1408382pjq.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2020 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RYNiO2wbp28snYb6ucmfg9wAWK91lJJjUR4Ps+atoWg=;
        b=sr8oIIhGSy6LiOPhDbKD6vaE4U93eTTyly7jzNYo37IwBZstod6BjGboufyhegngot
         vV1DLGhCje5igwurpYfGE6YZ94QtMZaSk31PEEuvCerS6Ql+TxV7l3PpqEQCD9LzEEwg
         J0CvkH5owz5E46YVV+juC1pNrenTYNzHkDx9FMIjoXj6QhiXfO4TZTp4rUJEb/cJ8Mi+
         ubeRnX3qALsJVvw+mqtfpBckhkOUyVA4iADNmr+G7rUZPXa/Hc9O29pLhnkRPFffA0MZ
         wXvXns4v7r9cNOJ6qduT3YGdw6mwncdJIO5WKcGoTwBN48EeVyFrpcY4/T9qL4jVSjLa
         QFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=RYNiO2wbp28snYb6ucmfg9wAWK91lJJjUR4Ps+atoWg=;
        b=r3JN05XeloxSIFX/H0tBfmeMkzk2y2lqVUnarmIlJmH6fD5Y2PeVJ/OpvpLcQYYQyk
         xaQvvzeg8twLrZIcZRdCC+DKxXsfdZCWGIXts6ObO9B7QvEGuiYSp6m1OXvVdAVVA7AL
         D1KAFMwwXiAw2ZMQ5370vL+MDjS1Q9IHrfIX86wyGuX/VugjECNdmVKkabx82RDVqunx
         j2ot0MpGKZt7kusCZj5Mkol86cMNkN9JYpdoHQrq2Ti09mObFrCOciZ0MgKUbpSDagVi
         qVO1hE6Koimcc7zF/pJf1ZdnXoLgo9nQLVBaKxGWcYhVa/UM1MA7mBfWG8RP8Tt49Mic
         1EgQ==
X-Gm-Message-State: AOAM530Jk+Ijikja8an0S/J82JQEKzUZiW7U8x5yF6/ePFQ+jsYrF2ef
        JlPLPA9dIbfee3RoUspYr/Ia6A==
X-Google-Smtp-Source: ABdhPJzDA/jZZBGEJbCmoZS/FqpQh5OBB1ZUvLtCywbMDNtDbq7jYqvYr+WIdiUkEGIZWHRDkxvhPw==
X-Received: by 2002:a17:90a:7348:: with SMTP id j8mr7121490pjs.137.1598466615795;
        Wed, 26 Aug 2020 11:30:15 -0700 (PDT)
Received: from arch-ashland-svkelley ([2601:1c0:6a00:1804:88d3:6720:250a:6d10])
        by smtp.gmail.com with ESMTPSA id a10sm2968823pfl.28.2020.08.26.11.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 11:30:14 -0700 (PDT)
Message-ID: <7261b75710e55a10f08e04b4ff8de7158cebb0ed.camel@intel.com>
Subject: Re: [PATCH V2 2/9] PCI: Extend Root Port Driver to support RCEC
From:   sean.v.kelley@intel.com
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, rjw@rjwysocki.net,
        ashok.raj@intel.com, tony.luck@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Date:   Wed, 26 Aug 2020 11:29:50 -0700
In-Reply-To: <fe1e4832-a634-66d8-96dc-4ad980dabd1a@linux.intel.com>
References: <20200804194052.193272-1-sean.v.kelley@intel.com>
         <20200804194052.193272-3-sean.v.kelley@intel.com>
         <fe1e4832-a634-66d8-96dc-4ad980dabd1a@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sathya,

Thanks for reviewing.

If you haven't see it already there are newer patches under v3 here:

https://lore.kernel.org/linux-pci/20200812164659.1118946-1-sean.v.kelley@intel.com/

Comments below:

On Wed, 2020-08-26 at 09:16 -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> On 8/4/20 12:40 PM, Sean V Kelley wrote:
> > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > 
> > If a Root Complex Integrated Endpoint (RCiEP) is implemented,
> > errors may
> > optionally be sent to a corresponding Root Complex Event Collector
> > (RCEC).
> > Each RCiEP must be associated with no more than one RCEC. Interface
> > errors
> > are reported to the OS by RCECs.
> > 
> > For an RCEC (technically not a Bridge), error messages "received"
> > from
> > associated RCiEPs must be enabled for "transmission" in order to
> > cause a
> > System Error via the Root Control register or (when the Advanced
> > Error
> > Reporting Capability is present) reporting via the Root Error
> > Command
> > register and logging in the Root Error Status register and Error
> > Source
> > Identification register.
> > 
> > Given the commonality with Root Ports and the need to also support
> > AER
> > and PME services for RCECs, extend the Root Port driver to support
> > RCEC
> > devices through the addition of the RCEC Class ID to the driver
> > structure.
> > 
> > Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> > ---
> >   drivers/pci/pcie/portdrv_core.c | 8 ++++----
> >   drivers/pci/pcie/portdrv_pci.c  | 5 ++++-
> >   2 files changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/portdrv_core.c
> > b/drivers/pci/pcie/portdrv_core.c
> > index 50a9522ab07d..5d4a400094fc 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -234,11 +234,11 @@ static int get_port_device_capability(struct
> > pci_dev *dev)
> >   #endif
> >   
> >   	/*
> > -	 * Root ports are capable of generating PME too.  Root Complex
> > -	 * Event Collectors can also generate PMEs, but we don't handle
> > -	 * those yet.
> > +	 * Root ports and Root Complex Event Collectors are capable
> > +	 * of generating PME too.
> >   	 */
> > -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> > +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > +	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
> >   	    (pcie_ports_native || host->native_pme)) {
> >   		services |= PCIE_PORT_SERVICE_PME;
> What about AER service? Don't you need to enable it for RCEC

It is enabled via set_device_error_reporting() in aer.c and in not seen
in this patch but in the lines above the code section you are
commenting on is:

#ifdef CONFIG_PCIEAER
        if (dev->aer_cap && pci_aer_available() &&
            (pcie_ports_native || host->native_aer)) {
                services |= PCIE_PORT_SERVICE_AER;

                /*
                 * Disable AER on this port in case it's been enabled
by the
                 * BIOS (the AER service driver will enable it when
necessary).
                 */
                pci_disable_pcie_error_reporting(dev);
        }
#endif

Let me know if I'm missing something here.


Thanks!

Sean


> >   
> > diff --git a/drivers/pci/pcie/portdrv_pci.c
> > b/drivers/pci/pcie/portdrv_pci.c
> > index 3a3ce40ae1ab..4d880679b9b1 100644
> > --- a/drivers/pci/pcie/portdrv_pci.c
> > +++ b/drivers/pci/pcie/portdrv_pci.c
> > @@ -106,7 +106,8 @@ static int pcie_portdrv_probe(struct pci_dev
> > *dev,
> >   	if (!pci_is_pcie(dev) ||
> >   	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
> >   	     (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
> > -	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
> > +	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM) &&
> > +	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
> >   		return -ENODEV;
> >   
> >   	status = pcie_port_device_register(dev);
> > @@ -195,6 +196,8 @@ static const struct pci_device_id
> > port_pci_ids[] = {
> >   	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
> >   	/* subtractive decode PCI-to-PCI bridge, class type is 060401h
> > */
> >   	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0) },
> > +	/* handle any Root Complex Event Collector */
> > +	{ PCI_DEVICE_CLASS(((PCI_CLASS_SYSTEM_RCEC << 8) | 0x00), ~0)
> > },
> >   	{ },
> >   };
> >   
> > 

