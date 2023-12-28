Return-Path: <linux-pci+bounces-1488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FD281F5F4
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 09:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A177282E0F
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 08:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9036AA3;
	Thu, 28 Dec 2023 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8mcfOO6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E143653B4;
	Thu, 28 Dec 2023 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703752256; x=1735288256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Td7wDBZOZ1czX/IHrkv16FpiEdzO3+im025Xnos2sco=;
  b=a8mcfOO6TRQNwmHlP8iMhG06q53vbrTUUzpqJivl8Zv3mtWN+2uViiCy
   eBiGN0n3uW/2w2cHQaPLgwNCIuEwa+cC1vuF0BG4/KFH6w0ZHc5zGAfAs
   mkEWpq6ru4MdCI5uySCIots/D+3t7yz4+Ve4Nd7W+SKBRZNP0OnQb9QDi
   9Xf2mJdVyWb9mz0H05R6VdHrbuB2mUZbHbFcTe/m8Nv0DlvnFeSayMnUf
   zF0xqVZncxxiTipEKhTdEah85W6acj+3SpE1p5vAlzeFsrfFc8Ykn6ldi
   dK3CJdJmbpm+g5bTPt4cbP0A2omrumwZxgJoecrhVkIpwf6Sho9rczxsW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="376013627"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="376013627"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 00:30:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="754684594"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="754684594"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Dec 2023 00:30:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 00:30:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 00:30:46 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 00:30:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFYGHjoL2XAZ2QiQDTNctXFQnaYF8WuNXtcZCU+AzQsPwCLKi+bMxFsHvwOFHqzUe5PHvCgUX7UBAXqmHrr9Stj81RpDHxuLmlELz4o6ngmKNj+SRFVhL6W1cKwsukDM9KL2lerunP4BILamf5G1DB+fLUPS+6plgthzWtcjXS1EHMRVO4FE+NfvJ75BTFCxpfGtxz2cyo+mQorVq4JqzJ6RT4tvHNOZdnC5WQr8n8/D/nURLDVcMug1Rj0ENkLkBNGRNxi5wixe4PJPNJ2OXUTk+KaJkulnr6XBAvjQFtSdGMHncTdcwpDpdqJEt+TtC907qar+utda7YkpFpEv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWqmr4vGDv7p22Pzhv9R8oYlJHOVl+77CLygMd18M14=;
 b=IhRXJu5kHp5dTlBA6bJwipUtQ2ufQBhTtmod+aF71ubjN7bfuwQKlI12Rl3vrSHtuW5nwWKbbEQ4o/29LHZO0/8cTcVVOZFr4Bm0FMaio5qOXD9ksOkuWSqJeDyZJxazZeX/HMkuxXt82OcgGsThi2W76DWNN6WMPCZ58LudgqIbbg3kCSH0kkbgwLH2vlc5R1VNQZb27fWmUgPk+c3GtxkS0f04iAwyuz7SD5ln3yDcNvwk4GfXiyDVNLctf4ZNiQUNO34S9yibuFvjOq6XhxzpHVji7gknbNs2fYyQVTf74w7P9vcH1TrVrYsS57LeAzuvZi1n3oyUELci/ysKhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6902.namprd11.prod.outlook.com (2603:10b6:510:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.30; Thu, 28 Dec
 2023 08:30:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7113.028; Thu, 28 Dec 2023
 08:30:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"lukas@wunner.de" <lukas@wunner.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v9 2/5] iommu/vt-d: break out ATS Invalidation if
 target device is gone
Thread-Topic: [RFC PATCH v9 2/5] iommu/vt-d: break out ATS Invalidation if
 target device is gone
Thread-Index: AQHaOSNKMi5mz6+zfkaNoEyCzumA+7C+XMEw
Date: Thu, 28 Dec 2023 08:30:42 +0000
Message-ID: <BN9PR11MB5276D70FD60FD1E0733B35AE8C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231228001646.587653-1-haifeng.zhao@linux.intel.com>
 <20231228001646.587653-3-haifeng.zhao@linux.intel.com>
