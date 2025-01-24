Return-Path: <linux-pci+bounces-20321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECD4A1B255
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 10:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B347188EE1E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E5F1D5AC6;
	Fri, 24 Jan 2025 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W5jKiaGL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310833595A;
	Fri, 24 Jan 2025 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709608; cv=fail; b=OUXucxVOgYlzpph5JKVQZsRbeKg/LtiDQzqPQrX0prpaD2IXj5kX4BqbBE0edL4RMsH91GitDRFzWmsqnPQDJBuKgfgo3ISiE/hhwt0WUY2XsJZYwS6DctedlzQwB+hCfPgVN99TUx9XB83fKLVOueURr6FjS8uio/HfgNOnG2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709608; c=relaxed/simple;
	bh=6Yp+9hTrQHG7X2NXKvwpUut99wFScDC5vDTZTZ9jF4c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ypvhr6XQI0K7H4ehMerXYV23/aS6uLoFJorvFS23+datG3ZNZZgr3LZLJqK2wId82EHSPU/xTJWWkP6L/qHBrJvx6EaFKCqJJmtQ+DZG8DfPCJDzCdPA6ZlJpckOdlYCBEcGhncibXcFKEkdr63PvYFYH77NKf4IC3InceK7v/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W5jKiaGL; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737709606; x=1769245606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6Yp+9hTrQHG7X2NXKvwpUut99wFScDC5vDTZTZ9jF4c=;
  b=W5jKiaGLz9n5L8CGdUMSmqYQnYQSe+eRIQqpJSXdhEf+9cqNF2EfuVgA
   mt2yrUQpC/HMj+3/IC7jmGYRglVVReLL2xw0/3vo/cMz+J+0sCtdCqiZQ
   jAYdwQ6byMlndHuIAtzKinlVI5l4gOP3Y1pVSAQHaSLdQo8WS3xFYw//9
   UUB+x1quwRNR8n9cDodEs/O4ZCR7pfe27vsIjsIpIkCk8TNpwKVklLRHg
   BEuw2T47/fqDj/9zxGSIopimTw+EGkDwz/eCeITYKzEBzC0/TSXVXJimf
   yaxZ0i4U0Amu0hgE+UyehfAm6keQxebOwmM9X2QSqfHpChtkD3GKMNXM6
   Q==;
X-CSE-ConnectionGUID: I6tGc6ryQxitPCWqt0CriA==
X-CSE-MsgGUID: ZxmId3OqTyOv/48lyDoVyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="37443697"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="37443697"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 01:06:42 -0800
X-CSE-ConnectionGUID: 5YyWlxRhR/SO5ZzkGBCCcg==
X-CSE-MsgGUID: /f+ytCeEQ8yd5nrBlbdpgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="107634072"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 01:06:41 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 01:06:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 01:06:38 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 01:06:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWUkoGxmqapYeigvMMPno36DdAzccgSDd+XmwOv15/TvBhNP8NgvpjtlVX4+VmH5IQX16K/D4VgVAH20FLJqt7KoP/vt/e5/U1+Kv2ez/oyYcfywMxCSuKAj3x5DqfAzV/U9yieYQvYOLSclZnolfCPXRc4BdTmEEUMt7gbiTUdWQJWDpq6ZFLQNMy6KliLKsKmdIwvcyNlDek/OIAT1jNMdLUv3cDz47smsxq9sNrQqvMItxbnZ5g2+nZwntJTF1u7aPcYIrfOO3H/hRWAoC0KixkeJ6EDA77+mVVJjY6wJU6fOGTm+zvFJezyP4qlyl1UQNEEr2lk+7xLs7UnDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+s1s7Fs9EW0I2Yb8kbrODku2UZlnY32KYvVrnkLPaXI=;
 b=ZlM3MDzB2AGeZ8rumSfOIthkj/nM7nUwVXtomQ7Gsw/Ta7cbU/3i58RyPHEddd5r5Fe1dsznvuD1QGC1hk4Agco0dBCbdhajp7z7zFoMJryWCwr3hMAloB1Zw4Mzu3tEYP1vXoG9AJX5hyrbjIyYv8lPISpJxlgHv4/5iUuly8Est/hSBlE5bcZfV8ssmnOqkyVI0Cly0DhbWxglj65iNxapFaQEA3LwxeYUy2/0Z6pqspLQKPCxyB/ILKZbje7HhPk7SDy7qflKnmcr4d6sJ3bzEt7LPa+IVFUsqalsaro+d2lr76V8C6INBrmGCS0uSM7YncwaxnXtJ5i7LJ2G/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5952.namprd11.prod.outlook.com (2603:10b6:510:147::7)
 by MW4PR11MB8268.namprd11.prod.outlook.com (2603:10b6:303:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 09:06:08 +0000
Received: from PH0PR11MB5952.namprd11.prod.outlook.com
 ([fe80::b961:2a71:c5e8:460]) by PH0PR11MB5952.namprd11.prod.outlook.com
 ([fe80::b961:2a71:c5e8:460%5]) with mapi id 15.20.8356.020; Fri, 24 Jan 2025
 09:06:08 +0000
From: "Devegowda, Chandrashekar" <chandrashekar.devegowda@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "K, Kiran" <kiran.k@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2] Bluetooth: btintel_pcie: Support suspend-resume
Thread-Topic: [PATCH v2] Bluetooth: btintel_pcie: Support suspend-resume
Thread-Index: AQHbMbvIxage3zLxU0CexpI7qMWqbbKtGv4AgARgZCCAADWvAIB0aGxA
Date: Fri, 24 Jan 2025 09:06:08 +0000
Message-ID: <PH0PR11MB5952F0D12A5EC64D9FDC30B5FCE32@PH0PR11MB5952.namprd11.prod.outlook.com>
References: <20241108143931.2422947-1-chandrashekar.devegowda@intel.com>
 <693d09b6-edab-4ed4-8df5-11ca74bb02e6@molgen.mpg.de>
 <PH0PR11MB5952C7090EAA4F6B75145611FC582@PH0PR11MB5952.namprd11.prod.outlook.com>
 <cb38ef85-363d-47aa-bc01-55a3fef5b0af@molgen.mpg.de>
