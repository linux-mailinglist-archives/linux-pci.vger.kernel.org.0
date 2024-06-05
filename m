Return-Path: <linux-pci+bounces-8348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C43918FD482
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 19:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778F81F22E94
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 17:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB6619538D;
	Wed,  5 Jun 2024 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd1mkKZU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFCE194AFC;
	Wed,  5 Jun 2024 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610280; cv=none; b=GLvsdviSoEyb8ytTqkTCEDBLvAyeWt+/p9TbRx6uLZ/17UlL5cJPuLM4Yemne2s4FdoFXTkvqWeUFrW2ASbBIAauYK7aS2C3404vESZ4rxlddD875oHJU+IIKyQSlt9lLF/AQCNxwsUaX5oIuA99RyfIaxYv8rv8Q/mRnZNvA2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610280; c=relaxed/simple;
	bh=7651KFw0eV+sZCBg3Xgw24WdzXcHIYOFgb2Cy9igrRI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YIaFdSluSpJaGSiqVimeNPBF+CTq5/vvZRlsGxv5j/U7otp7ZZ/NrN/Ga7BjeudNGvgutNHNR0GZ4bTJHeZMbfpliSNqSAMY3NbMJLc2TOj7aLW1jm+UEGZzESKbIHdZLNbUjIK0DGQVZVaIER9IEaxGxYqcUwn37VEmnJBrMlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd1mkKZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65200C32782;
	Wed,  5 Jun 2024 17:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717610279;
	bh=7651KFw0eV+sZCBg3Xgw24WdzXcHIYOFgb2Cy9igrRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hd1mkKZUhqQqGSBxCm4GPev0yQ2EhyJ/hnZS0yvgyGtNfBS8om6Bq1RE4ifOd6gI5
	 D8VetdPBrhbibxq/5zOvS8onnXu1R6FCGyyoHUAXd3cSpnu85JqX7ckJNf2pyzbUzY
	 MjxiEshiMdJkwl+wJpE22c15NY/CKktbPbdboJBMrgBWeTJiL9h8JinLCNuaox9GSo
	 GtwR57MNbDomombf3jMBJI8juBUZct7vfnfRdKjGTgIv6mmyHFEsR4tVai8f8qe9p8
	 EV670UDpwwOhsKCdGYgA+ho+/AM5EFh1w+wIiD5pu1QB2ephfYREjVAwQiUgGBsrXl
	 G4RSCtSn6mpuA==
Date: Wed, 5 Jun 2024 12:57:57 -0500
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
Subject: Re: [PATCH v8 15/17] PCI/pwrctl: add PCI power control core code
Message-ID: <20240605175757.GA733809@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-pwrseq-v8-15-d354d52b763c@linaro.org>

On Tue, May 28, 2024 at 09:03:23PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Some PCI devices must be powered-on before they can be detected on the
> bus. Introduce a simple framework reusing the existing PCI OF
> infrastructure.
> 
> The way this works is: a DT node representing a PCI device connected to
> the port can be matched against its power control platform driver. If
> the match succeeds, the driver is responsible for powering-up the device
> and calling pcie_pwrctl_device_set_ready() which will trigger a PCI bus

s/pcie_pwrctl_device_set_ready/pci_pwrctl_device_set_ready/

> rescan as well as subscribe to PCI bus notifications.
> 
> When the device is detected and created, we'll make it consume the same
> DT node that the platform device did. When the device is bound, we'll
> create a device link between it and the parent power control device.

