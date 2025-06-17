Return-Path: <linux-pci+bounces-29988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB968ADDFC2
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 01:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ED817AA2E6
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 23:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC4F218858;
	Tue, 17 Jun 2025 23:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPd8kitl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616752F5326;
	Tue, 17 Jun 2025 23:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203341; cv=none; b=bUPMjSW+gCUo+DPnFPSIiUMnc8kKAkYm7SHdScA9e41U0DuecnkHs49vO7K2N0ynfrdgRaoB+U1Y1pYh5bvPbv6n2REUQTnj3/fUk9Yyo4kl8K3oVXOZkz4gyVRhlSl04TPVuVoMG2LPaql43fdxS6orZ9NQUD/yU4La5OeMBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203341; c=relaxed/simple;
	bh=iLoQCihGzEBGYCVh3p3W+/pZ3DPuaTjIgYAmG7jTQxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hnzySM1qMTN+XoTwcalGsFLJhH4urD4y8ZbVMD5gb8TsZ70Jnm5wMsV5LR799HEbA6w73w057VthjyJ1qaasWpXEZfgSt69SfQbu6trPhbRLITL9VOAKlf1Dj3r6oac/hYmiZjm1lLC3mMP2MHq2bp6f/gNLKewhYC2OKYQwVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPd8kitl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5D7C4CEE3;
	Tue, 17 Jun 2025 23:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750203340;
	bh=iLoQCihGzEBGYCVh3p3W+/pZ3DPuaTjIgYAmG7jTQxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RPd8kitlsBO7a3MKgi/kF14PhO4LBtooMT2SU/HDAz0urVacRH48WrnVuO+QWq+h+
	 4H0VACCWifknEQMJ/1p+ai0D8q0i/xbfLLT9DYjey8Txq1HJB+kC1ZaiUhU/nU+0Ui
	 SbySFcxjmiPf99FWM9Lq9w1SyUHuIW76EI17PCPqZoTe7TP5jKFrRFvVlzlLgf4zey
	 iEW8wCBwTawXbESa88yzoKRe9dPPzGDeg+bZ7yGaxrEyqdfPKrPLVJOrBfc/yLaVQv
	 w1ERbvroGJ+MBOdhi+pqgxfMnYDaqjKgZ+DjFT23VKsTeh11RE7z84yOnXI757M4D+
	 zubUGhRDZFGCQ==
Date: Tue, 17 Jun 2025 18:35:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v9 4/5] PCI/pwrctl: Add PCI power control core code
Message-ID: <20250617233539.GA1177120@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612082019.19161-5-brgl@bgdev.pl>

On Wed, Jun 12, 2024 at 10:20:17AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Some PCI devices must be powered-on before they can be detected on the
> bus. Introduce a simple framework reusing the existing PCI OF
> infrastructure.

> +/**
> + * struct pci_pwrctl - PCI device power control context.
> + * @dev: Address of the power controlling device.
> + *
> + * An object of this type must be allocated by the PCI power control device and
> + * passed to the pwrctl subsystem to trigger a bus rescan and setup a device
> + * link with the device once it's up.
> + */
> +struct pci_pwrctl {
> +	struct device *dev;
> +
> +	/* Private: don't use. */
> +	struct notifier_block nb;
> +	struct device_link *link;
> +};

This is old and I should have noticed before, but we have partial
kernel-doc for this struct:

  $ find include -name \*pci\* | xargs scripts/kernel-doc -none
  Warning: include/linux/pci-pwrctrl.h:45 struct member 'nb' not described in 'pci_pwrctrl'
  Warning: include/linux/pci-pwrctrl.h:45 struct member 'link' not described in 'pci_pwrctrl'
  Warning: include/linux/pci-pwrctrl.h:45 struct member 'work' not described in 'pci_pwrctrl'


