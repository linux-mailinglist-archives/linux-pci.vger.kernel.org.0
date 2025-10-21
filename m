Return-Path: <linux-pci+bounces-38844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BD0BF4642
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 04:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3E9A4E2EEC
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 02:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7081D5CC9;
	Tue, 21 Oct 2025 02:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toPnH5Bh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65E71B3930;
	Tue, 21 Oct 2025 02:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761014122; cv=none; b=tjVeQHj6bC9sR207T+r1ubVIFlx/SgR+++C9xvuisLhP8RkZGp7gcbmjCYnl5CrrAnhkyIyzKOeBfPtr2khwNabPegdt+xqOf6KMPBfAvc3s4+7y7ki8Y3gMe4HXhyT1RaH8T8ah93g44ldohS3xrlgT/n48KIAzjfvgE58Tq5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761014122; c=relaxed/simple;
	bh=fcgYpZ04ddq603NytX9c8WGJNEs2JUuEfL+syo1Wfkw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gWAydn2lqcyK2IvEkX5tJrq3JZgRy3BmvGKbBoXNeP3mgQSviH8A5wjT6cJrGXF4Z9fb2x6PZ5DDGkC5kyh6c5lPVaYNj76JZmc/ArXhRUTJ78Ek+3mjeKsmxxV1x800rZa8W3GM+DYPXwWw834qj3orQeSVTLKqVqzjJDgLep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toPnH5Bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691F2C4CEFB;
	Tue, 21 Oct 2025 02:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761014122;
	bh=fcgYpZ04ddq603NytX9c8WGJNEs2JUuEfL+syo1Wfkw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=toPnH5Bh/mJooxw8Zd4IHJQTKNx85c+y4kWxyErwQ8ab3hBK524Q3Zpm7pHeGA2Ay
	 sg6r+9K0OI2Uqp8pl8wXtB95OmdCY2kg4jRvjeOYEo0ZUdBhPFhuzT9RA/fa6fbZg8
	 6snyZsBUyJbmIHnvP2JECE5OwjKrukliYoEV/AlbZDmSudzsY8YrpNyA95Y6Xsi2Pm
	 HMd8w9AbKRHC2gcJ420CRjPRfgH7D2PR6UDUceC0wJYRwXsNMala0cnUsheMLDLGJO
	 ifxY5RWfqWaOS7L1mTkkz1EBfpmtInGtT8kznuH/eTxzeimTeT7y2ZtGs/6P/LWHrs
	 OR1xI9Jp5UD9w==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Xue <xxm@rock-chips.com>, 
 Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Dragan Simic <dsimic@manjaro.org>, 
 FUKAUMI Naoki <naoki@radxa.com>, Diederik de Haas <diederik@cknow-tech.com>, 
 stable@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
In-Reply-To: <20251017163252.598812-2-cassel@kernel.org>
References: <20251017163252.598812-2-cassel@kernel.org>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Prevent advertising L1 Substates
 support
Message-Id: <176101411705.9573.17573145190800888773.b4-ty@kernel.org>
Date: Tue, 21 Oct 2025 08:05:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 17 Oct 2025 18:32:53 +0200, Niklas Cassel wrote:
> The L1 substates support requires additional steps to work, namely:
> -Proper handling of the CLKREQ# sideband signal. (It is mostly handled by
>  hardware, but software still needs to set the clkreq fields in the
>  PCIE_CLIENT_POWER_CON register to match the hardware implementation.)
> -Program the frequency of the aux clock into the
>  DSP_PCIE_PL_AUX_CLK_FREQ_OFF register. (During L1 substates the core_clk
>  is turned off and the aux_clk is used instead.)
> 
> [...]

Applied, thanks!

[1/1] PCI: dw-rockchip: Prevent advertising L1 Substates support
      commit: 40331c63e7901a2cc75ce6b5d24d50601efb833d

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


