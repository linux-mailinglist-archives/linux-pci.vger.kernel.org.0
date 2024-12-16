Return-Path: <linux-pci+bounces-18474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D27E89F2979
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 06:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DD41885551
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 05:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4F319644B;
	Mon, 16 Dec 2024 05:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUG9tTOi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03E101DE
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 05:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734326480; cv=none; b=tM/5T5DqI5QGCSb3OFjvpN1F34RivOmCcGiaNHCmGESF5UZpG6dL8gpU7rKx7wKpDJk7Ol5yhkYrHHF8xm5iuFweIsXbmbTO/fK1mRykj6L1f9u9Jvfoq4tzF3kZWrQz02knZHhqnn+xbUP85K9Tlb2BTMcrihFDvd8ga5JZBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734326480; c=relaxed/simple;
	bh=Y8BBnzSAQCrOq/vZCN+HTxvR9YBoCNxrtJ37hzJJipE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GThYkv1pe5RwhYjMhc0QCLteKKB7ZkEiupNL5DEqFbmxNNFsE8JoAUzr5JDGjG6rTnWuXbE1XVheFA1HzogWWQVdnZ/5b2rBQSDurPOat1QuLnNx3ALQb3FMyDf476JbL96W7qQhSJk0Tt1IB3FxJDRj85gwprZqsNCs2xLT0k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cUG9tTOi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2161eb95317so33106195ad.1
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2024 21:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734326478; x=1734931278; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4dODE1oLOneIGU2zuf4IE3qsFOnpfwOB30wuyhRbPCE=;
        b=cUG9tTOiww1RjLO67ZF7MZEBx2ZWhWnzPi/yxjBMmDuekjT8o3yKrvJMMLid22EiH8
         4Fh6xrtWO5jAqEHa9z3/fP3PG1YKX7+sQM2ddvQWEMcezqf3rQVrpLMcTGndJWKL6zlc
         5XhXN0etfUEgWGRHOwlsH6ig1kqVd1SidyMLiNyw5PuQivJb5HX1oYF/CRg3hT9FKA6A
         ASaE1OFJZ9zTYD4+WEzhx7p7M4+ky72RFoR49kauCnLVkZoFmTOF8ceyOd262C6ldK7w
         PihgrHJrSbgOMShVw2ERnk0B+3uxmE0hI3ED05KglhpHWPRY2miDrySLJdTsdtEEeT9o
         Pfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734326478; x=1734931278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dODE1oLOneIGU2zuf4IE3qsFOnpfwOB30wuyhRbPCE=;
        b=JfPXRtB3MERwE5UuQGfUq8QNs418OMwvk8LiavobvcIl9bH3yx8c7Ku2qJaieRnc8F
         o4q/ScyfbBsDwjhTF37rHGzxBIT2hWf7mESp1UWoyuyloCqr+1GQSMj+CVsT2j8LPNke
         5DC8x4zzE81/7M5eha4hsWYdLURLMiMAQCmC/7odvqJ2LhkCmNzFSl8KF1D4sa483p+R
         WploCNRd5pMgu0B4XxVL7WdG235H0K04X6Sa/fO8lyN7EKztcYUAGEaCS9RQjegMt8zu
         TIYdMmmYg+Ic/PPh4VByuDPaQmGlpR3cBkRFuzwcsP6oMu1RLrTThlWw52r8k6BjnRHn
         etfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWksborxY/OyS1hFcssi5y6AhIxQ+VbZrW66VNDMpVLaIuyKpPpwtxe8i9S4W7vMQZ2v362PLbwvHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxduYzN9lonjGzCpMF7ozvnFiC4qrZoHq2ZfY7idL4o6WTuGCx+
	e/8hI8Vo5SiuPbpg1ny7VKlwJALeP//dKcSJtdyvPMfUtHSxwVInz7gkHy4o6Q==
