Return-Path: <linux-pci+bounces-11641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D3E950A39
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 18:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2534283539
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 16:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598051A2C1E;
	Tue, 13 Aug 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwBxoiBs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255851A2C18;
	Tue, 13 Aug 2024 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566774; cv=none; b=eu6Plh38gbqzxdL6rd11rTUuMB+FNJsgfp1Db6Dx1kx48V6X5BbPsw+ZlYCYEQzb95HdAAxHK1xiAnJceNCOcy32GrE87ZvsjMyIl3fx+UMdTiYpfJvvkCwlapXYRcfqCytHDsHKzAprTr6LeYDDgElouavUxhC4ogKTk6p3Rmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566774; c=relaxed/simple;
	bh=Kbdfzn/ZdPj0XIrrD6C/Hpkw88aQjKyO1BNvwwISy6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRywQKfs6SZN8irSQ2Fe33nEXWN8JHUohREZJ3f90kfLtnwzF0mEk7cjyCO1db5MgK2HHuoBOTfbNS3SCTvsLHO7m88/UR/qWwbEOCNOvmDzVLHB+WW4LGfJKqmMVwpMtIykSsfm/S1zXUS+jrubxbNWqDSSarcgfVRVfGGYjnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwBxoiBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4634EC4AF11;
	Tue, 13 Aug 2024 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723566773;
	bh=Kbdfzn/ZdPj0XIrrD6C/Hpkw88aQjKyO1BNvwwISy6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lwBxoiBsBuh7e5l3TSpyvue+rKJnz9Dh3AWCsJcyadupJ9IrzqJ8Y+0g1RxUddk4i
	 9MEluCXzd61wHutZbUeQ+9k/mGy6DOsW7StjapsMU9MW+9qp+o/JS/8LyUBR57Ppqk
	 5xtC8iES35WghvelhEKjoKDQamc+zZjYRVYIWbS/s0A+ibCYTibn/ntBXri7Otztm5
	 digZiTtpfMWRZkkWMCTULLIsp8DUp+V0YL3YqFiFtgMpsbsZZh/t0fM1d2SBvlgSy/
	 xCB5ihCiy8SmeHlhDg3F8ieMeAb0zbjzhlkcCA+V6eyWodqB+rLjFJHgOFp6gg+SkY
	 kVOY/x4jY+fFg==
Date: Tue, 13 Aug 2024 10:32:51 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: shawnguo@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	conor+dt@kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	l.stach@pengutronix.de, krzk+dt@kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Message-ID: <172356674865.1170023.6976932909595509588.robh@kernel.org>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
 <1723534943-28499-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1723534943-28499-2-git-send-email-hongxing.zhu@nxp.com>


On Tue, 13 Aug 2024 15:42:20 +0800, Richard Zhu wrote:
> Add reg-name: "dbi2", "atu" for i.MX8M PCIe Endpoint.
> 
> For i.MX8M PCIe EP, the dbi2 and atu addresses are pre-defined in the
> driver. This method is not good.
> 
> In commit b7d67c6130ee ("PCI: imx6: Add iMX95 Endpoint (EP) support"),
> Frank suggests to fetch the dbi2 and atu from DT directly. This commit is
> preparation to do that for i.MX8M PCIe EP.
> 
> These changes wouldn't break driver function. When "dbi2" and "atu"
> properties are present, i.MX PCIe driver would fetch the according base
> addresses from DT directly. If only two reg properties are provided, i.MX
> PCIe driver would fall back to the old method.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml  | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>




