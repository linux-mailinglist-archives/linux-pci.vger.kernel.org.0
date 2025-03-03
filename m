Return-Path: <linux-pci+bounces-22882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0525FA4E92D
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 18:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD0B7AA11E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F21FFC70;
	Tue,  4 Mar 2025 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VNt3uvV1"
X-Original-To: linux-pci@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862FB292F8E
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108056; cv=pass; b=OdGESEageA9dFXSFT32Wc2kEubgMXT6Svqnit3BvBd7aVeG6D5LK1tiNQfHaVl52Mnvi9RpbFkg4TEkiUp74ycnmX5jju4vX0EXaArq0tQabKE5opX2EVPcdROWMBLJkCT1GJq75Obfslws/HHtdu43onZBFb6p3lqM+1gCyiqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108056; c=relaxed/simple;
	bh=45N3CTCQyFNYATVodSXBAL+a94s2+Sf5PekV0GfAnzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROXeVle4APtJPWHqu6Gguqjf4AWq+hIQWhEI92hVfcLqTjxZV/8tK0eTfeUFSEWe8yVm5juOmr7/tKNu4PuyFwjugMeCH2dVobaSuWruIblwmpE90bBOo4cisnCOVA6v1MZaXeZbCVPFUVIctgK/t/Yrt/jbGoQIG7J8QoFG4pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VNt3uvV1; arc=none smtp.client-ip=205.220.180.131; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id C0B0D40D0B9A
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 20:07:33 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gPp5BjczG21k
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 19:00:30 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id A6DCF4272B; Tue,  4 Mar 2025 19:00:18 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VNt3uvV1
X-Envelope-From: <linux-kernel+bounces-541360-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VNt3uvV1
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id A830443401
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:24:03 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 5C32E2DCE4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:24:03 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01FB916FA9D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B68F1F131A;
	Mon,  3 Mar 2025 10:23:15 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2601F12F8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997392; cv=none; b=duzudS5Nv1FBhr+LXxwtz/KoGGT10pcjOVDct/NKPTJZqz01VIjODy7zw+Mw7arOISf1Ocs7QQSA7kOxO6sKSQ5/M0bsEuAotPk2z146LV71bAZyty+ixawDvQFsItIqNZ4S3XOs7Z81SLgDbLB93fJg4gguMUBwzChgoed7/1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997392; c=relaxed/simple;
	bh=45N3CTCQyFNYATVodSXBAL+a94s2+Sf5PekV0GfAnzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opL1J33DLJZLEWpjwMyU9jixegFw4i2Bj2RFjkSLp2SJDSgLhJagCQkfsBYKH1TTPdfPdyu5GDXt6U0HSfdm1dnROxa+xkTww5GseWPIcWtYE4rcfiO28Jf0oTr287ZWVSrPvPiYuqtD818ICUkSy8iXvKj5NYgFlLhq6g/k1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VNt3uvV1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52300fmg001154
	for <linux-kernel@vger.kernel.org>; Mon, 3 Mar 2025 10:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GKhAMHMv9Qj1+aCKv/F3rYQfkqyHFXlh7B6Upy8lJ2c=; b=VNt3uvV1VYM+zOhx
	a4GpvWlv3sWQkm9TJqOKwNqZ21pPhTc+0p2ybbNPcXQqSWPwMR/N1SUM6kBK5C+W
	4wsvzev9/nqhbmeRPRnkpdCtTmw8yIs36ATAe3oO1VTqXZ8TdZhEY0IqLV8fyshG
	Tm6Ko65Qls5jIOuy7M3HhgPzJd2N6On87zDsizwEggbGu9AtqPKTq0jfIl5RSCdJ
	9QCEWRvj8s+sSdeHpTPkiRK6qWorTEqHe0A9NOn6KaAC06BtdmRON4P335xXO4Z8
	bE0Sqb6S564E88peQ3qg3HO6uyMQ3ymjW/Jw5cuFpK8JRcIhcHGupaCavVDG+8lD
	IJ3XGw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tascktq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 10:23:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22328fb6cbfso76901745ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:23:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740997387; x=1741602187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKhAMHMv9Qj1+aCKv/F3rYQfkqyHFXlh7B6Upy8lJ2c=;
        b=lyXuAgKMIfpQXE86uoPsuiwGEJMER+NDj7N7OCh7lUSan4ClhiF0C/07fn6j2apx15
         6LOdy1vtR7gVTto4ZrKwo1dT4QU4uyqvj6qJ1r96LR6UgOgviW99XVImqXEK2tnuHzYy
         s/dSo/mfYqQqVjACIrjuI3hQvXMOu/HkELccYbvmVXTHNNXLWfrWXaYJtZMnvsNol5iL
         IkHNiIrR96aoYppheqUmtCECr2Pl7z2ccQXlbavl7FmscthLb8LmlwPw4vg986J+7Ovw
         S5MLccsvrBAJznNbljJXqYzWEiOZjP5MfKFaMNfEnixrQtlPWYemMtdLMtVwc0MRTRDc
         qAaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2DlYrDmp8+pJPT01Z4pvoZ+wxupwUOTF+V0xz7CZMdqoAZ9hAu5OK08NOzpyyc/BHiA2tbzsRH/knCHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiOUNTeRT+j5ZHh0qrPOuWCHuHNkpOZGxE9mfCdZli5qcZZ9Hd
	pUKnA/1ADdPniHULkI0wtzkqhS77B1car0xNdVHWpPdRa1MeL2y9FKMU2Kf7MUr7r9L8Ty/XH0l
	SPRgoM/czCmyEux/0eO/KpSmZkJBOBa9puty3CMP30wiyC40DDU46/lJQROs2aDY=
