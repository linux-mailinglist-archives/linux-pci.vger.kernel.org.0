Return-Path: <linux-pci+bounces-43865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A720CEA472
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 18:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5949C301A1FE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B5423F26A;
	Tue, 30 Dec 2025 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LmPOQtwD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PU1qXFdj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5198821CA0D
	for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767114820; cv=none; b=f+6lmSWLxX6M3flQt/U6ewbcWoXYxofGG1Zig1jKDLvEHNlfRVLbvZrH/gc1IFSbggdTWh/nuVZxib6DhiPcLhd502MRdrfBLbRMjgG9gaOPYX4pYsZWBO9JSES6sl2eKKBb7dudIixU90dz7F1Mzj8jbZvL88Q2O/I1LGXRI68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767114820; c=relaxed/simple;
	bh=VXCiGMnnNa/afDS9FEx92+VeePXPynTiGO+i3tGbTbk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=syBE29irVwY7JuY0jTpkfPvIDpP6u+mG8nE8egfOJ0TAxQaGuvDLQ3ikRAKHAMXKDAARLRbtBzALlHzYNZAr4sPNubHkoP3iXvnTpTe8zRfgj0oGjovZMd+jkH5g97p7u65Ch22OZct5w6PCwnIIVJceofZ4HFS8pMugx9Ypyqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LmPOQtwD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PU1qXFdj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUA99vh2829793
	for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 17:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O2ELm1lluLn3D3dd27glXZ0eYBKJS1nER7eS6v4eehQ=; b=LmPOQtwDvtkgiDIk
	/um4xqPfNWbAB9U6iPRFBO06N3pFumd5Kn9bZCjfz7ZsxfCYlGqZd3zv0kzm5MPI
	Gqj5m8zL3orNCYIrkwXBW0mQqdtUMz0eKeGxlYaacQmyqoD3GD1ldCMRl7iXHrxA
	5MIWQ42RDnAHULQLODl1s4rRowYeG7HLo5MAxHBtFxCuNTMtZqK1UOJDDrTQFPGB
	+MtKT5xqNEZFtB2TU1iGuEUJgEfPHGE7yS4rdJn5IoN4dZ7H9ym98e2r3Z5psTmU
	+53OSkEB4v2y/eFMrUD9eh4zFB9P1n0/mfpwQ/HTkymqAn2aYPYljAb1VxxYESJL
	+ZycgQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0skjg2x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 17:13:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0fe4ade9eso103939715ad.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 09:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767114817; x=1767719617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2ELm1lluLn3D3dd27glXZ0eYBKJS1nER7eS6v4eehQ=;
        b=PU1qXFdjv/JiXVSADDI0ALZFQcXH5u304MfZuYPGFHnQEbQXKUSuhYo4etgNf5qNeG
         Mm+1BOrEnHUlm1NM5gs9kc+ZDBJ8kjXbej5SnCuzD6WuNC59INmx0AXFaqHFQ2zaCRHD
         VospiQMf5CyyPF0knFrrAGO9d/xX/T1ptjjZdv91JT7t8/V3zWnZ6kPwIvXtpJVTTeFj
         vqr5pZHv3Q1RrFCr+7PvRcXfsTTa9WXmDSPpIraH5l+ZWte0fsox04B3FxefJgmPd/gs
         V9E0VJN+uVem9AannXS6Ge1z7cdaAwOel8uXEIMDe6b8f6p/QDbQFmVyP8Fys6isnAIX
         CA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767114817; x=1767719617;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O2ELm1lluLn3D3dd27glXZ0eYBKJS1nER7eS6v4eehQ=;
        b=JQ/hzKRcb7TaxF+8H+g2MiijbdyKcpm8EamoEU97kOVyft6qP51kxdQmmt4PdFA4Ev
         q12Ib79eagavxnSP4bE9VKxtwbkFWgNFjO1HFFgAXXSCOaCyL2GHtBTkBDZM37Cxx2X1
         msqIX3d2o01+R/kQ78wwEhq83YItaUO8fSCPCqwOYrWT5iaPNCp/HITYAM811n7+2d6n
         Neia7niyyTaGBGeVc17lT4ph5UW7IJU5orbdLn7yBn43cJe4Wrg/Y5FexD0qjHfrm/X8
         5usyhhgzd2Goy0QfSIfiRdSMNKyszJwb49DR/9i5hTJfoCtneAdCVnWwFlKH/ExMUZBO
         nWmA==
