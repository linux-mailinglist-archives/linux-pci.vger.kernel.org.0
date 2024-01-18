Return-Path: <linux-pci+bounces-2309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53485831282
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 06:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF161F22F99
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 05:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717D18C19;
	Thu, 18 Jan 2024 05:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGdytAg/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DB78F4F;
	Thu, 18 Jan 2024 05:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705556992; cv=none; b=J/kaizWAV1L2YMxYiEKjKii3q2DH406irYw/QnXSLD72sSZ/L8BSeJPYN3m7Oe20hJkJInjbCS4ENRd2EAH3H+ro814kTZs9fN6PjigNcYYF3ZOll6ZJOngN9JEkkPV4uyZ+6wK88CZRKdmaVc3YhTDiaUSzq0NdUvjLHS0Bs3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705556992; c=relaxed/simple;
	bh=VpKUFfNg/HrPvFXUCiGE71qPbuDU/sf0aYz4C+NnmAU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:References:Date:
	 In-Reply-To:Message-ID:User-Agent:MIME-Version:Content-Type; b=WGtcskfKz5GKz4mekGUbA5usRL5tiBEWtSB6Tchg7cx5FbnkQHIYeS8o5ohrGtHu7D2FRv8vX7UMMpdRkKV3dVfQzgB1JPSn+WIzIEnHIBGnbyDn+bNmm+ku17WBxAX3o/XToxB5/bz9QkmANDFYZltgpZuw7T+CA7fDnyUappg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGdytAg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3632EC433A6;
	Thu, 18 Jan 2024 05:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705556991;
	bh=VpKUFfNg/HrPvFXUCiGE71qPbuDU/sf0aYz4C+NnmAU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=mGdytAg/rbFbk1cpzazA43EoXsrFTY6KGL7S6PGPYTpHuXImmM/jrLoxSpgG2sfJe
	 1S5sNO/EA4PFssquqitUBjqZsJuco7+tIbd4QmpdgQECqR7IOmUL2v56972UxANpNo
	 45xFQNOBdEmO/NHTpvMdzylYa54Na0Qq02Lxj2vmZyy9Yze08jaX++9LcIxey4+HbI
	 9kH+JBbtqvO+SMlb5NEqKBrEnyw0PeY1toDUy9v3dQYodY5sPk3DKYVe4IaOd6ftBY
	 WX9zwwqHjxriA0ani2taf+bn+9GJwo3Etn+ZwYf/T+0i1GLr380x5acgN4K8H0l/XL
	 VvyKkq8aT0GlA==
From: Kalle Valo <kvalo@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "David S . Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Rob Herring <robh+dt@kernel.org>,  Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Bjorn Andersson <andersson@kernel.org>,  Konrad
 Dybcio <konrad.dybcio@linaro.org>,  Catalin Marinas
 <catalin.marinas@arm.com>,  Will Deacon <will@kernel.org>,  Bjorn Helgaas
 <bhelgaas@google.com>,  Heiko Stuebner <heiko@sntech.de>,  Jernej Skrabec
 <jernej.skrabec@gmail.com>,  Chris Morgan <macromorgan@hotmail.com>,
  Linus Walleij <linus.walleij@linaro.org>,  Geert Uytterhoeven
 <geert+renesas@glider.be>,  Arnd Bergmann <arnd@arndb.de>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  =?utf-8?Q?N=C3=ADcolas?= F . R . A . Prado
 <nfraprado@collabora.com>,  Marek Szyprowski <m.szyprowski@samsung.com>,
  Peng Fan <peng.fan@nxp.com>,  Robert Richter <rrichter@amd.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Terry Bowman <terry.bowman@amd.com>,
  Lukas Wunner <lukas@wunner.de>,  Huacai Chen <chenhuacai@kernel.org>,
  Alex Elder <elder@linaro.org>,  Srini Kandagatla
 <srinivas.kandagatla@linaro.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Abel Vesa <abel.vesa@linaro.org>,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-msm@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-pci@vger.kernel.org,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 9/9] PCI/pwrseq: add a pwrseq driver for QCA6390
References: <20240117160748.37682-1-brgl@bgdev.pl>
	<20240117160748.37682-10-brgl@bgdev.pl>
Date: Thu, 18 Jan 2024 07:49:41 +0200
In-Reply-To: <20240117160748.37682-10-brgl@bgdev.pl> (Bartosz Golaszewski's
	message of "Wed, 17 Jan 2024 17:07:48 +0100")
Message-ID: <87mst342dm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Add a PCI power sequencing driver that's capable of correctly powering
> up the ath11k module on QCA6390 and WCN7850 using the PCI pwrseq
> functionality.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> [Neil: add support for WCN7850]
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Here also: ath12k supports WCN7850, not ath11k.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

