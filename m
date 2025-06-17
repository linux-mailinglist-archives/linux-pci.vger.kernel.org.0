Return-Path: <linux-pci+bounces-29952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B06AADD85B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 18:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717C94A2A0C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53412ECE88;
	Tue, 17 Jun 2025 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cSThR08J"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0132ECD33
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178187; cv=fail; b=JVyt2FWQMPq44ILJiJ5BiJX4YquYFzjeltGSbdJZTHvWjsqac/a+mbhHnuPeCWKQV9DhSyB7JcT6J9mfRcyDVvRsB+01Exn3ogu1rbCb437QQq2J4jNBqf3JWaVlnHY0k/0RyHJa0rZXUhNYGxqe8jIDKoG/h7QNvPC2z7BF9IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178187; c=relaxed/simple;
	bh=VrNo75tXGjKJh6xSOZZJOGlgg3yhLBvpLUTVD+W4rsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HXNAu4sm4roD46Al08Ox2WhGM7DuEcb5ecoAx6rud2Tq2BG7fu4w8QOEKG6k517QCFj2y8tLSRgGEYoVedIsGurUo+6ifHFbugc2gYkyeADYxE6YoDivX40vJ2R3y9lCE+897yxfowL9yDRpUsTyrZND1R7tnOI4uBwBbBwvgak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cSThR08J; arc=fail smtp.client-ip=40.107.95.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmrRtIk/WylYLPx7bL/hQfCTdzzRBthX3Jof1px/8jYKJpzbRnjYqfUgmphMB0S1Ax2xHRqlTZXA3uk76tPCYkkJug6rDaUyAAQifKkMORReC+uNJXjSLpIXA7q0bwWkZVZB6cyYjUt3fax0cLBkUHtGNNbKPPOMDsI7pQfR3taj3RiTe6f3/LwjqdTG1BBJAjSXCLbZms10idZBDvTi5vHvwBgnieSAVZevwQPoVpbq3r/CbF4s4hxvFoxlCtY5fsOaWu3cWqKwVcozVfCrM6tkftKFqtFmc0JqZencLygySRAvod7MQOhQRMDM0bGElPyXRrnw9sO3vCzoCM/ITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQ4jxbKw805IMRoXi09/tvf+LmAoYnuvR520seTMsXQ=;
 b=SMj3z3rBAygaMQVCW+Rd/18mJeSaXU43hXyOD6T+N6o1EHn2en7jWhMrX7sXGz/AlCV6XlLrtE5aOoJC4qeYx+Jp83a7g213VJhYHFY1XyJOrJ7tTXKoViBI+b0NSgMoD4rfU6hj+S/N0PFgzijswHAjUtSn3V+8gUWDelf0cTXQyU3I92aMz5ZzQjiiLnnjMOjj28Kdp5l7yWIUPBEAWA7xxvgcwV7C3TUwfSyBCDXN0j7Wcp2ygWMnTANErzlAv7xVNMn0t2ReYNj3FAooKEzaD0TPl6tXTCvFVgy1Md/oIJSbCCTR8DugGMkI/0mXEt59wXKIBpEnOKCFU2t+/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQ4jxbKw805IMRoXi09/tvf+LmAoYnuvR520seTMsXQ=;
 b=cSThR08JczpSdz09cGxVh7uSUqMvBvsusqYJiud9E6KzDjKQ2JAEzHuOrARN8DKoP/5onOOzkoLm2qX+lgfK0D32ohUobtqx5lp64t/N9lfBpAj+q/2xsFI7nIkp/NkghO97KuN0kLTYWA4tpmayETTUcElyJLDD8B2BmstVfA/8nkjZjdA583L/7UdkD86D57Wv2VqtVtlBSee8TmKroRekBowCpuyZOLdr01IQ3b9xYnJYFWByckjtrgjdTWJfCSAxOXRY9EQVY3Xqbw8AZ4Q4QCb6LtGXunRodihFwwvaNgxTemh+sCDyiADyhQkAcLaH6r5q99ATziIbRnjP3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 by CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 16:36:23 +0000
Received: from IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::50d8:c62d:5338:5650]) by IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::50d8:c62d:5338:5650%5]) with mapi id 15.20.8835.026; Tue, 17 Jun 2025
 16:36:23 +0000
Date: Tue, 17 Jun 2025 11:36:20 -0500
From: Daniel Dadap <ddadap@nvidia.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mario.limonciello@amd.com, bhelgaas@google.com,
	Thomas Zimmermann <tzimmermann@suse.de>, linux-pci@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
