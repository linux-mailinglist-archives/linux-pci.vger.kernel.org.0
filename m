Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B143D4C1A21
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 18:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240222AbiBWRr0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 12:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiBWRrY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 12:47:24 -0500
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2093.outbound.protection.outlook.com [40.107.24.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F06142ED7;
        Wed, 23 Feb 2022 09:46:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBX6XJ01FDHyZqut9whwXTYiPMYT4AP7lq+j1eIE2JCYqWQkv+Yyg8+GsyfQYpJVehWplJsQ/5nr3t4nlOgEbSYqr2HRaQXC3yLNHKMW50UTVv6Dd2GgSQAW4zyd1OI6W48GKsmbVP8EoA2JFwYpxQl1BiEsnAPKMGY2oWeFpnRd0b4jRpBar9I8lKOg9pFQ5VCDUCkqHgGZUQC6YHnrlSng3uTaGmlfqMquPsA3mHDhS09RceRDtCxvD/ICBv4ZGduSd0ErHSh3fdewOKU854OlBokdkklGjsvOUz5MhO/j0Rn4b8jNdEDI6efu2rFGna40wRHOJ11kHkFqBipaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgp37HER+FE+B1EUen2pP/7pumBxjBTYxO8RdkyhAx4=;
 b=Vwmh2Yo0eRIUyuWe39YlTA0/sekN2UqzUTr/H4fBetsbWTpU4WumUKiP93zToiFvuY6QXUtwwyqThFQYzCIfEYQnYbo4RuaricFWadBdJAy4Mf5PAeAjt77gC3cEayzWvAk2ZIKK/dmdbcupi0SGeJ+EaHSa64imFAzMzbvjyuekjucq0YulmOiDY/KIGVBHrMJdY313IECI3jUV0ik5jLWihKMz0P1X9sJz5zIILfzizbHHEUt+uyXF1Hr7TJTY3w6jnoRZwKLmW4+po1zigMbOWxSFLx30S/L8xvICl0h7vNZWeAzGNBdhkM5O+1JE9K9H4EQEBLEGkgMhjhfctQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgp37HER+FE+B1EUen2pP/7pumBxjBTYxO8RdkyhAx4=;
 b=C157PwUdHWg7tbO5tTvcYlBmv12faVC+6F+XZ3IDhtI9Nf/OoIlnhSb9Wi7fS+pLCZpsagCGvI6Ts8GoOOzegtKfNCy0R4GO3jWxHYOfVNYrJhkWOmvNPnh75ujjJpDOelzYtMId90Rg3V7gSvYPQMdHqmNkFGLZSpwn9D6k0Ts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by GV0P278MB0452.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:32::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Wed, 23 Feb
 2022 17:46:53 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb%6]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 17:46:53 +0000
Date:   Wed, 23 Feb 2022 18:46:52 +0100
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Agner <stefan@agner.ch>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v1] PCI: imx6: Handle the abort from user-space
Message-ID: <20220223174652.GA1341324@francesco-nb.int.toradex.com>
References: <20220131075235.787432-1-francesco.dolcini@toradex.com>
 <20220210080050.GA7275@francesco-nb.int.toradex.com>
 <20220223130059.GA28032@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223130059.GA28032@lpieralisi>