In-Reply-To: <20231228001646.587653-3-haifeng.zhao@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6902:EE_
x-ms-office365-filtering-correlation-id: d2ae98da-9a2a-4e8e-ffde-08dc077f47e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9PQkbEQfkvGY6er+r3l62V3y9BFwaRFBt4BkiJ4o9G249vqSNcw2yP4r8Eh4+qRaoZvyrNOg6duZwbWGvisjpemi/FUOVBgV5tSWZ7AqVrmb10xF7GKhA6DTKZ9UXkA7pZ9CJH5+WJb8xS/HMEb5M9zB0ME/zomJVIgqt6nFrTj1E92O/GCrMV2H5rdVvX+H8t+FMXOptqkCSByOyIjB/0hfDajxSDjtM6Q906+7DXOtZi91hMKh5hAO70MCi28B5KyE3q9oFw0eJUMphIPFg4V4NWjio0+kdQJ63v2bttH5CqYBNGZtHL/Jr6afCZJS5hswmCzPFRTyLrvGZecyv5CGF5fmPvs4gg2XeoVntHjdvgJ9gPEq2HzAqfeTs5RlDOdXQVm1bTpYflvQZ9C1OkGSUYUVjBgaTtkOq0V1gIyliPBS22qqdlIhPkIHdSN4bPhtR9FVbeNU+QwTxqDKXI4vBb0dJN6c1T9NiOjr/7n+Y7gP6Ji2J5sTAE8PMiyRqZlMppSrAaq/TEimqjHf0oOMS1cp0OM4ZTFO/FDySImlYEBbTooOtcAnZsMk0dqQDS6S6qk2gEEJr55PEMrP91rRo3x0Gli4GT47h0R/AsyXfuzJbj0ajJQSehEEmRzofF5Jrb32WWSFwZYPjSGZO25AH5DzZ+N6KgfCXFcxNqc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39860400002)(136003)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(55016003)(41300700001)(2906002)(7416002)(5660300002)(8936002)(8676002)(64756008)(66476007)(66556008)(66946007)(66446008)(54906003)(76116006)(52536014)(4326008)(316002)(38070700009)(110136005)(86362001)(26005)(82960400001)(38100700002)(33656002)(122000001)(83380400001)(7696005)(6506007)(71200400001)(9686003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gq51aO5Qbj6xxFpqwyn+tbKrgLuySg0Udp1i/noPKTxMIJKnAm51xO9tdusb?=
 =?us-ascii?Q?tgdaRoRanYNGqIDq76bKCvjusNugoEqYq5YYcnsJB38sjUlB/UiShfLLcto3?=
 =?us-ascii?Q?erUS8XSnwqRz4TdghJ0vJ/UI+8GkkTAqEn4rjsc+fUWTgJt4v5CKlvOMa/7p?=
 =?us-ascii?Q?WL+Wvp4dV1n3RchaMbDMeGmA5aQ0vXTI4qPE896tydG6uV4Ehm8AmrZrFCvK?=
 =?us-ascii?Q?/xHN28eanXfGWw1JxgSxNh7NoVg4N1Ef3E+gTcml3+0aXXbyiyu+sSNIUxsj?=
 =?us-ascii?Q?SjEC1niELF7Ke+A0lcjbRTNuAA3fblF5PatPXBdZm+3HcPxXH1CNj5RSR+LU?=
 =?us-ascii?Q?bfB/UaBQ/6hIhz8fD2LBiRBtfRMhmDqf/aRkAPXRkHHy70JZcz+JChPUHEk2?=
 =?us-ascii?Q?2SAbpQkvn0WA/kxMKDVs7iDaJUkN2qSYJwrYxi+/3TQZzfC8lfDcNF79oMa3?=
 =?us-ascii?Q?znVa1LRQ42Z8nS5oBfLDrMS68Ax0bcGvNOS2ieg6MbNlJGMn5jcsG4z1uTGS?=
 =?us-ascii?Q?xkNHJys40aiuZVJZQnNKO8hV5i6mpcT/grDDZiDoPkpynG0In9zyFLnOpMrY?=
 =?us-ascii?Q?itkIcOJfW5Z0EmDzw+G3b37ru90Mn3L/R1Xo6zSKzudnXukjk+QAzb3F4zzR?=
 =?us-ascii?Q?Ld4rCuP1kq1MKZHpFDAj1kR8C6Lfu9k1ASw787qAo+9jW4Y1WnjqHX0N8lDc?=
 =?us-ascii?Q?cDi/G+ngFXtKvisTcu5dd0XcUD32EoHku5pXaxZX5JLq1zDXVPovxI7Bt80o?=
 =?us-ascii?Q?Bu4opKue4ey6F+Y7xUaoJNdF4B81uWBOBEHjCznBWeWTGQyxX5IAE7KaBDWC?=
 =?us-ascii?Q?87zE3If6e7aLScz8CMyInaIvVZ9HyqGU1bAqMZz5KHJADuip8Mp9jeCqkGqI?=
 =?us-ascii?Q?IJ19CcGHqFYonDaHpYF78JIAAOnravWaofiMOAiE5IOEwA1foAcVt4K+cTal?=
 =?us-ascii?Q?WeS3yhvCyJj6UR4WI/KEbov6s2ol6ZVSmLSKR5iPZJGKu4CpRtkeJfCIQbgZ?=
 =?us-ascii?Q?ABmabNayG4EdFpzj1x5MUi+1xT9280mjuMyb7DYWVC4UyjlVkCI66K6yfBL1?=
 =?us-ascii?Q?8FL7LMOnEK8n299EVnbSwDcZLn9ifVY9QV0h3mlCJbqHwNDDY6C4yagiGeeq?=
 =?us-ascii?Q?cnogERrDQqbs67ALE517r4ZDsFm+5jU3b9/SMszADgcq4nIqI31mu895U2/g?=
 =?us-ascii?Q?RO6A0RtUy+o+3eoC1BpWYb8IyTI0eJUKsqZLXzqZ8yO7JxRgg7aRb+MOTA/5?=
 =?us-ascii?Q?BHr4AnvbjmscyhXzTN8XNVqv1quneIg46+FLQhWNGY/HSZomtU1VXeVPCT8E?=
 =?us-ascii?Q?bVs20UEgo+o2xwlS72CPyHroH7N9Fhiya12cVnSUMe+fSWw9o4ZKLjcPMNTC?=
 =?us-ascii?Q?WpOX9wANDT2G/+P1VB+9zcb2JodJSQOaqQPLjVyXmfvjl6kBuqsONaRW7Z2C?=
 =?us-ascii?Q?WSzjUlxX7BtUcrk2QKqhjTA6bCQ4MhMBrcbILcaFttwYwUFqx5Ze2cN0vFcA?=
 =?us-ascii?Q?/rh3L/XOv1b6MS2V70OP6EMCqr68ccXquLr+7bKoTkqp2YkrmMuxxhpI7WIS?=
 =?us-ascii?Q?RVOKbB7DlwpcAAscGNqH/Ep2NUpq6JtDVQmURLJW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ae98da-9a2a-4e8e-ffde-08dc077f47e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 08:30:42.8289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6UiwyP9cbm+WuVAR6i8kT2VHcd3T7v6mMYY614bbYjkpKXofEzPja7qRnfWG84KZCkWKh+8zvl/yDck7dUH2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6902
X-OriginatorOrg: intel.com

> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
> Sent: Thursday, December 28, 2023 8:17 AM
>=20
> For those endpoint devices connect to system via hotplug capable ports,
> users could request a warm reset to the device by flapping device's link
> through setting the slot's link control register, as pciehp_ist() DLLSC
> interrupt sequence response, pciehp will unload the device driver and
> then power it off. thus cause an IOMMU device-TLB invalidation (Intel
> VT-d spec, or ATS Invalidation in PCIe spec r6.1) request for device to
> be sent and a long time completion/timeout waiting in interrupt context.

is above describing the behavior of safe removal or surprise removal?

>=20
> That would cause following continuous hard lockup warning and system
> hang
>=20
> [ 4211.433662] pcieport 0000:17:01.0: pciehp: Slot(108): Link Down
> [ 4211.433664] pcieport 0000:17:01.0: pciehp: Slot(108): Card not present
> [ 4223.822591] NMI watchdog: Watchdog detected hard LOCKUP on cpu 144
> [ 4223.822622] CPU: 144 PID: 1422 Comm: irq/57-pciehp Kdump: loaded
> Tainted: G S
>          OE    kernel version xxxx
> [ 4223.822623] Hardware name: vendorname xxxx 666-106,
> BIOS 01.01.02.03.01 05/15/2023
> [ 4223.822623] RIP: 0010:qi_submit_sync+0x2c0/0x490
> [ 4223.822624] Code: 48 be 00 00 00 00 00 08 00 00 49 85 74 24 20 0f 95 c=
1 48
> 8b
>  57 10 83 c1 04 83 3c 1a 03 0f 84 a2 01 00 00 49 8b 04 24 8b 70 34 <40> f=
6 c6 1
> 0 74 17 49 8b 04 24 8b 80 80 00 00 00 89 c2 d3 fa 41 39
> [ 4223.822624] RSP: 0018:ffffc4f074f0bbb8 EFLAGS: 00000093
> [ 4223.822625] RAX: ffffc4f040059000 RBX: 0000000000000014 RCX:
> 0000000000000005
> [ 4223.822625] RDX: ffff9f3841315800 RSI: 0000000000000000 RDI:
> ffff9f38401a8340
> [ 4223.822625] RBP: ffff9f38401a8340 R08: ffffc4f074f0bc00 R09:
> 0000000000000000
> [ 4223.822626] R10: 0000000000000010 R11: 0000000000000018 R12:
> ffff9f384005e200
> [ 4223.822626] R13: 0000000000000004 R14: 0000000000000046 R15:
> 0000000000000004
> [ 4223.822626] FS:  0000000000000000(0000) GS:ffffa237ae400000(0000)
> knlGS:0000000000000000
> [ 4223.822627] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4223.822627] CR2: 00007ffe86515d80 CR3: 000002fd3000a001 CR4:
> 0000000000770ee0
> [ 4223.822627] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [ 4223.822628] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7:
> 0000000000000400
> [ 4223.822628] PKRU: 55555554
> [ 4223.822628] Call Trace:
> [ 4223.822628]  qi_flush_dev_iotlb+0xb1/0xd0
> [ 4223.822628]  __dmar_remove_one_dev_info+0x224/0x250
> [ 4223.822629]  dmar_remove_one_dev_info+0x3e/0x50
> [ 4223.822629]  intel_iommu_release_device+0x1f/0x30
> [ 4223.822629]  iommu_release_device+0x33/0x60
> [ 4223.822629]  iommu_bus_notifier+0x7f/0x90
> [ 4223.822630]  blocking_notifier_call_chain+0x60/0x90
> [ 4223.822630]  device_del+0x2e5/0x420
> [ 4223.822630]  pci_remove_bus_device+0x70/0x110
> [ 4223.822630]  pciehp_unconfigure_device+0x7c/0x130
> [ 4223.822631]  pciehp_disable_slot+0x6b/0x100
> [ 4223.822631]  pciehp_handle_presence_or_link_change+0xd8/0x320
> [ 4223.822631]  pciehp_ist+0x176/0x180
> [ 4223.822631]  ? irq_finalize_oneshot.part.50+0x110/0x110
> [ 4223.822632]  irq_thread_fn+0x19/0x50
> [ 4223.822632]  irq_thread+0x104/0x190
> [ 4223.822632]  ? irq_forced_thread_fn+0x90/0x90
> [ 4223.822632]  ? irq_thread_check_affinity+0xe0/0xe0
> [ 4223.822633]  kthread+0x114/0x130
> [ 4223.822633]  ? __kthread_cancel_work+0x40/0x40
> [ 4223.822633]  ret_from_fork+0x1f/0x30
> [ 4223.822633] Kernel panic - not syncing: Hard LOCKUP
> [ 4223.822634] CPU: 144 PID: 1422 Comm: irq/57-pciehp Kdump: loaded
> Tainted: G S
>          OE     kernel version xxxx
> [ 4223.822634] Hardware name: vendorname xxxx 666-106,
> BIOS 01.01.02.03.01 05/15/2023
> [ 4223.822634] Call Trace:
> [ 4223.822634]  <NMI>
> [ 4223.822635]  dump_stack+0x6d/0x88
> [ 4223.822635]  panic+0x101/0x2d0
> [ 4223.822635]  ? ret_from_fork+0x11/0x30
> [ 4223.822635]  nmi_panic.cold.14+0xc/0xc
> [ 4223.822636]  watchdog_overflow_callback.cold.8+0x6d/0x81
> [ 4223.822636]  __perf_event_overflow+0x4f/0xf0
> [ 4223.822636]  handle_pmi_common+0x1ef/0x290
> [ 4223.822636]  ? __set_pte_vaddr+0x28/0x40
> [ 4223.822637]  ? flush_tlb_one_kernel+0xa/0x20
> [ 4223.822637]  ? __native_set_fixmap+0x24/0x30
> [ 4223.822637]  ? ghes_copy_tofrom_phys+0x70/0x100
> [ 4223.822637]  ? __ghes_peek_estatus.isra.16+0x49/0xa0
> [ 4223.822637]  intel_pmu_handle_irq+0xba/0x2b0
> [ 4223.822638]  perf_event_nmi_handler+0x24/0x40
> [ 4223.822638]  nmi_handle+0x4d/0xf0
> [ 4223.822638]  default_do_nmi+0x49/0x100
> [ 4223.822638]  exc_nmi+0x134/0x180
> [ 4223.822639]  end_repeat_nmi+0x16/0x67
> [ 4223.822639] RIP: 0010:qi_submit_sync+0x2c0/0x490
> [ 4223.822639] Code: 48 be 00 00 00 00 00 08 00 00 49 85 74 24 20 0f 95 c=
1 48
> 8b
>  57 10 83 c1 04 83 3c 1a 03 0f 84 a2 01 00 00 49 8b 04 24 8b 70 34 <40> f=
6 c6
> 10
>  74 17 49 8b 04 24 8b 80 80 00 00 00 89 c2 d3 fa 41 39
> [ 4223.822640] RSP: 0018:ffffc4f074f0bbb8 EFLAGS: 00000093
> [ 4223.822640] RAX: ffffc4f040059000 RBX: 0000000000000014 RCX:
> 0000000000000005
> [ 4223.822640] RDX: ffff9f3841315800 RSI: 0000000000000000 RDI:
> ffff9f38401a8340
> [ 4223.822641] RBP: ffff9f38401a8340 R08: ffffc4f074f0bc00 R09:
> 0000000000000000
> [ 4223.822641] R10: 0000000000000010 R11: 0000000000000018 R12:
> ffff9f384005e200
> [ 4223.822641] R13: 0000000000000004 R14: 0000000000000046 R15:
> 0000000000000004
> [ 4223.822641]  ? qi_submit_sync+0x2c0/0x490
> [ 4223.822642]  ? qi_submit_sync+0x2c0/0x490
> [ 4223.822642]  </NMI>
> [ 4223.822642]  qi_flush_dev_iotlb+0xb1/0xd0
> [ 4223.822642]  __dmar_remove_one_dev_info+0x224/0x250
> [ 4223.822643]  dmar_remove_one_dev_info+0x3e/0x50
> [ 4223.822643]  intel_iommu_release_device+0x1f/0x30
> [ 4223.822643]  iommu_release_device+0x33/0x60
> [ 4223.822643]  iommu_bus_notifier+0x7f/0x90
> [ 4223.822644]  blocking_notifier_call_chain+0x60/0x90
> [ 4223.822644]  device_del+0x2e5/0x420
> [ 4223.822644]  pci_remove_bus_device+0x70/0x110
> [ 4223.822644]  pciehp_unconfigure_device+0x7c/0x130
> [ 4223.822644]  pciehp_disable_slot+0x6b/0x100
> [ 4223.822645]  pciehp_handle_presence_or_link_change+0xd8/0x320
> [ 4223.822645]  pciehp_ist+0x176/0x180
> [ 4223.822645]  ? irq_finalize_oneshot.part.50+0x110/0x110
> [ 4223.822645]  irq_thread_fn+0x19/0x50
> [ 4223.822646]  irq_thread+0x104/0x190
> [ 4223.822646]  ? irq_forced_thread_fn+0x90/0x90
> [ 4223.822646]  ? irq_thread_check_affinity+0xe0/0xe0
> [ 4223.822646]  kthread+0x114/0x130
> [ 4223.822647]  ? __kthread_cancel_work+0x40/0x40
> [ 4223.822647]  ret_from_fork+0x1f/0x30
> [ 4223.822647] Kernel Offset: 0x6400000 from 0xffffffff81000000 (relocati=
on
> range: 0xffffffff80000000-0xffffffffbfffffff)
>=20
> Furthermore even an in-process safe removal unplugged device could be
> surprise removed anytime, thus need to check the ATS Invalidation target

