Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A03EB5BE5B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 16:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfGAOdk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 1 Jul 2019 10:33:40 -0400
Received: from mail-oln040092255099.outbound.protection.outlook.com ([40.92.255.99]:55296
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727064AbfGAOdk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 10:33:40 -0400
Received: from SG2APC01FT116.eop-APC01.prod.protection.outlook.com
 (10.152.250.58) by SG2APC01HT206.eop-APC01.prod.protection.outlook.com
 (10.152.251.157) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.15; Mon, 1 Jul
 2019 14:33:34 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.250.59) by
 SG2APC01FT116.mail.protection.outlook.com (10.152.250.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Mon, 1 Jul 2019 14:33:34 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806%6]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 14:33:34 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v6 0/4] PCI: Patch series to support Thunderbolt without
 any BIOS support
Thread-Topic: [PATCH v6 0/4] PCI: Patch series to support Thunderbolt without
 any BIOS support
Thread-Index: AQHVEKroekXmwO/8K0mZzVmJDM4t6aadR3aAgBjLFwA=
Date:   Mon, 1 Jul 2019 14:33:34 +0000
Message-ID: <SL2P216MB0187E8F8592C37936D074B0F80F90@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <PS2P216MB0642AD5BCA377FDC5DCD8A7B80000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
 <20190615195604.GW13533@google.com>
In-Reply-To: <20190615195604.GW13533@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY2PR01CA0015.ausprd01.prod.outlook.com
 (2603:10c6:1:14::27) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:02F495DEDE9055371D4FF902BE9356D8A98945D611E9C3882DEC9BEB48EA05F6;UpperCasedChecksum:A685D2D3236C1CEBF2087A34EA8DFB59867388B2BFAD7A6FD613DCCA1F0BD0D1;SizeAsReceived:7891;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [GEFd3h9WTYzJFL1RIVZ02oOUp5ugg58pFsNtGi4cUGX67mOAbQfA1Uv5PZ/U0jb7yWpbcH6TRJs=]
x-microsoft-original-message-id: <20190701143323.GA5356@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:SG2APC01HT206;
x-ms-traffictypediagnostic: SG2APC01HT206:
x-microsoft-antispam-message-info: MoJ3+bqS2Xns/n5LHjhN4yip3zJboiFzzdQYn0TiUtxse3CSd1Djv6J3ZAenjOmX9Ng3VRT2VDUJgSOpXawIIFPdN9cjzaYI4MQPpZbquwnXQUmsrtX6uDr9ZjexYULwi0xYjITmL8UouLe+fR7IiAJ4dJIy1cQrF29uCYVkaY4ZqbsaAD5C14ITed4ht276
Content-Type: text/plain; charset="us-ascii"
Content-ID: <249187F61F1CD342A915EDAD3DBD0A58@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 12778708-7e96-4f8c-07a1-08d6fe3118d6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 14:33:34.6278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT206
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 16, 2019 at 03:56:19AM +0800, Bjorn Helgaas wrote:
> [+cc Ben, Logan]
> 
> Ben, Logan, since you're looking at the resource code, maybe you'd be
> interested in this as well?
> 
> On Wed, May 22, 2019 at 02:30:30PM +0000, Nicholas Johnson wrote:
> > Rebase patches to apply cleanly to 5.2-rc1 source. Remove patch for 
> > comment style cleanup as this has already been applied.
> 
> Thanks for rebasing these.
> 
> They do apply cleanly, but they seem to be base64-encoded MIME
> attachments, and I don't know how to make mutt extract them easily.  I
> had to save each patch attachment individually, apply it, insert the
> commit log manually, etc.
> 
> Is there any chance you could send the next series as plain-text
> patches?  That would be a lot easier for me.
> 
> > Anybody interested in testing, you can do so with:
> > 
> > a) Intel system with Thunderbolt 3 and native enumeration. The Gigabyte 
> > Z390 Designare is one of the most perfect for this that I have never had 
> > the opportunity to use - it does not even have the option for BIOS 
> > assisted enumeration present in the BIOS.
> > 
> > b) Any system with PCIe and the Gigabyte GC-TITAN RIDGE add-in card, 
> > jump the header as described and use kernel parameters like:
> > 
> > pci=assign-busses,hpbussize=0x33,realloc,hpmemsize=128M,hpmemprefsize=1G,nocrs 
> > pcie_ports=native
> > 
> > [optional] pci.dyndbg
> > 
> >     ___
> >  __/   \__
> > |o o o o o| When looking into the receptacle on back of PCIe card.
> > |_________| Jump pins 3 and 5.
> > 
> >  1 2 3 4 5
> > 
> > The Intel system is nice in that it should just work. The add-in card 
> > setup is nice in that you can go nuts and assign copious amounts of 
> > MMIO_PREF - can anybody show a Xeon Phi coprocessor with 16G BAR working 
> > in an eGPU enclosure with these patches?
> > 
> > However, if you specify the above kernel parameters on the Intel system, 
> > you should be able to override it to allocate more space.
> > 
> > Nicholas Johnson (4):
> >   PCI: Consider alignment of hot-added bridges when distributing
> >     available resources
> >   PCI: Modify extend_bridge_window() to set resource size directly
> >   PCI: Fix bug resulting in double hpmemsize being assigned to MMIO
> >     window
> >   PCI: Add pci=hpmemprefsize parameter to set MMIO_PREF size
> >     independently
> > 
> >  .../admin-guide/kernel-parameters.txt         |   7 +-
> >  drivers/pci/pci.c                             |  18 +-
> >  drivers/pci/setup-bus.c                       | 265 ++++++++++--------
> >  include/linux/pci.h                           |   3 +-
> >  4 files changed, 167 insertions(+), 126 deletions(-)
> > 
> > -- 
> > 2.20.1
> > 
I posted PATCH v7, finally. I needed a place to announce that the 
patches 1-2/8 which were made by Bjorn would not send with him as the 
"from" which seems to attribute the author.

Credits go to Bjorn for PATCH v7 1-2/8 (the first two patches) but to
send them I had to put myself in that field.

When applying them, I guess you will have to modify that field, Bjorn. 
My apologies if there was a way around it.

Thanks for all the comments and feedback from everybody.