X-ClientProxiedBy: GV0P278CA0021.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::8) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 050e563c-f5cc-494f-4dff-08d9f6f47a5b
X-MS-TrafficTypeDiagnostic: GV0P278MB0452:EE_
X-Microsoft-Antispam-PRVS: <GV0P278MB0452080D384D96F62D813429E23C9@GV0P278MB0452.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5grVybq4dtInH0OBdGFEUnf1tA9M+ztS5uqeh5B2BjBbQckW3HCjuf09fjUw4csMKOLAG1iUwciGdHezQ61j8xQNv2G0uag0SekImwKvEQPBjkJQE0GrhvVVHGXigTsV8qav9gp+eJiBoeGNg8klhrlARs/kQLBWeQ/PimNaXi/NgmDqw6Yz1RWnd8hYlK8SuKQqY4/kuDASqmfUXoAV24yADwS/qAgSjwq8nPdy+2ogInZveUs7Yv/JpXSci9T2DjrmB57Ds1BF/wvTtN1NSPKf7/dDSgMo1jD/o0IKIX1ey4h+bYW4sVirKwtr5hqIWHSg6He00qJnFAvbkF7nP/EujAGrN3h54E47OfHO3Qz0NnLqlrlBaLC1ZIREu64wQ0O8gGWogHBDa35GMSdinsyUDiV8/Ll0hO7+RZ5fdxfftVy3y7n5TJWdPrKgCYxoI87XyFEaoplEJ0kZNiSm/E48Mobv0JfkwHHO7crGCoWjPqhCSaHYmj5V8nvhh357F+qrWSyd98NpyoDuErrcQFx/AWSEeoqtm3y88fb927GW8eO1CihuSbN9gO0LgEnvGj5aF32yGe1ozTiWTmq1WYfXwQgCsGD1xwZLd1h52+l4mmE7J5tuhit43SAy0+IIs1PuueEFeq1RAShquEoE82rVJCzehacj1lm8Az4qP6PLTBDXIKZrBeaafacvKyKaXp2wg9W2coSR8ZY0NGe/S2l+x8Vp/XAnmt4L7t2DCKsSw3nQN9pyqA2QMHZzxHQevGLeSbVT+NBNsbGfjrYX2ZVusNpWa4hhaUIfy7mDgY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(38350700002)(508600001)(110136005)(6506007)(45080400002)(54906003)(52116002)(6512007)(38100700002)(8676002)(7416002)(83380400001)(2906002)(33656002)(186003)(8936002)(44832011)(316002)(26005)(4326008)(66946007)(966005)(1076003)(6486002)(66476007)(66556008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O5spQ6Jg1Oz7bebb6s1hH5ZAo+eE9fdy2F8hfxYfGwYo1HMhymrWcaXquXGs?=
 =?us-ascii?Q?xRqXS4xSdUK/rHnzfIr/LXH+WRO20bDYkxYrpbPEOKJ2TrA26hnRs60FW4py?=
 =?us-ascii?Q?SAIWE/Y+Nakgd8IL5vLvFau/kZqcT0dt6Hqn59nO5hTKtRXnd5DMBACTHJa3?=
 =?us-ascii?Q?K08KwbmeGUJcLqCEKfl8NJm+JRoPkylQmluHzAe/zvLjvrxgkwKj7E1Ewliq?=
 =?us-ascii?Q?1CHscnN2wxO5GAm2nQzU9TFWJybTVm23ZxyrOxR5YV94LMKX8muJeePMK9Mf?=
 =?us-ascii?Q?3os4/iI5x3ZsyFaSUrhqXKB4/KMaF9KPGMB5O2wHKIO6JIw1kTu+h+D8Qpmu?=
 =?us-ascii?Q?lcYg2AzgTS3G2NQ/vUD9/TDDLhAevZ6Bre5tntsK7dIZurwAWnIbZY8I74zH?=
 =?us-ascii?Q?f6mHaGmEOCPcF0aw7ljwwec5oKBr1lfQgVDIvD8mMMLzgaz6YUHW8LUc/keE?=
 =?us-ascii?Q?sshl8q7N9DshHEprYKLMLDlc6HbrXllOY1SiKd3VyPXGLLBLYG6Zc/h+wX9w?=
 =?us-ascii?Q?Bu4FJoz68kIThy0VGbeaI5jhFVLcoNiRaap2JWHUVY8xMXmcXPdavUZHn9AS?=
 =?us-ascii?Q?P4NYDSsFaWby3p0wBrZIE82fAAoPgg775GbCJx8MimHjHkuog+fiWNPr3XR/?=
 =?us-ascii?Q?sWZYEkqujlzjJGfbU7uf2PWt7ZtJDzUDAKaQazlo0WNo7uTY4UD9Ih7Ra7Bi?=
 =?us-ascii?Q?dCXM08ELaTFEeCz4q8EFTk4uXqHYa6Jz5XFqx1iB35GmL7bZpIYlqiACA1J7?=
 =?us-ascii?Q?CW/KZYV+GkKQNXyQyyi5bV8E5/68gCoA6dWpHfPUBGryvXrLID1feBaHm9Ny?=
 =?us-ascii?Q?j5wzwQhfV5CAK2R1LtpAOPXzrLOpJQ6b+h9VPiuo7ZLSXb8Ugg+NxfibCM35?=
 =?us-ascii?Q?jtXajjtmbPe7BH7Sdf/ke9zOQsghkLnAj2bR3qvDFTsf6xRM7YqAjtGLt5Wd?=
 =?us-ascii?Q?WYPG032AthET9NQVAGgZUrWWDnvhkOEyWm0tQuBHRXoFZGnPdlB+ZWRmZ/xr?=
 =?us-ascii?Q?BYbvOEZoU90VRaG+6q1mm+BJGOnAekcnR3OOMiDx6gnbTrori3gD+M+wyFIj?=
 =?us-ascii?Q?+BTAKG/CgCpIs2MzkhQsC3Kou0ov8T3mwpKWLCeHIvPi4qacnHn4EOjZdGUo?=
 =?us-ascii?Q?r7GTq2jUEYKex1oWUXDnHHCBaGdh2bzOV2klFWiAcJDda9gfHu2crfSqFwRb?=
 =?us-ascii?Q?DxVOQiLvs482fv2Jfu8H6viL3+n/mJuTBCSggy8FLf+BCKxwzmKj9A+15L2o?=
 =?us-ascii?Q?qNbWjKz9tB8GrbykZ0nXOoz6jubr6KcGPbyx3hJESgyCp2VO3p6DhcrkXchn?=
 =?us-ascii?Q?ZaQ87eRQXAAeqgnRT+AfG8P+kGzX77DyTlkyAntp+Qv1D0zVdCK6/4zRIqSO?=
 =?us-ascii?Q?M/BFPJR+OEjLcp9tVVHoEqpoHvkwOaSpmgyu+jYQVNyvhNFGes+3VfBQgdkj?=
 =?us-ascii?Q?usztBWv5TZuFzL14TEiwn1itj57daayffQR/XVB2ukODP2r03NOWYdroY82T?=
 =?us-ascii?Q?4HWy2xhZmKpzaYCPruJqmDzHmXbhhDl36+gcKj+8rMMx6576OYXI3I/mCDqn?=
 =?us-ascii?Q?vKBjw9gCpt8oH1VWIctqSqYWJbhnYif9c/asj9bvSc3uLJDafrfa6duKfqDG?=
 =?us-ascii?Q?S4WyhSBzOyzqCD6EQEX2Z3C8hL5k8Oh3yZtKYtolrYQ4Mr5XG/nVkU81PeuX?=
 =?us-ascii?Q?uxZPpw=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050e563c-f5cc-494f-4dff-08d9f6f47a5b
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 17:46:53.5986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4f13l8uwOQgRODrEAvvbk1RCaHL5GkzLOBJM2XMRic3Ct8MzgsdZCEnq6M2u0//5beV0ZwfJqgdi8H5COUc7q2ngy4z3N96T5D2no6Zmx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0452
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Stefan: I added you to this email thread, maybe you remember some
details on this patch from your previous life.

On Wed, Feb 23, 2022 at 01:00:59PM +0000, Lorenzo Pieralisi wrote:
> On Thu, Feb 10, 2022 at 09:00:50AM +0100, Francesco Dolcini wrote:
> > On Mon, Jan 31, 2022 at 08:52:35AM +0100, Francesco Dolcini wrote:
> > > From: Jason Liu <jason.hui.liu@nxp.com>
> > > 
> > > The driver install one hook to handle the external abort, but issue
> > > is that if the abort introduced from user space code, the following
> > > code unsigned long instr = *(unsigned long *)pc; which will created
> > > another data-abort(page domain fault) if CONFIG_CPU_SW_DOMAIN_PAN.
> > > 
> > > The patch does not intent to use copy_from_user and then do the hack
> > > due to the security consideration. In fact, we can just return and
> > > report the external abort to user-space.
> 
> Isn't this an issue for all PCI host controllers that install a fault
> hook ?
I would say some, not all.

DWC PCI keystone is likely the same, however from a quick investigation
other PCI fault handler do not touch any user memory, so likely not
affected by the same issue.

> Is this referring to accessing config space directly from user space ?
Yes, it is.

> Can you explain the triggering conditions a bit better please ?
Just a short preamble, I'm not 100% sure about the actual details, we
have a patch identical (but independent) to this one in our kernel tree
since years. I found this one in the NXP i.MX vendor kernel and decided
to submit that since it was already reviewed by one of the driver
maintainer, I sent it as an RFC [0] and after it was acked-by Lucas to
me it was obvious to move forward.

My understanding is that instead of returning all ones when we timeout
reading from non-existing downstream devices we get an abort [1], if the
read was triggered from user space (I guess reading directly the memory,
using sysfs does not trigger the issue) we end up with the handler
triggering another abort while trying to read the user memory.

Maybe this is just considered a non-valid use case?
If you NXP guys have more details please speak up, see LF-228.
If we move forward probably a `Fixes: [1]` should be added to this patch.


Just slightly related, today while playing around with PCIe to answer
this email, after a suspend-resume cycle, I was able to trigger this
issue, I guess is just the imx6q_pcie_abort_handler() returning 1.


```
[ 1969.800185] pci 0000:01:00.0: can't change power state from unknown to D0 (config space inaccessible)
[ 1969.800542] pci 0000:02:02.0: can't change power state from unknown to D0 (config space inaccessible)
[ 1969.800557] pci 0000:02:01.0: can't change power state from unknown to D0 (config space inaccessible)
[ 1969.800821] pci 0000:02:03.0: can't change power state from unknown to D0 (config space inaccessible)
[ 1969.842913] 8<--- cut here ---
[ 1969.846398] Unhandled fault: external abort on non-linefetch (0x1808) at 0xe6a00070
[ 1969.854276] [e6a00070] *pgd=12256811, *pte=01f00243, *ppte=01f00013
[ 1969.860770] Internal error: : 1808 [#1] SMP ARM
[ 1969.865337] Modules linked in: bnep imx_sdma coda_vpu v4l2_jpeg imx_vdoa dw_hdmi_ahb_audio evbug
[ 1969.874229] CPU: 1 PID: 16466 Comm: kworker/u8:8 Not tainted 5.17.0-rc5-00011-g5c1ee569660d #11
[ 1969.882982] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[ 1969.889549] Workqueue: events_unbound async_run_entry_fn
[ 1969.894916] PC is at pci_generic_config_write+0x58/0x8c
[ 1969.900194] LR is at arm_heavy_mb+0x18/0x4c
[ 1969.904415] pc : [<c06c7f90>]    lr : [<c0118378>]    psr: 60000093
[ 1969.910718] sp : c2147e08  ip : 00000908  fp : ffffe000
[ 1969.915974] r10: 00000000  r9 : 00000000  r8 : 40000013
[ 1969.921229] r7 : 00000010  r6 : 00000810  r5 : 00000000  r4 : e6a00070
[ 1969.927794] r3 : 00000810  r2 : 00000000  r1 : 00000730  r0 : e6a00070
[ 1969.934359] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[ 1969.941628] Control: 10c5387d  Table: 1000404a  DAC: 00000051
[ 1969.947405] Register r0 information: 0-page vmalloc region starting at 0xe6a00000 allocated at devm_pci_remap_cfgspac
e+0x44/0x8c
[ 1969.959055] Register r1 information: non-paged memory
[ 1969.964144] Register r2 information: NULL pointer
[ 1969.968880] Register r3 information: non-paged memory
[ 1969.973965] Register r4 information: 0-page vmalloc region starting at 0xe6a00000 allocated at devm_pci_remap_cfgspac
e+0x44/0x8c
[ 1969.985601] Register r5 information: NULL pointer
[ 1969.990338] Register r6 information: non-paged memory
[ 1969.995424] Register r7 information: zero-size pointer
[ 1970.000596] Register r8 information: non-paged memory
[ 1970.005682] Register r9 information: NULL pointer
[ 1970.010418] Register r10 information: NULL pointer
[ 1970.015243] Register r11 information: non-paged memory
[ 1970.020416] Register r12 information: non-paged memory
[ 1970.025590] Process kworker/u8:8 (pid: 16466, stack limit = 0x50c451ad)
[ 1970.032247] Stack: (0xc2147e08 to 0xc2148000)
[ 1970.036640] 7e00:                   c06e9620 c2704060 00000810 c06e9638 00000810 c0f65f54
[ 1970.044865] 7e20: 00000001 00000000 c06c7c18 00000018 00000070 c06e9620 c2658c00 c06c7c3c
[ 1970.053091] 7e40: 00000810 c2808800 c2808800 c2252cc0 00000010 c2808800 00000005 c06d1788
[ 1970.061317] 7e60: ffffe000 c06d0880 ffffffff c1709388 ffff97e4 c2808880 00000001 00000000
[ 1970.069541] 7e80: c2808800 00000005 00000000 c06d5298 c06d5214 c190af20 c2808880 c17093d0
[ 1970.077765] 7ea0: c1f23ad4 c088e0a4 c280895c 00000001 c190a200 c17093d0 c200f005 c2808880
[ 1970.085989] 7ec0: 00000010 00000000 c200f000 00000000 c190a200 c17093d0 c200f005 c088f6e8
[ 1970.094213] 7ee0: c2808880 c1f8b818 c2006e00 c088fcbc c35b7090 c17159f0 c2006e00 c0155084
[ 1970.102438] 7f00: c35b7090 c274cb80 c2006e00 c01481c4 00000001 00000000 c0148118 00000001
[ 1970.110662] 7f20: 00000001 c1709388 c1916f98 c1d81690 00000000 c13b76c8 00000000 c1709388
[ 1970.118886] 7f40: c2006e3c c274cb80 c2006e00 c274cb98 c2006e3c c1705d00 00000088 c2146000
[ 1970.127110] 7f60: c2006e00 c014872c 00000000 c3a2ee40 c2146000 c01486fc c274cb80 c2184080
[ 1970.135333] 7f80: c2645ea4 c2c2e040 00000000 c015189c c3a2ee40 c0151774 00000000 00000000
[ 1970.143557] 7fa0: 00000000 00000000 00000000 c010011c 00000000 00000000 00000000 00000000
[ 1970.151781] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[ 1970.160006] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[ 1970.168228]  pci_generic_config_write from dw_pcie_wr_other_conf+0x18/0x74
[ 1970.175163]  dw_pcie_wr_other_conf from pci_bus_write_config_word+0x50/0x70
[ 1970.182177]  pci_bus_write_config_word from pci_restore_state.part.0+0xd4/0x474
[ 1970.189547]  pci_restore_state.part.0 from pci_pm_resume_noirq+0x84/0x124
[ 1970.196387]  pci_pm_resume_noirq from dpm_run_callback+0x84/0x2f0
[ 1970.202532]  dpm_run_callback from device_resume_noirq+0xc4/0x244
[ 1970.208670]  device_resume_noirq from async_resume_noirq+0x18/0x4c
[ 1970.214894]  async_resume_noirq from async_run_entry_fn+0x20/0xb4
[ 1970.221031]  async_run_entry_fn from process_one_work+0x298/0x7d0
[ 1970.227175]  process_one_work from worker_thread+0x30/0x510
[ 1970.232790]  worker_thread from kthread+0x128/0x14c
[ 1970.237711]  kthread from ret_from_fork+0x14/0x38
[ 1970.242453] Exception stack(0xc2147fb0 to 0xc2147ff8)
[ 1970.247539] 7fa0:                                     00000000 00000000 00000000 00000000
[ 1970.255763] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[ 1970.263986] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[ 1970.270642] Code: ee075f9a ebe940f5 e59d3010 e6ff3073 (e1c430b0)
[ 1970.276775] ---[ end trace 0000000000000000 ]---
```

Francesco

[0] https://lore.kernel.org/all/20220128082920.591115-1-francesco.dolcini@toradex.com/
[1] 415b6185c541 ("PCI: imx6: Fix config read timeout handling")
