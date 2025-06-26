Return-Path: <linux-pci+bounces-30845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6EBAEA979
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D365556091E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855312153D3;
	Thu, 26 Jun 2025 22:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGOXiSZb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AAC213E74
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976272; cv=none; b=MIom34Vc41MWwztOjGpaXj2GzBFeTAySclgL8daP08tT980MGpYRb2q3npCEHC0jXnvH1P6fTKvFzK3nRN9mhO2e60cn4r7q78ozdY9uoAdlBxl1ZuDc15S+4bXFHpqmh/y2uFPMC3NpdPYYgJqoA/sBDPTjvxO5SrH4kwpUUyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976272; c=relaxed/simple;
	bh=MYtDdVYd0y1Ci0JlvX7groRfhkR30Cjj8br4lYV6ZGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PoE4MXYFnarPupXPnySLsMTSYgXQ6ErSFjUNYRsWZdy7xWYvXjuoEXmXIID0RvaBsmvy6bsCGxErFz7fj3dyjylz3H27anK9twtvQuJAcrv056htuIZjySuW5K2VH9ZFUd0TkbjN7EmxQTWulQWk7ZzCOHGUze1AtstcLa9cyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGOXiSZb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7394772635dso1076680b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 15:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750976270; x=1751581070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8zJT2nyBD/ZES/bgHq4ennx8G+2QIzbohvYjrsQZiSA=;
        b=HGOXiSZb+p1uUk2bsN/GeXzyvWY5xc79lNt5+ggSgEE1LO/TBHi4qEpzag9IDp/yr6
         0VZSoJSNVnYsK6MT2B7uwXM8nbLp+jxC4EFoXcgiXN2c6Vev7zHUHZ5m+C28JKvwBnsW
         zxG5BEVzLffsdmf+8cViQJHK7T9bvjh3bksG+2a1fXo6l7IDJK8Gat0wPkLhpREyqfOw
         1savsADuZOUmdzDWeHjnxv9iq1knPwvytLt90jIPKxyX6fjxKZHDmVJu68wGItulQoLT
         7uPBCkH3SliBCmUGO+a9Q0KnWUlhug5Kmol0RTuv3vf68YPDxOBg+pbJ/g7w/yLrD8wQ
         hWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750976270; x=1751581070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zJT2nyBD/ZES/bgHq4ennx8G+2QIzbohvYjrsQZiSA=;
        b=eoB40MznH9IjFzrTKSWzo9mQUmiweypr5ahqv7x3NF2eJwLZsR6o6tpdqiySs19vjN
         oMZB4COEYgO69EL76yT8R0y0pYVpOowAsDlxYFO1oc6azP0oz91TUzDFjJBMjpYWe/Gi
         WUGfwf76Ov+pqqOnioPD/O4CZUf6rr64/zXSOamyv3nLgHEBFk1kx97bbkrei92kMZuR
         pP78AL9Ylx4CYf5oEaf6R0S3p0S7WbUWJ+nSYQsXekSbetr4hPj20/0uKvVPBVh+sZWs
         UDePwlL2qXlXPIhBs07qyh3duCUH0UZi63uc0G4p7NOYiaUpOlIT9Lbg8JNaFlVSwoIr
         eutQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5KbLQN2uoSs80v6ZjqkVXASdNGlD4XxCIOY3nJtiSgncEhKl7nWZGYDfD+k1HcwzAx2PpikkDw90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoyRNdyBmb6s2FTjO0msoDkfI9fU9+U7TDcioYQ6NnYP1sRuYa
	Ct23n6zEGEgFGE86sPPuxc40rKXILw6Kxm1un7U16C4RLxA/6CvJodmeGFzM7piV3P9Xgy4I+AK
	zC/aTCg==
