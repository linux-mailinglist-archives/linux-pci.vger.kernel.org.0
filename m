Return-Path: <linux-pci+bounces-8259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 727D68FBAF9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 19:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28DEA1F2201A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 17:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFD8149C4D;
	Tue,  4 Jun 2024 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pv7WYyK7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDFC13D52C;
	Tue,  4 Jun 2024 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523576; cv=none; b=MK3gX1VTn04uXJJ1/NXCFzb0BvtYAc7k1mGMk6kOmF4pbUFBsh/C1QY74jKZnUwi+3gyUQlssP32FimX+o9tMmhrLjwkrAx02zxQyM/gJjQGt1HaCzuPUjQix3cP9XeHZ088ioccet7cWHU0A9add7Q4FOTQYMgNNiin2dsk6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523576; c=relaxed/simple;
	bh=Hqqr9yw/DX0Mf6mIuq2bE9GcOEl92STqqaD9QVg7U3M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WcxR/63Jj2RB1JvjVjvWV+5JkijtFtPIBg5L70STfPsDEGoNFQ1pf/EkHpAFqjNi8Vr/KE67jxWQjwYdDIRHW4/D2XjzZs4ziHm3wv9n9v4K358KT/OC2xJ0eDBi3VmIEYKCUPA67oFgPbyqGqM9uVYcoZURAz3NG8zWqnB/P78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pv7WYyK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DFAC2BBFC;
	Tue,  4 Jun 2024 17:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717523576;
	bh=Hqqr9yw/DX0Mf6mIuq2bE9GcOEl92STqqaD9QVg7U3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Pv7WYyK7Hiq+yltDhy7NyOgEtjKRjY5Ej2YyO02NzMaZOtQRZQpA7vFcOXpQimV9I
	 F9aOGaZLP5RX+2C1osztVl33qlRA2Ji5DTxA8vZ2/aLutg2fMuE0ISpEANn5R/aDox
	 alnSOFX4Vnt1BIVb0GJD1ICdnJYQKzSl1YSA9Bb5tSsh349vXSupVQFPggj3oHCAkr
	 EOXKkMAQwPht04HvLVa6Xt0tW9QMWXLKGmKN46xJ1JLEmisA3NxfxWFb3lkyd52KaA
	 Jb9quboEAhH9pThmE/C1yYV6hshYQBD27cnnWIZ0UfjecuG4NtGJjC6x2iyMitct0E
	 10JusfzF1w0Ow==
Date: Tue, 4 Jun 2024 12:52:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath12k@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel@quicinc.com, Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v8 11/17] power: pwrseq: add a driver for the PMU module
 on the QCom WCN chipsets
Message-ID: <20240604175254.GA733438@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-pwrseq-v8-11-d354d52b763c@linaro.org>

On Tue, May 28, 2024 at 09:03:19PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This adds the power sequencing driver for the PMU modules present on the
> Qualcomm WCN Bluetooth and Wifi chipsets. It uses the pwrseq subsystem
> and knows how to match the sequencer to the consumer device by verifying
> the relevant properties and DT layout.

> +config POWER_SEQUENCING_QCOM_WCN
> +	tristate "Qualcomm WCN family PMU driver"
> +	default m if ARCH_QCOM
> +	help
> +	  Say Y here to enable the power sequencing driver for Qualcomm
> +	  WCN Bluetooth/WLAN chipsets.
> +
> +	  Typically, a package from the Qualcomm WCN family contains the BT
> +	  and WLAN modules whose power is controlled by the PMU module. As the
> +	  former two share the power-up sequence which is executed by the PMU,
> +	  this driver is needed for correct power control.

"needed for correct power control" suggests that this fixes an
existing problem, and I assume everybody with this kind of device
wants this, and they will see some benefit from enabling it.  But it's
not clear what that user-visible benefit is.  Could be useful both
here and in commit log.

> +struct pwrseq_qcom_wcn_pdata {
> +	const char *const *vregs;
> +	size_t num_vregs;
> +	unsigned int pwup_delay_msec;
> +	unsigned int gpio_enable_delay;

Seems like it'd be nice to have a hint about the units of
gpio_enable_delay (apparently ms) and last_gpio_enable (apparently
jiffies)?  Maybe even use the same units for both, but I'm sure you
have a reason for this.

> +static int pwrseq_qcom_wcn_match(struct pwrseq_device *pwrseq,
> +				 struct device *dev)
> +{
> +	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> +	struct device_node *dev_node = dev->of_node;
> +
> +	/*
> +	 * The PMU supplies power to the Bluetooth and WLAN modules. both

s/both/Both/