I don't understand what this sentence is trying to say. what is "in-process
safe removal unplugged device"? Are following words about safe removal
or surprise removal?

> device state to see if it is gone, and don't wait for the completion/
> timeout blindly, thus avoid the up to 1min+50% (see Implementation Note
> in PCIe spec r6.1 sec 10.3.1) waiting and cause hard lockup or system
> hang.
>=20
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>  drivers/iommu/intel/dmar.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 23cb80d62a9a..76903a8bf963 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1347,6 +1347,7 @@ int qi_submit_sync(struct intel_iommu *iommu,
> struct qi_desc *desc,
>  		   unsigned int count, unsigned long options)
>  {
>  	struct q_inval *qi =3D iommu->qi;
> +	struct pci_dev *pdev =3D NULL;
>  	s64 devtlb_start_ktime =3D 0;
>  	s64 iotlb_start_ktime =3D 0;
>  	s64 iec_start_ktime =3D 0;
> @@ -1360,6 +1361,9 @@ int qi_submit_sync(struct intel_iommu *iommu,
> struct qi_desc *desc,
>  	if (!qi)
>  		return 0;
>=20
> +	if (iommu->flush_target_dev && dev_is_pci(iommu-
> >flush_target_dev))
> +		pdev =3D to_pci_dev(iommu->flush_target_dev);
> +
>  	type =3D desc->qw0 & GENMASK_ULL(3, 0);
>=20
>  	if ((type =3D=3D QI_IOTLB_TYPE || type =3D=3D QI_EIOTLB_TYPE) &&
> @@ -1423,6 +1427,14 @@ int qi_submit_sync(struct intel_iommu *iommu,
> struct qi_desc *desc,
>  	writel(qi->free_head << shift, iommu->reg + DMAR_IQT_REG);
>=20
>  	while (qi->desc_status[wait_index] !=3D QI_DONE) {
> +		/*
> +		 * if the device-TLB invalidation target device is gone, don't
> +		 * wait anymore, it might take up to 1min+50%, causes
> system
> +		 * hang. (see Implementation Note in PCIe spec r6.1 sec
> 10.3.1)
> +		 */
> +		if ((type =3D=3D QI_DIOTLB_TYPE || type =3D=3D QI_DEIOTLB_TYPE)
> && pdev)
> +			if (!pci_device_is_present(pdev))
> +				break;

I'm not sure it's the right thing to do. Such check should be put in the
caller which has the device pointer and can already know it's absent
to not call those cache invalidation helpers.

>  		/*
>  		 * We will leave the interrupts disabled, to prevent interrupt
>  		 * context to queue another cmd while a cmd is already
> submitted
> --
> 2.31.1
>=20


