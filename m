Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C97444EF9
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 07:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhKDGkW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 02:40:22 -0400
Received: from mail-eopbgr1300102.outbound.protection.outlook.com ([40.107.130.102]:11424
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229994AbhKDGkW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Nov 2021 02:40:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIKjs0uKBfSWDZTDcn67Cn/4Gey5wl/xsO3bSz1HTkP0yg/caVct9G/yRacHDLGfECYQ4QqKORTAIjmojYMAryGp00/UbTpIeqLBVDGEweJ6TQvtSj1ojbjV37q+0sh/yxlO9uBHV8iJ43snomZ1Y17uahm9o2aBJjgE6cPHqrVPZ9XzcwN7Ib1lQJfHyuJRbWkbzWeU+JA/vSsIKzhQDEe9xBoVIj/Mfsob+Cu3zJKJidRXAt6l9AqZ5wUcgF5U6lAs/UOX23G+IxVCsJ+BgkefgFlU6j9njsCzMvTtRB4rwNbgZ5WDYYpccxoFBe49G8KG7+Rgbncm9BIqi8jubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/CFL31lIFop2H3gVWi1eA+UYAE4pthQNA/cje7KZ/M=;
 b=HSqYiAFWdl1WxMdT29ssn1e8PEtqi8JdOmXtHuOTBkcnRnd2iGRz4gUmSh9L9a2E8hNqP+t+6sMAcIBLZA11M3v6QMMk5nOH2KC/UJFtlfRvwimoAkM0nBh14TxkWcb5fDj7WjEHAbVztjpfpsfbREuOQcekM+zSY/m+WSfKRRmihSwbmfCchprpI7pFSicepIE5wO9Bw4rKPiaW3lQShrXLPX2mXUTGc5yrzx4a13D2s4SCYagMXRH+Qelus06TU9HS+1StHZdEvgJJwXjCz23IUFulVvDwcrEL/eQYtqNdHCqsC22qAQEDdPoMCUNMBuWMq8VymD62KPHi089b0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/CFL31lIFop2H3gVWi1eA+UYAE4pthQNA/cje7KZ/M=;
 b=AHWNbX9Ugkj1F3f22M7EgkoBvWa77d/YUfPHxKJwVAwouFMA15IqeSCoaSclguctBJb4PybTztk6LhDzLyxbPUTw8vH1n9r5RcrN2N/ORRpAnDObY2mnflPzGCfNN/w3e1PRW8x/vsYmoWZRjkcG5MZKH9yNo6QnjKmxSl6/RzQ=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3450.apcprd06.prod.outlook.com (2603:1096:4:a2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Thu, 4 Nov 2021 06:37:38 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 06:37:38 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jiabing.wan@qq.com, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] PCI: vmd: Remove duplicated include in vmd.c
Date:   Thu,  4 Nov 2021 02:37:19 -0400
Message-Id: <20211104063720.29375-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0097.apcprd06.prod.outlook.com
 (2603:1096:3:14::23) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by SG2PR06CA0097.apcprd06.prod.outlook.com (2603:1096:3:14::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 06:37:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6fcdd9b-8dbc-45a4-a0d0-08d99f5d9767
X-MS-TrafficTypeDiagnostic: SG2PR06MB3450:
X-Microsoft-Antispam-PRVS: <SG2PR06MB3450A0C9AF185A0F58E75EECAB8D9@SG2PR06MB3450.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i1vQFdAN3sho4p2LjCxTQhOXARQcNwjpnFRL19lPT2d6BqjJHorwOeTDXwrXIvei7m4kUztFm3XSY4EBXreD+01eQTtB6ubDoGBuZaiLEHHsAj+PrV1KPyZP7R5oKEg0SMYGg0KkWRCcwVbp68UctsHrtdpwhKWZHmenZdO77vz5kxUH4Eg55P7NtYhn85T61B+9PlYrvc12MtbUTS65RSxWyGSE5ZF2/h/qvSyrFK2eWXYdEm/hfrdiAnkFYs8tcZe+rYhv2KWP52yhdi1UrJwqujW417muWDm+oQJWCuXZ1VJTD3uWmNUApqHOhKT/Mk4PBWmX03djQaoO0oWu4dfexAgyekkOTeqZ51WTX2G6HIv2xPojcyNQAUYk5cg6lXDTZ/kFW4fcDoqFjtcccW6z7GHdsADIpYdO5rZeGK2lzeypc4jmJQVkfxArwHWvlnO7NSUlQG8XRCdrq8WBrFVtpjmtxxUeblQUolqRyh5H1khpPbDQX6wNlsCNsTUbXR0Zwr7UiKQV7Z3L9u8wm1slaQoCKSF7bKPLSfAX/+9ueQNUsR48gsPYWdrZWlx2QjcDce4/eJ2vEpkB0iB0efmvx6FfskrBZjgFrFVW9qtgUS9jRSvE17wd8DIlODT7Hj6brYL3rhPtEVXEyhFN1RpaJ8uiLoar0H7ai1+XfP93i8CayklNhBq5ZRA4wNrThFjfF6IrD6OUX9cE8JGa0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(110136005)(52116002)(316002)(2616005)(83380400001)(66476007)(66556008)(4326008)(4744005)(107886003)(186003)(8676002)(38100700002)(38350700002)(8936002)(508600001)(26005)(86362001)(2906002)(6486002)(6506007)(66946007)(6512007)(956004)(1076003)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s7ICiWK3zVAqLahLzolgfSKQ8dC12BNAENTHZtyycQL89/OTO5fxABhit9QZ?=
 =?us-ascii?Q?aj48o606URT6fNxP9xhAcdmB7aQIaGIkVdPAeahDIl56M1paLH++b2PHwB9z?=
 =?us-ascii?Q?Panrdduw/7Dew2E8Tmi5pzXDpsMrgQDuGKpliXl6SVBL5b2s8QbJr5DrBJnF?=
 =?us-ascii?Q?E+ad2hfrJw5Wz8To0XbrVrwHhI6rPEfQD6V0pp7MqnbMpWuW0VqlVXmw7F/G?=
 =?us-ascii?Q?F/4LJ+ejQSWjmSOksu3zezqB9iOXsReJP31zNGhgacEMkMtRhJ9Uvx0+qCyj?=
 =?us-ascii?Q?5JYLXVOWSz2ZB2WmQdLOmPJJBi825f5SHwjAGdCkPA930Crq9jyodNRjDpGB?=
 =?us-ascii?Q?onhlTU8PY9Sy+9CS/mC0JqTBJcAKOmK3yFi9C/q5U0IYwOaaUjsz0GzLKv4U?=
 =?us-ascii?Q?1BiGVbvoIj106sXt51aJATd5mSlYFivh/QGUV9qNrR37I3+12mCcG0dGIxbE?=
 =?us-ascii?Q?gnI3Te4Sdra4R2V6GeiHWcn2AuAAe3gAe4hs4OKBT/55dvqI4pk36q/dbn4l?=
 =?us-ascii?Q?VFM4vjXGZWPeDv/rP3ECSzUW+GSgGGNFhARazoza5ZAksUNT1jwO1hdcV8k8?=
 =?us-ascii?Q?uDXhlwZo7rgM1dvEfew/Bq2/9d1jKXrdfKD+LS3IT955xNmKWBupYhZ4/okR?=
 =?us-ascii?Q?Vguh000E5wFD7i0HLZzv/kIlAg4XBv+GPpTxdcKEUpDeIzlLcF5LjaBPDwIK?=
 =?us-ascii?Q?0nanBBtmcG0K7UNtV9Iu84aMczcl5C5Y4h6UbmXA60/wHgqmZ0bRfpxhxXzP?=
 =?us-ascii?Q?lsok/acawzRhEtJBjn4wnaFuyB5ScCqkGYIti3c0YhgpgjPJoLj8QHOasSWK?=
 =?us-ascii?Q?umIu8bQeGMW/QWf869/DfzhRVYLq7Gnyn+4nQXhJbxN1bUEl0pH8Y1p4YVj0?=
 =?us-ascii?Q?TVAzGXHXC2yaWzY6Y/N0G3q/tkSacbNRmnOLUL1agac/JdP8lIkcLOVpEOLL?=
 =?us-ascii?Q?WmBlJ0s8+t2T+bmBSXDim1nXQ8maFuyd7zs2s90D+u1g2sJRJaqBDJTRGO6j?=
 =?us-ascii?Q?F9AD2a9+i5h42AFpn/iElDah7ouR9DowBzO0pTBCTC3GHMHn96OgwSmo9+yp?=
 =?us-ascii?Q?29InOgdUQRnC9ksD8DmXvLR1OPRiM/jSal75RfkH2rIAmU69/Qrzj1ptifbc?=
 =?us-ascii?Q?fzq29JPcvGrkslYvR39Gh1SdLzXRw07iNdyGdHmjwDmZ+i6b6jCHZteAT9zg?=
 =?us-ascii?Q?e1QrtgXK2WKEHKfH/vOx7cSC68U5DGkjmBpznZAohq1TINenJTJRLSXKXORB?=
 =?us-ascii?Q?B7r44yThnbAPJBZnvU7r3Oy9n510n8bXFdXhamxv++p8VSAXM82SvxLV+aPz?=
 =?us-ascii?Q?poMwVixTqptDZyIT4tF/rpugBFiggq9q/GDB4EcuMidXO5+i8JlUNGkgneMX?=
 =?us-ascii?Q?0XfUsTsME54nDTehy/gQeJiJMo/IPDYLncMLrsu/eztN5r9kXLsOkjycQV+u?=
 =?us-ascii?Q?8gleUGzGq+H7eERc0FnJ6WkerJtMJ+dSh6J9os3DdjV+bdvN4RcLqL2nPrIw?=
 =?us-ascii?Q?J9EaXcZhfDGlXkc//hgFsE7bc+9NXJj/yHudbdDDL9EcV5pIHdMT0uDuaK6t?=
 =?us-ascii?Q?bpGX2+E5JPfW0flXaRu0MMiYu9EWkFO7TKi60GjXe2hK7DvjFEusflsuoSyv?=
 =?us-ascii?Q?UhUaMc3gk9G5Dd25j5/bYB0=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fcdd9b-8dbc-45a4-a0d0-08d99f5d9767
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 06:37:37.7667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbFbZezE4lAxO/Az07r6NPJBZG64w4yxuabol23DhvhRUG5vRB9mrzF4UMWNavj5cxyMYeIA1zKC+MWAH6fGdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3450
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix following checkincludes.pl warning:
./drivers/pci/controller/vmd.c: linux/device.h is included more than once.

The include is in line 7. Remove the duplicated here.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/pci/controller/vmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index b48d9998e324..a45e8e59d3d4 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -10,7 +10,6 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/device.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
-- 
2.20.1

