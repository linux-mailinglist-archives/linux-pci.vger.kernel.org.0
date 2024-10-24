Return-Path: <linux-pci+bounces-15228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1DE9AEF1B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 20:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C4A1C2287C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 18:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04981FF5FD;
	Thu, 24 Oct 2024 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RSQlohiX"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DF31F8196;
	Thu, 24 Oct 2024 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792893; cv=fail; b=ACotvhZUyQQIWvNJDnrLyYhR7vfkLideBWm2XvvvS0uwaZbzu0Nc659+kiPHY4CX2I1lPH4INDJf+4uNvtlS6RuViwLYMA6cFGP6go+341XgzPX0PUKX4kS69YMr0CnnZcPPdszwcywPJrRWMeRUwC0FRb8IyruioaatGQRxT9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792893; c=relaxed/simple;
	bh=SDL93SAaesgAKD9tjy/wCDVVfOSkCyYAiSvua+WDgu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XwcT/0tJc7zQuSuO43ELi4M60xR6o8aCjN79Uo25efBgPCcb4gAm+QNh76ui+nRr3fNf86Lx9SGKzlAIUITbp9xQiQ3aHqubF7SIfgm4BlptG9R02qGKM/FspduLF/ZRqXvAzb2nR9rEUde6Mf9uPeB+krwS3prg31K/ln6clVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RSQlohiX; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRqnmvxmjt8OqfHdby6BpQVhmplhGnJZmW6CmjtMJJsLlfOh/PoTuvmN1sLD8c5KXbCurJjwQbqzNrrBZw5HRrbfnaqQNOFkFPezpKiUycG+K0ZJF4QH6CBQeoeVjdVQ+4nUyNOumCgeoz3HGtPIbX05YoPzNM5UMRiEe+h4oH+Ie8a97znCY2okQ+mVR7Hjxtpc9VLXB7p1mqhFHIoMY4+R+Ev2KuUYjyRaF4PCHE0fnLvRaLLHYOKsPeFlAbPsRvkPmvRD08nFB26+G9S9Ucar3t9nBDPF0eAjEg4mxhsjAA4AGqOFCWIQwAksi7EKqsPUHmsfgMBAxNOkR4F0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDL93SAaesgAKD9tjy/wCDVVfOSkCyYAiSvua+WDgu0=;
 b=RWSXV55d06LshUG1FEGIVqbV1SWezGk8TP2Zpt1juuHTFxTNp47k4DjXmTY9BWutIISDFlrzRUoD3zldZNu4Dri8X2aM06Tr8goCwXA8+/1dpNFUTSHqhVUB/ZMgTS6bRygcAfDA9dDc0qJm4yiC4uuVb3wNA9VPc7U1ctjFThs5nW+qtcJ12l+wZIfc/nrte+rsBs8fY1uzstwkO2GRETis9FZksXIpH1pWr3dyxIEWkmcQM3mIwJdMiePCE4nizIjLMVqIaFtvWEIiX4u1YeI5K8SOSFYshV5BBNkhvPoqeX1RrRq2u3OUHnC2O1jPYRhI4dvPrp6n6Ycbozw6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDL93SAaesgAKD9tjy/wCDVVfOSkCyYAiSvua+WDgu0=;
 b=RSQlohiXfRi8DDuZsYkVwtPkh/Z1aPyEIkMX5na4FPqBZCQRXUb0xd1N9NEOAf+MciQptImLJWhdNTcHKUPavXMkckk5TRK2n4q+I/U6Y0NpE/6WYelMSLg/bj1lkusuHUfdHw9tgasrOP2s+eCzFGLSicU3Ibg9plHahDUGkWLcKiOPECnA0KovTkVssMl5LMVctWQxETOneevykFWmGBwOpV14mLGfM4UaA3/EDS+h4KPqr8pFC6GeUBPe8Y5wOGCQwQvhp5DCQKV7Ws4ASGlGp7yqW/k8r6fBXldEomXtkktkXCML7aRXsxJW6Mk9tp79v0u2VmW3WMUZq4V42Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB11069.eurprd04.prod.outlook.com (2603:10a6:800:266::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 18:01:28 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 18:01:28 +0000
Date: Thu, 24 Oct 2024 21:01:25 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	Frank.Li@nxp.com, christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk, bhelgaas@google.com, horms@kernel.org,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alexander.stein@ew.tq-group.com
Subject: Re: [PATCH v5 net-next 09/13] net: enetc: add i.MX95 EMDIO support
Message-ID: <20241024180125.yf26yd6japvn2nfc@skbuf>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-10-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024065328.521518-10-wei.fang@nxp.com>
X-ClientProxiedBy: VI1P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::21) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB11069:EE_
X-MS-Office365-Filtering-Correlation-Id: 76dd3272-d73e-42b7-fec6-08dcf455e22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E07chqFrkUnNAGqMzs0Prmy19+Y6KyfQrFVZaDLUv0yGZ40uSV2QLeXukbxH?=
 =?us-ascii?Q?40CBTUJklmlKF0p4nq9DOEZgW5vKvLc3k7L71VzvQbyiZmrV4jYKXR3bnxpq?=
 =?us-ascii?Q?VjHpF32/lBbcDrxlT7U1a27jiOCch3QnjZlwCasEkqaO5Izw3fLxXeKHJzNm?=
 =?us-ascii?Q?pOgMWycZqy5lYM+imJKGBJNByFqAZZDEHc7wcs+klYarpNkD7/DytPq+amkQ?=
 =?us-ascii?Q?/bEHQ3C2gm6t7D5HI16IYuu3oalc9+l29OQGkk629KFPDmDHqTTukn6vDKGh?=
 =?us-ascii?Q?Zinqcynq5FlYohk5zDR3K52+QQZZmy4B/KOq3olKIG1933elogKnzi7YETDe?=
 =?us-ascii?Q?pWVSvCS+wBTjuRmg2pjG68FMPXuZIRlpOrbC8QA0zQcUE0gmdY+pLJ4oxkkR?=
 =?us-ascii?Q?bGT6vOuZA69MnzPIhA3ijsBQl6HNisBns0jSRutZlNYjvDvsTp/QmcQOQiOv?=
 =?us-ascii?Q?rphZrzAqK8+40goHHCY/wsktymBQZhUQObqbkCx5yAdd25DXUAaoGSmBp4Nz?=
 =?us-ascii?Q?UPah7ieWFhxf/Zz8vkYZ5zqaAEn8STcQZAOVhs5mOfRmiER7nRhWZjQmbPvp?=
 =?us-ascii?Q?bF8avk2ajWrxnTjB4kGRhAJ9ZmXzTXV/E0gYfWadWxUQUXCKXm2PfYOqa80n?=
 =?us-ascii?Q?gVamn6sL1+4xRhJda0rW3YgSnlU0R1SnZ5+9YwnjV51V6NMcdSpakt6EbUBu?=
 =?us-ascii?Q?A1MDh8zoJDA24mLNAIDT9jh44mxZfsC+NlwfWWq+vLi+CyZyp5aBtTpHmseQ?=
 =?us-ascii?Q?PMamhcxrYqVuOvPGbAX0Jr+y1Nn2XvsH/SpyIDmwBZIO85uvE9lThAuW4ezV?=
 =?us-ascii?Q?5KY+PdXoH+TkMW38Fy+dpqiZPBCPqKHEr8aeAujn/rPtik8mIzHiZCaE4Dzg?=
 =?us-ascii?Q?McLAtJwwGLaLTauRG311stoJqPuthxs00L7qUMa+edAvXOcjdRfC6nuCNA5w?=
 =?us-ascii?Q?XVA9JgWfPsgAN7iQ40Eb4KQyVl1eLgcMd+tCOH2+0OMlGk439Xf9saTmesZf?=
 =?us-ascii?Q?YmKNi2jlJUZddIDw/NMNBVDe+DdvB3ni9+rAhK5QyU+t68HjuofAwjBMF2Fc?=
 =?us-ascii?Q?fC+yDBkCm62Ua4EjbW5zNwj1CNPZkAyMvyd8R3shTv6oNfxD4XX8yN2bFu2o?=
 =?us-ascii?Q?OEF8N84lPtN4aqfJ3XFLIKLjLvvK+UhvxNbTLXzwGDd+HzRKR5txQSBn/LCp?=
 =?us-ascii?Q?QGjtMSzTvbhox8qw9d6F05ZFyfMgebMvmSTthkxOcObI7+YCVKVJWglcz11z?=
 =?us-ascii?Q?nEmM1OuokAGefbxOhebw7HtV2qjKdXF7qCodIbuWoMTbanICjg+r841vPQmw?=
 =?us-ascii?Q?6AxlMdeeWBhKedEziFJoRiYu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LtlRg9gyjOBLyW3eT5jC12dh8wgeTiDwHuVG1Utrm9oDpu59JwRmwQ9IlheZ?=
 =?us-ascii?Q?C12uuigvwMnqSMMPokxYURV0u8t1NjTp4FLOyle/O/7rg9/5l11qxkkk7VMj?=
 =?us-ascii?Q?D5I/pJiAPSW6WIfcqcXzrs1vGG3K/1BJ3fk2UYq9z9cTOvfC4z/YNSog60T0?=
 =?us-ascii?Q?0u0JpoOyiaXfI3NYypI6RhH42sCuAnoR0fk6VhXgcWG+UKVX/Z14FtJyPAmD?=
 =?us-ascii?Q?AkR37a6JacU5sVNlXq1Ka74hi6LlrKtpnhkg79sI2HYqft/RoisaYuesnr/X?=
 =?us-ascii?Q?wRE9amzsdpyZFG2yKuiZRE/1QsM/YAETCaFZN28Bc8JfHZQb55EsnRSc1mEj?=
 =?us-ascii?Q?w7MDQR9bba9P15Tv63ZnYgQMBmgsynV8uZ8+0bpv9AXXhmdPAjbcMs+a6y92?=
 =?us-ascii?Q?VH/iNi4ynTqusLVl5xStb1Ed2cCGkdJyt2pTb/0P7CpTVYx6JSbcrLhFg3gI?=
 =?us-ascii?Q?NAckKdfRTLoba5RGFXPznohcPZ8pCz3G7bqrQmqf7CaVHGI1711zkvFrvmrh?=
 =?us-ascii?Q?yfIX+b0hiVhZO3BA1vYGU5CqMspukcKpL8SwUhGakjLDt601VT2KttA8/qJ1?=
 =?us-ascii?Q?4gyKb+93DGMVl2w8iPIkjyuCmqUacu6miJBMMiqjeHRk/q8I1TtEJSC0jE1n?=
 =?us-ascii?Q?p46Bk/VrfcsowSvz81SEsYbk0o9xnmxvPNNq6plsnOHI2I8YiFWdvmtYdDP+?=
 =?us-ascii?Q?t0O4yRIfo3hyfW738BPtMHD1eFCLWlopSsQVRWc3a1wA+uXf0UE1GwKCL9Pa?=
 =?us-ascii?Q?q/baXpHwCq+gg3QXP04DukbDkEIjN26vvbnCJAEddSOD/ncttmiV92kE4cLf?=
 =?us-ascii?Q?GcKJI1/LxfaZjyj3yIoNeUG1flxfxQpnT3OzJnZqcrdBismkfk//WqQuDANP?=
 =?us-ascii?Q?zp78E4F5hJ2PguTj2yChaUBUC/WYNFwaUCv245WKYwaCIMvHD0MCT7NYcDw+?=
 =?us-ascii?Q?Mt6gItfRlLzSSqBRY2+Q04t5crs+RDJ7sPCxECAAPdDx/piX2z0JecGZwoGg?=
 =?us-ascii?Q?zaohjc0KoCK9d10/aVZNvEVNVxU3NlZxVH9kVVifUU0Vnk+oBqjzH0Kb5BfF?=
 =?us-ascii?Q?DiXSSPSBrPM5maX0WN8x8Kiwb4N9UOKucuklTcUFBYUQNhnKTldPt+ivuyTY?=
 =?us-ascii?Q?q81fT7TBSRlQ26nH/kmT08kaogDS0XNi9hPJBcMRiL0/UJg+sX6DI66VdH0E?=
 =?us-ascii?Q?5RFTQWIOPHygbzI81BK6NXqOr7UEL3ZW2jbooqDqF9werlFR6VHCvq+Dh9e6?=
 =?us-ascii?Q?a1V6ByLpz2YDQuC5kFMkQLq2WO/yXa3bxFOBKRV+SkDITapgLT3Tx9dvsjr0?=
 =?us-ascii?Q?gZK75PQJSYSNZxDj2f1SBNJSqS8a3Dv1uulwQYb9un3acyN7FJEEVGHSXmm9?=
 =?us-ascii?Q?4ndzL2Y4n3jVKKCvakXm9g8cqTU/H9Ro/OqMe3g3h6zrJ4M7z4EEEn1CQWQ0?=
 =?us-ascii?Q?DLV5mxTpWtnFpr4rN8Fu2XkwVA/lpWx1uubwEE6RYys1Vz+tg5oiH7MKhmMI?=
 =?us-ascii?Q?OWZtXke1XCXK15s5li47oncxvDkiKdUIMAzyE544g1aX4B6N+YOyyzCiDdvK?=
 =?us-ascii?Q?O3sGpAtIvfbJ8B0Ktkj0SFq6ibPn90nP2wCNtz26lM59YUMx6I3Ji9XPTjBs?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dd3272-d73e-42b7-fec6-08dcf455e22f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 18:01:28.5082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kd6vkQW3fUfr0c6BJRIDlMEjtn1moL2PThHeCBOOlKCQvlzWmCDHHfuPjh3TJ32O1a5Nh3XiBQ/0b9EqVQ5A/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11069

On Thu, Oct 24, 2024 at 02:53:24PM +0800, Wei Fang wrote:
> The verdor ID and device ID of i.MX95 EMDIO are different from LS1028A

Also: s/verdor/vendor/

