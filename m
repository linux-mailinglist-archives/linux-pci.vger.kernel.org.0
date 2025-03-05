Return-Path: <linux-pci+bounces-23004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25F9A50997
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 19:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A11F3A8E91
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 18:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC7A252909;
	Wed,  5 Mar 2025 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yM7PyJ8X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7B0255E55
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198712; cv=none; b=rwWOnQj8WQMpvyxp9Qy3v8zErrzWQD0zcnLZkGKF+DKuqZZQQOnFZN4OSsnbekgZU1vs6gP2lFV8noGtsUsi/XLlBg797CllpGF/r3IP4Pa9jaLORDrXxa9dKy4z6jaGHJf4O5hX9o0pTOsWn1ToYmSKZigjPlt9O0MAq2aWUNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198712; c=relaxed/simple;
	bh=CHVPeNV4aZlMVIMSYfYeSO8Ba+Yk0fM8VLR/eAjSu4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIz0O4M8O19D8+7i+8O8cAPmJHfJz6YJu4+FZCZ4E+8e7Zt3FxMNxASYMeeB2AHLvxXFR4tCBB9w4rHDq7LRHtlepJU9+iRcRaBCbQmZ9gGS5OWRqGYwowpcbNitXsi40UWYSZHt0cGg4GDgzWCY4Pw2NrD0rhgDk/ocBFyV1qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yM7PyJ8X; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22337bc9ac3so137429935ad.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Mar 2025 10:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741198710; x=1741803510; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oqKBFVD7BmtZnDhxGEB2Az6asxUlkas0B0Pi0JaurnM=;
        b=yM7PyJ8X4kk63j4ccy9lJ0gMgtJ5teBQflWki6SSlA+gugv6ZOhbi+XXFQnSP3f1TJ
         Z6U+mpkx5qRk3MRLL/T0XZggZBuCa6Pobkf+NSrBNmiIkDbs6HH10CDpdor79mZdafrf
         SHw8QZHVtJt7ODMkHICpOHoBneG+dhYOCD9o/o2koj8poTkM9QegttakW7r7Q5uS8X+8
         vPULZJ+wCAD1j+yTbCg+0tEIlNNdtPsmDRFpR1uphrFUzVLgVgI02CU1fj62ltwrRYuF
         whdZeqfJOAmdV6DOr92JhLy6vz20mO099Zm+USL434UxpcOjTRiyIgxFwPhq+vcbHIwu
         fqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741198710; x=1741803510;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oqKBFVD7BmtZnDhxGEB2Az6asxUlkas0B0Pi0JaurnM=;
        b=nA2uDLAU/UVy4G5A5R4CVU2ARORGBCrOyHotegQJ7KW1OeduatOHjzPZ6M2FRjZMW8
         ccUJoEAvuoKJ+mrdjmca6kc4i8DcWymTPnGBn3MhNldyyRQhNuZb9WICSdYaGGq9T7uJ
         nZJLjXt3Bj9UaaJbh0cNQYaMKzmydUQOJCCfGBdbVSbVnlxAA0j+PE4kAYFAlQaYD40c
         UeGAzCZ4zRUe71bDBjrNjzRAfUTJl2WrW8FJaKX/5rJgwz2bxREiaxxkliWJFhtI3lbO
         CZDaGPBMVgWHtjnEVHmimpK04KrnzI/ntU2Jogtb288I6PP2DTbBSljBWiCoj5ueZI36
         8iAA==
X-Forwarded-Encrypted: i=1; AJvYcCXPqEDViq9GPef8J864KTbe3Xc9k9H4ajcWMpqd8dIK15UogifuJQ4uPXJKhPyTUuKrUIvtiSHp/Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyym1NieAaOnS51VV8D8BM7y2QsAgUY2QJXPvOfgzBI4S+YIFky
	f4nhgsIKAcMEJl98cuK3JjLna6/Xc+QBH9PcyIi/1WE1y1SWaDaBAvrHgAb30w==
X-Gm-Gg: ASbGncvTE2qOMiBOt5yjkZkbicicOJuVGrcSrwuOvLJTpuJoZmL1UYLziT73yIVjlNL
	QTi995w4u1GC54LAISMjKMDU35ze9WJ3U5MS3yWcN8oZ88f/HS8PCMxWYkNq5m9Ok7V6+jxxTSN
	Usd5mKPvQ/q1moNNUHaPKad9eY66k8JYdz3dkf6LBgx6/fnQxETKFabJhzzIiT9+gJ4eo1dtK23
	ufNG7gPBBEcBGPnpG8t4GXiiekMByfprS/F1GxIRelJDkofWEuZ+YPakYB5PKl1NgV9vgbFYA1o
	C4bglgIi8bxiWAlpE01u6x1aDZasRENZ3bNqV4bDTgFK1YEUS+FKYO42
X-Google-Smtp-Source: AGHT+IHTeeIhNi/0pb7+gb1R76gjf4Wb38QT5wJFtMtan4n6WS8u6zPjBJy02e3tGW2OydQi15Tvtw==
X-Received: by 2002:a17:903:240a:b0:224:6a7:a5b0 with SMTP id d9443c01a7336-22406a7a82amr15559775ad.2.1741198710127;
        Wed, 05 Mar 2025 10:18:30 -0800 (PST)
Received: from thinkpad ([120.60.140.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350514239sm116134605ad.219.2025.03.05.10.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:18:29 -0800 (PST)
Date: Wed, 5 Mar 2025 23:48:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, quic_vpernami@quicinc.com,
	mmareddy@quicinc.com
Subject: Re: [PATCH v4 3/4] PCI: dwc: Reduce DT reads by allocating host
 bridge via DWC glue driver
Message-ID: <20250305181823.ltm54e4yxaj5etw5@thinkpad>
References: <20250207-ecam_v4-v4-0-94b5d5ec5017@oss.qualcomm.com>
 <20250207-ecam_v4-v4-3-94b5d5ec5017@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207-ecam_v4-v4-3-94b5d5ec5017@oss.qualcomm.com>

On Fri, Feb 07, 2025 at 04:58:58AM +0530, Krishna Chaitanya Chundru wrote:
> dw_pcie_ecam_supported() needs to read bus-range to find the maximum
> bus range value. The devm_pci_alloc_host_bridge() is already reading
> bus range and storing it in host bridge.If devm_pci_alloc_host_bridge()
> moved to start of the controller probe, the dt reading can be avoided
> and use values stored in the host bridge.
> 
> Allow DWC glue drivers to allocate the host bridge, avoiding redundant
> device tree reads primarily in dw_pcie_ecam_supported().
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 826ff9338646..a18cb1e411e4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -484,8 +484,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	struct device *dev = pci->dev;
>  	struct device_node *np = dev->of_node;
>  	struct platform_device *pdev = to_platform_device(dev);
> +	struct pci_host_bridge *bridge = pp->bridge;
>  	struct resource_entry *win;
> -	struct pci_host_bridge *bridge;
>  	struct resource *res;
>  	int ret;
>  
> @@ -527,7 +527,12 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (!bridge)
>  		return -ENOMEM;
>  
> -	pp->bridge = bridge;
> +	if (!pp->bridge) {

'pp->bridge' is getting dereferenced above as I indicated in patch 1.

> +		bridge = devm_pci_alloc_host_bridge(dev, 0);
> +		if (!bridge)
> +			return -ENOMEM;
> +		pp->bridge = bridge;

There is already a previous devm_pci_alloc_host_bridge() call before this and
you are just duplicating the code here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

