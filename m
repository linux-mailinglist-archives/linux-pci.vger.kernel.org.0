Return-Path: <linux-pci+bounces-13524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DA9986525
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 18:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE86E1F21824
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760C2208D1;
	Wed, 25 Sep 2024 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bcQBIaBZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B317547;
	Wed, 25 Sep 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282809; cv=fail; b=UvG1x3lveV15v8hj2vEUbAmk9LSYggTujBiDr6iuT4DgzEIqp5tPsbsPIt2bxrNJowqvPsHXWO22H8g6++Y5Scu0zUIknge6lNDkib0eya7YrgY5ukL4V7ONJ0Kj94AYNCeH/BjSKtvEZ044e/nDg85sCpxRPm65Vs4EqLZJaeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282809; c=relaxed/simple;
	bh=2j1giGOJlUe+Nh5GgoUpgE7d6xCjYkzY9e6esUevh10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oL8YLnCCCNJ8MLHEbbwJF8BHs5xUx1GY2WiEDlMXvzFYt990kOS/IvSaZltR5DnaGgh68SnAvbZodgMeESbrQYjkR7fBCeruNekFGmW2X4eWndWFbFJH5g6PmmjiJJqTdX7Cnh/hUiTNZvaBm5dRn6YRBqflRnv/BzF57WXXRUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bcQBIaBZ; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWEz5d2Ocg/iWZohkC1NLwvcNK1N1zzb1v7yeEhcGPIkpmSkMyOQiJJ+ObRIsrWjdcgSkH9XatKSzuwohH87O6P0SQanMpEO4/63PNKUI9WnMHIDEFXdOEwsyq026PdSp7dJobIysYHs1NmALEOCS2fec5sipjOTKbZ/i3Py3jJbYZ8KYte9yEi0yfGchmbpwvk0kQbw4hW+rO5uoDD6z7JXT8pESEvbrlNIQgao9m3R6mKj8gp2CxDHqm+iCP9AGSHqYR6+DpCehu0ToNXgGb8Rid+j/V2MerOGqPwbwzb8/4RjnO9s60leGdAhKIvTKslljKQndI4pfjcti1GIRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BH7644NgvY3KtMSGbuGDfaAj/YHW/WvvIK/K8lfNjKM=;
 b=oA/WAlRKFY1O5Qt6DratmUeRNAB3PzrdfECKPhGxV32LUL3+lJR7HJ21OhqyF/uxmzOq8dHpzTKyKvgPzcPscwZwcNbyrjmE4ivQIqWSXBjLO7SY9XPHLvN9KJhs/B1oRB6Rr+TX01Fy3fMBYTFY+2gQdsn4+A++TDLGOm6CD7Vy5T2tM3GrSMfMdEbIy/qOuMTXQZjzmO7ElVuH+bghQxq9iHHShgJ8RVozgwMLko2wW+Qr8tjZCa/sKQBDzNDc2ejKAi49mf3oguHTsN/WM7rd3Q95pZsQxdVmNgUVmvjyEFYUhs3DqJSlDkXQ0+g0CAdMnnZD5QyGjYSMgWsBGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH7644NgvY3KtMSGbuGDfaAj/YHW/WvvIK/K8lfNjKM=;
 b=bcQBIaBZK5AlCCIKnuTxaalPhNsV7/bx6StL5F6kkVQpqP0SNJ8lXHu25b/QBebfmcapUiOoCVdNoAUXVw2/zl4yCTLgIukwe3cPmW6AzYwWrBCDje+BQ9sGe45zvrb0T2x5aeM0lzlHKJvprTN3YiyRECjUteChzbKJBsoTaBMcRDBeMgw0QyJ3WnFbNsMswH8Wt/CdYgbTJTDStst80aHM+UKDXlerc9l3Qfqk/f4lntsbh9b/F4NRkdT8vqNM+2HL76/X1xszkod139nwB+zZTGSssVrEt1DiIvRccRnkPBbta1VoCA9dBFlVEfrsUxdWKWxfZ1lBskp6cNnjPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB11081.eurprd04.prod.outlook.com (2603:10a6:102:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 16:46:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 16:46:35 +0000
Date: Wed, 25 Sep 2024 12:46:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	kwilczynski@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
	robh+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
	s.hauer@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95
 PCIe
Message-ID: <ZvQ+YGqqwAUW+FaD@lizhi-Precision-Tower-5810>
References: <1727245477-15961-1-git-send-email-hongxing.zhu@nxp.com>
 <1727245477-15961-2-git-send-email-hongxing.zhu@nxp.com>
 <vtrxj3r4wy6htxyl44rzjyao4zso6z2idexkvxrh3cg4wazcdc@gffmfu22jiyh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vtrxj3r4wy6htxyl44rzjyao4zso6z2idexkvxrh3cg4wazcdc@gffmfu22jiyh>
X-ClientProxiedBy: SJ0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB11081:EE_
X-MS-Office365-Filtering-Correlation-Id: 9760a79a-f51c-4d86-ac3d-08dcdd819df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?avej8Wd52iPdRpz3wBIfebQJG1rYzqNNp+hnbvPlCAN5cXclbVYL5dmrdz1L?=
 =?us-ascii?Q?M4dLT+ntH5o8lcUblctsdNxU9lxDzKAp1JeGXri0kaSVlxqlwV6OsAOEk+wD?=
 =?us-ascii?Q?/NzxkQyaTt250rfbBWH+BBjc09qC1aaB5CAp0qkvPvTvruHic9kgGqYGTQrU?=
 =?us-ascii?Q?arMW8s+fvWOWG0a6Ek3Iy+VHEfBhKJMSo/uZVXDPa0nk9NHPuFq2nE50t4Kr?=
 =?us-ascii?Q?w3Kc/AFN+MJU+fovrlUgJIzsX5dKSD7c9oFKtRE9Q+ZhxoN6e2RTc0zDTAa3?=
 =?us-ascii?Q?t4D5INra7JeZGI1UaKqATh2qTapwjq2G5bXaQ71t48LPpwGpUVi6UqkQSnLf?=
 =?us-ascii?Q?xqwZkVoKHGGs2GGipoGRpS8MIhXWXX+AgauwkOmYlteZKNTFLgA63l1HjaWa?=
 =?us-ascii?Q?6+zBfgYOfb17qSZkFWqMSwU3bKyaWNH/YRaBB0+ywTavWxx/t34I+kMyHb1n?=
 =?us-ascii?Q?EY9xvKHjy9LvrtGUilt0z0HGqY82hR9XdibULTjGLQTEa54azGkfXvY97NuN?=
 =?us-ascii?Q?a9Fms9IZP/sU5IGh38t/Hp21R36u5O+yNhh6jf1EtUWfI4dZHbhVjKWA/6pq?=
 =?us-ascii?Q?GVHjJQAC8TlwP3/Ira78nXz57zcgGKrwz0nYzR6k601KJD+k8/kMVYVQLVO+?=
 =?us-ascii?Q?5lRY8rMV58hZVj2+oTfUFHjQOo+XFgS+Q5nkez3LaW5jtCZmevAfdjo1ztZW?=
 =?us-ascii?Q?7yDqReR9Kp8vBy29GLetLVtb1lO7Vflw2mAoWAgUs05vKSxEFIUOET/l0+ue?=
 =?us-ascii?Q?rDjMOxxDtiACbQssWtF3Id4OFI4/lNvuPDBUJjek1Ku/7CkK+utbEfpnrAO6?=
 =?us-ascii?Q?RZTiPqK5fDrUwQ0DEMnG1AhDkOeuOOoufXrawqyzx/FeypDX3HTeWRkA2vIK?=
 =?us-ascii?Q?rOAcvMhx9lhitTG6mcFemktkCYHgtsDNgufS+YqyaN44QgWC2yibpERuCnTg?=
 =?us-ascii?Q?P0de0IvX8pjQRAYakZsz+3oSJGusWKjtEJwHRwH5RfSgR/N7Z+q95lZ3qdp9?=
 =?us-ascii?Q?BKNCvSleY1lWHegwl7KcbYOoP15iM8dsOk9AooDxopES8LOxZ3bJvP558Spn?=
 =?us-ascii?Q?ghyjQFpMi0aAyr5RUvLTI0OU7yqHwxTLoIwHefFx23ROWOjEw4a2wUvS+Y95?=
 =?us-ascii?Q?5TUSZ/zt2u2bUyJWuaiCQlrmcaBrzg2uYdWj7jEi1u2/FzBwwlSP0wCPFeg/?=
 =?us-ascii?Q?iXSuEAkWPfzvNyO7bBausZo6PbGEb4Xahc/nVChGSRtVVw4gSYZgBBwnlF7y?=
 =?us-ascii?Q?/2gSw9CNXGeMryyNLMemKz8IM/rw9afx6RO0fIDCrQzVK+gkLpAZmurWuQKV?=
 =?us-ascii?Q?ifsJ6oh2ozxroS4iFsYp3rKksS3RtCy2QlGrG4QeRyO+nw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jC3tBwa/vSdPgpxuLuhkQeeMj/CRh+b0VrnsGibbmQNGsgof9wCtkqLSc+9H?=
 =?us-ascii?Q?x2yH1p7QD9RfvfjhoAqc4jfg1aOxIX3qV7nmpcPXbH3YM4z8ewlbvifpH3Th?=
 =?us-ascii?Q?kUKXkAJarzkAsNXdA0eHy3m+0Id80aH5k+dYTNR8+OO7SFkBt4uL4bOcTkvK?=
 =?us-ascii?Q?YLmk9/t4KzYXYfAG6sOpoRD4+pg5T2ZpAWhr3igOZPa/eg6PvXYDRT7uQvoY?=
 =?us-ascii?Q?g31BTtIqMNxcipwfcVCZq2wAOk/KgVXvyt0yyz+iMAcYLh6z5FYZXq5RymNq?=
 =?us-ascii?Q?xOB4ZFT20eE6Tp+kaVoQqUf4nMmx9w6QbR687QXQQbLidMuSlDU1q/57F62r?=
 =?us-ascii?Q?t3F1PvK2Nla1fRgyRHWngN+qAsgEHYQiPmxmYZsq2f1tAtwNh0L47a11bkn9?=
 =?us-ascii?Q?o9z4R46ZMzuJzxhdw4ZvWeZm3VbjWdBnc+wKQJnZhMLfHoXRMcYBgOxQfhT2?=
 =?us-ascii?Q?4A2YsFRF/Ylr6Bsg1ApNSTzqYUqxXPLBWnV3n9SROpIbhlua+uqbuIaXMVm9?=
 =?us-ascii?Q?9RID/p17cVIXMsiLrBMyn19gqtRw76BtaajeyyxL9rAONPSceAEE084AWpEN?=
 =?us-ascii?Q?kYABoJrc4sEiM7hRHVEItN/9iIU4u0b3bRh5YHbnQFm0i99CrldtZq2nY/Y6?=
 =?us-ascii?Q?VC1PZEPsG5Dz3q+I2/s2lPo0N+6svUP3XN+r9HIZ4d/4y05cEJ8NN7f+P5jS?=
 =?us-ascii?Q?ssdrVBV1/mXLIF/ulSXJ2K3WWDZr2wDCEotDMNwA7VFIP4kOj2nugtxbFkRr?=
 =?us-ascii?Q?iGAU7L0UtftzN8HXEg+x+JFsIpveiqnz74Fe1OP15a4feLaKVL/RwIbYMD5F?=
 =?us-ascii?Q?xs1aL7IwEtGkPWWrhPdmQ392wbuvGU+1NTAreSBfBQrzkEucHkVb6GAYA097?=
 =?us-ascii?Q?5Od84Xm8q5/pH+2lWfNCa+MoPtl2K/SGORKgpepTdx9brPRAtFhNYL9Gcd8g?=
 =?us-ascii?Q?eALj0KHZNMHjsJRWfUbSBI3zuLKODuU+uSs3mQu4g1yJ0c2r5PHumQm47Rq6?=
 =?us-ascii?Q?cPRuGCTn7Lv8NAQ6E+kwdhYLiBjrFMIMQoum21DXOu1f7rnhxLE4nQHm/pmM?=
 =?us-ascii?Q?56/5JeYqPJCyDmYxbpVPWt7Ic1lmktFqUZkRvUt4l4UR47hVJe7fKbbLtqW2?=
 =?us-ascii?Q?/nTZaM8GLfyEuxITAqgQO0Irld4+q8c3cwyxHep/IMZg7kBn24bYyLr/7bYS?=
 =?us-ascii?Q?USyroJZMrP3rnlR/M62WX66C5SGQ0Y5iUx2/3I9ZxWQ3mIffFYJYF9cBFVZN?=
 =?us-ascii?Q?zOQ44caAq9ZVIe+4+DqVWFEg/SmY1XIXmXSimSK8soVWrT8EC+Z3QfkoJbmo?=
 =?us-ascii?Q?IBxseDuI0M/VlJFAqri39D/cvMDMMOsRgbF8jJpTszgcrpGNs6SCxYC2Hnd3?=
 =?us-ascii?Q?WeWECfptI5ZcUeckPX78HX83nEg8OevGfzGc0Y7wtzxMPR8OZoLa8immU6De?=
 =?us-ascii?Q?A00TXZnjPDOSZC8hjPu+izmQD8qXQ7DmSZrNLzShGAq/+TJIA6gPpqdL1Em3?=
 =?us-ascii?Q?VpLS6KdrMbMSovsiSizuYrotPFLub7QY0piIr4yPEfeFX6kOV+LTDYfjSc0T?=
 =?us-ascii?Q?sqIEvoGAv1SJzakCK/FM5ltrC4/LSNqxiaE5Wr3R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9760a79a-f51c-4d86-ac3d-08dcdd819df4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 16:46:35.3005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAhHr2B4cwTtRvctRvfETerUrPbP4jvqPo0obhRVXXv8uZTFdKgo2Uns0v6bXtP/uZkp8MtZbvgE7NvUqHWXfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11081

On Wed, Sep 25, 2024 at 09:50:06AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Sep 25, 2024 at 02:24:29PM +0800, Richard Zhu wrote:
> > Previous reference clock of i.MX95 is on when system boot to kernel. But
> > boot firmware change the behavor, it is off when boot. So it needs be turn
> > on when it is used. Also it needs be turn off/on when suspend and resume.
>
> That's an old platform... How come that you changed bootloader just now?
> Like 7 or 8 years after?

It is new platform, which just publish in this year. Old platform reference
clock was controlled in PCI module, so needn't export to DT. So we have
not realized it when start i.MX95 work.

>
> For the future: you should document all clock inputs, not only ones
> needed for given bootloader...

Understand.

>
> >
> > Add one ref clock for i.MX95 PCIe. Increase clocks' maxItems to 5 and keep
> > the same restriction with other compatible string.
>
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about  if you added new
> patches to the patchset.
> </form letter>
>
> and I was wondering why I cannot find this and previous thread in my
> inbox... So please stop developing on two year old kernels (and before
> you say "I do not", well, then fix way how you use tools).
>
>
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  4 +--
> >  .../bindings/pci/fsl,imx6q-pcie.yaml          | 25 ++++++++++++++++---
> >  2 files changed, 23 insertions(+), 6 deletions(-)
> >
>
> You missed to update ep binding.

So far, EP don't need reference clock. PCIe standard require host provide
100MHz reference clock to EP side. But EP side can choose use itself's
clock or reference clock from PCIe bus. Currently i.MX95 only support clock
from internal PLL when work as EP mode.

Frank

>
> Best regards,
> Krzysztof
>

