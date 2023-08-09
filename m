Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD677762DA
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 16:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjHIOqC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 10:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjHIOqB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 10:46:01 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CCE1FCC;
        Wed,  9 Aug 2023 07:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw8pHwWtRjRG5VcIa7pJkYz2as2VmjWw8hTFGEA+N27VDJ2hF0UdD3uMJUr6nUi5gwbNBUkDGAl6gqmIFv4yfBKlvAG0LCkNzXcEIc8Mye/1HK1Og1GQBq5eQdjVEKezsMEeEnyY98LdXkYtm52hC4mqJ8nO9OlkWhlR0D0Uju4faP5MNhwJBYpFfNkKY5jSOEDjBEEGkjpwGzIc0TxjB8HKzzpRDq+jU5ORY8L1Kqk/hcRcivwhD7HWppcMUHTSV0kXy8J8EBRRJZnSCCVkzclCBjOuL0ExLMHLNrJ/+BXAagT0ecmS9NdTJFWhF9V75fqXFSu3LqDtLCbWLEMV/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKgSN+DipQLIqs5gKRMn9UzgNe7NMwabguil4hm8xDg=;
 b=a8pDP54HVE1BeCdV77e6N6TmI9J190VNqJGw+nYQ8gCLegirmmOIPkfKcKw0R6u3yjZqejmMLmkd89cbyOvXyo/KKBmhco4rTDTY4GcKH3jw7Thlz05lR3I5lGZxO/2CRkT2Up5cbLJnTCsRzqs8ZReSS/dAJwlTLHrUUd4K24hRDCtNYELIxtKX/EWJ5v4mHmGOg+6okneqGCelyM3xfrc1kmTpaTYWRm6KFHQjo3Pfk0YUtEUecB6TrAyTiQuB0EA1+d4Vj0qtBVhX9uiC1JXP0UOXiRpxPK+9qanPdo0MP5dZaw9Zdz1dO5X/iLkv5OfQdOuBs7NIZZQqM6A2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKgSN+DipQLIqs5gKRMn9UzgNe7NMwabguil4hm8xDg=;
 b=UGFEW8JZ+qefFm7Nl1ugxr5Dc7kgzOs2YJuR8C/9ElW76PvYlq2T0D7tGafJ4DKoQwzmKL4tp9VAoIVNABVjPGKlG/vwAlP/r0MB8qQ3pqnqpNVI+VxEiKrgdwbRlWpN40tpVmLGApp3651m4L7TZGi2VQTx5UQvXqo6xgGsvCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB10011.eurprd04.prod.outlook.com (2603:10a6:10:4c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 14:45:54 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 14:45:54 +0000
Date:   Wed, 9 Aug 2023 17:45:49 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v2 pci/net 1/3] PCI: move OF status = "disabled"
 detection to dev->match_driver
Message-ID: <20230809144549.ksw3slllph6kqwg7@skbuf>
References: <20230803135858.2724342-2-vladimir.oltean@nxp.com>
 <20230808222107.GA331664@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808222107.GA331664@bhelgaas>
