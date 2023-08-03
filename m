Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739E676E5D3
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 12:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjHCKk0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 06:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbjHCKkT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 06:40:19 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A42E2D7B;
        Thu,  3 Aug 2023 03:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeZp3I/udfCPUXyGBMzLuTtzF2YB2fV6rCPWFPD6rI7kWjIECqusBceXB2NkDDerWifrudO4XzmD9nTtvqm55WgBCdscnZKeib900V1f5cmoiYxItklKnedEhuu2GQyu5Sn4ZmCAnwxevjIyEGdJ0Ui0HdZNZhmTo38CijJeLXliPx5EKY7aj3enlnGP+/gSrIO51Drlxcts0elei0NOpXUiJDRwkhKdu3s/Kwgko+yzdErdrgqGdQsQmLuJCVOBrXn6wwoI246i73Sz5/ISViD9dPXVp8ZBh0wLYimNlM1eWorLBXbW3aKTUsJkRf9jfkt33JyYZgYodR6PZcAEiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBKd576hAtnPTNZpZHXXsfKhR1ZJaoxSlMNESmHpsyg=;
 b=nsmv7nax85OoONz+JDyogfuUri+OrbXX5cNi1LxV4JdZIz095BPa5s7RvDmvoq8zBF7bK+MdsdsIHN8A0mTWRE60+4eI8c2obljPRRqci5ug5FwTSlpTpdnRvFz7RF7ty5JOT9yXRfvI7Wxbhc2nHVmyHUZMXeJjX3IcIgkGddYaN2/TN4ILVWwNhXmTzKLigHX1N0pvP0vgV2HiXBpu8eHj8J4njNeU2FgbjBpEYdsIjor/3Y+fnwWbaZASNyV/xFgIWMMzELT5Kna45RnKoFwYPrx5Dm0njeJOjMgdJutcFIOezVToIAj9CH044SlwYbcgDQGCx8sPQW6kvQc6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBKd576hAtnPTNZpZHXXsfKhR1ZJaoxSlMNESmHpsyg=;
 b=nrjbwbI2y6gzz6pwat7TbUPa37CdcpvOVviUlRpnpuMj2WmHalH7NcUxE9EBME47Bl8iNI8dr3tn/PqonKCvw7RsMi88ob5KuTtTWZftJle2EK+95yCv1OTPRAej1NVe8g5aFIwQKE87sz+MO1/+DxQdrrNkYCcwry/HIJYvMUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB7851.eurprd04.prod.outlook.com (2603:10a6:10:1e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 10:39:59 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 10:39:59 +0000
Date:   Thu, 3 Aug 2023 13:39:55 +0300
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
Message-ID: <20230803103955.qsp2k7i46cytn53e@skbuf>
References: <20230601163335.6zw4ojbqxz2ws6vx@skbuf>
 <ZHjaq+TDW/RFcoxW@bhelgaas>
 <20230601221532.2rfcda4sg5nl7pzp@skbuf>
 <dc430271-8511-e6e4-041b-ede197e7665d@loongson.cn>
 <7a7f78ae-7fd8-b68d-691c-609a38ab3161@loongson.cn>
 <20230602101628.jkgq3cmwccgsfb4c@skbuf>
 <87f2b231-2e16-e7b8-963b-fc86c407bc96@loongson.cn>
 <20230604085500.ioaos3ydehvqq24i@skbuf>
 <CAL_JsqLsVYiPLx2kcHkDQ4t=hQVCR7NHziDwi9cCFUFhx48Qow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLsVYiPLx2kcHkDQ4t=hQVCR7NHziDwi9cCFUFhx48Qow@mail.gmail.com>
X-ClientProxiedBy: VE1PR03CA0012.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::24) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 1827fb4a-f9a1-4569-fccc-08db940dfc2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3flJbNJG7nlOZ10Rr/LroHK6WlZ/icLJuquxwNn4hX7/oZgse5tGViSU7P9FisuskHt6CkP/EctKE3X29yMV5Mf4nIlbgW4jUZGm6HZTWYIJaEcIzN5GWy1Ozpw8dbKfnGwZq939pQiTXHF4ZGr3SBPonWQazZ46/8Q0wf1UnywGm9oOZod0c57GDddr+Z4CAV/Ph9AAg8GgtM5OMQqg5PTS01rLSex6skQl5BdqFkeSdt3O0MlfuiFRiPru9sHWb0OX+BE0yG4+pRgvsvc1pkMPQnF0S4WJ0VcuScHwGj7gRinNCXzIb9jLDf+tA1LfU9r+XjBcBs9HMpzd0u5lRdjpbuikglYxlvU0cDnargCCGyxu/IDgEBhUmc0f40I7u7IhPzA/ayVs1yR3ITmUweRdVLDChm+YAYmiX4njYZNf9OTkNwEunNeSvOe90j6oMJCamzIGc+scSWNnzzF5EfJUawWTE1zCPryHFKYn1CWf33IHlM3ndQLrRoX89Wcnty/JzDz9tEC5R7JFK+ikoFLgIvaZbHkdsqwZUgKf0hlna54vO0NJDtwyXqJKGuUi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(1076003)(53546011)(6506007)(83380400001)(26005)(186003)(316002)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(6916009)(44832011)(7416002)(41300700001)(8676002)(8936002)(6486002)(6666004)(6512007)(9686003)(54906003)(478600001)(38100700002)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2NqS1Z3TGdBRUFlMVlwTkNqcU1JSGdJQTNBVXM5cHU3Uk5uT05oVVRyQkxt?=
 =?utf-8?B?RkppYU5MUG92YUJUOFBzUVdjVDhTQWJPQWNNZnhVVS9ZM1ZEZER1bXphdW5i?=
 =?utf-8?B?QVAxWmZ5U0Z3TDJQZHNyVkRDWWhtSXNWcFRMRWJucmE0bnR3bFh0U2pqd1pv?=
 =?utf-8?B?S2hiRlBmeDIydUpUbHdFY1FGM0xhOWZkdmQvREZjVVlrTlJUb3dOYzRaa2lY?=
 =?utf-8?B?ZEJsZldTLzBUWk5rZ0pNVUR4OWM0SkVBWWdDYktISEE2L2RBTTl0cVJpTnh2?=
 =?utf-8?B?NWltVmpRZFU4OWtHdnNKdHNCVVVKWCtqOUlGSVBMRTNRVll2SFRJRVVQelNG?=
 =?utf-8?B?Uzg4Ulhlbjl1REZ3TUt0NFdnQk80aWhHalNYaUZ5c1NuTXNiRnhNYmVFMmJ6?=
 =?utf-8?B?R0xyd3BHdWdzZ2NSbE5aMy9lN0ZickZJc1FCTEZualFDN1dwWTl0TXZEbFh2?=
 =?utf-8?B?amdPSFMrYlEvS2xpVWcrMHB2b3VkRVl2VlJYMjY1WFMzMk9zekQxNkk5MWxz?=
 =?utf-8?B?am9FT2EweGcrcmFoRm9TOWVWbVZLRTVMaGk1cVR3bTArbGg1SlJXbEVHYkpN?=
 =?utf-8?B?YncwUEJyUEo2eGl3V1QvbmRsK1hCdE1mTFAwdFI0L0daRHhKR2J4YnUrOG9s?=
 =?utf-8?B?VlNIOW0wZmlEbHFuSWFSeXpzUzZUM0xQSkpQcXlMOHMwSHV4Z05PWk9KWis4?=
 =?utf-8?B?SG40SmhuV2o4Sjk4cG5EWDlxS0hjZUNiWGNNcWJvNkRxTldjWkR4MHAxSHh3?=
 =?utf-8?B?b01iRzc0THlxdEVYWkJpT3g3d0hsL0pHZHFjK3VvUk9lV2lQWmFCbkZVcEhy?=
 =?utf-8?B?RXplMzloZUp2NC9MM01ZYjlGVFFDMzljNXVIWjBCQWVrbE45NE1lSkl2NHBL?=
 =?utf-8?B?SlA3VmZoZmZKek9PdjJvaDhzM2JhNFFZSlZuV3RnUUpRdUhQNytKZFdFNEZW?=
 =?utf-8?B?bUk4eHNWOEUvbnhOc1Y4eS95TTU2OG5wU3U5R2tKL3lDbHRUSnozM2JKYXJ4?=
 =?utf-8?B?eHY1UUxZYms0cGxKV05BQWducWdCbjFLRGJ3Z0FvQUloT09SMkJQU3ZOTjNw?=
 =?utf-8?B?cEIvTjd6T29veVBuVXBFSW5Bd0pLYU9uWjNMU1hMM2FvbTkxeUF3WU1nT1ZO?=
 =?utf-8?B?cCtNUEN5MnBKREdkK1NsVG1lK245Rm9iWjJmWFc4QW9rYmFCWUdiRGlkSVFB?=
 =?utf-8?B?WjRnR0NvTjdTcTJRVlFDZUdJRnN0alBOUGxvVnJ5TDZFNldMajBQMjQzWWtU?=
 =?utf-8?B?MVZyN0tuZDhzcExHdzZJUmlxaFVrd2dDNEVZYzlSZHhGdFFqYlcveG5odUV1?=
 =?utf-8?B?a3Rhak0yQ1dWRnYrTVFHcU5NT0NQWlBhM2Z1Q2gvSUdJZkVHbnRteFNRZENK?=
 =?utf-8?B?azhFc2dTWTk0NmxDbWZGZGY4RmR6NDFoWUtPcWZHa2FCTFFzaUtyNUFIdkw4?=
 =?utf-8?B?OC9BNm5xOTZoeVM4QlpNRWI4Z0VBaXR2MEQwKzVYUVNLeDNOYlAyYVNrMEhy?=
 =?utf-8?B?eG1MNUk2YVFCSmg2T3ZmZ3laRGdlN0YrRXlVR2pOMm5rMlNTa1JWZU90dXV3?=
 =?utf-8?B?WVp5NDBxeFVZMmU0WFBZNWpvL0UxdWNKY05abzBKZ2lnOE9uL2c3L1doZy9S?=
 =?utf-8?B?VEJHcEY1dkhNaUt4Q2dJVUNraEE0UUIwU0E0NTN4a2lBVTJJYVBjUjN6dTZk?=
 =?utf-8?B?N245S2dyN3duaWFmSDNSM1RiNUlnckpjU3R2bVVNRm9PVWhZSlVrOUNWaDVu?=
 =?utf-8?B?akFlait4WnpybjY2TUlaUy9helV5UGsxN3grMHN3WTdOTTRKUUZCQWNkQzh4?=
 =?utf-8?B?NytscEtBOVNFQUMzdVdDSE1JRmMwSC95cmIxQ1FHaTJmYlNWQjRKNlZFMnRB?=
 =?utf-8?B?SFdNSTBnS2IvMGhFbjRaWVcxcS9YQ0ppcWFFSDRWOTVRWlNwLy9iSmVVUHU0?=
 =?utf-8?B?M3hCVEg1MjZ6K3VJdm5nZVNjTHRSQTQzZ0ZXazBzUi85RElJUkxUK1pnbUVT?=
 =?utf-8?B?eGJQTmIzckYwRmVvVmlnRXpaeHFxalphSlFveFBXaTZ5UDFkMUVyQ24yWnlK?=
 =?utf-8?B?UFlGaUJDcm5zNVlCR0FhT3lGakJtajAweCtCalhkS3BkV3BSVCtRWStJZXYx?=
 =?utf-8?B?TzAyenk4TGZQaXh0VStaMTBoT1lEVEdVWWsvYVFQSk5ML2U3SFEzOGl4ZzZx?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1827fb4a-f9a1-4569-fccc-08db940dfc2f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 10:39:59.2809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6bm+s/xJwBUxfjaZr1n3uGaUmUiTFAqnuSsFkPgFynCIqgShf6W5a+Cq2NOjxZN8DtkCN/pz/U5wiVc982AOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On Fri, Jun 16, 2023 at 11:57:43AM -0600, Rob Herring wrote:
