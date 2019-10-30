Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F07B9E9C5B
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2019 14:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfJ3Ndd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 30 Oct 2019 09:33:33 -0400
Received: from mail-oln040092255070.outbound.protection.outlook.com ([40.92.255.70]:6277
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726209AbfJ3Ndc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Oct 2019 09:33:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnPCKU0zBsDiZUtHU/L4zM/t5fQXeMUMPcYYvibIXX1brVEP9BwPkaufsyUX2S7gWNBWApwJkgSm3mYTDSA5X1gHtM3SHHp9gaBMvO6nApKiLDkMvnZOqY5g6yI9+10WWR8yKj/keO1zparSWOwQ4uAutH78udgcw/9pLZSE1Mrmys6u4I2IuBrP1vxhp3Wa4qREjXJOUqW6ajplhPUSSmx8aaameVNXXgGLznZc+ia6zQOPevzlIK0tzbqoFvBRWnq+Lck9ewzPeqOFIo5tuFHE9ULrJ9O00SDCWOQ/TFZN2BQe3h6Nc3ejygyV+n1OgZxX8tsmkAPB8vvBalRxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4Gh8YwSwiR8w/fQwxcW3u9Y6sgV3lGpEgGLJiEI6js=;
 b=dH5K0ELdav8p/80L4idp1pDe6V5PDNE+UQUw7yb/AXdIyNGOVTPNGazquGkd9uN4F3kpjZ1af7/wcE7LUajuuJMR9UI9zmzEQ7X26DI/HVuWehFwoDenPFPuLfHASI9eZLfXwxIloUObLN7kzmCKT3Da6WXnduVQuITnAU696UhiJi9rFSj5peBsqKB8chc1M8j98QEEXl+EbciQjSKUG00XB/T6FFyquQJDPQG1rVh2jFh2s6tXXvLDjBoaQoVpskDoOIGLbD5mCEbBPAg0EJg3XEZo4Iu1rMoEARcNxRRFqPHy6S5uyiRtIe2m9Ub9B9m7pUCTiaMD1qK+qzs3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT007.eop-APC01.prod.protection.outlook.com
 (10.152.252.51) by PU1APC01HT225.eop-APC01.prod.protection.outlook.com
 (10.152.253.175) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20; Wed, 30 Oct
 2019 13:33:26 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.54) by
 PU1APC01FT007.mail.protection.outlook.com (10.152.252.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.20 via Frontend Transport; Wed, 30 Oct 2019 13:33:26 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d%8]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 13:33:26 +0000
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
Thread-Index: AQHVjyA5XlOSuojfyUiAJcF9cam8n6dzLKaAgAACSIA=
Date:   Wed, 30 Oct 2019 13:33:26 +0000
Message-ID: <SL2P216MB0187F0B0630B8C5950342CA680600@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB0187C1ACBE716693FD5622BD80600@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20191030132509.GE2593@lahna.fi.intel.com>
In-Reply-To: <20191030132509.GE2593@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYXPR01CA0094.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::27) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:F52AFA575D31254C7445DBE8A2806C230F005C97C594D427CA13D94194C6DC86;UpperCasedChecksum:D5CB05B2A30EBCFC2308AC774244B49240E96965B7FDDEC36B294648D8515C05;SizeAsReceived:7735;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Ywuz2OsRPoimN5rxLvGHpIPGg4hXeV4zpDNwdDYIDjSaHPgotsuG0zA/LFoDyvmGK28Jb62sfOU=]
x-microsoft-original-message-id: <20191030133319.GB27719@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: PU1APC01HT225:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s/Sg7eGj1QEFv0d4lRIBj9IUZfwG0AyO1mz62Erk0Scib3tbBa7m5iOyh03U9F84QoJYwQvHEpPsnTyo11IOUKtaAIwPlS2Q0BqyFAYUbpiL/QhhBu4mHvcHkKJtK1w7kC4dNwHCvDd6yDkuikJnGoDFPiFQvenFG5WU9v5VE4FBcLU7vwbaXjS5ZWvbW7eU
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C72593C1E972854E9E712024F8C81492@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 53110f9c-889f-4462-1bfd-08d75d3dbe0d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 13:33:26.3660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT225
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 30, 2019 at 03:25:09PM +0200, mika.westerberg@linux.intel.com wrote:
> On Wed, Oct 30, 2019 at 12:47:44PM +0000, Nicholas Johnson wrote:
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
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Do I need to re-post with this line in it?

Cheers!
