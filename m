Return-Path: <linux-pci+bounces-40520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C84C3BE5C
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 15:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D970C18842D7
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 14:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53054333452;
	Thu,  6 Nov 2025 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbYMZiPn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC4302168;
	Thu,  6 Nov 2025 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440634; cv=none; b=ENHpxsfAfsyOYxVPVlbsPFwkPOlWDexiDaKVbZIrO+s3ytQ6XTG5cU9soAgEHdKGSnLVNMR4/pCiTvMLenJ18QUFlhK2IYa7T6NtWbGbL8YD1jrVoNFfvAZrv28b2qnjPrmIeXUEi4DCzjXNBINgzQtC1oRtoOzXUQgXY13jv+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440634; c=relaxed/simple;
	bh=IjfgKW6hIskaV2eVOm6wXI9OOZsxDWXoktOpm7F/9Hk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SWrh/8Ip8n+PIveKun0K8+t27QotDSeLkypdsIgTfNEGBhjS6a26Qf4+OUVD8kWsilFxCRlheGJ1i7baO/TA7RnoLRxkUo8hSjXpMRiP7kOrARHuLolmpLoghlW9lfdHIWh5hLrwxCsXy0EWu11aaeW+/DNZmyaxIvGiqmtxN6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbYMZiPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0A3C4CEF7;
	Thu,  6 Nov 2025 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762440633;
	bh=IjfgKW6hIskaV2eVOm6wXI9OOZsxDWXoktOpm7F/9Hk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QbYMZiPnHKKy8pG++J/HHezQOzo/tEPG+udxV9FSA7ilyjLyGeHWF05TKl3wk2ljt
	 3W57oZr7xhvuT3jy3NN3xAdiUqcDLD29IiMofe9Y5UhZpX2gyQVyVSPuzztFQuq8yP
	 J+56NW1qASG7fgtt/5NG27qaFGKpyIud4Xyu3/gKSPTl5y8dctEA4+ltGItYYTLyS0
	 OZEqoz/cDzQYRc0/gFaUU7rVFoYb2zAtcWOfhFNYBdfW2Xgi+TdhTICdypGU3NUQNA
	 80hYO20BPAF0KglW5TKpNE3ahsI/kyY2u471fRQ+zyJIRfQcORtd6rkJfdIo+Titog
	 AvEDIFgnoPlag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1AD39EF945;
	Thu,  6 Nov 2025 14:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] idpf: add support for IDPF PCI programming
 interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176244060675.238839.11553624450020733973.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 14:50:06 +0000
References: <20251103224631.595527-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20251103224631.595527-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 madhu.chittim@intel.com, aleksander.lobakin@intel.com, horms@kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org, sridhar.samudrala@intel.com,
 aleksandr.loktionov@intel.com, marek.landowski@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  3 Nov 2025 14:46:30 -0800 you wrote:
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> 
> At present IDPF supports only 0x1452 and 0x145C as PF and VF device IDs
> on our current generation hardware. Future hardware exposes a new set of
> device IDs for each generation. To avoid adding a new device ID for each
> generation and to make the driver forward and backward compatible,
> make use of the IDPF PCI programming interface to load the driver.
> 
> [...]

Here is the summary with links:
  - [net-next] idpf: add support for IDPF PCI programming interface
    https://git.kernel.org/netdev/net-next/c/13068e9d5726

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



