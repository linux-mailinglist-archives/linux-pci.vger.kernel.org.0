Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43296466D17
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 23:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349088AbhLBWow (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 17:44:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39260 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242668AbhLBWow (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 17:44:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E5576287C;
        Thu,  2 Dec 2021 22:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B69BC53FCD;
        Thu,  2 Dec 2021 22:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638484888;
        bh=6OiKIjxtmjjpUOCmkRIj43jn8Md1ipCMNo/5OXc5h2U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A77LaDEakD7rtcB3KbTrqnfE9Ky1ZHZiM38wgDdUrUjeRW9pQo+EuNeoQBMcPWeJq
         oKk1QW1TP1/R3wsoJY9Z54V6zvQRs8DgjwGlrt8DXXBFguYGn7VkVWGI5t6cEMjRZ+
         /6Ou1f5zfXafc3vSum3HaCC0pWnxosFtJb0SXlwZ6bk2JUFTufy4s3uqar3NDxMk0q
         DpKUfnyObNN4rDJVrSKVB0uR5Rni+wZuaWJjWxNp/SO3kdA0ojapUhn2DLxvDurosB
         6jJrdhE/w1vWBB2NJZcor6xqYyd0g9Pv5cGoh/PNSbnkaDWvxr20JnY2PbsXzI6apd
         YJMQboRbBeRbA==
Received: by mail-ed1-f45.google.com with SMTP id z5so4039017edd.3;
        Thu, 02 Dec 2021 14:41:28 -0800 (PST)
X-Gm-Message-State: AOAM532qQ0QuDDbRyGaF8bOEt7iupTAmdHSxj//x9NWiinQe8Fi6qoGx
        bg1cZhAMmVbN2FKRfrBbw5ylk/Qxp1352JVegw==
X-Google-Smtp-Source: ABdhPJwlI+p9riw2EQARHYYQ7wuw9z4/AosHRQ9rvr5bD+PLTYx0Lh9d9ZeTJuc1FvaYCGMzuZBpIJCZb8ZoQcYci6w=
X-Received: by 2002:a17:907:16ac:: with SMTP id hc44mr18010068ejc.363.1638484887007;
 Thu, 02 Dec 2021 14:41:27 -0800 (PST)
MIME-Version: 1.0
References: <20211202223609.1171452-1-f.fainelli@gmail.com>
In-Reply-To: <20211202223609.1171452-1-f.fainelli@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 2 Dec 2021 16:41:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLR=TeKFj1DO-UDcFDcuuw9VUzy9tdxmdK797ywX+fN8g@mail.gmail.com>
Message-ID: <CAL_JsqLR=TeKFj1DO-UDcFDcuuw9VUzy9tdxmdK797ywX+fN8g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: brcmstb: compatible is required
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:BROADCOM STB PCIE DRIVER" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 2, 2021 at 4:36 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> The compatible property is required, make sure the binding documents it
> as such.

Yes, though if 'compatible' is not present and matching, the schema is
never applied. I'll apply it later, but I wouldn't be too concerned
fixing any others.

> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 1fe102743f82..7c24d711b377 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -76,6 +76,7 @@ properties:
>        maxItems: 3
>
>  required:
> +  - compatible
>    - reg
>    - ranges
>    - dma-ranges
> --
> 2.25.1
>
