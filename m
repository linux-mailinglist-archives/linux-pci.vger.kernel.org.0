Return-Path: <linux-pci+bounces-27270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F2EAABEDC
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 11:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231C83BA85E
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 09:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE2A279900;
	Tue,  6 May 2025 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ddM0Sm/O"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD852798FF
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522511; cv=none; b=IPt00ETn0pLr6HmOsYLnsARwkWiLXf+6rugOsF4po/B0/a/egLAua9TJejVp8EOXxocEw6B9pzVENOM7r7SGRnAQFxfADcQTsApODQ9Zfji1OvmhB0AmupWj8bW0Lg/kEF34fEmXzAet6/vu9Wck5tjgkXqmPeyzBMw4/XlvqoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522511; c=relaxed/simple;
	bh=d6/zglS/nlcjS8ZEaNWrjIo70157TXNnQ7F6PIBy2X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrmjGlAJQzMcYbbcb0RoNV2F4ukPjp0mOkg77S2Itr05NoCyFv/8OBHCPM4vCJnY3zABHKAPz/Wk4DEvs3eTf4lM2pdMjLtAm/3m3wNd2b6frDS9FdPKPiQtIUprmfzm8JBKAcjeum/z1C8pkDpPXh1fPPnXCAxS3ymYsCWYkC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ddM0Sm/O; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=MWCDoJQT9MFyFtLgnPCusrmwJX5toolzN2AmOgmAr0M=;
	b=ddM0Sm/O7xY63uIsMd/bqv3ltc6EXUQwACxI5oSi1Z79mMYzbqsB1fWndiFvfs
	SISR50SsLMZjKrwAXC6cECBp6a3ApqVmgSnXxnthA8mJSp5YQ8Hadp85FnV4cyUx
	KIsM4eaa7kUcPuJWJXeEy1YMLtwSwH1OjH4Aa9225sRcE=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAnpyw80RloFadeEw--.56664S2;
	Tue, 06 May 2025 17:07:10 +0800 (CST)
Message-ID: <cce17611-edba-42a4-8755-d227eafc0648@163.com>
Date: Tue, 6 May 2025 17:07:07 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] PCI: dw-rockchip: Replace PERST sleep time with
 proper macro
To: Niklas Cassel <cassel@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Damien Le Moal <dlemoal@kernel.org>, Laszlo Fiat <laszlo.fiat@proton.me>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250506073934.433176-6-cassel@kernel.org>
 <20250506073934.433176-9-cassel@kernel.org>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250506073934.433176-9-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAnpyw80RloFadeEw--.56664S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1rWw4kAw45XrW8Gw4Durg_yoWDWFgE93
	4kWr47Zr4DGrZ3Cr1jk34xJrZ0ya47Wr18WayFqFnxZF17Xr18JryrXrs0qFn8KrsxArZ3
	Kr1qvr40kFyxXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjX4S7UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhJFo2gZvJMH3QACsI



On 2025/5/6 15:39, Niklas Cassel wrote:
> Replace the PERST sleep time with the proper macro (PCIE_T_PVPERL_MS).
> No functional change.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 6a7ec3545a7f..0baf9da3ac1c 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -225,7 +225,7 @@ static int rockchip_pcie_start_link(struct dw_pcie *pci)
>   	 * We need more extra time as before, rather than setting just
>   	 * 100us as we don't know how long should the device need to reset.
>   	 */
> -	msleep(100);
> +	msleep(PCIE_T_PVPERL_MS);
>   	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
>   
>   	return 0;

Reviewed-by: Hans Zhang <18255117159@163.com>

Best regards,
Hans


