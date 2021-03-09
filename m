Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6312C331FE2
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 08:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhCIHcT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Mar 2021 02:32:19 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:31018 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230399AbhCIHb6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Mar 2021 02:31:58 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1297UBpk014277;
        Mon, 8 Mar 2021 23:31:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=IpeZvANEmfEcmxT07lfpfzXeoHblPUYFo9Id8QIOYWw=;
 b=XI7ChxWF5/fjbdUmC/QdFOsVawhVGC5+GFD4PJUYq5OibOiT3N9te4LCZCckjKDq1Khb
 myGTXCZFp9f/UWBELyNmbHBPfsxulBDClGZXUJM5VszG85b4C5f6rali8fYr+djVFuXN
 ZaC7CKT6IBV9+LYCB5Fl9j3cp+NBpZAmHC9LW4tuO9mndYeQBp+jwNC5iI6JQ3HjNKBM
 7GXZiLwgJmQlSXdev+DLjRsvtChMcSQMppUR7DfwdRNNF7DsV8o0siMYZvplueQM1a0K
 AqLqW7Z/UARP8aJv3OEVY5er1IlV4gMabhJMF77l3r7FjkOkHItQYRJIh4tWt7gob/dO sg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0b-0014ca01.pphosted.com with ESMTP id 374674yyfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 23:31:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oW3Se5od4+gFIecX2cQx19YC1k5+hxwOg5iH7ppElzQrFJtbXKtQs7BxxYy6N9zOIsrSEWUOH7+QW3v3ppBaPwk/SJ+ZiQeFxP3ONEyeVO1HsvwRvDhm4FqTPXXtccCwBSHPh4FbQqHJMxoiVJ9FNAwg6XmbkMoMoEwQJpwUwwM/vjFtQIRbANt+vKWKux7Ef6huoGBiQkckziwPDedT6bnS7BsGDVoQPBZOhEQ/X+nA2uIWRCAAnQgV7WhSdpq+QAwb2w/DHIh3SxISWAvhR5+KagyUucj1R30M8lyuIaPXGrQ/OteORell/ufp8nOafv/2q1Zv0iYKnRM1DCyFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpeZvANEmfEcmxT07lfpfzXeoHblPUYFo9Id8QIOYWw=;
 b=Dq3gDFQTPBvGUdrxPmGbVXLVdJPKtZIhxN5AaOIG04EKlvj+GfUlTaVfqgsyfHREuRD5sJyTdIlrYYsj0hEEtYSO7KBKl8SYrseeAp6HR3B635GfFQu58TkH6zqHwyBhffAvomPCOz5e/04WlljJTR/cYw5GIebk/UQBf7VMmgT/x5dqQK7qmvCP4EcMTo0G3kuJOm81kO6XjItew7bnYwjU4Z9oV+mQ1qaONzj5xP5hls1VTPuefq0qQpEEQHsBwyUrzJNjiD0EcpnjH37gBF7RDaagu5/RJNwOvnpNfEMAGIl7KcBbw5TVIoSNJKTRiYrge/rZIH7XuCIRVOx37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpeZvANEmfEcmxT07lfpfzXeoHblPUYFo9Id8QIOYWw=;
 b=rmhJlzi5ux1B9N7BlFZPa7l6bI7NQaST2VBSGGsDPg1frceKe5euoZf6dgnpEWM+Fmh0bF5o12gniReQqn4LH693UA/jhEWRIfMgKIZVX7K5/l9JeazAPN7S5ZYozRGHC/uSoOtXRG1tXTIclN7m7eP/JkcXglqec2/swgimZB0=