X-Gm-Gg: ASbGncuPQ7YYVertFAp33VjSv5h/fm9PMb049TydglzZw0u6tq0heTotZh3vtt6tpb7
	EP3uTS/WDHm/y7U3E0Chf4lAxIkPg8ykG0PpFpvzLxwYga5GJwg3PIPUnz6F70zxYV3V1/kHWnl
	o1dfCVIDhvtyU/YyQl+RaExajWRAt1yzvBEOjPMCDju/24R4UXiupB73zZAJyDUCoDClIRHb5Ue
	MjlMBCEa1BpON9Ut2kqi+Fo6ov/bAOwk/H7OndkTVnFAUYKx5adaEn0NWtHC01uDVk=
X-Google-Smtp-Source: AGHT+IH1mSVhE67FzmlPZUxDT5sePvi+vkzZfYMDKYk51As1yvOgwpFk9uK6IoSy8DGi01snoWjo4g==
X-Received: by 2002:a17:902:d2c5:b0:215:97a3:5ec5 with SMTP id d9443c01a7336-218929c8eccmr158587875ad.22.1734326478043;
        Sun, 15 Dec 2024 21:21:18 -0800 (PST)
Received: from thinkpad ([120.60.56.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6416csm34490965ad.230.2024.12.15.21.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 21:21:17 -0800 (PST)
Date: Mon, 16 Dec 2024 10:51:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Qiang Yu <quic_qianyu@quicinc.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH 0/4] PCI/pwrctrl: Rework pwrctrl driver integration and
 add driver for PCI slot
Message-ID: <20241216052107.tyhwzh4g3tmnp5ll@thinkpad>
References: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
 <c5c9b7fc-a484-438a-aa97-35785f25d576@quicinc.com>
 <Z18SkkuPbVgTYD8k@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z18SkkuPbVgTYD8k@wunner.de>

On Sun, Dec 15, 2024 at 06:32:02PM +0100, Lukas Wunner wrote:
> On Wed, Dec 11, 2024 at 05:55:48PM +0800, Qiang Yu wrote:
> > PCIe3 is able to link up after applying your patch. Slot power is turned on
> > correctly.
> > But see "NULL pointer dereference" when I try to remove device.
> 
> There's a WARN splat occurring before the NULL pointer deref.
> Was this happening before or is it new?  Probably makes sense
> to debug that first before looking into the NULL pointer deref,
> which could be a result of it.
> 

Precisely.

> 
> > [   38.757726] WARNING: CPU: 1 PID: 816 at drivers/regulator/core.c:5857
> > regulator_unregister+0x13c/0x160
> > [   38.767288] Modules linked in: phy_qcom_qmp_combo aux_bridge
> > drm_kms_helper drm nvme backlight pinctrl_sm8550_lpass_lpi pci_pwrctl_slot
> > pci_pwrctrl_core nvme_core phy_qcom_edp phy_qcom_eusb2_repeater
> > dispcc_x1e80100 pinctrl_lpass_lpi phy_qcom_snps_eusb2 lpasscc_sc8280xp typec
> > gpucc_x1e80100 phy_qcom_qmp_pcie
> > [   38.795279] CPU: 1 UID: 0 PID: 816 Comm: bash Not tainted
> > 6.12.0-next-20241128-00005-g6178bf6ce3c2-dirty #50
> > [   38.805359] Hardware name: Qualcomm IDP, BIOS
> > 6.0.240607.BOOT.MXF.2.4-00348.1-HAMOA-1.67705.7 06/ 7/2024
> > [   38.815088] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS
> > BTYPE=--)
> > [   38.822239] pc : regulator_unregister+0x13c/0x160
> > [   38.827081] lr : regulator_unregister+0xc0/0x160
> 
> The WARN splat seems to be caused by:
> 
> 	WARN_ON(rdev->open_count);
> 
> So the regulator is unregistered although it's still in use.
> Is there maybe a multifunction PCIe device in your system
> so that multiple devices are using the same regulator?
> 

Maybe the regulator is shared with other peripherals (not just PCIe) in the
system.

@Qiang: I referred your patch [1] that added the slot regulators, but they were
not used by any peripherals other than PCIe. Could you please post the list of
consumers of the 3 slot regulators?

FYI, I did test root port remove on RB5 board (with dummy fixed regulators) and
it worked fine.

- Mani

[1] https://lore.kernel.org/linux-pci/20240827063631.3932971-8-quic_qianyu@quicinc.com/

-- 
மணிவண்ணன் சதாசிவம்

