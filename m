Return-Path: <linux-pci+bounces-5509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43D6894983
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 04:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13EC41C20CC0
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 02:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE4F1119B;
	Tue,  2 Apr 2024 02:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TdNJ/GjS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3EA10A12;
	Tue,  2 Apr 2024 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712025957; cv=fail; b=j+3OsD4JNr9KnJIWzmb8Rin8jPsKJB04oXFXyl6p12otMzdnCE4iMNi7QZvQOW/wtyS6y90QuOGLDlU4FC1Zv3msuKJkxA/WUeZAf26AxArrCv15c1tJSnBSLUuS1OjA1DCab79rajTi+w1K/EqS9vv26xlNiRyc4bZkfbcpCUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712025957; c=relaxed/simple;
	bh=jrPoZDEUC2b3T5cUZkcptVevMzx+NcQsEqbE9+6zbjM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Alpd4qNIytFjf4UaPs9QbHzjKHvqhGEObuwhj41Qs16vBUHaojPkEKwwQC/FrCrdzaOta/uOqxPplmi49xSd0q5s7ELOClH8Rx654x2BDlP3ZQvAkG0vTTGE6bUA3YEZL5wcqTJMwbBmS33z4wXtLngLP0vIbGODitJqb+WNCuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TdNJ/GjS; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712025955; x=1743561955;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jrPoZDEUC2b3T5cUZkcptVevMzx+NcQsEqbE9+6zbjM=;
  b=TdNJ/GjSWfjHYLun8Ey5eOhB3FCBv7395I3hMvhaUttKyDSr/9qT1U8j
   9OiPhYdqOoRd+D3oiS5ULv9+AGqHXcQ2iTc7ox6Dea8BTnLrZjjYikwYY
   fobSB7BGnJgekIk3i0PraRVUjm3JgEqqkkjRdzURB1s9G53Qigdx8oFpU
   VZwMoSHUlYb357Tcd+B/NCFiBB9zeXaFHVO9En29vyI4OfSe04HZCD/XD
   n+dVtSsj393yOwaqLNEbi4aTQ48CcISbHUUVjpzyaycN/pkSXYVKeAKAk
   RxE1rVBUWajhee0YSWcnx8TPmSWotSoKYpIH2XpIYfs0GxYiJnviuE92o
   A==;