> On Sun, Jun 4, 2023 at 2:55 AM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> >
> 
> Sorry, just now seeing this as I've been out the last month.
> 
> > On Sat, Jun 03, 2023 at 10:35:50AM +0800, Jianmin Lv wrote:
> > > > How about 3. handle of_device_is_available() in the probe function of
> > > > the "loongson, pci-gmac" driver? Would that not work?
> > > >
> > > This way does work only for the specified device. There are other devices,
> > > such as HDA, I2S, etc, which have shared pins. Then we have to add
> > > of_device_is_available() checking to those drivers one by one. And we are
> > > not sure if there are other devices in new generation chips in future. So
> > > I'm afraid that the way you mentioned is not suitable for us.
> 
> If we decided that disabled devices should probe, then that is exactly
> what will have to be done. The restriction (of shared pins) is in the
> devices and is potentially per device, so it makes more sense for the
> device's drivers to handle than the host bridge IMO. (Assuming the
> core doesn't handle a per device property.)
> 
> 
> > Got it, so you have more on-chip PCIe devices than the ones listed in
> > loongson64-2k1000.dtsi, and you don't want to describe them in the
> > device tree just to put status = "disabled" for those devices/functions
> > that you don't want Linux to use - although you could, and it wouldn't
> > be that hard or have unintended side effects.
> >
> > Though you need to admit, in case you had an on-chip multi-function PCIe
> > device like the NXP ENETC, and you wanted Linux to not use function 0,
> > the strategy you're suggesting here that is acceptable for Loongson
> > would not have worked.
> >
> > I believe we need a bit of coordination from PCIe and device tree
> > maintainers, to suggest what would be the encouraged best practices and
> > ways to solve this regression for the ENETC.
> 
> I think we need to define what behavior is correct for 'status =
> "disabled"'. For almost everywhere in DT, it is equivalent to the
> device is not present. A not present device doesn't probe. There are
> unfortunately cases where status got ignored/forgotten and PCI was one
> of those. PCI is a bit different since there are 2 sources of
> information about a device being present. The intent with PCI is DT
> overrides what's discovered. For example, 'vendor-id' overrides what's
> read from the h/w.
> 
> I think we can fix making the status per function simply by making
> 'match_driver' be set based on the status. This would move the check
> later to just before probing. That would not work for a case where
> accessing the config registers is a problem. It doesn't sound like
> that's a problem for Loongson based on the above response, but their
> original solution did prevent that. This change would also mean the
> PCI quirks would run. Perhaps the func0 memory clearing you need could
> be run as a quirk instead?
> 
> Rob

