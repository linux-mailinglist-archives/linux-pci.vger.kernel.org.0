Return-Path: <linux-pci+bounces-26830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B481DA9DD06
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 22:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C493BE1BD
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 20:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1417C1E7640;
	Sat, 26 Apr 2025 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbmeIanh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE23C1D88AC;
	Sat, 26 Apr 2025 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745698423; cv=none; b=D6iGHo94y3gxucF0p+kvSTrRac8572rh4/SZu+EBFNcWnJdFpJzDvuNeQ7APMsxbzJYLiL71XplY560ac3OnKKYUEAnGJaGXDkDYPe90+aaBL7AVkkxpmA4iovJ0oEt7LUGLNoEPzE7kKVGIqe5EVdNC8UDI/yvjbJ5b1mUE8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745698423; c=relaxed/simple;
	bh=gjccBlvCWrBL49MXup4mGARaIMgxPNin5SIQOWU+oCE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qGJIrgScTqwYRVCZ0Ab7KmcOjTmNduz40bWwgheJgXwH+i8G95taeXWXFONXNN4jJx5Uqa6O8z1Ky82BFReaZgPx5SEV6vbuXwggyDwUieIZldqMHEGEjplLO8N7dhqC0BnDamzKtUfy51vBpb9P1GjjOFpMxd4YPOPve9cezec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbmeIanh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4262C4CEE2;
	Sat, 26 Apr 2025 20:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745698422;
	bh=gjccBlvCWrBL49MXup4mGARaIMgxPNin5SIQOWU+oCE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MbmeIanh+mG2cl7rfOuvPgiE+pJC7Z2ffmAWFn3P91mP/xK/tXOUZfccSuJeL11L0
	 zq96vjIMAhJ91EktORazsidAgEPFr/1xJsmeX5ynlU7UWOWBjiHClEvsg0o2uXmbDe
	 BmAkbZH+kWeBETTUeZ5zivhyrCj2kP2xltcXtDNMxo/zSNjlhodX1Blg+AGJy0ZwQw
	 wK4jUKdH1V0sCeuOygiVhziHFJmXVeNudITWFQYcOWZkECuG3jD0Rn4GTbOh/viWao
	 8Dz2DWTjLXs0CH/SOMJGTGNvDSs6npVwSdkqveC3zKDzhG8pRTu4uJF9/ZsoofJQBI
	 wrFL63RFN2I5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF4E38111CC;
	Sat, 26 Apr 2025 20:14:22 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250426195957.GA598020@bhelgaas>
References: <20250426195957.GA598020@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250426195957.GA598020@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.15-fixes-3
X-PR-Tracked-Commit-Id: 442cacac2d9935a0698332a568afcb5c6ab8be17
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bc1018675ec28a8a60d83b378d8c3991faa5a27
Message-Id: <174569846138.4054201.10380850453076813913.pr-tracker-bot@kernel.org>
Date: Sat, 26 Apr 2025 20:14:21 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Yi Lai <yi1.lai@intel.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Ondrej Jirman <megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Apr 2025 14:59:57 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.15-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bc1018675ec28a8a60d83b378d8c3991faa5a27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

