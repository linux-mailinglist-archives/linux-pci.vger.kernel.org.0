Return-Path: <linux-pci+bounces-25278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667FCA7B814
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 09:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18EA0171E81
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 07:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F06E18C031;
	Fri,  4 Apr 2025 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MaCuckXN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717E5BA49;
	Fri,  4 Apr 2025 07:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743750477; cv=fail; b=HL0w/hvXClJTen/vKEfe1FLXMm91Po4TOtyi8JMsOWaaQtH0H5LSpdEA50SkaQYQkXnE2g14HrtH+Vz/QEwX7XqZ9GRMRiWFqSp0PoBub8SenxedAmh8zg5VcGOzBZFDNPorNQQ8q2w7Qp3o8u4L7YxJwl1ZtRTO9eTscE7kk7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743750477; c=relaxed/simple;
	bh=uCCavXMKhi9ZTiNfgLS4Ge4VxWHrK6/GbcWCZZGSEgU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CYquOAclm9Gk1D1WdKJJtSvUEulN2Dptd3q1ZjcPCeQUczd4tbA1C1lPoa4IKuBZfJXORsyvWfJpkBchvGOIJzjlwuVFf9T0N9jNkvtYrMotmhubJRuPcw/XDkXYmrpDcxR1X0xtaZsT1ZYmBo7B8jVmNArs2zAd0HGjThUlS5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MaCuckXN; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGn0WJ6HKSzYA5G74E0okicJdiPzwnQxG+gZYRYGlRTGDqM4KTxoGKY75AXMFHTxGoJslXjGRrvNzMq3yu2+GOR/9zNzoTNCLOQ1dSaG3NA9QIPGDt57fMFwcN2QCVJWwlSDCSYjt2cCFI92NU/6nx+zJIifmaQ/ZkENzFjozAGiozEu7KkM91I+9Hk7E59wHyzFZ5xoNuzJLyIaVjlzC+I+nr3Ok7spqeImFCR6tey1bpgBIohMZM+kq6eKfD7x6Au8ED+fBAhajvQ8mdiJT6b0Z3VhlYWIb2XtFq5YSEcfg3tPB+vmWszp9M6o1FvRGSjALQIegK9bqrZ47zzmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCCavXMKhi9ZTiNfgLS4Ge4VxWHrK6/GbcWCZZGSEgU=;
 b=xyB33Kdm+3rIZXm5eBLQr3WfXNSmXmz86Lk0rAQQUwkSLgWKCtV3WNEGqTYSaVMN5eX+f3X8mdnQIRwl+uMFetIfe9P2ICx4JSuvGpIdNdrvht/HnLisrnmC7pC7pHyZVZR61dWKb6f2aw/TLdzGnSkVIngGPHQBmmJlceAXd+CLyKURp6QRncAK5+YxA7f72DZsK3GxN5gKaTvI99MsOzVRC2b2EcF8pqiCJNwJiRQrZWlrk7b0tB3Mbsu81K/WjTErciDlcCpEJe7w0szpGLZKmnwybU2rHnTO4e0af2WcZvaPqxowxELB7RoOERXOayu3XTcATeQrWChBw4AXHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCCavXMKhi9ZTiNfgLS4Ge4VxWHrK6/GbcWCZZGSEgU=;
 b=MaCuckXNR9GFDfa/k6EY94VHf+7G65ETCPUyKVvkiC1CvRuVqLZTtVW3zHpLEYqgnFaBHh1NzsHNJDZul51J1yfoxon6x3mZumY9sD/f24FrvhWkDxIVmnTCup5FvnymbnZ80ZOw1cNmOwnQfYtkTirSvWP7lz5UrqIeELlUZjw=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Fri, 4 Apr 2025 07:07:52 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%6]) with mapi id 15.20.8583.041; Fri, 4 Apr 2025
 07:07:52 +0000
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
Subject: RE: [PATCH 2/2] PCI: amd-mdb: Add support for PCIe RP PERST# signal
Thread-Topic: [PATCH 2/2] PCI: amd-mdb: Add support for PCIe RP PERST# signal
Thread-Index: AQHbngXNCEM0Bzx7+kuW7/tCQKsE7LOFFH0AgA4PGIA=
Date: Fri, 4 Apr 2025 07:07:51 +0000
Message-ID:
 <DM4PR12MB6158433474E7875ADF92ACA3CDA92@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250326041507.98232-1-sai.krishna.musham@amd.com>
 <20250326041507.98232-3-sai.krishna.musham@amd.com>
 <20250326-succinct-steadfast-pronghorn-5fcc21@krzk-bin>
