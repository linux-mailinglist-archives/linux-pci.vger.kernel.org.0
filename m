Return-Path: <linux-pci+bounces-36221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C10B58E92
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 08:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9459520356
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 06:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BB62EAE3;
	Tue, 16 Sep 2025 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG913p9x"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB9F1F583D
	for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758005098; cv=none; b=oX0UXVj8M6QI99UhE6DYNwXWqo+gz/Rm/EAMXaTPip8SQsc4oTZAIbOpRjp3Xra2LqhW+AecHPfEPVZH/B+tvBi3Scu9UGR+VKQM3UCX55C6czGqVbzAqzYttbBO8Dq96bClV/tdVnqihxBH1+7yhWoSFIR9ZLVvb9EhdKoVeUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758005098; c=relaxed/simple;
	bh=cGF/i2oyT43KZ3PVsnTnE5wXmAvvhrwe1VyD/F/P9+Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AIUz4YQ7AACZEoiiAKHLtP9S0+S1YtoahGE3DmDeXcaMxXnO7kcOSnKXTBUYT6MypEYzp6v7SJK7s6Iqi3ADmrv2DR0zZV1lfiFdWp40n9+oP59CY9Z59T//r3TgTB/uwq9/+CcDe2XO1rGMu3or4khgLpg+cdgSin9f/p6Vge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LG913p9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93379C4CEEB;
	Tue, 16 Sep 2025 06:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758005098;
	bh=cGF/i2oyT43KZ3PVsnTnE5wXmAvvhrwe1VyD/F/P9+Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LG913p9x5RUy7ClTX/S/Vp6XkWdn82S75+CRGK3IQp22U6D1TzwNGrK5I0nbwriUh
	 N8X6XwFj2n27RDymiIZCy2w18TK+AEt2uld/lyZQPrCb3E1gflgLzQcU3ZdEkCbb8n
	 WhQPU+Ov3XGFsKrMvZ/D5PFAqJ9ZU7Lf2CZlR6/4NkAXQUHY9P0jF5HBanmkHj1Qc5
	 g9klj48KlspCqGIRGq6x+prhkM3/Yw+AYOyVAWDYmG1Tskle2B4Fp5it/qV7Okz4Yo
	 qn/U5sQPLD8oNQ87iB3nJkvNzMXUPisetAFQqbceKbNDHptY/BwjI+4m8WyjYUFRxa
	 xIHpOvCxpf1oQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
 Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20250916025756.34807-1-shinichiro.kawasaki@wdc.com>
References: <20250916025756.34807-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-test: NULL check dma
 channels before release
Message-Id: <175800509515.249012.10022486346017466963.b4-ty@kernel.org>
Date: Tue, 16 Sep 2025 12:14:55 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 16 Sep 2025 11:57:56 +0900, Shin'ichiro Kawasaki wrote:
> The fields dma_chan_tx and dma_chan_rx of the struct pci_epf_test can be
> NULL even after epf initialization. Then it is prudent to check that
> they have non-NULL values before releasing the channels. Add the checks
> in pci_epf_test_clean_dma_chan().
> 
> Without the checks, NULL pointer dereferences happen and they can lead
> to a kernel panic in some cases:
> 
> [...]

Applied, thanks!

[1/1] PCI: endpoint: pci-epf-test: NULL check dma channels before release
      commit: 85afa9ea122dd9d4a2ead104a951d318975dcd25

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


