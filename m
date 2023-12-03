Return-Path: <linux-pci+bounces-384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D5780260D
	for <lists+linux-pci@lfdr.de>; Sun,  3 Dec 2023 18:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82031C20431
	for <lists+linux-pci@lfdr.de>; Sun,  3 Dec 2023 17:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C9168DB;
	Sun,  3 Dec 2023 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h3fLXSym"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733B8DB;
	Sun,  3 Dec 2023 09:48:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=av5tfB7za9jS5VFx6OA7KD08EJsLVMsiHJdbTPQQ5gkOLGmB2IVdN/cLYN/meNvktSquGpd+LYpLVcG1xM3Ch+s5x/adqJWUfFgJjVFCTJKkzgttSumOdhb0jdtxoOLlrVcizMEir+A0mSrphwt5t8zQMccpXKwgwgpUOxNJ2ZDHYAR3xIilK7hFtwWJl89mjyNqIb7vpk4x572HnIXkVaL5idHMoJm8ODXeE5cFGr6JcFuWDqmDDJT+fCogAdaPzsO27d0U4A3vyhF6xWFKQqlNK8Rzaj+5Dffu40oCfQGXOPPbqa8WwIDr7lgfZcJBrWAxLy4rvNfkDZO1jTiKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5nHb9sal9bcQjBvQ/izjHiyH/Uu0h1CELyuZtNDuEg=;
 b=OX+Kxg98VVJlN44ZKeQbZke4Y7mSTEULsQyHBJhKTcinhWWpXKV87S0I7sec+sdJDsOFDubkxs66lVyvjiAoxrURixSJGyBnPXHVZOnWxao02LXCqC4i8/lvvLU4Uw7Nc7Uq8t3Z7uKwB5QG9+GP8Ng/74rny3ObZV9vNcwGnnbzRCqnLa5oEjCTlQr8bPbFJ47FHqR2TUKb2V2HcbwhrerDH+n3lE3ZNZONgboq/KeDtFTXKiWgTrOt5ZGWvuLLTAFQ4yd2yTZMO4V39NyhODL5cfjJGcqubKbyRh9niIcgYzTII4TC6ijwZsxgASlOK3BSAjIw/LBP4DIE1sTmaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5nHb9sal9bcQjBvQ/izjHiyH/Uu0h1CELyuZtNDuEg=;
 b=h3fLXSymJfR+K9jDx/6K9zGGJ1DHzTJNsZxUAfwwcH+b6atHnMpivpdyW/KuFlpIp2vcDGxVDQT707AXG/SwWUNLUEL3vNwfS5KERiEurdCsF+CDemfbemEj7c7JVxw1HZlnX/m8R5x8q6L3yzb8x665PpKXYkOl2Kku1gOztKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PA4PR04MB9711.eurprd04.prod.outlook.com (2603:10a6:102:267::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.21; Sun, 3 Dec
 2023 17:48:44 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Sun, 3 Dec 2023
 17:48:44 +0000
Date: Sun, 3 Dec 2023 19:48:41 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Wasim Khan <wasim.khan@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH pci] PCI: remove the PCI_VENDOR_ID_NXP alias
Message-ID: <20231203174841.uj6ixj7ap2hzlvey@skbuf>
References: <20231122154241.1371647-1-vladimir.oltean@nxp.com>
 <20231129233827.GA444332@bhelgaas>
 <2023113014-preflight-roundish-d796@gregkh>
 <20231203151654.nh4ta7vtzwpwg4ss@skbuf>
 <2023120354-expansion-frequency-f991@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023120354-expansion-frequency-f991@gregkh>