In-Reply-To: <20250326-succinct-steadfast-pronghorn-5fcc21@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c7bcfb83-1103-425a-8588-2abaac89c27a;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-04T07:04:31Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|IA1PR12MB7664:EE_
x-ms-office365-filtering-correlation-id: e5c82872-1726-4f0b-ee41-08dd73476a5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tjdja3JTak12Qi9FOUhaVDNCZk56cXp1V25vSmtTcXYycjRjMmU0RWdreFNO?=
 =?utf-8?B?ZWczUDdEK25WVVNNL0tEUnA2SUNHMXRUdHcxbHQzUDQ2RXpRWGN0QjluMWdz?=
 =?utf-8?B?ZncrY0g5OVgvOHMrYlFFS0pDM3BTSmxuYUhPcm82YVpnTzdDWDcwSlg4Y1Jw?=
 =?utf-8?B?YzZvd1pobUhlUXhsQUt0QXR3ckY5UjN4VnJTS1lSK3lwSmE1TFE2UEkxUzF2?=
 =?utf-8?B?S0lpeHdpaDRwU1VDbGhUV29zVEYzZ3JpdHdXeFNhUC9PaGlBeUFYc05KQ1ZO?=
 =?utf-8?B?cWN6RWo1SFQ4SEpXdVhIcWsxUkxqN1FNOXk5a0FYbkl3REpiSVZuS1BGazVk?=
 =?utf-8?B?MkJ3cWRRRkFvSGtHU1dXUlNyNGRLRUl3dkFJNTZ5TitxWC9aMFdiZEJ5WEFM?=
 =?utf-8?B?Zy9ld1Y4aWN6am1oeExEMGZ5bkhLRkJJYlRHQjNyWHF2eFVBaXBZTFd3QlNI?=
 =?utf-8?B?SkpRMklzVU5URU1PSFlKYmhVTE9McE1LblFMY21jM0dBL09yd2hvNDd3U1Zn?=
 =?utf-8?B?dWlMUlZZTlhnWFVQZk1DN1Nra2VITzNBZytRVS92cjAyY3ZXdnBKWlMrcUF3?=
 =?utf-8?B?NWVHdVVDL0ZtQTZPOE1tVVFDbFVZcTVndjE5SHFqOEpPNFZzeXo3Y2F2c29Q?=
 =?utf-8?B?ZVk0RVpRblFsQzd6UHRWSGVwM3BEQy9CUTMreldwU1BTVmV5NHNQRlNIQXM3?=
 =?utf-8?B?OE5qelFnb3F2SFBVaUNDd0x4OXlzZWYxSG1CejJENm9PNEVkcHJkSm1kZ0oz?=
 =?utf-8?B?MXBiQ1BIcFMrcWJLaVQzRWVJaHNpQkRxeVVaYlFic2daZlVEY3N4M09BdzJp?=
 =?utf-8?B?NFZvMlFXdVhnUXJySEdZZzFuSHArNmI4R3V3RkowdWdCM1o5SEZUOGh0WWpn?=
 =?utf-8?B?VXc2OWQySUdobVZSTThLZmdnYW9NQnVCcW9vWnZ2WXp0TzVOODR3WnNMMG1S?=
 =?utf-8?B?b1ZJcEhHOSswcUdkM2xZblBPV21HT1I0dTJMMVI2OThnb0NtdGNWOGd2bHox?=
 =?utf-8?B?clQxRDlPbi9FYnpKSlZrdmI3cTJBYmYzdVBxb1pzRDY1bDZIVU8xNWJNd0ZP?=
 =?utf-8?B?RzdFbktxcVJIMndJdmwwY0VEWkV1dm1wN3o1dDdKYWZoS0Z5QjYyVmpaZGlG?=
 =?utf-8?B?MGZZZDZJb1VVSWliTmNsQ2kvTmhIMTVsclRodXlQRGtaUXo2N2xONUF1ZXdL?=
 =?utf-8?B?dE5HRUs5U0czaEVWMzIyV1Z2czFqOElsZ2VqTjA2TEJ0SS9TcFNKbGVFb016?=
 =?utf-8?B?YThHNjF2K21Oa281UkFzR1FpNER5eFdhRjhGK09lM1VReEhHeC90K3JYeFNy?=
 =?utf-8?B?QkFHb0FLdnFjQUNXUnF1cE5LSk1lVWhBN1RZZHdGdmMvYUYyejZkNis1SHhJ?=
 =?utf-8?B?Rk42QXZQSzhLbHdYLzYyVm10dzM4VUlNSmpuUVhiYUhCUWtmN1hGTDhwZitm?=
 =?utf-8?B?QU4va2dHS084Qy9LN0o5alBLd0dBNUZYbFJxYWo0SHVyb21lYVJ6cUJuR3N0?=
 =?utf-8?B?SlZNYjRDTUdMQUs5c1VUcG1qWWYrVmlPUE9KdHV0eVI3cDdBcWt3WGlXRGk5?=
 =?utf-8?B?VWtXRnBaR3lTdVhvUFIvUVliaGdHdnBZQjI4My81cDNnUTVQUmdBT3B5N0RH?=
 =?utf-8?B?M0pNTlJXd2RFZy90c2hrWi9FS1Z4clFKYUFnWC9mbzl5MUR1bFFOdlNyWHRj?=
 =?utf-8?B?cEZ3WHJRNXVGRUV1NjdDOEtsQW9xVS9EL0FYc21XUmU5VnBKRG03VGowSVJt?=
 =?utf-8?B?YktXVTVrZlZMQjJWMEp0dHhUd1pnN0NkbytxanE4S1N2SCtmYWtXNTZ6SWMv?=
 =?utf-8?B?RzlzV3VESXRvNFZaTEpYeWNxRE5RK1E1Rzd1UXBhaU95SkZaS2kxVVdRNS9v?=
 =?utf-8?B?cHNPclRJclMzZVdSYXVNRWJ6RFlUV1FIdFFJUWNoNXg3NUIxc0pyMG5xN29x?=
 =?utf-8?Q?/DH+pemuWeR34pxRdIbyW0GH6mRN5+zL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmgyVW13V1p6bm1FOGlseG9pTXpscC9QcWdJdTZzbTBGY1ZkMW93QkgyZndH?=
 =?utf-8?B?NldtalNtRytmV0lZZ0pDam9TM2tnVXRZYkdHdE1uMkdubXVjWXo5S0NhVmJR?=
 =?utf-8?B?YWlDbkc5QTZQNjFaeERoQnkzM0o1S3hrU0FrTDZtNC9uZ1k2VTNXQXpTTFYx?=
 =?utf-8?B?ZHQrd2lZRnEwRVJybndQZlRSMWZZT1o1Mi9MR1JGVFp6MW9wY2FYbXBONXUv?=
 =?utf-8?B?aDlMeUlHQ1pGeHZNYmcwbWUxbGZidW50bjE1TlV6YjgvLzBDV0tEcXJMTXpS?=
 =?utf-8?B?N0xGSFJTWnVUUkhkeVkySzRjYjZwamJSYUNoM2hnclNkalMzdTUydDFBdG11?=
 =?utf-8?B?bHFUbU1aZmIzQW8yZE1ZUkl3aWU3YlU2STBuTGRzNzZaL0JNdXdkRjUranox?=
 =?utf-8?B?akVkay9Oc2xmdnFTZHVRV21NYzlCV3BrYTlJYlVDT2xUV3puRkRCNUFkM0Zw?=
 =?utf-8?B?NTFmVDNNUnQxYSt5RHdUdkhxQnl2MWZQSVdHN0pyRFRzRHhSY2szT0dra1pm?=
 =?utf-8?B?OGVOdHdSTTRpa1RmRU5taUFnV2xjNnI3NzNQUSs0VFcwUkRNTFRBMkFiNzdr?=
 =?utf-8?B?WUFvTm40Ry9pRXRLcjJRakN3WEdDSE5TdmF3c2RIN2lycUxXOXdTVXg4OUhZ?=
 =?utf-8?B?MENOcmUrVGhZOFBpY3FwaXkzaVkyazlqTGR4NUtoZXRpeTNESGFJM3paNm9S?=
 =?utf-8?B?U3BWR3NjVEcyU0grSXdpWGRKUGMyTU9OQmZSMHdwVDdXbVpqSkt5RnVCVERN?=
 =?utf-8?B?aDdSQmRRazRaSUxjUzVLVjJseXhDcC9JbiswNW9JT1hCYWtpWUc5WWllQlJM?=
 =?utf-8?B?NUNUNXNFbk01aGlzVStpT0NMUWhWbEpxZ3RRK3FLcjMxM24vV1Qrb05WdEw3?=
 =?utf-8?B?ZlNBZmIxa0dFVXp4ZjVOdWFVZURXcjk3YWJvL1puOXpmaEVPM2ZYSFQwZW8r?=
 =?utf-8?B?enpyYTBhSnFlUGJaOVJ3NE9QbjNnM2JsYUxBOGJhMERDTUE3Rlh5aUNlZWN5?=
 =?utf-8?B?NFBGdTlvMWliOWVkQVhydGVYbFVsZDhJaGYxRDFmRmIwbDZUL2MvVmVUQkxw?=
 =?utf-8?B?SDY0KzJzTEVFYUNmZ2FHMUMzOXRIWUJUOXJQUmZKM3Q4dkpiaFdVK0pkTE1G?=
 =?utf-8?B?T3NGRitmRGZJb1ZFbkRoTDlrVXNLeFpmK2lsVEoySmYrQ1E3cmVneVZiQnFC?=
 =?utf-8?B?UjZJS0VOdVBVYTRwUEtYM3RwUGNMWks1U05VMW4wWXY0ZFYvaHROckhCa3NW?=
 =?utf-8?B?NmRBcjFDZ1Y2R1poQkFHWDZjL2pHdzhLUHBxNDc5cWFqTGlEdUNJTUN3YXhI?=
 =?utf-8?B?dGwyZlNPdEpGU2JXWmM0QUNFYlpMM1NqZ0JqdFprbWlIZlo4SGkzcEdPb1JN?=
 =?utf-8?B?Z0hQWGFHd2VlMEIweEt0SDJ0cXZFQjd3MG9FRVYyMjhtaVFFLytYM1JwYkdX?=
 =?utf-8?B?QVBNWVVTU1hpcW1lZGZqVWI5VEtET1dRZmttM2lMYzY0Z0o1WEtjNUl0ODdp?=
 =?utf-8?B?U2RWSVV0cVltV2pXV1BjbkxwWE5xZklPWTZSU3d2bEViOVBUN1ZFY2VTNFR4?=
 =?utf-8?B?Z0tIZlVXeDh0SldRd0RJWUwzLzZ4aVBJSFE3cVByU2dNMTYyQXhSM2NIYk9Q?=
 =?utf-8?B?SURoSktqeTBzeDdGb014S25pWllwTFlQUmFnWU5ralF3QXdDQitBK3RRWTI5?=
 =?utf-8?B?Wm9IT2E4bmRqUGxVdXZZYmxPY3NQWTF3WE9MQUZOWVhqOE5Ra3FyL0NzUjZZ?=
 =?utf-8?B?MFlrMEZBd1Arb3dtWEF1aytoSHAvdy9hN003TWJzcGV1VEZva1RubEE2RHRk?=
 =?utf-8?B?NzBkQ2R0RktlMjFWbnZVVmNCVEU3K1M0SjQwUlJ5amVxb3M5OGphVGJFZERk?=
 =?utf-8?B?UUVoWnpGN0pVbmEwOWpJSkl2QXM5bGhoUjNxUlZ5YVgwQVFnSktNMG4vdUdE?=
 =?utf-8?B?dzNvcDZRMy94OXBDT2RnOHArdlh3K2w2c0dSWHZtMFcxMDNvVWpaSXBCNmk4?=
 =?utf-8?B?ZG04OGJNUmxZMDd1aHRiVWQ0dlZTV2ZOYlVxNTFOU3paL2dxY2JmMjFVdDlV?=
 =?utf-8?B?UU04ZTFJcHFlOU9BaWdhSWZuUzgxL2tCS3R2SHA0MnlyOXg4aTdMQ0ppZ0RS?=
 =?utf-8?Q?xhVQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c82872-1726-4f0b-ee41-08dd73476a5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 07:07:52.0073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T8h0j0u7eu5vDiqAO5xP74CfONg1Hm/Lv7UMo4YvBg++X9fwT579BAKLRue+zXpvJ/9pyurgxzQ7//rLiFBSow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5
