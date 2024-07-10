Return-Path: <linux-pci+bounces-10038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D95B92C95C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 05:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95AD71F241C9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 03:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A053BBD8;
	Wed, 10 Jul 2024 03:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VrRryHog";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="v9i+PKUD"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3782939FCF;
	Wed, 10 Jul 2024 03:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720582856; cv=fail; b=BVVz8qMmAS/b6f0Entu713rzfAQZRp8JNz95QEsqcfN9peSAWskRosHjmcgq1ivB+7i6zVGJZ9MJdY4VQhxWnru/NAimS1Y/pGSWGfIFB0VDlpGDGw32hZJalOoV1QLUyBx74mmyD9LnxSBdav2lCuzEBUUXxdJmdHdDT/127sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720582856; c=relaxed/simple;
	bh=EtO/aw1Tj/gcyckch3IYaxHBUCupeiXiJJBuJ/15jAg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WrzHyPaJFV5DC5QRCVFBRxbt5muPqmh33aEVYEdyvz05i9B78cdqcDXgQ0VDliMPtSwXHyPwbP5Hw88YyLc94A5+11CWBvOEulWraJGxB544q8E++3RRjUws6QFsP8Nl6ua92pwUCjXXKa63f+zgGPBHn3KE6oRbz1mBLWkaCLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VrRryHog; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=v9i+PKUD; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720582854; x=1752118854;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EtO/aw1Tj/gcyckch3IYaxHBUCupeiXiJJBuJ/15jAg=;
  b=VrRryHogG+zXGdVR5KcXWWxdROI1B7qSgxHKh/SpNd9XrIhKnZGra3fD
   1rK+DAL5H53g04Y0tFDkxedRgnRquRG1qHeb/byQ7PiUgVwFjaOQbMgxj
   yG1Qv6oCxbuZtFsca2FQoxJpVn5BOpqeXweJsjQY4PT0mWhXTej1ZqWBo
   /LB2xdmQQ24Fcs6/G0ECT8LP2ZcDWrUEIItLe+IJJmEy+rNASCEK9e/MO
   /IPkut2YHThweiUd2K5ae5Ws+92mB28acBI04Hhu0YXzL2bfwVCVTrWP3
   SapLhNPA65Jh6coIc8wqs8G+J9y3E9NXTVLwAViVMjknG016cyYqkMTR9
   A==;
X-CSE-ConnectionGUID: Y2Wwpz8YSGaTj206QbEpSg==
X-CSE-MsgGUID: 3vk9g/j/S8eCbxKLb1fE1w==
X-IronPort-AV: E=Sophos;i="6.09,196,1716220800"; 
   d="scan'208";a="22018991"
Received: from mail-centralusazlp17011028.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.28])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2024 11:40:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5QEaWYcAY2P0KI6MgkwqFXQUxcsYbMjMb3XA+Xl8Ovwf3uD8ROpSj9MJcDz3PYpxmdljUkAHw1V+d+fhwvWP7v4IJAudMoMrOLNRIvHN4BHGJUYwagsx0OaRkwWi68Pysel+YrFIoxLaNoJaZQgbBWCvDqqcPmmVAhnqR8L7rj9TPUuodSwY/NftEBl+D1cROln/AzjiFmxhplV9e+0kUTETq3aLYcKQajMf3ywud7WKGRL5xCLEujjXCg558kvt3qOJwRt2It5Jm8ZwZFeXSE/ipOu493Mwlhep6g6r+3lT4PX9huQhItriJaqauKnsYLiBj8o66GNNPVGW//yiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtO/aw1Tj/gcyckch3IYaxHBUCupeiXiJJBuJ/15jAg=;
 b=DWirmUgGJOHc3VuZYXtmXoC15tZcg4jukGKMLs2JqYyxzRzfyLbfyni19qCIpQdThGRBzyOf5/IktsTKBJZafkdNHDTcDNErXZS9q8er3EhVo112I/p9D0E6nSzZOcM4CwfEk69QCY1g5J6RfgdClzkroiPYB8cC52tmYH1to/CsrJarVGI+SyOPzNvb5M6ldQ0TRBdxBmArIDIUEa/EwJj9Y0WLtPJaXXRyRq4fKA6JLiWuOlaIkobb4a4UJhgXyKMdSspy5HfeOPG2TlG6VqwUngNuE6lqDO9FZDBu+uPBkj2p4fJbRsNUEZnN4BwTedWXrT6AZQf0FpJySFkQjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtO/aw1Tj/gcyckch3IYaxHBUCupeiXiJJBuJ/15jAg=;
 b=v9i+PKUDfKEQf+K0k2ZPNBxlUOm0xiFV4CVqE+w42V+Rr29WsqFJOGFJeJnQDsKh3RMV0Y/6nwQwsjJiqbcOZqtOLGxQ7JLvgsxY1BX5D6ZbDdWSAR73tjye5BWDJRfXGYVrZc/keBnmq4t56ND5j1KSDEPL8gcRhDD+OjB+hbg=
