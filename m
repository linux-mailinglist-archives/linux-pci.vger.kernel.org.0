Return-Path: <linux-pci+bounces-6555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E83898ADFD7
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 10:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494F1B26A40
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 08:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7681E526;
	Tue, 23 Apr 2024 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="eEQss8hC"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23195320E;
	Tue, 23 Apr 2024 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861285; cv=fail; b=FMmRzl2vaLZ6Ow8dz//5HJfUjmM2jEZ7pCvwnQdmnfx1vJSmuCMLRAKuyEU6gAgH5Ur7pEwtk4ap7eCTVjH4cGEoZL/LR2XSE0WXaVg0gs4GWp0Ayx069HDF9+uG3liFcmg1xYlWEPZVhxxq4LGPxwiiihKo7eIW04dvnXs9x2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861285; c=relaxed/simple;
	bh=lES6dwQV6nHvMEOUsPo3j8Ig2MrXqb6EgK/P5cfOzKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QgSUhhJZN1OUVexPVD34chS43zNsFthkMBWibejW/AP5LrNxX/SlgHFw+8eKto1H8A1WqaW3DC/2wb57f+mLubukwvYuB3QY4KEKl9qZ2pcC4+4EF621H5sUTZecIA9f0cJ12NU9XgYXGqNayW1hHLSJ5T3XzTOIPoehqplR9UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=eEQss8hC; arc=fail smtp.client-ip=216.71.158.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1713861282; x=1745397282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lES6dwQV6nHvMEOUsPo3j8Ig2MrXqb6EgK/P5cfOzKI=;
  b=eEQss8hCWJmmc10cdUO3MhkUTFaaPkhvj6/NNBI+4xFqSSpAzkSHnqvM
   9QEKJbhMqgpWjeZODxhq0sZM2c1HAV8pJ/AaAdazKzVDyQNDGIP1eUqye
   WU0wzR/x1kVEdrqujISYivDsKl2D4eKdF1YBQSUclVNvZK1Y8shjGD3/d
   x/5qsCBUA8vI/9bTVqqaLOV49byH7wd5+iClxgyZw7UvBY9mHq+LawwTo
   zgNz1i/q8MK/J8k3CnONMjGx+XHz0zC5WtiY60dDE4eXPQzNzat47MKeN
   V/vQpw+EPuW9RGQdiJvrG73Z+m2rpWLrSIOTLNOp4bd+ngrFjIhRfwJA1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="117454263"
