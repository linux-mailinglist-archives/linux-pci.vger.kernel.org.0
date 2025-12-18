Return-Path: <linux-pci+bounces-43243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAD6CCA5AA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 06:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E90330249E8
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 05:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674043126AD;
	Thu, 18 Dec 2025 05:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dF8r2DLT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fVoRJ01K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9222301026
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 05:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766036710; cv=none; b=qHZcDDwxkCiW5KMuRjkiginYvOK6NbH6RIXeDzYn36Tso8cJMJPDLc0p5xt0MWDHMefT9DL2QuG8DxYnoqnDp2qhbe9Rnpo6G1Ap/E2pZifS03EUTx0RKwwZHV61Cowa1rNtoleJG1p9vlvlgzjEyUZoZF7IERrKbFoI/WqFMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766036710; c=relaxed/simple;
	bh=HaBYeIOkTGagepN65U0TxA6iVilNLt+Q2FKFuCdrMf0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E+8yDT6QKcX1fyXuIU1kC5Nykm6n6HskN0GSTTiu/fLIPtTNncz3P5G1ZP6dSqQgPJIno8li2HxEDUvCyXEpi0/9MFM8k6O2ge8auNXxXcB15oyl12Qj1BJe7ILymYoi32pVVa1Or+SsvTtSZZdH8egbxjMwLtZymgmrGnmw7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dF8r2DLT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fVoRJ01K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YiDY4057969
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 05:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9U3QLITKQ1B3nyhVOCgNC/mNiJoC20/DqWAwoazmIL0=; b=dF8r2DLT1jwA68S4
	PyIPZ0R6Af2ZP1kVC2xlWZWuoxJN05dp0CrmA2zegKyq24RhuziN/4SUrbOQGMHN
	eI22Ukc8u0cG6hOarBO6jAq8Mh3A6BB/buuL5e3l+eKzTU4vqsYeor/uxkqMQwhU
	NZ7nQU/a2bXGTg448gyHXztLjKr7Eymz+XQZ0xlOUaTyZlyo7WCx3LVDFgo3TXlK
	k2njtqOJmKx0wFoQffByqUhNp5YErDh1flIJATHc/PXRWhPXyaGhUxs62MGVjn9Q
	hA32i93a92sW7sGk22BKrvSHdBE7xLmxVeziuE99T2yOvCrda8ZFQBuB9s9F6v/I
	M7KAeQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3xr5a9tx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 05:45:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29da1ea0b97so7116245ad.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 21:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766036707; x=1766641507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9U3QLITKQ1B3nyhVOCgNC/mNiJoC20/DqWAwoazmIL0=;
        b=fVoRJ01KsHSRcqEGwOit1SbbQLzfMBt60M9FlQjznQZYSbOHGsg+h7c1q+sftlArHN
         +ObSFFUoq5nqjBgqfLzIv1yBky/6oM2ssyH6kK4yVLFc8/8I+kpzX6woC5Lai7Dp1R3p
         zCObAgTSZssY7Lnu+qN7D1wOVvqyQbEHBVUNS4xtA7lfinSDC9jeeHtu3P0b5vtmEJ8Y
         Oqe3Qtsq1r495d5AkuLSEATnfl4EAAMpL5kDwGuM0+K3dJbSJhqdYRukhBii72/lfHhz
         KG31E3bu168yDkIfK+ypwAG+wmTgr0v9UMHGXW5O9sua+dFZvN57XS3UAbIa+m3ckCtq
         1Xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766036707; x=1766641507;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9U3QLITKQ1B3nyhVOCgNC/mNiJoC20/DqWAwoazmIL0=;
        b=j8unrwGY2H4HoBbRTrDc1Dea43MfUfG+GH8nFdSILopRa1XTkm4mo9fGXtk7FPIhDM
         AZwH6AGTxjRNu80L4tOgS2tIJnqyllmtbNaVi7qPMGk+UBrcxayPvBKlC3bq62Ss3Vji
         OMCT+86LOvuCRnPRLcSBgF77XVIoi9n9H81kYVQoDvAlY9O1RH/J/w5UVApHDyYF1/k8
         YJtnHYoUJBXI9HBLTR2pWXhtNurjwsvOpnst9hll+WvMzKxkTtImqxDFXr2I/Bj/to7V
         S1q5MAW55fdZZP5l31SxXRyoExDwRrhCDwhm07tw3ElLeFT0+3+E/n2xKpXvk2LOLFcr
         VPYw==
