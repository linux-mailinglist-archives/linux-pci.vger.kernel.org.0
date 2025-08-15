Return-Path: <linux-pci+bounces-34100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DE0B27BDE
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 10:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 815EA7B213D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB592D3238;
	Fri, 15 Aug 2025 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iU/9GfQC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BE828399;
	Fri, 15 Aug 2025 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248135; cv=fail; b=ckFXNOqcr9iAxYLaPtNn/S2oGDF64ArppUIR5oT5Pqd+D7zr2imA4qJdr/Y/p4sgq0C31LNsFb/XXttXnnpCzy2cbNIl6Aw9csdCsT+ohEwPXrvR4QPnxVUZMt/bJUzj6860EEFvkrz9/OT3P4Jpdb4yk0LeLMyAJAsu3pwlQ9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248135; c=relaxed/simple;
	bh=P78ljHkFi0XsKP0ZO9cP+r1NhBR77e5uswviDfvI8Bo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s+mBIBw/enYN7oxGxpMfkDcUIp10ppdoQck3Vf5W7pCtlPHD1dMGu5aRQKmyejaK6f0WS1OrnbW3HmTw0YuyQs60I67NIBcgHG+gflJH8aHV/2MoHraB2cm5xU7i7R9hutm5Lf6iEdah6/dK9vzDsAZEyGXYDcXy2QbEpC8FRVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iU/9GfQC; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755248134; x=1786784134;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P78ljHkFi0XsKP0ZO9cP+r1NhBR77e5uswviDfvI8Bo=;
  b=iU/9GfQCHPNYgnO15jL7MqLlomOC43w0/iEjLWxtL7cJUIQwAwAGq1Tf
   IzM0ft9iDa7yPXSoS2TmEDjO114n123i2lBqaeHL/NZIlCxwrro2zNxnw
   7E3Yr71iUJAABRTC4xPaj7yXEXm2rFw50n46+cwlJNDGTWVjuvN0NX3on
   Fjy5T7sAfe0iCHjqi2BRc55gx7pK98vCW6RTGmdj478kWgjTnJPNzRXCw
   GcVcRP9HPfbNMHqwqxk/EUPPMVzsVhfb5eMVkhH0kUGvVnKK5yANHWL35
   CGE3sRlQBPprZL00KCaow12mjn50DozqgpEWG5nzSWWrAONZoWFj1p3X7
   A==;
X-CSE-ConnectionGUID: e6LrjFD2QYGxrkjcmqzzbw==
X-CSE-MsgGUID: vuUxZaZHTu+izcFLw9tU/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="83004260"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="83004260"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 01:55:33 -0700
X-CSE-ConnectionGUID: r4Jb5twVR+OuqwiHAsrDiQ==
X-CSE-MsgGUID: 3rXX/iVhS8iFr184s97xzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="171176307"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 01:55:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 01:55:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 01:55:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.52)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 01:55:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8k0OoK1k65oerpMBBv1DFVBaQ/G11gMKRHGWvOCNP4D3rIdvAxT55V2/BQK3O2cjj4LIHcFiV/ykoZbslA4tDgPdECV5cjVrkYv3oHydKMKx5mtL9EImy7m6PtaUK3XNozDLi2YryDwXbz9FmC/yQUMyqzCvzXm7d7XZcBOlsDvgSlaqMrXfEVk+jnc6t+fX6//TLYOYe5hKWd2EgAFprdPN519iaFLefSPx5+gg12A7dD5SAnIP5+ubE5srvUc9ewBa24omDG43Mlyy0n8S3YNapBbgcV/+0OhqZiN+CR90eb0XqGkfpiXaV4YkyfOUitN2nlY9VqEif7yJUSBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIepCS12bFqKv5Eb+Y5kjgJJuExDZf+V5KCTk5DXIcY=;
 b=DqNaLwyXsKt4bjdB//EkeS6cuAqmgVadNpiTk0vclX53AJGLnLcaad9fM7dd22Cbyuslv/ikM9MgGTqAXGiRLu7uTOClBoswawjet9Wy/VX7InHqqKhAm+doJfe6DjTyGiILMZcEISakZT1E2AIGXlSXsQXEq2L/x1GCkRi4cmoZ6W+BEs/SmoEjC8MtaBjKMjNV+mle3vUHh/m73rhydY8BrT0fHsiT+OFDgBerv038N3INxC+uPfNoEDg88PINbknGm7Glb+/XApCzndy+qyagvBa9h2UwmbVePQx2iuMNE5X/Ej2ATAL7lOoJwlh2yaiIh666vFeDkPuYjO5CIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4854.namprd11.prod.outlook.com (2603:10b6:510:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 08:55:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 08:55:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.clark@oss.qualcomm.com"
	<robin.clark@oss.qualcomm.com>, "yong.wu@mediatek.com"
	<yong.wu@mediatek.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "Jaroszynski, Piotr" <pjaroszynski@nvidia.com>,
	"Sethi, Vikram" <vsethi@nvidia.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "etzhao1900@gmail.com" <etzhao1900@gmail.com>
