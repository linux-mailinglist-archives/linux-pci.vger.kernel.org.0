Return-Path: <linux-pci+bounces-31143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78119AEEFEC
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 09:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665EE1BC4FD4
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 07:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D9E25CC42;
	Tue,  1 Jul 2025 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8kzdJvV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7523E1EA6F;
	Tue,  1 Jul 2025 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751355786; cv=none; b=gpnt+4bddnB6iJICuniDlfUnsg9ScWl3Obu33mnNF59EEiv9MA7gNUxzgEU41PuwP0vpJmznbEJfBgrlqhn7n1niZfaI0qcEtsco8PwKYhFCXPVOZ1bwZD7rMYKb7E3cXJ5orenCDhqqbmaLR2+uSuePdV40HSOH9rYvsyeALJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751355786; c=relaxed/simple;
	bh=krITJM0978IRsY752Yojw78vCX5/sdxxG3qP5TVzy9Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tDfifhp3NTrgXr3vACdlEL4UPaU034u45LwDjgABuwBKXmJz/n+uQQMu5yaS2zSH5v/4tBkQcOgaNswDhKnJJza8FMFE3LVq4/3FJD9D50hVYgIM6dK99F7c6yKRnrl9LciNceObUqwI57ZRLfO8rLJ59UVhhRcG/LLcGC9BuB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8kzdJvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E805C4CEEB;
	Tue,  1 Jul 2025 07:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751355786;
	bh=krITJM0978IRsY752Yojw78vCX5/sdxxG3qP5TVzy9Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=t8kzdJvVaW+RVkrfsOqoFvovi3S0LHUUSHi478rxkKO6yyXkKC0cU/ZpGAjsMT4qn
	 1JkXekfymC9MGmxV94LQ3vVsgdkNMzGtbkzV4RA6kbpQlSbs6BSRRlTDlyoIGzI43J
	 rsB5Jm/QFVoS3fB7JKVod82EgqT837jAC7aUQUq1nL/+AH1Xd4MqdZYS3uygK/RZV6
	 N8LuSTnys4A10aRFgkIpfYfOoCv0f5aB/rMATYEsF9+Iblccn5ycEzQoQJDkBViMu6
	 ilZq8DioXEDURnmgVyxW0HPPXHRJ+hNs4XnU9JpH0LcwdwDoez94rgGMeWQI44NdEA
	 VU47dKBUk5MZQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-rockchip@lists.infradead.org, 
 Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rick wertenbroek <rick.wertenbroek@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Valmantas Paliksa <walmis@gmail.com>, linux-phy@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
In-Reply-To: <cover.1751322015.git.geraldogabriel@gmail.com>
References: <cover.1751322015.git.geraldogabriel@gmail.com>
Subject: Re: (subset) [RESEND PATCH v9 0/4] PCI: rockchip: Improve driver
 quality
Message-Id: <175135578094.10306.3959145621535083465.b4-ty@kernel.org>
Date: Tue, 01 Jul 2025 13:13:00 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 30 Jun 2025 19:24:15 -0300, Geraldo Nascimento wrote:
> During a 30-day debugging-run fighting quirky PCIe devices on RK3399
> some quality improvements began to take form and after feedback from
> community they reached more polished state.
> 
> This will ensure maximum chance of retraining to 5.0GT/s, on all four
> lanes and fix async strobe TEST_WRITE disablement. On top of this,
> standard PCIe defines are now used to reference registers from offset
> at Capabilities Register.
> 
> [...]

Applied, thanks!

[1/4] PCI: rockchip: Use standard PCIe defines
      commit: a54fa9e656b38d64761478d06aa8679eae074ca1
[2/4] PCI: rockchip: Set Target Link Speed before retraining
      commit: 7a886fbf4004a990cb7231d64370c622d0eb741f

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


