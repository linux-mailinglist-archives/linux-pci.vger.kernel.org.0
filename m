Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0202B1080
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 22:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbgKLVeZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 16:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgKLVeZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 16:34:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0116C0613D1;
        Thu, 12 Nov 2020 13:34:24 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605216862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3bvy6rDTiG+QSb2CokdJjOXSIYS896H/oY3ZXOQcXt0=;
        b=rJbMMRpQB0plHKNFT2WVlgdjh5wsG8JwhP/s32stblDYnw7UlWg9M1ZgCiVFJhjwrQxQvt
        tH23ew8WhZ5CaKMYrP/4l6FbUC+K9ZvT8d90qSJ2ik3xuv4swo/jk1RLuIUTOASLSGL26C
        16U2HhDRxyeGGo9z3KC0x38oVNF6CfRc59pfNw/6LgDlgK1N+73A2kyRBr1IKrsSLZJo1b
        +pZPHj5iZRZ+Ex1I/L5tx87PvJFMXlk6dm4HxN8QR325LL8sz6jakYIB4hMiMC3cio4jOK
        iNr5e3ZwzBFboX5bIBDI50/T2kI9d932UBWG4a8eX+fS9vphMWTDXClH13zM3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605216862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3bvy6rDTiG+QSb2CokdJjOXSIYS896H/oY3ZXOQcXt0=;
        b=Xq9LmDFhJBGSzWGVcacQbRi35G9jreAOd9xuxmg6+RGDOE+vFzV0KZoEixn/hqWVODq9ou
        ibkTyhbw1Qi4ryDQ==
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Ziyad Atiyyeh <ziyadat@nvidia.com>,
        Itay Aveksis <itayav@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: iommu/vt-d: Cure VF irqdomain hickup
In-Reply-To: <87d00imlop.fsf@nanos.tec.linutronix.de>
References: <20200826111628.794979401@linutronix.de> <20201112125531.GA873287@nvidia.com> <87mtzmmzk6.fsf@nanos.tec.linutronix.de> <87k0uqmwn4.fsf@nanos.tec.linutronix.de> <87d00imlop.fsf@nanos.tec.linutronix.de>
Date:   Thu, 12 Nov 2020 22:34:22 +0100
Message-ID: <87a6vmmf8h.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 12 2020 at 20:15, Thomas Gleixner wrote:
> The recent changes to store the MSI irqdomain pointer in struct device
> missed that Intel DMAR does not register virtual function devices.  Due to
> that a VF device gets the plain PCI-MSI domain assigned and then issues
> compat MSI messages which get caught by the interrupt remapping unit.
>
> Cure that by inheriting the irq domain from the physical function
> device.
>
> That's a temporary workaround. The correct fix is to inherit the irq domain
> from the bus, but that's a larger effort which needs quite some other
> changes to the way how x86 manages PCI and MSI domains.

Bah, that's not really going to work with the way how irq remapping
works on x86 because at least Intel/DMAR can have more than one DMAR
unit on a bus.

So the alternative solution would be to assign the domain per device,
but the current ordering creates a hen and egg problem. Looking the
domain up in pci_set_msi_domain() does not work because at that point
the device is not registered in the IOMMU. That happens from
device_add().

Marc, is there any problem to reorder the calls in pci_device_add():

      device_add();
      pci_set_msi_domain();

That would allow to add a irq_find_matching_fwspec() based lookup to
pci_msi_get_device_domain().

Though I'm not yet convinced that the outcome would be less horrible
than the hack in the DMAR driver when I'm taking all the other horrors
of x86 (including XEN) into account :)

Thanks,

        tglx
