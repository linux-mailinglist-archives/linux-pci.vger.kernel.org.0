Return-Path: <linux-pci+bounces-34923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD71B38463
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 16:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19095E7742
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 14:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B2035209F;
	Wed, 27 Aug 2025 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv9sVQ9u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5E128980F;
	Wed, 27 Aug 2025 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303480; cv=none; b=UahkKeF29Bpwbch2mpKtr4OEB/6FOZEKc+FQBR0cPjjEwkEoG5w5aB9kIdpRZ1ZpJw1ZcgfjbHhv0ZYC+1oEwqonTmvd1i50AQv7Fa+PQATcAkmI93KqpYfoV8oWZG8dfbaby4IBz/oGzEQ2uwnlAvDueBrAu82Iz20p+8PRNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303480; c=relaxed/simple;
	bh=z1OWeobZjSJejI2sguAIcoQpglo81eE/fB7nBIXC78Q=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ocv6Buicb8FpTLTbnU8w0DzjrGZpo4PXhlFnYKM4+yNClEqLKHh0MUW69VeLv9wHPq9vMfbVdO29p1j9PZ6pE6/pNIQzfKwW5/R31XZE/3av5IJLSt9yCzvs5o3NnQ3sVLNIBGlECJQy2GA63I/ToL7DzmmIxfE4Abl43UbcZ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv9sVQ9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EE4C4CEEB;
	Wed, 27 Aug 2025 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756303479;
	bh=z1OWeobZjSJejI2sguAIcoQpglo81eE/fB7nBIXC78Q=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Bv9sVQ9ufk0Ivp5+a7QIrJQhVjrnw7TXJDCZxsMUEDuCyXKhsLhMLa6V9GJRDAdnt
	 LMrQelz1rMy1cQrA/WIYGf3YEOdzMM1flPpSRcChve0eyM2kt8tTVfRBG3nsf4AlKi
	 xplDvwenKaIIj3AmBWIbpTn7GYbF+xolDBNXDJwEgPeNxA875JfUAnzxxi5Om3Lh2K
	 gMyXAdC5ZdSAmOofXhfrdoCtNUkLSVDFE7CELyMgXzxKFSFZjdf60ttz1LIBW+jwkQ
	 Yu04ZWulc3IV9msO/CVR2ZsMd4em2WsGxiii3y8n9Rl9Y4W1mdemUpeIHFAnx+kkZF
	 9Hb0rOuMPlofw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Niklas Cassel <cassel@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Hans Zhang <18255117159@163.com>, 
 Sergio Paracuellos <sergio.paracuellos@gmail.com>, 
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250819131235.152967-1-rongqianfeng@vivo.com>
References: <20250819131235.152967-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH v2] PCI: keystone: Use kcalloc() instead of kzalloc()
Message-Id: <175630347585.12704.14542209032343661928.b4-ty@kernel.org>
Date: Wed, 27 Aug 2025 19:34:35 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 19 Aug 2025 21:12:33 +0800, Qianfeng Rong wrote:
> Replace calls of devm_kzalloc() with devm_kcalloc() in ks_pcie_probe().
> As noted in the kernel documentation [1], open-coded multiplication in
> allocator arguments is discouraged because it can lead to integer
> overflow.
> 
> Using devm_kcalloc() provides built-in overflow protection, making the
> memory allocation safer when calculating the allocation size compared
> to explicit multiplication.
> 
> [...]

Applied, thanks!

[1/1] PCI: keystone: Use kcalloc() instead of kzalloc()
      commit: ffdd27d36265be108827c606c9fbe81a5947547e

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


