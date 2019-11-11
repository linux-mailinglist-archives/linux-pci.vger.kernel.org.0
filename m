Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC752F73EA
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 13:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfKKMbY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 07:31:24 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:61252 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726994AbfKKMbX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Nov 2019 07:31:23 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xABCSUZ2014958;
        Mon, 11 Nov 2019 04:31:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=9dAIiU4HrQr/OkMOuiLIHdIphnU372y0RAi0rGvNI9Y=;
 b=cXOTsgRi3ph+fJyrQRRKxqJN2d2hpVggKUdjHaJ2fEI3yzmAtefvVE9j+5wBf992oisU
 bFZjt/RROcwsn2XErY+X46hV6DtwGj3uXUVbwZnKxVHS8nFhZC+uvcHxDZZn226oLD1V
 eV7taLty9qCvvep6iwIgdutCQzrdE97sYHHlwiT3Jaqx1+5FcZt8CBUMlS3MQvocU1Fb
 D6/wePXDEB487Zoyqt13gk+0W2Z0d136HW3/KHTo5MQfmJDmKa6IsptAlTmygA8JfK9p
 VH79dqV/xP5b9gpB1eOAs19Q1SlJOUrUq56jWg/WaJa2mXK83mI3SOGzw6QDUnqF4wfS Zg== 
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2059.outbound.protection.outlook.com [104.47.40.59])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2w5swy90s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 04:31:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9S1kDSKiXsakFOPxTmFt6ERAbnFUrUhxzyiOWEj4JNh+7huWGiPOA+1GPkw1W/odWCZ2uZkT7q56Bb+RrEWJRw20SEHcXi+89WxyLTJTLik83dlqzT28I+AIokInIxFw2Jxra09DBsdqGtGcCggXZWmBGyF1nIWULJb1dkjty6O/rQRr/X+EzX/lMPwdNxA80n8JXtLccbB1p/dJzpPTWrbXQh7gFSsBXrNwvhCtRL/KzD2NQAy24CdqE4Wvrv7LBhK2A1BzBBW939PvzaQFxQgZGPf509PrfcEPyNapHxHPkDWh/2QnZKGPyqSDdN/KsDE/Bioj80/OLMmupI8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dAIiU4HrQr/OkMOuiLIHdIphnU372y0RAi0rGvNI9Y=;
 b=iNXXiQjK7HAQudsERH1y4kuuMAdo+oxhnAkPU48e3Y7pvoHnNY5fOxPHJ+FafigcuXwkzQmUbLJCeDrWoqL5uLh5+Pe0W/gyikRpPuF4OQNddagtHkdFgsdTQLiGeZbPayg2UbeZHl3eTA0ZQrIDWkV0MmLID5yRxmKr5mm78nKQJ08PX2/EmTA7h2qmYRzfHEr/+30gzarB2Cv/fkt2zZV0pf2zTMCh6IRYm8ca3dHaUCF6A7HrM2YVyfdMbOHqBjOYKZMYu5cR1V+JAYFh6z4EQScCd3r1uK5S9IKmTxbr1LsCoZiUXXiXwQLhpd/5ZV/mU0ouh5ymLtQmD1fwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=arm.com smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dAIiU4HrQr/OkMOuiLIHdIphnU372y0RAi0rGvNI9Y=;
 b=sbDunUsSu7AvhKNFENgHoLEcEyiDiR+0ImvHwB9gZKkddFzFQRxRAx9Ln2boMfMIYQk5QurHndqwl6J92pMc4FgK1SSL7MNMVbVpL5s24xKpISu75XqUVJHsC6u8JAE5slrPjtwuH894hkrZzlgdnhvpuj6hQo80WYqVmPgxiFU=