X-ClientProxiedBy: VI1PR08CA0273.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::46) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PA4PR04MB9711:EE_
X-MS-Office365-Filtering-Correlation-Id: ff25b082-7c74-4364-95ea-08dbf42817ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KEzfpI+mXv2b96EerVwsV8wD6CEXZsEH4nOv6amKNxF/y7W9svHy2cICr576vxGY+vRZ7aby0z/afmZkFprfMGWJQA2f367i9b/HLAaSQ91bqg4UQBYVGvjqabrjtTfC/DiCLjz1Y+3qw4whlk1J0psz/mjA3/wmFz3BFAnYZ4dD04nLnvQu8Ji4Ck+2eOJG2RKrWpgx63y09CSFkh6dlTrcmQ7a90YFHRzb+qKaE8OJp23T3j0hJCDPzHBBub3sa3OIy0CZT/wKmQ+8jZ6uy0F98XEZLOLTKwCBxkl6vHb16GfsRVFxVL4rLOE+5mactrVSwJ11rcOE2QC3lpztVc2VAW4zPjb+eopxHDrPqNUCrTsB8Tx092bqWSqdh2tEZFStWX5iJlggGZskPI1kok+x8Z1HAUE1H+KuJwiP132ayWEa5bbwH7L3NKKTR3uHRh/rLctpE58rwvxhBc9J1wU5RRKHrd1MI+bQqQ0SixmTmXTQaxpBum+Wt0pqj7xS7VRWFWQpHRxowqzTB4VcoV9ENCEaV6IrBTvKhX/98CDYsJuaVVRWpJqiuxzE35Hl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66476007)(6916009)(66556008)(44832011)(54906003)(316002)(66946007)(5660300002)(4326008)(8936002)(8676002)(6486002)(33716001)(38100700002)(83380400001)(86362001)(478600001)(2906002)(6666004)(1076003)(26005)(6506007)(6512007)(9686003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RFCPSOaQpTL91H2/BE4tyAz73n+GrSCMpieh3HCdPIesokl05K2LjnUrfOxS?=
 =?us-ascii?Q?EuhypBcwT7a1ORdmwXRZkp/2OYQsOhZwAVOCQvgDOuJAaPaN7Yppv08kr04L?=
 =?us-ascii?Q?RHM9FutUd3IW845z9eeFxZ5cSAlZSfmBetfie9R7sSSnrQ3BXCsQdybHsJRH?=
 =?us-ascii?Q?qtaRX89vQEbOxogpT8+wydnKTdo9kE5twmtlqfytIKRanREp3/+LilWRO0BQ?=
 =?us-ascii?Q?ZkX+08acVuU7y6vi5ASUG9Q6dhEwwgq1BYlurVhfUcUWOgkWOvv3zzeP0a5u?=
 =?us-ascii?Q?nhLCdKPeM/0TyQZ6P4oHeiJCYY+k1sjDjlyM4/QFoHHdBBE/IkuTAePvL0pP?=
 =?us-ascii?Q?Lb6ueeuk3IvMqvbmD47RfZiPappjQ/ZkMiDWY43yfSZF5fx9m6MvOtjZzx/k?=
 =?us-ascii?Q?MVTFVu0WbsVhuaEghmhZJIUvBNn9QIQpIrYMVq+f5WvL7BljTfDprTHNhwUo?=
 =?us-ascii?Q?je9a54uRRYEO0ciDRpe+Y1kSgHQKyR02O8kFMW7Kf7SZ4H+XeBV4pa2SJSBX?=
 =?us-ascii?Q?knrU/mHGDdMRY71Bxo2YGIr5D8QW/RLNxR2HIg7MwBFSTZH3rB0KDdI3jWgW?=
 =?us-ascii?Q?01PhEjDUBBYLwpS1kuZcNBCeNy+Ol+NzCWwN0+NR8vEQwAl2HmTiIs5CLKQ1?=
 =?us-ascii?Q?hR6tIajq2uIYaxsXIALq3bx4UIClF2xmSkH2MvBEqSrNAVkPBCZAmcHjKKnQ?=
 =?us-ascii?Q?PI0um2t2xQCxvBQ4fLcCKPMrPJcHEA4IL5BVCkufmdaQNagT+XZzu8S9xOE9?=
 =?us-ascii?Q?sdddMXbdHH/azBvOjIJcXnfMBarLmfYT6+fVqJSgG/Gw0ETDmf3F5WrglQh+?=
 =?us-ascii?Q?6khgnCGnQoScCKUkqEhObdCxBY+QyKv8hOzeLXM+LQQtnX0yh/vrq+pvjN5T?=
 =?us-ascii?Q?7eEpPz9HcPFyr+iXubou/JF/+lyI9hNYJv8qOa1Ne0DvuRDJqr6Q2f+15J8x?=
 =?us-ascii?Q?VXMrOfwEAatYJi58GsKArwv8UJ9DPj2EW70Z4x4LLJW1503dqlyr/VnnezkL?=
 =?us-ascii?Q?vUK2SmiO7cymAFd0eOLGE9eW1EOG8JLUsJMLlzbiJ3+SRp4OBD8EQQkgXKrF?=
 =?us-ascii?Q?EzkfAzO+clCctd1sHFBLBV1Dc+e5YHWPmOFC9lw4JXWX852mzfB0o8MwIg25?=
 =?us-ascii?Q?kibf8qqZLR6DrDJwEBnMQr68hr0mptKWW6q8QcucPyZzmh1XjwRvlb701eaC?=
 =?us-ascii?Q?RGbfPAljL76/gVCHrrN8eq/+b7JzOh69Q2x8UK/G5KxpdLsKWqfRaDMcdBSB?=
 =?us-ascii?Q?Jtqy9aeBMiJjKVVfqMhpfp/bcTAXKxXeYQGgtYzEytxfiA/cF0vWpJhQiW7b?=
 =?us-ascii?Q?/FNexO2gV/lZP6hJDFIu/iuj2+ChBJb845E55h959BjzoAOFNnVzJk2DvrUH?=
 =?us-ascii?Q?ApkP5DMomBAYf6VHfncJh29XvEXFblEYlNHWbhFAXXeoUmlz5f5SZgk4T1vl?=
 =?us-ascii?Q?Xw4+Xdlq1umVghH/Mt09YP69CtSu03sJ+CFApfiwyH3fJlOHtff1Togs8xWc?=
 =?us-ascii?Q?lfM0oqxHnip9PS06z+gAW7+ye1qTiMdImH+fK8l47Dy7HfiySabp5rQehoeo?=
 =?us-ascii?Q?D2RU1ieHNFckXoWnEW7rnZ5t24ZWcK/Xl3pZgwZKCHdQdyRoU/I7RzbAebmZ?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff25b082-7c74-4364-95ea-08dbf42817ff
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 17:48:44.3575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTtoAxVqZbGut3TYly60gif9kgkedJXFUJLnnggiUD4lm79WyJ6RDKBvOTWvFV+NujOnIpH6TWeWITdS9533gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9711

On Sun, Dec 03, 2023 at 06:30:13PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Dec 03, 2023 at 05:16:54PM +0200, Vladimir Oltean wrote:
> > On Thu, Nov 30, 2023 at 11:10:19AM +0000, Greg Kroah-Hartman wrote:
> > > > Why would we remove name of the current company and use the name of a
> > > > company that doesn't exist any more?
> > > 
> > > Yes, this seems very odd.  What is the reason for any of this other than
> > > marketing?  Kernel code doesn't do marketing :)
> > 
> > I'm not sure who is doing the marketing; not me, that's for sure.
> > The patch that I'm proposing undoes these strange aliases.
> 
> Why?

Why am I undoing the aliases? It's in my commit message. NXP now
produces PCI devices with a different vendor ID. If aliasing is the way
to go, then are we supposed to add a new PCI_VENDOR_ID_NXP2,
PCI_VENDOR_ID_NXP3 etc?

Mellanox was bought by Nvidia and I don't see its PCI ID aliased to
Nvidia. There are probably countless of other examples.

> Who did it originally in what commit id and what was wrong with them
> then?

Does it really matter? "Git blame" on the line with #define PCI_VENDOR_ID_NXP
will point to a random commit by Wasim Khan (also CCed). The usage of
PCI_VENDOR_ID_NXP is not widespread, it's only that commit. Everywhere
else in the kernel, 0x1957 is referred to as PCI_VENDOR_ID_FREESCALE.
I can't comment on what was wrong with Wasim.

