Return-Path: <linux-pci+bounces-34919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36749B383BB
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 15:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B21B07A1B91
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E96929E0F7;
	Wed, 27 Aug 2025 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDGuqgFz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9728F1;
	Wed, 27 Aug 2025 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301458; cv=none; b=mrbd2wF0ugzeruUABZb2KOy8ZliDiaAdzQt8n/XaHg/i4GHWmaGqjMxsdtTveP3J4IP/N17VdAbUV0QbfvdsyJ/rNEddeckG+T+JcZI1Z+sn3oS4W5wJFE3kGb1aQF89ku60Rocrqt1EFEbvAIBCWn3SlW7v5uNDd0aSq0wAdT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301458; c=relaxed/simple;
	bh=D+f7sGcwgv+7yWZQKZNxbE+Fo7kTjohDpe0jO+6Mvf8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hN0dDfmzfQt/1eJt+HqRofHi/38Y4COEbAvFsFtcngjfqUqXp16yEorrANHR/SiD5GP3U79ciJbtDWF6wMI3BypKDAWb35LYEtQMTZt4ORdGX47LcI9AkDw5pm/coqQDFZCdsBgetsoSzsdGn29j6DuFrXGwP6R+0D4Oq4thclo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDGuqgFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04AAC113D0;
	Wed, 27 Aug 2025 13:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756301457;
	bh=D+f7sGcwgv+7yWZQKZNxbE+Fo7kTjohDpe0jO+6Mvf8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SDGuqgFzwsVWUQYALgiMql1WtTwrAAGmN+lcU06/ydR38GFlkdnJk4MjY13lN091O
	 nbSm/HmrEp2DGulV6STXZx7lRlLpOWXIgFzxJgDqpcT2QcXynUSiD3/5b6VNwjVVE+
	 s98n7JEiFTK0lzA+HvznK/KgOY/5iQCq1Ozd6SOrArJLcVekwVJhXAKYh3xtcnc3cu
	 Ezv6P9xJbF+gt6r4iUEzXo+7xOeihSfkggBJby2Ivx23zB8EmDJ0WVJT/VxbvPWWtd
	 OK0GO4VpntQwI5PxLs2oAXy80GcquzbdO3ksrlKan/QOf/7xUhGn02GvDRccerFUJY
	 ehB/Kr2FWvGmg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
 linus.walleij@linaro.org, corbet@lwn.net, p.zabel@pengutronix.de, 
 shradha.t@samsung.com, mayank.rana@oss.qualcomm.com, namcao@linutronix.de, 
 qiang.yu@oss.qualcomm.com, thippeswamy.havalige@amd.com, 
 inochiama@gmail.com, quic_schintav@quicinc.com, 
 Christian Bruel <christian.bruel@foss.st.com>
Cc: johan+linaro@kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <20250820075411.1178729-1-christian.bruel@foss.st.com>
References: <20250820075411.1178729-1-christian.bruel@foss.st.com>
Subject: Re: (subset) [PATCH v13 00/11] Add STM32MP25 PCIe drivers
Message-Id: <175630145053.10268.16196388698773824322.b4-ty@kernel.org>
Date: Wed, 27 Aug 2025 19:00:50 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 20 Aug 2025 09:54:00 +0200, Christian Bruel wrote:
> Changes in v13:
>    - Rebase on pci/next
>    - Replace access to dev->pins->init_state by new
>      pinctrl_pm_select_init_state().
>    - Document pinctrl PM state API.
>    - Group GPIO PERST# de-assertion with PVPERL delay. (Bjorn)
> 
> [...]

Applied, thanks!

[01/11] Documentation: pinctrl: Describe PM helper functions for standard states.
        commit: 272dad3f84004079328e8f36b2292e7297460ffd
[02/11] pinctrl: Add pinctrl_pm_select_init_state helper function
        commit: 08383cd479f8212fafee2f557b58cfd48818bee0
[03/11] dt-bindings: PCI: Add STM32MP25 PCIe Root Complex bindings
        commit: 5ffa3d2f43a487f60e9f6f692aa8e22251446755
[04/11] PCI: stm32: Add PCIe host support for STM32MP25
        commit: bb90c3dd42adba65fc2f26ecb16c1d27d74fa68b
[05/11] dt-bindings: PCI: Add STM32MP25 PCIe Endpoint bindings
        commit: 89f6842156333cca9abb8e641e28100b708bed00
[06/11] PCI: stm32: Add PCIe Endpoint support for STM32MP25
        commit: 679ebde120900c246925a374ea1ad39392d6e84b
[07/11] MAINTAINERS: add entry for ST STM32MP25 PCIe drivers
        commit: 3cf6b1bf4d250c15ebe537d55b5e09a902c41971

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


