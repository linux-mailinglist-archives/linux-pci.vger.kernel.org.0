Return-Path: <linux-pci+bounces-3206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D3184CE86
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 17:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D28B1F21FEB
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 16:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C1F80056;
	Wed,  7 Feb 2024 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VNtbESwR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006E80045;
	Wed,  7 Feb 2024 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321736; cv=fail; b=IieS2yslwlFU8cWbeNLpoN4f9z08WztbfvBhTymFvRmN2NlWnL/kResNDqGiN4tnCBz9jKVZMytDdpr0HeXr4PV/RTnW4k181OssUe7hL1dT2V58SaxDeyS93DVNFXqVmuQjVfqJEP8u8bOuRGTWKKBDmF3t3JuvozZbclFGdZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321736; c=relaxed/simple;
	bh=IyMV8ZgT1aPl1QwNHd4KV/EFqaDBTxG7xZ5XL+ZwyHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DAto+VDcHMz00xjogLpnhqhaZAhAlLRfJuB3xt0ZX7fu7COGfVUHqi71I28rqFmVUc1QJ32WK2kEduNhboIsCtzrjfdP1vnGH7Y12g2XbHTSl6tVReQug2CgJy9B94Az29uz2O/v1Gd8F1WkIcRowmJkLhsbJtWo9VAdJXTwlKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VNtbESwR; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cdi2Tj4ca4YbJXyrHUN2c95e3557QJfuEbCZpEHeNrlxPlUzG8q0t6o31LkoEKPlcmYmYyeCiFCM0mT+OJs3mwMvQqagH+fPXsMUr0hoHj5KkNmIb+Fh4dwIcyP1BjaKd0UWOFFMPSYgbQHC/kwDR+qRTJP69j8wRNXS7Yuf1RUoIqU21tMzZRS3bGTOHoxG4NWAC8p82gnRtr3GeOiJ7RH8KXD+w6qvHfkxcY44HSdpTTg5mZRC4cbd/SdKYjACAyVurubfhFwIoysOI51piCsT5MtM/hDvzNkvXzeTuigJQaZbASkJjTfp+uQkgCiD+eYtAGaszH/FE2i1GR1GfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0F+HOWBReSH1fk+mN8rtrd11pggWHFKn/FSFLx8AEE=;
 b=J48t5KT6twXcV7v/eOJ747eTUecZYbQKPMAtJrLM/XQV1uPWPOOeqxOKl3oFVdN6MhotaFQrt6WekbwUFxGkN+9ZAnkH79bMq1eGiiHKTSN73U3NpqmujC52fysaS9aESLEclU2hVVO7yp8OGVXTG/tQ2xchMCwtVHs8wTqZ1ZxpEjBzrReweyqIfNhuIn/fOVIyOFET8DM+mrZudkHABOr8XcQSB5JAyVakLpJVPqnk2IrDY0SXrfXsEbUflSc8JelNx7+geym8BcuA2/FrYgRAuvPnUypUOzbZZ8k2XM4b6ieg1XOhPq4/QXh8V9XMue1dPzO7m5mq1iVv7S0bBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0F+HOWBReSH1fk+mN8rtrd11pggWHFKn/FSFLx8AEE=;
 b=VNtbESwR0yBz2wofCiQACODGMa3lSbg1xuLGHvEKvGxJAZTXT2SmK/qWLs7ajOZ3sxdLrZzxIyc/whb6e3iMfuMYuaEhPMYnsCtQib8VxLyl+L86zlWaUjIUrUJ5dCLXcryJm5/xgpYZZacZGUqBfoHX0H29k3Z0ek58F7lk+7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7109.eurprd04.prod.outlook.com (2603:10a6:20b:117::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 16:02:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 16:02:10 +0000
Date: Wed, 7 Feb 2024 11:02:02 -0500
From: Frank Li <Frank.li@nxp.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <ZcOpehO3rzCfAwXf@lizhi-Precision-Tower-5810>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
 <20240202-pme_msg-v3-5-ff2af57a02ad@nxp.com>
 <eg7wrjp5ebz43g37fvebr44nwkoh4rptbtyu76nalbmgbbnqke@4zugpgwesyqd>
 <20240205183048.GA3818249-robh@kernel.org>
 <ZcEzYdZKotBJlR5i@lizhi-Precision-Tower-5810>
 <ZcK2/tmLG9O7CBEH@lizhi-Precision-Tower-5810>
 <luk5hswq4wnk5p7axml73qih35hio3y3pfnklctbn6rwres62s@mumnvygjh5ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <luk5hswq4wnk5p7axml73qih35hio3y3pfnklctbn6rwres62s@mumnvygjh5ch>
X-ClientProxiedBy: BYAPR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:a03:100::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d562459-f5de-48fa-d69a-08dc27f62422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dYIlA73jdGaArw4kzzo6pduHECGs+mFk/QWEQ/5iNIJ7fSF+qRD34j4fD1NF/iR0TX9jB4f8TiYCuKmbCMkuTUIDtldPRP7onk6c9dnIZn6QAgdcrdndAJDCCVAh2esHe0eJzCqACiZA82EhRA7IV9SE8wQY5OonerS0lXmNBUp9BZhiPixGH27go3PZrPTa75NCT2gaHJeJ0hcZxypxerrXCi4/a4C5bx1OOiPwMEHHcw5s9sfh4ZfAhMklnWmP/jWRUiN5GuUkHR5bEMBthveoPaVgih3D8HpNwtY8q3FYXsn/JVvRHuXvJd1GY4w8SvaMKyjQpeYGUorr3TzlLrB41ZzKVAkcS1lKZrW76mfQK5+wm1WJed0IoRpBUiKkMnvzoZhKF2LF7dXMIKeWmwMtizhGJBbS8IP8kJr9LTycgBV6sALvvXRxIsEYyD9zI04CNpYO5SS5i3uDPz25+zpDEGI98fuPVasxyeQhrfJDmO3hG+i5a12hQsDD5/rQwYtTm9tA45p/0qGxyHgkEwX/ccHUnYWFPvxA7By1ZyuYtp3GEE3do9V4oyJ775ULhDvswXR51w6RTxUjWTwd2VoriBFb1Kvf/RK/op6bSCk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(66946007)(54906003)(66556008)(66899024)(316002)(6916009)(66476007)(38350700005)(7416002)(5660300002)(4326008)(2906002)(33716001)(8676002)(8936002)(6666004)(83380400001)(38100700002)(6506007)(9686003)(52116002)(6512007)(478600001)(966005)(6486002)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ytpr4x+hmBtDTWkwW3JpH7oOP8yDUHCIYYFp/5+cnKeR6aQXvK6nO9616hEh?=
 =?us-ascii?Q?8noI7le4F8DUKZ8C0tpGimFdlPRV98lUdfQE54hmniaj0rJwRxrUyrPfuLuv?=
 =?us-ascii?Q?F1a9eADGDou0pAvpmhPM/YKCFSZFjRQlnLGGmdKxOGQIcmOk3u6hQlVLIlAm?=
 =?us-ascii?Q?RQU5x0lUUMKEgScKBfFn5eGaiM2BFqQInZCDKhPbELYJYZfteyH2VW//fsIw?=
 =?us-ascii?Q?UTiKTFazdSKQo8gmdKE2K7SSN8+8WJv3zXeJ7u15UD1V1rVlnDV+9T9MhI17?=
 =?us-ascii?Q?yx8+QiPVO1bzcjsasNVgdZpgrkCPzV/2pQutApAZyvbSuATdGegiE/OC8Niv?=
 =?us-ascii?Q?qv/GckD2N/rJtDyNw0+7QbkGO33hyfSMj41gwo+MYfpgFTalPaT2KtOQJT65?=
 =?us-ascii?Q?JtqlsqlyiEBzu/1fOIf71vV8sgPTQCBGOIQwgh8qfxeX+29cQ3d3y+ceXXsT?=
 =?us-ascii?Q?pwWc7PbnnrLcc2XVp1Ro+lcmd3E+kEijGsMjQKsmzVCbeHgMCMs718UrcB0/?=
 =?us-ascii?Q?I8r6pW0t+48iyfz+CdL4eMlpVu2Q5gjAJU1QxGiereuVjh7+sZjO8PNljmjn?=
 =?us-ascii?Q?4WdExWakEVtSRiIAKRfsXLeKmxXP3XDZ5U541hZ8sv/bMrzl81/qpuLSwPlL?=
 =?us-ascii?Q?AX23C1qnq0ManD+df1XrLqQJ9flSotvSsDYgpGmxlL5sPzoP7sYD0h837aIp?=
 =?us-ascii?Q?rEkVrQCP/u7XJg/PGI1Ndg4Jd5+msAmxn1c8vwuHlKTMwYXzEQmTcOjIa7Ad?=
 =?us-ascii?Q?ebHoQ9w9gkHDFKT6Fo4S8t95/u+gLXZROSjm/VjxLwQ5SFSsmR2fZqC1ReYB?=
 =?us-ascii?Q?VNNnL/lMlQPNfXtyZR5T2uuC9gtq/rbzNsAHjjBcYoksQ80aqGoA7tFddz61?=
 =?us-ascii?Q?gekx88Ub0jGfS6Psik7Vi4m9X34lN3KinYO1JhRXvAqvAjU5wBTD6y9JnZDU?=
 =?us-ascii?Q?entlie4izB03rHnNE2UpqpJb8o1GI1f+rlZCD5mpo+cLPX2PcOcIWjEz422l?=
 =?us-ascii?Q?S1tZpVFm2BJV/D7+oLkEWaZg5yD+2DlFybUZzfE9jBOjpe9AlXLSyKXRdOFF?=
 =?us-ascii?Q?cWJ9y5sD4LH2rJMELNDEe1tz/+SMGBvBt2fIUVIff2K/D39pX1EZ3YinGuRd?=
 =?us-ascii?Q?KLARml2DKaslZOfD2peOl8mqsBcYhqwlVm7ePpYMcnL+Jada2s3439C2H9ul?=
 =?us-ascii?Q?DYefGSycJuuAWlLsVEE9GgYGx2O5JFiXRI/QjXkU+BPc4ULG2Lugty4Q6YSy?=
 =?us-ascii?Q?OAfV24oGht50296xs7jVWkEvt2VN7wf7gR/uPiQP3dUkxnAnC5GEtorfr1AL?=
 =?us-ascii?Q?VqI4zimG9umj2hKxrAYQ/EqR1fNI7p3sT3FJO1hBP4zIlsNrHKHIMRhrR+2/?=
 =?us-ascii?Q?ekTydULm9DbsQ4YHDOEclR5S5zWFvqD86FN5KUvlNS7se86w2g+1GQZ1hPuA?=
 =?us-ascii?Q?aICoMl4se8k9OljgIQxP4OK+/Ky0ere4Sx79RE8ZGTxU4w0ePWsnQ5dX5IVz?=
 =?us-ascii?Q?P59u1lCLriWsDxlvdq8nM5L8Xigp2qbPCB/F6w62FyzT0nq81dvoVLhLTeky?=
 =?us-ascii?Q?RBjIQ2xdN3yuUqTXAxXwuZ8iTdNw1hysUtb5FxsO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d562459-f5de-48fa-d69a-08dc27f62422
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 16:02:10.3320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOESTTIhfRUxHZfgfPYVgRRBmGvOmRYh/V45IQBrnrXCqIEsRZ566acRgAg7288Cw4Ks2NyO6j1vv3PPZPiVPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7109

On Wed, Feb 07, 2024 at 03:37:30PM +0300, Serge Semin wrote:
> On Tue, Feb 06, 2024 at 05:47:26PM -0500, Frank Li wrote:
> > On Mon, Feb 05, 2024 at 02:13:37PM -0500, Frank Li wrote:
> > > On Mon, Feb 05, 2024 at 06:30:48PM +0000, Rob Herring wrote:
> > > > On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wrote:
> > > > > On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> > > > > > Add an outbound iATU-capable memory-region which will be used to send PCIe
> > > > > > message (such as PME_Turn_Off) to peripheral. So all platforms can use
> > > > > > common method to send out PME_Turn_Off message by using one outbound iATU.
> > > > > > 
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
> > > > > >  1 file changed, 4 insertions(+)
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > index 022055edbf9e6..25a5420a9ce1e 100644
> > > > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > @@ -101,6 +101,10 @@ properties:
> > > > > 
> > > > > >              Outbound iATU-capable memory-region which will be used to access
> > > > > >              the peripheral PCIe devices configuration space.
> > > > > >            const: config
> > > > > > +        - description:
> > > > > > +            Outbound iATU-capable memory-region which will be used to send
> > > > > > +            PCIe message (such as PME_Turn_Off) to peripheral.
> > > > > > +          const: msg
> > > > > 
> > > > > Note there is a good chance Rob won't like this change. AFAIR he
> > > > > already expressed a concern regarding having the "config" reg-name
> > > > > describing a memory space within the outbound iATU memory which is
> > > > > normally defined by the "ranges" property. Adding a new reg-entry with
> > > > > similar semantics I guess won't receive warm welcome.
> > > > 
> > > > I do think it is a bit questionable. Ideally, the driver could 
> > > > just configure this on its own. However, since we don't describe all of 
> > > > the CPU address space (that's input to the iATU) already, that's not 
> > > > going to be possible. I suppose we could fix that, but then config space 
> > > > would have to be handled differently too.
> > > 
> > > Sorry, I have not understand what your means. Do you means, you want
> > > a "cpu-space", for example, 0x8000000 - 0x9000000 for all ATU. 
> > > 
> > > Then allocated some space to 'config', 'io', 'memory' and this 'msg'.
> > 
> > @rob:
> > 
> >     So far, I think "msg" is feasilbe solution. Or give me some little
> > detail direction?
> 
> Found the Rob' note about the iATU-space chunks utilized in the reg
> property:
> https://lore.kernel.org/linux-pci/CAL_JsqLp7QVgxrAZkW=z38iB7SV5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com/
> 
> So basically Rob meant back then that
> either originally we should have defined a new reg-name like "atu-out"
> with the entire outbound iATU CPU-space specified and unpin the
> regions like "config"/"ecam"/"msg"/etc from there in the driver
> or, well, stick to the chunking further. The later path was chosen
> after the patch with the "ecam" reg-name was accepted (see the link
> above).
> 
> Really ECAM/config space access, custom TLP messages, legacy interrupt
> TLPs, etc are all application-specific features. Each of them is
> implemented based on a bit specific but basically the same outbound
> iATU engine setup. Thus from the "DT is a hardware description" point
> of view it would have been enough to describe the entire outbound iATU
> CPU address space and then let the software do the space
> reconfiguration in runtime based on it' application needs.

There are "addr_space" in EP mode, which useful map out outbound iatu
region. We can reuse this name.

To keep compatiblity, cut hole from 'config' and 'ranges'. If there are
not 'config', we can alloc a 1M(default) from top for 'config', then, 4K
(default) for msg, 64K( for IO if not IO region in 'ranges'), left is
mem region. We can config each region size by module parameter or drvdata.

So we can deprecate 'config', even 'ranges'

> 
> * Rob, correct me if am wrong.
> 
> On the other hand it's possible to have more than one disjoint CPU
> address region handled by the outbound iATU (especially if there is no
> AXI-bridge enabled, see XALI - application transmit client interfaces
> in HW manual). Thus having a single reg-property might get to be
> inapplicable in some cases. Thinking about that got me to an idea.
> What about just extending the PCIe "ranges" property flags
> (IORESOURCE_TYPE_BITS) with the new ones in this case indicating the
> TLP Msg mapping? Thus we can avoid creating app-specific reg-names and
> use the flag to define a custom memory range for the TLP messages
> generation. At some point it can be also utilized for the config-space
> mapping. What do you think?

IORESOURCE_TYPE_BITS is 1f, Only 5bit. If extend IORESOURCE_TYPE_BITS, 
all IORESOURCE_* bit need move. And it is actual MEMORY regain. 

Or we can use IORESOURCE_BITS (0xff)

/* PCI ROM control bits (IORESOURCE_BITS) */
#define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
#define IORESOURCE_ROM_SHADOW		(1<<1)	/* Use RAM image, not ROM BAR */

/* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
#define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move resource */
#define IORESOURCE_PCI_EA_BEI		(1<<5)	/* BAR Equivalent Indicator */

we can add

IORESOURCE_PRIV_WINDOWS			(1<<6)

I think previous method was more extendable. How do you think?

> 
> -Serge(y)
> 
> > 
> > Frank
> > 
> > > 
> > > Frank
> > > 
> > > > 
> > > > Rob

