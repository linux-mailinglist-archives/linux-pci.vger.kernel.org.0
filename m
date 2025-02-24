Return-Path: <linux-pci+bounces-22271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39245A43110
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 00:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04CB1189F202
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 23:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0266420B1F3;
	Mon, 24 Feb 2025 23:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYqV/Fnl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD120764E;
	Mon, 24 Feb 2025 23:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440375; cv=none; b=E54TsxEmxuxuSzP35t8PUBIVPNF80zWBJuDyWGBghD5uCJRVNx+a+Xgl6sMSZ6qsLYYjOrM8nPByLSsri0tNoM03M1dpslBjXjtGTBYUdX694IHrwzT9oeFMV4JTq4GQXmWEm5KBkgb+oBEC4cUXjbC723+AU0SvvVXaB5Z4GXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440375; c=relaxed/simple;
	bh=H/fdp/lgu3P0d5FbePVHc4hZ2QR1bTnY+ap8F4xxnTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiZmLR3M+vPl+LLdAKW0SCln1ZjT7toV4uWKQzNHgEVUoQh/0/GeajB3XAnN8QgPaHCRWaS2goAH8zPS6gJVL0Dozxugw7V0yoB7MjqcmaLYQyMuIQPlx5gL+Qcz9k5zhFzWV1R6j2k0mXcJnZT8nSkvSbSmjAh9uRAYhbwdzKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYqV/Fnl; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c08f9d0ef3so313040785a.2;
        Mon, 24 Feb 2025 15:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740440373; x=1741045173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I28BvW8sYtCIJpp5k7EPbcyeOkG6IabIbB4ctmQvitg=;
        b=QYqV/FnlF6wRmuqUBjc7G0d3RMsYFXcyNCDJbfjy/cVE0Wb6PJTMdeAbUwt768N0Lj
         yWLOsfHr7F1ahy5seuw+y/qi7lUbm9JFbG/e0BslmJ87TIh76xLbv1VCJj71q/wvC8sT
         78mC1fTkpOBTQJqpncgBIh4DSQjtmpcvwZ0TEYFzLh7hzhu2gKXAEeZIp8k9InEt1Zue
         iEO1/a8GX38xZ4l57BHL+1GL9+e6sTSX2XwlGjV+NgmEhw2uU6z5LTV65lOlXzlSpZ9Z
         6/ZIgjLZKWybd1whc/thl86bpNOuIolQC8F5f9eMG9IMB1wHcvNTdVBak1NJcbcS7ETd
         LKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740440373; x=1741045173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I28BvW8sYtCIJpp5k7EPbcyeOkG6IabIbB4ctmQvitg=;
        b=tbX4DowWRn5BOUoEtv+sCOtAt8qwMADnHP5XNvVap0vskIfxGyswI5XPDCvB0MVKIo
         9VUZRMQKIvgS5T/uvAQjzfbg4RIcIqDekWoCx4gwZBxyw1wmwshF3042kKMLq63ubofp
         XBZjqfwIhNSJ268V7lE6BvAD7ldLF6xit8kHYfAS6/uxYDh7CpJ4t1+Py/eF9Oe74LYQ
         w3bzoF9LZBrRXPZpxL5Imh/3T7kt4monpMUSVlsMykd1hprWf3kouEzhtCa7cXJT1ubi
         7/i0ADwW07jsBhZ2LLaUyNVCX4jlkSY831OUEJCJUv0eqgM+4DoaXPiffkpS/coZjkt5
         gEmg==
