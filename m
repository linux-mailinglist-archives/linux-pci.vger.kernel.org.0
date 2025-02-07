Return-Path: <linux-pci+bounces-20928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3814A2CAC6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 19:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB23C188C102
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AB4199EA2;
	Fri,  7 Feb 2025 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="trKygkUo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C0175D5D;
	Fri,  7 Feb 2025 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738951560; cv=fail; b=Lv/lvCLAxqrRSdPi57tss3KoMvoZtI1FPAh7ABLxrRjvq9OdFFIN8BAexRTlhCv6IUoi+fNuKFTm296tIef8dYxF+j4qwaLwSoeiil6bzSuvg8CFzZhX9YAc3wZE4E7cuXdi2/Icl6k4G424zsqqj18zXdOVxhsS2VO2+vcft5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738951560; c=relaxed/simple;
	bh=hntwIqQ1Ty4OWqEVcxwnCsYfDboMiBti2htquT7pvrM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Zu/0iACUAVmJXU29XFGowTdLTnNee7r/CGE8aOhii2nlN+YeHdHEdJqJYBKBeNN9j9ppkSlkObD+HzI61wCM6falQbmSQsRHv9Qfg6V3SGe9+61oeMzavmXwQI2/Bk/oAoUoL7YAmN4AZKup2JeY/M8VCF01jf3ZRcO/ja9Zq0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=trKygkUo reason="signature verification failed"; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517Ds3G7006202;
	Fri, 7 Feb 2025 10:05:29 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44nke4gfpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 10:05:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3kJ4uEAimRdkHhE7F/PDxANRLSL747O/zuz6KiyK3q9RjKGBOEjZbfQd9+m0xVZF/cVxzI1uxml+bao8kzjzbUR5vOMLg+yxCEpJM8BQ49Pbl82Ley8w23DxftBN1T3dA38GjwyL7e3M8eWUbKKtHLem7nUcua9wCWjs79qK7MaLGL+Qm6/TXyW+2nH3E3jJ1PlU1u4452H4x2v8nxRigi8uP4fd7zVjCiM2OIgqr5GDvomE2mApTa/Ha/zpVbvDXWgvnEqVtM//9YwF8ECxQki/HoDg9IYxrL0Js1gDrtF+pBD7bUuoJtBpxPrGqc+nDeQMz0PuJ6ZmPyoGgtSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QONRq9e8g6N0Jp/seMwj6JZVH4UKBSZbg/2KYCAOrWI=;
 b=yHEF/WZ6PFuw5voO/LKPuyRAqXe+wG2RDzl1AbeuBZ8tABrG5Ia2AADwRn/KX4Q/8qu3xCHgNb6Khfc4peTRznxNvQecnMbeUBVxKtmwAo8iSk8kY9U5ni/ffjTkYZmaiQhar9sH/Hm7rNeHEBSrwUO9zKdQVyiQ4QRSvRdAL6GgL6dC0DKX29cCNAcxeQ5vwmzOwNl57rONO8oac4ORYu7bQYeBYriKYmMkc7rsRtUCfzs8LEoKBzmJSRQ3vF2tfiRhZMc48OX7YYQYHjMsa45TnqqQooIkMFUsRWFWyJHo3nhc1VK9c8I9KVc569zxMrMGV0n4Y5PSVhykEPyB1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QONRq9e8g6N0Jp/seMwj6JZVH4UKBSZbg/2KYCAOrWI=;
 b=trKygkUo1PuejOs+OgIfxeH6894UVQWd5QRmHg8zBWELfL/uJimmN59ZK+4zLQLhTCII9S/IIgu8rt98u9jIv1gcfSbTDV/RWCgH9jXZ1W23l7aAFElBiFlRi7Y9Sh8rNo1bAfas6QKiBxprhO0WVmuojebcKWmA++R2on3VtwE=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by MN2PR18MB3526.namprd18.prod.outlook.com (2603:10b6:208:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 18:05:25 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%3]) with mapi id 15.20.8398.020; Fri, 7 Feb 2025
 18:05:25 +0000
