Return-Path: <linux-pci+bounces-32830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D44B0F7C1
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 18:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11BB585379
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 16:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863101339A4;
	Wed, 23 Jul 2025 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kju2Vkh5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06561F3B83
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286657; cv=none; b=LRbkR0y8kKyfqa3fZEwVCXSASz/keipQ7NYpmssSpX6wYa12QYRsSYmEv3Uq7CmqAxDPqHYOVrU+tV3kMm6uou6WNN0/NLB+P6j+1T9WlxttsgnhTUW9DzFwuNwcsJdgscWwbbUfl4sm+4433tm+9/+dolSoxxNKSEJ+vI3A3qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286657; c=relaxed/simple;
	bh=KCfstuN77De2m94GHTvsNHvFZ1vdK9nOTEgDVUINVok=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fcvxX0ti/1aYvinZXt70SSa5SJWXhJqoQ8qbOmzoPoKb2x3xUXrzn+81wDsnsHZHREH3Jiu0Ue0RGGZfUCaDT5vpUTBNaWsdEd9FjlPVOc3Nk9ZVQURR2D7QjnNHKAQceJMiECXQlIk016iwZWqm91m6ot6sqVYXaJjXceJBXTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kju2Vkh5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9bjIH007832
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 16:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1IVq+bSzc+i0gbcHvdWX5X0gFlHkos8QZkR6QJHMwvk=; b=kju2Vkh5qgJixjmy
	0LuCVz/DmtBSHrsGDasQ2Tu4i4rfNXAg2XZijdJlxWiM0RpwLAZbVFKCm8Hoovgd
	WyypJ2Tp2ECJ6/D1ZBIJHVqwaTsrmnVKfxO05S/8LVeJ0NmZJe+U7mjn8HyvKFW5
	WcNqfS5NM8YhZeMkOp0DKg7PAe1X3OEvU2mHfm1mF6KDDKQijF22o/x9jptCNyUh
	BOS1stNXo85wblzZy+glcyioFMYcaFb4KIcBZXUd5gJC3WFcJPxUA5DOEv/iR8ME
	wjI4qeGDb7YbpAdubb2R/ukaMSlVLcn4TxEL7E+S9nP8vhm/uE+yAodgIFoYaY9w
	wTDMiA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qdsud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 16:04:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e32b9398e4so8029085a.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 09:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753286654; x=1753891454;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IVq+bSzc+i0gbcHvdWX5X0gFlHkos8QZkR6QJHMwvk=;
        b=RFrBaNZTmx2RF9+awN4b9UTq+Ocz+Nq6gU1Q/jh+/gTvQVOmpIvJIQ6T2GdgHu+Lln
         dDPHskXIvSD5qZfPNZT9IdkkP+X7CCoONCds7yxX6tZ3g92XjGMgAy4es4lbJhC8cJBQ
         UpCqFFeUpo3xwNLnyrRuRobWsOccf5z/VnJx3g8brl/v8R2ZhY9B96ma9cOdCGTzm5AU
         /7x3ikCPX6qIBdG4qnq7wz2OwRZQmDgXSU2H90aBY2zf9zFSdJYgYY/1M4BLhqK3D2ho
         ca76sp5n/CpIjE6SkFGOBZ+ZRC+7cG2WpL7KlN1O6vQc6SaQ0k6io+PxZOCkuJ29B+e6
         e9Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXcO+7GFOQrDrdHh8SYVFPk12Hf4JNihTb7waBlMA4zQhrHfYqYpkmZOpO4soW0+TXsrrfwHVPvfRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+GGRZuO+pY+GYUYpBTA4QR4PjKpuQbrIKJ2+1p8UGltIffvZ2
	FGbfA/1KEmnj/25p9fBZOFplL94FDvQFYjBFHw2uM9Vptibx9oNCnKbQtu8BnxiPgmxtTDgE7my
	g1sKuZ4Bb8grpEAkYDetzi3ePCV9Re28WzstkwAhq1qHLX68HkpVS2GPIkMyAJCI=
