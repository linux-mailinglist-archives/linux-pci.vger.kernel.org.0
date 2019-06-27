Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53FFF57D7A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 09:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfF0Huj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 27 Jun 2019 03:50:39 -0400
Received: from mail-oln040092255070.outbound.protection.outlook.com ([40.92.255.70]:47264
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfF0Huj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jun 2019 03:50:39 -0400
Received: from PU1APC01FT039.eop-APC01.prod.protection.outlook.com
 (10.152.252.54) by PU1APC01HT176.eop-APC01.prod.protection.outlook.com
 (10.152.253.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.15; Thu, 27 Jun
 2019 07:50:34 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.51) by
 PU1APC01FT039.mail.protection.outlook.com (10.152.253.127) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Thu, 27 Jun 2019 07:50:34 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806%6]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 07:50:34 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 3/4] PCI:
 Fix bug resulting in double hpmemsize being assigned to MMIO window]
Thread-Topic: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 3/4] PCI:
 Fix bug resulting in double hpmemsize being assigned to MMIO window]
Thread-Index: AQHVJqddn+2PwrSPpkW3hy382qHokKajKMGAgAwD5wA=
Date:   Thu, 27 Jun 2019 07:50:34 +0000
Message-ID: <SL2P216MB0187E3E3A8307DF01B04020D80FD0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB01874DFDDBDE49B935A9B1B380E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <e768271e-9455-2a3d-ad76-4a6d9c71d669@deltatee.com>
In-Reply-To: <e768271e-9455-2a3d-ad76-4a6d9c71d669@deltatee.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY2PR01CA0025.ausprd01.prod.outlook.com
 (2603:10c6:1:15::13) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:3126F02D5E681196562C224996201390864D017BFF2BF82B0AF23732B13AB26A;UpperCasedChecksum:F11EE72412A421339BD7D51F0E5F3EC65ACD02A3DDD23C5ECEFC49DC5578DB5B;SizeAsReceived:7870;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [A9MQgcqjXC6gu9A7cwboCiZ8iD3Z1MzHtJWjMhX+5jWudxX5NrEVujuBi8ft0nFb3i66e7nDdH4=]
x-microsoft-original-message-id: <20190627075024.GB5604@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT176;
x-ms-traffictypediagnostic: PU1APC01HT176:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-message-info: 2OMsLn79HM78sX980GWRp8Wz7pmhLLBFrFckURpF5cOiBoY7ee4OAbEURyIh9xkEAVPzER6apsMvcTiv3Q1lgd3s2dipL0MmIL8ydHSWg/NIOO7oK302lv30Fi/ZDXTI3ZZ1tvcFM7jxZNpPYRSrjTzehkcpZIo4HjyWBsHDLbZy+qPv9/wYKm0MUndblxJI
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E4FF4645E7119E429BCF3400E1C95A89@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: adefef6a-c2e4-48cd-7e1b-08d6fad42270
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 07:50:34.2396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT176
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 19, 2019 at 10:21:21AM -0600, Logan Gunthorpe wrote:
> *(cc'd back Bjorn and the list)
> 
> On 2019-06-19 8:00 a.m., Nicholas Johnson wrote:
> > Hi Ben and Logan,
> > 
> > It looks like my git send-email has been not working correctly since I
> > started trying to get these patches accepted. I may have remedied this
> > now, but I have seen that Logan tried to find these patches and failed.
> > So as a courtesy until I post PATCH v7 (hopefully correctly, this time),
> > I am forwarding you the patches. I hope you like them. I would love to 
> > know of any concerns or questions you may have, and / or what happens if 
> > you test them. Thanks and all the best!
> > 
> > ----- Forwarded message from Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au> -----
> > 
> > Date: Thu, 23 May 2019 06:29:27 +0800
> > From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > To: linux-kernel@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, mika.westerberg@linux.intel.com, corbet@lwn.net, Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > Subject: [PATCH v6 3/4] PCI: Fix bug resulting in double hpmemsize being assigned to MMIO window
> > X-Mailer: git-send-email 2.19.1
> > 
> > Background
> > ==========================================================================
> > 
> > Solve bug report:
> > https://bugzilla.kernel.org/show_bug.cgi?id=203243
> 
> This is all kinds of confusing... the bug report just seems to be a copy
> of the patch set. The description of the actual symptoms of the problem
> appears to be missing from all of it.
> 
> > Currently, the kernel can sometimes assign the MMIO_PREF window
> > additional size into the MMIO window, resulting in double the MMIO
> > additional size, even if the MMIO_PREF window was successful.
> > 
> > This happens if in the first pass, the MMIO_PREF succeeds but the MMIO
> > fails. In the next pass, because MMIO_PREF is already assigned, the
> > attempt to assign MMIO_PREF returns an error code instead of success
> > (nothing more to do, already allocated).
> > 
> > Example of problem (more context can be found in the bug report URL):
> > 
> > Mainline kernel:
> > pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0xa00fffff] = 256M
> > pci 0000:06:04.0: BAR 14: assigned [mem 0xa0200000-0xb01fffff] = 256M
> > 
> > Patched kernel:
> > pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0x980fffff] = 128M
> > pci 0000:06:04.0: BAR 14: assigned [mem 0x98200000-0xa01fffff] = 128M
> > 
> > This was using pci=realloc,hpmemsize=128M,nocrs - on the same machine
> > with the same configuration, with a Ubuntu mainline kernel and a kernel
> > patched with this patch series.
> > 
> > This patch is vital for the next patch in the series. The next patch
> > allows the user to specify MMIO and MMIO_PREF independently. If the
> > MMIO_PREF is set to be very large, this bug will end up more than
> > doubling the MMIO size. The bug results in the MMIO_PREF being added to
> > the MMIO window, which means doubling if MMIO_PREF size == MMIO size.
> > With a large MMIO_PREF, without this patch, the MMIO window will likely
> > fail to be assigned altogether due to lack of 32-bit address space.
> > 
> > Patch notes
> > ==========================================================================
> > 
> > Change find_free_bus_resource() to not skip assigned resources with
> > non-null parent.
> > 
> > Add checks in pbus_size_io() and pbus_size_mem() to return success if
> > resource returned from find_free_bus_resource() is already allocated.
> > 
> > This avoids pbus_size_io() and pbus_size_mem() returning error code to
> > __pci_bus_size_bridges() when a resource has been successfully assigned
> > in a previous pass. This fixes the existing behaviour where space for a
> > resource could be reserved multiple times in different parent bridge
> > windows. This also greatly reduces the number of failed BAR messages in
> > dmesg when Linux assigns resources.
> 
> This patch looks like the same bug that I tracked down earlier but I
> solved in a slightly different way. See this patch[1] which is still
> under review. Can you maybe test it and see if it solves the same problem?
> 
> Thanks,
> 
> Logan
> 
> [1]
> https://lore.kernel.org/lkml/20190531171216.20532-2-logang@deltatee.com/T/#u
[1] says Reported-by: Kit Chow, but I cannot find the bug report on 
bugzilla.kernel.org - should I be linking the bug reports into my 
version of this patch in case it is accepted?

Bjorn never replied to my queries about which should be accepted and 
what I should do either way. For now I am moving my version of this 
patch to the end of my series so that it can easily be knocked off if 
Bjorn prefers your patch.

Cheers

Nicholas