From: Wilson Ding <dingwei@marvell.com>
To: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
CC: Bjorn Helgaas <helgaas@kernel.org>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "thomas.petazzoni@bootlin.com"
	<thomas.petazzoni@bootlin.com>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanghoon Lee <salee@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH 1/1] PCI: armada8k: Disable LTSSM on link
 down interrupts
Thread-Topic: [EXTERNAL] Re: [PATCH 1/1] PCI: armada8k: Disable LTSSM on link
 down interrupts
Thread-Index: AQHbdD9nYBcYj0YRMUe5aGbFZQ/QD7MxlmnwgAqN84CAAAPuEA==
Date: Fri, 7 Feb 2025 18:05:25 +0000
Message-ID:
 <BY3PR18MB467331D0F63143EE7BD0F0E1A7F12@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20241112064241.749493-1-jpatel2@marvell.com>
 <20241112214337.GA1861873@bhelgaas>
 <BY3PR18MB4673E2698A6F465FEB56B5A2A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <BY3PR18MB467343D941D2F7706FD88FCBA7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <20250207173341.anqw7ybp7vn6md4s@thinkpad>
In-Reply-To: <20250207173341.anqw7ybp7vn6md4s@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|MN2PR18MB3526:EE_
x-ms-office365-filtering-correlation-id: f87cc849-5812-4c32-031d-08dd47a1ff42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d25JTFZTNU1VUURRZmRjaEI1RldwQ0docERYU0Q5a1pTVHJTb0FQU21Ja0c1?=
 =?utf-8?B?RFEvQml6c2ZXTnprRWd4QnVqU1NiNHlRa3FNbHAyanF0aW1Idko3enR1NkRy?=
 =?utf-8?B?ZmVOR1ZQUmlDOHloWGY3aHJvMU9OR2p3WWVPMzFKUGJJRWNtMjRuOUNndlVv?=
 =?utf-8?B?MWJBM3hjZDV6ZXR6SWZQbXJyN2ZDM0lHSzdUQWlmcml0NnRhdk9KOTdlK0RW?=
 =?utf-8?B?SW54NnFRZjlCUC85MGdtOURnd2RFMjMyQ3BMYkR0c1FqYW9ucXpBYzk4WExn?=
 =?utf-8?B?RGxwOGRFTksycUtiYW5zcmtqcElkT2xYQXJ6QkZ2R2liZG5IbGZPY1FzTjdQ?=
 =?utf-8?B?NDRRRTNzYlkvbVVvQU11WTh0aHBCbFNHRTkyNkYzNHVqWjVLaGUxNUU3dmVy?=
 =?utf-8?B?aU1mNlpLZUFGZTdOZnVCSzJpOEp3V0dDL204NW9lMzl5L3RPS1VjYzgzV3ZE?=
 =?utf-8?B?bzlFRElVNlBWZ1BDanBrZThYUGtXY0VlbjIzQWxSSmwzeU5aeE5WTGRHNzFz?=
 =?utf-8?B?ZDRKWnluWm1wWkQvR29sMVVFckQrSDNhelFaWjEzRVpTczhaUEhNeHhubHJY?=
 =?utf-8?B?bkFEMStWZDdQbFY3TVBlS1MwaEphZG0yWW9RV3g1NjhZaTNscFB1WFlEWEw5?=
 =?utf-8?B?S0NxWFlET0dya0hZK2VTZEQvKzQvaEltbFNRYkZsWjdpQXA5aDdvKzQ4eDRP?=
 =?utf-8?B?RXFWaklDRmxLL2NsRW40akdLeHNZQ3BTMm5jVS94M2V0UzdZWUx5TC9FZWll?=
 =?utf-8?B?VG9FY1BuMzhSazRORG1pb1VLYTRNTlNJYkNWTkFhdURkQ0MwWEtST3ZJQzNK?=
 =?utf-8?B?b1Jic0JVNEt6bVZ0dnBGSUtydmNDN2dUZUl1MVB0MkFBWGFwVGlmVmMyWStV?=
 =?utf-8?B?NStkdXpVWVh4elNlem1qWWFCak90L1pZc3lTNXZDc1ZuakpyRmJQYXBoWVUz?=
 =?utf-8?B?VjlPNTdtckI1c205K05KUVpuTXZGdXZWcUFOSnd1bDEwcTJ0ZUVQNXRrdWhP?=
 =?utf-8?B?TEp2czJOcVFwNlY5OGFQb2c1aWw0TmY1VzJtbWd3RWJsTG1KbDRsZDN5eUJa?=
 =?utf-8?B?VmpocmFNNlRFYjV6QS80NHdGcWVtSGJCVTNYSXFNWjBIV1EvUnpWc3c5dWt3?=
 =?utf-8?B?VXcvRmtwMDJuVnIxbDNNbmhoVVhhVXlTeEM3TFVrV2d5LzVrV0taNDQvVjdz?=
 =?utf-8?B?NThBU1ZNaFFjZXp5SlZPdnh3SFVxMmdCUjhuajE3Z1NTYzY0OUk3MDFYV3dy?=
 =?utf-8?B?c3liNUhrOGdnQThMOTdWUUx6WjlMY3RMSzRYZmtybk00d0NPSGZQRXljMkhZ?=
 =?utf-8?B?bkVPcFJCYnJSTS9aZlgwTHJaOGh4eTVjaklhSW55bGgrbDYxMzRMR3hRUktl?=
 =?utf-8?B?aVAzSUF1M2FuUGdJSTVybVBJejg2eEtveVErKzNwYUU1YVovNmg4bFVjbmlV?=
 =?utf-8?B?Sit5SnRpdS83eTJ3aFZzM2NJWjhtN3ZPQ2NwREMrT1JTNVRDQkVuNUg5bEpM?=
 =?utf-8?B?czVQWXVtRjdCdUpMTXJVL2dmbWdrbFVwNlBzVHF6aEU3M1BpMTJWT2QwVWVz?=
 =?utf-8?B?aHYwYjNKSWlJUnY0R3Z2QWRzdFE5QjZKOEU0ZUVzUFhOYmNCdUZMenV5dnps?=
 =?utf-8?B?NWYwWWZNL0JYL01FRzRURXNUQjdiOUtkMElsZ2dlYVZ1bmtFcXNoRE91MzlW?=
 =?utf-8?B?UjVndVJRTG1JWURDM3V4eEdSdjdNUU5EOGVxejRjQ2ZXTWsvSkVVYVNrUmda?=
 =?utf-8?B?RllIMUlyZFVaUEdGbjJIY3Y0cnBMb2tkcHE3NGJTS0R6S0dQSE5jNkdKUHJC?=
 =?utf-8?B?Sy92RTlsQTlFWWVTZWt4dDFIREdVektsYUxocEU2Yi9EN1lXUEZVMHVteWNm?=
 =?utf-8?B?K1ordzV6WXZpRkI3UU1QQUdKcWVpMTFMMHhkUHVaSVpsRXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cE1VcVpteUVPMys0eFI2M3JESmFmRC9aMzFkc3hlbkM2TVhnVkVoR3RsTXc4?=
 =?utf-8?B?bFRDRGp2Z0FaNngrVmlsZXpZUkxrNWtWMFNmVHhLSDFueElRVkpNYWRscjZV?=
 =?utf-8?B?TW5qRWNRNE5RNTZVTmxvbG1RS29YQnl6RGdrK3Rocm9iVHNZckY4bjJEMlBj?=
 =?utf-8?B?WnRuNEpBQXNPd3BGb216SkU0RlNKei85YkdxckxUc3FTMXJFMUV2V2dRSnZO?=
 =?utf-8?B?QXJGTlNtYmtmVGJwNGpLQlZCenNralhQeERPZEtqV0VCbmQ5YnJYT3ZzY21k?=
 =?utf-8?B?a3d3R1JWcXA5SFJpbHIxU2JEZkFWdEdMZ0szaW8vVWYwNjNBdDhoeW50a09C?=
 =?utf-8?B?UnBKREZwejF4Nml5U0diR0tFamczbytoWklsRXlPejFSNVRJWXU5UnYvQkxK?=
 =?utf-8?B?RnY1a0s2Q1ltU0ltMzk3SFNXY3FyOFhMRWtSL0szK3ZVUGgxNXQyeEZQVWRr?=
 =?utf-8?B?eld3eW8ydS93dks3aFdvTkJIR3ROcmlGUnlrMU93TUpwR1hnUnlCMHlncmFu?=
 =?utf-8?B?VTYwemtjZE55LytFRCtQWHkwaDNqZ1JoRk5ZVk9NN0p4TWlqcEd1STBCREZa?=
 =?utf-8?B?RjBCMFYyWDRZS0Zud2kwZ0Q4d1pwVjZoOFhaTDQwRUdjOTNWc3dVUGkrWnZk?=
 =?utf-8?B?aU5VZi9zVVhscklmVzFXTU9DT1lmYmYvOU1lYjY4emVOUFlISVdCbGwzUDNE?=
 =?utf-8?B?R2ZndjlsSGdoRWNnN25uc1d1WmFESis1N3NnQnhFcndMMTBXMVhnbUV0ckpV?=
 =?utf-8?B?L3Rnb2VneWJsRmR2YkFkbXZiOG9KUjd3NTRUdlUrRE9qM1Y4eG4vcTd2dkxt?=
 =?utf-8?B?QmE1U0d4UXFOVkVCSGlPcXYxR1NYOEQ3akJMbVZGZG82Yk5Hc1ZsVGp0cDh6?=
 =?utf-8?B?Ny9Xb0FyRm44cEFhZWVCZzU2NEtPWU9oZzlDUDJIOHFXS3g2MjlpUnlQd25S?=
 =?utf-8?B?MEh0Ukh6OVJJUG15UVpqdGo5VGlVOVMrWnQyYjRKMGJPNWlET0I1WWRNK2l6?=
 =?utf-8?B?ZXljajdpRmdyRi9TTTJlSStreE41c2U3RmdIbzdiWVlCTGlFTEtMU0l0a3A3?=
 =?utf-8?B?SnN6c09ZNTI1eGovVGR6eGVFVGZONWZPK0J6ZlBGOUNBSEl0ZUNuL0VzTEFD?=
 =?utf-8?B?Tm1SdnBhazBmVk80ZGI1RUtjaVFTbjM0enkwMEprZE4vYnlrcC9Oa3k4SThB?=
 =?utf-8?B?ODBqT1doL2lTbjMrcHJXNzdHVnhGVnhhMUFRNDh3Um1DSUgrb3VLb012Y21J?=
 =?utf-8?B?Z2UrdUxITk5udnIwTVRJV2NFc0FpY3Zydlh2VEV1aERjOTRhMDBhV0JwbHg1?=
 =?utf-8?B?aGZUcFF1a0hzWWxGdDdQaEJYVUV1b2dIdWltYkJYb3FweWNHS0ZnYTRDZzB2?=
 =?utf-8?B?V0tRV2N4VzRnb1hrek5mQnNJQ0hPVlZoa2dwUlA4Tm5MVW1DNGRDSXdCN0FI?=
 =?utf-8?B?bzFIckJlODZTWXdJdHZ5VVRyYnVMQkVtZEJ1SnVYTUdCajVabEhQZnlnVlN0?=
 =?utf-8?B?a3JvN2NEdnZEM0lGTEhvYjRmWnJ5MldxM1JkU2x5aUE5UlMvWjRqdjdCSzJM?=
 =?utf-8?B?bE1BV2ZJVERaT2RLMksrM1ZvWTlKK0tZSHFYUXNTV2loWTliamlURmdEWVVo?=
 =?utf-8?B?OUxSb083QTc4L0VhZjZVYTNjcFZHM1I2S0dlRmJPM0M4SHVqZzRUMjFLTkw4?=
 =?utf-8?B?MmN0YUJLUkNyWUZKQ0d5NWpOaDdKNElhNlRkUXBsM1VFcmN4Wk5KeVYrc2hT?=
 =?utf-8?B?bWxyU1NnMFpqUm5ReDI3cDhZRlc2MlI2elBsRk9EcDQ2RTRsSHJtYWRSSE9I?=
 =?utf-8?B?UmNiSHppZlJhcEwrTkk4YTZHS2hqUVk2WWxMNkUvcTRidHhFMWhibEZPMkNX?=
 =?utf-8?B?RnluaFVxS1JtcTcxYmYvZnpJazlYYXBwVUw4cTJmbmhEaFUyNDRZWjdIU0VG?=
 =?utf-8?B?eWRzTW41YXZibmMvUmJjV1ZVL2Fna25oU0xjWkRVOFczZkU3dndlekx2cW1O?=
 =?utf-8?B?UVZsTDFKcVR2S3lKV2J6Z3gyOTdQVG1rUTUxTUhPS0JZWjNJMEM0Ri9VY0FQ?=
 =?utf-8?B?eHczc3V5aHc1bVM0QzV2cmo0S1lJQ3J0eHRQZldZczlmMjNqUzhiQVAvbjFT?=
 =?utf-8?Q?NBsRt7PWEfR1HOkOy6Xf/7cYg?=
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87cc849-5812-4c32-031d-08dd47a1ff42
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 18:05:25.3924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPG2ZdB5txNxZxQ1eEAXA99DzeUWr16qUUcoLPd/GxCe8FYm39ZaSHar9cR9fUOUK1XkESWp/JAIMbaViOkqsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3526
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: jbpFrbdB2_Re5TqcbHrjkYj1GgrptkIL
X-Proofpoint-ORIG-GUID: jbpFrbdB2_Re5TqcbHrjkYj1GgrptkIL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_08,2025-02-07_03,2024-11-22_01



