Return-Path: <linux-pci+bounces-27445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27DDAAFDA2
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 16:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F024C68D0
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 14:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72572278148;
	Thu,  8 May 2025 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nwwux9qj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94931DC988
	for <linux-pci@vger.kernel.org>; Thu,  8 May 2025 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715652; cv=none; b=Sm2cvL8tZYhuyxCd0EmwfQbM7qa03RiN7yRM7EZyIVjVWugFRxjSXo6t6MKErcjEGBuf85/ebx+BVHsJ5fgcEqu1c1h1vUBWN7u6Prr3sWmMo7x4/rbm/NTGi54POeW5Xex0zrV/k/x00b2RNGcRa4hyKS+IxTBfDzzB2/GaWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715652; c=relaxed/simple;
	bh=jR80K/QEewPWmOZTyn/9wMsnnumofKPCbkzLx0ZsB0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAQHEn+rM8b5B5/W52Q13kennOdM70pZ2tj+T+0Z2x0UssUgxnerZDwGvbrd/se7Tab9WiqSvvAR5gKpJyH+uQ/0o11GU1F43Zl5uioPUsn/wrr4sucguVvTCU1pyB2RMqFX2fOGpThEYnnUTukjgGqiOy/48hwzW2ZonopmtfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nwwux9qj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548D0Ngh009505
	for <linux-pci@vger.kernel.org>; Thu, 8 May 2025 14:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9tZOCsJGlyFLYoLfnAHP+VSjddc9mN16QDqcdZ3mWyQ=; b=nwwux9qjSB+axDMG
	+BWniAkTKP28HEqRJBPR5hVSNv5i4HCQ0bHNBCKCNCFb7l1uYkO3+AEKXSGujFfw
	Fx2uUpOdZQKwa1xy4un4N1Y1eEtb3iRmTG4MNo4G/G0O4vA8ZjVusFd7N7+h5L+1
	wPOCEjFgc86mb/FIv5lLn2ZYZX3f86zaTkY6/I26bZY8P778V7Btajd+gnnpMC/p
	utU1lztRL/NaasJGk9RN02lUqc7ipG8nVl+nJ3MjeWZmEqRj+cIksJFZOpr7Iwa/
	bblXbMVav2pb3Igxv5pv0vA/VkxZAL7iDbKjcOglQxyho2jttx2Ylm5cy/0hwtJl
	nZi5Gw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnpesmqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 08 May 2025 14:47:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5466ca3e9so25677685a.2
        for <linux-pci@vger.kernel.org>; Thu, 08 May 2025 07:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746715649; x=1747320449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tZOCsJGlyFLYoLfnAHP+VSjddc9mN16QDqcdZ3mWyQ=;
        b=LVvdqBglgyi47/IQ5a0RH1jN5FnKK7uFmb2Hq2jr11kiDqApC9yRNOKib+XOCHF+UZ
         tpr92KUuMkKX9icOagpB6aAZuETb9dJPCgEfSO4KEvdRYrL5M1Efc6fMr6lZpIbpAmwn
         weW8b9CGPcEiqLUCXG8QjYFwKbOUKBGZlcTLRo+ry6UNbfm1AdwYen7ROymenuAZVvWW
         6RqF82uawiNE5TnMLtfymJ6rVS1mdTPoqVynRXJ/ewWZR+gK1389pfDeYMjfjlTXyRBU
         5R5MKCAfh9dRFfJ1A+NT8l+RSHtCKHpCVXU3+c0YcWO6RpmzpY6fHHBuVmgFmTWNZTdK
         Yd1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNIlPHBCMKDuKQhxG97OyBmAUWqj/znf5ROEnLHx2zrMXYZZqDd3TYTYieh0fFaPxNqBVDfiNLZKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ePhQMXZ9C1m2Rm+k7nYG/hF1sV3EZD03PH6BUVHqO0V/ihX1
	YaYSkYpY2ARzsrVu944hAq9arf1MWJOib8JwKfH+ksvKyqxhaXO+FMf/jro0EINKLGQq2YbVn6F
	6tmQLBBACd9b7kolYiFUKvE6Gob14oGmjzPQWpg4lXX1xo90dzbwrlea786U=
