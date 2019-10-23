Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A949E158C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 11:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390436AbfJWJQU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 23 Oct 2019 05:16:20 -0400
Received: from mail-oln040092253093.outbound.protection.outlook.com ([40.92.253.93]:44266
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390367AbfJWJQU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 05:16:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaI9ad5oPMv2Poocc1YFlerD6LOe/om3bbMrtqdIhI6TCoBxt0BDAkYAR4k6HkHOQTNxmy471zVHnZGBDAsJW//rxcSY3XGcX06U/hf+wdpunapP1bCimtIrGERDCpVOObGywibhMutMxnvmNtoxj+6VnmY0mKkNHDtWXERpc5EUm0LdLmd11qJTxODllBzAWC2rtLrYyuhHWEItgD1jeRJOhpbbEvYThCMZ8+prq9+k3e9x/w2U5lYdxnFO9mV6gG/Lj7466Hq7l7v/u83RQcILam+52tfwYQo3co0h5MZBFjpUDSAjd4AGkhupCdJs5bicarR/xZQwE98WohAtrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NycifVh9sBjbR1wBmFPfH5YDYmsgbdEcT04g1mCDiQc=;
 b=EW42c9dIAxykkE+TaCX9e7AZyX+BRnzQ4Qfzr4W5fR4fsiT4gLc4FXDf/frs0UpfVzrNZST2nfB+NP6deW0gex2LoV48U2zo7FFhsIOyWVWoIs/CnVumXOKG12Thh2MHqLc4gqwKSQgnTz63UnHYJQgvuzOb6Ba6d+NFBKxfM2C+7bg3d6TU1CIZQP4Mr77/iJmMexUxrnKnSrHWmusBtfsrxDG4spbnmc3UlXfIqHXbMrviti8EMIip3PZfp9fplsIxBpljf7CB3aFJYbEEpPvccGOj78FRck9dsNWA3VoJIdJ+U34qZQT/vvfsqOxP7NYGoEBblbpJGlJ3cMranA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT024.eop-APC01.prod.protection.outlook.com
 (10.152.252.59) by PU1APC01HT017.eop-APC01.prod.protection.outlook.com
 (10.152.253.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.14; Wed, 23 Oct
 2019 09:16:15 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.52) by
 PU1APC01FT024.mail.protection.outlook.com (10.152.252.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.14 via Frontend Transport; Wed, 23 Oct 2019 09:16:14 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d%8]) with mapi id 15.20.2387.019; Wed, 23 Oct 2019
 09:16:11 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v8 4/6] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Topic: [PATCH v8 4/6] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Index: AQHVQ7E/8A75PE+Y1kKWz/bvvpr386dRGvuAgBdihQA=
Date:   Wed, 23 Oct 2019 09:16:10 +0000
Message-ID: <SL2P216MB018711E3699EE682FD4437E8806B0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB01879766498AA7746C2E5FB780C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20191008120907.GI2819@lahna.fi.intel.com>
In-Reply-To: <20191008120907.GI2819@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEXPR01CA0080.ausprd01.prod.outlook.com
 (2603:10c6:200:2d::13) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:F0922DFD55E2E5894AA624035E241984F1ECC0767E455AEA73B9084FADC6C7AA;UpperCasedChecksum:87A304CF412731D138425FAB808850D94F00337C675817C125251CBDB497AE17;SizeAsReceived:7811;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [8XzEoR9cmrxuUfV2+Whe56c4tIGmArMXFvJlRX3llKQ=]
x-microsoft-original-message-id: <20191023091542.GB4080@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: PU1APC01HT017:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fUl/7MuDs9YrneVQA0ZMTmOkMTUFbtfLHWNCRboP43u3n/+B7v7OnYRjlRzLn0a8rcIF8J5qj8fDv8drg7MuHmETAlBrz+voGxDBy9JUWD3hN+9bEFfySqK9/c2HOfREJnY1QYgdG+qYmKyPMeX0SiGN8TePpb9urOoSwCiiHD4e5Vtj65mBevToZvKNqlPu
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D0D3826CBE8E774BA2EA4C97A391E785@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d42ae68f-23ac-418b-8af1-08d757999c75
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 09:16:11.2150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT017
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 08, 2019 at 03:09:07PM +0300, mika.westerberg@linux.intel.com wrote:
> On Fri, Jul 26, 2019 at 12:54:22PM +0000, Nicholas Johnson wrote:
> > Remove checks for resource size in extend_bridge_window(). This is
> > necessary to allow the pci_bus_distribute_available_resources() to
> > function when the kernel parameter pci=hpmemsize=nn[KMG] is used to
> > allocate resources. Because the kernel parameter sets the size of all
> > hotplug bridges to be the same, there are problems when nested hotplug
> > bridges are encountered. Fitting a downstream hotplug bridge with size X
> > and normal bridges with size Y into parent hotplug bridge with size X is
> > impossible, and hence the downstream hotplug bridge needs to shrink to
> > fit into its parent.
> 
> Maybe you could show the topology here which needs shrinking.
> 
> > Add check for if bridge is extended or shrunken and adjust pci_dbg to
> > reflect this.
> > 
> > Reset the resource if its new size is zero (if we have run out of a
> > bridge window resource). If it is set to zero size and left, it can
> > cause significant problems when it comes to enabling devices.
> 
> Same comment here about explaining the "significant problems".
I have in the past, but because the problems are very hard to describe succinctly, it just turns into a 
nightmare. I can try to do it again.

> > 
> > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > ---
> >  drivers/pci/setup-bus.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index a072781ab..7e1dc892a 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1823,13 +1823,19 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
> 
> Since it is also shrinking now maybe name it adjust_bridge_window() instead?
I am happy to do this.

If we can drop the pci_dbg() calls, then I might be able to drop this 
function entirely. During the development of this patch, that is exactly 
what I did. How important are the pci_dbg calls to you?

Another option is to simply print something with pci_dbg that simply 
says the bridge size has been set to maximum possible while still 
fitting in parent. That will remove the need for logic to detect if it 
shrunk or extended.
