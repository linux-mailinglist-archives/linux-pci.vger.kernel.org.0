Return-Path: <linux-pci+bounces-31742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F10FDAFDE03
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 05:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1FC1AA7089
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 03:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC9E1DC988;
	Wed,  9 Jul 2025 03:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LZKS7cgl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9FD17BB21
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2025 03:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752030944; cv=none; b=s2jY6bYv7DrJpp3ZpyBrax9MxTF8NygCfT/6lukmHc0WDj1wYDRTseMBjyefznJAM59UR3vecy7HT8yIDyLdRu2sqSULl6rAjQzCssWHIqjvHmT5fe+8/Z8cb1eLPuzsI12gUUi8vkU7DjQwgJL7Suy4wzCrEQqYKRbrwdwqCtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752030944; c=relaxed/simple;
	bh=aNeDzIXQhqcdG04TNSugRMdSVq8zXoX2GXlhihdlsNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVL9pdb+dfIAWuWFnW/Hrzo4qUaFfzdzuXf6FYJhZOwf9bBj/VzcfQw6z6t3b7844w6d5qElGeKbgJBXPqZLdOpa4A8pGSZwyWjD9k+Ga3N9HxynbBIgIFT6xvUPqyCJ7LzXi6Xvwo8xS8bdkXH6KscBNZqO+XLBbwQcbMCgVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LZKS7cgl; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748f5a4a423so2967997b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 08 Jul 2025 20:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752030942; x=1752635742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9GnIvUvHcXYxKur3IY8TNR+7Jn3H/WOdcBI69S+hJek=;
        b=LZKS7cglVilgS2BvgZJtgaPVrTwE5NsdRRURZhbvIAEHP+aHsaPKz42Pbn6PRr10hV
         t73hEGuePDiIOU0N+KDvXZ7FEBNe8KMJczEBTu3RtKE10WlwS3art1ESNv7Y9FxnOaLU
         YuPjOkkbmE4v1adCDUBmUC82cHBdGHJQgnGl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752030942; x=1752635742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GnIvUvHcXYxKur3IY8TNR+7Jn3H/WOdcBI69S+hJek=;
        b=C7Ie8egNKMouy+VomLnTRkhRquIdO4oriejMyth3Fbg/pvN3HuzuRgFNkta5OFG9tZ
         pEZqZorMWMbqlKEwQjUgpIIKgEvh6TuHckeZjRSxdFHJBQBlE1S5p0JnKakO2d/kZqMv
         rKg7UKAaB3QWojLDroWrXLEbBQCzIpPejCX+nyRLdaKbTruvepXhYLUrNbjCmZzkaflO
         ntUxi0OOp+zc47fjeBTwHsZI3DeVRYzi0UYL1Mx+ocbNCeVRFtW4z/5rurCvtrWIWyiQ
         jZX20mXBB0f9hoq1bSeUodAYsOqTKFf6YKEqnbjl+awC4Nm3r/vUHybvo+Vp6xslrCU4
         s79A==
X-Forwarded-Encrypted: i=1; AJvYcCX8F3FNvHOwqIt7df2Re+vaqOrCCewZpJdGOrbaOcgr/++jWwtzpF7Zm/9RZZ9HmUXk+9Ws6aJr7zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAKThxZig1PKCRnkGbjG8bLNyNNzLacn555HXHEUjzJrcNhwt
	vBUA7eQpklQJBj0Bfl/dEtKjWNKhHqsfdSgzF0hvSGCPc1utE+6xUPoZgparZR4kOA==
X-Gm-Gg: ASbGnctAvGbhBspBX0QkSEyL4ojIheHK2thRtMxMdChQqXPUzpA1Yhivf6ymSALOSLH
	XZ62xwcd0bg8MY2ZNWIb9O9iNkst08UABoSzZfI/ovaAS17jSjiE3ivbGlUDYmVaD+LoQGhpqwZ
	L2YfdDu8GPFR1Jqauv4aYyFfG3H7QrPlFCzSPHfIQaDD0Op3JUvW91mwD330p7EhVrXTDKA7khQ
	f6YnQdmOCOuji9dZSXcpKGkr3yMFob3shuZG8QD38XVc+zOkq8ms0TwxRYbj0Me/Y/Inqudqsgq
	ZTB0WitEf8jGI7zxY4vuHWErCvrJiNgfIBPS18KrDR9ZWnYciKPKSXjJUhWs3RkglKyGBImENVc
	PgeQShoQDr3nV2wT/Zqlm6kjkW6OARMbuWgY=
X-Google-Smtp-Source: AGHT+IF1IFBUq+Vel6guXYxM+TJKgbZ/8d6R08Gbz0ZBjIlhPPomcVT1urw9RBD+q+rcrCl+MmPq8A==
X-Received: by 2002:a05:6a00:139a:b0:740:afda:a742 with SMTP id d2e1a72fcca58-74ea60b5ffbmr1559833b3a.0.1752030942102;
        Tue, 08 Jul 2025 20:15:42 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:9b88:4872:11ac:8ccb])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74ce4299c3dsm13178481b3a.116.2025.07.08.20.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 20:15:41 -0700 (PDT)
