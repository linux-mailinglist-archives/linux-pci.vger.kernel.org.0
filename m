Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46F076E6FC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 13:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjHCLee (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 07:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjHCLec (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 07:34:32 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD6D1FC2;
        Thu,  3 Aug 2023 04:34:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzjHAPJjN8rXYGZfgnPxau1ZnAFyKsK40hs+lvBXDRRSHN2Js5YchdBnwBmLYPAKS6s2mAY0bv0q9bikJRu3pp1TQvqkwg8vy/oiiyx/wnR+wOlPcyajg3/TA8O6Ps2X5DyAJIvpWz70mCY0GRAsEThgc/aoI9Vpx5hbZ7FMMLLC7rKxOnXTKRhUKg/REver3Zs4AXzS3Z9OxzXM6wQQKnzaC3B2ihq3osrsiVCMELSJ547rSWvhsimI+K7aNzmySlAjZIlFo7zOHKRZmxHmnydP3zSB7BKYYzOHYxkA02CMMxVzhrucinbu3t8ALMZjyO2f91xt76Oby4LJcJugkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RI9N8euLt+6eGH6wlmIBlRmp6QT/6tv5yn2El66aLE=;
 b=fk8BItYTWUUaUaXQiy7uW9F9ohJRLEcLD0L10BnJuBQJ5hFqiojXSG7sgaNqk4g1VjV+VjqWENjM+MIBcCUtR0SricB+KMRqbk67Em6+FU5PUuO2xgMKWcPmBeICnkKolkoCGS/nnnwj5nZ8W3h7S2S6suEtDMHGbndx/fKXM5peat76cfync7Bgo5HvN183JSs39gHBkfSRQAVhyKavjViiobKINGOwoPH2nGm1wGNl3vBNnaA6+FehMVV/NTdvXIFXge4Yj3+/SYimhefhRsIL9ytW8XmIZO1JknfMZn4dEUj0DGO1mLaZ/GI7ZOmOnWGvxf1lPgG5FM3C1ErP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RI9N8euLt+6eGH6wlmIBlRmp6QT/6tv5yn2El66aLE=;
 b=CFDwaUN8psm0t+jz3SwE2het3BShvMFkxyuOTg5zfv2QNES0xdJBHZ9g8yvwDFZHjG/ur/EnTugo97xE8mZWw8cbhtloHFkAb/YnhS0yr5Fyxy4nnM8eWLvjKk55M3XzvSE34XkirfqGuGDpAePrnn/j3B3Ln+AYTbXijk3/z6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB7499.eurprd04.prod.outlook.com (2603:10a6:10:203::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 11:34:24 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 11:34:23 +0000
Date:   Thu, 3 Aug 2023 14:34:19 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH pci] PCI: don't skip probing entire device if first fn OF
 node has status = "disabled"
Message-ID: <20230803113419.7tj4v527pvvqsvxo@skbuf>
References: <20230601163335.6zw4ojbqxz2ws6vx@skbuf>
 <ZHjaq+TDW/RFcoxW@bhelgaas>
 <20230601221532.2rfcda4sg5nl7pzp@skbuf>
 <dc430271-8511-e6e4-041b-ede197e7665d@loongson.cn>
 <7a7f78ae-7fd8-b68d-691c-609a38ab3161@loongson.cn>
 <20230602101628.jkgq3cmwccgsfb4c@skbuf>
 <87f2b231-2e16-e7b8-963b-fc86c407bc96@loongson.cn>
 <20230604085500.ioaos3ydehvqq24i@skbuf>
 <CAL_JsqLsVYiPLx2kcHkDQ4t=hQVCR7NHziDwi9cCFUFhx48Qow@mail.gmail.com>
 <20230803103955.qsp2k7i46cytn53e@skbuf>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230803103955.qsp2k7i46cytn53e@skbuf>
X-ClientProxiedBy: AS4P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::19) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 8750e73f-2dc4-4bb3-a257-08db941595ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZPhw/cqjMuwuMcAIC8igVm0bXbNflEj1pSeLpyr8GP1UUtdfWpXMSRIXL8Aiat3vBCbQ55j65bKWhwYGEgcmWyT9GAEKgm6aCrQZsA7VpUAC0Y4Fx3n1gAWi56I1+HN5kJPRsTrpbNRz0KuHTaF1WXvM8QQzE7QWkqepCBlzxp6oP5MCqQvBa5nWKJddtHwwoBk/4FIm6tImRrqKJAxXSB8RvkKTNfLcLjU6fAnx/yyPAvuNEjUatx34EO6sek/XSw2WIpgJZS4NmL8piYuCqTfoYygFOZh9e4UO4aecFzHsqk1aWaZphiy4mlhxWjrjGr3BfKgBuLun+Vcs5C7bwFfKVTYEMA9IDmBg1ciPAzIXZz2DeM3pD0E5ld3UGvj+AXlQHWd9zs8GF/LLopXUMesI/C5zMYv3ygvTd89qLmf2cLXULZPYMkPtWfu3uBIbOy0fq13Tk4UtfssPMcxN2Go85B9X9da22Kt/9k27VKXqKIbAiEnDtya7r1KjVOdDmtc6LouSX/DkVOjUoa/HYUHhZp3sEIqtA4iC9RowmoPrK0CYIqiGmtbKd+1PArA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(41300700001)(66556008)(316002)(2906002)(4326008)(6916009)(66946007)(66476007)(44832011)(8936002)(8676002)(5660300002)(38100700002)(26005)(1076003)(53546011)(186003)(6506007)(86362001)(83380400001)(33716001)(9686003)(6512007)(478600001)(54906003)(6486002)(6666004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVpuYXNZS2hjdTc2cTM4bXc0bnprdTlDMUYyd0l4TmZraGMyMkN0bEZMTEVn?=
 =?utf-8?B?RUxydVhQVHc0dEFscXhLM0NmTi9ScVRkeTh5c2l1dm8xNHg3QVBoVXRsMHhX?=
 =?utf-8?B?ZnFoaHB6SzhRVWFmOVZiZ3ZtT0ZSRm40SVB5eTZXTWxVUUJPYWNwU0hzTDY1?=
 =?utf-8?B?K2tSRVZ1S0FhTlZYQ0ZGZjJWTzlFcWhLL2NzYXBQWXhDbzlNSzh4ZUErYnJU?=
 =?utf-8?B?TXZpVythand4Yk14eVNLUjU1bG1DaXlXYUV0L1JvYXQ5UnRYR1hjMFM4TlRn?=
 =?utf-8?B?WUZOUEhjTEhwemk0NTlIaXpFa1VUWDgrMFNpSGJQRnpDMUxSTDhQVHpKUi9P?=
 =?utf-8?B?L25FNk9mK3hPb25mQi9qeEV2aVJJWHFlbkVRSW5TSUs4VUI2a1VSYU5ZRkpL?=
 =?utf-8?B?R1V3cnJHeWdzVUVmUjI5LzlReHJXK3R5YWhKV2tRS3p2am50ZUNYRXlHUE9K?=
 =?utf-8?B?eUl5OTRIV2NlZ09EZjVLMGRCQ1dRT2J6UzZUYmt5YStGZ1lBM25GclR6UFJp?=
 =?utf-8?B?d2xZTXJJNis5N0k1bWI3OHdEZmNqdDJkc3JXSkoyNVEyM1FDMGlwNlZ4bUZo?=
 =?utf-8?B?ME43cmYyZDU3Rm5aaGRsRG9Bb0pieXNxdDdxNlZqb0piOVJpT05qbHRab2du?=
 =?utf-8?B?UStMRms5aXBDNi84OUw4bFFMRWFrRit5bGw2R2ZrK0VOY3BadmNaa2taWFdQ?=
 =?utf-8?B?NE9TUG05RWtFdWVqa21aMWRKMDJGMHlKWk9Fa0R1QUFRU1BnSW5lTHYzT0dp?=
 =?utf-8?B?Skg5U2cxaFVVRkFtUTc1OXRRYk1EYXUyQU9xdGNPMUFlT0U2VEdzU2lSWVcx?=
 =?utf-8?B?WCtMaTRZTWdLd3J6dW5XdWlmeW1QSXJlMUthUVJvZnlNR2ZGS0xPcWVHdjRl?=
 =?utf-8?B?TGU3b083Zi8vUy9vQW1LUnRJYVlhUTBOM3UrNWNJZ0ZyR3lMcHErc3Q4L3hD?=
 =?utf-8?B?STFweUVpd3FSSzh1SVhvYzBkQjExc21yM1grbE5Hc0dOQmV3OEJ3QUFQS3VR?=
 =?utf-8?B?NmJpTU0vRjF0WWcvdUlXM2FpNDBsaHBpUTRLbkR3ZVRTVHRWYXMvcXVOdzBK?=
 =?utf-8?B?U0JlcEdWOHRJSm96UEpZUG1zMHZhbkhhaVhxTWJINlNobEFTWFpZbjV3d2Vl?=
 =?utf-8?B?c0p1b3VHTng5aFBLMk9HTm5RUjdIOFEvY2R6SHZCWlJURUUrQ3R5aGZWeUU5?=
 =?utf-8?B?blVSYzFGNHpwbUV4U216TVpUR1RSU3pSVnZUMTZHTklNTlpkTEdqQk8wbmVu?=
 =?utf-8?B?cGRFdGkvMTNQc2V6bUxtcXI2VHA2UzNZMjQzdjJzbDdGTkdabm9FYWVONmF6?=
 =?utf-8?B?YTMxakkyZ0Niays1MHlGQVp5UUlENDF5R1dLaVIwQ09xUUVhRlQyWDQ4NUJj?=
 =?utf-8?B?MXhzZStPT1pSNm9aVUp4UE9YSHB6SVluT25NT3pPOFJpVmxnbnVaUWJOT2F6?=
 =?utf-8?B?TTN3b2FKcWlFL2srcEdYWnYvTThXS25OVG43RHNBV25zeFcxbXVlUTRWWGtC?=
 =?utf-8?B?RGVDZ0pjVFoxTEliK3FlYUlwQklLWHpsaG1yOG8yTjJlZjd1ZDdDNHVPVnJx?=
 =?utf-8?B?NjFnajMzRVRTbzVjcHFhcmNQTk1mOG5HajNPRHJiMG1uL1RyVG83azdOeDdJ?=
 =?utf-8?B?aFBxM3NvQ2k0dHJLV1duaTZ0S0EyTHh5Q2lQbTd3cUFqeTVtR2t4Y1JyRjlo?=
 =?utf-8?B?dS9sZWNWeGpnNjBpbzN3MnJYV1VwUTZZWW45WVkyaHMzb2hXSldUdGRObTBW?=
 =?utf-8?B?bjgwdEh3aVdCOEJGeU94c2NaWmdobnpuRVhWUjQxT3d2cFZOZkdFaC9JTE02?=
 =?utf-8?B?Ty9relFpUEFqdkNUMEs2R0c1WFB5aEMxR1hXSC9CZmtKbjV4QlRlN2VMZEpN?=
 =?utf-8?B?TGYxQ3dlRzkrVW5SaVM0Z1BNMk5RRmFvazdWWWdUci95WHNFR1RNMWFlQnlS?=
 =?utf-8?B?S1hQajdrR3pjNWE0THdSS1dRSTlMT2I0aXBaNEFCa2NhcDIxTTEvbGlzRlNV?=
 =?utf-8?B?RWxHcnJEa3Rvb2Zsd3QrblFjaUR3d21EOVlVcDcxUzFtVWdiUVhtQVJEbmpE?=
 =?utf-8?B?S29hTGh5a1hmeFNibkdNMk1HMUQrVDVpM3pXNExsZk5JbFhtSDYxekduWElY?=
 =?utf-8?B?UGN6OE5uT210WlRKdmpNUXpVNTk5YUVDWHZuTm5SblZJRWx3SllGMXNkYnhM?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8750e73f-2dc4-4bb3-a257-08db941595ec
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 11:34:23.4981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8AlOBH46J69iJB3vPlXVIt8JunfHeiEDVI8/ErZc2wz5ehsYNFlgCQiAHOH6UWaeUip7/6+sKmJv7mLRPi6Lyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7499
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 03, 2023 at 01:39:55PM +0300, Vladimir Oltean wrote:
> Hi Rob,
> 
> On Fri, Jun 16, 2023 at 11:57:43AM -0600, Rob Herring wrote:
> > On Sun, Jun 4, 2023 at 2:55 AM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> > >
> > 
> > Sorry, just now seeing this as I've been out the last month.
> > 
> > > On Sat, Jun 03, 2023 at 10:35:50AM +0800, Jianmin Lv wrote:
> > > > > How about 3. handle of_device_is_available() in the probe function of
> > > > > the "loongson, pci-gmac" driver? Would that not work?
> > > > >
> > > > This way does work only for the specified device. There are other devices,
> > > > such as HDA, I2S, etc, which have shared pins. Then we have to add
> > > > of_device_is_available() checking to those drivers one by one. And we are
> > > > not sure if there are other devices in new generation chips in future. So
> > > > I'm afraid that the way you mentioned is not suitable for us.
> > 
> > If we decided that disabled devices should probe, then that is exactly
> > what will have to be done. The restriction (of shared pins) is in the
> > devices and is potentially per device, so it makes more sense for the
> > device's drivers to handle than the host bridge IMO. (Assuming the
> > core doesn't handle a per device property.)
> > 
> > 
> > > Got it, so you have more on-chip PCIe devices than the ones listed in
> > > loongson64-2k1000.dtsi, and you don't want to describe them in the
> > > device tree just to put status = "disabled" for those devices/functions
> > > that you don't want Linux to use - although you could, and it wouldn't
> > > be that hard or have unintended side effects.
> > >
> > > Though you need to admit, in case you had an on-chip multi-function PCIe
> > > device like the NXP ENETC, and you wanted Linux to not use function 0,
> > > the strategy you're suggesting here that is acceptable for Loongson
> > > would not have worked.
> > >
> > > I believe we need a bit of coordination from PCIe and device tree
> > > maintainers, to suggest what would be the encouraged best practices and
> > > ways to solve this regression for the ENETC.
> > 
> > I think we need to define what behavior is correct for 'status =
> > "disabled"'. For almost everywhere in DT, it is equivalent to the
> > device is not present. A not present device doesn't probe. There are
> > unfortunately cases where status got ignored/forgotten and PCI was one
> > of those. PCI is a bit different since there are 2 sources of
> > information about a device being present. The intent with PCI is DT
> > overrides what's discovered. For example, 'vendor-id' overrides what's
> > read from the h/w.
> > 
> > I think we can fix making the status per function simply by making
> > 'match_driver' be set based on the status. This would move the check
> > later to just before probing. That would not work for a case where
> > accessing the config registers is a problem. It doesn't sound like
> > that's a problem for Loongson based on the above response, but their
> > original solution did prevent that. This change would also mean the
> > PCI quirks would run. Perhaps the func0 memory clearing you need could
> > be run as a quirk instead?
> > 
> > Rob
> 
> Sorry to return to this thread very late. I had lots of other stuff to
> take care of, and somehow *this* breakage had less priority :)
> 
> So, first off, there's a confusion regarding the "func0 memory clearing"
> that could be run as a quirk instead. It's not memory clearing for fn 0,
> but memory clearing for all ENETC functions, regardless or not whether
> they have status = "disabled" or not in the device tree.
> 
> That being said, I've implemented the workaround below in a quirk as
> you've said, and the quirks only get applied for those PCI functions
> which don't have status = "disabled" in the device tree. So, as things
> stand, it won't work.
> 
> Also, the original patch on which we're commenting ("PCI: don't skip
> probing entire device if first fn OF node has status = "disabled"") is
> needed in any case, because of the other issue: the PCI core thinks that
> when fn 0 has status = "disabled", fn 1 .. 6 are also unavailable. False.
> 
> From 9c3b88196a7c7e2b010d051c6d48faf36791e220 Mon Sep 17 00:00:00 2001
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Date: Tue, 20 Jun 2023 16:31:07 +0300
> Subject: [PATCH] net: enetc: reimplement RFS/RSS memory clearing as PCI quirk
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  .../net/ethernet/freescale/enetc/enetc_pf.c   | 57 ++++++++++++++-----
>  1 file changed, 43 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> index 1416262d4296..b8f6f0799170 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> @@ -1242,18 +1242,6 @@ static int enetc_pf_probe(struct pci_dev *pdev,
>  	if (err)
>  		goto err_setup_cbdr;
> 
> -	err = enetc_init_port_rfs_memory(si);
> -	if (err) {
> -		dev_err(&pdev->dev, "Failed to initialize RFS memory\n");
> -		goto err_init_port_rfs;
> -	}
> -
> -	err = enetc_init_port_rss_memory(si);
> -	if (err) {
> -		dev_err(&pdev->dev, "Failed to initialize RSS memory\n");
> -		goto err_init_port_rss;
> -	}
> -
>  	if (node && !of_device_is_available(node)) {
>  		dev_info(&pdev->dev, "device is disabled, skipping\n");
>  		err = -ENODEV;
> @@ -1339,8 +1327,6 @@ static int enetc_pf_probe(struct pci_dev *pdev,
>  	si->ndev = NULL;
>  	free_netdev(ndev);
>  err_alloc_netdev:
> -err_init_port_rss:
> -err_init_port_rfs:
>  err_device_disabled:
>  err_setup_mac_addresses:
>  	enetc_teardown_cbdr(&si->cbd_ring);
> @@ -1377,6 +1363,49 @@ static void enetc_pf_remove(struct pci_dev *pdev)
>  	enetc_pci_remove(pdev);
>  }
> 
> +static void enetc_fixup_clear_rss_rfs(struct pci_dev *pdev)
> +{
> +	struct enetc_si *si;
> +	struct enetc_pf *pf;
> +	int err;
> +
> +	err = enetc_pci_probe(pdev, KBUILD_MODNAME, sizeof(*pf));
> +	if (err)
> +		goto out;
> +
> +	si = pci_get_drvdata(pdev);
> +	if (!si->hw.port || !si->hw.global) {
> +		err = -ENODEV;
> +		goto out_pci_remove;
> +	}
> +
> +	err = enetc_setup_cbdr(&pdev->dev, &si->hw, ENETC_CBDR_DEFAULT_SIZE,
> +			       &si->cbd_ring);
> +	if (err)
> +		goto out_pci_remove;
> +
> +	err = enetc_init_port_rfs_memory(si);
> +	if (err)
> +		goto out_teardown_cbdr;
> +
> +	err = enetc_init_port_rss_memory(si);
> +	if (err)
> +		goto out_teardown_cbdr;
> +
> +out_teardown_cbdr:
> +	enetc_teardown_cbdr(&si->cbd_ring);
> +out_pci_remove:
> +	enetc_pci_remove(pdev);
> +out:
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"Failed to apply PCI fixup for clearing RFS/RSS memories: %pe\n",
> +			ERR_PTR(err));
> +	}
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, ENETC_DEV_ID_PF,
> +			enetc_fixup_clear_rss_rfs);
> +
>  static const struct pci_device_id enetc_pf_id_table[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_DEV_ID_PF) },
>  	{ 0, } /* End of table. */
> --
> 2.34.1
>

