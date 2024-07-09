Return-Path: <linux-pci+bounces-10006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D3A92BE9F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 17:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CEDE28191D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 15:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE5F1891C4;
	Tue,  9 Jul 2024 15:40:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C88C3612D;
	Tue,  9 Jul 2024 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539656; cv=none; b=ce47gKZ0RtDAO9WKnzA4r1pA+6A1ieEwmnlqiTWXgakkp7sk2HcOgdvTyqzXMpJpXQNdo4NrNY+zjhfiDGzUL0W9stvrwC+rzgsWpXb4Pd6UcU+YqC34Opqb1Vz83Ga65bSee5ShPPvZbv/SQ11dPYEI0J1t6o/GcHR4EVMsbt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539656; c=relaxed/simple;
	bh=yLujh+quyCP5qinagyJXHAIxWyF9PCjlaNWetj7c5k0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lu1kTpeNLgi1heq3i8x3GRyJy1CD8z0AASSfM1dfbTFkyjC50/2tWt2vRh4MT50DmzeEZkF4MDG79IL6V2IJRDD5ITO5M3t0nRcsXyysxzDdKsU/MLXfO1vUWUfXnDTQNVUs2kQqdx5pcRb1gZVF/IEf0aoRsYl+JmOq8Oy88og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WJQCF3wqcz6H7nx;
	Tue,  9 Jul 2024 23:39:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 62213140C72;
	Tue,  9 Jul 2024 23:40:44 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 9 Jul
 2024 16:40:43 +0100
Date: Tue, 9 Jul 2024 16:40:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
CC: Xiaowei Song <songxiaowei@hisilicon.com>, Binghui Wang
	<wangbinghui@hisilicon.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: kirin: use
 for_each_available_child_of_node_scoped()
Message-ID: <20240709164043.0000184e@Huawei.com>
In-Reply-To: <20240707-pcie-kirin-dev_err_probe-v2-2-2fa94951d84d@gmail.com>
References: <20240707-pcie-kirin-dev_err_probe-v2-0-2fa94951d84d@gmail.com>
	<20240707-pcie-kirin-dev_err_probe-v2-2-2fa94951d84d@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 07 Jul 2024 15:54:02 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The scoped version of the macro automatically decrements the child node
> refcount on early exits, removing the need for the `goto` and
> `of_node_put()`.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index e00152b1ee99..7c591f50d0b2 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -446,7 +446,7 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
>  				    struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *child, *node = dev->of_node;
> +	struct device_node *node = dev->of_node;
>  	void __iomem *apb_base;
>  	int ret;
>  
> @@ -471,17 +471,13 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
>  		return ret;
>  
>  	/* Parse OF children */
> -	for_each_available_child_of_node(node, child) {
> +	for_each_available_child_of_node_scoped(node, child) {
>  		ret = kirin_pcie_parse_port(kirin_pcie, pdev, child);
>  		if (ret)
> -			goto put_node;
> +			return ret;
>  	}
>  
>  	return 0;
> -
> -put_node:
> -	of_node_put(child);
> -	return ret;
>  }
>  
>  static void kirin_pcie_sideband_dbi_w_mode(struct kirin_pcie *kirin_pcie,
> 


