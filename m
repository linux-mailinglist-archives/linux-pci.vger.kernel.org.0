Return-Path: <linux-pci+bounces-36781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35397B969EA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 17:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39BE18A7271
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5FF23E325;
	Tue, 23 Sep 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LSEnORMK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38FD231827
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641882; cv=none; b=WMKN4iYCaB1hjldC2vgWQxETAAJR5czk0xxY7KQaz/aJrMZfrhhbW841/j94CbVSXux9caCqColkD1Pw8CJBOYTjo54RpuZsi6zo+KuoIaKsC7baANThD5x0cZmKzXFisn1Evh2td7If7b87UuYrjB33ZHwX2+cJXbxOk+rKEOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641882; c=relaxed/simple;
	bh=cHWMRWpmElbbxnsvIVo4IfwpJwGptDDbWvG2sPBEoBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaT1AbK04u4acm+O/dUC1wvdzce6Xp8KasqcczPgjAhdf7u7/O193uNS2AOBnz8TZBe0+956D5H9aF7LjyTBCiQFL0K4LgIcuv9aYXJi5esjdjnToUeH6zv4fqRiDzLAO+Vl0DruDLPkR1oBd/1lL7nfoqMvDpdYAnXX/GgL3Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LSEnORMK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8HBjA002850
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 15:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ufAuzNOrEuaR7kWSPEsTig4aXq8QsxU007pyQbw/68U=; b=LSEnORMK6xSFBWBG
	WM96ZYe4AaIQpeGZOk2Er49cK60h4Jtp3xJir7zOjbnBWy/pK5c19aIPLng9oAsh
	/tD+Vp91woA1wlD8w/rjgRiDi3+uCUoS2t6X4oW+Vm0Nc1Y/+pA6W/NhLo7V5hyc
	3+3xsoMpLWCX572zLyw0ns0fzwN2KfZ1AlNj4gA2vYCD13CUMESeLBBjlah8z0al
	HwBh0XW4zSjbmBLQp9u7UTD/7HfNcW8Q8t71VV6XYfWAtFfAe0bENnvRXyS4xnio
	hbPYkKHvodJ2LlG8V2xMNAIkaXAdVJSK5WJ/UW5YxtvVZGPu5cKxcYuT7uyeXyI3
	9NUVTQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv11655-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 15:37:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32d4e8fe166so8229464a91.2
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 08:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641878; x=1759246678;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufAuzNOrEuaR7kWSPEsTig4aXq8QsxU007pyQbw/68U=;
        b=UzraTccJEYyf2Kep97ds/uUaESyJBxa5femEgH2X5VF9UkG/1D5n+UKibuhI5K7p3G
         e1Wdl13wtJgQMeIz/BXDFWDUMm4sbrnW68G9JUm+40GAJkJOPpyuty8Zshlb5Qo5lC4X
         mRmGBi8itPKTSGrFr4ViUJ+LQvEHKMM/eVbZEzLjV7n/tU78iDNZK4LtnIdnDisrssYw
         gR5fLuJSvYVFWr1ap0ibfY4e4DdKeio4eQM9oBScMmgR7sn4uGBemiyw9io/ClHE7gsM
         6M7NLFL9c3JXZ8BiDmzAowe3aUA+RbruOwrd5+X6Y0r+OCKN9JxKjGGsk5t5gym9vVMl
         hJrA==
X-Forwarded-Encrypted: i=1; AJvYcCUBjXFdBFY6m8gl4TG+ksKyreReQu/V7n5tPQlIGLqCXG4tBmLMvI6Cx8rZoGIrnDX+DV3fTV/TTUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR9lJoT9i7NJG9Mc6RvgPqP7jRV+de4kY9InwlLAxeb0LA/xjj
	m4HcU4nu8u39PrD++zdEvk4srPVpYzvVnNiDMRbM0xWVVVwkMRYgBLgq9vPosTkkrtKPsPoQNGV
	g/iE6l/cKdoaHSR+NTeGMMHdqRRfQc4Ew7Ju1pfmOOghQjS0/+uOiZcu4nQ3kqro=