X-IronPort-AV: E=Sophos;i="6.07,222,1708354800"; 
   d="scan'208";a="117454263"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 17:33:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFxsYBkaw/onwl9gh00gfKd4/v5UilF7qVNwQEo5Dy5keBrHqPcU8fLPhG61KcYT9VjYpjIIrUl0IbAn4b+w/iX2UbyPK43FD3aunELM+PyCU1bqtgEod659ivvoBi7Fo+L3yNBZbhJ3zlYO62091p82NNoUT8se4qBtavuinXI2U1pGxTlAb9nxWMs8RT8qc7vHqrK46QbWjA98RmPgeocIPWNlEdTbOTq9ECqL/LTy0DbrDmupwCloozOcinSPUEY/dOs1cJn8jA5Wtx7LaBtypUUjD9XJT/Ze73YsUaifO7ALEY/QtZkvcGA5+ER9rfywO13PreuY7Uc7CJ6C6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lES6dwQV6nHvMEOUsPo3j8Ig2MrXqb6EgK/P5cfOzKI=;
 b=b15JWuwrdZHWt+omcVDv72YC2Ntr17vOixPonAiC285LMn6wy+soHTItBnAjfR9oSCDleLyzHo5kFxnYmB+mEsr1RzgMH+geGaTYNh45FYWA8o4yHtACCQqUljjalLa5yB7w5hTB9mbWaudsjEMh5JGvIPBf+8dXN79Ma2YSZluVWwqD4gkCy8XOh9xZ0ZrTiBU5UBltoa80LnBnC4cT4C5pmFk0KCzvHOcU52RZCg2H0uctGtlNHKsjrXqGkVxa2K7N8Z1p5EOGuaVAkXMGoEtEobpdFuo2FeA29Q4qcpqeFfZxRjbpqlM5g6pVx6IvRml8VIuSmUXvPQjDnpKNPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OSYPR01MB5383.jpnprd01.prod.outlook.com (2603:1096:604:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 08:33:13 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 08:33:13 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Dave Jiang' <dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mj@ucw.cz"
	<mj@ucw.cz>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: RE: [PATCH v5 1/2] cxl/core/regs: Add rcd_regs initialization at
 __rcrb_to_component()
Thread-Topic: [PATCH v5 1/2] cxl/core/regs: Add rcd_regs initialization at
 __rcrb_to_component()
Thread-Index: AQHajKe0pP9wicoPEUisYs26tRO3Q7Fk6aeAgBCrmNA=
Date: Tue, 23 Apr 2024 08:33:13 +0000
Message-ID:
 <OSAPR01MB71823658767F3088CDA09489BA112@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240412070715.16160-1-kobayashi.da-06@fujitsu.com>
 <20240412070715.16160-2-kobayashi.da-06@fujitsu.com>
 <dcf61e50-2a56-4e1e-a21d-c887e3c07427@intel.com>
In-Reply-To: <dcf61e50-2a56-4e1e-a21d-c887e3c07427@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9NWRkMWYzYTYtODllZS00NWY1LTgwOTQtZjcxNWQwOTQ0?=
 =?utf-8?B?MDZjO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA0LTIzVDA4OjIxOjUyWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OSYPR01MB5383:EE_
x-ms-office365-filtering-correlation-id: 16ca37a6-b977-4d3c-6fa2-08dc637003e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?RW9SUUdxaXFXN0xTenJNVk00OWgzWU9iQ3paR1lnWEZGenJFWC9FUjdqWXVu?=
 =?utf-8?B?MTM3M0pPSjhjbEV3SXkvMUZsdkxRanFJSkxKTkRtQXNUSVhVcHVYVGREVm0r?=
 =?utf-8?B?eWI0elNOOGxvVDF0eVpKUEZ3Mkk4K0tkSXhwT2d3ektmZkp6UHJ5UGpleDJB?=
 =?utf-8?B?MWJ0WWRTQ2FubHV3TUxUdk5QUnl0cWM1SVZjc1EwSjB1TlpZMWNsOC8yOEhW?=
 =?utf-8?B?cDR1QUhmaXg0YVJ3YzNoMmJjK2dqSDZ5TVZ3RUZMNkJOL29sNkVmY1d2YVhj?=
 =?utf-8?B?eFovRHdKVmpEQjM1ZXZxZjJmQzdVYU1rSWVSbEVJYnlndlk4MTBwZjc5ZHkz?=
 =?utf-8?B?K2l1eXdzZDhZVnZOVTVJbnZrRlBpdFJXWHhRUGlaUStTeU9zZWpZcmNMM0FV?=
 =?utf-8?B?MFVNR2NURXZabUIvS21kU3d3Z1lnbmFJdmd1UlQ4Wkh6eWdUS011Smp5MWl1?=
 =?utf-8?B?REtPeGI5R2VBd001QnNBaWVScHNBM2tsbjVSQVc5SHlZcTgrbWM0alFqeWxD?=
 =?utf-8?B?eVMrU2JxOWRnOG5HUy9DaXZldTBJWUVlNUw3dXJZTWZKeU1yalBiOFJDMU4w?=
 =?utf-8?B?UmdFSlhWek9id2czWjhjZXZqenNzUFBrTk5FdUcwbVNyM3lCT3ZyM0lxL1Z5?=
 =?utf-8?B?NEd3Wi9PNTJiMXhKamU3bWZQN24vTzY5b0J1WGpyMURmQU81cm5kT3dvOWtM?=
 =?utf-8?B?Y2xqOTRaelp3VGpYeXJaOWxTOVhIcW05N3FDK2UyVkNIaWhVUTFzWk5Ud0pZ?=
 =?utf-8?B?TjZZdWlXWXdNWjl0azRNYWhrV0MrclJZZ2xnWUd2TXNYaUtXcEpaWG5iYy9H?=
 =?utf-8?B?dnZyc1FpVjkySWtNMjN3anQ3WVVibFdNMTZLaXd5OXJmdnpFT0dwSDBuSTgw?=
 =?utf-8?B?Tnl5SVFoQVRtWXFqY0ZJM0RINDR3b2FEdGVNTzd4cnhWaGtQbEFzRkFZdnBY?=
 =?utf-8?B?ajJOb3NFSHdLajdCZXZKTFp0QSs0MTFHUFZlamREYW1LYUE3RXBWRlJxYlNw?=
 =?utf-8?B?aDlsQ3ppWmFjRjRyaGoyQmtBdS9RZmNMTDFOa3RWZ3RVM0J6WmQ0d0FRMjBm?=
 =?utf-8?B?K2VBMHhGTUZwUmhLVVN4bCs2Nk1KNVNCbnNITTVsMXFMWHZPS3NndERzTHRQ?=
 =?utf-8?B?djMwZHlOWk9aMjg2ZlZob1pYZTJOeFNlcTUxY3NvWEFzeHk2NEdRQmZSdnZQ?=
 =?utf-8?B?cjFIbDR2TUJzcE5HVWQ4S3lGdmxwY3BuaVVQK0JUT0RBMU1uSkpTNnBiY0xF?=
 =?utf-8?B?Y2FwRmZWc2hxcVZYSllBMkdpZ25PSmQyYXh2SjAzbTl5NHVMNklYMCtkMHVo?=
 =?utf-8?B?eXA0ZktpVXR6VlNwRWV1WWx3dVNKTVpkSjVvZnI0cEhoVERqeWRMVEVPWHpR?=
 =?utf-8?B?eENPTXY0dmtDZTFkRGdjZzFSbEVsOWhXOG9YejhnZjRBL25nL1pMRjVWVFFt?=
 =?utf-8?B?RStHMkdpUVlaM3FKOGZacXRONWZFNlpjY2VuNWNqYnFkTDd1cnNUOVNWR0FP?=
 =?utf-8?B?NEpGSGdxancyK2dQaVBkTFRtN0xBaVNtazBHamRmWDYrcWtCeUZRaURnTnlZ?=
 =?utf-8?B?UGdhZHVjSlJ1cDVib2pibmx0elVxOHg2Rm9mR2lodkhKcUgrUU1OMkk5RU4x?=
 =?utf-8?B?VnNvRGFaNmY4ZTRHVmJLOGx0ekVuRExxRzZzRTU1VDdCUW5kRG54TXZtT2Jx?=
 =?utf-8?B?aWVGVjFQS1ZGRndLaGlZM2Q3dFVmOGZlK3R4MWl4VHNwRmR0bkEwclc4dGNt?=
 =?utf-8?B?bk9iaEtlVzRGZUJLbExPRkVjNjgwQlZKUHp6MXkxb2xkR1M4UG52K0UwMEJ1?=
 =?utf-8?Q?o+t+0Ixqpv2XWjxpU5DZZY1V405tqeXolTMig=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzNqeFVEekNVWmIySlA2NVowUS9kUk9iN0JIelo2QUQva29yM2ozMnUzTlcw?=
 =?utf-8?B?RzJOVmd0ZDl6RHcxUGtwNUdmc1l1SWpsNXNTdlBLbDJDbHJ0MmJyYnpHd0p6?=
 =?utf-8?B?Z0VhQmdaYjZSc3Q2WUJ6MGc5ZG4wRFB2b3RvMVRLNG40bWk5ZnE5SWVBTzlG?=
 =?utf-8?B?RWtOVTJ4Q0hSV0J4bWlYQTdEN1Z0TnErd01YelY1T1VXVThVSTkyQUFPRUMr?=
 =?utf-8?B?blYyV0lkQkh1RmpZVm9UbzVKaWJLM0JVV2h2dVA3cFJLMDZqVldscXlUa3dr?=
 =?utf-8?B?bGlZeDVWQ1Rob0tESXA2ZEozY280ZGtXN3BBRXRJSDZ3b0VxUm9VSUEzRERi?=
 =?utf-8?B?bXhLRU1XcVNGczdaaFgrWlJPeml0WVNYMEE1QVZTdzQ1ZHZPQ2gvTncwcnJk?=
 =?utf-8?B?Ulhnd2k2SG13YUdwdWhUdWQ4aGRuZ2N2d3NHcWY0djZreHdFZWRZbTRvOElM?=
 =?utf-8?B?YXg1bXE3cndpTTh4emRWMjBYdUljcnl2V0ZFSDdWTnlkM1dZTE5kQzVnb0Uv?=
 =?utf-8?B?VGJtdHNBTEkxNHNWZml2blJLMkJYT2wwdFk0TzNyMnd1NkRGSmRkVHltY1VF?=
 =?utf-8?B?VTRFbWxhYW13eVV6cHRsbGhqWFdRQlA2WEZiYWJQbExpc2IyODFvVlZwdHE3?=
 =?utf-8?B?ZVJGYkcveHhmK013djZ1NUhRbEdEVDhDYmRyZnQxTzlFYUNHM3JGV3M3Rm1B?=
 =?utf-8?B?RFNiN2hVRkpIaTR1VWxzOHF6aVo5d0tIUzg4RXBHTCt5NVdoK0NVeERPNWh3?=
 =?utf-8?B?aTdvMjlYckJCRXQ0ak5sTzAxNDBFeklmdDhxWFkxVVlWZmtDWGY2RDcxV3ps?=
 =?utf-8?B?UkZvdHQ1dEJ4bWRob2V6WkJIN3hLbjNRYmpRZk1IaVlBdE5UeklwUUMyalll?=
 =?utf-8?B?K2IyQ2J3ZmpSQXFnUEJBQ25kTndURFV1dnNvOWlzWFZJRGtDQkdzMUdQeTJ1?=
 =?utf-8?B?MFkwQitLR0hMWHF3Z1hvSHMybGZjZ3BYd3ptM2d0ZTNMbDg5OEJEdEcxZjJr?=
 =?utf-8?B?Z0hRSW91US8ydWR2MWNSSldabVFZdzJNdllVMG9UUXEwQXllSlhZamVqU0Rx?=
 =?utf-8?B?RndDQllVbnFma1Nxb2YzL2RUY1JaNWNFZzBBNzAyamp6b2FCbm5jaHNpVWtR?=
 =?utf-8?B?c21XKzdOWDNidVdRak1ac3ZBYkVjdGxHbzBnQUxzSjFTVkpwbzRSYkI3eHhH?=
 =?utf-8?B?ck9aQkFGWXB5bTh2bWpNY3kwQUxCZjVBZlVPYmVuekp0NU5nYW1RWkRoZnhw?=
 =?utf-8?B?QWpsV2VjY2c2L3g4K0pKUm53VFBHY0thYnlJT3JEN01hVTYyREU3bFY4UGFs?=
 =?utf-8?B?bXlLWWhoc3Nzd2V4ZFo2d2tpQjdLSXU3RXZ2QjJYUTJNVi9Lc1BWZ2gzSE5R?=
 =?utf-8?B?N3JQcG9iNkJicnBlUkxraitjcG5VRTJTWUx2bzZWOXVZVEd6b1pleUZPQlFF?=
 =?utf-8?B?VHZWSHU4bHRYVU0wa0U1WDc5MnVZaEhmRjJZV2tKUmFKcjM5WnhDMTR5bWFV?=
 =?utf-8?B?WkthdEVIUUpka3kzT0wrTFJMWGd5MHVBcFZhdDU4QmlwemYrNWFhcC83aG93?=
 =?utf-8?B?cHQwTjNiUnlGTmp6Qko5WEVjMjZLN2lNTmtySThXeHpqRW5rQ2JxeXBrSFli?=
 =?utf-8?B?QmpsU05Hb2lQS0wrTnIyVlU4TFNLQjB6MnlOVk5GT0Z0ZytRVGorY1FwMFhW?=
 =?utf-8?B?b0xNNFZsZlozRVVQRmlORXN2clpsR3hFbFdOd3FnQ3d0RERPSEgyNWh3Mndl?=
 =?utf-8?B?N1ZUanpPeTV2U2J1aTV4aTJob09SNWlreXRqcFJzYjhwOVBBK1F0ekV5UFRD?=
 =?utf-8?B?VHlBSVg3V0dxOE5LVWRXQ1MwQkQwdlNrZWVOS1hhQXZJR2tkSGV2WkhJU2I0?=
 =?utf-8?B?NW1FZFZDOE96L2ZHQ2pzMUxuc3Z4YTlPTW1zSFBHWEtKNC9WWW9tNkk5dEdX?=
 =?utf-8?B?WTBqbjUrSGU3RzBHeFlrMmJ1enR4aEIzZlFkeXVudnNCQ0oxdGNjellOb2N2?=
 =?utf-8?B?ZWNsTWt5eHM1UWR0c1hrazV6Y1Fsb3p4bSt2d3ZSdUpXU0xoYWM1cVdZY3pI?=
 =?utf-8?B?a29oRlRvMitxRmx4UHBUeHcrTWZmalhYS1FhT2pRQ0EvS0Z4Wllnd3ZzRWRQ?=
 =?utf-8?B?c0JnMkJyWHhUcnlWRW15c2FEcXJpZk9KVTY1MWkxY3Y5VExHQTExRldtelVD?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MJ/u7AFTD+9nsVeBeNFDD8m3ag9YjU90tFvtjYzAL++zhadDJiOQcj40sxkq6uNIgfdgPzeUFJoh+XPa3dHuRByfunNEwPWMMe/mDz2HvkJmF0jeRgGmNya71Fj3v0EAWP6fZYIOcpkeXkIgNrT4ztorfZG3IpexXbXgJntLr3ne4Y6rI39/AKqWLLykfv3uDWAwp0xD/1pufmMez5w9Q2OU0G5bL/cJRX8NLGJjfmHU9Zr9HNORM9mbrm0MkR1GFSscly+9qNeI5J9EhuFnidfnoegoJcMdqBlTd+0AcHk2wdeckaqdWxeQHk1DstTRwXJrIyMCTMxMwL5kfltrTey3xoo+sfiXsxECegQdBRZ/O8tCR/mfAQgsXKtxJfibWEvBSiaSwn6Ggo1qEnStOoHjUOBTJzamRHrWw8KGs+v2INSKshsVamFxPxLYDxVnfFQOvXwn4hM5Cn11i8+HMFodtsDQ6+3bYz3fTCPhRkiQlYfeOF5YNs17jgwCBQemHiV4rL1kA8ORWszbpsz7hF+DubTee0hn5XPaVKQcqrbtoVKPkP1MsMdiO2TxXrfae7lfk/tHxSkyS3IHdh1RY2BrAa8VZwWFCCGe/33pf1vUQ6n7x0qSDBVlBUdl/EHE
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ca37a6-b977-4d3c-6fa2-08dc637003e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 08:33:13.2211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/t/zlIcFuBwAp3xOGTgy6ExTLwfaI7LdHX/7yxnCVvAQbxmS6EVJDS9fIzjM62T+QV3Q6XyBeaVZQlgCi5rpuVhsyIOyTXjW7N/l8z7NGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5383

RGF2ZSBKaWFuZyB3cm90ZToNCj4gT24gNC8xMi8yNCAxMjowNyBBTSwgS29iYXlhc2hpLERhaXN1
a2Ugd3JvdGU6DQo+ID4gQWRkIHJjZF9yZWdzIGFuZCBpdHMgaW5pdGlhbGl6YXRpb24gYXQgX19y
Y3JiX3RvX2NvbXBvbmVudCgpIHRvIGNhY2hlDQo+ID4gdGhlIGN4bDEuMSBkZXZpY2UgbGluayBz
dGF0dXMgaW5mb3JtYXRpb24uIFJlZHVjZSBhY2Nlc3MgdG8gdGhlIG1lbW9yeQ0KPiA+IG1hcCBh
cmVhIHdoZXJlIHRoZSBSQ1JCIGlzIGxvY2F0ZWQgYnkgY2FjaGluZyB0aGUgY3hsMS4xIGRldmlj
ZQ0KPiA+IGxpbmsgc3RhdHVzIGluZm9ybWF0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
IktvYmF5YXNoaSxEYWlzdWtlIiA8a29iYXlhc2hpLmRhLTA2QGZ1aml0c3UuY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL2N4bC9jb3JlL3JlZ3MuYyB8IDE2ICsrKysrKysrKysrKysrKysNCj4g
PiAgZHJpdmVycy9jeGwvY3hsLmggICAgICAgfCAgMyArKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAxOSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29y
ZS9yZWdzLmMgYi9kcml2ZXJzL2N4bC9jb3JlL3JlZ3MuYw0KPiA+IGluZGV4IDM3Mjc4NmY4MDk1
NS4uZTBlOTZiZTBjYTdkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3hsL2NvcmUvcmVncy5j
DQo+ID4gKysrIGIvZHJpdmVycy9jeGwvY29yZS9yZWdzLmMNCj4gPiBAQCAtNTE0LDYgKzUxNCw4
IEBAIHJlc291cmNlX3NpemVfdCBfX3JjcmJfdG9fY29tcG9uZW50KHN0cnVjdCBkZXZpY2UNCj4g
KmRldiwgc3RydWN0IGN4bF9yY3JiX2luZm8gKnJpDQo+ID4gIAl1MzIgYmFyMCwgYmFyMTsNCj4g
PiAgCXUxNiBjbWQ7DQo+ID4gIAl1MzIgaWQ7DQo+ID4gKwl1MTYgb2Zmc2V0Ow0KPiA+ICsJdTMy
IGNhcF9oZHI7DQo+ID4NCj4gPiAgCWlmICh3aGljaCA9PSBDWExfUkNSQl9VUFNUUkVBTSkNCj4g
PiAgCQlyY3JiICs9IFNaXzRLOw0KPiA+IEBAIC01MzcsNiArNTM5LDIwIEBAIHJlc291cmNlX3Np
emVfdCBfX3JjcmJfdG9fY29tcG9uZW50KHN0cnVjdCBkZXZpY2UNCj4gKmRldiwgc3RydWN0IGN4
bF9yY3JiX2luZm8gKnJpDQo+ID4gIAljbWQgPSByZWFkdyhhZGRyICsgUENJX0NPTU1BTkQpOw0K
PiA+ICAJYmFyMCA9IHJlYWRsKGFkZHIgKyBQQ0lfQkFTRV9BRERSRVNTXzApOw0KPiA+ICAJYmFy
MSA9IHJlYWRsKGFkZHIgKyBQQ0lfQkFTRV9BRERSRVNTXzEpOw0KPiA+ICsJb2Zmc2V0ID0gRklF
TERfR0VUKEdFTk1BU0soNywgMCksIHJlYWR3KGFkZHIgKw0KPiBQQ0lfQ0FQQUJJTElUWV9MSVNU
KSk7DQo+IA0KPiBNYXliZQ0KPiAjZGVmaW5lIFBDSV9SQ1JCX0NBUEFCSUxJVFlfTElTVF9JRF9N
QVNLCUdFTk1BU0soNywgMCkNCj4gDQo+ID4gKwljYXBfaGRyID0gcmVhZGwoYWRkciArIG9mZnNl
dCk7DQo+ID4gKwl3aGlsZSAoKGNhcF9oZHIgJiBHRU5NQVNLKDcsIDApKSAhPSBQQ0lfQ0FQX0lE
X0VYUCkgew0KPiANCj4gd2hpbGUgKChGSUVMRF9HRVQoUENJX1JDUkJfQ0FQX0hEUl9JRF9NQVNL
LCBjYXBfaGRyKSAhPQ0KPiBQQ0lfQ0FQX0lEX0VYUCkgew0KPiANCj4gQWxzbyBJIHRoaW5rIHlv
dSBuZWVkIHRvIGFkZCBhIGNoZWNrIGFuZCBzZWUgaWYgdGhlIGxvb3Agd2VudCBiZXlvbmQgU1pf
NEsgdGhhdA0KPiB3YXMgbWFwcGVkLg0KPiANCj4gPiArCQlvZmZzZXQgPSAoY2FwX2hkciA+PiA4
KSAmIEdFTk1BU0soNywgMCk7DQo+IA0KPiAjZGVmaW5lIFBDSV9SQ1JCX0NBUF9IRFJfTkVYVF9N
QVNLCUdFTk1BU0soMTUsIDgpOw0KPiBvZmZzZXQgPSBGSUVMRF9HRVQoUENJX1JDUkJfQ0FQX0hE
Ul9ORVhUX01BU0ssIGNhcF9oZHIpOw0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudC4gSW4g
dGhlIG5leHQgcGF0Y2ggSSB3aWxsIGRlZmluZSBhbmQgdXNlIGFkZGl0aW9uYWwgbWFza3MuDQoN
Cj4gPiArCQlpZiAob2Zmc2V0ID09IDApDQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJCWNhcF9oZHIg
PSByZWFkbChhZGRyICsgb2Zmc2V0KTsNCj4gPiArCX0NCj4gPiArCWlmIChvZmZzZXQpIHsNCj4g
PiArCQlyaS0+cmNkX2xua2NhcCA9IHJlYWRsKGFkZHIgKyBvZmZzZXQgKyBQQ0lfRVhQX0xOS0NB
UCk7DQo+ID4gKwkJcmktPnJjZF9sbmtjdHJsID0gcmVhZGwoYWRkciArIG9mZnNldCArIFBDSV9F
WFBfTE5LQ1RMKTsNCj4gPiArCQlyaS0+cmNkX2xua3N0YXR1cyA9IHJlYWRsKGFkZHIgKyBvZmZz
ZXQgKyBQQ0lfRVhQX0xOS1NUQSk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJaW91bm1hcChhZGRy
KTsNCj4gPiAgCXJlbGVhc2VfbWVtX3JlZ2lvbihyY3JiLCBTWl80Syk7DQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jeGwvY3hsLmggYi9kcml2ZXJzL2N4bC9jeGwuaA0KPiA+IGluZGV4
IDAwM2ZlZWJhYjc5Yi4uMmRjODI3YzMwMWExIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3hs
L2N4bC5oDQo+ID4gKysrIGIvZHJpdmVycy9jeGwvY3hsLmgNCj4gPiBAQCAtNjQ3LDYgKzY0Nyw5
IEBAIGN4bF9maW5kX2Rwb3J0X2J5X2RldihzdHJ1Y3QgY3hsX3BvcnQgKnBvcnQsIGNvbnN0DQo+
IHN0cnVjdCBkZXZpY2UgKmRwb3J0X2RldikNCj4gPiAgc3RydWN0IGN4bF9yY3JiX2luZm8gew0K
PiA+ICAJcmVzb3VyY2Vfc2l6ZV90IGJhc2U7DQo+ID4gIAl1MTYgYWVyX2NhcDsNCj4gPiArCXUx
NiByY2RfbG5rY3RybDsNCj4gPiArCXUxNiByY2RfbG5rc3RhdHVzOw0KPiA+ICsJdTMyIHJjZF9s
bmtjYXA7DQo+ID4gIH07DQo+ID4NCj4gPiAgLyoqDQoNClBsZWFzZSBsZXQgbWUga25vdyBpZiBh
bnkgcmV2aXNpb25zIGFyZSBuZWNlc3NhcnkgZm9yIG1lcmdpbmcgdGhpcyBwYXRjaC4NCg==

