Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0336747487C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 17:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbhLNQtM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 11:49:12 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:34542 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhLNQtL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 11:49:11 -0500
Received: by mail-oi1-f174.google.com with SMTP id t19so27942310oij.1;
        Tue, 14 Dec 2021 08:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mQ+FCQGIjraSNBXn6Q0oHaQFvqG0vjLLJpw0h+bgBcE=;
        b=DHkFIdoPJ3H83MwUVM4l9bMbwghjr4zIfWHjqNaTLI35tM3he1L9jUozPZ09VfJEOQ
         KMRGMXn/1/u5msgTgmOVAyplrAYka3Nt/8fHoW+4jigVgrTYPiExWhuJqXkUX5tf/z6j
         Ha7i55lAly9h5cxRKaUlqHZqb52fGCIF6GXqFuysIw3awv4d/+QdgNeC5jUM5+xrebeX
         RuUsX+7yzUUo/1Rv/uPktrJ8AF6rB7KBQFn+O2e3p90VLnkZtoWKdgbGskKOq2VEhg+U
         9282Liouk5qd68U/FvJ29l/RJClrtjw00JJ89NN+O2Gz15i0VTvocY6KV2Zruy8a5dXO
         sOkg==
X-Gm-Message-State: AOAM533fXlWGNRjYg0i6Fjjz1qeqO9c2uUcAUrICmvc6axMte3tyUPCK
        6Wiih2MOE90rFUFD098hHQ==
X-Google-Smtp-Source: ABdhPJxZGlmqvZ6uMR2b+JkyeR0pbeVrj0fVdOUnnDv3i+buWlR8EMyWTY3fbd0mbE8E7kVIDnSKiw==
X-Received: by 2002:aca:674a:: with SMTP id b10mr5439657oiy.66.1639500550707;
        Tue, 14 Dec 2021 08:49:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n26sm74399ooc.48.2021.12.14.08.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:49:10 -0800 (PST)
Received: (nullmailer pid 3534175 invoked by uid 1000);
        Tue, 14 Dec 2021 16:49:09 -0000
Date:   Tue, 14 Dec 2021 10:49:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, Scott Branden <sbranden@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 5/6] dt-bindings: phy: Convert Cygnus PCIe PHY to YAML
Message-ID: <YbjLBem3gLRhLRM9@robh.at.kernel.org>
References: <20211214035820.2984289-1-f.fainelli@gmail.com>
 <20211214035820.2984289-6-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214035820.2984289-6-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 13 Dec 2021 19:58:19 -0800, Florian Fainelli wrote:
> Convert the Broadcom Cygnus PCIe PHY Device Tree binding t YAML to help
> with validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/phy/brcm,cygnus-pcie-phy.txt     | 47 ------------
>  .../bindings/phy/brcm,cygnus-pcie-phy.yaml    | 76 +++++++++++++++++++
>  2 files changed, 76 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml
> 

Applied, thanks!
