Return-Path: <linux-pci+bounces-31232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C134EAF101C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 11:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD8A1C27A74
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 09:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C39248166;
	Wed,  2 Jul 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RB1u6/Yf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFA9242D93;
	Wed,  2 Jul 2025 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448981; cv=fail; b=KcKLdEGoXnXnuI2h2QatnXSMV4ck5P6ezFOmrwAIs4ucORUfQYQuCJYPz91xdPyq8fywhqY2xCX6Ue8sodVJ6+T/FKhddm5T2u9R9A+HUeE9GBezdSS2E6fB5DvByK4fOJnHCssY1efwVGLJg5JBbpLYeh1FVCLBrGWDxJSR0E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448981; c=relaxed/simple;
	bh=SFUeTta9xw2rzV7j9vU/7losU1uWbNldGh53+x0QK1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k2aOs2XJAqQDC4LX6eKNyR6Z9mhtUitWn4OdFidtv3ARVkEiUXKxhB0mTok1XSYDSF214eCt5qsUJYJEhH7GHrP6CIWAbmNH8NdxcZHk4AlIgXRWyw4C7MH29A7b7t7JeLDp0DA3VIfkEAPMhnWI9U1JE0S29hy5pxbjwF3ywDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RB1u6/Yf; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751448979; x=1782984979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=SFUeTta9xw2rzV7j9vU/7losU1uWbNldGh53+x0QK1k=;
  b=RB1u6/YflrUwcFaNELyoWnauY7kKpWE9ilFOIudEwZmSwIhBfqs75jkc
   8Orc5utqekhv2Bb8AaFMSQ/FnUI84fNlEmm1XWh+fFsxR6ClSTzmAgASY
   Zr4+ud7+n2gF5UeyEPXngQvbD7k9ApbVPccOmy0C2oboOMCRoPMKMoI1X
   3zIPkQNwsayv+K9XEOjl7pHlOcjEHB6dP5PCE15WujH8FV+pW5WHxPQ7w
   1V0p/AidcBAUWo35snq7KD2lqW1ZsQa6I6bQfMnd/bq2PwcUgjPrM9Uf9
   x2kJwPE4jrAAUOUuBnvmU1i5ozfL1GvmR61+xAvB4D+Ne02Vulu2XdkYy
   Q==;
X-CSE-ConnectionGUID: D6M2qkGFRJ+QOveXCYgojQ==
X-CSE-MsgGUID: DjP+NyoJTO6pMOxZWLDTmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="79176917"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="79176917"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:36:12 -0700
X-CSE-ConnectionGUID: fF3zyKiKRVSfw0+LSpwvEg==
X-CSE-MsgGUID: WmRwUvYnRruKhWinYztpnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153431720"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:36:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 02:36:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 02:36:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.77) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 02:36:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMDtMMNFkZkR5CDSch1man3WjWJvTES7LbVZomioBAGyodWfoq2DAyWThYy3psufGWp6d1WsfYd2Vt46th0eD3CqNTMWXWhR9Slq/W80auXC28nifMnB5GP3+0FvE2gEOGJRyOWasmt8ahEcTCPJDkvnGDeMYw6T7NXnWiVEJ8Ny9iV4M4JOLxBU0t1iKoEZ6ibNzdnkux5AoqSvi8siV2+2NYUd5f2wouXwzgbtrNd+11SMq8x+AULO4HM2AcWJjAz9mLZW4iPJKSupmbPVRkvySOZ33RDOHpJ73uRC7oBNxjbnw7sEW8WSQLGsREo2uKacLwJ4mhTwcTYmzqNLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgvonhnhOOp3y9IkBdF3tj7BEdS/9TrASkLg/a7DuGs=;
 b=g0IGkQtJcSlwMIA9j5AmRJMLqNlmWB5255ens9HOsaYaq1XjVVLQ7ldQU7Dm7jTRX2zM1cS+Jja5OEI8BN74GmcJruWiSeZtKhFWXqWhK05kCmriambk6j+KrUvS4r9aUTUv0JkafvFfWks43ceCENrR67AbIhaifpXIAr8l+l8ymBSjB+0K7UrAUvyALgWZrqA+zpAVRah2+jCj5J9Jtc2CLFqZza7gJBk76II1Qpj/arTIyqLUWBufpnJKI14cRQuE0Zl+ymLpE/R9mBsRq2MxmTfXYkjinM5Ibz7PEbaIL3alGzpq8OTVeLilk965gL7/r1asJj3ViWgdjn80sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 SJ0PR11MB4846.namprd11.prod.outlook.com (2603:10b6:a03:2d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 09:36:03 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39%6]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 09:36:03 +0000
