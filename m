Return-Path: <linux-pci+bounces-22781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA85A4CC20
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 20:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8814B3AAD20
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 19:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75810232377;
	Mon,  3 Mar 2025 19:42:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5021C9EB1;
	Mon,  3 Mar 2025 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030952; cv=none; b=S7FKTi3TX3qZ/zMJL+dD/HU6BdVnCIbhi2nTsjGYvD+LDXgH7oMdssvJ/iBI2y+Itjf69zP1hyAsPm7Z1l2fNhBvDOljNBisFjQjB4wzb0y8y0vrLLVb46RkmYHw0cRR8WqLkX+Ixy1LQWUFXMfcfrhIgDAKqoC2WqrJclSD1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030952; c=relaxed/simple;
	bh=E166rXmV2gKxDo6lvtPbk6l4dZeaRFuu0JgC4cRRb6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLyIZ8RLUSoDBx5SmXtG+ykUQIhtbuECCqAu6fAe2EN4QDrWb18Z5nQ/0kAXASV2hCMz4Z4XJHZ/Oi4TgT9RvvSmiKtvbi/oGD3KLxbFa9D2VIaSLCnmGnzrgPz6A7w+gN+XVexRCqts2UDvEWN83pgG3GBwo0j5fgHduGvowek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fef5c978ccso2557636a91.1;
        Mon, 03 Mar 2025 11:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741030950; x=1741635750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr7DtT+cBeW7vunNHQDeXWMsjvqkgvHyclExXYfY/bw=;
        b=IrFa5DMr9jb5fy4OZIJBbqabybWiL9SqAB8iGghE9Ca4sKEmSDxF0VNAx8bCU38TV3
         QuXaTQbHfSuaZteYbiz54/xKkUjCmdK8iHtekqGHw/TH1NXWfxBE9jRImUn1wVMVnANd
         EufkZeCL74x/hVAupWzVkya3MCuuWwfl3bVWCjPqPO9yn9yIx+Z5gP6LEw2I+ZYz6GGh
         BbWkfvhtlOnep0D1n3dS1ehRkBpqz4IiOiH74wWbOB80/1qTWhoB2zaOPh9b6MCYP4Nt
         QVtMcsfBIdTjAEs7scFSa8wO3LWNJ56DXj+p9YX+uUcW3hxcj671f/CrKjRYmBvY98FZ
         D2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVFG2OXTRAxVSWrD7+n77RY7hkNNaAFU+8eBCse+i272Gyon6PIchlnUphwbgEinH7IJ9lEy+mNWsGLaQyYo8IAfQ==@vger.kernel.org, AJvYcCVgm8VG2g7oDbhtWpct8K6iiT+wb3BY1NOkMMWObWRxD9dj5hvZbwqmukB8juP7rn1t2YpexzoL0eWX@vger.kernel.org, AJvYcCXG0MAhwJUFHkfbK6VR7HFjPV9lOMcpH/CLkeQVugyin7zi53MN4HAzqtFrzfUAZjNiVdOFxD/bzX1Ab20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVUJo4plKAjzE1XDH8GAKaiLsLM/zauToFVKpqlREqDiukkgAd
	F0APBNuhyoHtfjlt87Gu0USLoed22wVXO/VXACoZvJBW+YrYjPFr
X-Gm-Gg: ASbGncvpU6yzInTifvlnAfAhB3HEVbn1VV30U2qX96k3Rl53x85XoCes6dX8NDp5jTJ
	NVzGz4SK0aoTNxd3tSVekuIQ7/URc5/RS9oMgYvRLWVWOFG52OTpPsgNPndf5ZZxgZKgeTcNr6n
	BhfuqUBZAc+17W+L0zInDCdz699eGw1LlvutBj8EkJbbt2GM71X/UGwTag95L368PHVvCmdR8fS
	qWDLEYJXZBfSuJM9kKWh7QtrdKl5Grg/XQghmNQTxlrdilZtqFvP2uOXEXKsQl6zvWRTZKSajVH
	GzVAmp+RGAavFYpzG3HLoKE6121xd36V4T9jRABSx0ILRN8137D+hVUnD5aWM5Yj5eOG32bD0gN
	BCLg=
X-Google-Smtp-Source: AGHT+IHYCQVs+/iE6vvKrmK1B/IMxzVg0/4kX5VfDcWNz3937RP9zksebTa9YiaF4RmT8h+1QZFM1w==
X-Received: by 2002:a17:90b:1b47:b0:2fa:e9b:33b3 with SMTP id 98e67ed59e1d1-2febab2bdecmr20911899a91.6.1741030950198;
        Mon, 03 Mar 2025 11:42:30 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fea67a7ddesm9360259a91.27.2025.03.03.11.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:42:29 -0800 (PST)
Date: Tue, 4 Mar 2025 04:42:28 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Fan Ni <nifan.cxl@gmail.com>
Cc: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com,
	cassel@kernel.org, 18255117159@163.com, xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 5/5] Add debugfs based statistical counter support in
 DWC
Message-ID: <20250303194228.GB1552306@rocinante>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132043epcas5p27fde98558b13b3311cdc467e8f246380@epcas5p2.samsung.com>
 <20250221131548.59616-6-shradha.t@samsung.com>
 <Z8XuuNb6TRevUlHH@debian>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8XuuNb6TRevUlHH@debian>

Hello,

[...]
> > +static ssize_t counter_value_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> > +{
> > +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> > +	struct dw_pcie *pci = pdata->pci;
> > +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> > +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> > +	ssize_t pos;
> > +	u32 val;
> > +
> > +	mutex_lock(&rinfo->reg_event_lock);
> > +	set_event_number(pdata, pci, rinfo);
> > +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_DATA_REG);
> > +	mutex_unlock(&rinfo->reg_event_lock);
> > +	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Counter value: %d\n", val);
> > +
> > +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
> > +}
> 
> Do we need to check whether the counter is enabled or not for the event
> before retrieving the counter value?

I believe, we have a patch that aims to address, have a look at:

  https://lore.kernel.org/linux-pci/20250225171239.19574-1-manivannan.sadhasivam@linaro.org

Thank you!

	Krzysztof

