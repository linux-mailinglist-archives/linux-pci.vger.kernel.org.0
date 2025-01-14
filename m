Return-Path: <linux-pci+bounces-19783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CBBA11450
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CEC37A254C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 22:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8E72135D8;
	Tue, 14 Jan 2025 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMhqJwjG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126FF2139B0;
	Tue, 14 Jan 2025 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894702; cv=none; b=jfcuayO8Sv3O3pbmmpcaT2LwALhncBjzqEx4lRXXNRzB+Pdk4utVO/qitO5WKm7tgkTg6WQSBzSLmBa2VQY8jXInr436FXgqA6U4UbyLtjfJoq69xQEsq2khuch5BSkb+mKTFonRTWBTDw0ui0Yp+h6WEowWvB2+k6OgzxQ4oP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894702; c=relaxed/simple;
	bh=Hrt4BL99ILfWN627u7gCX5yOkOFD285kjWcZ2jYKyOM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=S4CXWidgycilhLaSRtUnfwV9Hst0mXOoRPOlqC8WR+0gd7NmKtdSlAq9ttMZgmbqZmiOyWU8PJMmc7SF135JPeCKQnh7vazvojZNmJiwibbU0O3ame9jJ/Kixq5Z/5qeATGyrJtt/6FSzrPHuYiwML1eBUoSBz2NqaCJyaMLX8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMhqJwjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4E0C4CEDD;
	Tue, 14 Jan 2025 22:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736894701;
	bh=Hrt4BL99ILfWN627u7gCX5yOkOFD285kjWcZ2jYKyOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LMhqJwjGUSthS74VjyvCKt5jHWjTIOjhOITjZxmcKqmZoMWMVKdoqDyE/YyjHbbeI
	 GOONoN4+V4mXSJE6GxI9dIQMXiJaZqejtrLWdemeI21sdkEQ7L/AGsNk9app3XpE7R
	 YroMen2o4Ji26iH6AJzl4vHdpmsQ2Ssfzvetkl3ngXnGjU7a/5O6N9ZOBxcogOEjEO
	 /K40M+FcGbmSDWdGbPCQzP1GYYwpuLzvcOQehe03PDiTocQqTcvRk9CKL0KMwWF+GB
	 jITUiHexiWwd4Q6A+JA+fHc7Zdo4KJfotARioPHfhvJjPj7pQ9xZDWR1ibniHWoxkA
	 Vajw6jJ4zd4eA==
Date: Tue, 14 Jan 2025 16:45:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Yet another quirk for PIO log size on Intel
 Raptor Lake-P
Message-ID: <20250114224500.GA496098@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102164315.7562-1-tiwai@suse.de>

On Thu, Jan 02, 2025 at 05:43:13PM +0100, Takashi Iwai wrote:
> There is yet another PCI entry for Intel Raptor Lake-P that shows the
>   error "DPC: RP PIO log size 0 is invalid":
>   0000:00:07.0 PCI bridge [0604]: Intel Corporation Raptor Lake-P Thunderbolt 4 PCI Express Root Port #0 [8086:a76e]
>   0000:00:07.2 PCI bridge [0604]: Intel Corporation Raptor Lake-P Thunderbolt 4 PCI Express Root Port #2 [8086:a72f]
> 
> Add the corresponding quirk entry for 8086:a72f.
> 
> Note that the one for 8086:a76e has been already added by the commit
> 627c6db20703 ("PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root
> Ports").
> 
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1234623
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Applied to pci/dpc for v6.14, thanks!

> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 76f4df75b08a..4ed3704ce92e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6253,6 +6253,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2b, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa72f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa73f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
>  #endif
> -- 
> 2.43.0
> 

