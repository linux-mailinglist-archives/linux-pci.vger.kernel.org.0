Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 290FEE19A3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 14:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfJWMMQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 23 Oct 2019 08:12:16 -0400
Received: from mail-oln040092253026.outbound.protection.outlook.com ([40.92.253.26]:7196
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731256AbfJWMMQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 08:12:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adgMa9YA7mJgBdR4pAkYb+GufdxI+FjbtQWOmUCDB/ms8CgUtnWyH7di5RNZT4sDJq/eNgVgYJ/4ttK1GpBTlHe/D4R69H+O2sGxmbYa9P3o4st6JYCiG2J0GX7lgqToyVZCGw452eAv8jm7FD52YIxWsfnmt5xThZ4oq/yb22zsAmFEaucyVwqVuLY/Ww2TjgnwsRXBqQ3gUTphfE8+4AeYXYxBhqBYC7zqfWKsFGnX63bdYIvj/sH7gCGlizpOyw2MTAnD68QdIku4/rhyCdnjdIGfrP/i6KFyHZre8eR/6uofqR1VCd7A/9T5JmhA0ulvRsKDcQiWFGI4yitCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRiag2uO8KjRKbAMIAsa7rjMRhr1NmNw9n0SHcHfVfs=;
 b=SQmXxYBmwOe5gZYfQrjJcLIw/ZjZ8GbKV1875E/1/dgt+M6/gDzuA/fIxVYEFNFczC2rorYr+ls+nayBI63s9XmbyIjB7fjOyk4CLilLETp4T4NfNDxtsCT4mF2ltR8I8G9ogpAPzQykuy/5X4UoTMB1EZtKNiEGg5epWGLxqIVafiw351hfrtj+y/XpurvaCIBnNqQPnCHnARKcQLT4BauHKAhduoODKU9ffZSvfFF6fBzaYeYJq1nNWnyqwa6EAiUzS/HOjANad8INbUzgbNPbt8ZWaveZUeMDND4wBH9sW0HBJoupe9btI9NYCRaDL55kPg9VliZk0qvjcuzcwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT009.eop-APC01.prod.protection.outlook.com
 (10.152.252.51) by PU1APC01HT187.eop-APC01.prod.protection.outlook.com
 (10.152.253.156) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20; Wed, 23 Oct
 2019 12:12:08 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.58) by
 PU1APC01FT009.mail.protection.outlook.com (10.152.252.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.20 via Frontend Transport; Wed, 23 Oct 2019 12:12:08 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d%8]) with mapi id 15.20.2387.019; Wed, 23 Oct 2019
 12:12:08 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v2 0/1] Add support for setting MMIO PREF hotplug bridge size
Thread-Topic: [PATCH v2 0/1] Add support for setting MMIO PREF hotplug bridge
 size
Thread-Index: AQHViZsXphsMXuppp0aaaQoMHzlyXg==
Date:   Wed, 23 Oct 2019 12:12:08 +0000
Message-ID: <SL2P216MB018771B6A7F60532F99701A5806B0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0061.ausprd01.prod.outlook.com
 (2603:10c6:201:2b::25) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:45804B272D53CAF31E0C92CC6A35308795D33E288EDDE13B907CBEE1EBC00AFA;UpperCasedChecksum:5743AF275284E57C3478AF756258883AC3DC4017569B8F403CC8106352F86BD3;SizeAsReceived:7440;Count:46
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [hbKaN7I7B2huM9B/JilA1Wd55gYykHAzlsLqQWS/mOQ=]
x-microsoft-original-message-id: <20191023121200.GA18691@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 46
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: PU1APC01HT187:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JDRyLXjT+Ij5JVRXBKSWifc4G6XJS4En4IqEA5ZFWsQu5egbw7P5S0ZvQh8bCTBWiq3wR9TGfkhy3bTuLYiZNIPqDD+G6PrutRYjZq91PypzGQaXRguQL51hJKJuVt8OZ2ajdXEbjQZEIjTsuzfKwRpGY4dWX9YsRxLaJFydX2wK/pBCr2/URt3cDyzQNko9
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EFB97436A88363448907DE42F96E2AA8@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c03555e9-4c55-4807-5672-08d757b239b4
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 12:12:08.2898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT187
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since the first revision of this patch:

Ignoring 80-character line limit based on the advice of Mika Westerberg.

Mika noticed that memparse is modifying the str in pci_setup. Looking at
the definition in lib/cmdline.c line 125, he is probably correct. I have
no idea how this did not cause problems in testing.

Fixed the alignment of some overflow lines.

It turns out Outlook is causing my encoding issues with git send-email.

If I get a new email for kernel development, what should it be? Gmail
works, but looks tackier.

Nicholas Johnson (1):
  PCI: Add hp_mmio_size and hp_mmio_pref_size parameters

 .../admin-guide/kernel-parameters.txt         |  9 ++++++-
 drivers/pci/pci.c                             | 13 +++++++---
 drivers/pci/pci.h                             |  3 ++-
 drivers/pci/setup-bus.c                       | 24 ++++++++++---------
 4 files changed, 33 insertions(+), 16 deletions(-)

-- 
2.23.0

