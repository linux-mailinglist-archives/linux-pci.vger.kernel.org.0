Return-Path: <linux-pci+bounces-40988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA7AC52828
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 14:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5DE3A7565
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 13:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B9B337BB4;
	Wed, 12 Nov 2025 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jz0imOsw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2696A3358C3;
	Wed, 12 Nov 2025 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954126; cv=none; b=qHNcwHe20WbHVpRbgQytU0x4/RSB5yv/vMzx1eBvLLwp9kh7fZr/eS9WJ4OIYKWMRi5fxsncyxLv+2jBTgcwk4JyhWnKYb2Sfh4WsKaecik3hHxpYS6H9q/MWK0XK1TetrJOPJTFRxlmYo8kXmCysNcfk1akE/DXv4hJTGbHrjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954126; c=relaxed/simple;
	bh=7p+aSh/V+tz65soo1tD2yC344mTmqbEBiquY9Efluo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEn1MqAQaIDj16QClAKywuuj81OtqyFVqHVq+3QymwE1BQUviKgdVH0BofIOJ/0kuk33yOM41/B8yPl2CbsTMXygbnrinMDz1gLbn/60hcvGZawf6aHCrU3MQXgrdh3X+IYQKno6iG16LXwmHCTgVnkYewWenPO6NETusr3gO4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jz0imOsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEDBC16AAE;
	Wed, 12 Nov 2025 13:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762954125;
	bh=7p+aSh/V+tz65soo1tD2yC344mTmqbEBiquY9Efluo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jz0imOswLo9zbXTjFvWAmaUuauxblP2wi0OPbIS/hz1J4Iyxt4b2ZF3Op2BBW+RN4
	 PbdLtrCT1BTI9P+fVLQpvfSDkIMwINbAVEoHh6/nQlc0n1PB+FedBWTGAJDgTIqYXx
	 ybLv6R0u1KpKQGYZq1MACCr/R9nd/kAfVWR9Sd/6eZ0Gen4NczC/1S8Ulg/MGEVm6X
	 laRpi1vPi8dOgk11jMVkVr71bs41ua8FEmQ6KMhNLl+/9BgGe5YJXD3TxdY9dJS24R
	 PMOXNj2NnzwTfnjLzKYo5te165tef+fbQmBo2Q4hRi1u4Vw9nuS7J503D2dxmf57KC
	 yIn2F4cSBtTyg==
Date: Wed, 12 Nov 2025 07:28:44 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: zhangsenchuan@eswincomputing.com
Cc: krzk+dt@kernel.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, linux-pci@vger.kernel.org,
	ouyanghui@eswincomputing.com, kwilczynski@kernel.org,
	mani@kernel.org, shradha.t@samsung.com,
	pinkesh.vaghela@einfochips.com, bhelgaas@google.com,
	inochiama@gmail.com, jingoohan1@gmail.com, p.zabel@pengutronix.de,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	mayank.rana@oss.qualcomm.com, thippeswamy.havalige@amd.com,
	christian.bruel@foss.st.com, gustavo.pimentel@synopsys.com,
	conor+dt@kernel.org, lpieralisi@kernel.org,
	krishna.chundru@oss.qualcomm.com
Subject: Re: [PATCH v5 1/2] dt-bindings: PCI: eic7700: Add Eswin PCIe host
 controller
Message-ID: <176295412361.1610589.12532159548453602404.robh@kernel.org>
References: <20251110090716.1392-1-zhangsenchuan@eswincomputing.com>
 <20251110090900.1412-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110090900.1412-1-zhangsenchuan@eswincomputing.com>


On Mon, 10 Nov 2025 17:08:59 +0800, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> 
> Add Device Tree binding documentation for the Eswin EIC7700 PCIe
> controller module, the PCIe controller enables the core to correctly
> initialize and manage the PCIe bus and connected devices.
> 
> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> ---
>  .../bindings/pci/eswin,eic7700-pcie.yaml      | 167 ++++++++++++++++++
>  1 file changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


