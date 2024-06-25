Return-Path: <linux-pci+bounces-9258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B091741B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 00:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2581C20B93
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 22:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60E417E468;
	Tue, 25 Jun 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KR9MimB5"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A6617C7BF;
	Tue, 25 Jun 2024 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719353347; cv=fail; b=pYhKYxMQ2xj7dKDtwaeNte1vc7XZowEGTLoBO2QkzitPcMraotSC4G1vXhIbfn5i0rb5qX1Zt7Fymukt4/SSbw7bYoV6oHc4ortXQ/4ggDC1Rt0QlcyK08Sa76M5jkhmCIWNCknrT7O+t25KdLRngEp0a9n0yp0ff4FiFI/bDp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719353347; c=relaxed/simple;
	bh=74NBedbLORq9+tZi/IaCSfK3/kZYEff8S3KHeezdBh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dRlUj8BS3igS5t7Yeq2sdrDKwYM8BUlUqGu3cD/zLgn8imhhWPyFdsGmaCop6ssdcGHFnjwjg91K7TshBEkNgRniMhiGQUbXuetx/Sioj9QIDtHFURbaRFVthQHZi8WmD/V5OorKJ3oUzued+aSWHNXvxsYQvQC6BIlfFOIFKR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KR9MimB5; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Np5ma1fSoJP1DkSvouu22hJ7fAskNjCp6U7q9iz41A3wPMknL8h2EePbVTUHfB+0vUKHXQl+guxS7Z6YhWWP/qd8FEwYHIOOn43k9kh7B7ystnMZO60JUogAfakKPFJE/A/iYklCZDRz99HSOgRki71tC7T7XXO5wsoQOco6yL+Ky/OXnIxH5YNb2qVyjEhLo2Cv57dEIfJuKcVRCK1pMCxDfBPkeELiRUUlXDixtaOmNjcUHj+UlKa30wbX3kNslclJRQfoFe93dHMvvl11STLp//g39gD+uJLZ3RnfDpVDzFsP97mISOPGJa74rdD/LCI7KVPp1PO7vDJdY65zdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkFOShuNwR0tU4H1sic3QIBA+65ERs0DT8BAQ84NvkE=;
 b=OK024KuDDBcFgOKH+/+wVZR06X8gLjoOo3ZhUHJTwLLBpU78QJttvquRzNcp3AiBNRMNKMA1QPEAjH86GGE92/PntWmtZPIDG3YvTVimJJeHQNrDx0i9/ahbLcCb16zlOJ4vprY1KGBNo2blSilM7y8bTFwCXFiuSiILGUJgAPt2lsLJl4iZ+3uR/5SojRusIjBXsB/4fnBxVEjVQqtIOUdz6UP5SUnnVF+OpwEGZWo5uuMfrFTP6O8Yp+1o/LbXknoiBLjrDENue/qRDHLeJLUNOAoLNymRMgi+Zk0ykholqVVv2/z8NPvmEQkPdxWAXLGMcNUTD6seEB2rdH9dhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkFOShuNwR0tU4H1sic3QIBA+65ERs0DT8BAQ84NvkE=;
 b=KR9MimB5h8IOunJJETQwoQ4Blw2ZqsRaKQps6BLk8d0H+mgYKF0kB89QfTA13+MhS37VdDp+y4Y459p1/8kqjIHnIyymXnKxtsPiDX4FzW8Q9S9Um7IyCVOzXc97yq8F8UFIahZoyOm2c/1JZBeN8q8igOWcBvDcjLEJ9iVLz/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8407.eurprd04.prod.outlook.com (2603:10a6:102:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 22:09:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 22:09:02 +0000
Date: Tue, 25 Jun 2024 18:08:55 -0400
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
Subject: Re: [PATCH 2/2] dt-bindings: PCI: layerscape-pci-ep: Allow fallback
 to fsl,ls-pcie-ep
Message-ID: <Zns/98sen/qBEt9y@lizhi-Precision-Tower-5810>
References: <20240625211748.4041882-1-Frank.Li@nxp.com>
 <20240625211748.4041882-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625211748.4041882-2-Frank.Li@nxp.com>
X-ClientProxiedBy: BY3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:254::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: edf05cb6-9634-4035-7b7b-08dc95636c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|366014|7416012|376012|52116012|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nvHI92pw97oxd4W/TfhGSxBahIV6oecBN+C0LDtsNTHUSW5JbuXtQwoN70BJ?=
 =?us-ascii?Q?2GxQZg0vjO2J6s7CKOAiOFgRYwEr0yfoJFpOIZFt/ea5LeGCha8vgDetKAmt?=
 =?us-ascii?Q?DxQfZ0c9XfGcJ6SOXQ1FpWA3egoGPYRZqlponK9afeNS7w3jMOl2Y0hjKlcR?=
 =?us-ascii?Q?AEf8c6nlq64YqTO/sE7iZlu9quOiMo3OwOgJZjEker5qbfOxKXU17f8UVR/w?=
 =?us-ascii?Q?zoHhHq9hKi2GbEE7/tvtZBq2c4xt0mdz8LpotN5eLDEtcY/qBs9civBLT0Nf?=
 =?us-ascii?Q?HJNHpFnd3HwILnGHKGvMOBgC/J1GfwfEXDDXof0dgexZJ4yfcAQiLxBN2cKw?=
 =?us-ascii?Q?X6mK/kH+EJbu/KmNiM9YnmVsb6EO+qz8NjuDIla2Od7TJJXbhtnB+qsaV+HG?=
 =?us-ascii?Q?myuieBdLvSOHCuLQkwHTDzq33EMDGUPwKMvL9P9/DIw+5nY4yDEfpsnN8RYh?=
 =?us-ascii?Q?ogLCE7X4d043Gy77iB3Cd0dC6AdOVaRrP90MATUTokzHhFYWYnm3Pn4WRnyz?=
 =?us-ascii?Q?vL7AVchAxXF0TvESw3XXPGMRHhwSxhLM+HUSM6T7UE8I9OusRmpQDLeNH+Ld?=
 =?us-ascii?Q?m1r+Zbgskwma7Vmgn5Z0MtoDbQrEBXf3Ub2yI/wuQXSYjDALBdsdH/7XOzNp?=
 =?us-ascii?Q?+jjtwX3ust54ignYgOkPuWiL/RWycBByopAGj7FMHTTsCuZneAXYsPkxtuYG?=
 =?us-ascii?Q?9gpBVLdX/yHp80SOPzlp23ZZLi4z478GsfgIEuD51dpL1eSy+A3cMTFrm89O?=
 =?us-ascii?Q?NLfzrRp2sGAxnaYtF0/SSfIJwGbX+XUzNXjX3Ok9Xctf2f0H9tm/c22AVdJg?=
 =?us-ascii?Q?zuJF7YUHV0XbPuIQHW6TTHWk2wWgx0yXZ2AEhAi8FMH2PSddK2BW0WCsBEpV?=
 =?us-ascii?Q?JbutjiKNyRiULimi/HggBQ39pgk/p40z8JjqJI1J7pkRDBTGoVx1NdK3KDgg?=
 =?us-ascii?Q?TtFYM/GyRsC27XDJTHKwmvAnpZ2M2+n34RkbGd7CMo5lLSbwAchip1CxqOXe?=
 =?us-ascii?Q?7tCelt60xhi68kGP5xroUhpcDs9kQJ9kFZb38ZU2NR5MsLdEkmkX7+DHaRuW?=
 =?us-ascii?Q?qz7ITfflFw6IgTKdw7Mzz4K+npxjbKxdhkwp5e7o7iEZVO3erR3Of0//8IoS?=
 =?us-ascii?Q?1vlkoDH+bEo6CvQd7S9zI6gfN7tjRFyzcgaBk1FGOlOJfGw9JvO5A8KbPXcV?=
 =?us-ascii?Q?4rhJDSyZJW5xt3ET569IlwvkPcPamxzc9g8JPrhwjsI8U6QbrT+Be0Ufmxds?=
 =?us-ascii?Q?0mrqEIsFUXn95TXjTQa+VBUXdDcYJzBsGiPEmC0ruCCbGbzc0utk36Oy3niv?=
 =?us-ascii?Q?QPLRK9yOKyhTDN8SFmHwM9oLspY/F2TIaABaBMTuNeI9C+BycjeSLkPoBZBk?=
 =?us-ascii?Q?5UqXaU8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012)(52116012)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aA6R4f4OPHM3qmi86tFXCPu7K1gU3rw6rgxGWfci8G4SwVTcNfoyjMjHuCbk?=
 =?us-ascii?Q?z56YV8xaI2x3Tz1bErEkcu3EkZ4qknTsrKlI/+X1GwccEhm2cuWC4cY58hjL?=
 =?us-ascii?Q?7g1++dBoONwwZ+pACBIuos7K6Aq6aMmxOLGVcA4SOOwmXbv+wByF7+L3iZoj?=
 =?us-ascii?Q?rMRqGRDMib3M1O7rktRSCLAHK1U3ZPs6lQLrOMmMNlINGgD0Anf8v4YPiJh1?=
 =?us-ascii?Q?QUzqeMxhPjZPzYQgzvHcHIMzQxdlDq+ReKMIYzdAPZ1jF7u2qK8SsTUm0iYI?=
 =?us-ascii?Q?4tWD/df28QDi1cJuYkcral9VxkC3RuLXgVN5f+0Jf1xQqPdgyptYNYYfpqcJ?=
 =?us-ascii?Q?qZ6+HeN1sIhMm4TTdsFICZPbrVRm5VtEWCRfSd4CyDaaRK+hQbyleLjFnqQN?=
 =?us-ascii?Q?y2Lhoo7/sL1CfHUrDSvoDewVUfvgZsk0tUZC6UN1gZptESJnzq1doBYnbCJ5?=
 =?us-ascii?Q?icwJjqK+zoqloGImdz9YMJxVa+FE/k2A5CxW/JZ/SODNjxO5ob2QHqHzpCBV?=
 =?us-ascii?Q?xsmliOjWRc4piMPGZiIxjUfkSc75jRnaPq2xMNAvFzE6ltObl9B6xf/XHYR3?=
 =?us-ascii?Q?lxECBvke+/oj5sJXo1ssWPzQLRWHcXxA9aiT2h40R9W046pirkslMYgo1Gf+?=
 =?us-ascii?Q?GG+jj6lmBF0s5EF6OZrhN4NWkzLi4/wzSCV4WI2j+yaeQTQbGbMwY/PyQdxh?=
 =?us-ascii?Q?Qrc5LajeX+WWK+CBT2nwnGIzuqPQujW6jcyOYwYesaw55MZgjH8Bz9hD/pUy?=
 =?us-ascii?Q?avNkmjreslBCjcSnOVulzaq/SsuSPoA61j1/bUyUI66qH8lfvPhmAG2lNT2E?=
 =?us-ascii?Q?yTbkkGXTP7xTTNj9YSXFE4fHqKan3CrY+9tK/jRxeXDDHvjKVtkSIB77+iRu?=
 =?us-ascii?Q?MxpoPffXRbAxgXf2N6HY/trhdjTklHpBPzgNz7N8jQ7FS9/Br7dUxpA6kiul?=
 =?us-ascii?Q?LGKHv8Inm4jWp/eJhW4Wwyb9oniF5GUhF7+aAFOmpy4rBIOOz8TzYnpwvBaQ?=
 =?us-ascii?Q?nyU4dIhb9Sjy51q01fTEert07WSRbKwLf0BTehv1lJeLQvXmXxhzo5tvJPJk?=
 =?us-ascii?Q?YeP7I5gQyivyJX0qHuk6CQ7zNnKVYg5FHROfofgCy97qh0yzu7oHAARXF0Pr?=
 =?us-ascii?Q?lcJr0k21jP76kaYuoLwYgeEWovBfepd2hjwtY+T4ND8Afuo4YdsDqPbJVX0j?=
 =?us-ascii?Q?aIw2PeyPRKOqkBMgwEcZ/W5pyMkCUttTekb/kUphzZNyQ/PZA/6cXPX4XTG7?=
 =?us-ascii?Q?BsylmIJfrL2MDrkuq5pJ/PUxIQ5DkRJLwBuPoyvhVhtfREC8TpVMpVmJTjC5?=
 =?us-ascii?Q?+ZfPHvC7rK8oegfJK919YG++Y8bsn4eMf/QIcd/O6ShxxO86hrA7ZQIPDfGS?=
 =?us-ascii?Q?e+oYpCUtzAPNc02yqAVrVKETThYmoOcBThZtl1iDFcMXCTMN/rApZBULEvWU?=
 =?us-ascii?Q?0X2nlcQRqp+3aEFuDqq72HSEToeZ1ndkBLmFsM16cpG91d9x4WcGmlIxPNob?=
 =?us-ascii?Q?mtRN0khTJ8pD8T6ywg53P5PCjjF5nCvJJNQ8959doWDbArWMlT6tuwnPQ4l+?=
 =?us-ascii?Q?gqgIYn9ISBfWP9IGxNE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf05cb6-9634-4035-7b7b-08dc95636c03
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 22:09:02.7575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6RiXsb5IlMnVfwB6gN1l2Ku5lK5N6AAsoi7o6qRsuVSdheex4jvBpGMPvgJMaQaRAXMAX86rzZ8mP4mfSLlUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8407

