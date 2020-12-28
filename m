Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75672E41D2
	for <lists+linux-pci@lfdr.de>; Mon, 28 Dec 2020 16:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438260AbgL1OGx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Dec 2020 09:06:53 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:42286 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438243AbgL1OGw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Dec 2020 09:06:52 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BSDxjlP024446;
        Mon, 28 Dec 2020 06:05:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=5hHljOtJnlFAaO8/lUeFxGThMVRoMQEDoJYwAmqTI5E=;
 b=R/gZ8xAcdOKhsxj3FidMw20JOc1u/ZQqahDihPTn0OWUO+DoteZZ5bnOZgsOB/PEdaUm
 Yvk+PTIz9g853/vvVJR/6Z59BY99mEhetsZZ5rBtf2fSEFBn3ncXpB+t8oQTfQU+9K/2
 c3U+GBAblbA+QBhdryepgw0bRMbnso4SIyx8idiPfa+YXKBLrGMnW95IowraLwZns1Gc
 XPFWuFEUYTgIetuGY4OeKQbBSwFyB0QIhd6q93IMmoeK2dvyGL+QOgAla+OLfwXXehGu
 IL8A1S6pgGXb91w3k+oULqVQggZZMPnUw/4zTyPaKwXvG+VVWaw/RPme0dnVz4tLdrZ4 vw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0b-0014ca01.pphosted.com with ESMTP id 35p1n43hsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Dec 2020 06:05:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2YfSHfK29fkuHQN/vufR+XldT//pk4XQgtT93OEh8qK8eQXKg4Z4o5xnazlXJcw+QAy+irLJ2uv9eo2m0q+qIw4hL8/ETtsRDNmfIFi/0xNfXscetBeNAXb8dFLu0qaw+Z3aItyLvIMZjjz7lkHv1PwH2Udbpv9hu0+1+rd532VUfAX2lifPRYyi44ENSd4FRjypr13OVffZlk2vmYvq10ZwJvUDt7uVio48cWbPEJ7iKns0Kb1FtAYkCq/T0FvQDxTtAKV70ErR2V1kwUEAYyuSYU6fN6gS1Ra7Gdyi1Ctec/ucjGoJqgrzA9ZLwpJENyHkcvUpmBizKebBuL6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hHljOtJnlFAaO8/lUeFxGThMVRoMQEDoJYwAmqTI5E=;
 b=R2cR9gA04K+1UQjQZMaw6MHc+xxPcvA/gBomsCrdKk8dTcimV7t4pt7nxBMpcXI7xtprz5rbm4d5B4BwQgrmE8Z7Uk0g1dVf5qnK/Drw+smossvB2ZpdQa4rbzqOdqZX/EfJ13cQ9DlnqJ7MLy7N9D/95nfHiy7QvFaUeCta2m9Gu/R6Qkl0AgYlqoHkjs6H+G8tjXCKT+Fih4/VBcfSgnsEfJye0DC8ll+YxS0Bqzu7ywfp5LJs8Q1NjTR3NwQ3l4APpoDK1yK5jl9o+r1CztpPxD7Aj3Gi4Zlly+37FlFP3EmT4v7XVs9MWcB2z58nNFFz5GunvpFCe+bB/xPlGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=google.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hHljOtJnlFAaO8/lUeFxGThMVRoMQEDoJYwAmqTI5E=;
 b=KHSaamopsQAVGklKqEENZDdt5YelY5c65UwK7O6FxzuxxzZkVKM3mZotKXKvCFj8CKj+ltVnqa2HzP1fT7TQLjSHSwL191O9buxZ2CSjsc5TVkixR2wczDaDQWAmkbbudGZPd425/vzLZFI8G60VhqTubQ+R92e847twVIxdoLA=
