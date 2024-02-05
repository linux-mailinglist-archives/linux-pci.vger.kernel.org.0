Return-Path: <linux-pci+bounces-3109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C8284A122
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E56B8B20C5D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BDE44C7F;
	Mon,  5 Feb 2024 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R85febyp"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE845947;
	Mon,  5 Feb 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155045; cv=fail; b=d6aD62tALsPFhZpA611qqY87PDDSlJa4dAPYpY8PYRENCubAlRoynaJzGoRk4H3cvPpo4GQf859MtcrEEAoprc5g1xhUXVnGh19jknm4DfohJko4BGUQOlVoAtD9HdwSbQj7hL9hA9gsft3ofJOFSCGXl5Q8lhx5vAMWO2jyMDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155045; c=relaxed/simple;
	bh=otwBtVdJJijepU9fPBw0tcCLDHuttA19c9sU2t59/vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DaDRHbmZtM5jhj59+eQtMWADPTRSbhFkakyuH8WNDJ3rPFjyUblrd4hKDvWIaX5EhslpZwl0HnQqMMFsahhBEFHI5KVNwxJzpSv1b7EUuulJYggDISW4wJWeXHTl71+5q+NRNVYtn4Fm+NF1X/vX8U6nmXjY/gM4fT3LQroba0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=R85febyp; arc=fail smtp.client-ip=40.107.8.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdQti3eMdPQMY/hUgiSB1mRKNzNY5ayoekQ7uPAQyzd3xXGx2GD2OkRys2ZXGzipDx1+c2eiK9oPAthHSbLBxwvIomN2HvgbdVJZCTYQz6B9Qc4aKGKsxEVSPuyEcKH97exrg5z1bpTHRpAde+VWkzsAUVdptEPNOwTjltAerzjq2p5UyLTtJQYLbb/L+I8uQQ49/5CT5kKaI4PYj07nv9IeWHeDDS4/UiwO/Wun3USf37lttBbKp3LMrs1qhgELDWFP5+hqKQa/4k0EkRCOxy7yyJvKWWrih40v/7zzljSUyJRPTQSZXzg74eC10L+mHWVlIGl8+3AtSRBoIOSh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIk1RBtQQ3t57zC0lBGcssrxWdgauu3UqGduyzHJvaQ=;
 b=liCM03EXHmVoLyyCRnhaeP9fOtBgtCv6Rq0Acn68XUypqLVASHmrr+xVBc7m321G/XHHpwcPmsfpe2xgMK97gg2N38HXIO0g8k31YAXoyPU6gssGImJi3jAWa4v0RFJIp9TnxY6BjjQtHzx9iFu52LNCmi8Vfy5YMBUJnZIqIugi2u/f228tl3aDOl0xdLGWWdDjD9mbY1R0NUUq5G44j5ONRXjD7mGG+DQQ+DtNNd9FeNx9oIosR9UoXDU/+RRkSDBPSCLVXAeSD22S+V6hFjxbRUiGEK44pgkI407AGkoTvdoMvAXT3QO33MEfTof2FKZKGJC+G/hPENyd75SEpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIk1RBtQQ3t57zC0lBGcssrxWdgauu3UqGduyzHJvaQ=;
 b=R85febypbroXm2Z71TAB+xZeYLqIcV8U2xLk2AD5urpr1N/+cAbp5E7lRlMCxwjv0bU1Nl5ahnXoWTDrKDec1g/FM9Zbfu7vVuxtHLzkSdMNOLmdsnfmPxG2q2FpTrY7O6BBE0AyrBCOpMuGWgKWp+xefdfRfoQZiZckCQAR+NQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:44:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 17:44:00 +0000
Date: Mon, 5 Feb 2024 12:43:49 -0500
From: Frank Li <Frank.li@nxp.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
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
Message-ID: <ZcEeVc1y/V7jPay2@lizhi-Precision-Tower-5810>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
 <20240202-pme_msg-v3-5-ff2af57a02ad@nxp.com>
 <eg7wrjp5ebz43g37fvebr44nwkoh4rptbtyu76nalbmgbbnqke@4zugpgwesyqd>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eg7wrjp5ebz43g37fvebr44nwkoh4rptbtyu76nalbmgbbnqke@4zugpgwesyqd>