X-Forwarded-Encrypted: i=1; AJvYcCUp/Ym4/yL7oyvkqFSC3Vg0/WuQrDB3ypl5l3whjiE4igmMOHGjQ1Gdl2BA/rbJS5tmIt3RDWZwWc7s@vger.kernel.org, AJvYcCVaECsvMCadTnnMwCDncxFI74U5jgzQvDp87G+KbqMJN1C6ti+kY7dSR1/Diy1XC7TEWENnCQw68QYU@vger.kernel.org, AJvYcCWyPo5N2Eh5kLll881SXbcOnh+LSAWpT2kX/gBOTAQS4nbCmJTGpXoZRuAqU6xBKo0jajAFPMcgkCg5HffM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6fhYbxsROlU75LUN2hApDZKuu5iOarudIl9QJNIMW7y4QATr6
	CiwIJVpUqe5wdTfXrH5hir1ay45FdKHXe2rsdA5kDGBG33NE5GwY
X-Gm-Gg: ASbGncs7rslTv6AXl4vrU3izeKX9D0nFZCYhW3WI59WnE4VXx9V8D61f+K3MM3Q0sVY
	wiP9zyhxOGTVw01tfxyfdF73ZwuNfUEeA7gB1Xn1DayXgJPMp9Su//Fib83ivmi1TpakBbBb3wK
	dQMG6MngTZkRiOA+acw6F96apB5taZxIhCwU293mlW+7LEgAfmHIMfE6tSNZg5VA6l957+h62kI
	gDScbg6KSz5I4H3L7k2YllOgWzMIxuBqCSjp29u2RdYHcioFOX4F/JQ1rt81Fa8WizEf6aUodE5
	aQ==
X-Google-Smtp-Source: AGHT+IFwSiY82sk1UHPy1sh4TaxDRFtt/bKpmiKYsLl62LaJzeIFLc36bW8vjGEj+Z6l8tQnP1hrSg==
X-Received: by 2002:a05:620a:600b:b0:7c0:b368:5d78 with SMTP id af79cd13be357-7c0ceeea4e1mr2231799485a.9.1740440373095;
        Mon, 24 Feb 2025 15:39:33 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c23c299259sm35457385a.14.2025.02.24.15.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 15:39:32 -0800 (PST)
Date: Tue, 25 Feb 2025 07:39:13 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Niklas Cassel <cassel@kernel.org>, 
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/2] PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver
Message-ID: <jq55rzcvcp6bxfk3klkomr3gtzqgkwqb2qpjnfndymomaac6ry@5jmzq6vlpu2u>
References: <fanm6m6fx6cqwalhdvrxmjzsluiyptbvrwbi5ufwbqmxsf62xl@lntprhkjv6tm>
 <20250224194725.GA473475@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224194725.GA473475@bhelgaas>

On Mon, Feb 24, 2025 at 01:47:25PM -0600, Bjorn Helgaas wrote:
> On Sat, Feb 22, 2025 at 08:43:46AM +0800, Inochi Amaoto wrote:
> > On Fri, Feb 21, 2025 at 05:49:58PM -0600, Bjorn Helgaas wrote:
> > > On Fri, Feb 21, 2025 at 09:37:56AM +0800, Inochi Amaoto wrote:
> > > > Add support for DesignWare-based PCIe controller in SG2044 SoC.
> > > 
> > > > @@ -341,6 +341,16 @@ config PCIE_ROCKCHIP_DW_EP
> > > >  	  Enables support for the DesignWare PCIe controller in the
> > > >  	  Rockchip SoC (except RK3399) to work in endpoint mode.
> > > >  
> > > > +config PCIE_SOPHGO_DW
> > > > +	bool "SOPHGO DesignWare PCIe controller"
> > > 
> > > What's the canonical styling of "SOPHGO"?  I see "Sophgo" in the
> > > subject line and in Chen Wang's SG2042 series.  Pick the official
> > > styling and use it consistently.
> > 
> > This is my mistake. It should be "Sophgo", I will change it.
> > 
> > > Reorder this so the menuconfig menu items remain alphabetically
> > > sorted.
> > 
> > I think this order is applied to the entry title in menuconfig,
> > and is not the config key? If so, I will change it.
> 
> It's the title shown by menuconfig, i.e., "SOPHGO DesignWare PCIe
> controller" here.

Thanks, I will reorder it.

Regards,
Inochi

