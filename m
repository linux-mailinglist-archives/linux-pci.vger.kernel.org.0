Return-Path: <linux-pci+bounces-37417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 368A5BB3D70
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC301C5EB7
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 12:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E7F2DC359;
	Thu,  2 Oct 2025 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="g9pVocBe";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Lqu7L/rX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1292D8360;
	Thu,  2 Oct 2025 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759406689; cv=fail; b=bhBqGm8TnPSa1nIZyM1N0THTCMfL6BQOkrFV6Z1NA851RbcsUW2MiUZiK7rqlAve2Gj21FaxSV0Z6SgVl5ZrCJePRFyurvmJDRG8EIjoY6VKMLHtYibjry26KeAB+C2W9G1HkKJa4F+lPOQ2b0CtvKKa+5xUOQFO+eZDXvaQaR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759406689; c=relaxed/simple;
	bh=pMexhdzmt6Vja4gDf6tDiRrKrPtJxpTCbVUqB1mVqD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b021nP9iTz7rurgtscw06ynv9rkv4bKxQFKzeJ5XmpRcmJ1wGEYrbm9+kyRkOTNFh6DiEk2sHqrVGG5JbIjS3iRiHQu9+zfwSQP38jqd+eVukBvFhLxhQGhHwZZkivPiMF/Wke4TSMgIeEEv0UdX+WXBE4pZKI+36paQg2Ik+ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=g9pVocBe; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Lqu7L/rX; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 592BVDns3871684;
	Thu, 2 Oct 2025 05:04:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=pMexhdzmt6Vja4gDf6tDiRrKrPtJxpTCbVUqB1mVq
	D8=; b=g9pVocBeIKQ3cc1JvonPMsmP9SPYXJmFtZPxmvvrTeuToK2kO16tUctj0
	G5yHY6W+1EgNpmqtLZAo+ig7jNGnrO/aaS1uw7Vbs/k05Pzo32lMXljY5drtVJxn
	4MCgW1LrqoW7o0zP9+dTWlKlZTsce8/dlL6zZNk9dQvzSED+hI35Lj9TbO91pjo+
	p+ZWvbKE09tXNDvj0neIi3Pu9mnUya1BWnPKRbKheN4ORFxszRw4rJV0TJREmJx2
	t2L5V8/IGRNdLSZdFGaCnR+udnhBmXVyi7UrgOUyZx8buh9nb+dWqRnf2suhrI+b
	/J8qxkHNfG44ehEgqtnq4JrpK0Bbg==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022126.outbound.protection.outlook.com [52.101.43.126])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49hbkh1dd1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 05:04:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpDTH6XtqoV3cdnTthLq+uUReWpYMBSaeX93CJ22UZupkjUv48QZXXkYPOrJ9EoloB+IQP1EA9PNE1zCUUL1X2NA/wiPz9m3aLM+qs7ZR6F6KuffrLsDcll4R2LCVJI5VDOtu6Mn/dfPEtHIMY15eCb+qcJ7UnCOM1+ZAZ9dID4zoRKJr5EOYHgojqGqkHqEdYPhcK6YXPqWdpl0q+0FpUqNBqqg0fTlQRss2qdJy39MoLLCpFhhzyr9GXnvdIynhFm+B7pF91mxNXDM/znW6Eq9CG4eWjqOVnwzPzfTnotjmBUzq8VZuZNxea0K3/HwVlnjlS3y4JrA3OaKQ0XOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMexhdzmt6Vja4gDf6tDiRrKrPtJxpTCbVUqB1mVqD8=;
 b=ce/jOkSs1JWgUy2hdeHXWagZRoY7ledoAMVOlOgpFlAjFXhYfWQkednfEDuicxSxKt+Wwe6WscR04kozZNCkaqC4Ck1Gny5UlK7m1eRMhPml5lPbqk59qCxqEbHd+7SvrJtkqbNqV8UAd7dUT/pqOkSl660lS584rT1AwjIaI/4NJKIOhjFQWfAKFtlBJ9Un29g1rSZcn8bxKFoPl7VGuTuTW/uYoOfV/tuUyeIpAlcYUtgn5o7osozH3PaC2f5bTh44CMUNozW0IJC4GHChfTjzxOBE2PpN2xFNfndF+r7Eh3IfQPmuWmnx9mYj28SA6vwbHowodK2KTku2ncN44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMexhdzmt6Vja4gDf6tDiRrKrPtJxpTCbVUqB1mVqD8=;
 b=Lqu7L/rXFwlgjnldlDZFc5jiwXu8CE7fkK3SQvMKQXa8QwGLHmNRKl9VeQPguJFrFuqkGlNMLh3uu9y1tW7+go8a0MrpCQRB0D2B1SJhacNqULPzlc3nAp0FLwbdAeTlWyp9sJ22bWUSfvvngwFZIxAoR9Bv7UMqbDRPPOZmNzA1HOYvLQQkKnxQyMHScoE8uiM9o03ZuMvYDj1y4mD1pCfFbAuY2btOdHX14TGGpurwi552EpzL5HbbOlzaZ8c5VmHepI6/tYp1WaSzbDgjkFNiJc7xVhys8JpNokczasuDEFHAOdRvjTWOx1iVbI2ryIbwo/l6/Y93B+sM/5BE8Q==
