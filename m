Return-Path: <linux-pci+bounces-2292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 872BA830AED
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 17:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1BD1C25B19
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811C3224DF;
	Wed, 17 Jan 2024 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7iF2jc9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3833224C2;
	Wed, 17 Jan 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508546; cv=fail; b=UdjN0Mm6J8WjuFHwtR8p1ot9nvwDCwv1Sag6dDD7tRzLn1BWyvkkEkRTHJbDAf2n9bz33EosN1fGiLes39mgSbtDzsWv9wNuu/AEZwFhNC1aabjRnpUvfH4Ii06Cz0dmCfBCIIQ6X1LgWm0PtAdJH0QLw8xnOdRWxTU25CexIns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508546; c=relaxed/simple;
	bh=uDtBYQxXnajckf5qMYofOs2JbTzwpra1i5RUG9MxWK8=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=knfDmHlFYKrRdhYrPhYMVWQOwMl4Jd6CRHBLgQ1PmYuuWeXqnODz7MX6mJxwgtU8lAlbgTMJ2S9DS94O0aXl+ybXF/n4up85+KUkB7/gI2dWHfcNQMV3ukeqfKArRM1Hq/O8JcalpN7Rs+6PQV7Jzp2gpu2H9W4skD5IAL20KAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7iF2jc9; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705508545; x=1737044545;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uDtBYQxXnajckf5qMYofOs2JbTzwpra1i5RUG9MxWK8=;
  b=k7iF2jc9F8L5K72rbxKa7rLWLjdcJSpemMqpHv0ownyhzJOzodsnpNLy
   vOWG33FFS0QQYE8mU3Lten+3S/a2zcYClF3U7ru0rzvdKEqBTMArfVsVC
   /poJuLGgEFiy13W4QiiFUVD4hXHyD6dhDdzYSXj3+I62viW+JNVhwAq2g
   ZblPosZo50RFlDaafUiR+poijVBFxMFahygpGY+G/DeFJK4KzVlxQLIv8
   wdgdrflpXLFVgIQwMOMkBG9LBecfW1ubPnuToXiYXpJlh3NJjlNyrP82k
   JuX5OVq+/EHmZfecy75jVUXKe8DBjR03J5fv2YMi/sFaABbYQ1D9DheFm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="98860"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="98860"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 08:22:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="1031385742"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="1031385742"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 08:22:21 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 08:22:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 08:22:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 08:22:19 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 08:22:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWYd6d8HWtiIB6TQI4HySqth0X1RlmzDcgg7o1ItJtmf6ZbOPrHkOmpbu59wNz8pBItF3CqAuPsmkm2cT2PSRZBeeHe5O2uLV2CfU4dQhRJiCdqaSncXaiH8hh/4PBQdPdOsibpcnVJwBDdsTw+xLlaNRgtaGsHwOjGoTVnG/qiLjmdjs9+OuoZSF1SvlYnv9TUkhZDBNO1g6+z1IpeGRL3yreAguASpKwCzuHkq2JBa7ooXlYQYOY8rlI3Gt5iIM5r+umaYrKZn0MxHFU2rnbhPFpd/tuhc3dpxqHf3+IPmDcsRCxsTpMdOceG48YN2ZGtlYB1aIVItWzMG13Y5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMUoLZAt5We2LMzokJluy44oVco4gwvDvkf2/mrDrcY=;
 b=h8J1SsYyTMT/enI5Xvjyh3ij8FBWPJ13//J1b8oP0Zqr92nfVe3qTe+WUiLupt42y94tqCRkP2DG2PV4nbgnHTTAU/itMb/rmwRB7UlMVkWNLiUJXwlSiQCKHhZUND9QZKxgvKdvLFiag+7fVTQs0qKwIowGY0m9f09CCx3rV/erVzmKr6ssumd2rmmcBdJxprnT5KiTfscHYYZIpOreUJiexHoftSAustCQNh5fFtRX0ULZ6hroiwFRXvldN4vouEk2DjkUrV09RzZFoWMDj0hbanaKqMRj1LIFU49MTKl8vncts9d3ErPfCSd3eKyVE3fv6K3w86u6W+5QtCNxsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7682.namprd11.prod.outlook.com (2603:10b6:8:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 16:22:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Wed, 17 Jan 2024
 16:22:16 +0000
