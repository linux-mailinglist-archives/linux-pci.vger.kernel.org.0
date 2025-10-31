Return-Path: <linux-pci+bounces-39905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A91C23ED4
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 09:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA7194EBB61
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 08:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07989313298;
	Fri, 31 Oct 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dm9k6WmW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAF6310625;
	Fri, 31 Oct 2025 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900805; cv=none; b=iYLoSC2P5quaI66Iinyz9GNTI1TOfnQocAOisQwzSAJ2UKpO24R4gpb1Z+4HpsE+vJnKC1uM1y5uKuJsoVoxuV7IRmbC19CDXwc2A/YF1V47vYSa7X0AdrZk3Q4KxX4WrPG3cH7sul5mbNwemeuK2OCxS5EUkPj8XLQ7Rebdtcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900805; c=relaxed/simple;
	bh=5lLjxIzAgzkUJ1WMCPxKdYVneDvO0fPVfQqhFcLinzA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J4Ftu/9ZpkSE2ROwF36aYf4vmI8K91gceN/49haJlaKRGuMsrsxwCqMSWzbpoIeanKTWw42D4SabT4Frmb6bCZwZZSeSeCrva0T04MS799l4CNyvzEfCfzv7uZ52b7eppXbs1HNo+CwXhOUBeUJJxKBF3NJ59v26c5qwSy5Tro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dm9k6WmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8990CC4CEF8;
	Fri, 31 Oct 2025 08:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761900805;
	bh=5lLjxIzAgzkUJ1WMCPxKdYVneDvO0fPVfQqhFcLinzA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dm9k6WmWGVgybTFkgYPZXca2qmWqQBfx6bMJfZZSJwdWhAmrzi27tOCq1MjexlaH1
	 BY2MuUywMoh7JIihXqwl0TWcNhz4vBzrjJc9kSe2i4/bGnqLGmzgGc/DXeDZLtUymu
	 mYOGjSFGNrIkNJul/v9MWJZ46OuSijrTc8t/UBeJDTdX2uDAgdCzE5WvSyL00URSxo
	 jybwpLLoZR0iOb9Vz4ZYojPCp/k3EZtDDNRdYeiOS2gL0cZnqsdrgGBnTdguJbQoJO
	 FmwxoWuIYWkNkojuXfRm2U4Q+aBGvaTNj9eK13yjd53I1Yj7pguKTgmERcw68ovHab
	 22P89gdI3UFFQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Anand Moon <linux.amoon@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, 
 Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20251028154229.6774-1-linux.amoon@gmail.com>
References: <20251028154229.6774-1-linux.amoon@gmail.com>
Subject: Re: [PATCH v3 0/2] PCI: j721e: A couple of cleanups
Message-Id: <176190080005.8740.2017130135799803682.b4-ty@kernel.org>
Date: Fri, 31 Oct 2025 14:23:20 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 28 Oct 2025 21:12:22 +0530, Anand Moon wrote:
> Refactor the J721e probe function to use devres helpers for resource
> management. This replaces manual clock handling with
> devm_clk_get_optional_enabled() and assigns the reset GPIO directly
> to the struct members, eliminating unnecessary local variables.
> 
> These patches have been compile-tested only, as I do not have access
> to the hardware for runtime verification.
> 
> [...]

Applied, thanks!

[1/2] PCI: j721e: Use devm_clk_get_optional_enabled() to get the clock
      commit: 59ba8c0981e73cb2bb70074be4ef46b4188424ea
[2/2] PCI: j721e: Use inline reset GPIO assignment and drop local variable
      commit: 8895c0fc0671f38746ee1c02b728b126f7dbbf97

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


