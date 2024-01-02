Return-Path: <linux-pci+bounces-1600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84123821F2A
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 17:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91031C224FA
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 16:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C8914F63;
	Tue,  2 Jan 2024 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmwhRPPG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD1514F61;
	Tue,  2 Jan 2024 16:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195D6C433C8;
	Tue,  2 Jan 2024 16:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704211419;
	bh=K5Bh1a2M7J3iuoSs7ojMvA0kVanXRsbXh9Zs0nxwx4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmwhRPPGEIOUFzvE25wPosnJAk8xylcp39KZRM1TQK3/RBofHE+XYTyQ4B2xUbmA1
	 5Tnn7cVjpcMcU62PGnn79JA38VbvarObQCg0ZAXhQQeqp7UP1cefVBpjWD70889SCS
	 pEaitvZuP9DDvhdZBz9FJxSXe3QJ5M/7+3a6YrsS5L45NBa7amNHeXc3SzhGif2HYQ
	 vs0nsInbvWCBe5E1V2dvKMAwsEKw5bFHu0YlQUcUmFVBm1S+rBujmrAccMIfitU39l
	 RmWOIoOcr0Ll+8Ud3jaAD4NMvRzgGEBdS4gy48JzVnel1DDnGO/p6CGBXfT/56QxCS
	 PiCM7npGIt1FQ==
Received: (nullmailer pid 2930655 invoked by uid 1000);
	Tue, 02 Jan 2024 16:03:36 -0000
Date: Tue, 2 Jan 2024 09:03:36 -0700
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, helgaas@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org, hongxing.zhu@nxp.com, festevam@gmail.com, linux-pci@vger.kernel.org, kw@linux.com, bhelgaas@google.com, linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de, linux-imx@nxp.com, manivannan.sadhasivam@linaro.org, shawnguo@kernel.org, kernel@pengutronix.de, l.stach@pengutronix.de, lpieralisi@kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v7 11/16] dt-bindings: imx6q-pcie: Add imx95 pcie
 compatible string
Message-ID: <170421141637.2930587.8260068596502480735.robh@kernel.org>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-12-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227182727.1747435-12-Frank.Li@nxp.com>


On Wed, 27 Dec 2023 13:27:22 -0500, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.
> Add "atu" and "app" to reg-names.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v6 to v7
>     - Added my sign off
> 
>     Change from v5 to v6
>     - move atu and app after config
> 
>     Change from v2 to v3
>     - Remove krzy's ACK tag
>     - Add condition check for imx95, which required more reg-names then old
>     platform, so need Krzy review again,
> 
>     Change from v1 to v2
>     - add Krzy's ACK tag
> 
>  .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  1 +
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


