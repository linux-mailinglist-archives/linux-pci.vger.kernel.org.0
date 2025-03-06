Return-Path: <linux-pci+bounces-23048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2D7A546C3
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 10:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CF416B163
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 09:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8737D1FECB6;
	Thu,  6 Mar 2025 09:46:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0817F199935
	for <linux-pci@vger.kernel.org>; Thu,  6 Mar 2025 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254360; cv=none; b=a5EbklnKu08Kymmu6i9oau2jo7QYnlZYEuz7MXa7zXKeDNiLv1xCjRwJCmGBWkYXBuLB2DrOwFIlOWg4n2g+0f5dAZsGmw2R1un+AU7tG/hiY4KudziUTn8V0Ow+68YHNh/Yf0NqEAnlMtdrQKUzGMRiEBEI+AS69WKB+KiTaFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254360; c=relaxed/simple;
	bh=huDVxaKDPr4lEuEdrmPhpWEkxYnxbV2qyhg2mMaRhs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZM8YwMwYxVt9YkwUNL3hmOAcWWq1HbgP9AAt9T4hu8uG9cERUvkHt16ZkvReNYVP4cVIuYUmukgPcycoeYxLMStWJVMSVMTDmBGUvWoM3quVNpVnWXEbIUEnkqUgj5TF+lMja3eNPN3+0zwNwi2WNysdKDdxKxnqq3CB7W2Vm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22185cddbffso30951535ad.1
        for <linux-pci@vger.kernel.org>; Thu, 06 Mar 2025 01:45:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254358; x=1741859158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXUoH4HZnVXuhabgJFpZSeLP7B2PIeHvPBHNrCPg7aw=;
        b=MqgoPCjPnz6mOJwbGZtc07H3LlbtpHbH5n8uzKhWtdHaPf0TRWwMYAwcVg3e0dkZTc
         pt5zSvOAT1dYGIhZh007zoZgwWVPnz6dxUtXvtp59Dger54N8ecKNpyN77qak+zPQ8ET
         /x/8gLLCZISVd5VMpV4GfjKGOKKjMU+M9E3G/ffwNxuHK+b5hEHN6WA+UfrtSwXpYLSE
         7MQ4dmyweCn3RpOsnPxOPGMGfn5u3S4TgbatYygnoy+uc0uj+UbXJP9ascSouN0ybD6d
         jyGDJyJp2xpdcRzSWtmE9qhMpRTwoj3LNuJa8qajB3UmEuBH/vFAuVSHsI8/IPAOrLt+
         tjdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0PI3aV/DhxNggj7R7En5nt2SYjCgPyW+OjVXRvXmLQJzja+vLJeb9QxzY7LbE4Fyouygd+PUUruI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5wwd9929aBEj16qMlyhkY3QfuhpyMXJSQbLaKhcB9eBrLgB2e
	oHK1zQpOgaYhLwIGVz/n3CKOdMBnRL2ZF9bURfr1n0sLRNMaIpTd
X-Gm-Gg: ASbGncsocdR5mDXdAOVUXg4BgcTswc4pccCpX24t17ZT9h83wEwqxfnFFGKKC9Af2DR
	lPUm9UiHPZrHCFU4VJGvJOhiukf/hrpjlUcwcBPt4rpZ/wHFLIbF3ZZ78QSwH6fO5seiWj0x5OI
	CRBRVz1PsmZ6nt61AVCCo4JcCgP75SU93+7tBITW8eMLOC0v5xc9nkEhS+cIm9A4+4WU/D5RgDE
	Apf26YxXuB+zwfhNvHoaHFFonNGbd/qGU6FZR2dGwMKgyfgfSoDq/fm6RKePeL3c2PGbNkGTker
	pqsxsn0ExgC1MPlsH3DCEZ8hxWz1sLjL5Hfcap0blhpL20/TcbMwOQXIrKTFBQRcGf9dhBl25XX
	0rlc=
X-Google-Smtp-Source: AGHT+IHk2jFgpVBQ078WFc6yWvtnNQGDofWSk1i45JV1V57MC/e20NtcoW9GcpnWWnicDDlJFFbf+w==
X-Received: by 2002:a05:6a00:3a1b:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-73693e860eamr4326250b3a.2.1741254358114;
        Thu, 06 Mar 2025 01:45:58 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af281096763sm829763a12.30.2025.03.06.01.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:45:57 -0800 (PST)
Date: Thu, 6 Mar 2025 18:45:56 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Zhang Zekun <zhangzekun11@huawei.com>, songxiaowei@hisilicon.com,
	wangbinghui@hisilicon.com, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	sergio.paracuellos@gmail.com,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	alyssa@rosenzweig.io, maz@kernel.org, thierry.reding@gmail.com,
	Jonathan.Cameron@huawei.com
Subject: Re: [PATCH v3 2/6] PCI: kirin: Tidy up _probe() related function
 with dev_err_probe()
Message-ID: <20250306094556.GA478887@rocinante>
References: <20240831040413.126417-1-zhangzekun11@huawei.com>
 <20240831040413.126417-3-zhangzekun11@huawei.com>
 <20250305055431.ugiwvydrdw4rszte@thinkpad>
 <20250305112445.GF847772@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305112445.GF847772@rocinante>

Hello,

[...]
> > > +	if (reg_val & PIPE_CLK_STABLE)
> > > +		return dev_err_probe(dev, -EINVAL,
> > > +				     "PIPE clk is not stable\n");
> > 
> > I guess this is a timeout issue, so -ETIMEDOUT.
> 
> I can update this directly on the branch.

Done.

[...]
> > > +	if (!dev->of_node)
> > > +		return dev_err_probe(dev, -EINVAL, "NULL node\n");
> > 
> > This check is pointless, so you should drop it.

Done.

[...]
> > > +	if (!data)
> > > +		return dev_err_probe(dev, -EINVAL, "OF data missing\n");
> > 
> > -ENODATA
> 
> Almost all of the other drivers return -EINVAL in this case.
> 
> We can update this here, but I wonder if a follow-up patch to update other
> drivers accordingly where it makes sense of course, would be better here?
> 
> Thoughts?

I left this one as-is for now.

	Krzysztof

