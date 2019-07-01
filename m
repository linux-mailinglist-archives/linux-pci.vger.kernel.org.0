Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E49D05BDF0
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 16:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfGAOSJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 1 Jul 2019 10:18:09 -0400
Received: from mail-oln040092255098.outbound.protection.outlook.com ([40.92.255.98]:31066
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726863AbfGAOSJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 10:18:09 -0400
Received: from HK2APC01FT011.eop-APC01.prod.protection.outlook.com
 (10.152.248.56) by HK2APC01HT068.eop-APC01.prod.protection.outlook.com
 (10.152.249.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.15; Mon, 1 Jul
 2019 14:18:03 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.248.53) by
 HK2APC01FT011.mail.protection.outlook.com (10.152.248.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Mon, 1 Jul 2019 14:18:03 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806%6]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 14:18:03 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v7 0/7] PCI: Patch series to support Thunderbolt without any
 BIOS support
Thread-Topic: [PATCH v7 0/7] PCI: Patch series to support Thunderbolt without
 any BIOS support
Thread-Index: AQHVMBfLfzRSw534mkaIXXTWn4hhHg==
Date:   Mon, 1 Jul 2019 14:18:03 +0000
Message-ID: <SL2P216MB01873398C2BCB7766E09A6BD80F90@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY2PR01CA0040.ausprd01.prod.outlook.com
 (2603:10c6:1:15::28) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:D41B0092CBA4B5B72454FD4FBA53CCE83B6641CD516FF56A62EA64DA2E701D80;UpperCasedChecksum:5A6212CC06D63F71E20C90E551A182A0C050595E6093F3D70AC59F6F8BB87F51;SizeAsReceived:7711;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [bdHwIDgXhXsH/mz5eSWClGMK15eWcSKE5uEtkSCB7JVmnt7glSLG3JDmgYKFbU8+I1Mcz7vC9rk=]
x-microsoft-original-message-id: <20190701141747.GA4939@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT068;
x-ms-traffictypediagnostic: HK2APC01HT068:
x-microsoft-antispam-message-info: arv7vAb5nDGYtkHekNKFZZhOdxV2DCzr3/xaxOhR9PhnelLkWYjw9+7b7gFmBBWwCBI3hD9D2ak8u+2TiwTm3lOZp+470NTWEd1sIYB7tYCq3EFJPw8z1GsDV5utRyRk9CNq7YkpsW3iHM0vj7afuGjxcvdcmdTvzJh0O63CKPwa9R4B36w6cB7wI8zvq91u
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2A7385515CE2D24896256C578940F804@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 62546e7e-0a9d-422a-d322-08d6fe2eedba
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 14:18:03.2790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT068
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Included patches from Bjorn. I had already started my own equivalent
patches, but it will be easier for Bjorn to sign off if he wrote them.

Moved the bug fix to the end of the series, in case we accept Logan's
equivalent patch instead - in which case, the last patch in my series
can easily be dropped.

I split the [previously 2/4] patch into two, in the hope it can make
things easier.

We are running out of time and do not have high hopes of hitting this
merge window, other than perhaps Bjorn's 1-2 and my 3 which solves Mika
Westerberg's bug. That would be a win for me, and would make things
easier next cycle.

Hopefully I addressed as many of the concerns raised as possible with
this series.

There was no response so I went with kernel parameters hpmmiosize and
hpmmioprefsize which fits in with hpiosize. The existing hpmemsize
remains unchanged.

I still have no idea why my git send-email is messing with the encoding,
when it works for everybody else - but I will use "mutt -H" in the mean
time, which we tested to be working.

I have tried to test this as extensively as I can but I fear I may have
left silly mistakes, or forgotten to make all of the requested changes.
My apologies in advance if any slip through.

Bjorn Helgaas (2):
  PCI: Simplify pci_bus_distribute_available_resources()
  PCI: Skip resource distribution when no hotplug bridges

Nicholas Johnson (5):
  PCI: Consider alignment of hot-added bridges when distributing
    available resources
  PCI: Allow extend_bridge_window() to shrink resource if necessary
  PCI: Change extend_bridge_window() to set resource size directly
  PCI: Add hp_mmio_size and hp_mmio_pref_size parameters
  PCI: Fix bug resulting in double hpmemsize being assigned to MMIO
    window

 .../admin-guide/kernel-parameters.txt         |   8 +-
 drivers/pci/pci.c                             |  17 +-
 drivers/pci/setup-bus.c                       | 247 +++++++++---------
 include/linux/pci.h                           |   3 +-
 4 files changed, 150 insertions(+), 125 deletions(-)

-- 
2.20.1

