Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3A23090C1
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jan 2021 00:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhA2Xub (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jan 2021 18:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231183AbhA2Xua (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jan 2021 18:50:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 981A064DF1;
        Fri, 29 Jan 2021 23:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611964189;
        bh=bHyYJM7rYjf5CG3Ie3F1ruLwv+EQLpu9ZTUQs5cnxDc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MjsDm8SUiSeg6YRfsO48BX0463Gep9k6glJkmCdVInyM9bjzFEjBckzKPduMQupuD
         bxUG/INgM1ytQxttxAKBNQ7L4HpizJLtHLXVayViDThtW8brJCD+FvycvZVdyDUWor
         g+EykFh0ZORQkYq/qcT9Q25rfjGyQqnyu4aUlVwOCBjfnZtK+aPhJGqQh/Ubg06Gdt
         aIRmx/XaFi025k5KL1I3H1yQtWKEJ46CAsAvhRbjbBA329iXYJ5omgcm5yjWKq4Wxw
         iIvDxrh3waeG56PKMYIelXrpzlxwZK870wGQXKG/IW26IQP/NdFLBhEff3LJzUpifU
         MVboCzc1Qp9vw==
Date:   Fri, 29 Jan 2021 17:49:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Antti =?iso-8859-1?Q?J=E4rvinen?= <antti.jarvinen@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] PCI: quirk for preventing bus reset on TI C667X
Message-ID: <20210129234946.GA124037@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35612e76-0b97-7bb4-60b7-88ae6d53f0be@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 26, 2021 at 01:22:18PM +0200, Antti Järvinen wrote:
> On 22.1.2021 1.55, Bjorn Helgaas wrote:> 
> 
> > It looks like we would probably be trying a Secondary Bus Reset using
> > the bridge leading to the C667X.  Can you confirm? 
> 
> Yes, this is my understanding too.
> 
> > Wonder if you
> > could try doing what pci_reset_secondary_bus() does by hand:
> > 
> 
> I tried this by hand. It looks that result is same as through VFIO.
> 
> # cat sbr.sh
> BRIDGE=10:00.0
> C667X=11:00.0
> 
> setpci -s$C667X VENDOR_ID.w
> 
> VAL=$(setpci -s$BRIDGE BRIDGE_CONTROL.w)
> echo $VAL
> setpci -s$BRIDGE BRIDGE_CONTROL.w=$(($VAL | 0x40))
> sleep 1
> setpci -s$BRIDGE BRIDGE_CONTROL.w=$VAL
> sleep 1
> setpci -s$C667X VENDOR_ID.w=0
> setpci -s$C667X VENDOR_ID.w
> 
> 
> # ./sbr.sh
> 104c
> 0003
> ffff
> 
> 
> >   # BRIDGE=...                              # PCI address, e.g., 00:1c.0
> >   # C667X=...
> >   # setpci -s$C667X VENDOR_ID.w
> >   # setpci -s$BRIDGE BRIDGE_CONTROL.w       # prints "val"
> >   # setpci -s$BRIDGE BRIDGE_CONTROL.w=      # val | 0x40 (set SBR)
> >   # sleep 1
> >   # setpci -s$BRIDGE BRIDGE_CONTROL.w=      # val (clear SBR)
> >   # sleep 1
> >   # setpci -s$C667X VENDOR_ID.w=0
> >   # setpci -s$C667X VENDOR_ID.w
> > 
> > If we use this quirk and avoid the reset, I assume that means
> > assigning the device to VMs with VFIO will leak state between VMs?
> 
> I think this is true.

Alex, is there some warning about situations like this where a device
may leak state between VMs?

There's nothing in quirk_no_bus_reset() itself where we set
PCI_DEV_FLAGS_NO_BUS_RESET, and nothing in pci_parent_bus_reset() or
pci_dev_reset_slot_function() where we test it, but I didn't chase
into VFIO.

Seems important enough that we might want to mention it at least once
and maybe even every time we try to reset the device.  I hope the leak
isn't completely silent.

Bjorn
