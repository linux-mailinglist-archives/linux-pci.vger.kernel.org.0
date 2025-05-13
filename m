Return-Path: <linux-pci+bounces-27642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EB1AB57C5
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 16:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6937B08B3
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 14:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2231C84CE;
	Tue, 13 May 2025 14:57:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B5417578;
	Tue, 13 May 2025 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148253; cv=none; b=Y1YQ3wYai4jJpqZhExp+zBqoJX0n+TFeMs/ihzikaa13pwBrzZYLpY1i34BSmLfEdlNdURpGvtdZy0tFVXTZ5KOZkmm0FCc/p1/DkwtunPT5oaARTn42Eg3lJAiNenWUAsOfI2q5cos76hmw+/OS5/5YnJN4xBe10e3vi85uTx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148253; c=relaxed/simple;
	bh=ozJSIVhrsVZSmArvo5SbSNaFcz2ivHX7lRhpN1fzzp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK1XosP/FhUyn1S4gVf/qdEPO+/IONhuOpE/WPxeGs/URelXyLN4U2sABSCzc0WN4K+7ItOI6nEDTPeq8B6i+K3K1cli8Ch1A8YsPWfQzmOZMGS6SWTFFTrqBc/gGp56Y++cxqg10PDxIZoCSh5yUfNohhQK0K7God9ipUCRXGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74248a3359fso3654082b3a.2;
        Tue, 13 May 2025 07:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747148250; x=1747753050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KoZB2ihq3FKh16QI7sEuRE5275JyuaBBVfjNn/0xug=;
        b=mGiT5PXdq1oAq/Sxm8+8wEAkV0gCvK01EIlBI8whfPAvLDjviiG1/CD9q2ctm/1vAH
         HdTk/iP90t8cxQkwGi4uh3OmDOfY4oXSDM868ilsL4Zmmdl03mXwm6bB8Hs2NJNWbCMN
         5Eh6ZwhTe/C1xPjqgq27Q9JUOj2ju6ZlEBcxh3eyo8fOhy7f5eCXOw6tZq7NV+DqaERk
         74sCXa/q4V1OIJGBbxevxb6QpWgnyTdolnaKVA+2HOM3+oPlfcIlIGMLlf4qBItb9D4/
         ThjDz5WrT0EjwHQMQxYDFoEkJ1i+5x35qdQTHWE6Ag5uAlLQM4xB1I9NR+PqiFR2DSV9
         4LfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4yGpunYe/BG21Urde44yFlf2OFosXpsieYKojmwgcAdfT/n083vkvtGVSu4RwPPA9yV63mauPDE2DdVc=@vger.kernel.org, AJvYcCWqEl4T0X+vC04A6ujjCZKxG5MaqwwJRbBXHRRkKjYYdZlpJgiqgEJrEbeIt5079feARYnA5Hxl9CXT@vger.kernel.org
X-Gm-Message-State: AOJu0YxIHk3uATqILtZ4ltwYjvAbNHGaStqZ8Yp4GarncWgRHo4q8YfO
	Xxcq0j2n4JTxDrXYk/aZrZ1jElUV0DmmGprBh9eeY5H+0URUr99i
X-Gm-Gg: ASbGncvKR2bmFZP5NSDbbneCZygg8Z6CObAr9SUV7FLoKf+TufOr585t+cccx5CFGp5
	UF+dLAD+kfNio7CgZLZnVLLi7/jrgL1uF53Hef2iYPc7bed7wT61b5MHFuF6TH3nqwRXhmzQisu
	2JXTHpqnCIQdCzafVNIPbq1W/ecvYiCF3zHJ7JLGkAB85R6oHZUI0HQXYLTvb6Xj/h5kummtFgD
	Yt/niWsHepvdfAwdMGLLHW/rBfE78HMyeeR2ccGM8eDheHJRLZKEM+vTEfin1UsiXdeT8LIj5e/
	6CKxNsMZu36WHkVyF4BWHU97FRQ9tRTFuG8BYKcvzH4srZiy5OCWcoZZfkQHgh0oIUFagIF4tu+
	nm7X2TlY5OQ==
X-Google-Smtp-Source: AGHT+IFt2WrEJiIvBzwd9L2NKr3vlxlESO+fODgKM7hvHRDVcFkoN9TAMo39vDPjw72Ho2gP9wyO3g==
X-Received: by 2002:a05:6a00:1d0a:b0:736:a7ec:a366 with SMTP id d2e1a72fcca58-7423be8695fmr21744996b3a.9.1747148250086;
        Tue, 13 May 2025 07:57:30 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74237728345sm8106683b3a.58.2025.05.13.07.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 07:57:29 -0700 (PDT)
Date: Tue, 13 May 2025 23:57:28 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/3] Standardize link status check to return
 bool
Message-ID: <20250513145728.GA3513600@rocinante>
References: <20250510160710.392122-1-18255117159@163.com>
 <20250513102115.GA2003346@rocinante>
 <aCNLl-Kq0DPwm2Iq@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCNLl-Kq0DPwm2Iq@ryzen>

Hello,

> > > Changes for RESEND:
> > > - add Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Resending a patch is not a place to add new tags.
> 
> While I realize that:
> https://docs.kernel.org/process/submitting-patches.html#don-t-get-discouraged-or-impatient
> 
> states:
> """
> "RESEND" only applies to resubmission of a patch or patch series which
> have not been modified in any way from the previous submission.
> """

Yes, I would often take verbiage of this document verbatim, but..

> I would assume that this only refers to the commit log and code,
> and that picking up tags has to be an acceptable exception.

The above comment prompted me to inquire with a more senior maintainers,
purely as I was curious what the opinions/preferences would be. And, as
such, the replies I've got were:

  - No, follow the documentation
  - I don't care, really
  - It's OK, make sure to pick the tag, if it makes sense

So, wide spectrum of answers.  As such, I take it as, "it's up to the
maintainer", for lack of less ambiguous answers.

> If I take myself as an example, I would not be happy if I spent time
> reviewing a large patch series, but because the maintainers somehow
> missed that series, so the patch author has to RESEND it (without
> picking up tags), my Reviewed-by tags get lost.

While it's not about making you happy, I agree, that trying to preserve the
tag might be the correct approach here.  As such, I will adopt this approach,
whereas with other it might vary.

Thank you!

	Krzysztof

