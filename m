Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41FD14C4AA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 02:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfFTA4T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 19 Jun 2019 20:56:19 -0400
Received: from mail-oln040092253081.outbound.protection.outlook.com ([40.92.253.81]:30018
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726096AbfFTA4T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 20:56:19 -0400
Received: from SG2APC01FT004.eop-APC01.prod.protection.outlook.com
 (10.152.250.57) by SG2APC01HT076.eop-APC01.prod.protection.outlook.com
 (10.152.251.173) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1987.11; Thu, 20 Jun
 2019 00:56:14 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.250.54) by
 SG2APC01FT004.mail.protection.outlook.com (10.152.250.163) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1987.11 via Frontend Transport; Thu, 20 Jun 2019 00:56:14 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::8c3b:f424:c69d:527e]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::8c3b:f424:c69d:527e%3]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 00:56:13 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 4/4] PCI:
 Add pci=hpmemprefsize parameter to set MMIO_PREF size independently]
Thread-Topic: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 4/4] PCI:
 Add pci=hpmemprefsize parameter to set MMIO_PREF size independently]
Thread-Index: AQHVJqdtisSX95SZEkGuUZAlsxs7iaajL4kAgACJCQA=
Date:   Thu, 20 Jun 2019 00:56:13 +0000
Message-ID: <SL2P216MB01875B40093190DBB6C4CBB780E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB018784C16CC1903DF2CEDCB880E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <a473bee0-0a25-64d5-bd29-1d5bdc43d027@deltatee.com>
In-Reply-To: <a473bee0-0a25-64d5-bd29-1d5bdc43d027@deltatee.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYAPR01CA0041.ausprd01.prod.outlook.com (2603:10c6:1:1::29)
 To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:39326B2376E86E82CE73BA5CDFBDFB06147FBBD36081BB01A206E118ABC27B38;UpperCasedChecksum:D528E797C0E175D349863115B3360F6B257C4C235BE1D93D6116CB7CA0D08F32;SizeAsReceived:7846;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [D6PoS+OltHsQsVkl5nAL+If+Mnj5pUEq3pYuxBwoWiESVau5H1GzDEDDGii7ccYxebgQMAGZ7N4=]
x-microsoft-original-message-id: <20190620005603.GB3149@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:SG2APC01HT076;
x-ms-traffictypediagnostic: SG2APC01HT076:
x-microsoft-antispam-message-info: KolCLRMgmdRoMB/6qKCXHz1P5WBDm40CIkB92CY6u5Vi0gqRYHAMDjCOJNis6hVyRwsrUbLO51g+Ej6kU/4r62zbA1H1lbCj3e8Q+p9DJ80Dds16tC/RknjgkeD7SLHx5M++m5BdOE+fOy+JBCLxEauugFXleGg6POTktQMIxS2LpmxprL6+ojcc26AfaEwW
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E360D0A269AC8F4DAC4E04A227AEEB53@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d01221-5bea-45ad-6f4a-08d6f51a176d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 00:56:13.3879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT076
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 19, 2019 at 10:45:38AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-06-19 8:01 a.m., Nicholas Johnson wrote:
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
> > Date: Thu, 23 May 2019 06:29:28 +0800
> > From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > To: linux-kernel@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, mika.westerberg@linux.intel.com, corbet@lwn.net, Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > Subject: [PATCH v6 4/4] PCI: Add pci=hpmemprefsize parameter to set MMIO_PREF size independently
> > X-Mailer: git-send-email 2.19.1
> > 
> > Add kernel parameter pci=hpmemprefsize=nn[KMG] to control MMIO_PREF size
> > for PCI hotplug bridges.
> 
> Makes sense.
> 
> > Change behaviour of pci=hpmemsize=nn[KMG] to not set MMIO_PREF size if
> > hpmempref has been specified, rather than controlling both MMIO and
> > MMIO_PREF sizes unconditionally.
> 
> I don't think I like that fact that hpmemsize behaves differently if
> hpmempref size is specfied before it. I'd probably suggest having three
> parameters: hpmemsize which sets both as it always has, a pref one and a
> regular one which each set one of parameters.

It does not matter if hpmempref is specified before or after hpmemsize. 
I made sure of that.

Originally, I proposed to depreciate hpiosize, hpmemsize, and introduce: 
hp_io_size, hp_mmio_size, hp_mmio_pref_size, each controlling its own 
window exclusively.

The patch had the old parameters work with a warning, and if the new 
ones were specified, they would override the old ones. Then, after a few 
kernel releases, the old ones could be removed.

Bjorn insisted that there be nil changes which break the existing 
parameters, and the solution he requested was to leave hpmemsize to work 
exactly the same (controlling both MMIO and MMIO_PREF), unless 
hpmemprefsize is given, which will take control of MMIO_PREF from 
hpmemsize.

From a maintainer's perspective, I see where he is coming from, 
particularly if the changes were to backfire and cause disruptions in 
existing setups in the event of a kernel upgrade. What we are left with 
is not optimal, but it will work.

(Assuming this is accepted): In the future, if somebody were to come up 
with a convincing argument to alter this, the patch to make each 
parameter solely control its own window would be miniscule and easy to 
sign off.

Cheers

> 
> Logan