Sorry to return to this thread very late. I had lots of other stuff to
take care of, and somehow *this* breakage had less priority :)

So, first off, there's a confusion regarding the "func0 memory clearing"
that could be run as a quirk instead. It's not memory clearing for fn 0,
but memory clearing for all ENETC functions, regardless or not whether
they have status = "disabled" or not in the device tree.

That being said, I've implemented the workaround below in a quirk as
you've said, and the quirks only get applied for those PCI functions
which don't have status = "disabled" in the device tree. So, as things
stand, it won't work.

Also, the original patch on which we're commenting ("PCI: don't skip
probing entire device if first fn OF node has status = "disabled"") is
needed in any case, because of the other issue: the PCI core thinks that
when fn 0 has status = "disabled", fn 1 .. 6 are also unavailable. False.

From 9c3b88196a7c7e2b010d051c6d48faf36791e220 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 20 Jun 2023 16:31:07 +0300
Subject: [PATCH] net: enetc: reimplement RFS/RSS memory clearing as PCI quirk

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 57 ++++++++++++++-----
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 1416262d4296..b8f6f0799170 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -1242,18 +1242,6 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_setup_cbdr;

-	err = enetc_init_port_rfs_memory(si);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to initialize RFS memory\n");
-		goto err_init_port_rfs;
-	}
-
-	err = enetc_init_port_rss_memory(si);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to initialize RSS memory\n");
-		goto err_init_port_rss;
-	}
-
 	if (node && !of_device_is_available(node)) {
 		dev_info(&pdev->dev, "device is disabled, skipping\n");
 		err = -ENODEV;
@@ -1339,8 +1327,6 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	si->ndev = NULL;
 	free_netdev(ndev);
 err_alloc_netdev:
-err_init_port_rss:
-err_init_port_rfs:
 err_device_disabled:
 err_setup_mac_addresses:
 	enetc_teardown_cbdr(&si->cbd_ring);
@@ -1377,6 +1363,49 @@ static void enetc_pf_remove(struct pci_dev *pdev)
 	enetc_pci_remove(pdev);
 }

