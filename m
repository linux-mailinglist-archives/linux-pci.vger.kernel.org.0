Return-Path: <linux-pci+bounces-44096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B00BCF852D
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 13:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EC123008750
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 12:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2F82F1FEA;
	Tue,  6 Jan 2026 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="p9RsarMx"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020107.outbound.protection.outlook.com [52.101.228.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAFA1E868;
	Tue,  6 Jan 2026 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702785; cv=fail; b=LhRBkEvGObWg0A9Xao9k5+v0QgqjQPoIbjS7ipPfVjYeD0SF91Y55ZkWRdJxXfFmtnK7FRZQWtaeP+6IbtvABYW2FQ4XD7ka1zIX5kRSPhcIY/HWnm7n2ZUYMYzQy6cZShaNeHV1cLdup+zsQENJytz+6hTLnofLPlfStqAlk50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702785; c=relaxed/simple;
	bh=j0yndf0ua/eSkIDX+ueVgUn81AVKHc7UbxfjIep18FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PYOeMIva1QDGOCSMvBT7dUerYGi9qhMkE4RDOcnIAO2nKCZVRE1XOlrIDpED0bjEVNX8V4bTr0bF0t6j7pQOvcwkSZt3W39GUMEEKHTqWqpOVE149PjjjqYj3EGFp3TYJk9NzNLlrls31mftWMvOZPO2wWBkhPgTHoKt0XLbdPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=p9RsarMx; arc=fail smtp.client-ip=52.101.228.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e87gONpDpz5t95lMM1IC6hwcUTKyFHUc105r3rOoY61ZhiCEhXsnWN53VS/In57hMQM47cCXRjlcdag559iv7CIP77VQiJ3eNBYokJd+pZR2pcrYWza3KOzOEtj/v2tkXm6JiEqQCZxV4b7hCZnYp71zSm/f/IHjTbAY7dligHSQuF3vxrBkEHoGHlw0ou2Yn/WhqIAWXniyjJGp5sSvT/QpMZWn4OI/FxF3AfncdemDwZEzv6mAFQZRzdX0JfVrhO0UqGimkQi2lAzArUEl2XOLwsU2LjcJa8TibPbelFICC6efRNs6dMRBJSWrJ1ADgPwSouoCNVIiCGNX2hGsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RomKFiQloRZ1WvtZ4SCQ7uoGXb9ZLBgSn2g3pnYfgoQ=;
 b=itU4Ygr5OhL0ws+xCC0qCPhVo5hEUBEkdKIGZ93Wn/i0EDPRIv4eL0xtL2XuiP4LNjJoJ2Fx+uIBKCuybyr8X419n/pHKKMc+Q5ZLUnJUa006D43AM1mALTeiJBdhAw9nFsaTYzhNv0rA4xY5wg317Yw3OrOMPF5OFsb1z+U1IeZRcU61O5ElaC1g9nz/Jv+ndTClngbJU/BXr5ZnqSRNRUYAefMu2jE9qkoDfKR+joqvGIfhd7cYyMzhQKzGLyKYhbU53hy4Ow6a/yDEdat8IKRIvJKww0s2vjOKxT5xCPgju9GmmE88ou1GoUpKroKK9i0E5XcZUa2ukJYJ5HUCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RomKFiQloRZ1WvtZ4SCQ7uoGXb9ZLBgSn2g3pnYfgoQ=;
 b=p9RsarMx+jiZ4CLuUkJqVcud2W7p8YLtHpzZjO59d933aFtKcJPZMtFb4F2UMVSbIcKZ9Ulibd00sQ2z27vKnS6H+dZi3HSWujDmbaN6bfV70RqUeIkZJASD1OT7RpNQ0gSvBe2+eH20VBNiGJmP1NDSFVGs6pbcAHQ+1+7ffqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB1831.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:171::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 12:33:00 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9478.005; Tue, 6 Jan 2026
 12:32:59 +0000
Date: Tue, 6 Jan 2026 21:32:58 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, Frank.Li@nxp.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: endpoint: BAR subrange mapping support
Message-ID: <t3kgkqhg7ffenvrbyo6e6cdtxc7wfq5mpt2m5drvbdvesn7ow4@iobg4657himy>
References: <20260105080214.1254325-1-den@valinux.co.jp>
 <aVvtAkEcg6Qg7K3C@ryzen>
 <gb3mr7onokhufasxaeoxiqft22incwxxlf43m6jcrhrem3477j@63oi3ztvbqku>
 <aVzWQIOgdtyjom3Y@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVzWQIOgdtyjom3Y@fedora>
X-ClientProxiedBy: TY4PR01CA0124.jpnprd01.prod.outlook.com
 (2603:1096:405:379::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB1831:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c503304-3e46-4de7-8dc8-08de4d1fba48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6iY02ShWbnbmqMDXWPN7l3Cmi+cC3s4CLSDsW38lwuXby6pHrpQq8GlkM4KH?=
 =?us-ascii?Q?gH1wXgWXzANyeHFL8gX2iB786imn4o69hMFNbTRFHiLyRl0LBkT211/CiURO?=
 =?us-ascii?Q?927MnTrHZmV157G7x7uuAJoreW2HCI7/AoKa0m7Anem2UZ+s9q3LBzSa1qBV?=
 =?us-ascii?Q?fh1nd9qeFoQYMJAaMCLJtiqXSbmG6GRIYw3xN/1hJnbJ8j4lSx/zX96E/PyS?=
 =?us-ascii?Q?Yw5Hzj6BSDbL4/73IaREhMoXusFLyZXVDbZb8Aphcrz8sA3kwlp8FduceCBj?=
 =?us-ascii?Q?bAPbzMCYBwA+UJC2SvitQzQ65qQRgM7fPcp/WfiXhvm1ugTYNo3BNlw9ENcQ?=
 =?us-ascii?Q?V8wbaWmMfd9FxgtyOzP1u/oAm4wsIII8hYoSoXh5tGBFL+7Tnsj5QECKpYxI?=
 =?us-ascii?Q?1xZi+2n7GS0LWovRtaf+iwAjG9O1tklBaSSt/CIQmKsOnf9fPfE8VzkNEdIt?=
 =?us-ascii?Q?AexyKo1nP1l0Z9mxNdJ4IzSLwUFw6QUYXuB99Ag2q3jUhb2jse0VR4csdtZ7?=
 =?us-ascii?Q?n0qW0Qz7FNeqdJXV5i7HPFiHFELs/YxZHUrxH2xNrPDzztcn12Bzn8KfwTXa?=
 =?us-ascii?Q?ZXlojfVwvmHYQs5PYnNlm/TrJKEgD6jF/lloZlcVMrcK4KSOAZOaANkIJpfr?=
 =?us-ascii?Q?Qbd4v7TCZFW6EmwW4Lwq43t2Z0WxtJiGIl8IRsS5GojxpZpo6eFE4iTrWvsf?=
 =?us-ascii?Q?VrmwxBstxXAUpedd8LA5hEN8aKXzWRB85cfm8p7txcixAlu6X9KlfR25yD/4?=
 =?us-ascii?Q?LUdg4btEYwPEjfI13zh+Mdg8Ok/t5m/wNSIH8NlLApWhL2t8YZ4z7W2M4cS6?=
 =?us-ascii?Q?Yt2IF2oXht3WEAjtMmMxhOV+6EaAy6935u7peWXgjEzZwJ9OZGRbOI/8CwHp?=
 =?us-ascii?Q?C896fhtD/HJDvY/7uaLmINYoMPkEchSPqXGr0oVP6vPdOTgRWttTJjRg6lrU?=
 =?us-ascii?Q?YZL4Dl5WcBHioYyAVZFecB7NRymrj4qz/s7cliwcOEJRFUGz27N+JIVYDL5G?=
 =?us-ascii?Q?7jhsU2LICw4owSAiCbNSDaCB0lq4r/FPj++GGlCvMjpHxW39L6SuJKTofTdo?=
 =?us-ascii?Q?CYr+4p5YPv2Nb64Z5btVwwnCq0Evk5ALMb0cb06E2cMWjDWJqdS8O+SV/n+h?=
 =?us-ascii?Q?T4Ne0/aPOPxBo0Lo7omaMJHEMsI8MWSGfrkrohqZIAIIt/0ZyE/hOAAiipl2?=
 =?us-ascii?Q?ZGPn7FAdC2+a9Ow7ttlGSXwdTqoBBnfZWNU3DYeux3Qte8KrJBYdipbODi57?=
 =?us-ascii?Q?SIZVk1fS19WAgnqC1W5BVtA1WY6l10rNj4G1x6lza3bh4fpmZySNLej6Dnzk?=
 =?us-ascii?Q?/Z9dDFqHASSTUyY9TiT4zDv8r6qSxXY/cgf6b0fehizgQjQ3cwi0s7P0Ht9Y?=
 =?us-ascii?Q?oODJx9gerjcEvESF603JIxJSyQzy/d9hZZ3P4ErY9cL50KCNyCoArVvZgzW8?=
 =?us-ascii?Q?cjHtlbZGSJxru9ONsPtzXg3lQq/jpV9R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T5WvA0TFlgjLtZcsweJbmk61yCm/4gOFeNqTHNuEvMIuNLGEOIZWKUW//skX?=
 =?us-ascii?Q?u5Cw+1KUzVW2OwhJHmhYd98O89KrUCJKIAL0lY6PdGxBVvnql4+kmtpH0bVz?=
 =?us-ascii?Q?RBhyzBF2f6CZRh6CRv28v5ADz79g5I2+kJ8n/AUapX1nTVmC3xyaA5eYeRTi?=
 =?us-ascii?Q?fj8Qh3Ym3QXRSYnOpOdUJYxLB8F7T3PGPiaQ9kagRHBzgSCJoNNy6y8l875K?=
 =?us-ascii?Q?u4G5ww30j8m0t9te16c0s7Bs/reiR4sDaASLeMqD50on6R6W8qUuYYIuWTTe?=
 =?us-ascii?Q?kymbQy9TheO+BmNAr58a/ewnP75xBqf7pI19R2gBOfftd9wBhxuJ+4d4byrT?=
 =?us-ascii?Q?XU7LTm7jS3FifAY+wJLYeaHAEi0KNlN557BFJdHsMzd+Epku9tciH0swInHw?=
 =?us-ascii?Q?NRYaMM3YRE3E76/jm+qbgmxM/z+WEgVuHPfqhXEcl/psYuGDZke4uTCVleyR?=
 =?us-ascii?Q?QwVVnxzvZDQVdq1BTDH4Qe6Mj4EHPytTNSs0IcILYDTFtYJ7fdyasTukl/6z?=
 =?us-ascii?Q?E2siJ7Nokk+1gCSigYyALzjJ2C0E3wk35tO8RLU29PCb4eoT9vFEu+F9uVlO?=
 =?us-ascii?Q?rQ2UQrH7CTvVDBPDkc4HIzocEUjRgoL4qtDKpUKZY7BnEtmSGDJzYyVWMRNy?=
 =?us-ascii?Q?941DMLGWkSF8j+9GOxCBAKMdCk6aRuTlC+9zeuo+kg4DvSP5/4g4Ej1xL21b?=
 =?us-ascii?Q?ThCIXYGGjVgMr+XRbs+rT2bCvKVs8E5fpS3rxlJIfi3rR8Y6Z5F5oXF3Zp+f?=
 =?us-ascii?Q?VsFDhv9/pACVwCkqcPORNke9vlhHWWIHy4SRHEkuIBU5czKP6frEM8s41nIF?=
 =?us-ascii?Q?m8ONleFlAeYeaLUH7reuBVjZ9F8kWqbciryEKAlYCJP4zZe8BlDss2jq2hmB?=
 =?us-ascii?Q?+HNQWFYHTN4Q87PTQgcPBO8+Pxf1JNxaRR3YbthQnfX+rTlP6t1lexXGAfBK?=
 =?us-ascii?Q?x2/ZyNA/4JPUGk3KJs77F3IpjVKcK8mCLOWylD0ZEt/0Njhw5d9V+Ajomose?=
 =?us-ascii?Q?gLJ22Q60t+Tpz09ATnQvlLgMkay1anUSGkL3tqSGYHqnwkvncwNMDXHRnTe9?=
 =?us-ascii?Q?QMFhDe2XXD2mTMbaBuaFCH7ADehngEh2rj306Srvp98K87V4OSwpel5ItCrp?=
 =?us-ascii?Q?TZL5lj4/emvVeKEtPoXMR81BJBT3YObJb2XXPtaraZ7CwsN/47arcW8AUmWX?=
 =?us-ascii?Q?wZqEXGOwADOahY1Nk2uQqwpKaxCwUff7lNzeZYNt6If8jrYdk7p1RhwdFbPb?=
 =?us-ascii?Q?MGZbmR6ZcApU3zcMM+cU5P1TD1LfsF1SPzwvkU3wzwqBg2wqv95YFQYjSkv1?=
 =?us-ascii?Q?9L6CDEVY/5jUFViKDvODxvsAYEOpy0vuIJdP7SVaVS3tTz9GzaM1FolnxGwa?=
 =?us-ascii?Q?pnLC1HTNJjKCx4oMzHGezwOVhhQyYZY7ZW50GrmAxfNmAJ5boM+NocGjrCbw?=
 =?us-ascii?Q?wSTPvxKlS760e3EV9fO4Q/gSsqYoHTrBcRwxT2ulcrT5uj8HqJXudReWGsIm?=
 =?us-ascii?Q?XXHviJJm8o/edB2Pa476hOcz7kDLaQ+SeV6hOfWJxR7HxR5C7psylO56SxWq?=
 =?us-ascii?Q?+/yHpAQUWgdP31yoZq/A4KD0BAXXvnH2nW+qd4IOyPdSl6OJB2aZbEtstrdW?=
 =?us-ascii?Q?+MD88QgFDIHZT5pJZuxUl+gTNS1twlQ02cODh3pJ3ru/EEqnKj3QJqShyCe4?=
 =?us-ascii?Q?UNBsAZCZgcx9hB2F78XXjBQVcVzt2Xxr95xE2iqWpaqiHMXYoYE/g/RRxwos?=
 =?us-ascii?Q?32YnuqkIbuqqrqCWvOmCsDjfrzzbyEDMgB/cJlVT/rmvglOsIEjk?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c503304-3e46-4de7-8dc8-08de4d1fba48
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 12:32:59.8535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OB+fbEVquqd1ukZbZ+2OzCthx1/yp1rlvZkDaq1IvuOOl/RKcVkw5FO7hGQeI3Wmr+ZY4Um9jL3idNvLolAnUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1831

On Tue, Jan 06, 2026 at 10:30:40AM +0100, Niklas Cassel wrote:
> On Tue, Jan 06, 2026 at 10:52:54AM +0900, Koichiro Den wrote:
> > On Mon, Jan 05, 2026 at 05:55:30PM +0100, Niklas Cassel wrote:
> > > 
> > > You should also verify that the sum of all the sizes in the pci_epf_bar_submap
> > > array adds up to exactly pci_epf_bar->size.
> > 
> > I didn't think this was a requirement. I experimented with it just now, and
> > seems to me that no harm is caused even if the sum of the submap sizes is
> > less than the BAR size. Could you point me to any description of this
> > requirement in the databook if available?
> 
> 3.10.7 Inbound Features
> "Without address translation, your application address is passed from the
> TLPs directly through the application interface."
> 
> 
> Thus, when there is not an explicit translation, the DWC controller passes
> through a transaction untranslated.

I see your point now. Thanks for the clarification.

> 
> Sure, if there is no physical memory or IO registers at the physical address
> corresponding to the PCI address trying to be accessed, no harm done.
> 
> But because of the potential security implications, I think it is good to
> ensure that the whole PCI address range of the BAR has a physical mapping.

That makes sense. This (v1) series implicitly allows incremental iATU
programming via multiple dw_pcie_ep_set_bar() invocations with
incrementally added submaps, but if we want to prohibit any holes, it seems
reasonable to make the API contract stricter such that the caller must
prepare all sub-range mappings up front, and a one-shot API call should
either map the whole BAR or fail altogether (all-or-nothing).

Kind regards,
Koichiro

> 
> 
> Kind regards,
> Niklas