On Tue, Jun 25, 2024 at 05:17:47PM -0400, Frank Li wrote:
> Allow compatible string fallback to general fsl,ls-pcie-ep.
> Fix below warning:
> 
> arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: pcie_ep@3400000: compatible: ['fsl,ls1046a-pcie-ep', 'fsl,ls-pcie-ep'] is too long
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Sorry, this patch sent out accidently. 'fsl,ls-pcie-ep' actually are
not used in driver.

Frank Li

>  .../bindings/pci/fsl,layerscape-pcie-ep.yaml      | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> index 399efa7364c93..21f1edfe814d4 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> @@ -22,12 +22,15 @@ description:
>  
>  properties:
>    compatible:
> -    enum:
> -      - fsl,ls2088a-pcie-ep
> -      - fsl,ls1088a-pcie-ep
> -      - fsl,ls1046a-pcie-ep
> -      - fsl,ls1028a-pcie-ep
> -      - fsl,lx2160ar2-pcie-ep
> +    items:
> +      - enum:
> +          - fsl,ls2088a-pcie-ep
> +          - fsl,ls1088a-pcie-ep
> +          - fsl,ls1046a-pcie-ep
> +          - fsl,ls1028a-pcie-ep
> +          - fsl,lx2160ar2-pcie-ep
> +      - const: fsl,ls-pcie-ep
> +    minItems: 1
>  
>    reg:
>      maxItems: 2
> -- 
> 2.34.1
> 

