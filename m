Return-Path: <linux-pci+bounces-7216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B8E8BF859
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 10:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24451F263D7
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB7C3FBBD;
	Wed,  8 May 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="alrfViWT";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bY/8UjSw"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5A61DA53;
	Wed,  8 May 2024 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715156435; cv=fail; b=NyK3LBDDGmie4yKI1/nKHu7nlLMacQzrxlHLEkeIo7ogK8S8b32DJijH7xSBp2H4GWbTJs6aDYCqioJktEOPoTM7sVj7OfFNrZqTbAxTHQd7UWyGIkH+LUBNgHDy5GVy3z2OCQjky86kWsD3H6Nvkoa6+C+KkEB2ymxJzDT5poM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715156435; c=relaxed/simple;
	bh=k6tOfo8YAjU/1IcBf4dGv4EV8DPiuaY3oAct3+YTdF0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dqg8dKPgbjBxJIxLts9fRUzU+U/cyVbeHB6k2OFk+sDsRjw61QAMTtABx1Wz+0kEmp9kNgWZz4hAbF7/ni0RECo3fn5Vh1AXyT6BDTxQ7O3VlLdHEyUkscdHa+RWXR8g5mCMT/lroeJzQasXTS1pZesG+QqnoRy7ewBonelC+dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=alrfViWT; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bY/8UjSw; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715156432; x=1746692432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=k6tOfo8YAjU/1IcBf4dGv4EV8DPiuaY3oAct3+YTdF0=;
  b=alrfViWTisxYOLOEZ2FoVpV8ulqcCBgZeQcoC271NxmgsuJsN8KyVlsB
   I0h10i7sv9718Mo2KIN74nbfYoxKgpOtGDZnKiotB27maV9FqQlBpg1bi
   QlOzlCeYIR5vwaKCcodNQPgyVHb5NCoCOJ2HsMcq4ZuCj6MDOo/ETj8+U
   tCmaMhM/pAtFns8VRCN8SGuEr48g28JUdtjLO817MtS6pHmZfAqfkTCMr
   dZdD5p23VgUBLmk75IJZsQ619pQvLPPdvVr8ZWiptBrKt5PyVhUKHIVUk
   OQ7VQCt90BGIa2PpTn3vu6vrf5NqcLSMY598zIQzL1bQPCMvboxqCn+jW
   Q==;
X-CSE-ConnectionGUID: ZS9qbylmR1ux9RF5zQkdfw==
X-CSE-MsgGUID: qLhKLEMaTdSYaqrPWTr4tQ==
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="24084370"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 May 2024 01:20:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 01:20:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 01:20:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtViq018AiZWX4FkTuAGKYGSb8QZWpOQaknsoVbK+zE/wGT9K280QxfYegMA9PxI9rtRhpjBdzK9um0YlgQx+wFBA2LugqwI6cVqXqfx1GEIMtalsM95n9valZnVxCyTyUzlomp/brwGwYkgj0zcvWBzGCXbkJ5F5hjBCp5tAuEfKrEqSV57yJoFTrbxQdFbNKeVEh6bDgRSkl1KGYzoTkaDkZiYAsXXxBhm77Q0xKGlwOIqt5n4kzHmcqu1MwrdIba13uFWYyx3sHbhz5eGIHrcD0Ei/OpQT8K90UKrlyvQUEF203YHxl6nYbA/vsAXR+ljOz4kBoDOoFv/+IfLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6tOfo8YAjU/1IcBf4dGv4EV8DPiuaY3oAct3+YTdF0=;
 b=B23PnSi45sDuzyOg9Lo5Byb/yr66/6/Ws/+2jrFipAIrVCfoJigUnLO30UX/+BzTr2rsEAk3ZPbGWoMiQkN2Udxmd0RB604uXsztINONxIPbWnu31P7iLNmGEZpK0Fcjk/7JD2liZAwxvrM5WDPuJYMU8VRBWuIUKyxlfFOtzmqncum8R6XYKS74vvIxrk+vobh/nOAsdoHoFV/gl2cj647MGQvfm8z/+DWt+780a/9NnIndPR0lMil/HVX/Q5E5TQGhW/LE1Hxr93ZIB7x8vXyYtDOOThM9M9BJACthF7xBikbQpusmi9hhQ5ccnFgT/tBtW7ECB7oyp/tiZdnlkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6tOfo8YAjU/1IcBf4dGv4EV8DPiuaY3oAct3+YTdF0=;
 b=bY/8UjSwqh7gPZgctNapmgaVK1IJJQzJnkGIq2Tppph3RGNdHunERbHqurYKEyoDO+0WlWvO7jNnzeD4Iz9wqdJEdHOyrshN8lzOWRmMxO0QX2QNT+E6XV4y32ncogsCNV7nhxfEUn0c03XppdZxBUIuVN325mNV0xPNa6mItSVaGGHvEoM/YY2oRmvSOCf652SFr6cQhushOnk5UI8lHy4dVyTakChcBms4s3/lU7nxkss7VIEysIhnWE4LaAeJGB9Zl3YuddwZhzZol8ZVaPuYXomIzJtQfDYsNsQF0GpPcQYuQGMO84OKZQ7C73NuhRPrlmNL/Ky9MeLxT6D65Q==
