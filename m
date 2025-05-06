Return-Path: <linux-pci+bounces-27274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2ABAAC106
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 12:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39FC3A7E40
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 10:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD552277815;
	Tue,  6 May 2025 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mczhZz69"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F06277021
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526362; cv=none; b=ASTL5ZlOAq8DgMPKdmMpM+CeDhdy31sDu28VIDFwyU3YHcUzpHYor9Buj8vLXtyKz/auV8mWXDPQn8COipjBlQ/HrNbF52e9A7PWNmte2rt19dhV8Xq4jeKMDZcNtk3wbNW10bktFrNaslbuZ8ZEMjJjbWTEZON7bWDrbbKpvSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526362; c=relaxed/simple;
	bh=HJukHi1LkCMcp62xJpzMIYpieG9w5Sw3zreVCk6scfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXw15i4rBWntKWU/VTUkTEaaCqtvnKFsEroSMzXv+Afj2RfTwSGZL0C7mA60QFWFtM1yyXpiXTMU4y9EPfNkn1ZmhPh0/4K0Pb6K29lJAdGIOWGUfB0aawlAxt2GYBlVp2KQTchgMR8f0ozesPY7/UBpZb+skT08Sc8TkQDX8D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mczhZz69; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5467IPV7013822
	for <linux-pci@vger.kernel.org>; Tue, 6 May 2025 10:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k3U5Q1/s2e7qAa0fnbs4qZTwxhPTpyKPAzDwJ5zTpYM=; b=mczhZz69HB1x8xsA
	bFl4K6/zEne6ps9qOejw8/Htrkf8XaAgnzYkfpBt/wGwheb1DEgjhaPkZ9XX55bi
	xVo8/3430jIRio26KbLU8ccjFu8lHXQ9G8fa664mFAlyK5HC+Sc/qriV69u6tYvT
	2VVejhUzph+12j3A7JeYt7xUKgMSacENoXwf5VbBb+j5xO3UTqiFaZsseIwtYRCT
	eCRTApGLVnMnE9HlCVuu286npxTQz+GMIJ2Xn25WDhgcIsc00Rwz/yk84y05DXqN
	mhV8S6fHSdkGiSe1MIS/Sa1TMivQLKkJerXQiM7mMV/g9YnjlHh/3Ewgy5ZeZrON
	Dd69Bw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46fdwtrhn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 06 May 2025 10:12:39 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-739515de999so4246760b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 06 May 2025 03:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746526354; x=1747131154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k3U5Q1/s2e7qAa0fnbs4qZTwxhPTpyKPAzDwJ5zTpYM=;
        b=ey0Acw0zrjmRb3+S70AV+Ekui62/+P/yBuiqviJA4q+pQSZu0tYdaEkTka4A82PqQW
         xhZ4sJHfP9dIV68rI7UqoLgkJ9D5qBfCdXdJ30kbsiZYBEMfpeiLa8OidEtVZxko/dTY
         lqQOULhYcxPc9latewBWoNqFzSwWzTU0KEYyGo77s6GqisX9mS+fsaA0D464M3PPmWbq
         inAr2Cobr54lOEddrydXTNxkK4Qj6Za792ftgDpC/k8F4S07cEqntFqHbAzlh12o4pu2
         rQGwMvwn2hIyJ/xVMc9bno4slz8klBR9MWbn1zvNk1/0Zi73gP8JGtRbISrpODPtdSAV
         WR5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFPSSEmLZfaJlNEUU+eT0PorYpwN00TxHi3XvReFyWuko+chWqe1zTb8T4Cqfm2DHa+5at1ZcHazo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVbmEE7+8zWu16flvhl1L2tMR40N4IvxJSli7HJU2Jmnn76qh
	D5vgFxUJsTwQCeF4JORZEHozRWvAE0uciCxEHCWk4dCjI8o3K9oocXvfW5YPZplV2alR87NvxUv
	+Upchc/WhMxEs9uEHWcEjOpB3BMcZLod/SZmo3jswZ7z1M5CbwWuy/cOoMT4=
