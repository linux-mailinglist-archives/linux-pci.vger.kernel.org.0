Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF021C1A04
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgEAPsQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 11:48:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgEAPsQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 11:48:16 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F4E52137B;
        Fri,  1 May 2020 15:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588348095;
        bh=sBnS1EAfBQE4efMp26hhUr4f8wzrVS3x6YefMaqZz78=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DOPwEHGEjZEqnMfaWUQKHWkEMEd+Tmn4mT/4fCOCQuSLDpdqM5LvI/prO07lQVkNY
         9djefE/1vYJ58NdJdo9JImILf5z5Eu9mrGb48pPQtkIdIBgtEO3yfRBTLD3QcMvqCj
         PoC7eZ1+mBwZI7qhAbq6/geugvC9ZrxiCaHFzlyM=
Received: by mail-ot1-f46.google.com with SMTP id e20so2836675otk.12;
        Fri, 01 May 2020 08:48:15 -0700 (PDT)
X-Gm-Message-State: AGi0Pua3/uYObqY7xaHAPZCufel+aPB+M5Do3JoFjocssHbXGnroP0Uh
        CfdEASWcBNtXGOjl9PyLAGb+lbsdP1gDokcs7Q==
X-Google-Smtp-Source: APiQypLSuc1ficUgLIosueT06J05P8GWHscTEPVhw4ZK+6CAG+77HGOr9d8WOB+9XJU4M5RRsaeSpyrJ9RGJ98tkcT8=
X-Received: by 2002:a9d:1441:: with SMTP id h59mr4125612oth.192.1588348094755;
 Fri, 01 May 2020 08:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200501142831.35174-1-james.quinlan@broadcom.com> <20200501142831.35174-4-james.quinlan@broadcom.com>
In-Reply-To: <20200501142831.35174-4-james.quinlan@broadcom.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 1 May 2020 10:48:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKjRYXbtDVRnR6POfKtLBHULn=VGHSe2KFj1PTWSbA57g@mail.gmail.com>
Message-ID: <CAL_JsqKjRYXbtDVRnR6POfKtLBHULn=VGHSe2KFj1PTWSbA57g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: PCI: brcmstb: New prop 'aspm-no-l0s'
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 1, 2020 at 9:29 AM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>
> From: Jim Quinlan <jquinlan@broadcom.com>
>
> For various reasons, one may want to disable the ASPM L0s
> capability.
>
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> ---
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 77d3e81a437b..084e4cf68b95 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -56,6 +56,10 @@ properties:
>      description: Indicates usage of spread-spectrum clocking.
>      type: boolean
>
> +  aspm-no-l0s:
> +    description: Disables ASPM L0s capability.
> +    type: boolean

Copied from rockchip-pcie-host.txt? Let's make this a standard
property. It should be documented here[1].

Then this doc just needs 'aspm-no-l0s: true' to indicate you are using it.

Rob

[1] https://github.com/devicetree-org/dt-schema/blob/master/schemas/pci/pci-bus.yaml
