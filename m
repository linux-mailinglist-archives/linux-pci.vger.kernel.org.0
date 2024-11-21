Return-Path: <linux-pci+bounces-17181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 827DE9D53BE
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 21:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6651F22541
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 20:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED19C1C242C;
	Thu, 21 Nov 2024 20:14:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3A21BD9EC;
	Thu, 21 Nov 2024 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732220061; cv=none; b=caL4CI/KZiwprBECO2NAwioxVhFzgObd0P3gE44T0/Z4q4GCSZZkhcnH0lq9z/ZAALggl0Ryd6mTcnBhXJAh/VaiAie8odfD+nfJLv9ix75liyWiNxAeg1J2MFpcj4vo68CQmSPdsLW+vjSTGzZ4bshicXETOt/dCFiU7U1GPOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732220061; c=relaxed/simple;
	bh=gYsJwu02pWugVazNIEP1YeIcasnqbI8b2ezxJMncNwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xpp6olzAAyE2n9sow6046KW6pC42Isqr5aHpLoapyvcxaPu0fZU9F3vuwgdghbF4TT8eqkdpLBWo0LKIkf3i+NhnR25IEQBE6LnjWncQdVBTcK0G7BpS3AZrFmoPru8U73KIiacWR7/LBnm83LTyCz3N/nkwjuwaSRiXkF8Ri/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21207f0d949so12818685ad.2;
        Thu, 21 Nov 2024 12:14:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732220060; x=1732824860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jm9iL6DwjcTmoPVhHDUHF5A4pRNRL3Op5katTm02rI0=;
        b=D778EKpZpBRx2tLJNWiRuwyo0Y8IGWK71PduB0jV7Hi8tQv8ELwdu77GVJxKlMuAxa
         Ogw1BGUtKo+dK5eUjfDe6qqGygqrYDI4/9uamiK685q1sm1aFdyoAt1x3HoLsDQf5lo9
         trrV2THyw+wS6vJW2Tui8fDSCcG+mrslE1/AcIg+BdplqTPVb1vm+ndIXX72OAnN2i7k
         eAJjC7H8PYIdj3CRvFL5QQFq+3RgwVXYA+lcXqqytjwvIlLaed2rMDM/QEQOHTVlbJdO
         VLtkoJ5w5oGzPOggbVFLFUiIo42kAfrNNEsx2sTAnH3/UIZBKnJONmI4U3m+VMCiklXG
         wG1w==
X-Forwarded-Encrypted: i=1; AJvYcCV8EztEorZ30Nn4+T5+nBUtBK5jemVFkSXqUy+at12iR16dnQSfrMu1Y8kHvdmBAyNw06o1uju47y4B@vger.kernel.org, AJvYcCVczDYa16+dx8OI1iVRrtPTzubcnsOSLgzc77SjL4KSsbW+oO1PsPWLczpA5SriuTj+Jz5X6iYoEqFKudM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzknzwhIht6nJUoyEMFY3Pl6Bfft1nT3cSeQtgatd0My3vzfsdE
	NiI4WdEX1A0nLyzRjQIAvR3lx2NZSIlicyjmdQ5130YsFQNGdQKLuFKG+6lK6to=
X-Gm-Gg: ASbGncvjS0KZf06Hfqsi37AzHQT9+GEUgsvk9OACfcYlx3j3BN3QuFSC3o5Oiz4fd3C
	mDTGslx0/IJ4979vwWRnIsYyR3MofNkKhjIWZX30SZNLNequ8laE0vIfdZYnrjFPbz9p48twhkC
	5mGWNgGGDn2Vi5I8TML5+AeBLVhLWRwlZ7L45fJHcoJCVDbzptrVp7mjLy42J3uOtR61ak4Ckli
	+EOn5++D2BPxLolwMt2mqcg78/8IOVhTz2eNw4FO1gfZDLEfYxwIZ0C3J5GPyUg9Qc2CxOEGWlj
	t4D0VfKw
X-Google-Smtp-Source: AGHT+IF3z7YCs46o8PBTA8F9sNRp3I2o96B3q3m0XP0Vg++EgjKoc1O0YOTQnRr94Gb/NHPZMdB2jQ==
X-Received: by 2002:a17:902:8213:b0:211:ce91:63ea with SMTP id d9443c01a7336-2129f53288emr3164305ad.15.1732220059574;
        Thu, 21 Nov 2024 12:14:19 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc20feasm2231205ad.256.2024.11.21.12.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:14:18 -0800 (PST)
Date: Fri, 22 Nov 2024 05:14:17 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	stable+noautosel@kernel.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v2 3/5] PCI/pwrctl: Ensure that the pwrctl drivers are
 probed before the PCI client drivers
Message-ID: <20241121201417.GA767990@rocinante>
References: <20241120170232.flllyqcycsrsk6cj@thinkpad>
 <20241120201839.GA2338274@bhelgaas>
 <20241121120010.zjmo7sun2j7w2f5r@thinkpad>
 <20241121182824.GA69684@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241121182824.GA69684@rocinante>

On 24-11-22 03:28:24, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > > -			pci_err(dev, "failed to add device link between %s and %s\n",
> > > -				dev_name(&dev->dev), pdev->name);
> > > +			pci_err(dev, "failed to add device link to power control device %s\n",
> > 
> > Maybe use 'pwrctrl' instead of 'power control'?
> 
> Changed, thank you!  This makes the verbiage consistent with other
> messages, code comments, etc.

... this one might have slip into the after merge window.

Also, Bjorn and I, we had a conversation about the correct wording here in
user-facing messages.

The "power control" vs "pwrctrl", etc.  There is a single existing
precedent within the code base for the "pwrctrl" use per:

  55:	ret = devm_pci_pwrctrl_device_set_ready(dev, &data->ctx);
  56-	if (ret)
  57-		return dev_err_probe(dev, ret,
  58:				     "Failed to register the pwrctrl wrapper\n");

So, we should be consistent within the documentation and anything user-facing
around what wording we use, I believe.  Whichever it will be in the end.

	Krzysztof

