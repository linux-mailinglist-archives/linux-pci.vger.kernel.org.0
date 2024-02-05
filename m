Return-Path: <linux-pci+bounces-3121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A34784A6BA
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 22:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388DB28EC5A
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 21:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE42524B2;
	Mon,  5 Feb 2024 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KZ0MBYwf"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A5851C3A;
	Mon,  5 Feb 2024 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160430; cv=fail; b=Vts0wzsHsJb9QccW4BL3P0nfAM37QtjkRzDZBktyqgYljdZpwf//OPvaxIPRMCMNMFangnvu/Lf6d8V1YmoVoDCZrAJtStDq8fAICoQS8yAvVXY6QvKAMJWIsTPwzQTSBTlMV0Wue0NSOCkzTBpT6yqdh5pXjvglENn+XJEWhI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160430; c=relaxed/simple;
	bh=VZIth7dLNJiwrz8Obnr4g7PUpHIp9sKOEPrmwUrF2F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UcHEgH9ul37L3UCN7RvnrbVFR3GzdUUu/nd4bYrrGCzBhOGXoF/4/z2xGc2kJCoX+JySFkgG5Aw2Aoc2VU/BySpHJT+JughcAEeLCftOOYAO5W4i4kYjnsqU+WyDZzRFWop+N9mosK70FLJYJNjFAKeJGk85Z96zN69zgNyEaYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KZ0MBYwf; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezqMdIvuYIDqdiN94zKFRAVn2H57FOrzP6DNy+EDUJRVwb6qkV2RxXbtaYivjgyJilvRSxJn5x3rW5J6YmK3zRGrrOeEObFv2OYuHIgO+7TRw6v+aKNWXkp3gjihYoUrS/1D0f6uZ0bIHUgTJjLJBFceM15gtnySMvA/PFvD9rzyhvUwtTfqQdoifeiwDo8P+9SsCpiPsLREaewD/JplwzeJfaJx7Xfo9i+JkP61wnNq/VW0COTXOx7JXXeecwpy6ON3RX2ve59oG5p6ZRU20Mpws096RjUXjtE+h/rXFocRt76lPB1eTzrHF9ADp65CrgB9Cehq/L3BA+y9QnarmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLqAlojUislmgvL0hBYEKxQuht/D4BXRDxVkLIG+yis=;
 b=M6PYwRhwd24U7UsS4aGk+W11Tsc6vV73iZ/jZ7K/CGPYeqWRy1RO2cPQyF1rr8uF2bBzxh72ebyl75Au56clGOmwMCFsuNu5Z0Z01sFZmVzDq07yvZS+ey342F2udMc5ZmdX7rcAlXoUgo0ZhsqENpzhlV+rL5yoQOv4DWQAp8VzZRKkyOY5J6oGyTkfIROGPNdNlUUw9txO+e8ctJit269gCV6YavFB6EDofnbg3cC7ckULgzKewcccUK7vQNFaPvtXK8zV/0VJZGWWfE2Qdekd8HypWpdjDPXo45z+NJjpogpXC0HEjmZ/zUiEnS2O1MKWJrPn70lHXkBtijbC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLqAlojUislmgvL0hBYEKxQuht/D4BXRDxVkLIG+yis=;
 b=KZ0MBYwflEs6/QOSOXBOTeHeShEWVK+4hYAt6dtdrImjJfq2vqLyHmeBeNOVgqqZQEzdq/j73NiJYA4ZpQUkeJAZkeJNMngIg6cmPadBOMYvtkxrGeZex/yEcet5BQwK33CBZ0UdpC0yCDb2MDmKoeEjUM4ClLI+h3DijLWlVkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8286.eurprd04.prod.outlook.com (2603:10a6:102:1cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 19:13:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 19:13:45 +0000
Date: Mon, 5 Feb 2024 14:13:37 -0500
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
Message-ID: <ZcEzYdZKotBJlR5i@lizhi-Precision-Tower-5810>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
 <20240202-pme_msg-v3-5-ff2af57a02ad@nxp.com>
 <eg7wrjp5ebz43g37fvebr44nwkoh4rptbtyu76nalbmgbbnqke@4zugpgwesyqd>
 <20240205183048.GA3818249-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205183048.GA3818249-robh@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0383.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 92cfcc8e-cc3e-4776-0f71-08dc267e931f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rR/1k42aPDMSjAuU2IM6IEesoCblRYuxx51yARlxOl05zrsBZH7sc6dKWkQGGBbnWGqgRQzSlxjPYGrhXDJHGCbkerbHbdukPGFrlQutoB6migQuv41V9pUrPugDi0hIuKsZCfeG1Rr7keG/bdvDY/4/VBsIXEggaQkN25K5+/o63kGiEpAXNJif6koLlu+Er+iS7kiTUqrk3a4xiyxG7NekwmWFrDJUdefrbtso+VxVKrsKEHrMbBWRqXWjwua1fBoiwobaK3rgIVIokw2Klgfyc/eUzEowQNUWZViPEquRxIODm2ny+jE6lwZ/CKmuGWbfe3eHiyLxMQXE4G90WuxipYAGVh7mX65xQD6zsPUDnm/Kep5OeW9qoF3qpUU4wtc5O5NWrwGvfmDJmHkME99oTUNxeHiHfJbSVopO+32MI6Qtx+BRVUjBIqW36DPJpEQ2sFdx1snKMuoH9IJE7rwmVysU8qxT7qulNmAD+AZp9moqpUxVbQzIvzaaH8yI5ppY+hxIRvJ0swCCkvCb5O74Z4mUpl1AHCsIrd77BX+zpBicGj0E5XGQuIBjAir5cOYN06Am4Hdm1YotwzUdZbNblrficQsVVld/g9kiSn4GafDhTz3usMvXDeZww3GJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(6506007)(6666004)(52116002)(83380400001)(26005)(66899024)(86362001)(41300700001)(33716001)(4326008)(8676002)(8936002)(6512007)(9686003)(2906002)(478600001)(6486002)(7416002)(5660300002)(66556008)(66476007)(54906003)(6916009)(316002)(66946007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Q8BN8T3LqAKPCO0EyP/U2Z2GJ3IOb8Dj5lzeeiFWg59PbKVpNHqfZTCkiTn?=
 =?us-ascii?Q?k+Ss56sCtkQ2mSQaKAbPSrgiMCSZKJKCshOK9Gf/3SU1SvV9gbvqrySlc6sP?=
 =?us-ascii?Q?WSybrEhQuVqhzGq+gLewtYrl+HbB3MqDxsA+FoBGYGIFBQqfl7iFmU065I/P?=
 =?us-ascii?Q?yMNFfddPsRFockXYIo3ztPaQph1Vi7JjrGx1zq1d15yfNXirsEQiUeGQtZE0?=
 =?us-ascii?Q?0AgVo2QrmHrLM7uXGaWgwvNT/HNjcuubw894ZAvtygPsvqE5DVnGyMJQ4Ut6?=
 =?us-ascii?Q?esyfmZcli3FysHP9iFB1AnrGldfsMO6f4K4qah7vIx9T2TVD9Mg2zdLo6zds?=
 =?us-ascii?Q?EHFgq7u1W28bsH1Yc6S4PszjbQ450209/pmSID9G32CXzowCGTVI3gUkScrh?=
 =?us-ascii?Q?mP/FpczqVO6kEZ7xn7TNd7V76/Xd+TQnGiTKxQ8/d5offu80HtvIdlLO3gDn?=
 =?us-ascii?Q?rOxnWHAoXXLXnP0LShXPMDCCPE25pXIraYoyhc0kutYzfPSJ1+OFqjvzg3mF?=
 =?us-ascii?Q?5pkv7tAFhk6mjbCLqU/4496CsaKCebVdsTlkSsZZSHvcuxFX6gz+rBXuvNlr?=
 =?us-ascii?Q?1IU9+0eiDeCZ2zYIQs7/YbcLk+3fU6yyOKG79JJv0yFxKBqJgx8txKvasOau?=
 =?us-ascii?Q?BZSoK8byOsWuquiGyIWtaTac0ILn/CyljGMHb5s+aQLg4E5A47sRIoGneLlA?=
 =?us-ascii?Q?3a9St4SFg6SMmtS8R7XpPYs3F3d4CLkDR1LHW/dnYoblQ8RTXghPiYXeYMQ4?=
 =?us-ascii?Q?DMobdU4Oy5ZBqR38gt7TbaKKmEarT70Q9SqU1p0OHrRJubM7c9lGmekReuDy?=
 =?us-ascii?Q?sf2UMcjBpbZKSbtN/upuKVbyWt2Uzpdc7M6l+ZTR0XIUYUNsBu0cfMajMQZc?=
 =?us-ascii?Q?qA6zM7AJaKwuwkIwsFlmRS22Fa6IAWllaCz0p4G3/OEZtmg8jmcfrpUeB9tC?=
 =?us-ascii?Q?EvqrqxWwElM+ssixg4ZQ6STUULjpyVZuIJleVHobXuDnfdBTIlT2JAatsx48?=
 =?us-ascii?Q?QV+LOu/AQRVhwpCq7pmMTGgbmxA7xD1wn04UPPILRGIkb+Y0o84NjyDfLUa+?=
 =?us-ascii?Q?Ti0arn98hXdYUNUAkfOwFlxjU1qhjSngQvXWHgsg0J2BQCxkX8EqA3D1T6lQ?=
 =?us-ascii?Q?IkEDVo0Um8i8cgpI0WwZkPlRcw+nPNm43EQAzjcysDNaxMhqL5yllOMStzFC?=
 =?us-ascii?Q?jay9L2FQZT3XtCVVQ6Due8VIHubN2IiQcKvbMRhyy0PCxdqWHyGj60ubIK6K?=
 =?us-ascii?Q?EFpIhglD/WO83Z7IveDyJiiRB0PyVKeWsvud9YjzzwlLru6SzGz9M1S6Ofoo?=
 =?us-ascii?Q?LfBmd9EldtlYh+uMrcE0QMBJG9YGfk2xvmhlYl9QcRpfkmIpSoCvD95oA2pe?=
 =?us-ascii?Q?uMmAdJTqGii4petfGo0vtzy2HZzPkS0JEyxo0PDL+YKh5ag3JJmbu13DH+Ad?=
 =?us-ascii?Q?xhWk6uZznFwPIPQ4HVOYH0+oBujtXwhLWsWCaEPGlwbXWTeHOIes3HxwNTEx?=
 =?us-ascii?Q?iiifnK6g1wNta/KDvgH53qacybf/mmma0jfn3e3E4vMk54sQRLUZsZqHYAWN?=
 =?us-ascii?Q?/4fLP7geVNnzqSfQWY5QdA4ws7l+eDkTpzxA+2LS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cfcc8e-cc3e-4776-0f71-08dc267e931f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 19:13:45.6904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eb9eWbqkLDB2gWSXu3H9+EM+xJuX09zPeApdbdQdn06booo8PlJvf1cwZuytBtlGKS0QWK7wL8FaPRWX6fCp0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8286

On Mon, Feb 05, 2024 at 06:30:48PM +0000, Rob Herring wrote:
> On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wrote:
> > On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> > > Add an outbound iATU-capable memory-region which will be used to send PCIe
> > > message (such as PME_Turn_Off) to peripheral. So all platforms can use
> > > common method to send out PME_Turn_Off message by using one outbound iATU.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > index 022055edbf9e6..25a5420a9ce1e 100644
> > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > @@ -101,6 +101,10 @@ properties:
> > 
> > >              Outbound iATU-capable memory-region which will be used to access
> > >              the peripheral PCIe devices configuration space.
> > >            const: config
> > > +        - description:
> > > +            Outbound iATU-capable memory-region which will be used to send
> > > +            PCIe message (such as PME_Turn_Off) to peripheral.
> > > +          const: msg
> > 
> > Note there is a good chance Rob won't like this change. AFAIR he
> > already expressed a concern regarding having the "config" reg-name
> > describing a memory space within the outbound iATU memory which is
> > normally defined by the "ranges" property. Adding a new reg-entry with
> > similar semantics I guess won't receive warm welcome.
> 
> I do think it is a bit questionable. Ideally, the driver could 
> just configure this on its own. However, since we don't describe all of 
> the CPU address space (that's input to the iATU) already, that's not 
> going to be possible. I suppose we could fix that, but then config space 
> would have to be handled differently too.

Sorry, I have not understand what your means. Do you means, you want
a "cpu-space", for example, 0x8000000 - 0x9000000 for all ATU. 

Then allocated some space to 'config', 'io', 'memory' and this 'msg'.

Frank

> 
> Rob