X-Gm-Gg: ASbGnctXkvFVpYTOdY+w7POSLhGfuoyDxWv/izdrasofPpzkE0GMh+KNl7gIisWXKBb
	fMoICUuRpZNy0AT/0dSARpvVjsbwrPBxAMc+r+x4uxCeBm1n7li7mNbPKvydabdOJC7AoILlwBC
	O2sJxPtoUbAiUu8dO8UfSlvteOlUbatPnvmsqYEbdNJDx3Mqk+Njkd+uep5CyQ2f60fJ9gz5Mwx
	68c9FaO36nXJRB3Tfxly2jgp8Og9KjqngrVZjdiguMQjP8n4efWKaAJickJGRGJ2YNYV4DxKPf1
	XQDFNY45emAEESgK3ZPaqRDrHnAKvXY39jPGEh4uhdYK2A3bhstAZg==
X-Received: by 2002:a17:90a:e184:b0:32b:623d:ee91 with SMTP id 98e67ed59e1d1-332a95df91emr3380135a91.27.1758641878064;
        Tue, 23 Sep 2025 08:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ5jbKJKVF1FDLY8GLviHNw6cT/lbR2hSnQ4OQG1i2UHqwyS4SLyWKqPX7QqT4IcM9uxiqXQ==
X-Received: by 2002:a17:90a:e184:b0:32b:623d:ee91 with SMTP id 98e67ed59e1d1-332a95df91emr3380091a91.27.1758641877466;
        Tue, 23 Sep 2025 08:37:57 -0700 (PDT)
Received: from work ([120.60.54.28])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5526a9af62sm10960133a12.44.2025.09.23.08.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:37:56 -0700 (PDT)
Date: Tue, 23 Sep 2025 21:07:49 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Xingang Wang <wangxingang5@huawei.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Fix ACS enablement for Root Ports in DT
 platforms
Message-ID: <tzlbsnsoymhjlri5rm7dw5btb2m2tpzemtyqhjpa2eu3josf5c@uivuvkpx3wep>
References: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
 <20250918141102.GO1326709@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918141102.GO1326709@ziepe.ca>
X-Proofpoint-GUID: cgEaX_Lwl8hS01FFf-3v4tPuR2KFUEtU
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d2bed7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=0rnFkIpAFraqCr9DAfvGIQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=X2H1Dzq6MFM7WdPJhOEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX+G2UmaJbVvCX
 GiatLLqZyrKfM8qP9Tj2pWQOcYRTsh8go5Kn3cn+Hr4NMqYsVYmi13coex2qafuPksLykJW64Fb
 454Gk1sVMqJn2I1XWizzDfxmTfkeFNjQEzNHdtny+iIf3oNLv1IY6Z6GfaHVe+etsuUYxyphCG1
 EwICqrxLy3Lh97KaDFKVfODmLRJOH8BmhJKyLUIzABZs7jx3mKEph/QZX02Xp1WpLo6ABg3+7YB
 bispPBPw1tYhDjmYfkInmczbzOsFmFql6DNsapZj01zoEOS1eSyVdqoSI78+kCz+sUki5qV+Qfe
 uCx+pEUxBvp8RBZAjX+YZqWo265OhjLtrZvPQmmi45Qfn/1Oz4xanmQDg+wHelN3zkliZ8Y2Y/f
 +McRsEr+
X-Proofpoint-ORIG-GUID: cgEaX_Lwl8hS01FFf-3v4tPuR2KFUEtU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

On Thu, Sep 18, 2025 at 11:11:02AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 10, 2025 at 11:09:19PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > This issue was already found and addressed with a quirk for a different device
> > from Microsemi with 'commit, aa667c6408d2 ("PCI: Workaround IDT switch ACS
> > Source Validation erratum")'. Apparently, this issue seems to be documented in
> > the erratum #36 of IDT 89H32H8G3-YC, which is not publicly available.
> 
> This is a pretty broken device! I'm not sure this fix is good enough
> though.
> 
> For instance if you reset a downstream device it should loose its RID
> and then the config cycles waiting for reset to complete will trigger SV
> and reset will fail?
> 

No. Resetting the Ethernet controller connected to the switch downstream port
doesn't fail and we could see that the reset succeeds.

Maybe the bus number was still captured by the device.

> Maybe a better answer is to say these switches don't support SV and
> prevent the kernel from enabling it in the first place?
> 

I'm not sure though, as Windows seem to be running fine just with this erratum,
without disabling SV.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

