Return-Path: <linux-pci+bounces-43258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8E6CCABE6
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 08:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8304B3023EFD
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 07:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F5A2E7F20;
	Thu, 18 Dec 2025 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pk4hcSOo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S1F/E2uG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BC52E7623
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766044634; cv=none; b=iJAqOKRos6q2/vULyzuRU2qaujkHBaWSKQ6Hq8vh5kxtQ6eA7rGjwFF0jxYVdB0hpn43n2yp0zypOAwt2Z2mEZK/AZdDIlaWWni4UBz27Y1CarqHCxNNFD3Wf/6UJfwbTrGd7mFy49dEwuISzMocJzCaDGLCQ4EGBu40b1XjLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766044634; c=relaxed/simple;
	bh=NNiKMdTfFvhd9nsJPGJ+/oDRXJQO0LbyaPUuhw/87rA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aALD6uAY4VuqsxSs+o1fNr5mGyDIBA4GmjEwLnPYDtWYpUt/FFukPa1oAOUK/wI8aZmcvepzV9Hd79LdGx7USYPSR2M9FIfR7N+rvO5+bY3nIa5l0dnmnZR6iUIizKL8KFtEZyk40/HnX9LQzipo1FWVwLNDPxYWTb2XiTIwtAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pk4hcSOo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S1F/E2uG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1Yjpv3717109
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tmr9S6sDpiWNapvnEXdAgWurpJJXjWMVM9sn6AYEorA=; b=Pk4hcSOoAk99j/Sj
	sNaMeI/wKAqHnfCZBwAjsb5L1HiBX8rfrOh0w3N2bs+NYuxgZ1Ro8oqekKhnGsRo
	l5ylrB3YzB7tDFeTB2N12+txfdtsyzu36k1w9mEOdy7wGF+dB5ELEzFiH1l2Ptwm
	J0QFnXtK4xCZ33D9rCWA8UBmhL4Ua2Y8a1UlvMUObZ6+2H52zCPX+inO3aWiaCZ4
	On4d0M+HXOkeKOhelj8jtF10YS4z8XBnweqjpOZgH0SwCtxqmoo/Y6VnR0XdBY5c
	dojGWB3xTUiNmg2OcyHPH89E4UDArlDZXTNt26R5QIDFBh1CCs6sB9snPpqYwABe
	e/7NiQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40n7a892-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:57:11 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0d43fcb2fso11226685ad.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 23:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766044631; x=1766649431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmr9S6sDpiWNapvnEXdAgWurpJJXjWMVM9sn6AYEorA=;
        b=S1F/E2uGdMAwt452KC0TCmeavkJ5l/qsAbYWkvOJTOzF+TYEelGpM0en0zzdLyixmb
         AI+cXR0k5jWxUP3AL+OCbtuA7/i32JAVKXxd9SsjywXrkfwPs1gThXDbbqlgk3eNQWE1
         97gCwjmRls9j047daKgu/fm90fdgrVbC+atAfNwgGB/sl/gKBWGmUbRHDIcnGACtjr/c
         n9UpCf555VrjBDVRJKT1FzN6NRp5M4qU9Lf9sSttUQNa4zqqIMMyTaICYeiaF+AHPnD4
         XGsi3aboK3l5qvjxL4bcBMThPWVx7JN8ULauJ4ekiAF8mtm/D9wMXXf2d0ChvLs9B06Z
         Zxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766044631; x=1766649431;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tmr9S6sDpiWNapvnEXdAgWurpJJXjWMVM9sn6AYEorA=;
        b=vbbYjQiiX9U+DvQT1hlH4cUI3ezivk8hFPxx8X1o6CTAcc5RXSGVUyoF8zY+l05bHA
         UB3qHO/7zCaEgv6OPvb+IWSAMbRpMJkdVcrkhbqaFUvo9rYRYcNdrCcFEXc6TYv9BGxj
         F9xrB9mZEtfjfkQi3Fknivq3yGdBGO2/PI5EG8bFNGa6epB6OVWuY8l0k2WrfnVQWNJg
         yVsNyKixsd3M0enAHoxdMSEKgOnSvRdkJ62VS6qRsMzXKeMv1+2+0zcSD6DxMty2Xkld
         f4yspBq++pe7B40hoMLEdCt39bXj3JiA6pxBEw+QhsLxafiqxMn6eU+UGnJ8LjKkIS0d
         ciUg==
X-Forwarded-Encrypted: i=1; AJvYcCUg6w7CB/DpGHr9uoRtUNK/rszkDyQwaz53kYjeqsiUsW3Zqj+Bfhot8qZxOoSrG4BMD1lRPG1zgbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8pCuPOfKpHuYbohg7EaRbKzV+Yb/01CCz7u9/CnY6HIaAjcz0
	K+v833nwsQmzWmijjWMf0MfW81B2/+axWzIlZcyewSoIwKJvf/FcRdOxZfmbcp1s03UC7VQQKUx
	tjg9sWxruYKdjBnsadiIyfm8jbJ4ljpseLpZ5oSjian04AAm0MgYhdZdOnGkseSc=
