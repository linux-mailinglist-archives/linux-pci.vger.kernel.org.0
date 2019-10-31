Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F89CEB2D1
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 15:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfJaOeY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 31 Oct 2019 10:34:24 -0400
Received: from mail-oln040092255043.outbound.protection.outlook.com ([40.92.255.43]:6157
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727841AbfJaOeX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Oct 2019 10:34:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZ/znk2yaEW9ovnUHnyj83aLjLgmt/76e2T4XLRM3znpv0x7V+nqx5nvaVSfftBjvewofFheUeV8uGA84xAJGgKAO6M5AITNT/gd4kHt/8l1mTlQnRK0XMwjKxMUCrDR9YWnMDAsWSDME2/bSFfo2g4+j1Vy1wyIaUcvprpvYkQ2zyPdvzAgA8JrD6mVdKaq1xudjrnuM3jRfak31GeSB3Js9JbPRvRJDm9sthfbzF/pvNkwNGyI4yeyBwAdknUtq6CRdOYDuN+b41WkPqaCKL2tpALm13bKR4vExdpaypep+taveghMPPRqOBysX2KnfHesRTuRNC1pIOey43wSKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAQ+ruhUKwJ58jSPWe58F24IO2i6iBCdkFE7K/0CqIs=;
 b=m8sv+6PJX+thfky47zgfxmYODSCL8I//0WtR8PFDm11CFdbWx+eU8lLyulmp1rZ3PEINaK6Gk2XtE0XKP1pCILpbZCZ/sbq6GBliyD3P4RflzQB1t2PGVEugGzSfWNN+EiT2foEWO8R0PkZ705vwlrVh2ZdUgoYAk8tODYSGsZ5mML8NtH2YfQ8lnkZUt5uXe+IHC3Oli0cHoh2Vo3nHN2VxMnrpTwi8WfoqFv4mqqBI9aCpQ6dZg+c+ki4jeJByKd3+/L/VoiIiD1ApArRIEgjDuInXevuHaH0d97ZMxcsj4QphErQGMzbHAmnJu5dlDfUAnjYQ7CBe7Qx4zwwkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT132.eop-APC01.prod.protection.outlook.com
 (10.152.250.52) by SG2APC01HT193.eop-APC01.prod.protection.outlook.com
 (10.152.251.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20; Thu, 31 Oct
 2019 14:34:18 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.250.59) by
 SG2APC01FT132.mail.protection.outlook.com (10.152.250.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Thu, 31 Oct 2019 14:34:18 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d%8]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 14:34:18 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v10 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Topic: [PATCH v10 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Index: AQHVjyA5XlOSuojfyUiAJcF9cam8n6dzLKaAgAACSICAAASQgIABnsSA
Date:   Thu, 31 Oct 2019 14:34:18 +0000
Message-ID: <SL2P216MB0187930B744883ACBE240E0C80630@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB0187C1ACBE716693FD5622BD80600@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20191030132509.GE2593@lahna.fi.intel.com>
 <SL2P216MB0187F0B0630B8C5950342CA680600@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20191030134939.GG2593@lahna.fi.intel.com>
In-Reply-To: <20191030134939.GG2593@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYCP282CA0003.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::15) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:6349FE8F4213501951F8ECE1B6E340CF50B6E352CD732BA3C571F23EFEB8A8E3;UpperCasedChecksum:A5A6254C6EDAD22F0FBC0F2195292CC2F2269B8581FE2F0DAA3FADADD7EB9166;SizeAsReceived:7880;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [K9b4y/DDjgfEt446qthShDeLjx3Tu2KgfJhwSZChl/CR4I/Oh+Cl6nJm9Iu4wOV4PqYYqo5rtkM=]
x-microsoft-original-message-id: <20191031143409.GA1488@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: SG2APC01HT193:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: askCfHotqdToEitjwcbc/eL0NuJ0nZ5Lvir/mum2DUgsyeDqhj1EoT9cGmNJuCdV1FVOsZDBX3k3dzkRLHBGEsmqzVmPqGqge/Y97wasc7DjkTvqgTBlccZDQVKinsKtxCZtgwWo2snhLCGzrJqXCVeu4PgxyNxHPJELF8s0qySTV+zDVsxlxwL8MsASu8NY
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E14240BF8C0CD14A813F835577C31F71@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b41e100f-4105-4544-d590-08d75e0f68f2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 14:34:18.2236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT193
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 30, 2019 at 03:49:39PM +0200, mika.westerberg@linux.intel.com wrote:
> On Wed, Oct 30, 2019 at 01:33:26PM +0000, Nicholas Johnson wrote:
> > On Wed, Oct 30, 2019 at 03:25:09PM +0200, mika.westerberg@linux.intel.com wrote:
> > > On Wed, Oct 30, 2019 at 12:47:44PM +0000, Nicholas Johnson wrote:
> > > > Remove checks for resource size in extend_bridge_window(). This is
> > > > necessary to allow the pci_bus_distribute_available_resources() to
> > > > function when the kernel parameter pci=hpmemsize=nn[KMG] is used to
> > > > allocate resources. Because the kernel parameter sets the size of all
> > > > hotplug bridges to be the same, there are problems when nested hotplug
> > > > bridges are encountered. Fitting a downstream hotplug bridge with size X
> > > > and normal bridges with non-zero size Y into parent hotplug bridge with
> > > > size X is impossible, and hence the downstream hotplug bridge needs to
> > > > shrink to fit into its parent.
> > > > 
> > > > Add check for if bridge is extended or shrunken and adjust pci_dbg to
> > > > reflect this.
> > > > 
> > > > Reset the resource if its new size is zero (if we have run out of a
> > > > bridge window resource) to prevent the PCI resource assignment code from
> > > > attempting to assign a zero-sized resource.
> > > > 
> > > > Rename extend_bridge_window() to adjust_bridge_window() to reflect the
> > > > fact that the window can now shrink.
> > > > 
> > > > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > > 
> > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Do I need to re-post with this line in it?
> 
> No. Typically maintainers add these when they apply the patch.
Cheers, only 1/4 (the biggest one) is left to review. I will try to post 
the patch for the bugfix again soon, also.
