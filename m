Return-Path: <linux-pci+bounces-22909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A44A4EEFE
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 22:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE9C7A3A27
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 21:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24341FBEB4;
	Tue,  4 Mar 2025 21:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fo8li3UT"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C1A1F7076;
	Tue,  4 Mar 2025 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122149; cv=fail; b=M5DNokjbevYaMIN/GHm1hq/CILBHM0uUg54StZDgmuqRoq4YsNnVPLi2zpWwFGz3btNuyXkEXe+keiq2HXxHyEA2z8uAIxCcZG1QEBWbCEwdALXmTMxs57jansWPDsCmPeKNLiJZasJw7bOBcph7CVoMFJZK9UpONr3feUqKJT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122149; c=relaxed/simple;
	bh=Xb4VRbdcGudHrkfbEbzo6fkxUvJh0UNTOXYAk64YdRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C+nujkQ1k4VtCMlwbFBpDoe/KSd0mKW+WhSIJvxKfATKV81aDXSZTcFGXdOEL7iyHbX6/+xYRkEEGDRVYbe1v+sIzLrng4ZyiRqvkD3c2xunHFTGyRupb7TB0oMHOB/AjindC2olTZgM1qkpntyJIq3CamdrAvun/PpeEZvofpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fo8li3UT; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvTXZTTdgT4jEQYTEisbwfrRPVUvKf5SCg8KCps1Xy/KvvwYvl4gBwz3BrOaAXhwvhFbNJqXhr+tXgxZDF/6CZXGvidDHCfKu2yqC99sHJpYoDIxD+Hvwa92fESX28KUp+6ytwOeyPD567UoQSyZmY+UOtq8NhQEX1TIFoao+08WmZFClISVgi9knQ/l39U0J48UWtPftZNeKlohbc/7EVJpxUjYft8W+i6Eq+NrqPNgDOL9TrygRBygGcWwgUAygNrZzCrxujPA0nqOizQ8RNxpFaUHMwIODqjc4RobgULMsp7KPO8/xZAmWGFmtJRf0kHZ3xPDUJ2KGpSYcKE2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAXKOXwSQvIIpErMAIiWvMJkaIRZ6Jv7zVS4pIREqQ8=;
 b=BIdvL866sTMNA9aZd4nZt4CpCgSSxNttRXC+YpO/wp8v/x3tEEv2D1K/W5rEIiOPF0VJdg73W8oxhlJRTJa1LoZ1VCUJ9rQSCUcFv6i6TbotU9wB9E2TgGtP0z1OMckB/8/rG/j79xzcQvez398qAofovlNcWGFgVJey1hJg488L5f2uizw/OPyUUhP6VlJV3Nuq//16rxsxfQkFSvFt6cOLsXlbH5OvFATuLrOxH8uc2xFLlUHh5ZyCzhbnzqml01dX4ziKuYZ6YdjH6GyNb1SW+saIFMXj3Zj2BuJnXJ82UklXmX0DeBmKqjNfyr5OSOan6jfo63qahAsoFSE2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAXKOXwSQvIIpErMAIiWvMJkaIRZ6Jv7zVS4pIREqQ8=;
 b=Fo8li3UTCRkE+qPKiMp5t1N6waExrWp8m1vRqLPbtFlXEMqYQIeLFkOKFZR1op96LHR073ljwzMASBs5phM0M5aqqut44hps8x4xOgfsF8Ih23IiyGZpTuCqRzJnOZax2j2BDf0pCgWlcd8B9kd7gFcKRQB+8FwH+hSiBXhE3iYILPcDcvK/cY310WSIbn8afALs2ODdiDAq4MipsKdETwUkPwz34eCNhOWXDufiU7xeTvCzT9fwbaBTD0K8diLX1mHviEFJaA8a8dYaoBgXGgngvYpCj/Fq7XubzCk+0HzsaKiG1f+YO33uiPBy49Vdh2arr6V59fTFE8iw4OBINw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB11058.eurprd04.prod.outlook.com (2603:10a6:102:489::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 21:02:24 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 21:02:24 +0000
Date: Tue, 4 Mar 2025 16:02:11 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@axis.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC NOT TESTED 2/2] PCI: artpec6: Use
 use_parent_dt_ranges and clean up artpec6_pcie_cpu_addr_fixup()
