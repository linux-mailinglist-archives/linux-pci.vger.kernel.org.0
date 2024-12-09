Return-Path: <linux-pci+bounces-17966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1909EA1B0
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 23:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A81C281FED
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 22:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE82646B8;
	Mon,  9 Dec 2024 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qz7hsfiC"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2088.outbound.protection.outlook.com [40.107.103.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD20F198A07;
	Mon,  9 Dec 2024 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733782595; cv=fail; b=JIVE5tsnOaJs0lQJDYw/nQktw2qOJE8zHm2anfkjaZ+ROyDXW1wXt85kuynJRo1+pPFvAHi0cc+cfN2VAkjZ6AF/F3ZWU/rCO8cZs0mJxKBdn7ivrVzq1rMj4T6E9hjYt1hXWwK/2ydw6dUQnP2oIp8oDVZ4PdNCB3F8Qh0m/i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733782595; c=relaxed/simple;
	bh=yo1Vu0E3eFccHqbCiKFUblko+bKy2pxDMM9Ds792oUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tbKExQrt6Ih2z8puPBjUQE7ljXz7g1MT8vgjoR3ghQGPB0KQSqN8CdmlADKsx9wodN7chXxhtWLCq/z8yUM+q6vMKuLXgzLCQJiH7528GEeggeteoBIpXWWAQ9wEmmGafyajmJ439ksk79rc6/ATelSEOHQaeXzl0U3hrFpVtak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qz7hsfiC; arc=fail smtp.client-ip=40.107.103.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIP5aT7ipxdbOTQDiZEOUHoJvElMb5PXbljw86k5PXvywh5I0UdnKVGJ8yJOGNTYDaLSeQQVF8LeLxnYK83+g4TJKcUlxkpPj1AjZs8F4TcXNZ0Ul2ohnX91l7DF0nk228iPoejefdgXxxxgD4CqMHkTgCiVKUCjpeNeA6QMv+9MD1Ag44/y0BDRbX7SqlbG9XxtaXEiT6CIdLkT7jC4B3LG5tW3Oz3mcAfuQQGaWHTQub6EiYreYOCmsR1CzssAulSAzIHawdGVGUT61MSKsYORvTP24sMMb75SrgC8n2pmshOWbvHsDBbeJIveH/rZ/M/8yGrwByAuRxdnwq2TkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AyjBIW/EPj4X02B3zCX8uNNsArmWWU8U6Mmccj0ix4=;
 b=KuSCa8SHFr5fpk8jCF2IdREMry2GhnN0t1uZbstCM7XZ7epvuw7BMV4rXnONcY0uAI1O6mX2PD7UMYwVBER2Wge9J5t1C22fgORINk5lBgs4x8sXVr2Fubw+2If0HE2TvDD+vxzockDANk/CRLM8ZXJ88mP9hTAjN75jfgHhLD8bq48ggtY1f151jVyKzrj/iHGGAC+/q55Mtkf71/uYN6Zu4IbetIb30dHczgsuu1Vxm4jnab/q8IWY5VKdKzYK+uj7Gn0d2aze5veHnlGyzrd3U732RWjTwziti67DUiBewjig97PHRTn3KxQaJSYPtIIUjerF5kbkXBhmm0p9mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AyjBIW/EPj4X02B3zCX8uNNsArmWWU8U6Mmccj0ix4=;
 b=Qz7hsfiCwIZSHzmLCqR0LJOoCrtfJU6m4zuo9rPCt590c5RFYUpMMbYVdQ8mVAWG0bgcU/2ShghGzS3mT69vSxOw1HuLqcYhtqt8ehCHoozHLTuBPFRVZNqxfCigmir52Dt/EPTdXi6RFVTgpUbXMTjG+wIVlWGqZC2V76XMj1HtzY98EgVPROypOFcYKfwje9sTbD1+JmfBNv8wRL4j2oXB7eH8ccdJ1l3NqrjnFXolyf9thKt3/DquDiKoOYe+P8zByNX7WmCaOB+MAViZUIwvkzcwqebtETYDyEKn5amPpVnuIyLmWkiWfiOdLn6eGfTzngWC97sWcVn6zlyOKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7828.eurprd04.prod.outlook.com (2603:10a6:20b:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 22:16:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 22:16:29 +0000
Date: Mon, 9 Dec 2024 17:16:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, jdmason@kudzu.us,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 3/7] PCI: endpoint: pci-ep-msi: Add MSI address/data
 pair mutable check
