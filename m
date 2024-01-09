Return-Path: <linux-pci+bounces-1865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED713827D97
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 04:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BF9B2151F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 03:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB06468B;
	Tue,  9 Jan 2024 03:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSbUq6l1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4394418;
	Tue,  9 Jan 2024 03:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5652C433F1;
	Tue,  9 Jan 2024 03:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704772411;
	bh=8pgrFHvw3R9yjgrxxx423zr61bXGDlf7RpsTt+sa/50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RSbUq6l1YQ/5txmME7T8kV3R8NFkIpe2e5z2Ju9G4exXRvfwC+8Z4e4ml4ZBABd28
	 JLW2W7eq4v36xYr9vO3qJ3ejd+U3RQFi/ZP0ptdX6WuyQWS3/94tGv0fCdzZRxghkt
	 9UFOakZ20ImvCIiynh0CAwTzSH8K5xtXjSE8ARN1lxZGHAYtjzmJY0zWS30CA1Boks
	 Zy3JUh8Avg7E0L+yQOxhXhrBYISz7wH8WVSOblQhGEmApC1klVrM+tLnOSCMzmh/HJ
	 z8/4RgLenEq1/4oLYN5SPzd0GkJva0xuwDH4zdFMAP6QUpPAJ5Gz2AA7LxcY/B20mp
	 J0f5zDmJyFUDQ==
Received: (nullmailer pid 2611267 invoked by uid 1000);
	Tue, 09 Jan 2024 03:53:29 -0000
Date: Mon, 8 Jan 2024 20:53:29 -0700
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de, bhelgaas@google.com, kernel@pengutronix.de, helgaas@kernel.org, kw@linux.com, linux-pci@vger.kernel.org, manivannan.sadhasivam@linaro.org, hongxing.zhu@nxp.com, krzysztof.kozlowski+dt@linaro.org, imx@lists.linux.dev, conor+dt@kernel.org, festevam@gmail.com, lpieralisi@kernel.org, linux-imx@nxp.com, krzysztof.kozlowski@linaro.org, shawnguo@kernel.org
Subject: Re: [PATCH v7 15/16] dt-bindings: imx6q-pcie: Add iMX95 pcie
 endpoint compatible string
Message-ID: <170477240853.2611203.9074247440935063853.robh@kernel.org>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-16-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227182727.1747435-16-Frank.Li@nxp.com>


On Wed, 27 Dec 2023 13:27:26 -0500, Frank Li wrote:
> Add i.MX95 PCIe "fsl,imx95-pcie-ep" compatible string.
> Add reg-name: "atu", "dbi2", "dma" and "app".
> Reuse PCI linux,pci-domain as controller id at endpoint.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v1 to v3
>     - new patches at v3
> 
>  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 57 ++++++++++++++++---
>  1 file changed, 49 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


