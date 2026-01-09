Return-Path: <linux-pci+bounces-44392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AEFD0B57D
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 17:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BF973032784
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA1C3659E9;
	Fri,  9 Jan 2026 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWmCyolj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A63D364E9F;
	Fri,  9 Jan 2026 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977015; cv=none; b=LT1YPzWQhwEHbrESlnHWinwErr677ULESlq8n1NLiBhH4phPxyKGsGdHOFd5wHyCuD6RJax0OY0rbLvMWgighEevgV2fCEO/TOj/yfskRk3iHGMsvnrnYHrqhBtcM9cmZEWM22yknUuBeZ7alqK76qudmHYFvLrLMYoKrq1UIdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977015; c=relaxed/simple;
	bh=7jfMIyKudt/LZqHU0YW2bIFtiv1WkFGllHqnla7fNjY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NdA9hVxc+xN/MhCAP0Jqq/niu8Ux51OLDL2ubmSvBYAUutT/auNDZ9B2G/e9aAXoQTNKNol6p/WNaety/tbV2GCHNCDSo93/23QDmMbqhwyMaVD+50ahb0xIYqu+rIOhuUdMYJ5pLua8VLVl1nl7ktzr6dXsdTEHPbrTqniP870=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWmCyolj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201DDC19422;
	Fri,  9 Jan 2026 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767977015;
	bh=7jfMIyKudt/LZqHU0YW2bIFtiv1WkFGllHqnla7fNjY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cWmCyoljgINDP8bmNc2JdwNEJEiep6s0HVXOZrcq3j+pXn8jy7IqBpl/XwbIYjmc/
	 ACqfLIy7aLnRxDo+HvEQbS/d371r9ov3PoWuBDfesam67e857bv68MMSNFq42zy348
	 534EFleoNFD4Gd/+6XCBGouLl7PepmPobijZDZk60nDLXVt0nRoGH27utELHJT4ncM
	 QTlJqMVUY0LOOnQkCst5YKWdm4SVrSlYdQp9LzdHFdpbAEUlB/dDYJgb/DPTxHReLS
	 DtJykT5BGJpIcfXf5wEzn8v2J/7CzNWBtM4MiuazB8tghptfFicnrm+NZ93gfzZTeK
	 jSwyUcw5W2juA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B7F03AA9A96;
	Fri,  9 Jan 2026 16:40:12 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260109162050.GA548294@bhelgaas>
References: <20260109162050.GA548294@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260109162050.GA548294@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.19-fixes-2
X-PR-Tracked-Commit-Id: bdb32359eab94013e80cf7e3d40a3fd4972da93a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d6fe1dd12a77c7774a3210f8450bdad2f84d879
Message-Id: <176797681087.322717.6531368584511389899.pr-tracker-bot@kernel.org>
Date: Fri, 09 Jan 2026 16:40:10 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Nathaniel Roach <nroach44@gmail.com>, "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, Linnaea Lavia <linnaea-von-lavia@live.com>, Neil Armstrong <neil.armstrong@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 Jan 2026 10:20:50 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.19-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d6fe1dd12a77c7774a3210f8450bdad2f84d879

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

