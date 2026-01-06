Return-Path: <linux-pci+bounces-44101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AA2CF8623
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 13:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D622D306F247
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 12:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0413FCC;
	Tue,  6 Jan 2026 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="o5fnHJ+e"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021128.outbound.protection.outlook.com [40.107.74.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72277256D;
	Tue,  6 Jan 2026 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767703159; cv=fail; b=BMW3wkyWPxe+VGGS8HIZ0KbFUcHUGs85zJuq25nsgbqclSfc4otW84/WEuLdTNYOb20yHumHBbq83lf9INY54rwU1lyOuGZrdPUghnyze78uYvs0HLQQszL+liXMhu7/uoFvhFt92eBW4Mnzch/BcsVLPb1kX2EJvzltPjFqkHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767703159; c=relaxed/simple;
	bh=ou/fuZhYlfKnbCsvDz0drY+pcOkT4bn7HoMsots20SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tUNeXX+uUurf/4P6INqf+pDbII3daIH6Zd8mctlsBo/mZYFEbUepMbll9gBtT2leATWG1sRQtZTKZnpOlrSAOa2KoLGRD4sT5AarL8bjIcYp/59bmCtqEZ3RbAcOqHBiFMHGB3eeZwDpDrBy4QlpeMrI5ztHxjSkGh8npbZ9D6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=o5fnHJ+e; arc=fail smtp.client-ip=40.107.74.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJjrMd3/QgCNUvrFgPU8XZ8xbNeWYUZwxPgJ9C9T7wn427JobaW7v8z/UzQbQe/tcFvCQJm4WToslkIapmqULnfr2mSS3Cjy1iDbB7qkmqlPd2pmpR2OiNPy0Tla5cvBFhfPMx1dmbWVoxB77LVdwdLDciL3ReIX3RDdZlA+SQGtW5dOdBz9WioE4h3P8OPjnvwleIJxqSjem1dbvdFrYND3rvM0R/PpKvVd49acHJyA/l6XDCp4umALNiABt5Ixjsc/nrcjIfCatu8XuHT/WS69zqPYRMKTMUnGRW3JCclG0+tAiTPbCqdIhZfhxjRLGBKdFV0csZrpvk1Uhl63dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZRoH6oRumoDVEDp3C0cA0am28Km5cqvUZZv4RHb8XE=;
 b=B5lWtNrd0k+5YX6TWAqbRq7wYgBVkxk/J1glB6niV7V0rOQ5ni5oerTbWje7wXxSXzWcj7hG82dh/AjasTM/QUa0qBywXvBiwA5oJ7r3b0veuCZIPO6mH6K1VLrjludCcHESU06qYZRNKkBFa+8010XNwH7sDsGddj3/5IAuoZ1k5YLfhqf6bXzV8c76vYRgOacH7R4IGriaraOfOCFoRgWI1oeeSLwi/AzvHCjz6y2lQ2RfYf6zfJKId28HyejaPUHij/OhXBLvNW+cSIKIhQDtbtx8r1tM993hkr+x44j/w4DpyUrW4bjrMKA7Db89WO+dPJCuG8JdDYE70jw5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZRoH6oRumoDVEDp3C0cA0am28Km5cqvUZZv4RHb8XE=;
 b=o5fnHJ+exoyN4ClHHdm5wl7iIOVuOd+q6vv041VAfOHAUwqp8Vr5LyZkYxw9T5bRwtKAh95ZFcA/p2W4KhMmPNORdf/N4q2CiaPdRxZChytgMD0HKf7cjSdlifca34ndHRAb8oKLdQofe15Dg9kBG4TXDjosAdiiT5ZRmWmGxYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB1831.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:171::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 12:39:15 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9478.005; Tue, 6 Jan 2026
 12:39:15 +0000
Date: Tue, 6 Jan 2026 21:39:14 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, Frank.Li@nxp.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: endpoint: BAR subrange mapping support
Message-ID: <6dbjjx3q543e3nllxhl66aczujifikf6g2hp4kjjg6ojoz4r47@z5uvbjqlrxnb>
References: <20260105080214.1254325-1-den@valinux.co.jp>
 <aVvtAkEcg6Qg7K3C@ryzen>
 <gb3mr7onokhufasxaeoxiqft22incwxxlf43m6jcrhrem3477j@63oi3ztvbqku>
 <o6swnuf4aplcyd5jpgbyhslxcxuhzt4j6a4oq773eujva6ynqj@wmkorp4mavul>
 <aVzS3_Vx8hXZte1Z@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVzS3_Vx8hXZte1Z@fedora>
X-ClientProxiedBy: TY4P301CA0086.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB1831:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f5eb14-9476-4cea-6908-08de4d209a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/5JxJ+oRZvAvy+0JxRzlFST28GDjInhR5Ru9op//BIE3ZEt8z8YwaQm40YUb?=
 =?us-ascii?Q?ka5TxF3KwP9zFWfMIgBDqMYSmJQIqO4YZ3D95/SBFDanRp6lKpj3z+L27SXy?=
 =?us-ascii?Q?Z7q1Jlrpan4Cs55rA9Cow5HrkzruoFWltxHGBAPLorcBFJyKw4g9F42V6VZH?=
 =?us-ascii?Q?Cd61edULvia5EjcOgDEEpD89MYTn84x6pwiz8HN5EK15rYibw13janp/9oWa?=
 =?us-ascii?Q?tOLeeF7/dQt7Q5exrnw54xzKHhDXhl69EVqBud4osyyBzWzg1onZmH6b57Dz?=
 =?us-ascii?Q?pQPP6VIWbD+BGcyGteEX+E3WyjqRJ4JMcd2XB/E2lJNIBbPpJTjAN9purGQf?=
 =?us-ascii?Q?3HXwhUzc44qvwn0wZPT18JqQqlv/pfC2eNd/vg5acPaa+mbXNlw9HWHkIu+a?=
 =?us-ascii?Q?MduArSyRD8rOo9HQ4YOqUNvWXNsqewQB6XZ7BelsMzUJ6TyfTpw9ikrgTcql?=
 =?us-ascii?Q?KrtAp3of5e/MgAb1UmSF27aHp7ZzRdw+EpXNROjNAf0i4bWmUL8lEkTa6D7+?=
 =?us-ascii?Q?ojsuj/CSK1d+DQKo4WeiWe+xb8oMNn4vNqOKJXcF0U22OB3eG+IP/rAftPp2?=
 =?us-ascii?Q?2H/GolG+uSC+j8KS9stQ5Cc8JcVgwrAXZGsBZrx6ug9SvNz9GkcBhvN+fUCj?=
 =?us-ascii?Q?2s/7pgDRSYcXJ75YfWCMeWncnCJgzNyIGJaF0t2qqgPYHrIi7h/1abIJ0RoJ?=
 =?us-ascii?Q?DsNPdks6Ze95S0TPTlxnpblhQ02LZCXmCIkQzwHh1nbowsNbSpEd2W0snzkV?=
 =?us-ascii?Q?+gkxIFqRQLj04zdRBX8i7nlDWM5exETmomYk2zyKvZX8ulvq/G7UNWiVmT5O?=
 =?us-ascii?Q?cs8k5yWKEsNZWZt26aoriKjLtUE9wIGhRiPhKiXqYJiSyM7R6GUV4sDGyEJI?=
 =?us-ascii?Q?w28lhS7nh/L6MDYCVWNi9KMUtJU9YrKZYbCIew79J+M2GRdGustwdiMn0mSF?=
 =?us-ascii?Q?4XGA7sZ7ynGdzhIoA+cnrY8y7lgbbi+f5VrbhaPuSNbHPxYF44hWvcJK9coX?=
 =?us-ascii?Q?IVfR6OUwWGwwZHwJ1/6fUCuFtmTWWR25bHh1aBXQWWYd6u2ul7av4BbFEDWU?=
 =?us-ascii?Q?keVcvhvbjd1yddP3gtdVIVQu/i6fMSafLj81rRZ/yxNnBLSbltBWXBH4ZClS?=
 =?us-ascii?Q?hf1mYwQw/CSP5ZHcQPclYO+eREEDo/t/u9xY5hG7mA7I//hxaYf/fIYpqqLA?=
 =?us-ascii?Q?3RnmXm5sk74XFHGxvMt2Fzet+RysF1VOtEIZatpo3IRmEWl4Fk1xabAi0ZtL?=
 =?us-ascii?Q?90Tkpx+oBDOaZol9HvoshITJSqGkGpKikDNP5sUpZKHVkEyHh1IFYNo1t6EF?=
 =?us-ascii?Q?Uea4BioF8JkvV5pq9/+IzMzI0qjyoHRX2slAMoizaBvIBJx9S8dUCTCIg7O8?=
 =?us-ascii?Q?PypedGteP+zoq5xfzbCCqc3jv5Z1mbAKRSqfAFMh4WyqKmRnOKPjGdpTCxy6?=
 =?us-ascii?Q?zPMo+rVgZtYtpREQyoT183k8hB+Q1kh5pPH78vCjUUWMexfe1tgu7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7416014)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LRnXSCofhwboRJvgFxqJAPH6D2aVwCIl1q5M5UR7EF/kiPvdpQU9bqmxwHG1?=
 =?us-ascii?Q?k91svbePQluACPH0512hdWNtpyFv1m04p9S1FQKXJGgJ31Jamd4mWcib2hhb?=
 =?us-ascii?Q?e7DzDOhD3q9S8SYVf1+WWHD8Du4yIVMaBunIO0jQg7kx/PW1fAY6xV++0DMo?=
 =?us-ascii?Q?CVnaL6TQVS4G16TiH11txVWU+n2/yfl7e5Mqvhdmrrh6Oc6eDk66wVoTFnmt?=
 =?us-ascii?Q?KXK/wRio8WEqeQSdNZVs9YB9k914srWrslu6qnAvtQUCm+MaRgXeCwDNIs0l?=
 =?us-ascii?Q?qRfTjLggfkP2puqc3op8bXHrBWpEIIHPgeHwlQ+zcmFwjJET8PfQvrLBRDrs?=
 =?us-ascii?Q?1IbkHkbA2ZkLjoBSVx9ptyrbpAguI9FX9GokHULtxPteuB4271UMENNRqhcO?=
 =?us-ascii?Q?NXyBu4RPZL3b8klmyX9/2pwM3tAaZe1e4JVdsHUBBy0HBHQhiTNto1Xc7/rO?=
 =?us-ascii?Q?A2aQHhdCxFV9WVgEVEQJkjZF3zlid8gk0mQnsOtcxJMWZHxRcOtwf/C2qrmV?=
 =?us-ascii?Q?y0CBXON3ZLzt6Xf35S2smds8YJl5BiWjYZ7wnp9t3U5F1ewm395g+NdhRaGi?=
 =?us-ascii?Q?ObfxYVOcC8XV/VJnWXkZGAe8wbHp40mtfhpf+hGnGbDtqBE9NpTjG+BkTYrK?=
 =?us-ascii?Q?weNk1mZLuP+Vhg9BosnzLnpkDh0RNes63O7xD8ZxfrmItblEjsf64ChoY+rd?=
 =?us-ascii?Q?rYzz/dOX0bQJ3iHHne8ENp7kf9A9w4ApTCC+CWgbBVcXxYr5euHairPSsBPn?=
 =?us-ascii?Q?mId2Kiu/HjwSRS2C3pkyOM1a2CRCsxqmlUxK+/OIImY/VaWDlP4JPf4PWz0o?=
 =?us-ascii?Q?O7LZXN8dySeaZxKaO38qqKqimHDemHEndWxreQMsutvuMeKqrFVgpUdN45M5?=
 =?us-ascii?Q?UGd5wmxkAOO2YqD9YysBOTv59WDDQLZbFyMuiLMwwnb/Ow34NiDtH5NyYU6Z?=
 =?us-ascii?Q?bYTJliD8Hyiv9KidaA+0KR7zYPQTIrvR7us84dSYtuPDa7ZKrchghIiPrz7r?=
 =?us-ascii?Q?Xt+PBS9k6S7OXgqggvVbgsv3jSFMYi8piDh9BtlLKXc6YXONBBJqk7kgSY+r?=
 =?us-ascii?Q?y0mHblct8PyxLlHAduX5c8I10Ld1BM4PztCzhBbwmL2RqIYbfAlDVr4XZTEr?=
 =?us-ascii?Q?dAl96HM9IqzYIc/ki5mNE04Zvy/s1/LDCB2L4KLJgopeKGhEhZW8fLqzVOjk?=
 =?us-ascii?Q?D8RuzjTGVlSkbQZ7D02mkzpyFegwij5G9Z4hwA88Z5clngdYtfALg1z+L5za?=
 =?us-ascii?Q?oE7Y4CD3dtWhoIoNQguQNmmIsw/57u9khtYGsKrebx/0BMlPl5qzbsBBzbSs?=
 =?us-ascii?Q?EikmSplqHSx4PTq0j5nXsFFWfaDSDbkh2hHdlja6k9RGB1oynZWPzSjvv3Yj?=
 =?us-ascii?Q?HAlJZ9joP2yHNWqgnur9Enc52wz7qXpBe7N7wnawjAdF9knuWvGX2R50anIi?=
 =?us-ascii?Q?2Fr4bKGgP8g2W0IHuhMlL+Y+JWSqhpfnffVtm1oU2ubRHy1WbOBbFjSimh0/?=
 =?us-ascii?Q?eoPVK+gm6Cqh+R1ZieeqP/xIKOoJ59xGKvBpgxrKvKlTeUNa4nnlAZzFhJXC?=
 =?us-ascii?Q?5H9JjLZ/hJmlx+4T3+sfHhGOZ6iO/PsiySRduYRhnKoM547+7YU1eexJ9JVt?=
 =?us-ascii?Q?w7Uc9e+sPbQK+yFMMrwBWGAD+02FTsRc7EcCFgzWQo1d6u3N4GfQECYwthZd?=
 =?us-ascii?Q?ve94H/tAKAHIdukK055fZ0qD/8FnXQEq39FpCW3Uf1uZCxIxfOxrjCfIepgZ?=
 =?us-ascii?Q?H/rsk3wZh6XYsFhWRjhP+H29moUX8k3WxmkvbEaMr5fxIYhPrvxr?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f5eb14-9476-4cea-6908-08de4d209a1e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 12:39:15.3603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNG/I75udqSmjSQDQh3zOxUmqtWuySxTcqKv5upKunPAekh/ylGc+JYouiJ0ZbbE2vnUp+vaqCSMyNQAzprlZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1831

