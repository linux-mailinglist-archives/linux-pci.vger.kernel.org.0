Return-Path: <linux-pci+bounces-6039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB22989FC49
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 17:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915021F249F3
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 15:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24D0176FB8;
	Wed, 10 Apr 2024 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HREO9ktn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29111171659;
	Wed, 10 Apr 2024 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764679; cv=none; b=eghJnFG6YoV2w9xlyt/deV6Uw9Qqq9mwFWFLP7tcj0F/JXgXN+kvzMUVpkbiVllmjKUtXGbbAJgGPVQvmc5oxPtM+gVdH/VFeeRNPXy+7oDOKef6Zy/t5pkyS5x8H3OBykQ6xt5fOhF+TnlkER99OHOvXpw7wS55TDuwo0q24hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764679; c=relaxed/simple;
	bh=158o41P2FOBJVftCLhVbau3btyhldhHWhOVhDa5UebY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dvgCr5YI/S/8pZVDWNnKenfkTo7sRsNzDkwXw83+LNndmApW3dtg+B0hgYsxb1ZTdyEIma9DzeSPUmYWd8kb2Aoo+A0h98ozokCcqhgsn/LA6FrpfkZd28quheVYKJV1EVCD03v5CQEnXnSunqyi5VRqXlyuIpFOsTNuH0Zi05c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HREO9ktn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43AF0ClY000446;
	Wed, 10 Apr 2024 15:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5aUBuklUBGSU6oQ9ct3EHBYDelFvRczJm6cBGAEe6Gc=; b=HR
	EO9ktnalsEAReLS3NbmAK7tHz6cgXKCg3PSIiktdljMVABHYLhLHbhDkghtaDotK
	rmy4j29uhWo74jKA1RIiFZr06/oPdhwaqmbc1RymOY7SDK3zD7UvnDlZnjT9erXI
	uRhU1ZDI7HhfzTTlPcsXcJdP8WeDTfjeZE0hFbDKj6OXC/qh2b7IfhcpzVgIBNvm
	uR5J5yKxLpUZ2F855cjNT/ES6kPrlxDUZLQ78JEKGFvuCGLwW9dnJGrYv9S0ZXyD
	jZJqk42M+t8p4vvJamPZvZk2c6XryMwmxRqnY4KFwYLxgUsvfAIK0W9CnOgUcI6W
	Hrw0ljAA9NjMIQra4lFw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdskjh8vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 15:57:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43AFvQeM014775
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 15:57:26 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 10 Apr
 2024 08:57:25 -0700
Message-ID: <c47bfa2d-42d9-4765-b6ea-c76a15fa994f@quicinc.com>
Date: Wed, 10 Apr 2024 08:57:24 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/16] power: pwrseq: add a driver for the PMU module
 on the QCom WCN chipsets
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David
 S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Catalin
 Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Geert
 Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Neil
 Armstrong <neil.armstrong@linaro.org>,
        Marek Szyprowski
	<m.szyprowski@samsung.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Manivannan
 Sadhasivam <mani@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>,
        Amit Pundir
	<amit.pundir@linaro.org>, Xilin Wu <wuxilin123@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
References: <20240410124628.171783-1-brgl@bgdev.pl>
 <20240410124628.171783-15-brgl@bgdev.pl>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240410124628.171783-15-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EfQl4YuLzXuLVNYx9EwXY-G2mjg3Jw8I
X-Proofpoint-ORIG-GUID: EfQl4YuLzXuLVNYx9EwXY-G2mjg3Jw8I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100116

On 4/10/2024 5:46 AM, Bartosz Golaszewski wrote:
[...]
> +if POWER_SEQUENCING
> +
> +config POWER_SEQUENCING_QCOM_WCN
> +	tristate "Qualcomm WCN family PMU driver"
> +	default m if ARCH_QCOM
> +	help
> +	  Say U here to enable the power sequencing driver for Qualcomm

did you mean: Say Y here?

> +	  WCN Bluetooth/WLAN chipsets.


