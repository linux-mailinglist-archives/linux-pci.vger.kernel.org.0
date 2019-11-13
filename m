Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C00CFB1DC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 14:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKMN4R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Nov 2019 08:56:17 -0500
Received: from mail-oln040092253082.outbound.protection.outlook.com ([40.92.253.82]:17760
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbfKMN4R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 08:56:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qk/pkKL8ogy/F5rmhcjo5c/8KWOKVN30YwUNoHqW8Sn5JNNVYji7oUBpqQ9yef245MIjqC9MmJ94GmEJiF+rr3yGX1elaEqRcRJip3MIU0O0gVlw+Byr4CAE/5cEvfJA3J6D3agg9spwPS5SoISQJGyZY0YVvNnsL4gwbZ2bON6IR4zitQCiMULCz7BThTYxZYwBrZDTmGNrkc/EpwWtiIClv1cJ1Akafqrvc6Pp/S8vq5Zrx3XIyNEHAXCcrkp+Rdj/vzWmorpMKLXo3dSQ+TjJFbwQzk+lSWb+8A/EEl2khhcui6ud9T1wQSjieQn1ehNeajNMKP6SyAriQdG8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1B3yIIyn3XPONTST2wm3/CuT3jDW2scLl/wmZDSjOk=;
 b=O3Nm7pWp5X6kHguMDlBMgMsQIEP41Wz5GKbWQ41uOhGnt6Ef4ZXvvB1lLsHngcZqrs1tANIFihPuCrN9JyglP8iLtpuLI1PjVo5FAVmidxYRSh9ht812sWjirIpM5EhAdM8VJD5yFsO4qxLLbYR8ixaScof9Vart3RUrPPrim8CWFIvy4fHSqaxvWiWsuzU9JWXnFvYkS4lMDEY6F+pWUYb1GOg0Rlh5VhxZHWFD/uahqaPzuuJ7552AkcCHvASwj05TS4KK2S7vsWt+wI35jLk0HJO/bMY0wiFLXNJQo8v1WhEwNP7TUdB3/UW4qYH0kgenMOoZXrwnJyzEdLH+xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT035.eop-APC01.prod.protection.outlook.com
 (10.152.252.57) by PU1APC01HT090.eop-APC01.prod.protection.outlook.com
 (10.152.253.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.23; Wed, 13 Nov
 2019 13:56:10 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT035.mail.protection.outlook.com (10.152.252.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2451.23 via Frontend Transport; Wed, 13 Nov 2019 13:56:10 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 13:56:10 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v11 0/4] PCI: Patch series to assist Thunderbolt without any
 BIOS support
Thread-Topic: [PATCH v11 0/4] PCI: Patch series to assist Thunderbolt without
 any BIOS support
Thread-Index: AQHVmioaSa7sHk62RkSBash/x84tLQ==
Date:   Wed, 13 Nov 2019 13:56:10 +0000
Message-ID: <PS2P216MB07557ACBAFA091DDCAAC092280760@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY3PR01CA0080.ausprd01.prod.outlook.com
 (2603:10c6:0:19::13) To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:72F60432BA65C74500069CA3850DF7A4931B52D6AEAC8C9E3EAE5571131F242B;UpperCasedChecksum:65B6C477ADECCAEAF20156F49880D2747101B4EC03C0EBBD19EEF20463D0974D;SizeAsReceived:7683;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Z7OQFnI2exrgUNTDPxi1AD2GpkFvuQb+DHXnwVYRt4q44tkw9qIqK8+2BAY4TN6vG/xtlDyKP98=]
x-microsoft-original-message-id: <20191113135601.GA3213@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 986341e7-44c2-429f-5c40-08d768413cdf
x-ms-exchange-slblob-mailprops: S/btQ8cKWiQDZtlYU9il0pMWV3cqP7KMfBAtXkrnx6JbtCB+m2FilDgaPwdF2IDGIX40yl8OsZ8aE+aI3iDGcI2tVvGHk3BcbqBa9hdWWdDaAWa9DUPIyC+yZvXUDqqqgH/DSMgpLk0MUbrjqxu2qW6xylqWvzkx0gZ21Cw++pMu4UYjoL/UjfVwlYtMajWK9jW5V69y2e1MxslDd8qOKqWfuD9SJuSWGRYSCvYx6+YWog1f/xacgAaLOd47IMWZxmUlLHoUEf5DQUn0p16l378Tqk+NbE4MdDGbDpSWdpsA/NB2c1dt4Aop+5vnOT8ymQv5iogc/JIqkqcSrg+Ja06uJS15hCVPHI6kf7GGi95wHjx0BKAAWLix5BzkI+NSy3b91EhQ9C5N1qJxbmrFQIpXqFrpiVfGJn3frACRZTl1fBOzF8mBfH73Tf73qH938+Smy7qPsXa62CTazIC4lLZZp5FBlbgsXsHsFfvOQ3mlAZ/iGY5Nan3QFcbECaXoJoMH5Fl+UnAE68lC4aLpepq8roMBOLOLmW3bDlyOuxL19KDm85IPdJHO9YJPcRqVwj9Q2U9ZB4urSGs6wcX2meTbRtb7Ed2rAKkECiYRsZ+Cb+t9YR48j4I+e0pR0uxXSDctsgkcaANMhYGj4h5c21/y9pWrFE1Zcd+nvYwZdlIVk0lF0L/X+nNK/ehrZ0aNi99KV7DZBYOSwym9oagdr5lXlTys+ueKxwJ6MHiV2229+7mJSDd6IMmeqVWpiti+QBim1d+jiIQ=
x-ms-traffictypediagnostic: PU1APC01HT090:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +vTUqCY4egEWcgdt/5AIWw/hkLCtQwhXY3k31CSf1mzc9/fFjMVIVeZhCELOkzgVoQw3yE72xusa8I49iqciSYtHUcmUVZ8ca9t7wligasfoN/1kjHulFEfhGq+e/6U1wsbZnmGS3ooKLaKlBUu2njWSK1+68HIa9GxO8Thoygitj/u8+xjvb5O/D4v5L1sd
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2439EDFED505314291A2107D518382E2@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 986341e7-44c2-429f-5c40-08d768413cdf
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 13:56:10.4016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT090
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

 drivers/pci/setup-bus.c | 182 +++++++++++++++++++---------------------
 1 file changed, 88 insertions(+), 94 deletions(-)

-- 
2.23.0

