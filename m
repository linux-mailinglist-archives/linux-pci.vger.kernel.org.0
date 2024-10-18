Return-Path: <linux-pci+bounces-14848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB8D9A377B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 09:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6B71C21134
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 07:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C471442F4;
	Fri, 18 Oct 2024 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="COni5Iuk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A4015FA92;
	Fri, 18 Oct 2024 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237427; cv=none; b=qCgvz09O9KYHSOj2Mts7r6I23mZd4qQvw3/bitLVfjO2FckNhPh5774vyGiY0yP6mOYycRP10Dxi41JqGJoG6s4WoMzb66ry2DFalJqj35qCsvInPEQ0b20093Jbmop5AoQeP+B9wQTBNUqAN/DiwG+Sh7ukRDaDKunEssyyZI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237427; c=relaxed/simple;
	bh=uM/2PDd4kNl7hblbHTyq8FHJCJxSqUuG32vzeousUos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGMMAmnIF9NnIrllXU8gRRa1CZqs7bXu+0e4e49TewexkK/mEWH6IrHYU+jvIe27hvPn+6XwgIpHbBP4sYBA4TUAtRR1NYgJoV0qmQ6edrcB9wQllPUBGOWc0HscIrgxlAgr8jTSIEedQ428MP4eCbHUgfBlRGgGVe88E5ovQKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=COni5Iuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E942BC4CEC3;
	Fri, 18 Oct 2024 07:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729237426;
	bh=uM/2PDd4kNl7hblbHTyq8FHJCJxSqUuG32vzeousUos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=COni5IukMuMu9FUzLNOf1s5WUs6rxuMVFEl6t9y0LQBGiJfXuratg6ZUq42pulmpA
	 vgFrqYeW4ZugbMXV80WKH8dwCtsC1+nKGIk3eNzmXveT3KW2RTH/BkcGN7Rs7p08Dl
	 wYU8Kootz7eBTRc1yWhALKm7koiUZEFXbNkjjkxw=
Date: Fri, 18 Oct 2024 09:43:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	SiyuLi <siyuli@glenfly.com>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 4.19/5.4] PCI: Add function 0 DMA alias quirk for Glenfly
 Arise chip
Message-ID: <2024101830-ecosystem-treachery-773e@gregkh>
References: <B7F5C8CEDD17AEFB+20241018073750.48527-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B7F5C8CEDD17AEFB+20241018073750.48527-1-wangyuli@uniontech.com>

On Fri, Oct 18, 2024 at 03:37:49PM +0800, WangYuli wrote:
> [ Upstream commit 9246b487ab3c3b5993aae7552b7a4c541cc14a49 ]
> 
> Add DMA support for audio function of Glenfly Arise chip, which uses
> Requester ID of function 0.
> 
> Link: https://lore.kernel.org/r/CA2BBD087345B6D1+20240823095708.3237375-1-wangyuli@uniontech.com
> Signed-off-by: SiyuLi <siyuli@glenfly.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> [bhelgaas: lower-case hex to match local code, drop unused Device IDs]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/pci/quirks.c    | 4 ++++
>  include/linux/pci_ids.h | 2 ++
>  2 files changed, 6 insertions(+)

Now queued up, thanks.

greg k-h

