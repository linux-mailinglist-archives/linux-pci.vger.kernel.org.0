Return-Path: <linux-pci+bounces-3180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E117484C034
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 23:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44BABB25728
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 22:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD5B1BDDF;
	Tue,  6 Feb 2024 22:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LqQ+AHu1"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931C81C298;
	Tue,  6 Feb 2024 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707259660; cv=fail; b=sFj4doQ4O9nlP5cdvMSZL3hMWJ8TlRFLqcTluqnmsJV/73jt379bxL8XEssPmwgi6qnhjZ3dgAaX5HFvUFIV8/sNqCgKby/qzZ+sepgUWbGmqAK8pw3/AtH8uDOC+VGUZM0YExCCzFyNY8/Yhn90gJIbrrksvTk+IijG6LCZnlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707259660; c=relaxed/simple;
	bh=mIjCqdjMtNWnlniPSD8JnlXEtV+PqIE6bHmFDF+8dEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gErMyu6AKutw75QYE+TTEIqCif4whXc3SBw40zAvdgH8GVkn/4un6QuMB6ZCWsPvwZtc5bwLvGwOZ6d1VG1ck5KUyLifcHz7qiGM6P11LAm44pNwBKktaiv6Zu6jgTSIgeh4qXG4NEEXdg3xsSk0wanKFMVt2IFG9rXtWjWupWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LqQ+AHu1; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAsVJuWrEI7nRSXqTRdBf1dHZEbvES6hfsvFjoTom3HbczpPeJpO/SaelrxkZWAFwf4PGdXsEXGgDbumTw5zy1YY7Kv1DEJIMUcv1ZyZrPgSNwYHjKedbddWQw0XSokLDOXlbrianPKBzIr63ylnxeHlqlbwNOjK5jQsj5JtGUWHT5H7+xQT0V5N9admpzG/V7L1oyvlcitkr720JjM/Nu+AJSwDoIHzBWIGydyFmezfiHYLBs6W8B2V1IsnCglm6/cB4lUCuhyQnkNwwk3jcLsMr29jwR9Mn4fxR1ik7q9NmlAPdhqk5GY69H32pFDfg8gf5MIgQd0UqxQ+vXV4gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGdKc9m/K6uizUw/YvMsnF1RY2FCbWQwYHpMYph0My4=;
 b=By91+4iP6koZynxymfsOw1zKmzkbPgBz7McPjZAfpLDODx4rbk1bqlp3aDPEBRmhMPhjBccPjjt60xV7ITmtu90i1Rze1Qw5lZPyTaldolbAPQS+SdkvyG52Ob0YHopV+q6pmg5DvzgMmam+CBdBY61RKTR7uD6s4ne362EjdJNb3aZ00TY2jSsuktb9Uk4oce/yS8u2QfStLdBzxQ27wLjxG5+5kI5Iee5EVz3+oDHN7rjWlNRWQLqVgRb7oztbALDJNZ3+UI4JzOqtdXFECLfguTxBu0eyzlhexKtdBTLwHku9FQxGqhU1XN0zadivvo8Ln18+Oul7/169pInSwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGdKc9m/K6uizUw/YvMsnF1RY2FCbWQwYHpMYph0My4=;
 b=LqQ+AHu1xc0TBE9yh+guHDvTEkZ5rjkQL2wUs817/5yjyWIunvteY4TNG/XZdmWpoKJWmyMHNOmiutcu1UyyidRoV/YtPULe3MJNfRMWEde+aqOCoqU4uE2w5x3Y/F71lCP9cJG9bWhoI/7+HvtzAH6RB9iLY0+vTFNblcx52D4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7442.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 22:47:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 22:47:35 +0000
