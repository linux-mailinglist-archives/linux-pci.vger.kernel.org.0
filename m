Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E92C36140C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 23:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbhDOVUe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 17:20:34 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:34327 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbhDOVUe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Apr 2021 17:20:34 -0400
Received: by mail-oi1-f173.google.com with SMTP id k18so20812206oik.1;
        Thu, 15 Apr 2021 14:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pj47mw5Z19bo4piR6xETutvYCvQRjAqDcCMQcTewtb0=;
        b=CFRqTyNIiYSuYzGQMB2ptFfgcIebn23WyzrX76+6CP3KynTiMo4D7cTXTa5pjc8dav
         +hH+ZPkKuHS/YaULoREOhQ/p4Va7FRQXW0rEGAA6Z8w35KEg2DjXj3hnHsp0cIanNZJC
         N7Nd1KGZ7+BndINfdTy7cFYU0a4e04AF75UDQy3KBDR+dIrImCf75GE31Dk9hH0PAqy8
         8gJ1sgMZrqT2Uv+pmQ/YNIlqDsS/o1PQXeAwU/ZmGHVHxLswCkYgHFSuVqz8DRzeURR6
         JGOeucsmC4mu1mZgKbNmVayC1Kfi+wp5C0Cu0rvUcDOewrL+YRq+a/curcVYc1/OHUB9
         PXmw==
X-Gm-Message-State: AOAM531jXzc9CAFklkoy5V6iSJ2SEIC/gfd+VpJTFk5ZIbPh6NRRY860
        gJKcQ7p+DtdugZzLRLg+gw==
X-Google-Smtp-Source: ABdhPJzB+zGK5+x9z0k6g9pTrJvnmc0/86T4mHby4SRSIHNvDcP2g42n+KY2RNWooSLxfUActPPVbA==
X-Received: by 2002:aca:d907:: with SMTP id q7mr3934890oig.17.1618521610466;
        Thu, 15 Apr 2021 14:20:10 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j4sm860879oiw.0.2021.04.15.14.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 14:20:09 -0700 (PDT)
Received: (nullmailer pid 1901537 invoked by uid 1000);
        Thu, 15 Apr 2021 21:20:08 -0000
Date:   Thu, 15 Apr 2021 16:20:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     bpeled@marvell.com
Cc:     thomas.petazzoni@bootlin.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, andrew@lunn.ch, mw@semihalf.com,
        jaz@semihalf.com, kostap@marvell.com, nadavh@marvell.com,
        stefanc@marvell.com, oferh@marvell.com
Subject: Re: =?utf-8?B?W+KAnVBBVENI4oCdIHYyIDMvNV0g?=
 =?utf-8?Q?dt-bindings=3A_pci=3A_add_system_controlle?= =?utf-8?Q?r?= and MAC
 reset bit to Armada 7K/8K controller bindings
Message-ID: <20210415212008.GA1899572@robh.at.kernel.org>
References: <1618406454-7953-1-git-send-email-bpeled@marvell.com>
 <1618406454-7953-4-git-send-email-bpeled@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618406454-7953-4-git-send-email-bpeled@marvell.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 14, 2021 at 04:20:52PM +0300, bpeled@marvell.com wrote:
> From: Ben Peled <bpeled@marvell.com>
> 
> Adding optional system-controller and mac-reset-bit-mask
> needed for linkdown procedure.

Same comment as v1.

BTW, it's PATCH not "PATCH". Don't do anything and git will do the right 
thing here.

> 
> Signed-off-by: Ben Peled <bpeled@marvell.com>
> ---
>  Documentation/devicetree/bindings/pci/pci-armada8k.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> index 7a813d0..2696e79 100644
> --- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> @@ -24,6 +24,10 @@ Optional properties:
>  - phy-names: names of the PHYs corresponding to the number of lanes.
>  	Must be "cp0-pcie0-x4-lane0-phy", "cp0-pcie0-x4-lane1-phy" for
>  	2 PHYs.
> +- marvell,system-controller: address of system controller needed
> +	in order to reset MAC used by link-down handle
> +- marvell,mac-reset-bit-mask: MAC reset bit of system controller
> +	needed in order to reset MAC used by link-down handle
>  
>  Example:
>  
> @@ -45,4 +49,6 @@ Example:
>  		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>  		num-lanes = <1>;
>  		clocks = <&cpm_syscon0 1 13>;
> +		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
> +		marvell,mac-reset-bit-mask = <CP11X_PCIEx_MAC_RESET_BIT_MASK(1)>;
>  	};
> -- 
> 2.7.4
> 
