Return-Path: <linux-pci+bounces-22863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 308A2A4E479
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FCF417F18E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264F7278119;
	Tue,  4 Mar 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PcHRxeoJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F562780F3
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102339; cv=none; b=ZKs0T9Hh74sOwsfVpPfctK/luD2bRNmpWG2RkFYx0seeloyKnCQGzgWGZpVVxs5lQ11Iym5q6Z5ibIh+Q9u6H3OsRWhuM6fbzVCWRGfZIuxlFftQUh5JZzVOzMdo6UUOn8NPG60enacrmuyyVVkQ8QLmxVV8B2sLehewKjHL/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102339; c=relaxed/simple;
	bh=jHsoS/QfB3OLT+xMvFjIYwKmEM5bHtcU7LWt7y8mak8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERKXbUH+eAO9/Ap88Ehe0nx7DLQWxe0cs+mUgyfiJTl8YEDy+ygOoMIgKIijREtk7tSoLZ8EpJmwC8/6PS1yZxQ8nM70fxy2TrFIHho+nVz8HgHLbIFD20v67wpAzOu5FVllFSbejNDy1ELGPuHDITHuJ8BWygqS7mv0f01QKXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PcHRxeoJ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fe848040b1so11925607a91.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 07:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741102337; x=1741707137; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9J55i6SaAxXDmk71XUiDvvdHDUMorv5pKHh75B2QGvY=;
        b=PcHRxeoJRnnQsqqnpmTbzdbJFuUoQ6wslJvBQ1oXtZ6vlbZ6aI4+N14wW2b8UzUPxD
         /4WdAv8otbQKOIfVurvDb67QKRHwWuADKVpEFmvbBEUzy09otdz6SB+Q1FmmKFWYnL0G
         +Wo4JsWoPhupopYXMMzgma901JP6G5E+WHm6rQSkBFtNlhdszAnhDHFC6wxrvzEhVZDQ
         he/qzQQIGyRHK7n+/AyUYR1/y5AZqocZfAkyin6P3kLx5K8EbTbcwJBstocmJR1tErbA
         VrEL+Y+s0hn++WB4IUEuYsutvL+TzXzLRd1AO/UwNM6YVPJ0+vBpn7cbl0eud2eIm3XS
         /elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102337; x=1741707137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9J55i6SaAxXDmk71XUiDvvdHDUMorv5pKHh75B2QGvY=;
        b=UG/nzi/j8CS26NEGEH/KTjRD5ajdfPSzhcvTrOvsjTdUqVgXSVWmR1BIBjEDoYKELz
         OKBG+Sx1+YDFtSSm2xjDSicms+x0fB9qvSWyjL5smHIJlXBAXAeDyLeHSlmkQiDAXmCN
         x/Am3lBkWPOmUyBCn6Mb3uogidwWrFqJho5fu1riixKE8zFPFH8z44wt/in2HQBHr1qA
         RzJtOkddOznptBR7GYMFIOjq6fpVeFeexfF7+sOM5mYP8bcRFKGJ9YcMMwwcPDyAu4T/
         N0W9X2QYWPSPavuJ/+Fy7/zf5jPbv8kDH9E0xTmpRoDBwcBBEfM7C0nf2Yc+5IglHbOF
         09Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWsCxzgi5w6yTalrIT6fSDrK7iUKjxKA996iCoHdyxZtB44i2b+vlKaaNlT93oO+6+7Y0iuNuDhlgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5UudpZY9bpiEwQ3+hlmVoTK1n46hkhvD6Etdy3A89Lw5V7tr9
	/O/ejqiyK9O/Nk1RIpyRxfXsSYdobNcD2XMgSsHOvJOGEmzsCrsx8nyg2r2n4Q==
X-Gm-Gg: ASbGncu9w4WgrSMoQOC2HIbBSS0128eOjt6uH9Q1fPgaBYoMbsYk2HYPax0o2fjBnVg
	ADaRWOlbWLYN+MQBPhULLiEiyrjIX5RP+M0cJ/BueY6YrV5BIztZf7ZrCDgsAcHsTRaoN1uQYDI
	+hxX6DozbOLE5+W63pNC5uNTglT0i5+xaWxj6r+T2qW9HeNf00XuMf89W6MCqBGvHMasfVi/9nG
	Qu+zZasDOilr2Ssl8pw0fmI31dah9oAtdGR1qiWmMXOFUASuQSadCsPMzN6rdImWRT24oMvK8ib
	GROLrwud1i+xS1ig8UoJ52ZWmG2TcGSlbPAX/9YyfjNgDlTs84cEgpE=
X-Google-Smtp-Source: AGHT+IGGf95zBxRvPRSEYDsTC4/BBUP78sumCmzYhxc9letUVVeTQ59a5edLgdJXdoWT1eIqtoqw6w==
X-Received: by 2002:a17:90b:2888:b0:2fe:b907:562f with SMTP id 98e67ed59e1d1-2febab5e112mr30851643a91.14.1741102336858;
        Tue, 04 Mar 2025 07:32:16 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe8284f076sm13309640a91.42.2025.03.04.07.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:32:16 -0800 (PST)
Date: Tue, 4 Mar 2025 21:02:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Fan Ni <nifan.cxl@gmail.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 5/5] Add debugfs based statistical counter support in
 DWC
Message-ID: <20250304153206.gr7footrqrpc5uxf@thinkpad>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132043epcas5p27fde98558b13b3311cdc467e8f246380@epcas5p2.samsung.com>
 <20250221131548.59616-6-shradha.t@samsung.com>
 <Z8XuuNb6TRevUlHH@debian>
 <20250303194228.GB1552306@rocinante>
 <Z8YZEALV71PUkXpF@debian>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8YZEALV71PUkXpF@debian>

On Mon, Mar 03, 2025 at 01:03:12PM -0800, Fan Ni wrote:
> On Tue, Mar 04, 2025 at 04:42:28AM +0900, Krzysztof Wilczyński wrote:
> > Hello,
> > 
> > [...]
> > > > +static ssize_t counter_value_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> > > > +{
> > > > +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> > > > +	struct dw_pcie *pci = pdata->pci;
> > > > +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> > > > +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> > > > +	ssize_t pos;
> > > > +	u32 val;
> > > > +
> > > > +	mutex_lock(&rinfo->reg_event_lock);
> > > > +	set_event_number(pdata, pci, rinfo);
> > > > +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_DATA_REG);
> > > > +	mutex_unlock(&rinfo->reg_event_lock);
> > > > +	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Counter value: %d\n", val);
> > > > +
> > > > +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
> > > > +}
> > > 
> > > Do we need to check whether the counter is enabled or not for the event
> > > before retrieving the counter value?
> > 
> > I believe, we have a patch that aims to address, have a look at:
> > 
> >   https://lore.kernel.org/linux-pci/20250225171239.19574-1-manivannan.sadhasivam@linaro.org
> 
> Maybe I missed something, that seems to fix counter_enable_read(), but
> here is to retrieve counter value. 
> How dw_pcie_readl_dbi() can return something like "Counter Disabled"? 
> 

Only way to know if a counter is enabled by reading back the status. And that is
what the patch is doing.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

