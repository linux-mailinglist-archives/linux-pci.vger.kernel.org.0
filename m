Return-Path: <linux-pci+bounces-1949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FC9828C9B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 19:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 283E1B2464F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 18:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEDE3C464;
	Tue,  9 Jan 2024 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+vFgALf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BEF3C463;
	Tue,  9 Jan 2024 18:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28733C433C7;
	Tue,  9 Jan 2024 18:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704824884;
	bh=Ei8icv44/tc+xhWQFpv8ZCMUIGwAVPj2v0/fXVKZxhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+vFgALfW62iji9TQBue/a1H50KYHzRKyxKejuRyZDtzBna0otCgsv3GmxbBADLf0
	 LFkZeq1x7H86eR5i/WKYqLqlYg0hjLe4c1Ewyw0oo84Po75vQ6HFHsg2anFlrePn+2
	 /TbR2a2bw9yvzZOmDE13up5xzQhMvpenARMYPdu1uWceBTaw+Eaz2XDB4cU5GMLvKF
	 UtamfFupq8VeG0D6imbKOfvm0BjaP6YWg7b9ms/c5ZvOwgFMbNbhlXZ2FVe59XBRwE
	 IqSeyIjwzrxMS/TfLNHqzAWZ0GlRZuy3VBxS4J/a/NE6THLU0E8hB9ufswbPFMwM7w
	 qWsBphGPe14mA==
Received: (nullmailer pid 2906014 invoked by uid 1000);
	Tue, 09 Jan 2024 18:27:59 -0000
Date: Tue, 9 Jan 2024 12:27:59 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: lpieralisi@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org, l.stach@pengutronix.de, festevam@gmail.com, krzysztof.kozlowski+dt@linaro.org, bhelgaas@google.com, imx@lists.linux.dev, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, conor+dt@kernel.org, kw@linux.com, linux-imx@nxp.com, devicetree@vger.kernel.org, kernel@pengutronix.de, manivannan.sadhasivam@linaro.org, shawnguo@kernel.org, helgaas@kernel.org, hongxing.zhu@nxp.com
Subject: Re: [PATCH v8 15/16] dt-bindings: imx6q-pcie: Add iMX95 pcie
 endpoint compatible string
Message-ID: <170482487882.2905931.3757329978168080293.robh@kernel.org>
References: <20240108232145.2116455-1-Frank.Li@nxp.com>
 <20240108232145.2116455-16-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108232145.2116455-16-Frank.Li@nxp.com>


On Mon, 08 Jan 2024 18:21:44 -0500, Frank Li wrote:
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


