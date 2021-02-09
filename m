Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455163151FA
	for <lists+linux-pci@lfdr.de>; Tue,  9 Feb 2021 15:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhBIOr7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 09:47:59 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:50326 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232274AbhBIOrr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2021 09:47:47 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119EbpAb014146;
        Tue, 9 Feb 2021 06:46:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=LuW1n95X1tMZQ0ICeIVYUEVmB38v55X0tSFtqUvQqLc=;
 b=kKkR8B5IZJM71cHBLQ6xQDNGigr/pBNVzppIbEUQASiNKg3q/c/42VX+Pa9Y7T7thxfM
 ZIg3tUEmHnOmGyk3Oi21+dKvM9JjG9RfF/78lAHCQei9mGW4ciyBHSap961qTDkAmv1Z
 zxEMJTlIumXppjve6dvjtGXBAEtjEeviookix2AQYTz0ENfw+9Gn+zhZEprScUUTJQZ8
 decCWgbftJ2hJ3g/xqSpbWrK+dvPpsusGnQEJ9FWN7SDtwd8ORU7onX2axHLDfOAVipP
 x6sfhY0sSd7RrIQ8hh2lJjHDVaaXLPSLxa0K4n6e5GGAoisUVvzvAatsJHtdDqOd5W9J Cg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 36hrku0ng5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 06:46:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lajtwIheZFj324Q62uz1wmwk8Dgpsy4vbYLo6idYraZVet/v0NjoylybOxE1EeHHh+BfEyTnG3Z4sK1SLclPhnmXWYZGMnczLbl07vbXbv2MskD+T/+qsEg76MlztEjq6Nf3TM+K5EL/ajzMYOm34KsudnuBoHTOy9v4rBUYzoLIfsj7hFL+flBBo0GGapfsBby4ZBHuJCBTXepUVaOgrCrzzSw0BS/bNuLpunzf6h+4PDd1BjSg+iQpV2fVCle6TN9BPp7kk82YeucHCo58Jfvj5CdeLgn4WpX37XnRstsiYw4qPt3S7WQ3s8Ebz+3BW8khnt7DFP/fusjDQw7INw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuW1n95X1tMZQ0ICeIVYUEVmB38v55X0tSFtqUvQqLc=;
 b=Mk5r19vKLFUW4B82ULIU5tczPeOSaWcrWRXlmrPlm9Ag8DgG4NaLE6J8S25dWMhhPCPMBU00OlJEcSnh79sivPWy8GN29LPqyQn4PcgXQJrY2TKA2+DytPKb2W7CU/WX1E0oB1mjs9KNMcYYOujzfTQecPpqOYTtX6JO3Frpo/8ZtxTd0mx40Q4RTC8Kb8U4MUh69qR4yqYaZiRPDDY02ZerQsBaUWhR4g9DnxspcoC2m2R+xtAnlW/HrsxEn67MsK8bz5ogVbY5l4LzFvV6ZiJiMLcR+a+O0Rvaoh5q7xrdMBiD3gRMQCy25cJCRRhWG/JhoJPlnBGCgDw0JxpB5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=google.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuW1n95X1tMZQ0ICeIVYUEVmB38v55X0tSFtqUvQqLc=;
 b=BHs5/SSnrufLz10twT9C78WAlbIbHGosg5CTkSXML9pXvqv/x/Qx10ZsHj3kTRly+0+Lz9MA4tVZj9HzRTl3SuTrl/BhGkxYTs95InmpBew2N5spib9gy3+0dNzsTH/yYVqPhY2Y2qv04+ze3QcO6INiqQwj5HTYCGRoj5hY7v8=
