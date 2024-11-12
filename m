Return-Path: <linux-pci+bounces-16615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C817A9C6604
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 01:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5547B2A254
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 23:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9201A21B451;
	Tue, 12 Nov 2024 23:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGiHHNsP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D051CDFBD;
	Tue, 12 Nov 2024 23:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731454911; cv=none; b=OhiG55buSYjlc0RPnoBMrYLjgDfuP3KvFKqzq5CCWErEXPUyHLiGC286ffGJsR69q5D+cgbVMmF7LcACat7fxljhusPOaASqQze96wGKx7ERh9vs4FI+PEROkrji0ojRBOh7KaWJLF3Zb+758XUwvm89Dcn8zaaMoqADRQo9qC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731454911; c=relaxed/simple;
	bh=bJcRkELrtBlPUO01G/L6we+wyjkwmtPt6sLuXZZ6Qzg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d2be3TazDO312lKA2ac+QDfK2VFIqGm8+sHygTutozNSMqOJ5jOLSFBbxZfJGaVcNbawrAeOrK373QvUvItdFpEIRZSuxii3ylGW0Dz8b3oWuIYTQnf0WAsesbvDBqfNrG5xovMJdNqooQcGIHiL5NluNrpVNzwyv/n85a1WlZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGiHHNsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4142C4CECD;
	Tue, 12 Nov 2024 23:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731454910;
	bh=bJcRkELrtBlPUO01G/L6we+wyjkwmtPt6sLuXZZ6Qzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EGiHHNsP2s6PzU6R/QKaEULOG8AveQ31BwVLm6n1zh6nDRHcXGM4LYokY3zaXmDtj
	 ZaIMGpUDqQ+YWblKLxpkSu3TaSPvtYhQEGOETn7MjAz+reMc7TnKEKMset1MYXPNWK
	 h9juDeIsun7ztmxejnC7JH8uXyl+YEcZ/AwM8H8x9kEdqoHU6/e1Iw8t/iX4PXJS4T
	 8pqxg5DeN+Y8h99Y7KFwlYhqcJJZjstPLLBHvSGx25UK4+vpPSMDzs+DWhoYdpjsLC
	 OAbOuwWoka7jC12JrEPBmkoEQZV14rw8BQBpyLfF7566PSgAUFUPomlSkQwVPSWmEt
	 oHmA6pWsEKOcQ==
Date: Tue, 12 Nov 2024 17:41:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] PCI: Add new start_link() & stop_link function ops
Message-ID: <20241112234149.GA1868239@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-qps615_pwr-v3-3-29a1e98aa2b0@quicinc.com>

On Tue, Nov 12, 2024 at 08:31:35PM +0530, Krishna chaitanya chundru wrote:
> Certain devices like QPS615 which uses PCI pwrctl framework
> needs to configure the device before PCI link is up.
> 
> If the controller driver already enables link training as part of
> its probe, after the device is powered on, controller and device
> participates in the link training and link can come up immediately
> and maynot have time to configure the device.
> 
> So we need to stop the link training by using stop_link() and enable
> them back after device is configured by using start_link().

s/maynot/may not/

I think I'm missing the point here.  My assumption is this:

  - device starts as powered off
  - pwrctl turns on the power
  - link trains automatically
  - qcom driver claims device
  - qcom needs to configure things that need to happen before link
    train

but that can't be quite right because you wouldn't be able to fix it
by changing the qcom driver because it's not in the picture until the
link is already trained.

So maybe you can add a little more context here?

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  include/linux/pci.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 573b4c4c2be6..fe6a9b4b22ee 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -806,6 +806,8 @@ struct pci_ops {
>  	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
>  	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
>  	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
> +	int (*start_link)(struct pci_bus *bus);
> +	void (*stop_link)(struct pci_bus *bus);
>  };
>  
>  /*
> 
> -- 
> 2.34.1
> 

