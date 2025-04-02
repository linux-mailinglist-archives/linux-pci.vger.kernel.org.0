Return-Path: <linux-pci+bounces-25197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A87A7962F
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 22:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA171670FE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 20:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469BA78C91;
	Wed,  2 Apr 2025 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mhSQma+q"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012028.outbound.protection.outlook.com [52.101.71.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FF86AA7
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743624087; cv=fail; b=YU/6PWknZfmcVlCFZEFn8uejWnw3OyTckaFqU1faQSFNwW2ans4hmVaOJp6u68D2O/d+ZCUGFL0kgap+MW9Q/rEuwvPO8F/IPsWJvedvICDy4WhOySZCSGRgoTEWVMYyC8fAGqhkq7v7dGKiv3W1pqsXvPb6KS9NIlcvRStEGYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743624087; c=relaxed/simple;
	bh=Iu2tQvVJF+CCxo3wA0hYiBfkX2l11m129ANhI3H3f9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BTpPM+R17bFdRyws8vMRUP8YEnxquMF1x57neZntz8htGTFzzbRwCI8n4g3zND1d+J5kLVIoPHKtQY7r3MOcW0jd8OHE899URt0MQv/EWMr4/4cxw68I352zvCD0yQKeMfMJqZ6DPq0MCHNv1KlsLgVfRaTS8WWyugS0Mq28guE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mhSQma+q; arc=fail smtp.client-ip=52.101.71.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8+58lzYmcsiDg+/vSGQNX7JFuPcLUWgIxo04oBUCETU2/f9ROEiNcpQtdyvB+p+7kzesl1uHPpOqIqxQtP6UNXHlU3bax9DBvI7/hmzdYuhEoKLL1bepqNiBF9FM0+XLaTu3UwIIsJinEPYgq4yUr5b1/sAa8mirh9PCOmhvf0X9qRbZxaxmvbUplvZBqAITL3zqS4O6okjVKcLFEWVlelxq6vRHT84uRtShgCEozbG+nLcgvfl7e7hwVv5wY6BIjzeOF3DHY8nUz0ozsyKG1SKEr1xKXqP6tU2NN2hgxkfxAaG0frxzXC6Y7E+Sgy09VzO+0E0BfXD17nH5LHseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5noXw2XY1JESP8DzcbORV1gjvN5+zZrkOpij+z6K54=;
 b=qCBI3lVw/NlBSa/MsO2uBxbwnj8NLK5YNWtGmUXtliXpUulnSVgxcySWF6htflTitFqR+7j2T55LgnM+A4yg5chUmhRgqyX+4Po8tIBSn8vz5d2fzgdxm+eA/aHmDgX+G+7ZMo49T+7WU0re+CLxRkRD5A2s809W99SSVG/owlLjsofnzGFM3tqTI18Cv6VknEEbyaPGi856C2XviYCX8Mpur66TpEtR2s/3Q1AyzW3dhFPmWTOmRVk/bbhXB0pmBdgTbNhE8rrzOAwGgNbT7mLuvasXMdMQqFzd8K66y+rvn5EB7Cqt5zFGSWMV52uETYeQFqsPEvucRDWxXTrZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5noXw2XY1JESP8DzcbORV1gjvN5+zZrkOpij+z6K54=;
 b=mhSQma+qzWucjBGa24Ca+CDwp/saP3CeoLGLO54NdN+4w6ljsLM86s5ppdzQ27wj4oRic507wgBnak0Z8QLeV6xc1fZcmeIJvRot4ysOd5Mjr8gY7Z5NQQ7goygZX8TxOn7ATrUjwdkPoNqUg7TNFns49UXe3H7oP/3yxWY7gnZCxI6aWVP4+i+ezDwZiJSmJqwI7Oz6pgeQoziN/BZa2wpr818gwfu7DOjX5XxlJd7Ads8jmIrR8s0Z82m7hM123lyzYQjAwQJHo8kla0G/wOnVeyUL0EHPzBJayFW49lbr6twjwDGv64xG8fVyIZWAGo+ZUYKtHN/s1z3AW7lCsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7925.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Wed, 2 Apr
 2025 20:01:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Wed, 2 Apr 2025
 20:01:22 +0000
