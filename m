Return-Path: <linux-pci+bounces-1932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F82F8288B0
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 16:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEAEE287511
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 15:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB4039AEA;
	Tue,  9 Jan 2024 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b1q0SDGl"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EBB39AE7;
	Tue,  9 Jan 2024 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsWvqwv5RhnIKOfrbb8CGC/ryjhNrb36jaktGFVWx+UNLfGGEqneZmwrjHUbxUCoc6pC4BK95X8rAgxFDj74n/Uc5sOYtqSnJWzhrMwTyd3HZUTgvNooW+O1HmYjVnz0Ez/tmLj7FL0xKtt/fWcrfUtUoyabxxb/+ozD1uanb8erEtTb5keXG9//V1XiLNRfbgXmkqX0Q9dyhPs+V54uxwyqAhsDXcS8nVl5GslLxaITq3Tvh2p8kFOqXI2v9Z+TUneMZbeVpJiTUHZpwi6qHyVTDdSOdYQWBG03HWGsTfIJ1I8oaFtRWFEYj2ySpQjxnvUB53En4gk4v/JmjFRZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqpgPRxj/3q3N0RcQb9OQKdbYaEFDxDKGC0PksK3AE0=;
 b=Qn+c4Zl/A6GihtNwg8AP66RkcNPou+OtPIx6pFioug8l17iRr/TIL7vQzJjXe4NHVFAVXLMUVCbF3fIC7XgDGOCjD+mvCmiDlN3zCECYVb0MCgwpwC1TqbNCmQNxXc9tCPiZHb2COgDBYfAjCQvDZJSFbs8nqlbI8SHnZ7CUrCq+uaO2wCfaOyCJFco36GfpCfZMdVWcyKVdxwYudZZPP1oS1sDqp8ly019K7eIIKTIAdwaxqA28xlEgxa1YNvU17ZyKr1yH+yUDyEXbwwU3+c2I9uNrvesaJVzhGWTREbM6Resf+5A2vMSvGOIq550Ff5D3pbrBljnl/MAS6Odf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqpgPRxj/3q3N0RcQb9OQKdbYaEFDxDKGC0PksK3AE0=;
 b=b1q0SDGlBELR4jxXiBWVjQhOjS4uVfFEJkp92ixwNr0e94p0npO/Fpn5BbP3CwyCF8Tf4WbZ/l+45oex871e0bPn18p8oqWM+QgEfLmcV5fOw35Y+MUMACwa1bz5nc+KhFoZZ+/+YkyIQP/S6BFexJsGniJkSHTpcAfFbogGRpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS8PR04MB8772.eurprd04.prod.outlook.com (2603:10a6:20b:42f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 15:04:29 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 15:04:29 +0000
Date: Tue, 9 Jan 2024 10:04:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>,
	"open list:PCI DRIVER FOR SYNOPSYS DESIGNWARE" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: dwc: Fix BAR0 wrong map to iATU6 after root
 complex reinit endpoint
Message-ID: <ZZ1gdRLuirW473Vu@lizhi-Precision-Tower-5810>
References: <20231219044844.1195294-1-Frank.Li@nxp.com>
 <ZYFrUWM7JXdv7rtb@x1-carbon>
 <ZYGmpaf18pJgM/qj@lizhi-Precision-Tower-5810>
 <ZYGq6RdCfdhXFF/9@x1-carbon>
 <ZZ1Pj3MvhQNMnP8M@x1-carbon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ1Pj3MvhQNMnP8M@x1-carbon>
X-ClientProxiedBy: SJ0PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::9) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|AS8PR04MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 7525d6ea-b929-4551-8e46-08dc11244763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rDGVqOyi3L5wB8w3HXOejrQyXNE+/eUPUd00zRKWny+1fdPUfJYfiUb6kHVcN+4c/Zbkv2J7HlWV9kbFSsaGnTz6SnNPAeiGU9iOiMUX8J3bM6cWg0TzjPhWqUdTvFW82CzmAnk6moJcZ2pu6Zc8XGVlPmnywQD5irbcVB8WdLls3GuvDtF8NLUz1BWnbpH4Zu2jLZJWKqVWD/3Y67ZLdAOnTgvLWxWHM4BQk5xGw34BWTTw+4qu6XgCpe4M8vTSrzPOmzkvO2MIuLnyXI9M6bK5UJ6RmmZLCwEIgYxPvKaBUAJ4UjmSlCugIdxDT8p6u1CshVIfckK8Q2bpmPw/DOU2FYMZgGCbMigmJWW8vlkrg3LBHBXfZ7rqUGhdNTKy7eUBoVQNaiImQBgWYKZGmitKx0y32vcq4zcOUXjNTwIPNyG6gPDbCB/JUlpVnAl6+wvcb3cavPvvbyLlEH1jsWOCOoK7EXIz9uKQyAT0hUAKgFDoozPVFvTmBbIVWHWNi/51vYRO5fIT2BAX74Nft4gEwObj2ShAtpYUs5/sUk/Ru9rddQdL1Ya09+iQeauztC2K0r8uUauAzereWoNl0t2hxaYuWmsTezxjJ3zHK+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(396003)(136003)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(33716001)(41300700001)(2906002)(4326008)(52116002)(6512007)(9686003)(6506007)(478600001)(6666004)(8936002)(8676002)(38350700005)(5660300002)(7416002)(54906003)(38100700002)(6916009)(66476007)(66556008)(66946007)(26005)(6486002)(966005)(86362001)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xnr9b0JLdRFxoqcBdsfYgXuNC+ouh1uFHCyO9deDZgFVDoHfZeH/y4D4zQki?=
 =?us-ascii?Q?Negi1nlEJZw4qKtodFG7slImj7RQTKikhircDVare+E5JeDTaW5uKXXJmMWO?=
 =?us-ascii?Q?236axuQGQJPpCxkmXdhqhB5rF4P/V0XcORSOfu0y+alZRTFNbmW/v4vSdob8?=
 =?us-ascii?Q?m6m6KadiqjKjPDFGeQARiQY90G4zU6cikLcTMjj0HtkR86jXgxBWnw94J8o4?=
 =?us-ascii?Q?qtiaKLp/r1GSzzdKn6CFg0/puGAzrRKrbJYIGRKz6cZG2ex03jNI0MIluygC?=
 =?us-ascii?Q?ioPvuHaEhxjJuWb/72fv43b7XfGp77SnncI58fHea1wiuz4J+T3+PXai5b9Z?=
 =?us-ascii?Q?lSx24hdAyt6YQaVOJxCzJQzXRxmGTzBsH+mPVG6HhqOMsQZU7oA5MqL3JNY6?=
 =?us-ascii?Q?YGZsAgzbsJWqz59sVH04IMaXz/HHHH1aE7QX8iQkhG41E8CQxDx+LRZqhToq?=
 =?us-ascii?Q?zomlAYncQJ5omwRv38jJYJ6AyJT10OvVAFmiFkgnzBuyAC6iWzvrhQEVTuZs?=
 =?us-ascii?Q?0IK0861SzOPNiDjvUCz76+iJ7UfNEES/NSGw2Kc1ffqPdHih0iTlcY6VUw9f?=
 =?us-ascii?Q?I2VAMh1GOw03HDrP1+2IofRq5xY+aLXvp5NcvjJ6DFzMTNSuQ90HiZ8e9BPg?=
 =?us-ascii?Q?8Pd/BHKYbgaMd13WaXi97LqGdWX8kcFzc9FhKq+G134pvcLj3Wh1Z6uCh/+A?=
 =?us-ascii?Q?lZA8J1Aw0PldzT44qTVCh4j0IR4J000P0D9mvzHSOYxGhzl6H1MCJfQ6oMY+?=
 =?us-ascii?Q?AXXOwBqpHaZWKZ7x0f/YR0RbSy+MeT+vJjI9gSA4DGZn416iwERf61F7myre?=
 =?us-ascii?Q?EE0ylO6MVwtOA4hHZ6QKwOXi05Qx0tttzlC1xAjeF1gi099GvqrjHFORWKqM?=
 =?us-ascii?Q?jW/stKHS5So1Rnymq2yUBvV+iG9U03tT4KHD53X6SgJUxQDU9NwqlwdFZ1fC?=
 =?us-ascii?Q?EwLOWEbnl40gkKTHKOOYJZU1ZdIffrO2qnmRDqGnRs/tG6xDOY6ZLwFdy9f1?=
 =?us-ascii?Q?7aEKiX0VWGlJV5Rmr76t8XHPcsWXU8FDzthrV4Gwm1EM/qkhRRafzFOMS4jk?=
 =?us-ascii?Q?QLZENqq7g9fqufmtFPyTuIaRNQJxN44sDT7HMois5zYrCr5mse0t7F+V8xzh?=
 =?us-ascii?Q?U9d2dLzmx5fvhgblRbqMGnVSEfe0ZCqgat/9+ravsJIOIn55XJSg/O6XpCrZ?=
 =?us-ascii?Q?LAOtMbIZ0Td2KlbGeMeAKiEEkgLpKZkeeYqe/88cbfCQ01TjBcRVyGjs+UAz?=
 =?us-ascii?Q?m6w8VJDHOrSGCEmkchZwA5U83ZV9lfqEmE0zAmqAtXTSljy5yuooo6EuzvEU?=
 =?us-ascii?Q?lQLSTHtjbhVLAG1zj31FjTSX/au/6xf3Wz+VqFhuykmJHAYYRbtxMQCBb19R?=
 =?us-ascii?Q?zx4mJiwqn+GasnyjaoS+zBOuQtMzwHMbvaiQrgy1iuq78k550BqxKbovV8Rc?=
 =?us-ascii?Q?5Zk7u3x23Rg4jaxkfZpEJI82Z2jy/0rMiNdh4d5D8Eo8KPyHuoSGwD/D7qIU?=
 =?us-ascii?Q?F2IzkNiZmBhkYqvJ03/UFNDp6Z7/kNC3RqGkOF3jKDG2S7DQfcsiP7wArrOX?=
 =?us-ascii?Q?8I9iwS2M2GTRj3JZXY0EJRt9+4sbb0dY/+7Skjmk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7525d6ea-b929-4551-8e46-08dc11244763
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 15:04:29.6724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZ7QS+BrS8PFfGTbm5R7w1/EqC/FcLFMhQk5DAZniL7zNyo96aFpj2x1N5u+7VAeGO3mGOKkO5hyod4QhQE7eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8772