Message-ID: <aFGZhIS4IPxyjPCE@ddadap-lakeline.nvidia.com>
References: <20250613203130.GA974345@bhelgaas>
 <5ae2fa88-7144-4dd3-9ac6-58f155b2bc36@kernel.org>
 <aEycaB9Hq5ZLMVaO@ddadap-lakeline.nvidia.com>
 <aE0fFIxCmauAHtNM@wunner.de>
 <aFAyzETfBySFRhQC@ddadap-lakeline.nvidia.com>
 <aFBs_PyM0XAZPb2z@wunner.de>
 <aFGPXDfOkjiy_6HH@ddadap-lakeline.nvidia.com>
 <1b166e77-4151-426b-ab80-b4c34303ca8d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b166e77-4151-426b-ab80-b4c34303ca8d@kernel.org>
X-ClientProxiedBy: CH0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:610:b2::28) To IA0PR12MB8422.namprd12.prod.outlook.com
 (2603:10b6:208:3de::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8422:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a342fc-553f-4ca1-648b-08ddadbd18d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9GTrzm+7e1SEew55mlIL3enicLYCzQyTOaRH3J5EhAz7L0n2GeVZXwLfxUbR?=
 =?us-ascii?Q?iHxQDlFYdyglk/B4nIXRJIJCX5gQNm7VzOKz73Qidx5t08HfRFtci+E4/NuV?=
 =?us-ascii?Q?rhR6PC3p00qoaB966F5G+81kPqlBflM+GeV8DhT9b3fnwT2rXvCJF0OkQHUk?=
 =?us-ascii?Q?h9737WesxvBwPoAowvS3BNgonv2oKhI0wf4zAMkSJs5WEpt9K/IJ8KAhBxko?=
 =?us-ascii?Q?X59cIJT7/H6uCJitIS/fuDHnDr1Lw5MVg6s2/09VbEnSNeWIqE6vEa5tJzMO?=
 =?us-ascii?Q?rNCMNO425PJp3upCQ7WTr2bRrAoKSgP67c7dBeKBTvf0H7glz6TuGbkbfMUU?=
 =?us-ascii?Q?ePhslS8py1GixMovPSiuuG5xPXgQwVjXOyOYrMjIpZqgq9VGNWhM5ocl5jC2?=
 =?us-ascii?Q?ym12AwZ1zT5htwZYvEMJg/Em2AaOSb6dxhYlLoJ8RBHizVEtuHLEzl1nIyBr?=
 =?us-ascii?Q?VTGJ8BeOLYfOZjKQRnJYdinRoQ20hAkLdPb9TNG1HUR4HxbXBFPoERwu9o2A?=
 =?us-ascii?Q?r90lCfUS2I4xxSxxdu622FgYaa1aAU6W4yeIZ4ctr3tzmfUOUy8/bPTCorzn?=
 =?us-ascii?Q?JjpmU/9KPN95nMf8QdaDPlKUJwpw3nxaHsJPHQvq2GwoGF75otyLq0IjbvzD?=
 =?us-ascii?Q?XFtKhn4/yiR7Zkl7e13sDgMFaN9NFrC0r/yGFd0Lje55P2vxpQYj+M6ap6ku?=
 =?us-ascii?Q?oBe/nLa91fGgj7Nienl3X4wHcu2lefrCqcQX9P6ULIJB5YJtcMJCWunr79HE?=
 =?us-ascii?Q?1om/qGRuyFIFX1Eb8kcRuq5AWD5PUedwUd1nxKPn1/muobqvdqr8/DkiSXsJ?=
 =?us-ascii?Q?fSxdiaDP9UMGihXMtqPTZURYApXarI9OUK/krgS8yEWi6fE7ZYRYkUfmMSXz?=
 =?us-ascii?Q?OUNmEtlK0/fvNd7ryxjIz+eBORQ4bQAiA0pXMiehtweVf3wn+wvXYNY/w9Xy?=
 =?us-ascii?Q?VjX6TOChizRf1LneUhThLMiG9LSYrPwpRLqwlgrH4m3L6bpiGwrh5NdRi/q2?=
 =?us-ascii?Q?HlUO1RQQcXyoCOZhed9WyrWgLbB2+54zhzWzRcYtNFWdNacgusUWcTn810lS?=
 =?us-ascii?Q?M+CSJiLzBgMSAY15UOKewnRDPRPDwZEQz6pQCz6DVzyjciAotJ9x00Fu8KBU?=
 =?us-ascii?Q?CtNMq+wTg2t3l3DXhE/+dCxP3hemT7JPYMy0h13RcFd82icbun3a5LZw7wdj?=
 =?us-ascii?Q?ULs3caYinVZs1LAw9Df/9zYRnvCIr1aPcnlTjU0emkNEm2YkLbseRBB0qI9u?=
 =?us-ascii?Q?kTD7gkLm5XyeyeaZ6pccv4pSz0XyvY/bPqb6i9LdPMZTbsP2kliQQ+UsJJ2u?=
 =?us-ascii?Q?2y0Th+YggnbMOvr9iHqqHaf3juj5Tg+Lvc12waxineZlHedlKlfhht+eaLLZ?=
 =?us-ascii?Q?oeQkrmIKQ78OR6oeqBeVmmRjOQ3BGuHLTFrqADs4vbHG5brn1OFCHrs99Ubd?=
 =?us-ascii?Q?4JbuV5dfR54=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g+M0PahmDNnYSK2EyGAADsY4oN71DJKg+IsJi3ZFcFCK2MjHsXGEOSYrz4gV?=
 =?us-ascii?Q?FWku83sM7gZK4H7PSmXh3x9aFudSV+X4BZyUKwSC/e/olzekOY284NIJWt/l?=
 =?us-ascii?Q?xlVvx9lmS0nW+eZ2QCro04pcEyG6eo/3KQrc9KOqdxACvM7DzkfZ4F4QBJtI?=
 =?us-ascii?Q?u59afDIkwF0LmOE+r78Jjx0d/x/2N/XpFLENlkcaJgB+kXbKYGonP7OSqvJi?=
 =?us-ascii?Q?bMkITjCt5Oria++nelUyAbFml9EGL1ByMs6qHK59D1JKtfaR9NH5I4WnvfR1?=
 =?us-ascii?Q?NL0oJ6uNFHBB8DyAhq5aiEGihPXAMEbzxlug7Y1KLdpR4a2SsZAolH84GFW0?=
 =?us-ascii?Q?EfiIXMdX84zLWTUkOveXFs38T5ImV20b77jnBL8FK8PbtnfN37eRSnm9yV2K?=
 =?us-ascii?Q?71HccaKIG5tKIWvFJpLeSnIP+C/1L1CkEmHNCPLyYZJlagtqWUQ3nXOGjYDc?=
 =?us-ascii?Q?H4QzHi3u22mT3GssniYCT7ce5GJJtox3Ths2/5PTxOohY76PIxi0HDRDr6IK?=
 =?us-ascii?Q?tpJcdeZn/RDutbS93LSZrPh1WuQyTFVBC6z0JY6Toj+nPueEVvJeDHOtZ5WR?=
 =?us-ascii?Q?8kzYIE4k87noKIJsI1t6nM4ZJj84x3d3/lZiKAex9oiOq0vRh6ZeYOwbRn0b?=
 =?us-ascii?Q?qzmXgwySvfkX2+jrUq1+yqnA6E/g7/U8nTf2ND3j3FsrEnBA3hBUcRT9wkgr?=
 =?us-ascii?Q?ssfnYzwXQTPuWiX7KcQE4Woib8C9CrROHVTvYcRDYDLqFBDefaWWGAGHTZkK?=
 =?us-ascii?Q?20aqyjUY7RFydQiUXYr1hGhekE+SqiSJS7AXGYPeGkzIJIGpYR0wWJ3Wmoad?=
 =?us-ascii?Q?fbrLQmVAlwX7byeUG4859zk3eVf9bG+KnM1iKVVYM+QjyuAHY7CkDKrVr9g3?=
 =?us-ascii?Q?MShC1TWW8mfp8Rt8hkeUTs91fxHsm0rcrR8a7JUmmp521F78xH2EF2/qrdGl?=
 =?us-ascii?Q?FA7ZzG3Jfo+Wo2SPaWEN3tpfl9fthmJfugcoTxkhmHUW7CBki4t5ne6xql4I?=
 =?us-ascii?Q?pfSfakojbgKSpD8g/wxWWMIdVhZMGzc9zVmNJljYYQgrR514nTDJQvA0KiAp?=
 =?us-ascii?Q?xHp4WZ9DiyeTF4TVRojt8/5QtGML/OkaKbQG+S0KQizz1ua91lKcmWp73SLw?=
 =?us-ascii?Q?iofdAAR7H3kUHYkCWzUZUfWBZ2Nuw9w88OtuMNbwklWNOCPcU2IrHV4yPKJW?=
 =?us-ascii?Q?laOr2jhK2YkYVtO9XCO2F9hGSLtMlzYhXiuTCyI4+EzpM+r6Bx6UDZfbruMx?=
 =?us-ascii?Q?pbA+dhlRgRg93KwaLgFtUUQe2OCg8b68NcbN07j24m6zAuShzXiQt8CAHvzy?=
 =?us-ascii?Q?7axnC7BD/VqFIF0Vi+4agrR9Lnj+YS8OxQD5cw0giWTsd+KZ7jpJLfz8kjKg?=
 =?us-ascii?Q?78fb8y3fjUhlPnJNHsp/5iiMEe/DUuU5FzaVDnbdeqZ8TKZ2pI9teYvBZK88?=
 =?us-ascii?Q?dVtp4dSIBjrjX5GmlBNkedEJnB3tXKsOQHZmtHB8Y4itFhxuWBqn8ZOa0dfQ?=
 =?us-ascii?Q?Xxns8epAidvpq81KySsZ/a02JoYd4b7qfAm/PixOhsGhlx8VSC61jOVGW/fn?=
 =?us-ascii?Q?YlUkfkpr3ptJlU3Xi+gtVkNXndtpxYszSa+Y1Brl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a342fc-553f-4ca1-648b-08ddadbd18d4
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8422.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 16:36:23.5465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGH8q8YD02A7P75ugIAMtY/UJKpIv4gmfIQc2mTeflCj8xnYFpHrswGh3xkd/V79DWXa+7Y6pOqGODkVM6/DGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790

On Tue, Jun 17, 2025 at 11:06:00AM -0500, Mario Limonciello wrote:
> On 6/17/25 10:53 AM, Daniel Dadap wrote:
> > On Mon, Jun 16, 2025 at 09:14:04PM +0200, Lukas Wunner wrote:
> > > On Mon, Jun 16, 2025 at 10:05:48AM -0500, Daniel Dadap wrote:
> > > > On Sat, Jun 14, 2025 at 09:04:52AM +0200, Lukas Wunner wrote:
> > > > > On Fri, Jun 13, 2025 at 04:47:20PM -0500, Daniel Dadap wrote:
> > > > > > Ideally we'd be able to actually query which GPU is connected to
> > > > > > the panel at the time we're making this determination, but I don't
> > > > > > think there's a uniform way to do this at the moment. Selecting the
> > > > > > integrated GPU seems like a reasonable heuristic, since I'm not
> > > > > > aware of any systems where the internal panel defaults to dGPU
> > > > > > connection, since that would defeat the purpose of having a hybrid
> > > > > > GPU system in the first place
> > > > > 
> > > > > Intel-based dual-GPU MacBook Pros boot with the panel switched to the
> > > > > dGPU by default.  This is done for Windows compatibility because Apple
> > > > > never bothered to implement dynamic GPU switching on Windows.
> > > > > 
> > > > > The boot firmware can be told to switch the panel to the iGPU via an
> > > > > EFI variable, but that's not something the kernel can or should depend on.
> > > > > 
> > > > > MacBook Pros introduced since 2013/2014 hide the iGPU if the panel is
> > > > > switched to the dGPU on boot, but the kernel is now unhiding it since
> > > > > 71e49eccdca6.
> > > > 
> > > > This is good to know. Is vga_switcheroo initialized by the time the code
> > > > in this patch runs? If so, maybe we should query switcheroo to determine
> > > > the GPU which is connected to the panel and favor that one, then fall
> > > > back to the "iGPU is probably right" heuristic otherwise.
> > > 
> > > Right now vga_switcheroo doesn't seem to provide a function to query the
> > > current mux state.
> > > 
> > > The driver for the mux on MacBook Pros, apple_gmux.c, can be modular,
> > > so may be loaded fairly late.
> > 
> > Yeah, that's what I was afraid of.
> > 
> > > 
> > > Personally I'm booting my MacBook Pro via EFI, so the GPU in use is
> > > whatever efifb is talking to.  However it is possible to boot these
> > > machines in a legacy CSM mode and I don't know what the situation
> > > looks like in that case.
> > > 
> > 
> > Skimming through the code, this seems like the sort of thing that the
> > existing check in vga_is_firmware_default() is testing. I'm not familiar
> > enough with the relevant code to intuitively know whether it is supposed
> > to work for UEFI or legacy VGA or both (I think both?).
> > 
> > Mario, on the affected system, what does vga_is_firmware_default() return
> > on each of the GPUs? (I'd expect it to return true for the iGPU and false
> > for the dGPU, but I think the (boot_vga && boot_vga->is_firmware_default)
> > test would cause vga_is_boot_device() to return false if the vga_default
> > is passed into it a second time. That made sense for the way that the
> > function was originally called, to test if the passed-in vgadev is any
> > "better" than vga_default, and from a quick skim it doesn't seem like it
> > would get called multiple times in the new code either, but I worry that
> > if someone else decides they need to call vga_is_boot_device() a second
> > time in the future it might return a false result for vga_default.)
> > 
> 
> Right "now" on an unpatched kernel it won't run 'at all' because
> vga_arb_device_init() only matches VGA class devices.
> 
> Both GPUs are not VGA compatible, which is what lead to the patch in this
> thread starting to match display class devices too.
> 
>

Sure, I was curious what vga_is_firmware_default() returns for each of
the GPUs when run, regardless of whether or not it's currently being run
in the existing code - I'm wondering if vga_is_firmware_default() can be
a better tie breaker (or at least a first line tie breaker) than the one
you have now which tests for iGPU. I kind of went off on a tangent about
vga_is_boot_device() being possibly unreliable for a second time caller
when I was checking the callers of vga_is_firmware_default().


