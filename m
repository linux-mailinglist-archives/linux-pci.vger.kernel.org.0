Return-Path: <linux-pci+bounces-42033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EEEC852FB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7080F34EBAB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 13:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E001218821;
	Tue, 25 Nov 2025 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="meGWSM+v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590AB202F70
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764077650; cv=none; b=b3GPVRfdBczvZaACw/0M4O4jFG/BsfB60BQjsaG0yjYYm2ozqen6hUQrK8qOE1ykUNoCVCcJ3odoCE0iIvXLALfAIQBPUggbs8XgvKgVhO+BPO8MwrotdO7IERZtxD3b2T+3py/zsjdp8NPW7D4wNhVzBn2iqj5SzGdzV6gK7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764077650; c=relaxed/simple;
	bh=2MLNRS8OGcGxSnKUVKP+56ZKMabB5DVbJvKWuU9wTyc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3jIWes1geVfi+J4gzrXWXFBxgXc+jJGMRWmEkoCr+ni1Acp6QpkU0VynxH7+s95o0UDZrE5DS7BIv8zFS+ZeBkyb2jAJgQ+o/H16in5qP5G7TQ6slDv6m8yUKsR3wFYkTL3C7bNnyMx9Zg/iDTy/oIJ6AEBKQ0STq0x4SYXuek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=meGWSM+v; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5958187fa55so4240572e87.3
        for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 05:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764077646; x=1764682446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dAVYy7T5TP7gCxNE/224Hph+WRtTy6ByMNTbqAz/tmc=;
        b=meGWSM+vkMSX2x8SdJwaUHggf8VO2HW/KgcT3yaz4TaSyOb2/uG2wNNy/b43BjjVfv
         7ChW5ck/FfqN2Anfc5em3f5u8jAw3ANnzpbafdJ+/OZ3U2ZmLy2ee3EwU4svp0dIKD5b
         KZMk+74XZKdWjDknv1KH1yMOzgYZ8Gq15D6jtgtPtL8NyWzmT0ZnJ+YIlGcdVQLAMDLT
         gAhXyDXtd+0d7gG0ceM1UwORSHCfsFLVGNSCROypXJLQ2vfzPTwa783yIvAHBzKxxfJm
         FZSexM3AJHZIpSwmKC/Q+lyZsAwO/bXqmk4kmISE+YDIBZUeMWFDbp5Y170iKpuucrl9
         QABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764077646; x=1764682446;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAVYy7T5TP7gCxNE/224Hph+WRtTy6ByMNTbqAz/tmc=;
        b=lmR+cQCE7wlhQOqgqAXPC434jMaiCH3H0B0bNH9SA3jnQIDGJIHHSdmtUgu44dbfqG
         wbtFPhwkYgeTAevLrfKlBTbqM1aBtVV+b8XBbfLI6OUMujO9JekMf0c3vwusLMC/2tuf
         Ab4EoKwQuH3vm1MrkCWXmK+VmA+XpYVVqtR+UfZX5sB2lqcvS77ZcdFD4LaRuvUIYWrL
         sCber7g7TyQoA9tm4MWXxnRIXaukybfhGzNHIfuRlNrLMfH4epTb1vcE39kiMxVEPZgm
         4rMRtzTNgL7soheDxHPEJF85kK3oPshC7rE5VLHv0SCY+XslrI6KYXiQpoGv7JQo2WQr
         9y3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYMnjf+kaWTiSV9myE8VJlxrGToBnkRKT8nWI5QqBc/hZ8oXxiXduN3D1bq7FRiX/Wk5qplJJ2sPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIT+s6M4M0krxmV3UTzyE23j87HlzUiZ4nUwINozLNyYMHg0/f
	AySMgaR/yGMChMbbucBemuZipMQ0SZFL3grKozqWBqVKGRCUZsZIxyWpir10Sbto/7S5FgN9rVR
	75w8R1f2IqtJShsQJO1G1BZt+oZmJn40C3FukwO5nhQ==
X-Gm-Gg: ASbGncuEKfaF7RETxkC/TrA/ecHznplZzhZkxZX23u6uKK+MZe9vFuYTZvCgT6FVPeY
	DQPPMcn3xHYlt7vJ/xI/fRa/VO0CmS4uplPuQlihBwGa2jk1WGWSzXz+kB70JFJ+w5AmRNnLkyo
	b6/WlW5M4Y1rx7UeSW5Fd22psb1eJzEP7h0DGDBRI/f8Rmk1bTK37WZpxtGuLvlEB5Aqd3LldaQ
	JhKInV8ohEmKyYrRHtBd9ntDmxYRihdUuXCoreUAMdPRQsp1AwJa5SkIqnWdyBYqF6ZzKF4rfvp
	VtqeV/yWIiAAUSiWeHoWIxRDU4k=
