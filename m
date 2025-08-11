Return-Path: <linux-pci+bounces-33723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62305B20731
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 13:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644062A307D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 11:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525622C08CF;
	Mon, 11 Aug 2025 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ktTDidAI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7702BEC2C
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910881; cv=none; b=bb1psYLnL7i4RorOIijNwPF1P3bEr6Al2gVGw+ncf2nTWTuzyOiBTBKqZea2/L88TTSQ3PHn3JmXr5XwSmFzHYnFpddU2ogdH1R2N8aRuOQRMpN64O87B8GMLhn4/j4DLjgfyLWSaF/7fiTqJy28K8jn+R+FgMtVpfDcKK1TpCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910881; c=relaxed/simple;
	bh=e24QJFeYn/rd0qZBMV40BvBKk1/UrSZNtUYQoAsCBHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARpSZ3ygNN8RutmZ8i/3XqYJU4Ny9kC3f4CNoTpUvlVRPUbT8SxEltKcWVgZu3fp0ab7nzoPGlVBTTDTPZqOnDguXS7ys7G+pSnDid16ZKjT0/USr6OiscV+WmNxajoZI5AtJhxNrUMhIbdosF77Dj+LAdQ17tQ23Mpleb6NmkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ktTDidAI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dCQR021589
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 11:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FMVgCALr0eA8+Us8AyPrgn7ofcaNBLZnHFXRdCHjjtM=; b=ktTDidAItFqOW24t
	S2HZKgTLd608Um1Wjh9VBp6qsSawH55zNd6TIZw11mULKqEatccWJTDo7Mjm5C6n
	DwQlz/d12F0HPP2jPg0x+seP3HZr+XLAINcB7wcGiqNdwY5VQJm9glOX5mxo8/da
	rzrKG9D4mjdzpf6exaer6qjLaWEum3Uq5SgPpNl5ZmEHsJbhvOnURV1ondGMOEnG
	UeBeEHbIybYWKH641vvZNVqfu8TmAhRjb8wgr3S4obhADzh+mpZA9OeQmOOYlKVp
	4WGchkteboag+vIkXj4KcPEYY64Oswak4OkZfCz59BGRPTPLZIOdV9VOXV3whK74
	9LibGA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxj4458h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 11:14:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b071271e3eso10880741cf.1
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 04:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754910877; x=1755515677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMVgCALr0eA8+Us8AyPrgn7ofcaNBLZnHFXRdCHjjtM=;
        b=YhqAcVDdow0mn1cNfX++nC0o44Z8wk/gWCb+HFU5ciwla6E2R0DmQ+rIYuaqSA9T/B
         4SnXRdUXbGu9+o7E3S9T1puqy4HWJ/fzTvkPqfYnn8HT0x+jEKyG8tM6R/46XqP+rJs4
         2R8WknTex/duxoLb8qOjacENxpSPORGVy+wDCK6M0xEb6I9uIPG/n3oyuKzBWDUu/7rj
         Od1WnyoFPJGfJ0cVliiZh762ZBbGCBUNd3MuNIHu8BnkwxheAOzgOIFlJ9eJa1XicYdP
         LHnvu+0m4ATGquOnUJlfZDaNYS6zOdZlwjNlcd5+lWCpovCBo6ewAln+fabuAobBCpEy
         IYPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZv3H58FNGr2PCqgQYqZuxcB2oSZ8AjSYdsDPk2hyoYXV/EOzIzd1WVB74BD47xS/vDU0HuRxcQSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBzJrXdWOz0srVZ+Rd4K73KR7YxAkWsM57BNXkphQd1JK3KM+6
	MeSLUa40nHbcs/xMgXSMltOWOV+jBZ436ogpyp6xDB/lykmURgwQKOu6xKEKKno1/acOSI9qyZ7
	vHNVCodvMq/mXHYtD/Bk33XYsh1cT7Rei8ylncIPsUG0fWaW5CCqARUSiCse0hIA=