Received: from CH2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:610:20::24)
 by DM5PR07MB3434.namprd07.prod.outlook.com (2603:10b6:4:62::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.24; Mon, 11 Nov
 2019 12:31:13 +0000
Received: from CO1NAM05FT009.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::201) by CH2PR07CA0011.outlook.office365.com
 (2603:10b6:610:20::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Mon, 11 Nov 2019 12:31:12 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT009.mail.protection.outlook.com (10.152.96.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.15 via Frontend Transport; Mon, 11 Nov 2019 12:31:12 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id xABCVAi9001601
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 11 Nov 2019 04:31:11 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 11 Nov 2019 13:31:10 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 11 Nov 2019 13:31:10 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id xABCV9Za019034;
        Mon, 11 Nov 2019 12:31:09 GMT
Received: (from tjoseph@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id xABCV8rJ019005;
        Mon, 11 Nov 2019 12:31:08 GMT
From:   Tom Joseph <tjoseph@cadence.com>
To:     <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, Tom Joseph <tjoseph@cadence.com>
Subject: [PATCH v4 0/2]PCI: cadence: Convert drivers to core library
Date:   Mon, 11 Nov 2019 12:30:42 +0000
Message-ID: <1573475444-17903-1-git-send-email-tjoseph@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(36092001)(87636003)(478600001)(26826003)(2906002)(6916009)(2351001)(50226002)(86362001)(70586007)(70206006)(8676002)(246002)(8936002)(107886003)(6666004)(426003)(356004)(50466002)(76130400001)(36756003)(7636002)(305945005)(336012)(126002)(476003)(2616005)(486006)(54906003)(4326008)(16586007)(42186006)(316002)(26005)(5660300002)(51416003)(186003)(47776003)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3434;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.Cadence.COM;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fda27fc6-a26b-4589-b4ae-08d766a309c0
X-MS-TrafficTypeDiagnostic: DM5PR07MB3434:
X-Microsoft-Antispam-PRVS: <DM5PR07MB3434F7265F35922469AD91B7A1740@DM5PR07MB3434.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-Forefront-PRVS: 0218A015FA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RYo38qghFIr5lKAiZM36llEbWeLD7sF8Ysl69z0pWR9NXWdE8BNx09WahYy6XHMv86Zv7poAaVOTHcB1VMcTuOKm7AuekBhpZj7HgxHhWL0c5pUr4QkLCUSNIy8GpSVlkVMM8pLVeQu32kqQNGkrtR1HQ56WSAfkHi8Drxl/gLc22BLB6viJ243k//8zGse7cEkVc4aRGK1sFRNS4tftnt1wh34mkorvQlePt7YqTvmS4pBqsoezZOqyrjoio1PVkRISMPfZzgedM0QIn5y5gI/YHPfDmXGaJlxEa/lj1/0PJHIlGV1pkxQINDf9x8ccLC+z4p8Juxe99GWxfVb5SiQJtlds8iyQGyPnaxCHZ4rtOXnxp+LrjQMZ+gVe+S0jQNYsb1G7Uakey4VLblu8OWgUiByTffjaP87uPmiJjEo5nR0lZa9H02NQ5tKZvV72ncDDoGzV/AHwU4mNNelqmQ==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 12:31:12.4970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fda27fc6-a26b-4589-b4ae-08d766a309c0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3434
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-11_03:2019-11-11,2019-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 suspectscore=1 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911110119
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series intend to refactor the cadence pcie host and endpoint
driver files as a library, such that this can be used by other platform
drivers. A new directory 'cadence' is created to group all the cadence
derivatives.

v4:
- Updated commit title for [PATCH 2/2] as adviced by Andrew

v3:
- Commit logs rephrased and corrected as suggested by Andrew and Kishon
- Created a new folder 'cadence', as suggested by Kishon.
- Removed few unwanted codes, as pointed out by review comments

Tom Joseph (2):
  PCI: cadence: Refactor driver to use as a core library
  PCI: cadence: Move all files to per-device cadence directory

 drivers/pci/controller/Kconfig                     |  29 +---
 drivers/pci/controller/Makefile                    |   4 +-
 drivers/pci/controller/cadence/Kconfig             |  45 ++++++
 drivers/pci/controller/cadence/Makefile            |   5 +
 .../pci/controller/{ => cadence}/pcie-cadence-ep.c |  96 +-----------
 .../controller/{ => cadence}/pcie-cadence-host.c   |  95 +----------
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 174 +++++++++++++++++++++
 .../pci/controller/{ => cadence}/pcie-cadence.c    |   0
 .../pci/controller/{ => cadence}/pcie-cadence.h    |  77 +++++++++
 9 files changed, 315 insertions(+), 210 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/Kconfig
 create mode 100644 drivers/pci/controller/cadence/Makefile
 rename drivers/pci/controller/{ => cadence}/pcie-cadence-ep.c (83%)
 rename drivers/pci/controller/{ => cadence}/pcie-cadence-host.c (76%)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-plat.c
 rename drivers/pci/controller/{ => cadence}/pcie-cadence.c (100%)
 rename drivers/pci/controller/{ => cadence}/pcie-cadence.h (82%)

-- 
2.2.2

