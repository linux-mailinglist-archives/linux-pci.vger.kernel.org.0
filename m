Return-Path: <linux-pci+bounces-1947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA52828C8F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 19:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7264F1C24CDD
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9AF3C097;
	Tue,  9 Jan 2024 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azMTEdfX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B558A3D0A4;
	Tue,  9 Jan 2024 18:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B42EC433C7;
	Tue,  9 Jan 2024 18:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704824686;
	bh=PnDrugs88BDAIAb6eAZlaU3yRaBLitjafFB7/F7+Za8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=azMTEdfXrurBUfzqits2DVedRnaDyrHJwu8onYbzzthOqt3a496nA/kd1mCq1Tpz5
	 aP3jXTSVXvKCYWsdKZr2+1mC+MyAHxLoyoach6pXYsE3eJKyrY4jVaUTRQAQt00SVv
	 MQk5/2ag/p7+CoPl3ljBRT+p1nxUDkxPCXq6EhehdOnoBpD2/gESSK3fVVtHQfGWb4
	 PazD62dTvPU1VSc6oMDovi0/O6jE5DRJrxKL7mchGomhuqZ3NQelK/YWSx9tr2dQe7
	 4oAeGG/1dPOpYH4Ej0bI/jbuFbzs214Jez3/cSGaMQZA4/yk3lzL8KFy4afdAIn0hn
	 RV1sF4oO7qDrg==
Received: (nullmailer pid 2901512 invoked by uid 1000);
	Tue, 09 Jan 2024 18:24:42 -0000
Date: Tue, 9 Jan 2024 12:24:42 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, bhelgaas@google.com, imx@lists.linux.dev, manivannan.sadhasivam@linaro.org, s.hauer@pengutronix.de, krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, l.stach@pengutronix.de, conor+dt@kernel.org, linux-pci@vger.kernel.org, shawnguo@kernel.org, linux-imx@nxp.com, helgaas@kernel.org, linux-arm-kernel@lists.infradead.org, kw@linux.com, festevam@gmail.com, lpieralisi@kernel.org, hongxing.zhu@nxp.com
Subject: Re: [PATCH v8 04/16] dt-bindings: imx6q-pcie: Add linux,pci-domain
 as required for iMX8MQ
Message-ID: <170482466895.2901163.17160878800155555620.robh@kernel.org>
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


On Mon, 08 Jan 2024 18:21:33 -0500, Frank Li wrote:
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
> 
>     Change from v5 to v6
>     - rework commit message to explain why need required and why auto increase
>     id not work
> 
>     Change from v4 to v5
>     - new patch at v5
> 
>  .../bindings/pci/fsl,imx6q-pcie-common.yaml           | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


