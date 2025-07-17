Return-Path: <linux-pci+bounces-32396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FB8B08DCB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 15:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9FF1C273FF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 13:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973F42D9ECC;
	Thu, 17 Jul 2025 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z0gkORGL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7A2D9EE0
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757268; cv=none; b=jJFgwqNl/8B8FTq1R92hKRSxyBTjXWRs1n4XQmMRZx9EGdTmCCowzk6sF3rEeImTc17EOBZvXVHRYUy6oXl1huIjsNBPYgF9dCmtUil1DfDoRkJ1YyW+2+57i4WGsiWXqjqYUkCzqfHglo2K3QNuk5AT/6fhfi4qh0jm16r41Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757268; c=relaxed/simple;
	bh=6sH3eDRC6+5CeRl8Mp2RLafDJprCk7PzL5BrNhgsMqo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VrsF/re06b+TVm9la7iYZh7vSPUXGzo1lGxnWcQdHConpYp+kq9IEYqD24v6Qg9I+ZvKyOR7ty2vXB6xAJN2u0KUsVMf+1ZjXti7aPVoQLgChKo3iKKOc7Ghrc1w8ciN1UK7nHge4KN4kaXWTzXL12g6P4uYjF/trESb65n1roM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z0gkORGL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCPeUb032209
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U5UsuIaBIiPbuClHMuH4cTONIIq7r/pcY/6hVNc8gVo=; b=Z0gkORGLevPzWXlm
	vcy3MIRItHtOk71vKmNrXRumAl2/eU0FPxW4Q70JinG1rPuhQzS8hRL8b0IBZPXs
	INiXELfRkdR1z4+/7nRiH1PI8S/aW7dVdQp3FEGUZkd4DveCbrRFmt957pUXk6Q3
	/NjoY+3BEi3mNWfgDnlzmWtNHTYqlcMaGgO/HMEex9Or4Lo3HxNv2sGixEBpPJ1q
	ZY5VMfc1PJzzQZP1ZZURt4ZiPoFrkhDwu/yy2qH21rXgmR2ef7GA/hn5eYZjSOaD
	mBWGzXrklE6KIJ5vYT4cyEu2bLguPYfU8SZcx3tipCvvblS9AO5o/eWHpg6VqsJd
	fLkrvQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug387uc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:01:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-234f1acc707so10163265ad.3
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 06:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752757263; x=1753362063;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5UsuIaBIiPbuClHMuH4cTONIIq7r/pcY/6hVNc8gVo=;
        b=MJw2tJ901bUo/ooyyq+TcMWGiDOsaJ+V8L6BHR5L63cdUM9P13iVDmyn3p5utCbvQx
         ktdX/GiQhLoVS6cr4OIkKOxR35SWhj8xOIA4ds+ay+X0S9PJ2bGTolR2IbgbwsquA0k4
         y9hVYaNq2p0BdgQHExNspxrLng/jcPnDFNCZvXr3IYyotCqX2ofF4FKr3ye1CXFVdfsB
         hlU99z8pSlHfYcnfFTjBuS4rOw03pHFx8mOFSHOhjiBNgFU0rExO2lvWoF+1IYtzWh55
         Nck59G1Ew+sBIslGeq/PwgwoQE5OvyXzz2OTKmJkBkYlDhBfD8R0IrkmP9cOIwHKk4Rn
         8w/A==
X-Gm-Message-State: AOJu0YxPwwyquE6zInUXmKH543vBmDQ/i1EwHVJrTeweqUpa893hO7wk
	CW7FvPRjl3ATrS70BA7jROlt3q5hhYnadyNlVQRSY4jFQROw93PeRdrYxcvEFLTi9L3ibfKq1NJ
	MkK7SNYn/IG1PYCJIzBdaZ07jHPxqX0HzptIY6JaE5RfMzPbxReNrttsXSCcBMlA=
X-Gm-Gg: ASbGncvGOOoejjC1kI29IJVM2GXWDgtoIV8A57eqooMw5qKqSiavR5I9ME0Ao1s9apM
	iVAQxawC+AIiiTRkUm8HPMxx1wYjYovOhkpP8TEc/vrP/58ORmBTBSAWci30d1eDfA66IfOs8Ts
	UzMx2SKU1xXNH2qqC+NEXbQOd6HIJf5eDXNSZTPpcGbLNW67+hydPIJICaaNQo3aS/azxAna6su
	I4zkJ20Xe9q0AtEmkMRfeL96ZU68FyQGQ/LBPIAJ3akZgKsWZhOePhM6knrmCX7l0ia/wv1Bt5m
	FclYSw8VDigvjDJcKhvIWo7hvFi1+hO2v+rQ
X-Received: by 2002:a17:903:15ce:b0:23d:fa76:5c3b with SMTP id d9443c01a7336-23e256d7899mr91658265ad.22.1752757263547;
        Thu, 17 Jul 2025 06:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9ASpEXpTUCQBu6F8TSsn6R6L7kJf/fCt8R9NgupFXmGH52RNLM663t6kjqNInnvawgUpfzw==
X-Received: by 2002:a17:903:15ce:b0:23d:fa76:5c3b with SMTP id d9443c01a7336-23e256d7899mr91657685ad.22.1752757263063;
        Thu, 17 Jul 2025 06:01:03 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42847casm147179855ad.14.2025.07.17.06.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:01:02 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jonathan Chocron <jonnyc@amazon.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250710180825.2971248-1-robh@kernel.org>
References: <20250710180825.2971248-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: Convert amazon,al-alpine-v[23]-pcie
 to DT schema
Message-Id: <175275725909.8776.7592079694757871720.b4-ty@kernel.org>
Date: Thu, 17 Jul 2025 18:30:59 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExNCBTYWx0ZWRfX0PqENhP4kebC
 RmnfdwO0rYdN13RkMAtMUO6CiHRaKAqTal/IRCKZPJGI4rCp36m1+BHuZfQ/Dq7TRADMhUjWIA+
 7u31yMDtPl2dneZvXEssVXRXXiKXPvZFWMQgYuDatmHqiOciu19F5yYziKyTdb1NhBCKUGN6h10
 kY6NrHPgzDb8S+7hlEuddnU4LJMF92X2PR/KqAmNliga8pUyNkf/7PkFC7f/C88GXkczy8PzT/r
 0ugzZiGdaPZura5uVnh4nYn5nAgnSRpvfXLJW8U9x0X40yLeWymDGqieH4P/fWngT40EarkMFvt
 qh/xf5dFP/h1r3WmyfyMkfEghGjh5gIEJXXNzny3a93Q0GPZvIKuRBxVZRDQF1TGUzbyXKu5KXD
 oT4gZLooEisjKuxN+yTZoWWUtISpCSPUdbIRNm3CeJJp8T9DzppWgmKTTawb4/faWb9RwZYt
X-Proofpoint-GUID: F3pajCBDP4sB6cKIhKXJWD2Xv3bUj3Dc
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=6878f410 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=A4mJK6/VAfRUM2WLv3bxlg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=7zflxYQyjF-TGQw7vmYA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: F3pajCBDP4sB6cKIhKXJWD2Xv3bUj3Dc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=928 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170114


On Thu, 10 Jul 2025 13:08:23 -0500, Rob Herring (Arm) wrote:
> Convert the Amazon Alpine PCIe binding to DT schema format. It's a
> straight forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: PCI: Convert amazon,al-alpine-v[23]-pcie to DT schema
      commit: a4fa6a0c4d26c8a68b288c833f53235ebce8b6e1

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


