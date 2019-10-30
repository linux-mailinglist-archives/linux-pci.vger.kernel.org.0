Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC4AE9C30
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2019 14:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfJ3NWu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 30 Oct 2019 09:22:50 -0400
Received: from mail-oln040092254065.outbound.protection.outlook.com ([40.92.254.65]:56234
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbfJ3NWu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Oct 2019 09:22:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+2wrZstnkgU+3r5It3Ab5MR7ZVInU68a+6eP13YYsHbQKY/c77BVCFcie8xbcTXOLzOBxgaiaeCbe+DKvPb0tj5XacUtjCQqOyTkBNtprpDnS1+MZZcrl95Pk54VvUrs02lNyd6fdo4BzQVGotN8dXEh8ncBWlmDIzj3PbUmmK4rbUrjV+8FlHhCFP6CV+Af9NkCiL7GauLs92OkLRI56JntJUQ2o+QcC13A0WIT8EZgJhqgxMzTPS14ug1PtzW50wwfq8/InWs9ix6FaHZsvD40AXW9ZwWP1Q2rFuZHGg7AeseSwgSQTM2qWQKjOUU7z14sTu2PsLH/9LnKL20NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynlcacdcuwEaK2nEncg0gM4UkSoSNfYujkpgk+B74j0=;
 b=cZpLzsJZ2qgTCX/0AmXIuknrnT/qBPGnd3HzVPlZ0g/WGI7zdPDjMhmu1J7lHHeIreHFh7Cg35OW6q6OlC3+NA0PDQAWUozIlt3P5B1BiROUhRQdUozSS9OR2ZLt8gAzwGJ5TEl/1Ons6RnWqFPfHfR2zp+vUaMBGtRSJv1TLYzEC5BUe+vpk8rHckT5lzO50vUVsb7pnqZ0ULOwtwloqo5Bcm3MUPviiH2NDgxyJ+375o4U81YSMkc1700tAlkg9BDfNSTGkP0iQprSL4BasB/nAvONttB/30fImsdk4+HnOnjHQlbIeKw2jhZprWorcWK+Mjw79241T+oU+iVCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT057.eop-APC01.prod.protection.outlook.com
 (10.152.252.58) by PU1APC01HT047.eop-APC01.prod.protection.outlook.com
 (10.152.253.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20; Wed, 30 Oct
 2019 13:22:45 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.55) by
 PU1APC01FT057.mail.protection.outlook.com (10.152.253.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.20 via Frontend Transport; Wed, 30 Oct 2019 13:22:45 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d%8]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 13:22:45 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v9 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Topic: [PATCH v9 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Index: AQHVjm2j6KwuziponkGop9V32ZF1J6dzGDuAgAAVG4A=
Date:   Wed, 30 Oct 2019 13:22:44 +0000
Message-ID: <SL2P216MB018746C15E0262862D428C1480600@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB018739B339B453DE872DB71E80610@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20191030120705.GC2593@lahna.fi.intel.com>
In-Reply-To: <20191030120705.GC2593@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0108.ausprd01.prod.outlook.com
 (2603:10c6:10:1::24) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:9D53416EACB1DF86D9C8A1ECC5ADCA5892582068D1D608FF53189FDA068AE937;UpperCasedChecksum:6B62D25C89F168A497CE03236BE4802829DB0594E8B6C04BA86C88F4AE563A25;SizeAsReceived:7748;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [DdNjAGrKnSZH53kiIy2UcjhMLxXKJDtu0OHz/htpjNryfAgU0FTmlFatLwRsrR1Da7TYjhAgN4g=]
x-microsoft-original-message-id: <20191030132237.GA27719@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: PU1APC01HT047:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /nGUYWaDWHwUIY9An4up6q/TyevDjG4HY+ls5+PhDzQnnsrRhRYlMUEiJc3eXc0jT2zwM4TFzQOPePb+rQSWqEZdnH8ZFAQRNNl+Ah3P4vI8SYFxox31tH85P0OH9qGoGu5e+UcNd5mO0uaR7UYfkuZSae/GHuglsuBpNAlORZvioJJPo4diWTHWa33wJRNu
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AD622C2030C7064B86E3FF71276DC5CE@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f588a32-13c5-4ffe-3200-08d75d3c3fba
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 13:22:44.9370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT047
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 30, 2019 at 02:07:05PM +0200, mika.westerberg@linux.intel.com wrote:
> On Tue, Oct 29, 2019 at 03:29:21PM +0000, Nicholas Johnson wrote:
> > Remove checks for resource size in extend_bridge_window(). This is
> > necessary to allow the pci_bus_distribute_available_resources() to
> > function when the kernel parameter pci=hpmemsize=nn[KMG] is used to
> > allocate resources. Because the kernel parameter sets the size of all
> > hotplug bridges to be the same, there are problems when nested hotplug
> > bridges are encountered. Fitting a downstream hotplug bridge with size X
> > and normal bridges with non-zero size Y into parent hotplug bridge with
> > size X is impossible, and hence the downstream hotplug bridge needs to
> > shrink to fit into its parent.
> > 
> > Add check for if bridge is extended or shrunken and adjust pci_dbg to
> > reflect this.
> > 
> > Reset the resource if its new size is zero (if we have run out of a
> > bridge window resource) to prevent the PCI resource assignment code from
> > attempting to assign a zero-sized resource.
> > 
> > Rename extend_bridge_window() to adjust_bridge_window() to reflect the
> > fact that the window can now shrink.
> > 
> > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > ---
> >  drivers/pci/setup-bus.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index fe8b2c715..f8cd54584 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1814,7 +1814,7 @@ void __init pci_assign_unassigned_resources(void)
> >  	}
> >  }
> >  
> > -static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
> > +static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
> >  				 struct list_head *add_list,
> >  				 resource_size_t new_size)
> >  {
> > @@ -1823,13 +1823,20 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
> >  	if (res->parent)
> >  		return;
> >  
> > -	if (resource_size(res) >= new_size)
> > -		return;
> > +	if (new_size > resource_size(res)) {
> > +		add_size = new_size - resource_size(res);
> > +		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
> > +			&add_size);
> > +	} else if (new_size < resource_size(res)) {
> > +		add_size = resource_size(res) - new_size;
> > +		pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
> > +			&add_size);
> > +	}
> 
> Do we need to care about new_size == resource_size(res)?
Sorry, I skipped over this before re-posting. If we are not changing the 
size, does it need to be logged in pci_dbg? I could change it to ">=", 
meaning if the size does not change then it will be "extended" by 0 in 
pci_dbg.

Let me know if you wish for this to happen. But I am easy either way.

If you are fine with how it is, PATCH v10 should have addressed 
everything so far.
> 
> Also there are several calls of resource_size(res) above so probably
> worth storing it into a helper variable.
> 
> > -	add_size = new_size - resource_size(res);
> > -	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res, &add_size);
> >  	res->end = res->start + new_size - 1;
> >  	remove_from_list(add_list, res);
> > +	if (!new_size)
> > +		reset_resource(res);
> >  }
Cheers
