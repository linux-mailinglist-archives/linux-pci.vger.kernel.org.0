Return-Path: <linux-pci+bounces-21430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2429A358AD
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 09:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BD43AB72E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 08:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D62022173E;
	Fri, 14 Feb 2025 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b="wDJ5LwAx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0D184037;
	Fri, 14 Feb 2025 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.152.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521111; cv=fail; b=hIUQDFHxDD8D4rrySrkgxo14ZD8VA1Z4QyefbhxBe42Ot+2mOPXT69hlk4ZlGzx3MkQ7wUd+p4N82BXnOuU5z0lbhrm33iAg6wUgNcirxkqz0bWnoVQwgmunAdkjfktzq8I4+v7mJ+u4QH0gaeg3SzFyYZ4TTLckRWZ3cjX1ydw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521111; c=relaxed/simple;
	bh=qCEsDwJ1dAugf8sJOa746xoJ5UWxrhhxVeayuVIQJOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=By8bOVwcp2ZYO1OtZmJpFA5rkIBNx5WN9My4Tu3nBE7kwD2VEDNzKYvkXocQ2Zzp+Y1G8gHAvciOFLBsH7wqBHXM1b4C19z47W/R088YH3pmwRpux6GbQQRhyo15JrMlWhOKcY70/N4pxbCun9/3Ys4IorNJ+3l2kMC47Ln297Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com; spf=pass smtp.mailfrom=lenovo.com; dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b=wDJ5LwAx; arc=fail smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenovo.com
