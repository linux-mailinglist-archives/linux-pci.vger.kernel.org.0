Return-Path: <linux-pci+bounces-38873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39D9BF5EF8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 13:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B0D18C7ED6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 11:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45D82E6CBE;
	Tue, 21 Oct 2025 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyWnWQLm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6EC280CE5
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044543; cv=none; b=p0IX/HCNEzDORtrpGzz6YOcfhB3JG8u+MMx4dXwic4lnSl1jgTBA5WOg+b5CIqUI2k0AqlPqZgjJcD6AR5qGfioCeUS7vfHblgBgrOfLkTQeep1cuSii8F16PhAWoM1q6Rv7uM7Y3WTEcvH5fDrcPmEzh6pg4J9yD8EiGooUL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044543; c=relaxed/simple;
	bh=fGuJO/oCH0UaZiLZGDBuwIIRNqetEE6lB+0vfgiklFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMHLVjjqA2y8LgezIxCLaoGsrzMTb8/FmZCnWZLoCYf8pvDksNhdrsW6dSSF7SAWx3nV6f9y0AXYQVfnnk9DAsfnrXyMD7r26gRKknlAH4vokIyHoDGxVcer0v4Sy2CUL6S16kdsIyp62dvvzsQRGJdAhc1D4Ne4FDAIuUBgtBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyWnWQLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6DAC4CEF1;
	Tue, 21 Oct 2025 11:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761044543;
	bh=fGuJO/oCH0UaZiLZGDBuwIIRNqetEE6lB+0vfgiklFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PyWnWQLm33SXnzzJWQ6YwLRa6RGD6qdXuS7PybHYHip5ywjwGOCJpvBG6JXxroKTX
	 /NpW24PuqI74lqh29nh2jXknlhOq/keeVZDIw9gRFRIjrqWMz5AoWulsrDjmSCYgZJ
	 curNQ4bXYh+gaeGlKFwIYIC3egNQYccfc70d19xXal8FIpQaO05BP5sU9CuIv2pO6Y
	 SjymRMbL0+MeuhjlzIEebkRypd6D54iZzu9e3QU896AiZLikHKTBSdtUgdwsdbrtX0
	 41ZlBw552T9CyGiwa9LV6o8HRGk1WiUPzy6wSxBYBTwKOcA/nD8ZoKwNYv6JugpYdC
	 Nzxp9d5ScQZiQ==
Date: Tue, 21 Oct 2025 16:32:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: ROCK 5B/5B+ RTL8852BE probe failure on v6.18-rc
Message-ID: <dgn3ekyon6jwfinerxx2ohpvebnxvuvpyqratfc3ciys4l4et7@5un6wskt4xn3>
References: <7755D0222F97F8A4+6c855efa-561f-4fd9-aadd-a4de3d244c7e@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7755D0222F97F8A4+6c855efa-561f-4fd9-aadd-a4de3d244c7e@radxa.com>

On Tue, Oct 21, 2025 at 07:12:21PM +0900, FUKAUMI Naoki wrote:
> Hi,
> 
> I've observed an issue where the RTL8852BE fails to probe on the ROCK 5B and
> ROCK 5B+ using Linux v6.18-rc.
> 
> [    7.719288] rtw89_8852be 0002:21:00.0: loaded firmware
> rtw89/rtw8852b_fw-1.bin
> [    7.720192] rtw89_8852be 0002:21:00.0: enabling device (0000 -> 0003)
> [    7.728596] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.5
> (da87cccd), cmd version 0, type 5
> [    7.729407] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.5
> (da87cccd), cmd version 0, type 3
> [   11.420623] rtw89_8852be 0002:21:00.0: failed to dump efuse physical map
> [   11.422859] rtw89_8852be 0002:21:00.0: failed to setup chip information
> [   11.425273] rtw89_8852be 0002:21:00.0: probe with driver rtw89_8852be
> failed with error -16
> 
> This issue does not reproduce on v6.16. The issue does not reproduce with
> the MT7921E or the AX210. Furthermore, the issue does not reproduce on the
> ROCK 5A or the ROCK 5 ITX+.
> 
> The issue appears not to reproduce in or prior to commit 14bed9bc81ba. The
> issue reproduces, albeit with a low incidence rate, after commit
> bf76f23aa1c1.

Both of these commits are merge commits and they seem to be not related to PCI
or WiFi.

> It reproduces, but not 100%, on v6.17, and is likely 100%
> reproducible on v6.18-rc.
> 
> The dmesg output and the result of lspci -vv when the issue occurs can be
> found below:
>  https://gist.github.com/RadxaNaoki/bf57b6d3d88c1e4310a23247e7bac9de
> 
> What should I investigate next?
> 

So the patch from Niklas [1] didn't solve the issue on these board + WiFi chip
combo?

- Mani

[1] https://lore.kernel.org/linux-pci/20251017163252.598812-2-cassel@kernel.org/

-- 
மணிவண்ணன் சதாசிவம்

