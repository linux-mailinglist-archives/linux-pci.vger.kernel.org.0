Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9032868E166
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 20:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjBGTp4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 14:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBGTpz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 14:45:55 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA493BD8A;
        Tue,  7 Feb 2023 11:45:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAdJyuvAERh6F+gPSk4wbgi5ksCcVkBc2OmDehDI3sKVX1u1OODAB+7ValQLGceGo0VhJn0MTBOhIFDs215pXJ48kPiyD/XPNj1eaSHUlqqhDk9GO1jbnpcD4zpIHJpPSqYXEVJdn2vW93H/niGXLJAIEmO3WO1jZVwdD+Cmgw9KWU/2a+2e4obAirVq2idlU1KKeM3K/+XRBGjgjAkZFXZJMlyGNJZCjuVC+ZvczlZP5GEzPzKS61wy0+5VAxM4J7Zo383OqRqWw65Ql6nSfIbt0OWwnDAFMGWU9td1zkCsPXNrCBQQ6SXAUvqAqc3MYvakQFlRsTYHSKzkFDy9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOA1C9qzBWIVM+eKFmW23eB/BzDI1Hn9aQVl2ZGRKuI=;
 b=kr2J/YoVOVjfAZousRH6fprV8BkCNdydMZMeHodPuisnT08NPzBGQ79SCgosU08LHVQDh+VVP5Ys9PPC3OdJYsJjvbBRSRD3hLq5SE/5/jDKufvwh+qq6EjNwfWGsCM+2s/1rNDPU1nCmh47hkFxFOCkwXfxeOt8N0dOWdef+Nd4oyArUqSG9YHnmWY74ARsWwC5oNdzArT5Lcyj8itKEBCeeHzMD5h447+xBLPizEEVdXam97zvT7YMzCwoofkhFLZYenkmbB2C9hHqnUIajOhk7P04bf7siyaI0XD0kLaAobMKgOGPCmqB/zOACOmsFuVJ7e/V4DyTY/AY4DjQ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOA1C9qzBWIVM+eKFmW23eB/BzDI1Hn9aQVl2ZGRKuI=;
 b=bNVg1PCIJk6/Vyhm5S1EpmaGHjkvRwT/VRBsm9HQhEiX1PpDxky4K29ySfoBgjn2Pza3OT0AxNQRAx7/jfEh84Ql7VITlHvdAJEkX2VnTH1bXnM/9bXq4j+QSoeAjHC3u/9PEDQx5R7fIFNV4dV1fJd9J0TpQOKbN9P3awbAZvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by VI1PR04MB6925.eurprd04.prod.outlook.com (2603:10a6:803:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 19:45:51 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd%6]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 19:45:50 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mie@igel.co.jp, imx@lists.linux.dev
Cc:     Frank.Li@nxp.com, bhelgaas@google.com, jasowang@redhat.com,
        jdmason@kudzu.us, kishon@kernel.org, kw@linux.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, mani@kernel.org, mst@redhat.com,
        renzhijie2@huawei.com, taki@igel.co.jp,
        virtualization@lists.linux-foundation.org
