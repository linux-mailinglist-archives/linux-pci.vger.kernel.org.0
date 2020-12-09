Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E974F2D43CE
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 15:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbgLIOCM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 09:02:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36407 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbgLIOCH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2020 09:02:07 -0500
Received: by mail-ot1-f67.google.com with SMTP id y24so1422817otk.3;
        Wed, 09 Dec 2020 06:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sd8fD1HP0AJEeyA8TsTzLacJZWO7kg+ENpBmK4/xaNo=;
        b=Sluj24ioysUnqXOmhaqb1/A4DoBeNm+3DrIY1mjXdjWzk6ii7cIVqGR5GI/Pt4csa4
         ZtIYuB2hJLGCrGJuj9zYxdphrHLtU/K3PafYafD99V8xd7auSspXdY+EXIbM9Rd/Zz23
         ephZv6faNmh4cF4cnUBxMXnSQA755hotKN4H/+fAPpnYqkPlmG+amk4419+VNBZ2fNUJ
         bdK3jY9F7aNAA2ew/GB1/mR0xtSpHBlIs7RSqZqcUFcC5q2xLvwA9BY8n4//hZndjliv
         C8KHW/DFAstkyXEBCWzz63phq6+26xIftQ96U2XFms+svo4XTSxUsNra8jwU8pvbR4rt
         dOIg==
X-Gm-Message-State: AOAM533m34pqtBaLR7N7MPE299sCw/0GJxDTVNAoQUbzqYMl916KBp/t
        Fwc54gQs0mhtGn7q4R/qdQ==
X-Google-Smtp-Source: ABdhPJxxByan/XxZfDBvM7WtqrrDz3cgG+EGv1aSP5GqQ6pLfOTSPfezLRRpIurHDrQAWtJS5RHxkQ==
X-Received: by 2002:a9d:10d:: with SMTP id 13mr1861699otu.8.1607522484611;
        Wed, 09 Dec 2020 06:01:24 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m10sm348276oig.27.2020.12.09.06.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 06:01:23 -0800 (PST)
Received: (nullmailer pid 360450 invoked by uid 1000);
        Wed, 09 Dec 2020 14:01:22 -0000
Date:   Wed, 9 Dec 2020 08:01:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        broonie@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
Message-ID: <20201209140122.GA331678@robh.at.kernel.org>
References: <20201130211145.3012-1-james.quinlan@broadcom.com>
 <20201130211145.3012-2-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130211145.3012-2-james.quinlan@broadcom.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 30, 2020 at 04:11:38PM -0500, Jim Quinlan wrote:
> Quite similar to the regulator bindings found in "rockchip-pcie-host.txt",
> this allows optional regulators to be attached and controlled by the
> PCIe RC driver.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 807694b4f41f..baacc3d7ec87 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -85,6 +85,18 @@ properties:
>        minItems: 1
>        maxItems: 3
>  
> +  vpcie12v-supply:
> +    description: 12v regulator phandle for the endpoint device
> +
> +  vpcie3v3-supply:
> +    description: 3.3v regulator phandle for the endpoint device

12V and 3.3V are standard slot supplies, can you add them to 
pci-bus.yaml. Then some day maybe we can have common slot handling code.
 
With that, here you just need:

vpcie3v3-supply: true

> +
> +  vpcie1v8-supply:
> +    description: 1.8v regulator phandle for the endpoint device
> +
> +  vpcie0v9-supply:
> +    description: 0.9v regulator phandle for the endpoint device

These are not standard. They go to a soldered down device or 
non-standard connector? For the former, the device should really be 
described in DT and the supplies added there.

Mini PCIe connector also has 1.5V supply.

Rob
