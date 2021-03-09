Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479A0331FDF
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 08:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhCIHcS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Mar 2021 02:32:18 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:38720 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230397AbhCIHb6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Mar 2021 02:31:58 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1297RkoA014874;
        Mon, 8 Mar 2021 23:31:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=qiBxxcYP5C7osuK6J9jAd556dSdRGFFrT5anRCvvZ08=;
 b=euuyP/LgH70DUoYwRpqC4xKbxylhETG8zlZq79+A1v0JtFnCbba47UHRPV1Ng8aeRSs/
 yCeyezWyW9+kd7uxy89yst45gJZi2EMQ83QCl33VugdOQl1azXgEneomU+iCxW+Mbgf9
 AWC6yX1dYZdCpGeplb9p5JE/bH/IyznNDoBYh5rPUgQRQ+nzqHypCxNRFdTSeuDhVlw2
 ZhZn7IumLBZ0i6robC/7yRG/G07vIr0rpdkKaiXHy6AoaFGW7bbqAWJczq7aQrYT8oUT
 p3ZFVo+gJbEPBOVLc1xYqXFFmjVp5H863GEOW+LZRLsAG375QIk5iXbE1gZn7SrnxHnS dA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-0014ca01.pphosted.com with ESMTP id 374762yph6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 23:31:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5dmFR3bN1FnUV+c8+tzx3YX0TF8a4bxDx6ZU1Ib+NfFpew03ep8c0M3NZQ0QM1E6NKz/00a00mv78AkeUgJekQM38yY54sDVpLm9+/HyVVwo5vi9Rz/YjGyBI385XNY/VWfW2S+E9pt3a4RiQGh6rFPVHbDZNqNp4zJDsTFtB4a8yVUz/yeFf1ZD/Jk/BfCwxOJQn142n+MdAqv06HlUYnDNs1/NbrTt0Cr7bXZ/l7EI32cJd5J/S3NqY2a2y9lQ871OOmJlThWBW6PLNLN0bEpDlfcV7PiC4vBcNPBif2u8wq6bevorvoTdoX8E5d5YUzkIoQvJek6lE6eAMuk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiBxxcYP5C7osuK6J9jAd556dSdRGFFrT5anRCvvZ08=;
 b=b2nPHHsrpki7Pk5x5is68wOPttG1O7me6aaaOAoRUhrtB0DGuNbuO+HywFV+dNg7/os8YtBPm5lzNBcvZwrqb1DQDgqf06U9F6FyEz+5wxsJTyvZtG4jOB6Dn6JELJmvup+Rdav/N5xkrb3nay+nzur3elfsyqU4FWSW7zRu+eEPRwXbYpKMGEw10HO2yfnuz7/zV4yLQ885MfNgliKz6sbR4EWfs8QAbFDDjQfW+hF3sBnllIabjoJQOpHIu6YlCLCKYElZBv319CLB68niD5swZb0tkgqU4V65n+R53GxRIIn0JiI83UJgkgR9r8/fh2Gqsfj5iUxgXmd2wcU+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiBxxcYP5C7osuK6J9jAd556dSdRGFFrT5anRCvvZ08=;
 b=ZNL8NAMXlj5aNTd+n5v/UAOSaoB/JZPPU932l2Zb4hxd0nwQujRbLKoT1LeWL7rSoD+Jc8xCWFnNaOricq2WnrifbMjsZivXMBKCdNKi69NkdOQoWODPvwBYsuK9lfMxYASp/hfQM2eI4o0YIKsugf2OaHsAF278yUOxIBuBKyM=