LCBNYXJjaCAyNiwgMjAyNSAxOjUzIFBNDQo+IFRvOiBNdXNoYW0sIFNhaSBLcmlzaG5hIDxzYWku
a3Jpc2huYS5tdXNoYW1AYW1kLmNvbT4NCj4gQ2M6IGJoZWxnYWFzQGdvb2dsZS5jb207IGxwaWVy
YWxpc2lAa2VybmVsLm9yZzsga3dAbGludXguY29tOw0KPiBtYW5pdmFubmFuLnNhZGhhc2l2YW1A
bGluYXJvLm9yZzsgcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9y
K2R0QGtlcm5lbC5vcmc7IGNhc3NlbEBrZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgU2ltZWssIE1pY2hhbA0KPiA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBHb2dhZGEs
IEJoYXJhdCBLdW1hcg0KPiA8YmhhcmF0Lmt1bWFyLmdvZ2FkYUBhbWQuY29tPjsgSGF2YWxpZ2Us
IFRoaXBwZXN3YW15DQo+IDx0aGlwcGVzd2FteS5oYXZhbGlnZUBhbWQuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDIvMl0gUENJOiBhbWQtbWRiOiBBZGQgc3VwcG9ydCBmb3IgUENJZSBSUCBQ
RVJTVCMgc2lnbmFsDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20g
YW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0
dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gV2Vk
LCBNYXIgMjYsIDIwMjUgYXQgMDk6NDU6MDdBTSArMDUzMCwgU2FpIEtyaXNobmEgTXVzaGFtIHdy
b3RlOg0KPiA+IEFkZCBQRVJTVCMgc2lnbmFsIGhhbmRsaW5nIHZpYSBJMkMgR1BJTyBleHBhbmRl
ciBmb3IgQU1EIFZlcnNhbDIgTURCDQo+ID4gUENJZSBSb290IFBvcnQuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTYWkgS3Jpc2huYSBNdXNoYW0gPHNhaS5rcmlzaG5hLm11c2hhbUBhbWQuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFtZC1tZGIu
YyB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1hbWQtbWRiLmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
YW1kLW1kYi5jDQo+ID4gaW5kZXggNGViMmE0ZTgxODlkLi40ZWVhNTNlOWUxOTcgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1hbWQtbWRiLmMNCj4gPiAr
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFtZC1tZGIuYw0KPiA+IEBAIC0x
OCw2ICsxOCw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9yZXNvdXJjZS5oPg0KPiA+ICAjaW5j
bHVkZSA8bGludXgvdHlwZXMuaD4NCj4gPg0KPiA+ICsjaW5jbHVkZSAiLi4vLi4vcGNpLmgiDQo+
ID4gICNpbmNsdWRlICJwY2llLWRlc2lnbndhcmUuaCINCj4gPg0KPiA+ICAjZGVmaW5lIEFNRF9N
REJfVExQX0lSX1NUQVRVU19NSVNDICAgICAgICAgICAweDRDMA0KPiA+IEBAIC00MDgsNiArNDA5
LDcgQEAgc3RhdGljIGludCBhbWRfbWRiX2FkZF9wY2llX3BvcnQoc3RydWN0IGFtZF9tZGJfcGNp
ZQ0KPiAqcGNpZSwNCj4gPiAgICAgICBzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gJnBjaWUtPnBjaTsN
Cj4gPiAgICAgICBzdHJ1Y3QgZHdfcGNpZV9ycCAqcHAgPSAmcGNpLT5wcDsNCj4gPiAgICAgICBz
dHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsgICAgIHN0cnVjdCBncGlvX2Rl
c2MgKnJlc2V0X2dwaW87DQo+ID4gICAgICAgaW50IGVycjsNCj4gPg0KPiA+ICAgICAgIHBjaWUt
PnNsY3IgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKHBkZXYsDQo+ID4g
InNsY3IiKTsgQEAgLTQyNiw2ICs0MjgsMjQgQEAgc3RhdGljIGludCBhbWRfbWRiX2FkZF9wY2ll
X3BvcnQoc3RydWN0DQo+ID4gYW1kX21kYl9wY2llICpwY2llLA0KPiA+DQo+ID4gICAgICAgcHAt
Pm9wcyA9ICZhbWRfbWRiX3BjaWVfaG9zdF9vcHM7DQo+ID4NCj4gPiArICAgICAvKiBSZXF1ZXN0
IHRoZSBHUElPIGZvciBQQ0llIHJlc2V0IHNpZ25hbCBhbmQgYXNzZXJ0ICovDQo+ID4gKyAgICAg
cmVzZXRfZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKGRldiwgInJlc2V0IiwgR1BJT0Rf
T1VUX0hJR0gpOw0KPiA+ICsgICAgIGlmIChJU19FUlIocmVzZXRfZ3BpbykpIHsNCj4gPiArICAg
ICAgICAgICAgIGlmIChQVFJfRVJSKHJlc2V0X2dwaW8pID09IC1FUFJPQkVfREVGRVIpDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRVBST0JFX0RFRkVSOw0KPiA+ICsgICAgICAg
ICAgICAgZGV2X2VycihkZXYsICJGYWlsZWQgdG8gcmVxdWVzdCByZXNldCBHUElPXG4iKTsNCj4N
Cj4gRG8gbm90IG9wZW4tY29kZSBkZXZfZXJyX3Byb2JlLg0KPg0KDQpUaGFuayB5b3UgZm9yIHJl
dmlld2luZy4gU3VyZSwgSSB3aWxsIHVzZSBkZXZfZXJyX3Byb2JlIGluIG5leHQgcGF0Y2guDQoN
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KUmVnYXJkcywNClNhaSBLcmlzaG5hDQoN
Cg==

