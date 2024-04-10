Return-Path: <linux-pci+bounces-6040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 540B389FC6D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 18:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1011228D3DF
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 16:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D86178CCC;
	Wed, 10 Apr 2024 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZthO1lbM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAE51779B6;
	Wed, 10 Apr 2024 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765162; cv=none; b=OpTS7KzUcJCwJf/VqHXvK2DTkd28re5/2RCGvW/bKZkz9jSGASlyTD1NrWOi08thUiaHekKlvXvk5xkkxtMy+MuXxl8KqYBnxCCtFtyosebCmYitaouio9E/o5ZUvSSBNxZ5qhfvVGxuHekZOte2usV+CeMg/L4njj2Z83K1CTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765162; c=relaxed/simple;
	bh=piq+aZgljrVoCDKhCfSkoGK2WF2WNTFw7ziQ5tAjdOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lc8Ox9B9x8w7XPCLcLfCcVjyI54QwnThiRi3Jetn7rh+Bc2I46DOsfCHJI5sct4jW8p5Ku3jfL3FgOtOzR7JPJBG4zhoKAynlnaZmbHMQ3HI3fV6TZtLWYjUfF2vUEfvCsE9QfO9qoPes1KUY8vGBmzqDrTkHCaE+0mvFjI3DWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZthO1lbM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43AFr5a9030162;
	Wed, 10 Apr 2024 16:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gofH+p75A2H6MwZ+LcSc2nUNvgwMF53ULI8Ss/9g+q4=; b=Zt
	hO1lbMnlBlYM6pnlELChyEfOLMh6lvk+6K4hFEz7irHMPx5GRtqr6QJL8OHa4STH
	oY2274kPX9yaO21fipOT6y3smAhYzPP6GRS/B3aLVLAftOCeGcbeugvhU/G7yK29
	05SlUnMnkyOMoDEzkj2dQ/8cr08q9dNwIbh/yvuEkLnP6wbKlqYmpXtMd9h/m2du
	ui1PMRupXHY6oDfb2oMbIKBVK9Zl4o9ukJmcptWLKV/xFDZIsIyyxjPUTswV841P
	1Jy+QeZYF7p3HG0g7Xb0a/Q2QTLXpZ5Cu4gXcK9WwsPFkTaadMR3vIQNdILQQ/IG
	jFrXvEZsUHa3880I6uYQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdskjha29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 16:05:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43AG5T7f022079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 16:05:29 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 10 Apr
 2024 09:05:27 -0700
Message-ID: <c128cf9b-de30-49f1-9adb-8b03b61f4d51@quicinc.com>
Date: Wed, 10 Apr 2024 09:05:26 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/16] PCI/pwrctl: add a PCI power control driver for
 power sequenced devices
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
 <20240410124628.171783-17-brgl@bgdev.pl>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240410124628.171783-17-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DT7Wv9f2L7fktC3xWXbBoB4QdMNzyLRm
X-Proofpoint-ORIG-GUID: DT7Wv9f2L7fktC3xWXbBoB4QdMNzyLRm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100117

On 4/10/2024 5:46 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a PCI power control driver that's capable of correctly powering up
> devices using the power sequencing subsystem. The first user of this
> driver is the ath11k module on QCA6390.
[...]
> +config PCI_PWRCTL_PWRSEQ
> +	tristate "PCI Power Control driver using the Power Sequencing subsystem"
> +	select POWER_SEQUENCING
> +	select PCI_PWRCTL
> +	default m if (ATH11K_PCI && ARCH_QCOM)
[...]
> +static const struct of_device_id pci_pwrctl_pwrseq_of_match[] = {
> +	{
> +		/* ATH11K in QCA6390 package. */
> +		.compatible = "pci17cb,1101",
> +		.data = "wlan",
> +	},
> +	{
> +		/* ATH12K in WCN7850 package. */
> +		.compatible = "pci17cb,1107",
> +		.data = "wlan",

since you are adding both ath11k and ath12k packages, should you update the
commit text and the config "default m if" condition to include ath12k?

/jeff