X-CSE-ConnectionGUID: KpaAqtgwSp6QujEwaJ2yQg==
X-CSE-MsgGUID: gxv2J2HgSha68q9YHlfVzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7110149"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7110149"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 19:45:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="22395778"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 19:45:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 19:45:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 19:45:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 19:45:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgCeFinaYk8lIBeSQtfakT3pqajtSSpGdo4P1KERDGGm2VKlPgL55i8hnYBHOuU3sgRD2SEXipf1fg9qQxF3Gno1Y+U5ErW8RJYxOmCU/TXF340MAkTrg2i6fpmB7ZEIH7ssPAPMlJL8apW8ai2n4x/0KFmCFp1DAyE4oqUTAoBc0LVYBF58h1wk+KF6i9K6GnizjNDee34JtbB+CSmIrN5jnw6UIcImsWPb3mmiN9b6Fd+ySiM9ipWQRD05tHqYs1mm4aCPDXDjjw6qMLIQEMjldaLWVfWn68gQ68fgfHSJdbqWgPMzOvN8J8Z6GNVw4GH8q7Xj9S+92lMWd/d26A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb/t28IWQvn+qm4rzDTlv5cwowVAxoFuIP1F4EH1NmI=;
 b=OULRkJ6Yu1fvEDaBCRLGL/8gWfcpPhoHRmcCvndopq92Gn6ptYYOxd4bxq7dD9aqI/yF5pDXXzt/5SgyIKgtnudmotOCRwhnM+LAboXDo8UmQtUlQPidlbrd6lD9B0R+yu6f7tAAblKd1GMT4doXFA8bA0VCf/+32vPWbWBJm1TbxgL04F0E2vrGJsk5YSlbj82hIbR1rjg/CF3X/ZQf/TizQVVLuauZh8D9TgLV04QMIXDWUbIF6BSuPdrDo8D95m4OJvp0YuxH54uh9H1BCKDa7ndR7wK5O3dOROkY4Iegqdj/Ydy1gJAVEzu2cbILIBVGHolksyZMYWrZats/rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6515.namprd11.prod.outlook.com (2603:10b6:208:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Tue, 2 Apr
 2024 02:45:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 02:45:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, Megha Dey <megha.dey@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: RE: [PATCH 0/3] PCI/MSI: Remove IMS (Interrupt Message Store) support
 for now
Thread-Topic: [PATCH 0/3] PCI/MSI: Remove IMS (Interrupt Message Store)
 support for now
Thread-Index: AQHahIuitPn+W4R7dUidjmorj5gi4LFURD2Q
Date: Tue, 2 Apr 2024 02:45:50 +0000
Message-ID: <BN9PR11MB5276DF6EF5910917DDB0EEAF8C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <e5bacec0-28ca-4cd9-9ffe-92feaf5fbfef@kernel.org>
 <20240401232326.1794707-1-helgaas@kernel.org>
In-Reply-To: <20240401232326.1794707-1-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6515:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 89zN2wMTm7HxI8mtvCDqXAqBDoqXarf2DJHYPRzmG//OVi3zGKAlspRNpZwTf3jSyferR9ht9dmhhDjrBHe+5Sri2c/cx8Yx8E1ST1O+iSuHjE4bVv6mJy6g+8T/zrSh08wHuB2nPxwwieGHft49JEsUcDqr+hi2ri0WhqGCHakFRG4YCX/v1ytTnl00ZtW8lliIMiwuZ6j+hi3CjjIXtIznMo4vyVxa0IA0V1w1BCiV9I5LkkM/ZTpwVcKPySJbSMskFsY0YncYouogwYzz4TKwdPpN0LNrJ6ut3zwNsUG/vm7ijiUqZfdMMT1j6Cc+2sf8mcJ48u2iXVo6oRQBbmpXls5GmWYuZzugc52y8CNPh7Nvx8wVtuBoniGydKxqMBnotCDDpmL7BtQ0rN1H1lAnQe+HdzTHsGY/g/FWGL87rCGn8XynZs6tqCc7HHpF8HtEWVtL7cPCerSZ76k+6KoW/iLOGbFn+OLDvRr+Bxrmon0FErU9aNdDjMJ1813IridOiryMxgm9ztneJMuL8s6Y24dC4uYDgOH95bEDUXz2Wdg/PXMwHdZU0bRlqqlAEjwsMEmc9w9epUoydnfloMc7o/rximhGTEWdiY0KenQCFqT3dXepnPzmyzgXcjBNXCAv8Lp3JqKeQZr2ayMpsXKoxboD1tpgh7Lq4T4RU+I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?au0xaCaidleNJ9HRlYWwCQGms9i6HyuVdVrPNPtpNBh8s/03kwMQrTxeZPS0?=
 =?us-ascii?Q?dmzUSkUhwpNVbKjBkI7MACMaxcWEzfa4UPVCUrrfpq0KHdmr3afGZuhL5wJn?=
 =?us-ascii?Q?AmzTydW2B7o/6KXP/uLPYjptwAmXe/97SlVFTTVitIB2AXbvixBoRqSfdOOu?=
 =?us-ascii?Q?XU7a2Sd5PwrtkOoVfqRYZv1e+39ssqjJ9DAvXteLsmN9k7205rfXpdhgP6Ph?=
 =?us-ascii?Q?glXGo+7zhW4ZTf9P9fGGi322bjGRkm/C07/7sDWLFgh+g5hOskCBGo5q9ii4?=
 =?us-ascii?Q?McR6DmAMVYgZpsrtiJT2y15+bYNRB2dPXCy2h9awJ8TEWUkfUv06AaixdzkO?=
 =?us-ascii?Q?bMrVo7q7kGZdJRUdIscGtIU4/0a+cv8EKp2sZTs1sY8fFsoSCk6O6gBThuFO?=
 =?us-ascii?Q?aTa7hSPRXa6mK2aZLN5WG1SPi/VFwfX48mOE4F0UtDETqczkjuO6nEjPN05n?=
 =?us-ascii?Q?J4bANeRnVVPUyRNONzAH6csQ43xXMunlzf6f7DZHFYr7TxedNa1u6y8rz0c+?=
 =?us-ascii?Q?uwMnjDLaF4nViMYVt9XEUEpGErR+EAjt0du0segm6S3iVT6M5BdrGD2F0oNk?=
 =?us-ascii?Q?qbvMPCf7IqjwnPrU8y+InLrJ3ZKLQ0cEC2fM96QRuXBP9lDSFxtaaTqZH+ST?=
 =?us-ascii?Q?rHuzn6tnZGJm36n0QWtG7tP4WHJuBTotLCMwGZ4DXQQy6kew6rqLXnDdGa1W?=
 =?us-ascii?Q?+KgXCZxs07De7fXIOLKtqSu4b0sZG6lC/10nrFAAYuTjq2GfgwP2HVBNA9qd?=
 =?us-ascii?Q?5pgHeSRtFleE5Pn21uLZzUjiy4BOOrd6hjEC8BWU5SDivPM5/FAn+EUwVlCD?=
 =?us-ascii?Q?JrLaW5wdfNfUXzBB6QqSOQJj6uHZ9SIuoCqXUAwnvmMDVl/WvZiOfHXxDoiE?=
 =?us-ascii?Q?HLDYObYlx9Jfts11qnMVQTnkurYKoxfDetLf4bcrYzbyBaCSLKytuklYKmat?=
 =?us-ascii?Q?OiSYx+gYyuwTYhJWXUKRBx+Mn8FYqcWe3hJmG3nNALvwQC4a9V+eSb0PR8DG?=
 =?us-ascii?Q?3gyPwqkXQBiKGDXTldHo09F/MIxzeALCpY15mOwej9Z5JAt0HTYNwMED5XoF?=
 =?us-ascii?Q?fdLOTeH93KTR3KZ7/qvIjr9dgGJImx5GKsDJEhvWIA4nU69XrKkuWEseEqEF?=
 =?us-ascii?Q?OrpiVsyABZamV9CxT6arcrNTC/HelCBG9lzBhpvkj1YCIjwykIPdMyhcj3Mm?=
 =?us-ascii?Q?I4jVZ6jd8cxJTHAI/Zd9Wng6QWXjwAwacqbBxMFPtRhfHZLJkuCDhHB8wCDp?=
 =?us-ascii?Q?KlrtwVIxl6xBby33a5lOWP3Rt7qYIK7kHdgeEXqCWhPbOZAo+vuMbZA/g6e2?=
 =?us-ascii?Q?lVWAHYgO7c4GFzhUvLGzl832O+4eEscXtG4b9/GbCDhpEeT05HAvBAvnae9W?=
 =?us-ascii?Q?d/c6qNc60unLXKmcodX1nwA4rGg/wK0x1PVpUdmZHrZLQe9SWWDvN/n5NCps?=
 =?us-ascii?Q?vdinWsWnU3Bj0CcgcaveH3BflLK+McEhw3ACVzOdMLtg+yfEgA4krENnbX0b?=
 =?us-ascii?Q?j2ikpcpsYTpqBByz3f9WsgKUAAoGhOaHwWV3/35KNOfwryb20jBRQmunrdS+?=
 =?us-ascii?Q?yRvItg0Rz9rzFbPe4srOQzMxW3uasyENRCJq/6sv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d17c439d-d69b-46dd-532c-08dc52bf020f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 02:45:50.6079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xcItCS6C3hTXnCVxlur2Cl+PaWRmBvWuPbtACIKie8lyBqI+M5mFxCVn18F5fgiBNpp+JlAOBEIHtBu3ksXhjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6515
X-OriginatorOrg: intel.com

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, April 2, 2024 7:23 AM
>=20
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> IMS (Interrupt Message Store) support appeared in v6.2, but there are no
> users yet.
>=20
> Remove it for now.  We can add it back when a user comes along.
>=20
> Bjorn Helgaas (3):
>   Revert "PCI/MSI: Provide stubs for IMS functions"
>   Revert "PCI/MSI: Provide pci_ims_alloc/free_irq()"
>   Revert "PCI/MSI: Provide IMS (Interrupt Message Store) support"
>=20

What about the other IMS related commits which are also dead
code after above are reverted?

fa5745aca1dc ("iommu/amd: Enable PCI/IMS")
810531a1af53 ("iommu/vt-d: Enable PCI/IMS")
6e24c8877329 ("x86/apic/msi: Enable PCI/IMS")
e23d4192bf9b ("genirq/msi: Provide constants for PCI/IMS support")

