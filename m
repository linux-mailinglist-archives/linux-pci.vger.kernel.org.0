Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A529F2F6C95
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 21:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbhANUwY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 15:52:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbhANUwY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Jan 2021 15:52:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BE1023436;
        Thu, 14 Jan 2021 20:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610657503;
        bh=JMEP3qvxgNF3sBXT2ZlhoJfdGnMo3oAhoLgIt3PiwQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BJA8yTza0L2o30nDwP4OLxxC8c0nrrhwJtFWalJ9nEqW7yMITS5fPIRyb6Iol1ErO
         vqBgpvv8pe//9FzblHePOlvxipVhmNR6R1St91Kod4bHW25UromoxKu8bJ7/cHeOZo
         5ukDIR5TLj/Hb4zTOeOg+azcx6pBp6q3xuBmupB7tyRhd3ZvWWaRVQaUZoBpnKFe4m
         aeiBaJeRhWNEm8dGfxKcEq+6+Bg/EjQxSjE0zx1U+bxPNxwRkxDnv/GCWT5xgBHBMT
         b5LgzyhDiuPzCjwiX5z/RxV0jhsnFZWmL/UNEYi4XHHohV1sfoaLgcW/C6pMl8q3tO
         kRW5CfhBqPhNw==
Date:   Thu, 14 Jan 2021 14:51:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: Hook up a PCIe device into the thermal framework
Message-ID: <20210114205142.GA2021118@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHKzcEPuwZFei+6RehMn1yzRD45k_xfMgGC2Ma4eeR9y5rnFow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc thermal and DT folks]

On Thu, Jan 14, 2021 at 06:04:18PM +0100, Waldemar Rymarkiewicz wrote:
> Hi,
> 
> I've been looking for a nice way to hook up a PCIe device into the
> thermal framework recently and I want to confront my findings with the
> right people here.
> 
> I have a PCIe wireless adapter connected to PCI-to-PCI bridge which in
> turns is connected to a PCI root complex (RC). I want to define a
> thermal zone over the wireless adapter in my system and control it
> over DT (thermal-zones{...})  instead of keeping thermal zone
> definition statically in the PCI device driver (as it's done in the
> iwlwifi wireless driver or the mlxsw ethernet driver for example)
> 
> The issue I have faced is that a PCI device has no DT node
> (pci_dev.dev.of_node) which is reasonable as this is by design
> discoverable device. This, however, prevents me to register the PCI
> device as a thermal sensor (dev.of_node is required by thermal).
> 
> As far as we consider a fixed PCI topology eg. a SoC internal design I
> could put something like this in DT (used by ath11k/ath10k btw).
> 
> pci@... {
>    ...
>    pci-bridge@... {
>    ...
>         wifi:wifi@0 {
>               reg = <0x0 0 0 0 0>;
>               #thermal-sensor-cells = <0>;
>          };
>    };
> };
> 
> but in case we consider an arbitrary location of the device in PCI
> topology that DT modification will not work and still I have no device
> node.

I'm absolutely not a DT expert, but I assume that a thermal zone would
be associated with some resource fixed by the platform, such as a fan,
so I would think a thermal zone would have to be described in terms of
the platform physical topology, not the PCI device type.

> Is there any preferred solution in the Linux kernel for this kind of use-case?
> 
> All the ideas appreciated.
> 
> Thanks,
> /Waldek