X-Gm-Gg: ASbGncttzIiQkqH7zXaDxfAGWsvg4H1qrqACa5y55zjhvt5BoGC5xbzGeqlxT0OkM38
	zDujRk9TwZ9p9vJdYOQhp2S3zbIjipMf7BvfWX6WMDRmhQ0bsDiLi2ou3Gd6SpVuMWiBcmI+HTP
	VbRGpcHkHhmN3k5CVtJtPM4PfEDD5ndYYYXsWe5m3cdPjdBjwhaTzUlmIDINmuzpbVqSYxEpul/
	XY9rJN2ea4wlonojgpHMIBYGoM2GYSJjtlKt16VG1AAbTUty2F15teUo2IrGiB0i91wZHhINb7n
	qkbcy0GweQNr7rND3c18vltZjAaX8eWzFs8PtuUXImQ6tyWpccQ1Lb3pdNA=
X-Received: by 2002:a17:902:e54b:b0:21f:7880:8472 with SMTP id d9443c01a7336-2236924fa13mr206373605ad.35.1740997386641;
        Mon, 03 Mar 2025 02:23:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzewlI+MdkavpK5IxUd9OuTeDDFG7whKIl5HH92YgygrrZJJ+26+G+Xae6Q3us5qqTy1cWBA==
X-Received: by 2002:a17:902:e54b:b0:21f:7880:8472 with SMTP id d9443c01a7336-2236924fa13mr206373175ad.35.1740997386280;
        Mon, 03 Mar 2025 02:23:06 -0800 (PST)
Received: from [192.168.1.35] ([117.236.245.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505293ddsm73795215ad.229.2025.03.03.02.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 02:23:05 -0800 (PST)
Message-ID: <8dda7af4-b318-4e39-b79d-738b6084feb3@oss.qualcomm.com>
Date: Mon, 3 Mar 2025 15:53:00 +0530
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/23] arm64: dts: qcom: ipq6018: Add missing MSI and
 'global' IRQs
To: manivannan.sadhasivam@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-19-2b70a7819d1e@linaro.org>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20250227-pcie-global-irq-v1-19-2b70a7819d1e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Srpdol0LP4IUxYC9Pw7zSgdAWyHCfsG2
X-Proofpoint-ORIG-GUID: Srpdol0LP4IUxYC9Pw7zSgdAWyHCfsG2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=601 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030080
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gPp5BjczG21k
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712728.81661@yVmGEQIvxxHx+h7x2a3zYA
X-ITU-MailScanner-SpamCheck: not spam

On 2/27/2025 7:11 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> IPQ6018 has 8 MSI SPI interrupts and one 'global' interrupt.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)

Reviewed-by: Kathiravan Thirumoorthy 
<kathiravan.thirumoorthy@oss.qualcomm.com>



