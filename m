Return-Path: <linux-pci+bounces-35658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D2CB48B0D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 13:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71281896630
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 11:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8DE2F83C2;
	Mon,  8 Sep 2025 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="XYvGuQ2H";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="11ufIK23"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA88A945;
	Mon,  8 Sep 2025 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329429; cv=fail; b=K3T2B0MTAjHobi5CrVQD0uy/KyKW5X9+I83+8XdijntUV1X6bWOT92fKR7bSIW8nm0CDx8KQTpbbyu2KxC0xRzExxLADuvMPv53cdzMODQG/XunUe73TthOVyeG81exKFd+cFEQvOMBIiJnd7OumgjHNPHIiIYoceqFk6gt5XWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329429; c=relaxed/simple;
	bh=ZDtUY2jEc+s+fZ/kaMCfx0gA/x8K1rRWOUZQ5/Z4IIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E9JGjeluUdHjIQ3f7tb1xjEOIMS5MEekTmjRntGj1udUiQ1J/9si3uNSOskG/cjjYYS/xbbz9HSuCxnuSnlb4ulsMoG7E/k50VHnTeeTdIkSH5ddNCSOc0zGX8/M4idMbKGvCMD40KCzxajE27YURICcmUpvWsNczLhRBSvUiKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=XYvGuQ2H; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=11ufIK23; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5887U21D022269;
	Mon, 8 Sep 2025 04:03:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=ZDtUY2jEc+s+fZ/kaMCfx0gA/x8K1rRWOUZQ5/Z4IIA=; b=XYvGuQ2H7dZ+
	3TRuurdCL4l7x8wL7V79Jo+RX7SeSPlW4TU6TTaVw21tbMzRJm9RCyz4XJm/6Ost
	NUg8WaxP7zhVBtS6T47S3qE6r12TiH6dlTchyMaEClrLgHD8qjUc2J+Tbe9tiXoU
	9xRmor+6ubG0/+Ry/+WC4wcpNALf20I4DfaTdrVjevpPRmaa+BY/c4mfY0vT6oRc
	Mwk4bMK1lszgOuSY/8y58fZY51Cx23uSPPuP9m8O9sV1FGuLPvr2wwki5XvwyQm8
	2frdGF8GAJqjLEpPXu44egqtcNaHCWqINQG4LHnELKeu9d/rYZ55E676WsJgxca2
	Ukjy9CETHA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 490ghxpj8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 04:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djsig3yKkyk5PcEAIy+WtmWgCt+2czwETWiwpCeJXpNMwCRyb949pZelDHOr9wHsdhb2mJny8AbedA3ss2Si2XFCeAuFIg2C1Tx8YfI99hIoWusOfPbckF2Yn6rL7qCg4F8PnU0PnQhiLLul3yyOrK02ihaCpmIaer7J+vFtmmOYr/mVmli9QI/mhkURt9fyVmt/uS8ObL4lNrkHL5RVm+raW50X3Q5tt+tMILzBI1Fq+GSWmvX/qDsPhq9oJaRD5XTkESiQ/Z5TFO0VHnHQvhVFkj3fSM6CuPDH/uojSQieZf3h3pFEGgBRUF7+cbrCVV62LWCPJ9pkU4VkejIgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDtUY2jEc+s+fZ/kaMCfx0gA/x8K1rRWOUZQ5/Z4IIA=;
 b=usX0C1lp6sK8jMN5ijLpT3YTaWyETJt6KDnVsLQgIgBhljgyShBRRtx815MsB8wqyQteGfgBIkHxJLEj/ogLviVzBa7xoF49IBX5erOwOo7VkHK9cYZnNPqLdsK7SzyOAnUO6jqVAhQtjL/9PyCng1iMVKUEX3ScybMS1RAfeh/DHQ3ZoatUOFZjuWTv4sPguaDHA/adsOh+nn6fMASlZOdxRO1wFTeWPfFncSzvybbuEdgUxJPRz67kAt4GR2mqzDf06Xop+LQbUSuJKnS8C4XNHxLWtkZqZ3LYPxvUcfw2FPNOXbG8kmf/OMKiOk4O5vqQkVnG0+hD/sGWIqlU4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDtUY2jEc+s+fZ/kaMCfx0gA/x8K1rRWOUZQ5/Z4IIA=;
 b=11ufIK23ghiA/EGGzY99fN4aUOEgHYJAecj8pyBzxc/JWnxujytNmlwnHcAiDNGl0UcnDkXS9YhAM82E92FZ2UapL3ywedOT6Wt2g4QPWxJx+sUrzJgtzh2+GwxpJymzh/+kxWkIWAdZ8tQOglnLipFIvedsyZKwVVrKzvaNBIM=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by SA1PR07MB8465.namprd07.prod.outlook.com
 (2603:10b6:806:1ac::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Mon, 8 Sep
 2025 11:03:20 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::7cef:10c6:11b0:cb05]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::7cef:10c6:11b0:cb05%8]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 11:03:20 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        "hans.zhang@cixtech.com"
	<hans.zhang@cixtech.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>,
        "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "fugang.duan@cixtech.com" <fugang.duan@cixtech.com>,
        "guoyin.chen@cixtech.com" <guoyin.chen@cixtech.com>,
        "peter.chen@cixtech.com"
	<peter.chen@cixtech.com>,
        "cix-kernel-upstream@cixtech.com"
	<cix-kernel-upstream@cixtech.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 04/14] PCI: cadence: Add helper functions for
 supporting High Perf Architecture (HPA)
