Return-Path: <linux-pci+bounces-588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F70980752B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 17:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A25CB20EC9
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2232381B2;
	Wed,  6 Dec 2023 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5IdAlbs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2C48CE6;
	Wed,  6 Dec 2023 16:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13909C433C7;
	Wed,  6 Dec 2023 16:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701880618;
	bh=PAw5s5SpAWe3wAZR6pYxGYEQ6qttc4q+gC0fJiypNJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=j5IdAlbsgiy+9Txp0nN0TqkTvpiW+CTXnI9lNDq++3fi3am94Qs2X/n+KzrkyejEp
	 yDvNGm/oI60UmMVRny3sU/H6xkSt4cIBVj1l8g5W98y7SaAdGoaPRMdMr9UyLBbg7T
	 VW+SLXgIxPyGK67PpZOX8ya4roe4chlVe9T243OyDUPZb+qrSBt5fvq+INI0AR7XQf
	 7X8zr5NSo44LOxHlEOlyvV0q1JNSRIGCqVNaTb4f2z1tabYGYxBmMXxErw5ChNto9O
	 4ijFzVuxjeGg8ZQNtgmJo4ysKf/sGsgin0Bm5BIGQ9K9HoF5EdYt8NyG/9C3NApun2
	 GNhIGKz2TJHNQ==
Date: Wed, 6 Dec 2023 10:36:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	"open list:PCI DRIVER FOR IMX6" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR IMX6" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] PCI: imx6: Using "linux,pci-domain" as slot ID
Message-ID: <20231206163656.GA717052@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206155903.566194-5-Frank.Li@nxp.com>

In subject, maybe you mean "Use 'linux,pci-domain' as slot ID"?
"Using" is the wrong verb form here.

On Wed, Dec 06, 2023 at 10:58:58AM -0500, Frank Li wrote:
> Avoid use get slot id by compared with register physical address. If there
> are more than 2 slots, compared logic will become complex.

But this doesn't say anything about "linux,pci-domain", and I don't
see anything about a register physical address in the patch.

Maybe this commit log was meant for a different patch?  I'm confused.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 62d77fabd82a..239ef439ba70 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -33,6 +33,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  
> +#include "../../pci.h"
>  #include "pcie-designware.h"
>  
>  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
> @@ -1333,6 +1334,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  					     "Failed to get PCIEPHY reset control\n");
>  	}
>  
> +	/* Using linux,pci-domain as PCI slot id */
> +	imx6_pcie->controller_id = of_get_pci_domain_nr(node);
> +	if (imx6_pcie->controller_id)
> +		imx6_pcie->controller_id = 0;

I don't understand what this is doing.  It looks the same as just:

  imx6_pcie->controller_id = 0;

Maybe this is a typo?  As written, it doesn't look like there's any
point in calling of_get_pci_domain_nr().

>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX7D:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> -- 
> 2.34.1
> 