Date: Tue, 6 Feb 2024 17:47:26 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: PCI: dwc: Add 'msg' register region
Message-ID: <ZcK2/tmLG9O7CBEH@lizhi-Precision-Tower-5810>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
 <20240202-pme_msg-v3-5-ff2af57a02ad@nxp.com>
 <eg7wrjp5ebz43g37fvebr44nwkoh4rptbtyu76nalbmgbbnqke@4zugpgwesyqd>
 <20240205183048.GA3818249-robh@kernel.org>
 <ZcEzYdZKotBJlR5i@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcEzYdZKotBJlR5i@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR03CA0363.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef78613-fe8b-432c-3530-08dc27659cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ix0vDrSLks7IeOuxSgDzuept3cYxw3iAIg5Sb8cZAc13wgkWyJC46UT1f/CzzvAJp4Au56Mwuv7LfiLM8qktgjH0YHE8sBocVt6rpOfclcPS36AxUIAkY8UFStlKlG9FMFbP9SXr5bYCdchrZA21gk9YMMVFL6fPdRp8JlWXH3EGD03zqfHX3XpPpe/wwMffSho3fA+7og9lcHHSCk0Jno2hqp9UzvFgK/MQwrtrWUK0uExxguNl5rze1Qu6iGIIFYRweSw8PK5UgBTlb35oOJcb25Q3dMlKZgBtNPmbjSVETiQEmjkL6v0v8UcKl/KrSLmAEHo9AulbdGQi2qTTm06fcs5d6jAw4xoNvaMz5v9Hi5Z4S1A1c1UASRJwQFu9PYIfcVPIrOtDJGOgFTB4nqwRSJAJmblKIO5gcsCcE5T0/juBK7v3Ug/D+RVEF9Z2EIPqKSBi4L2P2tWWRBUZ00AdOHrrLaYW+p5kYNLJzpKMbL1YHZzKN53dqrlvLWkiiEsyQFAexDO3G518xVjeZN1zp/5PRMPLxyOXRVRD3IrnNO3LQT8mmACqDCYBlIaRq3Ji3zdvalgdDTIRjOkkol2Sx5PHNeHW1Vm+Nai3XdT04eXnkCYqDTAoBN/B3Keo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(33716001)(66899024)(26005)(86362001)(41300700001)(6512007)(6486002)(7416002)(5660300002)(478600001)(2906002)(38350700005)(66556008)(316002)(66946007)(66476007)(6916009)(54906003)(8676002)(9686003)(4326008)(8936002)(6506007)(6666004)(52116002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EmO1uLSiRFLaBzWg2XT1r/3Eu14144c5RtdViBYaeV9+htt+RKB6pppdI0fa?=
 =?us-ascii?Q?jDOxz7eiDCCjsGK0cTblMndIGoVOLbe86Si6rGXcW8JINm2t/JtlxRDPDfXe?=
 =?us-ascii?Q?BVAqu2Znj3XoyeFLaVWCjraDnnYHh7eIDvdkknrjREHMr/5iyf6o9HCCm8sV?=
 =?us-ascii?Q?ZsgFYzBzdh1FrBR/mnQ2Okh2twmfx/7ry4Sxm2HOzN2YKMZ79fDrbeXi6iyr?=
 =?us-ascii?Q?DNoYddqBh3tUCwDfk3ISErByf2CYY3KYvOKqlS7ph3x3dC/1iTzs9tz0QpWx?=
 =?us-ascii?Q?B9TMxSMlE/Umqt/DFCFUmHPBABWxmRf0O15dSlxsGjWtaS8neFHXS707oUNY?=
 =?us-ascii?Q?E3178Tf9uOR+FAy8TCX9NUD8658KRSB2nISokr99p310E/+KB/c+aV16TTOA?=
 =?us-ascii?Q?0TfqgEx5qWCtkHtv7cWSXr2sZX36Co8QREXAqKeT5XX8KEsB5JQGs6hMoEZR?=
 =?us-ascii?Q?fUWZ13jjJX5Y6xuEV0mlwg5X//FWUjeDNsDwDzW/uVVCHKGt4bG/BjVDdhwR?=
 =?us-ascii?Q?6mTUqo9qWThc7/VyRmUfZCRpGsLAoi2p3rAT5N+VJWbT8E2lzWvbLHrfvVqD?=
 =?us-ascii?Q?Wrx3pqKjQ2fQbqi5X9+nJNGmFOlfLOTsWPMtGs4BXkjExEmAQUwtY2Yr2xto?=
 =?us-ascii?Q?qC8FXhipeAjt8jOkmMp1XUyNdOFpkEZsUoYRHxofBts4iT/ilr/lfSNKuh+a?=
 =?us-ascii?Q?vS/7r8Z3c/FIV2JVc6y2resX+kkUZCodqsQyDku5TPoIEYJVXzWJnjGdbQhU?=
 =?us-ascii?Q?izrUsRNU/HDH87jNmORDuNUKC0qUkEj2M9jqx68PrlD+aa6mMaBwF2SsOGFh?=
 =?us-ascii?Q?TrW4CyvOdmN/VlMtls3q3hDMNBTj8Pm2HxyDxEqxQFKToHG5ipKayySE3jCD?=
 =?us-ascii?Q?UlDSm/cB3rcUsl4rnRmi23p4pZ90W/X1TFxnRKEZKWRztWVh5GgrukSWvO07?=
 =?us-ascii?Q?zLX2d+LTeqvrGajhTxl6EgN+OnxeKpBXX2nI7Y61qJi5lh9VtdGlvCrQWGdD?=
 =?us-ascii?Q?ru4Hq3zpLDM1fdvme/vH8rGiDncmOvVQ3CWDkhjC0bpKbuyOPgRwfYajW2zp?=
 =?us-ascii?Q?vavwxy6RbAPM1yabUmmeDChzcPeB1pfPpg198qWP2iY7frZWxw0DV1FWtA5e?=
 =?us-ascii?Q?xK8WOfNIDybJ/YcAhtEOw4iBQsXlXnS8wnGw6Amr2D7qesU8xlblzueuyhND?=
 =?us-ascii?Q?rF+h7Br+M+OLgUNXNuiA0PiKqT1yqD08bSLaq2JhYMB62r2sV5exSOydT7vS?=
 =?us-ascii?Q?CsWXegUdG6wxN/rt8UJtVtHqT2qUwQQaCcIgWEKZ7+JHNyBNoc3XsNL10yEI?=
 =?us-ascii?Q?4U0M82S+RudV7bkKLWonswIZdxmCDchDmrqd7D3nyHZmbRxjoFnpiZs7DKyO?=
 =?us-ascii?Q?/jMN3L8aoaZbgELvqaTguyEu2GU9zjLerW4Ig1t77j7f1bynTsNQ2YeI2Qp/?=
 =?us-ascii?Q?0EBdCG73aivNs4ILxZR6je+PPVcRD4U42xSvAwcBWyG2QnwLn6p1GQZC5HBm?=
 =?us-ascii?Q?C6Lst8LqgDUVYb9TH36Nl0Sx2wxBBaxllLATOE/NdJC5cYy6hYiF61zdosAm?=
 =?us-ascii?Q?KgFepMABdzZRBBYzj+8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef78613-fe8b-432c-3530-08dc27659cf0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 22:47:35.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dXcOTggb96t5FikW140OCHwgn/rpewJ7PDOReRx/ISEmkiCVYaV1IJJ89pnUKO57JC8CXV/bIzjDocrbAstdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7442

On Mon, Feb 05, 2024 at 02:13:37PM -0500, Frank Li wrote:
> On Mon, Feb 05, 2024 at 06:30:48PM +0000, Rob Herring wrote:
> > On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wrote:
> > > On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> > > > Add an outbound iATU-capable memory-region which will be used to send PCIe
> > > > message (such as PME_Turn_Off) to peripheral. So all platforms can use
> > > > common method to send out PME_Turn_Off message by using one outbound iATU.
> > > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > index 022055edbf9e6..25a5420a9ce1e 100644
> > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > @@ -101,6 +101,10 @@ properties:
> > > 
> > > >              Outbound iATU-capable memory-region which will be used to access
> > > >              the peripheral PCIe devices configuration space.
> > > >            const: config
> > > > +        - description:
> > > > +            Outbound iATU-capable memory-region which will be used to send
> > > > +            PCIe message (such as PME_Turn_Off) to peripheral.
> > > > +          const: msg
> > > 
> > > Note there is a good chance Rob won't like this change. AFAIR he
> > > already expressed a concern regarding having the "config" reg-name
> > > describing a memory space within the outbound iATU memory which is
> > > normally defined by the "ranges" property. Adding a new reg-entry with
> > > similar semantics I guess won't receive warm welcome.
> > 
> > I do think it is a bit questionable. Ideally, the driver could 
> > just configure this on its own. However, since we don't describe all of 
> > the CPU address space (that's input to the iATU) already, that's not 
> > going to be possible. I suppose we could fix that, but then config space 
> > would have to be handled differently too.
> 
> Sorry, I have not understand what your means. Do you means, you want
> a "cpu-space", for example, 0x8000000 - 0x9000000 for all ATU. 
> 
> Then allocated some space to 'config', 'io', 'memory' and this 'msg'.

@rob:

    So far, I think "msg" is feasilbe solution. Or give me some little
detail direction?

Frank

> 
> Frank
> 
> > 
> > Rob

