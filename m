Return-Path: <linux-pci+bounces-1946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E9E828C8A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 19:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E2FB216FF
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 18:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15E73C08F;
	Tue,  9 Jan 2024 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqfcIAoy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98443C461;
	Tue,  9 Jan 2024 18:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EACC43390;
	Tue,  9 Jan 2024 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704824666;
	bh=ORDcydzdI4WqaEgEC+N/AtgYAWYt9TwVHCyZQqFzwkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqfcIAoytbaSHClCub3k0jxMaJaWgOI2FQwjtJxIXh7UOH/yf0c7CdjZhcio43w8y
	 SesPyKyuELEZu5lUvXZklbsirfkcCwTXGK/7Em8UUraHtVQvdplLUU7GmEAEVk+uBr
	 rndLi8n+vAFCO3qvf9msB4n87DUT/S8pZdlnlMkgb0BMmte9VDshXW++Na/DC4io8H
	 /ABNg6zrJonmMswfLb92UHFPVuKY2qwTHcd/z7qcoN4x3G4N+ZAPRDQ+EW+Eym9qSE
	 DpIcz+KvZzUWyOkdsSIT/C3/uOHcGfGa4Dfgof0hebZMpLpFnQUviGPidOmuPJqH0/
	 b23KHxffuk75g==
Received: (nullmailer pid 2900974 invoked by uid 1000);
	Tue, 09 Jan 2024 18:24:20 -0000
Date: Tue, 9 Jan 2024 12:24:20 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: krzysztof.kozlowski@linaro.org, bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org, kw@linux.com, l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v8 04/16] dt-bindings: imx6q-pcie: Add linux,pci-domain
 as required for iMX8MQ
Message-ID: <20240109182420.GA2896319-robh@kernel.org>
References: <20240108232145.2116455-1-Frank.Li@nxp.com>
 <20240108232145.2116455-5-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108232145.2116455-5-Frank.Li@nxp.com>

On Mon, Jan 08, 2024 at 06:21:33PM -0500, Frank Li wrote:
> iMX8MQ have two pci controllers. Adds "linux,pci-domain" as required
> property for iMX8MQ to indicate pci controller index.
> 
> This adjustment paves the way for eliminating the hardcoded check on the
> base register for acquiring the controller_id.
> 
> 	...
> 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> 		imx6_pcie->controller_id = 1;
> 	...
> 
> The controller_id is crucial and utilized for certain register bit
> positions. It must align precisely with the controller index in the SoC.
> An auto-incremented ID don't fit this case. The DTS or fuse configurations
> may deactivate specific PCI controllers.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Keep current to avoid DTB_CHECK warning. After these patch merged. Will add
>     linux,pci-domain in all dts file. So dt-binding can remove condition check
>     by soc.

Please don't. No need to make required everywhere. Besides not needed, 
it is an ABI break.

Rob

