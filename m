Return-Path: <linux-pci+bounces-17661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8A09E3F62
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03B61652EA
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 16:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F274A28;
	Wed,  4 Dec 2024 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y0LVWFM3"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339A413D26B;
	Wed,  4 Dec 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328666; cv=fail; b=g+1xpdThx8hMHQEpdTXeV3K/PjPWzLH5RPLtLvj0RHWPHv8OIFNZWonve/z24xNSYkb25zQ1vACx1qRDpUuyO7SrVjDWaSdRhypN1MAe6s/sFz5GdzmP1QlNFj+TSCAK4Grh8Hd4NgRW2HV8KvvKJKkutthErP1hY3JczyhzeZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328666; c=relaxed/simple;
	bh=aGAMPCJe/RVQiIlYIMuFlvCVyxBNA2NRH7AepZB9Miw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rHEhpsAVz+48okfqRXhaYnKIBevgOVHFsM4DZbxoleoq0Mlxi/NNW18u48V/h7FTkYZk0cu/VdRaUhikIewIy7fMUmIAF/DoWkv3DSdn3c4dsVZTWr7Iljbf0wRDkedbiqoOXgugisqW5ivJC0XTTD8ydU/OmML6HQ4RB5WnSnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y0LVWFM3; arc=fail smtp.client-ip=40.107.247.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHZdfkL0ofXis992LBQ0GHfoS6zIi3XmP1TCI9hBf33PGefqm5U9GGS8mHAR+da02JLkD+vydZ1JwjDW9o2Ckye4djfVoMrSg7/N4/SuKQ5skPSTLAUmTnHZJn46Kg+huO/9yr4jDL/gRa/UU5ubPJevLc4gS5n1kst2j5b+b6sPlGFkS+Zz/1Q2Wb144wmv2g+VfU9pVKatbAQ1JDRmMGIev0a8DjGnqM3mWe0DQMH5RqDO/B17FHHXtme637Kt/M9uHLasL4TFPh43EgiGi1/ga6KOITBq0t2rkl+ssyLKcG1eGBHvR27fatVUNZomBcJ0UuAOiE66PV9caPK4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iikz7A9C/EX5VHh3KKnTNKSAFoDdZgJ9izz3Y+AxVQA=;
 b=ZJTTGEzJygqTwQtCPEr2NYrOGBU+1EUyflKytj/bCDGVNJaxWqzhbfsVAD5XqqUoJMCxgGElEWVro/ebJeZXOOQsHxfkIgCjWwVLdMKt1YD0atXD3mDwCQ5jGJEYWx58EVm+j3a3vDdEBbuigQ6+zZtAWhvEyonAHP0GCUg2DHtsWOZfBPOuLW84iWJkdYGnhABZ+cC8xRyHAcTO+RiXgRtd2kVaB6AFE5tXCKxPGcdgNtjykl7AgSH9SFqME9o/uSoDvWji5iXo8TigzRBUXgW9KwtnRkEqY2rkQf0pJJ/u7wIvq+mgsapirFTMSFTp2icypXROFhNZ4vHUtYDAWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iikz7A9C/EX5VHh3KKnTNKSAFoDdZgJ9izz3Y+AxVQA=;
 b=Y0LVWFM39sfWppP85u5kI2RXRwRmcvKeUORP/c95MFkkXOuMZx7JXusTqIqw8aUj861fCOZNOS67VpClrlfNSnSKkykfKZw/MWnDaqPWjZJh9SnjN6X5nxzKJwBSpZB/FXsclgCZ6HIpMQkygOm6G1S160X0Q2lffwowdjtkIX6QHm/EYMwg5aMBYGD3VR+UEJtzBTxPTmGXDpIW++sGVTRLvIYUVX3GeJDuxrQ9hPTfqcQb796Utvs+g3iMM7YsLZd9GTIXwZWVlEjeF9u0PnPMzld+L4HWE1gztv91yah1lS1kmdJYOgYszs+n3+Ljx9TPWHkqUmJR83Gm8yl+aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8838.eurprd04.prod.outlook.com (2603:10a6:10:2e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 16:10:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 16:10:59 +0000
Date: Wed, 4 Dec 2024 11:10:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	maz@kernel.org, jdmason@kudzu.us, stable@kernel.org
Subject: Re: [PATCH v9 1/6] platform-msi: Add msi_remove_device_irq_domain()
 in platform_device_msi_free_irqs_all()
Message-ID: <Z1B/CuivEIT9HR8c@lizhi-Precision-Tower-5810>
References: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
 <20241203-ep-msi-v9-1-a60dbc3f15dd@nxp.com>
 <87y10wsc6z.ffs@tglx>
 <Z096wCMFmR7AyfWn@lizhi-Precision-Tower-5810>
 <87plm8s6jy.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plm8s6jy.ffs@tglx>
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 03acfb47-b89d-476f-8b7c-08dd147e3dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?conHEeOveDW7D4y8EE/DSQJAu+kCDbvv0it5ygGWYtg163LLKfzWxeOLGKE1?=
 =?us-ascii?Q?ch1srzlwZNYYvT154JLqeRb+Svtz1RUy4MbD1otWwf4tSGEdJwXqK9dG29k3?=
 =?us-ascii?Q?Xs2GJ1dKu5ogDPKYvqc34YzEwMNHG7X9rODSbDQEKT8QfuTe5JCBSl1bVyjO?=
 =?us-ascii?Q?dZdHS8Bf1EtRtL4cJJ1SefivTOgTuC9a6FNfGD4p3VEhwg1dx0Ir8+peC/Xo?=
 =?us-ascii?Q?suIoQ7F1IaBfEKDvCfEIbBVK05KCeeYcwLMfiDqr/aJI0gar3MFJctXoQlOF?=
 =?us-ascii?Q?kcuqiX85SbAW+a2tNTb3c9ujCGRxwhWEPnB1wnE2PGeqe79fu/Vfui/tmp7F?=
 =?us-ascii?Q?FglON/lp7O4gZI1OU4Arm9YD+NZ0X1jzZO/iIBVFikCWhdRi5qy/W9us95LM?=
 =?us-ascii?Q?eT8HFMWfql0BIUmchw/EqAxeG+RVDo4qywOQltvs3CIM3C6M5qxyQmhhxIlI?=
 =?us-ascii?Q?TYTE3RQqut2xreJu0oeDwIeXaHeKPHrHRfKrjpTsVtwxorQd+opGyGk8jrtV?=
 =?us-ascii?Q?e9DC+kxS/rawpbDs5MNhQLlKbZqyCkuH+Y5q/txdVzJcoJXBO4Y32zuZp3jW?=
 =?us-ascii?Q?hBsojKdjrPMQQxBv4II0l0HNBHQOBK0forhj7jojnAjx6aJeef8FAQYorOTx?=
 =?us-ascii?Q?JmfKTRFVKTFbhesLRphftlgFmYYWUN63I8RV2wnSwn8VqCzuKvn17UccgdCN?=
 =?us-ascii?Q?BZDcazc304x+XVLSTJSeeS6VKMl2T4OWZ1DB61E5FBiPDPwqST2eAlzMT6zR?=
 =?us-ascii?Q?e4NPBIy3tE01lhmVhIR1TK3v4zNo8+YA8sKJzkkhWmbKq+dNxDDHGbw4nSDy?=
 =?us-ascii?Q?kd7M+pCGCKopyM9iauWqMLUWRfo/9DVzB4f8NeKPUY2pqsv9cX2pPJ/DtiSl?=
 =?us-ascii?Q?6x71WErlif20gc4B72Jub9Z/FzAAwE8bES9qq/d732P1KJbHGjxpQzXqbS7I?=
 =?us-ascii?Q?CgbEq0tDxM36Iq2L8xhKa/rifGX9ZzaKy2OgWrp356ao8VMjivH6aXhfkW2U?=
 =?us-ascii?Q?WoR0zQGveiDbKp5z1PeocZIZ7V7/c4puwTnZeL12PrxgjAwFCFAmAjUMT5n2?=
 =?us-ascii?Q?DjkLNGie6XZb5b7aFLLymXFebNPqx0YXerQMY8Cw4z1EX0eHE5kgAb68jf4D?=
 =?us-ascii?Q?aLBR/FuEzSoaqS5fRiG4uj21zXHrbbx4DESmpyAT8dfyuNmSgBB/W0JxyLFF?=
 =?us-ascii?Q?NSv60pgeEZqJUHIv+pIcpxqMM11kqEJFIX5snrrE9XKHWXaUAY86kSQuTErp?=
 =?us-ascii?Q?F2X7ZBLchrkT2d3Vaf53cYga6GwjcxdKogVrgj6OlSq9F/o3zTGYvAKG+tse?=
 =?us-ascii?Q?x6xs3LNARIDZVm2hog/CElj0be7X2FQqNq6UvWW8R5iDfBQ24FmmEyFyWT6s?=
 =?us-ascii?Q?jmMxKgY3Yzju72fhkjhRlhFhXyBOUZ0IB6HePmdi3scxhZz3Rg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YZ7Uu47qgpmwcYfSs9nsZomYwqTjqB+O1PG6lWDX9goo+6YzghLo4n/gw2z6?=
 =?us-ascii?Q?jFYJ2B26GMoeK1PjbHMCLPuoS7O/uvx+WTznjfTgYOQrV3s6MInDQnB+mF8d?=
 =?us-ascii?Q?CqLWVVlN6o9TGU1d7S2xTJ1s0wuRekXIcBnTXfq3mMTevjBfnuO04ISXpSPl?=
 =?us-ascii?Q?UZUa4XlXtmaRvcfHtneibsXMfj6kSTlePiaNA1UFygd0/rXUGDKKXeD+dcrN?=
 =?us-ascii?Q?QaIixYJbV/cxTjNqW2xEQeuz5aopwRmFSzTwoIaYF47eOtV5hi8yjyenzum+?=
 =?us-ascii?Q?M0f5bCPb/L9RRitdS8DG99b/5XBPgbuz1i3nunSCuBUkpzoEFcgpu3pRvU+L?=
 =?us-ascii?Q?VUdmFgY844YWgFqCiNGQVwRUi4VQcRfHc7ZR59aSFeSLzntZxO7l8Zp4RkG2?=
 =?us-ascii?Q?8emDCx9FOGosKQQg9UA+bBA6ScooEnMwErzZfQ1CzjbxjoZ+Mk5Cgc8KRBW4?=
 =?us-ascii?Q?rdT8BZwrr6kT3ejdMFaOcAfLItK+lKsPWOmGq4vhbh1hm7KAgkzLo0zr5wNc?=
 =?us-ascii?Q?gT66p3r3eSxaKG2kAzohMgSC4AGbkptT7fuohxK8WsNv7T69DbCaNigL+nG8?=
 =?us-ascii?Q?oM4g+ZK5SyYwdm0UoKrghbboTODXZX/t+chvAfFqw5ze8Ex8cW9YsQ3PyjKf?=
 =?us-ascii?Q?gb2wAFSanl6dStMUxeVH1RwXLsiZWuTN8oLn/k0oYgl+i63Td86kaouFrdBg?=
 =?us-ascii?Q?FRSN8+4hD5VxgSSTjrx3kEOvjoSXx5alEB+gT9UoloeOWZdHSIBr+Cyi/q42?=
 =?us-ascii?Q?T5KlskjFG6VQ+PGMJXcFE99J+WMhTY8TMK7Rh2jf2uUwKf2SaVaN7DaTjDM9?=
 =?us-ascii?Q?zHFpKfqlO2WHCcVOpTfwoh2cb24Uibscl/LFDtLJRZjCBmSOTyYDCO067HsS?=
 =?us-ascii?Q?NeV2n5V6gvkpFSE8bMPqaqnZMaAgy/VEr+TLzQR9opFOGZfUgzq5Unie8Jjo?=
 =?us-ascii?Q?yZS/XVkSiOB6n4XrSVJ7zd8bPUyTMK376YVIcu45SDQlkGkuN1FmuVVOj2rL?=
 =?us-ascii?Q?Fj9h7lPkyUUZ0D6CiGBhMVt2iBgMCKEGtse11kTltdqPbaLyzaQZLePB4uoF?=
 =?us-ascii?Q?Xq4P5a2mFbAYcU/e87iIu0CYK1vjxWjKD6koIr5wbo625LWljJSmIcVr1HoZ?=
 =?us-ascii?Q?G2zr0ERaAswdADoChc/OsyYFUhRaiCyGoJPktj4O0XhlCoshIQngJ8oCUn3b?=
 =?us-ascii?Q?ZzlGwh1Yps9X+Hq8gjch2WJSXG4BSdl6G/3/3XbzdXieKCTASLWMYVlXoS3v?=
 =?us-ascii?Q?xFtu0GfJhGJktttvlD4Ouf5z29nSe2NlT1uHsDAtX+nlvC0FpCkEVHvLwasP?=
 =?us-ascii?Q?BEPXef8ko43CrKnb2PH+zPRZuwmKAHVBqGTOPOVAYcS0IfoDmkPYKhcb6nTq?=
 =?us-ascii?Q?qVShPl8MVh1a0u1yWVQ74Wv1h+OzoG4CvR1ue5Ss5bfiSnuIU92ToDQYhysk?=
 =?us-ascii?Q?A0yB3wAd34dxzHX3wokVnlDSRtgTHjVXShfBD6U8HH82f/E3ve9PHHDZmZns?=
 =?us-ascii?Q?u/ulCIzYXKEcn20ltejL4ZjVjlZ9MmT99MBbDCE0vmSMWFkCGWTl5mAND37f?=
 =?us-ascii?Q?+X40DWQwJzYDVeHanT86vw9pvNGLQPC4H12i9LcH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03acfb47-b89d-476f-8b7c-08dd147e3dcd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 16:10:59.3756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3PwiSKELxTYIJPog21LeUIIkwAbwvOWflWmThZ0tCLLjs0GUAQkWS4fMG6AoBQhkWFwsdWyTRwFexL3pEpj1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8838

On Wed, Dec 04, 2024 at 12:14:25AM +0100, Thomas Gleixner wrote:
> On Tue, Dec 03 2024 at 16:40, Frank Li wrote:
> > On Tue, Dec 03, 2024 at 10:12:36PM +0100, Thomas Gleixner wrote:
> >> Sure, but that's not a fix and not required for stable because no
> >> existing driver is affected by this unless I'm missing something.
> >>
> >> What's the actual use case for this? You describe in great length what
> >> fails, which is nice, but I'm missing the larger picture here.
> >
> > PCI host send a door bell to PCI endpoint, which use platform msi to
> > trigger a IRQ.
> >
> > PCI Host side				PCI endpoint side
> >
> > Send "enable"  command      ->         call platform_device_msi_init_and_alloc_irqs()
> > Get doorbell address        <-         send back MSI address by shared memory
> > Write data to doorbell      -> 	       MSI irq handler triggered.
> > Send "Disable"  command     ->	       call platform_device_msi_free_irqs_all()
> >
> >
> > At endpoint side, need dymatic response "enable/disable" commands. Of
> > course, I can call msi_remove_device_irq_domain() in my disable function.
> > But I think it should be symetic in alloc/free pair functions.
>
> No objections, but that's not a justification for a stable backport as
> nothing in tree has this problem right now. You add a new use case which
> requires it, so only that new use case has this dependency, no?

Okay, Let me drop fixes and stable tag in next version.

Frank

>
> Thanks,
>
>         tglx