> -----Original Message-----
> From: manivannan.sadhasivam@linaro.org
> <manivannan.sadhasivam@linaro.org>
> Sent: Friday, February 7, 2025 9:34 AM
> To: Wilson Ding <dingwei@marvell.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>; lpieralisi@kernel.org;
> thomas.petazzoni@bootlin.com; kw@linux.com; robh@kernel.org;
> bhelgaas@google.com; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Sanghoon Lee
> <salee@marvell.com>
> Subject: [EXTERNAL] Re: [PATCH 1/1] PCI: armada8k: Disable LTSSM on link
> down interrupts
>=20
> On Sat, Feb 01, 2025 at 12:=E2=80=8A57:=E2=80=8A56AM +0000, Wilson Ding w=
rote: > I am
> writing to follow up on this serious of PCIe patches submitted by Jenish.=
 >
> Unfortunately, he has since left the company, and some comments on these >
> patches were=20
> On Sat, Feb 01, 2025 at 12:57:56AM +0000, Wilson Ding wrote:
> > I am writing to follow up on this serious of PCIe patches submitted by =
Jenish.
> > Unfortunately, he has since left the company, and some comments on
> > these  patches were not addressed in a timely manner. I apologize for
> > the delay and any inconvenience this may have caused. I have reviewed
> > the feedback provided and am now taking over this work. I appreciate
> > the time and effort you have put into reviewing the patch and providing
> valuable comments.
> > I will ensure that the necessary changes are made and resubmit the
> > patch in the proper manner, as it was not initially submitted as a seri=
es.
> >
> > > > When a PCI link down condition is detected, the link training
> > > > state machine must be disabled immediately.
> > >
> > > Why?
> > >
> > > "Immediately" has no meaning here.  Arbitrary delays are possible
> > > and must not break anything.
> >
> > Yes, I agree. A delay cannot be avoided. The issue we encountered is
> > that the RC may not be aware of the link down when it happens. In this
> > case, any access to the PCI config space may hang up PCI bus. The only
> > thing we can do is to rely on this link down interrupt. By disabling
> > APP_LTSSM_EN, RC will bypass all device accesses with returning all one=
s (for
> read).
> >
>=20
> Ok. One comment below.
>=20
> > > > Signed-off-by: Jenishkumar Maheshbhai Patel
> > > > <mailto:jpatel2@marvell.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-armada8k.c | 38
> > > > ++++++++++++++++++++++
> > > >  1 file changed, 38 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c
> > > > b/drivers/pci/controller/dwc/pcie-armada8k.c
> > > > index b5c599ccaacf..07775539b321 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> > > > @@ -53,6 +53,10 @@ struct armada8k_pcie {
> > > >  #define PCIE_INT_C_ASSERT_MASK		BIT(11)
> > > >  #define PCIE_INT_D_ASSERT_MASK		BIT(12)
> > > >
> > > > +#define PCIE_GLOBAL_INT_CAUSE2_REG	(PCIE_VENDOR_REGS_OFFSET
> > > + 0x24)
> > > > +#define PCIE_GLOBAL_INT_MASK2_REG	(PCIE_VENDOR_REGS_OFFSET
> > > + 0x28)
> > > > +#define PCIE_INT2_PHY_RST_LINK_DOWN	BIT(1)
> > > > +
> > > >  #define PCIE_ARCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET
> > > + 0x50)
> > > >  #define PCIE_AWCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET
> > > + 0x54)
> > > >  #define PCIE_ARUSER_REG
> 	(PCIE_VENDOR_REGS_OFFSET
> > > + 0x5C)
> > > > @@ -204,6 +208,11 @@ static int armada8k_pcie_host_init(struct
> > > dw_pcie_rp *pp)
> > > >  	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
> > > >  	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
> > > >
> > > > +	/* Also enable link down interrupts */
> > > > +	reg =3D dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG);
> > > > +	reg |=3D PCIE_INT2_PHY_RST_LINK_DOWN;
> > > > +	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG, reg);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >
> > > > @@ -221,6 +230,35 @@ static irqreturn_t
> > > > armada8k_pcie_irq_handler(int
> > > irq, void *arg)
> > > >  	val =3D dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG);
> > > >  	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG, val);
> > > >
> > > > +	val =3D dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE2_REG);
> > > > +
> > > > +	if (PCIE_INT2_PHY_RST_LINK_DOWN & val) {
> > > > +		u32 ctrl_reg =3D dw_pcie_readl_dbi(pci,
> > > PCIE_GLOBAL_CONTROL_REG);
> > >
> > > Add blank line.
> > >
> > > > +		/*
> > > > +		 * The link went down. Disable LTSSM immediately. This
> > > > +		 * unlocks the root complex config registers. Downstream
> > > > +		 * device accesses will return all-Fs
> > > > +		 */
> > > > +		ctrl_reg &=3D ~(PCIE_APP_LTSSM_EN);
> > > > +		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG,
> > > ctrl_reg);
> > >
> > > And here.
> > >
> > > > +		/*
> > > > +		 * Mask link down interrupts. They can be re-enabled once
> > > > +		 * the link is retrained.
> > > > +		 */
> > > > +		ctrl_reg =3D dw_pcie_readl_dbi(pci,
> > > PCIE_GLOBAL_INT_MASK2_REG);
> > > > +		ctrl_reg &=3D ~PCIE_INT2_PHY_RST_LINK_DOWN;
> > > > +		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG,
> > > ctrl_reg);
> > >
> > > And here.  Follow existing coding style in this file.
> > >
> > > > +		/*
> > > > +		 * At this point a worker thread can be triggered to
> > > > +		 * initiate a link retrain. If link retrains were
> > > > +		 * possible, that is.
> > > > +		 */
>=20
> Who is supposed to retrain the link? Where is the worker thread?
>=20
> - Mani

The worker thread is added by another patch posted separately. And you
have some comments on that thread ([PATCH 1/1] PCI: armada8k: Add link-
down handle) regarding removing and rescanning the root port. I am sorry
for the mess and confusions. I am fixing the comments received previously
and will push a new version of patches as a series next week.

>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

