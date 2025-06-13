Return-Path: <linux-pci+bounces-29662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FBEAD885C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 11:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2843BB0D2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 09:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D0E2DFA3A;
	Fri, 13 Jun 2025 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCQ+ArOM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF12DECBE;
	Fri, 13 Jun 2025 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807936; cv=none; b=DEpJ3CUEJJxeFkVAdvEX2EDEHPzVgy1Xpdb0k5FtVVm+KBX6hEiGp+ig73z5T05XFJDSVCu344+3/BlFF0oyfT667F2uBVUwlsdIGWAqJJggpG34i1pwjKgPD8e6AYdPy+wwjVFSNzHPEEWMUxHcqGd4yqNEO1JxbZsO/zN9NcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807936; c=relaxed/simple;
	bh=KZ0BWcWO/Nnu1q5NglmWAod4+nGJ2WWcd5CNjfdsUO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9EoiobhyFhlJHavrBmsG1n+E6i3WdZmYFHOznN4EK5SPkXrYWe2NMjFT40hEIOxrFOoVlfGVl2pzfj5BMW6Gk/oEb7Qmc6rpJjsZOgtRzjDCBhO27CRVCaPJ/tKePnxZAtQLRgi8I7+/lN6ecOXCKPM9qlOSk2AI7QpeBOkCcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCQ+ArOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7727C4CEEB;
	Fri, 13 Jun 2025 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749807936;
	bh=KZ0BWcWO/Nnu1q5NglmWAod4+nGJ2WWcd5CNjfdsUO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aCQ+ArOMfZ8sj9/trk2RN4zzQmNDRm57UcCwHqzSNmBb3apdfrSNyzaknWyYLRPjh
	 6E3L22twogCDgusyUyZzDGlDING27CHkfgVwL7Qfe5BDfSkbBp55e6vFTCsUCYhfWa
	 iFB8yIknypSzugsOXAz7FH6q/xY/0xFIUp7GlroH+Qbv1fuibs4wDOAL+dnSd7SmBh
	 PUekiEcVEkwP6WVmzgXHMenCSFCR5E17+KZjgA7/phOXpz9JEn4cTHyKgpHeTYwm+V
	 Fhc+PM/4QdvEhSmY2I4S88xQ+fYARMAcOlJnmoU94LA5kiKThUq2MTXDYd0v0NZdZI
	 bcsXM5H49D58w==
Date: Fri, 13 Jun 2025 11:45:22 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Qin Jian <qinjian@cqplus1.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, kernel@collabora.com,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
	linux-sound@vger.kernel.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 17/20] PCI: dw-rockchip: switch to HWORD_UPDATE macro
Message-ID: <aEvzMnxgsjfryCOo@ryzen>
References: <20250612-byeword-update-v1-0-f4afb8f6313f@collabora.com>
 <20250612-byeword-update-v1-17-f4afb8f6313f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-byeword-update-v1-17-f4afb8f6313f@collabora.com>

Hello Nicolas,

On Thu, Jun 12, 2025 at 08:56:19PM +0200, Nicolas Frattaroli wrote:
> 
> PCIE_CLIENT_RC_MODE/PCIE_CLIENT_EP_MODE was another field that wasn't
> super clear on what the bit field modification actually is. As far as I
> can tell, switching to RC mode doesn't actually write the correct value
> to the field if any of its bits have been set previously, as it only
> updates one bit of a 4 bit field.
> 
> Replace it by actually writing the full values to the field, using the
> new HWORD_UPDATE macro, which grants us the benefit of better
> compile-time error checking.

The current code looks like this:
#define  PCIE_CLIENT_RC_MODE            HIWORD_UPDATE_BIT(0x40)
#define  PCIE_CLIENT_EP_MODE            HIWORD_UPDATE(0xf0, 0x0)

The device_type field is defined like this:
4'h0: PCI Express endpoint
4'h1: Legacy PCI Express endpoint
4'h4: Root port of PCI Express root complex

The reset value of the device_type field is 0x0 (EP mode).

So switching between RC mode / EP mode should be fine.

But I agree, theoretically there could be a bug if e.g. bootloader
has set the device_type to 0x1 (Legacy EP).

So if you want, you could send a patch:
-#define  PCIE_CLIENT_RC_MODE            HIWORD_UPDATE_BIT(0x40)
+#define  PCIE_CLIENT_RC_MODE            HIWORD_UPDATE(0xf0, 0x40)

With:
Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")

But I also think that your current patch is fine as-is.

I do however think that you can drop this line:
+#define  PCIE_CLIENT_MODE_LEGACY       0x1U

Since the define is never used.


Also, is there any point in adding the U suffix?

Usually you see UL or ULL suffix, when that is needed, but there actually
seems to be extremely few hits of simply U suffix:
$ git grep 0x1U | grep -v UL


Kind regards,
Niklas