X-Gm-Gg: AY/fxX52eYesVimfKspfhrgmokgSqTlC7bOpv62ae8M/xf28lcpFFhB6KrMw8fiAMX9
	lPaNgIxku02katA3quHfHKcfPTxgBerPePPT+6PSLL+svt4tpq1drcaIa3DDvYgFqMGb0FoYbhW
	NrcID/BeL6ZerWS8wi70Q/JSwIOutNVHs8vD3aBwbIJPeR14JMSw2vnYTz0htozB043xAsVS7B2
	K+0X2hublJQcyh5H+Gul6FpPOHcdgG2eBO9M7C6RFoANOE9ltSwBheGsQ7QWANkhpO1rWE2W3TR
	4vOGSavbGh3Rd7C2wNd00VTj5/wU8JiBlSofQBAn+zNbfUS4olJb60oYOnuCqeDXCw2MWiFm+c3
	K+JsD1cjEWOI=
X-Received: by 2002:a17:903:380f:b0:26d:d860:3dae with SMTP id d9443c01a7336-29f23ae4459mr204531185ad.3.1766044631267;
        Wed, 17 Dec 2025 23:57:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ4mc/QATeZuw9YBw4cP2ebniDT5Eu2c+gkPaPmLvI1fTyaBUfHNC4rjrrKOsKVUvRNrFoUA==
X-Received: by 2002:a17:903:380f:b0:26d:d860:3dae with SMTP id d9443c01a7336-29f23ae4459mr204530955ad.3.1766044630863;
        Wed, 17 Dec 2025 23:57:10 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d193ce63sm16086545ad.91.2025.12.17.23.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:57:10 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: vigneshr@ti.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, bhelgaas@google.com,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: arnd@arndb.de, kishon@kernel.org, stable@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srk@ti.com
In-Reply-To: <20251117113246.1460644-1-s-vadapalli@ti.com>
References: <20251117113246.1460644-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] PCI: j721e: Add config guards for Cadence Host and
 Endpoint library APIs
Message-Id: <176604462693.840440.17361297043510952220.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 13:27:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 9sAn6hqxCuf3aolMLBRxf4GELhWZqr3Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA2NCBTYWx0ZWRfXyifKWxit3sf+
 zXlaQRIF4vx0fc4Wa7G0swlOqZgJGj6t4n1LHwpilsUZXjZiwe+8X6ycSKuHmpOUtaaSrmqahak
 mSESTWBbSG58Na5PwELgw78AHptqPbC0QM5HMgfQYerZrUdhQ+AacN36dJFuUA7W2QrHlK+Aqva
 9gm/S2X9dwYwUx0wwa5eSH4XZh6VFXOnBCsKG2JuwxLHiGE/kdoJoeSmarj1Au79buR595+QqIS
 JVr113vvGnwg1kJ0dmcdm4cg3UcaLXGos2R43h1988y5rMah1Aa04Y/FUxuoGmf8HMMJ7qkBt7P
 FQUmRd2lKTPgw8ahbB/721EB064hdgxCOmwXKiB+JowyKWHx6t+ypqURh9+ix0JIIrTLy+xhaiv
 o5E3BZtZiZwNrhRsSEKB6j4mqudmwQ==
X-Authority-Analysis: v=2.4 cv=TZebdBQh c=1 sm=1 tr=0 ts=6943b3d7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=XNqfoAmXSU-mxqL4qO4A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 9sAn6hqxCuf3aolMLBRxf4GELhWZqr3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180064


On Mon, 17 Nov 2025 17:02:06 +0530, Siddharth Vadapalli wrote:
> Commit under Fixes enabled loadable module support for the driver under
> the assumption that it shall be the sole user of the Cadence Host and
> Endpoint library APIs. This assumption guarantees that we won't end up
> in a case where the driver is built-in and the library support is built
> as a loadable module.
> 
> With the introduction of [1], this assumption is no longer valid. The
> SG2042 driver could be built as a loadable module, implying that the
> Cadence Host library is also selected as a loadable module. However, the
> pci-j721e.c driver could be built-in as indicated by CONFIG_PCI_J721E=y
> due to which the Cadence Endpoint library is built-in. Despite the
> library drivers being built as specified by their respective consumers,
> since the 'pci-j721e.c' driver has references to the Cadence Host
> library APIs as well, we run into a build error as reported at [0].
> 
> [...]

Applied, thanks!

[1/1] PCI: j721e: Add config guards for Cadence Host and Endpoint library APIs
      commit: 4b361b1e92be255ff923453fe8db74086cc7cf66

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