Date: Wed, 2 Apr 2025 16:01:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, manivannan.sadhasivam@linaro.org,
	linux-pci@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH] misc: pci_endpoint_test: Defer IRQ allocation until
 ioctl(PCITEST_SET_IRQTYPE)
Message-ID: <Z+2XjBd1wQezRlNv@lizhi-Precision-Tower-5810>
References: <20250402085659.4033434-2-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402085659.4033434-2-cassel@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: d93b3372-e2d3-4028-ceda-08dd7221243b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nwcZwqjb2qrtTRJJ+srpR8KiUzconvNI+cd6dYV6DQS7wE36eyEapwa4KD25?=
 =?us-ascii?Q?wCNcnx3uDs3sZxECGg5CZ5OihKF1OHwLqlKjPsU4ZqhZqnt7CwGMR6Vl6Tq7?=
 =?us-ascii?Q?nFCQEaktyJ+r/hIT3+4RcpQDx577fzURHd3PtvwyfmDURdd5btu8GEXTwoOc?=
 =?us-ascii?Q?Kg84oi/fPx232wDVW4YBQRQL0aIpZh5N5szwOj3lxLRpsb86vgEjL3X98Ouk?=
 =?us-ascii?Q?odw8idf5SpNAmHqTQkoH/ycgN/HVSXACZhRkdTeSCKA5QjYW9t7MtYM5JzrT?=
 =?us-ascii?Q?ovYJnjMHeskxJN07yIaDCZr9ZMAD/y9SQA6kkbMJXNoW9jp5nnqvnZq1wEOY?=
 =?us-ascii?Q?N/HRqi/+0nLOiqa6WcGP4oa5Q76oK4i3Zy7yzlRg6Yf4aKv9YyadD9Lu7gj3?=
 =?us-ascii?Q?tZTSsbDEarXPSfDj3kvY9EwR4WZIQUy/hGlEgOhirRWR5RzuLfWh8x688cK6?=
 =?us-ascii?Q?ddnmbMCJ0yIzVoebRq/oW1O3TPBSH99C2dnO8ROgNXANYQO0/K0YGfv48erU?=
 =?us-ascii?Q?/FFT7ehQHLeuZa7XAtCIKMj2mRItejGvTzih3CrGG8eC/tYirkH+w8VVzkYK?=
 =?us-ascii?Q?Y5W5RJvaCSEH5sKqh/tpWCZvf20dvQaVVdupq2stOEEXEMPH0bCnI+1ohjhL?=
 =?us-ascii?Q?tMAS2APd5UOaaoE5OB/cmQfc4bTV1JdTOjxF3XeZYfewXpbBOvWfQdJLD4K7?=
 =?us-ascii?Q?o6LkFek8OhtFwYEJrouG5Gv3x/tdJjBYAPQJqWtExiN4L+9g+payryzvb2KQ?=
 =?us-ascii?Q?4Um4ptQw7nJ6zAaNT7W3btquIJhyzSTaBayl7dT5FJPb545q/hsCKhddZOQn?=
 =?us-ascii?Q?HDPHthDJ/EPu9UoUgJRlddge/2Pyh76nJPXnAUBn7VHCA7XmCrnlidpJUHGF?=
 =?us-ascii?Q?Ly6Lrdi2FvXR5UNOG25M+WUgX0eBSD7ZPh7MByEjnzcna2kC1ywz1RNEKYXk?=
 =?us-ascii?Q?Mi0Rtj5LsDADamfwh+wkOJVdzDK7Rcx1kjMpRKHsXiQrDSSrff3SxNLR+Jho?=
 =?us-ascii?Q?qSIo13gXrKr5RPEmZC5s/IjPru0t1BhPRUipLhxWx4M/6SM4Bv5UOjr1v/nn?=
 =?us-ascii?Q?2b1XCkdyIWHOQgDo1nVrvUnGu749IiC1xSwNvRAhvq2bH57q71mVqOWBD7t9?=
 =?us-ascii?Q?jd+XNjDBwpqorG26mw4xb0xzJ2V8YgLa9s7slypVytf7IeypW/VpDuLxTgJ4?=
 =?us-ascii?Q?G/wHBqTLlsunaJTH0BzFTPzBLRI19R3m+DMdRNYYxqxHvCLHopi7+yoS09BW?=
 =?us-ascii?Q?bYn/OKhCbZ/P5P2EpEElDaO4dBVSIlEeXoFC/j05rXP5flVFPlVMsEa5o0tg?=
 =?us-ascii?Q?t+fUNCxWsnTMEenYDQSiyDt3wXxJu2PlokbSBJb3Yt6DmQFILTzhYDZdAhoO?=
 =?us-ascii?Q?T3bpoVSUD+t9wWo/LD7/K2w42P4nlkO8SPhEUgfYc9CuMXXevpM7Hui9/GQH?=
 =?us-ascii?Q?krOFxqMccZmjijzaP+9Y89Shq0Kzin0D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sqcPg1yzByYD7x58iohXeMgwzVEGk9qcFYWtNl5khHm1QlRhOjbexEDqQ496?=
 =?us-ascii?Q?Is09Ev0pEKndLqDZRc6uLFr51IJSIaytoCaCYKZ+7SVWEhyeegyr89D//HY5?=
 =?us-ascii?Q?/dBCWTpEWD1xuFAZGzbs4tvidEuN7zTQCQb41KhRsC2qIJ32bSAt/a8qK+Me?=
 =?us-ascii?Q?FAiGt3WNvj3tkdb3cA1R1FpsrnRLmJaXTnB9KBOz/UGNMk66FOn6fI4Y36eL?=
 =?us-ascii?Q?0pXG2QO8/BtyZ2UFrd4gT6EgB67XGpmZYO1GsyGOlRW01xPBa85/v9Nfr9+9?=
 =?us-ascii?Q?HKFY1wOePRR0tnHJMf4l1nsUa1Ej0ZaXONMunzpzOJGNVG3NcMLt2mZSV25/?=
 =?us-ascii?Q?koy2qKvwrfbsWaS6RGhYapsrIJtkfNeyLBoXIOmrJj/yeik71gzMCGdhk9Q9?=
 =?us-ascii?Q?oGQ7Cqvrt3mh2lJ8knhyqo5aMGS8oOdMV/jGd0k1D/uvuQkEcGWGP5jPCutw?=
 =?us-ascii?Q?/l24TWyWgQJ0bGWOwe1BnrxXSJENTsQX/P59oas/GkwwWiARFtojFzlxu09N?=
 =?us-ascii?Q?Hapi7iirIA2FTUWBn5lZQgOccHbaTHm4aRt/rMyT9tvxydLB/rIWSjS3o+Kx?=
 =?us-ascii?Q?iShvaD/tPbVO/UcNpq6e3DmSBZWrJbGBGpu5a7okhprdrLUGkjiwqtnpjsMB?=
 =?us-ascii?Q?XAE+U+3Gvb4eYQXWwKQNadi3KxH4od9U8DfinbfF37WTlsEkQnEIvON3xLpI?=
 =?us-ascii?Q?rRNEbe0oDMe3bqHO5kRUej0nDOTpJkRx8uykqu7C6wObzEuWjQGZJUeqEoTY?=
 =?us-ascii?Q?NAMUqQrbtvMOjHQwpKKh3YB77ahge9EtQwb7sCbs5ahw03qwXcwOkA5y4RUf?=
 =?us-ascii?Q?fjh38P68KxfMLkJZdVMsewfAQUr7BbRaC/jrkeZehxO3rmj+Erifg7WTqbw+?=
 =?us-ascii?Q?6Q1Aj7XtLpeX00ji5NHrdvbKIkX9AA06Tva1qZl5A9R7FGtn62ZfEdctOtjf?=
 =?us-ascii?Q?IuHN16NPupHm3LQxJH/EpcQgptZQyrIovbNA5aPS32Y9BavqZSdpIfRU7f4w?=
 =?us-ascii?Q?sGC4KFwZPHPH8c0VZiYZN/iWBhykhHruR7uLkHy59HbU7EZ4eSypyRKO75Yf?=
 =?us-ascii?Q?PT6OBriNa/mud17tzJNNXRnI1tBVoyFJMyHTmovwGxDUosut3bWiXUQbS/h1?=
 =?us-ascii?Q?YNKagFhkA1mUBGp33XUYWdR9qZUR1K5tffqyk6Tnrn/lmxYnuAJztlre+W+z?=
 =?us-ascii?Q?Uj2cIP9yHAWn3vyNNfwq9s3hhEEWG9qHPYt3yNYLu85npMDn/qz+N8YoVHoy?=
 =?us-ascii?Q?3er1NSdEp4j4mLwyqDVCzeJdCjgpxJF6wl23hXswZjg16doPWD9uH9U6au2E?=
 =?us-ascii?Q?87S09GnXlbfGG57Ea//eTpxRNlRLVoDhaNC69vJYz2xcer7nJalUvprKBeID?=
 =?us-ascii?Q?ZWbqjgyApGqhG+TvcvLeWAIgNm9L8hqpkZpM/L9iozBrFc/2WXTHmVXIEPLl?=
 =?us-ascii?Q?Ck4I3SQE4Iqvprge479uw7a9U7DkgXidPdQ2TTnkIYz0ZRARmbMxT4PfTztd?=
 =?us-ascii?Q?RXrZ+orlWCsX51WrSBk+R8grYOTZ8mMGfzT8uJx7lI0sP4furH2cyfrsDVq5?=
 =?us-ascii?Q?IV9bTgc8BRH74FTT0qKQOGx8SFXlNMnjwGszas62?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93b3372-e2d3-4028-ceda-08dd7221243b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 20:01:22.5896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KApl7zWMEGXZFzewzpB31D9nJUfCwMfDTdmLiDsfvWzcAN9BCTOJdF6qkPiwBI34QeXnD5x4H//4WNaVyfJaDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7925

