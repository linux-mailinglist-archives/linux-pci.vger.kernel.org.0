Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3F1DDAC4
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 01:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgEUXLB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 19:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730626AbgEUXLB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 19:11:01 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE6C9207F9;
        Thu, 21 May 2020 23:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590102660;
        bh=wnVJsMcdVukL+7XmCXsH+1qcmY1rqDsn5grM0oKG+Vg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b50y5T4/xOs+s5TZp/SGmlaI5l765m7i1wx22uNGLyBKIBzdh+5hpkyDWuuwfftfw
         ZMVAwk/zlo8GumNufVyNpb4usNPG//XsYyyQXbgxHwdmLqfTUQP35eVkbpBQ8lm1Eo
         mVRPCZQ5iXEuAXf0diEbUoBLJVSOffrww0tgviDU=
Received: by mail-oi1-f177.google.com with SMTP id v128so7707241oia.7;
        Thu, 21 May 2020 16:11:00 -0700 (PDT)
X-Gm-Message-State: AOAM53180e4X3HqpOn6aE1T6np5sEF6fyled+u8zc+9xmYr6SKyKtT1o
        qmBfktppOthGudrOLxWCfINu/6rN+nrJIOo7Ow==
X-Google-Smtp-Source: ABdhPJyY199Y85sucuTO5/BYg8SBRhUI/9X/7ZmJwp5eotefflL8Rgk71V55e2sEv0jRnuhZ/fAClQc1SjSy9dm5eSY=
X-Received: by 2002:aca:f084:: with SMTP id o126mr744784oih.106.1590102659988;
 Thu, 21 May 2020 16:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com> <20200521130008.8266-10-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200521130008.8266-10-lorenzo.pieralisi@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 21 May 2020 17:10:49 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+h18gH2D3B-OZku6ACCgonPUJcUnrN8a5=jApsXHdB5Q@mail.gmail.com>
Message-ID: <CAL_Jsq+h18gH2D3B-OZku6ACCgonPUJcUnrN8a5=jApsXHdB5Q@mail.gmail.com>
Subject: Re: [PATCH 09/12] dt-bindings: arm: fsl: Add msi-map device-tree
 binding for fsl-mc bus
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Joerg Roedel <joro@8bytes.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 7:00 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> The existing bindings cannot be used to specify the relationship
> between fsl-mc devices and GIC ITSes.
>
> Add a generic binding for mapping fsl-mc devices to GIC ITSes, using
> msi-map property.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 30 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> index 9134e9bcca56..b0813b2d0493 100644
> --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> @@ -18,9 +18,9 @@ same hardware "isolation context" and a 10-bit value called an ICID
>  the requester.
>
>  The generic 'iommus' property is insufficient to describe the relationship
> -between ICIDs and IOMMUs, so an iommu-map property is used to define
> -the set of possible ICIDs under a root DPRC and how they map to
> -an IOMMU.
> +between ICIDs and IOMMUs, so the iommu-map and msi-map properties are used
> +to define the set of possible ICIDs under a root DPRC and how they map to
> +an IOMMU and a GIC ITS respectively.
>
>  For generic IOMMU bindings, see
>  Documentation/devicetree/bindings/iommu/iommu.txt.
> @@ -28,6 +28,9 @@ Documentation/devicetree/bindings/iommu/iommu.txt.
>  For arm-smmu binding, see:
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml.
>
> +For GICv3 and GIC ITS bindings, see:
> +Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml.
> +
>  Required properties:
>
>      - compatible
> @@ -119,6 +122,15 @@ Optional properties:
>    associated with the listed IOMMU, with the iommu-specifier
>    (i - icid-base + iommu-base).
>
> +- msi-map: Maps an ICID to a GIC ITS and associated iommu-specifier
> +  data.
> +
> +  The property is an arbitrary number of tuples of
> +  (icid-base,iommu,iommu-base,length).

I'm confused because the example has GIC ITS phandle, not an IOMMU.

What is an iommu-base?

> +
> +  Any ICID in the interval [icid-base, icid-base + length) is
> +  associated with the listed GIC ITS, with the iommu-specifier
> +  (i - icid-base + iommu-base).
>  Example:
>
>          smmu: iommu@5000000 {
> @@ -128,6 +140,16 @@ Example:
>                 ...
>          };
>
> +       gic: interrupt-controller@6000000 {
> +               compatible = "arm,gic-v3";
> +               ...
> +               its: gic-its@6020000 {
> +                       compatible = "arm,gic-v3-its";
> +                       msi-controller;
> +                       ...
> +               };
> +       };
> +
>          fsl_mc: fsl-mc@80c000000 {
>                  compatible = "fsl,qoriq-mc";
>                  reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
> @@ -135,6 +157,8 @@ Example:
>                  msi-parent = <&its>;
>                  /* define map for ICIDs 23-64 */
>                  iommu-map = <23 &smmu 23 41>;
> +                /* define msi map for ICIDs 23-64 */
> +                msi-map = <23 &its 23 41>;

Seeing 23 twice is odd. The numbers to the right of 'its' should be an
ITS number space.

>                  #address-cells = <3>;
>                  #size-cells = <1>;
>
> --
> 2.26.1
>
