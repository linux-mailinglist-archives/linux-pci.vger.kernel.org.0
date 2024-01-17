Return-Path: <linux-pci+bounces-2296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CFC830C71
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 19:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C9A1F22376
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 18:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4ED22EFA;
	Wed, 17 Jan 2024 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO2AByMs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F9B22EE4;
	Wed, 17 Jan 2024 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514866; cv=none; b=dz9do20jaZVpP9dzcalWbb+NPe9uhELX2L99RbxuifWCqQWTIwErIk8UV5y25AyfKR/320bfID2w4BMSt0QrU5SU9Zh79CSYuKRwW3rbhgiKtB+7l8yiV31ujXuS4HZWl9j9BRsOy6AQLXKHVzLBz4vk9wfJYfrWjfosEwlC6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514866; c=relaxed/simple;
	bh=zB4Z72eSOkfwWI3re8tML42W8mSuDqpHqplPAWzj9UU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:References:Date:
	 In-Reply-To:Message-ID:User-Agent:MIME-Version:Content-Type; b=i5MJgBEKrbbkF1FjSZ8jcyxiWCi7KYPKrhqa75Ai9/H8VZXCOf6gsLbpyrsPxtifvwYfePJf7XRlRPqdiS19rCSwPS54p98N5J0VRWUABTCDnx45QkzeQXd1c314KGcjqmIS29MQGesAkJJ1IeEk156FCLhWXDEvH1DN7uSdsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO2AByMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0C6C43390;
	Wed, 17 Jan 2024 18:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705514865;
	bh=zB4Z72eSOkfwWI3re8tML42W8mSuDqpHqplPAWzj9UU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=SO2AByMsKqpphqbxHOmbOpabsDsirCKPTUKmHVZ7YoRfPFQEx0P3KKrtpN5H3O04s
	 359DXm0XbwWY2qG1D6nzQU0JhHovSacnghZSZzN8IUCuOLpPelFWGtusE3xv9uXUzf
	 2X4nNGDN+HaQflCae9ukU7Ll532UGWMN8akVh6156xUW2jqHs9kPheCs6CM3RQxeel
	 PK2JOOh/gEYf0csrk5YFXshV+7CIeyXqoxQvEBtx2R1/qEbU3qZJE3PnEq6vadhfKO
	 LArOwaa7awIM49nhtk+0CpLLL2uwD3c3ocOo0yQRNrSPk3Uu0qbRzjNd0KCDIXE/9E
	 4Lr+bnC7SGiPw==
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
Subject: Re: [PATCH 8/9] dt-bindings: wireless: ath11k: describe WCN7850
References: <20240117160748.37682-1-brgl@bgdev.pl>
	<20240117160748.37682-9-brgl@bgdev.pl>
Date: Wed, 17 Jan 2024 20:07:35 +0200
In-Reply-To: <20240117160748.37682-9-brgl@bgdev.pl> (Bartosz Golaszewski's
	message of "Wed, 17 Jan 2024 17:07:47 +0100")
Message-ID: <87v87r4yvs.fsf@kernel.org>
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
> Describe the ath11k variant present on the WCN7850 module.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

ath12k supports WCN7850 (a Wi-Fi 7 chipset), not ath11k.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