On Wed, Apr 02, 2025 at 10:57:00AM +0200, Niklas Cassel wrote:
> Commit a402006d48a9 ("misc: pci_endpoint_test: Remove global 'irq_type'
> and 'no_msi'") changed so that the default IRQ vector requested by
> pci_endpoint_test_probe() was no longer the module param 'irq_type',
> but instead test->irq_type. test->irq_type is by default
> IRQ_TYPE_UNDEFINED (until someone calls ioctl(PCITEST_SET_IRQTYPE)).
>
> However, the commit also changed so that after initializing test->irq_type
> to IRQ_TYPE_UNDEFINED, it also overrides it with driver_data->irq_type, if
> the PCI device and vendor ID provides driver_data.
>
> This causes a regression for PCI device and vendor IDs that do not provide
> driver_data, and the driver now fails to probe on such platforms.
>
> Considering that the pci endpoint selftests and the old pcitest always
> call ioctl(PCITEST_SET_IRQTYPE)

Maybe my pcitest is too old. "pcitest -r" have not call ioctl(PCITEST_SET_IRQTYPE).
I need run "pcitest -i 1" firstly. It'd better remove pcitest information
because pcitest already was removed from git tree. and now pcitest always
show NOT OKAY.

> before performing any test that requires
> IRQs, simply remove the allocation of IRQs in pci_endpoint_test_probe(),
> and defer it until ioctl(PCITEST_SET_IRQTYPE) has been called.
>
> A positive side effect of this is that even if the endpoint controller has
> issues with IRQs, the user can do still do all the tests/ioctls() that do
> not require working IRQs, e.g. PCITEST_BAR and PCITEST_BARS.
>
> This also means that we can remove the now unused irq_type from
> driver_data. The irq_type will always be the one configured by the user
> using ioctl(PCITEST_SET_IRQTYPE). (A user that does not know, or care
> which irq_type that is used, can use PCITEST_IRQ_TYPE_AUTO. This has
> superseded the need for a default irq_type in driver_data.)

But you remove "irq_type" at driver_data, does it means PCITEST_IRQ_TYPE_AUTO
will not be supported?

Frank

>
> Fixes: a402006d48a9c ("misc: pci_endpoint_test: Remove global 'irq_type' and 'no_msi'")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
>
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index d294850a35a1..c4e5e2c977be 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -122,7 +122,6 @@ struct pci_endpoint_test {
>  struct pci_endpoint_test_data {
>  	enum pci_barno test_reg_bar;
>  	size_t alignment;
> -	int irq_type;
>  };
>
>  static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
> @@ -948,7 +947,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  		test_reg_bar = data->test_reg_bar;
>  		test->test_reg_bar = test_reg_bar;
>  		test->alignment = data->alignment;
> -		test->irq_type = data->irq_type;
>  	}
>
>  	init_completion(&test->irq_raised);
> @@ -970,10 +968,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>
>  	pci_set_master(pdev);
>
> -	ret = pci_endpoint_test_alloc_irq_vectors(test, test->irq_type);
> -	if (ret)
> -		goto err_disable_irq;
> -
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>  		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
>  			base = pci_ioremap_bar(pdev, bar);
> @@ -1009,10 +1003,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  		goto err_ida_remove;
>  	}
>
> -	ret = pci_endpoint_test_request_irq(test);
> -	if (ret)
> -		goto err_kfree_test_name;
> -
>  	pci_endpoint_test_get_capabilities(test);
>
>  	misc_device = &test->miscdev;
> @@ -1020,7 +1010,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  	misc_device->name = kstrdup(name, GFP_KERNEL);
>  	if (!misc_device->name) {
>  		ret = -ENOMEM;
> -		goto err_release_irq;
> +		goto err_kfree_test_name;
>  	}
>  	misc_device->parent = &pdev->dev;
>  	misc_device->fops = &pci_endpoint_test_fops;
> @@ -1036,9 +1026,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  err_kfree_name:
>  	kfree(misc_device->name);
>
> -err_release_irq:
> -	pci_endpoint_test_release_irq(test);
> -
>  err_kfree_test_name:
>  	kfree(test->name);
>
> @@ -1051,8 +1038,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  			pci_iounmap(pdev, test->bar[bar]);
>  	}
>
> -err_disable_irq:
> -	pci_endpoint_test_free_irq_vectors(test);
>  	pci_release_regions(pdev);
>
>  err_disable_pdev:
> @@ -1092,23 +1077,19 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
>  static const struct pci_endpoint_test_data default_data = {
>  	.test_reg_bar = BAR_0,
>  	.alignment = SZ_4K,
> -	.irq_type = PCITEST_IRQ_TYPE_MSI,
>  };
>
>  static const struct pci_endpoint_test_data am654_data = {
>  	.test_reg_bar = BAR_2,
>  	.alignment = SZ_64K,
> -	.irq_type = PCITEST_IRQ_TYPE_MSI,
>  };
>
>  static const struct pci_endpoint_test_data j721e_data = {
>  	.alignment = 256,
> -	.irq_type = PCITEST_IRQ_TYPE_MSI,
>  };
>
>  static const struct pci_endpoint_test_data rk3588_data = {
>  	.alignment = SZ_64K,
> -	.irq_type = PCITEST_IRQ_TYPE_MSI,
>  };
>
>  /*
> --
> 2.49.0
>

