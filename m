Return-Path: <linux-pci+bounces-41895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAF3C7BA42
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 21:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D1F34E0631
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 20:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0892D2486;
	Fri, 21 Nov 2025 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aqNR1+Wb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA32C21EF
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763757103; cv=none; b=hkxXjE8y3OHKN4ae4jFPncHeEpxpBuVUEZXw2eYuf4RB5K++BuF4KOSIIYOjwlpn1dKPl1qyBUm6IBpa3BzXrm8rg93gs05l4I3KMqwRTj5mhiBncnWLnB0KxrBWvzOSMwdNdVhbol6qtb8Z1yxbuGxcLNaVqDdH/09IyzY+vzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763757103; c=relaxed/simple;
	bh=pa2lyT7lPJyZEw5mcRC6aPDB+evn8VnEjaf3itbvr6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PprYjf8vDXLb0ktTn/f+iQkHojwfgHrmZF0PXzXer+EOk5NSlM8pXjuluuwVwZee4C1cuQX1VM416qNKYlUIwK4YEfeQsPN98zA03m18aWUbbWv9N0TB5dTuBGv4Ol3WTzDcKqlBCN89jVpy3gXeMIX4wpBsTG6F77z8cau7w74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aqNR1+Wb; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2a4b6876fso329518685a.3
        for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 12:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1763757101; x=1764361901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MA/eAO+4QVAKat3kknBRmFeqDu1PBA3lvY9XwQeR9u8=;
        b=aqNR1+WbidCa6HATp8DPHIfa9qR6LRVqeSoWpLWjHgmHMiicg+a27Ap9m6O60kigmU
         IJiiaO4ljfSZ7pnaty4Zx9Vtp596BY2tTW3jFm1bd1HALpg6V6wI6f3DWQcKlo2jznEo
         CpSx1H+dqnc6lpTYkza0SknxfUAY9NES5qMs2qGEzdgdTpXwUGT9KaVXRzWpNXNrwBPR
         2VNkMhrfMHb28pVbv5aMdu63XorjCYOraOasTwqVjp08m2Y2jdTargvQ9iWWKYLenEd2
         bKpOr5x0dgaTD2ztiZbjH+GKrO4Zk/UN4KvnH9TqFbZgEwMXnh2js8ghkexZwhvqCrze
         RAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763757101; x=1764361901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA/eAO+4QVAKat3kknBRmFeqDu1PBA3lvY9XwQeR9u8=;
        b=gcjyPWFEezNy6411k0OBDRKeph4O5fci+qKrKu0LKdy32ZqZ4z9UfW+E1FIYaMJcsR
         j7A3FDBGY+9L6XGT0JtiBlcgPPRdx8ictRfHyuQiI6uHZifT1CdVQfwIEDNKcAwNRsr0
         kSl8JT6U8itXFozn1t9NVVTVi2B18AWm02V877Ysr+UbGBQUtsrr2inyoJ9ezSehpSY9
         ZycfL42pIynmcvEfgUd52x568nhgf9/yOb6bmDA5ydVfIiZW22LI/8cNGfBJkUqaCxUs
         cLNOLgqm/YmTz4LyCrEyxnalaSkjd8Eanekr//kdRMcKFc18IcAmV2Af/F9U4x+Leigh
         fQAw==
X-Forwarded-Encrypted: i=1; AJvYcCW2slBcd0QmK7P4XgUs7pqnfVPRVoJCVfym3lfn+sa2Ng6tT8azP48N7KU6tw9T869vLLW5Mtl6NZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjcL+MPNCVlZTb1AAL+1EUN8/e/Wou5Om7NrzYGnACf9BsxVtV
	vj3KFxgK3L0Ty29ll1BFyj2VVSsMqkgCPOT8ntVyw/c1dB+dYcNyQuDY0w5f8j2Wnnw=
X-Gm-Gg: ASbGncvrXH/Tquq5lwYyxcNKdsB/eHIMxuLoUF5YYEZg6oghVI5M2UcayDTW69OQNKQ
	BMpXCDMgkyBrVaXanB0/Y+jWomW2BOkqEyxGdiebxxM7AbOTDz4AWoBeLywYWQOkTWp3RyjMWZv
	D/CcQhBNVkXJAhdYneDCGSPmjyWf3M6DAmmZZ+xnOm6GoCbiJOZnWLLI+kCCURGPRBwK1wMbHHH
	zs8VVVISJkyRwZ9kkQ1IkC6xybsQpXeCUcAGQLbYa067MowP0UNQ4Yw644tnZyMeR9SEDFPAOs7
	U6s3pxfBAeLDSQkYdyrRXR/eWnGJxmhnJPTz/9gAVZMB+DNbuBj8SeNOZ8ikZ9M+kkZE5bOZWNq
	APX09ZKcDZQ8MYzrC77gMpLn1lcybP+0V7dfvv2+gBTxyib/5dWH/p3UVD/QoWO2X7WTVGtWjtQ
	c4ODNErjSF/c3L7ujEmNkCOWiK9tWwh2t0S8fzSC1WDeo0zrvIBtiUd48vGLi1I8q6WbVV4A==
X-Google-Smtp-Source: AGHT+IEppsMAgXRJUbmHUqOyXXTw2sZ/0rI2kwFa/51WHf2m//HJeX14YMFewHWFyaSeDb/zst1lPg==
X-Received: by 2002:a05:620a:4086:b0:8b2:e2ca:36b with SMTP id af79cd13be357-8b33d203ae7mr408745385a.3.1763757100743;
        Fri, 21 Nov 2025 12:31:40 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db3e3sm428368085a.43.2025.11.21.12.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 12:31:40 -0800 (PST)
Date: Fri, 21 Nov 2025 15:31:29 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND v13 02/25] PCI/CXL: Introduce pcie_is_cxl()
Message-ID: <aSDMId90SsE71p1W@gourry-fedora-PF4VCD3F>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-3-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104170305.4163840-3-terry.bowman@amd.com>

On Tue, Nov 04, 2025 at 11:02:42AM -0600, Terry Bowman wrote:
> CXL and AER drivers need the ability to identify CXL devices.
> 
> Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
> status in the CXL Flexbus DVSEC status register. The CXL Flexbus DVSEC
> presence is used because it is required for all the CXL PCIe devices.[1]
> 
------>8
>  
> +static void set_pcie_cxl(struct pci_dev *dev)
> +{
> +	struct pci_dev *parent;
...
> +	parent = pci_upstream_bridge(dev);
> +	set_pcie_cxl(parent);
> +}
...
> +static inline bool pcie_is_cxl(struct pci_dev *pci_dev)
> +{
> +	return pci_dev->is_cxl;
> +}
> +

We have encountered a crash on QEMU where parent=NULL here

static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
{
        dev = pci_physfn(dev);
        if (pci_is_root_bus(dev->bus))
                return NULL;

        return dev->bus->self;
}

~Gregory

