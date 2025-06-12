Return-Path: <linux-pci+bounces-29622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E854EAD7E73
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 00:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2A418982F6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 22:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF692DECD9;
	Thu, 12 Jun 2025 22:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eo8p9ywN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yRphQF2M"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EC22DECBD;
	Thu, 12 Jun 2025 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767738; cv=fail; b=jFSI1dbEDBHVCid6+QzJdvIqAzR1ale1Q1mi5AUxlh4cMMpSue+NfH/HX9DcLnkrFAYxfAFPUQX4AYb/oycGrhMso3RN/z3uRnb/xkhe/lqQy5sajJQ6IbukojYbHSLEWTlbqVlSGoGyzweBNmFvDfsLY6NhDcznlleN+kwLjW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767738; c=relaxed/simple;
	bh=zch2qUaDqvuQiauPmN1/AcqBAqPnw/36v3OTcnSyd6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bQH6tGqjBUDwcJaY58Jx7QFQ+wUDaNjU+GLlXSIGjAEOVu5uSDIYSp2oyJUiL7j8dTrMp9zinhkH0G3ALKvtG4AHKJ6xHAOPNKngVtw9YoviZYCHW280WKWMC++Whf3krK9k5YGwMNXHXOGn3BHweYQcsyIjq2/BAg+d3KjTbLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eo8p9ywN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=yRphQF2M; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749767736; x=1781303736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zch2qUaDqvuQiauPmN1/AcqBAqPnw/36v3OTcnSyd6Y=;
  b=eo8p9ywNKGACoDHZoaWmF6/5W7y2ZttcRcjm0GIMk7DGBWTMikCvrXyX
   xYzcfyvJ7GDfJUQWwYYGUOuLe8q07LxxhXWezRmmQR3Isba60ty/bCEiq
   5d8+mSEQFBs3Rj4O3vW0VQ9LncNhGhi2/QpHNdWV3o/wt9bQ1lagxmSnw
   DNcCr3RWwlvx7TbTnBJBifGSX3WjCgUExfx12DlpqmPBYoS8IvxXky4OR
   bkafSlS2E032ti4SPpD+tPJbeJIoDNlaEb1FLK5kn1PdVAO/OYrfA0C7E
   7vY8CElHQWcs8BwZ30X4pC3a9lh1J2mS5mAi2MFJA3motcjPG4SKmaQy3
   w==;
X-CSE-ConnectionGUID: FcIn6LGYRMqDHkxNCMipjQ==
X-CSE-MsgGUID: JfkwPpBbRgSQ6ri1W8tdtA==
X-IronPort-AV: E=Sophos;i="6.16,231,1744041600"; 
   d="scan'208";a="83943313"
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([40.107.93.63])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2025 06:35:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/4LOuUt4ppuEKwiP03gtPdsd7rMCcw193mam+Y7PYvxjRE7PWcyMaU4feG5Kt/IE2u3JS5qUSkCBbhO553fqSMp6804LoTnoDrV9yQQHWm2WaR2mQDeL19x924F6wHY5ztj72x2oh4md88qpxjovUJ8svExdR6Amt33Yj0G5gee2nLg2zeR41/cXMb4kqKqD9WW7UiAH1JcMpfETxoqDHkJq+F1aQ/tPLY73Ayqc297FgFG2Z5r8/f2aYin5Dfl+CyDQRaIA7XMrkGdc1fv5ODkgit5ERuhfCdD0G3rxfLwOcH0Lck3wVlg4E1Y4LcvMVih1AlWepmGySTLVqPSIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zch2qUaDqvuQiauPmN1/AcqBAqPnw/36v3OTcnSyd6Y=;
 b=P16VzuGIUfYngMvElDItxmQcwCSEs1LgdijHc5mn1CYYT+iGSATNtngKS9SVLBUmpm8CvKveOJ0fTBWXjvg1AXJ4koK9Or3ryYJIL70Fz2AHF0zhkptFogjnshgNiHM8kdysaCLC5687uUbSxLIaM8SeBQo75ZK9TdNcyJl8p+Gn5banxxhWYfsdq9tRfdZ+eZooTROEWca4H4B9GM8bfSrd/9k87bnc7BSQUceg668lzuhhuZh4/4qtpUjnWRYx0iVrmcqdhzEnKuzlVaGsUw6cLOtaF6B+xqbXONTBhnlvmcZwDyNAxABluKk4G85ndJ+oy4R4h+cf3P/2QJ/gsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zch2qUaDqvuQiauPmN1/AcqBAqPnw/36v3OTcnSyd6Y=;
 b=yRphQF2MEtrRlJQPXO3lR7Z6XHljbBOfEFiVYbSHi0AVpQiS7rqbiaJN+9W8g1qet2AIhg1fqtY+f01aHAaS6DePW3hP+yMKRNaojNUilEiUtCQKA8GoKzto5eOzcZKESRjUwEUlhCbsqxt2bGTNlRAvRGUnk7xQeWa9JDeAUSE=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 22:35:33 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 22:35:33 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "robh@kernel.org" <robh@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "cassel@kernel.org"
	<cassel@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "svarbanov@mm-sol.com"
	<svarbanov@mm-sol.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"laszlo.fiat@proton.me" <laszlo.fiat@proton.me>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH v2 2/5] PCI: qcom: Wait PCIE_RESET_CONFIG_DEVICE_WAIT_MS
 after link-up IRQ
