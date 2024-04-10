Return-Path: <linux-pci+bounces-6037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2389289FB7E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 17:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC46C1F2209E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2423F16E870;
	Wed, 10 Apr 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QMVx+iIj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5979D1591E1;
	Wed, 10 Apr 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762861; cv=none; b=NWidxYlPHSnMdJEFE7OeK2PNFYl7/bjiBIbg8zUdwkqsNe78KwQ0e/D97cOgl+McVAu06xN1wJ5f0pnYXIg38SmQUX2ALY9TCoqiM+IFCHIgH2tQ49756w7tkZFGxkW8etscol5zjjA9Z4jKu5PDm2HTCULw4nlkK9y+VS0z+5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762861; c=relaxed/simple;
	bh=yaqHM0962MfpM+OFdQda8fXPe0R1wO7c3AlNIHOVwdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cIDr9b+TXaDzq5eq0ksIiA5LVmLWXAL58VAPt8bPBT3w2Lp5ptcZt8K1cJEot2DdXJ3ZHUQemGHmuSecBTA7AXhXPlN0qm0PEMop62C+J9yTcBqnLuD/AvZI5AbjTIKRvXHuWID3lh/GmRj4O/5b3B4A1rcFzaHvSVRZEpjeZtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QMVx+iIj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A8bUQZ020430;
	Wed, 10 Apr 2024 15:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SeKInDMchgVr+fW9WAo6YizzoIlylrKBtPkpDrYflGc=; b=QM
	Vx+iIjNoBxgbQhbk47P1pSkvCBi6kiaSSZFteiH8PqXWUF0Y7UYSWrwJ3USY+xai
	GpMzaeDLZwM3AoGqxqUV9+ueya3RJGxE95WUHnvgCDFs5MzZP+Djd3mUZ8JzAwe0
	6S2YEqGQJdphdetr8iOfJZaaPyjM5230lKtCzNV8IrViCObX5p7tH3axnILjKVCn
	HrHWFKU22mBrjW0gJUsF1fI2uYWOU0hgzhaQSDLoYsE+Jpvut0geIRe/ud4DPPSJ
	8fggfL5TrmQ7pfWvB/7hPSNjCQTZ3E7PVA4IghTfCh3TrgZ3LycX2IH7oruboSQa
	QCfwL5e2a4lspc6371dA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdnqtjn3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 15:27:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43AFR8Ts012315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 15:27:08 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 10 Apr
 2024 08:27:06 -0700
Message-ID: <d440d38f-f805-4c85-96b3-ae0b5ad2bbdc@quicinc.com>
Date: Wed, 10 Apr 2024 08:27:05 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/16] dt-bindings: net: wireless: describe the ath12k
 PCI module
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
	<bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
References: <20240410124628.171783-1-brgl@bgdev.pl>
 <20240410124628.171783-6-brgl@bgdev.pl>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240410124628.171783-6-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Wx5pfsg1IEL3FNsbq-QxsVprddWodQtT
X-Proofpoint-GUID: Wx5pfsg1IEL3FNsbq-QxsVprddWodQtT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=826
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404100112

On 4/10/2024 5:46 AM, Bartosz Golaszewski wrote:
[...]
> +description:
> +  Qualcomm Technologies IEEE 802.11ax PCIe devices.

if you respin, nit: s/11ax/11be/


