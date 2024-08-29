Return-Path: <linux-pci+bounces-12438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5105F9647DB
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 16:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91894B2482F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F701AD418;
	Thu, 29 Aug 2024 14:16:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E50E19005B;
	Thu, 29 Aug 2024 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941001; cv=none; b=gvlDS+WmIDbqVC/wluvl8sl5WIyT7M/UPs5m5pG2KPcAz38Z9UZ+2eVuu4VM7DbTAqrZCHZSHc4AZMMp5vZ2DR6OT0W8CgrrNAweWfbXYL1DWHwFNkageVE0YBrtpwSjnYJIdlshrW2dZk5/O/T25x/jFpQ5/qCgYZi4jJ7wnwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941001; c=relaxed/simple;
	bh=tECZU7mql8sjrz983n7f9Ehzd3ecd772DREuZHxXL3o=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fSP4+TPBv+57n/nG3/1MqwA2L5Ll9qWkwKmMyLGQ7xcQ370kdFQnUflMOrOh1LlyEbpD13WwPwKliIPu86HrR/x5kztCuQeXMI96A1UGe5HjFMY9cBYT0ye5D9QeG2Y7gbrDrZX2VGRJA68VJITml5nlDJDJIStqxdcJc7ZzX6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wvjrc2ZMNzQr6Q;
	Thu, 29 Aug 2024 22:11:44 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 66BE51401F2;
	Thu, 29 Aug 2024 22:16:35 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 22:16:34 +0800
Subject: Re: [PATCH v2] usb: xHCI: add XHCI_RESET_ON_RESUME quirk for Phytium
 xHCI host
To: WangYuli <wangyuli@uniontech.com>
CC: <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <guanwentao@uniontech.com>, Chen Baozi
	<chenbaozi@phytium.com.cn>, Wang Zhimin <wangzhimin1179@phytium.com.cn>, Chen
 Zhenhua <chenzhenhua@phytium.com.cn>, Wang Yinfeng
	<wangyinfeng@phytium.com.cn>, Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
References: <196A709D168A9A04+20240829095028.345047-1-wangyuli@uniontech.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <4a26f1ef-9264-667c-faa1-33a7ae69b473@huawei.com>
Date: Thu, 29 Aug 2024 22:16:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <196A709D168A9A04+20240829095028.345047-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)

On 2024/8/29 17:50, WangYuli wrote:
> The resume operation of Phytium Px210 xHCI host would failed
> to restore state. Use the XHCI_RESET_ON_RESUME quirk to skip
> it and reset the controller after resume.
> 
> Co-developed-by: Chen Baozi <chenbaozi@phytium.com.cn>
> Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
> Co-developed-by: Wang Zhimin <wangzhimin1179@phytium.com.cn>
> Signed-off-by: Wang Zhimin <wangzhimin1179@phytium.com.cn>
> Co-developed-by: Chen Zhenhua <chenzhenhua@phytium.com.cn>
> Signed-off-by: Chen Zhenhua <chenzhenhua@phytium.com.cn>
> Co-developed-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
> Signed-off-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
> Co-developed-by: Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
> Signed-off-by: Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---

You should add the change log for a v2 patch.

>  drivers/usb/host/xhci-pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index b5705ed01d83..fabae8420ce9 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -55,6 +55,9 @@
>  #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI		0x51ed
>  #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed
>  
> +#define PCI_VENDOR_ID_PHYTIUM		0x1db7
> +#define PCI_DEVICE_ID_PHYTIUM_XHCI			0xdc27
> +
>  /* Thunderbolt */
>  #define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI		0x1138
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_XHCI	0x15b5
> @@ -407,6 +410,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  	if (pdev->vendor == PCI_VENDOR_ID_VIA)
>  		xhci->quirks |= XHCI_RESET_ON_RESUME;
>  
> +	if (pdev->vendor == PCI_VENDOR_ID_PHYTIUM ||

Shouldn't this be a '&&'?

> +	    pdev->device == PCI_DEVICE_ID_PHYTIUM_XHCI)
> +		xhci->quirks |= XHCI_RESET_ON_RESUME;
> +
>  	/* See https://bugzilla.kernel.org/show_bug.cgi?id=79511 */
>  	if (pdev->vendor == PCI_VENDOR_ID_VIA &&
>  			pdev->device == 0x3432)
> 

