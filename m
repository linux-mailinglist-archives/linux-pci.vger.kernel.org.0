Return-Path: <linux-pci+bounces-38629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CEEBEDA2C
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 21:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97B2B34A772
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 19:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D437280CE5;
	Sat, 18 Oct 2025 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSeTxti3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2130827FB1E;
	Sat, 18 Oct 2025 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815420; cv=none; b=pUZkKEblVSz9k0hK08MRzW7/kK7Oh1ROkV5+gFe7UZeDMgPvNvxsXRFD/ykb8c5srOLtcCFDMH4Y32zpIUglaxDRD4YI3hlcITqxTnuQn4ehkNeiRWdMVbwEAjF9o6nBIP/TOkDsvcex4DdJFtr0EcxmXsU7IQw3RCtpAI0Oeuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815420; c=relaxed/simple;
	bh=VF/EbsDCqwtMdwNPnKEv9Lk8Ut5LI3ZvijyCg0oo7Bw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZYVtLGM3bWi7QB2WVoY+qenCsHgPxlTE5X26jj8PqhBD9TbNMUwSwZVEzqjgpxBNUkjgM3XnEw5w9AHAvzchN216/lgcpasxvCAuxbbskElYohPuLSqxDfDZwhKjrG1DNvz+fAzQFQHyV4F9dfQGZ5dDBbn3BPo83nVVNf2KF/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSeTxti3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA948C4CEF8;
	Sat, 18 Oct 2025 19:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760815420;
	bh=VF/EbsDCqwtMdwNPnKEv9Lk8Ut5LI3ZvijyCg0oo7Bw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VSeTxti3+EA75XU7Aax5GGnaL1Im/iDJo0AQ6szpI+Tku9TyExruYSCTFHo3L1Jd1
	 rEg8q7W92kEwkdSA/ABts35dbeIVA8M3DZbA+k84N53UbCqJLN7T7Dzl6GgBXA7wBg
	 ifduDcN9IBSuCDwJ5vJhXhGwhW3+BrqBnyBjpkPXKC73ZG6OvlLNK9QWvaVc33jUlz
	 B1THCDZ92dqLMArDLbjSu7ELhP4L0cd0U0TozuI7gsZ5VwcTx4O9hhTdnU6x2ozpYK
	 4rFDAOjEvIWuSlBZSzs2gRVMAS0mrLhFy3BP/6kFmLUSgB8ZNns4yMWZQxW7OoiABg
	 eD2Q16LLp+N+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3422439EFBBA;
	Sat, 18 Oct 2025 19:23:24 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251017171810.GA1035665@bhelgaas>
References: <20251017171810.GA1035665@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251017171810.GA1035665@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-fixes-2
X-PR-Tracked-Commit-Id: a78835b86a4414230e4cf9a9f16d22302cdb8388
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e67bb0da332c6058b29a9c46cc4035647d049a0c
Message-Id: <176081540276.3081941.11954692418093019502.pr-tracker-bot@kernel.org>
Date: Sat, 18 Oct 2025 19:23:22 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Hans Zhang <18255117159@163.com>, Sasha Levin <sashal@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Val Packett <val@packett.cool>, Guenter Roeck <linux@roeck-us.net>, Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Kenneth Crudup <kenny@panix.com>, Genes Lists <lists@sapience.com>, Todd Brandt <todd.e.brandt@intel.com>, Oliver Hartkopp <socketcan@hartkopp.net>, =?utf-8?B?SGVydsOp?= <herve@dxcv.net>, Mario Limonciello <superm1@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick <jonathan.derrick@linux.dev>, Chen Wang <unicorn_wang@outlook.com>, Yixun Lan <dlan@gentoo.org>, 
 Longbin Li <looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Oct 2025 12:18:10 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e67bb0da332c6058b29a9c46cc4035647d049a0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

