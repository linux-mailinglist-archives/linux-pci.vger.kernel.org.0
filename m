Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC1946DC7D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 20:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239837AbhLHTxS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 14:53:18 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:37563 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239819AbhLHTxR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 14:53:17 -0500
Received: by mail-oi1-f178.google.com with SMTP id bj13so5577439oib.4;
        Wed, 08 Dec 2021 11:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rVa3BN9ICjdPo+fxW6/2/1jtvm1eoAj57oX8lHz++pw=;
        b=iS3E2lQ7SGtPCoVkn32OY25v0hzkRYwtJBw2asI/JWpjQENmccyiIEH+ecoi/GxDvI
         mw+DB3cF/tqz6K6laAPFjqmSvA6HkCvUybUdwmDid3E/xVtsKHiJEe9RLf8RZEnAgNMQ
         ZlIDAmwpTB/T74sPbjy9cj5ql9Z6sg9PXUjh9+ngek152L6ZHnQXGBgWN3vyQOU18rNy
         rlyBSz5Tg7AdyQaxm9vIUm1S+JYamfCXaG1eBTQmBswk5EjR45KWzdFHYZNK0Kar9TnK
         RcGMeyeqZq/DwcuALgxilLVYKQcwnApBGtohDRpcfCtm0dwZxNTOb3EpjB7tihn/VPzJ
         FQdg==
X-Gm-Message-State: AOAM531ttUx+0egS0eTE0FBENH4kfSOoJ/DeIlkCGXLh2TtJpUZz6cYU
        NKEa8bDD9mM3exyI7Cqz/w==
X-Google-Smtp-Source: ABdhPJxJJITFE08gJlrj4ZABcCwvdBcDXuejUXyN59mEmfcVXx82o4BMKcMc3mdXNIIAG4u7Fh9qkg==
X-Received: by 2002:a05:6808:2181:: with SMTP id be1mr1377432oib.147.1638992985277;
        Wed, 08 Dec 2021 11:49:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g7sm649392oon.27.2021.12.08.11.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:49:44 -0800 (PST)
Received: (nullmailer pid 257561 invoked by uid 1000);
        Wed, 08 Dec 2021 19:49:43 -0000
Date:   Wed, 8 Dec 2021 13:49:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Jim Quinlan <jim2101024@gmail.com>,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: PCI: brcmstb: compatible is required
Message-ID: <YbEMV/M9+81/CQyM@robh.at.kernel.org>
References: <20211202223609.1171452-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202223609.1171452-1-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 02 Dec 2021 14:36:09 -0800, Florian Fainelli wrote:
> The compatible property is required, make sure the binding documents it
> as such.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
