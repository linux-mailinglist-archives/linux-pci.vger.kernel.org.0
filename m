Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C96E145E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 10:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390183AbfJWIhF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 23 Oct 2019 04:37:05 -0400
Received: from mail-oln040092253103.outbound.protection.outlook.com ([40.92.253.103]:22016
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390231AbfJWIhF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 04:37:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tozzed29u41jNQbPWpgr+FEj7l6hdW5eNrcufXTmiRI9svfs4cpvtVRjNrLcYYoyNUIa+3tuGIcuhmc6JU4gmVcut3QkbDNLCRsspydxpyd7BES6QwdKwvUcUI54UNOrZIT+66aSIOXtG5HJavc31d/Qh/MXsXwLmzwZFrIbIoVqTj0lOhPb+/+VqMx2Z5ljR3Y13H4KB6Stm6WyBJoZ3W9rBGFUa7Z3ndqPwIz9QuDxOX5Z4HWnaPkBxTbNZqRhsjBhwr9NQ9MRnx9sE6g381z23E77WXf+ftCNMlNGNf9TSVCRMuZg7/82CdUZFxverIe0/+y7svlKf3a3KeEGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijCFpU/c0wAaTc+jGxyCj1GTWL1HE0mVaDXliaO3W0k=;
 b=YSO1/UDG8V36hBcUc7qGiY0ySwy94lCljYrDsFlo+Hll1eLbXuwJO4rU+MQB4ZVJethDoQvn18wReqXW8FDDdSlUCgD31ex3t7c6m3TZKR/IiCPlsASBTIAP8lfADgsoFDajQZAOHYeM2jXn+rtzqcFX4W0sh7CxnTEqS3NJoGNL37t6E3kbiohwEH5q4Lbo9NspmMQxAkmpedz/TvoneJwvv6P6jLOKqxqDwh0RQTiQ3y2GpMQp5jQKdNjuv2mFkd4ZTbIqDz4MPRb5m7fz0br5uCOzHGpBFmCUNR3RdtJTdVxBNJT7tvyJJ3uHsAwj5PezmAcC+aTPglaNwLIe1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT009.eop-APC01.prod.protection.outlook.com
 (10.152.252.56) by PU1APC01HT124.eop-APC01.prod.protection.outlook.com
 (10.152.253.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.14; Wed, 23 Oct
 2019 08:36:59 +0000
Received: from PSXP216MB0183.KORP216.PROD.OUTLOOK.COM (10.152.252.54) by
 PU1APC01FT009.mail.protection.outlook.com (10.152.252.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.14 via Frontend Transport; Wed, 23 Oct 2019 08:36:59 +0000
Received: from PSXP216MB0183.KORP216.PROD.OUTLOOK.COM
 ([fe80::707c:4884:c137:2266]) by PSXP216MB0183.KORP216.PROD.OUTLOOK.COM
 ([fe80::707c:4884:c137:2266%5]) with mapi id 15.20.2367.025; Wed, 23 Oct 2019
 08:36:59 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH 0/1] Add support for setting MMIO PREF hotplug bridge size
Thread-Topic: [PATCH 0/1] Add support for setting MMIO PREF hotplug bridge
 size
Thread-Index: AQHViX0IscNJYyHchk6j0ubA//SaQA==
Date:   Wed, 23 Oct 2019 08:36:59 +0000
Message-ID: <PSXP216MB01832E0DD8892B52A3FA2589806B0@PSXP216MB0183.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0110.ausprd01.prod.outlook.com
 (2603:10c6:201:2c::26) To PSXP216MB0183.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:b::17)
x-incomingtopheadermarker: OriginalChecksum:A56C3385AC70E360929D0003897C35202BA7E0CBFB80A5900E24EEDDB78B5516;UpperCasedChecksum:D6F2A8E27BDBCEC2C1341999D481193C6C96DA42CA3C4909A8F52CE3231879CB;SizeAsReceived:7765;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [ISr/nj35f9JQUpCE+STkcUX9EzAiB5YwVpct4TQ9VaI=]
x-microsoft-original-message-id: <20191023083650.GA3836@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: PU1APC01HT124:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /xBkDUPpkVUwuCz0XctBcPZKZxWCZHTULzK1JAklo5NAC+ehOQa17LMVl02GKXlx3XglwOLGlclrLlOx5hL4EmxOm6v7+qgDZcUVrSEf5fo1LW5FOTHRsreYQKXx62ASD/uyeCIAZGHJBvh+nHmI5EluXE2lU3+0Vlj+YS6rbt793XTO3Er+SlA+enZhym2t
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F17C8EFC3714BF45B732D1B50D45C45D@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f9231436-7176-4eeb-9af8-08d757942b26
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 08:36:59.2328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT124
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds support for two new kernel parameters. This patch has
been in the making for quite some time, and has changed several times
based on feedback.

I realised I was making the mistake of putting it as part of my
Thunderbolt patch series. Although the other patches in the series are
very important for my goal, I realised that they are just a heap of
patches that are not Thunderbolt-specific. The only thing that is
Thunderbolt-related is the intended use case.

I hope that posting this alone can ease the difficulty of reviewing it.

Nicholas Johnson (1):
  PCI: Add hp_mmio_size and hp_mmio_pref_size parameters

 .../admin-guide/kernel-parameters.txt         |  9 ++++++-
 drivers/pci/pci.c                             | 17 ++++++++++---
 drivers/pci/pci.h                             |  3 ++-
 drivers/pci/setup-bus.c                       | 25 +++++++++++--------
 4 files changed, 38 insertions(+), 16 deletions(-)

-- 
2.23.0

