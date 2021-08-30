Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0BB3FBABB
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 19:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbhH3RSc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 13:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237940AbhH3RSb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Aug 2021 13:18:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3C1060F42;
        Mon, 30 Aug 2021 17:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630343858;
        bh=H1o1TvSjaRf9FmgrRYENSuesBwwYmr16JkVBndSyqWM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eKpm45OEOc2RYw6pPy5L0eRx7GZb2p/bPUUHO7Frpwfxi9W0tuHQpFo2cLGVU00/X
         4GnSd0ZQ7xsaZ5PEgVz/N+wf0uuoRj0XI45VRAsrkoabR+HQvCLvPPNgzBvH9yZX6n
         vvdKtfDJvJTqgmYmosYatDwXv+7U/+1RlLatpHDPmCUFCT8Gb7yKKHKU2DaLhBvxni
         l7QfSHiDAIBsRYy65zeFXTulsaR2DllPUNZgCb4XQ290m6yVT5rNte2NPkc0ItDlkv
         S7adLu2hQqdMnWNe/ezYLu0x3NhlbTFwrsI4US39nTrnL5DMN8EcuUIoeRebzY+fD8
         4EzdjDLaO05VA==
Message-ID: <f683df669b9e4e844f801182dc405fc83a4d9099.camel@kernel.org>
Subject: Re: [PATCH v3 2/4] PCI: brcmstb: Add ACPI config space quirk
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        bcm-kernel-feedback-list@broadcom.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 30 Aug 2021 19:17:32 +0200
In-Reply-To: <f6860e38-c6fa-292d-f1a1-22b3e4b48f32@gmail.com>
References: <20210826071557.29239-1-jeremy.linton@arm.com>
         <20210826071557.29239-3-jeremy.linton@arm.com>
         <44ad79081412af289c68e74cdecb6a2baa2e873c.camel@kernel.org>
         <5c39cf29-a08f-48d1-b873-ce0fda763d66@arm.com>
         <f6860e38-c6fa-292d-f1a1-22b3e4b48f32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2021-08-30 at 09:27 -0700, Florian Fainelli wrote:
> 
> On 8/30/2021 9:23 AM, Jeremy Linton wrote:
> > Hi,
> > 
> > On 8/30/21 3:36 AM, nicolas saenz julienne wrote:
> > > Hi Jeremy,
> > > sorry for the late reply, I've been on vacation.
> > > 
> > > On Thu, 2021-08-26 at 02:15 -0500, Jeremy Linton wrote:
> > > 
> > > [...]
> > > 
> > > > +static void __iomem *brcm_pcie_map_conf2(struct pci_bus *bus,
> > > > +                    unsigned int devfn, int where)
> > > > +{
> > > > +    struct pci_config_window *cfg = bus->sysdata;
> > > > +    void __iomem *base = cfg->win;
> > > > +    int idx;
> > > > +    u32 up;
> > > > +
> > > > +    /* Accesses to the RC go right to the RC registers if slot==0 */
> > > > +    if (pci_is_root_bus(bus))
> > > > +        return PCI_SLOT(devfn) ? NULL : base + where;
> > > > +
> > > > +    /*
> > > > +     * Assure the link is up before sending requests downstream. 
> > > > This is done
> > > > +     * to avoid sending transactions to EPs that don't exist. Link flap
> > > > +     * conditions/etc make this race more probable. The resulting 
> > > > unrecoverable
> > > > +     * SERRORs will result in the machine crashing.
> > > > +     */
> > > > +    up = readl(base + PCIE_MISC_PCIE_STATUS);
> > > > +    if (!(up & PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK))
> > > > +        return NULL;
> > > > +
> > > > +    if (!(up & PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK))
> > > > +        return NULL;
> > > 
> > > Couldn't this be integrated in the original brcm_pcie_map_conf()? IIUC 
> > > there is
> > > nothing ACPI specific about it. It'd also make for less code duplication.
> > 
> > That is where I started with this, but it wasn't the linkup check/etc 
> > which caused me to hoist it but the fact that if ACPI quirks are enabled 
> > they end up statically built into the kernel. While if this host bridge 
> > is enabled, it can end up being a module, and the resulting mess I 
> > created trying to satisfy the CONFIG variations. I'm not much of a fan 
> > of copy/paste programming, but that IMHO ended up being the cleanest here.
> > 
> 
> Agreed, the open coding that is being done is reasonable IHMO, although 
> we may have to update the link up code in both pcie-brcmstb.c and this 
> file in the future if offsets/bits do change, nothing impossible though.

Fair enough.

Acked-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

Regards,
Nicolas

