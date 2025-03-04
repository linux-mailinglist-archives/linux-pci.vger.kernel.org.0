Return-Path: <linux-pci+bounces-22865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ACCA4E498
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193F819C5DC1
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1005C27EC60;
	Tue,  4 Mar 2025 15:35:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A127E1C9;
	Tue,  4 Mar 2025 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102515; cv=none; b=VdhF7VANgOcNm1IE09+GagKVLETM4V9Iiv/LLWd5OJXTl9Z0JLMhqPBa1U+NI2uKTaPU5+l2GPY5UedmC73MzPSqPOR/ZACpiJds/QzCdZGDS08VcMrraJKD8/TRTT6uOq29SrrcLDLY3+qVhu+qlUD1j124ppfi5dDuNU+tHkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102515; c=relaxed/simple;
	bh=25lxY0rRFzscOEISUUTmtF8cqJFNHESfhXic2drv9Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEg+wG2W38UCTL+mu+fOEjaSGQ8ovUwyW5lgjwszS6qpAJGNwCKqnrbveKJiTT08KqBXtGJ0c1x9QGZTcz336Uojgu9IFjVQgeZsUXBLRMxM/eX6Ngsj9CL1KGfj3MVsPIQ7rdPGhZUi3wiYcoF2M88Je6AQP2DfrRsjuvDoPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2239c066347so52775695ad.2;
        Tue, 04 Mar 2025 07:35:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102513; x=1741707313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPksOpIsWmD4LD84U/zyiEQF/6uAhUOVlj8rScJ6yGY=;
        b=MxGyosFLpa+q5WnPDwFlu4Mf6J9WfI7gwf3+SXdVXWTHgxhc0K/Aj3Mtk6MEYfmIEY
         NoYNeLTQRgWfoRwUft8/APav2coBkND7dVLVCW/rTUmMSkd+lKvOP5lRD0L8R/1/F9RG
         jB/pl3LdnjuC8cOfR9/TK7NWVZMRQ61axRPoCzTmyfqYaa7MzDcmVOI1mBCEndjy9nwu
         bOXmxpsIJhk8GMjxNHTK5WsOrp4RxKLeZZzpdRFXXyZjUNBpoKKJBljfRw43YamNcRR8
         Xp0lNSMZSoHN7EzP21yriMLbH5usK0moyF9Glh/TPlb+LXvYQD1AlCV2i338UJnNLFLc
         xFrg==
X-Forwarded-Encrypted: i=1; AJvYcCUvYJ3B8hNRltxWwsO3VsvSPaz52Ib4OD2yFL8jMtsZUkbaohq9OGvESHKuLC+rzDi3U9Ha3ZKdDcFX@vger.kernel.org, AJvYcCVrWbv9WA0VHbbPcMIETCv/j0lnlIKDTu2nMK9QXfjekRjmrE39mFqHQ7bakk0EQC+xdVNxRksKmCcurtZqGjpSZw==@vger.kernel.org, AJvYcCWGAHG0brgQy2RWjwyZKFM6jMz3S9WQiCFKPvwfXmoZsRhfc4DK4dX0+vYNYX4W66SGG9sHmH1c4f0UKYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKpyGxowldE8IXSTmiMEI1hFT0hONAZOx814UZXJ9zE1EwMaxI
	RxhZtzx3izJ4GTLGWlJn7vp3KA/o/iMw+pvRUTsJTbt06ygWs0IM
X-Gm-Gg: ASbGncsaveqgrrwsTrqHStgY4xFjR/gYGlrHfL0VUoRZczjEU1791rPVQA5h0xVbnJp
	bv+qUcqfDfcbk8r9k2SskNRlWRXFVvAF74mz/SNEyGoo02DuDpIB6bi3p9PD6L/QBtVLrLrTfWW
	z/9+XlDRcD01Hzc2WUhPHDTXabKzOU5XHbFSIZfC6IHEL338+ofzPRtm28+5ohKJjkdoiJ+ckYi
	ZRkr5iBpbOkZE8iD37YrmxjMB/62j+T/WX+HwVur1WjEPubjl+w+kBIBPvbEwOdaK9R+IVup96A
	5p6NY9rIxZ0+NZeb62Qnyt/mTzaobuIq6V6zckGx/WFCYH0AWNmfbXyo8IiQsihw9sAE2T0mHYF
	9FuA=
X-Google-Smtp-Source: AGHT+IHqM19CmKxrc3+/5zghLWm7z3K7HlW9tJVgM1xGFI0z5/AxnNorz6ln5aNsioCk4N/uTqY9lA==
X-Received: by 2002:a17:902:eccc:b0:215:6489:cfb8 with SMTP id d9443c01a7336-22368f6365emr341829405ad.10.1741102512747;
        Tue, 04 Mar 2025 07:35:12 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2235053e41asm96451805ad.255.2025.03.04.07.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:35:12 -0800 (PST)
Date: Wed, 5 Mar 2025 00:35:09 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
	nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 4/5] Add debugfs based error injection support in DWC
Message-ID: <20250304153509.GA2310180@rocinante>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132039epcas5p31913eab0acec1eb5e7874897a084c725@epcas5p3.samsung.com>
 <20250221131548.59616-5-shradha.t@samsung.com>
 <20250303095200.GB1065658@rocinante>
 <20250304152952.pal66goo2dwegevh@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304152952.pal66goo2dwegevh@thinkpad>

Hello,

[....]
> > > +		29) Generates duplicate TLPs - duplicate_dllp
> > > +		30) Generates Nullified TLPs - nullified_tlp
> > 
> > Would the above field called "duplicate_dllp" for duplicate TLPs be
> > a potential typo?  Perhaps this should be called "duplicate_tlp"?
> > 
> 
> Looks like a typo. As per Synopsys documentation, there is only 'duplicate TLP'
> field.
> 
> Good catch!

Updated.  Thank you!

	Krzysztof