Message-ID: <Z1dsNbJxLA4NK8Us@lizhi-Precision-Tower-5810>
References: <20241209-ep-msi-v11-0-7434fa8397bd@nxp.com>
 <20241209-ep-msi-v11-3-7434fa8397bd@nxp.com>
 <87h67cprc7.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h67cprc7.ffs@tglx>
X-ClientProxiedBy: BY5PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: e6cbdd42-2600-4d53-5a03-08dd189f2182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6O9YUK19yQNXqzoYs3Y9c+R/lubLJuOuFa+AUJSkU8GJUtZ+OYq44MAvV3P6?=
 =?us-ascii?Q?QZh1qj63qLbkbSd2YM3HgZOj4rsa9i/JBMbZE9LvQ5L7LC2P0Waj43zBo3gh?=
 =?us-ascii?Q?I33RW6DNlYtNN18O3eADjpe2ta0xjsoUJkEHZj2I53Jmn479enaIF5CPGr0g?=
 =?us-ascii?Q?YQrUL/2y8oMUuJDlTWfg1pftmq/LYgyUqP/qAIGFxL+tfvGsr9AK4FKMRkZs?=
 =?us-ascii?Q?FXMN9L2qyYwwBksjwRGcrzA2ytSJnf/iV+waZqmhm7E7qLkoM9rQI49oxjsA?=
 =?us-ascii?Q?ZpQwTYu5iwAk7+Vweoo3UVLXkHvawpxcSWn0H9xXUBKHubULLsK1UjcNbL11?=
 =?us-ascii?Q?bwgd69xNguszcRjbZi/LMe9V0kgtGWMWucEbU01aa3IHlAIbQicr+D7ISQw+?=
 =?us-ascii?Q?LgmUYFtWG8MOu00P+gMj0J9mjfOBKwwCejOH8dGJUUYcuWgUFQOcq/6pSuzn?=
 =?us-ascii?Q?a1bMTKcfDnVjDR2ogNZrkYomjCOcDSW2ygQ1LQlxJ3KxO6nNb07cPGQuny/D?=
 =?us-ascii?Q?q/swRAsAFjfCj9qPIzNqAVxhQfAVS17NDQ1GbJk0TmGeLJY6PK6L782d0RVI?=
 =?us-ascii?Q?14GoMPMuDXJoPva5hWXGMKNPRcH8cDeTXci9a9pvrCvnb5NTIkVr0mb2tMUV?=
 =?us-ascii?Q?GlhR9k6PVfxlo/Rwm8h6DJI7+jo7FO3Z/pOP1PuAqakJx6nU+3oZRAt8Dyc1?=
 =?us-ascii?Q?NGGQ5mX5mIUGbo/GKoBRGZtUg94krzSAY73asuQtMofPfIPtMT7wDEQPTTPh?=
 =?us-ascii?Q?IvSN8LBT6oTMtTYnwsR4O80IElaEqNeXJN7wtI2LhH4qNjWzl7v2KEDg+Wc5?=
 =?us-ascii?Q?SeLLKmSrVUmDM3dDFxLGIv+HjrFFjAxZiLmfbc1Xu+5cCFFH/6xoBdCWKQBq?=
 =?us-ascii?Q?s78R5/2UAhxE+R8qZE6z1n20/5fmnok8eXN9dgz2/RyeXXpf0KCE4P2qzsST?=
 =?us-ascii?Q?mVmUDq8qrSpZIZyjdY8XVRIV94tb/xTGGmTg4DfYGkWs4LMhLOvPNw7jrs+B?=
 =?us-ascii?Q?9HjD9crpNQaxHI4sHXQppFKBfAv0p1RbCEBGpiorSaHlD1Bxhzp5g77PTrAA?=
 =?us-ascii?Q?XyQrumJrCtf/dm3roO76mx+g/5PaE/0x+/RyE9pECzzukvEomIGgS/slnLEW?=
 =?us-ascii?Q?GS8n/q1t6zLVUrQIzHeqtR6PRU7rnIFnWq5e1Pnz4hYFAA1x+YVpGRfXm0en?=
 =?us-ascii?Q?Zpa4r1hk1QZ2gPkB9mu9eG6d3tkRYu2VkwZYybrNRTPRtoSbPtsPsW0kGLwh?=
 =?us-ascii?Q?Ir6TBf4FxsBIryTU2H51kWFyDd+e/StTcPII8uIGMcEojrm9+7cAI3EW/5Wt?=
 =?us-ascii?Q?iR4Y8hr6nGN+cwBoMQAFS6DsZhKCi1OhktsS32kSq6rCBZqaZJoMTgqzD8Zr?=
 =?us-ascii?Q?gTEQ0lg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IMwf6EFyv0sJJQCizNmW3GuIh9JF0JVZFfy2BaobxhcfcXWz1Z9nTC1Net8e?=
 =?us-ascii?Q?MZIAWx0HYYXQX/ZY8Fr3dhhxZNCvfrDyAJVGFuzivVCBva1TS9TMTCGMBqJW?=
 =?us-ascii?Q?j4Nctn/yTxzfBApn6b5a4k8YdPFZRLveIgJr0BnF/13cxSkcPu+e4MeM8qx4?=
 =?us-ascii?Q?ZLP4DnHoofAyxrfwQEaxr3OGA37CG/47aIt4l37xbrvTirlvsqD1a9yFGJC4?=
 =?us-ascii?Q?M+GRlhoNNZmafwFMZBYbZs2nGN/PZuhdMqufUD9TKnTYbd4C1u9sAug+5mmw?=
 =?us-ascii?Q?yjrlTlZxnsn1tLuasgn6axc9gED9do4jWjM2h9H0FRi/SxA1BuegAUYHhDkg?=
 =?us-ascii?Q?Wx1DiJ5WiehEiw8NC9DYCie4+AFOha3ueG8lz1r7D/6UpkQTqYcnNfUZ9c8C?=
 =?us-ascii?Q?8mjNiqUnvn36Iu8HLLpZVyzCv1ATLnFHAxCzzvOqDtwPEUDHXSf79dC1mZzW?=
 =?us-ascii?Q?T8iqdirnEEZSMHinEGB+69WT6ZpQNk7xJHIist09Wj3mEKV5qo7yvJV9yws7?=
 =?us-ascii?Q?YY1rIcHdE3YsDYWqAcFjsSA7atfwBAzzwWJw9ONkuhOp+UMpIrlT+pi005lY?=
 =?us-ascii?Q?GqGa/2kpdvahe7E6FpGX3L5iqoMFbVtuGITv0ObnWqLTF+d0GVPAVKzkkma2?=
 =?us-ascii?Q?UAL4calF8urrMBLUnmp8ZVIRvjb7iVfa2x+NCFlG8nliqS42D4tklZ72HDfy?=
 =?us-ascii?Q?Tm34JWaowNidVKonk1XFQaAASwfYZEUyuV8KW4Dj6R9Tdte4FnuefiVEOsis?=
 =?us-ascii?Q?cQAX882yVb+iT38uHgEw22Erx7zGE6J/Ou0CUoQQS1mDlC3hRILyAS1t7tBb?=
 =?us-ascii?Q?osF+K3DfemoWuwD2Wf+w9lf9DqO0gcyp0QulEEfLaDffApPKN6kjokCFvCaU?=
 =?us-ascii?Q?5vBYITv90ZKfLsRj/dmOvzRNbueLpyskQZQCkb1aRFh8QH5pc1BCZHmYS8/+?=
 =?us-ascii?Q?tgJA3QbVwQDjdqxioMUFKuqV42y9BpCMpLtJFLMuDzFZ+KAMm+ZqbjGrGXHq?=
 =?us-ascii?Q?ZlOnwyJCnCAUrKvotQiZHSWXelb5sB7v96u3rI0b+fCKnNzDqZSY6WsIGsLV?=
 =?us-ascii?Q?NlvtixZedl8ZsvUFwNxx0SGMXVFG/m8rW2M0TqF84UsDkyRdwH1SESvb0rN7?=
 =?us-ascii?Q?c6Pd84ejOmqLCS21ktHm89fJcceV8lM5uCF63/xo7udZ6AlmWuL4ShUp9RaF?=
 =?us-ascii?Q?q6IQ1tKGcp8FfJIMZ6bobDrzpgk5g02/L+hYKF+7c7lXha0N3SciqoOkbFp4?=
 =?us-ascii?Q?2DVIhRoXZlIqGaQxIJWXXSvOtMWmOQZZagTiuIY0fWs9aDNw/w/r6SsjWRPw?=
 =?us-ascii?Q?cqerQp+PftRknoX0tVcUZOy1Q8Dax+BVfwtcMvEMRngWN98qSL9c6NeXTfbi?=
 =?us-ascii?Q?AjWD9s2i/ThJJ3rY9sy9csO620bC1gQsbFnT8Bg5h/Ge9V7AZZkz8h/nbSSG?=
 =?us-ascii?Q?8Of1lshFFIWVJM/TkWBKfuV22OYLFaqbMqSiH83F69Zkgz0oyB/eJXISxMYp?=
 =?us-ascii?Q?P/F4RxhCxAQGlTdkMWfz+YXMDahrkKIMH1/0KzpFNkzegE3bec18p0jHNHo9?=
 =?us-ascii?Q?ETP6y7mHCKlig5zKks0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cbdd42-2600-4d53-5a03-08dd189f2182
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 22:16:29.8705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugO+2Bk4q4+GdDkWWoHwWr8ZrLM58tH9WsU9sDSFgBTooRooq2n40U0O4qJBgUGIP7UQhfmTgoLhfsLnXfP2+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7828

