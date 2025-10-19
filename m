Return-Path: <linux-pci+bounces-38655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99680BEDF1C
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 08:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484F23E71D9
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 06:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AE221A95D;
	Sun, 19 Oct 2025 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/iVFhoQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A741178372;
	Sun, 19 Oct 2025 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760855897; cv=none; b=ABly9+pW7x25tur8Gdtpp6r6XDMeSdo2ic5FtL61kkxOEvySTKTOHyb/KK42Hz/xVhiEUyVZRzNAxjSqKMv4Mnt8LskDvwjM5Cd8tdJEtgBfPX1UTd424QKXFmBKAm3YCnph6gKpUzv8BgfzmDkZ0W0DL1FqqiVjmq/r0j7mF5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760855897; c=relaxed/simple;
	bh=zutQ6iQf0byeRZ/GXJXZW1hAG258FPpWvXBWCy3HRR4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C2x7JmkItcbtV+LsvzUZY/77nZApe2JmYhuixwU2BxXPNTksX0M4BK1TZ1LC2MqUMoRid07gMtaWlJBq1N7LxcacVmd0GzRzWnWICIzq5KRrsY5ZjvxTNQdF8AHJjs97yPvzrSfbdrtJH1OV7IyXce4+LFN3NWfdG0/UrDf18YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/iVFhoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1D4C4CEE7;
	Sun, 19 Oct 2025 06:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760855897;
	bh=zutQ6iQf0byeRZ/GXJXZW1hAG258FPpWvXBWCy3HRR4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=h/iVFhoQAyK3Y8+SGOK5H/0il/s5MM/gUzmZhceLEECMiG6csCzKWW6/6MfkxuALD
	 2F5Sybk1He1fZhw4/5ggAQ2h5Qusv8wEUX8TDCOuoKPXMEf1Au1D1/lfp/HJ1vZ5Kf
	 EmVEvHguGrJYej3vSromF2Qa6CHvJqXNVCivdGrxyKq3FdfPntQZ2BM/3TQjXY+8nL
	 QuYgj9yrnjQ2Vti2EO5MD3Q2jDrl79vUKWvAQE9jtn5gqMt+/juvtXKX2MORZQYlzH
	 Id6h7XSCZUOX9dUF3mbDNW0/nI79xu0k06MiqqBpjeRYHkBzjeg9Wrv0c1xhPLugge
	 ODuLGy0m8u5OQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Hans Zhang <18255117159@163.com>, 
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
In-Reply-To: <20250905112736.6401-1-linux.amoon@gmail.com>
References: <20250905112736.6401-1-linux.amoon@gmail.com>
Subject: Re: [PATCH v1] PCI: dw-rockchip: Simplify regulator setup with
 devm_regulator_get_enable_optional()
Message-Id: <176085588758.11569.7678087221969106036.b4-ty@kernel.org>
Date: Sun, 19 Oct 2025 12:08:07 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 05 Sep 2025 16:57:25 +0530, Anand Moon wrote:
> Replace manual get/enable logic with devm_regulator_get_enable_optional()
> to reduce boilerplate and improve error handling. This devm helper ensures
> the regulator is enabled during probe and automatically disabled on driver
> removal. Dropping the vpcie3v3 struct member eliminates redundant state
> tracking, resulting in cleaner and more maintainable code.
> 
> 
> [...]

Applied, thanks!

[1/1] PCI: dw-rockchip: Simplify regulator setup with devm_regulator_get_enable_optional()
      commit: c930b10f17c03858cfe19b9873ba5240128b4d1b

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


