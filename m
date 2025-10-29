Return-Path: <linux-pci+bounces-39622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFA0C194D5
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 10:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8050C5A08D1
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 08:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D0431CA54;
	Wed, 29 Oct 2025 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DeRdNmx6"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47C3101A2;
	Wed, 29 Oct 2025 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727135; cv=fail; b=AItDaQ1QOCjtHgjb9Qy32HKXRea++vSDsfM9/kWK9iEaAJjOiTfvAK1xk4UhThCr2lA6AC9ff0cmEjDFJ+q4lJoGFI41yLZ777J6AqUNKULnCJl0exNv9HcoT7/lu/SZ5YDjxp2gVD1lJmKYxxMXUW4R7u9rKYcBb6yFgIuCpBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727135; c=relaxed/simple;
	bh=GhVKN93JXa4TjOxPx+SL7syJSXu2Ujb5wX5x8TafGD8=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NUSR+fgY9NAajh9rmfZhkRzG5n1QMtm6ueddvqgci5sh5bQSj/A+GWGLIBA8wLtrqM6mDjtSVsGKw7YNQ/LOmfmrsppBUsGUNjTGirViJH1J815drJ/UAIRQVVXQ0h00nV1+E0iSdpOHJACzC8imxsXm8nLFh4WGcxsOeDg7C1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DeRdNmx6; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/dIhHnI7C+KU1SeR5TtxxKeslfNPgRD66jSy1YgVGu3IS+T0nHXdJCtkWQkb1OZGoqtY6rgjC2+DmM0vSsmQG/tc/L6BQulkfMkrZ9qqKr5ic1uQUK0Lg+I4CAd8IcwLbJgKZ2ZbjEfqZHWBn01h0Hi86uN7NLR8v9fs3KQFvqkskzx+6UJuqTwp8inmkr/fcAjsyDHs/IjzGnB+9MXBNU30PwClL6AvlXj3MdOXA9+ja/nfaGYWeKP413cXKk7YQrDRkdcGaJtpF1ny9BqeKwPGKyNQlVgr4Artj0Wr9tIJOy1DjUCIvUgBhqpUenN3PA4G3gqRE94PkTip/2lzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHcDHxpwSSGFkiWXGDipKp5DsicJvlZpSrL4tKHFmKE=;
 b=awr9aOmlPpJIUQv+fT6A/36LlGzpQPBDTlQvKH4fIKFajIaQNHGmQwLQ1Od8xMZzk2NzYdwBDWuXyR/ovIcbohqB1gXc15epl9IBnD4U22oYu+AnWXvN9IW7V+jOrGFoy33fIUAxO+CDL6O9JAH3Q/bDG4fpZpkr24u4j3cOOwtfr7EdO2/XrrHsJDPzZHOes3pUIeUmT2N4RL0SFZMiV6J0Fs7yZjcL9ys409/6VbWLKyYmDgpP9hGZKuXjBrtlQDaKx9ppSsuo3d1j52KiHg9VYGdCTyelA3OfYx2hZtxVTfG0IS0Z5xJCx8WjkGUdBz8/Q0UxAgeM0o/FE2ipVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHcDHxpwSSGFkiWXGDipKp5DsicJvlZpSrL4tKHFmKE=;
 b=DeRdNmx6CFNWAtUfHo4mydhrCYK7+KmO6UZ9iE5FYqL8HLtSQN9PR7XLgbyBosD6uI1j/pemNdvkX23U7rrB1+YcBMs8pJaLZ68Uu7xp0MjEqSTaGuH4B4uo6sEhA912IQ8VC7/mo7uHRATgUdZYtvmUy5OQhLRD2IXkFwoIU2A=
