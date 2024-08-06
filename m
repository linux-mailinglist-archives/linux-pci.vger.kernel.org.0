Return-Path: <linux-pci+bounces-11360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8B394936A
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 16:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF772287147
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 14:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0181EA0D0;
	Tue,  6 Aug 2024 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTFMDJPA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC7017AE1E;
	Tue,  6 Aug 2024 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955251; cv=none; b=SUHxBbE177HEbIgkovbkLxhQ2b0R2zp1mN/utlskDw9cRVoxb39hkd9RMY88OYhJ8LicxEsObxXf4yVmSCrwEEEOwCAuqEbN+yyJ2glTYfo8Qgv2EeH8m9SOHCplOQq4Bb5s4vKvr6sewx6JQw+oqeB8GWQR+3VnutdMDgEUwqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955251; c=relaxed/simple;
	bh=ck4tWvVoFfRUFwDa9ixWn/oRRNMXb2QJWxw6i7I5tcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKWrM+Qtl5FjUS0oquVHjgdyvDy4jv7gB58p4n14h6iGReW0ynE7LZCvRe4drXl9EYMeO5nF2XDUCUIrBRbV0Gs4ClzZd86LoAKD5bHn99QuOxZeE6cQIGBVc1PyqZ8ka8BFtsvz9RUWELZ+wJI+Ld7DNLdAn6OP0/rPIl6HOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTFMDJPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E8AC4AF09;
	Tue,  6 Aug 2024 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722955251;
	bh=ck4tWvVoFfRUFwDa9ixWn/oRRNMXb2QJWxw6i7I5tcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTFMDJPAzVp1ROfBYmNRZwITqhREK9vrmTVXr0QiHaCV+W7Uyicob7UaC2UwPUCkH
	 xreLKguJ/zjFQkN5mHk7CBRyCW+aUD72wjhJ3+uVqCKkvheDi99QlMISsnJZdKw2KC
	 UqKtd1iqNy4goC8wHAvBfvoNfem41KJeRB9gWkjwXoKFIXfZ6kHCbhAa7L6/KdH1pO
	 wJclMN7apK3ME0seMmLwWcwXcJIGwufWP6tC1Lco2pgUJpLajZ9K8OLFW2Zh7xteri
	 WsbtFdYtjT5tujVMuCvYwcnufT+LgL2C7w8JncqCiQ8B6EB9NBtIO6Efhy6Mj37soc
	 52HovReLNXfOA==
Date: Tue, 6 Aug 2024 08:40:50 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	kernel@pengutronix.de, krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	imx@lists.linux.dev, linux-pci@vger.kernel.org, shawnguo@kernel.org,
	l.stach@pengutronix.de
Subject: Re: [PATCH v4 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Message-ID: <172295524841.1489029.13563934125937656478.robh@kernel.org>
References: <1722218205-10683-1-git-send-email-hongxing.zhu@nxp.com>
 <1722218205-10683-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722218205-10683-2-git-send-email-hongxing.zhu@nxp.com>


On Mon, 29 Jul 2024 09:56:42 +0800, Richard Zhu wrote:
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


