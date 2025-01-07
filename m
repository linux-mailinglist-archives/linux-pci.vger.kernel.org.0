Return-Path: <linux-pci+bounces-19482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3803A04DC4
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 00:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8606D1886D9F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DCD1F76A5;
	Tue,  7 Jan 2025 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNpjLy5L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818D41F669F;
	Tue,  7 Jan 2025 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293532; cv=none; b=X+vejnr8TCZ6nsRnSIpZzNNs+JZ2ntRsmPbGPzM6VeS6ghQ5jZsLlNyL7tUEYky3GAp1obBk6hfpdBR9DgpmUjHtroHcJUGP4YmdB8KKH7nX/Bd7qE6/3BUcMEZijjzqkkxIvrjU+Ncqs80qSQBjYme/QOupP73kezANvV5tznY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293532; c=relaxed/simple;
	bh=KMQZMLPm3P6M6lY0WhBtsN6MdWsf1Oy4QLUIVcWqmQU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AC/v4vygcvCmimhvHdufEgWQpTm9TXGDZoBWF3itt5xxUVlSDtSwrF1HtqD6KVLQHi4vP1NFv6geAULzRQnTRf1tfcjILJEQVwpmUxIbXDOovdYczDPY4HWr20WrmRE4Yg0iTMJ7/rnUv5AAWznpgYVjDoM7DKk/MqVSPZX/RgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNpjLy5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFA5C4CED6;
	Tue,  7 Jan 2025 23:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736293531;
	bh=KMQZMLPm3P6M6lY0WhBtsN6MdWsf1Oy4QLUIVcWqmQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eNpjLy5LIWOqfiaNq+zlY+kKtb0N6c4m1EvBuQkiLg0VyZ6ky/ESQKu92dhbh7FVy
	 m73l76RPio6M4G4HhL7Q/jJj1CJIzCgYoa5mHacksww/VHfbwhrTYTkP84oS0lHMCv
	 90MVLTe843n7qkjt/IoYHPqi4ZnDf81M7BtMQwPEOdiZcTL3SWvgRAHyecaEqaBzpm
	 tWN8OiE30aRtZHhqQqDL6VWw17Q3H+VpNNUVwUsJyV9D6WP7A+StBWDtH9xTPvQDhB
	 BophdfAQUim4sMBpzxvOSFIS3pFX4v6hgLiU5fiMI8n4ZIvzkb7ths/lTIsUdKipTK
	 m4dqF80aXWqiQ==
Date: Tue, 7 Jan 2025 17:45:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
	M Chetan Kumar <m.chetan.kumar@intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: wwan: iosm: Fix hibernation by re-binding the
 driver around it
Message-ID: <20250107234530.GA191158@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ec25117-e0c3-477b-96da-dd2adf870408@gmail.com>

On Wed, Jan 08, 2025 at 01:13:41AM +0200, Sergey Ryazanov wrote:
> On 05.01.2025 19:39, Maciej S. Szmigiero wrote:
> > Currently, the driver is seriously broken with respect to the
> > hibernation (S4): after image restore the device is back into
> > IPC_MEM_EXEC_STAGE_BOOT (which AFAIK means bootloader stage) and needs
> > full re-launch of the rest of its firmware, but the driver restore
> > handler treats the device as merely sleeping and just sends it a
> > wake-up command.
> > 
> > This wake-up command times out but device nodes (/dev/wwan*) remain
> > accessible.
> > However attempting to use them causes the bootloader to crash and
> > enter IPC_MEM_EXEC_STAGE_CD_READY stage (which apparently means "a crash
> > dump is ready").
> > 
> > It seems that the device cannot be re-initialized from this crashed
> > stage without toggling some reset pin (on my test platform that's
> > apparently what the device _RST ACPI method does).
> > 
> > While it would theoretically be possible to rewrite the driver to tear
> > down the whole MUX / IPC layers on hibernation (so the bootloader does
> > not crash from improper access) and then re-launch the device on
> > restore this would require significant refactoring of the driver
> > (believe me, I've tried), since there are quite a few assumptions
> > hard-coded in the driver about the device never being partially
> > de-initialized (like channels other than devlink cannot be closed,
> > for example).
> > Probably this would also need some programming guide for this hardware.
> > 
> > Considering that the driver seems orphaned [1] and other people are
> > hitting this issue too [2] fix it by simply unbinding the PCI driver
> > before hibernation and re-binding it after restore, much like
> > USB_QUIRK_RESET_RESUME does for USB devices that exhibit a similar
> > problem.
> > 
> > Tested on XMM7360 in HP EliteBook 855 G7 both with s2idle (which uses
> > the existing suspend / resume handlers) and S4 (which uses the new code).
> > 
> > [1]: https://lore.kernel.org/all/c248f0b4-2114-4c61-905f-466a786bdebb@leemhuis.info/
> > [2]:
> > https://github.com/xmm7360/xmm7360-pci/issues/211#issuecomment-1804139413
> > 
> > Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> 
> Generally looks good to me. Lets wait for approval from PCI maintainers to
> be sure that there no unexpected side effects.

I have nothing useful to contribute here.  Seems like kind of a mess.
But Intel claims to maintain this, so it would be nice if they would
step up and make this work nicely.

Bjorn