Received: from DM3PR11MB8759.namprd11.prod.outlook.com (2603:10b6:8:1ac::20)
 by DM4PR11MB6065.namprd11.prod.outlook.com (2603:10b6:8:60::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 08:20:04 +0000
Received: from DM3PR11MB8759.namprd11.prod.outlook.com
 ([fe80::1bef:c49a:9ad3:7372]) by DM3PR11MB8759.namprd11.prod.outlook.com
 ([fe80::1bef:c49a:9ad3:7372%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 08:20:04 +0000
From: <Steen.Hegelund@microchip.com>
To: <herve.codina@bootlin.com>, <tglx@linutronix.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<lee@kernel.org>, <arnd@arndb.de>, <Horatiu.Vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <saravanak@google.com>, <bhelgaas@google.com>,
	<p.zabel@pengutronix.de>, <Lars.Povlsen@microchip.com>,
	<Steen.Hegelund@microchip.com>, <Daniel.Machon@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <Allan.Nielsen@microchip.com>,
	<luca.ceresoli@bootlin.com>, <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 16/17] mfd: Add support for LAN966x PCI device
Thread-Topic: [PATCH 16/17] mfd: Add support for LAN966x PCI device
Thread-Index: AQHamtn/HvEuUMvVR0i7H8tl9ZPDibGNC1oA
Date: Wed, 8 May 2024 08:20:04 +0000
Message-ID: <D1447AHUWV6C.13V6FOWZ80GH@microchip.com>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
 <20240430083730.134918-17-herve.codina@bootlin.com>
In-Reply-To: <20240430083730.134918-17-herve.codina@bootlin.com>
Accept-Language: da-DK, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.17.0-0-g6ea74eb30457
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8759:EE_|DM4PR11MB6065:EE_
x-ms-office365-filtering-correlation-id: bf1b6569-4cf0-4d34-d684-08dc6f37aa13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007|921011|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cXlramxYbHRtYmhpQTNHeG5xdm9vMWh4cktMc3YzckhXV1lXQk9FMGdmM1o3?=
 =?utf-8?B?RXZ3WXFubzZ4T0c5NUlLeDBMZVpjOWtsaHVVSlVRQzlxa1RMUForTXQweEl0?=
 =?utf-8?B?bFpNNlQ1S1JoUVkvZ0hnNk5tdjlnM2JPRGM1elNKaW9kcHpTL1pvN2dSQ3pY?=
 =?utf-8?B?T1JaWXRnL2poQkVZczBFN3NYSHBJbGdTbEMwREdIZW04bGg2M2xLRTFPL25E?=
 =?utf-8?B?eWc1dG9EQzZjdXNOQUppVkhjTnNOaDI0dGJyc0V6b3JLWjA5NFRQbTlKTzFX?=
 =?utf-8?B?bHBaT2RncnA1ZFVDaVdnRUtVL2k2V05neGFYc2xtK2ZwV0hMMWo3REdNWndH?=
 =?utf-8?B?VkVqSldCeEk1cDNzTy9halFROEFaaExDRHgyYldML2c4QnA4Zy8vRmlpeXgw?=
 =?utf-8?B?MElOR0ZBanJ2TlZScThCVmxhelRzSzBEM0VLQ3FieWlaZndxYnRWbXMyMkkw?=
 =?utf-8?B?c1lIdlZRblFUTzRmbkt3NlRWRVAxSG1TbmpSS29ROVdOak9VVWFqMDUrS1Fa?=
 =?utf-8?B?cGhKakZpL3RpK0xSeXZPUDM3ZmZDWWEyZlFJcENqTCtYeVZNcmJQcHlsVWVC?=
 =?utf-8?B?MllrK0hyRzlKdGt2QjVFK3JYOS9vYjFKSGl0bHNKVFNNZlBjWmhaWDV2ZFY5?=
 =?utf-8?B?OVcrVjh6TUNGNFduZGpBTTBvVDBJZzVBa2xaODlnZFF4QXlnc2JmL1VNbW0w?=
 =?utf-8?B?OERReUw0V0VNTmtvWTRHRUxxV3BOQkh3REZBL0o1SWw2R3dId2hLS1R3OU1j?=
 =?utf-8?B?aVNIWUJtSC9wS3c3U01vdE0vVHNBVkUzaGFIdjRVTkRYb0J2dWxvQ0w2YjZ0?=
 =?utf-8?B?YkF3cXFhQVQrUzBxbmozSGpPaXJ5clFiTFJnc1VnOHFWWDdRZ0RBSEJ0SEZZ?=
 =?utf-8?B?bWZGZXBjMFcxVTM5ZDlqUk1ZT0p2YVZMZklMcWRQMjE4RTdqZ2FWbnc0U05t?=
 =?utf-8?B?TWJOdCsvYUw5eWRhM3NSRGRydGxMMnpDSjZGMEdER0pBUHM4di80K2RyVDhH?=
 =?utf-8?B?SVdxUDY5RTUwalJ3Z3V5U2NIaUJpMXVJSFVhSXVwenluWDkwYnlHbHRPUkYv?=
 =?utf-8?B?UmZQNmR3S2RQTC8xUG8vaWF5Y1FKb29jQm0rSUZJbWRBMlJyTnZ3TnhGS1JP?=
 =?utf-8?B?UXdkbjJXUFN3bThSM0hJK0Y4NEh4Z0dhMisvZXVGUi9mRVlQWXRVTktib05m?=
 =?utf-8?B?OGtJRzE2OU9jZ2lmVW5PaGVtaUxZTFZGaUs2d2lac2lUa3gxeDRnZ2ZGbEta?=
 =?utf-8?B?UnA4ZDZUbDVvTTBNWTlFTFVHTWNMNlBKd1VxU3A4aStXbFU2Y25wZlFFNjZF?=
 =?utf-8?B?R2oxOE52R0pMTkVTUjRoQjhoVnYzWXQxNE4vMlEwblVZdVpaem9MOGt2bkJq?=
 =?utf-8?B?MGRxSzNXQjJSVWJvZkx4WjFVU0hIVmJEemRjNUhhM0JISFY4THkxY0JwdmNq?=
 =?utf-8?B?NnlBOXJqOVRERnp1b0hnRUNzdnJoVkJGVFFBSFRpODNmbWlUbk5sUnJuK3hT?=
 =?utf-8?B?TGpKZDU1Sy9GTTErTlppVldTOGkxT3ZzQSt3V0kyOU5USG5hM0lVeHVCMVhL?=
 =?utf-8?B?YkZPWUNBeHBGc0pNUmZVR0h0SDNzVVBGREhtRVczcE5wVUdsNjNZdVk2RGhH?=
 =?utf-8?B?TGF0RWx1eHFIQmtodmZFTXNQbnBBYnE3TjVvTWVJazFjU2RXcVRtSWNrQVVY?=
 =?utf-8?B?UmJ0dU81dlpGTVZiQVgyS1ZGVkw5TFJtZ3orajRwMWt6Y3JoalowK1lXcFc4?=
 =?utf-8?B?MDdNdUFrUHlycnozM21PYWlTNGlFLytYNzVvY2NScWw2L1MybzhQZmJTZjEz?=
 =?utf-8?Q?xiSAm9An7xpUWLt+U/irp/iNdQXWbo0Zhh2JI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8759.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3NCWU1QZzhmWUFFcEFuN0NOQ0ZMbEtxMjhpOHorS2ZJc2lBd3FRNlVEMzJK?=
 =?utf-8?B?MldtSU1HbEpZcVhUWXZQbFY4Wnp5REZZQSswS1FoU3JhTCtxa0gyV083ekNh?=
 =?utf-8?B?MnFUWHZxRjZwWHJXSnVIazAzQjR1Q2xEQzhMVXo2YUtqaU02UWtJaDdaMDdY?=
 =?utf-8?B?aXVlOUhFZThGMDVVSFA4UWVnckxCaUxVb0o0ZWpaWnVVWk4vQktURlhES3lF?=
 =?utf-8?B?aWhXYWZEaVd0bXZGWWRNeG1OTzlTNy9ibmQrdjJybGNjVEFWdnltenE0ZkJK?=
 =?utf-8?B?K2prSk9qV1ZtakpVcUUxdnUyd0hhMFVJY2E1RWVzeS9jbW85ZkQzMEpaTnFp?=
 =?utf-8?B?cFJ3RkFCVmp6MFRybCs0eTFqUUl3UWtsaTVvdTJhWlJSZnQ0RXlvUDRNTlc2?=
 =?utf-8?B?ZzhaV3dWc0pSRFNKV3U3NEhxalEva3JVY2ZBNzkzT3hUbFduOFIxVzhHeHhV?=
 =?utf-8?B?R3Y4K3dhWlBLVTJ1MzB4L3pxdkhFb2h6Q3JuQjBiOTZFdjk0eWh0NXdGcWM5?=
 =?utf-8?B?RHNub3FRd0dpN09meG1iQ2N5R1lFeXVCR0hGMExkOFhPcUx5MmNXTXBSOHRG?=
 =?utf-8?B?alc3WU1EaVlUS3lsOVNkb0VzU1ZsL0FFYjlDeG1mV0JWWWRmN1BYR1k1ZWM2?=
 =?utf-8?B?U0N1ZFRwMEMwNXNGMWZEMEdxWXNOWFNCamdKTjJ4cTlsclNXaFFBL3d1WGFO?=
 =?utf-8?B?bVlHTGtsdUwrZEtZUVFwUVN1c0RGTGd6ZEV5SzJSbU5CbjZLUUZReGIvWVUv?=
 =?utf-8?B?VzEwT0NHRUVKMjZZWVpCREhFUEYwOUZabG1BQWJoWlZybllMM1FZR2NXSW1p?=
 =?utf-8?B?dlJYM3RzUDBXZStaUUEzT3VMcWdXc2UwZ1hYZGpvR2R4cURDL29lNXF0QUFN?=
 =?utf-8?B?TUdQNTlRbkF5ZTdaSWphMjVvR21rZER3bkFtWmpDRjArQzR6WHk4VmVrTS9F?=
 =?utf-8?B?QVJoMWhKck9yU1FEUW9ubFZSVFdxZzc5Z2hCUHgwYWtJOFhOTmFNbSt1c211?=
 =?utf-8?B?NXRwOC92bS9HOTdHMmtqb3FmakJ1RnRXMUxMdHpUbmZSY3VyL1QxcVVWUGVP?=
 =?utf-8?B?WHhNMnVTUGFybUdFQS83NElpaDBsK3g2aG56NjRUTG51eUdHSWRXYzE3UXZv?=
 =?utf-8?B?aTZhUE1nWVJmU2RxZFJCWTZmRUx3THFiNzlScXhFdVpycDNVdjFJSE5SYzFT?=
 =?utf-8?B?RWRlRmdFa1NvamN3ZlZycWZxSVFpK3BvRHljVld5Rk1tN2k0MlVSaHg3bDdS?=
 =?utf-8?B?RDV0L1UwbDNOUXlvZEhRdVNXeWNFSHBWWVVtT0x2clZOaUdFSy9ldWRLQktG?=
 =?utf-8?B?eWlaSW5HWHNubTE3N004S3NoRlpvZ1JlaDVWOEVBNzMrVDlha1F1UVlxQmZ4?=
 =?utf-8?B?azhybkNSZ3piamYzQVVEVHNJVXlBWHp2V250aTV6b1VORFVvUld1ZnN6czdU?=
 =?utf-8?B?OWNGaDJweGN6TkhKMUx3czRBVU1wd1R3YzRHRkVKdE5rUEJvbUN3RDdyRXM2?=
 =?utf-8?B?N3E0emI4eFlPbTgzWkZPUERqYnlEd083aDBCZjREMzVxMnBPeU40VlJJeUti?=
 =?utf-8?B?d2JGR1p3QVllY3B3YUVOb2s5MUlwWk5GZWxaVlJxYWZscms2S0tyRTJFMFBN?=
 =?utf-8?B?MFFiMWZBWFFDRGdBY1dpNlBJT09CdHU5MzVWZVVERGZHcHNWaWgzaGZqNERL?=
 =?utf-8?B?N1pXam1kUGpUVGE5M0phSmlReFY5TGM0WHRUWmF4TGs2K2pGVnRvdFZ3U2wv?=
 =?utf-8?B?ckdpblJzZjR3dk1uRTdwQy9iUUt6QzJ1QndqMlZsdmNTYTF6NjMzUzlEb1B6?=
 =?utf-8?B?b0hXeUhZcTV5bjNmdDNqSXJWbVp6Q2tvYkF0RGl0TzZsK28rWDhITm56UW5w?=
 =?utf-8?B?VTM5Y1VvRU4wdGxFZkZzUmVveXlRZmE2NEpJNE51WjZ2ZE9PVnRGcjNIL0ZQ?=
 =?utf-8?B?QXg2eHZJV0pYYktrWmZxTHdxVDB0azdZUlM5QmNUYW1GSGpZYTJ1Vm43NG9T?=
 =?utf-8?B?NFdwS1RLQzNEdSthcHg1TGEwRkQ4aDM1MTVXdWxEMWYrOUM1c0N1ZmdIR29S?=
 =?utf-8?B?RndtajVQMjFoUDZySHp0SzYvdlR5UHVEVlo2cDJsL3J5TnNSSHBQcFRHbUE3?=
 =?utf-8?B?TE9INUN2aEYyVXE1b0lhVUs1YnpTRmFsZkpIYkN2TzNvVVE0VXJtZDFDOUZu?=
 =?utf-8?Q?ZptFsrq3ZmNuSef8OjCdUPo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7283FBDF86DAD64FA4AC3561D3607020@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8759.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1b6569-4cf0-4d34-d684-08dc6f37aa13
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 08:20:04.6863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RyBOHZv08Hwd9RIcIrjUmo4aThJvbYjJE2IEnJXw86/RvqvCz5Ty6J227HDdldY+8cmSfrlxZ0T9DYd/3I4krqW3lCvA/8AbUJBbOV+x2nI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6065

SGkgSGVydmUsDQoNCk9uIFR1ZSBBcHIgMzAsIDIwMjQgYXQgMTA6MzcgQU0gQ0VTVCwgSGVydmUg
Q29kaW5hIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4NCj4g
QWRkIGEgUENJIGRyaXZlciB0aGF0IGhhbmRsZXMgdGhlIExBTjk2NnggUENJIGRldmljZSB1c2lu
ZyBhIGRldmljZS10cmVlDQo+IG92ZXJsYXkuIFRoaXMgb3ZlcmxheSBpcyBhcHBsaWVkIHRvIHRo
ZSBQQ0kgZGV2aWNlIERUIG5vZGUgYW5kIGFsbG93cyB0bw0KPiBkZXNjcmliZSBjb21wb25lbnRz
IHRoYXQgYXJlIHByZXNlbnQgaW4gdGhlIGRldmljZS4NCj4NCj4gVGhlIG1lbW9yeSBmcm9tIHRo
ZSBkZXZpY2UtdHJlZSBpcyByZW1hcHBlZCB0byB0aGUgQkFSIG1lbW9yeSB0aGFua3MgdG8NCj4g
InJhbmdlcyIgcHJvcGVydGllcyBjb21wdXRlZCBhdCBydW50aW1lIGJ5IHRoZSBQQ0kgY29yZSBk
dXJpbmcgdGhlIFBDSQ0KPiBlbnVtZXJhdGlvbi4NCj4gVGhlIFBDSSBkZXZpY2UgaXRzZWxmIGFj
dHMgYXMgYW4gaW50ZXJydXB0IGNvbnRyb2xsZXIgYW5kIGlzIHVzZWQgYXMgdGhlDQo+IHBhcmVu
dCBvZiB0aGUgaW50ZXJuYWwgTEFOOTY2eCBpbnRlcnJ1cHQgY29udHJvbGxlciB0byByb3V0ZSB0
aGUNCj4gaW50ZXJydXB0cyB0byB0aGUgYXNzaWduZWQgUENJIElOVHggaW50ZXJydXB0Lg0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBIZXJ2ZSBDb2RpbmEgPGhlcnZlLmNvZGluYUBib290bGluLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL21mZC9LY29uZmlnICAgICAgICAgIHwgIDI0ICsrKysNCj4gIGRy
aXZlcnMvbWZkL01ha2VmaWxlICAgICAgICAgfCAgIDQgKw0KPiAgZHJpdmVycy9tZmQvbGFuOTY2
eF9wY2kuYyAgICB8IDIyOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAg
ZHJpdmVycy9tZmQvbGFuOTY2eF9wY2kuZHRzbyB8IDE2NyArKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ICBkcml2ZXJzL3BjaS9xdWlya3MuYyAgICAgICAgIHwgICAxICsNCj4gIDUgZmlsZXMg
Y2hhbmdlZCwgNDI1IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L21mZC9sYW45NjZ4X3BjaS5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tZmQvbGFu
OTY2eF9wY2kuZHRzbw0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvS2NvbmZpZyBiL2Ry
aXZlcnMvbWZkL0tjb25maWcNCj4gaW5kZXggNGIwMjNlZTIyOWNmLi5lNWY1ZDI5ODZkZDMgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWZkL0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9tZmQvS2Nv
bmZpZw0KPiBAQCAtMTQ0LDYgKzE0NCwzMCBAQCBjb25maWcgTUZEX0FUTUVMX0ZMRVhDT00NCj4g
ICAgICAgICAgIGJ5IHRoZSBwcm9iZSBmdW5jdGlvbiBvZiB0aGlzIE1GRCBkcml2ZXIgYWNjb3Jk
aW5nIHRvIGEgZGV2aWNlIHRyZWUNCj4gICAgICAgICAgIHByb3BlcnR5Lg0KPg0KPiArY29uZmln
IE1GRF9MQU45NjZYX1BDSQ0KPiArICAgICAgIHRyaXN0YXRlICJNaWNyb2NoaXAgTEFOOTY2eCBQ
Q0llIFN1cHBvcnQiDQo+ICsgICAgICAgZGVwZW5kcyBvbiBQQ0kNCj4gKyAgICAgICBzZWxlY3Qg
T0YNCj4gKyAgICAgICBzZWxlY3QgT0ZfT1ZFUkxBWQ0KPiArICAgICAgIHNlbGVjdCBJUlFfRE9N
QUlODQo+ICsgICAgICAgaGVscA0KPiArICAgICAgICAgVGhpcyBlbmFibGVzIHRoZSBzdXBwb3J0
IGZvciB0aGUgTEFOOTY2eCBQQ0llIGRldmljZS4NCj4gKyAgICAgICAgIFRoaXMgaXMgdXNlZCB0
byBkcml2ZSB0aGUgTEFOOTY2eCBQQ0llIGRldmljZSBmcm9tIHRoZSBob3N0IHN5c3RlbQ0KPiAr
ICAgICAgICAgdG8gd2hpY2ggaXQgaXMgY29ubmVjdGVkLg0KPiArDQo+ICsgICAgICAgICBUaGlz
IGRyaXZlciB1c2VzIGFuIG92ZXJsYXkgdG8gbG9hZCBvdGhlciBkcml2ZXJzIHRvIHN1cHBvcnQg
Zm9yDQo+ICsgICAgICAgICBMQU45NjZ4IGludGVybmFsIGNvbXBvbmVudHMuDQo+ICsgICAgICAg
ICBFdmVuIGlmIHRoaXMgZHJpdmVyIGRvZXMgbm90IGRlcGVuZCBvbiB0aGVzZSBvdGhlciBkcml2
ZXJzLCBpbiBvcmRlcg0KPiArICAgICAgICAgdG8gaGF2ZSBhIGZ1bGx5IGZ1bmN0aW9uYWwgYm9h
cmQsIHRoZSBmb2xsb3dpbmcgZHJpdmVycyBhcmUgbmVlZGVkOg0KPiArICAgICAgICAgICAtIGZp
eGVkLWNsb2NrIChDT01NT05fQ0xLKQ0KPiArICAgICAgICAgICAtIGxhbjk2Nngtb2ljIChMQU45
NjZYX09JQykNCj4gKyAgICAgICAgICAgLSBsYW45NjZ4LWNwdS1zeXNjb24gKE1GRF9TWVNDT04p
DQo+ICsgICAgICAgICAgIC0gbGFuOTY2eC1zd2l0Y2gtcmVzZXQgKFJFU0VUX01DSFBfU1BBUlg1
KQ0KPiArICAgICAgICAgICAtIGxhbjk2NngtcGluY3RybCAoUElOQ1RSTF9PQ0VMT1QpDQo+ICsg
ICAgICAgICAgIC0gbGFuOTY2eC1zZXJkZXMgKFBIWV9MQU45NjZYX1NFUkRFUykNCj4gKyAgICAg
ICAgICAgLSBsYW45NjZ4LW1paW0gKE1ESU9fTVNDQ19NSUlNKQ0KPiArICAgICAgICAgICAtIGxh
bjk2Nngtc3dpdGNoIChMQU45NjZYX1NXSVRDSCkNCj4gKw0KPiAgY29uZmlnIE1GRF9BVE1FTF9I
TENEQw0KPiAgICAgICAgIHRyaXN0YXRlICJBdG1lbCBITENEQyAoSGlnaC1lbmQgTENEIENvbnRy
b2xsZXIpIg0KPiAgICAgICAgIHNlbGVjdCBNRkRfQ09SRQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tZmQvTWFrZWZpbGUgYi9kcml2ZXJzL21mZC9NYWtlZmlsZQ0KPiBpbmRleCBjNjZmMDdlZGNk
MGUuLjE2NWE5Njc0ZmY0OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZmQvTWFrZWZpbGUNCj4g
KysrIGIvZHJpdmVycy9tZmQvTWFrZWZpbGUNCj4gQEAgLTI4NCwzICsyODQsNyBAQCByc211LWky
Yy1vYmpzICAgICAgICAgICAgICAgICAgICAgICA6PSByc211X2NvcmUubyByc211X2kyYy5vDQo+
ICByc211LXNwaS1vYmpzICAgICAgICAgICAgICAgICAgOj0gcnNtdV9jb3JlLm8gcnNtdV9zcGku
bw0KPiAgb2JqLSQoQ09ORklHX01GRF9SU01VX0kyQykgICAgICs9IHJzbXUtaTJjLm8NCj4gIG9i
ai0kKENPTkZJR19NRkRfUlNNVV9TUEkpICAgICArPSByc211LXNwaS5vDQo+ICsNCj4gK2xhbjk2
NngtcGNpLW9ianMgICAgICAgICAgICAgICA6PSBsYW45NjZ4X3BjaS5vDQo+ICtsYW45NjZ4LXBj
aS1vYmpzICAgICAgICAgICAgICAgKz0gbGFuOTY2eF9wY2kuZHRiby5vDQo+ICtvYmotJChDT05G
SUdfTUZEX0xBTjk2NlhfUENJKSAgKz0gbGFuOTY2eC1wY2kubw0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tZmQvbGFuOTY2eF9wY2kuYyBiL2RyaXZlcnMvbWZkL2xhbjk2NnhfcGNpLmMNCj4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi5kOWQ4ODZhMTk0OGYNCj4g
LS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL21mZC9sYW45NjZ4X3BjaS5jDQo+IEBAIC0w
LDAgKzEsMjI5IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiAr
LyoNCj4gKyAqIE1pY3JvY2hpcCBMQU45NjZ4IFBDSSBkcml2ZXINCj4gKyAqDQo+ICsgKiBDb3B5
cmlnaHQgKGMpIDIwMjQgTWljcm9jaGlwIFRlY2hub2xvZ3kgSW5jLiBhbmQgaXRzIHN1YnNpZGlh
cmllcy4NCj4gKyAqDQo+ICsgKiBBdXRob3JzOg0KPiArICogICAgIENsw6ltZW50IEzDqWdlciA8
Y2xlbWVudC5sZWdlckBib290bGluLmNvbT4NCj4gKyAqICAgICBIZXJ2w6kgQ29kaW5hIDxoZXJ2
ZS5jb2RpbmFAYm9vdGxpbi5jb20+DQo+ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgPGxpbnV4L2ly
cS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2lycWRvbWFpbi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4
L2tlcm5lbC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiArI2luY2x1ZGUgPGxp
bnV4L29mLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4NCj4gKyNpbmNsdWRl
IDxsaW51eC9wY2kuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ICsNCj4gKy8qIEVt
YmVkZGVkIGR0Ym8gc3ltYm9scyBjcmVhdGVkIGJ5IGNtZF93cmFwX1NfZHRiIGluIHNjcmlwdHMv
TWFrZWZpbGUubGliICovDQo+ICtleHRlcm4gY2hhciBfX2R0Ym9fbGFuOTY2eF9wY2lfYmVnaW5b
XTsNCj4gK2V4dGVybiBjaGFyIF9fZHRib19sYW45NjZ4X3BjaV9lbmRbXTsNCj4gKw0KPiArc3Ry
dWN0IHBjaV9kZXZfaW50cl9jdHJsIHsNCj4gKyAgICAgICBzdHJ1Y3QgcGNpX2RldiAqcGNpX2Rl
djsNCj4gKyAgICAgICBzdHJ1Y3QgaXJxX2RvbWFpbiAqaXJxX2RvbWFpbjsNCj4gKyAgICAgICBp
bnQgaXJxOw0KPiArfTsNCj4gKw0KPiArc3RhdGljIGludCBwY2lfZGV2X2lycV9kb21haW5fbWFw
KHN0cnVjdCBpcnFfZG9tYWluICpkLCB1bnNpZ25lZCBpbnQgdmlycSwgaXJxX2h3X251bWJlcl90
IGh3KQ0KPiArew0KPiArICAgICAgIGlycV9zZXRfY2hpcF9hbmRfaGFuZGxlcih2aXJxLCAmZHVt
bXlfaXJxX2NoaXAsIGhhbmRsZV9zaW1wbGVfaXJxKTsNCj4gKyAgICAgICByZXR1cm4gMDsNCj4g
K30NCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBpcnFfZG9tYWluX29wcyBwY2lfZGV2X2ly
cV9kb21haW5fb3BzID0gew0KPiArICAgICAgIC5tYXAgPSBwY2lfZGV2X2lycV9kb21haW5fbWFw
LA0KPiArICAgICAgIC54bGF0ZSA9IGlycV9kb21haW5feGxhdGVfb25lY2VsbCwNCj4gK307DQo+
ICsNCj4gK3N0YXRpYyBpcnFyZXR1cm5fdCBwY2lfZGV2X2lycV9oYW5kbGVyKGludCBpcnEsIHZv
aWQgKmRhdGEpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IHBjaV9kZXZfaW50cl9jdHJsICppbnRy
X2N0cmwgPSBkYXRhOw0KPiArICAgICAgIGludCByZXQ7DQo+ICsNCj4gKyAgICAgICByZXQgPSBn
ZW5lcmljX2hhbmRsZV9kb21haW5faXJxKGludHJfY3RybC0+aXJxX2RvbWFpbiwgMCk7DQo+ICsg
ICAgICAgcmV0dXJuIHJldCA/IElSUV9OT05FIDogSVJRX0hBTkRMRUQ7DQo+ICt9DQo+ICsNCj4g
K3N0YXRpYyBzdHJ1Y3QgcGNpX2Rldl9pbnRyX2N0cmwgKnBjaV9kZXZfY3JlYXRlX2ludHJfY3Ry
bChzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4gK3sNCj4gKyAgICAgICBzdHJ1Y3QgcGNpX2Rldl9p
bnRyX2N0cmwgKmludHJfY3RybDsNCj4gKyAgICAgICBzdHJ1Y3QgZndub2RlX2hhbmRsZSAqZndu
b2RlOw0KPiArICAgICAgIGludCByZXQ7DQo+ICsNCj4gKyAgICAgICBpZiAoIXBkZXYtPmlycSkN
Cj4gKyAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FT1BOT1RTVVBQKTsNCj4gKw0KPiAr
ICAgICAgIGZ3bm9kZSA9IGRldl9md25vZGUoJnBkZXYtPmRldik7DQo+ICsgICAgICAgaWYgKCFm
d25vZGUpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PREVWKTsNCj4gKw0K
PiArICAgICAgIGludHJfY3RybCA9IGttYWxsb2Moc2l6ZW9mKCppbnRyX2N0cmwpLCBHRlBfS0VS
TkVMKTsNCj4gKyAgICAgICBpZiAoIWludHJfY3RybCkNCj4gKyAgICAgICAgICAgICAgIHJldHVy
biBFUlJfUFRSKC1FTk9NRU0pOw0KPiArDQo+ICsgICAgICAgaW50cl9jdHJsLT5wY2lfZGV2ID0g
cGRldjsNCj4gKw0KPiArICAgICAgIGludHJfY3RybC0+aXJxX2RvbWFpbiA9IGlycV9kb21haW5f
Y3JlYXRlX2xpbmVhcihmd25vZGUsIDEsICZwY2lfZGV2X2lycV9kb21haW5fb3BzLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnRy
X2N0cmwpOw0KPiArICAgICAgIGlmICghaW50cl9jdHJsLT5pcnFfZG9tYWluKSB7DQo+ICsgICAg
ICAgICAgICAgICBwY2lfZXJyKHBkZXYsICJGYWlsZWQgdG8gY3JlYXRlIGlycWRvbWFpblxuIik7
DQo+ICsgICAgICAgICAgICAgICByZXQgPSAtRU5PTUVNOw0KPiArICAgICAgICAgICAgICAgZ290
byBlcnJfZnJlZV9pbnRyX2N0cmw7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAgcmV0ID0g
cGNpX2FsbG9jX2lycV92ZWN0b3JzKHBkZXYsIDEsIDEsIFBDSV9JUlFfTEVHQUNZKTsNCj4gKyAg
ICAgICBpZiAocmV0IDwgMCkgew0KPiArICAgICAgICAgICAgICAgcGNpX2VycihwZGV2LCAiVW5h
YmxlIGFsbG9jIGlycSB2ZWN0b3IgKCVkKVxuIiwgcmV0KTsNCj4gKyAgICAgICAgICAgICAgIGdv
dG8gZXJyX3JlbW92ZV9kb21haW47DQo+ICsgICAgICAgfQ0KPiArICAgICAgIGludHJfY3RybC0+
aXJxID0gcGNpX2lycV92ZWN0b3IocGRldiwgMCk7DQo+ICsgICAgICAgcmV0ID0gcmVxdWVzdF9p
cnEoaW50cl9jdHJsLT5pcnEsIHBjaV9kZXZfaXJxX2hhbmRsZXIsIElSUUZfU0hBUkVELA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9uYW1lKCZwZGV2LT5kZXYpLCBpbnRyX2N0cmwp
Ow0KPiArICAgICAgIGlmIChyZXQpIHsNCj4gKyAgICAgICAgICAgICAgIHBjaV9lcnIocGRldiwg
IlVuYWJsZSB0byByZXF1ZXN0IGlycSAlZCAoJWQpXG4iLCBpbnRyX2N0cmwtPmlycSwgcmV0KTsN
Cj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX2ZyZWVfaXJxX3ZlY3RvcjsNCj4gKyAgICAgICB9
DQo+ICsNCj4gKyAgICAgICByZXR1cm4gaW50cl9jdHJsOw0KPiArDQo+ICtlcnJfZnJlZV9pcnFf
dmVjdG9yOg0KPiArICAgICAgIHBjaV9mcmVlX2lycV92ZWN0b3JzKHBkZXYpOw0KPiArZXJyX3Jl
bW92ZV9kb21haW46DQo+ICsgICAgICAgaXJxX2RvbWFpbl9yZW1vdmUoaW50cl9jdHJsLT5pcnFf
ZG9tYWluKTsNCj4gK2Vycl9mcmVlX2ludHJfY3RybDoNCj4gKyAgICAgICBrZnJlZShpbnRyX2N0
cmwpOw0KPiArICAgICAgIHJldHVybiBFUlJfUFRSKHJldCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRp
YyB2b2lkIHBjaV9kZXZfcmVtb3ZlX2ludHJfY3RybChzdHJ1Y3QgcGNpX2Rldl9pbnRyX2N0cmwg
KmludHJfY3RybCkNCj4gK3sNCj4gKyAgICAgICBmcmVlX2lycShpbnRyX2N0cmwtPmlycSwgaW50
cl9jdHJsKTsNCj4gKyAgICAgICBwY2lfZnJlZV9pcnFfdmVjdG9ycyhpbnRyX2N0cmwtPnBjaV9k
ZXYpOw0KPiArICAgICAgIGlycV9kaXNwb3NlX21hcHBpbmcoaXJxX2ZpbmRfbWFwcGluZyhpbnRy
X2N0cmwtPmlycV9kb21haW4sIDApKTsNCj4gKyAgICAgICBpcnFfZG9tYWluX3JlbW92ZShpbnRy
X2N0cmwtPmlycV9kb21haW4pOw0KPiArICAgICAgIGtmcmVlKGludHJfY3RybCk7DQo+ICt9DQo+
ICsNCg0KSXQgbG9va3MgbGlrZSB0aGUgdHdvIGZ1bmN0aW9ucyBiZWxvdyAoYW5kIHRoZWlyIGhl
bHBlciBmdW5jdGlvbnMpIGFyZSBzbw0KZ2VuZXJpYyB0aGF0IHRoZXkgY291bGQgYmUgcGFydCBv
ZiB0aGUgcGNpIGRyaXZlciBjb3JlIHN1cHBvcnQuDQpBbnkgcGxhbnMgZm9yIHRoYXQ/DQoNCj4g
K3N0YXRpYyB2b2lkIGRldm1fcGNpX2Rldl9yZW1vdmVfaW50cl9jdHJsKHZvaWQgKmRhdGEpDQo+
ICt7DQo+ICsgICAgICAgc3RydWN0IHBjaV9kZXZfaW50cl9jdHJsICppbnRyX2N0cmwgPSBkYXRh
Ow0KPiArDQo+ICsgICAgICAgcGNpX2Rldl9yZW1vdmVfaW50cl9jdHJsKGludHJfY3RybCk7DQo+
ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgZGV2bV9wY2lfZGV2X2NyZWF0ZV9pbnRyX2N0cmwoc3Ry
dWN0IHBjaV9kZXYgKnBkZXYpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IHBjaV9kZXZfaW50cl9j
dHJsICppbnRyX2N0cmw7DQo+ICsNCj4gKyAgICAgICBpbnRyX2N0cmwgPSBwY2lfZGV2X2NyZWF0
ZV9pbnRyX2N0cmwocGRldik7DQo+ICsNCj4gKyAgICAgICBpZiAoSVNfRVJSKGludHJfY3RybCkp
DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihpbnRyX2N0cmwpOw0KPiArDQo+ICsg
ICAgICAgcmV0dXJuIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgmcGRldi0+ZGV2LCBkZXZtX3Bj
aV9kZXZfcmVtb3ZlX2ludHJfY3RybCwgaW50cl9jdHJsKTsNCj4gK30NCj4gKw0KDQouLi4NCltz
bmlwXQ0KLi4uDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3F1aXJrcy5jIGIvZHJpdmVy
cy9wY2kvcXVpcmtzLmMNCj4gaW5kZXggZWZmN2Y1ZGYwOGUyLi45OTMzZjI0NWI3ODEgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvcGNpL3F1aXJrcy5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL3F1aXJr
cy5jDQo+IEBAIC02MjQxLDYgKzYyNDEsNyBAQCBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJ
X1ZFTkRPUl9JRF9JTlRFTCwgMHhhNzZlLCBkcGNfbG9nX3NpemUpOw0KPiAgREVDTEFSRV9QQ0lf
RklYVVBfRklOQUwoUENJX1ZFTkRPUl9JRF9YSUxJTlgsIDB4NTAyMCwgb2ZfcGNpX21ha2VfZGV2
X25vZGUpOw0KPiAgREVDTEFSRV9QQ0lfRklYVVBfRklOQUwoUENJX1ZFTkRPUl9JRF9YSUxJTlgs
IDB4NTAyMSwgb2ZfcGNpX21ha2VfZGV2X25vZGUpOw0KPiAgREVDTEFSRV9QQ0lfRklYVVBfRklO
QUwoUENJX1ZFTkRPUl9JRF9SRURIQVQsIDB4MDAwNSwgb2ZfcGNpX21ha2VfZGV2X25vZGUpOw0K
PiArREVDTEFSRV9QQ0lfRklYVVBfRklOQUwoMHgxMDU1LCAweDk2NjAsIG9mX3BjaV9tYWtlX2Rl
dl9ub2RlKTsNCj4NCj4gIC8qDQo+ICAgKiBEZXZpY2VzIGtub3duIHRvIHJlcXVpcmUgYSBsb25n
ZXIgZGVsYXkgYmVmb3JlIGZpcnN0IGNvbmZpZyBzcGFjZSBhY2Nlc3MNCj4gLS0NCj4gMi40NC4w
DQoNCkJlc3QgUmVnYXJkcw0KU3RlZW4NCg==

