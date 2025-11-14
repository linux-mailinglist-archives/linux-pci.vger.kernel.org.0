Return-Path: <linux-pci+bounces-41258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E601C5EB97
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 19:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E84E435AE8B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A821341AAA;
	Fri, 14 Nov 2025 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iw786pLi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SkmIQe+s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1EB340D9D
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763141945; cv=none; b=eG1iwQAumaWMJ2vFyZByeE/DnjoQX9aYRx5OEXZobYTgZZVooidBUJWl6VV43RTdvlOpXopkgWqIzLQU176HeGs6aOrGJB7N3iLrV8STGZOjRAyw837Lt5FcQA4PaHxSRy0c8rysLKhy9q0THu4x3NCf0vAQvKQoS7slfR4C4VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763141945; c=relaxed/simple;
	bh=5jqsF6qpdbjHJ9L3+uMrQ8lMk3Vf+muidopenzoDqXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryQDO/DJRnS2Ko+XXau1J6HcgE2at1QUbIHrSkIYzx+V7fGYgEikgB1YKWuePIpuxQPg3+i2rQDt0Zs7ZWusZtjmxXLpXOKRVwEq+uXEcTawpeZlJwAEdu/VHtKAY6dN8+M0K+lUQpy1gVNCxWlSn1I1Z3f2HI6CLanxnw+y/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iw786pLi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SkmIQe+s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AEHSjcj120518
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 17:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HMxW2aaBF5DcW3MN80vii4x5Su81NzhoZ3dDWieADzs=; b=Iw786pLiSRMhyq+c
	/slhpaN96gscDlFdPEzcFtjstFkWfY6kOPIPKa7Z7xRlO6hQM2Ug7hYQ3hyjfBpd
	SCVR10He/5frX7a/MJBiXh/5yrBkUYTbocEnaKXR7TfvyJ3Fhp6AF4csJI7h1NRY
	S/TR9Qu+nFyNVHdqYijFiRg4PRhGWPMGJg5JpVxuWYvqsLQWd/dCd61B8Deic11o
	99cSi2ktiUbEL6bzXLRhSbZzFbf4vKByefzcfGuTDGNcTpYRQose1DjjGxDSUHHJ
	wM5yC1jpBnuUusFynQgMW9XiZxqhZ+Ti0NCvI3DU5Lxnsb0ETbWr6pSyG+Iuc66Y
	zOVh9Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ae7pj0867-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 17:39:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297fbfb4e53so41145275ad.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 09:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763141940; x=1763746740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMxW2aaBF5DcW3MN80vii4x5Su81NzhoZ3dDWieADzs=;
        b=SkmIQe+sxvMUjYiVCOGggBdD/qQnn0K5I7ITOulNZfRu4Lm7v5sT8uPQoDjFPFYTU4
         wzP8SNDbG2LO2MaASABTd+rof0e+tKpFqSRixGfl4ofpl5r8GVFEjov2GqFMNP+f4JTK
         0OdyQkcFW3jfjaNYB1IsXMGjM61tFTqDRGWNsymx6EPDKcDXc7Mf7l5+LSIvrnObHuqm
         ccYwuJFrGK+PsSv3ElCF/zpdmomlaG7c4eNb8tWAge303PhxbVroRiBC96UUHtdMw6F/
         itztiFQZIVbhvsXbayRg68mCPBnj/dO0GaCWHr0rIjGK7QZaWncrVaYyx5VxGiloW7iZ
         l6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763141940; x=1763746740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HMxW2aaBF5DcW3MN80vii4x5Su81NzhoZ3dDWieADzs=;
        b=vtX5NbIsWdQVLqquTCCoZVJYWP91bcbi4KOgyzfiBLzP9LUQnNanmp7jp7wTc+OgII
         Aiz/XqE/Re/RbhYSgvwk+6jDXlpWJ6T765gome2vkpgiC6fw1UJra7Gd8TaEjmz6ZqfK
         qKvU8tEk2CGTZXF2q9B5Pzz670Rj/ESzhE4Pb1ceunAoIjywDWQ+b0lOMUrL83daEf54
         cBLI7Qoc31hiB6i9jxf3vNI7q9zZp2UI+RigEm3+L7xDO77mxMlRDwtiSRxD/d2FbPXt
         biuSykoLWLCxiva3jqhxKYGoCpjXWNDeG1IexUyArG3GFFIsJickNCGpTgM7bYDCm1Xs
         UFkg==
X-Forwarded-Encrypted: i=1; AJvYcCUMegDxHUNQn1poSlkNTQ7+ke96vNGY/UXmdU5YhSjITWAsKxj2XFXOR4iAeOiHjH4La4GIdG53pIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjVNqZpmbUzsNQQ1BeZsl5+z+fOUM4BltiPJB/4b0pB1c60Nj+
	fs0SyLBhJHBzQQfgx4JDeg64Dn4xsNgkvaWFwiG51uvhNHvNv6FUEnUhe/FxqA/651yaqDQuoSZ
	70QdXXmjL+yUwBehHgZJq4QDqj3OTeQPwSWoGQ04KA1ldVlP7ReXZOQIb42+qObed8Fmt+pw=
