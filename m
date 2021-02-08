Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E396E31334A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Feb 2021 14:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhBHN3s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 08:29:48 -0500
Received: from mail-vi1eur05on2093.outbound.protection.outlook.com ([40.107.21.93]:41568
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230382AbhBHN3p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Feb 2021 08:29:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+gTBaQZHWFnWskz4kvX1dQ2BAjoQrkOWZGY+wHa3FQYZGdlhlZ5hHE74hIQRQUcgYRJJFYqDzGWHNx9uR8Tp1lgC031ZfoqMP+yOUV/qYFbOWS8622InE1CL5oPyXTgQlpUhslq9JnFTTNJl1ZahxNdfecttph93DDX2a43z+ReMvClkomJGfwEAhS6wfjftVgu5dwryfWmQAeL1sIoUtpsLwvMkFLw2UawrCShDRTRfqvJrtUseDUutdyRy+d2pe/CDJcrwL+LugKw/cSS9Wmkn1FRNtY/eHFMGu0I2yFhkR/RZgeSwWaQ6DGjrO6fPh4TokP+9X6Gdai6Nm7RuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyCAMEf+IYxaFmJc7JnBw5xLjvLsKXy8kIZWIZ24e28=;
 b=X0/Ho4jG8HD8rzAy6tYuWtuvVUZ9u6buGzuGqowyy0Geo00MBLDToY9TmFmEwVUDAWwCfcuP/KW6yhOGhC/3O2ES15EL1/sqemF/g7kv36ecZ1C1fFunhuIfTcv0QQg7RFH6hdu9qGLUPWQ2zUnZcDGB1V1nB+0+l+hKUX6Q+bBJ7MlZ8pNWKIiwgM4WLlrjyju7e66ulrYGp/iMs5/NNV4HsYbOafvclZZ1BNKSbhkeCIslBbssh+O7HJY9/0Rhq92XvCeytNN5B0u6f2RjtR2HtQhgMGDvnCabDDhIOWtlZFtJcRpZK+MSpVilF2IdSaE7UjdkKDESqnziJmkl2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom.dk; dmarc=pass action=none header.from=silicom.dk;
 dkim=pass header.d=silicom.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyCAMEf+IYxaFmJc7JnBw5xLjvLsKXy8kIZWIZ24e28=;
 b=w8WCTmhK97u3u48TzZ+zuYk4z3ooBJ0pI7nXS3fb48FGCG7Leux5Kmi9eJIIfodD6CuUGqivtu+85861y+ska3e9mWV5lQ5Xt5owWfCvkMJ06yrT6g92GsccNydXrq9UXmLI49EcpTtCKsnvG6iWLr3C9RIfIql0EM6eA+SHV2A=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=silicom.dk;
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15) by AM0PR04MB4706.eurprd04.prod.outlook.com
 (2603:10a6:208:c8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Mon, 8 Feb
 2021 13:28:56 +0000
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::58c9:a2cd:46c5:912e]) by AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::58c9:a2cd:46c5:912e%5]) with mapi id 15.20.3825.020; Mon, 8 Feb 2021
 13:28:56 +0000
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: add Silicom Denmark vendor id
Date:   Mon,  8 Feb 2021 14:28:32 +0100
Message-Id: <20210208132832.2833630-1-mhu@silicom.dk>
X-Mailer: git-send-email 2.29.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.17.218.86]
X-ClientProxiedBy: AM5PR0602CA0018.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::28) To AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 185.17.218.86 (185.17.218.86) by AM5PR0602CA0018.eurprd06.prod.outlook.com (2603:10a6:203:a3::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Mon, 8 Feb 2021 13:28:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 583896a2-4cb7-4640-e626-08d8cc357c24
X-MS-TrafficTypeDiagnostic: AM0PR04MB4706:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB47067C7FFE4D743212D7A106D58F9@AM0PR04MB4706.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4NrvoZ0VqV/wDZsrPA3SozYYoyOTLuWFqPYAqQm9Lw9G1TG6nFmy+0Sy6z2d5ihfbiK8DFaQufjsNzxBuBwOM8wgrxOF59tG0XCmbzDicD0cK9tJuHvEn92AD8ZmxAAs5O0K7Tnu407AaD3b1snlBGwQvclD/1wELtYa50LkpwP8ayDw/3Hen2OxaLkXNgbgh1RoE/Om9BiemX1Zf9pnMqdFbe7lTCDgg5qCOYBntna1+WDeN1WgrndG+ufCE/Tfd6lIAlPCdnKUuqtBsMpTMLsGTv61adXfiY/QPzzkqbcC3wdhM03W6A0JzNudag8RRXRYbhaY2/VOjex66E9m0XTRQksNRWFOSA5qR0Ul3+J1TCC1gM13YWVRaQe+1ci2YFibsNapHQZ30rPVlKukmJl9IT2u8+rYsPAVuhxfP6YG2QCTFdiI9vbTK5EsYceFyiVfmxDqXJ6x+ehPqE0CF9gvSwTgq7pfw3rHdTXTl/wlOyg6GFbsnSLfU+rm+r8AfcIvLlgjOEOQfnIJYAbrBXCWOQLWbq4L5m0TVLX7nC+jF4W0kYzpvB0w8SSdGEwGMEDqgLZzzIzyhVagXA/GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(39840400004)(376002)(8936002)(1076003)(4326008)(8976002)(2906002)(6916009)(83380400001)(36756003)(66556008)(5660300002)(8676002)(66476007)(956004)(66946007)(52116002)(66574015)(2616005)(478600001)(86362001)(6666004)(16576012)(4744005)(6486002)(16526019)(186003)(316002)(26005)(110011010);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?emR0T1B5SEF6NkpnSDZza0doZ1VETzdoelNDSEFIdDNJRnJ6em15UmhCQ3lF?=
 =?utf-8?B?aVJFRXlXM2cyTytyM1pZVFVSdnpueFFMemVoOHBxVmNsMXduQm8zcis5Rklp?=
 =?utf-8?B?QWh2cm1uZ1lkWTZtN0k5c21Dei9wNlYxUlR5cmZZM0JsODRscXVNQm9DMnRz?=
 =?utf-8?B?R05yTlVYdUI4d3pvRGVIcEYwSGI3b2N2MW1xZU52cTVNclhHc0dxUUF1bE1x?=
 =?utf-8?B?Rk8yMTJ0NHliQjZlakZCT3VEUUQxWjEySmxSVWlZNFd4UTNwR0RaR1QrUWMr?=
 =?utf-8?B?OWlDRlRzYUZLQ0RmdjlKZFBHN0ROSXB0QlNuQkJOUkFlaHgxMk1FU1cvR1dS?=
 =?utf-8?B?eS9ZNzRTZnJQVzM5aUVCY1pjUU1OWndOSVZrUWY0SFJDcVVlT3ViSDZQSUda?=
 =?utf-8?B?SS9kY0kyK0gzS0MxNHA2S1Y0dDh6UTBadXJkR2JYMno3UUxnN0V5VmxzeDA1?=
 =?utf-8?B?Mk1tazFVbnBXV1EzZ0dra1lxd3JtbUZ1c0lUT3pKQnhGUjlNRkx3ak42QWRK?=
 =?utf-8?B?dEVsQmJBRno3ZUJab1FYRFdMcWRrZjk1QmcrQTBCbjJsNVNRM25HVFQyNHFV?=
 =?utf-8?B?bFRqY0ZjTUZlRFMvMnB4ekVSZ3ZlRS9yNlNidnJmUVUycHBDbitUdm5TU3Jw?=
 =?utf-8?B?My9kdUlHVTNlaTRBbkhwR3FieWxKYnhYSzZGYmQrYW5uQnI5dUNhU0lweUM1?=
 =?utf-8?B?emZiVHZMd3R4cDRDMW8xb0NybWM2SmN4b1U5VndkT0p4cHRYczNkaVJ4cXVR?=
 =?utf-8?B?akJMd0x5VUo3dGhEZGN2NDBvS3RhV2JRV1RZRXgrZGxPeitQbXc5YjREUjh4?=
 =?utf-8?B?ZStWOGtCMHM5Nzc4alJCUkx4RFFva0hYdUYyNzljcVpmV3V4dHIya211Kzg1?=
 =?utf-8?B?NytYWjBxQ2xObmVNM3lOd1lHaUlmbGozOG1YYmQ3UjNRSzBRc1JsVjFqNStn?=
 =?utf-8?B?eDJvNHBac256YlE2MW9LQjZwRTl4QUJVRzJDdVRvenRzTUtYRjQya1pVOStE?=
 =?utf-8?B?OXE0NVhTT3V0YWxzRFhqUHdFZVVzbk5ldStoMHp1VUdiemt3YmtVWEF6S0gy?=
 =?utf-8?B?Yjd6TTZoVjMzSDRBaDNiVGowUVNXcS9reDJ3ZTAraTJsaWhiekdUeGxXZUJl?=
 =?utf-8?B?OFJnZUZSbmNiMkhDd0RXc0IyTlFRMkJCam1QNDBKZVY1a1ZVL1hETWd4NEJ3?=
 =?utf-8?B?NEJXSG5YQmJRVUF3TElHNVhkRzlweGFrN1BKY0x5c0ZPQUpyWExSUC9wMHF5?=
 =?utf-8?B?VmJZRVFscTRFdk9VNU5Naml1NGhNbXFkdXpiSjc0cCtZaitzWThDaTl1L1Q2?=
 =?utf-8?B?MlEvbzZVeGRXWmJmZW44QXZRZjFUS1RIV2w5OTZxY1RObmxkZEtaZWRnT1Rr?=
 =?utf-8?B?Y0lwdGZ6TXZQSHFOR0ZSV0xLZHhHdlhlTzVINkV1aDlPeW1vY2hUc2tjTzI3?=
 =?utf-8?B?TGpZemRIdEpreGhudSthL1E4VzFLa1FDWjJlRDlaTGJWYkxjK1pZOFZpY25L?=
 =?utf-8?B?eHA1SmEwelJ0dXMyWjE4R1hEcEJxcUh5bDYwYzBFU3ZoL2F3SnAzbHo3eFhi?=
 =?utf-8?B?RERwWE1VUWcyV1h3MHAzdk50ZWMydEJtaFF5ZVZRVUVxU25rRWczak1QS2pw?=
 =?utf-8?B?Q24xc0NWL2NUd00yNHo5Zkw4SmJrMWY2VUVKdkZoRk5qZmNHeGJJbmwvaVpq?=
 =?utf-8?B?YmFlMGtJS3M1OG5tYXRRNFI5L1grNjRuWmNrellDNGowcjJUYXkwOURFQStM?=
 =?utf-8?Q?gxt8rELMmzWTVCv08aEcxlJrmUnj1MSOE4+ROuJ?=
X-OriginatorOrg: silicom.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 583896a2-4cb7-4640-e626-08d8cc357c24
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 13:28:56.2650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ln8AE5CaT/3RBtP7Ov3LmojKK0caRKYN9MsEVjD26pFx7WaowMJGEThcD2YsmY9O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4706
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update pci_ids.h with the vendor id for Silicom Denmark.

Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d8156a5dbee8..aae07d512ca6 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2588,6 +2588,8 @@
 
 #define PCI_VENDOR_ID_REDHAT		0x1b36
 
+#define PCI_VENDOR_ID_SILICOM_DENMARK	0x1c2c
+
 #define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
 
 #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
-- 
2.29.2

