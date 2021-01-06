Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75AA2EC3D5
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 20:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbhAFTUi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 14:20:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbhAFTUi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Jan 2021 14:20:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 482AC23123;
        Wed,  6 Jan 2021 19:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609960797;
        bh=fg6pKGCbfBbQ402UIRKUbM2oI8qZIamYYsqXNBiukQ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sGK+cYJlUHsapV/ZeJ0er60257V0UsPOE1A+oHNgcB8WogiQppHa6WS14fI00AWJZ
         BK3jfE2hwzrepJzf6Si7wcK8CRhFD+/nwYnjJHvtAaRV9XRLYj1/tGRjPFzVYRUBOD
         IOJylOyt7o5gQXXUMfah/tyWZuFQIavJvXlf9VSU6kYWoaKPMFNry55dZhHMipMn96
         63dzFYuLXRzYt7n5kbsWNWXJWjhaQCB5wbD1MGOmybcmLVrQTp/smibpXJr3GcIcdb
         ffWP8WNeUeLTSzioUrHoUl51yY8VLyKydSCodx0cLDZ/xtqJBCqbvJas5z47qfGRtT
         s6fgcFrjWuyDQ==
Date:   Wed, 6 Jan 2021 13:19:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        broonie@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 0/6] brcmstb: add EP regulators and panic handler
Message-ID: <20210106191956.GA1328485@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130211145.3012-1-james.quinlan@broadcom.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 30, 2020 at 04:11:37PM -0500, Jim Quinlan wrote:
> v2 -- Use regulator bulk API rather than multiple calls (MarkB).
> 
> v1 -- Bindings are added for fixed regulators that may power the EP device.
>    -- The brcmstb RC driver is modified to control these regulators
>       during probe, suspend, and resume.
>    -- 7216 type SOCs have additional error reporting HW and a
>       panic handler is added to dump its info.
>    -- A missing return value check is added.
> 
> 
> Jim Quinlan (6):
>   dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
>   PCI: brcmstb: Add control of EP voltage regulator(s)
>   PCI: brcmstb: Do not turn off regulators if EP can wake up
>   PCI: brcmstb: Give 7216 SOCs their own config type
>   PCI: brcmstb: Add panic/die handler to RC driver
>   PCI: brcmstb: check return value of clk_prepare_enable()

If/when you repost this, capitalize the subjects consistently.

>  .../bindings/pci/brcm,stb-pcie.yaml           |  12 +
>  drivers/pci/controller/pcie-brcmstb.c         | 219 +++++++++++++++++-
>  2 files changed, 228 insertions(+), 3 deletions(-)
> 
> -- 
> 2.17.1
> 


