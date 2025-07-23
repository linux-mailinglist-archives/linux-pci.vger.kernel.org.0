Return-Path: <linux-pci+bounces-32841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51482B0FAE3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 21:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E770172F03
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 19:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBF121D5AA;
	Wed, 23 Jul 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ac2zTObQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D51212D83;
	Wed, 23 Jul 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753298392; cv=none; b=bRIuNIUNw0a+8cCGwKrJ4Mq+SjbiIntakp++eIowNCtdOGvpboXBi1FFK0XHA32+y7vZ7czDQTtg1ErjoaZZZa/nWsWYQ0S8a59Wz2u3D4EG8ziAAMomObbvzbJnqPf0hlogW0RJVF9Di3SLnCDsmCRRYs8fpnyCM4vGFN3MMt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753298392; c=relaxed/simple;
	bh=cUaSAYeHdcNGsrMpWlR6qhxhfc84BEITWcbVNplIDwE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pgN7pjRvMfS406LUR3tAZUHkZYP70PbtAAZoTWyud6QPXlZM8+kvur8syVIrU1w7zPVtxCbWtsDFNQDnmkg0ni6/holZaw2f4XoLPAuMTLneFXpvWqCjRJkMbI6hrO9eUsIKfEoRqSIEAaRVbRq2FAqkv6NX1jZfsjj/4s0pNrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ac2zTObQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51880C4CEE7;
	Wed, 23 Jul 2025 19:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753298392;
	bh=cUaSAYeHdcNGsrMpWlR6qhxhfc84BEITWcbVNplIDwE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ac2zTObQTOjENmLDo3bR4NK4AZCyblFOG9vdkLQD+kGO/9gNqMSQi4QbX4e/aIFnD
	 aK/rDIbuTTqRcsPl7K93c7d8NuKlWAshoLp+fcaSvpmtTMsyhxafXV5D0cIZySQa1t
	 zDLQxSh8FIyU4DiqC1v7h23+xIhJ1taQ1T/1VPr6WYZhd+OOJk9/sYk1fsW9ITyeJj
	 7ARqkurQiDtUSwAZylbWic3ZIYVpYq/8SkiBc8oZ2otiQPvtxTftUwmze4TPt0Hu29
	 30GK0md5Z+n1LiHRGbkkeIwbEME5MPOrkUJ3eF+rguNIYgaearmpsZjiB/cKjWogJz
	 mfL7ThU+oFPcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD9F383BF4E;
	Wed, 23 Jul 2025 19:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] Bluetooth: btintel_pcie: Add support for _suspend() /
 _resume()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175329841021.1725551.13603504074353509526.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 19:20:10 +0000
References: <20250723135715.1302241-1-kiran.k@intel.com>
In-Reply-To: <20250723135715.1302241-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, chandrashekar.devegowda@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Jul 2025 19:27:15 +0530 you wrote:
> From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> 
> This patch implements _suspend() and _resume() functions for the
> Bluetooth controller. When the system enters a suspended state, the
> driver notifies the controller to perform necessary housekeeping tasks
> by writing to the sleep control register and waits for an alive
> interrupt. The firmware raises the alive interrupt when it has
> transitioned to the D3 state. The same flow occurs when the system
> resumes.
> 
> [...]

Here is the summary with links:
  - [v5] Bluetooth: btintel_pcie: Add support for _suspend() / _resume()
    https://git.kernel.org/bluetooth/bluetooth-next/c/33bb9b1ce6f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



