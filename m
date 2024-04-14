Return-Path: <linux-pci+bounces-6223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0276E8A41DC
	for <lists+linux-pci@lfdr.de>; Sun, 14 Apr 2024 12:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55DE281B1C
	for <lists+linux-pci@lfdr.de>; Sun, 14 Apr 2024 10:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910CC2D7B8;
	Sun, 14 Apr 2024 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofepjH0w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F41D537;
	Sun, 14 Apr 2024 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713091177; cv=none; b=tKnCSZOQDaPq8SEoz1xeCf8IQgRTNKthmHD0AwKDnWfI6qZhSOOQy7BmU+kq2+DPsVxG/SyiBZVp41SBtE/C/AZ3i/JbmXZv84asskmSavTt7/aRb/uUwn6Gd9lsVDpwx6Lzr9xzDWYsx6HU3orjfAiI2hwcvlwjveRbpcn3qaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713091177; c=relaxed/simple;
	bh=JbtOUWHVC7wNzadBF8bYSYuSrVY77oLf7wqjRB8KLZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfkWH7wfCOHXYxaCjGWiECTNRgjuy51xwlGT110PjwZz0Wre1mLfy5BSnpUanx3/p2hvrC/8m/kb2WO+jHPwAUlCeFfba3CSDy1vmdNRJCBlEpfNaytZ3IAFtzhxsagXnMsn1eF1qmIEl2kQozjF0qsg2oNb7toMmD5WpZvtNC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofepjH0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963E6C072AA;
	Sun, 14 Apr 2024 10:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713091176;
	bh=JbtOUWHVC7wNzadBF8bYSYuSrVY77oLf7wqjRB8KLZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ofepjH0wUf3Os10OXvzt5lHI9qsH/w9nNsvcYVyBhHvdV4m2cw1ohO/Vis0QJOZPT
	 QNyIPOOSPN9/npG3/acx1bApWHvcRg4inaWGF7oI86g09jSvOtGs3JJuOQmxR5+DqK
	 V/5DIXQc2ngSjOvui34lFC+GSfpozW/Y1/RcAEHh13yGpVo7SBlIDUUVXg8NY9TQw0
	 pBiSrPRv47ciuhlJwVmwEsGvS1Jq7za0ry0lmYTjh0Gn3/rXYJWaXhUKZXdofrNYTe
	 2JXfiqIDu/+DKNmMNI7krvG53xb65g67PP1mGaNc9TkDe1l4j5Xn0zP+PRvAt0VObl
	 j1ne7+aCuG2ig==
Date: Sun, 14 Apr 2024 11:39:26 +0100
From: Simon Horman <horms@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Xilin Wu <wuxilin123@gmail.com>, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 13/16] power: sequencing: implement the pwrseq core
Message-ID: <20240414103926.GB645060@kernel.org>
References: <20240410124628.171783-1-brgl@bgdev.pl>
 <20240410124628.171783-14-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410124628.171783-14-brgl@bgdev.pl>

On Wed, Apr 10, 2024 at 02:46:25PM +0200, Bartosz Golaszewski wrote:

...

> +/**
> + * pwrseq_device_register() - Register a new power sequencer.
> + * @config: Configuration of the new power sequencing device.
> + *
> + * The config structure is only used during the call and can be freed after
> + * the function returns. The config structure *must* have the parent device
> + * as well as the match() callback and at least one target set.
> + *
> + * Returns:
> + * Returns the address of the new pwrseq device or ERR_PTR() on failure.
> + */
> +struct pwrseq_device *
> +pwrseq_device_register(const struct pwrseq_config *config)
> +{
> +	struct pwrseq_device *pwrseq;
> +	int ret;
> +
> +	if (!config->parent || !config->match || !config->targets ||
> +	    !config->targets[0])
> +		return ERR_PTR(-EINVAL);
> +
> +	pwrseq = kzalloc(sizeof(*pwrseq), GFP_KERNEL);
> +	if (!pwrseq)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pwrseq->dev.type = &pwrseq_device_type;
> +	pwrseq->dev.bus = &pwrseq_bus;
> +	pwrseq->dev.parent = config->parent;
> +	device_set_node(&pwrseq->dev, dev_fwnode(config->parent));
> +	dev_set_drvdata(&pwrseq->dev, config->drvdata);
> +
> +	pwrseq->id = ida_alloc(&pwrseq_ida, GFP_KERNEL);
> +	if (pwrseq->id < 0) {
> +		kfree(pwrseq);

Hi Bartosz,

pwrseq is freed on the line above,
so it should not be dereferenced on the line below.

Flagged by Smatch.

> +		return ERR_PTR(pwrseq->id);
> +	}

...

