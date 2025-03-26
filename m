Return-Path: <linux-pci+bounces-24752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CCAA71429
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 10:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204683A55E8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 09:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B39E1AD403;
	Wed, 26 Mar 2025 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zEOH8gsY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7A91A2545;
	Wed, 26 Mar 2025 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982752; cv=fail; b=NkD8860hjfA/OAAJZysj0bLaNV/lNUAWMdxI9dFGJeG7C2g2yLrTyRk6btsRaPh2xtYg6S/Sf4Vjr3JVAU1u1e0XXQqwHDGP9OuzNo5rEEdlxgt30Mw58bYZSb7yYQ6FRbTqAkxJui2nuXEA3BQscKNM7BAypC+pNjpZ5Vnc1Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982752; c=relaxed/simple;
	bh=TpNIaZd1cw3uY2RXER8QqGquml4j9WNCTx6mciegPd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qU5YUvDsrJkIaT8rcTH2+DJ9NaMt413Mli175Qu666QTR7ixDYeT3Pw0Tdy5FjpYHszldlyODAtCVYuoV6olFINK/fJbNjEdWfFMCARzOYK5AJbGeH6+UiU6dmgz+YqP3CZ5JADgS1xMEfmtPlryA7jpPGsfFZ+1Ld6dyKPdTmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zEOH8gsY; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZhUHWpvRPCrngsubslBQ99TrU/gp7CstTxzw/+QdsJ6Yd/BDQORwPZ70F2JhIiJEraQczlBxwVgPQZXq9CEIQy6z94tj4RJRvPoXD0R4rgFB7MoyurS0vOwQ7IY4E3S4gtCkxGxftk/v30o7M457eNmnsW3kM2p3+HfH5raL5Y/6R+oVSaSKWzebK9nnAEP4p7mdg8hDllvt6qOYOb+HyUdhgHYJ8WN34c8NsaV9EKMqj1ozAZdmvApPMISXWkOUruPMYDXwV0sylHcwHH2NHkdVmjBhHC50uCbz2fSk+O2WIhCfonJ4mAvTMKxH4alpiL2IWDhcUMvflCbcyzRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpNIaZd1cw3uY2RXER8QqGquml4j9WNCTx6mciegPd4=;
 b=T9ikV5ttQmGcfukQ1rIiVIJqZoRcqckcx2rwsBUe9AWOoyQ6RJTSuu6UVTj+ud4KEf9R/gtmq85qz6ZIErsfBQzUVHnj12N4wv7lEB8uZwWLQK2govr7Nuhght+X9vwWs02EIlmSjZngFkLP+UGN+Njo8iNCs4Tz34LBhW5tNAHjf0pNERa0Zk4kefP//asyGHo+d0vqopy37lmVTeSXGiEeaUdrPV2LXNLm6oThwm6HC5c1r66LkBotIi648mu3VuAoF3s+M6/6+W5QJ5x0VS/0ZM4XrEQTIsMuBG+FcDsCt6geWFtS5PYMZg9GE6zfhOP2WF1p0KhmQxq7PV3ywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpNIaZd1cw3uY2RXER8QqGquml4j9WNCTx6mciegPd4=;
 b=zEOH8gsYqku0mYper865iOmnL39TAoSdZJev/cnF/bOp29ym8EF07FNY7Y6eeOPeoAg2Uh1jjHq5GGuH/xiFrcci0cH2APkPncXkpZdZ79C53tioiii8V32NuUo+1z06uJf/1K+HiiRBoRlM5fH5Vn3rf4hmJqqRjnWm0W6P/3E=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 09:52:27 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%4]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 09:52:27 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [PATCH v6 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for
 PCIe RP PERST#
Thread-Topic: [PATCH v6 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for
 PCIe RP PERST#
Thread-Index: AQHbnfbjvSDMCDU48k2nBVXxoWlwx7OFCj6AgAAfQpA=
Date: Wed, 26 Mar 2025 09:52:27 +0000
Message-ID:
 <DM4PR12MB61583FB27440F33C422A9F44CDA62@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250326022811.3090688-1-sai.krishna.musham@amd.com>
 <20250326022811.3090688-2-sai.krishna.musham@amd.com>
 <20250326-stereotyped-agama-of-reward-e6baf1@krzk-bin>
In-Reply-To: <20250326-stereotyped-agama-of-reward-e6baf1@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a5387370-dcae-4d50-a410-cdaf40953859;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-26T09:37:39Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|MN0PR12MB6104:EE_
x-ms-office365-filtering-correlation-id: 89ba7ba2-df52-4b1d-8810-08dd6c4beaf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MjN4RTA2RVBEZkZKeVA5blFvKzJmaTVVTm5ybFRXeEd1ZmkrYXd1T1EzMFZ5?=
 =?utf-8?B?UStmcUV2ZndTVWJReEh4cVFnQnlXeEp3d1JUSVJocEVFSU1VL3B2SEZEZUJK?=
 =?utf-8?B?TW52OCtwQjlCMW9WYk1xZm5iQzNjelA1bEhKNzc4bXN6cTJDRWlQNVpWdVdq?=
 =?utf-8?B?aUM5L2NrUEdSZkNSOFNpcjNybk9zYXJEMS9YMnVPb0xpT3ZaY1BKTkJNVVRi?=
 =?utf-8?B?U3RaT0VEV1c0cFR4RGtwT2E5Rk1kVkJOdlFrMXg4N1FKcEY5eWhJS0tYQzFV?=
 =?utf-8?B?TmNIYy95TG5nOWxSUk1wbkhGNXdudkZaeFY3RFdvVnJTV3VSTWp1Q3YxZTBJ?=
 =?utf-8?B?SkVNTzlqRHFUVm9zTHFaSTNuVnpzamhvOUFEZmNWcXBlbGVONkZFWjBraU5N?=
 =?utf-8?B?NnRuaEZ2N3J1NlZLYUFoZXYrWGVCZy9uUDM2WG8vbXhQRHFVQXdaMzdQR3dv?=
 =?utf-8?B?dGxQS1krM2d3d05QOWtQQVRVM0t1bkl1Ti9ockFZemZybjR2RXlMTlI0bFpr?=
 =?utf-8?B?elh1clZ5NlhtSnh5YnBPNlVTRUwyWmZUUEdtN1pYbmhEUmVHWVBiUDQ2WndN?=
 =?utf-8?B?RTZaUXVheUs0R0tkOWM2NEo0R2xndVVGV1N3Sk9vOE1YM01vaTlrTGI2TjJz?=
 =?utf-8?B?NjEyZEZIMnlsS3FkVXpheXF2eGFzaFZtNnZpVDIzSmlJRjdYYjNaRDVDMktZ?=
 =?utf-8?B?SGRsQjNxQjdKUWJQYWZSTGd3UEFzMnE1a3I3VzdxREhlYS9CdGwxZVQ1Nllp?=
 =?utf-8?B?ekE2ZmdjZTdadXZRNnlUejJnKzVrUEhOaVlPNERxWjBnMmMwblA4a3MxaHdV?=
 =?utf-8?B?WWRTM2JBaTBtQlBSSEo2Rmlyc2d4bUQ5SzNHSkF2aUNWY1BWcThNTG5oUVVu?=
 =?utf-8?B?YWNBWVhIa2paZ3VjU3QvTjFOeG9qMDhHbHJxNXFHcmk4a3NvVGlSeVpDTTBq?=
 =?utf-8?B?eTJLOXFISDl0Z2w1bDZaYm9MSUVRUnJYdHBTNEhqck0wTTlBNXkxQjR0dU55?=
 =?utf-8?B?U25HRUdXYnNXbGp6YVdwdUNvRjlBaDZzcmxoQWcvaFd0cXpLamxsb1lFSDdG?=
 =?utf-8?B?WnRJSkJyWlVSeDNKdHB4c1J0ci9xQ3VBcUZtaVJpV2RxVURiQ0RhR3VJcXFX?=
 =?utf-8?B?SC9LRDJpckh6TmpRM3ZFblliOWNSNzVOY2E1U29RQjZVNGpORDZEd0FsdElU?=
 =?utf-8?B?UHo3ajVHRHlOVmRVekRzWkJ2UGpKREo5SDNBN3ZsQlVaaUYxZ3kvVXFUZ3ZB?=
 =?utf-8?B?U25jdlJFODdydTE1SDQxR0Z3Y0xzdzR2OGFUNG1xbk1rWit1bDkzOTdTamNP?=
 =?utf-8?B?bXdCVG1xSXd4NVQxV2dNa2tEWEpqem5FeUI4ODVtTlJteEJFRFQxanVOMU1y?=
 =?utf-8?B?NzYrWitGa0FHZ0pja04rMWRNejJYQThjV1dpRjlueE9KSUZRcVJ5VnNUaG5U?=
 =?utf-8?B?TnAxci9FZGtnR3JHRXVCdDRSRnhUZFNHMWZITTRsYkhvSjFaT3hTb2JEQ2F0?=
 =?utf-8?B?SmEzNWczU3VlWHdoRnlvREJ1QU9FeGk0cEZGSjVwOUl4NXdEQTY1bjFDanRX?=
 =?utf-8?B?ektQRHhjeVFMUjZKYWY5UE1kNXVuSW10cmdpN01KdGR4TlFyRnE2dFRacklj?=
 =?utf-8?B?c0R0Ym1JQm8xZlIwSTJZNE8ya2NEWFRoNStMRHFoZmFlSEw2MGZDdU52dFZO?=
 =?utf-8?B?VHZmS3JzcGZlNGNYODZsUVo1VFJtVERraVBpYU1YNkdGYjc0K2FVclczTDF0?=
 =?utf-8?B?MWJmRjJvNVpyTTdDakovS2ZsOWxhRWNEZU81Zktqa1dwNTBsV205NDZsZzhp?=
 =?utf-8?B?aHZTc0hMYklNaXpacjVOZHVIb3cxZkVEQWtUeDVoODNhQnhPZWs1cUxjL2pu?=
 =?utf-8?B?OUU0VUJRM3E4V3lvQnh6VVRyUEsxdTJzUmRPUWdzTUJFRGNHem4wZnoxZEsr?=
 =?utf-8?Q?h3ZE6V2Bb71/IMnGb6lugjSk3zliP146?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aW9zSm5HaHEydmlQeVM3WHNJMVRlU1puNjA1dWFDVnVqUXljYnFIR1FqQmZ5?=
 =?utf-8?B?QUVITFJGWjlNOW84YW9ib0F1WjlJcnFKR2Z5WGg2NkNjMmhwQUFjUVQ4NDNs?=
 =?utf-8?B?RUlwaXBOTU1ocUcxdmZ4SU5WT290Q3dINEd4YXF0T0dza2VZTDZPVnNvRkJq?=
 =?utf-8?B?NzAwL2xqMDk5U0F2TU90M3gyaG9LRm5qWk9rTTlXZC9tRFRCV2t4QTMrWjVL?=
 =?utf-8?B?QytSc241UnczVHVINXJmdnlxQUxhVXlRdzVwaUp2ZDlrS0xlZklqaitQRjJ1?=
 =?utf-8?B?aDR2MnRPcDFxaWlSQk1FRGNHT1h3RjRjZ25ZNDNVbHJDUTZjbzdCLzhnM3dJ?=
 =?utf-8?B?d0ZDa1AwN2ZCdFArb052NVplRGhlQXNnVnNvWXJYSlRTS2VuTHhQSDBEYnQv?=
 =?utf-8?B?R3VwTksxQWhkb1RHWXJzeG1FRytBMXd0L08vdWJRYzdLbU1LdVVXQmpBeGhx?=
 =?utf-8?B?R0twSDVCY2FDcWFtbjBZc1EvOTRVNGxQbEpIYmNrWHVyVHNMKzFWU2FZcEh4?=
 =?utf-8?B?c05Rb3RYeWF3WHBHOU1sMFlpeXVmVUdaSFIxL2dBZXhOUGFRSmIrYjVLcXgy?=
 =?utf-8?B?UERmR3BOQm9RY0owbzM0SEVVMUFGcDA4T2haVm9QQ3k5NTRVK0RwcVhpM3Vy?=
 =?utf-8?B?SGxRMEgxWTJDSDE1akhTT3lmVFozWXZTdGJFOWl5T2k5UHhFTGxOSWx0SkFJ?=
 =?utf-8?B?SEw0UExuUnJyL21WQmNoeVNzQ2grdWtVeEo5NmpvQ1FkU1FVSFh0MEV1MTZz?=
 =?utf-8?B?NGlDaVd0ajVPVEZuS0kvQXF4UkNtREswekdST2pkMS9OTkJSWHZ4TU9abTNQ?=
 =?utf-8?B?QVlLKy9hK1dib3hialR4Y2YyNHVuSFFjaXkrYk43dzRHeVRLZk95bFB6OFBY?=
 =?utf-8?B?a0VJclUwTXRmR0dNb0pydUZYY1BFVnIzVk5zQlgxdk9STTdrei9SSk55Zmkz?=
 =?utf-8?B?emFLUmVnWGx4eHFpcWwrNG0zWGp1Yko5bEZkZmxlNjI3MzkrVXFhaU81Q2V6?=
 =?utf-8?B?aWtSV0ZCZDBhSTY4eHJXSkFPV0Y2RDlqTDB0VC9TOG5BMWxnUVNXeXJTL0pu?=
 =?utf-8?B?Z01PQmNpNUdqeEpEcllaUE5uekNqZHR4T3FIeWVUY3JZbVB3RUVYb2RjOGlr?=
 =?utf-8?B?dlhnTWtNQTQ3TFZETyszWFpQMU1sdkJlS1NOMHRIcXhpU0xBTXR0Tys3ZzFT?=
 =?utf-8?B?ZnVxc21mTDYycXJ4S0NhUU1QMHl0UHNtV0lxZVZTM0g5c0Z4OEFaQzg5SEIx?=
 =?utf-8?B?WUNTbkwzdkUwQ1hvTFZEc2QyNGtnN3N4N0lUK0hxSmk4R0VNc3p0MEFFd1Fz?=
 =?utf-8?B?USt0UStia1prTFhqVTBUR0ZwWURRNktrR0hpd2x3cFgxUUV5THdsL3BBVVZQ?=
 =?utf-8?B?SHBFTm96WmxaTjdYYTVubVBEb0IzWnFGclg1NENsOFlwR3BxOHFXY0x4d0gy?=
 =?utf-8?B?OCtTVW1GWW10bG0zVUErMXZHbFhQc2p0SGZnV1RqUjJTUm9kYnJFcXJ0UUg2?=
 =?utf-8?B?MUhFZ3R2cHB3MjFJaXRsOGJhR0dzMFlyNzh6Zlp6KzRQZ3RZUFRIWlQwZmND?=
 =?utf-8?B?STRNYkZld1Vkd1dEWXp2R3RJVFRtbnlFR3VoN3JzQkJ6WVBmWWZsTXF0TTFJ?=
 =?utf-8?B?L2tyb3FFQ0s2cGM3aEhPK2kzemh4UHVkby9lRVhTNXJ3ZzcrWDRldjg3Qmd3?=
 =?utf-8?B?c09JR2J0ZXpuOUNJclRwMnBXVXJHQlJNQmhSSCtRcE1SN05XT0EzSHRsNFpz?=
 =?utf-8?B?QmpYQnNoTUpoNUxkT3V4WkpScjdta0RaZ3BMdnpUd0JEQjdXdXk4MWJvd3FR?=
 =?utf-8?B?N21MSklZdm54UmUrRlg5ZjJRdVBLNGxLSnNkdlU1SVpaVDdURStwRjB1K2FE?=
 =?utf-8?B?Ujc1UlBnUHJpK2JMQTM3eFZ3ZHY5Y1FCT3lqalluN0xDUkRTUURHdnpPRjNB?=
 =?utf-8?B?NnFCSURiVTJjN01NYXBZZXVmZGFhNE9XNGNWVDNJU1FzVElCYlhoRFlHRXdL?=
 =?utf-8?B?SldNakdhRkxDVlhlWktSNUQ5Um5DMEV5bm04NmFWeVNmWDZnaE5RZVR0ZVhC?=
 =?utf-8?B?ODhhOUoyRi9WMExReWZLVDdUT0xQUmh3bWZxTGhsT3F1YXhZWWlJZW1PbkdL?=
 =?utf-8?Q?fysw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ba7ba2-df52-4b1d-8810-08dd6c4beaf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 09:52:27.6013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3E8G8rCYE6GEo/pcbJWQQr/yes2TQ3uJ3fR1fdVeYHpmOUcJt7et2NfJwXSqEThBYTS7TZklUEWgPoTbhr55w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5
LCBNYXJjaCAyNiwgMjAyNSAxOjE2IFBNDQo+IFRvOiBNdXNoYW0sIFNhaSBLcmlzaG5hIDxzYWku
a3Jpc2huYS5tdXNoYW1AYW1kLmNvbT4NCj4gQ2M6IGJoZWxnYWFzQGdvb2dsZS5jb207IGxwaWVy
YWxpc2lAa2VybmVsLm9yZzsga3dAbGludXguY29tOw0KPiBtYW5pdmFubmFuLnNhZGhhc2l2YW1A
bGluYXJvLm9yZzsgcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9y
K2R0QGtlcm5lbC5vcmc7IGNhc3NlbEBrZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgU2ltZWssIE1pY2hhbA0KPiA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBHb2dhZGEs
IEJoYXJhdCBLdW1hcg0KPiA8YmhhcmF0Lmt1bWFyLmdvZ2FkYUBhbWQuY29tPjsgSGF2YWxpZ2Us
IFRoaXBwZXN3YW15DQo+IDx0aGlwcGVzd2FteS5oYXZhbGlnZUBhbWQuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY2IDEvMl0gZHQtYmluZGluZ3M6IFBDSTogeGlsaW54LWNwbTogQWRkIHJl
c2V0LWdwaW9zIGZvciBQQ0llDQo+IFJQIFBFUlNUIw0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3Nh
Z2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9u
DQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRp
bmcuDQo+DQo+DQo+IE9uIFdlZCwgTWFyIDI2LCAyMDI1IGF0IDA3OjU4OjEwQU0gKzA1MzAsIFNh
aSBLcmlzaG5hIE11c2hhbSB3cm90ZToNCj4gPiBJbnRyb2R1Y2UgYHJlc2V0LWdwaW9zYCBwcm9w
ZXJ0eSB0byBlbmFibGUgR1BJTy1iYXNlZCBjb250cm9sIG9mIHRoZQ0KPiA+IFBDSWUgUlAgUEVS
U1QjIHNpZ25hbCwgZ2VuZXJhdGluZyBhc3NlcnQgYW5kIGRlYXNzZXJ0IHNpZ25hbHMuDQo+DQo+
IEkgdGhpbmsgaXQgd2FzIHJlbW92ZWQsIHNvIHRoaXMgaXMgbm90IG5lY2Vzc2FyeS4gVGhlIHBy
b3BlcnR5IHdhcyB0aGVyZSBhbGwgdGhlIHRpbWUuDQpUaGFuayB5b3UgZm9yIHJldmlld2luZywg
SSB3aWxsIHVwZGF0ZSB0aGlzIGluIG5leHQgcGF0Y2guDQo+DQo+ID4NCj4gPiBUcmFkaXRpb25h
bGx5LCB0aGUgcmVzZXQgd2FzIG1hbmFnZWQgaW4gaGFyZHdhcmUgYW5kIGVuYWJsZWQgZHVyaW5n
DQo+ID4gaW5pdGlhbGl6YXRpb24uIFdpdGggdGhpcyBwYXRjaCBzZXQsIHRoZSByZXNldCB3aWxs
IGJlIGhhbmRsZWQgYnkgdGhlDQo+ID4gZHJpdmVyLiBDb25zZXF1ZW50bHksIHRoZSBgcmVzZXQt
Z3Bpb3NgIHByb3BlcnR5IG11c3QgYmUgZXhwbGljaXRseQ0KPiA+IHByb3ZpZGVkIHRvIGVuc3Vy
ZSBwcm9wZXIgZnVuY3Rpb25hbGl0eS4NCj4gPg0KPiA+IEFkZCBDUE0gY2xvY2sgYW5kIHJlc2V0
IGNvbnRyb2wgcmVnaXN0ZXJzIGJhc2UgKGBjcG1fY3J4YCkgdG8gaGFuZGxlDQo+ID4gUENJZSBJ
UCByZXNldCBhbG9uZyB3aXRoIFBDSWUgUlAgUEVSU1QjIHRvIGF2b2lkIExpbmsgVHJhaW5pbmcg
ZXJyb3JzLg0KPg0KPiBTbyBkb2VzIGl0IG1lYW4gaXQgd2FzIG5vdCB3b3JraW5nIGJlZm9yZSBh
dCBhbGw/DQpUaGFuayB5b3UgZm9yIHJldmlld2luZywgaXQgd2FzIHdvcmtpbmcgZWFybGllciBh
bHNvLiBDdXJyZW50bHkgYm9hcmRzIGFyZSBkZXNpZ25lZCB0byBoYW5kbGUNClBFUlNUIyBhbmQg
SVAgcmVzZXQgZnJvbSBzb2Z0d2FyZSBkcml2ZXIsIGFuZCBJUCByZXNldCBpcyBiZWluZyByZW1v
dmVkIGZyb20gZGVzaWduLg0KSSB3aWxsIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2UgaW4gbmV4
dCBwYXRjaC4NCj4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNhaSBLcmlzaG5hIE11c2hhbSA8
c2FpLmtyaXNobmEubXVzaGFtQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBmb3IgdjY6
DQo+ID4gLSBSZXNvbHZlIEFCSSBicmVhay4NCj4gPiAtIFVwZGF0ZSBjb21taXQgbWVzc2FnZS4N
Cj4gPg0KPiA+IENoYW5nZXMgZm9yIHY1Og0KPiA+IC0gUmVtb3ZlIGByZXNldC1ncGlvc2AgcHJv
cGVydHkgZnJvbSByZXF1aXJlZCBhcyBpdCBpcyBhbHJlYWR5IHByZXNlbnQNCj4gPiAgIGluIHBj
aS1idXMtY29tbW9uLnlhbWwNCj4gPiAtIFVwZGF0ZSBjb21taXQgbWVzc2FnZQ0KPiA+DQo+ID4g
Q2hhbmdlcyBmb3IgdjQ6DQo+ID4gLSBBZGQgQ1BNIGNsb2NrIGFuZCByZXNldCBjb250cm9sIHJl
Z2lzdGVycyBiYXNlIHRvIGhhbmRsZSBQQ0llIElQDQo+ID4gICByZXNldC4NCj4gPiAtIFVwZGF0
ZSBjb21taXQgbWVzc2FnZS4NCj4gPg0KPiA+IENoYW5nZXMgZm9yIHYzOg0KPiA+IC0gTm9uZQ0K
PiA+DQo+ID4gQ2hhbmdlcyBmb3IgdjI6DQo+ID4gLSBBZGQgZGVmaW5lIGZyb20gaW5jbHVkZS9k
dC1iaW5kaW5ncy9ncGlvL2dwaW8uaCBmb3IgUEVSU1QjIHBvbGFyaXR5DQo+ID4gLSBVcGRhdGUg
Y29tbWl0IG1lc3NhZ2UNCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3BjaS94aWxpbngtdmVy
c2FsLWNwbS55YW1sICAgICAgIHwgNzIgKysrKysrKysrKysrKystLS0tLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3hpbGlu
eC12ZXJzYWwtY3BtLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9wY2kveGlsaW54LXZlcnNhbC1jcG0ueWFtbA0KPiA+IGluZGV4IGQ2NzRhMjRjOGNjYy4uMjZl
OWNlYTQxODg5IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kveGlsaW54LXZlcnNhbC1jcG0ueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kveGlsaW54LXZlcnNhbC1jcG0ueWFtbA0KPiA+IEBAIC05
LDkgKzksNiBAQCB0aXRsZTogQ1BNIEhvc3QgQ29udHJvbGxlciBkZXZpY2UgdHJlZSBmb3IgWGls
aW54DQo+ID4gVmVyc2FsIFNvQ3MNCj4gPiAgbWFpbnRhaW5lcnM6DQo+ID4gICAgLSBCaGFyYXQg
S3VtYXIgR29nYWRhIDxiaGFyYXQua3VtYXIuZ29nYWRhQGFtZC5jb20+DQo+ID4NCj4gPiAtYWxs
T2Y6DQo+ID4gLSAgLSAkcmVmOiAvc2NoZW1hcy9wY2kvcGNpLWhvc3QtYnJpZGdlLnlhbWwjDQo+
ID4gLQ0KPiA+ICBwcm9wZXJ0aWVzOg0KPiA+ICAgIGNvbXBhdGlibGU6DQo+ID4gICAgICBlbnVt
Og0KPiA+IEBAIC0yMSwxOCArMTgsMTIgQEAgcHJvcGVydGllczoNCj4gPiAgICAgICAgLSB4bG54
LHZlcnNhbC1jcG01bmMtaG9zdA0KPiA+DQo+ID4gICAgcmVnOg0KPiA+IC0gICAgaXRlbXM6DQo+
ID4gLSAgICAgIC0gZGVzY3JpcHRpb246IENQTSBzeXN0ZW0gbGV2ZWwgY29udHJvbCBhbmQgc3Rh
dHVzIHJlZ2lzdGVycy4NCj4gPiAtICAgICAgLSBkZXNjcmlwdGlvbjogQ29uZmlndXJhdGlvbiBz
cGFjZSByZWdpb24gYW5kIGJyaWRnZSByZWdpc3RlcnMuDQo+ID4gLSAgICAgIC0gZGVzY3JpcHRp
b246IENQTTUgY29udHJvbCBhbmQgc3RhdHVzIHJlZ2lzdGVycy4NCj4gPiAtICAgIG1pbkl0ZW1z
OiAyDQo+ID4gKyAgICBtaW5JdGVtczogMw0KPg0KPiBUaGF0J3MgYW4gQUJJIGJyZWFrLg0KVGhh
bmtzIGZvciByZXZpZXdpbmcsIEkgd2lsbCB1cGRhdGUgbWluSXRlbXMgdG8gMiwgc28gaXQgd2ls
bCBub3QgYmUgYW4gQUJJIGJyZWFrLg0KPg0KPiA+ICsgICAgbWF4SXRlbXM6IDQNCj4gPg0KPiA+
ICAgIHJlZy1uYW1lczoNCj4gPiAtICAgIGl0ZW1zOg0KPiA+IC0gICAgICAtIGNvbnN0OiBjcG1f
c2xjcg0KPiA+IC0gICAgICAtIGNvbnN0OiBjZmcNCj4gPiAtICAgICAgLSBjb25zdDogY3BtX2Nz
cg0KPiA+IC0gICAgbWluSXRlbXM6IDINCj4gPiArICAgIG1pbkl0ZW1zOiAzDQo+ID4gKyAgICBt
YXhJdGVtczogNA0KPiA+DQo+ID4gICAgaW50ZXJydXB0czoNCj4gPiAgICAgIG1heEl0ZW1zOiAx
DQo+ID4gQEAgLTcyLDEwICs2Myw1MyBAQCByZXF1aXJlZDoNCj4gPiAgICAtIG1zaS1tYXANCj4g
PiAgICAtIGludGVycnVwdC1jb250cm9sbGVyDQo+ID4NCj4gPiArYWxsT2Y6DQo+ID4gKyAgLSAk
cmVmOiAvc2NoZW1hcy9wY2kvcGNpLWhvc3QtYnJpZGdlLnlhbWwjDQo+ID4gKyAgLSBpZjoNCj4g
PiArICAgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAg
ICAgICAgY29udGFpbnM6DQo+ID4gKyAgICAgICAgICAgIGVudW06DQo+ID4gKyAgICAgICAgICAg
ICAgLSB4bG54LHZlcnNhbC1jcG0taG9zdC0xLjAwDQo+ID4gKyAgICB0aGVuOg0KPiA+ICsgICAg
ICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIHJlZzoNCj4gPiArICAgICAgICAgIGl0ZW1zOg0K
PiA+ICsgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBDUE0gc3lzdGVtIGxldmVsIGNvbnRyb2wg
YW5kIHN0YXR1cyByZWdpc3RlcnMuDQo+ID4gKyAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IENv
bmZpZ3VyYXRpb24gc3BhY2UgcmVnaW9uIGFuZCBicmlkZ2UgcmVnaXN0ZXJzLg0KPiA+ICsgICAg
ICAgICAgICAtIGRlc2NyaXB0aW9uOiBDUE0gY2xvY2sgYW5kIHJlc2V0IGNvbnRyb2wgcmVnaXN0
ZXJzLg0KPg0KPiBCZWZvcmUgdHdvIGl0ZW1zLCBub3cgbWluIDMsIHNvIGFub3RoZXIgQUJJIGJy
ZWFrLiBNaXNzaW5nIG1pbkl0ZW1zLg0KVGhhbmtzIGZvciByZXZpZXdpbmcsIEkgd2lsbCB1cGRh
dGUgbWluSXRlbXMgdG8gMiwgc28gaXQgd2lsbCBub3QgYmUgYW4gQUJJIGJyZWFrLg0KPg0KPiA+
ICsgICAgICAgIHJlZy1uYW1lczoNCj4gPiArICAgICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAg
ICAgICAtIGNvbnN0OiBjcG1fc2xjcg0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiBjZmcNCj4g
PiArICAgICAgICAgICAgLSBjb25zdDogY3BtX2NyeA0KPg0KPiBTYW1lDQpUaGFua3MgZm9yIHJl
dmlld2luZywgSSB3aWxsIHVwZGF0ZSBtaW5JdGVtcyB0byAyLCBzbyBpdCB3aWxsIG5vdCBiZSBh
biBBQkkgYnJlYWsuDQo+DQo+ID4gKyAgLSBpZjoNCj4gPiArICAgICAgcHJvcGVydGllczoNCj4g
PiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAgICAgICAgY29udGFpbnM6DQo+ID4gKyAg
ICAgICAgICAgIGVudW06DQo+ID4gKyAgICAgICAgICAgICAgLSB4bG54LHZlcnNhbC1jcG01LWhv
c3QNCj4gPiArICAgICAgICAgICAgICAtIHhsbngsdmVyc2FsLWNwbTUtaG9zdDENCj4gPiArICAg
IHRoZW46DQo+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgcmVnOg0KPiA+ICsg
ICAgICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IENQTSBzeXN0
ZW0gbGV2ZWwgY29udHJvbCBhbmQgc3RhdHVzIHJlZ2lzdGVycy4NCj4gPiArICAgICAgICAgICAg
LSBkZXNjcmlwdGlvbjogQ29uZmlndXJhdGlvbiBzcGFjZSByZWdpb24gYW5kIGJyaWRnZSByZWdp
c3RlcnMuDQo+ID4gKyAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IENQTTUgY29udHJvbCBhbmQg
c3RhdHVzIHJlZ2lzdGVycy4NCj4gPiArICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogQ1BNIGNs
b2NrIGFuZCByZXNldCBjb250cm9sIHJlZ2lzdGVycy4NCj4NCj4gVGhpcyBtYWtlcyBubyBzZW5z
ZSwgeW91IHN0aWxsIGFkZCB0aGUgZW50cnkgaW4gdGhlIG1pZGRsZS4gVGhpcyBwYXRjaCBmaXhl
ZCBub3RoaW5nDQo+IGZyb20gaXNzdWVzIHByZXZpb3VzbHkgcG9pbnRlZCBvdXQuDQo+DQo+IEl0
J3MgdGhlIHRoaXJkIG9yIGZvdXJ0aCB0cnkgYW5kIHlvdSBrZWVwIHJlcGVhdGluZyB0aGUgc2Ft
ZSBtaXN0YWtlLCB3aGljaCBtZWFucw0KPiB5b3UgZG8gbm90IHVuZGVyc3RhbmQgdGhlIHByb2Js
ZW0uIFRoZSBwcm9ibGVtIGlzOiB5b3UgY2Fubm90IGNoYW5nZSB0aGUgb3JkZXIuIElmDQo+IHlv
dSBjaGFuZ2UgaXQsIGl0J3MgYW4gQUJJIGJyZWFrIGFuZCBub3RoaW5nIGluIGNvbW1pdCBtc2cg
ZXhwbGFpbmVkIHRoYXQuDQpUaGFua3MgZm9yIHJldmlld2luZywgSSB3aWxsIHVwZGF0ZSBtaW5J
dGVtcyB0byAzLCBzbyBpdCB3aWxsIG5vdCBiZSBhbiBBQkkgYnJlYWsuDQpBbmQgY3VycmVudGx5
IGluIHRoaXMgcGF0Y2ggSSBoYXZlIGEgY3BtX2NyeCBwcm9wZXJ0eSBhdCB0aGUgZW5kLg0KVGhp
cyBpcyB0aGUgZGVzY3JpcHRpb24gZm9yIGNwbV9jcnguDQogICAgICAgICAgICAtIGRlc2NyaXB0
aW9uOiBDUE0gY2xvY2sgYW5kIHJlc2V0IGNvbnRyb2wgcmVnaXN0ZXJzLg0KDQpCZWxvdyBpcyB0
aGUgdXBkYXRlZCB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2guIFBsZWFzZSBsZXQgbWUga25vdyBpZiB5
b3UgaGF2ZSBhbnkgZnVydGhlciBjb21tZW50cy4NCiAgICAgICAtIHhsbngsdmVyc2FsLWNwbTVu
Yy1ob3N0DQoNCiAgIHJlZzoNCi0gICAgbWluSXRlbXM6IDMNCisgICAgbWluSXRlbXM6IDINCiAg
ICAgbWF4SXRlbXM6IDQNCg0KICAgcmVnLW5hbWVzOg0KLSAgICBtaW5JdGVtczogMw0KKyAgICBt
aW5JdGVtczogMg0KICAgICBtYXhJdGVtczogNA0KDQogICBpbnRlcnJ1cHRzOg0KQEAgLTc4LDEx
ICs3OCwxMyBAQCBhbGxPZjoNCiAgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBDUE0gc3lzdGVt
IGxldmVsIGNvbnRyb2wgYW5kIHN0YXR1cyByZWdpc3RlcnMuDQogICAgICAgICAgICAgLSBkZXNj
cmlwdGlvbjogQ29uZmlndXJhdGlvbiBzcGFjZSByZWdpb24gYW5kIGJyaWRnZSByZWdpc3RlcnMu
DQogICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogQ1BNIGNsb2NrIGFuZCByZXNldCBjb250cm9s
IHJlZ2lzdGVycy4NCisgICAgICAgICAgbWluSXRlbXM6IDINCiAgICAgICAgIHJlZy1uYW1lczoN
CiAgICAgICAgICAgaXRlbXM6DQogICAgICAgICAgICAgLSBjb25zdDogY3BtX3NsY3INCiAgICAg
ICAgICAgICAtIGNvbnN0OiBjZmcNCiAgICAgICAgICAgICAtIGNvbnN0OiBjcG1fY3J4DQorICAg
ICAgICAgIG1pbkl0ZW1zOiAyDQogICAtIGlmOg0KICAgICAgIHByb3BlcnRpZXM6DQogICAgICAg
ICBjb21wYXRpYmxlOg0KQEAgLTk4LDEyICsxMDAsMTQgQEAgYWxsT2Y6DQogICAgICAgICAgICAg
LSBkZXNjcmlwdGlvbjogQ29uZmlndXJhdGlvbiBzcGFjZSByZWdpb24gYW5kIGJyaWRnZSByZWdp
c3RlcnMuDQogICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogQ1BNNSBjb250cm9sIGFuZCBzdGF0
dXMgcmVnaXN0ZXJzLg0KICAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IENQTSBjbG9jayBhbmQg
cmVzZXQgY29udHJvbCByZWdpc3RlcnMuDQorICAgICAgICAgIG1pbkl0ZW1zOiAzDQogICAgICAg
ICByZWctbmFtZXM6DQogICAgICAgICAgIGl0ZW1zOg0KICAgICAgICAgICAgIC0gY29uc3Q6IGNw
bV9zbGNyDQogICAgICAgICAgICAgLSBjb25zdDogY2ZnDQogICAgICAgICAgICAgLSBjb25zdDog
Y3BtX2Nzcg0KICAgICAgICAgICAgIC0gY29uc3Q6IGNwbV9jcngNCisgICAgICAgICAgbWluSXRl
bXM6IDMNCg0KIHVuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4NCj4gQmVzdCByZWdhcmRz
LA0KPiBLcnp5c3p0b2YNCg0KUmVnYXJkcywNClNhaSBLcmlzaG5hDQoNCg==

