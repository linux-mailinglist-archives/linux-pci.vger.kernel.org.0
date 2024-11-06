Return-Path: <linux-pci+bounces-16101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C1E9BDFA3
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 08:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E163285120
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 07:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CCB1CC8A3;
	Wed,  6 Nov 2024 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="i7eSp9A7";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dWoDwaAL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47641190470;
	Wed,  6 Nov 2024 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878997; cv=fail; b=DUDbTUJwYbwXROoxguTxX29Zaofwxc029fmYYU8XK8wTJPf6lA4E2qtryjPA7t2ZIHGhBITiqIuniWYmS2mQ8lX0/u9qhQsQwMzQi4FQJh1ToAjilXRnD95s62k/RfoPu0Efk2gcV20P76/rBr0FVM2Tz/Nz8ugGtBam2pChPD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878997; c=relaxed/simple;
	bh=B11shqUYyRaRpOHPMZff1z0ISQDbUK+Hj0NAjdZCLYM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wben1/zLI/RQjMxHUhDfeUuXS6e2kjFWI3zix14BvSf6X2fApoePTfMW4N7CFmx2fZLTOTW0/uyPcfHHR+2h9H5PzCmai16ucQM2ZFY5i4cOpPY7YK3WoeReDsKXqwdaRpMe3Oc62bPFIE/JGzhdQXhatEqIurePF7Pel1gXNWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=i7eSp9A7; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dWoDwaAL; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c424f93c9c1211efbd192953cf12861f-20241106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=B11shqUYyRaRpOHPMZff1z0ISQDbUK+Hj0NAjdZCLYM=;
	b=i7eSp9A7cC/hOptqkKAKdIhfodM9reZuzR3wr2RuI7Hd8FvajG08ZMnR6PW3ZUpXKd2jzC+tWEDGfxgesn7M0OIhD2a5wLhWRazYMTbQPf1ZJQi8usd4YMvPqWAL3Nx6rLpI4q5qP5LYJB9fWCUqXwoWvYE0og/bp6pPjZDviwU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:44f7b8c7-438c-4016-9fd7-7cd99f2d4a08,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:608a7d22-a4fe-4046-b5be-d3379e31a9ef,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c424f93c9c1211efbd192953cf12861f-20241106
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 81851667; Wed, 06 Nov 2024 15:43:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Nov 2024 15:43:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 6 Nov 2024 15:43:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrXKs2JXRluozukYS6q23HHBlk+4GaL2p6wyZJvw3S4GEaRJcxxReBBcmxS0uPy+/aQdGZ+ebWSD9g157yWrdMSl/jf2BOA5xuCNgFX3/bQEaUBzWP7q7s9FmbpSETnZps7lYySYjQflN6kM2GO+swYa+wf9neoH/YUzwUQk9gbVEVMi//SJpsCsF+RHn/oqsKQ5F1xqpHBUQOe/5FenvtdkAgVk5gWwoz1cdTth9AcEIVFv9ceYLhcpdXuhv38RsLjC5dNtC6XZ+FuPIZceuryAMkvypiCaEKBEaZDkNxWbTORHqSF7UpK0R8VHDtqvu1y2cK1l7epUXM3jSPckuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B11shqUYyRaRpOHPMZff1z0ISQDbUK+Hj0NAjdZCLYM=;
 b=IuRkmrJdGWrlQZNIOMdt5DlVh7mbtc010O/KUxT5Jnq1tDV77lZdmdx/uNUMwv57WKnDmaixipWmJ59ubq6+6hLuH9cpYkvtiBDaEk/hPy5LxhPr6ZlJCsxHdTE880sHaCr+Nr7TpgReKg6A9Vth/PK1xE40/HqkcW6wkUVQNCw2Sv4zcnkOI7YEbMqaynLy9z6ztrTkeYjLUn7Q9pHdVqRPJWWO8z2o9TADOdn7nQIlLRovxK7s+DS4vO4bb0Edi4xQEsIV3w8ikR9M1Y3HHBF5tGuqFDyj94WDj7VdLaIYt4TzM9tPUf0T1KqhQx57diny6wzuWPyoYG5Y6ut0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B11shqUYyRaRpOHPMZff1z0ISQDbUK+Hj0NAjdZCLYM=;
 b=dWoDwaAL3n/er2gyqRMIxc88vzCI9wOKsvpjoP4Rs3V2Ei2B+Hik8tqM2w6x1KJZgW09aLXSbvZzkuhKB93mjCF3+ieVvHK5qrWlrc/HWguesPCiJ6H0pzvebkCRmNdd/AA15DmaGNDsglzp3BukcQ1XirlqLFm3ugd41S6jT18=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by SEZPR03MB8273.apcprd03.prod.outlook.com (2603:1096:101:19a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 07:43:03 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%4]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 07:43:03 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@collabora.com" <kernel@collabora.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	Ryder Lee <Ryder.Lee@mediatek.com>, "fshao@chromium.org"
	<fshao@chromium.org>, "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v4 2/2] PCI: mediatek-gen3: Add support for restricting
 link width
