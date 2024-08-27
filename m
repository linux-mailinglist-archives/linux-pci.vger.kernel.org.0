Return-Path: <linux-pci+bounces-12291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D44A9613A7
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 18:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6721C23343
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E571C6F5A;
	Tue, 27 Aug 2024 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7WsD/Rb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ACB64A;
	Tue, 27 Aug 2024 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774875; cv=none; b=qOWkriVTAvf7+d5ZgLOyiFSmBctVQWBKpPignr0CwmXrkJtAxmzNOyJx5sQNPyBxegUz4TCfJP/6IHOFlerU7nwMfO/+PvyzprPz/ls34IchHYC5emddRq6AkllipheHipOiP/11fhOYzJE9sby5JS04cP8f3VC5VxaXM8GxT+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774875; c=relaxed/simple;
	bh=PxD+IcsDEZ9xXG7fmj5qGES4cWSVJLZ0Q/GZsBMb8Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg+XZ7CWu/KKR3KvU8bBtQL7g9XmcnSVe7bQ6rSlN2VnVX4rQZNTEu7XHXBNt2tVoIyoM6+xKtqq4fl3NNaqMysdmDZoTPvCiZlxhjfLKeZ1JkILkfSqYb6WsNrnJVGAbGKEiZpDtg/AHdpeVsW1PkMwjIJIqWwJB33UowbG5/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7WsD/Rb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8686EC6106A;
	Tue, 27 Aug 2024 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724774874;
	bh=PxD+IcsDEZ9xXG7fmj5qGES4cWSVJLZ0Q/GZsBMb8Ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7WsD/RbALGPv6gLXwXXbC8he9X0lrMd/w3TFcnsyxQcCQ31W7LjADm481hdqgWII
	 R26SDKINFMZX+QcVj4H1xgLRXVhWvzzilQpebxBA+4n1r+cy0eTgXefjb7CCbecxBk
	 x/bF5E/WfAu6tjQ8BC4H5Uwj6X9EDTLvquTf4jQ4rI07vQpKh4xe/qcmXfUialyoiF
	 rWnB7tE+bqQGjv0g1E9AZwC8/wn0wzbeKs4OZ7OE9gq3MCBh9xAPVowhXqNQStIN+3
	 nWTEOMbsStiqiTrKEzCaT1eQQNNjk+z4qfO2rz1KztP76W09lMqeW5q7sKsdR/QE6i
	 V3u+xbPWwTgOg==
Date: Tue, 27 Aug 2024 11:07:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, devicetree@vger.kernel.org,
	Olof Johansson <olof@lixom.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, imx@lists.linux.dev,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: layerscape-pci: Replace
 fsl,lx2160a-pcie with fsl,lx2160ar2-pcie
Message-ID: <172477487189.4026008.12479335354124304319.robh@kernel.org>
References: <20240826-2160r2-v1-0-106340d538d6@nxp.com>
 <20240826-2160r2-v1-1-106340d538d6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-2160r2-v1-1-106340d538d6@nxp.com>


On Mon, 26 Aug 2024 17:38:32 -0400, Frank Li wrote:
> fsl,lx2160a-pcie compatible is used for mobivel according to
> Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
> 
> fsl,layerscape-pcie.yaml is used for designware PCIe controller binding. So
> change it to fsl,lx2160ar2-pcie and allow fall back to fsl,ls2088a-pcie.
> 
> Sort compatible string.
> 
> Fixes: 24cd7ecb3886 ("dt-bindings: PCI: layerscape-pci: Convert to YAML format")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/pci/fsl,layerscape-pcie.yaml          | 26 ++++++++++++----------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


