Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D67FA4E031
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 08:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfFUGBS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 21 Jun 2019 02:01:18 -0400
Received: from mail-oln040092255087.outbound.protection.outlook.com ([40.92.255.87]:6140
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbfFUGBS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 02:01:18 -0400
Received: from SG2APC01FT015.eop-APC01.prod.protection.outlook.com
 (10.152.250.59) by SG2APC01HT173.eop-APC01.prod.protection.outlook.com
 (10.152.251.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1987.11; Fri, 21 Jun
 2019 06:01:13 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.250.57) by
 SG2APC01FT015.mail.protection.outlook.com (10.152.250.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11 via Frontend Transport; Fri, 21 Jun 2019 06:01:13 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::8c3b:f424:c69d:527e]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::8c3b:f424:c69d:527e%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 06:01:13 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 4/4] PCI:
 Add pci=hpmemprefsize parameter to set MMIO_PREF size independently]
Thread-Topic: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 4/4] PCI:
 Add pci=hpmemprefsize parameter to set MMIO_PREF size independently]
Thread-Index: AQHVJqdtisSX95SZEkGuUZAlsxs7iaajL4kAgACJCQCAAAr4gIAAzHoAgADcxwCAACVagIAADfiA
Date:   Fri, 21 Jun 2019 06:01:13 +0000
Message-ID: <SL2P216MB018735338F997285B486E28180E70@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB018784C16CC1903DF2CEDCB880E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <a473bee0-0a25-64d5-bd29-1d5bdc43d027@deltatee.com>
 <SL2P216MB01875B40093190DBB6C4CBB780E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <89c6a6ee-46cc-4047-0093-30f07992e7e5@deltatee.com>
 <20190620134712.GI143205@google.com>
 <SL2P216MB018710C0513F97989DCD3A4880E70@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <7d008368-d358-ede9-215b-1971cbdc2d77@deltatee.com>
In-Reply-To: <7d008368-d358-ede9-215b-1971cbdc2d77@deltatee.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0117.ausprd01.prod.outlook.com
 (2603:10c6:201:2c::33) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:84630D3DCE5F960FC934D9ABC781EA49DAA26A67A4D0BD55F9BCA6024B586AEC;UpperCasedChecksum:8C00EF40BB7483BA4CDE12AC2AA12E2AC3D90E0F20C9F3A2F34A23D92EA01C23;SizeAsReceived:8198;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [GmhGjfFy3dNuy3t3CZUSVv6B9Oc/dpoQjLEVRpZdmhSYpWfVVf/H7YS2ug0sMG34]
x-microsoft-original-message-id: <20190621060102.GA3378@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:SG2APC01HT173;
x-ms-traffictypediagnostic: SG2APC01HT173:
x-microsoft-antispam-message-info: 7OmDlMnv2qrZkmGp5wXn1FAvhAvjKeCRFNXKAYZ0JjQc39ospQhH3HpYj4IZPm5cVDkG9zHt8WTHE+F0mJj1KftmMJYFl2X+NPtkUAiflEQGYNGVsSXPw9RS5y0eNtYNwlHmn+c6Um/ZMEVZyb8nicMueQDZJYAVlSeg62PqtwuCSprrMHVLp+wQBBH6QkXd
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FF6338C8110834B85C247BDC0E5380B@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f5e5ce-6781-41ff-df50-08d6f60ddd4a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 06:01:13.3998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT173
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 20, 2019 at 11:11:05PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-06-20 8:57 p.m., Nicholas Johnson wrote:
> >> Adding two new parameters sounds like a good idea to me.
> > Yeah, that is basically what I did originally (except I depreciated the 
> > old ones rather than keeping them).
> > 
> > I did it this way on your direct advice in keeping with minimal lines of 
> > diff, minimal disruption, etc. If I were to do this, the number of lines 
> > of diff will increase and then I will be fielding complaints that it is 
> > too large to sign off.
> > 
> > I am already scrambling to make last minute changes before end of 
> > release to the other patches and I am not even convinced that that stuff 
> > is going to get accepted based on proximity to deadline and how many 
> > change requests are flying around.
> 
> Friendly advice: Linux Kernel development doesn't really work on
> deadlines. The patch I linked you to has already been around a couple of
> cycles and has missed a couple of merge windows. It's not that big of a
> deal. I  try to make it better, if I can, and resubmit it once or twice
> a cycle. It will get in when other people understand it and it meets the
> community's standards. I had one patch set I submitted for more than a
> year and a half, or 25 times, and it eventually got picked up. It's not
> always the best experience but patience, persistence and openness to
> feedback are what works.
> 
> New kernel parameters are important to get right because they are user
> facing interfaces and we are stuck with them forever -- breaking
> existing users is simply not accepted here. Deprecating features is an
> extreme action that the Linux community takes pains to avoid. If we cede
> to deadlines to get a new parameter in, and it turns out to be
> non-ideal, then we are stuck supporting it forever and it's painful for
> everyone.
> 
> Logan
Thanks for advice. I do believe you are correct. I guess it is my 
inexperience - I have trouble telling what is normal and what to expect 
from the process. But I am not feeling like this is any closer to 
submission than on day one - no sense of progress. It is not reassuring 
and I do wonder if I will ever manage to get it right.

None of this is technically Thunderbolt-specific, but that is the use 
case, and if a single one of these patches does not make it in then the 
use case of Thunderbolt without firmware support will remain broken. The 
only benefit of a partial acception is patch #1 which fixes a bug report 
by Mika Westerberg on its own, so I guess that would be a win. If it has 
to wait another cycle then I will live with it, but this is the cause of 
my anxiety.

I can look at this patch again, but my concerns are the following:

- If we avoid depreciation, then that implies this patch is ideal - we 
are not breaking anything for existing users. We can set MMIO on its own 
with pci=hpmemsize and by setting pci=hpmemprefsize to the default size of 
2M (so it remains unchanged).

- If we have two sets of parameters, then we have to support having two 
sets for eternity, and the loss of minimalism and the potential for 
confusion. The description in kernel-parameters.txt will become 
confusing with a lot of "if this" and "if that".

- How do we deal with order if both are specified? It will become 
unclean.

- If we make two new ones, then what should they be called? I propose 
hp_mmio_size and hp_mmio_pref_size from my original submission. Then 
should hpiosize be aliased to hp_io_size to keep the consistency?

- I am quite surprised that when 64-bit window support was added to the 
kernel, that this was not done then, although I am not good enough at 
navigating the mailing list to see what actually happened.

Should I perhaps forward my original submission for this patch again and 
you can see if there is anything to salvage from that that?

Cheers