Received: from DM5PR07CA0025.namprd07.prod.outlook.com (2603:10b6:3:16::11) by
 CY4PR07MB3575.namprd07.prod.outlook.com (2603:10b6:910:7a::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.25; Mon, 28 Dec 2020 14:05:32 +0000
Received: from DM6NAM12FT022.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::64) by DM5PR07CA0025.outlook.office365.com
 (2603:10b6:3:16::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend
 Transport; Mon, 28 Dec 2020 14:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT022.mail.protection.outlook.com (10.13.179.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.20 via Frontend Transport; Mon, 28 Dec 2020 14:05:31 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0BSE5SJQ045194
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 28 Dec 2020 06:05:29 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 28 Dec 2020 15:05:27 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 28 Dec 2020 15:05:27 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0BSE5RmV014700;
        Mon, 28 Dec 2020 15:05:27 +0100
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0BSE5OQc014699;
        Mon, 28 Dec 2020 15:05:24 +0100
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <kishon@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nadeem@cadence.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH v6 0/2] PCI: cadence: Retrain Link to work around Gen2
Date:   Mon, 28 Dec 2020 15:05:08 +0100
Message-ID: <20201228140510.14641-1-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a14a07d7-5dae-4ebc-b92e-08d8ab39a370
X-MS-TrafficTypeDiagnostic: CY4PR07MB3575:
X-Microsoft-Antispam-PRVS: <CY4PR07MB3575F25F05847E8B89B11581D8D90@CY4PR07MB3575.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1mB0SHJ0wWPzhckzyguezMpHPzDFN1gjzy0rN8aE+XIGme/TcFilsBrmITnstJnqeUl1g5aLcM3qizbqT5SVX3VWZSi207jPqZ0ELZbcGRKW12dCxKFZWZaCUgLhhybSGulfsbLnasohSKuqZVEs/4j8YTiU+l5AJQK1YqyPaBnRoa5HS+GaWNeDZlJb3V6Fu3uPhcVsSITiJMT+C/eS8xjJ+v0HdXgrMxwta86VvI8EsOKYftqhIa35/UREkZJaLZ2LV6ELdqD4p+57xkJi+Opj72GE120xuq/cc6PhK6hPChiSNGPWjdfz4uxeYnUB3v4cP0OCpBuoKkFAh3R2cEkhln1Y++qFzaWdiHqqwm47Mv80EQleybDfOthFj0I9w0hEb1Yi/3UdxD/L/TlER/Cua4uCQoETp2XysoVq39O9kH5lcPi3x0kpwJ610LOEci3xPCliOV/Of0kfeL+9h7d9QTIeGxyg3bOGkjcU/HhCxDvFNj/b2c3v/dNFKlQK
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(36092001)(46966006)(110136005)(36906005)(186003)(81166007)(82740400003)(8676002)(26005)(8936002)(36756003)(107886003)(336012)(6666004)(426003)(356005)(2906002)(5660300002)(1076003)(4326008)(82310400003)(83380400001)(54906003)(2616005)(42186006)(70586007)(47076005)(86362001)(478600001)(316002)(70206006)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2020 14:05:31.5435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a14a07d7-5dae-4ebc-b92e-08d8ab39a370
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT022.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3575
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-28_11:2020-12-28,2020-12-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=934 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012280088
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence controller will not initiate autonomous speed change if strapped 
as Gen2. The Retrain Link bit is set as quirk to enable this speed change.
Adding a quirk flag for defective IP. In future IP revisions this will not
be applicable.

Version history:
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
  PCI: cadence: Retrain Link to work around Gen2 training defect.
  PCI: cadence: Retrain Link to work around Gen2 training defect.

 drivers/pci/controller/cadence/pci-j721e.c         |  3 +
 drivers/pci/controller/cadence/pcie-cadence-host.c | 65 ++++++++++++++++------
 drivers/pci/controller/cadence/pcie-cadence.h      | 11 +++-
 3 files changed, 61 insertions(+), 18 deletions(-)

-- 
2.15.0

