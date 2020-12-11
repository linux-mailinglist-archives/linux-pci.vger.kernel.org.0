Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D972D6EF7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 04:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395303AbgLKD52 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 22:57:28 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:39536 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392205AbgLKD5V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2020 22:57:21 -0500
Received: by mail-oo1-f65.google.com with SMTP id k9so1829403oop.6;
        Thu, 10 Dec 2020 19:57:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ayCrwQlHyJ7DNWgoLclYh2e9r036lnB6ZWhtgl68KDs=;
        b=deZoHfqAd7a10RFDrtYBoUk1P2IyNEE7bv9TohGRPrQfLprjkIQC6W3RF9rycRQcK8
         ISMeZ86mlrXFEPQND1vamvEIaBu1MKxbiW4BQx/oABMpTNCfwiFDOl+xcRorNCkHObno
         3EKMbGv4yRtLxCAkwdjuSKp9zR9MM12gtzl5ByQBj0BAv8GNc5DG1nwul5/RooDNVDB1
         DM/LHFC1v5WDNUbKBenhZck7e8yF+sVKuI714Zyv12HUJ4UB49WtPWVLQnKu7aOoKNoS
         bkqJv9uK14j3K3ow6YYHQgmmZvE/NFj8uUH9FdDBVmaykrgqaZjSCOJSMFYn4+2ejU56
         KBow==
X-Gm-Message-State: AOAM5328csNoMjLFV1pPz3umnz1tfnzsjQqtj1aFqS3qD9Kmzm1YW1qq
        Ks+IsJnhu4Z14A+XZvnkMw==
X-Google-Smtp-Source: ABdhPJwwpC7HWUhCXu0d+UyWyoNPc3+FWY6aX/GqPI/txqW9+ZnUWzheF5f4zETBZ01DX/kKP7qTqg==
X-Received: by 2002:a4a:c485:: with SMTP id f5mr8470680ooq.78.1607659001036;
        Thu, 10 Dec 2020 19:56:41 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e1sm1534103oib.11.2020.12.10.19.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:56:40 -0800 (PST)
Received: (nullmailer pid 3616780 invoked by uid 1000);
        Fri, 11 Dec 2020 03:56:39 -0000
Date:   Thu, 10 Dec 2020 21:56:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-pci@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: brcmstb: add BCM4908 binding
Message-ID: <20201211035639.GA3616734@robh.at.kernel.org>
References: <20201210180421.7230-1-zajec5@gmail.com>
 <20201210180421.7230-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201210180421.7230-2-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 10 Dec 2020 19:04:20 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> BCM4908 is a SoC family with PCIe controller sharing design with the one
> for STB. BCM4908 has different power management and memory controller so
> few tweaks are required.
> 
> PERST# signal on BCM4908 is handled by an external MISC block so it
> needs specifying a reset phandle.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> V3: Drop "reset-names" from the generic "properties" - it's now defined as
>     "compatible" specific property
>     Drop "$ref" from the "resets" - thanks Rob.
> ---
>  .../bindings/pci/brcm,stb-pcie.yaml           | 37 ++++++++++++++-----
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