X-Google-Smtp-Source: AGHT+IG9Ti7lkxwD7MySbGXbpescEnPD1qEmT//p7y8c8bi7c2mgLpxwJZgArS0veNWA5TYlb0r7uGuZGZ7oZ1bzD/s=
X-Received: by 2002:a05:6512:3d91:b0:594:2f72:2fa2 with SMTP id
 2adb3069b0e04-596b4e4b868mr1099951e87.5.1764077646330; Tue, 25 Nov 2025
 05:34:06 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Nov 2025 05:34:04 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Nov 2025 05:34:04 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20251124-pci-pwrctrl-rework-v1-4-78a72627683d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com> <20251124-pci-pwrctrl-rework-v1-4-78a72627683d@oss.qualcomm.com>
Date: Tue, 25 Nov 2025 05:34:04 -0800
X-Gm-Features: AWmQ_bk4lV0HZ4z8cp-6GbalWXiC88o63pPNYrCLxihcKDksJLD6FQwEonYAt8s
Message-ID: <CAMRc=MeRVLALxdPoFP2fXpq+inZpA7h-eCBRuegTkxWUGOpDew@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI/pwrctrl: Add APIs to power on/off the pwrctrl devices
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Niklas Cassel <cassel@kernel.org>, 
	Alex Elder <elder@riscstar.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Nov 2025 17:20:47 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> To fix PCIe bridge resource allocation issues when powering PCIe
> switches with the pwrctrl driver, introduce APIs to explicitly power
> on and off all related devices simultaneously.
>
> Previously, the individual pwrctrl drivers powered on/off the PCIe devices
> autonomously, without any control from the controller drivers. But to
> enforce ordering w.r.t powering on the devices, these APIs will power
> on/off all the devices at the same time.
>
> The pci_pwrctrl_power_on_devices() API recursively scans the PCI child
> nodes, makes sure that pwrctrl drivers are bind to devices, and calls their
> power_on() callbacks.
>
> Similarly, pci_pwrctrl_power_off_devices() API powers off devices
> recursively via their power_off() callbacks.
>
> These APIs are expected to be called during the controller probe and
> suspend/resume time to power on/off the devices. But before calling these
> APIs, the pwrctrl devices should've been created beforehand using the
> pci_pwrctrl_{create/destroy}_devices() APIs.
>
> Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/pwrctrl/core.c  | 121 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-pwrctrl.h |   4 ++
>  2 files changed, 125 insertions(+)
>
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 6eca54e0d540..e0a0cf015bd0 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -65,6 +65,7 @@ void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
>  {
>  	pwrctrl->dev = dev;
>  	INIT_WORK(&pwrctrl->work, rescan_work_func);
> +	dev_set_drvdata(dev, pwrctrl);
>  }
>  EXPORT_SYMBOL_GPL(pci_pwrctrl_init);
>
> @@ -152,6 +153,126 @@ int devm_pci_pwrctrl_device_set_ready(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_pci_pwrctrl_device_set_ready);
>
> +static int __pci_pwrctrl_power_on_device(struct device *dev)

Both this and __pci_pwrctrl_power_off_device() are only used once each. Does
it really make sense to split it out?

> +{
> +	struct pci_pwrctrl *pwrctrl = dev_get_drvdata(dev);
> +
> +	if (!pwrctrl)
> +		return 0;
> +
> +	return pwrctrl->power_on(pwrctrl);
> +}
> +
> +/*
> + * Power on the devices in a depth first manner. Before powering on the device,
> + * make sure its driver is bound.
> + */
> +static int pci_pwrctrl_power_on_device(struct device_node *np)
> +{
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	for_each_available_child_of_node_scoped(np, child) {
> +		ret = pci_pwrctrl_power_on_device(child);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	pdev = of_find_device_by_node(np);
> +	if (pdev) {
> +		if (!device_is_bound(&pdev->dev)) {
> +			dev_err(&pdev->dev, "driver is not bound\n");

This is not an error though, is it? If there are multiple deferalls, we'll
spam the kernel log.

> +			ret = -EPROBE_DEFER;
> +		} else {
> +			ret = __pci_pwrctrl_power_on_device(&pdev->dev);
> +		}
> +		put_device(&pdev->dev);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;

Bart