On Tue, Jan 09, 2024 at 01:52:15PM +0000, Niklas Cassel wrote:
> Hello Frank,
> 
> On Tue, Dec 19, 2023 at 03:38:33PM +0100, Niklas Cassel wrote:
> > On Tue, Dec 19, 2023 at 09:20:21AM -0500, Frank Li wrote:
> > > On Tue, Dec 19, 2023 at 10:07:14AM +0000, Niklas Cassel wrote:
> > > > On Mon, Dec 18, 2023 at 11:48:43PM -0500, Frank Li wrote:
> > > > > dw_pcie_ep_inbound_atu()
> > > > > {
> > > > > 	...
> > > > > 	if (!ep->bar_to_atu[bar])
> > > > > 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > > > > 	else
> > > > > 		free_win = ep->bar_to_atu[bar];
> > > > > 	...
> > > > > }
> > > > > 
> > > > > The atu index 0 is valid case for atu number. The find_first_zero_bit()
> > > > > will return 6 when second time call into this function if atu is 0. Suppose
> > > > > it should use branch 'free_win = ep->bar_to_atu[bar]'.
> > > > > 
> > > > > Change 'bar_to_atu' to s8. Initialize bar_to_atu as -1 to indicate it have
> > > > > not allocate atu to the bar.
> > > > > 
> > > > > Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> > > > > Close: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
> > > > > Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > > 
> > > > > Notes:
> > > > >     @Niklas:
> > > > >     	I have not test your case. I should be equal to previous's fix in
> > > > >     mail list.
> > > > 
> > > > Hello Frank,
> > > > 
> > > > Thank you for sending a proper fix for this!
> > > > 
> > > > Personally, I slightly prefer your fix that saves the iatu index + 1, and
> > > > keeps 0 to mean unused. That way, you don't need the memset, and you don't
> > > > need to change the type to signed, but either way is fine by me, so:
> > > 
> > > index + 1 don't match hardware iATU index. It will be confused because
> > > other parts is 0 based.
> > > 
> > > So I choose "-1" as free iATU.
> > 
> > A s8 can hold a max value of 127.
> > CX_ATU_NUM_OUTBOUND_REGIONS seems to be 0-255.
> > 
> > Since the DWC code can be synthesized with 256 iATUs,
> > your code will not work on systems with 128 or more iATUs.
> > 
> > If we continue to use a u8, and offset the saved value by one,
> > we will at least be able to support 255-1 == 254 iATUs.
> 
> Do you plan to send out a v2?

It is easy to change to u16. But I hope Manivannan Sadhasivam have time to
review it.

Frank

> 
> 
> Kind regards,
> Niklas

