Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1D22D781E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 15:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406351AbgLKOo7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 09:44:59 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:16398 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405723AbgLKOo1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2020 09:44:27 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BBEbhIT027452;
        Fri, 11 Dec 2020 06:42:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=f9DRWxCFqsKZQERU4C60DZdlvKytV1SYLYjdR9xq2Ss=;
 b=X6wiwZTRy3w4LyJ6ETmZFrC9omZNNzE6gf9wbik8ckrRCVF6/8BJNUtMovaEZk5ufdYN
 rYGTQo6AEzH5AGUAvaWKdb8SQrqdtwRBev5bSIDHw1re8VOYCfoQ0F5PZfBmNW5abTMv
 CAyoL5WY+n/z2tMYk4oMnkphLYyJom9ehWfmFJuPzpNjiW6huseTAxVWsnXUX3oENDUF
 p1BRWWEpak1cL8tUn838oV2/9CXGLolm3miOYIGPv+fU7JpkJ0QMXDIbKmEnPz9Ue9kQ
 8xOG8cbkQEkvoOY+HzaBrrnO64LDPhItk9SrbpwjfhnYyDoFV6ZXfD5bqnDKqeQL9iML fQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3587n35mgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 06:42:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TijZKfWX4K6krzS4cazRObBYlZfP/IUpivKm4Q61a8qKaXwGGorKg9G/4U+rvJYPQtsckWDh4ESz+Zi8vjDl8fRXeY3WVgLs852x/pzcdJTJDTcGAfXwLg8vtCtXFDdl0tSyKD9eePvrIjLBDb9gWhNk5k1jfHMp477QzSLJ1zQyGlxH3ifLNV17ijfF8w3aO18B9JmcUHAFCmJyIMX5wjJfZED013taQiNyFT8PkPNqmH9JLpLlZbeK4youbgijM99beWbMuSW3Bdhq3ZCMF2BLJt7Tw55zGLxIjEo0B1hNs9yRfegW0ksdbCAw0NlaJ8WQQU/K2avMPusoSjS5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9DRWxCFqsKZQERU4C60DZdlvKytV1SYLYjdR9xq2Ss=;
 b=dkHcBx5vJX031MHJcc524M4JzB6rg5urwDwI7Z7PEhNpcbG5nK/dPJCm9bDLlteBgnE3VK2Lh1zmo+HKpPHvRXxxsVBfBZIqOWSWfBPKpd+q+Cj2IY26Zn21/YDOxIqm4VrWLDqP/BDYodfnKs0fNdn0ixspxYXmiM69JFzvYi4M38Ykf1vm71ao6a2u95gMtfMyDK17RKHDCAqferkslXFuaHitKMlPsnUVKcC8JAixOoPRaLcAsb5aZtEgxC+edJEpNpfoEO/2LDVpParWxFUVS1O9T+LpklUAJUKcyOtoT31vmpQLJxovQSRfC9lPlhamhCqh444D5APxUY3ECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=google.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9DRWxCFqsKZQERU4C60DZdlvKytV1SYLYjdR9xq2Ss=;
 b=UYNccWMBovp2Ai+MZrBWcOWC1msdeRQ6r65g6ODkbjZAQNiQBVTPKKfw6843lqo4Bp+dr1Jydc4r1ivzxMAWmJfvQSFWVaGlQtaRTGarcmZ9hM4ZZacvM/gbkyT4oc8bUzaqSYPswvR2+N70wP1zhvzgq9Vrj6BFRgJR7dYFRuM=
Received: from BN3PR03CA0095.namprd03.prod.outlook.com (2603:10b6:400:4::13)
 by MN2PR07MB6637.namprd07.prod.outlook.com (2603:10b6:208:164::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 11 Dec
 2020 14:42:46 +0000
Received: from BN8NAM12FT059.eop-nam12.prod.protection.outlook.com
 (2603:10b6:400:4:cafe::e0) by BN3PR03CA0095.outlook.office365.com
 (2603:10b6:400:4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Fri, 11 Dec 2020 14:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT059.mail.protection.outlook.com (10.13.183.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.10 via Frontend Transport; Fri, 11 Dec 2020 14:42:45 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0BBEgg2Q007333
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 11 Dec 2020 06:42:44 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 11 Dec 2020 15:42:42 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 11 Dec 2020 15:42:42 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0BBEgfd5003890;
        Fri, 11 Dec 2020 15:42:41 +0100
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0BBEgeZR003885;
        Fri, 11 Dec 2020 15:42:40 +0100
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>, <devicetree@vger.kernel.org>
CC:     <nadeem@cadence.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH v4 0/2] PCI: cadence: Retrain Link to work around Gen2
Date:   Fri, 11 Dec 2020 15:42:34 +0100
Message-ID: <20201211144236.3825-1-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47f934f4-4107-410a-8ee3-08d89de30639
X-MS-TrafficTypeDiagnostic: MN2PR07MB6637:
X-Microsoft-Antispam-PRVS: <MN2PR07MB6637BA61DA27CE887CF501ACD8CA0@MN2PR07MB6637.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8q0fysLNU1kVkbsjjSnSdQ8rLD8ndxlQ0/wWm3mII1lY13CQjdkLvk9ddjagYRQ/D+3XNnnHXCQ5kNsMC//7MdPkfSzIgmtMeMnBGXeBcGFxoYjeFosI/PagEtEbn3ODimX2ldPaIxS6Nxfsva9rQFoFrRB/d20jYrjTkX/1Vt9PrIVqocRTnX/DS17NLwFptWV4JL9R1wTddVUt+dhAH+rp7QG1Qc1l+DO/6JhVUbVJTUT18k76RpwzcVclAao6u+McNBoz3V5jJmzGPyaxFzKKxPuPoOXddzAm80leGD0LEA8n6dx3t8T0KEaPXcSZcKhHkTqtBlnpmsXacZnWqVZ6pKlghhQrVgkcl1bJRWOZLDVTKrfgYg/nGoeHN1DYmALORy4jYHWCL+FmHEs1/A4Mb9KdjIVQi2rhcHFy9ikiq0/GtoqvWBzp/B/fre5kLQBaQq6fAW76YCd4tzrJrg==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(36092001)(46966005)(426003)(83380400001)(5660300002)(2616005)(1076003)(86362001)(36756003)(42186006)(36906005)(336012)(7636003)(4326008)(47076004)(54906003)(356005)(6666004)(8936002)(82310400003)(70586007)(508600001)(70206006)(2906002)(34020700004)(107886003)(186003)(26005)(110136005)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2020 14:42:45.9108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f934f4-4107-410a-8ee3-08d89de30639
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT059.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6637
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-11_03:2020-12-11,2020-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 clxscore=1011 phishscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012110096
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence controller will not initiate autonomous speed change if strapped as
Gen2. The Retrain Link bit is set as quirk to enable this speed change.
Adding a quirk flag based on a new compatible string. In future IP 
revisions this will not be applicable.

Version history:
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
  dt-bindings: pci: Retrain Link to work around Gen2 training defect.
  PCI: cadence: Retrain Link to work around Gen2 training defect.

 .../bindings/pci/cdns,cdns-pcie-host.yaml          |  4 +-
 drivers/pci/controller/cadence/pcie-cadence-host.c | 67 ++++++++++++++++------
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 13 +++++
 drivers/pci/controller/cadence/pcie-cadence.h      | 11 +++-
 4 files changed, 76 insertions(+), 19 deletions(-)

-- 
2.15.0