X-Gm-Gg: ASbGnctHR9rjrJKr4PHI9m5M4KklVBQtzaoI7gEYUR1deya3Eh1/OjjSYpNPCqr0kKG
	gy90r0fkgV7dqT4TBQEwT2p4gvewJx8W4irQ4IU3LB4W1QqOU0Rrla7Aw0eea7ZO/jfPmfPyQBO
	fJGRKC9rpVvZnC75iKzt0AMcN8SmBpq+88NCf5eNXvg2VsyaK2NuKu/4Se4pLtwBCbR/U+uRhzX
	CnvZdYiffZ6mO2C1hxEiAtzxjMvlaqgP1J6tjsc2+DUr4HbH4D+hXum+szisXprmGFTO/uNiQY3
	t5CVe0/S/8TeEkb/Insla6ZchWXOGii3s3E=
X-Received: by 2002:a05:6214:1c86:b0:6fa:c81a:6231 with SMTP id 6a1803df08f44-707006aa843mr42537606d6.8.1753286653586;
        Wed, 23 Jul 2025 09:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhZaSVPPcM0H02S0SyrGlN2YH/RRRuvuVz7tS54TmJPI+kAWBGLQw4aW0+GxosM+D8oehJNQ==
X-Received: by 2002:a05:6214:1c86:b0:6fa:c81a:6231 with SMTP id 6a1803df08f44-707006aa843mr42536996d6.8.1753286652887;
        Wed, 23 Jul 2025 09:04:12 -0700 (PDT)
Received: from [192.168.1.17] ([61.2.112.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8bc2dasm64468956d6.12.2025.07.23.09.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 09:04:12 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
References: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 0/4] pci: qcom: drop unrelated clock and
 add link_down reset for sa8775p
Message-Id: <175328664500.29282.12330427204137280127.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 21:34:05 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDEzOCBTYWx0ZWRfX/o7Gkqk7HTwO
 iDK6p+1kfAQzCe3BeBb0Rd49xxMGillWOLqwTJfyoMHJMceSbBymClh0aZ6Q/0thLECzOiRUYF1
 Pm3cD27BGQSliQ5FNFp09ThCaER89ToXm0JWWKFl9AkrL6ksgrMrAozRCMDUEJh9WTtXx7fCqGL
 6mACB4r8KZUVRSGNAE64KUpe7FqHZqr4bd5LUm8iuGzK+20o0tFnU1SeHNcgbqRVoyOyUJXSU4G
 TQjeCq3v2N1WX6+jHoZk1nt3VPpO4moaaDDZMcJltKZO6Ir+PlRKFFeJ1C8gWIJe+r8AIHVqjKK
 AMYMukgldiQlksVPOG1v8yVctYcXR8U7GusalCQLolSC/0vMDzCmMafk5FJfZiEkZNHxG3X3dpc
 HGvXkx/+aJc0e0EHE2f/5ZHa91LXShUciVeoR7ur9bAey9jxzeyZkOU5aFqC+8Nu7/RaRrI9
X-Proofpoint-ORIG-GUID: a7vBI4bYG_KltT_Bz1hMHeUd329UsJrb
X-Proofpoint-GUID: a7vBI4bYG_KltT_Bz1hMHeUd329UsJrb
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=688107fe cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=L2vWZV9GmkZVUxua0bORKQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=AxdmJqN1ex9b-t5leqYA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=843 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230138


On Fri, 18 Jul 2025 16:17:14 +0800, Ziyue Zhang wrote:
> This series drop gcc_aux_clock in pcie phy, the pcie aux clock should
> be gcc_phy_aux_clock. And sa8775p platform support link_down reset in
> hardware, so add it for both pcie0 and pcie1 to provide a better user
> experience.
> 
> Have follwing changes:
>   - Update pcie phy bindings for sa8775p.
>   - Document link_down reset.
>   - Remove aux clock from pcie phy.
>   - Add link_down reset for pcie.
> 
> [...]

Applied, thanks!

[2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document link_down reset
      commit: 10e7298dc0f14c52d9b5c52fb52558f567815b7c

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