X-Gm-Gg: ASbGncv5eVMKtOip5oBcmEbZxbfUI2V5BFCW4l67yuFftCwJHAE+GTjiaFrg0WF83aE
	RzcCEhRhw2Em+Qp2pzD7F0lm1vFJ91S8tNuP48tYYmD85cloLPXrBbUOzvhO9NCIJkfFc9irfSx
	TgdExwd80A2S1giiW3r6XMC6BzA+is/iz36wp5Nho6Rbp8Lk7xmz+EXgzZ5SGFF69/DN6B3p6CV
	BZWtpivxAPBp1THEq8ecRcdNBx3lO9WsEmEdfE6pNLZcrcMDqY2ztsqj0OUkrONnwvXIKkrhCEK
	rLIPOwoWdLh+Lm1kmRkVlvE68jHIkI0f4Rh8bGQczZSDQrlHMsziOXkmyl3bmA==
X-Received: by 2002:a17:902:d48b:b0:295:8da4:6404 with SMTP id d9443c01a7336-2986a74af0fmr46220405ad.40.1763141940212;
        Fri, 14 Nov 2025 09:39:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHutVOyH5k64ynXYMtx+bq2Tb3zdEJvtOd9hJTOgTVPbN1aautTCRluYkEqXUbvSGzDK3h9iQ==
X-Received: by 2002:a17:902:d48b:b0:295:8da4:6404 with SMTP id d9443c01a7336-2986a74af0fmr46219985ad.40.1763141939669;
        Fri, 14 Nov 2025 09:38:59 -0800 (PST)
Received: from work.. ([120.60.130.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c24941csm61649035ad.41.2025.11.14.09.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 09:38:59 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, helgaas@kernel.org, lpieralisi@kernel.org,
        robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, hans.zhang@cixtech.com
Cc: Manivannan Sadhasivam <mani@kernel.org>, mpillai@cadence.com,
        fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
        peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v11 00/10] Enhance the PCIe controller driver for next generation controllers
Date: Fri, 14 Nov 2025 23:08:45 +0530
Message-ID: <176314178823.616736.15861987413016604978.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251108140305.1120117-1-hans.zhang@cixtech.com>
References: <20251108140305.1120117-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6L3BEdh1y_wlJ8_Nl9ibLexQG1Q4vl8L
X-Authority-Analysis: v=2.4 cv=Z53h3XRA c=1 sm=1 tr=0 ts=69176935 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=FzO0a8Pu37YIpYJNCzyc8A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=TAThrSAKAAAA:8 a=VwQbUJbxAAAA:8
 a=qsCD9Ejo0f7OZcNaWdAA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=8BaDVV8zVhUtoWX9exhy:22
X-Proofpoint-GUID: 6L3BEdh1y_wlJ8_Nl9ibLexQG1Q4vl8L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDE0MiBTYWx0ZWRfX6BFD1prHFlvG
 +mVThxP6m9Asn0QuuNFWzgIEazyr9bI7eNMUSFmiZ6Bf7ggIUEJvq6ExDrTyQp2pqO/c3StYMam
 Jg9ZNEszebAnIQBwUON/HXnSzBEd8BRNMJggItPkw1MU4f1bADZbdjUqctooQ6rNsGT5J6L5Vn+
 NRGPtGEluP53ugrxANsqnSDG8iBkZjW05fyPOuQN2R2cSp2skKv1KqK5vMmYU7tACJ7Lz947wVG
 TeQrQKuodNNggzkyVli2fBNUAICv/3O7dflH5Vxk8cw3OGkQXIchpbnEw1xRUkPJE0GkEweOhzi
 M/utA28UynO/s5iDnD1xrAbvjbqW0DLxxIzZoSPvWz5SXzxIInaOXL+5On/yXkgVpnuR9FQ98G4
 gYouqt+NaM4sppNM2lfMXMYaFwXbLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140142


On Sat, 08 Nov 2025 22:02:55 +0800, hans.zhang@cixtech.com wrote:
> 

Applied, thanks!

[01/10] PCI: cadence: Add module support for platform controller driver
        commit: 611627a4e5e4af7b96aab4f10d130f6a8a615020
[02/10] PCI: cadence: Split PCIe controller header file
        commit: 3977be25f5fd973cad6bed810ac1045ba8cfbfa6
[03/10] PCI: cadence: Move PCIe RP common functions to a separate file
        commit: b80a7b4713c967479752ea4801eb1d1933093f58
[04/10] PCI: cadence: Add support for High Perf Architecture (HPA) controller
        commit: f5fa6c33b173d9279a4c6c9bff166aa7881f9e0f
[05/10] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex bindings
        commit: 50067e81132b9938ae655d7c17cc6e1ec7824e39
[07/10] PCI: sky1: Add PCIe host support for CIX Sky1
        commit: 8fdf7a5556526f646cbec0c4575ebc639052ee8a
[08/10] MAINTAINERS: add entry for CIX Sky1 PCIe driver
        commit: 7bdb5b229c552ea69962aa33f508a72f2789543b

NOTE: Squashed the patch 6 with 7 and moved the PCI ID definitions to the controller
driver itself. We don't add IDs to the uapi header unless there are more than
one user in the kernel.

- Mani

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