X-ClientProxiedBy: AM0PR02CA0180.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::17) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB10011:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e95930-8199-4c11-f26a-08db98e75544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dd4c6LgLRFkOc9HC3JhbSEwTUacy0gDc1Zvl+0GP26ip0OpgWCoAWb2dqU4rySxy3aLxAfLnJ89h2tJFRnm1dfUPYe4VcqelIMV1iO576ONGEcgjcie2lebuxUzvV0D3pw0Fv7YJVFSM4v8eB0MmLRIOH4nc2m1nZpLYhSbe8/LBJMt9bYazU8xB8QmThpMbWCgSN8+iCZ97WGT3q2ZwsfKJ9RLpuRbE4PbgmiLXnQKS66DnBLRl39sEMy2/GUS9bhuLJKaLet/Cx3DhKfjMucd15rZw6mL2DkHQBYuU0SisK+0g5oYAL6MYAOGxMzCF4KONdRvdLftENrOZ4ErvOTwu89QktYPOqHRRjhSsB3n0V28N3Iqr5XCDZYCLtwRUcSku4fByvpupsTFP5TIO8QW7CailCoxRQrdbTQg+nXciZDL98zBLD4mkKG2Uqd5XuB/v97M+BLVQCrkxT5u7Z34Pu4G1sQYAI8Ms33/Y15ucqWhkb/1lzrtVSIVqDoqWlutDlqrAhyT7ojcVDTlD10uUaZky/8Fonp/N7rlLbZhEY0oj5CvSdSXWTsqF8ZOV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(366004)(396003)(39860400002)(346002)(1800799006)(186006)(451199021)(6506007)(26005)(1076003)(9686003)(6512007)(33716001)(6486002)(6666004)(86362001)(478600001)(54906003)(83380400001)(316002)(66476007)(6916009)(66556008)(66946007)(4326008)(41300700001)(8676002)(8936002)(5660300002)(38100700002)(7416002)(44832011)(30864003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qDEMu78q1KZf9ZaKxNLkWtXkwTM5hW0keOKBkfl0ltnEHJ4yaPP4UdYsD+U/?=
 =?us-ascii?Q?Um7a4VXy7kaYnMIYx10LtEJI6yCfkH2ucB6o2K3GFs/PBWazal1fufQCFgpO?=
 =?us-ascii?Q?ngw4a1SSdZMP5hGB82jJhLzhbJ4NYQ51RdSSb5JbO8Fw7OoQ5hZwD1h+hPeP?=
 =?us-ascii?Q?Ab4J+ibvXYHS4CrG5tTrp78fgIEGasgTYUF+oWwfqo2KOKw2HfOfibhyN5bb?=
 =?us-ascii?Q?kWmpmFTp0zFjumLbDUcYWOTKNOzzALCh1ilyIOREr1dGHGWGAyFJ/0sL89Ki?=
 =?us-ascii?Q?f/5/qM89Nyyq8u6BmsyO5MMPaIdkalHCq6ACFCHaVg06u9iHUpAa8TlMa9fs?=
 =?us-ascii?Q?3d9FE7xEfqpCZiRiSR47DYLu012ZcpYH9zecIR5mJc+RTtdCJD2srQX7QPmG?=
 =?us-ascii?Q?H4s6V/Fl85OrFz7a3HuRRlYY1wlprculLdntTTTP2V5z9H6mlb8mov2/WFWC?=
 =?us-ascii?Q?jCjb9yuY7eILUeRLizikArijlAz+Wt51YQ6Mbn6TIjF8+rrzjBuLeb/M6MmO?=
 =?us-ascii?Q?0rphZdHWI/Xa5ov8/5wLEHUXcz+RgU/5ylM+6zGaNPWO1pFqR1OaUGhB6xli?=
 =?us-ascii?Q?MCk8viAGRTCG7B2gcAKZsKeMn9a66LdPjMN6/i4uMhFOi1Q6PCv7hmnYbOYU?=
 =?us-ascii?Q?s8TC0IO9Fehyue1s34Dg4UQDy9cazKwGyFghS7Ybo4XnDjWJk44NpQiIf4Sw?=
 =?us-ascii?Q?PGpQBM2FhMHbOfRLoZgqvACJPFyD2qyi2O9bdy6zZwfccSZb33THmvxPZhW4?=
 =?us-ascii?Q?nVigfQLFsiJ62uC9znEAh2yja85pf9ggxSmCFa0T0YNPVXqjbsA1r5DKDYE9?=
 =?us-ascii?Q?PSx7Cw4ZLidMwEG68lnJHRgOQ4othxQmMK05oaHUsVRd6KUs1CX/nghF6cDs?=
 =?us-ascii?Q?NjkBzBNUBWr/2sBjBDG9cuLiv4hiCBqskAV8lYm6InnuJw1nlcO+E5wZ2Tq3?=
 =?us-ascii?Q?CA+V8PGhQJAS1O83A+cW9NPwlPo/c6XMvfrmpZw8SDKYQH7LJWaVZKDlTDK1?=
 =?us-ascii?Q?NkGwn7FFpZLDp8Vho17XFL3SFxfA/VeK/F/H54n8hFnZTILCamw9/ZlVszRa?=
 =?us-ascii?Q?iE83tLBO9kIRaDAcxUjdc/WVJJERCn2IUK/U45P+hVPmtB5D24Us1L5B/GVp?=
 =?us-ascii?Q?MCPQFVWUypzAyml3UHosXDlQylEUbcU47iwyZ6EzuIZ5gvkusHsXIMaUXD7D?=
 =?us-ascii?Q?VvxnPLPDFKIAB4Q8i4CmhDgznfsCANY7mLFijLD2KMs+81+zM4PAE2Jd9ngk?=
 =?us-ascii?Q?ivTx23ccR9W9qcd4uBhoC41soPzj5QgH56t9sL3NyeRti8HwgYjmjJPwmJWL?=
 =?us-ascii?Q?4JDJZlPcAr1/2JutNpglXEbDE1GNISl74oZ8yVpz2k4+x+Wjs8lcIsR1RFUT?=
 =?us-ascii?Q?d17afmzfqxsivkeQ7LcmDaMp87rEjSO5yDGvy23zHo9UhSBo27BPRIC1Yufs?=
 =?us-ascii?Q?g37v5yYtFzmoGSxhEgmUpi9CS7ajcKbPzzk4OtXdSeZaoL6Dw4QXvQaiaxX7?=
 =?us-ascii?Q?Nx1t7MKM/AEFyUCo0jxt2dSBlH8ITYjgANKt0xH/rNoGnCd2qzpYyi++cYEf?=
 =?us-ascii?Q?+9PJqacTskl3zNi09/+FFd3Xg5sNvQc3TdwP635isEyWdWyiSBXy/dQe+BWc?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e95930-8199-4c11-f26a-08db98e75544
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 14:45:54.0517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoZKNYJ28EMSSH2iOXGBZVqayZshXz6OH0wi+fiidUKTFNf0t4dUW1LAuD7bAqVvYJKZ7YuTb+PZC3SrICChSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10011
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Tue, Aug 08, 2023 at 05:21:07PM -0500, Bjorn Helgaas wrote:
> I think this makes good sense, but let me make sure I understand how
> this works.
> 
> I *think* what's happening is that this Function 0 responds to config
> reads, so PCI enumeration starts by discovering it normally.  But
> after 6fffbc7ae137 ("PCI: Honor firmware's device disabled status"),
> we abort in pci_setup_device() if the DT or ACPI status is "disabled,"
> which means there's no struct pci_dev for it, no quirks can run on it,
> and no driver can bind to it.  And, since PCI multi-function devices
> must have a Function 0, we don't enumerate the other functions of this
> device.
> 
> That's a problem because (1) you need to do some initialization on
> Function 0 even though you don't want a driver to claim it,

Correction: on functions 0, 1, 2 and 6 (all have PCI_VENDOR_ID_FREESCALE, ENETC_DEV_ID_PF),
and not just on function 0. The particular nature of a hardware IP bug/afterthought
makes this necessary.

It may be best to look at the lspci -vvv output on this SoC:

00:00.0 Ethernet controller: Freescale Semiconductor Inc Device e100 (rev 01) (prog-if 01)
	Subsystem: Freescale Semiconductor Inc Device e100
	Device tree node: /sys/firmware/devicetree/base/soc/pcie@1f0000000/ethernet@0,0
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at 1f8000000 (32-bit, non-prefetchable) [enhanced] [size=256K]
	Region 2: Memory at 1f8160000 (32-bit, non-prefetchable) [enhanced] [size=64K]
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE- FLReset+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
	Capabilities: [80] MSI-X: Enable- Count=32 Masked-
		Vector table: BAR=2 offset=00000000
		PBA: BAR=2 offset=00000200
	Capabilities: [90] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [9c] Enhanced Allocation (EA): NumEntries=4
		Entry 0: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: BAR 0
			 PrimaryProperties: memory space, non-prefetchable
			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
			 Base: 1f8000000
			 MaxOffset: 0003ffff
		Entry 1: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: BAR 2
			 PrimaryProperties: memory space, prefetchable
			 SecondaryProperties: memory space, non-prefetchable
			 Base: 1f8160000
			 MaxOffset: 0000ffff
		Entry 2: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: VF-BAR 0
			 PrimaryProperties: VF memory space, non-prefetchable
			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
			 Base: 1f81d0000
			 MaxOffset: 0000ffff
		Entry 3: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: VF-BAR 2
			 PrimaryProperties: VF memory space, prefetchable
			 SecondaryProperties: VF memory space, prefetchable
			 Base: 1f81f0000
			 MaxOffset: 0000ffff
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [130 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [140 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 2, Total VFs: 2, Number of VFs: 0, Function Dependency Link: 00
		VF offset: 8, stride: 1, Device ID: ef00
		Supported Page Size: 00000013, System Page Size: 00000010
		VF Migration: offset: 00000000, BIR: 0

00:00.1 Ethernet controller: Freescale Semiconductor Inc Device e100 (rev 01) (prog-if 01)
	Subsystem: Freescale Semiconductor Inc Device e100
	Device tree node: /sys/firmware/devicetree/base/soc/pcie@1f0000000/ethernet@0,1
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at 1f8040000 (32-bit, non-prefetchable) [enhanced] [size=256K]
	Region 2: Memory at 1f8170000 (32-bit, non-prefetchable) [enhanced] [size=64K]
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE- FLReset+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
	Capabilities: [80] MSI-X: Enable- Count=32 Masked-
		Vector table: BAR=2 offset=00000000
		PBA: BAR=2 offset=00000200
	Capabilities: [90] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [9c] Enhanced Allocation (EA): NumEntries=4
		Entry 0: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: BAR 0
			 PrimaryProperties: memory space, non-prefetchable
			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
			 Base: 1f8040000
			 MaxOffset: 0003ffff
		Entry 1: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: BAR 2
			 PrimaryProperties: memory space, prefetchable
			 SecondaryProperties: memory space, non-prefetchable
			 Base: 1f8170000
			 MaxOffset: 0000ffff
		Entry 2: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: VF-BAR 0
			 PrimaryProperties: VF memory space, non-prefetchable
			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
			 Base: 1f8210000
			 MaxOffset: 0000ffff
		Entry 3: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: VF-BAR 2
			 PrimaryProperties: VF memory space, prefetchable
			 SecondaryProperties: VF memory space, prefetchable
			 Base: 1f8230000
			 MaxOffset: 0000ffff
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [130 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [140 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 2, Total VFs: 2, Number of VFs: 0, Function Dependency Link: 01
		VF offset: 9, stride: 1, Device ID: ef00
		Supported Page Size: 00000013, System Page Size: 00000010
		VF Migration: offset: 00000000, BIR: 0

00:00.2 Ethernet controller: Freescale Semiconductor Inc Device e100 (rev 01) (prog-if 01)
	Subsystem: Freescale Semiconductor Inc Device e100
	Device tree node: /sys/firmware/devicetree/base/soc/pcie@1f0000000/ethernet@0,2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	IOMMU group: 2
	Region 0: Memory at 1f8080000 (32-bit, non-prefetchable) [enhanced] [size=256K]
	Region 2: Memory at 1f8180000 (32-bit, non-prefetchable) [enhanced] [size=64K]
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE- FLReset+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
	Capabilities: [80] MSI-X: Enable+ Count=16 Masked-
		Vector table: BAR=2 offset=00000000
		PBA: BAR=2 offset=00000100
	Capabilities: [90] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [9c] Enhanced Allocation (EA): NumEntries=3
		Entry 0: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: BAR 0
			 PrimaryProperties: memory space, non-prefetchable
			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
			 Base: 1f8080000
			 MaxOffset: 0003ffff
		Entry 1: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: BAR 2
			 PrimaryProperties: memory space, prefetchable
			 SecondaryProperties: memory space, non-prefetchable
			 Base: 1f8180000
			 MaxOffset: 0000ffff
		Entry 2: Enable- Writable- EntrySize=3
			 BAR Equivalent Indicator: BAR 4
			 PrimaryProperties: memory space, non-prefetchable
			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
			 Base: 1fc000000
			 MaxOffset: 003fffff
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [130 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: fsl_enetc

00:00.3 System peripheral: Freescale Semiconductor Inc Device ee01 (rev 01) (prog-if 01)
	Subsystem: Freescale Semiconductor Inc Device ee01
	Device tree node: /sys/firmware/devicetree/base/soc/pcie@1f0000000/mdio@0,3
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	IOMMU group: 3
	Region 0: Memory at 1f8100000 (32-bit, non-prefetchable) [enhanced] [size=128K]
	Region 2: Memory at 1f8190000 (32-bit, non-prefetchable) [enhanced] [size=64K]
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE- FLReset+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=2 offset=00000000
		PBA: BAR=2 offset=00000010
	Capabilities: [90] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [9c] Enhanced Allocation (EA): NumEntries=2
		Entry 0: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: BAR 0
			 PrimaryProperties: memory space, non-prefetchable
			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
			 Base: 1f8100000
			 MaxOffset: 0001ffff
		Entry 1: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: BAR 2
			 PrimaryProperties: memory space, prefetchable
			 SecondaryProperties: memory space, non-prefetchable
			 Base: 1f8190000
			 MaxOffset: 0000ffff
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [130 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: fsl_enetc_mdio

00:00.4 System peripheral: Freescale Semiconductor Inc Device ee02 (rev 01) (prog-if 01)
	Subsystem: Freescale Semiconductor Inc Device ee02
	Device tree node: /sys/firmware/devicetree/base/soc/pcie@1f0000000/ethernet@0,4
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	IOMMU group: 4
	Region 0: Memory at 1f8120000 (32-bit, non-prefetchable) [enhanced] [size=128K]
	Region 2: Memory at 1f81a0000 (32-bit, non-prefetchable) [enhanced] [size=64K]
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE- FLReset+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
	Capabilities: [80] MSI-X: Enable+ Count=2 Masked-
		Vector table: BAR=2 offset=00000000
		PBA: BAR=2 offset=00000020
	Capabilities: [90] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [9c] Enhanced Allocation (EA): NumEntries=2
		Entry 0: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: BAR 0
			 PrimaryProperties: memory space, non-prefetchable
			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
			 Base: 1f8120000
			 MaxOffset: 0001ffff
		Entry 1: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: BAR 2
			 PrimaryProperties: memory space, prefetchable
			 SecondaryProperties: memory space, non-prefetchable
			 Base: 1f81a0000
			 MaxOffset: 0000ffff
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [130 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: fsl_enetc_ptp

00:00.5 Fabric controller: Freescale Semiconductor Inc Device eef0 (rev 01) (prog-if 01)
	Subsystem: Freescale Semiconductor Inc Device eef0
	Device tree node: /sys/firmware/devicetree/base/soc/pcie@1f0000000/ethernet-switch@0,5
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 96
	IOMMU group: 1
	Region 0: Memory at 1f8140000 (32-bit, non-prefetchable) [enhanced] [size=128K]
	Region 2: Memory at 1f81b0000 (32-bit, non-prefetchable) [enhanced] [size=64K]
	Region 4: Memory at 1fc000000 (32-bit, non-prefetchable) [enhanced] [size=4M]
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE- FLReset+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
	Capabilities: [80] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=2 offset=00000000
		PBA: BAR=2 offset=00000010
	Capabilities: [90] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [9c] Enhanced Allocation (EA): NumEntries=3
		Entry 0: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: BAR 0
			 PrimaryProperties: memory space, non-prefetchable
			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
			 Base: 1f8140000
			 MaxOffset: 0001ffff
		Entry 1: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: BAR 2
			 PrimaryProperties: memory space, prefetchable
			 SecondaryProperties: memory space, non-prefetchable
			 Base: 1f81b0000
			 MaxOffset: 0000ffff
		Entry 2: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: BAR 4
			 PrimaryProperties: memory space, non-prefetchable
			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
			 Base: 1fc000000
			 MaxOffset: 003fffff
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [130 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: mscc_felix

00:00.6 Ethernet controller: Freescale Semiconductor Inc Device e100 (rev 01) (prog-if 01)
	Subsystem: Freescale Semiconductor Inc Device e100
	Device tree node: /sys/firmware/devicetree/base/soc/pcie@1f0000000/ethernet@0,6
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at 1f80c0000 (32-bit, non-prefetchable) [enhanced] [size=256K]
	Region 2: Memory at 1f81c0000 (32-bit, non-prefetchable) [enhanced] [size=64K]
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE- FLReset+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
	Capabilities: [80] MSI-X: Enable- Count=16 Masked-
		Vector table: BAR=2 offset=00000000
		PBA: BAR=2 offset=00000100
	Capabilities: [90] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [9c] Enhanced Allocation (EA): NumEntries=2
		Entry 0: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: BAR 0
			 PrimaryProperties: memory space, non-prefetchable
			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
			 Base: 1f80c0000
			 MaxOffset: 0003ffff
		Entry 1: Enable+ Writable- EntrySize=3
			 BAR Equivalent Indicator: BAR 2
			 PrimaryProperties: memory space, prefetchable
			 SecondaryProperties: memory space, non-prefetchable
			 Base: 1f81c0000
			 MaxOffset: 0000ffff
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [130 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-

00:1f.0 Generic system peripheral [0807]: Freescale Semiconductor Inc Device e001 (rev 01)
	Subsystem: Freescale Semiconductor Inc Device e001
	Device tree node: /sys/firmware/devicetree/base/soc/pcie@1f0000000/rcec@1f,0
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 20
	Capabilities: [40] Express (v2) Root Complex Event Collector, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn+ NFERptEn+ FERptEn+
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Capabilities: [138 v1] Root Complex Event Collector <?>
	Kernel driver in use: pcieport

> and (2) this is a multi-function device and you need to enumerate the
> other functions.

correct

> What this patch does is make it so the PCI core enumerates Function 0

The patch does not special-case function 0. Fundamentally it changes the
meaning of "disabled" in the firmware description from "not enumerable"
to "driver shouldn't be bound to it" (which is more or less what the
meaning was, prior to the blamed commit, except that it was down to
individual drivers to observe the property) and that's absolutely it.

> normally so there will be a struct pci_dev for it, the normal config
> space access to it will work, and it will appear in the dmesg log and
> lspci output, all as usual.  But if the DT or ACPI status is
> "disabled", we will not bind a PCI driver to it.
> 
> If that's true, I'd like to highlight the PCI details here and move
> some of the device-specific things to the driver patches, e.g.,
> something like this:
> 
>   PCI: Enumerate device but don't bind driver if firmware status is 'disabled'
> 
>   In some configurations, the NXP LS1028A has a multi-function NIC
>   where Function 0 is not usable as a NIC, but it's accessible via
>   config space and it's needed for device-specific initialization.
>   Function 0 also indicates that the NIC is a multi-function device
>   and the kernel should look for more functions.

Instead of "multi-function NIC", I'd say "PCIe endpoint integrated into
a root complex (RCiEP)". Reworded, it's not a NIC, it's 4, plus other
device classes (system peripherals, fabric controllers).

> 
>   arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi marks Function 0 as
>   "disabled," and after 6fffbc7ae137 ("PCI: Honor firmware's device
>   disabled status"), Linux doesn't enumerate Function 0, which means
>   the entire NIC is unusable because Linux doesn't enumerate the other
>   functions either.
> 
>   Instead of completely ignoring a function with DT/ACPI "disabled"
>   status, enumerate it as usual but prevent drivers from claiming it.
>   The disabled function will still be accessible via config space,
>   fixups will work, and it will be visible via lspci.
> 
> So feel free to merge this along with the other patches via the net
> tree with:
> 
>   Acked-by: Bjorn Helgaas <bhelgaas@google.com>

You may have given the netdev maintainers some mixed signals with the
rewording suggestion plus the ack for my wording, and now we have commit
1a8c251cff20 ("PCI: move OF status = "disabled" detection to
dev->match_driver") in the net.git tree.

I think we are mostly on the same page about what is changing, it's just
that we are focusing on different aspects of it in the description.

I hope you're ok if we close the topic the way things are now? :)
