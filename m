Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94950101217
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 04:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfKSDRM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 18 Nov 2019 22:17:12 -0500
Received: from mail-oln040092255077.outbound.protection.outlook.com ([40.92.255.77]:58400
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727539AbfKSDRL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 22:17:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLfklHitGiQ1jDFztwcl4ht6Qg/32KSJkd0cJ0eBL64oP3PEM1wK78Zp50p9d1klninfbRzz422T4+AtpnSSHsFN0J+hPluynvvy800V+7CbuOD544gP5EuytITJslfs17aMPhX3kLdTdeXLLIko3EjPnq74c6AFUZNhxZeeevFkMXlkvLEu4f+0S8w0vk5EYxwZ1ywyeB4YUEWQsgdeoCx0ZlnJS8sZBQJ13yCv2fvPKOcpXqGgCzzCsMcsF9jR2+rqC7/8QyDmOUhbSbeAeoRBhUk2d7KT7WGqMnKXt57SLeiIeXqMQ6pIRPdQV4DKkvFzMvMQx54bqmE4PobvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4jobBERaTOad8I8KS8AnHQEZKbKVugZJycA2qbqy80=;
 b=gXllSee4me2RAxCLIPe7PZQy0l787BUD8yuIQ5YYoRZ7df1Z8i8wIGkDHmqomGO+uA0omTnJJ736D4Rbt9RuUfDACL2Yhgh8zktaf9x7s/WJYqOhF32czG3Jpuis2OfOCNTRUUxdETxBhdCzdDoq6+HnoGXcuhzSR7FhAQiYGokdS/wHQqE4AbIXfDlUIhI+Y/e4psTO/gI7R6SFTDfzmDyHnIQYrpP8aWAc0YkF2xKESo608xUiLqCIgh/MJqErKMJKukB/3HPDPugdckfUwxT+bvwB5/wYc+OH0/BUOOesKFwgHeNFw0QrxR4rdA7rsvoGWNMq28dDJFMUdAJxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT020.eop-APC01.prod.protection.outlook.com
 (10.152.250.54) by SG2APC01HT035.eop-APC01.prod.protection.outlook.com
 (10.152.251.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Tue, 19 Nov
 2019 03:17:05 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.250.51) by
 SG2APC01FT020.mail.protection.outlook.com (10.152.250.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Tue, 19 Nov 2019 03:17:05 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 03:17:05 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v3 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Thread-Topic: [PATCH v3 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Thread-Index: AQHVmjaUpBZrOiNs+EaePGmphxD+QaeK5IeAgAXQSwCAAN4DAIAASFMA
Date:   Tue, 19 Nov 2019 03:17:04 +0000
Message-ID: <PS2P216MB07556573D454EB9A6D1A5140804C0@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
References: <PS2P216MB0755848993A4445324AC516E804D0@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
 <20191118225802.GA71768@google.com>
In-Reply-To: <20191118225802.GA71768@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0127.ausprd01.prod.outlook.com
 (2603:10c6:201:2e::19) To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:C7AB357FF30A67422B3CB6EEA17A033E1E646DA22363A06C4C0C7DD9934482B3;UpperCasedChecksum:FEC8761BDD4159481985670F2279C60F60D7E0A1BE3ACE32031C038A15BD12A5;SizeAsReceived:7769;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [DAQr26JcakTPYSL6AVtMq8itVcBBGvk2]
x-microsoft-original-message-id: <20191119031654.GA29050@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 998ac35b-ef86-43c7-82cc-08d76c9ef37f
x-ms-traffictypediagnostic: SG2APC01HT035:
x-ms-exchange-purlcount: 2
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oza0LWMgZGWSkcPzNRU3U6AEcbsZe87gIW3i0ETmbjL74wo4IIhLTunEjw/QO+DjE6frjb24AVvWknTE7g/0WecQSvbOc/NTJm/fMmULC1GxTPvWZLD8E8VZCo/iesAcdp+5OR/QJI2VjUtyH6joDNPgssXJ28t9cZ/1vci99Yxxw7fmt8eAJHJALLludCimsWrrDjL8jc6ysPI9TppXfxxNyUZsRj93W+mRHWDrSV8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <60100CA5BCE4F64384DEE96D9C81F361@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 998ac35b-ef86-43c7-82cc-08d76c9ef37f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 03:17:04.9843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT035
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 18, 2019 at 04:58:02PM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 18, 2019 at 09:43:34AM +0000, Nicholas Johnson wrote:
> > On Thu, Nov 14, 2019 at 10:56:37AM -0600, Bjorn Helgaas wrote:
> > > On Wed, Nov 13, 2019 at 03:25:28PM +0000, Nicholas Johnson wrote:
> > > > Currently, the kernel can sometimes assign the MMIO_PREF window
> > > > additional size into the MMIO window, resulting in extra MMIO additional
> > > > size, despite the MMIO_PREF additional size being assigned successfully
> > > > into the MMIO_PREF window.
> > > > 
> > > > This happens if in the first pass, the MMIO_PREF succeeds but the MMIO
> > > > fails. In the next pass, because MMIO_PREF is already assigned, the
> > > > attempt to assign MMIO_PREF returns an error code instead of success
> > > > (nothing more to do, already allocated). Hence, the size which is
> > > > actually allocated, but thought to have failed, is placed in the MMIO
> > > > window.
> > > > 
> > > > Example of problem (more context can be found in the bug report URL):
> > > > 
> > > > Mainline kernel:
> > > > pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0xa00fffff] = 256M
> > > > pci 0000:06:04.0: BAR 14: assigned [mem 0xa0200000-0xb01fffff] = 256M
> > > > 
> > > > Patched kernel:
> > > > pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0x980fffff] = 128M
> > > > pci 0000:06:04.0: BAR 14: assigned [mem 0x98200000-0xa01fffff] = 128M
> > > > 
> > > > This was using pci=realloc,hpmemsize=128M,nocrs - on the same machine
> > > > with the same configuration, with a Ubuntu mainline kernel and a kernel
> > > > patched with this patch.
> > > > 
> > > > The bug results in the MMIO_PREF being added to the MMIO window, which
> > > > means doubling if MMIO_PREF size = MMIO size. With a large MMIO_PREF,
> > > > the MMIO window will likely fail to be assigned altogether due to lack
> > > > of 32-bit address space.
> > > > 
> > > > Change find_free_bus_resource() to do the following:
> > > > - Return first unassigned resource of the correct type.
> > > > - If none of the above, return first assigned resource of the correct type.
> > > > - If none of the above, return NULL.
> > > > 
> > > > Returning an assigned resource of the correct type allows the caller to
> > > > distinguish between already assigned and no resource of the correct type.
> > > > 
> > > > Rename find_free_bus_resource to find_bus_resource_of_type().
> > > > 
> > > > Add checks in pbus_size_io() and pbus_size_mem() to return success if
> > > > resource returned from find_free_bus_resource() is already allocated.
> > > > 
> > > > This avoids pbus_size_io() and pbus_size_mem() returning error code to
> > > > __pci_bus_size_bridges() when a resource has been successfully assigned
> > > > in a previous pass. This fixes the existing behaviour where space for a
> > > > resource could be reserved multiple times in different parent bridge
> > > > windows.
> > > > 
> > > > Link: https://lore.kernel.org/lkml/20190531171216.20532-2-logang@deltatee.com/T/#u
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=203243
> > > > 
> > > > Reported-by: Kit Chow <kchow@gigaio.com>
> > > > Reported-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > > > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > 
> > > Applied with reviewed-by from Mika and Logan to pci/resource for v5.5,
> > > thanks!
> > 
> > We have v5.4-rc8, so there is one more week. Please let me know if you 
> > have any concerns about the other four patches so that I may address 
> > them ASAP. If you are worried about the first one, I can re-post the 
> > series with it at the end, so that the others can be taken first.
> 
> I assume you're talking about this:
> 
>   [PATCH v11 0/4] Patch series to assist Thunderbolt allocation with kernel parameters
> 
> I hope to merge those early in the next cycle so we get some time in
> linux-next for wider testing.  It's later in the v5.5 cycle than I
> would be comfortable with.
> 
> Bjorn
Fair enough. Thanks for this info. :)

I did just discover linux-next and I built it. Should I be doing this 
more often to help find regressions?

I will now concentrate on fixing the problem where pci=nocrs does not 
ignore the bus resource. One motherboard I own gives 00-7e or similar, 
instead of 00-ff. The nocrs does not help, and I had to patch the kernel 
myself. Only acpi=off fixes the problem, while knocking out SMT (MADT), 
IOMMU (DMAR) and the ability to suspend without crashing.

If you disagree that nocrs should override bus resource, then let me 
know and I will not attempt this.

Nicholas