In-Reply-To: <cb38ef85-363d-47aa-bc01-55a3fef5b0af@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5952:EE_|MW4PR11MB8268:EE_
x-ms-office365-filtering-correlation-id: 1f0ed8a2-b723-4069-ecba-08dd3c56572c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?kqGAH8wSTBy+AjUaQbOJSg57MS3In7Bdjzu7dR4A0fiPcw2o+QyuQz+d+q9+?=
 =?us-ascii?Q?h2BynzU6Hq9A+m8k9m9rXHB+DLPjBWTlnlLR4RhkYC0f+kzMsuJqtj0tKJYg?=
 =?us-ascii?Q?dErqqYU8uV3io248lzCSzcZR5KzvCfwUKMRaSH07ZPAGeuo7Kxrchkbat08/?=
 =?us-ascii?Q?z9M2BaOLFAhmkXHUexdvOac2Ck6FCcc7Gt/tmG+0q9e5l85eTXDeEKpBTptL?=
 =?us-ascii?Q?gbBeWaG4QmLOIYvHNmAmh9Fpy4YGY7VJ45Woi9ghdpowzQgIIIePS4NCHh6Y?=
 =?us-ascii?Q?/aGUbnVCG0aHNQmc4qm14wTjQ4qG+inJfZU+xvK68Irm3riP4YK8VHfplSzt?=
 =?us-ascii?Q?4dlOA2fjZrT4sSCbAP7mfXLWSA8y4QaeBiU470ZEaOlS72IvovkrKH4Xa+be?=
 =?us-ascii?Q?2DnYMDstz0kGG6j1Fb6odWO4rxwYloFjzqp1u75W4x2fgKEjd7HVMHExoQ7c?=
 =?us-ascii?Q?hO0+MGPjcR5p3xC+3v9DZi4WfMX8tkHAX/z732UiG+UPzt1gkkzWE/e6FR/I?=
 =?us-ascii?Q?bpl4j2vJIADtiuekTlRJHef6R/Gl+nAuSee/IDqpaTRXyl6TkxZpVhVbxGfJ?=
 =?us-ascii?Q?jNd+W8Ym9A3F+UDRMLAn22HSMlbjr3YIjUoZarRQvOTVYzYYXxoUw1BRvwre?=
 =?us-ascii?Q?M7T6NF/dAbZ3ULfman6LcUJsZt42yDM6+PpmQ0X3OQhlR5zuVqx7xYMmJ+5j?=
 =?us-ascii?Q?MjhWt3ULADk3hn2mSgYh8vcKHQ7DJks40u0NnlOSaLJq9Ae8M9cm3CzE/Gj8?=
 =?us-ascii?Q?8d7CgBKdVONwKwVTfqUqrUgUXflbOisxRbAogog+YVuAAnOBnFCDJZ3Awu9G?=
 =?us-ascii?Q?MX2bhqxoPZ27cF24ovUcBTNkTcqBMqTdK1A9fSxDAHmgf2L1paIZfINqV+J6?=
 =?us-ascii?Q?p8G2iUxdDIZKZcvfN0cpXaT5ZnOnzT7XG1q6Z/FcEOudxMp5D5F1cfJnpfC5?=
 =?us-ascii?Q?N/yXAXDB0oKcaPS1lS7P8FL7lEf7XF14izlBp5G1JmNWmFj5lk2tvYnNJOzl?=
 =?us-ascii?Q?jXnp7RRIgfyzud8SjjAwmHP3vU/bcoQWMdKAvCrXDUWn45giRvqXCqN1pBoR?=
 =?us-ascii?Q?1ryNAuddK3vKy1RmX90P364mqI0x6zYynHF7NV0YKCeyLX9p/DuU4X6bhOxm?=
 =?us-ascii?Q?vzfedwchPZnxejB8urnRoDMLrArbbwZTPGfyB2wpSyWVaqbxCAYUwnSBm8Ta?=
 =?us-ascii?Q?38Clmi6xOXTX+4V99NII2A2cONkgTeNH9Kq+R1MKbbmmTGrI3YZNlEDpTIkZ?=
 =?us-ascii?Q?82ABCWBGzkkPPAU5HKwS8VWyLse/htdcZb1Kj1Li+Boy004pSf08T31v/lg5?=
 =?us-ascii?Q?+R3h94URKbmOedMiqw2hIcWdIgIHmNIYZIPb+gXUfOl/B5mfEp9uuiDcX5gs?=
 =?us-ascii?Q?qhGOmVmYQxzxOl3helzdhz00J8/iLlpaKhUMry7m8OzTXENGSXuTvw6QCLij?=
 =?us-ascii?Q?yWNMETC7YtlMB0y78Ht+3zsDT76DyMWT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5952.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z4F9mErxuav9i+SYSaZj+EZJqvAxM8cKwir3VEdiT6PvDd19uM957hmDphpP?=
 =?us-ascii?Q?l7ca1K4IoBGz27bfY3ems2LDDBYPcOYV7nngJccbRanP8J5fUQxaDdL5n9bC?=
 =?us-ascii?Q?VadPaK46BxI/z7uQrqoSNGJzteI7G5gxZuLkghP3/NzilhSqzDu8KT0n7Hh9?=
 =?us-ascii?Q?BsRnJGZGR1XnuaK2dpyU0GjQ60itFbqMC38yYLnzDTHhyiJknkJoqBBXr+E/?=
 =?us-ascii?Q?iyxNmM55rPdXuB9nBKQxJWGY3GPMSwW+5tp2gq63gfjjZOi/76sBon88wa6U?=
 =?us-ascii?Q?CzDVMSvCtZ8YQEMu9oHLYkxVHduxdpvxYb1N//Ivms7AAXERBxCfb1aVUhKQ?=
 =?us-ascii?Q?QrezqpAE2BZYa77X8fvY3XmOo5W2JWJbZ0cRugBZflKrnS36roK2x02joRw4?=
 =?us-ascii?Q?YmF3pdssLk98XcaeCopV2ir2syyI3z8uSAIDxHWPyBVTXq0ZVytYj5mkQgya?=
 =?us-ascii?Q?4k9QAlC50aPcacBtaikwBLiZPPL2HHufsByKHeDZGWZh942gH5K2nh5JzS38?=
 =?us-ascii?Q?AtL3GzkgPwNh8S/PhlehohyRwiHaKk2m5DZS5Qm3HML8GpVxZSVE++eq+CQw?=
 =?us-ascii?Q?VTlHuZpnufBb2e8rHSHlC50jh0tQ4gPJWEIwKbN7/KYIvPENx9a/bXPXEtBl?=
 =?us-ascii?Q?V7Otb7lvEhWRpr5LuE2n62bDqze6b0viR5XQkdqjylE6ZRSvbjvC+stLbYc2?=
 =?us-ascii?Q?unbLRp8HW/VdE+dP6CP9aqgppBqm24+dRIYqFB1+rXeeFrnoNQ4RUQCctEdQ?=
 =?us-ascii?Q?RQ3BQuqXIWgy4cnEgT2LdTzqrlasqqawtnooYNpoDyvHlif0PAzy2Pefm7aG?=
 =?us-ascii?Q?5f85GvcEElBMNCIO6wfdYyECAME2dZHpxOhdK+u5h1qeVTRwSyPCGtlJP1Ia?=
 =?us-ascii?Q?M62OZWLVhobfxJfulwFsbQon5Ri7gYwxNQEnEpT9G99xn1AP9lD9jj0qQaEe?=
 =?us-ascii?Q?57T4OJCKUxCJsmkIuNrC4gPj3qlTtrD7Z7SFYmueWURQ7GPFHD73UWggFQAv?=
 =?us-ascii?Q?OKlVxqq35UShgaqNfpHMdZzt4ApXGrO8ZHAWVVMCve1XTfbXypuaksIHn4Bh?=
 =?us-ascii?Q?z/a8GdC6ufFWYI5T8QlhVcSFSEgBBhApNu078BUUQSIOCXSJ3cJVZpop6Y23?=
 =?us-ascii?Q?yprRC5pEl2AyA0J1odVKve14nesDe8iVfRbrfrTLJFVK0jiF79JXE6FqI4p7?=
 =?us-ascii?Q?RcvjsFIATY1/Va9hRC9JcvPFZqqjPcsowZKX91hwHtbPqq8Jf3VeQXNBIC98?=
 =?us-ascii?Q?2gyIYJiGyS50grExsmNXZLS99gpM3tFZG7SEh425uPwHtNfRSb2p9+Dnw5AM?=
 =?us-ascii?Q?1zriSTinWOhvtJ0SMvwBEaSCFT4VHT+JdtS6KTHOXVmaBJU82506tPzoJrLj?=
 =?us-ascii?Q?67nDFduwa/lGwfT+xnI8bvr/0TGociLl6FrgWgMUhcHdfm4vXfDnzTQ412lp?=
 =?us-ascii?Q?yTbU7/8ctd8W4DNHdXXBi0nrDukuqtAK0gnc2kp74wzA1OUMQl07v7vHOP42?=
 =?us-ascii?Q?hbPcwz4zoHBQ9McaUAOWzfV2CRwpMWZe6sHh70M1PJMRE5ZTBMmiYcEL8Rvi?=
 =?us-ascii?Q?n+BxyWYqAE2RIeVNN4sitNgdNo+g0+ZFdPLXxXw0Juj/jnmTxs70swAnyBLZ?=
 =?us-ascii?Q?kQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5952.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0ed8a2-b723-4069-ecba-08dd3c56572c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 09:06:08.1980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjaobDT9aiMTqvwNT0ENkAA5w09f1lrSJhKLTT1D7j8C0Sit6f1rIpjHwAdPBj4kFPnmPlDBMhK15YzqjegmYsCsjhgP9nFXsZZihpVZIYRvSyC9JsPuQv/bNWhqIlKU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8268
