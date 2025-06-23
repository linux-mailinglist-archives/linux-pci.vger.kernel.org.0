Return-Path: <linux-pci+bounces-30381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D16AE3F94
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F0D178DD6
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C122255F5E;
	Mon, 23 Jun 2025 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bT/LjJgN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFDB2550A4;
	Mon, 23 Jun 2025 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680407; cv=none; b=CwjRgnnhe9Te1TX/UKEJ41Dd9TADouqsGkedtND85An8Azg1+FIpDhwTrnx0RoJEmlHYW3MtmVpnlRY54kL/WqfqRs/w2xnLsgAFCVnRbooaaoeRdP6Pr0vYIxi8VxqtOdkUsY3ZTBvSQ8ppudL2dZtuz+/Hcxe5j27CFuCl6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680407; c=relaxed/simple;
	bh=OdSD8nYZGOkV8fnciDyV48OQwABe71AhiAIazDnGy0E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fuQC6sxbb8JUODvrIKGUnNfbqaZ6xJSYzYGRu1V8afuwlWQQqjyxolrrJQERClsV3l7P+lfEQm885MgQWsEiPlVchhLFZfuA/Kn0v4AydQaxMXb1OZGV9OpgN+7IPpX3hWpBie7mvdh4mps8W/0TvWqhjSkEacUkBO8GPxLV0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bT/LjJgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F9CC4CEF0;
	Mon, 23 Jun 2025 12:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750680406;
	bh=OdSD8nYZGOkV8fnciDyV48OQwABe71AhiAIazDnGy0E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bT/LjJgN3A7McGMME8EdhZ6ny6E6SXKCbFxo6o9r8gxql98GAkpTm3cIDX0Y4LkEW
	 ekp5vNTXTgp1nR5SHWqieiHB3EFNM8Jh3FA6sL1UuPdS4HK/8VVtT7PIlu9+kUDeur
	 JfdYLSo9Rm3eLbPnrgzlVvTt9j0pklUnGPKAp8W134awIEb04ahcbRzlaMeozQIULH
	 m0Nt/N3v9ID6m2Dba0/kGWSOP49EV7/bLGUSABuSGKjnEeEKwPC1qP6WLoxAzIlDxT
	 30y2rM3urJw8AFG2qw3FJ0zRosHFS3C+DJsKr5QNJyaphUnwRlIsMA94wSO/OoYgTI
	 tJHFLtCTQTmqA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250603-pci-vntb-bar-mapping-v2-0-fc685a22ad28@baylibre.com>
References: <20250603-pci-vntb-bar-mapping-v2-0-fc685a22ad28@baylibre.com>
Subject: Re: [PATCH v2 0/3] PCI: endpoint: pci-epf-vntb: allow arbitrary
 BAR mapping
Message-Id: <175068040623.12516.4425064763865712731.b4-ty@kernel.org>
Date: Mon, 23 Jun 2025 06:06:46 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 03 Jun 2025 19:03:37 +0200, Jerome Brunet wrote:
> The patchset allows arbitrary BAR mapping for vNTB PCI endpoint function.
> 
> This was developed for the Renesas platform with requires a mapping that
> was not possible before:
> * BAR0 (1MB):  CTRL+SPAD
> * BAR2 (1MB):  MW0
> * BAR4 (256B): Doorbell
> 
> [...]

Applied, thanks!

[1/3] PCI: endpoint: pci-epf-vntb: Return an error code on bar init
      commit: 7ea488cce73263231662e426639dd3e836537068
[2/3] PCI: endpoint: pci-epf-vntb: Align mw naming with config names
      commit: a079d83c4afd4896f7f29bd9e807cb382043b360
[3/3] PCI: endpoint: pci-epf-vntb: Allow BAR assignment via configfs
      commit: a0cc6e6fd072616315147ac68a12672d5a2fa223

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


