Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBED1B995
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 17:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfEMPKl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 11:10:41 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40137 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfEMPKl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 11:10:41 -0400
Received: by mail-ot1-f68.google.com with SMTP id u11so1650957otq.7;
        Mon, 13 May 2019 08:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mrlBNb20gXfjogJL/vTxD9cKe2qkJA2/o6bt1fHbzvs=;
        b=ZqR0MZh33/xDApqoKIwiJmvIMtYy70DHOVP2jdGRZbj0bOFmncoiPXQ3+qtwAICDNt
         Z4l07sl0lTj1MK6arSv1BxokivfCS2LgJE+b/L6qLOWcq18jvHMpN14GWJ2tTs1GHEEd
         sLH4Czy4yqw6G8/LJTtrGwPiZUBotCY+RFIVDN+9LoJ+j1Zg6tElNtjAxx47EG24vSZM
         ULX+3moYYQYYmZYDoP1A8jgr4x9LTtyzEZ1rIG3c9yFAtwW7L2x5vifG0IJvQ2CbYysX
         H81vA9Pbpx5Xlvqo7O7iEX6f1fHnuAPbg6U+BriyP34fEtMIRq90ghA338zAUkmn+0sJ
         0Weg==
X-Gm-Message-State: APjAAAUWv4q7K/s3lwd7RpNPsGx0yCJ4pAGqQaUmJDDTIV8/WoZH9TvD
        iy7hKlB7cPkBgL+q0ejTiw==
X-Google-Smtp-Source: APXvYqz9+00kzCXfTWCaYUMHUIJW4CqyQSVc0SoytOVsa8luLWoZm8aaMTmTn2waEWJZVCnDKf4BTw==
X-Received: by 2002:a9d:4a98:: with SMTP id i24mr1395692otf.199.1557760240114;
        Mon, 13 May 2019 08:10:40 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 64sm5294507oth.47.2019.05.13.08.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 08:10:39 -0700 (PDT)
Date:   Mon, 13 May 2019 10:10:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V6 06/15] dt-bindings: PCI: designware: Add binding for
 CDM register check
Message-ID: <20190513151038.GA30653@bogus>
References: <20190513050626.14991-1-vidyas@nvidia.com>
 <20190513050626.14991-7-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513050626.14991-7-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 13, 2019 at 10:36:17AM +0530, Vidya Sagar wrote:
> Add support to enable CDM (Configuration Dependent Module) registers check
> for any data corruption. CDM registers include standard PCIe configuration
> space registers, Port Logic registers and iATU and DMA registers.
> Refer Section S.4 of Synopsys DesignWare Cores PCI Express Controller Databook
> Version 4.90a
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v5]:
> * None
> 
> Changes since [v4]:
> * None
> 
> Changes since [v3]:
> * None
> 
> Changes since [v2]:
> * Changed flag name from 'cdm-check' to 'enable-cdm-check'
> * Added info about Port Logic and DMA registers being part of CDM
> 
> Changes since [v1]:
> * This is a new patch in v2 series
> 
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index 5561a1c060d0..85b872c42a9f 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -34,6 +34,11 @@ Optional properties:
>  - clock-names: Must include the following entries:
>  	- "pcie"
>  	- "pcie_bus"
> +- enable-cdm-check: This is a boolean property and if present enables
> +   automatic checking of CDM (Configuration Dependent Module) registers
> +   for data corruption. CDM registers include standard PCIe configuration
> +   space registers, Port Logic registers, DMA and iATU (internal Address
> +   Translation Unit) registers.

snps,enable-cdm-check

>  RC mode:
>  - num-viewport: number of view ports configured in hardware. If a platform
>    does not specify it, the driver assumes 2.
> -- 
> 2.17.1
> 
