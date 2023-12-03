Return-Path: <linux-pci+bounces-381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A16D80250C
	for <lists+linux-pci@lfdr.de>; Sun,  3 Dec 2023 16:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF7D1F20F04
	for <lists+linux-pci@lfdr.de>; Sun,  3 Dec 2023 15:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD62BA40;
	Sun,  3 Dec 2023 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RFwfYZrz"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E10C2;
	Sun,  3 Dec 2023 07:15:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jejWIvalseW87T79Xdyn8CfCfQV5t0DdyNYSDxw4yeFWhKtX+X8yMy3/OjJ4gSKocS4yOwrYrsAUeNZZUOr7z7KWhXOv2W/uJaj7OQsEgYg0rneQzh9uQtRJNiUAlEIF8nbkbXnraB4IjjyN6WlE6hjyzUM2p/FDex635cw0rxQdAVz3L117zIjavs3kgBph/6ZyBxfaSNmxDZLxZO/snXWgaU/1PTz/ik+7TxdEaYH3BzizE8cKhPD7cw6LE4W8uaqfrBMlqlUMzPDEVohlkMgLJsaj2yiT09ziv1bqB/WTiYnl8Bl/6UYOWc3fBRFWfrE3IsLW6FWAJ1GBN3EZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1KCHI5LSky5YF8CsEt52+OIW3Ex+33j3yCE8gtY1DQ=;
 b=ee0PzXYdqD7zwvf/5gBh6j0Gm+KzWKUNytEw/WI4WFmnu1LYpt7bPY3YELFIdEVkqAoxP+91/kco4hSAWol4XMZ6ZPBl0P1p8fEJ6fMxkUdUy/Tv5pfI0b2Flp3PVOKEzqiNRtgLF3ZaA2iZsaw761YITL7brNa2aAP8t36NpBWFM2T6Ks17D/gnA8WLEW1cwZa3v6a7/b3VO84y5F+mftKgSUnhKfjxA1+rWz+ebKrQGO95q/U9L2HYuqpGLG5eFmdLl1ZknyBtMwxrPwxdIvYdsZuVGUzyGF74DjNqOu19LlKTv70zur2WCF2CfgAF3KWJniyKpwzuR+LltB0dQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1KCHI5LSky5YF8CsEt52+OIW3Ex+33j3yCE8gtY1DQ=;
 b=RFwfYZrzelPYwV6B/3ejbIgL0WWXUtgF93yNG3EOwSLoKEM0HE5fScL8WAE0rlzkMlrfJRzOM8nEAwbAgjdduShLxo1KgQ2TJJXbqLQMvSA3ppSQkwmxtsEFKDtS4NtHRZjwurLQVlUOoI0GIk+sDUmjnY27U81lHinj7kF/Q+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB9740.eurprd04.prod.outlook.com (2603:10a6:800:1d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Sun, 3 Dec
 2023 15:15:08 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Sun, 3 Dec 2023
 15:15:07 +0000
Date: Sun, 3 Dec 2023 17:15:03 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, Wasim Khan <wasim.khan@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH pci] PCI: remove the PCI_VENDOR_ID_NXP alias
Message-ID: <20231203151503.vgyy7kidk7xhlles@skbuf>
References: <20231122154241.1371647-1-vladimir.oltean@nxp.com>
 <20231129233827.GA444332@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129233827.GA444332@bhelgaas>