Received: from BN9PR03CA0193.namprd03.prod.outlook.com (2603:10b6:408:f9::18)
 by BLAPR07MB7633.namprd07.prod.outlook.com (2603:10b6:208:298::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27; Tue, 9 Feb
 2021 14:46:33 +0000
Received: from BN8NAM12FT036.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::3c) by BN9PR03CA0193.outlook.office365.com
 (2603:10b6:408:f9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Tue, 9 Feb 2021 14:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT036.mail.protection.outlook.com (10.13.182.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Tue, 9 Feb 2021 14:46:31 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 119EkRwF001420
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 9 Feb 2021 06:46:29 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 9 Feb 2021 15:46:26 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 9 Feb 2021 15:46:26 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 119EkQe1026748;
        Tue, 9 Feb 2021 15:46:26 +0100
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 119EkPvI026742;
        Tue, 9 Feb 2021 15:46:25 +0100
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>
CC:     <nadeem@cadence.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH v8 0/2] PCI: cadence: Retrain Link to work around Gen2
Date:   Tue, 9 Feb 2021 15:46:20 +0100
Message-ID: <20210209144622.26683-1-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15b32a4a-0563-4064-d324-08d8cd097db8
X-MS-TrafficTypeDiagnostic: BLAPR07MB7633:
X-Microsoft-Antispam-PRVS: <BLAPR07MB763381ACA1B1884366DEC602D88E9@BLAPR07MB7633.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vvSaz+DGZKJhQ3G2tLAuLfJbCdrECn8Dx8erKVkkjEBjOyhig0l6ikD5MKWJbxHQDieqQo1z9R4HMQZjcyF6x6PdSl1pXyygVFaSGrwyIsgJkaAI7TbdjrxWSa0by3t3VbzWiVH7/vyKlmmfQly4eBYSCQOQTSae59LAzDm93WJFC1MNf2sEQDSQ2LhS7wEykh1R7aVOhkHLmqDge2hrhhcrUI+tCN7uCocNnn4L3m4RlmZZZFAXtJKcdjgQdVAuFIVVwybitN33bDBP/uSeLXv2nCNMwyI64UT1TZxJkF1Vr/sxf5KxueCJHjGS7YmfmgLJghPzcPXZXWig1/MLHKdfEuSda2kdV1AnyX1tl1q7uS/4s8Pnmabh5J3YlmOrMdAx/Ers/MWqrAbUvKqokTFnlDXwoF2/vZUErHWv8P7+O3H5zWJdP3iD3SA4L9tnsiLPJwbKWVpi49aKWR7cvFFREb3jYKx8ssLJBQS3+M0w6rSCDbR2UAr2xzcZQLqvcobfw7lz1T18k1Uv21aJdjPlsSPhL0LV74WKhrPUo38FOGedu0ZSVWt1uBawjxf6VntuRlIX2bPhkQGmKRwomD7hnr4RlClofp0ST/XHUyZKI9ZpPuO3BUKOMzPxbgp7W8VA0qJNGENqtRnH/5KDv2Wlp9Ft7YrnbRyn5XRrlYm4wFrjOp+mLBaO496itRXJiAPm5A26hg+xfyz6GbkwoSayIWxlj+ZYB/5Ev5ZzNZD7/fVcpm0R+lcKXRddEaKq
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(36092001)(36840700001)(46966006)(316002)(36860700001)(5660300002)(478600001)(1076003)(54906003)(4326008)(2616005)(34020700004)(186003)(36906005)(36756003)(47076005)(70586007)(86362001)(110136005)(2906002)(8676002)(26005)(82310400003)(83380400001)(356005)(6666004)(426003)(42186006)(8936002)(81166007)(336012)(70206006)(107886003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 14:46:31.9120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b32a4a-0563-4064-d324-08d8cd097db8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT036.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB7633
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_03:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=965
 lowpriorityscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102090076
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence controller will not initiate autonomous speed change if strapped
as Gen2. The Retrain Link bit is set as quirk to enable this speed change.
Adding a quirk flag for defective IP. In future IP revisions this will not
be applicable.

Version history:
Changes in v8:
- Adding a new function cdns_pcie_host_start_link().
Changes in v7:
- Changing the commit title of patch 1 in this series.
- Added a return value for function cdns_pcie_retrain().
Changes in v6:
- Move the position of function cdns_pcie_host_wait_for_link to remove
  compilation error. No changes in code. Separate patch for this.
Changes in v5:
- Remove the compatible string based setting of quirk flag.
- Removed additional Link Up Check
- Removed quirk from pcie-cadence-plat.c and added in pci-j721e.c
Changes in v4:
- Added a quirk flag based on a new compatible string.
- Change of api for link up: cdns_pcie_host_wait_for_link().
Changes in v3:
- To set retrain link bit,checking device capability & link status.
- 32bit read in place of 8bit.
- Minor correction in patch comment.
- Change in variable & macro name.
Changes in v2:
- 16bit read in place of 8bit.

Nadeem Athani (2):
  PCI: cadence: Shifting of a function to support new code.
  PCI: cadence: Retrain Link to work around Gen2 training defect.

 drivers/pci/controller/cadence/pci-j721e.c         |  3 +
 drivers/pci/controller/cadence/pcie-cadence-host.c | 81 +++++++++++++++++-----
 drivers/pci/controller/cadence/pcie-cadence.h      | 11 ++-
 3 files changed, 76 insertions(+), 19 deletions(-)

-- 
2.15.0

