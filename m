Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E348F44EDD8
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 21:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhKLUXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 15:23:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235292AbhKLUXq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Nov 2021 15:23:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D16A7610D2;
        Fri, 12 Nov 2021 20:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636748453;
        bh=QG1RTkjIm1ym6Mf4xj5ZqBBb9c7wMXQdzUU7jgKmeaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=k0AetiwU45kCR8l2vRqLMahVLzjopFRewSMfdrW5IK76d4KbbKhPTPUAbUoG38A7u
         FrktXnR9+LGOywMExkp3R3fP/bYtKy7EaO/KSjsTHYQ/euoHT1s4k8P3L+dsdKhpDN
         oztbO5Q/C5e3eITvlsgCv13GVh5+Rba2WQHv1HcNanElAOjfxyeQz4hODOAONRuAA5
         DnOFQMr/NAJfzXE4iqYMEwFU9H7sJhLQOKmVwU9PfYID7jEbM1xwIPMSYACnKTQyCG
         NoRm83nvXCzs6SWyj15ZdPKSyAoJps6Bf3nX9oybuahu00vf5sc2My99aKuSdoJk6Y
         byHtJRXYKiAug==
Date:   Fri, 12 Nov 2021 14:20:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 3/8] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
Message-ID: <20211112202051.GA1414166@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCKTBun0MCiH5QWBMQqP+pxAN=+dX=ziB1ga39kdr5CmK=Gfw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 12, 2021 at 01:25:11PM -0500, Jim Quinlan wrote:
> On Thu, Nov 11, 2021 at 5:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Nov 10, 2021 at 05:14:43PM -0500, Jim Quinlan wrote:
> > > Similar to the regulator bindings found in "rockchip-pcie-host.txt", this
> > > allows optional regulators to be attached and controlled by the PCIe RC
> > > driver.  That being said, this driver searches in the DT subnode (the EP
> > > node, eg pci-ep@0,0) for the regulator property.
> > >
> > > The use of a regulator property in the pcie EP subnode such as
> > > "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> > > file at
> > >
> > > https://github.com/devicetree-org/dt-schema/pull/63
> >
> > Can you use a lore URL here?  github.com is sort of outside the Linux
> > ecosystem and this link is more likely to remain useful if it's to
> > something in kernel.org.
> Hi Bjorn,
> I'm afraid I don't know how or if  this github repo transfers
> information to Linux.  RobH, what should I be doing here?

Does this change get posted to any mailing lists where people can
review it?  Or would people have to watch the github devicetree-org
repo if they wanted to do that?  I was assuming this pci-bus.yaml
change was something that would eventually end up in the Linux kernel
source tree, but dt-scheme doesn't seem to be based on Linus' tree, so
I don't know if there's a connection.

Bjorn
