Return-Path: <linux-pci+bounces-27860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A8FAB9CCC
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 14:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783861BA70BF
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 12:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B3B241662;
	Fri, 16 May 2025 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QztZcwel"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1286023FC74
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747400282; cv=none; b=rw63Sc59HidT1Yci80I6rrVtfbMXxlsbDZ8tnOJ2BLzWa7/M9f6Kc0Bm2JLgkSQBXzkKKi+w+FtXUesO93FHK22foANCXP+CBu1YfzbLC9eJ+9Oue1egFy8FqDie1WW073KfC9iDb5PX+ORfAHpHh6T7TLK5WeLqH1MqCcYNY0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747400282; c=relaxed/simple;
	bh=2I2jJViJOWlayOl8zhNj+XEsEWeGms/kw3wOaSTHwaI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixx4RRENxcXTbaDN1EueX2vOGgaLvW2g9INT85/UHA+Ao6Pm0/BrHyfOOLT4Sl2Y5o9d0SBclxcECGAWPSrAI6/swlCthyG6RuohZj2l0UpEGZUV2/j6lX3DyixamELL3v76z8B22PpDkOQ8ynLNWkfqB/Mm4qJGxgIStbNtrLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QztZcwel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D6AC4CEE4;
	Fri, 16 May 2025 12:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747400281;
	bh=2I2jJViJOWlayOl8zhNj+XEsEWeGms/kw3wOaSTHwaI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QztZcwel5EIE7TykRubQaNmlAbfOXmTcuEjSn2FkJmUI9GoDY6vCUDgwZJ+DpzvNr
	 btgf9KFRA6ihYJlKrYYYn8GQyvQXGw2uBIOAE85pDowWSkbTHs11e34Q/Pw9JBorVn
	 E/ol2OgPxwlcSeImZVolKTh+7TMaqzIJlBRIYc6jdeyWr2VggJL4xXPMqKHDb4RlFv
	 7sJsgWuEwNJnQsHSunb+j/UCO61pwYFQyUfLs5qSMXZokcRxmEHweTO+yhwEyswXTf
	 3L+heMJrpLHQRaEHA5y6ZyXXPVXU7CY8Oeegi7f/Wn/d39rN8+Fwlmg9Oe8ldFKJpC
	 /tTw3FIAltifA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: linux-pci@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v1] dt-bindings: PCI: microchip,pcie-host: fix dma coherency property
Date: Fri, 16 May 2025 12:57:59 +0000
Message-ID: <174740026918.68680.6391480800979217255.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516-datebook-senator-ff7a1c30cbd5@spud>
References: <20250516-datebook-senator-ff7a1c30cbd5@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello,

> PolarFire SoC may be configured in a way that requires non-coherent DMA
> handling. On RISC-V, buses are coherent by default & the dma-noncoherent
> property is required to denote buses or devices that are non-coherent.
> For some reason, instead of adding dma-noncoherent to the binding
> the pointless, NOP, property dma-coherent was. Swap dma-coherent for
> dma-noncoherent.
> 
> [...]

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: microchip,pcie-host: fix dma coherency property
      https://git.kernel.org/pci/pci/c/db8266017e0a

	Krzysztof

