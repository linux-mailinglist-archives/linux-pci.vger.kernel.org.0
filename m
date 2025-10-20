Return-Path: <linux-pci+bounces-38710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3F3BEF5FF
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 07:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A4DC4E1027
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 05:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555BC2C0278;
	Mon, 20 Oct 2025 05:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nlrb1AiS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C522299AB1;
	Mon, 20 Oct 2025 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760939512; cv=none; b=hR7Rx+DSRIc6qoTKVJx4S/RZViULfxOqeMJ0qYcYko96zhtOx55JjmKHH2kt9iWJd103HRdLv6AOt3q255mEEttJvuo/FpQ3m4tFyepd7kcMvyKDtTvpiAnPV3ibPYiQ51CCtJp2F3xYps2R+ZhJ+Nve8HTGrIdgwb/M1uqjSGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760939512; c=relaxed/simple;
	bh=tKe6KGdSc+szywqAtEr+xj+w4ukPNV6Ofoi8OlP5MMo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ihAg963+R8C+jjxjsGxcE4mMd4X+hBQL5fyw4Djv+JYAVTQJYN44t8acVqpVkR4pwaW/ofDjjNOQEjoAOBVW21sA5dmePLrvx3AhmS8VyGLUgd6PikwdT2uHKtiPwzb+fshQ+/PnssjPT5tkZXCQy2jHmfUV+ncyieUxRCrGSyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nlrb1AiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140A3C4CEF9;
	Mon, 20 Oct 2025 05:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760939511;
	bh=tKe6KGdSc+szywqAtEr+xj+w4ukPNV6Ofoi8OlP5MMo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Nlrb1AiSE4p8sESgZ1sX2uII1Z5tg5K4tueF3+964Mvp27k4Iiz5BbddGhZvFDoUW
	 zCXC7RYshTacWu32xzqovtfMJSrP1l40CjyJ+Y8Vnlf/JfpwYIdb8mjOm2yprGpZNs
	 jKAf16fFv+1p3KQpCMrgR31yVZIVL20FopsaTZBd1owCm0FyX7ckFvEDqUh1jv2ysr
	 4lNman0d7nrP4DeO3lB1E+9CDsRyMc+PrmyoB6cnPfFaUTclV/OkMI4iSMGqrAO1O6
	 cF6Gt3R41JCoO1xIpiXv5GGtsv3Gmq0ym6PjrjHY+e/ExhEM687QqHdmZqPXXbqjqs
	 yMXBc8iwBdTag==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <00f75d6732eacce93f04ffaeedc415d2db714cd6.1759480426.git.geert+renesas@glider.be>
References: <00f75d6732eacce93f04ffaeedc415d2db714cd6.1759480426.git.geert+renesas@glider.be>
Subject: Re: [PATCH] PCI: Drop ARM dependency from PCI_RCAR_GEN2
Message-Id: <176093950640.8510.11343827027415313657.b4-ty@kernel.org>
Date: Mon, 20 Oct 2025 11:21:46 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 03 Oct 2025 10:35:34 +0200, Geert Uytterhoeven wrote:
> Since the reliance on ARM-specific struct pci_sys_data was removed, this
> driver can be compile-tested on other architectures.
> 
> While at it, make the help text a bit more generic, as some members of
> the R-Car Gen2 family have a different number of internal PCI
> controllers.
> 
> [...]

Applied, thanks!

[1/1] PCI: Drop ARM dependency from PCI_RCAR_GEN2
      commit: bd4e28f711a0c218641f72bb1602a2c8b9d36274

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