From: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Rodrigo
 Vivi" <rodrigo.vivi@intel.com>, Michal Wajdeczko
	<michal.wajdeczko@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Matt Roper
	<matthew.d.roper@intel.com>, =?UTF-8?q?Micha=C5=82=20Winiarski?=
	<michal.winiarski@intel.com>
Subject: [PATCH v10 5/5] PCI: Allow drivers to control VF BAR size
Date: Wed, 2 Jul 2025 11:35:22 +0200
Message-ID: <20250702093522.518099-6-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702093522.518099-1-michal.winiarski@intel.com>
References: <20250702093522.518099-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::14) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5373:EE_|SJ0PR11MB4846:EE_
X-MS-Office365-Filtering-Correlation-Id: bcfb779d-3197-4c82-2340-08ddb94bdccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFBKeGxMODRyS0U5TEp5dzhhaUh1SWYxQlpNSFVDZmlxZGlOcGpWa1haMUd6?=
 =?utf-8?B?Ri93RnRKZVZtSlU5NW1MVWR0V3FaUUJ5MGV2enl1bGpXS1BaYWVreEczMzB1?=
 =?utf-8?B?alNXSmdINVBWUTBuRk5uZ2dCd2pLNWVaKzdLdThrUHlkSkVHZiswUklHeVNz?=
 =?utf-8?B?QUppNzZRN3ZLWGlEZ3RHNlhIMFMvV25JbjRJVXRIQ0tHOUlQK04vRG1zOUtT?=
 =?utf-8?B?dnRWZ0o3ZE8wbEhRdndIQ3p2bVk4RHFYUVEwemI3SE1pMTNZRGRXTDU4QzNq?=
 =?utf-8?B?K0R4TmVJeEZOMTNqdThTaFczUDhqRnhWaXREK2ttLzVjazZzdi81Y2k5SWYv?=
 =?utf-8?B?aVJRb1owNXZMVXordkd1dEFBb3JvbFk4OUFRQ1lXMUpITnlXazVUbVR3a043?=
 =?utf-8?B?WEtha3ZLbHF0anFDRmZoWjNWTVNaVjl4V3YxM0dRWUw5aFF1TzlFQU9TNHJJ?=
 =?utf-8?B?eHhQdzJNSFE0dC9LamtwaGsxVmxpOGgrd09aWU5NbWQrbWdDMG1CS3M4WEVm?=
 =?utf-8?B?ZDQ0V3RMb0xnbXdyMDZDaUFTMmltYVpuek13UWxqQ2JoQnBlYzBxV3RXM2xB?=
 =?utf-8?B?bTlXdmFDSGJtcGw0TG01NDRXVkxEK2V1ejRyVmN0Y0VZSXJFRjJDR2RialZS?=
 =?utf-8?B?cmRyRWp0VHFLS01HVXpwdzM3NG56VXRPU2V0OHZmZ0t2N2tVSzVicTdOM3c5?=
 =?utf-8?B?VEJQZGdKTkdNV2dlMzlpK0J1YUxDc2NlYTZ0YVM1R0YrUVpZOVBlZ2tPTVNS?=
 =?utf-8?B?VzBPOTVHR1FwL1RFQnoxTlVqUnZuMzEyNXdXR1VCMFpxdkxmYVlESUEzbnNC?=
 =?utf-8?B?R0ZCVDh4Sk11TW5ZZHpDUE82K01ONUZuNzFJcSsvdFo2ZkczV2l1elBhekZR?=
 =?utf-8?B?c0R3NThwSFI5UyttekoybVRXSlJrTUdVUXV3dkNnZmtVajlEUXFWOTZBUS9j?=
 =?utf-8?B?eEUrY2hQODhuMGoxWklOVmFKMitMYzNnQTBhMkltc3p6YVgvdUV2TzgxWGJs?=
 =?utf-8?B?cjkrcDJxcVEwNkVjTFBqWjd2dzlnaVhlU2g4TTJIUVV1NzZmdVN4VkpOQmFC?=
 =?utf-8?B?SEllU0lrdHc0SEhtK0JCQnA1djZyMVYzV0hVT2UxMVRxVzRTQVE1akpTNVBH?=
 =?utf-8?B?Sk5QZ3ErWWxmVXVUcTljOVpWNjJpMGZ2SktkSGVNM0QyYlVhVE5lR0sxV1JX?=
 =?utf-8?B?WmlVMGpacTRZRENueGw3QklRQ1gzaFhsRFQ1NjlOMFQ4cGxHZFhlL1U0aUgx?=
 =?utf-8?B?cDZEMzQzS0U5dVlrRU5wUzBwN01vOGo0dUlHU05EMXFsTFFxTllXcHZwM0V3?=
 =?utf-8?B?dXVHcUpKSmhaMStnNmpOTEwrdUxWWG5sN2hjZW50WmpPeS9aSDUwYTRTUFBL?=
 =?utf-8?B?QXYyelVGWUFvMnVDNm4vcVhSaXN0TFBKWFI2a1N0RHdBTllHNjI1V2FUcHRJ?=
 =?utf-8?B?cFErcjAxLzdxaXNoSmxGcEM2NXp3NEsvNXgyUFZMSlIyOGl3MDdBajhpRkEv?=
 =?utf-8?B?WFlRcjhpQWZsYVpYSUp6LzE5UVNlM3NaajU2UERsVVFoeVhoaytyaEMrcUFa?=
 =?utf-8?B?TjJHQmFQVW54aS8vVU5ZaEhjQ1ZEZmhrc2hmK3V1NTBtb0dSSm9QQ0MyRFpM?=
 =?utf-8?B?RWZVRVpORzJ3YVVQSTBrdTMvR0dKZzBXLy80Yzlzb0ZtMGJCVTV6YUpqZzlo?=
 =?utf-8?B?UU1JdzdDU2dZcHcvMC9EdWR5VGVkdU5KbnExOGpNNjg2OWx6SmVWVVMwQlhV?=
 =?utf-8?B?L3QzajhEYU9nc0xUTFRKaENBdldGVDk3emxhVEJUSGJCa0lpNkhGS1Roeitt?=
 =?utf-8?B?V2YzdHliSkVPQmFzdERiN2lmUXEzMUhQSUxhd2x3WXROQ0J2MDBpenlRR3do?=
 =?utf-8?B?NFZHamtyODI1Qy9jc0dod2VrT3ppT3VBc3hTekpjQkJOaVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHdSSWJQYVhKK3U4aEpLb0JhK3M5Q0FUYnBlYWZTMk9oMFNtVWRTQjJkU2oz?=
 =?utf-8?B?cWVYU3lqbkg2Tk1WUWVZdHdMS1IzV1hGbTBHWkJhSEhDdktNYmNqeUdiM0FV?=
 =?utf-8?B?R1M4cUFmZC9MdkpLK1FJSVFTN2dNWFhPdWVyTVdpc3JzS3p4eVFReW1hdXhN?=
 =?utf-8?B?MkV2ZmtXRFcxZGdja1hnaDVUZDdoNnZaaDR1ZGNZSXNsSXByMnZDeTkveTBD?=
 =?utf-8?B?NCs5ZzlSSjcveVZjWDM3b1h6em54eVhlVlNQK2Z1S1dpRXQ4TXJ2SDZaUDdp?=
 =?utf-8?B?WUNLSTJUT1V3MkcwVlgxeEZKcnlmV2hxSTJKcngrSVVlemxTdGFsS0g1NFpm?=
 =?utf-8?B?cWNkcm5FQStmU3djRVhHU3ZtWmlTYXVWUThFZjJnYVNUclFtV2JHTmpMSjBI?=
 =?utf-8?B?UWs1eWVoOHQ5THFZT3diSUFjM3diSlBNYzZmVmpxdTllQm5saGtWeHBCdkxt?=
 =?utf-8?B?SGcvNDhVdWlYaFZ0blFjYmhYeEJTc3F0TGF3bjVjV0Noa3oxdlBmc2ZYNzVp?=
 =?utf-8?B?WEdMaVp2Zk42UWtBNzNQYWU0bFJWLzhjeC8vMm0yajlnNXg2UkVKM2JEdlBY?=
 =?utf-8?B?ZlZpTFhzWDBZVVpDMzloK2lhYWo5UDRFWkxFRHMrZEZlS3cwYkE3U2prRytj?=
 =?utf-8?B?QTdFRjNWMjUxdVhFNXc0OXhXV3BhU1JtTm9LUXc2MWhFVEx6bWFWUFNEcm9D?=
 =?utf-8?B?QjgzcGZZdEd4VDlXd0tZYWZlcU5SWERKV2xRM2RGMHgrOVFvMEV3NkU0Njhk?=
 =?utf-8?B?eHArT01iYllHSnVkcU55U1YwUUVXdFV0WlIwdGdwSlJRZVY2dG1CODVwZWJ4?=
 =?utf-8?B?QTZ4aTZ5WmxJY1ZsVjlveUJxaUNiNzFjZTBXV0lYQ0kzRlFiVFdQZmlYWllG?=
 =?utf-8?B?M0FleStCa3o5azJiYkpubDc3Nkl5V21aVm0wdzdJN0VpZE1IUjhMOW00NFMx?=
 =?utf-8?B?V0pyYWxvTGttNmdNVy93c05RYUtaRi9VTldxb0VVd0xpM0owT1d5bE0rVnFZ?=
 =?utf-8?B?elIwaHpzdE9zWUNuak45OWFHUk1NUTlBS3FtY2Z5NVdWYnc2OVV2SEQwdzRi?=
 =?utf-8?B?U0o1STdQSkp1Szd1dDJITVhPQ1pYU1c3a0lRS1VvQUtqQk9Xb2E0cTNFMWVz?=
 =?utf-8?B?MnBNWWdGMi9HeXB6ZjhMZ0dGalM4enZZc1BKMVlLcjQwYnU0Zy9rK241ZE5i?=
 =?utf-8?B?bXFCR3pWbTRDaVREZzFaMDJNTzZaYjI1Uy8xNnN2bzd1Wm9iVE8xTTZoY0xR?=
 =?utf-8?B?LzRiWGlvQW1aWCtrbXZnNEJFTTZhYXZtMC93dWgzSkxrNC90SGd2Y1p0bmZp?=
 =?utf-8?B?ODhFS0ZiSzJ4L2ZPcEdDRUFhMUp0bVZiMzFEc3NHeXVJa3dPZUlPQ2lsTzlp?=
 =?utf-8?B?N2V0V1k4bHRISm92em00MlNyd2YvVVIrYW4zMXl4alhocDlTREkxRkVzTWk1?=
 =?utf-8?B?UlZtUWgveEZZZGloMnhTTHNhWGp3WlhVMEVDZ0p2amVBNXlQbVBaTDVMM1Ev?=
 =?utf-8?B?eFBweWlWNEF1aTBOOTBzZTgrdTY2Z2R6a0E2Z1JnUkhRLzdwQ1N5QndwT3Ri?=
 =?utf-8?B?M2tsS0w0UXZ6ZVFrUnJ4Y3J4aHFQWFNNdlR4THBwcVhlcURxYWU2YjJqNjhW?=
 =?utf-8?B?Zko1MTR0MkNJRGJEdE1OOEdjVTgyaTQ3RThDVTg2eXNEZzRjU002ZGNNV2NF?=
 =?utf-8?B?bFQrS2pzZHZKL0h6am5Sb0lMeWhFTi9SNng1aW9IendtZVRibXAxY2l6MUFY?=
 =?utf-8?B?SFErSk1pZk11cllvYVNVN3F5Ti9JcDlYUVNFdnZmVGdRODMvWXBBV0xpNnRP?=
 =?utf-8?B?MjFsbE1KbXgvSC94ZU5PaEEyMWlWblBoeWI1ek9yL2JxeVBFRkZQbyt6UDlW?=
 =?utf-8?B?Qjd2M2FiYzlNS1RUdVc4QlB2WnBzQS80STFhM2xQVGJvazZJM1Q3dGllRGJV?=
 =?utf-8?B?NWI3UDNuTWJUSGRoeUcwWlRxRnZxZVBpdGtaN0ZONG9tNTBFVFdNdlBIUVdl?=
 =?utf-8?B?c0I3VE82Tm5mZEgrOXM5R0ZmMWI2dzlGWGEwMyt6ZWtybE52N2VVTTM4NWJT?=
 =?utf-8?B?U1huUDd0ekZkY0lsRWtoQklJanoycGxYaVljQW1hc2FBUFliNndXNmRvSXdz?=
 =?utf-8?B?SGtsbGJDYzdJNjR3MDcwd3p3Vk1zSzlhTXRUaVQvazI3VXhlN3FrbWlpRmli?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfb779d-3197-4c82-2340-08ddb94bdccc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:36:03.5735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEvTpY1Xqe+5cjq96UyZxK+4Q9RGKnhxBq1IZUQgVBYRny1KL2hnxAE0i9f8h+lIVh4M87pl6fyHGcBCZsQC422WIUvTIBhAd16EfZAdBh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4846
