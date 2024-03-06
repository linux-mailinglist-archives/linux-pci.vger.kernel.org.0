Return-Path: <linux-pci+bounces-4555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59EC8732AE
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 10:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D825A1C2040C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 09:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC605DF1F;
	Wed,  6 Mar 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6prxrGX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD1B1B7E3
	for <linux-pci@vger.kernel.org>; Wed,  6 Mar 2024 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717946; cv=none; b=GeYTgT0Ph7cX440flcMjRNkMfrlM+vwjsPumeyf4Pd9xPga+dn0Q0cgW3qP+mHMk71UijTGKmYEMP7yd7NepCCx0Ne4i+uTEYSIdEICnp0rtP0yKFrb3T73ERdTP5Ibkv/kGQuS9an3zrX0p1SXxrRB5sr9Kv1dESV3IusKtE6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717946; c=relaxed/simple;
	bh=tZqOWl/U+Elbnt1R7UGa8ygGo0JWMb8haTOc9kpg6ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTCbskXpZDXgxHvDU/Tk2j2wMQE0kuG8jRhFYi0JAoIC/9NUgw4sytjYVx/Jnn61TBSouO3BBNbU6iyyvrs+/qj46h4q3WDaOMeiJH5AG8OjVGaGNdaM5g1wrla2zmBbDhndbxdUpsmjQTinsGjRDIDjfCv4/y5sYyfc0xAlV4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L6prxrGX; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29b7caa88c6so74142a91.0
        for <linux-pci@vger.kernel.org>; Wed, 06 Mar 2024 01:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709717945; x=1710322745; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B9/QgTMyt6fHk74mMOMoiAquWcsGjb450gZKkLexk1U=;
        b=L6prxrGXTA52RVYVPuhlpSGRlK7POfhoePJeok+mqUHFwsHncqxj5XtbELkyfy7RJP
         ZDvVz50pKFpzHk0V2jea7EJdQiacSjRRgH8ypAggOndXlDHamMY2oYTie+cBlLfhdPhb
         Xwv0Im/OXk2p8Y4UQHsepXuwWMMBOgdKre6cu8QpowzdjtD9R7x37IDHJ4iQttgXNWHW
         MwWS6h7/5lLa1+gpFEBAbRqoA3xBAHU3OE4osAuut7jtBH2kKZ/kccKquBDI2ZabX7uV
         2f5rsf83Av5HCGVVW4jmFYSyUh+vNHWTuhNYE02Y29jrpZ1+DMT25jT4NcOxz7QIEvZc
         c9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709717945; x=1710322745;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9/QgTMyt6fHk74mMOMoiAquWcsGjb450gZKkLexk1U=;
        b=BRofm4FX8HLs4VEQ5BfjNAn3S3c/A4UrOaibbGdIzyHjG3sFoIK+CrC8xoH0y5V8tt
         WvNdGO+85aCAAACjJ/o4CoUdN5myTPNvg6DLIupco69Ucnc6mMtyrqD//vyqcbNkBnOF
         18QH7AFPC+pcgK36MjFeu6/zhl405Jn8wwts1PuyHrkbE/KAWOfALcmQAq3OOA0/NOjE
         TyXAiI6b2BSQmkY9mxsnlEsR2b+jX2FZcamErhfY1H0ld+wirw7eJaz0Wg6zTXkt0ac3
         9NDzVCjjQBybxaOsrdloANVkChiACB9LHk9UksBmvrooWHhf7Ze5WTisK/bnL7jAEz4a
         Tm/w==
X-Forwarded-Encrypted: i=1; AJvYcCXjx9t6sy0UmVnAswz0LY1ILL0TWro2clJUvboyr114zLAOnVqnqjJpRrp5sEu9RCVNejtrIGaXhST/Q4KYzydTZJNGE5e6Q4C8
X-Gm-Message-State: AOJu0Yzr3N+8KmqtXKNJXsz9jbpEyQkrloo89RwBY4z7Zp2T7ExPw8uc
	SsY8iH8lwJsh2pjSVV45MVbty2NVuVt/lE7JJ3t2BP/RsWtB/+7slFEA1oJqKA==
X-Google-Smtp-Source: AGHT+IHbO1CHuqg+60eRdVkKVCxleqZt9OqbjKUuy5Fd7mfWIapm625mEDrgXo2J1vMHZLAWyc1MHQ==
X-Received: by 2002:a17:90a:688c:b0:29a:bdbe:5859 with SMTP id a12-20020a17090a688c00b0029abdbe5859mr10903212pjd.7.1709717944519;
        Wed, 06 Mar 2024 01:39:04 -0800 (PST)
Received: from thinkpad ([117.248.1.194])
        by smtp.gmail.com with ESMTPSA id oj13-20020a17090b4d8d00b0029b13f233f6sm10337019pjb.11.2024.03.06.01.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 01:39:04 -0800 (PST)
Date: Wed, 6 Mar 2024 15:08:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] arm64: dts: qcom: sc8280xp: PCIe fixes and
 GICv3 ITS enable
Message-ID: <20240306093857.GC4129@thinkpad>
References: <20240305081105.11912-1-johan+linaro@kernel.org>
 <20240306063302.GA4129@thinkpad>
 <ZegZMNWxCnLbHDxP@hovoldconsulting.com>
 <20240306083925.GB4129@thinkpad>
 <CAA8EJppsbX=YXf1Z6Ud+YMnp2XnutN1hcb1T0KdAAWXFREVxXg@mail.gmail.com>
 <Zegzf_QKbr8yA6Vw@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zegzf_QKbr8yA6Vw@hovoldconsulting.com>

On Wed, Mar 06, 2024 at 10:12:31AM +0100, Johan Hovold wrote:
> On Wed, Mar 06, 2024 at 10:48:30AM +0200, Dmitry Baryshkov wrote:
> > On Wed, 6 Mar 2024 at 10:39, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > > On Wed, Mar 06, 2024 at 08:20:16AM +0100, Johan Hovold wrote:
> > > > On Wed, Mar 06, 2024 at 12:03:02PM +0530, Manivannan Sadhasivam wrote:
> 
> > > > > Just received confirmation from Qcom that L0s is not supported for any of the
> > > > > PCIe instances in sc8280xp (and its derivatives). Please move the property to
> > > > > SoC dtsi.
> 
> > > > Ok, thanks for confirming. But then the devicetree property is not the
> > > > right way to handle this, and we should disable L0s based on the
> > > > compatible string instead.
> 
> > > Hmm. I checked further and got the info that there is no change in the IP, but
> > > the PHY sequence is not tuned correctly for L0s (as I suspected earlier). So
> > > there will be AERs when L0s is enabled on any controller instance. And there
> > > will be no updated PHY sequence in the future also for this chipset.
> > 
> > Why? If it is a bug in the PHY driver, it should be fixed there
> > instead of adding workarounds.
> 
> ASPM L0s is currently broken on these platforms and, as far as I
> understand, both under Windows and Linux. Since Qualcomm hasn't been
> able to come up with the necessary PHY init sequences for these
> platforms yet, I doubt they will suddenly appear in the near future.
> 
> So we need to disable L0s for now. If an updated PHY init sequence later
> appears, we can always enable it again.
> 

It could be the same case for all 'non-mobile' chipsets (automotive, compute,
modem). So instead of using the compatible, please add a flag and set that for
all non-mobile SoCs. Like the ones starting with SAxxx, SCxxx, SDxxx.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

