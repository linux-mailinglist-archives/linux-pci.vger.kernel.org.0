Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4097982BD
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 08:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242183AbjIHGyM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 02:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjIHGyL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 02:54:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E7F19AE;
        Thu,  7 Sep 2023 23:54:07 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3885UNQM029550;
        Fri, 8 Sep 2023 06:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=WtSrmTvqvjuRg3aiOd2xtgKf2FBA3IbNf1R2PJblSPs=;
 b=QC5oHhHUODlkGOU8YbHdWCMxaQnQDEge6LrKPqr8LTo+D1lQQUpUDnldJ/qfcvqhN3qa
 5Z0Dd8j/Da/oF3jyKqkrg5cZ6QJhlwNSICnZpxbNd/AW/m/7LZFVcXyXHwo+avQXWBu/
 orcOmJM8r6Z3BXi/mP154pP2KUVNO56FxFcpu81qFOoySnZ6b0h1XgjNZKhA6i1vovOm
 iR882+iGw7bFO/zyL12pqv41crVjZKS0uQbBP1Y/FSgnS9/UKjgmVgQJP8nOMfPeGSfU
 TTODqmjuqmbXmZR8UnoSk9VWRk8kkbowg9lpku2CBrtedIGYnPt5pAaviCiZPD+ysiPb BA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3syk9ns8ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 06:53:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3886rut6025697
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 06:53:56 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 7 Sep 2023 23:53:52 -0700
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v6 0/4] PCI: endpoint: add D-state change notifier support
Date:   Fri, 8 Sep 2023 12:23:34 +0530
Message-ID: <20230908-dstate_change-v6-0-b414a6edd765@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO7E+mQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHQUlJIzE
 vPSU3UzU4B8JSMDI2MDSwNz3ZTiksSS1HioZJJRalKiRVJqormhhRJQT0FRalpmBdi86NjaWgC
 xUVzSXwAAAA==
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694156032; l=1570;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=Tmd0F65PbOPi6tmLoLbCsSjBMitm8wXzFUFJFAC+pNE=;
 b=HUbCGyawxgPi6wGvIbH7ojs/F+yMqJEuvP4YMjScs2oQrWZ7alCs3/Fd2R5ZKBnewxHSSQk5U
 INyBomSfpPaCrK90wyGPHxpDFWW24O6xGLMibBMqAuJZHibChSCyk+A
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: h1n0wqdDprzOxmosZeX2pWwV4ULx__jn
X-Proofpoint-GUID: h1n0wqdDprzOxmosZeX2pWwV4ULx__jn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1011
 suspectscore=0 mlxlogscore=717 mlxscore=0 priorityscore=1501 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In this series we added support to nofity the EPF driver whenever there
is change in the D-state if the EPF driver registered for it.

This series needed by the following series for epf driver to know whether
link is in D3Cold or D3hot to wake the host ('PCI: EPC: Add support to
wake up host from D3 states')
https://lore.kernel.org/linux-pci/1690952359-8625-4-git-send-email-quic_krichai@quicinc.com/T/

Changes from v5:
	- Fixed compilation errors & removed checks in the dstate_notify()
	  function as suggested by bjorn.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Krishna chaitanya chundru (4):
      PCI: endpoint: Add D-state change notifier support
      PCI: qcom-ep: Add support for D-state change notification
      PCI: qcom-ep: Print D-state name to distinguish D3hot/D3cold
      PCI: epf-mhi: Add support for handling D-state notify from EPC

 Documentation/PCI/endpoint/pci-endpoint.rst  |  4 ++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c    | 10 ++++++++--
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 11 +++++++++++
 drivers/pci/endpoint/pci-epc-core.c          | 24 ++++++++++++++++++++++++
 include/linux/mhi_ep.h                       |  3 +++
 include/linux/pci-epc.h                      |  1 +
 include/linux/pci-epf.h                      |  2 ++
 7 files changed, 53 insertions(+), 2 deletions(-)
---
base-commit: cd76a0897a67d2e70effd0f5d411792e2d6896c6
change-id: 20230907-dstate_change-b2eba8bea718

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>

