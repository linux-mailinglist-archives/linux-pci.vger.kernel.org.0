Return-Path: <linux-pci+bounces-22791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDA1A4CD25
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 22:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D227A74AD
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 21:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833A022F3AB;
	Mon,  3 Mar 2025 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEIUtNQE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D71E9B3D;
	Mon,  3 Mar 2025 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035799; cv=none; b=QaHwbbS7+vf2Dby9mAIH6qKRteuRV6Erlp0tzl2qUKRcT8fChHxOc4ETImeZfKmRhIxpqRvowzwMJOBUIVnjav2SU5PB2J9EBoB/1rTh3DLeetvvahnbUgzPy5Km7aLWyyFsMA6UxUdAfTq78eRCEZx1ux0cvc6uAN5n2ya2mBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035799; c=relaxed/simple;
	bh=cwtgwMtlhWsPzlpXc8XSzTumsmavKHIDAJ+Sj83kK8g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pntEAOhAG1ayYGywWGbHLOcrrJK3AvT7C2O6t1+vLcLg061Xto+KBfVb50stpmLq3pekDTpVSyOoHZiQ+C1a18W95c3vktcBMXztd/fTiPiAzAAV9fsIC6dy1c43EbA1yFfCRJxS7h9NviTELLCVYgoenMPH+dv0hWHhPh+eiuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEIUtNQE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2239c066347so35282865ad.2;
        Mon, 03 Mar 2025 13:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741035797; x=1741640597; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B9HBpbXIy/k/ZzJzT43ntRHVnDGFv2MuASArIvtm8UM=;
        b=nEIUtNQEknXXf2OPK0lXdP/AWrX/8uyttDIaXvuvVRVhWltYAOIAyvR8U5ePHC+3b+
         QOq79e27xK2pXNy+fy3985tMv1dhPKAUfSEQFTQ6JyP8DDeFMwfl80W3+bPyaRgXA1SL
         enwIS6vUutTu1+iLHZOtXvD4VqpdBmEZ4TsmjbIUcV6+KfUIqs/qMFjjbMjpf3a3J0wF
         UTDbwMVG4Da+Vc253KRSC3O3CwFz1zgVm6oTNOBvKeIoaGGU7RQrTHHrxiy/vf3yCPQy
         Bdz39KB25jpClgA2wJ6ANx4E8mIfH8VSryvt+loGonrSGnmS8O+4JMSDAUaUUMRG+6KJ
         3JAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741035797; x=1741640597;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9HBpbXIy/k/ZzJzT43ntRHVnDGFv2MuASArIvtm8UM=;
        b=r6aSxn0eKteLkLeLxIeDyMLkqUBWbvcmYthhVLURIHVETIYTvkotnCcf66bZ8MzBvO
         o/5jXxNuTdi2w1HoER7klqlV0SnvSutkHfsrehAa1khjh0NQZtyv6EAC1YICWMh5tCAf
         5OeH254Imaf2o2uRXAIcAEBHBuLgL54JSedIz7VALt6Ibtggj7sOXPezfWz0oOWtXEoV
         DI38RAFQJ7hwVKth+sqMU9WENfdD3hf0dTbA2rXAZJGUDwNtfGQWvPRzGC5oEfqJATuq
         5wq9ZpVXY5NQmBvOzpeE4Ymh0EhB1ttbPXq+0xyi4I/2jqBob7ZezpvQb3cgUX2nzUrQ
         PSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx2NHTa1wco+HP/zWSbNivoz5kGbgot9LfGW5JfoMhuHtUUT+748ECLslQ4b/wu30rdbtaK4TrVBAsb7nwu7no9w==@vger.kernel.org, AJvYcCV7QiJxFn70b1YvUu7TCJSPfC+1vNnlbe+rZBBL0LiUKk2/nwXkpVUPEa6DekZuoK6DMC8F8BcSBdpK@vger.kernel.org, AJvYcCWBO4WWBG/J9T4+pVKBjU3kQZLm/U80K79YzqLanEngU+iao9IL3AYHR4GCi1iR8tun+dzNtJRn20ZESjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzD3pgz6HosBxK7yToHH3TEicId+VodBIWGJJveHMMuNgXXy2x
	+am6Daxzr+0i26wx/H+UeEu2xTjyytU2Q6zfR4nhRglbznvQd8zb
X-Gm-Gg: ASbGncuGm9jgL8cLHe+SiGLHzzkrrxj5CikkZkVgUjvxaAG+yykH23VWmHBzopeuDEr
	tw84fTw3+sFToki5Yf7cryQRLVlOqgAdkAZvBRjuXje1WC58pjhkoKoimI9pXqe1ESXuuUL2Xy1
	w/ubqh8drShwFA6QlcEzGJwOJjhmclIPW/1sTXup9ypTO7sgGn7zdyX2T6+peEyBBgfmzAiBTSo
	qL+9c6aM8Ghvq8SohcpCoWLnwlwKRjQHYBu7P4nt87yqjZJ1StZe+xrbswY4g5w3HNm8nebUhB+
	VRDSOEEdLcaxhKWA/NAm+qkGr6OOMq2/XJhay+o2
X-Google-Smtp-Source: AGHT+IHInytWSAP68J0pF/25lZDGpVvx/ij28c4zW0D1/qGfM3LkSyEL79EClseudwK/bIrxfeuiDg==
X-Received: by 2002:a05:6a00:3cd1:b0:736:34a2:8a20 with SMTP id d2e1a72fcca58-73634a28b18mr15869743b3a.21.1741035797227;
        Mon, 03 Mar 2025 13:03:17 -0800 (PST)
Received: from debian ([2607:fb90:37e1:4bed:f057:b35a:e3e2:4c5f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73630744c23sm5969768b3a.15.2025.03.03.13.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 13:03:16 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 3 Mar 2025 13:03:12 -0800
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Fan Ni <nifan.cxl@gmail.com>, Shradha Todi <shradha.t@samsung.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com,
	cassel@kernel.org, 18255117159@163.com, xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 5/5] Add debugfs based statistical counter support in
 DWC
Message-ID: <Z8YZEALV71PUkXpF@debian>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132043epcas5p27fde98558b13b3311cdc467e8f246380@epcas5p2.samsung.com>
 <20250221131548.59616-6-shradha.t@samsung.com>
 <Z8XuuNb6TRevUlHH@debian>
 <20250303194228.GB1552306@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303194228.GB1552306@rocinante>

On Tue, Mar 04, 2025 at 04:42:28AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > > +static ssize_t counter_value_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> > > +{
> > > +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> > > +	struct dw_pcie *pci = pdata->pci;
> > > +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> > > +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> > > +	ssize_t pos;
> > > +	u32 val;
> > > +
> > > +	mutex_lock(&rinfo->reg_event_lock);
> > > +	set_event_number(pdata, pci, rinfo);
> > > +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_DATA_REG);
> > > +	mutex_unlock(&rinfo->reg_event_lock);
> > > +	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Counter value: %d\n", val);
> > > +
> > > +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
> > > +}
> > 
> > Do we need to check whether the counter is enabled or not for the event
> > before retrieving the counter value?
> 
> I believe, we have a patch that aims to address, have a look at:
> 
>   https://lore.kernel.org/linux-pci/20250225171239.19574-1-manivannan.sadhasivam@linaro.org

Maybe I missed something, that seems to fix counter_enable_read(), but
here is to retrieve counter value. 
How dw_pcie_readl_dbi() can return something like "Counter Disabled"? 

Fan
> 
> Thank you!
> 
> 	Krzysztof