Message-ID: <Z8dqU4BGa2aZ2L81@lizhi-Precision-Tower-5810>
References: <Z8dem5gBf3xLxSIT@lizhi-Precision-Tower-5810>
 <20250304203146.GA256660@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304203146.GA256660@bhelgaas>
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB11058:EE_
X-MS-Office365-Filtering-Correlation-Id: 12194072-97b2-4d3a-2f04-08dd5b5fdd02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G00EhQDu+I+NzJitLHPsMtz5O0r/LcJZUY01dcp1WSkd5Du3ntnCsmugltFW?=
 =?us-ascii?Q?dybmub5p37Rb/P78+78feyHd3wBeMTr0poTZHFqjOwhWXry8A8MHRJl9hmnE?=
 =?us-ascii?Q?y8OXDJ/yNevnQ71iYJzpwYmvKRHiEB6IJls4ClRJdGYvJrNMPBQa3SidBWgg?=
 =?us-ascii?Q?bigBpSfBV3Zm3fybipPERksDMhvA6FNV9kzJvQMqOsAOBrffozxSy6oD1jac?=
 =?us-ascii?Q?Pumf0y+AlbzpKOW9f1m4KiEFaU1vhGnG50VySVr5mrUKU+3CcCYHFajRI5Dc?=
 =?us-ascii?Q?TmKt/PzSrZbzl7e8bS/V4ysl3vT9Thr3cegcrkID4R6aPkvgraQL6CaCEn8T?=
 =?us-ascii?Q?InKPwaFEuuNf+zx6R2pBohqEjV4uTu0jRfXnIa4xXiCBIaSBXNq5pIAiP2OW?=
 =?us-ascii?Q?4n1uxx14EeW56batqi9BaX1QiexiwXrGNwPg8vJd30jUybJPkXwM2vexqwsN?=
 =?us-ascii?Q?nRUIN2otcfrGD8Uk/P/fcmlsCtt2p1QO5S6zFnvjQOgbJCqKVnMsTVxe0F+d?=
 =?us-ascii?Q?OjDVByYx3VVHl1Er/9FVkS2JK2TtXxpA+Ypw3tbHV5EjHZxoZGZIU04Hvmlq?=
 =?us-ascii?Q?w5j91H09ysnvrW3gXG2CIlZaxLCjXUQntZogvtfKGwSXdj5JI6J09Z4gqTEX?=
 =?us-ascii?Q?NMWrVuA1N4ivWbXvset2difa/rhKoMm8Z5/S5TH2cYEDTVyvqN5NWrnyL1C/?=
 =?us-ascii?Q?7pus17vRyqwlvZZQaetJfWpTCCOgCxt/nvKdhdAoaHfnK2soEnByPtig/yNN?=
 =?us-ascii?Q?MFdk3TFA0VjHohJXP8ac3X6syzEh6RRSc/ezMp1YXN8xYM6KBu0MR5EtXcTc?=
 =?us-ascii?Q?7AGgZwKz0QwKH2zIn5FQdjgY5s3KAFCOK9/jgqdbvcOqtm10RJpWVMqghHB2?=
 =?us-ascii?Q?BXU2ze1c/u8gY93pX/cn+oBytNH2CH4Qc8UxtBa/qtWUkh7v1aJK4MQnc7XQ?=
 =?us-ascii?Q?4is9Qq5hpjEq8C+nJ7yfKqjzY8N05roBWt7AHL5fM++mn8OJ7ldD4Mni40lM?=
 =?us-ascii?Q?+pfYECDqhzthBzP8XWjO7M54zJBXtzsVs7n/4Z+bc7G/iL72mXkPUelxnHYV?=
 =?us-ascii?Q?2jMlZ/ra1ruJHH4hh1XXmP02ZNDHg4qvF7STs8Z99aohg2Gon8BQj4qOf1NJ?=
 =?us-ascii?Q?AOxWbwvlKLqgERNR6RjbymLp+k1Z+VxS1XBTddDd/qbQMmFAXqTB7c2LCSGL?=
 =?us-ascii?Q?4JktAIMlEGvYAMQvQeCG8DiONcQlvoBM2AcZUfsAkzt59ZcLU2+yDHuu9q4H?=
 =?us-ascii?Q?Z+Fv9s2/q5Q57x+5JMHIbHKh+y3QX/DW3nlopsMY3QzK7n8szb2QAfRG1lzC?=
 =?us-ascii?Q?u6M31njPNuZrBQ2NrqH+cUMCFq47r03ssCi6jFdJFXcBLP2p4kBRBeVJEAnu?=
 =?us-ascii?Q?Fx8B7UhygP+Z4Ly7Mir4tgjiXY3kU4qOzRegIMcsgVk74jpj7Xf3cKJP2GCf?=
 =?us-ascii?Q?zhioebJnBomvPxklRmbygYqug2yrg4bK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rncbthbdx45BoMNz7bqOv4FpvTJS11Q4yKSQadKUraWEcuU3CUGt8XDVltKe?=
 =?us-ascii?Q?A7p0erpoTt65EfrzPmfikFmgaR6Nb+Rim5KoU9zS8/iP1BQOCRDhKkAs4zEA?=
 =?us-ascii?Q?M+evHrSyhRsqCatnE5/QdMEnN4zkc9u7O+hebPWY/4Ui6BXBJg8D+fyqVMXL?=
 =?us-ascii?Q?Px7ZoDGWyVZFT0ewfle59SgMZVPXcoDz7uEWNNUpXzPaZtqeqo0fFbLGj7cu?=
 =?us-ascii?Q?r0S1KicLu8vYUT07TlhpNnxJ2JEZ1MvRL+qfK3YYZBLmg2zNIiQOYU6CD2v5?=
 =?us-ascii?Q?Aa3+603WOcKmw88tlOSS4u3s+Nj20PW4+8ZH9ERRIrYekOhVls36qrkl+cUA?=
 =?us-ascii?Q?13qck7sWLWRNfYSg5SqPuaRPd74s5xYQJ0zR8kGCJtYZ+Xs/YcfVww/9E0y1?=
 =?us-ascii?Q?OID6SkYUXd1TnKenH9MM2qfDDQasfTCYRGL2RSsWy7qPuAZsq9SG+8rg7HP9?=
 =?us-ascii?Q?rF0B5W1HMWAYf56+2G9QvHYIvHElAA6eW/A/Kk/4BCUfDgL+Fw5bhIg4TF04?=
 =?us-ascii?Q?Ra15p4ksfatUWxrGm13RFnbkf/4hw+xqvR+WwkmOQQr76w3cnqIIbzVAvX65?=
 =?us-ascii?Q?9lrB8DJCFlz82cunk9VpDqu5iDHfFxvOMl7hh1ImhLcK77cZ8mwJZWSG9Sbg?=
 =?us-ascii?Q?8iMz/wUgrG2hXy4dqOFsARvBSR3ygVlsu2ZqF1js82nLpEu2ktlUYxVm7etK?=
 =?us-ascii?Q?OJeW2nG3Pn1fkS/6uR70v4XJpTzoovZ9dojhE5l1G+waYT9n9qxEhRaIy2QJ?=
 =?us-ascii?Q?wUDmDbmg4LZ+fyBVr276DA02LMdazJTLA0kPdY5dWNK0BEwZ3jgxa9iuIgOq?=
 =?us-ascii?Q?EYioZUbj8rCraISEBfxiiDKnyiCodmzzQyieO36Ynidpzn3mCGbDNg5Pw90C?=
 =?us-ascii?Q?OZR930Z8ybc+IVGXeXeV3f1LeI1CPuV8vnexAqpY5VCnMX36cEKIDnpx+fFd?=
 =?us-ascii?Q?Iln7tgX8gyE7fBVoI70RnVZ+xI5keBSB4eh3rDwzfPLGQh2arUv9igb9AUkL?=
 =?us-ascii?Q?tPL3rVLb9sXij3xHQeEAKkTrlfK/C5p/tsjL76s2kbzlRjWwc8eunoJqg01v?=
 =?us-ascii?Q?uqYc9iCTxMqBDLQRZVLU6vOyvNqH29NYntLZbE4z7+gzw+1zITqIMbH9PMA6?=
 =?us-ascii?Q?XOLyeb2xQFTfJ6JPt7NQpaO8mhclkxV8uiaqlyHHMAOqN/Oxo0CIFgCJ7TFF?=
 =?us-ascii?Q?X55OyjK/eoxvbhfhw/xx/bSb+fTDMI+/Iy+oS7jDlq4V/l7cAcAS765K0KlW?=
 =?us-ascii?Q?2ZZ7XoGYDXADG5EQ+vUBBACEOvVDM6BJ4ikDVDmb6AlXpWviq4zpecoazBnq?=
 =?us-ascii?Q?txE8OI8psxH59arW/CWeSRhKjIg/D2cztcodR+B1SkiJWBYGHcdaeTZwWW8u?=
 =?us-ascii?Q?mnkam9ZASF4z4AP5ILcXTxLlZ2cT34gbqND/z6mMaYP7p5J5xgCxft6l2Ru0?=
 =?us-ascii?Q?nk/pg8nAhBzWttFTiHxfwfXOx5nyEfEdjF5zIj1OLSH8itFfBF/gl5kxgsHG?=
 =?us-ascii?Q?H7v1o+V2xAMzRYzE/hnA6V9dDnVwcCLldmKYrqmhMzOvndvo16LoWg9WbYNd?=
 =?us-ascii?Q?6pXS5kkmxh3ftL6+0OL8mZjt9Ya+rgIEnea2Pj1d?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12194072-97b2-4d3a-2f04-08dd5b5fdd02
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 21:02:24.5659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQ1Pds50mGLNfi24/hd7x/ZPwr2wAh8rhbxeV9zbWtUd8GbOsemA+ANwu95MFhvEMMLtBqUPJWg+/89xPDzrwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11058