X-Gm-Gg: ASbGncsMFjtRpkbOOY0x+2aAcT972BVkgaAvWZZcsVZXSos3GN72nMI5VRVRTXG+Y97
	pW+EcnmuBkvpcEAfKA+dGZVvmUdv5niprznuedHY929OKcg3yLeVHTzVQttzxR0l48jPr/+g4bP
	QD/6P6lKisXjgXeiroL+aMPoDeTLnasLWrRqOyx0+Yw8k/ntbWy2scQjNR8cPWVkQQ1tT8vr7Z1
	RA/qEWtXIqql0EkHuIBJlu3Wt2wVypiCBjr9A22AVeHm2SfFr7Js0yAcBsKhUY+KWHqyfCg3vuT
	90dHkvWMWE8ke3pBV9/iEObqZbT7n/FiVErU9i4ZYHvxhFi4UoU6oK/0dZwIPdlNTQA=
X-Received: by 2002:a05:620a:254c:b0:7c0:bb63:5375 with SMTP id af79cd13be357-7caf7385bdcmr375785885a.4.1746715648870;
        Thu, 08 May 2025 07:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbEK+0rVOs5KX20bF2OzVz+4r7xuzdh1bFzxcezKHmRZSJtEuVUnd36y5OF/bb2KQ1G70Cng==
X-Received: by 2002:a05:620a:254c:b0:7c0:bb63:5375 with SMTP id af79cd13be357-7caf7385bdcmr375782885a.4.1746715648491;
        Thu, 08 May 2025 07:47:28 -0700 (PDT)
Received: from [192.168.65.105] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fbfbe5c5bfsm2220198a12.9.2025.05.08.07.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 07:47:27 -0700 (PDT)
Message-ID: <96c54162-f985-46d9-820b-48868cfb1405@oss.qualcomm.com>
Date: Thu, 8 May 2025 16:47:23 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] arm64: dts: qcom: qcs615: enable pcie
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, vkoul@kernel.org,
        kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org,
        manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250507031559.4085159-1-quic_ziyuzhan@quicinc.com>
 <20250507031559.4085159-4-quic_ziyuzhan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250507031559.4085159-4-quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEyNyBTYWx0ZWRfX3q/4tWtP8mXD
 yJ8brW1sJyVcHXYZOn6kQSnHyggzXa8b2v2CPzE5uHS0oSvRVtGoC+LyoobK2WAKNa8e1ZUlLKF
 qVcSimypl3+mdwq3Yg/sl0TVn3dXyh96xvH6aO7e/AUOvxTjqpCJqsagX/P+a5Gz4oKOJZ1rdB3
 kCpX9WXtl2WoN0mCiaPkCEmAP7st2oxjIE9cq+3In+Ufq3q/LoRCAF7xKWOFAY9YE0OiYRSo0a6
 aWmwbkj1ekdgoPFZOmxconlT0oHGx4h49GUSm4oC7CBrM3F8tZIof2LJDtS1YcDUhfYJqvMUw+c
 p2m/QQp1ETjsD/DRBF/VBu/kNcVbBy9E7MUHasUgs8N3RewDt3S/1ctWeG0RzzmDnm7Mr78KSh+
 w7/ETSSeX5eyHl+SSNjrnPZhUMy/C7UB03zWN75fdAC3Khq21AkZdtDDBgN8cyMKu8iqQ1i3
X-Proofpoint-ORIG-GUID: H5fzbLoA_gV54cYaCIQi--fP0713mNMb
X-Proofpoint-GUID: H5fzbLoA_gV54cYaCIQi--fP0713mNMb
X-Authority-Analysis: v=2.4 cv=Yt4PR5YX c=1 sm=1 tr=0 ts=681cc401 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=u-Wjf5nI4b4gXCDVDnUA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=618 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080127

On 5/7/25 5:15 AM, Ziyue Zhang wrote:
> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> Add configurations in devicetree for PCIe0, including registers, clocks,
> interrupts and phy setting sequence.
> 
> Add PCIe lane equalization preset properties for 8 GT/s.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---

[...]

> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>;

You added too many zeroes after &intc, this could not have worked

[...]

> +
> +			eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555
> +					  0x5555 0x5555 0x5555 0x5555>;

very odd indentation, please put the 0x's under each other

Konrad

