Return-Path: <linux-pci+bounces-40371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35197C370BB
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 18:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70A2624EE7
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3832334C25;
	Wed,  5 Nov 2025 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lxRV1Whf"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B433328FF;
	Wed,  5 Nov 2025 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362817; cv=fail; b=skb4lEBZaD75ntAqR1LONeWqrKdvszD8c6s+iNXqMmxEnc/KvfXj/OYkqf794uLH0d6E4Muq3PKSNXqS8b3lAF2PKDtTtJrWC7ObTx2mJ5vre9pZYYpX4KvEEb2zd/h4a1CkaVOPCL35azuXry4i5jY8qKABq9Gr3X0FWu+3RKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362817; c=relaxed/simple;
	bh=MXEYEGTSI4PO0I7nzTNkxT5pTWSINjPFklecraiD5Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eR95JDNoiNaWdIdBcfT3MTtmGHXyDqliIsSPHhCUVE9VI+tSXhMfdlaFGSspNNj5AcRWZ/9mCMxJnbuROzgHVLv3iDDYSzFm6xV4ZB7TBeKyeVUuyEcfGsFwsBC7yxKp9VzbMxyuuXxofVim39CZJ5XXeeOo42A09Sx8imWj2+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lxRV1Whf; arc=fail smtp.client-ip=52.101.70.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPsY++LSD+kc+NQ8E/O0MvaoC6CqdUvuzpf6jikVGa1o+Wd7jj/M4lhrQHlGMH1OVORHQ5j4AWQRfC31oOLgSwXVjY1JRcasrSK3Xm/wiJf/kvS2Cnv0WKy3YHW0P4R0s7TkU9QOmk7AHw4B/WedH92X11JG/3uMPDCk7IQYf4YiHCEq2+rSAHRv4gaf0j75WtnoHIiKDgXFh2+a0g3haE9iksH4BFwoQ+7X6SR2v5rb+/QwkQJQ4oVGhyYZ3Dax9gW58alC5ieYaNQSgOgdatEJzpaLEF+qQzkRmdtAY07u9EspUErwy62xYjpdoJPHU3hqc4QFTtOsfLgMuI7mLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2FSTrJohZ+jzN4cP92zeViuBYYvl3CIiguoHMCiGIU=;
 b=ely4a1JVkB7k4X/xxgyKvVVGvi3qGsmho2k/p8mqJSfupleoHXUjeLbXkC2pzhWmHq/DDU4rpXGNRZQmT5RVVwNsFwVXIcDH4ZERhN7k6qDPpK1qiCt0O+QB3JUPJ86Sn536XLCj7XsVrt3q0ldLIIK2v7z87JcoNDlEpkn8SW6DGfC1xTeBsTiY/Gu7IgDdJLZ8tu81UYo252yaMrloCf/qfeWvN++vBPQvONKLtpVqAF19POce9pNv8wJZrXWakyEXKgiepQ4xTemRiuvcDAHK0sDoIoLVU/tA6ipvPl25t5xjL5NmfMOspOoPA8jMMDB2iZkePmXC+5s71HQuRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2FSTrJohZ+jzN4cP92zeViuBYYvl3CIiguoHMCiGIU=;
 b=lxRV1WhfS+y3MLuwz36X6S8tz7xtjt0eqVVBmH/p5pcmP8VKgtcM4WtHMhFP7F/S5jrfvhMJ2eUZaspza40kK6WxhzRL/8fU/+cgz9x+TH83cME0jGVcty6Om0QPzUlaZ5IXDVZbyckGcPeJS0EN7RpUPlrFOLyHjv+juNopxVBV+d5i7yRQ+2kbVSHCllihkTwBwEeNWpSnveCya/jBgliXA8vGjMx7AEqd7F/T7WbFA+TEB8gswCP/cwYhlm795JWq/dcWG4Rfl0k2b6qW/EcyGlAqI/OQZ/Gubo/K3nH3OmKWtaqCoBfjISpHuTv44f3f2w3HSEEjFdmJe0VAZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DBBPR04MB7884.eurprd04.prod.outlook.com (2603:10a6:10:1f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 5 Nov
 2025 17:13:33 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 17:13:33 +0000
Date: Wed, 5 Nov 2025 12:13:25 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical Key
 M connector
Message-ID: <aQuFtfmzbNoyHwG1@lizhi-Precision-Tower-5810>
References: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
 <20251105-pci-m2-v1-1-84b5f1f1e5e8@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-pci-m2-v1-1-84b5f1f1e5e8@oss.qualcomm.com>
X-ClientProxiedBy: PH2PEPF00003858.namprd17.prod.outlook.com
 (2603:10b6:518:1::7a) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DBBPR04MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a61d9e-36b2-4295-95aa-08de1c8ea5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|7416014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j1yXtNcFt4t9ftylkCzouqBu4MAkOh7nbAa0x6QLbzVMWHtgPpVHg/1yOg07?=
 =?us-ascii?Q?QKB2WdijR5Eq/Q1545cl68/HNzMcpXbtr/UU+Svi+p6ZPSmMt2MtdlvugrGM?=
 =?us-ascii?Q?Aev4PxiuhRoRO+elE7+hTDvFm6Qct2uylfN2OJIZHyjayt/eA0OU3FGPrvDF?=
 =?us-ascii?Q?ubOzOMFD+IynlS/pcXrRLP97DpNmlIDGWLXyUbfWqsf+mmXlFQxoGy8GWeXP?=
 =?us-ascii?Q?u6sWyWG3IwA3qGJUTcfw2X7WMtSHefXGH36qbb+UpQ5Fg1fF1rwtUVRbgAKJ?=
 =?us-ascii?Q?jrfLDobydBDgGQS8uI6oLzvjdNsUA2JdQEO60jlazEqLaXQMHn4bNOJbcUpT?=
 =?us-ascii?Q?YrBZC/bV7nrwi9mYgai62vCXc9Q4/DHZblfMsMEso8Fxe1KE+kTdBukIxRqj?=
 =?us-ascii?Q?06cCNRVmiZhs6WHWzCZ65fGyauLH3L92E+CbyFP7a5aN/PPYdFNa0Puxx4Af?=
 =?us-ascii?Q?y6NYpVrbLofKCeGU1B4M+A88YnSHC26JHjXy8VbrMkKTMW/IEjHmgWHuQkil?=
 =?us-ascii?Q?qij9A13XSW7V7j6MtxOdY5xwz+yi24kk/019ib8j0yRP60YWvBdT/8utFJBg?=
 =?us-ascii?Q?MQ4pknKTGxBIPyAbMdNeiSInu/WJ1NPmfjfaV23JKmql6BZKIF47Rr5fpSUG?=
 =?us-ascii?Q?QGkESNEsH9Oa/+RDtG0+ftdImEFrRu+2PYMXtgsQRsHM7WIx7xGB+CqQP9a4?=
 =?us-ascii?Q?LBLIchiuei/7N8bU32eEyRE2qQffftKWVwkYy7xj9JtBF2pc1D9Y9A7xFh+Q?=
 =?us-ascii?Q?3VI7mCvfsouBTDLp2oTlLK/GAy57zwp+TiSO55mY0iiFZTUZqI39mYIM+g5C?=
 =?us-ascii?Q?M+qrVauJ8NFfNLiSylMcLCZYA0+cX/BaGly0QodZf5Z91WpXLx1/64sDeXmS?=
 =?us-ascii?Q?lr8PWQhobpIh14wyAAMCOqL1yLGmo8tNXY0G8e5QQVVLVymZ/YyXBGVQXM3O?=
 =?us-ascii?Q?tO9hDa3JxbNvN2SDCc+oRDEYK3rKUGk0l7+AiicjsBhDXy3qtoDserTXm7Ap?=
 =?us-ascii?Q?3VODlLfTcE3UWBadrPTg3gkH45SzgXPFQgcYfzoFKmeYnwvcAqwB2F5WAX5h?=
 =?us-ascii?Q?BIDPjWmGkZ9NRMWhYCn71tjvC+DsGNFVUVYOAM51aJ+qc2+yARHRx0EQz7w7?=
 =?us-ascii?Q?BMl4wxruRPA51cLazeVCpuKSyWD6/1Naprid+fhsrAPEpyykxC/8zQWNk+p4?=
 =?us-ascii?Q?j86/m7lYRGPfjA3faE+MCeSVzEB5LbbQ/TvsnlG0XhoE23b4XcHzKxymfjUr?=
 =?us-ascii?Q?uPl3Q0PRkus6qSGvZlCVZveR5Aadc2DS0jmGpJEZnWn7vOcqmQCbjuJAPdCI?=
 =?us-ascii?Q?I49HBSD13NQHGIW+JDiXkl8dNYFWhqzDjKV/qgpZ2cb+LtPSdBdHV7Rk/LEZ?=
 =?us-ascii?Q?ab/Wgbz5Zsvn/hrCE0qDPoUolQuKDuiVLraEexyX8PVjGyBVynWHJD1S75SC?=
 =?us-ascii?Q?WaMPCxXmWEuvpCKyZ7CBbTc+TzJooNGbftd2DdBuPWfiH00ScP+m+9AClq9C?=
 =?us-ascii?Q?OJVJNhcsa6/vwa9azjlclTEzVhCjazKSzLrZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(7416014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xMYFWhkxoW31JzkflsqPfp3XvauFMYTds3+DmYEnCqi+g6mjq4nlBUrGPpEy?=
 =?us-ascii?Q?pszzG7Hn1hLJt7fSXKVAl28TuSeoC1UDPJp7xfQWV5M2BcwWkjx49Cf5Jl06?=
 =?us-ascii?Q?9hg5p/Rlqn48wfG3o88J/46nu5Ng5RGajEoFgiglcrjvCnrfTdytiZ61x6P2?=
 =?us-ascii?Q?J25B/OEZDO4jXNSCD0phgNCkvvbrdMSaKXeASkxrJQhXFaqCa8B0IotnvCTW?=
 =?us-ascii?Q?hZbDDUngg9Z7S1ctcXKTWTI3X49BvCczK+ky1pbL47gP2lKGB3zDg5cN5Jt8?=
 =?us-ascii?Q?NcOEq/lSmBhCCGesiuzm37dscWCJ94p9bDFxH3kP1Jnc2QLBml/L2lHo4yV5?=
 =?us-ascii?Q?hiNASo9r92KBvAQAPfVdCCLe//EGUaa1qME9yuHWLbDeSftNbnhTqPpEC/G+?=
 =?us-ascii?Q?B/Ue8rESE8eBrXnbJTRD66Wrv8fsfQ6GetpMq+o/RpnkMWxmMhozvwQqnV/s?=
 =?us-ascii?Q?1yqOZrEHUeIdnyjJh6QuWw0ebeLxFNY8ivmqeFz6o3kxi6MKA+i/d+fbDWJi?=
 =?us-ascii?Q?+GeNec1DU43eKxdz6Qei7KqHk6AIGZ53jjsKz+GvLt5265BC5uQYqcYfNcBp?=
 =?us-ascii?Q?maBR/AJCZRVnSOlb5ZKuzcgyhsKLkKmEZyifbUWpmzpYiepeLX5uwJbPfh5b?=
 =?us-ascii?Q?UTo1D087oAnRuFiN0NhIZSMxViOVUPTZlmL+BGM/p7Rzn26IogUguBvDyZdU?=
 =?us-ascii?Q?k9uKcWD5EWZiC9KJrfu8VTgFE6NBOaNLAR77Enc3oHHMBkvgHmT8AnUhkIOp?=
 =?us-ascii?Q?2xG6bmKnUOLzHOw9fkoPQU/SEzVlF///tVFb+H4K3OknobYl8n9xvUc3QXu6?=
 =?us-ascii?Q?HUcttLjaLJQS6USj5MdZwxGxWJUCDRAfJNYz9iEmZnUK3719Up9/gL+k1e3d?=
 =?us-ascii?Q?eDxC+nM7BtkINSP6iP2iP5vb6tiYr+yJcR6id9M/q4L67LNxBPJTtE7QQwQK?=
 =?us-ascii?Q?mP8QXKpAktaAa2XTHVKGa8ibu+S58yi5aW5JBD1Mj2yzsGHnc4+6rDbp2AaF?=
 =?us-ascii?Q?EHRR8nQFE4CmiRphmkiWK585mwIn1I3ycTiQqW4waOuQHrW48fosv63oCMjX?=
 =?us-ascii?Q?L6YFfvNXs7qdxsBVOO57rfeTYwX+x5bbmPlgZrCPkZMwUvV8kCK83EJEtK4o?=
 =?us-ascii?Q?Ar7Zpi9t5AN5wMmjHJ5fnYPjn9RRjfh9lvEsUlfw4OAcvLpJTyyVmkEWnGji?=
 =?us-ascii?Q?GNuMBqhB1rbVIEWyaY4vyqcQ+IhvEgFTPK/jl14ooOnncteK0vMe85NVC9cO?=
 =?us-ascii?Q?D/mhUBCwvBzZXSRiNSzVzXUy4yjh5ZE5DrW3D6cpErcQ/0UTN4tJ3jyQ2Ajd?=
 =?us-ascii?Q?ECm4xJFij7M8fx3kQmAcjbtvbpbXxdkt7dVVNED30k5BTqPxkirzwfDislso?=
 =?us-ascii?Q?nayta2GUsczCSZSCOoJTJ6U2z8XCQNmsWVDQAqeyGm5Br65V0LgOtASEpwx5?=
 =?us-ascii?Q?o8sMY9lwTTILsMgLAum/Va4lUCrssDbkKvgMspbMDy0Tt4NfzHAZ4p7j/BwI?=
 =?us-ascii?Q?gZdpSPiQ9aLBNfF6x18RoqCDRwOtYbIG9Ef2fuHs+n+FAHb6pXn+BqggMsNY?=
 =?us-ascii?Q?E+B3sXi4581CjXxgtD4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a61d9e-36b2-4295-95aa-08de1c8ea5f6
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 17:13:32.9651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSHP1n1dB8uhtRegdzJKlHKXyTTBGUFzxN26KQ8r1BFqFqJlTlF8go/cSQ42nmpmi1J96AoNsBoM5pMVP2xd1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7884

On Wed, Nov 05, 2025 at 02:45:49PM +0530, Manivannan Sadhasivam wrote:
> Add the devicetree binding for PCIe M.2 Mechanical Key M connector. This
> connector provides interfaces like PCIe and SATA to attach the Solid State
> Drives (SSDs) to the host machine along with additional interfaces like
> USB, and SMB for debugging and supplementary features. At any point of
> time, the connector can only support either PCIe or SATA as the primary
> host interface.
>
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> 1.8v sideband signaling.
>
> The connector also supplies optional signals in the form of GPIOs for fine
> grained power management.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  .../bindings/connector/pcie-m2-m-connector.yaml    | 121 +++++++++++++++++++++
>  1 file changed, 121 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..2db23e60fdaefabde6f208e4ae0c9dded3a513f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> @@ -0,0 +1,121 @@
...

> +  plas3-gpios:
> +    description: GPIO controlled connection to Power Loss Acknowledge (PLA_S3#)
> +      signal. This signal is used by the M.2 card to notify the host system, the
> +      status of the M.2 card's preparation for power loss.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - vpcie3v3-supply
> +
> +unevaluatedProperties: false

No ref to other yaml, so it should be

additionalProperties: false

> +
> +examples:
> +  # PCI M.2 Key M connector for SSDs with PCIe interface
> +  - |
> +    connector {
> +        compatible = "pcie-m2-m-connector";
> +        vpcie3v3-supply = <&vreg_nvme>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;

Need space line here.

> +                m2_pcie_ep: endpoint {

Needn't label m2_pcie_ep.

Frank

> +                    remote-endpoint = <&pcie6_port0_ep>;
> +                };
> +            };
> +        };
> +    };
>
> --
> 2.48.1
>

