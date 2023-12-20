Return-Path: <linux-pci+bounces-1225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE47981A33A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 16:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE16283CAD
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 15:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE7046429;
	Wed, 20 Dec 2023 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4tzYCzV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB1B41228;
	Wed, 20 Dec 2023 15:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6ECBC433CA;
	Wed, 20 Dec 2023 15:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087675;
	bh=AM5719R9/C4+1es2WOJRGzV9K/BOUfmgbJTp8XrC8WM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B4tzYCzVwxLds0uOf+/b869Ml9KakXONq4jpLpWWZphICn0aibnLVPDcfij6TVhri
	 z9dR6PFb+2s7WzGUWfclfpYam7t6B12omxpmLwSAICY5jWIhMa2kHKYokXXHl85+MB
	 66NRxqsHRK9hyLJ4FacRtHvDsRdXLMRztpaQTjBBuidoxp7UuRjwBYGgcUksYelnjh
	 nUXJY8pIUO1MH6WE0PrZ7nBWxT0aDKd/+qcWpsy4Oiz1jDESpZNa1WNWVL2X/LRb4v
	 qmaEw5muVLjFprGiPrfVEmUEm/dlhaBC3cUlKEWqlpAH+tK005w+Gi00cTKaBgl1iu
	 6yOFo1THa/Wiw==
Received: (nullmailer pid 278038 invoked by uid 1000);
	Wed, 20 Dec 2023 15:54:32 -0000
Date: Wed, 20 Dec 2023 09:54:32 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de, bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org, conor+dt@kernel.org, krzysztof.kozlowski@linaro.org, lpieralisi@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com, imx@lists.linux.dev, manivannan.sadhasivam@linaro.org, krzysztof.kozlowski+dt@linaro.org, helgaas@kernel.org, l.stach@pengutronix.de, linux-kernel@vger.kernel.org, shawnguo@kernel.org, linux-imx@nxp.com, Frank.li@nxp.com, hongxing.zhu@nxp.com, kernel@pengutronix.de
Subject: Re: [PATCH v4 09/15] dt-bindings: imx6q-pcie: remove reg and reg-name
Message-ID: <170308767228.277985.15603263470608919081.robh@kernel.org>
References: <20231217051210.754832-1-Frank.Li@nxp.com>
 <20231217051210.754832-10-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217051210.754832-10-Frank.Li@nxp.com>


On Sun, 17 Dec 2023 00:12:04 -0500, Frank Li wrote:
> snps,dw-pcie.yaml already have reg and reg-name information. Needn't
> duplciate here.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v1 to v4:
>     - new patch at v4
> 
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml        | 10 ----------
>  1 file changed, 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


