Return-Path: <linux-pci+bounces-386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9B580262D
	for <lists+linux-pci@lfdr.de>; Sun,  3 Dec 2023 19:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5519AB207BB
	for <lists+linux-pci@lfdr.de>; Sun,  3 Dec 2023 18:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0522F1773E;
	Sun,  3 Dec 2023 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HJMy6G+v"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2047.outbound.protection.outlook.com [40.107.6.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD25E7;
	Sun,  3 Dec 2023 10:15:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nn4VMl/e/iuV2rtCjqEDgV8AqUDbO9O53IZFFM+uSWbXkiLze0UJ7EIuRByMFfj5aotyza/+H/5I7ss8yGd9h0tR38HwknfxGRRtZGm1OO+LBIPZEBkkNiIAGseLviWVY8pQElJbhZ3hY3EnVQJASYDHVwjvJlplMIab/4vykECwu3YveEg1CaGfyL3g0NBSWnYLVg9/m8NoKqetOr1YQEPZbywVAVPyFZS0auYMpT4QMf5N2MTTmQQLMUdf7RgyuEcqa6cOgNDUTmUs0u1LMyZSojMP7aVRzzBvLW6CA2/0GB4ynlwgvPK4njFl2CPCSXIYeRXJaApYvlXNMYSw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hE1iOXIL9nlSt5cJ0k46CQwmZJOgVvDbL36UCMAx7bM=;
 b=kq2LPRelq2Aqzls5dLV3Lz9+m2uqJvlcmeRShegy6fPgyjILKeDLc01q+8YVT/y6ifVTIzyIz2wawX7m9xgbyOQf88rR8sMnVJ99Bu5lWm6j5kM5TcGVFWEPzcCNIivtS9+9BWins1XQ5aCouQIxfWyVQiWapogXWGFuXvCawRl+CWDdE/juAyWOfck18qq+hCiFFSi/hnq7zXyqeJBFEzOXsq5Ewd3SIXH36cQA9JSDkwF9qFmfXwHGD72rwbbzev4QaQN+cIFC/jKrVccL+JrrJikM5YVGjAPD3a+Coi3tkz33CmvLzvDOR57/5D72p/LYFrPZEkkaSULEMG2Yuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hE1iOXIL9nlSt5cJ0k46CQwmZJOgVvDbL36UCMAx7bM=;
 b=HJMy6G+vzH7BpOE//NS9UXBdCKVA/2z7DG6HY2Xq/PxX/NPDRKYYWxtZlcDFhmPuftJt5K2KTldV8jLkPrR9v0bLObqe9fFrT9bjS1C10SYtDVJ7u26IF/oedAJZIaoEvzesv3B6YWBS9gUtUPBrOsb9K4fiHRCAZCUY+PPuAmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBAPR04MB7461.eurprd04.prod.outlook.com (2603:10a6:10:1a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.21; Sun, 3 Dec
 2023 18:15:11 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Sun, 3 Dec 2023
 18:15:11 +0000
Date: Sun, 3 Dec 2023 20:15:08 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Wasim Khan <wasim.khan@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH pci] PCI: remove the PCI_VENDOR_ID_NXP alias
Message-ID: <20231203181508.n2hxjnoeuydnzyeo@skbuf>
References: <20231122154241.1371647-1-vladimir.oltean@nxp.com>
 <20231129233827.GA444332@bhelgaas>
 <2023113014-preflight-roundish-d796@gregkh>
 <20231203151654.nh4ta7vtzwpwg4ss@skbuf>
 <2023120354-expansion-frequency-f991@gregkh>
 <20231203174841.uj6ixj7ap2hzlvey@skbuf>
 <2023120318-creme-cold-206b@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023120318-creme-cold-206b@gregkh>