Thread-Topic: [PATCH v2 2/5] PCI: qcom: Wait PCIE_RESET_CONFIG_DEVICE_WAIT_MS
 after link-up IRQ
Thread-Index: AQHb25Ahlles4Y+9m0SVvU7NIoSnRrQAHXwA
Date: Thu, 12 Jun 2025 22:35:33 +0000
Message-ID: <96fa65058ce0676f81241f91e03b8a8202b2c4ea.camel@wdc.com>
References: <20250612114923.2074895-7-cassel@kernel.org>
	 <20250612114923.2074895-9-cassel@kernel.org>
In-Reply-To: <20250612114923.2074895-9-cassel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|BY5PR04MB6327:EE_
x-ms-office365-filtering-correlation-id: 697c34b8-77bd-473e-713b-08ddaa017192
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OHY2VzdSb3VDQUoxNStOVFN5cFFiNWZ1RkZaM092TGNXWE5Wek5KbVJVeEhI?=
 =?utf-8?B?L3EvZWhmL1pJNTYremx3bVFqYVlGSHJySjVTKzFuMnlaUEgwa2x6ZHd3aGlu?=
 =?utf-8?B?emM4NjczenBYVTdJdjYyaEtBRkdVZ25UdytHb0sxd3dtY2s5eTQ1bmNXR2Fi?=
 =?utf-8?B?aHFId3E4RTdQQnhaQlc0NlBGeTg1SmtKVFN6MTRyanQxYS84RzNYTCt0K1NY?=
 =?utf-8?B?UmorVFMrZUNqMUI1QlZieFhwcHhNOXF0U241ZUtrYTk5RUZlNmpjM0ZZdThB?=
 =?utf-8?B?RzhGWnEyandKU2NmR0NqMVdBRnlxeFQvZFFiUEZRMll5TU1FTm5NWlg4b01G?=
 =?utf-8?B?TmhqM3ROQWdMMnZCWEk3Z2hHRmZuK2JpQzB0bDZnRmNMb1hBUjhnZDNFMVFO?=
 =?utf-8?B?R3d2dnh1MHdsamVzNUVBOWFNa3RYQTNDNUd0Zm9tdDBxelVqaVoya1pUQnNC?=
 =?utf-8?B?UGd4L3dtTDhYeHJQUFVrMkF3M1haNTk4anlxaFN0MlZsUjNDTVBvd25SVFp6?=
 =?utf-8?B?ZEZkQkhoTDNwUWZ3M1h2Y3UrclhZS3krQVJqQkpKTllRcUsreTBwZ1BpWnI5?=
 =?utf-8?B?blFEaG9jT0puaVcxNkcrRzZIRHlwYkUvWjN1L05zN1FHYmhuMmJ4UUZiVloy?=
 =?utf-8?B?NGdsbXJhQTZkdGZJRjNoM2NtaFhCdm1GaUQ1MUhZelFwVmhRMDBSZGNhL3ky?=
 =?utf-8?B?eUlPSTg2SHpRR3FoMkdTZ1dIU0lMb0lyVWM3NUtQM0M2c2F1MUk0ZjAxc3hW?=
 =?utf-8?B?Q0dPeUdxVm1GV01yVG9nR0gwWGpCcUErRXVhdkVCMzVNdE1McytaNnN3cjZm?=
 =?utf-8?B?NWVZQUNkaWtJRVdjczVsN041dEhjTnlHRXVGeEFWUUdJNGV4K1o5cGp2TDNO?=
 =?utf-8?B?dDlTUmhwSHcwbnd3cnp5OVRpMHk2b1ZsUVg0Rlk5YmF6VU9Jc1h0M2V5eHQ5?=
 =?utf-8?B?a2plWWhMWHdjODlha0w0N21Zdlg1SWp2M05BZmFmMDc0TFRZdEMyVHVyTXlB?=
 =?utf-8?B?ZmZ3M3g4WTJGVC9PNGNhOWsyUVgwbS85aDZ2dmVwYkh1TUptSWNUR1Y1RDRC?=
 =?utf-8?B?SytIdGFqVFFaUjFqQVlicVZTSXF4RGl4Z2lxWWFwcTBpMVE3dWZNZy9kTXZh?=
 =?utf-8?B?OVNZSGlXbDhRTkNDa2ozM2gvMXRmZnAraW42TlNOeTBnaGMwRlRZWEgvRzBD?=
 =?utf-8?B?R3U5TUZsOHQvNnlFSkFSREtaUmRPNmNidjM4RENmTXM0N2NmME5ma01NL3Fs?=
 =?utf-8?B?YkJHK05TTHBTNjJlcExlWjhyRERsS3VGdGdQdVBFU1lLODBoVGpEaTVvYmFs?=
 =?utf-8?B?T0E4ZC8zMEd3Q0daYnZRTTNSb0xCMUd5aDFPaVYrQmV4L0hOb2x2UDNOYS9U?=
 =?utf-8?B?aStHWGRlaEYwWm1aYUJoM25RTGZHUGozRnpvSUxDdHFDOXJrdnI1YmpoZ0tG?=
 =?utf-8?B?NUVaWTQ3anpGYitCRm80aEkvTjN0Wk1ZenZiRm4wNkk2Qkl5WmdDeFJ2WFlM?=
 =?utf-8?B?VnR4bE5xOEVBV1paaVk3M2pxckt5bXRoTTFFUFBpajVXdHJjYkJWeG45OGhj?=
 =?utf-8?B?eHVYMHRuNHNNTWpmWDVBeXYxTzRjQmFGUFpVdFE1cXhjbGUxOXdzV09mc3BV?=
 =?utf-8?B?OU9hK1c2WC9LVU5sME9XdWZndXZXSXlQU21zTWlkY2tIRjkvZXR4RXJMSDJP?=
 =?utf-8?B?eU50NndRc3ZNMUJyQnRmdVlJYU9leGQySERHa2MxdUFad0V0bEdoR3BvUWlo?=
 =?utf-8?B?NmJnWXVod0NBVTN5Z2Z5T2tCNlgvdnd2RUJKUnY1NE9BczZZQ1JYQXJKQXpB?=
 =?utf-8?B?KzBqbjIzbkpUcnR1dGZRMUtwb3VNb2FHOUFjWHhBMzRjcFdZZVBXSDREeGFr?=
 =?utf-8?B?aG5VVmE0dWpqeVVaOFFJaFJ5Yk9aY1pRdzkralpGMnlUdTZzczJpRlJnVWU5?=
 =?utf-8?B?UkN2VHdweEhjakpXbkYvWnVmV1RPNTJibmtrelY4aStZTXZuVjhLZXhadlNa?=
 =?utf-8?B?SW1obkV3WkV3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWhQd1NMdC9pWWpyamptSXBQUXh5TkFLYlRCTE1JQ3JzcG8zM3I2dFBuU0cr?=
 =?utf-8?B?R1VLZU1wZVdnajY5R3VBMXVnd2poZXZ1czNvK0Z6VEtJd2Q1eWo1K2hEMjc5?=
 =?utf-8?B?WitVZW84SjZRR0I2S1U1ZzNXSE13NnQ4d21CMCtDMjdzSCtKcy9yNUc5RVpJ?=
 =?utf-8?B?T29jZ0kvOG5pRDN3YUt3SFJza0ZpeFE3Y0tmZHhFT2lYaWU4QVNiNW1kOXZt?=
 =?utf-8?B?ekdCSjBNRUZZRVY3RHBWSlVQZHZacmJzUE5WV0JuaFN2K2R4RVRBNkF4TW95?=
 =?utf-8?B?Y0FiZzRYV1E1WTc1V3hQcWN0cDB6S3duSGdJWkFVellpMmdETzJQdDJHUHor?=
 =?utf-8?B?SktGcm5UaG5mWVZ0T2N3dTN0aVJVUXp4c0p1cHllVGVNQXlzS2E3U3FsT0hR?=
 =?utf-8?B?Y3Bsa0VzZ1hnNldBQ0NxYktoZ3BXblhjalNWVDJmOHJER2dWU0drNHpvcFZD?=
 =?utf-8?B?cWpWUzZsRTNvVkxQODV0eTA4M2JHZy9IcmhRSkF2QVlkakZtclN6czdxM3N3?=
 =?utf-8?B?M3BIRDhDS0FON29EQUVFK1lnTCt1dGdqakJTNlNkQzdzREhFMVc1ejQrdUpO?=
 =?utf-8?B?Smd4bkNLNmdTc040TEZCVEYzVGlMU2w5NjI1c3Uwem1jSGNoVDVjYm44UzJ4?=
 =?utf-8?B?clNnQjNTQStxV1IwRE85dDVMck40OWxpTDRjbGtqeDhMVHB6K3FRSVpOWmVD?=
 =?utf-8?B?cmlHTDNYWEVkQklNUEQ3VHo1dUdyY0pQSmh6aUFhS2plYmlxeG5iWnNYaFpn?=
 =?utf-8?B?NVJSa1BacElxa1F6OGQ2NVZVRmt6NjdlcU5ZSHY3cXd5ZUpkaWhpZktSbGND?=
 =?utf-8?B?VW1XcHRxUm13b2ZoK2VoU0UxYW9VRFBqajMzQm5VVUk2RUtSZTRyK0ZXR3kv?=
 =?utf-8?B?N05oYnZvejlzc0lQSGwvOWtSQzcxOXhlcHgvY1lLcjlkZWhQVWg0QXMzTUZt?=
 =?utf-8?B?V1VXVjVsVEc4WGozcHE4M3hUN21JOTFsZDIxeUtVcHZpY0VFNUdHMDRTSXBF?=
 =?utf-8?B?UjNhc3RyTmowN1hUaENBUzcyZDJWdHRoNktOa3Brc3JvdVg4Qm5ML3gxb05V?=
 =?utf-8?B?bzVzV240N1NYUGtNb0JnM24xMVVRKzdreHkydDV5SFlqOS8rNmpVbWx6L3Vt?=
 =?utf-8?B?d3VUbHNQVkgvWmM5WlRZUFA3UGRhWEVhWWtYeWlBYytTeFdnNzBDQUpIQzZL?=
 =?utf-8?B?aEpKUUdMS1lHdEVNbWRkc092ZEZ5Q09kMU1la1hzWXVrMTVNOXpZOEFpQTZ1?=
 =?utf-8?B?RkRpRVZGTmZTVWFGNU5oVjJRN1hjRHgzRlRNUUhXM2lnTG9hU1lPTmwwYkZv?=
 =?utf-8?B?SE1CeXMrU0gzZU43czgyTHBBVTdnVWQvUG5jMVNHS09yUXk2K1pHanQ1eHVS?=
 =?utf-8?B?MDYwd2dTZ0k2TTd3cXRNNk5qWEhtNkdHbDNvUGJCWGJrOGwzd2xwb3RuZzJI?=
 =?utf-8?B?Sm4vUlpZUUpHNnlldjdwUE85M3B3RnMxTUJLYXE0L2FOSXM2RjdyUE53RlJI?=
 =?utf-8?B?cVQwbVUxdzkrVTBKUklOSk9GR0hzdXBHRzJRSkNia3V5ejhHNHV5SkdiSWV5?=
 =?utf-8?B?Z2xkNmpDaUxnM3FOZ3FZRmUzdDI2OHpuMkhlK2JXNy9BMG9yQk5ZNUV3MWFv?=
 =?utf-8?B?YUxsVG1zRWJ1SmdZRU1nYXZlYnpKQmVGcTFPQVZBT21sbnJqTXNuY3Rlc0Fp?=
 =?utf-8?B?OTlUQ1Rzd0tSMXJMZnZlRFVYOVNBd1JqMnBCVnYvQytPT3JHQkd2cGMvOUpM?=
 =?utf-8?B?ekhlVlM4QUFVV05iZDk1YlZkQ25GQ3Q4MTl2ZmN0TFFiVUcvWHlyb3FMMVdH?=
 =?utf-8?B?cUtHQmI1T3didldqbkZoajF2cU5NK1VTMnh3RmtHN3VMUHhVRnJGSUtQcjlo?=
 =?utf-8?B?SkczQkhmak50TThsU0p4dHpCdktLZFZGQk1uSGw1enkwOFhEZDFpNjFLUWFm?=
 =?utf-8?B?RjJLclF3Y2VoMVhndWpLSzJVcTB5REs1dDQ3bk9RajlwVzUxRzZFUFRKTUV0?=
 =?utf-8?B?ZzREWDBFN2JuV3BEWkRmbERRem0zTHBnUU5ibHpSaE93KzNqcTcrbnBIZEE0?=
 =?utf-8?B?RW9TOURjU0lycUUrSDZZL01aNmQ1MkRYN1BDR1NZZlFoZk5PRlVvK0VCVEpK?=
 =?utf-8?B?bDBuMGhpRjIrdlZOeWY1NzhtVkhoWXA3STYxbDlDTVgzVC9RNWZNV3Z6bUpm?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <558DCF6AF327B0439F22F699CB416F43@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aLTw+LotLP8jrWiPY9uRNX/9J7Eh0KLPYF99l3QbB7f38r9tc6EJaf8knhHs5DPh2WkiH75CiOiqzPJs8DGNvw/sXfnagzYabc40A4+wLeWDByKclLDLMPUE6iF5kGYbnsLNqjuOFoZj3svHRBU5AlI7m6wD2nM37GLYH4c2mNCO69GtqTLyozxeUNgJcULgDySU3D5e9/rlJnIyZTySOB6qPQz96k83cA7dUt8fIyUFpA8IGVjy6E1rx3tWJrrGPe2fbDIy0BECO2+7nEOiQR5jn9DA9UEGTejU+QHcfo87WjXbkRWjusWZJMlcJUylZgBakNr43UToAJRA6LePJobM2VJxJlPl89AlQPmlsrpehmuxK2vMGiD7/q+6fkiWUExbqY261R61LuKOMyWab3jOnO6oCitpWPsg+2YHQH0knO10JbDi2FMR+4OgCu22TKeZ9DjE4GjCiBATC42YdT62IjQOyenSARfnG9lV7dqTMj5qIPmgqNdu6oHCWKtEgwxO0Ns1dUEILbIbGGL3fO2ZES8V2vzV8X1+eLcnxGQwbGFCNwcY2RZOhSsKsZQUPkW8kUbTdzDRp8oGCeXSjIpcW0kA+oVZU/P2uMOXzvdZOgu5za+cc9Vvu1Jpauxg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697c34b8-77bd-473e-713b-08ddaa017192
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 22:35:33.3093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8Sdle6K3wb7NWrQOqKrQbO1iuHmqlkH1lHyM2Q6yrFigKqzRiV8dlykkHolvz5PFLsI4pZSQe4+WR0UHrSY5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6327

