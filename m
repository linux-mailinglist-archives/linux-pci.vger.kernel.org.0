Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F02C10D7F
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 21:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfEATwH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 15:52:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41780 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEATwH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 May 2019 15:52:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id g8so29561otl.8;
        Wed, 01 May 2019 12:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9NsoR2Ks/W073QysE5yiIgEpVwfiWFp5562O18X26QE=;
        b=RpCYv/IKgMrHt3bK+CcPrSTugRf2q1z/VL8Bnxd5yWXp4ISONJzH/4/B3GQpAMcQ1i
         Heu/OKRGb941Zdm1BwywzB11Stn0KOfTHZvWelDwf44KgGE3/ZILO0LhEl0ElFFoaR8o
         Bp6/18g9WZoa6ac8Z1NJyjFqJBdQtmnLsd5G5hlRt0Rr3Grfrxu5q2k/ya7ofLukDFTV
         xbAxXkQ8T5GKwodaop0pHJx9/KmRlcyRsgmkz9e/7/1qCIO3Sj6DZq3K+KQcZE7troBz
         Jf1hj+qyxyh8XF6Fx/guyYWE/i7UxJR65E/sZ3ex7jtEbL9M9UU/knWCIHDJTc1wnTzF
         bS8Q==
X-Gm-Message-State: APjAAAUrunYLa8zAkCO7Aj2iAaun4gi1PyOQwLgrh37lKNTmOE+Y8sXi
        5CGTwzkm00gO/8exnw5gqg==
X-Google-Smtp-Source: APXvYqwy8SA0ZY6TS2WSuhSqkpoE//XrYc9gQ9DbySPebHLRUVxHj7ufxND2egI0VpUD0DrkS21ywA==
X-Received: by 2002:a9d:7408:: with SMTP id n8mr3916248otk.256.1556740326696;
        Wed, 01 May 2019 12:52:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i203sm8590198oif.32.2019.05.01.12.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 12:52:06 -0700 (PDT)
Date:   Wed, 1 May 2019 14:52:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     thierry.reding@gmail.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com,
        lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH V2 23/28] dt-bindings: pci: tegra: Document PCIe DPD
 pinctrl optional prop
Message-ID: <20190501195205.GA16256@bogus>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-24-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423092825.759-24-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 23 Apr 2019 14:58:20 +0530, Manikanta Maddireddy wrote:
> Document PCIe DPD pinctrl optional property to put PEX clk & BIAS pads
> in low power mode.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Using standard pinctrl names, default and idle
> 
>  .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt       | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
