Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032481E65D0
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 17:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404230AbgE1PT1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 11:19:27 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34743 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404149AbgE1PT0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2020 11:19:26 -0400
Received: by mail-il1-f195.google.com with SMTP id v11so522331ilh.1;
        Thu, 28 May 2020 08:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5kBEZPlNqzKPyCgrp/KWIwOTiSVLQMBol2Vgbb91EpM=;
        b=MM1PuxzpqwTUehG7kwhCLrTNuKmCNylscFq0rcDhM6R7rFAGG3ZHG+hq0cRrsxO6Ku
         sRMGYnY3c7x7LFWYEBah3koE+3Ut67yVZl27KE949sM+pL76+oshChxho2bucOFA76Ny
         5Hqa/fTooJiZWVD1GcANLMuwOwjGI66hiXAs5c9NacgfHWXAHzN6koE7pceU5AzEhqmS
         bXrTZbMqeVjvbaD55+4283EMhjn+QpxgcsvjKMFV3ev+hiGpkhxs0c0HHaAxJK5qIa+u
         dunTDE2VyfofG8NxAeI8l1w9KEIj2upHlJyK5PMVkmjOtSIYXdhTepvtYwrBi8hSBmO5
         Bf8w==
X-Gm-Message-State: AOAM5335qDZG27izfSauiRbLwMe0+24cE1c9hJqwrX0Q2UW+wRBhi8aA
        Ea+VFfY6TL5hT5ecxQ0iLw==
X-Google-Smtp-Source: ABdhPJwibNiFPrIx377+XuzcIXNpytt1Fqw5yA5j7iuroWojsn3v5IBwUqhYpDxPaOr7/N2GzRdyqw==
X-Received: by 2002:a92:1b86:: with SMTP id f6mr3430564ill.9.1590679165207;
        Thu, 28 May 2020 08:19:25 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u66sm3018630ilc.61.2020.05.28.08.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:19:24 -0700 (PDT)
Received: (nullmailer pid 94809 invoked by uid 1000);
        Thu, 28 May 2020 15:19:23 -0000
Date:   Thu, 28 May 2020 09:19:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-pci@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: Add UniPhier PCIe endpoint
 controller description
Message-ID: <20200528151923.GA94755@bogus>
References: <1589457801-12796-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1589457801-12796-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589457801-12796-2-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 May 2020 21:03:20 +0900, Kunihiko Hayashi wrote:
> Add DT bindings for PCIe controller implemented in UniPhier SoCs
> when configured in endpoint mode. This controller is based on
> the DesignWare PCIe core.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/pci/socionext,uniphier-pcie-ep.yaml   | 92 ++++++++++++++++++++++
>  MAINTAINERS                                        |  2 +-
>  2 files changed, 93 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
