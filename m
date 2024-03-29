Return-Path: <linux-pci+bounces-5413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77AD892054
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 16:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A8C1C29351
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD0912F398;
	Fri, 29 Mar 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwobvZGO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06E412F390;
	Fri, 29 Mar 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725424; cv=none; b=N+rVMaTQVgLBzsiaipz8d/Bd0dxT9I//h7H9iLMCofcpBHjZ3EV+tdO1uyGDTYZaQ0FH6gF9MMnoc1jkIjIjsSaBBh6ET6jtxWdH8AvXmF22nBbjFqPmjBMhWSkmcTFnn1yy6ljsLeVYweSYJH3FUaOdbsTl1C2LbDVZvERfYz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725424; c=relaxed/simple;
	bh=cVtF3/B9z9gUvm50YhtU+CWwJdHQzQ0/7FvW6q5QEBg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LUiDVLvTu0tlWTwjQ4eb6qCn8yY0BKKKl4byk2JYI96zIUpAzUjkoWAko7hqS1UXN0ew3pEKnSpOFp0H8RV66CtU5JdUi/hd/kuH+8L4LOnyZZwxQxwaZ3gE1C3GyE4N9w/dyxj87eEr8vNsO5+gZ05PImq0UmgT5gb+k4Y+Hmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwobvZGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DC6C4166B;
	Fri, 29 Mar 2024 15:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711725424;
	bh=cVtF3/B9z9gUvm50YhtU+CWwJdHQzQ0/7FvW6q5QEBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PwobvZGOPm8cm/XEMTyreGlEdfRIxSpGE1rURLd/keGu9DZDn3Txqno5foFxvDG0X
	 nXHVQ7MzV1Tbp8C9G+sJeMbZoL24QmbjiwQ/BSTYmEc/3MQ6cnOzBNO+hezyNYxiNC
	 VgU9ARVAG6YZ4OqNXfmYU7BL2BTxnoFjIJ5Xs4IDteeKYlYhZb84AQ5Me/lZ+WPX+w
	 /SKDW0VUKfErZ+69me9COFJLklhyo7CQwn54pTHxh/cJEOX458qPYwcsdwaMPqI7ry
	 wGYTSGIMoaZkr6OJoMz1fIgQJoZSMksaFhB5jdtO0SdQtl9ZtCNzyxv+GccB1q4H2o
	 HD+Q3nTAvpjpg==
Date: Fri, 29 Mar 2024 10:17:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Edmund Raile <edmund.raile@proton.me>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 52/75] PCI: Mark LSI FW643 to avoid bus reset
Message-ID: <20240329151702.GA1643117@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329124330.3089520-52-sashal@kernel.org>

On Fri, Mar 29, 2024 at 08:42:33AM -0400, Sasha Levin wrote:
> From: Edmund Raile <edmund.raile@proton.me>
> 
> [ Upstream commit 29a43dc130ce65d365a8ea9e1cc4bc51005a353e ]
> 
> Apparently the LSI / Agere FW643 can't recover after a Secondary Bus Reset
> and requires a power-off or suspend/resume and rescan.
> 
> VFIO resets a device before assigning it to a VM, and the FW643 doesn't
> support any other reset methods, so this problem prevented assignment of
> FW643 to VMs.
> 
> Prevent use of Secondary Bus Reset for this device.
> 
> With this change, the FW643 can be assigned to VMs with VFIO.  Note that it
> will not be reset, resulting in leaking state between VMs and host.
> 
> Link: https://lore.kernel.org/r/20240227131401.17913-1-edmund.raile@proton.me
> Signed-off-by: Edmund Raile <edmund.raile@proton.me>
> [bhelgaas: commit log, comment]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

We're about to revert this upstream, so I wouldn't backport this to
any stable trees:

https://lore.kernel.org/r/20240328212302.1582483-1-helgaas@kernel.org

> ---
>  drivers/pci/quirks.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b5b96d2a9f4ba..687f9b00b3057 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3758,6 +3758,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
>   */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
>  
> +/*
> + * Apparently the LSI / Agere FW643 can't recover after a Secondary Bus
> + * Reset and requires a power-off or suspend/resume and rescan.  Prevent
> + * use of that reset.
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5900, quirk_no_bus_reset);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5901, quirk_no_bus_reset);
> +
>  /*
>   * Some TI KeyStone C667X devices do not support bus/hot reset.  The PCIESS
>   * automatically disables LTSSM when Secondary Bus Reset is received and
> -- 
> 2.43.0
> 

