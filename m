Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8797FE8763
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 12:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbfJ2Lpl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 07:45:41 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:47566 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730214AbfJ2Lpl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2019 07:45:41 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TBTP9i031767;
        Tue, 29 Oct 2019 04:45:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=R2+KvFbVEt6MFhW+3JYJvx/TTozMHQ7Lxc7+p/uUOMc=;
 b=O7KSXM1oF8XE2ZuRmll2/E2EOscGRPSPdzA6EhETsKQtaxJX1kxnAQ3cHDybc16Zgidd
 HEdt6eV7xENwTN0mGYbLK5dH8GVMii7wIAmRsx/09vW5jMKxpNwHt+UeQLZ7hN1JI2/i
 7J5Nu4zTfilkB09vBsMgIFzlqbeOCtVx3OwlZQ5Y0E0oUWlowoCh4WH1CCHfUhECOFld
 /VBWsHWryVjCNkLQRNhOUxfX2aQMrejhDoXLqIVMtqdvEgijeGScxNmIkogQHx4yPKJK
 DD/FpeWVK77FFXE0cotM/GnXyaYHJnQxtqkGgaLmWR/XmsIwETX5cJDl4LvvvnOgTezs fQ== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2058.outbound.protection.outlook.com [104.47.44.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2vvhqx9m9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 04:45:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXws08UnhJ68E0kG94dOXPnweXr8wE6S+dacgFTgFem+rsXnkAv1Z7/gnkCD5H9XWwnuc80IVIMt/c7M2nVPR7E2LTJ6HeBIyEU4jyRRW3C+Br1PnVC0YBUQpwfkiQspgDogDwY1ZQSmIo22bGWvE4ANcB2I4/y5OQTDFfhlivpJ/HZReB8jOYasckjElV2CDucY7kJe1k1pUmNtPP2s/4hWv2DhhN06xVGwBzxLDNIRXIv7sfUens/eOBYh/pTm3nXFot3SHZt+yVpdKYxJ/yYA1BREoPqqbcNWjCavzYu2YFIn3jDPbj33A6btvP/wskPsxcbjT2oRPDnzzJ8IAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2+KvFbVEt6MFhW+3JYJvx/TTozMHQ7Lxc7+p/uUOMc=;
 b=l3qvC0ooptVMC0ejkLan85Mc1JgZY/8EE1c6g4/gghYVBed/J9v7rtqFP5t1hBZkVDkJaKOJCGjjx+80b3PKAW7F5lToo5XBVmLRzmQ/4UzyG+hR1jl0rpvm6PxuwARZdL/SufBOgx3JHBCJCOlQURrH2UCS8K2g5uOW8l9w/wz70GaadTKbz+KiDsE5MHWdzS1/YumssqFHMQjjtulQSA3hQu97WTmDeiDmRN/WvsOcx5AhtLP74AY+/xsHeAc6ANcmJ/6GuMz93qaFuqEPYVMs1LBUrWcDVV8ShwLVHjvzZjdNjolfr1RoXmOMrvBl4Yy57nRhzDIci+pnzccP6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 199.43.4.28) smtp.rcpttodomain=arm.com smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2+KvFbVEt6MFhW+3JYJvx/TTozMHQ7Lxc7+p/uUOMc=;
 b=Bb6XwXaJ2JoPZ72UhoTALz3LQo43jUHyFYMRfyhaKyLmU1ofY9hfl1ixXduWZN+bwJEgZWJ1fln053eKj8PYBVG1qq1G0Hko/fOP/8+5h4t8761bH8pIA9Y7UJoao5hnWzbQIlxuPeCbcQR+5OAQyJy21RkWn5PL0/YyfeXKhNw=
Received: from CY1PR07CA0020.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::30) by MN2PR07MB5903.namprd07.prod.outlook.com
 (2603:10b6:208:105::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Tue, 29 Oct
 2019 11:45:33 +0000
Received: from CO1NAM05FT042.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::201) by CY1PR07CA0020.outlook.office365.com
 (2a01:111:e400:c60a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.25 via Frontend
 Transport; Tue, 29 Oct 2019 11:45:33 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT042.mail.protection.outlook.com (10.152.96.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.9 via Frontend Transport; Tue, 29 Oct 2019 11:45:33 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x9TBjRPH003769
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 29 Oct 2019 07:45:29 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 29 Oct 2019 12:45:28 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 29 Oct 2019 12:45:28 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x9TBjRhR007963;
        Tue, 29 Oct 2019 11:45:27 GMT
Received: (from tjoseph@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x9TBjQcu007960;
        Tue, 29 Oct 2019 11:45:26 GMT
From:   Tom Joseph <tjoseph@cadence.com>
To:     <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, Tom Joseph <tjoseph@cadence.com>
Subject: [PATCH v3 0/2]PCI: cadence: Convert drivers to core library
Date:   Tue, 29 Oct 2019 11:45:10 +0000
Message-ID: <1572349512-7776-1-git-send-email-tjoseph@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(376002)(136003)(36092001)(189003)(199004)(36756003)(476003)(4326008)(51416003)(6916009)(2616005)(86362001)(186003)(47776003)(8676002)(2351001)(126002)(305945005)(81166006)(8936002)(336012)(81156014)(486006)(107886003)(316002)(356004)(16586007)(48376002)(26005)(50466002)(42186006)(26826003)(50226002)(76130400001)(54906003)(70206006)(6666004)(5660300002)(70586007)(478600001)(87636003)(426003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR07MB5903;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e3f9c73-5436-4b25-7e78-08d75c658198
X-MS-TrafficTypeDiagnostic: MN2PR07MB5903:
X-Microsoft-Antispam-PRVS: <MN2PR07MB5903D05F48A483613A8794BCA1610@MN2PR07MB5903.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0205EDCD76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXZJKm/UexB/rktDy1hLhD7lSdqTf96pbhB0VHxbzsZjqIdN+SQKWG8Jr+hVuiGjb9hOGAZhQQiaPLQHM8HSW7fpTdKWsC38lwjnSqCROen7H0fGQ5Z4i/H1IvuTKcmgllEGmamG9WfBjEKzOmJrYXB1UVWTYA8FBpVZzfJAJRScuclkeZIMTtAs2WdLnj1LGPS5vuAfi5CFCBxpaj/vTeQei/wx2/XUcjZueuozamUKLk1++Fr+CUBT4QYnxGFtqhnBrB9W7HdUbWNWzfO2Y61GxT/VuGlmxHo79RSx/bZtfInDbYN+36+lyPszrFCLM8v3hPtylzu1kHLZ7sFFP7cYYmUYmo1QRa6Y+jXWZCy/GDTSLjnWaRcmeMjmp2erwa36PLvYSxa3mZI9l9sV3npyHxZRWoGJXPxdntziJA0iY89HJAiglH9qatgTIlLW8CcGcUUUvNmnrLI6rr72aw==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2019 11:45:33.0350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3f9c73-5436-4b25-7e78-08d75c658198
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB5903
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_03:2019-10-28,2019-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=1 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910290118
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series intend to refactor the cadence pcie host and endpoint
driver files as a library, such that this can be used by other platform
drivers. A new folder 'cadence' is created to group all the cadence
derivatives.  

v3:
- Commit logs rephrased and corrected as suggested by Andrew and Kishon
- Created a new folder 'cadence', as suggested by Kishon.
- Removed few unwanted codes, as pointed out by review comments

Tom Joseph (2):
  PCI: cadence: Refactor driver to use as a core library
  PCI: cadence: Create new folder 'cadence' and move all cadence files
    to it

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

