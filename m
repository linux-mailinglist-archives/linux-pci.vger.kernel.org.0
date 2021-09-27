Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164AB4199FA
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 19:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhI0RFy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 13:05:54 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:46686 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbhI0RFi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Sep 2021 13:05:38 -0400
Received: by mail-ot1-f52.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so23250560ota.13;
        Mon, 27 Sep 2021 10:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C/jjeb5V5zArlx4eFPn95hjOtyLhzqqErbP7ergc4K8=;
        b=6euDN4uIryCPprIqM2GN3L9NGiz1QbhZg9dKh8oXuZc44dO1L2w2lnnnmFKtGnwH75
         hauBud+tlYDKjEmafsX4oFIUYccNZQiS+AmT09qCs0HimAkRFL67+LDd/kbQWUBZ00Qn
         gGvy8ErQzNE24BCw3aGs/xvrGMmNSkZewHjS2ayyIZ77f7NpQvFTbuchJgZvf61wcMX7
         mGP2luFe8asvitkPERZPtFB9mGW61I1BVg3ZlRpGm6duZsHb+25tUGJKhq5919WEoxEP
         g5HH389Q8FxsvIVGLBI8CWod/b7/ZvRs12B59M0gGIDUBiRI4PsKPJ4zIz2KsGLTf7z0
         Y3XQ==
X-Gm-Message-State: AOAM532AIVh0uv7gnZlm352reNjlVj7vVrqRcqKHzVSPz2/7J4C6Naxd
        r2e+JVmgyS1XUZ4jk33FmA==
X-Google-Smtp-Source: ABdhPJwDYK9CtDPFvmcT9FbrW/OuLYcWgNoxrp02aOQ2qkD80fHL9UlbaDaUsTRVgLJ+/kJljMlS6A==
X-Received: by 2002:a05:6830:2b0e:: with SMTP id l14mr904793otv.201.1632762239188;
        Mon, 27 Sep 2021 10:03:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g4sm311981ooa.44.2021.09.27.10.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 10:03:58 -0700 (PDT)
Received: (nullmailer pid 3472455 invoked by uid 1000);
        Mon, 27 Sep 2021 17:03:57 -0000
Date:   Mon, 27 Sep 2021 12:03:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mark Kettenis <kettenis@openbsd.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Saenz Julienne <nsaenzjulienne@suse.de>, maz@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        linux-rpi-kernel@lists.infradead.org, robin.murphy@arm.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        alyssa@rosenzweig.io, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-pci@vger.kernel.org, sven@svenpeter.dev
Subject: Re: [PATCH v5 3/4] dt-bindings: pci: Add DT bindings for apple,pcie
Message-ID: <YVH5fZeIJBRQbU4O@robh.at.kernel.org>
References: <20210921183420.436-1-kettenis@openbsd.org>
 <20210921183420.436-4-kettenis@openbsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921183420.436-4-kettenis@openbsd.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 21 Sep 2021 20:34:14 +0200, Mark Kettenis wrote:
> The Apple PCIe host controller is a PCIe host controller with
> multiple root ports present in Apple ARM SoC platforms, including
> various iPhone and iPad devices and the "Apple Silicon" Macs.
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>  .../devicetree/bindings/pci/apple,pcie.yaml   | 161 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
> 

Applied, thanks!