Date: Tue, 8 Jul 2025 20:15:39 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH RFC 2/3] PCI/pwrctrl: Allow pwrctrl core to control
 PERST# GPIO if available
Message-ID: <aG3e26yjO4I1WSnG@google.com>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
 <20250707-pci-pwrctrl-perst-v1-2-c3c7e513e312@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-pci-pwrctrl-perst-v1-2-c3c7e513e312@kernel.org>

Hi Manivannan,

On Mon, Jul 07, 2025 at 11:48:39PM +0530, Manivannan Sadhasivam wrote:
> PERST# is an (optional) auxiliary signal provided by the PCIe host to
> components for signalling 'Fundamental Reset' as per the PCIe spec r6.0,
> sec 6.6.1.
> 
> If PERST# is available, it's state will be toggled during the component
> power-up and power-down scenarios as per the PCI Express Card
> Electromechanical Spec v4.0, sec 2.2.
> 
> Historically, the PCIe controller drivers were directly controlling the
> PERST# signal together with the power supplies. But with the advent of the
> pwrctrl framework, the power supply control is now moved to the pwrctrl,
> but controller drivers still ended up toggling the PERST# signal.

[reflowed:]
> This only happens on Qcom platforms where pwrctrl framework is being
> used.

What do you mean by this sentence? That this problem only occurs on Qcom
platforms? (I believe that's false.) Or that the problem doesn't occur
if the platform is not using pwrctrl? (i.e., it maintained power in some
other way, before the controller driver gets involved. I believe this
variation is correct.)

> But
> nevertheseless, it is wrong to toggle PERST# (especially deassert) without
> controlling the power supplies.
> 
> So allow the pwrctrl core to control the PERST# GPIO is available. The

s/is/if/

?

> controller drivers still need to parse them and populate the
> 'host_bridge->perst' GPIO descriptor array based on the available slots.
> Unfortunately, we cannot just move the PERST# handling from controller
> drivers as most of the controller drivers need to assert PERST# during the
> controller initialization.
> 
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/pci/pwrctrl/core.c  | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-pwrctrl.h |  2 ++
>  include/linux/pci.h         |  2 ++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 6bdbfed584d6d79ce28ba9e384a596b065ca69a4..abdb46399a96c8281916f971329d5460fcff3f6e 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c

>  static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
>  			      void *data)
>  {
> @@ -56,11 +61,42 @@ static void rescan_work_func(struct work_struct *work)
>   */
>  void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
>  {
> +	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dev->parent);
> +	int devfn;
> +
>  	pwrctrl->dev = dev;
>  	INIT_WORK(&pwrctrl->work, rescan_work_func);
> +
> +	if (!host_bridge->perst)
> +		return;
> +
> +	devfn = of_pci_get_devfn(dev_of_node(dev));
> +	if (devfn >= 0 && host_bridge->perst[PCI_SLOT(devfn)])
> +		pwrctrl->perst = host_bridge->perst[PCI_SLOT(devfn)];

It seems a little suspect that we trust the device tree slot
specification to not overflow the perst[] array. I think we can
reasonably mitigate that in the controller driver (so, patch 3 in this
series), but I want to call that out, in case there's something we can
do here too.

>  }
>  EXPORT_SYMBOL_GPL(pci_pwrctrl_init);
>  
> +static void pci_pwrctrl_perst_deassert(struct pci_pwrctrl *pwrctrl)
> +{
> +	/* Bail out early to avoid the delay if PERST# is not available */
> +	if (!pwrctrl->perst)
> +		return;
> +
> +	msleep(PCIE_T_PVPERL_MS);
> +	gpiod_set_value_cansleep(pwrctrl->perst, 0);

What if PERST# was already deasserted? On one hand, we're wasting time
here if so. On the other, you're not accomplishing your spec-compliance
goal if it was.

> +	/*
> +	 * FIXME: The following delay is only required for downstream ports not
> +	 * supporting link speed greater than 5.0 GT/s.
> +	 */
> +	msleep(PCIE_RESET_CONFIG_DEVICE_WAIT_MS);

Should this be PCIE_RESET_CONFIG_DEVICE_WAIT_MS or PCIE_T_RRS_READY_MS?
Or are those describing the same thing? It seems like they were added
within a month or two of each other, so maybe they're just duplicates.

BTW, I see you have a FIXME here, but anyway, I wonder if both of the
msleep() delays in this function will need some kind of override (e.g.,
via Device Tree), since there's room for implementation or form factor
differences, if I'm reading the spec correctly. Maybe that's a question
for another time, with actual proof / use case.

> +}
> +

Brian

