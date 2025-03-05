Return-Path: <linux-pci+bounces-22932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08294A4F60B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 05:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA46188B686
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 04:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FF71AAA1D;
	Wed,  5 Mar 2025 04:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZZ5iXXn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D019258E;
	Wed,  5 Mar 2025 04:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741148772; cv=none; b=AlHfL9xlAxyPecP9mIltsp7KyahAwQpvSE7gyrD/So8bEO9gk35I/f9hAW7WL9WnOZIm0C9ldHJVtIfDHLEIis4hTtLD991GjHH62vZRn83W4Av6ns6OrdvMkpki7N1exOwQtDhszkzJNIwZgbYou78ag/37pA13KGG56uEauVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741148772; c=relaxed/simple;
	bh=Ma9rbC5Lm1hcZ0TRRXqeaYpaIEccVc7d1Sur+2dI6bA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvIxKhxEGJMx2NFysXiQe8V5L8LasOke40ic2bNZPRk+H1rl8KLX1nEazUIH2yJO+VBiYE/TQ3zccYGnOKcCEJM77t92BBqr8Vo9V0oFZE0xPt+b6qQjYqua1cfdeF/M7NYbDD+kbq8DAuBxmDpTYO6Ovq/SVvrmIad8kdXlzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZZ5iXXn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2232b12cd36so87521765ad.0;
        Tue, 04 Mar 2025 20:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741148770; x=1741753570; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lDbPu0GoIrMl1ekfCD/PMILNRbV5SLzILd3Nw6UHcyw=;
        b=BZZ5iXXnZkls8MGlK7mGB0Vi/yERJ2Uzd4k/d9yW5GwfiSpsFny1oFxvV3wHSlbviH
         +7exKVdMrxGmUi44mU2VEY7IOBItWyB62PtcttjSLGFDl3k1J8wZQeC+kWu0cooEG3Wm
         4E6xUeSU2O++VkFIrURU9cPTz328Is9WLEpErRk28mv0m3NeqMHhgTO3ALXhxZBHBN+E
         /pEo0f36HPsv1YBxEBlOLpmPdoRY8G0TlH92EmTo9WHW72apzBsPR39b/IlgyVSYbI/w
         KzZeyIBxx18VASYFBkfH9F08lMsvSh68vUzpR+uexE/ZWFL1mBWn/M2WZQrq9m65pwao
         SQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741148770; x=1741753570;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDbPu0GoIrMl1ekfCD/PMILNRbV5SLzILd3Nw6UHcyw=;
        b=I3t9u8B7WJ865plYyZTuxLDOy3G4wtmZjqCC1/MLQv/DqYsqm+ftspFB+jaqEcr831
         zipaSibBmXLvYFUoAiEg3l63vTSWGsBkG3nMww+PfOeXiSq0oRt+EzRtXsexbm27skZ8
         YvykqSwTQMoWxq7fpWFSu+LlBfPEZENY2M/W3Z4OFBf5vdhTxEMMHgqApWryMD8EHbXY
         a58n2qvxZbUhBWOUpPFsD5D5QcH+wn4ZC2rTRCzYQ29mkhlOIVtWhQTXoBe8wFIoZgSQ
         bfyEVARvBqZwIJkQR7cHu1efG5P8lWUw4RUNQLVo15BnMa0lySwgYxUDcAlXdHsLtJKA
         Q31g==
X-Forwarded-Encrypted: i=1; AJvYcCXBKsNwWNI5//Gq6hUoBsFTUShhckCR3FLbjwstgfTw8G0m6oIRuJOgGruuLNcX1Lo45cAD9HRv+9Bt6+Y=@vger.kernel.org, AJvYcCXh5prK6wAUZcBfIyzMeVmhDWdlbWcWU2VcymUNaHy8SW29AD6UDX6kwDrxiOfXGrdNAONM5pPw0yehjHtzYhB3JA==@vger.kernel.org, AJvYcCXnfk+OTmOGsJYUCCl3iKWXiBlDlLJQcVuA7zzss3U5pE27QQPiwBRwzKCYbGT6qKQVpm39GUhdKopj@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+TU1jxbU1MSr/6KjZSfRKfLWMT/XOn+XOt87MO2AuWZSfhqj
	3kQTzTZxcKkgpYwNr0bPaGLogKJkaFRqrHfG+Qye70ZQPEFddL8w
X-Gm-Gg: ASbGncvn0gs9unvM5E3GI7EgzB+4duXNkpEUsxtVjNd/vXUuK+UFRuLDG/MYc8qRMjT
	qHwlKW0FhuX+dDoeOQKPDjgDbZq8oKtW+zuwsxLT7mNSZSTsTAQvtR2sH56NvlZjgfG8e6VCplx
	cPgN7YIudAyMbRWG8w0UGy1O3XgL8MGxWtsUf/QUAVl62MEgfUQxQXoNY6r7h+Uqr8Uqop53cZ+
	ttK83CSex3uI9e8tMhJxRozb7XipWgnJ6Dbim4hqUDZb70UfvqgXjDWruvOWkkH67ZlRPdgsOBz
	3ahjSpuFIUL5lUb0ehno49wfwCsB4uYlyZ1iUA==