On Tue, Jan 06, 2026 at 10:16:15AM +0100, Niklas Cassel wrote:
> On Tue, Jan 06, 2026 at 12:09:24PM +0900, Koichiro Den wrote:
> > On Tue, Jan 06, 2026 at 10:52:54AM +0900, Koichiro Den wrote:
> > > On Mon, Jan 05, 2026 at 05:55:30PM +0100, Niklas Cassel wrote:
> > > > Hello Koichiro,
> > > > 
> > > > On Mon, Jan 05, 2026 at 05:02:12PM +0900, Koichiro Den wrote:
> > > > > This series proposes support for mapping subranges within a PCIe endpoint
> > > > > BAR and enables controllers to program inbound address translation for
> > > > > those subranges.
> > > > > 
> > > > > The first patch introduces generic BAR subrange mapping support in the
> > > > > PCI endpoint core. The second patch adds an implementation for the
> > > > > DesignWare PCIe endpoint controller using Address Match Mode IB iATU.
> > > > > 
> > > > > This series is a spin-off from a larger RFC series posted earlier:
> > > > > https://lore.kernel.org/all/20251217151609.3162665-4-den@valinux.co.jp/
> > > > > 
> > > > > Base:
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > > > >   branch: controller/dwc
> > > > >   commit: 68ac85fb42cf ("PCI: dwc: Use cfg0_base as iMSI-RX target address
> > > > >                          to support 32-bit MSI devices")
> > > > > 
> > > > > Thank you for reviewing,
> > > > > 
> > > > > Koichiro Den (2):
> > > > >   PCI: endpoint: Add BAR subrange mapping support
> > > > >   PCI: dwc: ep: Support BAR subrange inbound mapping via address-match
> > > > >     iATU
> > > > 
> > > > I have nothing against this feature, but the big question here is:
> > > > where is the user?
> > > > 
> > > > Usually, we don't add a new feature without having a single user of said
> > > > feature.
> > > > 
> > > 
> > > The first user will likely be Remote eDMA-backed NTB transport. An RFC
> > > series,
> > > https://lore.kernel.org/all/20251217151609.3162665-4-den@valinux.co.jp/
> > > referenced in the cover letter relies on Address Match Mode support.
> > > In that sense, this split series is prerequisite work, and if this gets
> > > acked, I will post another patch series that utilizes this in the NTB code.
> > > 
> > > At least for Renesas R-Car S4, where 64-bit BAR0/BAR2 and 32-bit BAR4 are
> > > available, exposing the eDMA regsister and LL regions to the host requires
> > > at least two mappings (one for register and another for a contiguous LL
> > > memory). Address Match Mode allows a flexible and extensible layout for the
> > > required regions.
> > > 
> > > > 
> > > > One thing that I would like to see though:
> > > > stricter verification of the pci_epf_bar_submap array.
> > > > 
> > > > For DWC, we know that the minimum size that an iATU can map is stored in:
> > > > (struct dw_pcie *pci) pci->region_align.
> > > > 
> > > > Thus, each element in the pci_epf_bar_submap array has to have a size that
> > > > is a multiple of pci->region_align.
> > > > 
> > > > I don't see that you ever verify this anywhere.
> > > 
> > > I missed it, will add the check.
> > 
> > My reply above was wrong, the region_align-related validation is already
> > handled in dw_pcie_prog_inbound_atu(). I don't think we need to duplicate
> > the same check at (A) (see below) in dw_pcie_ep_ib_atu_addr(), and would
> > prefer to keep the code simple as possible since this is not a fast path.
> 
> The region align check in dw_pcie_prog_inbound_atu() validates that the
> addresses (pci_addr and parent_bus_addr) are aligned to region_align
> (min iATU size).
> 
> You also need to check that the size of the region mapped is aligned to
> region_align (min iATU size).

You're right, thanks for pointing that out.

Koichiro

> 
> 
> Kind regards,
> Niklas