Thread-Topic: [PATCH v9 04/14] PCI: cadence: Add helper functions for
 supporting High Perf Architecture (HPA)
Thread-Index: AQHcGyHFmbVf6Uw3pkeQnm7HTJ+DirSJHwQAgAAK1KA=
Date: Mon, 8 Sep 2025 11:03:20 +0000
Message-ID:
 <CH2PPF4D26F8E1CF8D94B3CB2F45EC7E158A20CA@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250901092052.4051018-1-hans.zhang@cixtech.com>
 <20250901092052.4051018-5-hans.zhang@cixtech.com>
 <dyqe6bczkzfrd77ixwuydclak2tfvkno6def77omg6nfzod2lr@ykj6b7npzbxs>
In-Reply-To: <dyqe6bczkzfrd77ixwuydclak2tfvkno6def77omg6nfzod2lr@ykj6b7npzbxs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|SA1PR07MB8465:EE_
x-ms-office365-filtering-correlation-id: 48306a77-8fee-4664-2047-08ddeec7525b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUlDb2duZjhzNFdHNVhLaFNoaHltSDlXbWhrYnc0U2ZZUE50WTVhZE5OeThp?=
 =?utf-8?B?MHo3ckhSM2JzaE0zMTk1dEh3NXJFUVZvV2ZqT0F2eWJyQkdZeFhXSTBJVzZp?=
 =?utf-8?B?c2tEbXVkWE5LYXJSZWJKTTBGNlgxemRuakJNY3hqTFhZb1FjN1lxcVdEOTJZ?=
 =?utf-8?B?Y2xaeDNISzF3am5MVnptbFo3UjQwZ2ZBWGxlZE0yVEN5b3pzUkhKNlFybmhj?=
 =?utf-8?B?eXhDbkJLMEl4ZlJrL0JRK09pQ2pSaFN4bXlKNXRweUpaOFA1V3BRcFF4Mytv?=
 =?utf-8?B?VjFDdXU5U0xZUWhiMXVOczYyZVI3S0kzVjdHaEJjcE9CcEh1bmcvb29aM0JY?=
 =?utf-8?B?M2tjckFGam51U3IwOUdrM1dDN09ZRFVVbXBqV3RSNFdxWVdNaXY1VXR2Rm52?=
 =?utf-8?B?T2NuOXdmbGVOZkhjMjMrNXhFckN2R3RnNWdBeXVZeUxyNGJsY3JnN1EzVnBw?=
 =?utf-8?B?S0JmcnZITW5HVlpZU08xRjhTUFNKeGxiR0tjOUZjSzhiY1N4d09pTkJJcm93?=
 =?utf-8?B?cVlGNXgzNE5pa1QzYlFPNS8rVzgrckJ6N0RPaFJBbW45R2k3TU9UK3grZUpz?=
 =?utf-8?B?LzBjNGxVOUhHUFg5Tk53bVdqdTNQUkxLZEU2Qi8wamdsanZidC9yZ3dVazNV?=
 =?utf-8?B?ZjY1Y2U2TVFaWEJKNEdzRWs2aDFYNVc3S2syTVlCdEMwNE9wZGhyWi94K3JM?=
 =?utf-8?B?REZYdVhtc1I0UzFCdkVVVk5OQzJYMGs0ZGhQdGlVMlhWWmtkaFkyTW5YdFNv?=
 =?utf-8?B?Qk9HVmppbS8yMTBwK1Bsa29QM2hJY056ZG5jMURWWi9oUk5VemljZHZ3NVlq?=
 =?utf-8?B?TTI4RGxGbmc2c1ptb0wvSmRyTm43TXlQZUZrQU5DSWlCRUN4dGc2K0pKNzNS?=
 =?utf-8?B?TUtQb1pHRHZZWXJwd2tJaUo2ZFJUYmdqY2ZnSkQ1WGRhT00xV2VVSGE1ajBn?=
 =?utf-8?B?U3BaOFFpNGpCQVlHUElCUWVNSFBLZk53dGpSK2JWaFVRbVJaZm1uRGhHU1la?=
 =?utf-8?B?U3FCUXlrYUQ0c2k3QXdGZUFOOW45SENaWll3aVJZdE5zeGRsTVpkdXBld3Ro?=
 =?utf-8?B?ZWM2U0o4aFVKWGZ2TVp3MGNudTN6bzBWUzE4NVMzUWo2blEzMVVRSE5FUnRp?=
 =?utf-8?B?cTFUTEc3WnJTL1VSb2R6RTFMenF4M1A4NmNmWEtmSm5HaVdPaUNqWUF4aEx5?=
 =?utf-8?B?QjhCTG1QTHgrZVkyQlV6RnZZRjV5T3N0LzVjM2pyQ2t3RUZ1MzQwSE5yaVE2?=
 =?utf-8?B?dUQ5SmoveDZndENiSGtvWW90Z1RoTEk3emxxR2k0WnkwNUpTYkdBbkppN3NM?=
 =?utf-8?B?bmhSQnpWVW9rZ2JjUy9nNHQ4QzRhODdMRmh1bWRuZzFzYllxamtUNVBIN1Zs?=
 =?utf-8?B?bU5KSkFCSWpFSXlHQlRNdnBEdVpxSHNnUDlqV20vWTFQRVpvcFhUVythMDRS?=
 =?utf-8?B?SjFKdEZ0c0JSeWhXUENBSnhWUWJLNVlHQ3B6V292U2gwSFhUM05id2l5dHJW?=
 =?utf-8?B?dGU3cGJXZGR5VTZ4c2NraDdCUVgvYndvZzhObDl1SCtISXNSVXBONHBlTnZv?=
 =?utf-8?B?eG5yUW02QWgxNGRpZEEva1hENXJTNFBKV3BnaTlQNU5mdWVtUHVpM2REUTFk?=
 =?utf-8?B?SGZ5RlNXL3ZrL0kxTi9NV284VnQrU2U4TGNtemIyeld3ZlI3bjFQV0lRZi9j?=
 =?utf-8?B?cTZVRE9mUGpCTDBQMlZuVm9qanM1RVNFWnE5RXMvN2dnVVRrZ2RLTUgrMVp3?=
 =?utf-8?B?amZHWFR1RnhTdVBGK1VZUzlzRUhQUEtFQ0pxYXhvbVpYRDN6NVVtZUVMWGFO?=
 =?utf-8?B?cnpwRXA5SGFCOFp0Z2tMNUhkOG9IekF4bnM3dDExa3NlOU1xamk1Ui85S2Uz?=
 =?utf-8?B?QVZ3bWhleTNiYUNVYkZMS2ErWHROTmtHdW1aaHdzemtSTDY1cndYcFFqc3lU?=
 =?utf-8?B?bUZJWDBFMWFxZmZsTmtwKzVOeFJqanVjeHBZU2RORkNMdUlQL1ZFUGNSNzBG?=
 =?utf-8?B?MjFBUmVXY1l3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWJ4K2VvRTdYMDBSWDBXNFZiU1NmZzQxUncxcnMwZlEvdzJIb0hlbUMzalhO?=
 =?utf-8?B?emRJRTVkWmhmazR0aXp2VVhoQ0h4OHVDaDRTV1U5UmJmSGdhUHRHM2NwS1hK?=
 =?utf-8?B?UWN6QTBEaG1uZURRK0V3bjdJVUR4NlR6b3gwWmx2RGllRkYvL3lBeS9SdFJk?=
 =?utf-8?B?bHNTM3JYZTg4enJ2TjRxcmxWL0NBU3Rxa0FlRVJUbFM3YnhqVW1sUCtkTURQ?=
 =?utf-8?B?bVNBMVJEUlgyTU1YVE5MRm5kWThrTkRRYUtZZi81SENsbm5NTEZTOExrc094?=
 =?utf-8?B?d3BFZUdtMHNOeUxYT3Z1ZmRobTdxSzFpb2lWODN1emI2bENuY2tkOVNOMXBj?=
 =?utf-8?B?ekJJVWo5WjJ1Q2VOU0RhTk93L1BoUkhvV0d4bDRBRS9mSGM1OUhPaEdOaS9y?=
 =?utf-8?B?dVpuTkVGOWZIU1FMMkJSczB4SjZhbkE2Vk53VzZibjQwbjNoaSsydDIxQnV6?=
 =?utf-8?B?MHlZS1dBa2YzWmxEbVRFU1FtMW5yTlIzTE1qaWxwVjkzck1BSnVoK0RHN2hW?=
 =?utf-8?B?RjF1VHlQQkoyS0tPUjVjV3lYTE5RNUI1MWZoYzZITmw5aVBMVEVRcndMa21t?=
 =?utf-8?B?ZDNHNWROODZzcGhPWW5ZNmF5dFJOSmhiTk5YVjZzNTlac3d6SzhYZHp2UnNO?=
 =?utf-8?B?VnhZOWR2NnJFeTBkSU9oUUsyZHl5dk5lS2FaVHJSTGUzSEpENnhFS0x2aWEr?=
 =?utf-8?B?SHdjYmk4SUc5bEpjMWZRMFNPa3VpeGpOcU1jQ3hWTlZKUW94TE9vZEt0VnVr?=
 =?utf-8?B?UWE1WnYvcnFkWnFYeXp5N2dJYjIvdTZtelFGYngvbnZtcGxSYUxHMjBnTDJJ?=
 =?utf-8?B?aDJMWFBhWlZ2MkcwNWZoTlI2TW1ib1NKSVhDZUlQVUh6bXVxVlZmUDIrMzUz?=
 =?utf-8?B?dkxEcDUwbGNIUmU1cVBsY1ovbFFrYmFhSkV6OS9ON0pyeHk1dG52dExoMHVS?=
 =?utf-8?B?ZEJ3VFdjY3J6SFY3blgvQlFIblRlMHhxYzUrdjdrQ0tLNmRmVjFkeVljWDNJ?=
 =?utf-8?B?ZnlDbjh3K3BacnllMWM2UDNWNC9kY1BxUmprRjNsdjlHenpwbExrVVc2K1Rz?=
 =?utf-8?B?L3NrV3VmeXNDUjhHRy9ET3JpNEFnQnRoT0NkeW1MK1dVVmUvanlTbUVTREh3?=
 =?utf-8?B?bExVekZ0NmJEUStqbmxzS1Z1OStpeGJGY0tnYWxDTmlBWFpyM1ZEUlJmZDM1?=
 =?utf-8?B?WitVREsveFYwNlBVQU0wZVBuMS9NZFk5Y0RhdUZNcHI4dEVRQ0Z5cEhPWXJC?=
 =?utf-8?B?S2hHRkJUWHVBa3pzeVF4ZVV2Q3QzbmZlNXFVS0RiZFdVWjl1YlpmOHdHQmVD?=
 =?utf-8?B?Z0JSSzFuSWk4c1J0TnovcXl0UldiUHcvZ3VadDcrb0ViMlc3MFRuandOa09M?=
 =?utf-8?B?cnVmb3ZiWDEzcWF1aVF4ZWZIYkNSbXlweUo0bERYcGdva3cyeE8xQkJRT21h?=
 =?utf-8?B?d1ZsaHcyZlJlY21LcFNaY08vZEY3L0s3UmhnNllRRHNSdWxnZThWMjc1SWhF?=
 =?utf-8?B?SnR1SUppQlNNYlJVS01saDZHY3lTWHF3V1B6VkZoNjNrQmVVWStoa1o1Y29z?=
 =?utf-8?B?VGpENW1PckErZmY1bGltb0ZxSU5EZmsxQklLa2M1WXdzTzYzajd2M0lnNW9k?=
 =?utf-8?B?eURuRnRSY3NXRU9BR21sajBEOHgwMWJDM2tZOG12RjczanVLeVZUbFhWT0tu?=
 =?utf-8?B?VGl0U25NVE0xWnVCTHdSelZOeEwrZkc1bFFFTmVmb3plWUI0anZKVm1pYnI1?=
 =?utf-8?B?S0FUbE9jZW45N0dkUVFBdnJUQ0JmTWgvZXB2Vk4rOENYY3JVM2Y5TmZZczFh?=
 =?utf-8?B?ZXRQUzlMZ0dCdXd4UWgyWXZoZ2RyZGFjc3NYTE56TitiV09Hc1NZRzhnanJS?=
 =?utf-8?B?ajE2OWxITnBqMGswVFVvM2JBdUF4R1dkTFcvY3h3dmlUVWh0cGhENEZwTVhs?=
 =?utf-8?B?WDZDYTgvQU53TDlDUUpLeElCQklmWCtuaFB2bzlMQ1NaeEpDQmVWZzN0WUxV?=
 =?utf-8?B?NmtNbjJXUml4bEFXMkxVWndlOXkycXBSVlhYVVI3Ym5naG16RGIwS1g4KzVY?=
 =?utf-8?B?MGJQdHJucWdvTmtUM3lkZUNDc0U4eUY4VjBvVWF2Tnpxc0ZIeTRiSVFQeHlH?=
 =?utf-8?Q?oCi6EONZ5YLROZTidiW3rqu0y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF4D26F8E1C.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48306a77-8fee-4664-2047-08ddeec7525b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 11:03:20.3610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RiGm37+aKt7rXc9ON7y3KLyrLcZk/DZjUMT4ujWBnOU9/2uTLg4BXseie3RyUXU81/VxeeNmUTC9KZBsQeIfvBkc858vBaimLMQ59Fyk140=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR07MB8465
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDA2NyBTYWx0ZWRfX+jHllQEtAYV0 YEbiWoqMYjYhSLpxVDocdfJZWsowvlPOwRSLiBLJNE8m0/lkJkSk4gu8FxHCwpD90FjmlQOgYbr XDi23/M6iaQeL/sUYONW4AnIjDA8xnf0uCXjq5z7JfuMQ5eANuX42ZHhbk1R1n1IRQmxykNmazB
 pweC8kEly3EeJkM2Bfmy8/YjI4gdH+Qma914FO1LftADmdPTSzzbYKkS5kTAETx7XuFE/VbMF8D WfCHNMLAg5T221muTF0r0yd475Pqv2xlS8OBs9OBltEiCz4+AZpeNL73mbScS0GmXcODSrmuX8m GnC6avkfn4aGAUFRuRKvqubpReJB9Ub/kV/QtNkXk2cASoU8JSlLrpB4td+WwAAhVK1XuWZrqq1 XZyLmzRV
