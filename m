Return-Path: <linux-pci+bounces-31291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D294AF5E6F
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 18:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749623B1DED
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 16:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F4E2F5460;
	Wed,  2 Jul 2025 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBaRenqn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC62EAD1A;
	Wed,  2 Jul 2025 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473301; cv=none; b=SI5KJ9RFzFNwcte8CE5iQiADnIg4m6et2VckTAIJH4VKpXI44sfyZgiOcsuNxdyGMyhotVU7w6bFDxOf0b97LhA1xjINwOeUuDPD8ysp6K57/6LDa0UcAisHyuJ/vh4SO0gb7dmRVddaADF8+dpkaPo0vVObiZuqD8Wz5L1IYNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473301; c=relaxed/simple;
	bh=9QVOwWxCq6vU9om7he3BjCZEBDSRveGFOzMgdxLpToA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:To:
	 Date:Message-ID; b=bOvYFJmoZbsiLLGeC/tPK36IOHLIRfArqMF/YKyHtmisxjCnr19wOmtz2EH/J7AlgbX/62zSPi108oNmpMgRB5uIORd8NHe+9f1RGLpuY8qIe42CezZpZCw2rniqmSayoQnz5K9b40ggghulJt5UXe2AyjAwDUpVoMU9n0uybl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBaRenqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB733C4CEE7;
	Wed,  2 Jul 2025 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751473300;
	bh=9QVOwWxCq6vU9om7he3BjCZEBDSRveGFOzMgdxLpToA=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=OBaRenqnWo3vVxvR3tpFSU+/CO1Hn/C2AOFYnPCUJtG3yPc0LL9KQguMqJel+PrgV
	 9YwWsHlk+d8l0QcmBa85IGgqVH6Rp514K3Uh+r7GTx6DzrTsm5boDaF7tZcleIEraq
	 lHlxghzWYxvmOiKZR1lfylNYjd1aZlmj8Wk/CM52kH2vwjB57EweNkf0wL+enKMtZT
	 iDuQz2u3453dJmbIgm6BDIr6K90MuF83uFCKsZNJ3Z/xVY4UbKjs7MX6RhuNhYXQoV
	 imIWr+4FKAr9TZIO0ZRivUYvvpzgpdIXOtmA37Xm4DNY+SfTAaThWiC/BqcGDU4k5b
	 rMBj4Ot9czqPQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c20066500908db854aa4816b40e956296bab526a.1750714412.git.andrea.porta@suse.com>
References: <c20066500908db854aa4816b40e956296bab526a.1750714412.git.andrea.porta@suse.com>
Subject: Re: [PATCH v2 stblinux/next 1/2] dt-bindings: clock: rp1: Add missing MIPI DSI defines
From: Stephen Boyd <sboyd@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herve Codina <herve.codina@bootlin.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, Linus Walleij <linus.walleij@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Masahiro Yamada <masahiroy@kernel.org>, Matthias Brugger <mbrugger@suse.com>, Michael Turquette <mturquette@baylibre.com>, Phil Elwell <phil@raspberrypi.com>, Rob Herring <robh@kernel.
 org>, Saravana Kannan <saravanak@google.com>, Stefan Wahren <wahrenst@gmx.net>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 02 Jul 2025 09:21:40 -0700
Message-ID: <175147330025.1004940.8501762790281649413@lazor>
User-Agent: alot/0.11

Quoting Andrea della Porta (2025-06-23 14:46:27)
> Declare the positional index for the RP1 MIPI clocks.
>=20
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

