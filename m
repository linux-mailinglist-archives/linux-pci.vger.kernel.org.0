Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDEA5BE303
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 12:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiITKW6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 06:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiITKWz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 06:22:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5C76DF83;
        Tue, 20 Sep 2022 03:22:54 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K804gS013233;
        Tue, 20 Sep 2022 10:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=mH6Fwz3K30BlKk2TJCtxVla2r992cpTUFjl1FsBUztU=;
 b=ZxqwOM7D+fTg/0ff4SiN3dJwpez5HttRrbSvCgx0MGSyrU8EQIbOcuDbXfMB0bxwyL1C
 O1CfwEmf02/GLn8tO/AFVWIHtdFhclf6xuTfBDRKMjWXpOYSuf2b4X/Jqle2q4IA6xD8
 zCwKBB3ffeZu5h68iebg5kfV4ETMG+q03BSS7F6vqQeo2SMCwl8gVZX7yFpnIS39LS9q
 YFJr9RPdoJand1+yOTJw9vtxbFUwcvhk65gSxy7Hhak4tTQn/Uhx90a2axF7K0lPpw3f
 1pGbp2iM9i2PhiRoOwSJpgRtQsMqUI23KyWHBxACeL9Pr2E2FRJYrtyhHmz2UXDseSVT YA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jpvahjss7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:22:34 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28KAMUpu016172;
        Tue, 20 Sep 2022 10:22:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3jnqrbnbqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Sep 2022 10:22:30 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28KAMUnB016153;
        Tue, 20 Sep 2022 10:22:30 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 28KAMTkK016147;
        Tue, 20 Sep 2022 10:22:30 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id EAD2B19F4; Tue, 20 Sep 2022 15:52:28 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        svarbanov@mm-sol.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-phy@lists.infradead.org, vkoul@kernel.org, kishon@ti.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v7 0/5] PCI: qcom: Add system suspend & resume support
Date:   Tue, 20 Sep 2022 15:52:22 +0530
Message-Id: <1663669347-29308-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tpr95SO5zlUUUhoZMHUx5re_yGPDoMYK
X-Proofpoint-GUID: tpr95SO5zlUUUhoZMHUx5re_yGPDoMYK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=953 clxscore=1015 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209200062
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Few PCIe endpoints like NVMe and WLANs are always expecting the device
to be in D0 state and the link to be active (or in l1ss) all the
time (including in S3 state).

This patch series adds this support for allowing the system to enter
S3 state (and further low power states) with PCIe Device being in D0
state and with link being in l1ss on qcom platforms.

And to get to the lowest power state on Qcom SoC, all the clocks need
to be voted off. Since PCIe clocks are managed by qcom platform driver,
this logic was added to the qcom platform driver.

And when we turn off PCIe PHY-specific clocks, PHY may go off and along
with it the link also will go down. To retain, the link state in l1ss with
PHY clocks turned off, we need park PCIe PHY in the power-down state so
that it can maintain the link state in l1ss with the help of the always-on
power domain (aka MX).
To support this PHY Power-down state PHY driver has been updated with new
interface APIs.

Its observed that access to Ep PCIe space to mask MSI/MSIX is happening at
the very late stage of suspend path (access by affinity changes while
making CPUs offline during suspend, this will happen after devices are
suspended (after all phases of suspend ops)). If we turn off clocks in any
PM callback, afterwards running into crashes due to un-clocked access due
to above mentioned MSI/MSIx access. So, we are making use of syscore
framework to turn off the PCIe clocks which will be called after making
CPUs offline.

During this process, The controller should remain powered on. For this made
changes to GDSC. 

Few endpoints are taking time more time to settle the link in L1ss.
So Waiting for max time of 200ms for the link to be stable in L1ss.

Krishna chaitanya chundru (5):
  PCI: qcom: Add system suspend and resume support
  PCI: qcom: Add retry logic for link to be stable in L1ss
  phy: core: Add support for phy suspend & resume
  phy: qcom: Add power suspend & resume callbacks to pcie phy
  clk: qcom: Enabling PCIe GDSC retention

 drivers/clk/qcom/gcc-sc7280.c            |   2 +-
 drivers/pci/controller/dwc/pcie-qcom.c   | 163 ++++++++++++++++++++++++++++++-
 drivers/phy/phy-core.c                   |  30 ++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c |  50 ++++++++++
 include/linux/phy/phy.h                  |  20 ++++
 5 files changed, 263 insertions(+), 2 deletions(-)

-- 
2.7.4

