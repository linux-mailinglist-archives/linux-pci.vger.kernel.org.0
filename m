Return-Path: <linux-pci+bounces-22862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCBDA4E532
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7417A8A20B8
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FC7BA38;
	Tue,  4 Mar 2025 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0qihsw6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB421FCCF7
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102204; cv=none; b=gzwhgOGJTsHtQvTq3eKMulPTSzjbvRHwTmq1qHLSJnXAPNY2/lusHme6E9FVPAHWo3BmKTXzFCYFOKP38uJtEmC2jbHDHXJhkYxtSiDdmpcy/1uUJ1hE3IMHKECaqOC5i554VCNiP6/gIEYdsgrJ0bCP1W6mektnpi2+BcoxfjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102204; c=relaxed/simple;
	bh=DvT37mlLylWirMmvziApQyMOyXFz2tPHw47pSw/2Ns0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGJMNk/T12RjIyVSMISzQBAKaiuhCoiU9/WlZIEdgoF6n8CzPTt2+63UjsCnmhz2SOcpVeh1WWAhejS9UsPo01v2nXqn/M+eu9z7P5WgIwn1PwHWkmYW+4Mp0a/O3guedn5d3alExO9s3bcJG58jFkhTClZ6dIPVOWSXu1x3Uqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f0qihsw6; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2feb9076a1cso9571799a91.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 07:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741102202; x=1741707002; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=66psdEYIrVGR86JKMR8+mqBEFxkGfgmcukM2sBzapxc=;
        b=f0qihsw6h6E1twiuVjL+pwN2kHj+/eIdoqLQS/bM5Pu1Rcst++qQvUyQnyW4fIl3Fw
         XHmrKq6oSDnN+xGBU+RPFbDbngaZY06NTdSdDc8lixsezuXDonsQtMs1DGPVU1+5o06U
         geZyewK6D+0sAxdjsYLg23YV+TA2kHt7sp/cAAWt0tKecJxorvOrQFJpAWJlOX6rGtXT
         aiRCAFZPNplSmEsb20L7Yjy3Oy5aNa4dIG6QvrRILp33DAlP208t+V8sni5oafxqCkrI
         KowpbOlG9gjuYfBw6xi5OHCkdKYAOqnd31j/Smi9wHgI5RTMl4TKXW0BpSlgeTgElKoe
         wKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102202; x=1741707002;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66psdEYIrVGR86JKMR8+mqBEFxkGfgmcukM2sBzapxc=;
        b=E+xl96JgsrL9IYv6TS72442Kn06NIWOyaQGdaSGJAshWci8kzMCPnUNUoQZXfQn9g/
         7b1Pt+fS/WPsSDYs9qiPQwR81aFCjWfAx2Hgi+Lc3vaMf7UPBzyF+EamwfF4rPf0I4Cw
         dEPhcoK/4TYaeXSIKsEKpe95E4W2NuXvx6nkvDZ/83SeIOodl1jM143HjKxSfU4GqGnX
         z+s5QNj0kj83ciDriZR7aOwTcabxPyT7uvFgrHLIdLjaWqmf6ONEG8XB6VgV86cKjLCI
         JSVMhWAHqGIMT1RfKO+UKG2B1DXZRa9qJVWMJ3/Fol47hGPoHv7jMg4JpgSh5PN4Cfip
         Ag5w==
X-Forwarded-Encrypted: i=1; AJvYcCVhdqqnItv0Om69DBOIYHiwUMQGv8rUNVdP4IhCXnRbsBGue4KDqm3Vv2nsMRyb0A7a0zRIHbJIyOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ycwPDIICCumm9d+8hmhhynPUYa60qaL4mdnf8U12gKtmu11a
	iq2W/cq1JcFg8KrhRqcFv07+/k0+pXxplHUEa2R3LSbVbWPyLVjgPu33HSz+2A==
X-Gm-Gg: ASbGncs+O5V/UXZZCnJ4u4ti58uyXXFFUxocDURPVpqmzx4KNvuNr4aPWE8sbavIadu
	LyfDpWu0df4Dp62vzJ2GLOZ4f8Zcp7QxfJdmwaTXwPFwW8Mxugo9sV0AbU8Kyiv1Xwuy9zoUHF2
	2/NA+4fz2zOE91uGQCqpZn52mNfvYjbLOcmGgBWgFF0Jbc3QzkOdP4B7JwNoLlH7L1fTphDa28b
	d/NkrvdymwvdTjsnJoO1odXpiapOYyeNZ5QSYmTJ/Q8Pwiin6fwNnGjo5BAgHmGYrGx8wEkUO74
	5fqIeiSXMNbH1TOEHJ06GYPv3Wvkbkp/OGKy0piJ4lBP/qLYHyYparo=
X-Google-Smtp-Source: AGHT+IHDLoudvsE8ThGCBDtv8xpmDC4PMrV1KRLn9yaD488OmdYvS42vvygcsTzqkS+txl9sTFzPNQ==
X-Received: by 2002:a05:6a20:7348:b0:1ee:be88:f5cf with SMTP id adf61e73a8af0-1f2f4e00bfbmr34435609637.32.1741102202650;
        Tue, 04 Mar 2025 07:30:02 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de38003sm10265993a12.33.2025.03.04.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:30:01 -0800 (PST)
Date: Tue, 4 Mar 2025 20:59:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
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
Message-ID: <20250304152952.pal66goo2dwegevh@thinkpad>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132039epcas5p31913eab0acec1eb5e7874897a084c725@epcas5p3.samsung.com>
 <20250221131548.59616-5-shradha.t@samsung.com>
 <20250303095200.GB1065658@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303095200.GB1065658@rocinante>

On Mon, Mar 03, 2025 at 06:52:00PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > +		29) Generates duplicate TLPs - duplicate_dllp
> > +		30) Generates Nullified TLPs - nullified_tlp
> 
> Would the above field called "duplicate_dllp" for duplicate TLPs be
> a potential typo?  Perhaps this should be called "duplicate_tlp"?
> 

Looks like a typo. As per Synopsys documentation, there is only 'duplicate TLP'
field.

Good catch!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