X-ClientProxiedBy: FR0P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::14) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBAPR04MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: f085488a-526b-4ef6-8fc1-08dbf42bca12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V5KiIq6O/9WOm6MgH8UJn7I+zB2GFYGL0TLWtX8pbHCLVYCjvfFeik3DdCgyF70Lx2cSadFSyiM2MW98UzkDdJmJa1E1ft/NK/eXhJbjhd4I1YJsds7fA5gnm9O4t4r7JMaxfRPnqOXsr5n4P9aYCyi4+SXSNy2aso4WIw0ByYRyuibwZc96L4of1o6ZCE4vb3mp7argAAlbGvw62PJdinvpnenWMSHTxIGR3To7LTIVHNg/5XDc05Ca5OlmOCmPLp/xBY9t8F6HmR1/nnQHR+UOmqT23VS5/djtc1bKRI8tkMkianm12nPqOsbAwwnWK/krtrgbZ6YW0aSRgYF2oCf/JTNlQnpMAQq6ILE9gL/QKLyDjif/vENru1yXozOygq+3muD9ZFv0Md38lmjAyUQXfJLmq9TvTAMIiQBMft8Geg/+XoRvpDlyxUIiIcKC0YAc46SlxdRGE+uahg2bpmD3RR4ST6T1dUn+1dfJnZDzmAjTzvRuK/1ZXoJmHve15ofUVOFXFoRU434IJWpg1/MpBDwKzglbShJ+BNncntY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39850400004)(346002)(366004)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(478600001)(26005)(966005)(6486002)(83380400001)(6666004)(6506007)(9686003)(6512007)(1076003)(316002)(6916009)(66476007)(54906003)(66946007)(66556008)(38100700002)(5660300002)(4326008)(86362001)(2906002)(8936002)(8676002)(44832011)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hAvDpQDJvFh+b+UzvHn0u7eoBKrhDfgGHUTSMOTkOTz36BNMcu8wHi5RnHmu?=
 =?us-ascii?Q?6MqnRl41S3BVNLV8vgpIGdVi50s5jz5T1MEERtQuMrTyIXs3iStOvNVMpwPQ?=
 =?us-ascii?Q?eBq9KWj9PPozTnUO+3o5nbAEYV1BxOmUyAXLeG9W0k0PFOpasBG56GXCtuHQ?=
 =?us-ascii?Q?IPQsSUgzdWzOJXxsePdCZttFB4bq1r33NUulrnsliZLag0FLVJYKotfAaPSl?=
 =?us-ascii?Q?Z+HztEGaqvfe7ukyzPA+v3qtV/+hfGKoFHRWe53FlR3hCXVnopGb+BWUy7R2?=
 =?us-ascii?Q?HkNrJbxA9+qXhDDQiu98Zog63bBYiY9JCJ9x/rzoVJJM/QRGDIAaZjjH6GF+?=
 =?us-ascii?Q?FEPqc4F+gxMoHHnSJL3AXO/kRSzCLZcbVNk7kHb4L+nqAoIuQGFUcUO8gWJk?=
 =?us-ascii?Q?PFIzyjf4M9Bcl7mw6GKnKKsKj04kvWTh14md8ggI7Y7He1xbLq9/CGahO2/j?=
 =?us-ascii?Q?8JS9TQXdx+cwnfTC8+jes/OU3CQ7usyONXTZgqfC7bzCVxTZ/sQmCLk/mEKt?=
 =?us-ascii?Q?KAd1839NDSLQMsmWoBOaYMYVfN6FY9AwLcW7MgYpn5pUFENzNJ7lDl8goYXg?=
 =?us-ascii?Q?gl8AaxwjFf+5TE4L6cybxDqJOKlobHx7zs1/OCJWUOIyRUI41GCiLkJB1ozY?=
 =?us-ascii?Q?/jZrHG5WdTv+R7bJDGhY52wOq56PbWYsz+w2sqWtGdoDiUuECD0Cagx3pOzi?=
 =?us-ascii?Q?OVyyjL6VWF/OTh/lp3XAdaFiM9gZEYob6Gbs/8aJOAgEiaVSGpbJ/6fUkefr?=
 =?us-ascii?Q?KDia5DarzVOclsrYMUh0y1wbz3t1wcfW2JB2e3+jC739YxOIhRNBSr8nA54f?=
 =?us-ascii?Q?mPcvlHuD26BhKUaaW0Bjbz9E5E4mbGvZvDD0cIq9s2ncU4yTxcb2ezjM+xSG?=
 =?us-ascii?Q?ODLeYGfE/0nvI+NR4Trq+xAMK+6pIX3fHQhQzNYKpxnE4FljJLZ12aYpJHua?=
 =?us-ascii?Q?7+S2DUehDxgMsjW11zNbWJq2koBg8muzX08xoYyJ6WZ6bM1aAGDebCEYSOBl?=
 =?us-ascii?Q?t60xwhFrw+DFzPWNDTaakO520DXvKReujzkKSSPmoxa+WcrfMog2oyn+ENg8?=
 =?us-ascii?Q?Xz6rSWpZdxJ69hEPyndaXvRX74nan2DZSV2R2X5tK1KyGa3FDeIqtD6VkAQK?=
 =?us-ascii?Q?lKE6geA9HVkI6Z5i7/d8IAyKVZauTIerd9+mO8VlpPfTUZCW9cdh+DqLA2M9?=
 =?us-ascii?Q?o77W2dWuN6Mnc6U48duwl541KyQne0IIDuaCq71w+CkLnlKxuXq3vYddHPNv?=
 =?us-ascii?Q?oe/4L6CNrsVUkj4I3ieSUOLlSx1gAnmgC0HULJnXvrRfRm4OAo8VyOHJaJJE?=
 =?us-ascii?Q?f4iEx6CP2PI/PfM+SbSSOJHZgCVgZu8OzucRhKSsvEDwe8V8q7okT5aRGny8?=
 =?us-ascii?Q?2zpuvXQyXPxVjNlessaBXzskmLMidWelEoYgwfzmXrMrr+bgHLDN28AAhiHU?=
 =?us-ascii?Q?7mcb5waTwyZngB6w+ohalyuJWJZEhS4yquBZRM7DRgZkLYzsnkiRUbZ3uwsV?=
 =?us-ascii?Q?UUgYuIMa83TNvbDOmfTYJ6u2GHkAh+GoOIf9jKhZrjXkZPG2t8jJ/rMx0DFQ?=
 =?us-ascii?Q?JV88ie2yVN9T2AXUhm4DywI/hwe4aqHdHvKLkRe6g2FF6bgop4lBwEOV+Ip0?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f085488a-526b-4ef6-8fc1-08dbf42bca12
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 18:15:11.5246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /it39+IVlW6TW9Dn9r7mXwz6GkM13gyFTa7S2njKqw3tBi/Vmzs1v5XbE5kZeE0addFHiFsdcWTSk1OntfRHbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7461