+static void enetc_fixup_clear_rss_rfs(struct pci_dev *pdev)
+{
+	struct enetc_si *si;
+	struct enetc_pf *pf;
+	int err;
+
+	err = enetc_pci_probe(pdev, KBUILD_MODNAME, sizeof(*pf));
+	if (err)
+		goto out;
+
+	si = pci_get_drvdata(pdev);
+	if (!si->hw.port || !si->hw.global) {
+		err = -ENODEV;
+		goto out_pci_remove;
+	}
+
+	err = enetc_setup_cbdr(&pdev->dev, &si->hw, ENETC_CBDR_DEFAULT_SIZE,
+			       &si->cbd_ring);
+	if (err)
+		goto out_pci_remove;
+
+	err = enetc_init_port_rfs_memory(si);
+	if (err)
+		goto out_teardown_cbdr;
+
+	err = enetc_init_port_rss_memory(si);
+	if (err)
+		goto out_teardown_cbdr;
+
+out_teardown_cbdr:
+	enetc_teardown_cbdr(&si->cbd_ring);
+out_pci_remove:
+	enetc_pci_remove(pdev);
+out:
+	if (err) {
+		dev_err(&pdev->dev,
+			"Failed to apply PCI fixup for clearing RFS/RSS memories: %pe\n",
+			ERR_PTR(err));
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, ENETC_DEV_ID_PF,
+			enetc_fixup_clear_rss_rfs);
+
 static const struct pci_device_id enetc_pf_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_DEV_ID_PF) },
 	{ 0, } /* End of table. */
--
2.34.1