X-Gm-Message-State: AOJu0YxBD8uhCZiD06+htj+EMKUWXBLdHSDEbHal6WjbJLLoWVr2nd25
	UdJrDRTOdcsYqOi60BuJvSUH6Nr482kw77TSDTIvyqNK/pUIzZlvRwLfQN7lQU6jqAAm4X/HGp5
	mLmZDLNy1IX5G65FGlQn9qkip0OU6HnGtq5jEe633OdbbEppLXXeLESuqiisS2r0=
X-Gm-Gg: AY/fxX5FxsprX3vvK+GNzYpz8hZz1NpThrOzjT24lYYdeoKC1DdWeNBDqZma+qAmbft
	YvXEs1ned0h2n9vUi1l2k8n19snW9AlqMDAvnSK+J9TfkDCpd4fwLy8DKrxYkN9EyCsKWZSPcXS
	afZHwPJsXE+BmoqARMBnpPu/TtWx5tp07lg57jEmXkjIMKm6KjRcOVHMCEdpxV0kRN+aXo+vgOF
	io3O+0I9meB7qlAkakKy1P5bNnd1U4PNGuNrwuufCpCqsaE65pBZ7crhah3RLJ/OBILF8gxOvqz
	RDrr5ulqMJrLBlW4frwxF9ICrbeS9en8mSwb7bl5ivjYBwXolbCnTFS/6Qwq6REF/VI9WeiVXmO
	VPuBEOXs=
X-Received: by 2002:a17:903:240f:b0:298:4ee3:c21a with SMTP id d9443c01a7336-2a2f220d4ebmr373188885ad.2.1767114815525;
        Tue, 30 Dec 2025 09:13:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVt1C0/8+CYVMPpEK1t2gAyMpRP82PQkqWeY8laBzPkqHbdx8fdFoEUUer001YqHdQYYD/zA==
X-Received: by 2002:a17:903:240f:b0:298:4ee3:c21a with SMTP id d9443c01a7336-2a2f220d4ebmr373188295ad.2.1767114813886;
        Tue, 30 Dec 2025 09:13:33 -0800 (PST)
Received: from [192.168.1.102] ([120.60.65.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c6b7b0sm307540245ad.16.2025.12.30.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 09:13:33 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, Claudiu <claudiu.beznea@tuxon.dev>
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251217111510.138848-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217111510.138848-1-claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 0/2] PCI: rzg3s-host: Cleanups
Message-Id: <176711481112.2043082.9998692929898772326.b4-ty@kernel.org>
Date: Tue, 30 Dec 2025 22:43:31 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDE1NSBTYWx0ZWRfX07dQjcZIk11+
 sLEZvkoQPLSibB+3JaML8c+jCrgsXdppEZv6k3mmCB4kjz2tnTwiOCdnZR/nOvAaSaKsaeuEPp5
 1Jgltr4mRoswR6jYwBW/SRQT1V3+g2UEc09yBIIHrNgaaCYfOEqfvMYTXM/OI27AEM8uh4G6rR5
 qgZCsu8gJuiy3fjEuYjit4E4T+BdhMiZEIja7SZcz4eHys5tN1CaSch1WBCrt2pfV8hHek1X6cT
 ps+Ihk7xTHc0n3MQCume8bwZVo6lOI1W1YjhyQWuC7OUtac9JMrqy3SDbNkjdgIKqRyS+n7rIlO
 zQkVD726NMCJ6bd3qaTmbFaSeg5nUKuUoekRkElzVe49ciZkL+puLv1Q3hoI6YAcQ/UbCEx3Qpf
 70ZQAmv+YM8ynSHC59mEeYxM3lFkcTMfQpIplLbKvVRR94hG+hvyivs7H3u1kU1Q1qHVqnHNRia
 BIyOAx+lDfCJYYkBhQA==
X-Proofpoint-ORIG-GUID: eBeSYNVylDym-o4TuHOmDQuFD4lDVWwi
X-Proofpoint-GUID: eBeSYNVylDym-o4TuHOmDQuFD4lDVWwi
X-Authority-Analysis: v=2.4 cv=FJ0WBuos c=1 sm=1 tr=0 ts=69540842 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=+SK5D59PVgoENw9OlSzWFQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yC-0_ovQAAAA:8 a=VwQbUJbxAAAA:8
 a=crh6BrjQ4IWGsnHI0oEA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_02,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300155


On Wed, 17 Dec 2025 13:15:08 +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series adds cleanups for the Renesas RZ/G3S host controller driver
> as discussed in [1].
> 
> [...]

Applied, thanks!

[1/2] PCI: rzg3s-host: Use pci_generic_config_write() for the root bus
      commit: 4b86eff47e205819eb862097493ec20e25ac8f56
[2/2] PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS and RZG3S_PCI_PINTRCVIS
      commit: 62d4911290f9cbb16f5b6ba6782660148a656fc7

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


