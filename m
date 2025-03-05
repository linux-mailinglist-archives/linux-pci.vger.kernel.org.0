Return-Path: <linux-pci+bounces-23016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CC8A50CAA
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 21:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62AF31888FD5
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 20:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48156255252;
	Wed,  5 Mar 2025 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5yW/C3g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5535025484E
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207166; cv=none; b=uTtV2b3A6rs7ATGcXEvZRDvzQDo24luuEOVDz8tMAX4RLOvSpdSZR3yHAaqgcp3vTzw3k+N6vJ1Ct/g/UpZkReusQTJa0IknrRzgtzdAAQv6Ye/2dTee0OoKk91KtKx5q7gpAo2yzC4UYPnRVTB+kVDBimhDGZNxk4EwNrq6c14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207166; c=relaxed/simple;
	bh=OOdcGVb9J/2+PQH2L2EJo4drk+rT60VmQIudXxz2zS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTU9RuKeZJPJZ2Aw52/N9Jf2j1mVcpp2Uu0vuhdK/KKautjf3VUNLvq0uj9vR3JNiL3UCAGvbD5lVNsJVFsm2Na+uyFkXJKfouI0jgDjkfvAna5Wdjla49XmPJYTq3Pp/7apFPOgtKT9tHIA0rKCLs43G26mLdvu8y46TJRCsyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V5yW/C3g; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30b8f0c514cso53923831fa.2
        for <linux-pci@vger.kernel.org>; Wed, 05 Mar 2025 12:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741207162; x=1741811962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nfcoSxpPFiFuUn8/1PBHFRFeN5zz8LwDXafFbEhPVL4=;
        b=V5yW/C3gtv77+9LuT6pw5yMMjUnHpzsMQyEObUuDzGhbRiGniega86NL+WpapVNide
         peWR+q1NIZluJ80DP/FXDqsdKjHSNM2cP1OMkMGHvpod0Fx1kEzp07osK0xKSsHIaBMZ
         Hbg9KB6/dLauJQdg+o7PvSxLHRcfjJjyB1iihUWOaPxgYEyYxp0W8Zvech94KiAvcA2F
         QeMbppTuEJ+waVg1dS4R7oDzroV+kyipB9ycviEEv1Fh36cEHIr717NhzWp4Vpg+cMii
         hVvOtPGIFOGJM8sYUKTXdDxYWxz6EHHmKmxzOpcqXYua7XLQs2Y8Sw3RkNyye2FVadVh
         7zAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741207162; x=1741811962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfcoSxpPFiFuUn8/1PBHFRFeN5zz8LwDXafFbEhPVL4=;
        b=xClooMs2WxshBV3IDNZgddguVB6gKzqmK8UmyNqJLfz8B8u01Ca4fzA2RUuo0+WV/c
         zqLitiVfSjIXUGfCr8knd75s+O8nkgqY44WvX7qCfd0uSiEJQ1cF8H+pYLXiBCU4e9c3
         Qlu9DzdZ9SMelhtuLJE+IlqHlyA+tyLu/L2pxboEMGpcn95c02VUc42tfU+PDazKTj5R
         g+i1Xb20BLXM+m3aZt6mDCqspdljdtiHO95wgt3RU0Tpv6nf5D1aZCD0iYUyZYR5X1OP
         lfyk141bNv1X0VydZEJCA+q3wsiQbx7e8TuwAU1F846eL2qraE37MvMVb0n4kj7sWjPv
         pgaA==
X-Forwarded-Encrypted: i=1; AJvYcCVnH5RqQDd3z3NydMIApVbkuPdfBjABI/PgEtX6d9AWrRvQG0tpAbXj86keXS2Fsh1N38BSft52vlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRLz3TBafb+a3TRB2Be5rNhewCrgAqCCXBRDFyER1YLYjJNADS
	2M+AZ1hV+abIwBdHZyuoU2nK7Nb6yd6+E/H5CDwbUnYw+fPlDaaeZEzDdS7mBq4=
X-Gm-Gg: ASbGncsLBeXsTWcL+FvI4I7hG7k0JYA+jYdHtSR0HjuwG1NsdGqKSwaHhisnKQNOrrL
	15BXjJaefKTpSSAR0SGtiNsqO90I00lDjtqSjfgrehGt69gZYIofHTTSMS9nP0y1OrJVyBBNmir
	Rb3osPgGWBQMuFLWa6cYne5Qtl3UicmITCyzmNpirFR4ifNzTpFnVFf9VNeZJPVM2XoQtvJfmHB
	oyEmI1KaK3M9ErluRISzEBYfH8iEYBbcpSWQWPqBaqFwYUPja4VOZ85DcmW7rnZHHzoLHgHPCGz
	OTF5htisABDfsU7620kgOPCiNzk/Hfx0ghstLDkK4xfpuqdEsDKq+RF0snLFp9L1ZFvMbfJWPS3
	MmqucJS9O1joxeo+wKicxFRmB
X-Google-Smtp-Source: AGHT+IEbTbwWMOL7YUjwBALdMqyrxkNiXMKt6dO7bGnM96j30pIhXzA/HZiAODGdLHzT7qmpsh6SMw==
X-Received: by 2002:a2e:b1cf:0:b0:302:48fd:6922 with SMTP id 38308e7fff4ca-30bd7b324c0mr16257451fa.37.1741207162209;
        Wed, 05 Mar 2025 12:39:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bc2ad651bsm9041781fa.20.2025.03.05.12.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 12:39:21 -0800 (PST)
Date: Wed, 5 Mar 2025 22:39:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, andersson@kernel.org, 
	bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	kishon@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, kw@linux.com, 
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, p.zabel@pengutronix.de, 
	quic_nsekar@quicinc.com, robh@kernel.org, robimarko@gmail.com, vkoul@kernel.org, 
	quic_srichara@quicinc.com
Subject: Re: [PATCH v3 2/6] phy: qualcomm: qcom-uniphy-pcie 28LP add support
 for IPQ5018
Message-ID: <oeu6wkfhx2masvendoweoufzit6dcwwer5bakzvg75dz3uc4bj@bwuj4slnb24e>
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
 <DS7PR19MB8883A6C7E8FA6810089453149DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR19MB8883A6C7E8FA6810089453149DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>

On Wed, Mar 05, 2025 at 05:41:27PM +0400, George Moussalem wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Something is wrong here. There can't be two authors for the patch.

LGTM otherwise

> 
> The Qualcomm UNIPHY PCIe PHY 28LP is found on both IPQ5332 and IPQ5018.
> Adding the PHY init sequence, pipe clock rate, and compatible for IPQ5018.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 

-- 
With best wishes
Dmitry