X-Gm-Gg: ASbGncuEDNdOn6Y7MxcOYUW5hvOAvtIABfvzhxJpBKbx9AL7OVBHM4tsxIt8FPhluca
	lxBFAXu3jh4UKiPldbD6nCFJxN6Hi/NuywuJKzc3qAVhLyqY7GPdpfBzUhqgWEimqSyIEvIWepH
	MwN64hfMVoiSoSjSP4uk8Lr9cXuVVmKxhMCyUpuhvaoNAvhdys7oXzgqYzGZ/zMgN9nzaH9jcpN
	XaZaj6mfhLQttVosSWpxvlpe6No5KgW9MjyE18byIxsQnoURtgA+dPdSSFL8+tQw6tJDeWUlg7Z
	sGxZONw0vKY9UBBB20ZM97qjDBqdOWWLDyTGfj8A9A==
X-Received: by 2002:a05:6a20:2d26:b0:1f5:77ed:40b9 with SMTP id adf61e73a8af0-20e97eb2041mr16218706637.40.1746526354159;
        Tue, 06 May 2025 03:12:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhvjkqZaa5GWk2WXy8+Weu8/uaDFvUYvL3eQ4kTQv9vAFiciJDgiA0tYUJjGQ1XP5GX94YBQ==
X-Received: by 2002:a05:6a20:2d26:b0:1f5:77ed:40b9 with SMTP id adf61e73a8af0-20e97eb2041mr16218678637.40.1746526353804;
        Tue, 06 May 2025 03:12:33 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059067f0csm8761488b3a.149.2025.05.06.03.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 03:12:33 -0700 (PDT)
Message-ID: <14a99ae7-e33f-7160-970b-2097967b8ab7@oss.qualcomm.com>
Date: Tue, 6 May 2025 15:42:26 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/4] PCI: qcom: Replace PERST sleep time with proper
 macro
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>, Hans Zhang <18255117159@163.com>,
        Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250506073934.433176-6-cassel@kernel.org>
 <20250506073934.433176-10-cassel@kernel.org>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250506073934.433176-10-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VPPdn8PX c=1 sm=1 tr=0 ts=6819e097 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=sJz4SpAV8H3t2npvi_MA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: wZmy8BWQvav5WE1NwA8H-NlJFqNp0mj2
X-Proofpoint-ORIG-GUID: wZmy8BWQvav5WE1NwA8H-NlJFqNp0mj2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA5OCBTYWx0ZWRfX9L9nNIbXTcg4
 QkkuvGarto3JE/nMlDDQBcwZ1NcL2maf00DLGciUUXK6FA6/Zt2bJ73FM0Nh7CylC9N/oM+9IUm
 zMTDcofvDM5CJ5WbWBPO3UVVP4/aCR4lCq+fIKu2xmNNJ1g0Pwl3CCMqCADUv+lL75VjB76IZjs
 pkkQ3V0WOzNkgW5dN0Ngzq1TfTTn5G3myyFItPGXoc4Xku4biJdH2IuHPH4HDzVQ3J5WXARFkht
 2++dvBUsYn3S6Xv5MHDJ/cWjYXJSVJOws4cvoyeAvyO1VYZgWy7PtkN7oD4rsHFEZM2ROnBdmMk
 Arle26KUXjx5ktL44Rc67NXJJ/gYZe+mz3wsEU/qGb7xnRhak/jO0oz1mmSFkDAvzwK+6pJkbMz
 98hERff7X3snNzRT1K0aM2+avcCR8U7/OYjeBapfB9pKco68nld/lf5Mij9gf9gqwZQkGkmx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=903 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060098



On 5/6/2025 1:09 PM, Niklas Cassel wrote:
> Replace the PERST sleep time with the proper macro (PCIE_T_PVPERL_MS).
> No functional change.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 01a60d1f372a..fa689e29145f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -289,7 +289,7 @@ static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
>   static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
>   {
>   	/* Ensure that PERST has been asserted for at least 100 ms */
> -	msleep(100);
> +	msleep(PCIE_T_PVPERL_MS);
>   	gpiod_set_value_cansleep(pcie->reset, 0);
>   	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>   }

