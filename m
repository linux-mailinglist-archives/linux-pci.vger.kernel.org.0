Return-Path: <linux-pci+bounces-2501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6439839A61
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 21:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7E728D616
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 20:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ACD443E;
	Tue, 23 Jan 2024 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2+6HTtU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F20B4403;
	Tue, 23 Jan 2024 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042198; cv=none; b=Ju+aLSWCihBuY0F6FUtds0ydkgSAWfzlCNnSLbXv856xJl9OE6HvQ1yGOSIHRmn+h5C5wQN2DeGighhlJ+ir7nJr6lfWlnwmo/tiux8vgez7Jruuo9t1gsD16RmhmJOx0HvCLcXDSlA06Q+l69q8HRY4vA6FD7ziCvj/oai3r8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042198; c=relaxed/simple;
	bh=o2oLR7nViSQJyGRojc+2a9LMv/Xr8p1GgzdAgDaZRtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQ9zkcVi7HutRP0ZK19heDlf6SrSNUZsHBC3d65lRLwk6Iuw/unwyehXJf/yZJRG+5trmN+e8XjsCLSUNqLkCCDW2dEsu0IYmxa0+g0SZDgk3mtP9SLIOGrLiBGMsvMiOPHVEy2mcHWhnOIuUQhga928sLlEKSYZBj0FMHezkdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2+6HTtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BA5C433F1;
	Tue, 23 Jan 2024 20:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706042197;
	bh=o2oLR7nViSQJyGRojc+2a9LMv/Xr8p1GgzdAgDaZRtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r2+6HTtUQaA2YelEGW/GoPKha6kWNoR7E1zjXjbpxBtPoDcsQ1ud7uyrWMEgAkSbU
	 bmr5QJXZ4qYMjrPKzC/SHk+J8ab4bn4oog7bipz+B5qBiq+LbZmqg/+6qB7xX/LTHC
	 Pfcumi37mW7r+TnW5+XoLCqWilQERy94NfuPRObpdqRTPgqqZJM/8k0SBDvGus3cKH
	 ZMM4O1Co4Ho3VuZNkDxCTZexU257ldYRW8UPL6Z6ZorXhaHmWiW6tWxDrfUoRtZZHG
	 uno3gptC9HLex8z5gRQXrcbqHkZOf2+KMu2Hqiq4leraNgRrRUR01jGKiAg0xqt7fN
	 qPD328LcHvxAQ==
Date: Tue, 23 Jan 2024 14:36:35 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, s.hauer@pengutronix.de,
	linux-pci@vger.kernel.org, linux-imx@nxp.com, conor+dt@kernel.org,
	l.stach@pengutronix.de, hongxing.zhu@nxp.com,
	devicetree@vger.kernel.org, festevam@gmail.com,
	manivannan.sadhasivam@linaro.org, imx@lists.linux.dev,
	shawnguo@kernel.org, lpieralisi@kernel.org, kw@linux.com,
	krzysztof.kozlowski@linaro.org, bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org, helgaas@kernel.org
Subject: Re: [PATCH v9 10/16] dt-bindings: imx6q-pcie: Restruct reg and
 reg-name
Message-ID: <170604219472.1842354.3353410583194075887.robh@kernel.org>
References: <20240119171122.3057511-1-Frank.Li@nxp.com>
 <20240119171122.3057511-11-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119171122.3057511-11-Frank.Li@nxp.com>


On Fri, 19 Jan 2024 12:11:16 -0500, Frank Li wrote:
> snps,dw-pcie.yaml already have reg and reg-name information. Needn't
> duplciate here.
> 
> Add 'if' check for existed compatible string to restrict reg and reg-names.
> This prepare to add new compatible string with difference reg-names sets.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v7 to v8
>     - Add Manivannan Sadhasivam's ACK tag
>     Change from v6 to v7
>     - add Krzysztof's review tag
>     Change from v5 to v6
>     - Add if check for existed compatible string
>     Change from v4 to v5
>     - add Rob's Acked
>     Change from v1 to v4:
>     - new patch at v4
> 
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 30 ++++++++++++-------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