X-Google-Smtp-Source: AGHT+IE5O1ZVuOwmp//oQrwhNgSp7QZxuUhf3G7FCkClB32cJAQnuuVkN/3c86LEBjvOfGY+rzBunA==
X-Received: by 2002:a05:6a00:23c4:b0:736:3f4d:4d49 with SMTP id d2e1a72fcca58-73682b8b965mr2481120b3a.8.1741148770219;
        Tue, 04 Mar 2025 20:26:10 -0800 (PST)
Received: from debian ([2601:646:8f03:9fee:cf74:c30d:9ff:fbc6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736560f5e6esm5099715b3a.104.2025.03.04.20.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 20:26:09 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 4 Mar 2025 20:26:01 -0800
To: Shradha Todi <shradha.t@samsung.com>
Cc: 'Fan Ni' <nifan.cxl@gmail.com>,
	'Krzysztof =?utf-8?Q?Wilczy=C5=84ski'?= <kw@linux.com>,
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
Message-ID: <Z8fSWcR_aXyxmFEZ@debian>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132043epcas5p27fde98558b13b3311cdc467e8f246380@epcas5p2.samsung.com>
 <20250221131548.59616-6-shradha.t@samsung.com>
 <Z8XuuNb6TRevUlHH@debian>
 <20250303194228.GB1552306@rocinante>
 <Z8YZEALV71PUkXpF@debian>
 <061401db8d28$5f0a4b40$1d1ee1c0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <061401db8d28$5f0a4b40$1d1ee1c0$@samsung.com>

On Tue, Mar 04, 2025 at 10:40:43PM +0530, Shradha Todi wrote:
> 
> 
> > -----Original Message-----
> > From: Fan Ni <nifan.cxl@gmail.com>
> > Sent: 04 March 2025 02:33
> > To: Krzysztof Wilczyński <kw@linux.com>
> > Cc: Fan Ni <nifan.cxl@gmail.com>; Shradha Todi <shradha.t@samsung.com>; linux-kernel@vger.kernel.org; linux-
> > pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-perf-users@vger.kernel.org; manivannan.sadhasivam@linaro.org;
> > lpieralisi@kernel.org; robh@kernel.org; bhelgaas@google.com; jingoohan1@gmail.com; Jonathan.Cameron@huawei.com;
> > a.manzanares@samsung.com; pankaj.dubey@samsung.com; cassel@kernel.org; 18255117159@163.com;
> > xueshuai@linux.alibaba.com; renyu.zj@linux.alibaba.com; will@kernel.org; mark.rutland@arm.com
> > Subject: Re: [PATCH v7 5/5] Add debugfs based statistical counter support in DWC
> > 
> > On Tue, Mar 04, 2025 at 04:42:28AM +0900, Krzysztof Wilczyński wrote:
> > > Hello,
> > >
> > > [...]
> > > > > +static ssize_t counter_value_read(struct file *file, char __user
> > > > > +*buf, size_t count, loff_t *ppos) {
> > > > > +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> > > > > +	struct dw_pcie *pci = pdata->pci;
> > > > > +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> > > > > +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> > > > > +	ssize_t pos;
> > > > > +	u32 val;
> > > > > +
> > > > > +	mutex_lock(&rinfo->reg_event_lock);
> > > > > +	set_event_number(pdata, pci, rinfo);
> > > > > +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_DATA_REG);
> > > > > +	mutex_unlock(&rinfo->reg_event_lock);
> > > > > +	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Counter
> > > > > +value: %d\n", val);
> > > > > +
> > > > > +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf,
> > > > > +pos); }
> > > >
> > > > Do we need to check whether the counter is enabled or not for the
> > > > event before retrieving the counter value?
> > >
> > > I believe, we have a patch that aims to address, have a look at:
> > >
> > >
> > > https://lore.kernel.org/linux-pci/20250225171239.19574-1-manivannan.sa
> > > dhasivam@linaro.org
> > 
> > Maybe I missed something, that seems to fix counter_enable_read(), but here is to retrieve counter value.
> > How dw_pcie_readl_dbi() can return something like "Counter Disabled"?
> > 
> > Fan
> 
> Hey Fan,
> So the counter value will show 0 in case it is disabled so there will not be any issues as per say. We could add the
> check here but I feel I have already exposed the functionality to check if a counter is enabled or disabled, (by reading the
> counter_enable debugfs entry) so this could be handled in user space to only read the counter if it's enabled.
Ok. 
Returning 0 when the counter is disabled makes sense to me.

Just some thought.

It seems natural to me if we make "counter_value" only visiable to
users when the counter is enabled. 

Fan
> 
> > >
> > > Thank you!
> > >
> > > 	Krzysztof
> 
> 

