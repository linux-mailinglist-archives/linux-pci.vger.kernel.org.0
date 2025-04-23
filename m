Return-Path: <linux-pci+bounces-26615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD48A999AD
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 22:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B41B5A7810
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 20:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DE826B953;
	Wed, 23 Apr 2025 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejv8ieMM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219B8269AF9;
	Wed, 23 Apr 2025 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441383; cv=none; b=EA6bJ3QrIlT78QKMPUilQneDSBgBbs0dDPtWyUFV6ZexwrIygSIosw+SJwlx9N7qHE8o1d3bXoQJOtMvwJvtspUh+cbIHczrXaqcp3VUvmkEN/0LBtcjAjAFx20jzgZ5CR1hku7r0AuQzG0OgY3YFA5slh2jJe1Qoce61oo19Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441383; c=relaxed/simple;
	bh=SlsceTeKP169Z7bWXvcuJYpEFN+vi9NMqlHYsr8sBog=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V4ahRMjxPg7BSzm6ueQvmSxF2P9gi6UpyiXHXY2uVuSd54goeq0FW/uepf36nPREmSGsYzbUW+TiJustITQ3sW9Z+XX3sLkN0ECoWHg8Hfzs0ae91B2hqws5vlXOAE7HT4ZQz4aIDW5079SqrNkVG0Ov0Frtlz+xTBec5npO6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejv8ieMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7516DC4CEE2;
	Wed, 23 Apr 2025 20:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745441382;
	bh=SlsceTeKP169Z7bWXvcuJYpEFN+vi9NMqlHYsr8sBog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ejv8ieMMXqPy3DuEiYockJL/nXxShmy1tIoeFGvOaLBQ8LYZIHw+NQoJbNsmmIEpn
	 Is4ruOoxfY0jIrxQlLoOZF7JURbl6/60wnikIfco8uYFAAnCURANE0zAKs1ZR2jhIT
	 98LbyiPVr09Bj58dsoIdW8oCzBo4pmOoO10Bj+WRpvQ4bgg2DkHcUQq7K1qvfbNtgp
	 FJfRosLIeghcRC4b5s5umS5oHjxWxvs6zpljxAtSwLE+PHa0SPH4Wv0mS88xV2qc5I
	 PtEtRzH4YzIFOcF22nzyRLkDYiG5U1Xl6byrAG6xm3DK3Wx4OZMT98HQ11TPgU+2cY
	 /5JsOSrL3SCzg==
Date: Wed, 23 Apr 2025 15:49:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Brian Norris <briannorris@google.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] PCI/pwrctrl: Cancel outstanding rescan work when
 unregistering
Message-ID: <20250423204941.GA454025@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409115313.1.Ia319526ed4ef06bec3180378c9a008340cec9658@changeid>

On Wed, Apr 09, 2025 at 11:53:13AM -0700, Brian Norris wrote:
> From: Brian Norris <briannorris@google.com>
> 
> It's possible to trigger use-after-free here by:
> (a) forcing rescan_work_func() to take a long time and
> (b) utilizing a pwrctrl driver that may be unloaded for some reason.
> 
> I'm unlucky to trigger both of these in development. It's likely much
> more difficult to hit this in practice.
> 
> Anyway, we should ensure our work is finished before we allow our data
> structures to be cleaned up.
> 
> Fixes: 8f62819aaace ("PCI/pwrctl: Rescan bus on a separate thread")
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied to pci/pwrctrl for v6.16, thanks!

> ---
> 
>  drivers/pci/pwrctrl/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 9cc7e2b7f2b5..6bdbfed584d6 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -101,6 +101,8 @@ EXPORT_SYMBOL_GPL(pci_pwrctrl_device_set_ready);
>   */
>  void pci_pwrctrl_device_unset_ready(struct pci_pwrctrl *pwrctrl)
>  {
> +	cancel_work_sync(&pwrctrl->work);
> +
>  	/*
>  	 * We don't have to delete the link here. Typically, this function
>  	 * is only called when the power control device is being detached. If
> -- 
> 2.49.0.604.gff1f9ca942-goog
> 

