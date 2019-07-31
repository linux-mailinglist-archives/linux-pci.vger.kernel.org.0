Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA87E7CFEC
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2019 23:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfGaVSo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Jul 2019 17:18:44 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:56703 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfGaVSo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jul 2019 17:18:44 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 5E1F53000467F;
        Wed, 31 Jul 2019 23:18:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 282E722B035; Wed, 31 Jul 2019 23:18:42 +0200 (CEST)
Date:   Wed, 31 Jul 2019 23:18:42 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Aaron Plattner <aplattner@nvidia.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Karol Herbst <kherbst@redhat.com>,
        Maik Freudenberg <hhfeuer@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "PCI: Enable NVIDIA HDA controllers"
Message-ID: <20190731211842.befvpoyudrm2subf@wunner.de>
References: <20190731201927.22054-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731201927.22054-1-lyude@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 31, 2019 at 04:19:27PM -0400, Lyude Paul wrote:
> While this fixes audio for a number of users, this commit has the
> sideaffect of breaking the BIOS workaround that's required to make the
> GPU on the nvidia P50 work, by causing the GPU's PCI device function to
> stop working after it's been set to multifunction mode.

This is missing a reference to the commit introducing the P50 quirk,
which is e0547c81bfcf ("PCI: Reset Lenovo ThinkPad P50 nvgpu at boot
if necessary").

Please describe in more detail how the GPU's PCI function stops working.
Does it respond with "all ones" when accessing MMIO?
Do MMIO accesses cause the system to hang?

Could you provide lspci -vvxx output for the GPU and its associated
HDA controller with and without b516ea586d71?

Does this machine have external display connectors via which audio
can be streamed?


> I'm not really holding my breath on this patch to being accepted:
> there's a good chance there's a better solution for this (and I'm going
> to continue investigating for one after sending this patch), this is
> more just to start a conversation on what the proper way to fix this is.

Posting as an RFC might have been more appropriate then.


> So, I'm kind of confused about why exactly this was implemented as an
> early boot quirk in the first place. If we're seeing the GPU's PCI
> device, we already know the GPU is there. Shouldn't we be able to check
> for the existence of the HDA device once we probe the GPU in nouveau?

I think a motivation to keep this generic was to make it work with
other drivers besides nouveau, specifically Nvidia's proprietary driver.
nouveau might not even be enabled.


> that still doesn't explain why this was implemented as an early quirk

This isn't an early quirk.  Those live in arch/x86/kernel/early-quirks.c.
This is just a PCI quirk executed on device enumeration and on resume.
Devices aren't necessarily enumerated only on boot, e.g. think Thunderbolt.

Thanks,

Lukas