Received: from BYAPR02MB5016.namprd02.prod.outlook.com (2603:10b6:a03:69::27)
 by CYXPR02MB10259.namprd02.prod.outlook.com (2603:10b6:930:db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 12:04:32 +0000
Received: from BYAPR02MB5016.namprd02.prod.outlook.com
 ([fe80::c759:bef6:2ea6:d47a]) by BYAPR02MB5016.namprd02.prod.outlook.com
 ([fe80::c759:bef6:2ea6:d47a%5]) with mapi id 15.20.9160.014; Thu, 2 Oct 2025
 12:04:32 +0000
From: Vincent Liu <vincent.liu@nutanix.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich
	<dakr@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] driver core: PCI: Check drivers_autoprobe for all added
 devices
Thread-Topic: [PATCH] driver core: PCI: Check drivers_autoprobe for all added
 devices
Thread-Index: AQHcM5S26AjEcy4U4UWd74XlD0ssCw==
Date: Thu, 2 Oct 2025 12:04:32 +0000
Message-ID: <9323BB3E-EE65-4863-8060-FC124066C456@nutanix.com>
References: <20251001151508.1684592-1-vincent.liu@nutanix.com>
 <2025100209-hefty-catalyst-e5b2@gregkh>
In-Reply-To: <2025100209-hefty-catalyst-e5b2@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5016:EE_|CYXPR02MB10259:EE_
x-ms-office365-filtering-correlation-id: 5d16648c-699c-46fb-ee2c-08de01abd8fc
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MExITG1aTzM1SThnaEpPMnE2Tklycnk2U3VINmpmM0ZiOWVUdzlEaDYvTEpF?=
 =?utf-8?B?ejhZUkJHTk5Sa2JrNmtybUhQaEFKbTVRdnZQZjVabDBlM1JBTERTa0ZwcVE2?=
 =?utf-8?B?MGlpUG5CS0tCYmVsSWlIVU95akhpRU5KQThiWFdOMUtNOG9BSmJ2RTZMaTJv?=
 =?utf-8?B?VGYvWFkxQ3ZIcW5tSFRDdkVFeEtuNXExK1hDUnUrN1FUVUVIVTdQOHVrb0FE?=
 =?utf-8?B?YjlQRVduOG4xNVIwNkptM3lPcEQ3bEJ1RkJBVHMvczV6dHJmMFREdHR4S1pN?=
 =?utf-8?B?dkI3ZTJqakNYYVpoU2h5Z3NxMnE2UFNRcVNjdmVCbVNUaTFvMitCSHRhNFdW?=
 =?utf-8?B?VE9KR053NkxSK1E5Y0IrMnROclhwRkdMV3U5eDNENjYxQWpYVjdNYnM5bmVl?=
 =?utf-8?B?ZjNHWC9nK0lzR0M3VDJ0TXMvc2xrcUtybExUbHZuc2ttaVlLU0lPOHpQYnJ1?=
 =?utf-8?B?TC83UVdkQ3A2UUs4V1R6SnJrZ24wYUl6NVczWExJYXpOKzkrLzlweDN2b3Vv?=
 =?utf-8?B?SnhiZEtkSklDS2syU09VcTFsOVcvcWk5bndwRU1PVk5uLy9aMml6VkJhQWF2?=
 =?utf-8?B?YnkzSFZnNVJ5YzNjY2VNa0JRVGdzcmxBeENFRWVSK2ZRMkJlU3RBQytGd1hy?=
 =?utf-8?B?UEhBLy9XdHFDUnQ5RURMMnllbnUzNFJIWGhJSlh3ZkdCMEl1ZGJrN0p0VzZM?=
 =?utf-8?B?dlltQmE5RW93WlNFQ2pmejI1bDJnQ2pDS1BuUU9pSjlCZkJWc1BsTlFBbTVz?=
 =?utf-8?B?UEFnQU9seTNyT1RCNVdEaUVyS0ozQTkwQjFBZzU3Z1hwNTljZ1YwaTFpQ3Z5?=
 =?utf-8?B?M21YM0M0NTI1ZStZeDJzdElZTk9KQ3dad1pwTEJuZFo3WHY0NXJicFBhZGVt?=
 =?utf-8?B?K2s5ZGtUdWNubThLWitUQmh5eSszVTlxQ0VOanI2bUxBLzJ2aDdUTHlLTHUr?=
 =?utf-8?B?ZkpERWgreXQ0eXVMZTFST1lDWVc4d2Y0dVk4Wlo1a25ZdFJ1dU5RblhZS0xM?=
 =?utf-8?B?U3pNcjN1K3JnQS9kOHN1VTNwTkN5NHJybFF0Q1d2VCtEc1hJQUVOeFdwSnVE?=
 =?utf-8?B?dWdYR1lNaWNxcERBSno1bllySGlXRXJVZitxMjYzTklnMHBiMUtGT2srUTRJ?=
 =?utf-8?B?eTlxNjZCZlFwcFo5dW5JaUcwUCtDa3N0Y3RoNFJVMnZxZ1JSQnZTaFZLd1I4?=
 =?utf-8?B?K3lybytBSlpoa3JRaDBDTkJhbm44SWhxYUJtSzBvSUV1aitqQU1QMGNxYzZj?=
 =?utf-8?B?T1l0VkZlTGgweUhzdDVTUlZjYWlhMmJVcEZxVmIwUXRLSDdyTjIzMEcrRXhx?=
 =?utf-8?B?Q2hvMmtQVlhsM0o4NWVsbDBqRnBtdmEwQXZzaW5qOUZBeTlBU1BWczgvVzg1?=
 =?utf-8?B?UGUySGJUYytTdm1RdGgzQ0l3dm02azM4NjFNcEdkdWFLaHh6Z1lKbkV1Sngw?=
 =?utf-8?B?NXQ3KzlOOVYxcFNCUDViY3U5UXBQcTltWUt3WmdEdkRiS25LMEZTSEduS0xk?=
 =?utf-8?B?WUpEVU55RnQ1QTBEOWo1S3h5a20rUlMzaVJmMHd5ZkhpRHZ6Mmk0ZkJMR1lC?=
 =?utf-8?B?MXpTSkNEVkk3RmozZTZWT0hXTXFHeklxOW5qR0J5aThTaGhuL05JdnhxaWpK?=
 =?utf-8?B?NS9rWlpieklEM2NCN29ZSFJ4cWlNRjJjMWZranNJa3VOUWpYcFc2Y0tGZXVj?=
 =?utf-8?B?bUl1ZUNvS0c0ZHo5UnVsTFMrMWQ3VVdaQlJJS0x2bElVUUlrZkU4aEhaWWN1?=
 =?utf-8?B?dG1FRWswOEMvTndycWRNSDgvRUo2VGNSaFpMZ3gvTVpPRlpnUTRhY1MxUFg3?=
 =?utf-8?B?WXZFYjBoNEVndys5bmZYNTFqRTRBWjQzd3c1QitxQ1AydFJQak1abHpWRzNs?=
 =?utf-8?B?dFQ4RlRua1FSaW0ybmMrYUVQZmZZRFNseVB0SHN2bnk4dkVKSWZvN3ZSWi9y?=
 =?utf-8?B?aG1ieU82dTVKYlJTd1d4RlR5RWhOV0ZaZnFlVktoUVNqMngrb2lncmZlZWZi?=
 =?utf-8?B?eS9UZ0d3YzFRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5016.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0pNUGwyZkxJY0RENWIwdFRMVktvMHZaRVlUaDVhdVpyNTM2cU5CMnFzc2Jo?=
 =?utf-8?B?bUhBNEE0c1pOQW93R2hTbm9ZRDk2eERhcnlUYXFUSWJWNXlMQ2ZaQlkyRDBI?=
 =?utf-8?B?T25sQzJnMC9pR3A0cUxia21nRWsxWGVFYW5UbnVlL2t6K2FTeEtrVjBjTjAv?=
 =?utf-8?B?bmNlZlhNSXBrTWl2b3JyOUFGVkZOSWZZOWx4b0xRUEpYTk41ZUdoQnBXUlZ3?=
 =?utf-8?B?ZmZ0cHViVWduWFFta1NZVzA3UGN1R3NESG5wVll4WlJlMHNQRHI5aUVBb3ow?=
 =?utf-8?B?OVlZN212c01iTnR4K1FHdElnZ1BldFArcU1BN1JLMitWVi8zV0tsRVptR1pa?=
 =?utf-8?B?cjFRNjR5T3JJblA4SmNlYnhZT3psWnRzK3lKMHlzcytpby9ZTmJrTWMvbEow?=
 =?utf-8?B?N05rSW54eDZGY2Q1M0hySjl4UnZMdzFUL3ZyQ0gyMnhJbEpBMjVZSVVXMy9k?=
 =?utf-8?B?UlQvSm9oVGdrVkxoRGt6Sjdodm42TFo4WWZvbFE2ZU9nUVc5WUZSdmVyUDZa?=
 =?utf-8?B?KzhESnF4bEtqZWowK21yVUdYNHVYNDRrcVNmYlNBdkNkOFV0MW1kc3RBS0NK?=
 =?utf-8?B?UUdqUlZHYmVhdmk2SThsMkN4eVJIamd1c0NUenY5MFBXUlZQazZ1eS9YU3R5?=
 =?utf-8?B?K3lPZXBIR3RnMFJVM29PMlQxK0t4MHZ5OU9hVGtDdklna3ZLK1dhd2c5aUhq?=
 =?utf-8?B?dUJHMHNZTHN6ZllqZDd0Q1NkOC9wRFNya05EdGdHbXpFNXJVOTAxeXplVERC?=
 =?utf-8?B?c2R6eE80ZnBPNnVBeW1aZTViR2U0c1NRZ1dnY3BYeDRjeEpNMi9FenJiTnhG?=
 =?utf-8?B?cTA3L3loQTQ4VzlKaytPc1V6bEE3MFE3WldUclJpSWtrdWpJZHRpdVljMEJm?=
 =?utf-8?B?RnhKd1d6eFpaU0M0Mk1RdEVSOWJnRHNTL2M2YThYcElrV1hXK1JsNXpQT0JL?=
 =?utf-8?B?OVp5SjJnVXJ6QS9nSVdYeUNMWXhQQkVQNE9paG55TXNWWUJQNTl1Yy82aGw2?=
 =?utf-8?B?SVZLU2pFMWI1d0Q3dXJFaXRZRDVpVkVlQUhyTE5YV3lpUlRMZlZGL1JvSUdH?=
 =?utf-8?B?N1l2ZUkrc3p4QVlmMXM2ZStwMng5N3diSkgraEZxNUJ3REErTGh3M2w4MWZY?=
 =?utf-8?B?eHJkK0NHTmhVVFJZVm8wZDFxODB3OUxpYWtSYlFCbDhldFM3YSsxRzBsQ1po?=
 =?utf-8?B?QlBYZ1lwZzJ3Sml2RFlnUHdKd21WNGNuczd3MXFTMXd2NFYwamdBcU8zQ0pY?=
 =?utf-8?B?MDdoakF4VTlJS0hJT0hwZ3pqdFpqVUI0b2Vtck9tMHFXTE5mZ0JCZGxQcThk?=
 =?utf-8?B?ZmhiUC9uaXplKzVlS04rT09Vd2F6L0FnR2N1VzVKb0hSOFN0eFE4VU9yTWd3?=
 =?utf-8?B?VnNzVWhKeG1DTmV6UUlsSEwwMmNaYS83eWxWbHZJVU1RVHFFQ244T1NhZ1U4?=
 =?utf-8?B?eFVQNDZzMWduLytEdmFDYmowSHF2REpYbXE4MnJaVmdaUXo3V1c0WDRpeURx?=
 =?utf-8?B?Sjk3bFIwNG1kYlJQbVVoQy9Nb3Y2VjFBUTBYbSsySnhMTURDZW9QQi9jeVdJ?=
 =?utf-8?B?enZjSG8wUW5pTVBjR0JTazVXdUFvVjM5bHBDMDhaS1k4RWkyR2d3c3BUc3NB?=
 =?utf-8?B?VU11MmZ3U3lvelppRmd2ZEtQVWtiakcyLzZPYWt0Lzl0VllFU0pqZWFmYW5F?=
 =?utf-8?B?d3hlS3FDZG1VKzd6cUpJZ0VQUHM2Z2poVkY1MmoyUWxoazlzSHhLZnNQZ25M?=
 =?utf-8?B?VWt6ZjlRUE94RWtqMk8wa2JweFNZYmJiZjFQenNrWHhCUWx6L296ZnlGQ3Nt?=
 =?utf-8?B?TS9PS2tnSGphZDliYkZuRFNoQjd4MldXQnppalVxZnRUdHdkWkJPUzJKZDZ3?=
 =?utf-8?B?UCtvZDRPTjRkR2ZPbjFuOTJ0RFczL29XaDV0aUNoTnVieGxvTFJTRWFuRU5D?=
 =?utf-8?B?ZmJVak1qekFCNDRHMGNkanJyS0NlYktKR2ZGTDJ6UWFoNkI2YnAxQk9wdjhH?=
 =?utf-8?B?SmxVOG5NaWw2NzVKS1VzYUxqdVAxZlViTk10OVZNdldTOTAzNHhxNHdVOGw4?=
 =?utf-8?B?WDBYN2EzMi9zRDhCL3NMalVDbEs5VldFeWFOSlRlV3VBVmtlSWZmZGVoR3pD?=
 =?utf-8?B?eEJUOVFVSzVZUFdMSi96UDI0bUxaa3pxenIwbFVLdVNuVnVuU0IwbDlEampk?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C86E04DC7FBF24C97067C2D7A23A74E@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5016.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d16648c-699c-46fb-ee2c-08de01abd8fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 12:04:32.4628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10AfcRuhWwoeb/miI9Fk7eyzrudaQ9HmdURsw4HT70Rp+cMr7BIca0AnBjmm/MH1Q4KU2v0VChgSFif+9n/rsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10259
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDEwMiBTYWx0ZWRfX/4Dsw5nlpAJp
 lx8/30iZ0eZubyMygaZ2VzHh3Rj7qi+7/PZtgsm2ScutpA0oLbul1blA+L7D6vqMMkSQ5NtfWWG
 Dbu6qTtMahX2SMsM6irgBDucSP6R9wx+fA5Wro3NoraKrHVN7gR3u8ZP+MBuHeK4ksB1rQ08Y2E
 3HACPrLmOMhiIW9vLsRP+aYjUyypPpVWI9K5mVcHJWgeP9gEVaRqR8OcgzTVC7Y+SmMiNGON6bb
 6XOFkCfU9byNlDccW/RMuSnYuAU7x7fkT0S9BstjQkG4j66kVqTlgICjKkfMSJ9x46wDqM97u3v
 0Y6B2lV1Gx2UmyKuS4cjC0wookG7wu4Kb5UmDV6KnxeyAhkJvTWey8yvnaJ6tBYFFhIt8ZwPxD+
 KABQvu7VSEGY246NLwI3UWa0mebrTw==
