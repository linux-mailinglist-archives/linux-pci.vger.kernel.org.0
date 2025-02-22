Return-Path: <linux-pci+bounces-22104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F55AA40A20
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 17:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE7D3AF871
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 16:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7471713C81B;
	Sat, 22 Feb 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bIRYPTfz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5015200B98
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740242454; cv=none; b=u3a7LJOcQeEO/Ru+e8nAzEFEewlJtIMzjnxqiN4BRFRePxWHHhgWi2/9298ciWOhtgEtCiD4B4tUB6N78ni3M3WFSjGpHIL6PPZHE5yuvAVZF4FxLCzbHIZP3iTeVC88azqYKJgoBrcDHx1MegPqN+iICvJoOy/WqlF4Zb7wuEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740242454; c=relaxed/simple;
	bh=RlG6dofeQhSMbUCrjzCISW4dWW3PiiUkCHVSzb3s/xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQUFrGbvJTx7mEo6rqjDN7X7RScAwG+/Txm09nev7YUsoZ6fPtzdHp0c5QIHsUO1PQCKVjTsIPxAZagoJUZ0uXjJN+IcJ4IZh8NBCZg2ywLj5Oy9j8SsZLEIOY6EeMZt63ETNoe1OjcFCIy7OskiZBvrP7Ucz5zwksq8SVtfcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bIRYPTfz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-219f8263ae0so65751475ad.0
        for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 08:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740242452; x=1740847252; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q7SmUkU0wkGg93tuHuPQ8+F/dJahpuQFSIUY8F9FZz8=;
        b=bIRYPTfziicSN4R6DPcO+t1f1rSmIKZIrj0dVlbd8dmQBumHFtiUdY9Ip3MojqxjvG
         clpWg12Vk1H19eqMVJP6CjHRxHLiw6OyFjtofxU+wxg2GRHrh3gE+y3oPB+TrYQthH/p
         NVESAxtyGxbBIv03MTNPsQb+7kp2kXeILzl+n2c/mEg2DPx/GNaCAUpAPxZqKJ+ANvqP
         Qc8W5K5M6V4ZwbTaT0XmPmUMB59ROFv9n/HuZgJabjFTh1bG0ni/44A+mRK7ACY6vHud
         B7kTjJT7xoeU1I4SD25MqMbrIPNMdVTdMqu0RFTI7sqRlj560MsfBXNbo2VIZtB1aSSB
         Jr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740242452; x=1740847252;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7SmUkU0wkGg93tuHuPQ8+F/dJahpuQFSIUY8F9FZz8=;
        b=pKgqnfoE/Kz2Ws6FVWmpzaSDYWdDb77y6nhTkoqHKJ9PuNWXnSn8minyOF4vb087tN
         Z/v00I717LXOROil8/clT1S/fzZ4Y7aN9yZX13KPp/jXcLy7ThRjuCTcyp4Hevw0bICS
         5pHwzdKOCekiqbpEZVo2mpP7brmvXKgo/pzKIVbtmQNdx/lbQdB4MvF0RBbd088IVHj2
         OgGkUqamOU0B9EG8CHWkMk5ubbcBjQppo9S3lSxoINt/klNgYkwaphB1MTSwNhNRSSdg
         bKocywL5cEO5MaCOHGW+BV7xGAy/I3GclHg1mkF5vPORP6w3cEDA6HQWZ2bEV8I8k8ij
         3Vsw==
X-Forwarded-Encrypted: i=1; AJvYcCV88Eyus0GhzzhbRd00oZRoKuwSOmiSoRX3U1BjV4aYJFgnUX1tjY2PhtrGO4mu39PK2Xlj6jRQTmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgDfwdJINqU0WMtS+GLwwbPgBhsGR7oUgStbKQA5eYg14STnLd
	wkU1naLDUhkj2y4ayUyWgzq5WuaUYUw194ECdgbFdf9zKpdUDQbJVCfUW4v6JA==
X-Gm-Gg: ASbGncsHhUt07mTsZC8PcBxI/iJu1EX1yjJAT+Jhd8VUxBFhVBxNWMwLqIn1TPFEXfG
	tpqEPEAFqQL3IXuklnDE7dnWPszGPfXSfSisbtmHlWFjnkB4rTuiastw07DEGYHTd9o4fXkIes6
	0bs9t2sUIrgdaJfLQNo9nApqoRTl6N/vk/GYKU2m0THGbVSFYqAAr5zqR7Tn3SDLeYvvCRUYm7W
	zP4n2aGH4BL0HNhWneZ7v8RSLHatRzksr2I6Qs84lURbJzK+LJCuKxCjeA4v7JijsOyuG4ICr8b
	eRgMAbKhUeIqkpTDxT2pHYPj/83wuF9e/JreIw==
X-Google-Smtp-Source: AGHT+IFEDHZtuniMfOeDjLrVBa5hGySK9NWCQAT8oNjTSS7bMd12a1VSSCxQNJaxtxTV8J/i8HbMHw==
X-Received: by 2002:a05:6a00:4615:b0:732:5651:e892 with SMTP id d2e1a72fcca58-73426ce7667mr11977154b3a.14.1740242452204;
        Sat, 22 Feb 2025 08:40:52 -0800 (PST)
Received: from thinkpad ([120.60.135.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324276171fsm18225136b3a.144.2025.02.22.08.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 08:40:51 -0800 (PST)
Date: Sat, 22 Feb 2025 22:10:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Hans Zhang <18255117159@163.com>, jingoohan1@gmail.com,
	shradha.t@samsung.com, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [v4] PCI: dwc: Add the debugfs property to provide the LTSSM
 status of the PCIe link
Message-ID: <20250222164046.b7itpksdlmchrnby@thinkpad>
References: <20250222143335.221168-1-18255117159@163.com>
 <20250222145432.GB3735810@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250222145432.GB3735810@rocinante>

On Sat, Feb 22, 2025 at 11:54:32PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > +What:		/sys/kernel/debug/dwc_pcie_<dev>/ltssm_status
> > +Date:		February 2025
> > +Contact:	Hans Zhang <18255117159@163.com>
> > +Description:	(RO) Read will return the current value of the PCIe link status raw value and
> > +		string status.
> 
> The description could be refined a bit to make it easier to read.  But this
> is not a blocked and the changes otherwise look good.
> 
> Thank you Niklas for testing!
> 
> I will pick this up if there are no objections.
> 

Not yet. This patch has the dependency with Shradha's debugfs series:
https://lore.kernel.org/linux-pci/20250221131548.59616-1-shradha.t@samsung.com/

- Mani

-- 
மணிவண்ணன் சதாசிவம்

