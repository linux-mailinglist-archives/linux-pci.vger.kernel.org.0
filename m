Return-Path: <linux-pci+bounces-26588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF40A996ED
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF9F1B8689A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E6C28B50C;
	Wed, 23 Apr 2025 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy/A49MZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513A11E2606;
	Wed, 23 Apr 2025 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430271; cv=none; b=ZeQK3oVnksT8IOJzaG8A+I9slS4o0fJW4h6UyHY76ZrB5huYLAgT6OsqFmdJ4m5Ps0kQ6i148ljwtd93CvW+anNGQbweTbNwN26qpWn2L5hzpd0uhacXc5SJi9LINpahn+GxNHbS93+SjrHD56E5mLk+JNr0sLC4V28BpeTsAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430271; c=relaxed/simple;
	bh=llem0D4ATDI6T5o6sjQUewox5CfgKQJnmzI3EcK5Pj8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=heYR0alFbt/Ukt7cPjcbX0c2FXehnRnWQ3mCZV2n6QPdBSKGAWZtUrv7C3oZxHDMcUUl7p/AsiK73HzdFOdIqqolhK+MoDOgnB4jr6N5I1CPxFDVgIQ+LJNh0gp4MRBCiGwVoP9QIkeyMfAudIRkXRu5xbHd4Jpt4E5HwuN9mv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy/A49MZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F09C4CEE8;
	Wed, 23 Apr 2025 17:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745430271;
	bh=llem0D4ATDI6T5o6sjQUewox5CfgKQJnmzI3EcK5Pj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Jy/A49MZDzCLBXYnUn4t4vwseHKFwyR3byI7Kl3qOIGr1MXXGKAONVfV6+yQ4UC9B
	 i/7hz2Hv546V7nbVnjV9E+JfdZU+7kFD9laAkDxU8ftxnVpOespE1y7hohw8fSKG1a
	 W86uRzMUwPP+n9LX3+f2B51jmbhlKtHOV+IuuAosppg8mWPicIZV3Z2DIwb1BjBqiR
	 AjlGEU2HeBqWqkHc6HxMeF9b76pLXn38ULza+2VvRbifgz6S8l7wL94raFz4GO7qQ2
	 x2jAb/F1ErK4gAId5HGOkYs2SvzdG+sMx2jr/gBiCptHoiADid8BRxPhc752qoxp6I
	 SEF+3UApACXew==
Date: Wed, 23 Apr 2025 12:44:29 -0500
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
Message-ID: <20250423174429.GA441684@bhelgaas>
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

Looking for ack/reviewed-by from Bartosz before doing anything here.

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