X-ClientProxiedBy: BYAPR01CA0058.prod.exchangelabs.com (2603:10b6:a03:94::35)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 13abe6ef-9376-440c-da54-08dc2672094e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MDyA37LW63Llo2NE3wBQtVAmcl0my8a13Xf9W0e+EI42Pjw+v/bznv3cIjIVHAHBIrqJJ1+phoHD3ttLZrQDHBbo0z+//twWX2Mj4ttJQe4TWN/BZGWD4vwOCqkqk7N1JxPKasACeglDZRm81XWvIeVNu0HeQhlVCqBT7khCJqipcLspRn+sJda4eTENtVPpuhD2c6D26oCflCU7oiBdWt9ioUSzZhFFL/zuFiUgEGEM1h7w07j++i2FUqATW7c8OxDeIFHKrtZUJw23Xny0Hqs1SqL6bDGVRHPlMJ1o0g7S6z6++gkb5ANufutTqOgwzzRrtv52N2xRDhY9hvNnik6BgP5RXLlmnAfh6WYfgLaEDo0IlagPFtpeyGygP9127g0B6kxznIXdS4/Uw6qw7OVgdoUO6DBr3ynsGFxBR5qlBQKGh/CSFkeE24i1ZWBSLZBzyMKVfwA3pWE6SNSvB4uZL4W7FqppLDq2kPIQuj2JwdPkrqDNYgkiZBHc82Iy/A0SOJm6AQCNw7oq0FG+TUQTlqYrYg2uBb5jUp5vLJmGlRueFfgu990BZcXgcYpqQhI1kpAqJkRZshQY1zAJtEqmgeIyVDT3hUx6KuP2FHGvFTU0ePeNGiw9QbalWMZ8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(33716001)(66899024)(41300700001)(66556008)(9686003)(66946007)(6666004)(478600001)(6486002)(6512007)(52116002)(6506007)(2906002)(26005)(4326008)(8676002)(6916009)(316002)(8936002)(86362001)(54906003)(7416002)(66476007)(5660300002)(83380400001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RdDskFce42UDUn4U9IovSFmhMPds84ch8+abTOfdFkSAwx2I8k4sZBtC1moX?=
 =?us-ascii?Q?2vV6Eq4VmQiFDF3y1NgQuyTwKTxCPVySnDfGL4h47BVX9Lp60v3g6pUDFkLz?=
 =?us-ascii?Q?it63ubj9cW0gckNtxy8ocmsLAHYDvPNaxqK6IE122aZKtoUgrK8OhjMgJQBj?=
 =?us-ascii?Q?DRKtA4H7RbssQQBvubQN5pu5/9f19gTE+eCs+COHAx7coCjCA1B9P+mlOz0/?=
 =?us-ascii?Q?ZRoPBq40M0FCwQjUzNifyyrxtkfTOrHObK8ZnG1b1FEWmjAO+YiOUpnplY2/?=
 =?us-ascii?Q?/fueNaecVHlbVbzl3I8bhQxKNx+0oEwMubuitKpn4iKBpadT2LV43Q3m+rnu?=
 =?us-ascii?Q?0oN8hTMNjXtaNPvvJNmdRP2u+N0LhyKlUZFnCZyKtGqi8uWrlM8gtS7leTfu?=
 =?us-ascii?Q?W6E75lJlrpeLTDpIggXqSerma7O1dFnfD4lpZwcG26n5ARFYRmBkbJlFUa/a?=
 =?us-ascii?Q?AlTajvDD0Fz7s2n/i+7CHIlFGqDCRfjcfIUJG4ZLxK8dtFMxvBfDPCNPTm2U?=
 =?us-ascii?Q?dua5Yez9VhrjdE22RTLDZtAaT6W/B8iBxsAi2dRyq4+HYU4vG35X4rvie5CA?=
 =?us-ascii?Q?d2wLRZZuGfh11GmNsoIx6aogQ9v3aCSCvYorsgPuthN1BgFOebYW3tNJky76?=
 =?us-ascii?Q?7/QJFdO15fE/CjYOHN/8rN9JHYrXmvlclPaOD28mlJM1ZCzbQUBhhM6KvqN7?=
 =?us-ascii?Q?9mfLwkRmsoAe8r73AZaTrM67KKiUb0f/USBnXkyf3cA4ZUcF9wiClx5U1SFT?=
 =?us-ascii?Q?8yWvccl7yaScpGPDq312eUUDvuy/Rh1eY2E28vHokG+pHO+UUmsa7vcaaC+1?=
 =?us-ascii?Q?oPs76I9RPtrgwvj8WutXJMmV9P/XWu9r5L1+Veu7uQ5LNxGmB0IsmArcxClC?=
 =?us-ascii?Q?ccQbLKjjYRtYMH2UHZqI0SPlzXWCbGTWECwvtHSBvBMfE3K/vxS4mP+bPpgF?=
 =?us-ascii?Q?FgXUfbfzv8+aCyxLYM23eWgzmUMgIwx9LDgPMlQ2aCCfAQR9HW3HpKQLhrLv?=
 =?us-ascii?Q?rwHaST6uzpuzS5BD3VrysDySZlTqa/tS0D5/4jcxPgAZhX+BNiny7G/aqBMo?=
 =?us-ascii?Q?hBVPIaH++sFFyEoIyW8GWklRTbNYYVJ2ur7zVk2TMbsYXhFEa8GZokfY+dNU?=
 =?us-ascii?Q?Oq34A5qPu4p7eB8DpIv08lX/7a7IFKkUX9Cmivs0qc2yhauJEyKOcUq2IYP6?=
 =?us-ascii?Q?2ywVvQw8sKR9bd9yac5XTc9JXzsoYaZQ5oQ1N9lbqGN7R+DKkzsMx5n047qq?=
 =?us-ascii?Q?9HJnTK9hz8/u5utxFQRjVnMUXl0rT8roN67AQtkbn3W6Wpu2jjXoxCzWGkXj?=
 =?us-ascii?Q?4S9C3VJ165BL+7eR/kzGtZ1SlCpTRhvuz6wnNexqc2IGDbxvwiRNU5ZBWjwu?=
 =?us-ascii?Q?PkclLzZiR4NX36mpEYHpjkp/KTIQgzK2TRrMtvNA3O3DTN8QT6VroDCLWTsm?=
 =?us-ascii?Q?xe+ty8OcFLFzGM7t+T1nTdndsn+7uWuXt8SvEVosBw6kdhLEwUO/gjxkEpaF?=
 =?us-ascii?Q?b+q53sFaHLbdBoNPTiLd8Lr+ZRxHP/uRvPXF6LAKrafpBs/B5ENIJUI7zeeZ?=
 =?us-ascii?Q?piI0aquzpVvmKkwQeF4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13abe6ef-9376-440c-da54-08dc2672094e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:44:00.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaHl9CAbXwlNmGN4eFviJIrdc4vEg2SW/kRaGnKCt2HuJFS+scktTG/567iWv5Y/OTMHqxB/WkhgbwBt/uRJdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733