X-OriginatorOrg: intel.com

Drivers could leverage the fact that the VF BAR MMIO reservation is
created for total number of VFs supported by the device by resizing the
BAR to larger size when smaller number of VFs is enabled.

Add a pci_iov_vf_bar_set_size() function to control the size and a
pci_iov_vf_bar_get_sizes() helper to get the VF BAR sizes that will
allow up to num_vfs to be successfully enabled with the current
underlying reservation size.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/iov.c   | 73 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  6 ++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index f34173c70b32a..ac4375954c947 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -8,11 +8,15 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/log2.h>
 #include <linux/pci.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/string.h>
 #include <linux/delay.h>
+#include <asm/div64.h>
 #include "pci.h"
 
 #define VIRTFN_ID_LEN	17	/* "virtfn%u\0" for 2^32 - 1 */
@@ -1313,3 +1317,72 @@ int pci_sriov_configure_simple(struct pci_dev *dev, int nr_virtfn)
 	return nr_virtfn;
 }
 EXPORT_SYMBOL_GPL(pci_sriov_configure_simple);
+
+/**
+ * pci_iov_vf_bar_set_size - set a new size for a VF BAR
+ * @dev: the PCI device
+ * @resno: the resource number
+ * @size: new size as defined in the spec (0=1MB, 31=128TB)
+ *
+ * Set the new size of a VF BAR that supports VF resizable BAR capability.
+ * Unlike pci_resize_resource(), this does not cause the resource that
+ * reserves the MMIO space (originally up to total_VFs) to be resized, which
+ * means that following calls to pci_enable_sriov() can fail if the resources
+ * no longer fit.
+ *
+ * Return: 0 on success, or negative on failure.
+ */
+int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size)
+{
+	u32 sizes;
+	int ret;
+
+	if (!pci_resource_is_iov(resno))
+		return -EINVAL;
+
+	if (pci_iov_is_memory_decoding_enabled(dev))
+		return -EBUSY;
+
+	sizes = pci_rebar_get_possible_sizes(dev, resno);
+	if (!sizes)
+		return -ENOTSUPP;
+
+	if (!(sizes & BIT(size)))
+		return -EINVAL;
+
+	ret = pci_rebar_set_size(dev, resno, size);
+	if (ret)
+		return ret;
+
+	pci_iov_resource_set_size(dev, resno, pci_rebar_size_to_bytes(size));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_iov_vf_bar_set_size);
+
+/**
+ * pci_iov_vf_bar_get_sizes - get VF BAR sizes allowing to create up to num_vfs
+ * @dev: the PCI device
+ * @resno: the resource number
+ * @num_vfs: number of VFs
+ *
+ * Get the sizes of a VF resizable BAR that can accommodate @num_vfs within
+ * the currently assigned size of the resource @resno.
+ *
+ * Return: A bitmask of sizes in format defined in the spec (bit 0=1MB,
+ * bit 31=128TB).
+ */
+u32 pci_iov_vf_bar_get_sizes(struct pci_dev *dev, int resno, int num_vfs)
+{
+	u64 vf_len = pci_resource_len(dev, resno);
+	u32 sizes;
+
+	if (!num_vfs)
+		return 0;
+
+	do_div(vf_len, num_vfs);
+	sizes = (roundup_pow_of_two(vf_len + 1) - 1) >> ilog2(SZ_1M);
+
+	return sizes & pci_rebar_get_possible_sizes(dev, resno);
+}
+EXPORT_SYMBOL_GPL(pci_iov_vf_bar_get_sizes);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f3923..28f06045ab200 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2438,6 +2438,8 @@ int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
 int pci_sriov_get_totalvfs(struct pci_dev *dev);
 int pci_sriov_configure_simple(struct pci_dev *dev, int nr_virtfn);
 resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
+int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size);
+u32 pci_iov_vf_bar_get_sizes(struct pci_dev *dev, int resno, int num_vfs);
 void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe);
 
 /* Arch may override these (weak) */
@@ -2490,6 +2492,10 @@ static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
 #define pci_sriov_configure_simple	NULL
 static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 { return 0; }
+static inline int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size)
+{ return -ENODEV; }
+static inline u32 pci_iov_vf_bar_get_sizes(struct pci_dev *dev, int resno, int num_vfs)
+{ return 0; }
 static inline void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe) { }
 #endif
 
-- 
2.49.0