Received: from DM5PR10CA0007.namprd10.prod.outlook.com (2603:10b6:4:2::17) by
 DS7PR07MB7800.namprd07.prod.outlook.com (2603:10b6:5:2c9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23; Tue, 9 Mar 2021 07:31:47 +0000
Received: from DM6NAM12FT037.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::15) by DM5PR10CA0007.outlook.office365.com
 (2603:10b6:4:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Tue, 9 Mar 2021 07:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT037.mail.protection.outlook.com (10.13.179.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.16 via Frontend Transport; Tue, 9 Mar 2021 07:31:47 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1297Vi7r003118
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 02:31:45 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Mar 2021 08:31:44 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 9 Mar 2021 08:31:44 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1297VixW013274;
        Tue, 9 Mar 2021 08:31:44 +0100
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1297ViAm013273;
        Tue, 9 Mar 2021 08:31:44 +0100
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <kishon@ti.com>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <nadeem@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH 0/2] PCI: cadence: Set LTSSM Detect.Quiet state delay.
Date:   Tue, 9 Mar 2021 08:31:40 +0100
Message-ID: <20210309073142.13219-1-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b500ee6-a411-4a31-1760-08d8e2cd65ed
X-MS-TrafficTypeDiagnostic: DS7PR07MB7800:
X-Microsoft-Antispam-PRVS: <DS7PR07MB780042667EBEBEF515975E42D8929@DS7PR07MB7800.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HkKtqD6uZcrWkSxuHQuCra39SYI7vYke8lZq3hFwwDg6SpHk2/wLm5XbWA6kDCflgG2NTlpYSZx4TQcyV81XtPJ7+A4cNm0DW5y1xcp+FlWuLVsMaKjxU1bC5AGfvhIoUrxGnpRkSJ/zmcEFvWAK+HdscwL/AVBOfdo//uu8GY39Smq8nC5xuMiTeXuGzjclrduIM/k7cd/1wLWIMoFDAPNm5U5h3ZL4Jm43NM8D19do5YZu2nsg5xHCo5INqb/vrO49LlpEqEPCSWI0kRsGltZsxCgnFE18dyvWesykURUSmrMQimI0f6psYsfjFXGjAyMc3Fby55JcvzLa7MbV4/p/Ir5zoBzd94HJjNreDb5+KydLGWbI5HedmD3H27nSvB6LYc8U4CgGLA/yPFOIWrDkV5IoHJQlq+lANkBo/o+Z/VmvRdVfQP31++WKYT2vA7NGUlBXFKBTFymwL/dgPVCewoV6leBLXI+g2eH55s6Aebl2CtowYU9UofDeG0jFuHlwtQQW0DRUy9RBIcv48xzTL4XpLueWPQoCnEhMq9GinjLeFgSsPLKsCVsOr1YOv5CXcwW7Qca95jMyZ3qNlW3AqvK9Qq2LK9fo1D1c2lPLiRF9ke7D0BS63LDRX7lrUgCWiYSjkiGaRkN8ceFQ45CPwwQZf8yAXfC7nhzRdqaaLccQm5T8Z1pt1UW6G6jzBBnYkOqE3pYaRg5MCVQQmAz2WIIDKe49jUsXEtpb2HY=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(36092001)(46966006)(36840700001)(47076005)(54906003)(107886003)(478600001)(26005)(110136005)(316002)(86362001)(186003)(4744005)(36906005)(426003)(8676002)(336012)(42186006)(1076003)(5660300002)(4326008)(2616005)(8936002)(70586007)(70206006)(2906002)(82310400003)(83380400001)(81166007)(6666004)(36756003)(356005)(82740400003)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 07:31:47.8065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b500ee6-a411-4a31-1760-08d8e2cd65ed
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT037.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB7800
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_06:2021-03-08,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=720 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090036
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch includes a set of two patches.
First patch for adding a new property detect-quiet-min-delay in yaml file.
Second patch programs the delay value in host pcie driver.

The parameter detect-quiet-min-delay can be used to program the minimum
time that LTSSM waits on entering Detect.Quiet state.
00 : 0us minimum wait time in Detect.Quiet state.
01 : 100us minimum wait time in Detect.Quiet state.
10 : 1000us minimum wait time in Detect.Quiet state.
11 : 2000us minimum wait time in Detect.Quiet state.

Nadeem Athani (2):
  dt-bindings:pci: Set LTSSM Detect.Quiet state delay.
  PCI: cadence: Set LTSSM Detect.Quiet state delay.

 .../bindings/pci/cdns,cdns-pcie-host.yaml          | 13 +++++++++++++
 drivers/pci/controller/cadence/pcie-cadence-host.c | 22 ++++++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h      | 10 ++++++++++
 3 files changed, 45 insertions(+)

-- 
2.15.0