On Tue, Mar 04, 2025 at 02:31:46PM -0600, Bjorn Helgaas wrote:
> On Tue, Mar 04, 2025 at 03:12:11PM -0500, Frank Li wrote:
> > On Tue, Mar 04, 2025 at 01:08:16PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Mar 04, 2025 at 12:49:36PM -0500, Frank Li wrote:
> > > > Remove artpec6_pcie_cpu_addr_fixup() as the DT bus fabric should provide correct
> > > > address translation. Set use_parent_dt_ranges to allow the DWC core driver to
> > > > fetch address translation from the device tree.
> > >
> > > Shouldn't we be able to detect platforms where DT doesn't describe the
> > > translation correctly?  E.g., by running .cpu_addr_fixup() on a
> > > res.start value and comparing the result to the parent_bus_addr()?
> > > Then we could complain about it if they don't match.
> >
> > Can't detect because:
> >
> > There are case, driver have not provide .cpu_addr_fixup, but dts still be
> > wrong. such as
> >
> > bus@10000000
> > {
> > 	ranges = <0xdeaddead 0x1000000 size>;
> > 	pci@90000000 {
> >
> > 		reg = <...>, <0xdeaddead>;
> > 		reg-names = <...>, <config>;
> > 	}
> >
> > };
> >
> > above dts can work with current driver, but parent bus address 0xdeaddead
> > is totally fake address. We can't detect this case because no
> > .cpu_addr_fixup() at all.
>
> If there's no .cpu_addr_fixup(), primary-side ATU addresses must be
> identical to CPU addresses.  If the DT parent bus address is
> different, can't we assume the DT is broken?

I think so.

Frank

