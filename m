Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F326D68A9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 18:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjDDQXm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 12:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDDQXk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 12:23:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB80D198
        for <linux-pci@vger.kernel.org>; Tue,  4 Apr 2023 09:23:39 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334DwKrp032604;
        Tue, 4 Apr 2023 16:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pXKasqGJAPatU89Nox019djod6UryfNEhumm0yoXgyM=;
 b=eVp0fd5wpq5PWSOnHUq7UZoRSXHUDuSAJekEkW8FOp+ZoKxw/PXx6cXq7Sq01XoBMyS4
 /IP32JbLHY7iGHFL7/iT7MtDn+8uUzwGyHN/zhqs6OFqyHtpATeOunJ/gW2c/paIiMD+
 3igNtF8wttZ+9L/6M0A+xTKXfIhuq29uGEteKy6cOlm0u0uc0VPe0z4hzfh99TeAWipO
 qtrg01Apvhrd+SHpubmjOHqwn2h7UKUwO+JmqPwHFKXFV6Wg3GAsz24BM3qLTZopbB1M
 qlnQADdErhGdEqJUSyVCCS1a3XzxFUdHaKhQlR3IbhPTTO3b+Gm0UbxNVC2+XKJEmH5T RQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prn8b0exw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 16:23:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 334GNWQ0030397
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Apr 2023 16:23:32 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 4 Apr 2023
 09:23:32 -0700
Message-ID: <36e100b0-c9ac-b07e-f27b-36960164da4b@quicinc.com>
Date:   Tue, 4 Apr 2023 10:23:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] accel/ivpu: Remove D3hot delay for Meteorlake
Content-Language: en-US
To:     Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>
CC:     Oded Gabbay <ogabbay@kernel.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>,
        Karol Wachowski <karol.wachowski@linux.intel.com>
References: <20230403121545.2995279-1-stanislaw.gruszka@linux.intel.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230403121545.2995279-1-stanislaw.gruszka@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NRCnPlwJythnnKJ-AhXt4pLE_6xzhVzt
X-Proofpoint-ORIG-GUID: NRCnPlwJythnnKJ-AhXt4pLE_6xzhVzt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_08,2023-04-04_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=769 impostorscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040151
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/3/2023 6:15 AM, Stanislaw Gruszka wrote:
> From: Karol Wachowski <karol.wachowski@linux.intel.com>
> 
> VPU on MTL has hardware optimizations and does not require 10ms
> D0 - D3hot transition delay imposed by PCI specification (PCIe
> r6.0, sec 5.9.) .
> 
> The delay removal is traditionally done by adding PCI ID to
> quirk_remove_d3hot_delay() in drivers/pci/quirks.c . But since
> we do not need that optimization before driver probe and we
> can better specify in the ivpu driver on what (future) hardware
> use the optimization, we do not use quirk_remove_d3hot_delay()
> for that.
> 
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
