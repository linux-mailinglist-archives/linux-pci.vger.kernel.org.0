Return-Path: <linux-pci+bounces-10313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCF2931B97
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 22:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796431C20E88
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 20:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9621D13D50B;
	Mon, 15 Jul 2024 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGTdthzy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16A13D28C;
	Mon, 15 Jul 2024 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074236; cv=none; b=Vh3WEMnuMUowPOFaDZB3vr2tESrspmu3TDdpjqul3MV9gyenuCCEU62y6VwSHokXf3wNq21pDsKtQHekQMRu/xohlOm0hcmVg0tS6maIyg5vLLg8UEKMbrqgjgl0kbugxUNCspL18CJTcx8u7NxbgrbVG9sANv9PuACPlXcdtVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074236; c=relaxed/simple;
	bh=vzj1dZm7eDFyjCwERJESfdTzNBF2RyuWMQKLsjqTcK0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qSWlkpd7Y+1TjVgs0jiOVsohGp8qDJR7eTNtmNfUhUnwiANbVQca0VFb1Lj6SbB/bFvnUio5Lcu7o4/LMBwbFEZxqxLM66QlyUEuuL8LsDgyi+r2Ka3wxGq0Xw86dDRqca/94FZ3iib0Kjx2/oGetg7c4H+66gC2idgVEgAo3Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGTdthzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E848AC4AF0A;
	Mon, 15 Jul 2024 20:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721074236;
	bh=vzj1dZm7eDFyjCwERJESfdTzNBF2RyuWMQKLsjqTcK0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hGTdthzyVissZlrRy/9fCkM9W4jkT2u3kKRuexDIaHJ6mkOTkyPiG1hyJCi0FWeMa
	 eXOk6lzroQXVeAU/PCw2SQym9d20/qs7tqmsAB8U7lSLPTn057qHkQR05cEwHpJy9P
	 MQDmRajpVUIeKYjhMyz47DBfx157hUnkds11jGy325inv50/IpriHJ83fJgZRpz0jH
	 9WK1xBfFjDuQTkYrcJP6Mn69IN3sp0Ll/rCXPhhpXi20GdDs1oUaJz3iPubLVmagdg
	 4QJPavSS1alXAb+13miTOMCEg4JoCkFX0iVlzwK36e6A9pGsFjp9yMvITtQEYWIOuz
	 L495J4whigC3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D325FC4332E;
	Mon, 15 Jul 2024 20:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v5 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172107423586.20270.6352541411898717585.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 20:10:35 +0000
References: <172079913640.1778861.11459276843992867323.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: <172079913640.1778861.11459276843992867323.stgit@ahduyck-xeon-server.home.arpa>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
 alexanderduyck@fb.com, andrew@lunn.ch, sanmanpradhan@meta.com,
 linux@armlinux.org.uk, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jul 2024 08:49:08 -0700 you wrote:
> This patch set includes the necessary patches to enable basic Tx and Rx
> over the Meta Platforms Host Network Interface. To do this we introduce a
> new driver and driver directories in the form of
> "drivers/net/ethernet/meta/fbnic".
> 
> The NIC itself is fairly simplistic. As far as speeds we support 25Gb,
> 50Gb, and 100Gb and we are mostly focused on speeds and feeds. As far as
> future patch sets we will be supporting the basic Rx/Tx offloads such as
> header/payload data split, TSO, checksum, and timestamp offloads. We have
> access to the MAC and PCS from the NIC, however the PHY and QSFP are hidden
> behind a FW layer as it is shared between 4 slices and the BMC.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/15] PCI: Add Meta Platforms vendor ID
    https://git.kernel.org/netdev/net-next/c/c5eaf1b3f824
  - [net-next,v5,02/15] eth: fbnic: Add scaffolding for Meta's NIC driver
    https://git.kernel.org/netdev/net-next/c/546dd90be979
  - [net-next,v5,03/15] eth: fbnic: Allocate core device specific structures and devlink interface
    https://git.kernel.org/netdev/net-next/c/1a9d48892ea5
  - [net-next,v5,04/15] eth: fbnic: Add register init to set PCIe/Ethernet device config
    https://git.kernel.org/netdev/net-next/c/3646153161f1
  - [net-next,v5,05/15] eth: fbnic: Add message parsing for FW messages
    https://git.kernel.org/netdev/net-next/c/c6203e678cc9
  - [net-next,v5,06/15] eth: fbnic: Add FW communication mechanism
    https://git.kernel.org/netdev/net-next/c/da3cde08209e
  - [net-next,v5,07/15] eth: fbnic: Allocate a netdevice and napi vectors with queues
    https://git.kernel.org/netdev/net-next/c/bc6107771bb4
  - [net-next,v5,08/15] eth: fbnic: Implement Tx queue alloc/start/stop/free
    https://git.kernel.org/netdev/net-next/c/40bf06a160a1
  - [net-next,v5,09/15] eth: fbnic: Implement Rx queue alloc/start/stop/free
    https://git.kernel.org/netdev/net-next/c/0cb4c0a13723
  - [net-next,v5,10/15] eth: fbnic: Add initial messaging to notify FW of our presence
    https://git.kernel.org/netdev/net-next/c/20d2e88cc746
  - [net-next,v5,11/15] eth: fbnic: Add link detection
    https://git.kernel.org/netdev/net-next/c/69684376eed5
  - [net-next,v5,12/15] eth: fbnic: Add basic Tx handling
    https://git.kernel.org/netdev/net-next/c/9a57bacd574b
  - [net-next,v5,13/15] eth: fbnic: Add basic Rx handling
    https://git.kernel.org/netdev/net-next/c/a29b8eb6e533
  - [net-next,v5,14/15] eth: fbnic: Add L2 address programming
    https://git.kernel.org/netdev/net-next/c/eb690ef8d1c2
  - [net-next,v5,15/15] eth: fbnic: Write the TCAM tables used for RSS control and Rx to host
    https://git.kernel.org/netdev/net-next/c/355440a6981a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



