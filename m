Return-Path: <linux-pci+bounces-32393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2318B08DBB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 15:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A560D3B8836
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 13:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C932D877C;
	Thu, 17 Jul 2025 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dHiVSzOa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16C2D8375
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757255; cv=none; b=SChTIVzJldWT5SpiCMwiLf1efkJzv7ZzzC8HUDrdy0ub3o01FCgY65ndnhOIJgYuK8ujSI2FfxYVZWXGbIjNqsAWkUNDOR/xMaYYsEDdLqSUrTu1Ff0AXGvvOY7wulx22AfBOi+jG9jISS/bNg0ezTWf+FBjFYWNfGxvOYPCPig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757255; c=relaxed/simple;
	bh=XBWj+K2b9C8/2lXZd2Ys5olIeeGxyJQzoy6N7+ggAbo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CbCgEKp7lzbT6J6fANFku7K5kPtNR8/q1GZVadJc8XSmZPXrGt5TeGZgsPzPrsVK1i4iqhu1NsKswWK0Phjjb84VeupW5UsrRCQ5hOoLqPBUymRKyzjItVjADJUJQ0CUxAcvy4p8JZE/FMOigbDFgFC6TXkSfSAOB1X3Dfa+ai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dHiVSzOa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCNLKF032424
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sw6LPLuhEELuBjJMJTabeU8hBl1JfGGZnqYPdlkW7+I=; b=dHiVSzOaPCs2zqZs
	j0DJMIQDmqOAx1UNpYj49VA63b5C9coVlfirV7zVd6bJ0P5LcGqDrgETd07XCnJD
	yCa5zacyWM2AA51iXeZhXDZotgYNwLzEX/D+QKFsacgD3JEO2xmkPquA8N1TrGIQ
	KZdnYP0GqGgQ1ULhGmFU72OwpYJizd6wCi7YJyxPK6BtXidaORlfkd2TfGLANp06
	PcLjgVUtOvKToqX1KA2K/1CzPllDKgoIOMwdmHGK8OH/5OTfo6l/0wKOPrlYs6AE
	T4MVKEBH8x9esyoDuPWuFv2/lgf6p9Y+y0KTU+BrtEwKUFYu8SQoRJFnh9BoFYzU
	yFoHew==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug387ubd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 13:00:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23689228a7fso13985715ad.1
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 06:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752757252; x=1753362052;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sw6LPLuhEELuBjJMJTabeU8hBl1JfGGZnqYPdlkW7+I=;
        b=gkP/sHyhwm2PtR5biqhf3PKboxTbRJvdScEyOOqcuPBytN2XiiszvlAiw0lYGa8y5y
         clo7WgrJXG8ETses7OvB2m5bEmuwU6iaEr6MKvyg41HN2Qxf0ZWSjqcjr4axAD/I081p
         UmnG/y9KWxz/vL8Y9bdU8c9RavNmRH6+q+yshnHreGWCUdY7X8G8cBTfdj/quHaO8XXW
         TIkCgy3DoOjsCoNkOU3gsfXW8OVNkWJH1W9JXBOtJwxEL+MhRiL6oo0ZFUbeJdKfyHlN
         kZaSsb+E93MuynXmsQL9YZeC5ew/9N1bIJXMaTe5dI+CVSJTKSpVZabX+pn3RPiwBCsL
         9o4w==
X-Forwarded-Encrypted: i=1; AJvYcCV53rhjRRrQkOAvBaxUjHrGMNFFEYECRrR1EXgnz6DBlfts2nXViNf7q+/f59bJn9n0HSz6qqdtDAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YziOSwsoqhwSM0GRCltVR8PBOBbha/ZrBzvLwiwMZKpAy0BPIAi
	rDAK9SCedyVHcevdm4Z0ub+jHwBEO2PGTo3ukojaiqqubtjd1uD2/s8srDL3Gv09yQiIMKwUWqV
	n9Dfg5J2d3Gj7akzgddYONoNLfBagXTNIo/2atKjpdkuhmejWhAykJP5xxdyM8bE=