X-Google-Smtp-Source: AGHT+IHY/EPT/zmKG1i7jacrdolpL1ToMgnL7IztE9rUDP/sr/QX/ddMHlpECos0ZSbpr8h5AgefkNdMO+4=
X-Received: from pgg8.prod.google.com ([2002:a05:6a02:4d88:b0:b2f:5d02:68e9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6da8:b0:21f:568c:712c
 with SMTP id adf61e73a8af0-220a12e39c1mr960899637.14.1750976270374; Thu, 26
 Jun 2025 15:17:50 -0700 (PDT)
Date: Thu, 26 Jun 2025 15:17:48 -0700
In-Reply-To: <20250625230313.GA1593493@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624171637.485616-1-seanjc@google.com> <20250625230313.GA1593493@bhelgaas>
Message-ID: <aF3HDIzpe3vnpBdj@google.com>
Subject: Re: [RFC PATCH] PCI: Support Immediate Readiness on devices without
 PM capabilities
From: Sean Christopherson <seanjc@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 25, 2025, Bjorn Helgaas wrote:
> On Tue, Jun 24, 2025 at 10:16:37AM -0700, Sean Christopherson wrote:
> > +void pci_pm_init(struct pci_dev *dev)
> > +{
> > +	u16 status;
> > +
> > +	device_enable_async_suspend(&dev->dev);
> > +	dev->wakeup_prepared = false;
> > +
> > +	dev->pm_cap = 0;
> > +	dev->pme_support = 0;
> > +
> > +	/*
> > +	 * Note, support for the PCI PM spec is optional for legacy PCI devices
> > +	 * and for VFs.  Continue on even if no PM capabilities are supported.
> > +	 */
> > +	__pci_pm_init(dev);
> >  
> >  	pci_read_config_word(dev, PCI_STATUS, &status);
> >  	if (status & PCI_STATUS_IMM_READY)
> >  		dev->imm_ready = 1;
> 
> I would rather just move this PCI_STATUS read to somewhere else.  I
> don't think there's a great place to put it.  We could put it in
> set_pcie_port_type(), which is sort of a grab bag of PCIe-related
> things.
> 
> I don't know if it's necessarily even a PCIe-specific thing, but it
> would be unexpected if somebody made a conventional PCI device that
> set it, since the bit was reserved (and should be zero) in PCI r3.0
> and defined in PCIe r4.0.
> 
> Maybe we should put it in pci_setup_device() close to where we call
> pci_intx_mask_broken()?

Any reason not to throw it in pci_init_capabilities()?  That has the advantage
of minimizing the travel distance, e.g. to avoid introducing a goof similar to
what happened with 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing").

E.g. something silly like this?  Or maybe pci_misc_init() or so?

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9e42090fb108..4a1ba5c017cd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3205,7 +3205,6 @@ void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
 void pci_pm_init(struct pci_dev *dev)
 {
        int pm;
-       u16 status;
        u16 pmc;
 
        device_enable_async_suspend(&dev->dev);
@@ -3266,9 +3265,6 @@ void pci_pm_init(struct pci_dev *dev)
                pci_pme_active(dev, false);
        }
 
-       pci_read_config_word(dev, PCI_STATUS, &status);
-       if (status & PCI_STATUS_IMM_READY)
-               dev->imm_ready = 1;
 poweron:
        pci_pm_power_up_and_verify_state(dev);
        pm_runtime_forbid(&dev->dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4b8693ec9e4c..d33b8af37247 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2595,6 +2595,15 @@ void pcie_report_downtraining(struct pci_dev *dev)
        __pcie_print_link_status(dev, false);
 }
 
+static void pci_imm_ready_init(struct pci_dev *dev)
+{
+       u16 status;
+
+       pci_read_config_word(dev, PCI_STATUS, &status);
+       if (status & PCI_STATUS_IMM_READY)
+               dev->imm_ready = 1;
+}
+
 static void pci_init_capabilities(struct pci_dev *dev)
 {
        pci_ea_init(dev);               /* Enhanced Allocation */
@@ -2604,6 +2613,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
        /* Buffers for saving PCIe and PCI-X capabilities */
        pci_allocate_cap_save_buffers(dev);
 
+       pci_imm_ready_init(dev);        /* Immediate Ready */
        pci_pm_init(dev);               /* Power Management */
        pci_vpd_init(dev);              /* Vital Product Data */
        pci_configure_ari(dev);         /* Alternative Routing-ID Forwarding */

