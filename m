Return-Path: <linux-pci+bounces-28401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6676AC3E65
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 13:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EB1176F61
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 11:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55AC1F8BC6;
	Mon, 26 May 2025 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jr895s3t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B621F5838
	for <linux-pci@vger.kernel.org>; Mon, 26 May 2025 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748258214; cv=none; b=fk1xx4xewDz4QGv+3MmI/+p/ev445LW5sIZl1xI465geVnAV+ZhE8+s0OF5p75VK8wFY9/3qXgx+MV+xIAQLsEOuPVDmVNaIeen4GX8zEUVHRzj8g6VhlbBgPw5lJbG1XggIwSau8H+jGQ8S9YAuxXsHMZCsMtqwGBGZpnppB2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748258214; c=relaxed/simple;
	bh=oc+X8bF/5frSyry5RmoMGZugC3S28EX+om9zx6pPuzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEUufQ4OkGPF+c05zIC1RbeieU/GCj1xp9JiZX3F5F1Gk3ta4MG+4PkztCgiZS5Y4GitvIBYUhcYkG54YHULpXdC1Fxf6uCbofPtHYZNg/TBLLXVAKt0HfHMkE5d+86DY7dyWKSO5ofX/Jmhnz/kjBVFjxfmAXdpJ1EdTudhBNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jr895s3t; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2346846ee0eso5838285ad.3
        for <linux-pci@vger.kernel.org>; Mon, 26 May 2025 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748258212; x=1748863012; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ulxYmn9OC6+sDst91oQAEFfcIS70kmh66nNINkuqjTQ=;
        b=jr895s3tV1MBSAWPfXqDo93zmyExxl4EhiDUsSLC4hv0CumYvXZUUGiGnony6JNsVN
         /DZ541bnerw82EGtaMJfl5YQI7WaPP3ZMlDLSCyA8gDsgQnC0JCwNBG+FTcZ1rcRvypr
         cha90JWZxBzo7nt+dYTYgzI6iMV+k1fcf0kYO6VVTgLDM2J6RtCQMTK6wTH+KZsUHS8g
         OONMYnBuTnwYNVwDQO1Lo9jSBTS3cGRc/JbsiHomCOlCcjiECDRQZyvWhTPy29oSCcs1
         +hry76irJdfajtCmOkra1XUCuCcwID2KtCHAd13lwL66Awzh0tbTjtx3wDBY1mseXcVA
         eWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748258212; x=1748863012;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulxYmn9OC6+sDst91oQAEFfcIS70kmh66nNINkuqjTQ=;
        b=RTqzWIOtoxvA9+pEuqaG17n8ShtFNwbynAdmkDX8Jesw16DiWUDWyQjik4ZZLn7VJt
         bCoTC6klExSF00ClKhmWpDgrdqqaolrSIBLN7SbpFU85NIIRpzWgzHUvPRC3RKmQz6Xo
         DxeyYDV5GkOOOcJmwBoUmNcvkRZ7DpmANSSAnhOgZtScDawp+r8HmiSUkELxqrOj9Rqm
         FOF9bEaKnOwEWh0KH6UlJEQmw6HPK+2RsaD4uZ4I15eANqMq8aoTwigfFmRcfgOcIP2Q
         2oW1XLTfVyAdccnNUDVmTKPWpV5hilgBJhrUawV9vd5rSJi6FP8bLsByg4qtgKUQYAAH
         TWCw==
X-Forwarded-Encrypted: i=1; AJvYcCUSVI2eN2L7RuKS/0Tn2lQDmIGwzMZZ0oAB5k5bHp3uL21E6cbUdQuPtqhx8OQd/4X9rOt1OgZImWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3OKcx22oLj96+tghQ46qxM7LvnUt9xPuFTyPbt94CAAAIcLFm
	V9s5bXfSDGDyuogOssZxOLdzrKRzRNVCZJ8D6EWxY4H4L/WUQV4Mrq5mgNoCZnrRmA==
X-Gm-Gg: ASbGncv0PSNONpZuJOeVsZpvZKApyBAaLMp68Hdijia4OOw9EoaoOaTPdZvn1ARm88x
	CYZ0NPawCZjhwSaUozHyQSB0fa4YGR0fZ4LZ7G8nFNcxbZCFlGPLoRA3Xj8yUuS6wBGJgktP6YI
	8pV69XOPo7WADNYfVIseJ5QCa4kiuCGDb+a+xs66IwF+XZRp5noSVRm9ux+obhyR9xHr70kX5ay
	cAx5pOWoAQt81pFCsKUbOv4taFqUnrdkOM1XgoNrNiEHuBjybwwi1LmsULJ6XZjZUTaSQvvnyc4
	ePRUr9algJKtxElurPMYw4hbIu2KC9yezYQkssQv49OtJ5WYFPNv+90ubiQhzs1R224wvXgPuA=
	=
X-Google-Smtp-Source: AGHT+IE3knpqyPoHytl1HTPVu5Io02EXVExU+HLdRLl7BELYi33dIBObAhSkST7PxeVLbJc2K7u30g==
X-Received: by 2002:a17:903:4b30:b0:224:24d5:f20a with SMTP id d9443c01a7336-23414fe558emr147961405ad.48.1748258212357;
        Mon, 26 May 2025 04:16:52 -0700 (PDT)
Received: from thinkpad ([120.56.205.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234180b2c31sm39997795ad.155.2025.05.26.04.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 04:16:51 -0700 (PDT)
Date: Mon, 26 May 2025 16:46:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cassel@kernel.org, wilfred.mallawa@wdc.com
Subject: Re: [PATCH 1/2] PCI: Save and restore root port config space in
 pcibios_reset_secondary_bus()
Message-ID: <crihkpezsnfuzwm4b7fkyy5b3je55zwxhnk65ctq5wncr4hwq5@63f4fr3bvrsx>
References: <20250524185304.26698-1-manivannan.sadhasivam@linaro.org>
 <20250524185304.26698-2-manivannan.sadhasivam@linaro.org>
 <aDLFG06J-kXnvckG@wunner.de>
 <qujhzxzysxm6keqcnjx5jvt5ggsoiiogy2kpv4cu5qo4dcfrvm@yonxobo7jrk7>
 <aDQQLU1wrgstypEi@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDQQLU1wrgstypEi@wunner.de>

On Mon, May 26, 2025 at 08:54:37AM +0200, Lukas Wunner wrote:
> On Sun, May 25, 2025 at 01:28:18PM +0530, Manivannan Sadhasivam wrote:
> > On Sun, May 25, 2025 at 09:22:03AM +0200, Lukas Wunner wrote:
> > > "The device state" is ambiguous as the Root Port is a device itself
> > > and even referred to by the "dev" variable.  I think what you mean
> > > is "The Endpoint state".
> > > 
> > 
> > Yes! Will fix them while applying, thanks!
> 
> ICYMI, current controller/dw-rockchip branch still uses
> "The device state", not "The Endpoint state" in commit
> 56eecfc8f46f ("PCI/ERR: Add support for resetting the
> Root Ports in a platform specific way").
> 

Ah, missed this comment. Incorported now!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

