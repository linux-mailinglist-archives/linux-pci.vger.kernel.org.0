Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEA14255FA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 17:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242243AbhJGPF1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 11:05:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233428AbhJGPF0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 11:05:26 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B55A860EE5;
        Thu,  7 Oct 2021 15:03:32 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mYUvi-00FLEb-Le; Thu, 07 Oct 2021 16:03:30 +0100
Date:   Thu, 07 Oct 2021 16:03:30 +0100
Message-ID: <874k9sri65.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     tglx@linutronix.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION (MCP79)
In-Reply-To: <CALjTZvbZK3vxexyoEHmh9TPoceckvGV7ACHjOa0rJ9HH=YAyYA@mail.gmail.com>
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
        <87ee8yquyi.wl-maz@kernel.org>
        <CALjTZvakX8Hz+ow3UeAuQiicVXtbkXEDFnHU-+n8Ts6i1LRyHQ@mail.gmail.com>
        <87bl41qkrh.wl-maz@kernel.org>
        <CALjTZvbsvsD6abpw0H5D4ngUXPrgM2mDV0DX5BQi0z8cd-yxzA@mail.gmail.com>
        <878rz5qbee.wl-maz@kernel.org>
        <CALjTZvZZf25tqoQWM_HsBb84JgKpMKAxqfhUdpD_e5M-Bc_yzA@mail.gmail.com>
        <875yu8rj5t.wl-maz@kernel.org>
        <CALjTZvbZK3vxexyoEHmh9TPoceckvGV7ACHjOa0rJ9HH=YAyYA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: rsalvaterra@gmail.com, tglx@linutronix.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 4537d1ea14fd..dc7741431bf3 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5795,3 +5795,9 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
> >  }
> >  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
> >                                PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> > +
> > +static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
> > +{
> > +       pdev->dev_flags |= PCI_MSI_FLAGS_MASKBIT;

Duh. Make that:

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index dc7741431bf3..89c7c99cd1bb 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5798,6 +5798,6 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
 
 static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
 {
-	pdev->dev_flags |= PCI_MSI_FLAGS_MASKBIT;
+	pdev->dev_flags |= PCI_DEV_FLAGS_HAS_MSI_MASKING;
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);

	M.

-- 
Without deviation from the norm, progress is not possible.