Date: Wed, 17 Jan 2024 08:22:11 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kalle Valo <kvalo@kernel.org>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
	<konrad.dybcio@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Heiko
 Stuebner" <heiko@sntech.de>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	"Chris Morgan" <macromorgan@hotmail.com>, Linus Walleij
	<linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>,
	=?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado <nfraprado@collabora.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>,
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman
	<terry.bowman@amd.com>, Lukas Wunner <lukas@wunner.de>, Huacai Chen
	<chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, Srini Kandagatla
	<srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
Subject: RE: [PATCH 4/9] PCI: create platform devices for child OF nodes of
 the port node
Message-ID: <65a7feb3ea48f_3b8e294bf@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240117160748.37682-1-brgl@bgdev.pl>
 <20240117160748.37682-5-brgl@bgdev.pl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240117160748.37682-5-brgl@bgdev.pl>
X-ClientProxiedBy: MW4PR04CA0320.namprd04.prod.outlook.com
 (2603:10b6:303:82::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c9826c-5dfa-4a71-7e02-08dc1778787b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnKukjZH2k+wRbGKqWbEnYuEvNzQgstEglxqGzBgAAARKtGWL9tUsGh8BTNVDCrU6BDPUXqsZ6hBf4H33Eox80Ll3ASS3GtY32HRFZKYP98r6/qFoOSPkM2HH/jJk6VviHUtR/C11ORpb9v23tkQzcvapvr5obTDKSDx2zxxoLduB5UgibQbchVYe3l3CfoD7R7R7rmftovFNcfK4M0JAmtudheCzhv+BLuHQGd15tfFiEWRVlNcx70LbPyWeCV6i7MjezgAAb678Vvz088D+ise8mnSYcJcAzq4EL/QUTXiPq4sukA5dJ39J8U1IbBS3Mkh5AIskK4QHGrE3KkuwauSrl9KQA8tLYUudeTkM5mHZOog5hwFazENIoBoBk64/kQu2j+PcuVgVYNZs1KcPqbJB15g8fSbAB7bsNwFxnBAFZiNFPKOH/AzNkvVCwQH5GIojHNdNMwZsnDDBwUFGJqE8/vv1PgYKIP5QSVjEBl/Dcx1FfVi7CjJKZuCL7VJo6j2MVA+O/TDAFf5o1UXHiQJtpyrNpt+KeJQ1rT1aNd1Q7aVLnG6AjLIyNPpp0Cia9LBKpZAowdudpBwnXBoptdwP9sPYYd0XcfeptPsZcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(5660300002)(8676002)(8936002)(2906002)(7406005)(7416002)(66556008)(66476007)(66946007)(316002)(110136005)(6486002)(478600001)(9686003)(26005)(6512007)(6506007)(6666004)(4326008)(38100700002)(82960400001)(921011)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mMIaePo2uqTD+PltBnwHL9ZeQeAXqCo45ZAwbmjtB2dZ0Pwnqa/Ar1bPEurP?=
 =?us-ascii?Q?T7xACBtNtd1JgPtcjESi2kohliirQwD36+6AxT/BATAiLhHpmcuQQpbD32z6?=
 =?us-ascii?Q?lEmUR64deEt8jmfvHBTH4rrp02upV+QMg9zXu2jAY2e4nael3/oDFxbA5a40?=
 =?us-ascii?Q?e+6AcSYGdpFmp9DUMH1R2B8+a4qsOHu2GvQ/21GHhvHiMiHGxNfIzis/Rlrv?=
 =?us-ascii?Q?My6d6FmAF6g9/c24hpnp15DeqbV6MOiEahUoEZGU70Hy1hzF8dDlN9ExNEP6?=
 =?us-ascii?Q?2gParqu9m/we3PWKMEyQb22hyoyzEQ5STWXhakiDcC8sEq+aeX5qbv16LaLz?=
 =?us-ascii?Q?MCkKwG1YK/o6L1hP0s5bVJOzXN6prXfr9klOk1WHG4UsPH0wvTUjsL3XcMWq?=
 =?us-ascii?Q?x1I+SY567BobSCpqFaHSvHSgGkzy+gQ00tSpAs69tnTVlSb7MD+vNKpfBaAk?=
 =?us-ascii?Q?7mid71+NuaHB+Y4TEoghEeITmpyXw8THTmOwI1uaBiIGB5oMGaQXbLkVqSUo?=
 =?us-ascii?Q?nxGdHFypiEEGnLziQDnG7VqKx5kKPcRzxGjU2tQmpfKIS8QBJg60tU9dVNib?=
 =?us-ascii?Q?LHSo6bnOhjoB0xlmRfip6J9LVylE08A5hnueT9LQ+7oFx3EJc7pfOri98u+j?=
 =?us-ascii?Q?e/wvL3YDimB3QKEJkAn+YB92uZIW0v2pV4wCdzEazlCK6MxqdR8yVFFz0QzV?=
 =?us-ascii?Q?xqUBFi7zm6o/ojS42beN2ZzbIKigG1D9jAUNwf7xtBe3sSs4heZJ6hTvNLPD?=
 =?us-ascii?Q?24PLTYwmzPYQimkUdFy7LLhavgevP7mS6wQZIaQgfdDjPtF5JmvJPXTWpRLy?=
 =?us-ascii?Q?OUJjPsTb2XKgJ/u09MD08nhLH9GKP45d84HO5cVdiUiCJDiYyWXO31mJSQrm?=
 =?us-ascii?Q?4jPdKdpZWSdc45PFqep4bGJj8/2Uo0WiNkkszlh7NPespuGupS+LhAg+OCAq?=
 =?us-ascii?Q?VYUxt1XyqQ7JjyXKqvR6CzdjX5vRmsdxp89GhR5SMs2lBTzcMbrXo/cwWX4y?=
 =?us-ascii?Q?LSd34TRfyEJ53R8oAFn4L0YiwJ8lasp9TCe8mQXvWF7Mg4VP6aZTAtn25XDu?=
 =?us-ascii?Q?MLtKFWOmYRCKdxGiY5wlAcafYW7QVIIUVxaHJBltP6nvKI/W7gddLIkukj2k?=
 =?us-ascii?Q?pD2ux1wVvdDu0AUvgMFWV4b/I1RPAY7Cd4JHaV8aWD9sQhLw7EacYVwe5ElS?=
 =?us-ascii?Q?mavNRmFKviglrsoDD0AuWs0bLKMjjZGW5Y+CvG4PeHGTZ8EZQb3odT7QjSNR?=
 =?us-ascii?Q?vshh7HvkgRepYFGFqYkz9SUaV39U+kzO/mGZu430zzZ9II8Ni+gqvuTonpSV?=
 =?us-ascii?Q?qzhu4HpFlxEghZ66la1P+OPTd8iboiCUJC1qoI5Nzwe5uIhLqXMFmulnpdn6?=
 =?us-ascii?Q?3vzMTshSqMM9H33atyWWiC/uf+7tTyrDywlV3zvVNBrWgvmwxLqSAjAQzxMh?=
 =?us-ascii?Q?DhTOUNJEaeB4nuEjJRjP6mb1zUYohTteiEPLhyG6uqJH5C2S+31/P7d4VcjZ?=
 =?us-ascii?Q?NAjcl8n3XHIMPRpqYIpbhNhl56S3UxWp5QX4SImOmUAGbvNHutEDnJr39bpv?=
 =?us-ascii?Q?jpsAmDwtK6Q/NuekqJ+AgM3YTN77PdrxOMiiKIZQk3DaFagCg/ouQx4xnPwk?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c9826c-5dfa-4a71-7e02-08dc1778787b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 16:22:16.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0hb6ffoU59agTQUEH4SlJrOc5hx1liAZAI13dHrJO/QFHSwcDmOG7IDM5uFIl/PZVm8cqTqAxL6782/8zLy6DzYMNc28XgTx7AupdptzrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7682
X-OriginatorOrg: intel.com

Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> In order to introduce PCI power-sequencing, we need to create platform
> devices for child nodes of the port node. They will get matched against
> the pwrseq drivers (if one exists) and then the actual PCI device will
> reuse the node once it's detected on the bus.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
[..]
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index d749ea8250d6..77be0630b7b3 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/pci.h>
>  #include <linux/module.h>
> +#include <linux/of_platform.h>
>  #include "pci.h"
>  
>  static void pci_free_resources(struct pci_dev *dev)
> @@ -18,11 +19,11 @@ static void pci_stop_dev(struct pci_dev *dev)
>  	pci_pme_active(dev, false);
>  
>  	if (pci_dev_is_added(dev)) {
> -
>  		device_release_driver(&dev->dev);
>  		pci_proc_detach_device(dev);
>  		pci_remove_sysfs_dev_files(dev);
>  		of_pci_remove_node(dev);
> +		of_platform_depopulate(&dev->dev);
>  
>  		pci_dev_assign_added(dev, false);

Why is pci_stop_dev() not in strict reverse order of
pci_bus_add_device()? I see that pci_dev_assign_added() was already not
in reverse "add" order before your change, but I otherwise would have
expected of_platform_depopulate() before of_pci_remove_node() (assumed
paired with of_pci_make_dev_node()).

