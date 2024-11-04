Return-Path: <linux-pci+bounces-15934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55F79BB0AA
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 11:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20616B23D66
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 10:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56171AF4EF;
	Mon,  4 Nov 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnyjXEyt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749A51AF0DC;
	Mon,  4 Nov 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715021; cv=none; b=ZKRIC2uIUivd8c4DnvvkCE90lUYOG/DqIxSnRaKzZ+8rfBOd8pJwU6qWwhoSdh+ccNEkybrmNYS/VHRekicExhTjkdZFsPvtnXlMXFOb3C4nEKwcC7e72fwhlXmlGP+6XMPJWRhjERyBpWr3trl7wscLZIIo67KAVer2QQhiGcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715021; c=relaxed/simple;
	bh=6ml2BT2raqF8G8x+buM0eWiADTiQBARWLyqnb/h1l28=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EuwFiSOnN85sye116QaX0287SVGFNSW72ry4WqvYCJ1J35Mnt8zuuxMMXGrLovS9qY34pGpq8b7gHGuxqwzEljLyPmS4sE0N18XY4Oleg46GYFCIvnw6yO/Lai2Xurov1hNo1bv9x1KW7+BgimpzJaaK6rm4fHxiB5wVSiU4i+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnyjXEyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E603FC4CECE;
	Mon,  4 Nov 2024 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730715021;
	bh=6ml2BT2raqF8G8x+buM0eWiADTiQBARWLyqnb/h1l28=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jnyjXEytSg4Dm0xzK4vuTLgkBxwZ/GX7mBQWaqRAntPAIU1v59qxD3oNhcM18YxMX
	 r546u+w39gMnchf3pd1bD9X3zBzJKFO6DJnRj2Cx2KF7afLAlpWhGXhJjQ6ZevXFQ7
	 q/h6iJTvDEcTw7VqawGHV4R5zuTQ9XoHe3TU5Kk2OAToHLmkLGpAHM8lQZdthSO6Gy
	 ZEVU61Xgq1630a9a1eFAaG/3Y5ASwCNWo9rnrzL9QsKiYWByPwoXLFqBQOMi/EXnCP
	 viQ3Ar0siICl5XbP7Y/S+GmsLhT0cZHUbz0gdoiphvkwAGRAgrTvMLaOA05AxcCeni
	 Oh3+bqznOu8nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF403805CC0;
	Mon,  4 Nov 2024 10:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 net-next 00/12] add basic support for i.MX95 NETC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173071502951.4013812.6348392511340491502.git-patchwork-notify@kernel.org>
Date: Mon, 04 Nov 2024 10:10:29 +0000
References: <20241030093924.1251343-1-wei.fang@nxp.com>
In-Reply-To: <20241030093924.1251343-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 vladimir.oltean@nxp.com, claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
 Frank.Li@nxp.com, christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
 horms@kernel.org, imx@lists.linux.dev, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, alexander.stein@ew.tq-group.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 30 Oct 2024 17:39:11 +0800 you wrote:
> This is first time that the NETC IP is applied on i.MX MPU platform.
> Its revision has been upgraded to 4.1, which is very different from
> the NETC of LS1028A (its revision is 1.0). Therefore, some existing
> drivers of NETC devices in the Linux kernel are not compatible with
> the current hardware. For example, the fsl-enetc driver is used to
> drive the ENETC PF of LS1028A, but for i.MX95 ENETC PF, its registers
> and tables configuration are very different from those of LS1028A,
> and only the station interface (SI) part remains basically the same.
> For the SI part, Vladimir has separated the fsl-enetc-core driver, so
> we can reuse this driver on i.MX95. However, for other parts of PF,
> the fsl-enetc driver cannot be reused, so the nxp-enetc4 driver is
> added to support revision 4.1 and later.
> 
> [...]

Here is the summary with links:
  - [v6,net-next,01/12] dt-bindings: net: add compatible string for i.MX95 EMDIO
    https://git.kernel.org/netdev/net-next/c/da98dbbc2c74
  - [v6,net-next,02/12] dt-bindings: net: add i.MX95 ENETC support
    https://git.kernel.org/netdev/net-next/c/db2fb74c8560
  - [v6,net-next,03/12] dt-bindings: net: add bindings for NETC blocks control
    https://git.kernel.org/netdev/net-next/c/f70384e53b09
  - [v6,net-next,04/12] net: enetc: add initial netc-blk-ctrl driver support
    https://git.kernel.org/netdev/net-next/c/fe5ba6bf91b3
  - [v6,net-next,05/12] net: enetc: extract common ENETC PF parts for LS1028A and i.MX95 platforms
    https://git.kernel.org/netdev/net-next/c/80c8c852615e
  - [v6,net-next,06/12] net: enetc: build enetc_pf_common.c as a separate module
    https://git.kernel.org/netdev/net-next/c/3774409fd4c6
  - [v6,net-next,07/12] net: enetc: remove ERR050089 workaround for i.MX95
    https://git.kernel.org/netdev/net-next/c/86831a3f4cd4
  - [v6,net-next,08/12] net: enetc: add i.MX95 EMDIO support
    https://git.kernel.org/netdev/net-next/c/a52201fb9caa
  - [v6,net-next,09/12] net: enetc: extract enetc_int_vector_init/destroy() from enetc_alloc_msix()
    https://git.kernel.org/netdev/net-next/c/b4bfd0a904e9
  - [v6,net-next,10/12] net: enetc: optimize the allocation of tx_bdr
    https://git.kernel.org/netdev/net-next/c/9e7f2116199d
  - [v6,net-next,11/12] net: enetc: add preliminary support for i.MX95 ENETC PF
    https://git.kernel.org/netdev/net-next/c/99100d0d9922
  - [v6,net-next,12/12] MAINTAINERS: update ENETC driver files and maintainers
    https://git.kernel.org/netdev/net-next/c/f488649e40f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