X-Gm-Gg: ASbGncul8PoaQjaie7y29+a83UC4mHk7Ac6H582c6NV0Mp2vrLNqz8K7DoyvnQTbrQm
	T5YpR3LPuCcLBu50agfOWVDAOrN1DA1MtocZ4tFA3BeltLDHRv0jzI8XRQN8siyEFOEgWBTlfaI
	cgXy1AuGT2HEULMGqvUPo89raQLG04USx0TifEconYIbKceT11VI5rBFNFtik1OgN5uiHpINzpK
	SH1QP5BPXn0arFwHk0AQ+iaV3UAtE1BC+hTKlLFn3SBf4fukbIjL1xdQ3WvgMX8bQXUFuYQjlm9
	Fu7vL6sm2KNIvQNhlvc1CK3GQLVR/yDNIzGE
X-Received: by 2002:a17:902:f547:b0:220:c164:6ee1 with SMTP id d9443c01a7336-23e30338824mr45454015ad.32.1752757251663;
        Thu, 17 Jul 2025 06:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPXXNo8cXoPkWxF6QYKGoAcZdb1+peqzLQ5KqZw4p93lkII9cj+MigMVeqxxAlIyqbiB13Xw==
X-Received: by 2002:a17:902:f547:b0:220:c164:6ee1 with SMTP id d9443c01a7336-23e30338824mr45453135ad.32.1752757250981;
        Thu, 17 Jul 2025 06:00:50 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42847casm147179855ad.14.2025.07.17.06.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:00:50 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@axis.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250710180741.2970148-1-robh@kernel.org>
References: <20250710180741.2970148-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: Convert axis,artpec6-pcie to DT
 schema
Message-Id: <175275724738.8776.8637174515757948922.b4-ty@kernel.org>
Date: Thu, 17 Jul 2025 18:30:47 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExNCBTYWx0ZWRfX7Gt6sYfwpqf1
 3GBlHJcixeg8BTywgczRQfAUbVSOMYBJmZ11RHgyqa03D9FHw/G4uNQisvvB95psIkR+23FPIqW
 8NjFpJ/+Tp6uXz/yqDZDl+vlczkjh3xgHfUYcRRuwGzTkez55MNE+jRoyCCRWwcMQfiYKMIhA8T
 HnXFXTL7ZauDZGLwLmopUR/wTIKrpiwPQwa3ju/cdfoq5UtnV5ORu/YXfqlNjqg2MhQ6BQVUTSA
 gd4a7OJMxrqSS8RULlvY7IrK0799uhQVbndNJzXyUkcdVetN3nK6evJFIoqoaS5lHsb7ExtumPb
 ihQWCtlfnrEH0oM5cnmXEDK1nnDKEPvebUIwC5O+tIgTuwQqhNKGluVACjwIJuYsvUlWyxLtmYx
 5XL6zWgVEAUs8B2ft39mUtvAUC9u9wxqqc7pckZ37Q/teop/YuwAQ76VlegLoGcnxj/YAKaO
X-Proofpoint-GUID: hYfS1kdSXkDccmm0VTyxrJh1IBcAocVZ
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=6878f405 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=A4mJK6/VAfRUM2WLv3bxlg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=oZnIUJi4OH_DVw05ZF0A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: hYfS1kdSXkDccmm0VTyxrJh1IBcAocVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=889 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170114


On Thu, 10 Jul 2025 13:07:40 -0500, Rob Herring (Arm) wrote:
> Convert the Axis ARTPEC-6/7 PCIe binding to DT schema format. It's a
> straight forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: PCI: Convert axis,artpec6-pcie to DT schema
      commit: bfde613ae16ec592e2aa28ad7f7729bc20b9382c

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