Thread-Topic: [PATCH v4 2/2] PCI: mediatek-gen3: Add support for restricting
 link width
Thread-Index: AQHbLq/LIuLgeuph2U6TRy8ZZ39u3rKpd+sAgABpuQA=
Date: Wed, 6 Nov 2024 07:43:03 +0000
Message-ID: <7bf0dfaae19d604dbc8f1bef3a65d36474f851cd.camel@mediatek.com>
References: <20241106012438.GA1499437@bhelgaas>
In-Reply-To: <20241106012438.GA1499437@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|SEZPR03MB8273:EE_
x-ms-office365-filtering-correlation-id: 9a5431a3-54fc-466b-5e8a-08dcfe36a531
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aEc0T3F6dWlPd1NpQk5pbTd5bDI2WkYwVmxnSUNwKzVzSmxveDh5dVg2N3V1?=
 =?utf-8?B?OTgrc2UvMTgvc0FRT2I3M1hMRWhzQUtvRmpDVVN3ck9RclYycHB5ektSdzRC?=
 =?utf-8?B?L2FBZ0NtaHMzUW0zdWczR3BNNFZZR211M0YvQnJOMkZIZHozV3grR0wxMno4?=
 =?utf-8?B?UXdSV2QyR093ZG1jaExySXFLRkV0bjJPK3p6YXRzVHBkbU1QRERKTEx1Qyt4?=
 =?utf-8?B?K2w4Y0JkR2NRcEVGZ2JSVHg1eWhockFIbXhPTHg2c2dMNUVjdk9CT29zaE1q?=
 =?utf-8?B?b2tTanFZT2xCSWhIdDFMWk5mODdIQ3I0S1hZMHdLSVc4ZnhJZUQybmRWWmZl?=
 =?utf-8?B?MDJkcDUzS0xySFpmUXo3dGJsK3Jja0o3ZFZaWG1meFdQK3F5Vm9EdDZWZ2Q2?=
 =?utf-8?B?U1dHcFhycWJFK01TZkVTdmppVlBUMXA3MzQ2NzVJajJwb1VibFlsakZQL3N6?=
 =?utf-8?B?OTZZY250eXlTYkdEWHB0S3hqZ1RMSFZXa1lVRlVFSWFuMzZUR3c0aG9KTENi?=
 =?utf-8?B?VXVQYldWWnByTE5lYVRJNi9qQk54U3habXY2bjIzSEdBMUFXUWdwZUxaU0tP?=
 =?utf-8?B?V2pYZHdLV0l4NEp0WGdXQzFUTTJHMFR0cE1YU0NBMWZxaEZKUzFrbUc0ckFT?=
 =?utf-8?B?Qzh4V1g2d0VLOW9VRjk0NlJ2VGhQNVdPb0FWQ3JDb3N4aGIyUXRaZ2xDQ2dV?=
 =?utf-8?B?Z2VURTd0TDRYMTBaT21sczB0MHRGZERTRldiakZVUU8vSit0S3VVRUszTkpn?=
 =?utf-8?B?U2xGandxUUo4YW5Wd0Y1c3hCaTRYZVU4QWs4U1ZEZG9MbXRrcU53OENFSjdS?=
 =?utf-8?B?VUVWR05ZaDZHQndCSDMrSTdldHRpQ0JGdEpDU0UyUk43aFhUZ0hObVZJOUl6?=
 =?utf-8?B?bEtxQkU2QUZSeFJlQVJ3SWJNcTFXTHZLMDgzMU1mdzJNTlhvM0JqbkRQU05h?=
 =?utf-8?B?eGdOS0dUd0lqdVJyVHJpR3ZncloyNzVpR2xRUm0vRllKcUNrRWxxelpEQ1pH?=
 =?utf-8?B?MzN5V0IvYWhpOHBpdHRuby9TQ1U4Y1U1UWZXcU4vbEovVUFXVzZIdGlzRG5j?=
 =?utf-8?B?VUhRVlFIMHBXUW4yNmJVNzRVdGhRZmJrNzJZUUlneGVlVmxVdnlGc3MvQWNR?=
 =?utf-8?B?NmJ6cm1XaEVjRWJsMXA3cEIzbUdUN1BuVTcyeGFsRWlTeHpnZXlxbTF1Zms1?=
 =?utf-8?B?QkZBR1IvelBRVWtON2xZZkhIS1RBY1BINU13bWZLeWcvVCtDTWhSY1NuZk1D?=
 =?utf-8?B?Zi93dFBZU2dKNWVPVFhkOVc1MXQyZTdoZW8yOW9OSVZHZmlSc1R0SU83dThK?=
 =?utf-8?B?ZENjbW5jcEdxLzZsWDZDdzhvQSt2azhPQlU0UlhvZlhTeTB4Yy9wS1A2WUpj?=
 =?utf-8?B?eWNCOHR0ckk3UEpXdEZacWhvWmpyQ0FveUtTdFhrN0RkSmh5Tm8zb0k3UzE0?=
 =?utf-8?B?ajdpTHJWNGZ1VWkzTEhldzM0M1ArY3VzVlRNeVFCdTExNmdTcml5NUN5Mlpr?=
 =?utf-8?B?YktUVHl1TVJwRVZrYjRGQytDK2hCRVNqT1REU1Z2anh0cXZuZVlUbG1BNmUw?=
 =?utf-8?B?WWhDc3A1OXJTSXZhaXdwUXV3SS9kaEY1ZHNINnVIb1BsZDdsZEJoalpXNTRr?=
 =?utf-8?B?NFVhN2lTYlRxK1hjN2Q3bER3cURSRGtPVGVrWHlqV0FPWENMU0hkTUE3S04v?=
 =?utf-8?B?ZFZ6eU51U1pjaGtFSlB2cEIrTDVUYzNMK1FyeXRua0dJNkZXTk4xSFU5U0lz?=
 =?utf-8?B?RXRvdTRONE1yWS9sVTRBWnhzVHF6RWlIb09iY1dvQU5uZ0NZa1BlU2RWVnZs?=
 =?utf-8?Q?t2lDvDugTubQfRiVfoPD6cYZXLNlyLeaN35CE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVdBSUozR0pqWjBObS82ckhEZVM0dm16a1dLN3l1N3MvN1JhUDJVYitLb21t?=
 =?utf-8?B?a2c5Z2FMSGJxdnlzSlZLRzJvZE1HenRWY2FneERZWkVETU95Q0RVZTdRTFYz?=
 =?utf-8?B?aTFjR2RNTWpnRXN0TklLMWpIRDBjdVZXdEdkOXZkNU0wZCtSVmhkV013eUJs?=
 =?utf-8?B?ajcrcjNSSzVCaWZnbnVSRmlENG9xdEVCZFFiWERRUlBpRXlqVGU1Q0hBeFBQ?=
 =?utf-8?B?QTlKZDRDcnc2QnMvM1ZoU04xS25DS05YYkRrMWpOdHFjdjRYUUY0dVF3T3BQ?=
 =?utf-8?B?VlBGN3A4OWlLSnFFYll3SkZRa1FnU2ZPRElhdEVFSXNGOUdwd2htTnJoRVF6?=
 =?utf-8?B?MFRaOXFwZmx5Z2htSkJ3eGpnUkMvNGtXeVR3MXVsZW5CUU5oRjc3UHF2UHps?=
 =?utf-8?B?anB1ZUgzVitZcXN1bEg2ZklNeWtaRjZIaVkzRHJCd2R0bk0rNTJyT1JmYWk2?=
 =?utf-8?B?eDdJWUdxZk5kYjg0QXFtODZOMUlMbjVhUzdWS3NuaS9PWk5kT2ZxbXhqMzFG?=
 =?utf-8?B?dldrOFh4Nitla3VVWmgvb3psbmkxSXAvMGF1NlE2akZNS0J1WkpJT1g3SnRZ?=
 =?utf-8?B?NUpOS1lMY0JHTXoxQllUL0EvMldTWVh1UysrUDBVT3FOQkNYRDhRVWxQK1hC?=
 =?utf-8?B?ckx3TEpUL0NwK25XNmxHQ0JzVitJSTBNdVIvQTY0YVB2QVdYYy9lckljOGk4?=
 =?utf-8?B?QXhzcGRCaU1UN01YZUFPeGh4YjhlQnVmRDUyMGNxeHY4ZE5Cc0cyTCswWVU0?=
 =?utf-8?B?TmJjYy9CMDZLeklxOHRJLzArQXUvN05tcmxnc1pBcW0vTWVBa0NzcW9oS085?=
 =?utf-8?B?NHVXbFA5Z1MxR0RpNmpXK3UrS2YxeUNZN2YyK1hKQnJ0cjRETE4yQU9Ka2dM?=
 =?utf-8?B?MWp4RVRYOW9wcG4xdWZyTWpoSzNDSmkyMnJiZnR2bTRwbVlVd2VxRFlEcGll?=
 =?utf-8?B?WGNzejhmenBLZkVmRHVMWG5CR1c4S2VYSUpSWEVSbXJSWityYTlBeDd1L1FL?=
 =?utf-8?B?c1h6a201cEozN2oxWGtnUWdPOWJkcEZnbm9PU2o2L0xPMTNYZk1WaVpaNUxG?=
 =?utf-8?B?OGoxU0hMK3o5alVLZDcrNDBNSDZoczhFRU9ZRjBwOFZnZzlTalQvVFpGUTZ5?=
 =?utf-8?B?MkFoK2NIdVBNMHBTTUN1THZBQWR5NUR3ekVncWhKckdnd1cxYmM4cklCZTFB?=
 =?utf-8?B?UmN1WnBid1hDZkZFdVU3SEh5c1o5VUdTSzJwMXhiMytNY0VtTWZWSk9iTnl1?=
 =?utf-8?B?RlpOREtrSG5tc0VuWkp1elNtS1IxcWU0T1NySmFiVGhQdEIzTitVbzVVN3hC?=
 =?utf-8?B?TUxDMmFXSW1CVGVFZ21rVXAvbmw5QWoyN0QxSzdvU0lYblRISnBNT3lXR256?=
 =?utf-8?B?WmhpMVRhL3A5bUNuSkVuWitrTldFRTY2Qy9jUHliOU1mclp5NkJIRnBNbTlj?=
 =?utf-8?B?d05zS3oxS0FvbXNtNEx3L1YzQVUrMytta3dTeDBKdTVaS2lYd0dubjVra3ZT?=
 =?utf-8?B?cjdYcUVGdHA2YmJpcG04SU5FU0cyN21VOS9ROUpYT1FBVCtrb0xUMGloWDdG?=
 =?utf-8?B?MXZkaHkrY0duM2p3cXhiZGlQd3U1MWFUMTBhVGc5YWJtRmxtNmdZR3dZRm82?=
 =?utf-8?B?dG54MVJYbUxMQkhoL0lkYkVNWkN0dTQyRGhyb2VjbWllVWFoY1lvMUJMUDl5?=
 =?utf-8?B?dHlyTXpKWGgyKzc0YS9rSUhBNjVRMERNR2c2OXFsd1FqalFGdVB0QzZGMldk?=
 =?utf-8?B?T1JuYzJyTnhwd3dPSEh3dmZrT0FGK25naFN2aUFPdGNLRmxkeU1zWi95Y1pH?=
 =?utf-8?B?bnhnejljU0hDc0FoZmRBYWpEQkxwV2JkT2Q2YVdaMEJLdTB0Z0h2RzF1b1o5?=
 =?utf-8?B?R0ROWU5VSWtjNXRQV0FWL1hZYkliWncreVUycnFUUy9Od2pXYVZSSEpTNXc4?=
 =?utf-8?B?eXJFZUJxUm1DTlo4bEphaUlDejNGa1VOdWZWTlB3TE1hZ3pKdndRem9tMDZa?=
 =?utf-8?B?M0Fuc0tVQ0JmWHE2azE5WXNmSUw5V25NYjhsWGhJS0xHS1J0VHJJeUhxSnFq?=
 =?utf-8?B?eUxpVkx4eVdzeFBuVWltUW1QQ0hKemtrMnlLQVgyeTd4QzRzTmhJcXZQYU85?=
 =?utf-8?B?ZFo3dTZEK2diNDFHVzIxWmE1VVZmdkQ4Y3R3T1lVbVFrbHpub3krZWExTk9L?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DEFB217FE9303428B1C99A1EDC6BA5D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5431a3-54fc-466b-5e8a-08dcfe36a531
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 07:43:03.2571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJ4lLaA+5HfU5qXJ1WjpIaMOn6AygYMdJ99dmYFcjPGhti2zQE32h4b+Sf42OTSZ1d8IjabeAQgQ/SsPMIQoTsKmKKmQEQP8tYGgZn9yCxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8273
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.841200-8.000000
X-TMASE-MatchedRID: Nail4dlEBNHUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCvg6JVNagPxEGPjYszIlSDz44jpewrcFYZ722hDqHosTmAI
	yWr6xn59Qt9vEOtjPy/h8QEGoo0UrszLAY5oHhBBtzb3s8Aa1ZtKVa2W234pIHFSQk97VYGpeHv
	WAfU/lA1WwZukkUqM5T2lJLSf/Q/r8lw2qKJHAVkKcYi5Qw/RVIfZjRfGTydiYfLu5qIysvvvt4
	ENurW24AbclFZCc5YUCwxa/7EKStIHcC7KYYAdENCWPXerN72lt3qsaFY4DBAqiCYa6w8tvYRWG
	TChXyt3k0NDh6vpy32a39PjWf0NNQv21zJNl0CyDGx/OQ1GV8t0H8LFZNFG7JQhrLH5KSJ0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.841200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C6C01AC96909A6B3C1047B3AF969722B4E4EE44C41059223BD11777E0CF4DB1C2000:8