On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wrote:
> On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> > Add an outbound iATU-capable memory-region which will be used to send PCIe
> > message (such as PME_Turn_Off) to peripheral. So all platforms can use
> > common method to send out PME_Turn_Off message by using one outbound iATU.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > index 022055edbf9e6..25a5420a9ce1e 100644
> > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > @@ -101,6 +101,10 @@ properties:
> 
> >              Outbound iATU-capable memory-region which will be used to access
> >              the peripheral PCIe devices configuration space.
> >            const: config
> > +        - description:
> > +            Outbound iATU-capable memory-region which will be used to send
> > +            PCIe message (such as PME_Turn_Off) to peripheral.
> > +          const: msg
> 
> Note there is a good chance Rob won't like this change. AFAIR he
> already expressed a concern regarding having the "config" reg-name
> describing a memory space within the outbound iATU memory which is
> normally defined by the "ranges" property. Adding a new reg-entry with
> similar semantics I guess won't receive warm welcome.
> 
> -Serge(y)

Okay, Anyone from device-tree give comments about this?

@rob, krzysztof kozlowski

Frank
> 
> 
> >          - description:
> >              Vendor-specific CSR names. Consider using the generic names above
> >              for new bindings.
> > 
> > -- 
> > 2.34.1
> > 
> > 

