Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D1713CB6B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 18:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgAORzW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 15 Jan 2020 12:55:22 -0500
Received: from mail-oln040092254041.outbound.protection.outlook.com ([40.92.254.41]:6165
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbgAORzV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 12:55:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TH4DHm8tzd2BcDZY3jCexdct8X29JgK4T1SR9CoZ3fHM22lLjo10FcSaZQzOyEsqQrqiD1O9lvvkQOR6OiLIzIeIduOHpN94muxECPIBTc9S4UHgV/wTuIixQ7f0/kOZox5ttN8atVQQAozJPQdCKEC2CjALS/p6echVON1lxhiklU+Qb+6MQ5X4ephCxR/a2Q9rThEaODCY8x4tp8WOP0ccIu0xx2wVQvExH20bgQffc4xSIzrZ7oJL1TEFmvD3C++oVuA8bqxdFEHdMDt0zcvwVX3CSsDefpaPHizmlr83017I178kZxTyBxvEbJENkNj1WwWMBUa7PWbd13UuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwrHrs3hsBumaJ66DLtUIOXyRW1kkvuywmlrXO/fibU=;
 b=fo0psRQ76ceRSkl+9X82maUcEMCBSrbdHDJE4Agnd+8B2zWffjHV4j+yYGiaE/0QRf4aPDJ/YjoIW/opxZOtQtzRVXZsMgj96UtqZYncR650RsqpBpwAN1UrJM0abPTiF8jp7tD771kC8314z2iD4VdsSE2gYahHkIqGp1G4Dy9KHltuOWVVg6Ae3QL5dC4dtL0qFVPuvk1lpIaXA2FB9gXz7MLWB36dHwk7XhMPe/0c/vZP9Cnx97mHfvg4XEcHSU8XFL2yt4tJ3MhU7sXVeUYXFGBooknpgqsBUNmDcUyo+vgNAeAAeAQ0QKbtH8kPAGNDLUDdaDEGsz/+RWOrRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT115.eop-APC01.prod.protection.outlook.com
 (10.152.252.51) by PU1APC01HT158.eop-APC01.prod.protection.outlook.com
 (10.152.252.185) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Wed, 15 Jan
 2020 17:55:17 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT115.mail.protection.outlook.com (10.152.252.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Wed, 15 Jan 2020 17:55:17 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2623.018; Wed, 15 Jan
 2020 17:55:17 +0000
Received: from nicholas-dell-linux (61.69.138.108) by ME2PR01CA0124.ausprd01.prod.outlook.com (2603:10c6:201:2e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Wed, 15 Jan 2020 17:55:14 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v2 0/3] PCI: Fix failure to assign BARs with alignment >1M
 with Thunderbolt
Thread-Topic: [PATCH v2 0/3] PCI: Fix failure to assign BARs with alignment
 >1M with Thunderbolt
Thread-Index: AQHVy8zxsAcuWcBVnUOaHrWI/O9uwg==
Date:   Wed, 15 Jan 2020 17:55:17 +0000
Message-ID: <PSXP216MB04387C41E6734CC4DEA9846280370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0124.ausprd01.prod.outlook.com
 (2603:10c6:201:2e::16) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:9BCD66280E596EBA588BBAB7CAF578C2700EF1CBE08D7DC6E68A4118C9CA2220;UpperCasedChecksum:1FBC8856690AEC71C1D8D695B7B9AB1CDC9E4DCB257F1B498C3775709184686F;SizeAsReceived:7798;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [tccJdBO/fWgCSAz8DQY7D2G/iSgcXRf1]
x-microsoft-original-message-id: <20200115175508.GA4503@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: f12dca4c-660d-47e2-74d9-08d799e4144b
x-ms-exchange-slblob-mailprops: mBy7Mai7yE5NBIk4d/kkaYf19Kf5IaBB2ougQ3QCcMIjZyL4I2r/u3GZgbZ6LJJKYtR9hPJk37ZennVP2juFXXLWsJHLAP4lTdVlGYxJhy9kLWcQkQZaPb0kuNjJa0Dw383gRwenq0vfOZH3AffhU/yAMqc87JrWv+TA06UPmha13Ca/WwGa9eXa0laKveHHTXwVxzL8Dfbh0JUrBjovRsY2C/sPlRSsmNpiWsBLdngSSXoz+WIgED+f9duIdrhAy64RCxOz6N2/63N+ReFSMvmMEhsXp+/KJuEihD4Z2n6OTsD5DT47NAGY7H4NuKkZmh+5xNvvG1a2nh3zsWJrhAtvKcHKOFgyk9/spICRDz10jmR3zsr5kfPsi7lum/NGz6VaztZjj3W818FeNgEEeBekh1CU1jp8adGkhA4tdfPdIGxiNLngJINgK7ENAeiwEGZhGru45KFHZEuFcdiywfZDQYPigTthrshv2d2Ra77Yi+Vf5CWl8Cmi+LeRqNBwQHNWoBOekIbvCRTCoSWiW1GM5FCg3DWa/0fx5VvZJswK9n7Jc8msMueNiIY70oLAIKZpunXa+pTkdJW4sracsvvYTkgLTTHqUE/wCeqbV0NSnFxPNUACtfWpImtZfgHSQDWD54ZWwUSanS8bm88WJAjp8glvVzVEX1B5bZYm43N4Z9oNXOaBhSfMWinGE9hC+rK41pBuyn6SdkpAqEz9cdfH5LXRk282
x-ms-traffictypediagnostic: PU1APC01HT158:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q8A5eiQmGvK0nPCDgDHbxNtvLdCVmlJKRXNrQsuoxkR1xoV4lYDJvFK5ZmivC5vzKPSvytTaYbxvtz2aY+ijVh1FRjluw6QmG+zG2Ovr/6gWKMUdLGWbcYepBpIRtIZhkO3HyAxmGUTk6ydOT7v5SiP7o+DLEfYJQdmfamP+rMUppOzL45hRq3qIQmDUYnk2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8A9B1EE179975A4DB1177E45C0110F1C@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f12dca4c-660d-47e2-74d9-08d799e4144b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 17:55:17.2045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT158
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tiny changes:
	- Add Mika Westerberg's Reviewed-by: tags which he gave.
	- Change commit description slightly in 2/3.

Nicholas Johnson (3):
  PCI: Remove redundant brackets in
    pci_bus_distribute_available_resources()
  PCI: Change pci_bus_distribute_available_resources() args to struct
    resource
  PCI: Consider alignment of hot-added bridges when distributing
    available resources

 drivers/pci/setup-bus.c | 106 +++++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 45 deletions(-)

-- 
2.25.0