Received: from DS7P220CA0071.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::18) by
 MW4PR10MB6419.namprd10.prod.outlook.com (2603:10b6:303:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 08:38:49 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::52) by DS7P220CA0071.outlook.office365.com
 (2603:10b6:8:224::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 08:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:38:48 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:38:46 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:38:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Oct 2025 03:38:45 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59T8cf2O3719548;
	Wed, 29 Oct 2025 03:38:42 -0500
Message-ID: <37f286dd4ca58fba146b8a76738085c523d4bd97.camel@ti.com>
Subject: Re: [PATCH] PCI: cadence: Enable support for applying lane
 equalization presets
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: kernel test robot <lkp@intel.com>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <unicorn_wang@outlook.com>, <kishon@kernel.org>,
	<18255117159@163.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Date: Wed, 29 Oct 2025 14:08:52 +0530
In-Reply-To: <eed524b60b43bf22e88c40dd770a6b0bc38c44b9.camel@ti.com>
References: <20251028114746.GA1505797@bhelgaas>
	 <eed524b60b43bf22e88c40dd770a6b0bc38c44b9.camel@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|MW4PR10MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: e5103924-ea65-4acd-25a8-08de16c69494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|32650700017|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aC9WVk1QKy94UUhjUTdkMjN1UHF5bE82ZURNTmFyS21KWFhQY0kvemZraGZB?=
 =?utf-8?B?V1ZIWnpzYytlVVJwZEcyRDRTMXdVdWNMalI1dHNOSkxsaTRraVVlaVZpeTBQ?=
 =?utf-8?B?TFE2V2dGWkhFUE9DSlFuQVFOSzcxSjlmUmVMTlNuSHZGaXc1dGQxVmtFR3d1?=
 =?utf-8?B?cGs4ejYrb2t0QTIxRlRrdVRJdWpFMUt5UjdXOU5tckVDTTIyRkVBRXYwZmND?=
 =?utf-8?B?VTRMVWludzBGV28wM0xYS2RDeGJoOGs1WHE4WDV4L3p1Y1loYVRwR0UvL2VM?=
 =?utf-8?B?MCt6K3htNjEwaHArWFpTL09ab0VocWVra1JzZGtkNmlYS1d2RE1JTDM5MDNk?=
 =?utf-8?B?NG1mUlZiUXlZTHdlcnNJeWRObjcxeTZVdHZ6ZGZOWnRKb09sUjNaaWIwaC9P?=
 =?utf-8?B?NHVNL0RYMXVHK1RFbXFkUXhMb2pjZlZVK0VjYVppL1NpSlc5bWVvczc3ZVR6?=
 =?utf-8?B?NmVadEgyR1VJVWdLSnNxblhmSkxKSWVqWUdZTUxUWExtZ2dBeEs3ay9PUDdO?=
 =?utf-8?B?K2JFNGp1dHNaTzA2NUxkYUJhWjRYWlNUR0pCWGpQTzhUS0ZaL2pNeGhwaXNV?=
 =?utf-8?B?TUtQUy81ckVPaXh2dDJvbTNlckx6WEoramNtcmthejNDWlZrbksxN1JXVHo5?=
 =?utf-8?B?UGU0OXdqUXg2N2tXUkkyZUN1NmZPYXpOaU5maXRiTWZaeEUrNXNWN3pMTk0y?=
 =?utf-8?B?aThmSStoeWkwTHAxcGlnK0ZIVVhCUGhXWVpnNE5VRmVsYUJOR3p0WmtYTE82?=
 =?utf-8?B?YVQwbE5ONG44RkNZemsrTkJnZXpmc3VOaFBCTndtRmNEajQwMXZxUFdzQVNq?=
 =?utf-8?B?cTZFUGNSdGlrYU9wQXgzSExmOXA3cGM2cDZ5cE9xOWZtbE1RczVLbzhiT0Vy?=
 =?utf-8?B?SmJuaHpYZDRDaXVrVzArWmZGVWdxYTY4YlFFQVVHdEozZ3Jnd0NMczNrRDNv?=
 =?utf-8?B?bGpHSmo0aDk5S0k3Uzk4QVc4NE1vd0djY0EvVWlNZG5IMDdqMWp2ZU5EbWNP?=
 =?utf-8?B?c3dhNUlXcjV0ek5mVnp4WVN3bFNVamVaQWhqVzJLcE1OMDJqWmdwSEFNY2pN?=
 =?utf-8?B?ek5GenM5Yk14VUV4d0lwWGU0WUxjOHVpM051UEtZajBWUnVJd3dxUWFjZURK?=
 =?utf-8?B?RkFIcmw5RXRwbW5iK0ZDZzFzdGQ0TU1lc2ZJditCT011TU9TNFdiem84dGYx?=
 =?utf-8?B?b292WXhCQkgyUHVybVpGZWZvL2xvMkx1by8rNm9pWU0wNTlKZ003YXJLc3p3?=
 =?utf-8?B?a29jbHpTODdBSUtVRXJIOUJXU1d1WmZ6c2RoNVFicVYwWDJvaHVZU1QyUDN4?=
 =?utf-8?B?SlZCdWVSZm81Y1pJNUxlS1dVS2tJVUFrOCt6VEt5WWdES1JkRUc5S0NURTY4?=
 =?utf-8?B?T1BCM0ZEOC9pMUxwVmpGS1pQajVpck1iU1hLdTdSYSs2MEU0cHNPTjdmMGtI?=
 =?utf-8?B?VEpRc2ZhTXZuSjlHMW5MVEFNQmYvZ2xodTJzV01kU3lBUGw3S3dldkNqajVQ?=
 =?utf-8?B?OGgybnlaazY4TjZHWXg3Z0FWeTdjb1NWKzFxT0FpbEVyaUJCZTdpWDlIdUpD?=
 =?utf-8?B?ZCthSWNIcFpkZlMvT0JYQ3RadlM2bXRublRyNG92T1hPOXY0ME5mN0hCemRV?=
 =?utf-8?B?MkNTM1RoL1JUL21ieWpLUWxvNFM2SW9VSDZ1UkhuWHhJUnNtMnQ3MXNPZGVD?=
 =?utf-8?B?Y0Q5L3FBL1d6QWVvMG1FY2NuZ3oreGNTRDUxdlcreHc0WURMTjFnM0hqcmo3?=
 =?utf-8?B?ZW9VblhHUzBOdmoreWVwU1lWTWRuWWpVVEhUWkJmM2paazcxZnZnS21kQlJz?=
 =?utf-8?B?c0ZJK3Z1WkszbkR2MjhvN2ZrUE5WZDdvR0pTcEljdkdUSWZuN0wrbzVnejlR?=
 =?utf-8?B?UGNSdERoa09EeXR0QzJ6a2xlWWhpVXF0QTNWODBLeFJidU9RN2NFL0lVK2Q3?=
 =?utf-8?B?OCt4K1pNOGZ1ckRXdElQWGw3WXAxT1pnSUZueTZsbXhNMnlYT1k1bXVwODJB?=
 =?utf-8?Q?qhh+i9uWR4vXKONvs8xvuD9zNsHZXg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(32650700017)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:38:48.4346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5103924-ea65-4acd-25a8-08de16c69494
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6419

On Tue, 2025-10-28 at 18:13 +0530, Siddharth Vadapalli wrote:
> On Tue, 2025-10-28 at 06:47 -0500, Bjorn Helgaas wrote:
>=20
> Hello Bjorn,
>=20
> > On Tue, Oct 28, 2025 at 10:56:33AM +0530, Siddharth Vadapalli wrote:
> > > On Tue, 2025-10-28 at 13:16 +0800, kernel test robot wrote:
> > > > Hi Siddharth,
> > > >=20
> > > > kernel test robot noticed the following build warnings:
> > > >=20
> > > > [auto build test WARNING on pci/next]
> > > > [also build test WARNING on pci/for-linus linus/master v6.18-rc3 ne=
xt-20251027]
> > > > [If your patch is applied to the wrong git tree, kindly drop us a n=
ote.
> > > > And when submitting patch, we suggest to use '--base' as documented=
 in
> > > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > >=20
> > > > url:    https://github.com/intel-lab-lkp/linux/commits/Siddharth-Va=
dapalli/PCI-cadence-Enable-support-for-applying-lane-equalization-presets/2=
0251027-213657
> > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git=
 next
> > > > patch link:    https://lore.kernel.org/r/20251027133013.2589119-1-s=
-vadapalli%40ti.com
> > > > patch subject: [PATCH] PCI: cadence: Enable support for applying la=
ne equalization presets
> > > > config: x86_64-buildonly-randconfig-002-20251028 (https://download.=
01.org/0day-ci/archive/20251028/202510281329.racaZPSI-lkp@intel.com/config)
> > > > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci=
/archive/20251028/202510281329.racaZPSI-lkp@intel.com/reproduce)
> > > >=20
> > > > If you fix the issue in a separate patch/commit (i.e. not just a ne=
w version of
> > > > the same patch/commit), kindly add following tags
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Closes: https://lore.kernel.org/oe-kbuild-all/202510281329.racaZP=
SI-lkp@intel.com/
> > > >=20
> > > > All warnings (new ones prefixed by >>):
> > > >=20
> > > >    drivers/pci/controller/cadence/pcie-cadence-host.c: In function =
'cdns_pcie_setup_lane_equalization_presets':
> > > > > > drivers/pci/controller/cadence/pcie-cadence-host.c:205:20: warn=
ing: this statement may fall through [-Wimplicit-fallthrough=3D]
> > > >      205 |                 if (presets_ngts[0] !=3D PCI_EQ_RESV) {
> > > >          |                    ^
> > > >    drivers/pci/controller/cadence/pcie-cadence-host.c:225:9: note: =
here
> > > >      225 |         case PCIE_SPEED_8_0GT:
> > > >          |         ^~~~
> > >=20
> > > Fallthrough is intentional. The lane equalization presets are program=
med
> > > starting from the Max Supported Link speed and we fallthrough until w=
e get
> > > to 8.0 GT/s.
> >=20
> > It's poorly documented, but use "fallthrough" here:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/deprecated.rst?id=3Dv6.17#n200
>=20
> Thank you for pointing me to the documentation. I will update the patch
> accordingly and post the v2 patch.

I have posted the v2 patch at:
https://lore.kernel.org/r/20251028134601.3688030-1-s-vadapalli@ti.com/

Regards,
Siddharth.

