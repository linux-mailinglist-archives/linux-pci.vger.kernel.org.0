Return-Path: <linux-pci+bounces-27300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C3BAAD0E7
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 00:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07DC1BC5636
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 22:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3465157A6B;
	Tue,  6 May 2025 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G5v3Fip0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Mk2Alg4p"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D25218AA3
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570244; cv=fail; b=UiRSNA/esKwun7zs+pqNM9TGgJJ3g63vyBkm2n1W3jeP2xwvLxF8LELg00ZJwAfX0eX3IdIivBBu5VYy1MNTkhNXv9qRKwvTA0WWe2WC5KNsa5XdUm8Z2wnrx+sQnQXhn+xKmlBFytPGcqhK6ESrSZX1TXQUQA9hv/j54DHdtEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570244; c=relaxed/simple;
	bh=WuN+YTZGtmP4DCzAso9u8HVAZ8Tn9s0Bkl0e2nr1dL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hig02o3SidH+AYJRutoHX8sXJCGPpydwpumCUAiJLCYxccQkcIXpvTapQQHvy4dsy/XcQBU1ilCXnHg5FVC0U3rqekUyYBXutjKwL1sMWacYgIlmDk4EMXA37WzlxitOXgtiaRwcC8IptHUA4/8DaOEF954LOOhaGNCvbS3Jp1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=G5v3Fip0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Mk2Alg4p; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746570242; x=1778106242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WuN+YTZGtmP4DCzAso9u8HVAZ8Tn9s0Bkl0e2nr1dL0=;
  b=G5v3Fip0svrqkcUvglSM9wZgoP7m5x5a3R6Tj+F3kfXhGpW6OqzoTW+n
   T9+gKxR29eDtgEIe8OGWKr1LPxLoijhyQYF4OwxD5TfpbTsBSD68YoT4D
   sixcb9+uyptNJ0q7+ra39FJoy/zlemXmO8ZQ6IMAA8yMEJ8/Do6/rcH1a
   npZrbsgBTKjSCT5Kes1RJ6a3uRIJmFXJI9AbqEzTHPqZkzOwry37llLsX
   xK/4y6+q0dOLh2ufE5274ILzzGHMyLCUBBTJ7QzeVYSRkQdWTt41d2HcK
   73ihraxceQseI4V960d+CYVOEyxwkKTZ8jOZqtUJENkSnsHGMFn4K+jFs
   A==;
X-CSE-ConnectionGUID: HcgTeCUVQty0OdV1w+p2iw==
X-CSE-MsgGUID: eqnQmpMuR7+BmZ9qTmD9ow==
X-IronPort-AV: E=Sophos;i="6.15,267,1739808000"; 
   d="scan'208";a="84416600"
