Return-Path: <linux-pci+bounces-39734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B3C1DAEF
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 00:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D00334BD94
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 23:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4191E309EF8;
	Wed, 29 Oct 2025 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2objD2q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E02F2DCBFB;
	Wed, 29 Oct 2025 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761780205; cv=none; b=gOperVMqtwQZTHHnn+Cz+tnadOOFbyGSHD6N3xd0UoELdf4DIVajiHqOBPJM3SSNwvdEoZq3/2+bbbZJ1G39tiNUw+agmJfeaf2xyR8EGJp7lyN4L5ezoYummd0ODq9Wn036kuPrIdHJdg6+LIzWjW9HLj1aZFhuGnUi72i3dg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761780205; c=relaxed/simple;
	bh=c/sTjrq+R9ZaCsBuwnVAqRM5QZJaaojvFV/fjYuoNGs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VdtZCaETpQ/ERTLlFXfiB+nI6iBpxKF3fg9gG/j6j16Py1ESpZEQuiDwFXYq/8M+/NHRyup5v2jx4J1fwDMncMk2NExp/a9DTa1pdJwN0l1ILzzU3QXyp8pt3zgT3TugH3a400jlNziwWADsOBVWntEF3ztornUF02YmY/MQhMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2objD2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63756C4CEF7;
	Wed, 29 Oct 2025 23:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761780204;
	bh=c/sTjrq+R9ZaCsBuwnVAqRM5QZJaaojvFV/fjYuoNGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=n2objD2qH1724Re0HCcuSPzk1/aNZVzfB4rKes83yRy/4rJohBGae/kHc+PLNJvjV
	 QBTxxd59XiSacPcC9e9vKkErhlnbtauqS0N72jpQVM/VTIQbEF86KdpGEJYHZISUP6
	 QISwHziNuIX/hA89l85FIfTqm1eWnehJzN1rzajfoPG7iX03hdyVfyBH52teHRldKR
	 3CLD4dsQxbEJYCAP5ZRHxB0s26dczjgfbkc8nTvRX6bM4f26UEmZa/dMolb6gd5qGi
	 fV1nyrJC/Yz/7LmuZaZHktINivzgbUlnPppJMuO6jWq2S6DNM1DvCn8k5jdM/8gcje
	 JgPdL1iICbtxA==
Date: Wed, 29 Oct 2025 18:23:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, quic_vbadigan@quicnic.com,
	amitk@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	Dmitry Baryshkov <lumag@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 0/8] PCI: Enable Power and configure the TC9563 PCIe
 switch
Message-ID: <20251029232323.GA1602660@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>

On Wed, Oct 29, 2025 at 04:59:53PM +0530, Krishna Chaitanya Chundru wrote:
> TC9563 is the PCIe switch which has one upstream and three downstream
> ports. To one of the downstream ports ethernet MAC is connected as endpoint
> device. Other two downstream ports are supposed to connect to external
> device. One Host can connect to TC956x by upstream port.
> 
> TC9563 switch power is controlled by the GPIO's. After powering on
> the switch will immediately participate in the link training. if the
> host is also ready by that time PCIe link will established. 
> 
> The TC9563 needs to configured certain parameters like de-emphasis,
> disable unused port etc before link is established.
> 
> As the controller starts link training before the probe of pwrctl driver,
> the PCIe link may come up as soon as we power on the switch. Due to this
> configuring the switch itself through i2c will not have any effect as
> this configuration needs to done before link training. To avoid this
> introduce two functions in pci_ops to start_link() & stop_link() which
> will disable the link training if the PCIe link is not up yet.
> 
> This series depends on the https://lore.kernel.org/all/20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com/

What does this series apply to?  It doesn't apply cleanly to v6.18-rc1
(the normal base for topic branches) or v6.18-rc3 or pci/next.

I tried first applying the patches from
https://lore.kernel.org/all/20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com/,
but those don't apply to -rc1 or -rc3 either.

Bjorn

