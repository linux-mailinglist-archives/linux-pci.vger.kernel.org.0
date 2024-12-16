Return-Path: <linux-pci+bounces-18500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0FE9F3011
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 13:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750BA18869F8
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 12:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B0B204C19;
	Mon, 16 Dec 2024 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eJJhjJQA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6496204C14
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350751; cv=none; b=t7gyvcrRf8H5zzFgD5AWbHWcSyrj3R85eq0LlcgS/8g7szRRALF0VAi/UBFU6WvTmfsd0UeavD7mWNhNuY8c8UmdKsNKvia4rTBa+PuprfshOgOziU76brpl5LYrFOc0S6cKEN64s7i5b6Ogz/i0Sh7D2iyJ7Cy2/Hs+/LTF/kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350751; c=relaxed/simple;
	bh=br4Inlr1OYwkQ4DcqTTZJifF6KCfFQoqEw3+vLT1824=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjpCLqm5QTuimCepGQaLegIe+wHMiQb1LnxsuG4eekCqBF0xG4SJHb9MDwqS4rJILZoxgkZpLQJTbtlR5JEvFyZLyWRNWBq1l5/zDalNL7E9eyve66d7Dra+yQa3y2T5dl9KJ2ASplnkmhr6lO1nNbTpHOxr5mf3FNnmyS6XWhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eJJhjJQA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGBQaee024985
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 12:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nozNBImrI0flQxop21C9levd721Nd++WaY3xG3YzRL8=; b=eJJhjJQA5mcOLeLf
	DEXI/VxmbwVAt3hqafOOpQepPggnSHfVc6eHRPGH57MO4Ih6Xgq9ExGYOksNDpz6
	Q8oZzqtc3CxUrXyTU3uP1+r3AUsV141RuhKsyfq9E5n/kSxkXMV2v6zryxI2MMbD
	wCqNRr/N3DVUsyuDBRuBOBtr4u2s5d2J+9wylIBFekAsZr8USm7arBkffJiCu4sG
	yaazRHG+XBMkPwYZAWAjUd2t9+ZDL3BiKNUP5mNrgVcS2ebR4SIaNcHY1N5unmZF
	QJ/zDJqyibSNwM0hpefLL67/f6cstqRIiMGqNDxII8sFVPh5GXxf4u9CpQciQymx
	ly1tEw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jkb7r474-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 12:05:47 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6db1009a608so8797616d6.2
        for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 04:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734350747; x=1734955547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nozNBImrI0flQxop21C9levd721Nd++WaY3xG3YzRL8=;
        b=TqhiKg5uWEz2gAFWs7WHP0nRWMW1yfappi2QHdyTXGMZs4dZS3rON5WBgN5cFkCnRz
         aqgLyVIp7eXN5zFWeMa9sh3mJrY4IZOlBNHOL2S2P5skz5wcHZ517z6gtwNgU8Xuxfw0
         KJH6riz4nKjT3zidGJsOzhm6tgxZ/JQ0epZS2NUowXppGh6RFfTbTOKqaf/OAcObltZ0
         7lMIF7K+0B7lDoKXPiaBhIFEO7TxciI8Dnm+yNaz0VOgm0VDzp2SjUB3HDv9Wdk/0+ot
         hZNMxT5xHKjbM/wOm7JuxgUMVrHSHK9ETvSqckhs57ZUJve35b3XU1MmS3gjZxjF4k9O
         x3kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVH4DJ2f+gpuMe61NVEiaW1P2S/hrv4MHgSmjbLXh10VzLRjZYmO+GR07xU5t2s/GAn/6F0cTijkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxok9b42cdKXZgTBokyPYxJgSmQG8qLHVuUlbo2tdW4+kBl411c
	LC2Qa0RugcM3m+bbQpzy7CANoJ13icnFsm4tg0HkxuY0XMRsQW726SGMGBDqM0Luf78bKDuuBP9
	hFK0vJkFoozAzc8UYnhUIApzMuuzMAzu26FbjuFV5Y1oNoOOmA1QydKpdaHM=
X-Gm-Gg: ASbGncvYjTcMO4lVHQfwDSvqeY1k2jLFNdqNNu72dj/VWOMC6SOZ5pssNpMd0pCHNK+
	fr+NyJ5r1cCQm+UXWlsK+gcfD9VIzQYIgNbCv/dlIkkZv5I0Nfz4byE8KrHxj6XfN1KvI1k5xxr
	70Zf6qFspcTrKMi8XjHPP7amqr+0vLrw7MfEcOyc7Ann0jFQUTHc2zbgu8mD6rpLaDy2yhaQxmm
	DnR16wlO3YYTDDp0MqkXaPVQDu+7t0j5OSojqJZYgQTsdKTEhD9THUm95iM0M9BjwQ5m+PkTxoQ
	zUJDUA8kjTglDUlR43NGGC+xHOA53NcSjHc=
X-Received: by 2002:a05:6214:27e5:b0:6d8:a723:6990 with SMTP id 6a1803df08f44-6dc9684f7camr74570696d6.7.1734350746688;
        Mon, 16 Dec 2024 04:05:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeXN80xQXmAhwdOx8Qvq8LX1rjnJEvO+IAfXQhj1EJOLdCPH2AIDU5QEJn1/k/Qfvf2stHuA==
X-Received: by 2002:a05:6214:27e5:b0:6d8:a723:6990 with SMTP id 6a1803df08f44-6dc9684f7camr74570366d6.7.1734350746286;
        Mon, 16 Dec 2024 04:05:46 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96068928sm322936866b.70.2024.12.16.04.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 04:05:45 -0800 (PST)
Message-ID: <b17f1675-9ffc-472c-9dc8-50fbae5d18b3@oss.qualcomm.com>
Date: Mon, 16 Dec 2024 13:05:41 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] phy: qcom: Introduce PCIe UNIPHY 28LP driver
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
        robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
        conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, p.zabel@pengutronix.de,
        quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20241204113329.3195627-1-quic_varada@quicinc.com>
 <20241204113329.3195627-3-quic_varada@quicinc.com>
 <710aa948-d27f-49f6-a4a8-73f6208502c3@oss.qualcomm.com>
 <Z1/JG+RkTBW9JuMO@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <Z1/JG+RkTBW9JuMO@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GWMewMmtN9e-UdRsfYumFCXvdM_BOMbI
X-Proofpoint-GUID: GWMewMmtN9e-UdRsfYumFCXvdM_BOMbI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=843 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160101

On 16.12.2024 7:30 AM, Varadarajan Narayanan wrote:
> On Thu, Dec 05, 2024 at 05:40:15PM +0100, Konrad Dybcio wrote:
>> On 4.12.2024 12:33 PM, Varadarajan Narayanan wrote:
>>> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
>>>
>>> Add Qualcomm PCIe UNIPHY 28LP driver support present
>>> in Qualcomm IPQ5332 SoC and the phy init sequence.
>>>
>>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> ---

[...]

>>> +MODULE_LICENSE("Dual BSD/GPL");
>>
>> I think this is too vague, there are many BSD variants
> 
> Will change it to "GPL v2"

Checkpatch will ask you to say "GPL" instead.

If you want to preserve the dual licensing, maybe consult with
legal whether MIT/GPL could be used instead

Konrad