Subject: RE: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Thread-Topic: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Thread-Index: AQHcCxPRj0zb6W5cHUaGmJqSwKG0krRja68A
Date: Fri, 15 Aug 2025 08:55:28 +0000
Message-ID: <BN9PR11MB52769ACDFED7201CE282FE3C8C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
In-Reply-To: <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4854:EE_
x-ms-office365-filtering-correlation-id: ead7ad91-b026-405b-19a8-08dddbd97bec
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?fAwDAGg+uISwY9gGhOE8Qxd+qdN4mOSU1LtG3s9ft0Rna9XfoYW4v5vx96+G?=
 =?us-ascii?Q?THMLckEQ8C2Uz7MjMGMPRgTL8dUL9AJNle3wkljhUrHDKfEge/XjuYeJpoh1?=
 =?us-ascii?Q?HOLCxqHZb79kisLDDqxLNjteXpcN+bKnCb3FiEhiSJ6Vh51+2/lXrbJ2w5SH?=
 =?us-ascii?Q?aW4aqjKyP8Ymu0DwweYYISzYmAEhxHGrUUHAaqwWnmlifBfKyPATfJlNjxBX?=
 =?us-ascii?Q?kgwD4N5qLyoutrAwTwjMfW5dUILmEM5zpST4Wh9TWEJiZAx+kKkOKibzI3EE?=
 =?us-ascii?Q?nk1YwWHOgqsPp/nwiTlnZhIvh1OPLqDicfFVODJHkssbk2NAaVS+RPWJfn81?=
 =?us-ascii?Q?8V9qxH0xiFm+xFU0fjOxZfOZHxN4ioQ8LSfyCj2ZVmEzmUOJ3dTJDYOHlbUo?=
 =?us-ascii?Q?ZLi3hEKaCAvoKl3rT9Fb48UUe+eVjvZam6eQESMrHI/HqYz4uRgpzFyMLFUU?=
 =?us-ascii?Q?mkKRvgM/YI//vWZ5c3aHbOQwLggFRnqTsXDdaFB+joGDldN4UGbiyYLygd7U?=
 =?us-ascii?Q?s9Bc3ltfdegabNOarGLvHfel/HT9UMFDyIRmMOAxh3C/H6d1ziDT6XPi7xWN?=
 =?us-ascii?Q?S+rdHTMSMCmE/HEeZVtBfyV7tR1JznVxrPDBB2yXnNboDCP8XVQWZ1m1ioig?=
 =?us-ascii?Q?PVDZcHUN5m9W4XPJ6Z+aIZhIxYUgBWNTH7ygHzttmoxzMB/unFDzhkG5o22c?=
 =?us-ascii?Q?WbuIViDUZnORABiUTeUB/ULGu2zdP79P6a+QSnMXcIJInJcESswtVXqHdicE?=
 =?us-ascii?Q?YxjBVOgLVywXl+feAA4ER4RbIy3mII0SzmZjtRqct/g/xslwumcP3e78Jyn6?=
 =?us-ascii?Q?o/CsjjH3V9kZUB8rvW9KboXMIDjgZFuDm7wn8qm7pxcTZ6nlja6yDntCMikf?=
 =?us-ascii?Q?Q8zPj9PlQleAydX898dO3k44DW8MOY2jT8d9YIcczo2YbIjekG526slpdHdn?=
 =?us-ascii?Q?UwgaFThS6V16goNdvVyJPzyL8cldaN1C0NGSXmDBFIGvd5lfmFqrVaeQZyuc?=
 =?us-ascii?Q?nAkAN2MaAV4RuuQSCgQ6lCcDL8cuZmmjcF3+Mq94AwKN1p7Zv3Vda1GyVTxM?=
 =?us-ascii?Q?F4U7QuSqpNodlP59+FfFFXV8Fbh1b7zVanL1psI6is83Z9Sq7Uu5sQ4qDwpf?=
 =?us-ascii?Q?9IY68ZGsgj8S5FK+ENoHDPS6l+Evt1GthzkX0LBdwMN5JXaeqrUSmeyk/LTB?=
 =?us-ascii?Q?/vlNDdjSCAUDVe49VF6vKaepq/njC/ICgppPQESoBkzcTiYboTX5/xPQbrOk?=
 =?us-ascii?Q?ich2Jc+VVgFlnU6dNS53NX54o5AOvlmtYkAbPgvrCy0P45XlXRVNQ0mWly+E?=
 =?us-ascii?Q?LUtY4+dGTiNP16jEduRtSSJ2Eds831brFw2dXIUhsxF/eLKhPC7DIZOcIJUK?=
 =?us-ascii?Q?gpXh9qmezZCl4pfXfBy14DUlnaob7lvggWIgndVWAhF2ROGo0s/EC6rjSh5f?=
 =?us-ascii?Q?SHCzedVHkTYKCeMu143eyhkB0lH+GO8xV4lbGtNP0STDEjtZTC+fMA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/bngbC7Lxu+pALJ2qlUDqdncCqSUjuBmUPJm2PY9uBbr9hX4VOSfL3QfC3f0?=
 =?us-ascii?Q?IiUnt0GkA45I2sKfFPLiv+/FfCftoonL3JEIfTWnzzo352rfc/CpiO9KGYe6?=
 =?us-ascii?Q?Webihyg4zoNXWzYXCI/FNCafEWOR/mXh4GlTjIpJAvjiD0AjERcnrIm/lCGk?=
 =?us-ascii?Q?eHC6x4BNhjAUMi5rc71N5xJUA3luAKBbTB6p0jykp37gxtKRUPJVgsCvJy20?=
 =?us-ascii?Q?KUzHdHtTYQ0KwYCWE5+1cK8Ocv++ENX9gkWqoKLntnQqRDBA0qiCN0W2wOkZ?=
 =?us-ascii?Q?4rB3yf3SIvJsgmPSK9ZFxKE6yandHILkaBteNjh/knEX7s0l/xb+HPx62pmp?=
 =?us-ascii?Q?T1/2nWXFXXu2PODGrU5RADHqkblJb3UEUlPmu8P0RcajH/qBRVgWGJS+LF4p?=
 =?us-ascii?Q?ZujVOMs+KRiX1GDxzPKLuSN22fEDwRWqAoOooQoDEbOz3blbO4pQO4glHqRj?=
 =?us-ascii?Q?dgl2vuSVANXVF5AG9IEYdXPXaWv7g9NgzH8RaF+P6CcYkjL/nSFIjIh81XbX?=
 =?us-ascii?Q?wnpcLScfM/ErjW4tVgYq0ST7Sl4JU1H6+iL3DAf+/Na0IN2P5KBIuKEMVCY5?=
 =?us-ascii?Q?DNfWp2dc2mlpJlKcpFHk7LpX5ofuwdyVY63+mN59FOX6JWyJYyoTC54flfrM?=
 =?us-ascii?Q?ZHVzaCcodc6Kk9OwZH4Bo872S7LH8r5pFhjSirevwZF6fhauMEc3VqFKNmIc?=
 =?us-ascii?Q?TC5TiL6ICt/OFo89bt4Y28Ncqu4R9N8oCG/xifzcU7cZGqt72x5jCkAUKj4u?=
 =?us-ascii?Q?2+FjLrq/Jpkm5+gd+hYTptYzfme4EYuWQe5FHfYSVr75j3E5EPTyTdqUTVRR?=
 =?us-ascii?Q?O6NadACCuMe5r8tTLHlMArXDR165XWg/n9Th+TpromyLsVNr6s3ttcvYUwiT?=
 =?us-ascii?Q?RiBplVFpjLhc6kj02JCxqO6X7WsKg7vn43JgXtx4qkmnEMm6YZvfhUGCqgbg?=
 =?us-ascii?Q?TFzJ3FLQ13J82ZjTdmpBjw07KrW+hkfMwc2DhwMdU9loD/WEzi3iTiH1GUE1?=
 =?us-ascii?Q?1sscpdSRqS4rBAD+9gaomR5gAVEYDhNCQB6TMkYdZbmkyaiUHO6pq+fmDzpE?=
 =?us-ascii?Q?UrHV7TYnQal41dvszZsISWCYYll28dgCecz+fwpGPlFvTNkMPWFGa/lWo/Ji?=
 =?us-ascii?Q?Rjjtc8cHFO2xZ5EpsM7UceAuisVNum3xUSWuDR1+OekOD3MVBsXO98b7wmiv?=
 =?us-ascii?Q?BjMlES6lkwpowtCIpspBIWjLMB3Hlgwx+R/SrlLYyg57uCTuGeRTvFH2MNOO?=
 =?us-ascii?Q?Uj5VftNap5Pd5RFwzYKp5hElhBWw98TjX+urSZJpjvpFjNjEMFS1Yd3kTwox?=
 =?us-ascii?Q?CP+agEDKyh7414EEjEUTBh1EDe0Q2jFOqo7cqxi+dOi95m1pR4LEh8N1IzjO?=
 =?us-ascii?Q?VAuASKZzlasb55NN3mZbZaK05rFj2XXxUaRTMG7oK3XgPurcWvC3VZPI250M?=
 =?us-ascii?Q?yukd0tDs+d/N0b/wOl/B0UTJHpm0/3QQfw0rxdQVCmnAVRZwEzJmf67QcV1Y?=
 =?us-ascii?Q?Zap1MQ8U7TDEFQSRXHqO5lsL7GmqT4mpS/aYkosb7yeuV4U5jvwoWM6WlZzi?=
 =?us-ascii?Q?K1zvIOcpvSe4oSqXYikOsWKEqdx8IsN00ox94akn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ead7ad91-b026-405b-19a8-08dddbd97bec
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 08:55:28.9565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yKpOCKPkrQdMtQo7c2GlFXkD/ODA6LJRDJvzofQ1FZu2s5hGhmN/WP21Fh5Gh8726+zgvXznlbDq1Ljf7ui/gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4854
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, August 12, 2025 6:59 AM
>=20
> There is a need to attach a PCI device that's under a reset to temporally
> the blocked domain (i.e. detach it from its previously attached domain),
> and then to reattach it back to its previous domain (i.e. detach it from
> the blocked domain) after reset.
>=20
> During the reset stage, there can be races from other attach/detachment.
> To solve this, a per-gdev reset flag will be introduced so that all the
> attach functions will bypass the driver-level attach_dev callbacks, but
> only update the group->domain pointer. The reset recovery procedure will
> attach directly to the cached pointer so things will be back to normal.
>=20
> On the other hand, the iommu_get_domain_for_dev() API always returns the
> group->domain pointer, and several IOMMMU drivers call this API in their
> attach_dev callback functions to get the currently attached domain for a
> device, which will be broken for the recovery case mentioned above:
>  1. core asks the driver to attach dev from blocked to group->domain
>  2. driver attaches dev from group->domain to group->domain

the 2nd bullet implies that a driver may skip the operation by noting that
old domain is same as the new one?

>=20
> So, iommu_get_domain_for_dev() should check the gdev flag and return the
> blocked domain if the flag is set. But the caller of this API could hold
> the group->mutex already or not, making it difficult to add the lock.
>=20
> Introduce a new iommu_get_domain_for_dev_locked() helper to be used by
> those drivers in a context that is already under the protection of the
> group->mutex, e.g. those attach_dev callback functions. And roll out the
> new helper to all the existing IOMMU drivers.

iommu_get_domain_for_dev() is also called outside of attach_dev
callback functions, e.g. malidp_get_pgsize_bitmap(). and the returned
info according to the attached domain might be saved in static
structures, e.g.:

	ms->mmu_prefetch_pgsize =3D malidp_get_pgsize_bitmap(mp);

would that cause weird issues when blocking domain is returned
though one may not expect reset to happen at that point?

> +/* Caller can be any general/external function that isn't an IOMMU callb=
ack
> */
>  struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)

s/can/must/ ?