On Sun, Dec 03, 2023 at 06:59:04PM +0100, Greg Kroah-Hartman wrote:
> > > > > > Why would we remove name of the current company and use the name of a
> > > > > > company that doesn't exist any more?
> > > > > 
> > > > > Yes, this seems very odd.  What is the reason for any of this other than
> > > > > marketing?  Kernel code doesn't do marketing :)
> > > > 
> > > > I'm not sure who is doing the marketing; not me, that's for sure.
> > > > The patch that I'm proposing undoes these strange aliases.
> > > 
> > > Why?
> > 
> > Why am I undoing the aliases? It's in my commit message.
> 
> Which is long gone from this email thread, sorry.
> 
> > NXP now produces PCI devices with a different vendor ID.
> 
> "Different" from what, the old one?
> 
> > If aliasing is the way
> > to go, then are we supposed to add a new PCI_VENDOR_ID_NXP2,
> > PCI_VENDOR_ID_NXP3 etc?
> > 
> > Mellanox was bought by Nvidia and I don't see its PCI ID aliased to
> > Nvidia. There are probably countless of other examples.
> 
> I'm not asking why anything is being aliased, I'm asking why change the
> existing names.

With all due respect, I can continue responding and this discussion
will go nowhere, or you can go and actually read the change.
https://lore.kernel.org/linux-pci/20231122154241.1371647-1-vladimir.oltean@nxp.com/

There is nothing more to it than "I think it's confusing and inconsistent
to have multiple PCI vendor IDs for NXP, especially when they even weren't
NXP's to begin with". I've said that once in the original commit and
once to you directly. I don't think we even disagree about this basic fact.

> > > Who did it originally in what commit id and what was wrong with them
> > > then?
> > 
> > Does it really matter? "Git blame" on the line with #define PCI_VENDOR_ID_NXP
> > will point to a random commit by Wasim Khan (also CCed). The usage of
> > PCI_VENDOR_ID_NXP is not widespread, it's only that commit.
> 
> So does your change here just revert the change in that commit, or does
> it do it in other places?

A tree-wide grep for PCI_VENDOR_ID_NXP will show that the naming
introduced in 2021 commit d08c8b855140 ("PCI: Add ACS quirks for NXP
LX2xx0 and LX2xx2 platforms") is also the only place where 0x1957 is
referred to as NXP rather than Freescale. My change eliminates that
localized NXP alias, and makes the kernel consistently refer to 0x1957
as Freescale everywhere, as a result.

