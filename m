Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13AA588B2D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Aug 2022 13:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiHCL3L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Aug 2022 07:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbiHCL3J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Aug 2022 07:29:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB7B357C3;
        Wed,  3 Aug 2022 04:29:06 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273Awv2w025786;
        Wed, 3 Aug 2022 11:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=apAJC9A1P4zDZZhOp4LM7NtUEQKsAgXOLw893NJkRig=;
 b=WG/8/is7UNuWpvhyuyOEZK/gSNXF3d5jyBbdX/ywjSoTmndb0jgIFYxAToJHW6D2Nmpb
 v0/NCDzTdI3j4R5Fn/wy32jUBYN+eBgw2OINBNNm85EWESezz5s1Yiy4we0j2r+Om0kV
 ArwUXrPrGvHFpyl/x4UVvQMu1FoBl1zSFxacgqOnlj78f/DD25JB2UeEdZAKEhfP0dht
 UgN0Ta222Mb37bFQPUgFGOzjHwotBBWcfVZciWqe9wsI3ZnvVWFIch6NLaTKjXU3PUTf
 FRkgKs9cwjFR0chnyxgtBak+ZkqX1w0J9zV7MTqS/L+2br667Nv7s1EUiOdIDbEzfn69 kQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hqev411ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 11:29:03 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 273BSwMC023584;
        Wed, 3 Aug 2022 11:28:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3hmwqkd7d8-1;
        Wed, 03 Aug 2022 11:28:58 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 273BSwsL023564;
        Wed, 3 Aug 2022 11:28:58 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 273BSwfH023559;
        Wed, 03 Aug 2022 11:28:58 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 6E16141BE; Wed,  3 Aug 2022 16:58:57 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v5 0/3] PCI: Restrict pci transactions after pci suspend
Date:   Wed,  3 Aug 2022 16:58:51 +0530
Message-Id: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4It0i_2UFOMb7dbzcS1xEfH7a397He8Z
X-Proofpoint-ORIG-GUID: 4It0i_2UFOMb7dbzcS1xEfH7a397He8Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=788 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208030050
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the endpoint device state is D0 and irq's are not freed, then
kernel try to mask interrupts in system suspend path by writing in to
the vector table (for MSIX interrupts) and config space (for MSI's).

These transactions are initiated in the pm suspend after pcie clocks got
disabled as part of platform driver pm  suspend call. Due to it, these
transactions are resulting in un-clocked access and eventually to crashes.

So added a logic in qcom driver to restrict these unclocked access.
And updated the logic to check the link state before masking
or unmasking the interrupts.

And some devices are taking time to settle the link in L1ss, so added a
retry logic in the suspend ops.

Krishna chaitanya chundru (3):
  PCI: qcom: Add system PM support
  PCI: qcom: Restrict pci transactions after pci suspend
  PCI: qcom: Add retry logic for link to be stable in L1ss

 drivers/pci/controller/dwc/pcie-designware-host.c |  14 ++-
 drivers/pci/controller/dwc/pcie-qcom.c            | 117 +++++++++++++++++++++-
 2 files changed, 127 insertions(+), 4 deletions(-)

-- 
2.7.4

