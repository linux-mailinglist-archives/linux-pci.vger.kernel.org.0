Return-Path: <linux-pci+bounces-22099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E790A4093D
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 15:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE0B7004D0
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233B5194080;
	Sat, 22 Feb 2025 14:54:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9AF142659;
	Sat, 22 Feb 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740236077; cv=none; b=rB2ZcurfzkT07tCNHJ/vNmvLDfFeI+6+xLqFDIWJR5KBZ434RspPAAARfEArPtSwcj1SXH1bFiR8tKjWPsF4kyvbTAXx72e3phNNRQpF9x4qSZzhiRcVV1WT7ghnpWBwjQRyZrFON7Hsb1C6K77L06VHgXahmoBfdJNaHTx+wgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740236077; c=relaxed/simple;
	bh=wFRIOhN8f54UOmSpVLzQUjFObfT62f4uBOp9rdRPjM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDdQ/w45Dl46EBzYadgvj39B+mw+OrBWPpxXIkDpT7c0wJP9j+rvk2N1QcWH/AJPl4ZMcoDjZYed9Bg+Q0DjMSFm+54wJPOcLFh4Zhiacdv864qMU6gBlJ2pcjt984aMBGDxthNMjk/sDbpKm74U5RUJ35vSN6lOGP0r8e24VBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fcf3a69c3cso1968232a91.1;
        Sat, 22 Feb 2025 06:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740236074; x=1740840874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vA5/nqMv/eBlFbHP5T9UBQnGk4nkRjHxb3y15HJQWJQ=;
        b=OiMiUizNEqV1Z4DOixiivOuvk7r+GcNmts9nXIuJxscCl3xLrsnR3jkv0nKBVHXhNA
         CB5C172EcvIXUHLX+A7H0BMKqs/O00gT9hJ9dkQ3mnsRgVQPGbxjm8lCwJZ7iivJPDwx
         cwp+1xlYzhRlmMECFjuS39AAwv5EsXEy0osIq/4cDpJBZHApFgUP/kbiiN1Hd5W0b2Mo
         dFFPYzROpAL8Bu6IyCz1dKP9BLFQYkt2kpoOqyvtTodQYXSdi49aOy9mRadoBV9AwK5B
         BQpjfZSPCLDGrdvFYcadmS+GsVSictaKy43RAIXS4aZY5gcnlC3qFIASFMZaxGHzjOpq
         mRVA==
X-Forwarded-Encrypted: i=1; AJvYcCUIWWuwftaN7YiKqQ9L3QCzmL1t8fr8Zj+iRT0JHM0W3SeV935X7hchxyunX4Senlc6kI3+JypP17Iw/aQ=@vger.kernel.org, AJvYcCXeArrq9hxNbGdxzGmSHugyUeCrOfYGjJdwO3GlrN+7FDTPjbpskxHlpVzZ+O/8bp53+GPL+TgIRw1+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7b8f594DqSCBF4A8OX9bRmQHMByitBy3heuBSt5Os0N6C11R
	Tm87isGujis7glu8qETEtfK7P81lAwIMtJf2hNxrtzAD4AiPrgeF
X-Gm-Gg: ASbGncu8DmhgAn1lzw6WwxYDipXk5/VILOgvryqUgzpdSFF2OFmvYN10z78vLLneJym
	A3ceKaySBVTjaj5zJ2XJQ1uAvBBBdbW5zBPaf+I4bNs9rr+7KlYCaDG1bquT8G5isdK622mcBv1
	wk+tkuA3qsvIvJiabgnFJX0JsX7CrR1Jem7e+iCyn22kc00PVbj6wp/C+WZI3q+HYeCOWgEvnhx
	sGk76koe+yf35fduxKza8ACpyDI6275XlzBV0KAbmo6C5Ga9PX8chtxzkhweF1q1XGFtkPNZ9+l
	yclUphp8y2N2Vmk0YikkfKLGUAKpbb8HdkOuVOrDXcHvv3+jbykEifdfDhct
X-Google-Smtp-Source: AGHT+IHUI0k4pMWsMmk0OZ4kpv15Z43iCUVKsblHbmUu13QKzoj43eE5QFnPj/vglT7QCP9opAh61g==
X-Received: by 2002:a17:90b:1a88:b0:2f9:c144:9d13 with SMTP id 98e67ed59e1d1-2fce7af3f1cmr12851514a91.24.1740236074464;
        Sat, 22 Feb 2025 06:54:34 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb10fb2csm3175218a91.34.2025.02.22.06.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 06:54:33 -0800 (PST)
Date: Sat, 22 Feb 2025 23:54:32 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Hans Zhang <18255117159@163.com>
Cc: jingoohan1@gmail.com, shradha.t@samsung.com,
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, Frank.Li@nxp.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com, Niklas Cassel <cassel@kernel.org>
Subject: Re: [v4] PCI: dwc: Add the debugfs property to provide the LTSSM
 status of the PCIe link
Message-ID: <20250222145432.GB3735810@rocinante>
References: <20250222143335.221168-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222143335.221168-1-18255117159@163.com>

Hello,

[...]
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/ltssm_status
> +Date:		February 2025
> +Contact:	Hans Zhang <18255117159@163.com>
> +Description:	(RO) Read will return the current value of the PCIe link status raw value and
> +		string status.

The description could be refined a bit to make it easier to read.  But this
is not a blocked and the changes otherwise look good.

Thank you Niklas for testing!

I will pick this up if there are no objections.

	Krzysztof