Received: from mail-westcentralusazlp17013079.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.6.79])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2025 06:23:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOoJHMfhBCPDTwu4vhlDCCRzPt4Btf9DHl8DOZ8djP9lT26EevB9HMtCN/zv/A96MDa9+vzlFXO8M2FaiB1gN/9UY+zax+trKWyzWNA4qlilZ3TCeFdsKAXNYspd7eFa1giKqd/jiHquN35YDxwedgs4y4n0QXOXmTJHkJ8bmXVOZuRzzjMle08Q+N7NQrhYD4LnWXxM9aFdSDIuUeHt+X6SLG2E320OCCJEANqc3ZHzZGOqCecSviCRYQGonpCA0kwczgo/SFej/mEd0P21YdG5+z0W1c/BBKNl4/0h243q38Ep63JqoxVsUYWZAXR9Qyc0SbvayejXIfTSRqknXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuN+YTZGtmP4DCzAso9u8HVAZ8Tn9s0Bkl0e2nr1dL0=;
 b=NTkrUhNsD4K0y2uNH5ySBElFEHg1u5FcDV6f1Q6xbkRg1Ksoyy6CkXtoUdRnMCGGqRFhRMb5SLog8MKrR90rESyHOILzPh1Du9E8xokQCJEUGFlZXuQhn4BZieh2mhunin7qkqvS0jB+omkuBgQnsdCUFW0EpRefZIUZnBlxxeXNcMxGrZO61jz1sff+DjNgft/uzovawvnPtiQdbn2ZniflClJWtJDgypeB5j2bMZl1zTusGWO581c845vvuUCxHpCCEeRykvO0IurZHCnhR4clwXmoLPCyqSic+ZkwI29Hhkoofpnkr3ahomIUSZ6jutu1H1YD3AVCu79wxp4joQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuN+YTZGtmP4DCzAso9u8HVAZ8Tn9s0Bkl0e2nr1dL0=;
 b=Mk2Alg4pyy9TY2eeKL1aWtJV4Uc1X81kx04F1JUPf12OOmgtDCSi/SQ8LO2PDcXwtdttSfpBQIWi0y6kC+MvUuyAgDSOTcKeFLHN3oubjcX/alk9Dnin7rUWLhAc6maMjazdB+Rz08PS+IIIBJc0e/bNxuEl48rkwp3xFrlKD14=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by DM6PR04MB6729.namprd04.prod.outlook.com (2603:10b6:5:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Tue, 6 May
 2025 22:23:48 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.8699.031; Tue, 6 May 2025
 22:23:48 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "cassel@kernel.org"
	<cassel@kernel.org>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "laszlo.fiat@proton.me" <laszlo.fiat@proton.me>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "18255117159@163.com"
	<18255117159@163.com>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Thread-Topic: [PATCH v2 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Thread-Index: AQHbvloR63Fc3bM5h0aHRcLprUd9rrPGLl2A
Date: Tue, 6 May 2025 22:23:48 +0000
Message-ID: <520920ef4a412f2242150d6a96098e10ba1dcb62.camel@wdc.com>
References: <20250506073934.433176-6-cassel@kernel.org>
	 <20250506073934.433176-7-cassel@kernel.org>
In-Reply-To: <20250506073934.433176-7-cassel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|DM6PR04MB6729:EE_
x-ms-office365-filtering-correlation-id: 16d32dc9-5476-402d-5c24-08dd8cecac13
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cTFJeWN1d2tJcEU1T0lobUxjelJzcHdRL1lsRFhJOWpGa21VaUcyWVNwZXdG?=
 =?utf-8?B?eFNkdHBQdFhCbGNtT0lXM2JqaDFSZEdIYnZrNUorZUdPUU1zL3JJWXdIeU1z?=
 =?utf-8?B?S3BxeEtYVDIxSnlJVUVFcnh3SjZha0c3MnlIWldsdm81d04xL0EzM05OU0k4?=
 =?utf-8?B?YzViQUNMK0Z1Q1J5a3FvRy9lT3hxSGFCcDFPZFpkREk3MndYK1ROR3JDa0Zu?=
 =?utf-8?B?UmVHWk9uMTVoWFRiT3gxdENmRTB0K29pbWVEVldvRU5vdThhRnU2bjl5bmdN?=
 =?utf-8?B?TDdXNncyak5YaHQzdEN4V1dYRnBhU0V6ejhLSGxmQ2F5TjRtaHdYS0I2T3FI?=
 =?utf-8?B?ZUMzalJ2ZmwzVU5DcGN1cjg5d2xRMkdwSUQvK0EzNGZENXBmS0ZjVFYwdE1Y?=
 =?utf-8?B?OEY3UEUyVThSZm5qSWovck15Q1BNdmd6NGF2YUdXT3NaNklXcGdtSk5jenFV?=
 =?utf-8?B?NUg2Y292dEgvV3loQUpHNTd2K2xUSW1KMjVDeWMyOXdiY3RjRWdacERCcWtS?=
 =?utf-8?B?Ni9obHhZNjQwK1diKy9maVN5OFVabGpkZnVvOFdKdnFnY2NWdmdhMGY5NUs0?=
 =?utf-8?B?bk1pS01tbm4zZXhxTzdFN2dwWk9Lekh2c2ZEcWFjTEErMkRpaGZ0UFdhdkdT?=
 =?utf-8?B?M0J1Tkl5bEFUdUcvSWdONmM5bHovZ2NJYmNRVmlYakFKRW96bHhCVW1GWXJZ?=
 =?utf-8?B?aG52Sy9wWENoOWh6MEd4K2pUYmZWMkxML095TmdPS0JuVW9SUURKTGZQbVRQ?=
 =?utf-8?B?bk4zQnhicVdPOHlkU09JVndtbW5FTk1TZHhqN1Ntc3dqbVJCTGs4UWR0UTFE?=
 =?utf-8?B?WkQ2R2pKTk9uTTJ3Y3kvU0RTaFIzZUl0bHhrZHJxbjR6bW9rWFVLMjBDeFpO?=
 =?utf-8?B?KzBFN1FNSWs0aWYrNko0eFBCMzludGdmYTVLa2hHQVZvNlVSakpYUFMvUVFa?=
 =?utf-8?B?TVFmOVQ3cHBQOHNwbnMxOE85bTRaSkFEUzMzR2t4QzBGUkk4ZE5EcHlLRDlG?=
 =?utf-8?B?eWRESk1UNU1yVTNidjRQWm9PdnhYaUdPM2FHcXRnVytDL1Q3MkU5blZsWUtV?=
 =?utf-8?B?S2NXb0d3aGlpZmxUR2Qvc3JMQWRKNzdLMkFEVmNzVm1rb1FTMm9TVEhxcG1P?=
 =?utf-8?B?dkxobWdsWTIvSXRKZjNVK3c1V3B3eU1yS0FsZnNKMVhubWd3LzQ4RjZTRmVt?=
 =?utf-8?B?MWd2b0p5RjdPVit2Q3lxNkp1ZmJ3SmQ1Uy93OVliYzd5M0V3WHFBU3IrWmhX?=
 =?utf-8?B?emV0R0NPc004bDk5N0RTSEdSdWZVaFdITjF3c3d0TGRxZXpLZUJUc0RVV093?=
 =?utf-8?B?eWhhaFdQSXZuTm5wNWpPcDAxNG9GU3VzVDVHVEdlWjBrY1BHTUNId3RLY2Vn?=
 =?utf-8?B?NXZkcVhwSGxwalh0WXJJWG9IL3VOR0Y2aUc5THhzdzhaTEkwdEJsampIYzIy?=
 =?utf-8?B?YkxKRzBja05Sc1ZjaUpmNjVoY1o1UWI4NWEzMmpoN1A1RkpuaTNjTTQwTmg1?=
 =?utf-8?B?cVJWNjczZW1yZHdmVlc5Z0ZZZEtKOVIrU0dZdW96cnp5TFRqd2h0M1JGQmlu?=
 =?utf-8?B?dEgzZnEwTzJyRHRpZXlQQ3dNMzJ2Tjg3STFWNUJlVk16R1VWS1VjbFBFaXp3?=
 =?utf-8?B?dUFOU1YreDhubDkvQzFrakFrN0FMRldBS0NiS0t2RkRHbXFlS3RDTXJ3akpX?=
 =?utf-8?B?M3dRcmM4cTBUZEF3a2paOEZLbjZyL2lpNTVWd1YvSkUvdS85eEZtSW5GN2g4?=
 =?utf-8?B?cVE2bll6N2k3ZFYzUXA3N2RpRnl0N1JFOC9YaE94NmJrcHBhaUhZZUg4OGxw?=
 =?utf-8?B?T0tSVEt5blVtUGpYd1EzbWk5bG5MV3dGdTZ0WXJCZU1SQzJOWlZwYURpZ0J3?=
 =?utf-8?B?STY3NGVSUHZCcExHaFFKamJEVVFzQjZzNXFWMlpzWjZQbkFqKzNGZWZ5ZFVu?=
 =?utf-8?B?c1JSVnBUMENpVFBsVENrVjB4aTh2eXJFQytteHozeWplZHFQdk9OZER5SXRW?=
 =?utf-8?Q?dUfJg+ckBH2pErkP9+YN6dK92cuP5U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1EvR09ESGZzWDdpZmI3dVgzVEJoYTk2K2MvRytZbi90eE8zWG9qTzRSNXJw?=
 =?utf-8?B?NWVtVEJ4aTRiZGpja0IzL08zYkZyYyszMTBDQXoxd0ZHTWp0SHBSRWhsWklr?=
 =?utf-8?B?K0hSMmVySlJEZUVOK1ZWemVDdEEyWStBSWFsOEg3UWlVWEN0RDZZbXhXM3U5?=
 =?utf-8?B?YURxRnRmOVF6ZUUyeDAycGQ0c0N3OW8zd0lDYTlJYTVkY29qclhYbTR2dUI5?=
 =?utf-8?B?bEpUWUJMaHRMU0NqbTNBYWtvQ1VpZjc2RTZGUHU0dlk1Q282T2poOU5JbnpD?=
 =?utf-8?B?MnF2WjhEVHNuZXBMSnpaYm9BZDhXU1ZKOEt0dWEvRzZDOHdqanQ5QUJpMVdF?=
 =?utf-8?B?SU14NHpqRWxEbXlNUWZ4c1E1N1JOVi9ZajNuMmhmdUxpaGRiYVdkbXg4NS9j?=
 =?utf-8?B?YzUwTE9nREpjS0xrZEhLUTIwVDdtUFFQZ3czekNRdFFvd1lpcXp3Q3RYUmRu?=
 =?utf-8?B?UE0zbHBmcnRnUUVSeXVKS2Q3bzVRZ28xaVcxcmRPY1N2OTBZeEduMmNnb2V5?=
 =?utf-8?B?TlpxNEJ5bWdGYUh0RzFmZ0R6M0lWNlovQkIyNHozc09pUExtOHF0MURBUCtU?=
 =?utf-8?B?ZGU2T2h6emlIY0xIZWowSTZQdHZENFg1TGRoNi91SUNFYUhsWHo2c1hWNHFM?=
 =?utf-8?B?RTNvYW16a2NKUTBzQW56R080NWgvenJxZDd3NnQxS25rUFZ4VE80YUlWaG1y?=
 =?utf-8?B?NVMwb280MDkybFd1eWk5b1VLL0ZIVkszSk1nZkUyNmhYVUZRWDRzZFQvSzM0?=
 =?utf-8?B?R054V3NQbXhSNy9MUzEzeUlhU29CN2x5M0Eydk4xSjYyUmtCYU1ZdXBxVjhV?=
 =?utf-8?B?aFRqcy9GcEFjSTZxZ0ZvSGxKUDR6MGJIYW1abGNXMzIwRERaQVZ3NTk1Ky9h?=
 =?utf-8?B?eXhkZjdyTy9uelEzNXhmSk5YOGtraE1YaDFITzBWM0JlK2FWYTlJSmVQeHBx?=
 =?utf-8?B?d2pCSzNrRE4yejU2dHozLzVxcW5xOGZxUlpSSS9TWkZGU1AraU5oSVZjWnNJ?=
 =?utf-8?B?YXdXdzhyaCt1MVFzSmxOYjdhdUFuejNsMXVYYVFZb2Z4RC9lTlo5TnpRVmhq?=
 =?utf-8?B?R2prR1gxSlA3Z0VtdXhCa1hSTllNL1hqTS9FaGwzQzlLMStzSjVoeW8vZUti?=
 =?utf-8?B?RlZzenV3L3p0ZHlaMW9KQTgySU9LQlJtQVZQVEpLM1RkWFZaSG1BTE9LYkZh?=
 =?utf-8?B?UmtJcE9wb3hTRkl6L2tYTldtWmhoQlhTMk5aa2xiY0l3OWN5WVR3bE9sSFlM?=
 =?utf-8?B?LzRmVDdoNHF2NUNIUDQ2bWhNMVcwMjZlSjN4a0hVcVFIa3doZ0FERmVDanBz?=
 =?utf-8?B?d0FlOXJQMDg0cllBRmFheElTSmIyZmJLdnl0YjIxRDM5eHdZVE1MV2ZZNGVs?=
 =?utf-8?B?cGhtblBqMjliRWdOb251KzBiTjF2b3F6RGdkVUsvODZyTEo2cE5GYjBsM0tO?=
 =?utf-8?B?c24wemxqSCtNR1ZSWkRVQTJxWklqZzUzY3VzdG9rVERPd3ZMVUhSM1R1OXJi?=
 =?utf-8?B?YmxRWndrQjMySFB0RmxMU1RDODYycE8vdzRBSmUrcHRkTjM4S2hyejEvUEZO?=
 =?utf-8?B?UnpSTGgxS0RzNC9POW1OQnpzSEJjVHE5clVmMjBhVnpsdWwrUkdPdG5zdEdy?=
 =?utf-8?B?bHRrWWpGVFBiOVdSaFlhaVpOVkl5bW93My9mVjJIQk56bllSeFJ6S2RnS2JZ?=
 =?utf-8?B?OE80bGdjSWt5WmQ4eVB4SmZ1VGl6WUZaeEVBa1A5SEFyYkVtL1FPNFd2L2kx?=
 =?utf-8?B?b21XMXZoSzBFN09PT3NOWjUyYU1nYkJyY0h0UnQ3bmpIWW85QWVVa2R6VUVZ?=
 =?utf-8?B?S2RRQk0rZFN6TVdZOXlzRUFMV2NxYzQrOTVhTmxRV3UrdWgvRkVjdlNWT1Rr?=
 =?utf-8?B?TG54U282Q2pBZGFrMHJNeTNiRS9wVEJmeXJKVFk0YlFGRktDc0pjMDJjOE81?=
 =?utf-8?B?djIvWS9tbzEyOWREUnFvM1YrZm1jV0RXV21TUnFybC9Bem9Vc3lYbU00K3o5?=
 =?utf-8?B?ZHFhRjJiTzVDMFdqc0hURmxnOFBwUStUMU5iTFJ4K2FxU3VWdWtoRU1IVXFK?=
 =?utf-8?B?dkxGU0NyRDh1RXhUakRJeWo0TUtnenBLdmYwMkFPV3VJZFdIK1Z1ZTg3T2Qr?=
 =?utf-8?B?WG1YVllMU3hvdFJGVG45VE1tVTZXcXFOalF5cUg1dlA2OUZFNnNKQ1Juc0Fo?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D00F15E2E6B5AD40A539E6AADAB71DD4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tJc84h+tnOSRcxKt2OyPOJ3fwn97Ybo17hdCYYCzN0fGj2lOEIsHFRbtMFEqxpRhsZXCUmXiLlOe9nihMnmIfXkjTLaniAThaObKcphhrbkx4/nqzh2gI+QVf8UTa+b4LURmOcY+AdVsmbNv9xK5qFyMthbqIBAk8E+3Zq2oZTl4S8Z4h8pKdCIHY0FHzAbX0SzQLHM7bF6w2LDILXl5mhNAJx+RibC00mEfQ1qOi2aD8bLss+5KbDhtf5hNKEORGmcBRWDP0U5s0/RtY6JBAZzOsZIMsUSgWPo8VstISWMc7k1iRyVSGYPYbHSMyJ3in6nrHwhAmZRZIJO75nZm8eGWk4wkPAYQBRrNrsyphPbfHtz2IZFBpdZDz9zNxGmaPJxHI9N9M9GaloHYpeUqbEoA+Po3LzX47Z9YZ2SfywKohR4zJtnDvWxJJpSXPQx/VTKOE7gFiXYOti0nzMBeERyDnhIf7S/iz5VYCq0T15xR4YUER4jiHxlORYiJokHnsilG5zD7pQDClWwVfg0ULnv2MvCjvLH9dQuwsbKzFZVuEyWvz+KlBRscsJXKhknAcVRQqd0st3ooessKcVZJDnDAOuGGd7bKio/uws3CUGr5A5p0d69v9BiOmxiZYdZG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d32dc9-5476-402d-5c24-08dd8cecac13
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 22:23:48.3152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C01B/gr1j3BQ7n5fWiVes2veAaG7cFvgKC0LIBk6UbJ6gTpGsze9xOd8cNotGailR86hsHaYT4SqrGOuU9MphA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6729

T24gVHVlLCAyMDI1LTA1LTA2IGF0IDA5OjM5ICswMjAwLCBOaWtsYXMgQ2Fzc2VsIHdyb3RlOg0K
PiBDb21taXQgZWM5ZmQ0OTliOWM2ICgiUENJOiBkdy1yb2NrY2hpcDogRG9uJ3Qgd2FpdCBmb3Ig
bGluayBzaW5jZSB3ZQ0KPiBjYW4NCj4gZGV0ZWN0IExpbmsgVXAiKSBjaGFuZ2VkIHNvIHRoYXQg
d2Ugbm8gbG9uZ2VyIGNhbGwNCj4gZHdfcGNpZV93YWl0X2Zvcl9saW5rKCksDQo+IGFuZCBpbnN0
ZWFkIGVudW1lcmF0ZSB0aGUgYnVzIHdoZW4gcmVjZWl2aW5nIGEgTGluayBVcCBJUlEuDQo+IA0K
PiBMYXN6bG8gRmlhdCByZXBvcnRlZCAob2ZmLWxpc3QpIHRoYXQgaGlzIFBMRVhUT1IgUFgtMjU2
TThQZUdOIE5WTWUNCj4gU1NEIGlzDQo+IG5vIGxvbmdlciBmdW5jdGlvbmFsLCBhbmQgc2ltcGx5
IHJldmVydGluZyBjb21taXQgZWM5ZmQ0OTliOWM2ICgiUENJOg0KPiBkdy1yb2NrY2hpcDogRG9u
J3Qgd2FpdCBmb3IgbGluayBzaW5jZSB3ZSBjYW4gZGV0ZWN0IExpbmsgVXAiKSBtYWtlcw0KPiBo
aXMNCj4gU1NEIGZ1bmN0aW9uYWwgYWdhaW4uDQo+IA0KPiBJdCBzZWVtcyB0aGF0IHdlIGFyZSBl
bnVtZXJhdGluZyB0aGUgYnVzIGJlZm9yZSB0aGUgZW5kcG9pbnQgaXMNCj4gcmVhZHkuDQo+IEFk
ZGluZyBhIG1zbGVlcChQQ0lFX1RfUlJTX1JFQURZX01TKSBiZWZvcmUgZW51bWVyYXRpbmcgdGhl
IGJ1cyBpbg0KPiB0aGUNCj4gdGhyZWFkZWQgSVJRIGhhbmRsZXIgbWFrZXMgdGhlIFNTRCBmdW5j
dGlvbmFsIG9uY2UgYWdhaW4uDQo+IA0KPiBXaGF0IGFwcGVhcnMgdG8gaGFwcGVuIGlzIHRoYXQg
YmVmb3JlIGVjOWZkNDk5YjljNiwgd2UgY2FsbGVkDQo+IGR3X3BjaWVfd2FpdF9mb3JfbGluaygp
LCBhbmQgaW4gdGhlIGZpcnN0IGl0ZXJhdGlvbiBvZiB0aGUgbG9vcCwgdGhlDQo+IGxpbmsNCj4g
d2lsbCBuZXZlciBiZSB1cCAoYmVjYXVzZSB0aGUgbGluayB3YXMganVzdCBzdGFydGVkKSwNCj4g
ZHdfcGNpZV93YWl0X2Zvcl9saW5rKCkgd2lsbCB0aGVuIHNsZWVwIGZvciBMSU5LX1dBSVRfU0xF
RVBfTVMgKDkwDQo+IG1zKSwNCj4gYmVmb3JlIHRyeWluZyBhZ2Fpbi4NCj4gDQo+IFRoaXMgbWVh
bnMgdGhhdCBldmVuIGlmIGEgZHJpdmVyIHdhcyBtaXNzaW5nIGENCj4gbXNsZWVwKFBDSUVfVF9S
UlNfUkVBRFlfTVMpDQo+ICgxMDAgbXMpLCBiZWNhdXNlIG9mIHRoZSBjYWxsIHRvIGR3X3BjaWVf
d2FpdF9mb3JfbGluaygpLCBlbnVtZXJhdGluZw0KPiB0aGUNCj4gYnVzIHdvdWxkIGVzc2VudGlh
bGx5IGJlIGRlbGF5ZWQgYnkgdGhhdCB0aW1lIGFueXdheSAoYmVjYXVzZSBvZiB0aGUNCj4gc2xl
ZXANCj4gTElOS19XQUlUX1NMRUVQX01TICg5MCBtcykpLg0KPiANCj4gV2hpbGUgd2UgY291bGQg
YWRkIHRoZSBtc2xlZXAoUENJRV9UX1JSU19SRUFEWV9NUykgYWZ0ZXIgZGVhc3NlcnRpbmcNCj4g
UEVSU1QsDQo+IHRoYXQgd291bGQgZXNzZW50aWFsbHkgYnJpbmcgYmFjayBhbiB1bmNvbmRpdGlv
bmFsIGRlbGF5IGR1cmluZw0KPiBzeW5jaHJvbm91cw0KPiBwcm9iZSAodGhlIHdob2xlIHJlYXNv
biB0byB1c2UgYSBMaW5rIFVwIElSUSB3YXMgdG8gYXZvaWQgYW4NCj4gdW5jb25kaXRpb25hbA0K
PiBkZWxheSBkdXJpbmcgcHJvYmUpLg0KPiANCj4gVGh1cywgYWRkIHRoZSBtc2xlZXAoUENJRV9U
X1JSU19SRUFEWV9NUykgYmVmb3JlIGVudW1lcmF0aW5nIHRoZSBidXMNCj4gaW4gdGhlDQo+IElS
USBoYW5kbGVyLiBUaGlzIHdheSwgd2Ugd2lsbCBub3QgaGF2ZSBhbiB1bmNvbmRpdGlvbmFsIGRl
bGF5IGR1cmluZw0KPiBib290DQo+IGZvciB1bnBvcHVsYXRlZCBQQ0llIHNsb3RzLg0KPiANCj4g
Q2M6IExhc3psbyBGaWF0IDxsYXN6bG8uZmlhdEBwcm90b24ubWU+DQo+IEZpeGVzOiBlYzlmZDQ5
OWI5YzYgKCJQQ0k6IGR3LXJvY2tjaGlwOiBEb24ndCB3YWl0IGZvciBsaW5rIHNpbmNlIHdlDQo+
IGNhbiBkZXRlY3QgTGluayBVcCIpDQo+IFNpZ25lZC1vZmYtYnk6IE5pa2xhcyBDYXNzZWwgPGNh
c3NlbEBrZXJuZWwub3JnPg0KPiAtLS0NCj4gwqBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLWR3LXJvY2tjaGlwLmMgfCAyICsrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
ZHctcm9ja2NoaXAuYw0KPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZHctcm9j
a2NoaXAuYw0KPiBpbmRleCAzYzZhYjcxYzk5NmUuLjZhN2VjMzU0NWE3ZiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kdy1yb2NrY2hpcC5jDQo+ICsrKyBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZHctcm9ja2NoaXAuYw0KPiBAQCAtMjMs
NiArMjMsNyBAQA0KPiDCoCNpbmNsdWRlIDxsaW51eC9yZXNldC5oPg0KPiDCoA0KPiDCoCNpbmNs
dWRlICJwY2llLWRlc2lnbndhcmUuaCINCj4gKyNpbmNsdWRlICIuLi8uLi9wY2kuaCINCj4gwqAN
Cj4gwqAvKg0KPiDCoCAqIFRoZSB1cHBlciAxNiBiaXRzIG9mIFBDSUVfQ0xJRU5UX0NPTkZJRyBh
cmUgYSB3cml0ZQ0KPiBAQCAtNDU4LDYgKzQ1OSw3IEBAIHN0YXRpYyBpcnFyZXR1cm5fdA0KPiBy
b2NrY2hpcF9wY2llX3JjX3N5c19pcnFfdGhyZWFkKGludCBpcnEsIHZvaWQgKmFyZykNCj4gwqAJ
aWYgKHJlZyAmIFBDSUVfUkRMSF9MSU5LX1VQX0NIR0VEKSB7DQo+IMKgCQlpZiAocm9ja2NoaXBf
cGNpZV9saW5rX3VwKHBjaSkpIHsNCj4gwqAJCQlkZXZfZGJnKGRldiwgIlJlY2VpdmVkIExpbmsg
dXAgZXZlbnQuDQo+IFN0YXJ0aW5nIGVudW1lcmF0aW9uIVxuIik7DQo+ICsJCQltc2xlZXAoUENJ
RV9UX1JSU19SRUFEWV9NUyk7DQo+IMKgCQkJLyogUmVzY2FuIHRoZSBidXMgdG8gZW51bWVyYXRl
IGVuZHBvaW50DQo+IGRldmljZXMgKi8NCj4gwqAJCQlwY2lfbG9ja19yZXNjYW5fcmVtb3ZlKCk7
DQo+IMKgCQkJcGNpX3Jlc2Nhbl9idXMocHAtPmJyaWRnZS0+YnVzKTsNClJldmlld2VkLWJ5OiBX
aWxmcmVkIE1hbGxhd2EgPHdpbGZyZWQubWFsbGF3YUB3ZGMuY29tPg0KDQo=

