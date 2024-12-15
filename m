Return-Path: <linux-pci+bounces-18460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D879F24F2
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 18:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD421640E0
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 17:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454F4196DB1;
	Sun, 15 Dec 2024 17:19:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B3A4C80;
	Sun, 15 Dec 2024 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734283169; cv=none; b=hpmeirkv7OyAK7TsRyqVUMWECL2qNTs/pvlCnOptc9MqZtHpsAAzxDPZ131M8qFUleRc41kSK4SPJS59V10TfmsVmvB5uk0ZUEqphAly1fw1MFqd97M9IT5rs34dA6DLW87136VyI14Cdt8sTJTvPsvdjQAr4daf5u7KyTSx8Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734283169; c=relaxed/simple;
	bh=6jW12wldE/aX15oid43joNXKS5Bk5xOHfcVkXCmHMB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3P/SeOhS/Eq3yIOCCxOq4M7ZloN96bWl6FdqjJ5YJwcNJVlJn0XwZGZiG+6VjQndV1bLOfTw1W20Gzml3WSqv8BEwdZmW7t8q4qCHtu4vZT/86T8zs1zSxGBVFmS4+2KQg/4HTQ4ulcQN7jpkF9LrpzcKOKlcMtiLojeMLDXbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id F28F5100F00C1;
	Sun, 15 Dec 2024 18:19:22 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BFFA948D1B7; Sun, 15 Dec 2024 18:19:22 +0100 (CET)
Date: Sun, 15 Dec 2024 18:19:22 +0100
From: Lukas Wunner <lukas@wunner.de>
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Qiang Yu <quic_qianyu@quicinc.com>
Subject: Re: [PATCH 1/4] PCI/pwrctrl: Move creation of pwrctrl devices to
 pci_scan_device()
Message-ID: <Z18Pmq7_rK3pvuT4@wunner.de>
References: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
 <20241210-pci-pwrctrl-slot-v1-1-eae45e488040@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-pci-pwrctrl-slot-v1-1-eae45e488040@linaro.org>

On Tue, Dec 10, 2024 at 03:25:24PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2446,6 +2448,36 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  }
>  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
>  
> +/*
> + * Create pwrctrl devices (if required) for the PCI devices to handle the power
> + * state.
> + */
> +static void pci_pwrctrl_create_devices(struct pci_bus *bus, int devfn)

Nit:  AFAICS this only creates a *single* platform device, so the
"devices" (plural) in the function name and in the code comment
doesn't seem to be accurate anymore.


> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 2fb174db91e5..9cc7e2b7f2b5 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -44,7 +44,7 @@ static void rescan_work_func(struct work_struct *work)
>  						   struct pci_pwrctrl, work);
>  
>  	pci_lock_rescan_remove();
> -	pci_rescan_bus(to_pci_dev(pwrctrl->dev->parent)->bus);
> +	pci_rescan_bus(to_pci_host_bridge(pwrctrl->dev->parent)->bus);
>  	pci_unlock_rescan_remove();
>  }

Remind me, what's the purpose of this?  I'm guessing that it
recursively creates the platform devices below the newly
powered up device, is that correct?  If so, is it still
necessary?  Doesn't the new approach automatically create
those devices upon their enumeration?

Overall it looks like a significant improvement, thanks for doing this!

Lukas

