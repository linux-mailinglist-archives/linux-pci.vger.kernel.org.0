Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00FD3135F6
	for <lists+linux-pci@lfdr.de>; Mon,  8 Feb 2021 16:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhBHPD1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 10:03:27 -0500
Received: from mail-eopbgr130123.outbound.protection.outlook.com ([40.107.13.123]:65158
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231518AbhBHPDW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Feb 2021 10:03:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iG3000oUOIGVtBnEG+CjFDRCeaiKskrg/hrQfp7by+MXh6UZBwnt27ZoOCJO0iksA5kQ3rFU4XWOdaCTtKHSUV3rbgkXzfjiy9xDMon8TkWMQS9cfzIhGW9xKfZXXHbKKiAiu8SyjG9y7xorGXxOkOhTc+nGpirPmstiR3KTR0HkJLQ5e8ozxysFZj9koH5lgvxqjUXDIaUqjXhPvmies7cJUf6ISNQ9MNXwZfK8wutoBUPzD228F2spMENFO6gqeYNS84fh4e/jp64PQ+dnl5f0vDVBCCm4Q/IX5N5ly+3unTulxuRQxmClCvAFpASSkq5GocJb1Nk+eDNreDP/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSNX9w5do/ZM1q9r45VBDojL3Na+fyi7ST47hs0yvkA=;
 b=U8ML7FLUUlBJpfHlApeHz+IUEV54lxH/FdJHzcQZteW0plyYkE+y4eyGOEHDHFkStLfHFjNm6cLlDWInlvIRkY0lXjee3J3uqoQ+zpL8ZLbn8FjlCYrrzQEXHvniLTSOqUpPRwsu21vS6JEUSDnfIH2yQlMahpk4yoT0wvDrQhKdd9J7khz37IYrZoIna6A1k4SvMo35KlDMnW0waXIX2o8a81wqOFHp/93vOqKvyI3VYO0aEjnOs6errJd6wUJe90VbUwNOAlkUXvkBoIdzJ5kjn+soV5df175k83Jg17Wq9UkiZn3+babQIf5vMs4kFROof5kAWWM09cj2K5+t7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom.dk; dmarc=pass action=none header.from=silicom.dk;
 dkim=pass header.d=silicom.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSNX9w5do/ZM1q9r45VBDojL3Na+fyi7ST47hs0yvkA=;
 b=PEQJdJgNLtU82/2HM8xNel/D4l9Xq2S3/qZWRw5E/EFQK2b8sWHCSPSc7XUQ9l1MF+OgMxO2JsbHufWT5HLTnnvneNnDOhGOfHTkAo6OtZonskamCMPhgiSn1HswANZH+Kzk4uCDjgk9D5ynssowkh6hyS2oJyCn9SgjtSZTk2A=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=silicom.dk;
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15) by AM8PR04MB7220.eurprd04.prod.outlook.com
 (2603:10a6:20b:1d7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Mon, 8 Feb
 2021 15:02:34 +0000
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::58c9:a2cd:46c5:912e]) by AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::58c9:a2cd:46c5:912e%5]) with mapi id 15.20.3825.020; Mon, 8 Feb 2021
 15:02:34 +0000
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2] PCI: Add Silicom Denmark vendor ID
Date:   Mon,  8 Feb 2021 16:01:57 +0100
Message-Id: <20210208150158.2877414-1-mhu@silicom.dk>
X-Mailer: git-send-email 2.29.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.17.218.86]
X-ClientProxiedBy: HE1PR08CA0070.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::41) To AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 185.17.218.86 (185.17.218.86) by HE1PR08CA0070.eurprd08.prod.outlook.com (2603:10a6:7:2a::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Mon, 8 Feb 2021 15:02:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68ef046f-74f3-434e-2792-08d8cc4290b3
X-MS-TrafficTypeDiagnostic: AM8PR04MB7220:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB7220B90524290D780A422FC8D58F9@AM8PR04MB7220.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:457;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWVAetUh/qxN+kJdaQnWjGIasZgTfhU8BpK7P6e/gFtsHgIkv0OGkMBcrJsNXdTOO+To3DCQRCF9GzXEeijHk1wyrMJ9VCGWHpOy7WXwhHvTnbGvxgDY5fO39n+xZEK7hM2HHKZbY222RdzI2TG8pO20pTbeSOYwAuBk4hOVhSkvEVeOP1dJV2e1wWJMYb3E9teIJF4Cj1r5xKLoQAOkl3BFMTWFG8E7JIJuVZkXi01s4w6x+UuzSIgM3/OXnNkDVnUA34OqApPVC9a8jpaiI2O0IjcV6I+9NAVZnpgYFxNW3vyooeFOOQX/T+3f1t1xAu3Ire9bPOh0HrULa8YYzTJWNSoRMsGcpyjekq3wd3+VphNExnIiKwfUDIz/Vot9YaahTeZgYm5Y/EUVeElOJbzX+X1VlTd3O4/XucnfoMh1ZfeAH4SPOu9f8u9w5Ryq6ct3S8d4Zt+Q/zW5f0g/I+iUTRC58dlpI95UBdJqLb4DGSho2seff1cLD3xfXPZqAK+oxqUGMKkvHkv3QvU8I8AJYvWBv0X5OsZzOaqtgkHxZ7CGcX5LKoztqIok8GPcZoazh9ft19mB0v6af9aQ7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39840400004)(376002)(346002)(366004)(396003)(16526019)(2616005)(4744005)(52116002)(1076003)(316002)(956004)(16576012)(478600001)(66476007)(8936002)(66946007)(26005)(66556008)(86362001)(83380400001)(6916009)(2906002)(8676002)(36756003)(6486002)(186003)(6666004)(4326008)(5660300002)(66574015)(8976002)(110011010);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NEZBTXRlSWFoTzFQS3FjZndXaWpmMGtJNlBuck9FZVdhRlE5L2hJU2lXdFZQ?=
 =?utf-8?B?MEU3ajNPRDFJbTlaMzdPS0c0azhocUdKWXJoTlM0RzlEYk50cXJiYnhic3B5?=
 =?utf-8?B?U0hOUDRoQVE5MDVDa0xSdWZUc1dSZ3c2bUhMQ1pqVEpjNFNSU1N3QXFkQlBK?=
 =?utf-8?B?R1RzNDNuUm1NYVVNcnhoZGd1cmFkNm9PQkRvKytMS1BVN0NBT0NBRVdIb0Jz?=
 =?utf-8?B?b3YxajNlTjM2ODIzSG44enNDZTNvNlRmWTNFMmE5dFdFMFNpMWs4dUZxcHR4?=
 =?utf-8?B?a1h2blRiMDRMSCt6QXFrUElJQU8yWmY3Skhwbmxtb0M4MmQ2VzNUSUtmd1k5?=
 =?utf-8?B?TU5XcW93bXZTZm9Md1ZYMEd4V3dsUGFNTmFWaVdjZjlIeTlHNmYxZTl4MGdJ?=
 =?utf-8?B?MWZDcnRmVE1WbUZJbGFpeTRvRjlhVWRiRVpSVjBFOHdvdC9qZG1PSmh2Yi9o?=
 =?utf-8?B?OGFCblhKMHdYdUJrUUpWS3F4TVIvd3RYNEVSMC93SURQcWNhdW5Xb1l2QzV4?=
 =?utf-8?B?dFh6bURMdXhFaTJ2RG03Sm40Q1dreDhwcWdVZEh1dFlSb0RmcjBTbVVPRWZh?=
 =?utf-8?B?QVdPWFc1NHVVQ3pxZGozcWpRWXFJa2g4Z2ZObVk2Z09KSXFRYVp6WnIycXV5?=
 =?utf-8?B?dFc0RnpDd3BrZ0tMaWpPM3dCdGE3a2pRdlg5QnpPaFBSdzlxeVRlcFNjT0Qw?=
 =?utf-8?B?M040MVdhbitDNUhOVDE0NGE4ZzVrUmx3c1kzSzJrV2phaExmalFyT0w5YytP?=
 =?utf-8?B?aFZhYndUMUNMcnEwQmV2Y1lvUlF0bytJVWdXaVVnMkZNb2J1U2Q5SWdjZGdF?=
 =?utf-8?B?MXFFdXBEMzk2d3BtNlR0MThzMHJOa1VxQzhSbWlZMk1BSGpxeEZ6UldEMWJX?=
 =?utf-8?B?cEtwVFJXUU05cEs4WGt5bERjeDllTUxPUE9oaG9pVTEzbEx2NnJzckhEMTh3?=
 =?utf-8?B?VHR3RHpQMTlDa3crMlowWU9Tajh5ck9mT21lSWFtQzc2NjdwRnVDdFNtbUxV?=
 =?utf-8?B?NitKYW8wcW4zeVRDREFoSk9CV2VHeXgyU3ZiejMwRmVpdm03c25URVJMS3lC?=
 =?utf-8?B?V3NKNTFtWEcvcGhiRUdzaUNtMUQrMWtnM0hmZjhPUDdXZEpOZlRGejl3UzFY?=
 =?utf-8?B?aUlyWm03TStDSlhSQ3JRSmRGU0NubHRCcnM0UGxodXkzbUEySUh5NFBDYWpz?=
 =?utf-8?B?dXhtNDV6clp0UjI4bHNsUUlSdjlKUFIwR0M0clhjcC9rNjE4ZDVQcDRWeWd4?=
 =?utf-8?B?d1IvRWVCVVkvUFJVWFVET1Y0T3dpTHlndDlYc0dRWkRQakdjZmRjN2NEM1VT?=
 =?utf-8?B?WThtQ1JWRkhKUTh6cWFLVEpKMW56N2QrUFVHOEhqWk1lODlVc2FwRjVHeXhm?=
 =?utf-8?B?NDAwbWlwZWFKMFBoTHhqU0pxbThLQkc3RUdrVzJzZlI3UGFob3k3dHIyeVpL?=
 =?utf-8?B?WW0xMTNMTUdmT1ROQ0t0dC9JVVUrQjUrV1RhUXZ6TVVZM3NOY0J5TzNXdWRS?=
 =?utf-8?B?cG9XOFpRTHYwVDkyUGxxdXJHTUhWRjh4OUdhelM4T3Q3d2tRczlXNW9aeldS?=
 =?utf-8?B?MEZocVRybFBQc3hnNXNXQWN2aFRvaUZPUUMva2g5SkhiRFZhNWRCYVlSelhS?=
 =?utf-8?B?QVd6WDJ2K3BLL2dQR2hRdkNlcU1LYzA2WmZNM1gyVlZ4bW5DVitWOFFBNUYy?=
 =?utf-8?B?UXBIVU1WM21nNCtkeEc2VnpKUlRqRjBwRUV3OWdGT1dENlo5YXpXU0RRMFZh?=
 =?utf-8?Q?Wx/QnEkNgKxb0PSSzFjvPbRjBr0Fa88ieXpxOP8?=
X-OriginatorOrg: silicom.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ef046f-74f3-434e-2792-08d8cc4290b3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 15:02:34.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNGUw5I+VgUmobXcIRfV8rVGf3eLq4TWtzRyRi/DJIM8H82DZbtBdtr0G2FY4uR9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7220
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update pci_ids.h with the vendor ID for Silicom Denmark. The define is
going to be referenced in driver(s) for FPGA accelerated smart NICs.

Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
---

Changes since v1:
 * Align commit message/shortlog with similar changes to pci_ids.h

 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f968fcda338e..c119f0eb41b6 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2589,6 +2589,8 @@
 
 #define PCI_VENDOR_ID_REDHAT		0x1b36
 
+#define PCI_VENDOR_ID_SILICOM_DENMARK	0x1c2c
+
 #define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
 
 #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
-- 
2.29.2

