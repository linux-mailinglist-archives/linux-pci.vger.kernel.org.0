Return-Path: <linux-pci+bounces-22950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 373A1A4F7D8
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 08:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F25188FA72
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 07:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22A71EA7EF;
	Wed,  5 Mar 2025 07:26:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2188B84D08;
	Wed,  5 Mar 2025 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159597; cv=none; b=fJcmP4uMiwFXx8Z4H6ThTC3gEwve7inhWSIdQI3/8ydoPGTVxZe7aJ8JcUZR8r8N9rN+wRjIOsJEV2ey5PqTNdtFw8eFZKwB7PFZ/phEgtQijDeXKG4ic53YjuQv58n/gShoGsF05KCLylM05yNr3Nj8r61ctDWKT10Ppyh6TFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159597; c=relaxed/simple;
	bh=o0D0OR4ETeM6TgdeTYRWURr8ShM7XjsdgCXgPgCLuM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KU53z8t08RsV1GNY5vhKiDhKUSxtp+TJ/C2mu904iachPASXxmhB95VBI6N/5uBWtOj+fS9aJwU5a7b9/Eax9Dp1P1KBKAvte3hdC0ct+P0UB6hBcGXSx8LJEbHEqozPTCzrYpebXtF5Sw4XXXfs7dfgkgvYJ0b8uA+nXL/oVGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22185cddbffso8425615ad.1;
        Tue, 04 Mar 2025 23:26:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741159595; x=1741764395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNgzDD9KflnZOadx5j+UnJGC4H2dSOBqjrhq830X+Ig=;
        b=E4qPt9Ks/f+Uvc8FREFMMebjgMcIObSLc+zefBI4uBeYI+aTlPtEPbDvXV5xwxjLu9
         8QfaTiq6K2tGoDAjmjmDwDYW6FCP5Jc449DduRHbJ9fZWDGJ1dHNMqfNjszRIsBAmvf+
         d2Ezhi3FZqT5HqfLwIvp8mryFCgWvPATWFVeLPG08c6vPRUK3NjDs4zrWv+HhxRMsHT0
         4jQ6/ja7W3bWiaAfMXiAnoEFQFe77jGplE7dlmgEKHac4XlDbiX9rux2eEszTqdQIJ4K
         1Wll+1WKtaPgs3EMoMvDjYCFU1Suq6yOU4Hp1FwWI6BOhHs1HdDYgMsbhwzd+Sg0Ipx9
         XM/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2CFkrOrtLjhA65HfjJJgmAqzGSjqbFr1aadGoi7TmNhXVo48Hv9pFurw5H24q+ygxsbkX4ebwaelt@vger.kernel.org, AJvYcCVHKSefhuxW6TycnHRDIF0D6PwkzHDoSPP7JBoSzt3iRkg9lF6mxhDgW4nBn+PDi5epFESscek934l2+fcoaVW8Kw==@vger.kernel.org, AJvYcCVwfSFwCMjFjoyXhz+elXRXM/AMN9uqTiCajTk5JxAJpY9WsrCWz3u5k8PM5yRVcsmFv08uotZqwfGI/PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXkWyrQqNgT57VPOBYaNsJhH/ksLf22bpB7ZxNxBsiJn3X3iMR
	ZL7pTMUJb/FS3/RVp3ihGB77I0QJJ6jHzO+PpAf8D1g5HKJjZ1NbLB7HQpKpAt4=
X-Gm-Gg: ASbGncvsLLathL468EIz478vQir7pTYgd/1TW8tB/HvpqcVzJ4OEz0VIerF69quzc9E
	oCzAdg+wFT1Z+vs37rlL4Ru/2Tak+ACFUkWzCPsQdoDVUg5tcV1mN4kGJ+OuyZ2g6ftd7RLzSJz
	K+AaPL/DQD5KqncwtLQ6OvW1WD7/XjLdkQAW56TxImb9XQ5xfvCf6FfvfNVJUfne74z9xRhmJ1J
	vLqpVKI2QQyvdA2gms0W4yQT3KX0+1RIgxuany4hThSAarr6cj/j+IT99X4QF5ykSQVkNPQ8P0S
	DUC8WRoDU7eKbAXajVEy3I+at/V6s0iebI5/mtn4FoGtL8QH9l+6SNpzBsqMT9vGW3wEuXVAp14
	bj0g=
X-Google-Smtp-Source: AGHT+IH4t9c1giK1O3kPlJL0PRn7mp5PNA7gzv7H2Tv8w5GXPqUFHbxAbvmymLda57tcg7gd3IxW4g==
X-Received: by 2002:a05:6a00:9a0:b0:736:38b1:51c3 with SMTP id d2e1a72fcca58-7366e75b316mr10877398b3a.10.1741159595256;
        Tue, 04 Mar 2025 23:26:35 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736881fa8easm449243b3a.39.2025.03.04.23.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 23:26:34 -0800 (PST)
Date: Wed, 5 Mar 2025 16:26:32 +0900
From: 'Krzysztof =?utf-8?Q?Wilczy=C5=84ski'?= <kw@linux.com>
To: Shradha Todi <shradha.t@samsung.com>
Cc: 'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
	nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 4/5] Add debugfs based error injection support in DWC
Message-ID: <20250305072632.GB847772@rocinante>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132039epcas5p31913eab0acec1eb5e7874897a084c725@epcas5p3.samsung.com>
 <20250221131548.59616-5-shradha.t@samsung.com>
 <20250303095200.GB1065658@rocinante>
 <20250304152952.pal66goo2dwegevh@thinkpad>
 <20250304153509.GA2310180@rocinante>
 <061301db8d27$02e0ced0$08a26c70$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <061301db8d27$02e0ced0$08a26c70$@samsung.com>

Hello,

[...]
> > > > > +		29) Generates duplicate TLPs - duplicate_dllp
> > > > > +		30) Generates Nullified TLPs - nullified_tlp
> > > >
> > > > Would the above field called "duplicate_dllp" for duplicate TLPs be
> > > > a potential typo?  Perhaps this should be called "duplicate_tlp"?
> > > >
> > >
> > > Looks like a typo. As per Synopsys documentation, there is only 'duplicate TLP'
> > > field.
> > >
> > > Good catch!
> > 
> > Updated.  Thank you!
> > 
> 
> Sorry, this was a typo. Krzysztof, we need another change for this typo.

Not a problem.  I am glad we caught this early.

[...]
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -113,7 +113,7 @@ static const struct dwc_pcie_err_inj err_inj_list[] = {
>         {"posted_tlp_data", 0x4, 0x4},
>         {"non_post_tlp_data", 0x4, 0x5},
>         {"cmpl_tlp_data", 0x4, 0x6},
> -       {"duplicate_dllp", 0x5, 0x0},
> +       {"duplicate_tlp", 0x5, 0x0},
>         {"nullified_tlp", 0x5, 0x1},
>  };

Oh here too.  No worries.  I missed this one. :)

> So sorry for the inconvenience! Should I post a patch for this?

No, no need.  I will update this directly on the branch.

Thank you!

	Krzysztof

