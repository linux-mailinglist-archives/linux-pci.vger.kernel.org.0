Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E2E69A75F
	for <lists+linux-pci@lfdr.de>; Fri, 17 Feb 2023 09:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjBQIsm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Feb 2023 03:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjBQIsj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2023 03:48:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A641F604F0;
        Fri, 17 Feb 2023 00:48:26 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H63KTZ014637;
        Fri, 17 Feb 2023 08:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=33eDyuvYJVBHbnCO5NSYD6X2R8vEOym0xz2B1IWSiNg=;
 b=OIzwO8AxZ1YEu1WVQkroLorCRDoyjaojbAzbQTYgUPPpqLFaxp4ghkZ9IX/VogWDw7qH
 yTKGdlOVi6ylU2qBDFvH7PeLyo+QW7Xc2ss0akTBlH5SVw6c8EhiuCLsDXSwfm+S5M7T
 f5ph1fTyguTQKzyO3leW+qksSnT8+1VJubAYzrHZdRTrPcQBBcTXwUWsVP2fcGqyBdbB
 83qiq7ls4+U69wb4NijORuMQQCt3u2KHt3zRewnZE2DTzCYw0SK9tUqyzW+aaQsjDyzf
 vyPvIo1Vgh15nhK5x9zYP83dh8+VEs4fDveRVNHW7kPuSiycyVJNbfcDw1jkBEbfci6K bg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nt10u0v06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 08:48:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31H8mFVp000693
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 08:48:15 GMT
Received: from [10.216.47.237] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 17 Feb
 2023 00:48:06 -0800
Message-ID: <a987fc17-3924-7ece-59e2-3fa1d000afc1@quicinc.com>
Date:   Fri, 17 Feb 2023 14:18:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/7] Add PCIe support for IPQ9574
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mani@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20230214164135.17039-1-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SkGcIu3rfLWbX5OreuJ1hWeFzovxmJIH
X-Proofpoint-GUID: SkGcIu3rfLWbX5OreuJ1hWeFzovxmJIH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_04,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 adultscore=0 mlxlogscore=693 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170078
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/14/2023 10:11 PM, Devi Priya wrote:
> PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
> are found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane
> Gen3 host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
> 
> This series adds support for enabling the same
> 


<svarbanov@mm-sol.com>  --> This is bouncing, please remove it

Regards,
  Sricharan
