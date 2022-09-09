Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1614B5B3211
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 10:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiIIIpW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 04:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiIIIpV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 04:45:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D74AC697A;
        Fri,  9 Sep 2022 01:45:18 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2898Ztg1031313;
        Fri, 9 Sep 2022 08:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=7ebOkA5Aq2pbAoiAYKlzrhx2KdUocxzrKX3dIDQrmOE=;
 b=U7+sEdDowU1ikyU1G/kAgaaLdCB3MX/sHk8uw2EeUA3SZoHczcf8zgdhBevAUQKUWrtX
 Knm00Ko3CkI/y2xBfxPZ61JAIttcU1gN4cewPNQ2rQJioKOlSqubnKQmhgNI7JrbsnHj
 1uVgdYiodXuqIoB4uuWUBot4hFTb8GvFoxunWtsFXx3PE1PuMIOIwrFnIKzimF/fUerL
 Ds0JR8LnlG/UWOx8ExGYgliOmgJRhzNoGGV8BD0BlwVUEqVdNWPOhGgHYsOLWXHGPUHH
 PJ6V5lQJyWMPvilniVAwGgtxMou5f9GeVn3rYRpi8+Th/0pOAgE2ZkpCTOMMVwd/FqKU cw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jf8514u3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 08:45:14 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2898j4Dx014219;
        Fri, 9 Sep 2022 08:45:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3jc00m8vpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 09 Sep 2022 08:45:04 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2898iqem013918;
        Fri, 9 Sep 2022 08:45:04 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2898j4GH014196;
        Fri, 09 Sep 2022 08:45:04 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 4D74A44A6; Fri,  9 Sep 2022 14:15:03 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v6 0/5] PCI: qcom: Add system suspend & resume support
Date:   Fri,  9 Sep 2022 14:14:39 +0530
Message-Id: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TbLfsAV7DORAMglmZT6oOP27IdlWqycL
X-Proofpoint-ORIG-GUID: TbLfsAV7DORAMglmZT6oOP27IdlWqycL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_04,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxlogscore=704 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090030
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add suspend and resume syscore ops.

When system suspends, and if the link is in L1ss, disable the clocks
and power down the phy so that system enters into low power state by
parking link in L1ss to save the maximum power. And when the system
resumes, enable the clocks back and power on phy if they are disabled
in the suspend path.

we are doing this only when link is in l1ss but not in L2/L3 as
nowhere we are forcing link to L2/L3 by sending PME turn off.

is_suspended flag indicates if the clocks are disabled in the suspend
path or not.

There is access to Ep PCIe space to mask MSI/MSIX after pm suspend ops
(getting hit by affinity changes while making CPUs offline during suspend,
this will happen after devices are suspended (all phases of suspend ops)).
When registered with pm ops there is a crash due to un-clocked access,
as in the pm suspend op clocks are disabled. So, registering with syscore
ops which will called after making CPUs offline.

Make GDSC always on to ensure controller and its dependent clocks
won't go down during system suspend.

Krishna chaitanya chundru (5):
  PCI: qcom: Add system suspend and resume support
  PCI: qcom: Add retry logic for link to be stable in L1ss
  phy: core: Add support for phy power down & power up
  phy: qcom: Add power down/up callbacks to pcie phy
  clk: qcom: Alwaya on pcie gdsc

 drivers/clk/qcom/gcc-sc7280.c            |   2 +-
 drivers/pci/controller/dwc/pcie-qcom.c   | 156 ++++++++++++++++++++++++++++++-
 drivers/phy/phy-core.c                   |  30 ++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c |  50 ++++++++++
 include/linux/phy/phy.h                  |  20 ++++
 5 files changed, 256 insertions(+), 2 deletions(-)

-- 
2.7.4

