Return-Path: <linux-pci+bounces-36519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CF0B8A983
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016EA1C85CAE
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205AC31DDA4;
	Fri, 19 Sep 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="giLEtmmT"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B55271A71;
	Fri, 19 Sep 2025 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299967; cv=fail; b=SpxWOoog/KwOLoBkal9wdEqjiZohJZNUHi9xPDMZ9sYrZNgg6x/CTTOY4v6+buQYwW1kK14sBnQ/n2uPfeZwd8nHrYAWdPsT+YT/PUaI/YI4jBbxRmsUC+K5Dj+/m/IHcrFwaNwtMVLN0hMThoAkrD/Lol+59LMjYvtvZHSCuHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299967; c=relaxed/simple;
	bh=VIc2ZkX9fm5G2VpepQvybANgrkJ4Y0bEHNCIRpRaY0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uFjL2sOny7uPNVMm0+O2bwEaeeXAeV47NsI31EK0RUWocP64yifIpacNR363GWVUmcL5f6Wc01fHiPQ2yLeOCTk+0nIuWuPEqBjxV1OpSl+TfVuxtvzBxF8VGyVLPP1OeofnpNdoRB5FDYEFwrHRUh/S6UIw4vPb2R+Pde6Quc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=giLEtmmT; arc=fail smtp.client-ip=52.101.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMH1jB4NRGhRt+F/J3d0N8lZ5j5dU+0IbqOXHS/VoeecZ2VC4PeMgBNprbz/CLZ0FKu5NPMdLPdwRYZIdGW333NYaaiv4nSTBgLAVWxfhERVTgumK/cXWcr3gikz8wkfadQY34uj2IyzCip9tZbKKpoNt9LnoSdtLiKnFDo1DBbGlgHV0gEbXTjNYAWEfPPQyziLWbMO2vfJ96MS0lSuGrNx/44GqT25ss1beltXZxC6wPG/T1pENKy7fOrV89vNYb+Lp9dZ9IO3wy+jo/Tdk043VsPrRkosXVYNuFB7lN9lfWog2iSXnfv44jGk2pxtF9n3cng5a7xPETSRlvkwPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2TpT2Np4TzjFKG2Nke9IIZKcGdn+AeFrKolyvqu7fs=;
 b=WuJ0dB6Yof90NLn6NjTUf7+jR8H4MrfzvXDe7urOQnt/Gpi6OnbAFvaXwET/eWdO5vWqzVMvm38byKIjDU34nbm5J3m3+lvmEsgBw7FsGyefPIMf+kCovJgiqsDUhMZ+kOuDmzQzsPM0KhQAetmYRp3xT2ZmZAhCo27K97pfCa5bCtCAllGFI/7arZVe/z9xLOmmpgDIlLJmwpzVRvc7xa3UN8EywPWoYmDuELjuCkxbbICek2cOEe8JOGMVs0yYZqY2ZS8g3HVtYFl83gqC7ay4DBNMel1bneyhUelMz28F4WW33/rvYR1dAt8g5fjubStMY8Sj3HcTg0Ls0Z/1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2TpT2Np4TzjFKG2Nke9IIZKcGdn+AeFrKolyvqu7fs=;
 b=giLEtmmTCvcdPf7ck/INZdnV3wyqXpkK2Izu1pe/V+cFmd4mKLOFsXnJKVcIb2NonksZKVJ48zuZzAMAGgnIxdLVRAKqj3S0gfNmdtQ0FplVDxQebofAA9EpdBJ/nPwT6bXRNWeLTTqTsofxZXIX274iFm7LW1Jx182AjMswvbreG4j5tMo4rQUYn5/6sPQBU/UupqwaZi3dSlUqBfUTG+MNg1oUP7640gpJ5M22y5mb3E6o9CvFaPtYlVrLp8s4dhgil0l+q5bqPwzOniyrl1hUuxqSdQF8btY+A6J/dF2piQgNJaQ/CQCmRC37zVpG0jQtZUeTZGsMkYz8jUd7dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8708.eurprd04.prod.outlook.com (2603:10a6:20b:42b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 16:39:22 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 16:39:22 +0000
Date: Fri, 19 Sep 2025 12:39:12 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	cassel@kernel.org
Subject: Re: [PATCH 1/3 v2] dt-bindings: PCI: s32g: Add NXP PCIe controller
Message-ID: <aM2HMOvksD0kSd1u@lizhi-Precision-Tower-5810>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919155821.95334-2-vincent.guittot@linaro.org>
X-ClientProxiedBy: PH8PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::10) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: ab01b1de-1047-4f09-9069-08ddf79b160d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|19092799006|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tkqMuV3bLQiUW7MRJBlGpNlP1tCtKoZANLepJwhQlqu+qLmDQNdY2KMKIP61?=
 =?us-ascii?Q?VgoM52brgLlZHRaxlQC6owbDFDZxSkW3mQBmH6rXnsbyAFNPX1Wx0fPlRc9S?=
 =?us-ascii?Q?glo3cCnmh86PeOMHQ/xqmPIrT5En7EFKg1gxswH5XXcMrBGYPiro0Sd81r2c?=
 =?us-ascii?Q?RoTTyUpPkus2USkO9pAp5SOaskVYhGvf8oOqMnzE9kdGevht+/m8w9VguFSA?=
 =?us-ascii?Q?L29PisQJZJitttcWxcMIlrcE05y1AXi0xknFJI2ZfnyYFGZNb0AhI8FDKtXJ?=
 =?us-ascii?Q?FXVbyhuYnz/7ylHsCBX4zaXc5s+0Pwe0TP8WpbK4jBPZEXJ+tiDBt9cgaSig?=
 =?us-ascii?Q?VQO2+FWfd9gn9oPQD+ByWXQdmTqKuzAgs3UA6HPaiGlyGaRcXNLTRx7Wf2bD?=
 =?us-ascii?Q?KtRkhIUlRZFa1AJNA1lq75/6oXBHBMtMaplnTyjbHkToRFFifukWGi6nahg6?=
 =?us-ascii?Q?xCSSN4ocAlHCoOM7F20jVRk4CyqGih7hnwTZf+BHEY8cbhTgCSBYJ9+kIbuB?=
 =?us-ascii?Q?xtgmYRBKqSa0eOyfxh/+rDNZ6fvPwGLM7jDFj8YarQIAon/qvZ+zns8c0GCh?=
 =?us-ascii?Q?U2dhRpLo/Azw1bwx7Nfnaz26Ligk1td/wsTJl1c8PlGzFLwGF4MhfQdPZ2wG?=
 =?us-ascii?Q?yPpDrf4ettI5g8RJiaoNQhdNOiPCejpkJ2BC0oVGsTkPP0R9EbPnfoxEtttD?=
 =?us-ascii?Q?469r+jkKE499aNbIGKfHI6ye6PEhuWeMMDrpYN39hGLAJ/z+vU3dsHmWSsxW?=
 =?us-ascii?Q?SzALW6CDqm4uvbu9gGlOJTVUMfKN3Hana5LoDdtdHJl8fsQmahGnr1A9aEn3?=
 =?us-ascii?Q?M2+L9VEpo1C90ha08/Hdfb+DwLGrP06vqxw38lEsLnA9rcj0biFlJEWe9ZYk?=
 =?us-ascii?Q?NrL3K1VfkN/inChb4eDcSJhgh3iF96sOFnQKSRYYpZYybwLeBBz0hTyVI8qF?=
 =?us-ascii?Q?i5gG2IvGE6zMjItKHUlvmoBt6vEkN4wFqrHCtmoOi0fynhdpcsaVQQIVX0pE?=
 =?us-ascii?Q?wHo2/Ng4n1TYWlicNPAq+mIeu9M0L1P6JCBHnu3vKnqhCliAAPjSPht31FEN?=
 =?us-ascii?Q?ZhG3kwi/FoW8Lp1dPRcSJ2N2Jr+Yt54vrfQpoL49rHtXQMOPDeKTzasghc06?=
 =?us-ascii?Q?0w1yo0cKiZEevUcHX+F9uSieqwv5yvoxCvH3IWSl8MRHtsjm1UXhZGGIyntT?=
 =?us-ascii?Q?eD1Kd5Zxt7RVcmxlANgiB5uCvQ3NMeLHy/jbsTC2J9FzUhNZb8vYsb2gufCL?=
 =?us-ascii?Q?xbIN4exzHVhbsPuGy1QYOUIdpj8ct73ICdE6BMkMN3yPIaj+Uoaw/alZI9Ky?=
 =?us-ascii?Q?fSqaXE8EjtIso/kpK4rt9890OVHnATv5v3IhakjrW3ExCHXdw+mwxas+/e15?=
 =?us-ascii?Q?Mo016As8ccIlURSxw0OOPSNEtg9ByNc5q6fMH9SKh2mWm0o5ugRuRpmWX+ob?=
 =?us-ascii?Q?cNt0+eAHZwyt8mIZHY2x0MTc8iE+koRA4bdiU7X/no+1nfbSE/az7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gBnM+G6t0mMgavD4oLzb3ylMbu5FmClMQv/Kj4lRhHWZ7HvTcvaHe1dreeYb?=
 =?us-ascii?Q?0goMuxUCpTtHCTR8rPIyVIeMsOQYrtkL8qa/biojEK3ZAP56YyB1oi4jImhi?=
 =?us-ascii?Q?W5itCWt+VlVAS24E7FswYkEPBoSG7ThH1NnjEgvE50k6TP5/IEKzctiOmSUp?=
 =?us-ascii?Q?BNcmGFqeR6pDTXg5dXgwH2NeJkjwF7a21TNs54uEreaLqCIbnUMjisLwmE3v?=
 =?us-ascii?Q?LVv2825SzjClLODYRGzCgV2wXDiXCZ0T4lq7Z23YJIVgbtgPCuAr9+LJ7X+G?=
 =?us-ascii?Q?J3bwc7ysn405+TCiNveonpgOcBjCPlEQs9Z2kUB+qsSbbiM9TXLxfFApvNtm?=
 =?us-ascii?Q?wOUfOU4wpfaisFvl5B7DVLr1vcI7GxMGj/9iT5JOl628nubUCfOummc++YZM?=
 =?us-ascii?Q?+c/G5H3or0WvAgMDT4PHzWLfkw/5B/P9mUld08sD9FOvtJhwcJ3qRGyIdcK+?=
 =?us-ascii?Q?AHEDeQ0BAp6W9H1jpmlbcKQUGecvynf4GoxJzDWMvk/7PY8wpmJ4BLgJqn9h?=
 =?us-ascii?Q?llA4FZ63cPw/DeXFUH/JGRlxIr2ufNs9PPNkcAezBhNCPbJgGOoyXueVxIKA?=
 =?us-ascii?Q?sOeJsD16WmK4KcgERng2jlelljWiaBdgvTRdBsjF2t2vyyZL3UEI6+h3LKz3?=
 =?us-ascii?Q?xFPBrrquEIsg8Dyr8esUOwSyN+L3TXbnHZU9MATPEmkc9aMmSz464NHEcnrF?=
 =?us-ascii?Q?GJIkBpuHd481Ol7Fs9rftvp061MnZAkJDb5vqJkinrwMWizEgOEi+YNa8qWh?=
 =?us-ascii?Q?RoSZ2DcwSQFpJzIjUsNi6J1Bz28wJHPz7BPYuQo0VhyPmPHTDhR3WXiHs6O5?=
 =?us-ascii?Q?DslB4YaO7irQLfi9sKNRRcpGI2V8TIT4SJZ5ykoh0wechhHtr7iKQs8+sjBd?=
 =?us-ascii?Q?7n4LTQIOve9HSwSldw87HrftPkYbRRypoUNDzo7JcHMYZfTyR0viMYUjVERj?=
 =?us-ascii?Q?z6K9Jfpog2ISVmVQvlhGyzJe41BVU9scndG3AWzpd44sMKuMk7tX99aDDIOB?=
 =?us-ascii?Q?dZ3TvUJh7ld9bHsQ4d7OlM4yxbGIZJXTPtSoFXvz12R/78puw4MVPuNGlnCT?=
 =?us-ascii?Q?9HXQK6D09Le7a+xznYqeDcQ0k5Dm32XU7QaetWuQTv1qu32qZbSeYS6bBNSq?=
 =?us-ascii?Q?GuJPxjCZw+d33XJpgZH0ATf6RKsFbqw3rzLfvjMbYdlckb581YbhGrvELCQ5?=
 =?us-ascii?Q?qA0so6feV4xEWomS54sGOdckQRRJZ7u154Cpqfoe+5AdnExxp+2U/emNRw/L?=
 =?us-ascii?Q?FAq2W0Bp/O5tV0qjlT8IiU5lIRp+nzJ/KmHaiI1k2J5vJYsbWdzaUOdUQVsB?=
 =?us-ascii?Q?q7x9ufETt0JnUyhtjWa1smj6/1vv0uZnT1SBT7pJHDxpeUcuXe/GqL1szFrn?=
 =?us-ascii?Q?wdCF7WMtyokzZEurxByYws87UZ308I2ehQ9i7X7a9y4APT0pLWfHbGxDmbW5?=
 =?us-ascii?Q?oxUUbaZ0XS2SFthWtrBJkcbZr8GqCb55MnRVX7/0qB/zNLQXapzv9m0gAWhE?=
 =?us-ascii?Q?3/MI87iq122lGOKLPRQxHl+9NoQWGspq6xbs6W33HuaBmUMLR81AsPLNnKzi?=
 =?us-ascii?Q?IeRAUtq7Dhk+2ZSZwskG9tbFtwZUwhH0PlxKoo9w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab01b1de-1047-4f09-9069-08ddf79b160d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 16:39:22.0065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cb4kCciLGDUxSQakrLljM1te8xu61S+mgiH0D1I7atIsCf4vOoLT8lycTvmBg37xHCaNlboiN7ULEo6WGq/B6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8708

