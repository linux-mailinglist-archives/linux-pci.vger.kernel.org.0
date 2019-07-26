Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFC6B76689
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2019 14:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfGZMxD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 26 Jul 2019 08:53:03 -0400
Received: from mail-oln040092254033.outbound.protection.outlook.com ([40.92.254.33]:24800
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfGZMxD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jul 2019 08:53:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXH9LSmdFTwi3Y5kR38S6+35eXdeZOD3mJy83yMqvRMmuRdPQxAhGYmShgV1RlXQMHS0C5p71xz6UHK/QcdCk7d0zr8K9wdsl375tle5nY7v4LEW65YBydTVci15y6dBskXf3s643aoVRzpTT0Z2UxCTk7eoIdRNgQC9Vn3Siucp6HwQFa5lcR9awEXSCplZUD2lbaO7yAoKKg4iYqr+1YFGZU199vwy77M1scFnQ1XWx6K2uLCWdrSp8ZnU3reY7MzbprG4gkO/OEmuGRzCa6Yb4ERgYiukZQ8E021+QYChuNpmmRCpRkxn/8m2WtnbIFuaEcVYIhHVCnBUYR+59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwyScT6p0CPb0Lyp5mnwzfwCHpMqnb5rRR/KS+tAkTY=;
 b=lDRaFgqojnxqnSDSqv2mty9fSf5m/PeIqeoNobvuu6l6BF/Cb74P9EtTMOVf7fn+cqnP0BbThMiMQVmtVCRxp2GqhyZcQI84Sc/mSs0HiTkxxEGT5Iz23b/JYVirT+aEDPgXI5Q83G+4O/JcQJsImDXdXXG7JDt+tpt03GxNCd1NnsDbhw1kD+xkpXwrSaKJwpplpV2LEelEMKvxaOtfn/DryDdKeWOf1OGI1P9jCLoOqC21bt4kfcu4JS22aFUqL1dP8MU4nqf/okd0HgbxYWoiw9M24hRB6QDd9osq8ACL65z3SBUC2tPHE/D+5rTzNrWaoUo1szdxEvheR56mZA==
ARC-Authentication-Results: i=1; mx.microsoft.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from PU1APC01FT060.eop-APC01.prod.protection.outlook.com
 (10.152.252.54) by PU1APC01HT058.eop-APC01.prod.protection.outlook.com
 (10.152.253.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.10; Fri, 26 Jul
 2019 12:52:58 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.59) by
 PU1APC01FT060.mail.protection.outlook.com (10.152.253.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2115.10 via Frontend Transport; Fri, 26 Jul 2019 12:52:58 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d%3]) with mapi id 15.20.2094.013; Fri, 26 Jul 2019
 12:52:58 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v8 0/6] Patch series to support Thunderbolt without any BIOS
 support
Thread-Topic: [PATCH v8 0/6] Patch series to support Thunderbolt without any
 BIOS support
Thread-Index: AQHVQ7EMFjpbQeqsQESrK2KNnG8LAg==
Date:   Fri, 26 Jul 2019 12:52:58 +0000
Message-ID: <SL2P216MB01873757CFAE0E4B02F1BBE080C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY2PR01CA0002.ausprd01.prod.outlook.com
 (2603:10c6:1:14::14) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:C1103906F62BFE2486639208E6571013AB303418B97FB837F76E5947D2EB556D;UpperCasedChecksum:17B2CDE6500E139C833C8900ECB5A1A411954DE05E9FC4BC8D9C4DD236F9301B;SizeAsReceived:7693;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [7Gsd+AuGlqD4wp1UvmI1+NiP77oqon8QLFMaDDmSK7iVDZw8xW3+K7kqGPU6wq/Z3rFkb2LLS24=]
x-microsoft-original-message-id: <20190726125240.GA2601@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT058;
x-ms-traffictypediagnostic: PU1APC01HT058:
x-microsoft-antispam-message-info: ELFtnrRCgenmnq7ObU+3V0fNzXhnwbWuuW78dOGFOKnUwfN70kXGFLe3SX9udOgU6tSci9LPY5rGsYLroHi3oMkpUIQlAioM9ypy1zo1dB5wjpMPOAU4hO6V191TymcIIAiB47FhiXmYA3S0g7ns3dUE84gh0aMTYDQOmGhVki5sMpUFK/19w+066bBnIVum
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EE73F2F33D98374CB83F39BE5C4B7289@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e03b37-567e-41bc-6f01-08d711c82f2c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 12:52:58.3365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT058
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Patch series rebased to 5.3-rc1.

If possible, please have a quick read over while I am away (2019-07-27
to mid 2019-08-04), so I can fix any mistakes or make simple changes to
get problems out of the way for a more thorough examination later.

Thanks!

Kind regards,
Nicholas

Nicholas Johnson (6):
  PCI: Consider alignment of hot-added bridges when distributing
    available resources
  PCI: In extend_bridge_window() change available to new_size
  PCI: Change extend_bridge_window() to set resource size directly
  PCI: Allow extend_bridge_window() to shrink resource if necessary
  PCI: Add hp_mmio_size and hp_mmio_pref_size parameters
  PCI: Fix bug resulting in double hpmemsize being assigned to MMIO
    window

 .../admin-guide/kernel-parameters.txt         |   9 +-
 drivers/pci/pci.c                             |  17 +-
 drivers/pci/setup-bus.c                       | 233 +++++++++---------
 include/linux/pci.h                           |   3 +-
 4 files changed, 143 insertions(+), 119 deletions(-)

-- 
2.22.0

