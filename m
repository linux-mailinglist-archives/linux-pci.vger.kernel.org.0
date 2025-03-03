Return-Path: <linux-pci+bounces-22854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F8FA4E2F5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67D3420664
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248C427F4C4;
	Tue,  4 Mar 2025 15:09:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2827EC84
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100949; cv=pass; b=urVNq2faPWtlg1qlzIgOvyIAzBHgOoenZ7mydEoOFoU6pJV5yHvhAXCggIqvsPTN+AYWIFWIzkHSqq4p52LnnsJf7DV+vzOFAf2nJX/uENhX7ftj4jLA0/a47m1e7EN3ASatFig6Gv8jSsZX9XmyS6NAew1j2R9UY4qyFvzzpBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100949; c=relaxed/simple;
	bh=MAcogLOHTDP8IrUlz+d1JPodWURGuPl7w4VJy92YRTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2KfliPdT8/wEOElKXIvoXimFiz5PJ3E7Vk4CL3zP/jrMkqitUjZcN8CkXhulOjCKOY7vEpk5NTIE/PMwlNm8mII5W8alBKjDJI6AYpI+WDADC6x85rwp2ZrFujHWSBILs/YEsLfijtla6JZXAv1Yk5+1aDbJ9D+7igAUipZgK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=209.85.214.172; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id AD5D640D2865
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 18:09:05 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6f8C1BDfzFwMt
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 18:03:39 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 8892B42749; Tue,  4 Mar 2025 18:03:22 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541313-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 4CECA422F0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:52:27 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id D747C2DCE4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:52:26 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737E63A55AB
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11D71F1520;
	Mon,  3 Mar 2025 09:52:06 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F312BB04;
	Mon,  3 Mar 2025 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995525; cv=none; b=h+6M9oh9Zt3wj0f8I/7X2OhDtIqEvUEFF0bOBEoEuRY/tImcPhqcclwLNuqayJSILXGBXXDkissMj/ikGVt5SST2/eR9h05w0oX4fNd4wQu9Lenhcsxh0ukBTD8/YVURmN3Wgg0nHFkt5cA3zBqb+8YKufIVbEY0MaFrU9Gy7nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995525; c=relaxed/simple;
	bh=MAcogLOHTDP8IrUlz+d1JPodWURGuPl7w4VJy92YRTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAIpNu6J5CS9WGhhfnGgrf+VuMZPyuTwCQr0vKP0sEfXN/365T4PMikirvluCC9xz5/CLmwH0B1R4e1bI58qM4Nq0DIgpVYdiDQ81B4pM3ivsf91U+cbXhR4rZGm1/y5FCP4Fa4tcf8aXLqPgDxdI4qtMnCsDTVImEg4W88nv2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2239f8646f6so20014035ad.2;
        Mon, 03 Mar 2025 01:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740995523; x=1741600323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40J+Ql5K6IK0gLn8z0lNt2yYrMqV11O1QyGkgGVKClI=;
        b=FBYWWX6A9nk9F06Pjau918QKv2paEiG1O86nxbQ9e22IYzTMDhYTD6G57LTa6RcKyN
         nrr0iAbstC5MT8dravb9wcLGFeJP7fo3NH7iWSUFQCxvIMj2m6L6hca7sTwjXpb1m/8Z
         Ds14KMoxTEcPHEaeJu2wrRtfjeU9CLOe/J2rDalb1u4gSpuhZNVyb5K4YI34RBAWnLgM
         ij5RY49TszV0cic4whKX+k4IeNg0IfTdHBtqr/goId+XSkLNi89XLC6jd/vjagI14kgV
         11zQESktxY/LrNrFwAZ6xqeCIlu36XQobqPOlZI8LMSjdb3diwRl+WTKoLiCxlTd5Hbe
         93Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUWYyr4/OTrSngYvyidww+YJqZf2tMPh3sCCXIbrkvNNrlSJWuWJscfxksizb9OZ56EPBN47QBaK379TTS3E2XIzg==@vger.kernel.org, AJvYcCWcX0Q8nnd9bcVNFUPen9iyMiW8TH34GHhG/c3sKameW7yMMQimBXzAEnYI5jKy+cVK8Rpzw2Az+jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt1+3LKTuguMLZOLIK6zmR/2LNc4UVoN+9Ga2pewT4S8R38EQM
	qZ6S2DY+DxCW6nt+0S2jnoBhFmF2ALMd5A2M/cXRHk2pltMMnQSN
X-Gm-Gg: ASbGncv8mmwixv0fVOq5Flp5Yxg0LUsRB4ssVHUUjxw9RclIFWu/gtjcnHqXs2mawfm
	NXT/0L89HumOlGBSyEkSL/rNw2cWaSNuSzaxeqw6XqHeRdnnUrKJiNWaXeUW3eZ1FnytE59f9qF
	xxtbUOMQFZUcF51NQ5LPPn399yBLQVRIQIWEkxEF83z7CqsUUoresUkO+azrQixvB5dU/Kl0gJX
	DDd52IRDMzh/nhhIwMZcVJSTKxTwhS6g6RyBGXQumY01LIzYSl5G9AXELHO63kDVQYWSzUx3w2K
	6l6u+Z9ewt0p9EmzmV67RhvQXvHNi81DYeYV05mQp5Cy7DtM0M8Npmw1Q4Sn37h3p28HfLF7q6v
	4yAI=
X-Google-Smtp-Source: AGHT+IEWAfT5Z97RfY9VXKqz6TqnQKfcazGhBUq366+ebKsHwhmWqH4G2doQhibh2hZGJVaVQ0CoDQ==
X-Received: by 2002:a17:902:fc48:b0:223:66bb:8993 with SMTP id d9443c01a7336-22369207c1fmr208309815ad.43.1740995522806;
        Mon, 03 Mar 2025 01:52:02 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fea67532a2sm8540087a91.9.2025.03.03.01.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 01:52:02 -0800 (PST)
Date: Mon, 3 Mar 2025 18:52:00 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	fan.ni@samsung.com, nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 4/5] Add debugfs based error injection support in DWC
Message-ID: <20250303095200.GB1065658@rocinante>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132039epcas5p31913eab0acec1eb5e7874897a084c725@epcas5p3.samsung.com>
 <20250221131548.59616-5-shradha.t@samsung.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221131548.59616-5-shradha.t@samsung.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6f8C1BDfzFwMt
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741705677.00342@ztVOGjlbSJnRwBmdozJCTQ
X-ITU-MailScanner-SpamCheck: not spam

Hello,

[...]
> +		29) Generates duplicate TLPs - duplicate_dllp
> +		30) Generates Nullified TLPs - nullified_tlp

Would the above field called "duplicate_dllp" for duplicate TLPs be
a potential typo?  Perhaps this should be called "duplicate_tlp"?

I wanted to make sure we have the correct field name.

Thank you!

	Krzysztof