Received: from CO6PR04MB7857.namprd04.prod.outlook.com (2603:10b6:5:35f::13)
 by BY1PR04MB9658.namprd04.prod.outlook.com (2603:10b6:a03:5b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 10 Jul
 2024 03:40:49 +0000
Received: from CO6PR04MB7857.namprd04.prod.outlook.com
 ([fe80::20ca:cf38:92a8:6922]) by CO6PR04MB7857.namprd04.prod.outlook.com
 ([fe80::20ca:cf38:92a8:6922%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 03:40:49 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "dhowells@redhat.com" <dhowells@redhat.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>
CC: "sameo@rivosinc.com" <sameo@rivosinc.com>, "graf@amazon.com"
	<graf@amazon.com>, "jglisse@google.com" <jglisse@google.com>,
	"ming4.li@intel.com" <ming4.li@intel.com>, "gdhanuskodi@nvidia.com"
	<gdhanuskodi@nvidia.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	"seanjc@google.com" <seanjc@google.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "david.e.box@intel.com"
	<david.e.box@intel.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
	"dhaval.giani@amd.com" <dhaval.giani@amd.com>, "aik@amd.com" <aik@amd.com>,
	"pgonda@google.com" <pgonda@google.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v2 10/18] PCI/CMA: Reauthenticate devices on reset and
 resume
Thread-Topic: [PATCH v2 10/18] PCI/CMA: Reauthenticate devices on reset and
 resume
Thread-Index: AQHayys4VTHKfkZyPE2CywacKDD9m7HvX5EA
Date: Wed, 10 Jul 2024 03:40:48 +0000
Message-ID: <b024aaacce709ede085aec184cf4ec02d970dcf7.camel@wdc.com>
References: <cover.1719771133.git.lukas@wunner.de>
	 <bd850e8257552d47433bdb2e10fa9b0a49659a4e.1719771133.git.lukas@wunner.de>
In-Reply-To:
 <bd850e8257552d47433bdb2e10fa9b0a49659a4e.1719771133.git.lukas@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR04MB7857:EE_|BY1PR04MB9658:EE_
x-ms-office365-filtering-correlation-id: cfdecdc6-01ff-4c94-b960-08dca09216f1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?eElPNE9hQVd4UUF4NWV5VEVxekZXN2xRNnNBZDB3aEVBRzhDVjBBSjRKT1pO?=
 =?utf-8?B?a3l5NTN2ZEduMDhOZ05XMkIrZGNkTk43UWREWEhydlg5WU9rN3pZU3paV1Iz?=
 =?utf-8?B?ZnJOWlFEZ2NNeE5hMFJUcnFqYkNiYUFvQWtQcU4xTTc1TzJUWFRYTzZ4RkRs?=
 =?utf-8?B?NDFES002WnRhSXJmMTBZd1hJandmSHMvU2lDdVkwV1BVMTNCU3Nvd2l3aW1i?=
 =?utf-8?B?eGR4VE9CUkpHQm1wNEtZZFhQYnZ2WVpxcXgyQUJvNERrOUhyZTV3bFYwQlUw?=
 =?utf-8?B?TXB3dHNFM2ttTmI4UmxBUG5PQ0JhOU4rbVQrM2Z6RS94OSthdjZUQ0kvZmVQ?=
 =?utf-8?B?aFpraE15Q3JUY1Y3UnEwWG5ZTlkrRGNzd1FoUlQ5MS9YOXpOQ05ITGpnT2Z3?=
 =?utf-8?B?cjlMbzVFVm1oUnRvOWVQUUhHTENYS2F3REhZQnlLdVJaeWZnRldobC9jdjV4?=
 =?utf-8?B?a2JrUEVYSEhsTzJNSWRmc01DcDUzWmxIa3hjOWo3QTRnTlNHNWR1MkdNSzNR?=
 =?utf-8?B?bVJVMFFSS1JSQVdJVCtNN3VqMzJKNCtETWcyRFNxZ2JxNTB0aTJWUGx0MHND?=
 =?utf-8?B?TVMzYTVPdWNLSm01T0ZjWVAyUUNIcXpoYUJhYzJMc2RHVWlVMnVMYWZ3eU5V?=
 =?utf-8?B?cWpVTjlKYUlYZDlWS3RvN0dJQTF6eEpLWkNwbmhjV1d3ekRZZDBPT3V5bElS?=
 =?utf-8?B?ZXQ4YjJzSlVkYndKcFVKZTRHY1VDclpHaFJhUkdJb1pRVUZGTnVxVFZSa0xW?=
 =?utf-8?B?T1NRTjR1MVNmWHQ0Unp5Q0VVdDgxdnQ1WWpPZDVBV1BBNHJiaVQ4cW8zT0Rt?=
 =?utf-8?B?blNUeXVQS3RUYjZJU0V3WkowN0JTM01ReXA1YzMxQ244QTB5b1FQQ21rdjVh?=
 =?utf-8?B?VEx2NkJ0SnNGUzluZVN2cmhOY09jeWZ3aDJVZTJvZGZzaUNPaGxEZzk1dGp0?=
 =?utf-8?B?cVpjUm9ILzRNaEpEcHFwZEJTODNoNlF5QUtnWWdJY293SDducFhPa1kzT1pF?=
 =?utf-8?B?a1AxZlBmRTRUWm1iY051b0NISU1UVGYzYUJqdGJXVzIrS05OYUhXRk5VRkx1?=
 =?utf-8?B?STJwaXVmUk93Z2JQalNPM3ZYa09aUXk3VW85OG9mV0tScDQ5Q2xDTXpFWnRp?=
 =?utf-8?B?djYxcWtRYzBwa1VNQ1RxeWlPWGxCcFNiNzZtK1I2ZUxlaG00b2l5c0F3UGto?=
 =?utf-8?B?d1pIVkJ3aUZFY2VjTUZLWkpPTWxrSWJ6bTQ0ZEVqd210VnRvYlNtd0R0ai9t?=
 =?utf-8?B?Rm0vbmhGSkE0WHY2eEMwcnZFTklRZ1hjeGJERGt2RUxaL1FoL3NheUVRMW9Y?=
 =?utf-8?B?OGg3WWJ0R0ZWRDA0dEVvVThGb1BaQnhrcnJNUm1JOWVNTUZ1SGVOZUVFcFVC?=
 =?utf-8?B?SVZQcWEyZndCb2xpNjVQbFJ0OGhvT1Y5SWxJcjVhQjZPaXVkS2JXay9jRkFR?=
 =?utf-8?B?Z0kvRzdBS2tHOGZWVmV4QXBZQmFsUm0zeEJqbms0Q3JudWpldmNuK1hIQlBI?=
 =?utf-8?B?d1JKRDhWQ0xLcFk3d3lEWm1ER21oNDNSSXZNV05tVUR2cVd3R2xOKzU5Q0h4?=
 =?utf-8?B?NXEzNnRvQVVPNEcyeTI4RXdQN2VEY09qOWtMWUlyREh2WDZaR0J2TWlOYStl?=
 =?utf-8?B?ODFOR21JNU0xNlBRRFNxcU5ocG1yQmlZdXhpNkltR0tlOGMwSGN6dlY5Nytt?=
 =?utf-8?B?L09hdjdEN3krVnR0WXZzYUdyNEMrYUNvbHEwU0M3TzZjSTBSbWlKMFFVQ3F1?=
 =?utf-8?B?VDNLSjl6Tm5rTlkrNElwYVNVR1EzN3hUQ0gwNVA1Qk5GbmxYOXVpWkVnT09K?=
 =?utf-8?B?Y2taS2R2NWMvUFFKeEtoUVBkV1JlMDhpc3E3VDMwVDEzYVhMNGtNamNzdjFE?=
 =?utf-8?B?QWlLRGZ1cnlpaExicFh6bWNRTjJZRmZHdlFGOVl5VDNZanByMGY3UjdDOG1t?=
 =?utf-8?Q?o2mypq/SG78=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7857.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmM3cHRyZDJ2S1puNVFVdzAxVGVRa3E5NGZHeCt6NUloUjhtSkhmSG1OWkFX?=
 =?utf-8?B?WkthTGhkS2JKeHlFc0MyS2JBNEw5NGJMRTUyb2UrNEdIcFdENXNQYm40azNw?=
 =?utf-8?B?ZVN5S2ZuUW4rWXZnMk1GVFpsSWt0d2RRMHV5SEFDZlVUeTB4akpybkFTVmJF?=
 =?utf-8?B?T1A4RU0zWCtObkxnK1FUc1h3ays4eGZrc09QYmdsU3A5eko2L0hRVkh0cm1M?=
 =?utf-8?B?NFlQWXE1UGJwSmhHUXFNN1VSNnE0cyt6aTJmZXNENVI2SHBaRkNuVFNMZS9Q?=
 =?utf-8?B?NGRoTnQrTWxjV05MRzN1cWFCcStmVk9aekRUZlMxYlNaRzNGK1NGczdyTFk0?=
 =?utf-8?B?VlVxZlhBUmtqOTZYZThOd2hJWWZxaG1CbklkOUpOdVRmSXV3ckpUbVkxMGEv?=
 =?utf-8?B?cDVkQnJTaWwzYTkrdnludXphcUZTMjRjNHg4OCtXN3FGWjRiTkRySVVQenQ1?=
 =?utf-8?B?WWlDZ0NSNjE5VHFJNkxDbGRpUFRwaHVsN294SlV5cWcwbDNYYlF5Ni9DbHIz?=
 =?utf-8?B?c3hPUHk3QVdSY3dpTkdsZElWVG9INXprSzJmTGE3UkpqaE1hR256bW1SMXpu?=
 =?utf-8?B?MUMwRk5kQzR3TEd0U3VMWWZZL0gra3Z1TFBzRlN1eGxVcFhoL0JSQzI0NDZT?=
 =?utf-8?B?M1R4ZVhRTGZWM01NYVNLVE5MNDd0MC80cWx4d2FLNHNaeVVCRGIyU213VW1i?=
 =?utf-8?B?S2s5Z3dxY0VyN1NLdGlVZFo0NTFSQWpWMmZOa2M0aERKRVY0WmFiazJBWGJZ?=
 =?utf-8?B?bUhKUzZPRVExMk5KRldvdnEwVUJmbkNQUWJMRDE5YXM5bnNLK0RnR0FOUVR4?=
 =?utf-8?B?UkxBZm5RYWl6Ny9GUi9vWHY3a29WN1VjdThxRDdIanZLQlg2cEk5VStLc3R1?=
 =?utf-8?B?bHoyVTNwMDl4OEtNNENjS2VqdEdDaWxOSmZ1Sm4xUW96a0pHa1JGY2dPMW1V?=
 =?utf-8?B?ZytxcGFFVHI0bWsxM1hTYTVoeEJQUVhnVW5CUmNabXM4OTVYLzRXckxUTDJF?=
 =?utf-8?B?cVVhSEJUYUI2RUJwUzJ6Q1NSZGIxNWFDeEFvMlZpNkRsbGliaXVDeHR3WDZZ?=
 =?utf-8?B?SzRZYjYvQ0dXVTdTeUVIcWwyRExTZ1JNb2FlYlI5L1p4ZW50MHYxM2JINStH?=
 =?utf-8?B?cEVVM0RlNVdDbE1BdENrSzA0VkVGSEdtMEJGTkp3T1hDOGJXTmZ3M0FKOXgz?=
 =?utf-8?B?SVdlWEZucUxac2EzeVJ1Mnl3WlMwTkZ2ZzBOSU5rT0ZyeHpHb3owZ3dxYXAr?=
 =?utf-8?B?ODdwVGpVeGFtMEVRWTcwV0pGcWdOVGNQb2pacGpLQmZwM1FKd2JFNVRlRlQ4?=
 =?utf-8?B?U1BGNm1ybCtBcytSWFlhMnZZcWZRZGZRWkFnQmFlUWhVMDhvekxXOGxZM3N2?=
 =?utf-8?B?Y1hPRDB4WHRBQzFVcjd3NyswakxLMzNhRXEzamVGT2tvSTJWV1VTVkRJSVdV?=
 =?utf-8?B?bXREWGxRZFNUZ1kvWThlaHd2MGdQUTFiR1AyWG52ZWpaZGl5bXQxazhKZzFU?=
 =?utf-8?B?TkJmaUhyTHlwdXVDR2lNeXVGbjdVOTRvZ3R1N1BPTWF2YWt2YjRaeFBaZHln?=
 =?utf-8?B?UHpIU2NsMXhFR1FGeXZYa3c2RzZibjJ6TkMxUTlvaC9EZkdXcFpBcGg3Q2Rh?=
 =?utf-8?B?aHBrZEpvQ3dENmc3LzdOUWVQcWZZb21LdXJTZEdUdHJSdlkzYjRneG82R3M2?=
 =?utf-8?B?cGhvcHg2NWJiMEdSUTgzT0NXZkFJL3crSWJtdm9VUEJ6UStoT25oenV2OEJ5?=
 =?utf-8?B?S2dOR1hGVFhXSnhRKzdibGJTcXc0R2FjWUhWdEEzQ2s1cWJOdDc0RkdaNS9U?=
 =?utf-8?B?dDgybnYxN2xzeTBnTlNVdnFCMlovYUwrRGdvUnJ1YSs3bWU1Z1Rub3lraGpO?=
 =?utf-8?B?ZXdEV3FpN0lja1NxNGQ0aDR6VkVqRHYrOGY5dlFvNlZOdjJEc3N4aXBNTGNu?=
 =?utf-8?B?dmlWSnhLTGt1d2ErcHpvV2MvaUFoalpKRVZ2RmxmenBHQ3BzYmN0cEhtQVM1?=
 =?utf-8?B?ZjJjWTJnaGdoWXFCcTJWam9FRkwvSTNYenBHaUYxVzlUUjZRemRsZWlqVmZ3?=
 =?utf-8?B?QWJCVXcwd3lDZ1U5ZmR1RzZ6OVVORkdHWEhkbzRPOHBZamI1bEt0amxVS1ln?=
 =?utf-8?B?R1I2aEExelROS1ZjaURyM045ZVN3S1lUaVhsWlB2UkhiQ3paVk1GblNoRTdm?=
 =?utf-8?B?Y0xQdlprWHlTZVIwazh2cmJ4Y3oyYUlDWUZTemwxa0NiWU1wWjJVUDQvRkk5?=
 =?utf-8?B?UGkzZzJTQ1N0RE9lV0Zxa2xmWTZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56296D94D187A44682567147DCC30C63@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Gzde9A02yC4Sefv6aXhJIUe8ZOm+P1MDLw5D+dbR8UG14GSRj7BfH1giBbe9asVxZmtjqr2EgJ2HCZnkV+6kSHHuMqZl+dlEnbAiGw+L3gGEthF6hUDpMjFK2eV2iHTabGiwHJGDNxx4f6riIZgoS6gh7vLEu1gB3ewV6zpm4PZwf/4ES4f80ZiXJAUqBGWDIAbvI/JCHN/khStUltqXyMXmt2O9kGH99gxIdc3HywKokYxslWefo6tFcfOdvKtUC8VkoESzo0KuaNyYgoAOuMq05NMhQKW4ofLVybWqbjSK0UzKr/peVWG6xQ3wUx8WL7RXB2i6SjUW6a9HX7OJHCJ5UDY3zjNBzR/MKm5CHb6srQhszWHucSl0Nvopf/F9tUEwvxiFWKUIk0KV0M8CdPDWBvoxIYhjR7xW11eWj76Clpp0XbwR/2NNd1PCTv2i/YMLUtxvJJNzQwn6/AAkv7rnfBx5A8ACY8aAiG3onH1yusm/He3aaRSBnFoQfzcVCKc/hyl1t9b4Kd2LLNhQCN3+XljTIYd0qb/K4tpW9ZznwYMIs4283r1Vu7HCFyH+6Yxa51oJU0CGV7zIe+yehNhiZjG9n1W3K8WwYCV6ZtvN5276XDMJ37StH7tmndoz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7857.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdecdc6-01ff-4c94-b960-08dca09216f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 03:40:48.9992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8NCL8uwivNDrtYkQjQ07hBKchG9FEL4L5QdBuSAnmVVM5wp3xYGedzRSfQcjFwP7pHhq5Ry1Q+HAPUWGwB0db/81YYz2yQ3AvRvDmVkHiRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB9658

T24gU3VuLCAyMDI0LTA2LTMwIGF0IDIxOjQ1ICswMjAwLCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+
IENNQS1TUERNIHN0YXRlIGlzIGxvc3Qgd2hlbiBhIGRldmljZSB1bmRlcmdvZXMgYSBDb252ZW50
aW9uYWwgUmVzZXQuDQo+IChCdXQgbm90IGEgRnVuY3Rpb24gTGV2ZWwgUmVzZXQsIFBDSWUgcjYu
MiBzZWMgNi42LjIuKcKgIEEgRDNjb2xkIHRvDQo+IEQwDQo+IHRyYW5zaXRpb24gaW1wbGllcyBh
IENvbnZlbnRpb25hbCBSZXNldCAoUENJZSByNi4yIHNlYyA1LjgpLg0KPiANCj4gVGh1cywgcmVh
dXRoZW50aWNhdGUgZGV2aWNlcyBvbiByZXN1bWUgZnJvbSBEM2NvbGQgYW5kIG9uIHJlY292ZXJ5
DQo+IGZyb20NCj4gYSBTZWNvbmRhcnkgQnVzIFJlc2V0IG9yIERQQy1pbmR1Y2VkIEhvdCBSZXNl
dC4NCj4gDQo+IFRoZSByZXF1aXJlbWVudCB0byByZWF1dGhlbnRpY2F0ZSBkZXZpY2VzIG9uIHJl
c3VtZSBmcm9tIHN5c3RlbSBzbGVlcA0KPiAoYW5kIGluIHRoZSBmdXR1cmUgcmVlc3RhYmxpc2gg
SURFIGVuY3J5cHRpb24pIGlzIHRoZSByZWFzb24gd2h5IFNQRE0NCj4gbmVlZHMgdG8gYmUgaW4t
a2VybmVsOsKgIER1cmluZyAtPnJlc3VtZV9ub2lycSwgd2hpY2ggaXMgdGhlIGZpcnN0DQo+IHBo
YXNlDQo+IGFmdGVyIHN5c3RlbSBzbGVlcCwgdGhlIFBDSSBjb3JlIHdhbGtzIGRvd24gdGhlIGhp
ZXJhcmNoeSwgcHV0cyBlYWNoDQo+IGRldmljZSBpbiBEMCwgcmVzdG9yZXMgaXRzIGNvbmZpZyBz
cGFjZSBhbmQgaW52b2tlcyB0aGUgZHJpdmVyJ3MNCj4gLT5yZXN1bWVfbm9pcnEgY2FsbGJhY2su
wqAgVGhlIGRyaXZlciBpcyBhZmZvcmRlZCB0aGUgcmlnaHQgdG8gYWNjZXNzDQo+IHRoZQ0KPiBk
ZXZpY2UgYWxyZWFkeSBkdXJpbmcgdGhpcyBwaGFzZS4NCj4gDQo+IFRvIHJldGFpbiB0aGlzIHVz
YWdlIG1vZGVsIGluIHRoZSBmYWNlIG9mIGF1dGhlbnRpY2F0aW9uIGFuZA0KPiBlbmNyeXB0aW9u
LA0KPiBDTUEtU1BETSByZWF1dGhlbnRpY2F0aW9uIGFuZCBJREUgcmVlc3RhYmxpc2htZW50IG11
c3QgaGFwcGVuIGR1cmluZw0KPiB0aGUNCj4gLT5yZXN1bWVfbm9pcnEgcGhhc2UsIGJlZm9yZSB0
aGUgZHJpdmVyJ3MgZmlyc3QgYWNjZXNzIHRvIHRoZSBkZXZpY2UuDQo+IFRoZSBkcml2ZXIgaXMg
dGh1cyBhZmZvcmRlZCBzZWFtbGVzcyBhdXRoZW50aWNhdGVkIGFuZCBlbmNyeXB0ZWQNCj4gYWNj
ZXNzDQo+IHVudGlsIHRoZSBsYXN0IG1vbWVudCBiZWZvcmUgc3VzcGVuZCBhbmQgZnJvbSB0aGUg
Zmlyc3QgbW9tZW50IGFmdGVyDQo+IHJlc3VtZS4NCj4gDQo+IER1cmluZyB0aGUgLT5yZXN1bWVf
bm9pcnEgcGhhc2UsIGRldmljZSBpbnRlcnJ1cHRzIGFyZSBub3QgeWV0DQo+IGVuYWJsZWQuDQo+
IEl0IGlzIHRodXMgaW1wb3NzaWJsZSB0byBkZWZlciBDTUEtU1BETSByZWF1dGhlbnRpY2F0aW9u
IHRvIGEgdXNlcg0KPiBzcGFjZQ0KPiBjb21wb25lbnQgb24gYW4gYXR0YWNoZWQgZGlzayBvciBv
biB0aGUgbmV0d29yaywgbWFraW5nIGFuIGluLWtlcm5lbA0KPiBTUERNIGltcGxlbWVudGF0aW9u
IG1hbmRhdG9yeS4NCj4gDQo+IFRoZSBzYW1lIGNhdGNoLTIyIGV4aXN0cyBvbiByZWNvdmVyeSBm
cm9tIGEgQ29udmVudGlvbmFsIFJlc2V0OsKgIEENCj4gdXNlcg0KPiBzcGFjZSBTUERNIGltcGxl
bWVudGF0aW9uIG1pZ2h0IGxpdmUgb24gYSBkZXZpY2Ugd2hpY2ggdW5kZXJ3ZW50DQo+IHJlc2V0
LA0KPiByZW5kZXJpbmcgaXRzIGV4ZWN1dGlvbiBpbXBvc3NpYmxlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTHVrYXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+DQoNClJldmlld2VkLWJ5OiBBbGlz
dGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4g
LS0tDQo+IMKgZHJpdmVycy9wY2kvY21hLmPCoMKgwqDCoMKgwqDCoCB8IDE1ICsrKysrKysrKysr
KysrKw0KPiDCoGRyaXZlcnMvcGNpL3BjaS1kcml2ZXIuYyB8wqAgMSArDQo+IMKgZHJpdmVycy9w
Y2kvcGNpLmPCoMKgwqDCoMKgwqDCoCB8IDEyICsrKysrKysrKystLQ0KPiDCoGRyaXZlcnMvcGNp
L3BjaS5owqDCoMKgwqDCoMKgwqAgfMKgIDIgKysNCj4gwqBkcml2ZXJzL3BjaS9wY2llL2Vyci5j
wqDCoCB8wqAgMyArKysNCj4gwqA1IGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY21hLmMgYi9kcml2
ZXJzL3BjaS9jbWEuYw0KPiBpbmRleCBlOTc0ZDQ4OWM3YTIuLmYyYzQzNWIwNGI5MiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9wY2kvY21hLmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY21hLmMNCj4g
QEAgLTE5NSw2ICsxOTUsMjEgQEAgdm9pZCBwY2lfY21hX2luaXQoc3RydWN0IHBjaV9kZXYgKnBk
ZXYpDQo+IMKgCXNwZG1fYXV0aGVudGljYXRlKHBkZXYtPnNwZG1fc3RhdGUpOw0KPiDCoH0NCj4g
wqANCj4gKy8qKg0KPiArICogcGNpX2NtYV9yZWF1dGhlbnRpY2F0ZSgpIC0gUGVyZm9ybSBDTUEt
U1BETSBhdXRoZW50aWNhdGlvbiBhZ2Fpbg0KPiArICogQHBkZXY6IERldmljZSB0byByZWF1dGhl
bnRpY2F0ZQ0KPiArICoNCj4gKyAqIENhbiBiZSBjYWxsZWQgYnkgZHJpdmVycyBhZnRlciBkZXZp
Y2UgaWRlbnRpdHkgaGFzIG11dGF0ZWQsDQo+ICsgKiBlLmcuIGFmdGVyIGRvd25sb2FkaW5nIGZp
cm13YXJlIHRvIGFuIEZQR0EgZGV2aWNlLg0KPiArICovDQo+ICt2b2lkIHBjaV9jbWFfcmVhdXRo
ZW50aWNhdGUoc3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+ICt7DQo+ICsJaWYgKCFwZGV2LT5zcGRt
X3N0YXRlKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlzcGRtX2F1dGhlbnRpY2F0ZShwZGV2LT5z
cGRtX3N0YXRlKTsNCj4gK30NCj4gKw0KPiDCoHZvaWQgcGNpX2NtYV9kZXN0cm95KHN0cnVjdCBw
Y2lfZGV2ICpwZGV2KQ0KPiDCoHsNCj4gwqAJaWYgKCFwZGV2LT5zcGRtX3N0YXRlKQ0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpLWRyaXZlci5jIGIvZHJpdmVycy9wY2kvcGNpLWRyaXZl
ci5jDQo+IGluZGV4IGFmMjk5NmQwZDE3Zi4uODk1NzFmOTRkZWJjIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3BjaS9wY2ktZHJpdmVyLmMNCj4gKysrIGIvZHJpdmVycy9wY2kvcGNpLWRyaXZlci5j
DQo+IEBAIC01NjYsNiArNTY2LDcgQEAgc3RhdGljIHZvaWQgcGNpX3BtX2RlZmF1bHRfcmVzdW1l
X2Vhcmx5KHN0cnVjdA0KPiBwY2lfZGV2ICpwY2lfZGV2KQ0KPiDCoAlwY2lfcG1fcG93ZXJfdXBf
YW5kX3ZlcmlmeV9zdGF0ZShwY2lfZGV2KTsNCj4gwqAJcGNpX3Jlc3RvcmVfc3RhdGUocGNpX2Rl
dik7DQo+IMKgCXBjaV9wbWVfcmVzdG9yZShwY2lfZGV2KTsNCj4gKwlwY2lfY21hX3JlYXV0aGVu
dGljYXRlKHBjaV9kZXYpOw0KPiDCoH0NCj4gwqANCj4gwqBzdGF0aWMgdm9pZCBwY2lfcG1fYnJp
ZGdlX3Bvd2VyX3VwX2FjdGlvbnMoc3RydWN0IHBjaV9kZXYgKnBjaV9kZXYpDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BjaS9wY2kuYyBiL2RyaXZlcnMvcGNpL3BjaS5jDQo+IGluZGV4IDU5ZTA5
NDlmYjA3OS4uMmE4MDYzZTdmMmUwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9wY2kuYw0K
PiArKysgYi9kcml2ZXJzL3BjaS9wY2kuYw0KPiBAQCAtNDk4MCw4ICs0OTgwLDE2IEBAIHN0YXRp
YyBpbnQgcGNpX3Jlc2V0X2J1c19mdW5jdGlvbihzdHJ1Y3QNCj4gcGNpX2RldiAqZGV2LCBib29s
IHByb2JlKQ0KPiDCoA0KPiDCoAlyYyA9IHBjaV9kZXZfcmVzZXRfc2xvdF9mdW5jdGlvbihkZXYs
IHByb2JlKTsNCj4gwqAJaWYgKHJjICE9IC1FTk9UVFkpDQo+IC0JCXJldHVybiByYzsNCj4gLQly
ZXR1cm4gcGNpX3BhcmVudF9idXNfcmVzZXQoZGV2LCBwcm9iZSk7DQo+ICsJCWdvdG8gZG9uZTsN
Cj4gKw0KPiArCXJjID0gcGNpX3BhcmVudF9idXNfcmVzZXQoZGV2LCBwcm9iZSk7DQo+ICsNCj4g
K2RvbmU6DQo+ICsJLyogQ01BLVNQRE0gc3RhdGUgaXMgbG9zdCB1cG9uIGEgQ29udmVudGlvbmFs
IFJlc2V0ICovDQo+ICsJaWYgKCFwcm9iZSkNCj4gKwkJcGNpX2NtYV9yZWF1dGhlbnRpY2F0ZShk
ZXYpOw0KPiArDQo+ICsJcmV0dXJuIHJjOw0KPiDCoH0NCj4gwqANCj4gwqBzdGF0aWMgaW50IGN4
bF9yZXNldF9idXNfZnVuY3Rpb24oc3RydWN0IHBjaV9kZXYgKmRldiwgYm9vbCBwcm9iZSkNCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS5oIGIvZHJpdmVycy9wY2kvcGNpLmgNCj4gaW5k
ZXggZmM5MDg0NWNhZjgzLi5iNGMyY2U1ZmQwNzAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNp
L3BjaS5oDQo+ICsrKyBiL2RyaXZlcnMvcGNpL3BjaS5oDQo+IEBAIC0zMzYsOSArMzM2LDExIEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBwY2lfZG9lX2Rpc2Nvbm5lY3RlZChzdHJ1Y3QNCj4gcGNpX2Rl
diAqcGRldikgeyB9DQo+IMKgI2lmZGVmIENPTkZJR19QQ0lfQ01BDQo+IMKgdm9pZCBwY2lfY21h
X2luaXQoc3RydWN0IHBjaV9kZXYgKnBkZXYpOw0KPiDCoHZvaWQgcGNpX2NtYV9kZXN0cm95KHN0
cnVjdCBwY2lfZGV2ICpwZGV2KTsNCj4gK3ZvaWQgcGNpX2NtYV9yZWF1dGhlbnRpY2F0ZShzdHJ1
Y3QgcGNpX2RldiAqcGRldik7DQo+IMKgI2Vsc2UNCj4gwqBzdGF0aWMgaW5saW5lIHZvaWQgcGNp
X2NtYV9pbml0KHN0cnVjdCBwY2lfZGV2ICpwZGV2KSB7IH0NCj4gwqBzdGF0aWMgaW5saW5lIHZv
aWQgcGNpX2NtYV9kZXN0cm95KHN0cnVjdCBwY2lfZGV2ICpwZGV2KSB7IH0NCj4gK3N0YXRpYyBp
bmxpbmUgdm9pZCBwY2lfY21hX3JlYXV0aGVudGljYXRlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KSB7
IH0NCj4gwqAjZW5kaWYNCj4gwqANCj4gwqAvKioNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNp
L3BjaWUvZXJyLmMgYi9kcml2ZXJzL3BjaS9wY2llL2Vyci5jDQo+IGluZGV4IDMxMDkwNzcwZmZm
Yy4uMDAyODU4MmYwNTkwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9wY2llL2Vyci5jDQo+
ICsrKyBiL2RyaXZlcnMvcGNpL3BjaWUvZXJyLmMNCj4gQEAgLTEzMyw2ICsxMzMsOSBAQCBzdGF0
aWMgaW50IHJlcG9ydF9zbG90X3Jlc2V0KHN0cnVjdCBwY2lfZGV2ICpkZXYsDQo+IHZvaWQgKmRh
dGEpDQo+IMKgCXBjaV9lcnNfcmVzdWx0X3Qgdm90ZSwgKnJlc3VsdCA9IGRhdGE7DQo+IMKgCWNv
bnN0IHN0cnVjdCBwY2lfZXJyb3JfaGFuZGxlcnMgKmVycl9oYW5kbGVyOw0KPiDCoA0KPiArCS8q
IENNQS1TUERNIHN0YXRlIGlzIGxvc3QgdXBvbiBhIENvbnZlbnRpb25hbCBSZXNldCAqLw0KPiAr
CXBjaV9jbWFfcmVhdXRoZW50aWNhdGUoZGV2KTsNCj4gKw0KPiDCoAlkZXZpY2VfbG9jaygmZGV2
LT5kZXYpOw0KPiDCoAlwZHJ2ID0gZGV2LT5kcml2ZXI7DQo+IMKgCWlmICghcGRydiB8fCAhcGRy
di0+ZXJyX2hhbmRsZXIgfHwgIXBkcnYtPmVycl9oYW5kbGVyLQ0KPiA+c2xvdF9yZXNldCkNCg0K