X-Forwarded-Encrypted: i=1; AJvYcCWWkXgt06PrZRQ8sTrLQxJpdyt2rHuWjF3FSp7JY+apwwhs+tZ2NtxoKQ5yel86Ur1EMuA/9KsCnx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgP9Pi06/ZhpB11KXBVoDPoUX5Ce7PAVrG7P+O9PjSGopv5U1i
	jp2DX3zt/7Yci1kRQdrW9lYODnKLk68Yu7NDysqOm+WA1GBiwjwbkskGdxUKFVhyJLK8L7PzpwV
	f1adoQseKSzORLRLsqi3Q74/3+nSndPCHagGDzuNNxlceqwkQGo3ZlcsxqLz1NZU=
X-Gm-Gg: AY/fxX4NfhnlXquDeSWSpzGTQtuZ3cTRupmJEfCYU+W1K9Z/Z7ZYIgQDBfPjhF2r30A
	xBi2n3GlwjtPJE5JN4U19Qi4RTmvD4jA/vLdN5B4PNhcFoGpGgp4NJx6o5ZAP+vJMLWLAbuFF3o
	IRvyhvv3CF55UtDabqneIbNiKYJUbBtY/TLxGom0g0eN5r4MgX4/hY6MIgtkOcD8uCrYBy0sLE8
	UQxpoz1ksGERyNOmymmZLDCVl+tyTYZHEPWBcus87bztk6jHqZ+2ywWbZOlP3SHuCZXqKGZYRzb
	gBJQJ1XDAQGzMnj8J4vHzO7Fg7EqJBVf9MqZanUl2XFzwkZ4YP3kg9f0zanbwvsmfsdDYCpGwew
	jNKGKrQvvPYE=
X-Received: by 2002:a17:903:120f:b0:2a0:b62e:e012 with SMTP id d9443c01a7336-2a0b62ee090mr150111705ad.38.1766036706483;
        Wed, 17 Dec 2025 21:45:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJH2bEza80lyNERlPJV2qdvFDSc9a6kqmacYXBjsJlW0ihbAy2evMw+tv7Qi5YF1VC6pksOQ==
X-Received: by 2002:a17:903:120f:b0:2a0:b62e:e012 with SMTP id d9443c01a7336-2a0b62ee090mr150111605ad.38.1766036706046;
        Wed, 17 Dec 2025 21:45:06 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c690sm11534085ad.20.2025.12.17.21.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 21:45:05 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: kishon@kernel.org, liu.xuemei1@zte.com.cn
Cc: liu.song13@zte.com.cn, linux-pci@vger.kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, lpieralisi@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250710143845409gLM6JdlwPhlHG9iX3F6jK@zte.com.cn>
References: <20250710143845409gLM6JdlwPhlHG9iX3F6jK@zte.com.cn>
Subject: Re: [PATCH RESEND] PCI: endpoint: Avoid creating sub-groups
 asynchronously
Message-Id: <176603670341.14052.15041295759159951868.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 11:15:03 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: n0X4Nd4_Xq_mRzHQpVrug4J9X2QR50mm
X-Authority-Analysis: v=2.4 cv=DsBbOW/+ c=1 sm=1 tr=0 ts=694394e3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8
 a=Ini7W7neDqlUuicUPW0A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA0NCBTYWx0ZWRfX13KdFQiJ/YRZ
 BukoIksVMmIDnLn4pQDDmSaxgEqA4K+5BFDQoZFm8UZS+bWg786lUXd8rzBap2Eo2XCznpwe3q3
 CSY5szypUCD3iw2Ti0cXjPJ7FE7O+NZiNVw2Nhl+1rA8AvKPHX+yadYVRNWWjW0PlNkHGOIPCPV
 tzgZF/C+g2LoHheE1W2jYaYugmWFL9ITPYmM9VuNNop1sPUA7Aj83sN65yVRndZAA+CAvaqTNuZ
 IXAXCpSsLUyHb0yKYjTrF4Ei1gshPPYukzEXNoFRBq/ey0wDZnHem/wtBdRhlDSC2EnqcJyaIRi
 fnuo1SfOScT3SKI9qm7sqbv8VcQIzOlaIOaGA3ZfKoes8rmNtyqiDMQZtftoqpndqPPdU4ZYAWV
 6snfJmBSPRUnWQHd2pPuKCrtZy7mpQ==
X-Proofpoint-ORIG-GUID: n0X4Nd4_Xq_mRzHQpVrug4J9X2QR50mm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180044


On Thu, 10 Jul 2025 14:38:45 +0800, liu.xuemei1@zte.com.cn wrote:
> The asynchronous creation of sub-groups by a delayed work could lead to an
> null-pointer-dereference exception when the driver directory gets
> removed before the work completes.
> 
> The crash can be easily reproduced with the following commands.
> 
>  # mkdir test && rmdir test
> 
> [...]

Applied, thanks!

[1/1] PCI: endpoint: Avoid creating sub-groups asynchronously
      commit: c7a1d2620a290417a0bc8b921259ac036a9d33f2

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


