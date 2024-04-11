Return-Path: <linux-pci+bounces-6106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 685038A077F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 07:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CF61F2361C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 05:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFD013C3CC;
	Thu, 11 Apr 2024 05:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgW/Q3nA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B08613C677;
	Thu, 11 Apr 2024 05:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712812421; cv=fail; b=jnUnvjFmDoRfdoEqRe7oeL1EWrMusd7jgtWzT11MUq415CZjB437bJf6+XFaroToNC4xG4fLUGq8W5/mT9yksR94J9WSojD0JNjnwP5gWAjQI4bPs1Aiy2vOZ9P/Ay2t1u7vak9pE8gT0H0o8ICF6xUa5VNSuhrRzL7t93pVLP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712812421; c=relaxed/simple;
	bh=wjjzP45eVbgLk8OoeC8cNmfQr9FHBO4+LwXzwrYELOM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VbmVfJ1XfKT1eJ6mzwxA+oDFtjwOIdsCZd3KRuGebGB4TpQEZPuHbgQMUkDU17YTaNphrVXQ3079fyKRvUjuMHyV+vc50yowpe6m2tt1QYB5DtL/qkXConZkFU1F9AXYehm9y15hysXfnaCdvP0ipWhF+oiQMNWyIzQzfDt6IDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgW/Q3nA; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712812420; x=1744348420;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wjjzP45eVbgLk8OoeC8cNmfQr9FHBO4+LwXzwrYELOM=;
  b=JgW/Q3nAhUiuDpQRFxqn8+oObGejGv9lYFPNSCKrWZjcI/YJF+1ulecr
   Qh+7Dv0ZpklPklRa7N03VRrdT9eJJ8BTdj0nABctjHZMNrJqstDU5L340
   NbfkKn4wMduBYh/QL8qtqYCPRhINybHILsJfVvaKnm6EFdpR1sadzs1qm
   9Gog4OSGmXUXU2m82gDMy30m4oZ4wjjKfFevTIj9P21nFphtmxykGrKMb
   y8abKy8xya3nbXwRkEZHTHWzoAG6VkysnleSBkqdZFxiTS7VkjFfmDCcV
   O2ZgNxWfgqiV1bh51hf/nAPL9gd0cPHoc/XTWFcpV3tJ6ros6PUYrHUqr
   g==;
