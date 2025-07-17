Return-Path: <linux-pci+bounces-32394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9383B08DBF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 15:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC45582384
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 13:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F9626E6E8;
	Thu, 17 Jul 2025 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D3paOvIm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791602D8798
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757258; cv=none; b=Nn/jh8yaXHj+DWpY3/JsBahQ6pQlhgo4ddGa1UuQhxj38QsxibxOKP2TjZXxFrBKhTG254BeyX9HL6GCMkMRxZ7t7abzgHXdl1mfBUeJnaUfygkl9J1ohafCSK/KSXBYuL6BGM6+AgNqkI6ZHQh4Jt/ElhYutzapOw8jO+fw8io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757258; c=relaxed/simple;
	bh=4R9lsc48a67psU3Pr1dtqISLFfU1EyeEeVLBRsDHQ9M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UIi43SvzoNU5andK5O6VWtddLfzr+ZuPJLlFSHxETIbvwhpsYugPar14fQ7KsTf7+Cqpk9ggAE6reaRWP9cYnGUOdU921pKTE70CORpTl735avRMhEC2HbWRakWOD0xSYtleN86cWjsuQ/CayUbU/NvlOvqLPpgU07GlDs1MX1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D3paOvIm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBjQ72002924
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UsxenPoC8lra25vGZoVrKrqJsQX6ay90sm0xWM3ltaI=; b=D3paOvImo+HHDZvK
	1z6eOiH0RTwW/2Py4ROR3hnLNj3h3ebsfNzQ/3W8L0g23byXPueN4aMms8HvDxrV
	xz/hyDD3gC2qlFA6teiUO9Cepsy0V9wMoJw06X0Cg3YdEy0wQi95fw4lMw3sS1KZ
	LcWAH7330IDbzB1EOeFp5pFG/7IArmBl7u3bb3kdasQnU8IMKjj9qdA97Cb6D5wk
	TKUXqz+HRxYv9GcVpXrW5x5+RppDVtZ/gGL/DL/GFS4iSdgjsuAiyxiDYX0ai8GN
	kL3QU2lrByBzCP9RkH1qPpeT68L7mNJEgaJW4x+jO7U4eRzeqczGt0H9SttGt0Fo
	WQK2ug==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xsuksh55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:00:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235e3f93687so14893275ad.2
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 06:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752757256; x=1753362056;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsxenPoC8lra25vGZoVrKrqJsQX6ay90sm0xWM3ltaI=;
        b=u94fCCQVpdWQrIsVsmt0o4rjtr0CiXFx3Olhp1C102uwmUqJ9m3+bT6FNlt6DWAInq
         VfiqYfffiP+dKYj8gbzWZTGPV0TuX6VPZ0YoMVjrOfTHZemtBDTUuTlk043oKeurghor
         9KnaXGtkFetqaVf1/TlCT3uHHvFZOY10cFl4O2Gq+jHhTH2YIEcwPrLQYtn9i+NFwSFU
         ueWPaxWoHVfbipU4/4vqM/uPtFIO0jWalK8rXlGKf+PRXj5nCQGCWDwcoZozhXiSDe3Y
         GxxtXoO3d19w4TI5AM+krD87G52pkRfNIOXKAm/4ui6gTY24REDwPfqNGgTDqjqjwLwd
         1GOA==
X-Gm-Message-State: AOJu0Yzo+p0yP0jH6nzzZYyY5l194iIo3eP470/8m6YKtF1jUcrys483
	izhidw01u9YcewF22ez53oDwdFXqMCvWKPuhmY8t+mQtE1k0RLYyI5ke5smZ+0KDt9yUqPPOUYn
	eXldZbwf39pUE/DJebIzxkXxgjqRUINzkSlVQKamowj/oQh3ch3zrwO0QXrjjFG8=
X-Gm-Gg: ASbGncu0lVBTlU2HZzFOfZ5Tg3WztMHczbZOqDaQtZyYfJKWsA6US7d4v1W3WfVUC5H
	WcQZ92xO/mz2xOgZtU3KjGW6AI+rUgArF1QnROwgk6/lQVVGMZykjVwbL1+PzoCbNYpP1A1C+gl
	nkrvs9y6DPu+3xnH/d1fG4PedIN2tGjaPctYTqQqkegKnIV5aQ3/kJnD7vzSp/BsyJAgnyeoOh/
	E5+lsWm4MoaPETG/jYRnMNWLdsLYPaFtBzbIJ8Rho3aNWs13UXqYcPi7UWugh/zBHC05KOBoKd6
	y5gSRptO4Nq7I39rosxxqltWNx3mppXMaGTn
X-Received: by 2002:a17:902:d2cc:b0:234:a139:11fa with SMTP id d9443c01a7336-23e2566ae85mr106699105ad.3.1752757255546;
        Thu, 17 Jul 2025 06:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6kLQyELqoUaThRM/8jo3nwD/JTvp0msjb/NlH5yEoYUZGlu5Twk019E2H65MO9AFL6Ponlw==
X-Received: by 2002:a17:902:d2cc:b0:234:a139:11fa with SMTP id d9443c01a7336-23e2566ae85mr106698245ad.3.1752757254911;
        Thu, 17 Jul 2025 06:00:54 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42847casm147179855ad.14.2025.07.17.06.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:00:54 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Toan Le <toan@os.amperecomputing.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250710180749.2970379-1-robh@kernel.org>
References: <20250710180749.2970379-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: Convert apm,xgene-pcie to DT schema
Message-Id: <175275725132.8776.11740165619532481906.b4-ty@kernel.org>
Date: Thu, 17 Jul 2025 18:30:51 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: t8a2cYWgzFMapdVD81_Lb2Z45EowLSTa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExNCBTYWx0ZWRfX8fBHTkM7Uo7B
 cZ+3YzWpaS+6BRKrvRVHPohbRM+e6Jw4g3TqEUG5STXrkbQzVZjE1fC7k4DzfMTvLl/rESz4ac3
 T2WV2le57iiZgxU0wN528Wk7ug0Yt3FwfhZg6sOTSQXNRhbRNC+TMdnQ+jqpKqqVxkayIHqUotS
 OKmsA9X2bM3G1/zwC2dSimSUDRIH+XpEmWw7XWnMhde1V/bIMyAjslukjgS8fwZMU9dHhu2jr1i
 chUqQfiVmZwGdJtvzfQW8/I4eJ/rGyB9XpCeqcX/i56JwwtSigutOSbMpnv3PNrMCLiCfNZ5SNz
 vqmNKLTU03QQhmMzo1PYd/uF6NJkzYrmNOBS5wCJ4sWBIdwb+bBoIxljC03B+CZ9WD56k4zTBmy
 P+l7d/0svG7MVjNbygX2CUP7OXOrJifAEa0qmN+BN485fbZYux0pFOE27bpU0G71dpsh2xiM
X-Proofpoint-GUID: t8a2cYWgzFMapdVD81_Lb2Z45EowLSTa
X-Authority-Analysis: v=2.4 cv=JJk7s9Kb c=1 sm=1 tr=0 ts=6878f408 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=A4mJK6/VAfRUM2WLv3bxlg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Tk-7pMtUu1chtXBpElQA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxlogscore=795 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170114


On Thu, 10 Jul 2025 13:07:48 -0500, Rob Herring (Arm) wrote:
> Convert the Applied Micro X-Gene PCIe binding to DT schema format. It's
> a straight forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: PCI: Convert apm,xgene-pcie to DT schema
      commit: ac8ff3e15ec6c54f11d38a6f5016de323ca1d576

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