X-ClientProxiedBy: FR4P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::7) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB9740:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4bbf1c-f387-4716-b28a-08dbf412a237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k1px7kwtkG3VNsYYajbDBJkpZULzyOODNYYPVQ3PghyjptBsc/uG3yv8b08PBhD42cduErRTsFeF0JPBy7eV4RouMPMkmEE7WFBspNlaz3qZqbvwZjoRZI9YYUMheTg/NDonzpk9nI5EzUxZWynWU02aArk16+eVAjuc5aKECst/xMZqdcVKIjUBVlw0S/rnEgO2yY9qIgvxJs1NhcAWyU8JWiYra8xUFqeHMLeTkIlJA87Y8XqMsL7JLCfdpwKanZ0p1xYz9OjCJA/zrgY56+ewjPbICseC9gViW+GkGesAfBuBi3GCy5T+JId25ssvAFfEL0Axo73KOQhYkpwYedLC7Gtv3oAsNMYZXclfLPTNPJrs2YMt4ohK8AS5ggvVoH9xjzqcBVskFRfcF/jRZZxtP6tXYkoDLVBUZMtNY6o0pfElo90epvbLjz+13NpN/8Hibs9F7FqZRT2woHCVgaO9g0ee0Zsug4hS8FVThGbhfb5q7RUxsuZ6F58gCtKd8WJQpEmVe+4M8WvUgnlhivXzn2HPfh5C7515eMmWzCY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(39850400004)(376002)(396003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(1076003)(86362001)(44832011)(8936002)(4326008)(9686003)(6506007)(6512007)(8676002)(38100700002)(26005)(6486002)(478600001)(966005)(6666004)(316002)(6916009)(66946007)(54906003)(66476007)(66556008)(41300700001)(5660300002)(2906002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yw1QiRbsfUTeQd8QThBnBIMDLPC7bgMJCKp1Fco+FbzCZYn/XNcedoQSM9nZ?=
 =?us-ascii?Q?EQnl5H6fAPPh8lyIRpuI++5vlGIerEtw3hu0jIlmu4/daOkyndMZnsnNrJiH?=
 =?us-ascii?Q?rozOt/agSBaNuDGoDwA44Ypq4pHqmPG93H7lxk5nuE6HwIS1EhrNNBSscA+6?=
 =?us-ascii?Q?qsykGq+/RKToXWFXoBh5Jw26ycPrCN4t8hke0RMOct++bJ8/yKsrNsHHPVW7?=
 =?us-ascii?Q?GviENf24DusO5QX/Hw8umxPVikFlwiqo0Fo4QEJf8twdgQmDGbs97tM2Wa2T?=
 =?us-ascii?Q?saI4CC/tRxKK6dhFC5Hibj03nKkZdwLnnxoE+8lU/L5qZoe5syHd9y93uO1f?=
 =?us-ascii?Q?tH5d174VmP8N7XNKRlGtRzaWq5qyY4RP82TQdETgk8wjlhkkpUzRd48z6HpL?=
 =?us-ascii?Q?M+4fugUbhDEIV1UNBsE4lXwqt//e/UC+Ykf/L/5FAgk5YIaypJ8rb60e28UC?=
 =?us-ascii?Q?Uk2CulG5HAOa7pAzsj2darcHH4V2WyWrR8tZIIsfLCEtSDU5xe9rtOUNeOFM?=
 =?us-ascii?Q?mCjgd4ZwnqHVW1IE9Fmwl9YZIwKBt0r2o/q0ttlP8DLnHvdMT9WTAPk18TD3?=
 =?us-ascii?Q?rJvO/SnzvDijHNLDX3+Zs0QGgfzEoCgca3FlqayGV1sZYuAhmWNJF+td4B86?=
 =?us-ascii?Q?oPC12hk9wCWXB9q0+W1F3imxbcAvexTCjemSOoyBadi69U4lLkED1++GLPYj?=
 =?us-ascii?Q?jRLX2kjl/Z+ZQWluJ46pzpr1bwJZfMKSv8RrWgmUksYCVuK6HEIsExogBPJf?=
 =?us-ascii?Q?1pQM+Ex+Qrh8LmAMLb2aXaNH4ngl6E7HWl2T62dBH8o4k1ahI+nXUB81r/8H?=
 =?us-ascii?Q?M23TpFVunwLZ0VutOU5N5nue7D722DnPaFmS1+RH4RfyxRiOHwcQlhyduyMq?=
 =?us-ascii?Q?miqciMEK1qUSfY0xSXVmj7wWTPKA83xMCyc5PqaQLX0EO2qfhzVuq5CX/AOl?=
 =?us-ascii?Q?rktjkLw61YDioAlNzooecgKbTz764s+XPiLLhJi7yeXnkAr7tCEXuNZ1tUzr?=
 =?us-ascii?Q?RvJ3Z9jg7yJk1ULI7WTJzNWQl5UMPR64yPOU8nvSJm9Y+pZGEJLNBCJRW3Xz?=
 =?us-ascii?Q?aZMlVk8l9PxYlMcSwGJOWaVtKsPNUCqzEw0QavUYI0UIQumvVBgyFkYWU/a8?=
 =?us-ascii?Q?brBV0ktwbfGfbkNzA9rDfb4/zeIODKbtX6PaRXTqi1P2LjjPVzObwTKKV96H?=
 =?us-ascii?Q?audsWcVH59ZKJ5klEEmZPS6BhPiMM4zUVAf7ZlrSJ6KtKsmlc1OjwmF6zLU2?=
 =?us-ascii?Q?UcxH6czgkRzXUDSV48d+/yU6cNWwpdeLwk3ycSl7/KJM/veqMsQ3bE2SPxRR?=
 =?us-ascii?Q?gPZ17SFeKN52ctowRrW070r6yFdUMM9siFq8Oti/61OHWMIAmppQSeiJDWCX?=
 =?us-ascii?Q?/n2uJXP6hX2NwOYxCawgVcYGEUyehYkNk7g/9LmxqoXHJruLR8gvrMkdsw7g?=
 =?us-ascii?Q?upMJoijg6jy3fExEjd4smzbapRGwCLHAeGDHzThW7jVdZ7OKKKf2pdSRB0ah?=
 =?us-ascii?Q?1VXeigWxKcFCSTE+rYyLIlPAaVjoT6Lq1cROTsoosbEJ2esND1C0LOwq6dHJ?=
 =?us-ascii?Q?4qVq7tD7zxao3RgL1FZsiLmLetacE55ESBI7tYmtczYKeqexmazjBIrQNa6/?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4bbf1c-f387-4716-b28a-08dbf412a237
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 15:15:07.3060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXCJM+EwA/v6HM33DP5Q7xJr+cvXDF/6eCBJPplSiYpxyNC/lS2RGVcm5WmMFlY/VmzJtsy5YC1ZKXJraGsSwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9740

On Wed, Nov 29, 2023 at 05:38:27PM -0600, Bjorn Helgaas wrote:
> Hmm.  I can't find the 0x1957 Vendor ID here:
> https://pcisig.com/membership/member-companies which is supposed to
> be the authoritative source AFAICS.
> 
> Also, that page lists 0x1131 as "NXP Semiconductors".
> 
> There's a contact email on that page if it needs updates.

Sorry, I've no clue what's with that list of PCI SIG member companies.
Of course a company which no longer has a legal status cannot be a
member of the PCI SIG.

FWIW, the lspci tool uses this database: https://pci-ids.ucw.cz/

> I don't quite understand the goal here.  The company is now called
> "NXP", and this patch removes PCI_VENDOR_ID_NXP (the only instance of
> "NXP" in pci_ids.h) and uses PCI_VENDOR_ID_FREESCALE (which apparently
> does not exist any more)?
> 
> Why would we remove name of the current company and use the name of a
> company that doesn't exist any more?

Because that company doesn't produce new equipment with the old vendor id.

Aliasing the old vendor id to the current company name is polluting the
Linux definitions.

The goal, quite simply, is to call the Freescale PCI ID "Freescale".

