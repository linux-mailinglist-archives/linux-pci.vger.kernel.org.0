Return-Path: <linux-pci+bounces-19092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DE99FE769
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 16:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1E43A2239
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AB41A9B42;
	Mon, 30 Dec 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gRzagZ3Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD99CA5A
	for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735571165; cv=none; b=N5MBe2Ts+nx9FNZlt0GdAPSiBdElwsLru6P+Vla5AcbeOBnXOfkf3j3NvfVCa8BORD4ZYiEftaO2/NMvrsaFxP+Mu/jConDa5mZgu6onUxyp94oOv7hs4FKhh+mow7Lk5qXsHEGfFcVUZA5cqeJ7bBizXmaoRV2ER2HuOUIuDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735571165; c=relaxed/simple;
	bh=3P1N7aXCvO0uphOPa8U8nOsYXKeppbeAFr24u0IB9qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZtmLvxt580rhPZGKbM7jOm3zOGYery9DMqvuJAD7j3ePfRya3G0EzMjxYgimZBVuL5HvCr7H66BUcQuch5s5pfEI3IjydtDxQQVjnPtvdp10AmXYRj7hQWKNy+mRCZQ++RAE+dCcnWJIdxKTBpmx++VeSXEaHkohGdIgU8TtCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gRzagZ3Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BU67rbr023043
	for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 15:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ehWfGPcCLSEfEC42hvN/XOS5H/EYqBO9m0oPbiJ8mWA=; b=gRzagZ3ZWUXQ3lau
	45MumRAmNuaKtUOTeAp2MgI40pWbvK/mBiMW3DCQtZI3QFzVHjQCCpKJvzCeX1b6
	jQpN/FrmlXtAeNW0gAqD3M12G2jpvJ3m5VTwJLbicS0tyrStXdjDJ37mncoU61QT
	JmAqKMeLF67rqCh99ZQiXxrMfj1Sj3mjaiOFAJTX+tezfotiSxV7jOl6ahO2/R4l
	sjd152e8i4viRmD5+A2Pg/MUbEJx4csLiel9DsaUTsIbdwSAek8roFlWQokUmx98
	DHfj01C81kaPWLFT4Nl5pu4YKL4TgeYjgd2z29OtysGnm42k6clIRV/MSmlxehWl
	apOPxQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43unys12wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 15:06:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-467975f1b53so25032091cf.3
        for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 07:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735571162; x=1736175962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehWfGPcCLSEfEC42hvN/XOS5H/EYqBO9m0oPbiJ8mWA=;
        b=h4u94r7UIdId2/ohO3y+c0YCgIZ3fqpH76J7RQ62zoQC9804djN4llBLwe4nQod/Xj
         2frh1ReKAiTiwlLtLQjHzyra9DLP6uJOqk9fQTq3/29hJaiB1EfXJnBsNI0aQyQa9HxK
         v5MDM6gSfoEJRMws7BaQvl2HxlVVew0CQeT0eDQaafkw50uVtANfaLTBW0EbW6Z7/Kbu
         Qq2zGAUkahEJ0AeC67twqve4/75th/Gz/J/Ut9B/iLWF4cf+a043Ln6Tb05PgkEvd1fc
         674iJCyermrLdm/zEW63wx8/w+cASXF3P9UpslWuQmlisPXQoUEJUsjVhAJfEqz6v1R9
         C8kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfe7rCw+Pbo2D91dOLC4oKi5pMGEIdc0NjSv4qbRRYq8RZQh43nLEjlpmQN9KJ/Jhls2qrjht/U5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQeM2zC9fYbnYf5ryb7OBkz1ojQm3aB2IvBEsSTXT2aopyJs9H
	wldLAGrs5EIu7JoLMMda+YqNSNad8/jhOHGaA0iwvy8XeTfPW4YOvk6sHKouSxVf2jAgfHbHrLG
	yhXQF5TxCQfFKJi2ubTq2MWFRWuKQ8upU1zo9tJ/6tyLvsXH2NOL6iO4uaJQ=
X-Gm-Gg: ASbGncsj2gCwCJPcerOEiBPyoyi5Tza0PjxRuuRKvtbU0LEK5bB4HFHi4OUDEAV6EXz
	vyP4kb+DA7NOUSl9nunJhaT++hBYtCKOAZefKOzKV8NQsqsV17Fdi7IicIhlXa9Kij/HwionqgO
	jZvm99uoNVojUbClIAt18AGz8QDueQrP0vcRmfX7xb1qu+dW+sG1QsEaKiEFmjtEytcB3EBU4Zr
	WMe+zw6wyw1etxjOpjAqPsPA0w8W+TVe3Tqg7AbvtkHUwxW22o8nHkzWBF32t/7l7948rqR3EaK
	lOxsK7l6xoCwu8vdcJpKyAZv+5hb+8BgZzA=
X-Received: by 2002:a05:620a:454c:b0:7b1:4add:f234 with SMTP id af79cd13be357-7b9ba7232c6mr2332799785a.1.1735571162499;
        Mon, 30 Dec 2024 07:06:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXsa5g7Aqph9cbjlEpfN+a2POv8ZHcFZcVA5zwUYAJMZi9yRoNMP5FC+yqW0MHB9wXyzdGUQ==
X-Received: by 2002:a05:620a:454c:b0:7b1:4add:f234 with SMTP id af79cd13be357-7b9ba7232c6mr2332796785a.1.1735571162139;
        Mon, 30 Dec 2024 07:06:02 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe46casm1502781266b.129.2024.12.30.07.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 07:06:01 -0800 (PST)
Message-ID: <8e60ac5c-dabc-4790-a663-717b7fd6e232@oss.qualcomm.com>
Date: Mon, 30 Dec 2024 16:05:59 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] arm64: dts: qcom: ipq5332: Add PCIe related nodes
To: Varadarajan Narayanan <quic_varada@quicinc.com>, lpieralisi@kernel.org,
        kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
        bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, p.zabel@pengutronix.de,
        dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc: Praveenkumar I <quic_ipkumar@quicinc.com>
References: <20241226102432.3193366-1-quic_varada@quicinc.com>
 <20241226102432.3193366-5-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241226102432.3193366-5-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kpZPRZvca-XFVLYBlnXZ5i30sXFzsTWI
X-Proofpoint-ORIG-GUID: kpZPRZvca-XFVLYBlnXZ5i30sXFzsTWI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=712
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412300130

On 26.12.2024 11:24 AM, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Add phy and controller nodes for pcie0_x1 and pcie1_x2.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