X-Gm-Gg: ASbGncvXbO0k/0e7cLyjmaeE2ibiC/6eVLYuYOJEQDpUu7fpw6nV4LhUdBlF0BMkibG
	EZd6P1K8MPzLHaD73gGfd8mSCcuwuiToktt7BG7Bh4dI94sw6iKpdBhZ7c2405kxCrIUQfpwMMt
	wXApadvCSlCN1T/nPliq4H6SdLzY3UeQYumgUeHDCUJFXPOGGePX2bUbwVYaSGfuHcq3Fy3PP5L
	qwXpX75vfANhJR1+/s+NTqHY1+r0T7KzPnZg7SN9bzfvGMBZ/cCwZj3YnrYuIkk/MJ+XYd7veED
	R/xPghbEJb4fA+NQtijS5Ell362l8YYNmh6Q67sSyvHXuqnyM2IGs7TGQgYV6j92UYP/woBN/oG
	3uhIVtbSb/IkRoTap9w==
X-Received: by 2002:ac8:7d14:0:b0:4ae:d762:c070 with SMTP id d75a77b69052e-4b0ea60d209mr1240961cf.2.1754910876592;
        Mon, 11 Aug 2025 04:14:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcUfndsz+/5jp0G9OaiDDbR36Irm8Uk+PPCGZvdlMWx0v8ppULBdZLYX9OArLLxW8LKzxvuQ==
X-Received: by 2002:ac8:7d14:0:b0:4ae:d762:c070 with SMTP id d75a77b69052e-4b0ea60d209mr1240671cf.2.1754910876078;
        Mon, 11 Aug 2025 04:14:36 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21ac0asm2000540266b.99.2025.08.11.04.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:14:35 -0700 (PDT)
Message-ID: <a6dbfe06-00bc-4fb0-9496-fb7ca849f832@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 13:14:33 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8750: Add PCIe PHY and controller
 node
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com
References: <20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com>
 <20250809-pakala-v1-4-abf1c416dbaa@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250809-pakala-v1-4-abf1c416dbaa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNyBTYWx0ZWRfXwdrjn8qTFhAR
 eR7VPTlJ/nEuv9RKvikXiN9VBMtnEraIqJMYMJ1w62tB6hIzQPdBzjFdKmOyvVAZLDncBPOUDKx
 wc7AQrVi2QWzJVHPXDSGLLQSZoEKAvtwzItPwn1KOh2NWEsix8b0nidStI7r2yEMOIM5c80p2Yw
 IhJ2SNP6kBLCwiuU770Y0IS5ap/TuBoCRSealExqfst4DgU8AAcFuFASvcVIdne++SgP2nmc3Qk
 AKwlCeKX3PyXK7wF+P/7W/SvPx2u5rhhYmwnp9S8mCB92Uo4TB2wPNdc2OCvVObr6PBl4/Z6xvF
 AD0jOpOCtEJFjRcttha/P5V7amvJDGTtj6XHE4J7EaTkTs8Q2WfAA4z5PaRL59PsISK3Iqc9Mdm
 DzU2OldS
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=6899d09e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=gkRObvzxmN_HJK3DEhcA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: u6h1Lia5ZAvsp5tisrZEHUdDDNdUS-ee
X-Proofpoint-GUID: u6h1Lia5ZAvsp5tisrZEHUdDDNdUS-ee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090027

On 8/9/25 11:59 AM, Krishna Chaitanya Chundru wrote:
> Add PCIe controller and PHY nodes which supports data rates of 8GT/s
> and x2 lane.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

[...]

> +			phys = <&pcie0_phy>;
> +			phy-names = "pciephy";
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0 0x00000000 0 0x40200000 0 0x100000>,
> +				 <0x02000000 0 0x60300000 0 0x40300000 0 0x3d00000>;

The BAR space is larger (0x2400_0000)

please align the overall node style with x1e80100.dtsi

Konrad

