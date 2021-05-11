Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F201437EE1E
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 00:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhELVJy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 17:09:54 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:42793 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385220AbhELUHT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 16:07:19 -0400
Received: by mail-oi1-f176.google.com with SMTP id w22so9510030oiw.9;
        Wed, 12 May 2021 13:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LLaiNSER/CuF4k/ZQl4o7B4RMtYVO4Q0ajyRegoC1pg=;
        b=JLXQbpPCwCoEuhGwHN23KanR8rgn16T+3a/xMKtqMHrjtOUnx/JhS8wtvyw732WsBO
         X2BMfRxuTTcbV4RBqc7cMwi/vjQq8BKH+rXn1/3ar+nFmeUUMTc26y7ZIxevV+zTGqBb
         bVffgH4mBzlufJbCBUOkiuhlZPxKmi7Te8GZSfmcXiOlEZGIo86tiC7Q5t8u7D2jzYAT
         x9KB6uPcpdfyuFYzLJH3wMdWlk7mgIpmoJkKxxqZ7YJsuvl8BD5aPjVQafPdon6lkjoq
         8QCnwVjWW5T3kUIcAugo22RDFhQabxTGSW+u37iT0ru5rlY5m+A8IBfJTImK6k999HLH
         a0Og==
X-Gm-Message-State: AOAM530N3f1TUf0ODcKnnBHMIx2MTBLEe6JOgGBOY6sMm3bapVdTgrw/
        qxoE2PITzs/iRS8IZRy2XQ==
X-Google-Smtp-Source: ABdhPJw82bZPlnu+iCAIt71VfQ3ogL1ELlUonEaYyHFwCebzooh6OM+Qw6hZR7vbx4spXvZC8c8xtQ==
X-Received: by 2002:aca:7501:: with SMTP id q1mr16399922oic.9.1620849970693;
        Wed, 12 May 2021 13:06:10 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a23sm171009otf.47.2021.05.12.13.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 13:06:09 -0700 (PDT)
Received: (nullmailer pid 2503320 invoked by uid 1000);
        Tue, 11 May 2021 19:55:52 -0000
Date:   Tue, 11 May 2021 14:55:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: Re: [PATCH 4/7] dt-bindings: imx6q-pcie: add a property configure
 refclk pad usage mode
Message-ID: <20210511195552.GA2496435@robh.at.kernel.org>
References: <20210510141509.929120-1-l.stach@pengutronix.de>
 <20210510141509.929120-4-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510141509.929120-4-l.stach@pengutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 10, 2021 at 04:15:06PM +0200, Lucas Stach wrote:
> Starting with the i.MX7, arch PCIe instance has a differential refclk pad,
> which can beused in multiple ways:
> 
> - It's not used at all and the PHY reference clock is provided by a SoC
>   internal source, like on the previous SOCs.
> - It's used as a clock input, for the board to provide a reference clock
>   for the PHY.
> - It's used as a clock output, where the PHY reference clock is provided
>   by a SoC internal source and the same clock is also routed to the
>   refclk pad for consumption of board-level components.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index 308540df99ef..3ebd8553a818 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -38,6 +38,11 @@ Optional properties:
>    The regulator will be enabled when initializing the PCIe host and
>    disabled either as part of the init process or when shutting down the
>    host.
> +- fsl,refclk-pad-mode: Usage mode of the refclk pad. Valid values:
> +  - 0: pad not used. PHY refclock is derived from SoC internal source.
> +  - 1: pad input. PHY refclock is provided externally via the refclk pad.
> +  - 2: pad output. PHY refclock is derived from SoC internal source and
> +       provided on the refclk pad.

Seems like this belongs in the PHY's node?

Or you could determine this based on the PHY's clock source. At least 
for the first 2 cases. Is there a known user for the 3rd case? If so, 
it's possible that what it's connected to needs a clock provider as 
well.

Rob
