Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FC32E786A
	for <lists+linux-pci@lfdr.de>; Wed, 30 Dec 2020 13:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgL3MHG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Dec 2020 07:07:06 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:58484 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726486AbgL3MGv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Dec 2020 07:06:51 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BUBwJrs000983;
        Wed, 30 Dec 2020 04:05:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=TcWzqyfJgk6LYAu/u4iflmlFrD/Dex+cvnsjRXtvJJA=;
 b=AGhGwPr3MR6WvWXLCE5SoDXkwxQFmCtJNBmmuPQu8F+RDI3zQVKIHw3V3pC0wRFWNKCY
 jOWksa8nxIHmrQ800WXpYNerfJjaK0ASGLwNK743PSL50eUAH2/zPgiCmmpmlB6woio/
 pTPoDK6phRLXmsKnNf+lsaji37O1PSsZcBhVi72EfIU80tV9ecaA2sN5ZQ18c+VqwJZ4
 EnW4YcYiNlkLdpTv4Vy7HkcK9LOkdhvJR4TGxj9YGWnA5y2V6DtoZiW+kxoPaIrl9tqs
 zQM2KdCWTvUC1ZHPmVeLfvPe0SfbQkM2vmyM+0vuIvzpfKiKzeEADg1K2Xc2h0mTrPxa fA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-0014ca01.pphosted.com with ESMTP id 35p2m1fh2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Dec 2020 04:05:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YL+kZGJNTCL2Pw18BNV5rL5IPFEv+xnc+lZowQ4asx24C313ENnKBLeLQn2/cW3j5Sv3ccHafM85wvEJ6zeyWc+TuhQhdDthMXnZkBf6yRUIIy9HD701GD0WyIBD9z4pxnC4YymLRSfRzWTOouELkNNbril2K05azvkwMm6StuQ/dS5AsGel784ZTCzdRGaNpDyMr2D64ua/9o2cWYTlF0U58NF1uRLhy1Ou+EaG9UtZy/xVyh/WyxAFauvCp73XLMWI/O7UmIjpmjh4vNunyGMaRCzzvxxG+At103LW0gvMLDZFjDBIlIXbpHTEG7j2CimpO+zNYdHluPJz61Ue1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcWzqyfJgk6LYAu/u4iflmlFrD/Dex+cvnsjRXtvJJA=;
 b=O8P8d4of8bN1amjh+AIW2J1KX5xcMNnDRod/EcSbuDW0fYiNCGmdx338Hx0VCfttj0GvEKkUtLqGHzst/6X69fTqqGArYlnxfNDV7oaTcEiaTuWFzgxcXu37enhRejrYiD1vZWQJokVtPGlbfO8VpbqGhbi8thwDR8m5ZigApXDDpIijKwm0jPlTZXEBcGpDWQrcIh50g3XhgIuO7t89i1kNib1Z+6ClL65ech0DjZpkc2v76XjPtsLY8zg2ZZyYdEH9r4oge1TBF+Le2eerAOr7RCSIVRO0ALEcJCj0lRkTjXA+mwQqG9kYTSXx37CsxRLll0cvtfmgn1RQ3dTdrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=google.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcWzqyfJgk6LYAu/u4iflmlFrD/Dex+cvnsjRXtvJJA=;
 b=azOQaP4u/sdZQX2jn0hLEE79lRf4Tq/CyRzKJAewZZ231RfyG2y+7f5pahLrWLqqjZgiYPjMEr1WRAQsnCigAFZIWMqbIq2XPJWjy2LyslMvfwxB8Dzd0PTaewAQQrqAMWq+EjC5dg2KQAOJKA8n73KmkhLEYtIc6Ob4xpXHi28=
Received: from DM6PR07CA0074.namprd07.prod.outlook.com (2603:10b6:5:337::7) by
 DM6PR07MB6809.namprd07.prod.outlook.com (2603:10b6:5:17c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.31; Wed, 30 Dec 2020 12:05:27 +0000
Received: from DM6NAM12FT007.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::70) by DM6PR07CA0074.outlook.office365.com
 (2603:10b6:5:337::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend
 Transport; Wed, 30 Dec 2020 12:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT007.mail.protection.outlook.com (10.13.178.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.12 via Frontend Transport; Wed, 30 Dec 2020 12:05:26 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0BUC5MCe030682
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Dec 2020 04:05:23 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 30 Dec 2020 13:05:21 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 30 Dec 2020 13:05:21 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0BUC5Ldc002398;
        Wed, 30 Dec 2020 13:05:21 +0100
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0BUC5JA6002397;
        Wed, 30 Dec 2020 13:05:19 +0100
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <kishon@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nadeem@cadence.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH v7 0/2] PCI: cadence: Retrain Link to work around Gen2
Date:   Wed, 30 Dec 2020 13:05:13 +0100
Message-ID: <20201230120515.2348-1-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0eabc87f-d997-4224-6906-08d8acbb31e1
X-MS-TrafficTypeDiagnostic: DM6PR07MB6809:
X-Microsoft-Antispam-PRVS: <DM6PR07MB680916A82F71E232AB42CC32D8D70@DM6PR07MB6809.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S1aoGZWMP6Iva/WSt4qPxVR5i+8WmfksUIs0BfS483oXB4I3Tee7DJeSHbg3FTeTGq4Xv4wq9P3aduThagUqzFUkGsXekmvvj6+zkUTTm1pIQaA2xlNcVlMm6qi9ghmxGtZ8Eif9DEDXcfpiO5fGmcM35eisXaXqZgnh5ZZbiwvKIp/wR9Vr+ELSkhUYhak2guCv814MLjFPuUvsj2A4cQ7YRhOxDq8WL5B8DPHPwGroTKrpV/ZDiqC1d5asRWYjUJqYJR4N1eBKdJJ5T9XedeIfskyRqEJvB0gAQBXxwD1wOXHkNuNuEtjEkUXqIj62hOKFreUnsyrFSkvDEKilPWQCEhChr2bGjtG7HC5iPegqWMe0/5RNQcjtoGlYV7sgQC7hORPCttX+/g9zumivySnwCG/191L+wHhedKId5O0wuzqGe3lcPlboJ56B6LtBAlrFURBo1QRhmoQEe66v6J8Y9pj/C+ifdbRPZZyqLTWJJHMPs2YEi2cBDVliVlBE
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39850400004)(36092001)(46966006)(5660300002)(426003)(70586007)(186003)(316002)(4326008)(478600001)(42186006)(356005)(82310400003)(86362001)(7636003)(70206006)(110136005)(36756003)(82740400003)(336012)(2616005)(1076003)(2906002)(107886003)(47076005)(54906003)(8936002)(26005)(83380400001)(36906005)(8676002)(6666004)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2020 12:05:26.7593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eabc87f-d997-4224-6906-08d8acbb31e1
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT007.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6809
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-30_07:2020-12-30,2020-12-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012300075
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence controller will not initiate autonomous speed change if strapped
as Gen2. The Retrain Link bit is set as quirk to enable this speed change.
Adding a quirk flag for defective IP. In future IP revisions this will not
be applicable.

Version history:
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
 drivers/pci/controller/cadence/pcie-cadence-host.c | 70 ++++++++++++++++------
 drivers/pci/controller/cadence/pcie-cadence.h      | 11 +++-
 3 files changed, 65 insertions(+), 19 deletions(-)

-- 
2.15.0

