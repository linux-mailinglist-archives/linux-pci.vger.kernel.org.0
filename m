Return-Path: <linux-pci+bounces-23188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F2A57B98
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 16:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5039118915A7
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 15:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AA51E3775;
	Sat,  8 Mar 2025 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BWUplUDZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058F21DEFFD
	for <linux-pci@vger.kernel.org>; Sat,  8 Mar 2025 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741447753; cv=none; b=Hz3T1TZ/xxJbFYrG9wJHWONnQMhR4BGLhN4RWH4C7dIpwFcDVkHo0jvi+LLVmJoWAMI0XgQbWMANGF2Kb17XOOnR4ksQw6ZFSCueVZXFuDdzBtvUC0OvwbVZiPEs3AsRCRZIGUOxHjhYzdIW5nnGTsA1S35c9rd7KPO6brWT1Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741447753; c=relaxed/simple;
	bh=DngW6UKwtoP4vTNhZNLO04627yOjUXfCZEoZdkARLkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POtKdm9l6HviNFWCsXDgLwltb/7BHoNAW5kAkuxlaFcfrqMuj4/IDMDfGan4B9tr5bR5w5blK7AexdSBDuFaPOtXkOk5C39EuDN8YGt7p/NlCzC9NXAdf36NUh2iqQFefmtDHNqglOYxa5xVIsSEIwTRPaAVnDDi2I2FbwHKzHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BWUplUDZ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bf1d48843so20606161fa.2
        for <linux-pci@vger.kernel.org>; Sat, 08 Mar 2025 07:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741447749; x=1742052549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1erwRbEpf42IpSPu2HfeF24p9T9l4keifT6FQUxIMM=;
        b=BWUplUDZeU96vc/TLQ7w/otbqzRgDvT04TbNFonvcJaruyHrXUlYrduHQmt78qat6q
         GmonXuEAXKDRBa90glxwaCN77+Wde2D5FsSFPkXNcQ2vy2MVdRbAu/YuPHQcD3M6EsSR
         dlCD9uJGmSBQYvIpmokxA1U+N/WFnKyJJGNiHwgOTlQGijR17Dz1nBGt/teRWg85WzgL
         MdtsLpgZ7rLGnZzIlDxhE9zg4ijroIIpoCzw/+dfvkBmCa4/V2BOa7Mjm/JL1V+T715o
         oKXC1OtQIA47M2C5tQmXRuaRhiTz5K3fYWqSaWM76Ss3/vq6KjMxEwb+6RarroS5CjCZ
         fW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741447749; x=1742052549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1erwRbEpf42IpSPu2HfeF24p9T9l4keifT6FQUxIMM=;
        b=PKt8+4v4ZPGH+q7fA4cSwvOn+UMGi9nSPchFtE16Zl2fk39wxV6oXCCGPt3MaGpoKU
         /ocxIfQdzqcpQIqjfQ9wXmuUr33pF4uYtL8cBbM7xe9yB76k8zeURZzmFwIG9ZMdLlaM
         8khfDOS38WVa0tu2/VFbk6jVrXZqXE2vKsSF23ZF/Jq0fBitq7SanU937BmtKkhpFVBq
         zBS+ahDcAetiXReHNHM581yX1QOCblJAT2iFMBzMxqMSoJVe9cjH26nimsPVcdxi1N3m
         grjhLDpEEcMpTIHbHaIw3bHvHxE1DTEFtKhLVU/n0YHYb5ZBSGCCz9xKnWHtgRXHtA14
         QhHw==
X-Forwarded-Encrypted: i=1; AJvYcCWAeyXBJ6CBtmiDR6o5Aw4dCq0j4WqMZ5HefsocWxlAP/kzgVIX6WRGkVOKa5EbC9OX/+9S4t7ASjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy01q+WvPnRGsojIEf1GKtcT9CLX3pgE2myjqaDNx1gZsldFCkw
	mh5aDgUYTONNRMcaYOnzuTdOzWZ6AaycdDXULA7LhjqRJgdKQEyDQcjwsaU4FXY=
X-Gm-Gg: ASbGnctIcmyr3T5Sjn9MWvNcs4J5KwIxUNb4ZOa9yCTZmJhOmQStMWgCdTyI8nMU9tE
	kAY5r9hUW6epdGKzGG0rsU9xjRGl3b1dNh/q4DuQupCAsol1ilxTGw+O4M5h5EIAxmfkOhPMi/a
	WwDY03k2yrmutVaBTxeT/m3JaR8shZzPl9b31rFlgniWKfW0Ez/4jx0/fjOP9KYKDxcUTSe9AZy
	NlNhqiSClFvqIp5goHfqRGRkv0m8hbhgvfspWeylo1t4zGn1XZBQ/IgeDeM5qUSoeuxWzSqQcMa
	HdoA1BvqbzTdKTTgXk644slHlrvHwgfJe8f7WFzr7Wsq84byQpRsMYakMAlTKxJ7hQztmMgOAV4
	DPoUpxACUrrXfc1rnyx6gBGcb
X-Google-Smtp-Source: AGHT+IHWJzyRENoKYCsCD6ryWleW1FfCxkcxA9oKFolKIPqPM2Gc1cW/mG3/aDezKXNBCG2jOe6Msg==
X-Received: by 2002:a05:651c:2106:b0:30b:b204:6b80 with SMTP id 38308e7fff4ca-30bf44eda0cmr24484481fa.8.1741447749006;
        Sat, 08 Mar 2025 07:29:09 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bfcc80809sm3965871fa.86.2025.03.08.07.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 07:29:07 -0800 (PST)
Date: Sat, 8 Mar 2025 17:29:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: George Moussalem <george.moussalem@outlook.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, andersson@kernel.org, bhelgaas@google.com, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, kishon@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	kw@linux.com, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, 
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com, robh@kernel.org, robimarko@gmail.com, 
	vkoul@kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v3 2/6] phy: qualcomm: qcom-uniphy-pcie 28LP add support
 for IPQ5018
Message-ID: <fwpdzm4gdulyhfnmcvoqsbnu3fwbqyc6gne3ayz7sr6eu2yyqy@hhii6x4pk7a7>
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
 <DS7PR19MB8883A6C7E8FA6810089453149DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
 <oeu6wkfhx2masvendoweoufzit6dcwwer5bakzvg75dz3uc4bj@bwuj4slnb24e>
 <e2d84147-c061-4f12-a44b-f60919625f77@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2d84147-c061-4f12-a44b-f60919625f77@oss.qualcomm.com>

On Sat, Mar 08, 2025 at 03:25:05PM +0100, Konrad Dybcio wrote:
> On 5.03.2025 9:39 PM, Dmitry Baryshkov wrote:
> > On Wed, Mar 05, 2025 at 05:41:27PM +0400, George Moussalem wrote:
> >> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> >>
> >> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> > 
> > Something is wrong here. There can't be two authors for the patch.
> 
> It may be that Nitheesh was the original author, whose patch was then
> picked up by Sricharan for sending (no additional notices of
> co-development), but George later did the same, forgetting to remove
> Sricharan from the chain.

That would go to the SoB trailers. The issue is slightly different. I
can't even come up with a normal way to end up with the patch having
two From: headers:

The only way how one can get the From: header is by doing git
format-patch. But then git am would get rid of it by filling the commit
metadata.

-- 
With best wishes
Dmitry