Received: from pps.filterd (m0355092.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E68X9P008307;
	Fri, 14 Feb 2025 08:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM202306;
	 bh=qCEsDwJ1dAugf8sJOa746xoJ5UWxrhhxVeayuVIQJOU=; b=wDJ5LwAxPKE2
	Y6WppUJN7dHaZtfKs64FjA0PcqRtzzvxbc8cER1XpbrL9ZPZrd1TVM6/sesmtzV0
	bvV2D27CeeIb+/tHxN4rY89P03ZZjcyMEg6Qsfh2byR5UN/zG0el2HH3ndSYRGTU
	HV2RwRVzy9mwUjr+uTV0P8V3/iiwHCSTASLSYPcz1u/BvFIYO0Shv2fs+5cLvpKE
	tTbgXwHnsimOaVmFj5TiM1cMpU5+r7N63VNh++cdTvOA9sg/IJ/7saqbFnboWqoG
	ALIo5Levq9WMCp7SGkITcnorVOMgFkzVJj0r7u43sSq3w06rjR87P57ZUyzzXyRf
	GtqHM+iVNA==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2046.outbound.protection.outlook.com [104.47.26.46])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 44pnkcqj2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 08:18:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nX6/pVyVn7GN+xq4CmFpfCDtOsC7K9QPrIDoUmGMecXKzH/oSKasLp3/+N2KcSS44NXsja/ZcJfjB+6s3LFMYi72397wOo9GEg3APGHvJJWILYiijtD25K29CAitqLtKkFGw9VWdoheuPiIMABcrMZs5VbbxqiIQvgAzXiX9gqfGJiYwdc8E78Sdge0p/dZwmJx7q0FTUJf+RhEGn4B9Cwn5bL/2yTWard3s38DzMcFcQ8ch+XxlaJx/uDmGMX1+Kq8FOwnC5gmknEFgX1bIauGNBPHCfjvVV334mk+OWvx9R+oHcwx8NGQX1XjigCNaB/IJrkAMk7IVfq2mH6Hfxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCEsDwJ1dAugf8sJOa746xoJ5UWxrhhxVeayuVIQJOU=;
 b=aoYyL/o7sKzHDxpHoSnnwg1zDsH4/R37074nPI/J4jYhj9iOb0zLe2cZ9BVAm/B9YYECNMLQyGkowe5lZJlr2oz1SPFDzIMMXQAaEZ7V1HvVIb/PQbmcrTx3xNIbyPOBcPSjzRqDKgmudpbWJfNN29RBQif6bukuWDqEtfH72g05u5Inu55LgsQXIh7v/FWEGYUVB3+2c4YTMnFJJIz5g+FKpKrHnkEdXomrB/HJ6CKwNjLJvCqSFuOs87kXCsD+88aN+nXGuM2gNeJKsUHL5wuwv44g7LQKL5D1HcK4y6YbO9r9JqlW27KFMY+65qOeeR2Q621oC6TbsaTuAfxT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from SEYPR03MB6877.apcprd03.prod.outlook.com (2603:1096:101:b8::14)
 by SI2PR03MB6590.apcprd03.prod.outlook.com (2603:1096:4:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.12; Fri, 14 Feb
 2025 08:18:19 +0000
Received: from SEYPR03MB6877.apcprd03.prod.outlook.com
 ([fe80::c273:e221:2cbf:81a0]) by SEYPR03MB6877.apcprd03.prod.outlook.com
 ([fe80::c273:e221:2cbf:81a0%5]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 08:18:18 +0000
From: =?utf-8?B?WGlhb2NodW4gWEMxNyBMaSB8IOadjuWwj+aYpSBYYXZpZXI=?=
	<lixc17@lenovo.com>
To: =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn
 Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        =?utf-8?B?TWljaGHFgiBXaW5pYXJza2k=?=
	<michal.winiarski@intel.com>,
        Igor Mammedov <imammedo@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika
 Westerberg <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH 00/25] PCI: Resource fitting/assignment fixes and cleanups
Thread-Topic: [PATCH 00/25] PCI: Resource fitting/assignment fixes and
 cleanups
Thread-Index: AQH6TTL5DQjkwgIHkySrt/7khZQhdbMIuQHA
Date: Fri, 14 Feb 2025 08:18:18 +0000
Message-ID:
 <SEYPR03MB68778FC6609C967F1C05F556BCFE2@SEYPR03MB6877.apcprd03.prod.outlook.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6877:EE_|SI2PR03MB6590:EE_
x-ms-office365-filtering-correlation-id: fd7a2923-b118-460a-3011-08dd4cd02383
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnJVdHN5NUd5WkpOUkpkY2RDdUJhc2MybFFEV2dDaGdURTFNbDJhMVRpZUli?=
 =?utf-8?B?OFhjNjV1YVNGMHFYV0VCVHJkTEVxOVlIYlZndlpublZCV0J2SGU1Yk9RUDg2?=
 =?utf-8?B?K25XZE0vRFdlQWxnRFdjOWQ0c3R1bWhzZ0FoS2F4Yk9xWGMxZ2NFNG5pNHo0?=
 =?utf-8?B?REdpT01USFM0QW1aRG4yRThWaUVGNU1RdEhHVllIczA4RmpaeGJydEVTR05j?=
 =?utf-8?B?Ujg5ei9ETEFrN0hTRWQvcWtKL2hrSXFrVjdDY3pZSVNreHI5SGo3Q1AvNjhW?=
 =?utf-8?B?UXQyMU1OQWk4a3Q3VjFhRFNXWkIxOVhOUUU4V053REIxUnhkM3hrL1JXT1hs?=
 =?utf-8?B?Y0wyRHFRcWM4bzcwcjVtV2FJSVJ3ZmRybzRkOXNxTHk3RFBpZ1dIU3RYeEZo?=
 =?utf-8?B?ZHpqMXd4SStCeksvdVhrbzBrTE8wZ25FVzF3SWswc1FJUzZzcGk5YWh4Y011?=
 =?utf-8?B?OHg4dnFUbGtTNTVHMloveHpFSEdtU3o1cVpvdXBSbWZudEVON3lqTGJqOG0v?=
 =?utf-8?B?dERZWWY4eEV4dFUwZWxGdktiVDlLcmVBSHRJc2s0OENLajR2RlVXaHc3dk5I?=
 =?utf-8?B?Rks2UjBFbU9HUkRKTVgzaktlRS9pZWVJdnd2L2Mvd2YrdExJalhzWXRJaGp4?=
 =?utf-8?B?VHc5a3ZubUc5V1ZtdTVMV0dETmhvMUxJNGdCNCtxTVZHaTRVUG5POXFXUE1Q?=
 =?utf-8?B?Z3ArRWhPcHJ2bnJpa1VpN2JWcVNFZWo5TCtqUmR1SDhrV0NXN3c2REhJalNq?=
 =?utf-8?B?TnBNNFZCc25RN0F4MktWMzRlY21mRlVCeHZEUzVWVDFXNmtWcUt3WE9JdjNo?=
 =?utf-8?B?Mi9PcDE4aXVqMHhBMnQzcEtFclRPUXJJN0U5MUZEdDNNdnFJd1FTWUJ1YUFS?=
 =?utf-8?B?TExwb2JzY3FNcC82M2s1Wm1LL1FUUEhJVWplUFRFcnhkZkpJNE9PeVRvK0lW?=
 =?utf-8?B?aTRiUEVjUm1PemNRYVQ2ZXZVOTFQV245SGt3YWJuTDB3Y0l2elp3K2hTWk5X?=
 =?utf-8?B?MUFEQUFwNHFlVTFVRjBsV2ZPMTF1UGFUcy9wc1JkSEE1YjRRUzN0aG1sSHRM?=
 =?utf-8?B?SFVFc0tXQ2lQSUZDSDcxM29rTGZ4bitkVzRKeGlSejZJSTkvUHErU2ZBV3Iz?=
 =?utf-8?B?UlUrVDVIRjJCYS9QTHFhMFAvcVNnM09URnFhTWtrdWdTeksxUFZ5Rng0TUQ5?=
 =?utf-8?B?R0tDNWc3eFYxQ0lpTE9IRkp0VjJIZ1NjRzZvNjNOMGNkNTNxUk5kSVFFaXZQ?=
 =?utf-8?B?dTNyTEhjQUFLK09YbTdtZ1JZRFEvOStLcWY4Wjh6Tk0zYzBKUDJlMHNOVHBI?=
 =?utf-8?B?Y2E4S3hnT25SMFdiMldNMU9sMVI0NWhPVS8xL1l5YldwL1VvVGpJUWZrWE11?=
 =?utf-8?B?ZWVkalNLVUsySEVicDVaOEVjclM3ZVNGVkJ6K0t5cElsOURLOGZ3MGhWS2tz?=
 =?utf-8?B?SnBSYkhRYXV1dElmaXh5aWN6Z0lMbFBjL0VWKyt4dmNwSkg3aVBjU29FaUc5?=
 =?utf-8?B?TDk5SmFobGxSU3dPcGVYVUhaSzI4TmNDclFhZjFmSTcxaW1RazJsUk56cWdF?=
 =?utf-8?B?dmxma2l4b1VLRHh0K25XUTd6c0h5WVYrYXNxZk1XR0xZOGsrY3pKMjdYdjhh?=
 =?utf-8?B?WHRqbkE2dlZXNTVPNFI3NTF3Mm1OcFFaSFB5Q3JBcjE1RzB2QnAwRE9RN3h5?=
 =?utf-8?B?dXB0TWRPZENvVUtnZy9Jc1BRUVNaTWdmeWd4TVY4aGhHWGpLZFp3MWs2ejhW?=
 =?utf-8?B?SHprNndGbFg2TzhRUEh4TDBPNElWajZWSlhHT1MwUkhjQ0hVV2ZjMWFIYW8x?=
 =?utf-8?B?K3FDRGVJbElxaEZnZ3ExNk5MUUZGWWcvNng4MTZjY0h0UDd1OC9xUE92R3BX?=
 =?utf-8?B?algyUXZPeGI0Tk1uTldlZVNtQzhxV2Z4OERjNy9QRnVybTVMSEdZZ0Z3TW0x?=
 =?utf-8?Q?5ZapUV6tgADZLz472T34x8kue8f84vb6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVhSVDgrWk8wTzEvVVVOSWlDMEdabFE1aDg1QWhub0FRaUYxb2JRVkoveWJi?=
 =?utf-8?B?NjI3aEJTQTFpRE84L2I4VDBaN1VFN1RReDlCTCs2elZqYk9XcmFmV1lJaVdx?=
 =?utf-8?B?TzRSTmYwWVh3d3I4NCs1amE4VGNqN21oMlFzeEZaMWlPUm1sY2VyZXZyWjgx?=
 =?utf-8?B?TUhjVE0xVmFEcis1M2p5SEx2UFhJaDQwVG9CeXN0cE1sMW4xWU42YWhveHhB?=
 =?utf-8?B?UngxK0t4RDZqdkJyNmtMWHJOSVFBVnZ0OVJGZis5bkxwTDBUdS9EUG1qS1pu?=
 =?utf-8?B?b2VvZXh4eXBDclB5MVkxT1pna05BaWNVWEFkenhvbnRST2VzQmFBeThLZDdO?=
 =?utf-8?B?N1ZYYnl5WHZSQmtIUmJXOE1KU096dzNtSUxFZThvZEZ6SHpEbWZSem4weDZa?=
 =?utf-8?B?b204ekpPRHY1L1p1czc0M1N2ZDFpYVZ4ZkJxNjdrZ2pCVCtPT2F6em5Ic3F1?=
 =?utf-8?B?VVo2U0FaMW9CVGNCOW9aZ2ZCbHRrZjFqNk40cnBZanBmWVJuVGl0ejllSS82?=
 =?utf-8?B?RlpSaldiYzNWYVlrUkR6WE9kay9BcGFEM0MxT0dRZnZSMXlJVDkwcXBYL2lO?=
 =?utf-8?B?STJpL0xqYlI0dUlNaXJsNVM2U2RtU1E5TXFxRjFFWjhwTWdzWVFJcUhneFgz?=
 =?utf-8?B?TjFRYkNPSFpWOGRDSEtCSVZLZnZ6QWJ1YkVRL1NHNjJiY2E0NnlrclcrM0RG?=
 =?utf-8?B?WTlDL1A1RTAxcDFtSFd5VjZ4d3NzQlRLUVNJc1VrN0JVSXdTNUZGWURTLzVY?=
 =?utf-8?B?bUV0aGlKSjNSM2F2dWY3UENMZi9EM3g3bXlXWWE2YmI4aTN3WWJLOGJmY0dj?=
 =?utf-8?B?RmpyNGRTSzdoNDZwMmxGTFR6enl0ZVBXQ204T2lvNkhjQXJXcld1bW01TFE4?=
 =?utf-8?B?ZHRUZUZQV2tQbW1ZbWxvdW95bEl2Q2UrcXJaY0gvbGJYZHByd3RnZm03MXcr?=
 =?utf-8?B?VU5sRlJZZDM4VVl0VUthVk1VdWNIRjVncFF6am9ZcW9Ud2t3SzNLWitpdG1S?=
 =?utf-8?B?RG02ZzhlWVUreWdmWWYvdGdnMnpEVEJnOXZINFlvK0hKVWVMWW1td2RXUGFz?=
 =?utf-8?B?MWZuRE1leFF2VDNhMGtVOXFBMGNsZ0lWSWM0b1J1UXhsZEFWMG9tL29TNDZ5?=
 =?utf-8?B?Nll4bnl3QXArNGhTakxzQUljY01nMXo4TUk3aUdRUTdMSUhiWlRGVGZ2V25H?=
 =?utf-8?B?ZXZYSWYyKzNhNjBvTk4vRFdYOE1Za0RUc1Y5dWRVM0tJc2Y0T0x0OXROcU1V?=
 =?utf-8?B?TUM2TytHSkF0UFF4M1JyNEQ4ZVRyZ2ZlM1VpWTdNOGhEWGdRQkV2b011dkNX?=
 =?utf-8?B?R0R4YVRzdDh6VEt6cTVScWx3OEtoM2JlSkxqRkx4OEJZK2xFZjltYmJFbVdp?=
 =?utf-8?B?KzRmdllDNytsMFNMc2ZjRW1GZWRIUk5rcDdNY2R1S3ZvR0ZDSlVFSUJqdTBG?=
 =?utf-8?B?TGNQZFp1TFljdFNYdDVIcGFVMXRYYXVMdUJWeEZSSHlsWkxFcllmVlA1cllX?=
 =?utf-8?B?VlpyeXFFcUxTRnJEK0xLRGRENEc5Z3F4Vml1R0tFT3Erd1hHNU9iejA1NmJ0?=
 =?utf-8?B?R0E3VkpXWkt6M1pVN0p6WjBPczJzZlp0dXUzdmxXcWx4eXN6MXhLdmVzc0dp?=
 =?utf-8?B?ZVlmMzZ3TXdsRVFIK254dS9JZFJBYVN6cEE5YW1jV0k0cHZlcVpiMGQwcXor?=
 =?utf-8?B?TVU2ODhBTStJdU1tcDJTbzZUaU1DR1o4WG1McDV5RnhuSnFkUCtrQ0ZISDBz?=
 =?utf-8?B?c2hwSVB6UWtaSVNWcVFjOWVERm1jd3E0Njl0N0craXBmSnphaGVQVXZrSGgw?=
 =?utf-8?B?Szd4V0xYNUNNR1FSVmZ2Mk1FNENuemY0UGZOdU96a21QVURNN1BVWVNabVBS?=
 =?utf-8?B?QS95SW96TEZDL0oxN0F3ek8zdytrL1c5OENsWGptd0tueW55NVU2RjRGNlk4?=
 =?utf-8?B?Rnkvd01xbi9ydjNzVjM0S0pjZWEzdERqbUFzWjAwU1FheW9acnBUajhhc09o?=
 =?utf-8?B?eXVybUlnajZzRHBncGVDTkhNbTNCeVM5NkR5WjdvRkFYaFY5ZWxGbjdUdmUx?=
 =?utf-8?B?c2VEeWVUSUdhZ1NGakxDT1JkOTYyZUh4cnVVYjg2aWtQUk1ucllKT2t4enFy?=
 =?utf-8?Q?f3kc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7a2923-b118-460a-3011-08dd4cd02383
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 08:18:18.8744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NzV7hG/VVpeAY6WK0Q9v+646MjOmVNrpOIxEqoA5vRKqBW9xzO3V5mLITjb1bkcN0TEKC76qjdMh36mwIR4x3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6590
X-Proofpoint-GUID: OlJObu7aH3nJ3L4NQApHVzHzH4ejRjdi
X-Proofpoint-ORIG-GUID: OlJObu7aH3nJ3L4NQApHVzHzH4ejRjdi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=-20 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502140061

DQpPbiBNb24sIERlYyAxNiwgMjAyNCBhdCA3OjU2OjQ1UE0gKzAyMDAgSWxwbyBKw6RydmluZW4g
PGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gRnJvbTogSWxwbyBKw6Ry
dmluZW4gPGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0KPiANCj4gSGkgYWxsLA0KPiAN
Cj4gVGhpcyBzZXJpZXMgZm9jdXNlcyBvbiBQQ0kgcmVzb3VyY2UgZml0dGluZyBhbmQgYXNzaWdu
bWVudCBhbGdvcml0aG1zLg0KPiBJJ3ZlIGZ1cnRoZXIgY2hhbmdlcyBpbiB3b3JrcyB0byBlbmFi
bGUgaGFuZGxpbmcgcmVzaXphYmxlIEJBUnMgYmV0dGVyIGR1cmluZw0KPiByZXNvdXJjZSBmaXR0
aW5nIGJ1aWx0IG9uIHRvcCBvZiB0aGVzZSwgYnV0IHRoYXQncyBzdGlsbCBXSVAgYW5kIHRoaXMg
c2VyaWVzIHNlZW1zDQo+IHdheSB0b28gbGFyZ2UgYXMgaXMgdG8gaGF2ZSBtb3JlIHN0dWZmIGlu
Y2x1ZGVkLg0KPiANCj4gRmlyc3QgdGhlcmUgYXJlIHNtYWxsIHR3ZWFrcyBhbmQgZml4ZXMgdG8g
dGhlIHJlbGF4ZWQgdGFpbCBhbGlnbm1lbnQgY29kZSBhbmQNCj4gYXBwbHlpbmcgdGhlIGxlc3Nv
bnMgbGVhcm5lZCB0byBvdGhlciBzaW1pbGFyIGNhc2VzLiBUaGV5IGFyZSBzb3J0IG9mDQo+IGlu
ZGVwZW5kZW50IG9mIHRoZSByZXN0LiBUaGVuIGEgbGFyZ2Ugc2V0IG9mIHB1cmUgY2xlYW51cHMg
YW5kIHJlZmFjdG9yaW5nIHRoYXQNCj4gYXJlIG5vdCBpbnRlbmRlZCB0byBtYWtlIGFueSBmdW5j
dGlvbmFsIGNoYW5nZXMuDQo+IEZpbmFsbHksIHN0YXJ0aW5nIGZyb20gIlBDSTogRXh0ZW5kIGVu
YWJsZSB0byBjaGVjayBmb3IgYW55IG9wdGlvbmFsIHJlc291cmNlIiBhcmUNCj4gYWdhaW4gcGF0
Y2hlcyB0aGF0IGFpbSB0byBtYWtlIGJlaGF2aW9yYWwgY2hhbmdlcyB0byBmaXggYnJpZGdlIHdp
bmRvdyBzaXppbmcNCj4gdG8gY29uc2lkZXIgZXhwYW5zaW9uIFJPTSBhcyBhbiBvcHRpb25hbCBy
ZXNvdXJjZSAodG8gZml4IGEgcmVtb3ZlL3Jlc2Nhbg0KPiBjeWNsZSBpc3N1ZSkgYW5kIGltcHJv
dmUgcmVzb3VyY2UgZml0dGluZyBhbGdvcml0aG0gaW4gZ2VuZXJhbC4NCj4gDQo+IFRoZSBzZXJp
ZXMgaW5jbHVkZXMgb25lIG9mIHRoZSBjaGFuZ2UgZnJvbSBNaWNoYcWCIFdpbmlhcnNraQ0KPiA8
bWljaGFsLndpbmlhcnNraUBpbnRlbC5jb20+IGFzIHRoZXNlIGNoYW5nZXMgYWxzbyB0b3VjaCB0
aGUgc2FtZSBJT1YgY2hlY2tzLg0KPiANCj4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSdkIHBy
ZWZlciBtZSB0byBvcmRlciB0aGUgY2hhbmdlcyBkaWZmZXJlbnRseSBvciBzcGxpdCBpdA0KPiBp
bnRvIHNtYWxsZXIgY2h1bmtzLg0KPiANCj4gDQo+IEkndmUgZXh0ZW5zaXZlbHkgdGVzdGVkIHRo
aXMgc2VyaWVzIG92ZXIgdGhlIGhvc3RzIGluIG91ciBsYWIgd2hpY2ggaGF2ZSBxdWl0ZQ0KPiBo
ZXRlcm9nZW5lb3VzIFBDSSBzZXR1cCBlYWNoLiBUaGVyZSB3ZXJlIG5vIGxvc3NlcyBvZiBhbnkg
aW1wb3J0YW50IHJlc291cmNlLg0KPiBXaXRob3V0IHBjaT1yZWFsbG9jLCB0aGVyZSdzIHNvbWUg
Y2h1cm4gaW4gd2hpY2ggb2YgdGhlIGRpc2FibGVkIGV4cGFuc2lvbg0KPiBST01zIGdldHMgYSBz
Y2FyY2UgbWVtb3J5IHNwYWNlIGFzc2lnbmVkICh3aXRoIHBjaT1yZWFsbG9jLCB0aGV5IGFyZSBh
bGwNCj4gYXNzaWduZWQgbGFyZ2UgZW5vdWdoIGJyaWRnZSB3aW5kb3cpLg0KPiANCj4gDQo+IEls
cG8gSsOkcnZpbmVuICgyNCk6DQo+ICAgUENJOiBSZW1vdmUgYWRkX2FsaWduIG92ZXJ3cml0ZSB1
bnJlbGF0ZWQgdG8gc2l6ZTANCj4gICBQQ0k6IHNpemUwIGlzIHVucmVsYXRlZCB0byBhZGRfYWxp
Z24NCj4gICBQQ0k6IFNpbXBsaWZ5IHNpemUxIGFzc2lnbm1lbnQgbG9naWMNCj4gICBQQ0k6IE9w
dGlvbmFsIGJyaWRnZSB3aW5kb3cgc2l6ZSB0b28gbWF5IG5lZWQgcmVsYXhpbmcNCj4gICBQQ0k6
IEZpeCBvbGRfc2l6ZSBsb3dlciBib3VuZCBpbiBjYWxjdWxhdGVfaW9zaXplKCkgdG9vDQo+ICAg
UENJOiBVc2UgU1pfKiBpbnN0ZWFkIG9mIGxpdGVyYWxzIGluIHNldHVwLWJ1cy5jDQo+ICAgUENJ
OiByZXNvdXJjZV9zZXRfcmFuZ2Uvc2l6ZSgpIGNvbnZlcnNpb25zDQo+ICAgUENJOiBDaGVjayBy
ZXNvdXJjZV9zaXplKCkgc2VwYXJhdGVseQ0KPiAgIFBDSTogQWRkIHBjaV9yZXNvdXJjZV9udW0o
KSBoZWxwZXINCj4gICBQQ0k6IEFkZCBkZXYgJiByZXMgbG9jYWwgdmFyaWFibGVzIHRvIHJlc291
cmNlIGFzc2lnbm1lbnQgZnVuY3MNCj4gICBQQ0k6IENvbnZlcmdlIHJldHVybiBwYXRocyBpbiBf
X2Fzc2lnbl9yZXNvdXJjZXNfc29ydGVkKCkNCj4gICBQQ0k6IFJlZmFjdG9yIHBkZXZfc29ydF9y
ZXNvdXJjZXMoKSAmIF9fZGV2X3NvcnRfcmVzb3VyY2VzKCkNCj4gICBQQ0k6IFVzZSB3aGlsZSBs
b29wIGFuZCBicmVhayBpbnN0ZWFkIG9mIGdvdG9zDQo+ICAgUENJOiBSZW5hbWUgcmV0dmFsIHRv
IHJldA0KPiAgIFBDSTogQ29uc29saWRhdGUgYXNzaWdubWVudCBsb29wIG5leHQgcm91bmQgcHJl
cGFyYXRpb24NCj4gICBQQ0k6IFJlbW92ZSB3cm9uZyBjb21tZW50IGZyb20gcGNpX3JlYXNzaWdu
X3Jlc291cmNlKCkNCj4gICBQQ0k6IEFkZCByZXN0b3JlX2Rldl9yZXNvdXJjZSgpDQo+ICAgUENJ
OiBFeHRlbmQgZW5hYmxlIHRvIGNoZWNrIGZvciBhbnkgb3B0aW9uYWwgcmVzb3VyY2UNCj4gICBQ
Q0k6IEFsd2F5cyBoYXZlIHJlYWxsb2NfaGVhZCBpbiBfX2Fzc2lnbl9yZXNvdXJjZXNfc29ydGVk
KCkNCj4gICBQQ0k6IEluZGljYXRlIG9wdGlvbmFsIHJlc291cmNlIGFzc2lnbm1lbnQgZmFpbHVy
ZXMNCj4gICBQQ0k6IEFkZCBkZWJ1ZyBwcmludCB3aGVuIHJlbGVhc2luZyByZXNvdXJjZXMgYmVm
b3JlIHJldHJ5DQo+ICAgUENJOiBVc2UgcmVzLT5wYXJlbnQgdG8gY2hlY2sgaXMgcmVzb3VyY2Ug
aXMgYXNzaWduZWQNCj4gICBQQ0k6IFBlcmZvcm0gcmVzZXRfcmVzb3VyY2UoKSBhbmQgYnVpbGQg
ZmFpbCBsaXN0IGluIHN5bmMNCj4gICBQQ0k6IFJld29yayBvcHRpb25hbCByZXNvdXJjZSBoYW5k
bGluZw0KPiANCj4gTWljaGHFgiBXaW5pYXJza2kgKDEpOg0KPiAgIFBDSTogQWRkIGEgaGVscGVy
IHRvIGlkZW50aWZ5IElPViByZXNvdXJjZXMNCj4gDQo+ICBkcml2ZXJzL3BjaS9wY2kuaCAgICAg
ICB8ICA0NCArKystDQo+ICBkcml2ZXJzL3BjaS9zZXR1cC1idXMuYyB8IDU2NiArKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL3BjaS9zZXR1cC1yZXMu
YyB8ICAgOCArLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAzNjQgaW5zZXJ0aW9ucygrKSwgMjU0IGRl
bGV0aW9ucygtKQ0KPiANCkhpLCBhbGwNClRoaXMgc2VyaWVzIGhhcyB1bmRlcmdvbmUgdGVzdGlu
ZyBvbiB0aGUgZm9sbG93aW5nIGNvbmZpZ3VyYXRpb25zOg0KLSBMZW5vdm8gVGhpbmtTeXN0ZW0g
U1I2MzAgVjQgZXF1aXBwZWQgd2l0aCBJbnRlbCBHcmFuaXRlIFJhcGlkcyBDUFVzLg0KLSBUaGUg
bGF0ZXN0IHVwc3RyZWFtIGtlcm5lbCB2Ni4xNC1yYzIgYW5kIHRoZSBzdGFibGUga2VybmVsIDYu
MTMuMi4NCi0gV2l0aCAicGNpPXJlYWxsb2MiIGFwcGVuZGVkIHRvIHRoZSBrZXJuZWwgY29tbWFu
ZCBsaW5lLg0KLSBSZWQgSGF0IEVudGVycHJpc2UgTGludXggMTAuMCBCZXRhLg0KDQpUZXN0IHJl
c3VsdHM6DQotIEFsbCBwYXRjaGVzIHdlcmUgYXBwbGllZCBjbGVhbmx5IGFuZCB0aGUgYnVpbGQg
cHJvY2VzcyB3YXMgc3VjY2Vzc2Z1bC4NCi0gVGhlIGFzc2lnbm1lbnQgZm9yIHRoZSBST00gQkFS
IG9mIGRvd25zdHJlYW0gZGV2aWNlcyB3YXMgc3VjY2Vzc2Z1bC4NCi0gVGhlIGJyaWRnZSB3aW5k
b3cgaGFzIGJlZW4gYWRqdXN0ZWQgdG8gZml0IHRoZSBkb3duc3RyZWFtIHJlc291cmNlcy4NCg0K
VGVzdGVkLWJ5OiBYaWFvY2h1biBMZWUgPGxpeGMxN0BsZW5vdm8uY29tPg0KPiAtLQ0KPiAyLjM5
LjUNCj4gDQoNCg==

