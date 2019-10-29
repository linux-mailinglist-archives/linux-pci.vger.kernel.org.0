Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5246E8BC3
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 16:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389967AbfJ2P2G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 29 Oct 2019 11:28:06 -0400
Received: from mail-oln040092253053.outbound.protection.outlook.com ([40.92.253.53]:34113
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389975AbfJ2P2G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 11:28:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzp48Y28OvQnu2LLnZmuIsKlRLuwDm0Ohn4o4DAIoV+/cZ69f/whSUX7zdZHrkifwKXPUa3sQX2EuYE/UJ60z51z+xDNmZbF4v849Frd6jqqVcP8z5IklrHVUr3muK++zDHDvgvwD+2rYkrKeWcQzG+IlB8NPvHcQhb+1P3vodZkvs3eU17XtpsYTPmpOYewEof6T4Aww0EvkpMmANZC7cUNUCoyZhjX2GwX175nfGGbtDr2t6fDJ2J0DSCTv1IW+REm2IQDpQS0WK9ds0rAAZOAa3/bK/OXUbjFwGth/SLSP0tBYUrZ0jMlGt9zqgFKVBWG31jweYsAmv0XRaoAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nm6czOgb+ChSBWDJEie23stQRa1AQMI4M9FNrPIYBWs=;
 b=TMWbohl/0Km7v/ltKetJTOkgYxuZq/XekfvdAvwxOcWCm1yVTupUheem1hOQhuftrV543kp/zmk5q0YNHAM9JOPeYoUxnshiDCaXJASAFkwvamJ/9CwjPyZpiP5K0mHs9oMqrY+GaeWFr0YrfJxoSfBSlIVgH73QZa12dn37bbT2v6YvodL2CssJXenxlmSQrztEz/JZeFI1Yck1b1XCtP9qiU9CwZWZ8l9qJkFJ6MiSiyFAo8Wn4M8I3+h5AUXeSlzYgjP3BDDuaQqAQuUUvEzGA5YPr5B9aMPV3DN/PBfeADaLehr4kDhpgqCuqZYNFwZm88BucHsC0mIXgllVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT018.eop-APC01.prod.protection.outlook.com
 (10.152.252.52) by PU1APC01HT036.eop-APC01.prod.protection.outlook.com
 (10.152.253.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20; Tue, 29 Oct
 2019 15:27:59 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.53) by
 PU1APC01FT018.mail.protection.outlook.com (10.152.253.189) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Tue, 29 Oct 2019 15:27:59 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d%8]) with mapi id 15.20.2387.028; Tue, 29 Oct 2019
 15:27:59 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v9 0/4] PCI: Patch series to support Thunderbolt without any
 BIOS support
Thread-Topic: [PATCH v9 0/4] PCI: Patch series to support Thunderbolt without
 any BIOS support
Thread-Index: AQHVjm1xplapXFmZIkCq3Hpwmc2uSQ==
Date:   Tue, 29 Oct 2019 15:27:59 +0000
Message-ID: <SL2P216MB01877B771222A6E1699D14F480610@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY3PR01CA0084.ausprd01.prod.outlook.com
 (2603:10c6:0:19::17) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:91745C2D76E02F26978D3A05B3F8020673FB9D7E54A3878040C638631CEAE437;UpperCasedChecksum:6761C367EEA246311420D29B56CBD5CDF930F9C8ABDAC1A04DBE1CA0B3D5AA29;SizeAsReceived:7522;Count:46
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [uMjUQEL97shVgVs3/Nx7cZpvR4PZpQplgrJbSC4ecojXMrKGt5br6Aqf53kwOazW98nIv4PYjTI=]
x-microsoft-original-message-id: <20191029152750.GA1909@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 46
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: PU1APC01HT036:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uxxxfep8NdZ8bXiXzHakO5YRJGIC76Z8IIhVDUCiucdQG12DIM8Fw7vT+7sStC6iPPuTHsU/LkVD2+Ig4DCiQG7TpiNeCPp2XAK95ShIkAyDaQmKmd4He2NEsPYOcZB69YVl2/OACfJFNsOOJRw4U3sElKAviGygcTGmyTKbivIBH9KM7jBiMYBneL4XUGug
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7BC39385E2C6545927FD4FC0650470F@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b96cd4d-88ca-4013-ff3c-08d75c849430
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 15:27:59.2559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT036
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since last time:

Broken off two patches from the series to be dealt with separately.

Adding const like Mika suggested gives compile warning due to
pci_resource_alignment() function.

Does it matter that the dates on my patches might be out of date? I do
not normally re-create them.

I do "git am patchfile" and then do "git commit --amend ."

It is late and I am tired, so apologies if I have forgotten to fix some
things or made mistakes. If I do not get it done, I will keep putting it
off.

Thanks to all reviewers.

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