T24gVHVlLCAyMDI0LTExLTA1IGF0IDE5OjI0IC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiANCj4gDQo+IE9uIE1vbiwgTm92IDA0LCAyMDI0IGF0IDEyOjQ5OjM1UE0gKzAxMDAs
IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vDQo+IHdyb3RlOg0KPiA+IEFkZCBzdXBwb3J0IGZv
ciByZXN0cmljdGluZyB0aGUgcG9ydCdzIGxpbmsgd2lkdGggYnkgc3BlY2lmeWluZw0KPiA+IHRo
ZSBudW0tbGFuZXMgZGV2aWNldHJlZSBwcm9wZXJ0eSBpbiB0aGUgUENJZSBub2RlLg0KPiA+IA0K
PiA+IFRoZSBzZXR0aW5nIGlzIGRvbmUgaW4gdGhlIEdFTl9TRVRUSU5HUyByZWdpc3RlciAoaW4g
dGhlIGRyaXZlcg0KPiA+IG5hbWVkIGFzIFBDSUVfU0VUVElOR19SRUcpLCB3aGVyZSBlYWNoIHNl
dCBiaXQgaW4gWzExOjhdIGFjdGl2YXRlcw0KPiA+IGEgc2V0IG9mIGxhbmVzIChmcm9tIGJpdHMg
MTEgdG8gOCByZXNwZWN0aXZlbHksIHgxNi94OC94NC94MikuDQo+IA0KPiBJIGd1ZXNzIEdFTl9T
RVRUSU5HUyBkb2Vzbid0IGNvcnJlc3BvbmQgdG8gYSByZWdpc3RlciBkZWZpbmVkIGJ5IHRoZQ0K
PiBQQ0llIHNwZWMsIHJpZ2h0PyAgVGhlIG9ubHkgdGhpbmcgaW4gdGhlIHNwZWMgdGhhdCBsb29r
cyBzaW1pbGFyIGlzDQo+IHRoZSBUYXJnZXQgTGluayBXaWR0aCBpbiB0aGUgRGV2aWNlIENvbnRy
b2wgMyByZWdpc3RlciwgYnV0IHRoZSBiaXQNCj4gcG9zaXRpb24gZG9lc24ndCBsb29rIGxpa2Ug
dGhpcyBQQ0lFX1NFVFRJTkdfTElOS19XSURUSCBtYXNrOg0KDQpIaSBCam9ybiwNCg0KVGhlICJH
RU5fU0VUVElOR1MiIGFuZCAiTElOS19XSURUSCIgc2V0dGluZ3Mgd2lsbCBiZSByZWZsZWN0ZWQg
aW4gdGhlDQpNYXggTGluayBTcGVlZCBhbmQgTWF4aW11bSBMaW5rIFdpZHRoIGZpZWxkcyBpbiB0
aGUgUENJZSBMaW5rDQpDYXBhYmlsaXRpZXMgUmVnaXN0ZXIuDQoNCkhvd2V2ZXIsIHRoZXNlIHJl
Z2lzdGVycyBoYXZlIHNsaWdodCBkaWZmZXJlbmNlcyBpbiBoYXJkd2FyZSBkZXNpZ246DQpUaGUg
TWF4IExpbmsgU3BlZWQgc2hvd24gaW4gdGhlIExpbmsgQ2FwYWJpbGl0aWVzIFJlZ2lzdGVyIGNh
biBiZQ0KZGlyZWN0bHkgY2hhbmdlZCBieSB0aGUgIkdFTl9TRVRUSU5HUyIgcmVnaXN0ZXIsIGV2
ZW4gaWYgdGhlIGhhcmR3YXJlDQpjYW5ub3Qgc3VwcG9ydCBzdWNoIGEgaGlnaCBzcGVlZC4gT24g
dGhlIG90aGVyIGhhbmQsIHdoZW4gd2Ugc2V0IHRoZQ0KIkxJTktfV0lEVEgiLCBpdCB3aWxsIGNv
bXBhcmUgd2l0aCB0aGUgbWF4aW11bSB3aWR0aCB0aGF0IHRoZSBoYXJkd2FyZQ0KYWN0dWFsbHkg
c3VwcG9ydHMgYW5kIGNob29zZSB0aGUgc21hbGxlciBvbmUuDQoNClRoYW5rcy4NCg0KPiANCj4g
PiAgI2RlZmluZSBQQ0lFX1NFVFRJTkdfUkVHICAgICAgICAgICAgIDB4ODANCj4gPiArI2RlZmlu
ZSBQQ0lFX1NFVFRJTkdfTElOS19XSURUSCAgICAgICAgICAgICAgR0VOTUFTSygxMSwgOCkNCj4g
PiAgI2RlZmluZSBQQ0lFX1NFVFRJTkdfR0VOX1NVUFBPUlQgICAgIEdFTk1BU0soMTQsIDEyKQ0K
PiA+ICAjZGVmaW5lIFBDSUVfUENJX0lEU18xICAgICAgICAgICAgICAgICAgICAgICAweDljDQo+
ID4gICNkZWZpbmUgUENJX0NMQVNTKGNsYXNzKSAgICAgICAgICAgICAoY2xhc3MgPDwgOCkNCj4g
PiBAQCAtMTY4LDYgKzE2OSw3IEBAIHN0cnVjdCBtdGtfbXNpX3NldCB7DQo+ID4gICAqIEBjbGtz
OiBQQ0llIGNsb2Nrcw0KPiA+ICAgKiBAbnVtX2Nsa3M6IFBDSWUgY2xvY2tzIGNvdW50IGZvciB0
aGlzIHBvcnQNCj4gPiAgICogQG1heF9saW5rX3NwZWVkOiBNYXhpbXVtIGxpbmsgc3BlZWQgKFBD
SWUgR2VuKSBmb3IgdGhpcyBwb3J0DQo+ID4gKyAqIEBudW1fbGFuZXM6IE51bWJlciBvZiBQQ0ll
IGxhbmVzIGZvciB0aGlzIHBvcnQNCj4gPiAgICogQGlycTogUENJZSBjb250cm9sbGVyIGludGVy
cnVwdCBudW1iZXINCj4gPiAgICogQHNhdmVkX2lycV9zdGF0ZTogSVJRIGVuYWJsZSBzdGF0ZSBz
YXZlZCBhdCBzdXNwZW5kIHRpbWUNCj4gPiAgICogQGlycV9sb2NrOiBsb2NrIHByb3RlY3Rpbmcg
SVJRIHJlZ2lzdGVyIGFjY2Vzcw0KPiA+IEBAIC0xODksNiArMTkxLDcgQEAgc3RydWN0IG10a19n
ZW4zX3BjaWUgew0KPiA+ICAgICAgIHN0cnVjdCBjbGtfYnVsa19kYXRhICpjbGtzOw0KPiA+ICAg
ICAgIGludCBudW1fY2xrczsNCj4gPiAgICAgICB1OCBtYXhfbGlua19zcGVlZDsNCj4gPiArICAg
ICB1OCBudW1fbGFuZXM7DQo+ID4gDQo+ID4gICAgICAgaW50IGlycTsNCj4gPiAgICAgICB1MzIg
c2F2ZWRfaXJxX3N0YXRlOw0KPiA+IEBAIC00MDEsNiArNDA0LDE0IEBAIHN0YXRpYyBpbnQgbXRr
X3BjaWVfc3RhcnR1cF9wb3J0KHN0cnVjdA0KPiA+IG10a19nZW4zX3BjaWUgKnBjaWUpDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgIHZhbCB8PSBGSUVMRF9QUkVQKFBDSUVfU0VUVElOR19HRU5f
U1VQUE9SVCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0VO
TUFTSyhwY2llLQ0KPiA+ID5tYXhfbGlua19zcGVlZCAtIDIsIDApKTsNCj4gPiAgICAgICB9DQo+
ID4gKyAgICAgaWYgKHBjaWUtPm51bV9sYW5lcykgew0KPiA+ICsgICAgICAgICAgICAgdmFsICY9
IH5QQ0lFX1NFVFRJTkdfTElOS19XSURUSDsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAvKiBa
ZXJvIG1lYW5zIG9uZSBsYW5lLCBlYWNoIGJpdCBhY3RpdmF0ZXMNCj4gPiB4Mi94NC94OC94MTYg
Ki8NCj4gPiArICAgICAgICAgICAgIGlmIChwY2llLT5udW1fbGFuZXMgPiAxKQ0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICB2YWwgfD0gRklFTERfUFJFUChQQ0lFX1NFVFRJTkdfTElOS19XSURU
SCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0VOTUFTSyhm
bHMocGNpZS0+bnVtX2xhbmVzIA0KPiA+ID4+IDIpLCAwKSk7DQo+ID4gKyAgICAgfTsNCj4gPiAg
ICAgICB3cml0ZWxfcmVsYXhlZCh2YWwsIHBjaWUtPmJhc2UgKyBQQ0lFX1NFVFRJTkdfUkVHKTsN
Cj4gPiANCj4gPiAgICAgICAvKiBTZXQgTGluayBDb250cm9sIDIgKExOS0NUTDIpIHNwZWVkIHJl
c3RyaWN0aW9uLCBpZiBhbnkgKi8NCj4gPiBAQCAtODM4LDYgKzg0OSw3IEBAIHN0YXRpYyBpbnQg
bXRrX3BjaWVfcGFyc2VfcG9ydChzdHJ1Y3QNCj4gPiBtdGtfZ2VuM19wY2llICpwY2llKQ0KPiA+
ICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IHBjaWUtPmRldjsNCj4gPiAgICAgICBzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2ID0gdG9fcGxhdGZvcm1fZGV2aWNlKGRldik7DQo+ID4gICAg
ICAgc3RydWN0IHJlc291cmNlICpyZWdzOw0KPiA+ICsgICAgIHUzMiBudW1fbGFuZXM7DQo+ID4g
DQo+ID4gICAgICAgcmVncyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUocGRldiwgSU9S
RVNPVVJDRV9NRU0sDQo+ID4gInBjaWUtbWFjIik7DQo+ID4gICAgICAgaWYgKCFyZWdzKQ0KPiA+
IEBAIC04ODMsNiArODk1LDE0IEBAIHN0YXRpYyBpbnQgbXRrX3BjaWVfcGFyc2VfcG9ydChzdHJ1
Y3QNCj4gPiBtdGtfZ2VuM19wY2llICpwY2llKQ0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIHBj
aWUtPm51bV9jbGtzOw0KPiA+ICAgICAgIH0NCj4gPiANCj4gPiArICAgICByZXQgPSBvZl9wcm9w
ZXJ0eV9yZWFkX3UzMihkZXYtPm9mX25vZGUsICJudW0tbGFuZXMiLA0KPiA+ICZudW1fbGFuZXMp
Ow0KPiA+ICsgICAgIGlmIChyZXQgPT0gMCkgew0KPiA+ICsgICAgICAgICAgICAgaWYgKG51bV9s
YW5lcyA9PSAwIHx8IG51bV9sYW5lcyA+IDE2IHx8IChudW1fbGFuZXMgIT0NCj4gPiAxICYmIG51
bV9sYW5lcyAlIDIpKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBkZXZfd2FybihkZXYsICJJ
bnZhbGlkIG51bS1sYW5lcywgdXNpbmcNCj4gPiBjb250cm9sbGVyIGRlZmF1bHRzXG4iKTsNCj4g
PiArICAgICAgICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAgICAgICAgcGNpZS0+bnVt
X2xhbmVzID0gbnVtX2xhbmVzOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gICAgICAgcmV0dXJu
IDA7DQo+ID4gIH0NCj4gPiANCj4gPiAtLQ0KPiA+IDIuNDYuMQ0KPiA+IA0K