X-OriginatorOrg: intel.com

Hi Paul,
    Thank you for the comments

> -----Original Message-----
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Sent: Monday, November 11, 2024 12:51 PM
> To: Devegowda, Chandrashekar <chandrashekar.devegowda@intel.com>
> Cc: linux-bluetooth@vger.kernel.org; Srivatsa, Ravishankar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>; K, Kiran <kiran.k@intel.com>; Bjorn
> Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org
> Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Support suspend-resume
>=20
> Dear Chandrashekar,
>=20
>=20
> Thank you for your space.
>=20
>=20
> Am 11.11.24 um 07:33 schrieb Devegowda, Chandrashekar:
>=20
> >> -----Original Message-----
>=20
> >> Sent: Friday, November 08, 2024 2:49 PM
> >> To: Devegowda, Chandrashekar <chandrashekar.devegowda@intel.com>
>=20
> [...]
>=20
> >> Am 08.11.24 um 15:39 schrieb ChandraShekar Devegowda:
> >>
> >> The space in your name is still missing.
> >
> > I have added my second name, my first name doesn't have a space so
> > please consider ChandraShekar as a single name.
> Thank you. In your email you now do *not* use CamelCase, which is more
> common in Western culture. (Of course you can write your name as you want=
,
> and I just pointed it out.)
>=20
> >>> This patch contains the changes in driver for vendor specific
> >>> handshake during enter of D3 and D0 exit.
> >>
> >> Please document the datasheet name and revision.
> >
> > Datasheet is internal to Intel, sorry wouldn't  be able to share at
> > the moment.
>=20
> Although it is not public, the name would still be good to have. Intel em=
ployees
> can probably get access more easily, and non-Intel folks could directly a=
pproach
> with the name, and in the future it might be even made public.
>=20

Ack, I have added the Intel specific SAS document name and the relevant sec=
tions in the commit message.

> [...]
>=20
> Thank you for acknowledging the other comments.
>=20
>=20
> Kind regards
>=20
> Paul

Regards,
Chandru

