Return-Path: <linux-pci+bounces-11435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F1794A982
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 16:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BDB2B2943E
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 14:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538AC28399;
	Wed,  7 Aug 2024 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cTkkFEZi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6592BD0D
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2024 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039897; cv=none; b=jRnE3xMxDWqHrwlTPz0TsEiw3Ra59jWFqgmzGD5MNtLvry7fBNoa2c8FLAVDFb09zxDrN0lwAsZ54Vo8hX4wt4q4y73bHcLuWyV6D/xn5mDp+kKBfOen0WctdlwdADtbnVbHKPRH016ovPSXZNRkLbewT9jrcAaHYHhAcoY1LVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039897; c=relaxed/simple;
	bh=YGJIzKe9bPUamv33TRtk3adS2klN2aPE5f8iLZyx3ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtokmIFYTk/3rwvNR+QoKjhDgpdO+Ig2iflAB/3h2Lh1a8gmlta/X6N/26BAyjf+y9GYHoMmrQvbijTOVZEkcBWaKLxWiCDic/0BItQQjV+P9/5fkJ9eGIG52UFtsbLTq3cPFv5miQqDUzuNzh/I+L6bvhgYBIzbzoYrjXn4a40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cTkkFEZi; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d399da0b5so1494981b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 07 Aug 2024 07:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723039895; x=1723644695; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rimw5Jn9uH+cdYJjb+50EhdPc5GlcLFDSEPep8LTiow=;
        b=cTkkFEZi4uxgju6ytG/iQaEckyKiSxKaVNDn8Ykixf1w36GISpicieaG1p37ek/DF/
         oDVjszsmivuTDprnxJFDNmvNj76mYzdFiWGIsqu402DBTNQG1mMFrCwXSsZlLkAv6LC2
         bmzjoQ/p1/yFy3eiu3tj8iNkzCO19/nve14DBISHMbYiLLkzmImf5VttoW6NSXbKuZt6
         wWMnB3HBAffz9jAmmdQOgbg9XjMCsLPlgZXFv7R7lMFIzYkaqgzuv7DuJ4A4e4TW7irW
         e5uoPyRqxkeKEV3l462sG9qNTi7mZQjU2XVcSRe3A2+e9FkgTrxjdjoJ+SxjrxUcaCM5
         wRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723039895; x=1723644695;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rimw5Jn9uH+cdYJjb+50EhdPc5GlcLFDSEPep8LTiow=;
        b=QBUGfEYC8QHKxTC+Al1tgmMJMcYng70K2q3WOOU0cow7G4YmpOCEuH0VfWulorliwS
         WEi7PgdlU723DlgHVdunzyVdr4NlLNvSbLW27K3C+GMY3jI9sUTF2lRBMA/dzZ4QGRAq
         WNG+sAjDl46TPEPPZzFALyOpN+zT20q6mHajAGPRB5bcMouczm1RpLSRKx8gMXMidfEd
         M1Ly+n4XRzcbaye+X8YNH+s78J+86vHDTYjz9GpNUnLUhInbSXgHgHmA+e8KcwkxEeXN
         a58SqgXfdPt37ABI0dghRDmj/UUNfSulkSdgFKGGNF0eftn6FyJ7FKFziSTn+gVbVL7f
         cTIA==
X-Gm-Message-State: AOJu0Yxo2fI3z1us6U3j1L6PkiGYyV4YYaDqqJ/1zKqOSRGbWnBxYKd1
	YJodFttsEdciB6JUGWJD6VMXHzmM2JNwCPzYFSx6dgEc3jjlMMwmE9a2+p0omA==
X-Google-Smtp-Source: AGHT+IGodAwSN1lMhVJFTLhKee9VbLa7+wzCnQRfzZCvZUvMjJkNY3ENmfDIA5EFtx44ruALqfnj2g==
X-Received: by 2002:a05:6a20:12cd:b0:1c4:919f:368d with SMTP id adf61e73a8af0-1c69966bacamr27493687637.49.1723039894907;
        Wed, 07 Aug 2024 07:11:34 -0700 (PDT)
Received: from thinkpad ([120.60.60.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7109d5e0318sm4277892b3a.121.2024.08.07.07.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:11:34 -0700 (PDT)
Date: Wed, 7 Aug 2024 19:41:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 10/12] PCI: brcmstb: Check return value of all
 reset_control_xxx calls
Message-ID: <20240807141117.GK3412@thinkpad>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-11-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731222831.14895-11-james.quinlan@broadcom.com>

On Wed, Jul 31, 2024 at 06:28:24PM -0400, Jim Quinlan wrote:
> Always check the return value for invocations of reset_control_xxx() and
> propagate the error to the next level.  Although the current functions
> in reset-brcmstb.c cannot fail, this may someday change.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

One comment below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 102 ++++++++++++++++++--------
>  1 file changed, 73 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 0ecca3d9576f..c4ceb1823a79 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c

[...]

>  static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
> @@ -1478,9 +1514,12 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct brcm_pcie *pcie = dev_get_drvdata(dev);
>  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> -	int ret;
> +	int ret, rret;
> +
> +	ret = brcm_pcie_turn_off(pcie);
> +	if (ret)
> +		return ret;
>  
> -	brcm_pcie_turn_off(pcie);
>  	/*
>  	 * If brcm_phy_stop() returns an error, just dev_err(). If we
>  	 * return the error it will cause the suspend to fail and this is a
> @@ -1509,7 +1548,10 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
>  						     pcie->sr->supplies);
>  			if (ret) {
>  				dev_err(dev, "Could not turn off regulators\n");
> -				reset_control_reset(pcie->rescal);
> +				rret = reset_control_reset(pcie->rescal);
> +				if (rret)
> +					dev_err(dev, "failed to reset 'rascal' controller ret=%d\n",
> +						rret);

I don't think it is really necessary to capture the return value in err path.
Unable to turn off the regulator itself is fatal, so we could just assert reset
and hope for the best.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

