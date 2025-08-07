Return-Path: <linux-pci+bounces-33531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5C7B1D43B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 10:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8D567B1C1D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 08:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1FC2222D6;
	Thu,  7 Aug 2025 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSJkgmwG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1553B1B7F4;
	Thu,  7 Aug 2025 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754555040; cv=none; b=gHwR+HedbCQ3SzveSPAygEZg+suQDaXwLy8LVSgjb28f3Tj2uDpAvLPCy41xPxsPhC1gLi6UW8GVqTw3LyDbzuqi/YsEq1zyXLICLiExMS+zZ1T7ti0lCmf1TiudxAvHrOdIQ4t38UBAgiauhak/kwhPpOVPGpTbpvQgKSicuY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754555040; c=relaxed/simple;
	bh=0NJziiGdCrPe6ikKhGXkqWzuF7OOp0aWP72QcSrY1sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMGb9nSUVqwsWhcry5GkZGb3WF1Wsg0MNCaYV6U12FdYU+NFvQCSj9pDuz+grNYYJCKnblVKBkDu1XDoQfV56mk3++OLoNuB8cssCLM7pAuwnW9jxL66uTI5EgUq5PnU0gL2I7X1A9CSfiJGclhzXEeAFHXt8Oq2Yy+bR4IrSpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSJkgmwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB81C4CEEB;
	Thu,  7 Aug 2025 08:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754555039;
	bh=0NJziiGdCrPe6ikKhGXkqWzuF7OOp0aWP72QcSrY1sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSJkgmwGR2vsL1LzbGcKaHmFg8JyJ3j/w5LgPkpCCIirdIU0F465cq4NJk3fvWscl
	 OcRP5/byezip2uwstA0ur+eZ7TnZlW3jviU0hHHu2+xF9tLZu+ZjP1A10qkSWcxwCf
	 s/C6OvTb4xBqhf3H4dj2xLgnpV4YpDUT0YRX3kIxMbG8flF6N3xMhZyqCqeB9XHRrO
	 bxRJSHmxvaACBOm2SmxvVFj1T9NryskWtQo9thWeOaPPCPdyxqBgMnIuRvWlm94Fk9
	 NRLxQyj5ADu6YtcCRxvQFsThn2GQnLhj6zGAu89oXTiLBAv11PIE+hcyONe9FLedtr
	 A8pPLeB+S+m0g==
Date: Thu, 7 Aug 2025 13:53:53 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: Packet loss with QCA9377 (ath10k) on ASUS VivoBook E410KA
Message-ID: <l3iebypcyxpqxod5os3mn6465cwdlbnmlkbjnx3vu5bzyb4vhl@3dxnam2a7c2t>
References: <20250806204018.GA14933@bhelgaas>
 <BBAB0136-BB7C-4D59-B29D-2F35FC29D7AC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BBAB0136-BB7C-4D59-B29D-2F35FC29D7AC@gmail.com>

On Thu, Aug 07, 2025 at 11:33:08AM GMT, Bandhan Pramanik wrote:
> I'll tell the guy to clone the ath-next branch then and will inform you pretty soon.

The patches are not in ath-next. You need to manually pick them up from mailing
list.

But even if it doesn't help, try to disable ASPM using cmdline by passing
'pcie_aspm=off'.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