Ah, sorry, I completely missed your comment about match_driver.
So I've added this extra patch and both issues are solved. The fixup
runs for all functions (thus I see no AER errors), and functions 1 .. 6
continue to probe even when function 0 has status = "disabled".

From 3528d4a48cb37dce8d1d83d2fbb465f21a32adcd Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 3 Aug 2023 14:31:27 +0300
Subject: [PATCH] PCI: move OF status = "disabled" detection to
 dev->match_driver

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/pci/bus.c | 4 +++-
 drivers/pci/of.c  | 5 -----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 5bc81cc0a2de..46b252bbe500 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
+#include <linux/of.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>

@@ -332,6 +333,7 @@ void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
  */
 void pci_bus_add_device(struct pci_dev *dev)
 {
+	struct device_node *dn = dev->dev.of_node;
 	int retval;

 	/*
@@ -344,7 +346,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);

-	dev->match_driver = true;
+	dev->match_driver = !dn || of_device_is_available(dn);
 	retval = device_attach(&dev->dev);
 	if (retval < 0 && retval != -EPROBE_DEFER)
 		pci_warn(dev, "device attach failed (%d)\n", retval);
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index e51219f9f523..3c158b17dcb5 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -34,11 +34,6 @@ int pci_set_of_node(struct pci_dev *dev)
 	if (!node)
 		return 0;

-	if (!of_device_is_available(node)) {
-		of_node_put(node);
-		return -ENODEV;
-	}
-
 	device_set_node(&dev->dev, of_fwnode_handle(node));
 	return 0;
 }
--
2.34.1