Subject: PCIe RC\EP virtio rdma solution discussion.
Date:   Tue,  7 Feb 2023 14:45:27 -0500
Message-Id: <20230207194527.4071169-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::27) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|VI1PR04MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 3875e180-6c14-4e55-5362-08db0943ea88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeevlhRFxpIwmE1A6Vqc6v3LbNoG3MPL2Sxkusn0O+aIFJ6UQC8tk8XGVeS3LA3dT8ahmoPigWvmf6x5gzTvrGSDDDlz/ov3HtMdQFZPC7TViWqyOSXfLP+nXxUptygE/L+PEG4+PFwcUmWtMsYM1tfRKLjQRX4xparEvwS9/w83SI/wmrzmcGZ7SrMyLR7cJO3KvCK7WWV8YEODUd+XMEXGy85Al0EzSSCvYAuZWPuOc4QLDBmvdiM2uNp5xW2mnaC6l4PW0IQhvrt2IhIu1nTQaSg5sdUfKO0ADBIXRybj+mDyY9W9xcE63e3VkgIJd0NOQoN7Ev4l1y1A06Ra7FIAN40bWojH0hprGkATUCC6NI2lp8PsbwCcz03PVGpFlr+O+yy1KW0bVzU+pTtFMxAbwHH6oPMffffXfkgfcx3M9zCZ4/dsd5Cw9bTIy5LZaBCsr3gNZM31v7Dr00K4fWsOf6hmfdUt3+KK+6B9E2wB9QNMAEAZvbnVTJ6wjzgufM+Zo0m/SjzVQfE0HTgHqBlb4IOoIDmQRBJEnHALQVzQCg8uVPjZtUd5UirEVt6Mdwfiz7V5C0R3+MKv3Aw/qlz39gHmkqQ6EVDOwyxwBhp1nMve2AJjMcm+aKZ50FCIMJOuUQCu2Yo3+ofRA9Wz2QBk5uBfoBGR2bNspYBT/iE9d5fjm0ulDjppLl2gWDj5wUDne6h3/LlFBlunv1L97JzZ2zOmooZi/VDFj5Bm6hROTRGkbHWdWJd1/Z1pwJ97HL0wtmZsBw2hAtmBcz9+oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199018)(478600001)(83380400001)(966005)(6666004)(6486002)(52116002)(6512007)(2616005)(26005)(1076003)(186003)(6506007)(36756003)(86362001)(66556008)(38350700002)(8936002)(66946007)(5660300002)(66476007)(41300700001)(38100700002)(2906002)(7416002)(316002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmFxalZFSjYwenJNK0ZDQUhBWlBvb2tReGxnMHkzbkVibmo5emI0bWJTS05a?=
 =?utf-8?B?N0xmc2twMEpBOHRBOWI4UVlON0Fua2NQVTZ6dHNNRnVOTUJVRGtSVXdGejJv?=
 =?utf-8?B?OUFhRUtWOGhJZnJYMTlOSzdYVFdMTFF0RGtyU1dnbXFmMTMvdTMwbmY2dVpL?=
 =?utf-8?B?YlM5dVNZMkFRS3NYT1RTNlZ5WlJBVE9RVSsrQ2k1YUJqSkRrZ2lNMlNxaWR3?=
 =?utf-8?B?MTd0UnhLZzQxb0hvUHFaVW9XQXpjZHhnUEhuM2hTT2JJTDEwY2JZMmR1dW5u?=
 =?utf-8?B?MTJKUm5QSXo1Kzlyb0RuS0x3dlh5OEdQREdPYVFqQUtWL25lYzQ2cjdxMXMw?=
 =?utf-8?B?WWhGWEZud3dRSkFXeFE3VDNYY1VjOGRZV1I5a2w2dTFzNjlnZk40eUZNRWtm?=
 =?utf-8?B?SW5CM1BkRGxuMUplSzZHYVllcE1icHROWmFoMWdleW5SSjJWbjYxZHJRUGl6?=
 =?utf-8?B?SmlQb1FobXIrcnh2LzlsUmhqNDRBeGp6SHhsWWljYU9TS29nL0hxRGpydzcy?=
 =?utf-8?B?OTJXclcwZ3V6MHlIRTAvQU5LSFdWUHNHdUtudHVuSXp2cE1GVWE4TFpiTFJT?=
 =?utf-8?B?eTJPeExpTVNoVmN4UmsyelhUaElkQkJzUkFwaUp3S0ZuZjcwUUc0bGE2S3Fl?=
 =?utf-8?B?bElmRE9zVE9XMmF4RXgxcGEvR0RTMXkrd2JpbTNqb1lxc3hnQXVMZkthVytk?=
 =?utf-8?B?U1FOa0Q5OWQ2S1ZYdyszdEFXNDhnV2UzanNxN2RXOE1mdEtFWnlHNnVkbW56?=
 =?utf-8?B?NkNEUTdDUkZDeWVRRDFHSjg0Z2pxSjZBWGNUc21vQkYxdnpHeGRhbC92Q1Bl?=
 =?utf-8?B?a2xwWnlkNjJMcHM2a3ZVOUxPS0lUcTBTVjltZVBlNVB6UHVkOWwxWS8wRFQz?=
 =?utf-8?B?cytNK2FiNWFVWWhSRDY3MlRiMytTR3AyZVFSYjF1eTQxQWFwU1RMS25MeVh3?=
 =?utf-8?B?Mk8vYko4eThNSmlpamdlNVhCT0FmdHBpRWwwcEdhRkdma1gwa1FKbGJBdGFh?=
 =?utf-8?B?RTMvcCt3N1VWSVZhSzY4emkwYi9yYkx5ZWtyY0YyVzNCMTMwUncxbnZyT3Zv?=
 =?utf-8?B?Sk1vN3ZPNEN6YmtmS1d3UlU2YmpKY3N2ZHhXaUEyZnZSdnBTMHJqOEpHMHNy?=
 =?utf-8?B?RUFMUW5EOXZ6aEl6Y0RGeGEyanZIVHdRaFJoRFgvSEF5MTg4VWJYdTNtYWls?=
 =?utf-8?B?Skx4bnNvcHJJNURjcnZhZ3FDMEZYdmQ5YkhGdmt3V241VTFrK0pEbFdqWnB5?=
 =?utf-8?B?L3hqV1JuTFkxWWE1aVRtRTV5Y01LNytmSWxyTkhXRE40dUw0RzQrK3cySWU2?=
 =?utf-8?B?bDZ4VGJxU2dqYkxRdytOYlV1OXdGTnR6MDVSWHBQa01RVjUvTVpQOGFUWGxp?=
 =?utf-8?B?ZU1QZnFHMGhJK2tnMUF0bUYzWVpCaldRVzNSM0J2ZTh2SlZJektBelZ3VzFW?=
 =?utf-8?B?MVNwMUl0c2trb1djMXAzMmVpMlZCTEhLbVh3ekl3WmYxT3lpR1MzMjUxTHJl?=
 =?utf-8?B?U0NEM3JyNnQzRnpsSFd6U2JzUTBCbXlUMWRvK2dVSVV5aVJ6SHFyR0YrT3ZQ?=
 =?utf-8?B?S2ZjbURZalJNak16WW9VYXBnWXRuV3ZCQnFzSHhHcmIrdkdmTkxyZ3N6ZEJQ?=
 =?utf-8?B?amt1N1hBSW1CYjJGbGMrYWdqdlRJMEQ1eXBTUytCWXpYSkNERVI5ekxRVzc5?=
 =?utf-8?B?U1NzTmEvNmNtVnl4Y2ExWFJZK1ZJNlZWNmJuWDhyVmtZeEtRRFNhcllRZExm?=
 =?utf-8?B?K1pIaDAxdSthSkw1WGxabVFOa2dBanFiUDA0ZW5IalNwUmU3YjhObytkRWJQ?=
 =?utf-8?B?Wmt4TE00cW5LUEZGdFdMZmJScXhkc3UvWlpobmhWV3paWXlnbWVQNlIvUDZB?=
 =?utf-8?B?S0RhVmRBWlNKSnFvd3ZOSGloNnJBS1BDNDhMTzdlTFhyVEtHT1FnK21iU0dx?=
 =?utf-8?B?eG1xRXdhRzhXcWxGZ0w0TXZ3cFNydGdwYnJEQ2pmZm8waXRrb0lqcGlXVy8w?=
 =?utf-8?B?VytIU3JmbHhZSU1lRnk1UWVWM3BqMFJqNUdKaFZMMTBKTkpBZVFGdWRRTFgw?=
 =?utf-8?B?dDFaSUZidHl3WUVuTCt3RTFVTk5BaUJleXdFZ2ZKZG5YSGpmSWtzMmJNTnlO?=
 =?utf-8?Q?1PfgN3f8ELSCZnaMnuZlmmCHL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3875e180-6c14-4e55-5362-08db0943ea88
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 19:45:50.7349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gtZ0yATXITAdeaVoMZLbKsoGoOOJi4RrMVZUlv2f9qPAGBm6sClOrej7JyrEsj3bP+T23crFI8D1LiC3ZlvZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6925
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Li <Frank.li@nxp.com>

Recently more and more people are interested in PCI RC and EP connection,
especially network usage cases. I upstreamed a vntb solution last year. 
But the transfer speed is not good enough. I initialized a discussion 
at https://lore.kernel.org/imx/d098a631-9930-26d3-48f3-8f95386c8e50@ti.com/T/#t
 
  ┌─────────────────────────────────┐   ┌──────────────┐
  │                                 │   │              │
  │                                 │   │              │
  │   VirtQueue             RX      │   │  VirtQueue   │
  │     TX                 ┌──┐     │   │    TX        │
  │  ┌─────────┐           │  │     │   │ ┌─────────┐  │
  │  │ SRC LEN ├─────┐  ┌──┤  │◄────┼───┼─┤ SRC LEN │  │
  │  ├─────────┤     │  │  │  │     │   │ ├─────────┤  │
  │  │         │     │  │  │  │     │   │ │         │  │
  │  ├─────────┤     │  │  │  │     │   │ ├─────────┤  │
  │  │         │     │  │  │  │     │   │ │         │  │
  │  └─────────┘     │  │  └──┘     │   │ └─────────┘  │
  │                  │  │           │   │              │
  │     RX       ┌───┼──┘   TX      │   │    RX        │
  │  ┌─────────┐ │   │     ┌──┐     │   │ ┌─────────┐  │
  │  │         │◄┘   └────►│  ├─────┼───┼─┤         │  │
  │  ├─────────┤           │  │     │   │ ├─────────┤  │
  │  │         │           │  │     │   │ │         │  │
  │  ├─────────┤           │  │     │   │ ├─────────┤  │
  │  │         │           │  │     │   │ │         │  │
  │  └─────────┘           │  │     │   │ └─────────┘  │
  │   virtio_net           └──┘     │   │ virtio_net   │
  │  Virtual PCI BUS   EDMA Queue   │   │              │
  ├─────────────────────────────────┤   │              │
  │  PCI EP Controller with eDMA    │   │  PCI Host    │
  └─────────────────────────────────┘   └──────────────┘

Basic idea is
	1.	Both EP and host probe virtio_net driver
	2.	There are two queues,  one is the EP side(EQ),  the other is the Host side. 
	3.	EP side epf driver map Host side’s queue into EP’s space. Called HQ.
	4.	One working thread 
	5.	pick one TX from EQ and RX from HQ, combine and generate EDMA requests, 
and put into the DMA TX queue.
	6.	Pick one RX from EQ and TX from HQ, combine and generate EDMA requests,
and put into the DMA RX queue. 
	7.	EDMA done irq will mark related item in EP and HQ finished.

The whole transfer is zero copied and uses a DMA queue.

The Shunsuke Mie implemented the above idea. 
 https://lore.kernel.org/linux-pci/CANXvt5q_qgLuAfF7dxxrqUirT_Ld4B=POCq8JcB9uPRvCGDiKg@mail.gmail.com/T/#t


Similar solution posted at 2019, except use memcpy from/to PCI EP map windows. 
Using DMA should be simpler because EDMA can access the whole HOST\EP side memory space. 
https://lore.kernel.org/linux-pci/9f8e596f-b601-7f97-a98a-111763f966d1@ti.com/T/

Solution 1 (Based on shunsuke):

Both EP and Host side use virtio.
Using EDMA to simplify data transfer and improve transfer speed.
RDMA implement based on RoCE
- proposal: https://lore.kernel.org/all/20220511095900.343-1-xieyongji@bytedance.com/T/
- presentation on kvm forum: https://youtu.be/Qrhv6hC_YK4

Solution 2(2020, Kishon)

Previous https://lore.kernel.org/linux-pci/20200702082143.25259-1-kishon@ti.com/
EP side use vhost, RC side use virtio.
I don’t think anyone works on this thread now.
If using eDMA, it needs both sides to have a transfer queue. 
I don't know how to easily implement it on the vhost side. 

Solution 3(I am working on)

Implement infiniband rdma driver at both EP and RC side. 
EP side build EDMA hardware queue based on EP/RC side’s send and receive
queue and when eDMA finished, write status to complete queue for both EP/RC 
side. Use ipoib implement network transfer.


The whole upstream effort is quite huge for these. I don’t want to waste
time and efforts because direction is wrong. 

I think Solution 1 is an easy path.



