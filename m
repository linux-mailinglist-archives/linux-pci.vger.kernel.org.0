Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16AE29EF7A
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 17:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfH0P43 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 11:56:29 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:47094 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfH0P43 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 11:56:29 -0400
Received: by mail-oi1-f195.google.com with SMTP id t24so15313489oij.13;
        Tue, 27 Aug 2019 08:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=496l2D/NBnu+OvAkK9jRIei3uNVRt46Ohb23zKW6VBA=;
        b=Ip4BOgFzCmdSJc/Fj2oTurPMNEOsOCmNxXS7B9TKVMUyewmCdC3FaWNO//GgzOyalH
         Zw66tuSK2XIB91oiMc+sZ5HxOAqLIcQ/MVV2CMTMAeenQbEbvYR0vRKyixrU7oJUwY8x
         mjJLmxIRFc8fFh1ftQzCYGZ2Y0G/uiQyXTTPToamD4APVbUoXqg0b6Dwtm0pMdtVnl/D
         wqXB6x6R1PXyPXWZMpYSfz6qmom8qi7b0EYeENz9q7WKy92wOwga5rlozBvmYrANow+7
         rai58C49FldB685/szh2Z7jbD0Vxo7u3La8nIv/5MXPFxfW8CBqse283kBVUbjQKsdSv
         kXbQ==
X-Gm-Message-State: APjAAAUqHFl6R2yFiKMifC5AviQBHaV5ZJZwPUItWXRjX4B+c08rM40a
        AryHwdYF+ELXspM1bHI7Xw==
X-Google-Smtp-Source: APXvYqw99eOThTzexUEoPloxhW15jSlo6SFvfq/fyqIVqp8VzElz20lzUAUloqaV3S+Cnxsg4g40dw==
X-Received: by 2002:aca:c6d8:: with SMTP id w207mr15904130oif.94.1566921387977;
        Tue, 27 Aug 2019 08:56:27 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u5sm4384898oic.45.2019.08.27.08.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 08:56:27 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:56:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Draszik <git@andred.net>
Cc:     linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: imx6q-pcie: add
 "fsl,pcie-phy-refclk-internal" for i.MX7D
Message-ID: <20190827155626.GA29948@bogus>
References: <20190813103759.38358-1-git@andred.net>
 <20190813103759.38358-2-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190813103759.38358-2-git@andred.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 13, 2019 at 11:37:59AM +0100, André Draszik wrote:
> The i.MX7D variant of the IP can use either an external
> crystal oscillator input or an internal clock input as
> a reference clock input for the PCIe PHY.
> 
> Document the optional property 'fsl,pcie-phy-refclk-internal'
> 
> Signed-off-by: André Draszik <git@andred.net>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index a7f5f5afa0e6..985d7083df9f 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -56,6 +56,11 @@ Additional required properties for imx7d-pcie and imx8mq-pcie:
>  	       - "turnoff"
>  - fsl,imx7d-pcie-phy: A phandle to an fsl,imx7d-pcie-phy node.

Not sure how this got in, but why is the phy binding not used here?

>  
> +Additional optional properties for imx7d-pcie:
> +- fsl,pcie-phy-refclk-internal: If present then an internal PLL input is used
> +  as PCIe PHY reference clock source. By default an external ocsillator input
> +  is used.

Can't the clock binding and maybe 'assigned-clocks' be used here? 

Also, this is a property of the PHY, so it belongs in the PHY's node.

Rob
