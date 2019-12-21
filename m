Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E23D1287A7
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2019 06:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbfLUFtQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sat, 21 Dec 2019 00:49:16 -0500
Received: from mail-oln040092254088.outbound.protection.outlook.com ([40.92.254.88]:59638
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfLUFtQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 21 Dec 2019 00:49:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lnhw+t/hMH2HN81scRTRdmJo7dxYJjQArVZKeugzJzC9FxyOMnKIUYl7YCk3rHhffzitEg0ptDO1IWNfN5I9AMJJKu9LZbXYo/W9AWD7bHDuRoFUuVv4jH27SBhsegI5qThJeF6GEfEUaHmUgJZoCMYQCXberVKw9n0wLXiEEjqCErTsdO1bbPrC1Wbdpxex/zvUf2FTEGmZfVaazOghLZ3nqEfGTcQ8NpKWd0syJv9dk80/wkuXEQGH5+WwbAaZ95/Aq0CvKxtPiTEueArzPUnUOK32wwvRVBMYkbeEnrumRmY7bvjxC363j35Ao/ZM1FypAaePXUQGigrkyicMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+QnFU/Cp+bPSofXn7nSi79nhVUOGJj7dqUor9xF4j8=;
 b=ItXFJmuQyaDSEszipeUvjvgjiGDJe8YFuGXrX2nU9ZMpDeSm9vzZsKEGXhLtGQlCRAlMfRNkgNMz5rH4ywtp/DyXgOo7g4PlXgW90Dfq0a4wa9Jvph7nNsAY9JO6jtnw2SRqUcRcIfF9vnKqWTrRfsOoT1/tAaVPr5Ugj5svZ3I7geEQ7x56VO+HLZJMcOTkNP/tpGr3V1Kq+VVL86zOnwBGda5XHZyQ4MXRn+s/lUdAqUXEp+unsUhOe6lqum4AzEQhymDXVpoz892O5j83Os93VOFh2kAdCV144HIzWy9hRWKCJOr75HupI7bIPddit6rUjdVYEeE0DqKlyDlZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT013.eop-APC01.prod.protection.outlook.com
 (10.152.250.53) by SG2APC01HT066.eop-APC01.prod.protection.outlook.com
 (10.152.251.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Sat, 21 Dec
 2019 05:48:56 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.55) by
 SG2APC01FT013.mail.protection.outlook.com (10.152.250.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Sat, 21 Dec 2019 05:48:56 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2559.017; Sat, 21 Dec
 2019 05:48:56 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v12 0/4] PCI: Patch series to improve Thunderbolt
 enumeration
Thread-Topic: [PATCH v12 0/4] PCI: Patch series to improve Thunderbolt
 enumeration
Thread-Index: AQHVrpB+5sK/XGeQw0yttw28ATWBvae+e8EAgACidQCAAxacAIAAkwAAgABhdwCAAP41gA==
Date:   Sat, 21 Dec 2019 05:48:56 +0000
Message-ID: <PSXP216MB0438F46577120B6E80B3932B802C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB043888F94710A361E4D84DFF802D0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191220143856.GA92795@google.com>
In-Reply-To: <20191220143856.GA92795@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0198.ausprd01.prod.outlook.com
 (2603:10c6:10:16::18) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:F1F1EC5EC6ED7A54E43AA0EAE9ABB43E7FD43B09D490AACB1E63CA8A9FA025B3;UpperCasedChecksum:BDF88537DBC624C96641AF88C2EC4B67F364B414816FEC08A0E15D23A160433F;SizeAsReceived:7751;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [+fW7c5CYTEX+iu5K7lA19dXkyPJkOON+PD+abrbAWqov1nT2ihKOsdMXOHyPi6PzZIS+xLylWEQ=]
x-microsoft-original-message-id: <20191221054847.GA2537@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: e02876d9-6189-4895-64f9-08d785d9778e
x-ms-traffictypediagnostic: SG2APC01HT066:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uL2RuD+MuEGihUyDWK5oMYbdH0jk14aGXFeaCleCgJAh+M7NU3eQ6aRo7eQETpZHSzeM+8zpdPYNSEoW/c+1aw07YaK6MBHbLKSAWDTFeLmh+yLh6doVgEEH2tk2tc0bbz9HrVJ88HEjuZAv5fUOKDrFf1z0jIwYP5pZq/LXC7VIxSkQ4kdLmzYq4kfloMvK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C12F7D308C8EBC49B26A3F13D7D5E4C0@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e02876d9-6189-4895-64f9-08d785d9778e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2019 05:48:56.3379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT066
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 20, 2019 at 08:38:56AM -0600, Bjorn Helgaas wrote:
> On Fri, Dec 20, 2019 at 08:50:14AM +0000, Nicholas Johnson wrote:
> > On Thu, Dec 19, 2019 at 06:03:58PM -0600, Bjorn Helgaas wrote:
> > > On Wed, Dec 18, 2019 at 12:54:25AM +0000, Nicholas Johnson wrote:
> > > > On Tue, Dec 17, 2019 at 09:12:48AM -0600, Bjorn Helgaas wrote:
> > > > > On Mon, Dec 09, 2019 at 12:59:29PM +0000, Nicholas Johnson wrote:
> 
> > > > > > Nicholas Johnson (4):
> > > > > >   PCI: Consider alignment of hot-added bridges when distributing
> > > > > >     available resources
> > Prevent failure to assign hot-added Thunderbolt PCI BARs with alignment >1M 
> > 
> > > > > >   PCI: In extend_bridge_window() change available to new_size
> > Change variable name in extend_bridge_window() to better reflect its 
> > purpose
> > 
> > ^ I would have preferred this not be its own commit. Is it too late to 
> > squash it back together with patch 3/4?
> 
> Not too late; it's trivial to squash it.  I consider these branches to
> be drafts, subject to revision until I ask Linus to pull them.
> 
> But ... why?  In general, the smaller the patch the better.
Now that I had to justify why were are putting it in, it does not fix a 
bug or have any effect on the end user. But it seems I was mistaken in 
that I have to write reasons for each patch. It seems like it is one for 
the whole series.

> 
> > > Basically, I'm not comfortable asking Linus to pull material unless I
> > > can explain what the benefit is.  I'm still struggling to articulate
> > > the benefit in this case.  I think it makes hotplug work better in
> > > some cases where we need more alignment than we currently have, but
> > > that's pretty sketchy.
> >
> > In my opinion, fixing failure to assign is a clear reason to merge, 
> > especially when the failure will result in a user wondering why the 
> > device they plugged in does not work.
> 
> Sure.  But there's nothing specific in the commit logs about what the
> problem is and how these fix it.
> 
> For example, I think the first patch ("PCI: Consider alignment of
> hot-added bridges when distributing available resources") is something
> to do with increasing the alignment of bridge windows to account for
> descendants that require greater alignment.
> 
> But the log says "Rewrite pci_bus_distribute_available_resources to
> better handle bridges with different resource alignment requirements."
> That says nothing about what the problem was or how you fix it.
When I first started the patches a year ago, it was all about my 
Thunderbolt add-in cards. Since then, I have realised that although that 
is the motivation, there is nothing in this code specific to 
Thunderbolt. Hence, I tried to write the logs in terms of what it means 
for PCI in general, and tried to leave mentions of Thunderbolt out. If I 
recall correctly, the fact that there is nothing specific to Thunderbolt 
here has been brought up by reviewers.

> 
> Ideally that patch would very specifically change *alignment* details.
> It currently also contains a bunch of other changes (interface change,
> removing "b" in favor "dev->subordinate", etc).  These make the patch
> bigger and harder to understand and justify.  Some of these lead up to
> the alignment change but possibly could be split to separate patches.
I tried to split the first patch up, but it got very messy, very 
quickly. I tried to do the interface change first, but I found variable 
names to clash when making partial changes. The overall number of lines 
of diff would have been much greater to achieve the same thing, and each 
patch was not a whole lot smaller.

I can re-submit with changed commit logs if you wish, to mention the 
Thunderbolt problems.

Patches 2, 3 and 4 can be applied first if that helps.

I can try to split 1 up more, but it is going to be a lot of work and 
I am not convinced you will like the results much more.

> 
> Bjorn

Nicholas
