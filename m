Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F50358B94
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 19:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhDHRl6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 13:41:58 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:46877 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbhDHRl5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 13:41:57 -0400
Received: by mail-oo1-f49.google.com with SMTP id 125-20020a4a1a830000b02901b6a144a417so687463oof.13;
        Thu, 08 Apr 2021 10:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TVCJiS1z+MY0UDiNoK/GhDDEmrRItUOoR1juoSlc43w=;
        b=sOSGeSrSRFIUfye5ALb6yaXHi+9AP8+D/85eSZTNlxvSeka3TTKlN6IsJj+ECzyT9l
         tKiNmRugKNQndHVAnL01I3ifIUSWn9JbbYI8r21JboAb2vbGXnS4FKvFjGbLLgXSwKSQ
         +FuaKAlXBkXyykt2V5Cy1vqaT6oeoVi3R4v+9gK8wnq44o3Zd83mDpEzq9lwPqdLRHdh
         0nOYqWRalef1mKtBeuQc/qewxsYLLvvffhY2AnAhNcx+r9rFOBOgoMxocxe5YMUQNMRE
         hukA7yyN+lnfmfULkXZsJ1PWyKxL36F8z0YBBW+YPS8GYrXQUHM4OB3RDtyIufkx3mdy
         WvpA==
X-Gm-Message-State: AOAM530ibY9pMW/6JHolBTTq4kpzqDfg7IZPrmk7HKKhvNJW9zSEWSGb
        KvUV5Rk11Ox/Jvbz2HQMSXiIZfQrHg==
X-Google-Smtp-Source: ABdhPJzdDpTqXgekllydAa3XosvM1EQ/Ki+dnUmydnVP+MBSIiHAKrmWN6QqPU8+GdXPyucFIQ/gcQ==
X-Received: by 2002:a4a:1ac3:: with SMTP id 186mr8444242oof.8.1617903704309;
        Thu, 08 Apr 2021 10:41:44 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s21sm27856oos.5.2021.04.08.10.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:41:43 -0700 (PDT)
Received: (nullmailer pid 1688167 invoked by uid 1000);
        Thu, 08 Apr 2021 17:41:42 -0000
Date:   Thu, 8 Apr 2021 12:41:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: PCI: Add bindings for Brcmstb
 endpoint device voltage regulators
Message-ID: <20210408174142.GB1556444@robh.at.kernel.org>
References: <20210401212148.47033-1-jim2101024@gmail.com>
 <20210401212148.47033-3-jim2101024@gmail.com>
 <20210406164708.GM6443@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406164708.GM6443@sirena.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 06, 2021 at 05:47:08PM +0100, Mark Brown wrote:
> On Thu, Apr 01, 2021 at 05:21:42PM -0400, Jim Quinlan wrote:
> > Similar to the regulator bindings found in "rockchip-pcie-host.txt", this
> > allows optional regulators to be attached and controlled by the PCIe RC
> > driver.  That being said, this driver searches in the DT subnode (the EP
> > node, eg pci@0,0) for the regulator property.
> 
> > The use of a regulator property in the pcie EP subnode such as
> > "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> > file at
> > 
> > https://github.com/devicetree-org/dt-schema/pull/54
> > 
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > index f90557f6deb8..f2caa5b3b281 100644
> > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > @@ -64,6 +64,9 @@ properties:
> >  
> >    aspm-no-l0s: true
> >  
> > +  vpcie12v-supply: true
> > +  vpcie3v3-supply: true
> > +
> 
> No great problem with having these in the controller node (assming it
> accurately describes the hardware) but I do think we ought to also be
> able to describe these per slot.

My hesistancy here is child nodes are already defined to be devices, not 
slots. That's generally the same thing though. However, 'reg' is a bit 
problematic as it includes the bus number which is dynamically 
assigned. (This is a mismatch between true OpenFirmware and FDT as OF 
was designed to populate the DT with what was discovered and that 
includes some runtime config such as bus number assignments.) Maybe we 
just say for FDT, the bus number is always 0 and ignored. In any case, 
there needs to be some thought on this as well as the more complicated 
case of devices needing device specific setup to be enumerated.

Rob
