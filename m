Return-Path: <linux-pci+bounces-39338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91921C0ACA3
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 16:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE4C1896945
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 15:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A6425D540;
	Sun, 26 Oct 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4HzZeJP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F8E22172C;
	Sun, 26 Oct 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761493051; cv=none; b=g54azzDcMsvah+Mb3xbmA4BF8vBTK47asoHCya1aUi9p+xyUAzTubVk5Z8O1/s+58UZe5S6D0jE8oxDzoS9tEYEh7mecKLCKHWX1JYAaNbOARs7YwivZetLWelEmNKMKhFKnIa6aVwH8Lo87MVHdzbX67obpQOu1s+/JMP6wJB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761493051; c=relaxed/simple;
	bh=FAVjGfD5iURxjFRW5lrdmhLUB13r0BoxN6mWb3t0/xk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D0prWLSbqHDEYjGgfQWZh8LUkFIxbNYDuCqCbPAu9s0Wbr9vsbhQREp1Zy+UQGIf9NiQQv32v7uYw+HZxbgg9Hua5FR/62BQBIT7foz+ojMa/FYSwmZyKr9CxXpctZP5E15Rey41Ao8HlKFEku3zu/HtoohFNW1kMkuEEKD8B2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4HzZeJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3263C4CEE7;
	Sun, 26 Oct 2025 15:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761493051;
	bh=FAVjGfD5iURxjFRW5lrdmhLUB13r0BoxN6mWb3t0/xk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=J4HzZeJPQpyjpjHs5BetJodW89YXoquuALgjCtc5jWbwY1BoToyqS9kRSZZFO2FpR
	 jq6wO0xkP0ZqwOPdElKLkQ99oOiAbdM7XiH733TejtoyNDThkRXd1ARvBNM+ntGY8k
	 KVjDIENQehaaKuUCAlJ8oeaOv9zUqjqbRoqNUq5HxfQ2yoQd//QcLVjdoP19olUbfI
	 RAfUS6svpTuRvyThLcB6+ise03q/qUNUfQVCL53gBaK3HBP/oySZdzqAx9L/1eKkuJ
	 ppy2FBR3b5TiSVwgFOMFpgiOav5KI3PXcUiSviPPcPPeOixRY+ZkhnKX9QFnPKtIZq
	 21k931UdAZUkA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251024011122.26001-1-robh@kernel.org>
References: <20251024011122.26001-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: amlogic,axg-pcie: Fix select schema
Message-Id: <176149304726.5459.7196722337090746268.b4-ty@kernel.org>
Date: Sun, 26 Oct 2025 21:07:27 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 23 Oct 2025 20:11:21 -0500, Rob Herring (Arm) wrote:
> The amlogic,axg-pcie binding was never enabled as the 'select' schema
> expects a single compatible value, but the binding has a fallback
> compatible. Fix the 'select' by adding a 'contains'. With this, several
> errors in the clock and reset properties are exposed. Some of the names
> aren't defined in the common DWC schema and the order of clocks entries
> doesn't match .dts files.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: PCI: amlogic,axg-pcie: Fix select schema
      commit: 7411850df8e460d5e8319f3c020d03a88fa2dbc7

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


