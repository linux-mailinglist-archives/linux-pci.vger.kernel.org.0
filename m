Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4E5FB221
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 15:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfKMOH1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Nov 2019 09:07:27 -0500
Received: from mail-oln040092253055.outbound.protection.outlook.com ([40.92.253.55]:5152
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbfKMOH0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 09:07:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePDwhG9e9NbuxWtoptQ5TBqYjOkNtw7YTj97/S3sF9TjiVAujQej1NHQzWNe3P2HUm/liJexFXhOns1k4xKy3v5Rd0++CiqWirRs4WCAMB+eJQSZ7FNxYdFGztwJatQXt97ZjUff2NzxCIJtTwipwdKxrWetShnq5kL141CZHt4bxZUL9e/KP9dexq606Y3VCacnYDn8v5mfREQQxi8wH6FIfW16SIJ9Sse3t5S3eqNVspw9rooIPdHF0n4xxzn/oTy3LqpVCLb+m+TsPuZ5ryG/zmkd29hZ9IMe5wyex4RC5a00ACxDkBZ1ofWAx15JedIADNFjbilXgBqPeuqmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrvnyCj2Zc7MvF3VWd8uMRpmLLnPrkZP8Ay1i3yY+XE=;
 b=cqvHvE/qaRd5QQeyK106PAhZxt4zNe4kwAugNVPdHhFl/ekd8a44rhiEFDO0gdtdv1laWeX66zDiQ0W75UKWCjZ2cek88vQkdDFvwwi83dx//7eJSDR72EMV2zuSEWcD72k0GZp5dDYFGAlkJexowmEcxbxvm0w1wNuUoytjvYy43h03s5aEcargXMg1FG8SBBpq0R869X3DMP88h9Fz8URdVOKmdRKcGVDyAhy1WTHmRm0q1AfbBGxfTaPu1/TP3WL8FizvEdUHHDTDqWit9iz0LLTY9PCAWpfPi5q8LMpvV9vRQijytJjp7Llq9HrqkSt54nFZVA8BzbI7DZZH3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT025.eop-APC01.prod.protection.outlook.com
 (10.152.250.59) by SG2APC01HT127.eop-APC01.prod.protection.outlook.com
 (10.152.251.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.22; Wed, 13 Nov
 2019 14:07:21 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.250.51) by
 SG2APC01FT025.mail.protection.outlook.com (10.152.250.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22 via Frontend Transport; Wed, 13 Nov 2019 14:07:21 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 14:07:21 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v11 0/4] Patch series to assist Thunderbolt allocation with
 kernel parameters
Thread-Topic: [PATCH v11 0/4] Patch series to assist Thunderbolt allocation
 with kernel parameters
Thread-Index: AQHVmiuq7Kku4MzQ9E+b/MIHWt5ZKw==
Date:   Wed, 13 Nov 2019 14:07:21 +0000
Message-ID: <PS2P216MB0755D487E0027CF30493E02B80760@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0038.ausprd01.prod.outlook.com
 (2603:10c6:10:4::26) To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:3A4D0549735BEE1C102BAA9E5948307284D18736882594E1264C6C9492A74D3A;UpperCasedChecksum:2A4975F642BC259F460BC686AE96B6508BCCC6154A0CEC7D6AF0D1A268669808;SizeAsReceived:7686;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [tbngIBZw3V9TSGEsJuDmQqkFQPx28vpcyJdBB5HKcZ/SlOCFBU/PIkKm/Oc0RI/u2QImk+iMoXI=]
x-microsoft-original-message-id: <20191113140711.GA3814@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: bf8f560f-b220-4723-f25b-08d76842ccb4
x-ms-exchange-slblob-mailprops: q+fD6XS3/ULDBPt9unTKEKrrKClZJydFUfZgkDLwljlhEka6XenXQ6vLOj80v0YAtUg7cU9FjBBmI3cQvGvfo0li+vza1XIQroCiJGQpX+QBBqRF//vTEvSg/VLWx/3jtcmWCBRuFwIsvk2HXQZQLcDLgbqLpDFbzckbNT4lZyKTU3oCAA3OrSx/P18nd3WVlMRIxLddR0PjVFnTVIcZU6O5LE/ya9ByiHoBPsxn0IVaOUtt/Bgc2k2xRRpQ2SxUGfjPPMjxRViCiT3spKxx+T05SNT0oROMLKTlQjlB/LAyo7jSwKmyzH1ZIg5G4C0TqAewqyazX2E+YJzxcVOzFKDalbPP9VsaciJ7cYZF8qsCoYDSEdZtoClCnJl8rTog4BLYhMOUqvesrITNmT2Q4LPszzRljfnihpyn95a9ZHIZjudo8bREPEjZqvKpj0bMLUvW85pj5k+xOp2T8Z9H2oT+2m+aYwSX5fIU6bnZZKjEvcZsv35DxoDOsofyLyXGv/XBxtUoiBlZFbtwih1YKvwVThpS77ZXNlwyYdXRpAC0Bxt+NM3nw/2QqWj+MZKa0JYjkmlZXsVXboAovUnQPDBAgA97hCWTBoRglvJzzDul+21pHhsU41zuRRtAl53wnjxAUuvOfUQKMOIqr8Yy19y/b45nUhz+bBqV9hrDH1hzwa9JVHm9GwB3l6Ws6m3zmiSQa/yjRg3uh4U+UbNSbw==
x-ms-traffictypediagnostic: SG2APC01HT127:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5BPDF6pZt/SSHnGY1b/ZhUbw8VC83SsRuFGWdvfHeMzmew5amE2VYDUYRonkfI4o7Zp0Q0MGSXhXiJhS95C5+l5lO2Li+dBjY7KE+/892bTFmnlMxE2dUETkDAPcgBRm51gnoZLKi8/SnNL8q4NntRwX29htRF0NPggfinuXubfAbGLYIwbBvyKbA2nmAdui
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A63E1BFD1432284C9A8140BC9DB14168@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8f560f-b220-4723-f25b-08d76842ccb4
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 14:07:21.0584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT127
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Accidentally sent out patches which still had "PATCH v9" unchanged - 
should have been changed to "PATCH v11". No changes for most of them, 
but that might cause confusion, so re-doing now. My apologies for 
unnecessary spam.

Since last time:

No significant changes. Re-post to get attention and to level out the 
patch version numbers (some in the series had been incremented and 
others stayed the same).

Change name of patch series. In hindsight, this will not "support" 
Thunderbolt with no BIOS. It helps, though - it makes it usable.

Something I have not gotten to work is sleep. Suspending tends to crash 
the computer if Thunderbolt devices are attached at the time (without 
the BIOS support). I have tried to modify the Thunderbolt driver to hit 
up the pcie2tbt mailbox on Titan Ridge, but to no avail. There might be 
a PERST_N in GPIO which needs asserting - which is difficult.

Nicholas Johnson (4):
  PCI: Consider alignment of hot-added bridges when distributing
    available resources
  PCI: In extend_bridge_window() change available to new_size
  PCI: Change extend_bridge_window() to set resource size directly
  PCI: Allow extend_bridge_window() to shrink resource if necessary

 drivers/pci/setup-bus.c | 178 +++++++++++++++++++---------------------
 1 file changed, 86 insertions(+), 92 deletions(-)

-- 
2.24.0

