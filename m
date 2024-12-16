Return-Path: <linux-pci+bounces-18482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0073D9F29DC
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 07:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3EF16687D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 06:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989581C5799;
	Mon, 16 Dec 2024 06:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sEBDpJA5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B01BC064;
	Mon, 16 Dec 2024 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734329369; cv=fail; b=drwnDiuRvXHMjk/ONuq0d8lOJ4YyEt6Om7/KLCeApZdpF9cbJNJRi5vXleIG3g2bVGr/FQMF+PP8H8I+mwxePRDpnvZ6uMfM6U4gFZZcYwf89HrGosJXO9caepwm8MZ1or2qQj8yIJaR6EglFBjha4fVzbfDrkThSKwCwhV4jAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734329369; c=relaxed/simple;
	bh=saFjtsUbgMetMPDf+Ep+isAtWhDW0Zot4ERhxCdvt44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t/G1YsyEBuX4TijW1zCsHG42ZDvjfKBgcrXJgRJ1WikNSRX5s+hzCfZvPnIONY+F1Gce+Fim9w7CR/UFWjvUkcsieDcgK49arx5+LwCtp9UYQR8uzFY1byOHvawGApXZSgKzmaPCcOrlkDKdw5knMpJFC3HqSsa+ZhFRrNh3TRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sEBDpJA5; arc=fail smtp.client-ip=40.107.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSQl/HVPsLmFuSb2NIlXLhNnd6xz57tM59Vh+84J1Wphu6Fz/0uTbYBa2X+QPOnCyLb8K2sgnQwnmq1Jkq51wTiOkXmexjWsisMRzOaNR7ErGrGm/OSdIcvayFPrEhUhDNLNS0kEwhFZJhqtGdaU+0uligTpSQLdZqfxauR8TMH3xNc5pIs1r6jrl/zMPaL4N0GZl6nr4KSb+A4WmHTrLoikXZoH/rl9lOvvbIXlkgySeVX/th6xVBuLKQV6E/vEALIK1Z6BxGHtMRZG7aQ6aRulfXxxJvEJ4/got4c/tItDK7RUGdqGgb5gLYsoLK2/CTBgiQkLKRdZv/O1xQh0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saFjtsUbgMetMPDf+Ep+isAtWhDW0Zot4ERhxCdvt44=;
 b=OwH4JKAs8G937PTebQMEZ3SSxBNFXyf7CceQV2qLEelzM9ZqgD3koXHYzZCvjsofbj5ZGljHCNApcUdnq0wg3EXbC90sSFTGzdvGsLvSW5mTdvubXSauXd8Ed3s4Q1D48Ps08d4a+FJH9ZSG5ESKyfjZ2tX/6nYk732wXSPWKpSHKrzxEGC/RDVPyWdy4eX0d0sydUFsN1zJQ2SvuIX+C3KCFSroG6zB7hZ1wK/hvsxMh5ozcHXSoQSnH+gv125cpqpbGYmPJ5p1ftfDgd2M6Y0ARGVI9WUDYafb20awS+ndEzsLOooiOFFEwDN1XtVZ+PiwXElBiqKFAW+sJm5FFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saFjtsUbgMetMPDf+Ep+isAtWhDW0Zot4ERhxCdvt44=;
 b=sEBDpJA5//tCUe6ft9asQd0rlJxlSLa51U+uoLSNAVoUgR0USh+Fp/aa8KUrOwIU+I7MEL5XENTfxnt2Ai/MU3T9lHHNIidUjpre9l12SyauIsfi7fwB130ec7qGMc7trriQldjwaP3wDYEWQtJ5q86OTqAuJyfE6da5L2be7L4=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by IA1PR12MB9500.namprd12.prod.outlook.com (2603:10b6:208:596::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 06:09:24 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 06:09:24 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "Simek, Michal"
	<michal.simek@amd.com>, "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [RESEND PATCH v5 0/3] Add support for AMD MDB IP as Root Port