On Mon, Dec 09, 2024 at 08:51:52PM +0100, Thomas Gleixner wrote:
> Frank!
>
> On Mon, Dec 09 2024 at 12:48, Frank Li wrote:
>
> > Some MSI controller change address/data pair when irq_set_affinity().
> > Current PCI endpoint can't support this type MSI controller. So add flag
> > MSI_FLAG_MSG_IMMUTABLE in include/linux/msi.h, set this flags in ARM GIC
> > ITS MSI controller and check it when allocate doorbell.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v9 to v11
> > - new patch
> > ---
> >  drivers/irqchip/irq-gic-v3-its-msi-parent.c | 1 +
> >  drivers/pci/endpoint/pci-ep-msi.c           | 8 ++++++++
> >  include/linux/msi.h                         | 2 ++
>
> This is not how it works and I explained that you to more than once in
> the past.

The below suggest is great and I will update at next version. But I want to
know where I lost this.

v10: https://lore.kernel.org/imx/20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com/T/#m3060eeab5d5bac931db685d21755a827dfc7a8c7
Talk about MUTABLE or IMPUTABLE
v9: https://lore.kernel.org/imx/87v7w0s9a8.ffs@tglx/
Talk about need add a imputable flags

v8: https://lore.kernel.org/imx/20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com/
v7: https://lore.kernel.org/imx/20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com/
v6: https://lore.kernel.org/all/20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com/
v5: https://lore.kernel.org/all/20241108-ep-msi-v5-0-a14951c0d007@nxp.com/
v4: https://lore.kernel.org/all/20241031-ep-msi-v4-0-717da2d99b28@nxp.com/
Have not found your comments at v4 - v8

v3: https://lore.kernel.org/all/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com/
Talk about
msi_get_virq()

Frank

>
> The change to the interrupt code is standalone and has nothing to do
> with PCI endpoint. The latter is just a user of this.
>
> So this want's to be split into several patches:
>
>    1) add the new flag and a helper function which checks for the flag.
>
>    2) add the flag to GICv3 ITS with a proper explanation
>
>    3) Check for it in the PCI endpoint code
>
> >
> > +	if (!dom->msi_parent_ops)
> > +		return -EINVAL;
>
> irq_domain_is_msi_parent()
>
> > +	if (!(dom->msi_parent_ops->supported_flags & MSI_FLAG_MSG_IMMUTABLE)) {
>
> Want's a helper.
>
> Thanks,
>
>         tglx