X-Proofpoint-GUID: Wen9E8rJ8BVXMYShtlx5Aqheapn04o95
X-Proofpoint-ORIG-GUID: Wen9E8rJ8BVXMYShtlx5Aqheapn04o95
X-Authority-Analysis: v=2.4 cv=dKWmmPZb c=1 sm=1 tr=0 ts=68beb7fb cx=c_pps a=KpAYtidZDBXEQYHgHtvmiw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=Zpq2whiEiuAA:10 a=LMKeIgcfiVWqhP9aApAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060067

DQoNCj4NCj5BZ2Fpbiwgbm8gbmVlZCB0byBzcGxpdCB0aGlzIGludG8gYSBzZXBhcmF0ZSBwYXRj
aC4NCj4NCj4tIE1hbmkNCj4NCg0KSGkgTWFuaSwgDQpTYW1lIGNvbW1lbnRzIGFzIGVhcmxpZXIg
cGF0Y2gsIHdoZXJlIGl0IGlzIGEgdHJhZGVvZmYgYmV0d2VlbiBtb3ZlcyBhbmQgY2x1YnMgd2hl
cmUgcGF0Y2ggc2l6ZSBiZWNvbWVzIGxhcmdlLiANCj4+IC0tLQ0KPj4gIC4uLi9jb250cm9sbGVy
L2NhZGVuY2UvcGNpZS1jYWRlbmNlLXBsYXQuYyAgICB8ICAgNCAtDQo+PiAgZHJpdmVycy9wY2kv
Y29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS5oIHwgMTExICsrKysrKysrKysrKysrKyst
LQ0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgMTAzIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNp
ZS1jYWRlbmNlLXBsYXQuYw0KPmIvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUt
Y2FkZW5jZS1wbGF0LmMNCj4+IGluZGV4IGViZDVjM2FmZGZjZC4uYjA2N2EzMjk2ZGQzIDEwMDY0
NA0KPj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS1w
bGF0LmMNCj4+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVu
Y2UtcGxhdC5jDQo+PiBAQCAtMjIsMTAgKzIyLDYgQEAgc3RydWN0IGNkbnNfcGxhdF9wY2llIHsN
Cj4+ICAJc3RydWN0IGNkbnNfcGNpZSAgICAgICAgKnBjaWU7DQo+PiAgfTsNCj4+DQo+PiAtc3Ry
dWN0IGNkbnNfcGxhdF9wY2llX29mX2RhdGEgew0KPj4gLQlib29sIGlzX3JjOw0KPj4gLX07DQo+
PiAtDQo+PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgY2Ruc19wbGF0X3BjaWVf
b2ZfbWF0Y2hbXTsNCj4+DQo+PiAgc3RhdGljIHU2NCBjZG5zX3BsYXRfY3B1X2FkZHJfZml4dXAo
c3RydWN0IGNkbnNfcGNpZSAqcGNpZSwgdTY0IGNwdV9hZGRyKQ0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UuaA0KPmIvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS5oDQo+PiBpbmRleCBkZGZjNDRmOGQz
ZWYuLjExNzRjZjU5N2JiMCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
Y2FkZW5jZS9wY2llLWNhZGVuY2UuaA0KPj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9j
YWRlbmNlL3BjaWUtY2FkZW5jZS5oDQo+PiBAQCAtMjYsNiArMjYsMjAgQEAgc3RydWN0IGNkbnNf
cGNpZV9ycF9pYl9iYXIgew0KPj4gIH07DQo+Pg0KPj4gIHN0cnVjdCBjZG5zX3BjaWU7DQo+PiAr
c3RydWN0IGNkbnNfcGNpZV9yYzsNCj4+ICsNCj4+ICtlbnVtIGNkbnNfcGNpZV9yZWdfYmFuayB7
DQo+PiArCVJFR19CQU5LX1JQLA0KPj4gKwlSRUdfQkFOS19JUF9SRUcsDQo+PiArCVJFR19CQU5L
X0lQX0NGR19DVFJMX1JFRywNCj4+ICsJUkVHX0JBTktfQVhJX01BU1RFUl9DT01NT04sDQo+PiAr
CVJFR19CQU5LX0FYSV9NQVNURVIsDQo+PiArCVJFR19CQU5LX0FYSV9TTEFWRSwNCj4+ICsJUkVH
X0JBTktfQVhJX0hMUywNCj4+ICsJUkVHX0JBTktfQVhJX1JBUywNCj4+ICsJUkVHX0JBTktfQVhJ
X0RUSSwNCj4+ICsJUkVHX0JBTktTX01BWCwNCj4+ICt9Ow0KPj4NCj4+ICBzdHJ1Y3QgY2Ruc19w
Y2llX29wcyB7DQo+PiAgCWludAkoKnN0YXJ0X2xpbmspKHN0cnVjdCBjZG5zX3BjaWUgKnBjaWUp
Ow0KPj4gQEAgLTM0LDYgKzQ4LDMwIEBAIHN0cnVjdCBjZG5zX3BjaWVfb3BzIHsNCj4+ICAJdTY0
ICAgICAoKmNwdV9hZGRyX2ZpeHVwKShzdHJ1Y3QgY2Ruc19wY2llICpwY2llLCB1NjQgY3B1X2Fk
ZHIpOw0KPj4gIH07DQo+Pg0KPj4gKy8qKg0KPj4gKyAqIHN0cnVjdCBjZG5zX3BsYXRfcGNpZV9v
Zl9kYXRhIC0gUmVnaXN0ZXIgYmFuayBvZmZzZXQgZm9yIGEgcGxhdGZvcm0NCj4+ICsgKiBAaXNf
cmM6IGNvbnRyb2xsZXIgaXMgYSBSQw0KPj4gKyAqIEBpcF9yZWdfYmFua19vZmZzZXQ6IGlwIHJl
Z2lzdGVyIGJhbmsgc3RhcnQgb2Zmc2V0DQo+PiArICogQGlwX2NmZ19jdHJsX3JlZ19vZmZzZXQ6
IGlwIGNvbmZpZyBjb250cm9sIHJlZ2lzdGVyIHN0YXJ0IG9mZnNldA0KPj4gKyAqIEBheGlfbXN0
cl9jb21tb25fb2Zmc2V0OiBBWEkgbWFzdGVyIGNvbW1vbiByZWdpc3RlciBzdGFydCBvZmZzZXQN
Cj4+ICsgKiBAYXhpX3NsYXZlX29mZnNldDogQVhJIHNsYXZlIHN0YXJ0IG9mZnNldA0KPj4gKyAq
IEBheGlfbWFzdGVyX29mZnNldDogQVhJIG1hc3RlciBzdGFydCBvZmZzZXQNCj4+ICsgKiBAYXhp
X2hsc19vZmZzZXQ6IEFYSSBITFMgb2Zmc2V0IHN0YXJ0DQo+PiArICogQGF4aV9yYXNfb2Zmc2V0
OiBBWEkgUkFTIG9mZnNldA0KPj4gKyAqIEBheGlfZHRpX29mZnNldDogQVhJIERUSSBvZmZzZXQN
Cj4+ICsgKi8NCj4+ICtzdHJ1Y3QgY2Ruc19wbGF0X3BjaWVfb2ZfZGF0YSB7DQo+PiArCXUzMiBp
c19yYzoxOw0KPj4gKwl1MzIgaXBfcmVnX2Jhbmtfb2Zmc2V0Ow0KPj4gKwl1MzIgaXBfY2ZnX2N0
cmxfcmVnX29mZnNldDsNCj4+ICsJdTMyIGF4aV9tc3RyX2NvbW1vbl9vZmZzZXQ7DQo+PiArCXUz
MiBheGlfc2xhdmVfb2Zmc2V0Ow0KPj4gKwl1MzIgYXhpX21hc3Rlcl9vZmZzZXQ7DQo+PiArCXUz
MiBheGlfaGxzX29mZnNldDsNCj4+ICsJdTMyIGF4aV9yYXNfb2Zmc2V0Ow0KPj4gKwl1MzIgYXhp
X2R0aV9vZmZzZXQ7DQo+PiArfTsNCj4+ICsNCj4+ICAvKioNCj4+ICAgKiBzdHJ1Y3QgY2Ruc19w
Y2llIC0gcHJpdmF0ZSBkYXRhIGZvciBDYWRlbmNlIFBDSWUgY29udHJvbGxlciBkcml2ZXJzDQo+
PiAgICogQHJlZ19iYXNlOiBJTyBtYXBwZWQgcmVnaXN0ZXIgYmFzZQ0KPj4gQEAgLTQ1LDE2ICs4
MywxOCBAQCBzdHJ1Y3QgY2Ruc19wY2llX29wcyB7DQo+PiAgICogQGxpbms6IGxpc3Qgb2YgcG9p
bnRlcnMgdG8gY29ycmVzcG9uZGluZyBkZXZpY2UgbGluayByZXByZXNlbnRhdGlvbnMNCj4+ICAg
KiBAb3BzOiBQbGF0Zm9ybS1zcGVjaWZpYyBvcHMgdG8gY29udHJvbCB2YXJpb3VzIGlucHV0cyBm
cm9tIENhZGVuY2UgUENJZQ0KPj4gICAqICAgICAgIHdyYXBwZXINCj4+ICsgKiBAY2Ruc19wY2ll
X3JlZ19vZmZzZXRzOiBSZWdpc3RlciBiYW5rIG9mZnNldHMgZm9yIGRpZmZlcmVudCBTb0MNCj4+
ICAgKi8NCj4+ICBzdHJ1Y3QgY2Ruc19wY2llIHsNCj4+IC0Jdm9pZCBfX2lvbWVtCQkqcmVnX2Jh
c2U7DQo+PiAtCXN0cnVjdCByZXNvdXJjZQkJKm1lbV9yZXM7DQo+PiAtCXN0cnVjdCBkZXZpY2UJ
CSpkZXY7DQo+PiAtCWJvb2wJCQlpc19yYzsNCj4+IC0JaW50CQkJcGh5X2NvdW50Ow0KPj4gLQlz
dHJ1Y3QgcGh5CQkqKnBoeTsNCj4+IC0Jc3RydWN0IGRldmljZV9saW5rCSoqbGluazsNCj4+IC0J
Y29uc3Qgc3RydWN0IGNkbnNfcGNpZV9vcHMgKm9wczsNCj4+ICsJdm9pZCBfX2lvbWVtCQkgICAg
ICAgICAgICAgKnJlZ19iYXNlOw0KPj4gKwlzdHJ1Y3QgcmVzb3VyY2UJCSAgICAgICAgICAgICAq
bWVtX3JlczsNCj4+ICsJc3RydWN0IGRldmljZQkJICAgICAgICAgICAgICpkZXY7DQo+PiArCWJv
b2wJCQkgICAgICAgICAgICAgaXNfcmM7DQo+PiArCWludAkJCSAgICAgICAgICAgICBwaHlfY291
bnQ7DQo+PiArCXN0cnVjdCBwaHkJCSAgICAgICAgICAgICAqKnBoeTsNCj4+ICsJc3RydWN0IGRl
dmljZV9saW5rCSAgICAgICAgICAgICAqKmxpbms7DQo+PiArCWNvbnN0ICBzdHJ1Y3QgY2Ruc19w
Y2llX29wcyAgICAgICAgICAqb3BzOw0KPj4gKwljb25zdCAgc3RydWN0IGNkbnNfcGxhdF9wY2ll
X29mX2RhdGEgKmNkbnNfcGNpZV9yZWdfb2Zmc2V0czsNCj4+ICB9Ow0KPj4NCj4+ICAvKioNCj4+
IEBAIC0xMzIsNiArMTcyLDQwIEBAIHN0cnVjdCBjZG5zX3BjaWVfZXAgew0KPj4gIAl1bnNpZ25l
ZCBpbnQJCXF1aXJrX2Rpc2FibGVfZmxyOjE7DQo+PiAgfTsNCj4+DQo+PiArc3RhdGljIGlubGlu
ZSB1MzIgY2Ruc19yZWdfYmFua190b19vZmYoc3RydWN0IGNkbnNfcGNpZSAqcGNpZSwgZW51bQ0K
PmNkbnNfcGNpZV9yZWdfYmFuayBiYW5rKQ0KPj4gK3sNCj4+ICsJdTMyIG9mZnNldCA9IDB4MDsN
Cj4+ICsNCj4+ICsJc3dpdGNoIChiYW5rKSB7DQo+PiArCWNhc2UgUkVHX0JBTktfSVBfUkVHOg0K
Pj4gKwkJb2Zmc2V0ID0gcGNpZS0+Y2Ruc19wY2llX3JlZ19vZmZzZXRzLT5pcF9yZWdfYmFua19v
ZmZzZXQ7DQo+PiArCQlicmVhazsNCj4+ICsJY2FzZSBSRUdfQkFOS19JUF9DRkdfQ1RSTF9SRUc6
DQo+PiArCQlvZmZzZXQgPSBwY2llLT5jZG5zX3BjaWVfcmVnX29mZnNldHMtPmlwX2NmZ19jdHJs
X3JlZ19vZmZzZXQ7DQo+PiArCQlicmVhazsNCj4+ICsJY2FzZSBSRUdfQkFOS19BWElfTUFTVEVS
X0NPTU1PTjoNCj4+ICsJCW9mZnNldCA9IHBjaWUtPmNkbnNfcGNpZV9yZWdfb2Zmc2V0cy0NCj4+
YXhpX21zdHJfY29tbW9uX29mZnNldDsNCj4+ICsJCWJyZWFrOw0KPj4gKwljYXNlIFJFR19CQU5L
X0FYSV9NQVNURVI6DQo+PiArCQlvZmZzZXQgPSBwY2llLT5jZG5zX3BjaWVfcmVnX29mZnNldHMt
PmF4aV9tYXN0ZXJfb2Zmc2V0Ow0KPj4gKwkJYnJlYWs7DQo+PiArCWNhc2UgUkVHX0JBTktfQVhJ
X1NMQVZFOg0KPj4gKwkJb2Zmc2V0ID0gcGNpZS0+Y2Ruc19wY2llX3JlZ19vZmZzZXRzLT5heGlf
c2xhdmVfb2Zmc2V0Ow0KPj4gKwkJYnJlYWs7DQo+PiArCWNhc2UgUkVHX0JBTktfQVhJX0hMUzoN
Cj4+ICsJCW9mZnNldCA9IHBjaWUtPmNkbnNfcGNpZV9yZWdfb2Zmc2V0cy0+YXhpX2hsc19vZmZz
ZXQ7DQo+PiArCQlicmVhazsNCj4+ICsJY2FzZSBSRUdfQkFOS19BWElfUkFTOg0KPj4gKwkJb2Zm
c2V0ID0gcGNpZS0+Y2Ruc19wY2llX3JlZ19vZmZzZXRzLT5heGlfcmFzX29mZnNldDsNCj4+ICsJ
CWJyZWFrOw0KPj4gKwljYXNlIFJFR19CQU5LX0FYSV9EVEk6DQo+PiArCQlvZmZzZXQgPSBwY2ll
LT5jZG5zX3BjaWVfcmVnX29mZnNldHMtPmF4aV9kdGlfb2Zmc2V0Ow0KPj4gKwkJYnJlYWs7DQo+
PiArCWRlZmF1bHQ6DQo+PiArCQlicmVhazsNCj4+ICsJfTsNCj4+ICsJcmV0dXJuIG9mZnNldDsN
Cj4+ICt9DQo+Pg0KPj4gIC8qIFJlZ2lzdGVyIGFjY2VzcyAqLw0KPj4gIHN0YXRpYyBpbmxpbmUg
dm9pZCBjZG5zX3BjaWVfd3JpdGVsKHN0cnVjdCBjZG5zX3BjaWUgKnBjaWUsIHUzMiByZWcsIHUz
MiB2YWx1ZSkNCj4+IEBAIC0xNDQsNiArMjE4LDI3IEBAIHN0YXRpYyBpbmxpbmUgdTMyIGNkbnNf
cGNpZV9yZWFkbChzdHJ1Y3QgY2Ruc19wY2llDQo+KnBjaWUsIHUzMiByZWcpDQo+PiAgCXJldHVy
biByZWFkbChwY2llLT5yZWdfYmFzZSArIHJlZyk7DQo+PiAgfQ0KPj4NCj4+ICtzdGF0aWMgaW5s
aW5lIHZvaWQgY2Ruc19wY2llX2hwYV93cml0ZWwoc3RydWN0IGNkbnNfcGNpZSAqcGNpZSwNCj4+
ICsJCQkJCWVudW0gY2Ruc19wY2llX3JlZ19iYW5rIGJhbmssDQo+PiArCQkJCQl1MzIgcmVnLA0K
Pj4gKwkJCQkJdTMyIHZhbHVlKQ0KPj4gK3sNCj4+ICsJdTMyIG9mZnNldCA9IGNkbnNfcmVnX2Jh
bmtfdG9fb2ZmKHBjaWUsIGJhbmspOw0KPj4gKw0KPj4gKwlyZWcgKz0gb2Zmc2V0Ow0KPj4gKwl3
cml0ZWwodmFsdWUsIHBjaWUtPnJlZ19iYXNlICsgcmVnKTsNCj4+ICt9DQo+PiArDQo+PiArc3Rh
dGljIGlubGluZSB1MzIgY2Ruc19wY2llX2hwYV9yZWFkbChzdHJ1Y3QgY2Ruc19wY2llICpwY2ll
LA0KPj4gKwkJCQkgICAgICBlbnVtIGNkbnNfcGNpZV9yZWdfYmFuayBiYW5rLA0KPj4gKwkJCQkg
ICAgICB1MzIgcmVnKQ0KPj4gK3sNCj4+ICsJdTMyIG9mZnNldCA9IGNkbnNfcmVnX2JhbmtfdG9f
b2ZmKHBjaWUsIGJhbmspOw0KPj4gKw0KPj4gKwlyZWcgKz0gb2Zmc2V0Ow0KPj4gKwlyZXR1cm4g
cmVhZGwocGNpZS0+cmVnX2Jhc2UgKyByZWcpOw0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgaW5s
aW5lIHUzMiBjZG5zX3BjaWVfcmVhZF9zeih2b2lkIF9faW9tZW0gKmFkZHIsIGludCBzaXplKQ0K
Pj4gIHsNCj4+ICAJdm9pZCBfX2lvbWVtICphbGlnbmVkX2FkZHIgPSBQVFJfQUxJR05fRE9XTihh
ZGRyLCAweDQpOw0KPj4gLS0NCj4+IDIuNDkuMA0KPj4NCj4NCj4tLQ0KPuCuruCuo+Cuv+CuteCu
o+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==