X-Authority-Analysis: v=2.4 cv=eM8eTXp1 c=1 sm=1 tr=0 ts=68de6a58 cx=c_pps
 a=WO81/b4ipP7ax+rFmsMjaA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=64Cc0HZtAAAA:8 a=ag1SF4gXAAAA:8 a=ScGGvDOOPzZWhE4XBZQA:9 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: sZsV5LBtrVLk1-hhObu0xuQDqBDtYId6
X-Proofpoint-ORIG-GUID: sZsV5LBtrVLk1-hhObu0xuQDqBDtYId6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

T24gMiBPY3QgMjAyNSwgYXQgMDY6NTUsIEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gSWYgdGhpcyBpcyBhIFBDSS1zcGVjaWZpYyBp
c3N1ZSwgd2h5IG5vdCBjYzogdGhlIHBjaSBkZXZlbG9wZXJzIGFuZA0KPiBtYWludGFpbmVyIGFz
IHdlbGw/DQo+IA0KPiBBbHNvLCBhIFBDSSBwYXRjaCBzaG91bGRuJ3QgYmUgZm9yIHRoZSBkcml2
ZXItY29yZSBvbmx5LCBJIHRoaW5rIHRoZQ0KPiBzdWJqZWN0IGxpbmUgbmVlZHMgdG8gaGF2ZSAi
ZHJpdmVyIGNvcmUiIGluIGl0Lg0KDQpZb3UgYXJlIHJpZ2h0LCB0aGlzIHdvbuKAmXQgYmUgUENJ
LXNwZWNpZmljLiBBbmQgd2lsbCBhZmZlY3QgYWxsIChmdXR1cmUpIGNhbGxlcnMgb2YNCmRldmlj
ZV9pbml0aWFsX3Byb2JlLiBDdXJyZW50bHkgdGhlcmUgYXJlIG9ubHkgdHdvIGNhbGxlcnMsIGJ1
c19wcm9iZV9kZXZpY2UNCmFuZCBwY2lfYnVzX2FkZF9kZXZpY2UsIGhlbmNlIHRoaXMgY2hhbmdl
IG9ubHkgYWZmZWN0cyBQQ0kgZGV2aWNlcyBmb3INCm5vdy4gQnV0IGluIHRoZSBmdXR1cmUgaWYg
dGhlcmUgYXJlIG1vcmUgY2FsbGVycywgdGhlbiB0aG9zZSBkZXZpY2VzIHdpbGwgZ2V0DQp0aGlz
IGJlaGF2aW91ciBhcyB3ZWxsLiBJ4oCZbGwgbWFrZSB0aGlzIGNsZWFyIGluIHRoZSBjb21taXQg
bWVzc2FnZSwgYW5kIHRoZQ0Kc3ViamVjdC4NCg0KQWxzbyBjY2luZyB0aGUgcGNpIGRldmVsb3Bl
cnMuDQoNCj4gSSBkb24ndCBzZWUgd2h5IHRoaXMgaXMgc3BlY2lmaWMgdG8gUENJIFZGIGRldmlj
ZXMuICANCg0KSSBpbmNsdWRlZCBQQ0kgVkYgZGV2aWNlcyBhbmQgaG90LXBsdWdnZWQgUENJZSBk
ZXZpY2VzIGhlcmUgYmVjYXVzZQ0KdGhvc2UgYXJlIHRoZSBvbmx5IHR3byBleGFtcGxlcyB0aGF0
IEkgY2FuIHRoaW5rIG9mIHRoYXQgc3VwcG9ydHMNCuKAnGhvdC1wbHVnZ2luZ+KAnSAoYXQgbGVh
c3Qgb24gdGhlIFBDSSBidXMpLCBhcyBjb2xkLXBsdWdnZWQgUENJIGRldmljZXMNCndpbGwgc3Rp
bGwgdXNlIHRoZSBkZWZhdWx0IHZhbHVlIG9mIGRyaXZlcnNfYXV0b3Byb2JlLCBzbyB3aWxsIG5v
dCBiZQ0KYWZmZWN0ZWQgYnkgdGhpcyBwYXRjaC4gRGV2aWNlcyBvbiBvdGhlciBidXNlcyBzaG91
bGQgbWFpbnRhaW4gdGhlaXINCmN1cnJlbnQgYmVoYXZpb3VyLCBhcyBleHBsYWluZWQgYWJvdmUu
DQoNCg0KPiBEaWQgeW91IHNlZSB0aGUNCj4gcmVjZW50IFBDSSBwYXRjaCBmb3Igbm90IHByb2Jp
bmcgVkYgZGV2aWNlcyB0aGF0IHdhcyBzZW50IG91dCB5ZXN0ZXJkYXk/DQo+IEkgdGhpbmsgdGhh
dCBtaWdodCBmaXggdGhpcyBpbnN0ZWFkOg0KPiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2lu
dC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2xvcmUua2VybmVsLm9yZ19yXzIwMjUxMDAyMDIwMDEw
LjMxNTk0NC0yRDEtMkRqaHViYmFyZC00MG52aWRpYS5jb20mZD1Ed0lCQWcmYz1zODgzR3BVQ09D
aEtPSGlvY1l0R2NnJnI9QzdDMGN4cmVvNnlTRlh4dFQxemVDUENYSTFLUW0wRnZBMlFxMzE0OEpf
byZtPTJvYWItVDc1cjRLTER0Z3c3dU1JOGpTUWRIei1BS2RIdVRmMmhMUmZzN05LY0RhQUUtRmJM
NWVqWWl4U053NkUmcz03ZFBMUXF6dXRPWDhWTjVhWm1wb2xpWmsxMERZR1B6cm1XR1FoVEtDNmVj
JmU9DQo+IA0KDQpBcyBmYXIgYXMgSSBjYW4gdGVsbCwgcGF0Y2ggYWJvdmUgaXMgYWJvdXQgYW4g
b3B0aW1pc2F0aW9uIG9uIGF2b2lkaW5nIA0KY2hlY2tpbmcgYSBkcml2ZXIgZm9yIFZGIGRldmlj
ZSBpZiBpdCBkb2VzbuKAmXQgc3VwcG9ydCBWRnMgYXQgYWxsPyBUaGlzIHBhdGNoIA0KaXMgYWJv
dXQgcmVzcGVjdGluZyB0aGUgZHJpdmVyc19hdXRvcHJvYmUgc3lzZnMga25vYi4NCg0KSGVyZSBp
cyBhIHJlcGhyYXNlZCBjb21taXQgbWVzc2FnZSAobm8gY29kZSBjaGFuZ2UpLCBoYXBweSB0byBz
ZW5kIGENCnYyIGlmIG5lZWRlZC4NCg0KVGhhbmtzLA0KVmluY2VudA0KDQotLSA+OCAtLQ0KDQpT
dWJqZWN0OiBbUEFUQ0hdIGRyaXZlciBjb3JlOiBQQ0k6IENoZWNrIGRyaXZlcnNfYXV0b3Byb2Jl
IGZvciBhbGwgYWRkZWQNCmRldmljZXMNCg0KV2hlbiBhIGRldmljZSBpcyBob3QtcGx1Z2dlZCwg
dGhlIGRyaXZlcnNfYXV0b3Byb2JlIHN5c2ZzIGF0dHJpYnV0ZSBpcw0Kbm90IGNoZWNrZWQuIFRo
aXMgbWVhbnMgdGhhdCBkcml2ZXJzX2F1dG9wcm9iZSBpcyBub3Qgd29ya2luZyBhcw0KaW50ZW5k
ZWQsIGUuZy4gaG90LXBsdWdnZWQgUENJZSBkZXZpY2VzIHdpbGwgc3RpbGwgYmUgYXV0b3Byb2Jl
ZCBhbmQNCmJvdW5kIHRvIGRyaXZlcnMgZXZlbiB3aXRoIGRyaXZlcnNfYXV0b3Byb2JlIGRpc2Fi
bGVkLg0KDQpNYWtlIHN1cmUgYWxsIGRldmljZXMgY2hlY2sgZHJpdmVyc19hdXRvcHJvYmUgYnkg
cHVzaGluZyB0aGUNCmRyaXZlcnNfYXV0b3Byb2JlIGNoZWNrIGludG8gZGV2aWNlX2luaXRpYWxf
cHJvYmUuIFRoaXMgd2lsbCBvbmx5DQphZmZlY3QgZGV2aWNlcyBvbiB0aGUgUENJIGJ1cyBmb3Ig
bm93IGFzIGRldmljZV9pbml0aWFsX3Byb2JlIGlzIG9ubHkNCmNhbGxlZCBieSBwY2lfYnVzX2Fk
ZF9kZXZpY2UgYW5kIGJ1c19wcm9iZV9kZXZpY2UgKGJ1dCBidXNfcHJvYmVfZGV2aWNlDQphbHJl
YWR5IGNoZWNrcyBmb3IgYXV0b3Byb2JlKS4gSW4gcGFydGljdWxhciBmb3IgdGhlIFBDSSBkZXZp
Y2VzLCBvbmx5DQpob3QtcGx1Z2dlZCBQQ0llIGRldmljZXMvVkZzIHNob3VsZCBiZSBhZmZlY3Rl
ZCBhcyB0aGUgZGVmYXVsdCB2YWx1ZSBvZg0KcGNpL2RyaXZlcnNfYXV0b3Byb2JlIHJlbWFpbnMg
MSBhbmQgY2FuIG9ubHkgYmUgY2xlYXJlZCBmcm9tIHVzZXJsYW5kLg0KDQpBbnkgZnV0dXJlIGNh
bGxlcnMgb2YgZGV2aWNlX2luaXRpYWxfcHJvYmUgd2lsbCByZXNwc2VjdCB0aGUNCmRyaXZlcnNf
YXV0b3Byb2JlIHN5c2ZzIGF0dHJpYnV0ZSwgYnV0IHRoaXMgc2hvdWxkIGJlIHRoZSBpbnRlbmRl
ZA0KcHVycG9zZSBvZiBkcml2ZXJzX2F1dG9wcm9iZS4NCg0KU2lnbmVkLW9mZi1ieTogVmluY2Vu
dCBMaXUgPHZpbmNlbnQubGl1QG51dGFuaXguY29tPg0KDQpMaW5rOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy8yMDI1MTAwMTE1MTUwOC4xNjg0NTkyLTEtdmluY2VudC5saXVAbnV0YW5peC5jb20N
Ci0tLQ0KZHJpdmVycy9iYXNlL2J1cy5jIHwgIDMgKy0tDQpkcml2ZXJzL2Jhc2UvZGQuYyAgfCAx
MCArKysrKysrKystDQoyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvYnVzLmMgYi9kcml2ZXJzL2Jhc2Uv
YnVzLmMNCmluZGV4IDVlNzVlMWJjZTU1MS4uMzIwZTE1NWM2YmU3IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9iYXNlL2J1cy5jDQorKysgYi9kcml2ZXJzL2Jhc2UvYnVzLmMNCkBAIC01MzMsOCArNTMz
LDcgQEAgdm9pZCBidXNfcHJvYmVfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikNCiAgICAgICBp
ZiAoIXNwKQ0KICAgICAgICAgICAgICAgcmV0dXJuOw0KDQotICAgICAgIGlmIChzcC0+ZHJpdmVy
c19hdXRvcHJvYmUpDQotICAgICAgICAgICAgICAgZGV2aWNlX2luaXRpYWxfcHJvYmUoZGV2KTsN
CisgICAgICAgZGV2aWNlX2luaXRpYWxfcHJvYmUoZGV2KTsNCg0KICAgICAgIG11dGV4X2xvY2so
JnNwLT5tdXRleCk7DQogICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShzaWYsICZzcC0+aW50ZXJm
YWNlcywgbm9kZSkNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvZGQuYyBiL2RyaXZlcnMvYmFz
ZS9kZC5jDQppbmRleCAxM2FiOThlMDMzZWEuLjM3ZmM1N2U0NGU1NCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvYmFzZS9kZC5jDQorKysgYi9kcml2ZXJzL2Jhc2UvZGQuYw0KQEAgLTEwNzcsNyArMTA3
NywxNSBAQCBFWFBPUlRfU1lNQk9MX0dQTChkZXZpY2VfYXR0YWNoKTsNCg0Kdm9pZCBkZXZpY2Vf
aW5pdGlhbF9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQp7DQotICAgICAgIF9fZGV2aWNlX2F0
dGFjaChkZXYsIHRydWUpOw0KKyAgICAgICBzdHJ1Y3Qgc3Vic3lzX3ByaXZhdGUgKnNwID0gYnVz
X3RvX3N1YnN5cyhkZXYtPmJ1cyk7DQorDQorICAgICAgIGlmICghc3ApDQorICAgICAgICAgICAg
ICAgcmV0dXJuOw0KKw0KKyAgICAgICBpZiAoc3AtPmRyaXZlcnNfYXV0b3Byb2JlKQ0KKyAgICAg
ICAgICAgICAgIF9fZGV2aWNlX2F0dGFjaChkZXYsIHRydWUpOw0KKw0KKyAgICAgICBzdWJzeXNf
cHV0KHNwKTsNCn0NCg0KLyoNCi0tDQoyLjQzLjc=