Thread-Topic: [RESEND PATCH v5 0/3] Add support for AMD MDB IP as Root Port
Thread-Index: AQHbTSn4T3imW3TNw0uXK9OPbHLm9LLj30OAgASINLA=
Date: Mon, 16 Dec 2024 06:09:24 +0000
Message-ID:
 <SN7PR12MB72015EF007E38D92F5EF61C58B3B2@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20241213064035.1427811-1-thippeswamy.havalige@amd.com>
 <njrgaeqjw4csczzvkf7rqgc7fr5cctgidbstygrpasprcrja7v@oah6glzexhsf>
In-Reply-To: <njrgaeqjw4csczzvkf7rqgc7fr5cctgidbstygrpasprcrja7v@oah6glzexhsf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|IA1PR12MB9500:EE_
x-ms-office365-filtering-correlation-id: ea4dc048-3f80-40e2-4633-08dd1d983079
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aVVxY1hYZHBMN2tLb0F2R2pWdWpHOVhEcGt3MHNwMU9KbWp5VEkvSVJsa25k?=
 =?utf-8?B?MWJvTFdjNi9IZTNDVmhuRVFqVEJtaHN4UEtOdlQwcWxBUkZtbTRGN3VPRitQ?=
 =?utf-8?B?NllGa0x3MmQ0MHZjbEJuYjhOMGk3TzFkUlJEM1hHRldMNC92OHFiOHJwemRT?=
 =?utf-8?B?dE5yV2VkSFdUK0x1aFJBdDFmTDM1dmdYMkZ6N01qU2VreU1jcjh2V21nbWd0?=
 =?utf-8?B?aWZKS3BRNVlqOWhsYlM5ZkNqSnZDVDZMMnpxMjJXZDFYdURIRmlwT3FLUURF?=
 =?utf-8?B?SjVKM0hNUkFWbkVteWcwQ2dYZFI1bWNmR2N4bU1rWVdtNEh1ZE54b2lxdlhD?=
 =?utf-8?B?WmdRaURlcWJtekI1V1dsQXJYTC9uMG93clZwQUpZZjVEekVjSXNFY0RkY0I0?=
 =?utf-8?B?ZFBjYjh1R1RSdGk4OFpuMTl4UFl3Zm9HWGdxTzk5bjVxTmJHZTVjN2M3MHcr?=
 =?utf-8?B?dlRWUXkycW9WY2w5SkFYOGJHYm91WXIzckEyT0tBdXFrdk5IMm1OYi85Nzcr?=
 =?utf-8?B?ZWNGY2lNbC9KWGk5YWVxc2tTZkp6UW5wVW9XbFl5YXZYb0dsVmd0QXA3UERN?=
 =?utf-8?B?TlczY1pIRWNBbWFkSTd6OHY5eG5DWHAxWmdLbjZUVFVDWHpoM0dzU2xXbTBK?=
 =?utf-8?B?bC84OThTM21RUlZ5bkhnWlRmanE2blFkNEoyNkFhUnl1UjRUZXhlbTBhYUUy?=
 =?utf-8?B?UzNoWEJJdVJRV2l5U3o4RXNidiszWG1EdFRQdU9xTkNaaGNreDBPcEd3eEMy?=
 =?utf-8?B?UEhabDFsTjM3M1ZFbGtJUXowamRFaHNKSmJoWDZhNWhzems0bmtRekk0ckRn?=
 =?utf-8?B?eDVYNVpLTjh0R3pyYUN4UGZ4cGc5QlNJSkNNVjJFaHliY3BTVGNjUEI2S3V2?=
 =?utf-8?B?Y3Q1b1hPeDgyeTgwM3dGcEFuM2kyRjBZMWxNMlhyeE10U1dqdGxNOGtwN01n?=
 =?utf-8?B?VEhNZjkyNGZseGdFTXFIVHc5WjVJck8wM3Uvb1pLeWJKLzNkaWduakhsVHht?=
 =?utf-8?B?cHFjREtNUkZmbGVWVzdXVCtRV0x1azVubERPZlNkaUYrSnE1aldwYzhPZ0ZN?=
 =?utf-8?B?N1FtTko4aXNQL3dBMWJLdm9ROWQ5S1hKWUxlaGZXVmVKcmkxcUFlVlpCV2dp?=
 =?utf-8?B?d1pEUHhteXVGbWZmMG1nM053SE5aQ0pGMStHTGRHOHdEQWZwb3NMTTViWko3?=
 =?utf-8?B?UTBJczhSQWxCdkFkYnBWT2FjUHVtWmNwV1ZhbjZWbnZtbVNwYnVVK2pCbkF5?=
 =?utf-8?B?dVM0Ly9XOWY0V2dtQTJ0eWpKcXBLYVlVeVI2WlRCR295Mk9EaU5kUkwvNSs1?=
 =?utf-8?B?aWp5YmYzWXNXckhXL29mc3VzTXl6UUZPMkdCOVJzZ3d6eEhYcVhGNnBPc3M2?=
 =?utf-8?B?Szd6dlFrczVaYnJvVXhxNFVaVklHR1RESTYyRDFOOVZLSVRQQkxuMlVTV1dh?=
 =?utf-8?B?a2RMc3RmZFh4WUxVQ1RRM1IraU5rQmpTR0RnZDNReTNESzdiMnNmZlVzUzhL?=
 =?utf-8?B?d1c2YTJvb01ReDN5YkxlR2F0cENFeXVUNmo4ZlduZXZHUHhXeFBXaDVGc3hY?=
 =?utf-8?B?LzlDTm1Eei9JNnhEVzlWbEdPUjR2VzBITmQrYm5Kc3Rpc0huWmFkK0dpWWd5?=
 =?utf-8?B?d3hwclNISWVoZzhnaGVQbGl5K3c5WllIcm1CWlpKbHBrTndhU1ZFOGJSS0dH?=
 =?utf-8?B?aDZNWUpmZlczY2Z3L0JSdzRoQmVZbWR6NFdKNVBRV3lGNGhCUGtZZERkZU84?=
 =?utf-8?B?TFdLZkZ1Qm1NWDNjUUtQMHprUzJ1MFlLdzRMci9OSnozVCtWcW42Rm1iMk10?=
 =?utf-8?B?UUVUL1l6T3M1ZHFZUkJETXlqeUNtY3R6djBqMGNCc2Yvd1JvOVZxV2t0WlhB?=
 =?utf-8?B?TDBRTXArL0gyVTh3SjFoRmx1ZWZzTWl4WC9VVFl4ZEFXZ1VXKzl6amFMMmhC?=
 =?utf-8?Q?nbAARsI3ASo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVZJbVBXVGduOC9ydE5GRkUvc1ZRQjBmSCtyWk9aa3l5UEkvQ0xQZjFPbTVh?=
 =?utf-8?B?N2ZsWE9LMjF4SmFzK3JSUGNsbnJPNnhiS2N2OWovZVZWTFFYeUxPSGNqVnJi?=
 =?utf-8?B?eXdCRmozZC8vb1hiQlVDL0tXODhMbDN5eGVlbEJlYUd1bk5lZDFmZ1E3NVA1?=
 =?utf-8?B?eHJkMGpDNzA4NTlrSnRVVEVsa0djVE1vZmZFVm96dFl6aTloQnl2dVRaUGps?=
 =?utf-8?B?Lzd4Y1VCamJYM3RTK2lFOGdZa1FpY3JUTjM3Q0k3RFZzMTZsQVloeDJPcU9D?=
 =?utf-8?B?WlFkemJBaHpvNUU4S3NBSmVVb1libFptd1JWaWNjSFI0cjRuZHVKOTNnQ3lr?=
 =?utf-8?B?WlVWdUJFVUUvdVo4cUxNQk8zLzIvM05EYzE1N2YxcnN1bnZzcWlCU0sxdVY0?=
 =?utf-8?B?RlcyWjRKS2NBZHFESDIxL1VWMFd4OGNaY0xWOEh1YzJ3bjRSelZVRDc2TjdX?=
 =?utf-8?B?bnNZcDFDUEtYaStVY244S29BdUN5VmRwUmJDZ0VrSDVnQUYxR0ZGSTdoUmNH?=
 =?utf-8?B?bTBTZ1g2akJwR0NTTVBnN3RWWDFoQXByc3ZDYysxK1JzWllBOGc0MThGamFF?=
 =?utf-8?B?bGxKbnc2cjJDdHU1WFpzY2tueUlqSW0rV2F3L2RuZW1EeWpIdmtpQkFDUlJK?=
 =?utf-8?B?SXVwS3hzWkduMENidm9SOEtQL1c4cVZRN2pqam01VVoxZUF3SDE4VFROL2tI?=
 =?utf-8?B?UkpRWDRBSk9LeEtxL3AyY1d1Rm5CQnRFNjJnUmlHM1M2Y1lYWld1T25QUmtn?=
 =?utf-8?B?Q2k5czYzRVV5ay84RzBadFpSSDhCNFBvZ1U5bXZnWUlONG5DNE90VEVuUWNJ?=
 =?utf-8?B?NG1VcE5aYlg1UUhvZTE0LzRSb2FuZk1kbVJETTdsbStkT3NycWR3Q2Uvczhu?=
 =?utf-8?B?eFV3aEkyU2JpNERPS3FlQytlYUNjT1llMVF6UkgydmVkaCs4VXNnQmsrSFhx?=
 =?utf-8?B?ZllZRGs4TkdpMHdjQ0RzRDIwSnYxUEVRdFBLL21Ea2o5TEt6Y0k3Z2J5UUdL?=
 =?utf-8?B?d0pNUzlYT0VqZkhGaWtsU2ZNRUhjNzh4a0N5V2FBTGVQQS9McEpvZFViUFR2?=
 =?utf-8?B?OTZETkxqaW1XOFRrQ1V1NHhlUkUyemcvd01RVWpWeVhhSVdEUjgwWStCcnJT?=
 =?utf-8?B?cjQ2Y0dXa3cxeGc1b0dpMS9KLzVHMUJnck9DMjVYcGN1WUk3MFBsSHZqS29j?=
 =?utf-8?B?TzFGSUdNdEs0bmZQSkI2cy9KaG1wWDlNU1RsK2ZMaGt1cEducVNkeUVBOHdW?=
 =?utf-8?B?NUdJR2V3QWNzc3dxS3ByQkpzdnJrZXJXMEFNTys3SUlQRldnTTI2eWNJSFFl?=
 =?utf-8?B?SlY5aGlWcEpHQ1lKYTczd0RCOGNTaWJYSzYvT2RYY3FZaW5yL1Q4anMrK3hE?=
 =?utf-8?B?ekt3OWo5ZXdobDE0ZTJBbjk1UHBMT1lEZ1o1Q1N2MFA3U2lBNnBqL3BlaTMx?=
 =?utf-8?B?TEM0V1JNZmtHUDViazQwUnh0RVE1OFFOd29nbmJmOVhNNHNlaGEwYjdVUlhn?=
 =?utf-8?B?RmkxaXZwd0FGaHJieFFYODdKd3VVWGIzMk4wYnExTm9IWWpuR1NLYmdiS09j?=
 =?utf-8?B?ZE5PUGNEelI5VmIxTmhyNzF0ZkhjRGlsU2xoOGx0QTJaQXVUV1hBMDVabGpP?=
 =?utf-8?B?dkpqU29wSXQ1dXJlZngrV2FWSjMzMUdvZmp3Tm96MVdxbjBVYllFdGg1UFZx?=
 =?utf-8?B?UUYxZmttNjNVRkd5dEswRVZsTFlUSHdQV0UzVkJuS3dnaGtldGZkSzZWYVdl?=
 =?utf-8?B?RHhHdmVDZ0s4UXBHVmd2T0hBdXppL2NObnhZQllpc1NHNnZibFh1L2NyMXpt?=
 =?utf-8?B?RXk3UWI4VFBqZ1VxdlJiQnBsRFpRcWlpNFU1REtCNkpiOGhGc1NPZ1JrZGlu?=
 =?utf-8?B?eFBSVEJqZnA3c1JqZkdrVEJyOVV1bnpEUmdqdnBWckFNT1o4Q05YMitMdURW?=
 =?utf-8?B?SUFTbnh4NzhYN1RwSDJRLzRvN3dOZUdVeFJjTm5VZldDTC9rM1grdUdTNzVq?=
 =?utf-8?B?VndUR3VzUmFEU2ROR2JNVnltZFprdTl1TXZMY3pxL29OcXJ1NG9mOVk2aXQ0?=
 =?utf-8?B?aEF1c3p6di9vNkovSkxJTmYxUG5TS0ptRFNoQllkZ3Z1UUxnOTlrK3hOQnNJ?=
 =?utf-8?Q?BG4U=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4dc048-3f80-40e2-4633-08dd1d983079
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 06:09:24.1409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwQUFdDhNDhqhv7SeefagLwQ8V1WBIUis8vg+va5s3TnPOAAAIl4km4Hqrjp2qAobBg94V95poxANXQ9ymyb1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9500

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KVGhhbmtzIGZvciB5b3VyIGlucHV0cywgU29ycnkg
V2lsbCB0YWtlIGNhcmUgb2YgdGhpcyBuZXh0IHBhdGNoLg0KDQpSZWdhcmRzLA0KVGhpcHBlc3dh
bXkgSA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296
bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMTMsIDIw
MjQgMjoyNiBQTQ0KPiBUbzogSGF2YWxpZ2UsIFRoaXBwZXN3YW15IDx0aGlwcGVzd2FteS5oYXZh
bGlnZUBhbWQuY29tPg0KPiBDYzogYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbHBpZXJhbGlzaUBrZXJu
ZWwub3JnOyBrd0BsaW51eC5jb207DQo+IG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3Jn
OyByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVs
Lm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBqaW5nb29oYW4xQGdtYWlsLmNv
bTsgU2ltZWssIE1pY2hhbA0KPiA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBHb2dhZGEsIEJoYXJh
dCBLdW1hcg0KPiA8YmhhcmF0Lmt1bWFyLmdvZ2FkYUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1JFU0VORCBQQVRDSCB2NSAwLzNdIEFkZCBzdXBwb3J0IGZvciBBTUQgTURCIElQIGFzIFJvb3Qg
UG9ydA0KPiANCj4gT24gRnJpLCBEZWMgMTMsIDIwMjQgYXQgMTI6MTA6MzJQTSArMDUzMCwgVGhp
cHBlc3dhbXkgSGF2YWxpZ2Ugd3JvdGU6DQo+ID4gVGhpcyBzZXJpZXMgb2YgcGF0Y2ggYWRkIHN1
cHBvcnQgZm9yIEFNRCBNREIgSVAgYXMgUm9vdCBQb3J0Lg0KPiA+DQo+ID4gVGhlIEFNRCBNREIg
SVAgc3VwcG9ydCdzIDMyIGJpdCBhbmQgNjRiaXQgQkFSJ3MgYXQgR2VuNSBzcGVlZC4NCj4gPiBB
cyBSb290IFBvcnQgaXQgc3VwcG9ydHMgTVNJIGFuZCBsZWdhY3kgaW50ZXJydXB0cy4NCj4gDQo+
IFdoeSBhcmUgeW91IHJlc2VuZGluZyBwYXRjaGVzIGFmdGVyIDUgZGF5cz8gWW91ciBjb3ZlciBs
ZXR0ZXIgc2hvdWxkDQo+IGV4cGxhaW4gdGhpcy4NCj4gDQo+IFJlYWQgc3VibWl0dGluZyBwYXRj
aGVzIGFib3V0IHRpbWVmcmFtZXMgc28geW91IHdvbid0IGFubm95L3NwYW0NCj4gbWFpbnRhaW5l
cnMuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