X-CSE-ConnectionGUID: 7aWP90G6SEuMxO8Q/7uvDA==
X-CSE-MsgGUID: FwAkWy3rT5avLYmQScIhnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25716652"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="25716652"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 22:13:39 -0700
X-CSE-ConnectionGUID: FjusIexuTyyIzxWRtv1dzQ==
X-CSE-MsgGUID: VxsZk5JLRnWBO5He+CZMrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="25270232"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 22:13:38 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 22:13:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 22:13:37 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 22:13:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5kMKYogSIw5BAPH+monzHvjfJI/nfbL6B5XdMBaty33B2Jd13M5mEReh5HExAmPSjGATXqx+xdgkmaQ4978rOvel53oZRCVgf079I9xHzhAFlvW/nyQ4+5EqEMzUIJQrAIaiqAlHg1ZxibgBFGwJi+lUHyK0zibws8++NFL2ofNdQrkgU6mdv2PTJo5SuWWeejm7T8TXbtZynD1H2DfK8a7+RwpvHHQJdwUiKDXXusz3hoY/J7jS5EXif4j2Q8QER2XKcaKnUqhdJ/X8KNu04DR6Jj+BpnTr2rVJcIxpnwhh7X+i6M269RgSg8XhLce/E5MOlrjVwBQEtth06W9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fa4ch3vEXhH67tqNVI9jovNjFNwHpExxzMTimexIWUQ=;
 b=UI5SjJR9wmgiul1xqKNxHZGdIXfRm06SOBwGQ/4bHokZ+lKvMG2kK55tbw9zpdVpZUFshQfkRI+kqZVg5bo439HZrLTg/tOJzofSLpk1byvbyToPtPxGdHybqTKAKKEtg/gEDDsnXiq8VOxBZNM2pxnt9bImGxfDCY4qSOzuVxVJxUggrPvI2yU6U+WUca9YOTc+lCDh4LDosHLii3RxdFBX+9mnNh3myD1ZfaTDLBx48o0KaTeSeGc+EoMRcIDm17pBMC1kihuGKp6WOjmKGdhEGpUhds749g4ictIP5XTSUEIAOZ3M0Zv8+oDLApUruGPNd7D1VMCN+poxSgfl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7789.namprd11.prod.outlook.com (2603:10b6:208:400::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Thu, 11 Apr
 2024 05:13:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 05:13:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, Megha Dey <megha.dey@intel.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Robin Murphy
	<robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: RE: [PATCH v2 6/7] Revert "x86/apic/msi: Enable PCI/IMS"
Thread-Topic: [PATCH v2 6/7] Revert "x86/apic/msi: Enable PCI/IMS"
Thread-Index: AQHai5RYCRkoxVIO9Uqvbywvr4+/UrFihskg
Date: Thu, 11 Apr 2024 05:13:35 +0000
Message-ID: <BN9PR11MB527677EB32A4DA9BBBBAFDEF8C052@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240410221307.2162676-1-helgaas@kernel.org>
 <20240410221307.2162676-7-helgaas@kernel.org>
In-Reply-To: <20240410221307.2162676-7-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7789:EE_
x-ms-office365-filtering-correlation-id: 0a9dead5-0b67-4d95-b08b-08dc59e623c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qVyqNKftfnIJm+Szn/m5ouFdyAkcRUrc51VcwIvwKcFxy7zKpyLunoEyc/qRh+bQOz4p/rIY9CCKrLZi76CLrjWm0RQ7awHaH90TPIqojN2h5uoEqcfyFhBWe4oZcAP8VgaGEgmKLrk+HSDjBn66WfN6bT6Ikf5utt04fvI2z1QDfLAJkqAHmAi4UExXI6SOsoNBl7bItz0PZQOZPbQdk5KT/Ax8yHFIL7tf3EUFfk2FokRE+W2ik1ZZWwnVGrsZfcEB7+im/uRUyB6HThCmKrs74T2F0H8g/AmqiWwSCumUrq/SIq1iI8tJ5oe55B4Fb0W5lG4DU0iO5guCFC3DEJb4MldDceJvQER1kX1pqv7PtXpMsqKTMtOebt1OPrcKgw06u76/pFkW0E/UjhA4laaD5NJXCmpI3H90vB2WJepuqlG+jK+tXIKUaIIRw8fyHw4HObzUhwxkRN9mTYHxVuvQKfCm7ygxG4SVOMPuldD4dNDzVjkYBQBgK7Nx31SjKQFDGo5ySyk4vA8wkm/ZKkJMEaAUFCpovDTRdWwqHYOINcEXZJH3lPPuHa2blJhA5xo6KFBhDU/t8Y8rbjJ0r/xqc+YQxlbIZO8oVBZnZyIZNG5lwxpM2P3PVMgYJwEO741FQ3G14KJDOv+WVGiYBpm62zEuR+pVTyXTJUO6XW9z2MsRJ9oPm+MfD8XZ922vZjgZi/NKLxkaelrVImuN4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JdjmJX40gZ78c6/btiU+2zJtszvHWJVIW/l+TUoLIFTd18C+QBWeHLz8mbBv?=
 =?us-ascii?Q?BOehVMS1jAdpO/FtDg17TcWiONPXVMZGadFoSiPsGNIMBRjJjo/DA8frxQqe?=
 =?us-ascii?Q?oG1kfiHwwGXimoC0Ce7Yo3h+C6QmkL2cVRLpgyff1I8OUj3B8I/QGg/Tnb46?=
 =?us-ascii?Q?exOlIjMcieNRO6UK84AdgXgvuNLoFmd45PD1MCJo9WywBrhjtzAQtA2EwKbg?=
 =?us-ascii?Q?NE2ykkgUHb13GU+qhP0X/mbp4FzWw1+YgtQCloGZ6Z5XegSYgznibdx/up9U?=
 =?us-ascii?Q?uBJPsorf1XG/uC+DROm19TE/zOw9KqJo9OQWnPmVNShJ6xNXNQaryen/wmlg?=
 =?us-ascii?Q?b7rGPUTq1G3bh3lmR0AGXNNsgV9yzN0BOATTmwatCDda5UmDCsospQkXWrX/?=
 =?us-ascii?Q?9WL+xGxYJlQ5DPkYfNIx9uUcCW3Q2i0RYQXUflTTsJU9JGTi1UdueMvFENdg?=
 =?us-ascii?Q?do1dP9iR/HAWeu2SLagrZYK771Rxd7KE8I3PbwsiFdK6q6YLMcC+7GI3T94z?=
 =?us-ascii?Q?2nVWGDJV67baXzTlceG5NIY5Sufxqn9b/8WcaOY16xZq/vi5M/uCAX4x/bn3?=
 =?us-ascii?Q?5W+BMwjAeHkcZ9IAQdgxI9gaieH3jMy3rJd2ExDatB1OVhO9re0ktEKZic7J?=
 =?us-ascii?Q?aEDZRB6HiU07C66DsB4SaCkkjQ1hBtllyyLCDMq84UgFKfJT5CI62nPnBFrn?=
 =?us-ascii?Q?CHb85IcAZLYwT64lUi7ZRTsD9ISqIJ5cdQp+c0bRhPI/dhmTTFPjV2KDhsSV?=
 =?us-ascii?Q?8Ar6l92zGUW8Ch2nU8c2G5AefZz2IoLhBLWaIcOZBymuGwDfDoU4vqwVd7j9?=
 =?us-ascii?Q?iqesxvWLqyNHDqrMSNw12tdpvxkzA7+yeAWTXYJZE3ia9tc+J52/x3x8lUD2?=
 =?us-ascii?Q?AI0lJRKoXElz6j6Iso7nE0hdmPoDG2owGu/4HqWhjS1Gg8N2pfLPrXq3vSJX?=
 =?us-ascii?Q?0CB6VxotcA5ceER42x5ly067V18dQ9cJWwpZI7mr8dqs9bg1Lb4FsWQOK6Hy?=
 =?us-ascii?Q?IQyHS+zunm8FaQyg1YAQW8NjH2gpA+7sET32WGJv6+PUfaiIfWLOkLxAcxRy?=
 =?us-ascii?Q?AYl63gFwBGit6bpmB1OFh7q+R3yNL+YZ1lVkDUPZrbAMVg4EQY6DW4Wu+zXL?=
 =?us-ascii?Q?06cO7zBkurIfTjWNVO8uaC0e80r1P9YRJzLqV/uo1+eOKyn7vCDj+4noQVzY?=
 =?us-ascii?Q?ysFW+95TSmyGMvyxlfEOPy09rjurSsZf313M7v4Qk7hGyMx+v0wf9LusY0dn?=
 =?us-ascii?Q?aRAIDICwyCn2jU5TL7B2CVe54OKR+F+9XElERgUo22c8FSN/vZI+vgaWH5jC?=
 =?us-ascii?Q?IjK85WZxtKdOu9VfFzFsj8lnahxM4NZYKp6H8rIfvdf5d2+BrahsJzUvZ+M5?=
 =?us-ascii?Q?DYXdh+tP6VsXXJtWrA18UalLsSzHew3kA8cXAdykNxi5D+okQC37YT+Ahz9J?=
 =?us-ascii?Q?3FjCifVQVXZ37YmQHznDbyzx50t6H+eZAKF+pU7b1Kt7GVUjBy/SKvFx/Qja?=
 =?us-ascii?Q?n47kWh393K00J6dIRMYilkLV2bjvYVyK0zMAaIcmmG5KBDULvYOMywINxa3t?=
 =?us-ascii?Q?SpXQC8n99mV4PuztydI0LaCfQrfATqfkk8v/T8Qb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9dead5-0b67-4d95-b08b-08dc59e623c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 05:13:35.7265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SR3PNLhirwesWi+sDth5GelWhLi0Ihw2ZB3SeiikP/8bNsGB8vBnEUbATPhLfUHnUqdfPph+16H3SxdpmZEmHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7789
X-OriginatorOrg: intel.com

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, April 11, 2024 6:13 AM
>=20
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> This reverts commit 6e24c887732901140f4e82ba2315c2e15f06f1d6.
>=20
> IMS (Interrupt Message Store) support appeared in v6.2, but there are no
> users yet.
>=20
> Remove it for now.  We can add it back when a user comes along.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