Received: from BN9PR03CA0915.namprd03.prod.outlook.com (2603:10b6:408:107::20)
 by SN4PR0701MB3760.namprd07.prod.outlook.com (2603:10b6:803:4e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 9 Mar
 2021 07:31:47 +0000
Received: from BN8NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::d8) by BN9PR03CA0915.outlook.office365.com
 (2603:10b6:408:107::20) with Microsoft SMTP Server (version=TLS1_2,
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
 BN8NAM12FT050.mail.protection.outlook.com (10.13.182.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.16 via Frontend Transport; Tue, 9 Mar 2021 07:31:47 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1297Vi7s003118
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 02:31:46 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Mar 2021 08:31:45 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 9 Mar 2021 08:31:45 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1297Vjhn013289;
        Tue, 9 Mar 2021 08:31:45 +0100
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1297Vj0C013286;
        Tue, 9 Mar 2021 08:31:45 +0100
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <kishon@ti.com>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <nadeem@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH 1/2] dt-bindings:pci: Set LTSSM Detect.Quiet state delay.
Date:   Tue, 9 Mar 2021 08:31:41 +0100
Message-ID: <20210309073142.13219-2-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210309073142.13219-1-nadeem@cadence.com>
References: <20210309073142.13219-1-nadeem@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cd6fb44-246b-4984-ba95-08d8e2cd65a7
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3760:
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3760D69615325CD47D76B421D8929@SN4PR0701MB3760.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NxVfYg3EtCJlM/G2fH7QdztSLmMCF8yex/nnGn2uVMroGn2Nm9xU8i1BxH9/e8Bq583XL5RJ25fYf2WPI42kt1007xhpv2n9uDSTQUmsYhghqvMBei9ZimBMJUTJHmUVtn6mrnGvEcDDx1JWcquYoeglzD6HVEtDPMtcayqqcSbLHGrRP+YemC5vR0CkB+D56uYs0/OE4phPnq68Ki6ap0mpODhgitn/vX7L6ibyFCF5VW1cPY7DHlTsZfnIpQyvcyj9M4QP40sFT32VzatN4nDop4ViKpgAB2q//U6ItEuag4MDIuQ/u5ZfYe9/7A6YVbKSM7gl1JahW96389JNX4JxcwD8+sLH9KemYRSjVJiCyYT7qc7BtZX/5FkCmk2qmyVxP+SPlOK/R6Lxv3pawQevZVP+8SqoP290ECTIC2nTtoctZivEXtVcYPmQ0U0GuUWwJnawYq0Jl/bKDueHjnjl7Bhakv86WX6riU2Lo5tL/IxXRVK9nffIWASrNZaXsx4PhhLgrLxM9pUE45UYgAgZGanYraiv3nNmo7mmAt0I0g9sRkdRM6dypizjYf7kNhuBtDvXNzSqcW5hT9jkUagd68PyqnR8UqYca3nLLakWjO2J0F2XDGzhZOxGGt/HLot+/2LFDDj1G63k/iqUc9oG8ONDW7Yd1alHbpqpsYOvqNVW6TV/VRJvpKfIH8Jlzej3f81+AKK59qaZqohgwB2ERskv5d+RY/uI2wplXgI=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(36092001)(36840700001)(46966006)(8936002)(83380400001)(47076005)(86362001)(6666004)(2616005)(42186006)(70586007)(316002)(81166007)(36756003)(70206006)(356005)(2906002)(336012)(186003)(4326008)(26005)(82310400003)(54906003)(82740400003)(110136005)(36906005)(478600001)(8676002)(5660300002)(426003)(36860700001)(1076003)(107886003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 07:31:47.4339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd6fb44-246b-4984-ba95-08d8e2cd65a7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT050.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3760
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_06:2021-03-08,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103090036
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The parameter detect-quiet-min-delay can be used to program the minimum
time that LTSSM waits on entering Detect.Quiet state.
00 : 0us minimum wait time in Detect.Quiet state.
01 : 100us minimum wait time in Detect.Quiet state.
10 : 1000us minimum wait time in Detect.Quiet state.
11 : 2000us minimum wait time in Detect.Quiet state.

Signed-off-by: Nadeem Athani <nadeem@cadence.com>
---
 .../devicetree/bindings/pci/cdns,cdns-pcie-host.yaml        | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
index 293b8ec318bc..a1d56e0be419 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
@@ -27,6 +27,18 @@ properties:
 
   msi-parent: true
 
+  detect-quiet-min-delay:
+    description:
+      LTSSM Detect.Quiet state minimum delay.
+      00 : 0us minimum wait time
+      01 : 100us minimum wait time
+      10 : 1000us minimum wait time
+      11 : 2000us minimum wait time
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
+    default: 0
+
 required:
   - reg
   - reg-names
@@ -48,6 +60,7 @@ examples:
             linux,pci-domain = <0>;
             vendor-id = <0x17cd>;
             device-id = <0x0200>;
+            detect-quiet-min-delay = <0>;
 
             reg = <0x0 0xfb000000  0x0 0x01000000>,
                   <0x0 0x41000000  0x0 0x00001000>;
-- 
2.15.0