On Fri, Sep 19, 2025 at 05:58:19PM +0200, Vincent Guittot wrote:
> Describe the PCIe controller available on the S32G platforms.
>
> Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Co-developed-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> Signed-off-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
...
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - ranges
> +  - phys
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
> +  - $ref: /schemas/pci/pci-bus.yaml#

why not snps,dw-pcie.yaml?

Frank
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/phy/phy.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie@40400000 {
> +            compatible = "nxp,s32g3-pcie",
> +                         "nxp,s32g2-pcie";
> +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> +                  /*
> +                   * RC configuration space, 4KB each for cfg0 and cfg1
> +                   * at the end of the outbound memory map
> +                   */
> +                  <0x5f 0xffffe000 0x0 0x00002000>,
> +                  <0x58 0x00000000 0x0 0x40000000>; /* 1GB EP addr space */
> +            reg-names = "dbi", "dbi2", "atu", "dma", "ctrl",
> +                        "config", "addr_space";
> +            dma-coherent;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            device_type = "pci";
> +            ranges =
> +                  /*
> +                   * downstream I/O, 64KB and aligned naturally just
> +                   * before the config space to minimize fragmentation
> +                   */
> +                  <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
> +                  /*
> +                   * non-prefetchable memory, with best case size and
> +                   * alignment
> +                   */
> +                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;
> +
> +            bus-range = <0x0 0xff>;
> +            interrupts =  <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +                          <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +                          <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +                          <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +                          <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> +                          <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> +                          <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> +                          <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "link-req-stat", "dma", "msi",
> +                              "phy-link-down", "phy-link-up", "misc",
> +                              "pcs", "tlp-req-no-comp";
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 0x7>;
> +            interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 0 0 2 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 0 0 3 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 0 0 4 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> +
> +            phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> +        };
> +    };
> --
> 2.43.0
>