T24gVGh1LCAyMDI1LTA2LTEyIGF0IDEzOjQ5ICswMjAwLCBOaWtsYXMgQ2Fzc2VsIHdyb3RlOg0K
PiBQZXIgUENJZSByNi4wLCBzZWMgNi42LjEsIHNvZnR3YXJlIG11c3QgZ2VuZXJhbGx5IHdhaXQg
YSBtaW5pbXVtIG9mDQo+IDEwMG1zIChQQ0lFX1JFU0VUX0NPTkZJR19ERVZJQ0VfV0FJVF9NUykg
YWZ0ZXIgTGluayB0cmFpbmluZw0KPiBjb21wbGV0ZXMNCj4gYmVmb3JlIHNlbmRpbmcgYSBDb25m
aWd1cmF0aW9uIFJlcXVlc3QuDQo+IA0KPiBQcmlvciB0byAzNjk3MWQ2YzVhOWEgKCJQQ0k6IHFj
b206IERvbid0IHdhaXQgZm9yIGxpbmsgaWYgd2UgY2FuDQo+IGRldGVjdA0KPiBMaW5rIFVwIiks
IHFjb20gdXNlZCBkd19wY2llX3dhaXRfZm9yX2xpbmsoKSwgd2hpY2ggd2FpdGVkIGJldHdlZW4g
MA0KPiBhbmQgOTBtcyBhZnRlciB0aGUgbGluayBjYW1lIHVwIGJlZm9yZSB3ZSBlbnVtZXJhdGUg
dGhlIGJ1cywgYW5kIHRoaXMNCj4gd2FzIGFwcGFyZW50bHkgZW5vdWdoIGZvciBtb3N0IGRldmlj
ZXMuDQo+IA0KPiBBZnRlciAzNjk3MWQ2YzVhOWEsIHFjb21fcGNpZV9nbG9iYWxfaXJxX3RocmVh
ZCgpIHN0YXJ0ZWQgZW51bWVyYXRpb24NCj4gaW1tZWRpYXRlbHkgd2hlbiBoYW5kbGluZyB0aGUg
bGluay11cCBJUlEsIGFuZCBkZXZpY2VzIChlLmcuLCBMYXN6bG8NCj4gRmlhdCdzIFBMRVhUT1Ig
UFgtMjU2TThQZUdOIE5WTWUgU1NEKSBtYXkgbm90IGJlIHJlYWR5IHRvIGhhbmRsZQ0KPiBjb25m
aWcNCj4gcmVxdWVzdHMgeWV0Lg0KPiANCj4gRGVsYXkgUENJRV9SRVNFVF9DT05GSUdfREVWSUNF
X1dBSVRfTVMgYWZ0ZXIgdGhlIGxpbmstdXAgSVJRIGJlZm9yZQ0KPiBzdGFydGluZyBlbnVtZXJh
dGlvbi4NCj4gDQo+IFJldmlld2VkLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwu
b3JnPg0KPiBGaXhlczogODJhODIzODMzZjRlICgiUENJOiBxY29tOiBBZGQgUXVhbGNvbW0gUENJ
ZSBjb250cm9sbGVyDQo+IGRyaXZlciIpDQo+IFNpZ25lZC1vZmYtYnk6IE5pa2xhcyBDYXNzZWwg
PGNhc3NlbEBrZXJuZWwub3JnPg0KPiAtLS0NCj4gwqBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLXFjb20uYyB8IDEgKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5j
DQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1xY29tLmMNCj4gaW5kZXggYzc4
OWUzZjg1NjU1Li5mZjI1N2ZlYzZhZDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtcWNvbS5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtcWNvbS5jDQo+IEBAIC0xNTY0LDYgKzE1NjQsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QN
Cj4gcWNvbV9wY2llX2dsb2JhbF9pcnFfdGhyZWFkKGludCBpcnEsIHZvaWQgKmRhdGEpDQo+IMKg
CXdyaXRlbF9yZWxheGVkKHN0YXR1cywgcGNpZS0+cGFyZiArIFBBUkZfSU5UX0FMTF9DTEVBUik7
DQo+IMKgDQo+IMKgCWlmIChGSUVMRF9HRVQoUEFSRl9JTlRfQUxMX0xJTktfVVAsIHN0YXR1cykp
IHsNCj4gKwkJbXNsZWVwKFBDSUVfUkVTRVRfQ09ORklHX0RFVklDRV9XQUlUX01TKTsNCj4gwqAJ
CWRldl9kYmcoZGV2LCAiUmVjZWl2ZWQgTGluayB1cCBldmVudC4gU3RhcnRpbmcNCj4gZW51bWVy
YXRpb24hXG4iKTsNCj4gwqAJCS8qIFJlc2NhbiB0aGUgYnVzIHRvIGVudW1lcmF0ZSBlbmRwb2lu
dCBkZXZpY2VzICovDQo+IMKgCQlwY2lfbG9ja19yZXNjYW5fcmVtb3ZlKCk7DQpSZXZpZXdlZC1i
eTogV2lsZnJlZCBNYWxsYXdhIDx3aWxmcmVkLm1hbGxhd2FAd2RjLmNvbT4NCg==

