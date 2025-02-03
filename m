Return-Path: <linux-pci+bounces-20648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D33A8A251DD
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 05:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833543A44A7
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 04:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B4941760;
	Mon,  3 Feb 2025 04:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="CVx46RwT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A44F259C;
	Mon,  3 Feb 2025 04:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738557311; cv=fail; b=h3uZze+aJt+63a78igAxVSYrhJquyYNsfVTab7LzN9FAian5QI+kl1mnqNHKtNv7ZQLZo7bZJStg8gPUDqya+jvzxFz0lifb0bEpDqOhKSS+jJWaFc6OPLY6TL5QkKAOj39HDWCnuL71irn+aZTRG+k2NtOiZ7wZ5ObpNjXLlKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738557311; c=relaxed/simple;
	bh=uIQi7kS8NdPUv99Kq0AqsUbaWUKSDg00Il4UVdu0aRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RzpKnkbw3ObG00L8niHbldQNAhJTAS3e+mVc7GjeWO4CotyKlHF7a2WteZmg3LboeFTRig5TkouV8HrqiMen+E+CrNmUf7thDwRw8Ez7phdhEJD2ya+YXM47B4L6PPZLlCkP9U7iXTVdU/PSZN5WmN+DLFVEayUDG91cTkA8FS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=CVx46RwT; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5130X8xM031897;
	Sun, 2 Feb 2025 20:34:46 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44jh4w8e2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Feb 2025 20:34:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcVLVJEAhroH3E+9U+IG4F+X9A0JyqrSltsjILogRUq7oPpTvJnpQd3h1S6SFXW7+2Cv/drT04k33/kEmY5bi5WANVscugjcdCZr8a7CPc0J0LU8VFohvTsRNZfbBsu4YrK6Lu3sG9vMDaWZUgBVuQM3Od+hcrX513CKWqxmbtEf/atga8AgwFagHNbYiULkzeH62t3be5Ycsl0xWIB6syFAf8CjpmemcWm+MrVLdHtjNaH3M3e4LzUWa9fydW/FC+Wu9nPA7Tp97qxznuYBx58IE6JTv7E/FTdYHrqGuRCqT91siMYWU0kM71CeVaOigGrjVutOZz1iy0jtjLfodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIQi7kS8NdPUv99Kq0AqsUbaWUKSDg00Il4UVdu0aRo=;
 b=IVkLJoSOziMP3xoqu5JeP0uOlYVwoZc/kqomP9iXP0giDH3082LCjKkyEoa0Z38X/ETt7w/qljKnFJOUTc6kbmHccZZb+Xyk7QTvxqQcK1axZ8OpSMexwRb64vpnI1lD3yq/p6M2mIKXr4YgYvtBsz48gDTsys+gc7F4o59fThch5Xo+On9Koh1gXDWneBmaWQHwqS3xywXbvyboJ1slLLR21WgjvQY4J0dAW3ztuEGDtNQNmxufEJ85mglmwVJ0fzux2IIqHor45G0kGA3J/FtuOjMESf8HX7VFMI9zCQFaWs1I5/WzTHakgQC6kaAVYGLWpVuz5SsdsDBT9YzdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIQi7kS8NdPUv99Kq0AqsUbaWUKSDg00Il4UVdu0aRo=;
 b=CVx46RwTOSh9xevIJ5LUvIMAm5mLi5eI/cFifRzQkCvePCWBBhG1/tsK6pHJ21SYxCJR0QbUW86wC/X7a0SIitEDBMH6qmnWz8pCVMWKWDbwNosI+sYblWZnsMEJYDsnieex9hODp+56RvwkVaYQuDuW3XDrL4YzDUgwZgUaipg=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by BL1PR18MB4117.namprd18.prod.outlook.com (2603:10b6:208:310::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 04:34:43 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%3]) with mapi id 15.20.8398.020; Mon, 3 Feb 2025
 04:34:43 +0000
From: Wilson Ding <dingwei@marvell.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "kw@linux.com"
	<kw@linux.com>,
        "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanghoon Lee <salee@marvell.com>
Subject: RE: [PATCH 1/1] PCI: armada8k: Fix bar assignment failure upon rescan
Thread-Topic: [PATCH 1/1] PCI: armada8k: Fix bar assignment failure upon
 rescan
Thread-Index: AQHbdfRBH7uueiNHA0msuagcPXJBM7M0/K7w
Date: Mon, 3 Feb 2025 04:34:43 +0000
Message-ID:
 <BY3PR18MB46731C643C15D3F0AA473977A7F52@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20241112073227.769814-1-jpatel2@marvell.com>
 <20241112213941.GA1861660@bhelgaas>
 <BY3PR18MB467388C5289E714475F334D8A7F52@BY3PR18MB4673.namprd18.prod.outlook.com>
In-Reply-To:
 <BY3PR18MB467388C5289E714475F334D8A7F52@BY3PR18MB4673.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|BL1PR18MB4117:EE_
x-ms-office365-filtering-correlation-id: 2a273279-d2a3-4217-fe92-08dd440c14e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlNVbXpsSGhuMHo1bUhxbWo4VW51bGorV2YxRnY2aDJ5ZldxTGNvd1dUQ0J1?=
 =?utf-8?B?eVNLNVdrZy9FUUkrNnJ6Mmp4MEVzd3kxajMzcm5hamJsTkdnRkhJU0VNS1pJ?=
 =?utf-8?B?SFo0NnEwbjhQZmY0Zy9TS3R5NzhValg5SWtiNFRCeU1adWtsVHVrYmppeGdT?=
 =?utf-8?B?Ylo1M3dRT1ZZQ293Y0hwTmEvNGo5MFFEY3BwbHdnb0k4L0x0ZEE2eVJDUnp2?=
 =?utf-8?B?TUs2QUhLNllTV0ljU3Q1cmtNMmQxaUtoT3RZdHlIaGhZN0RKL1VrcThsa0xj?=
 =?utf-8?B?aWxXenF6OHFEN1YydzBZcUVOK3ZxUGhQRlZkT3N4cE5idUd6NFJrbytZZE0y?=
 =?utf-8?B?T3RXdW9FcXozMUxMZnNIMlhudzFwcGIvMmNhVklxZ3NIMUJ4QktqbHpjSEdW?=
 =?utf-8?B?V3RuU1ZTVkJzMzlieVJ2ZXEyWkJwckQ2RE0zYmJKVml1S0dWZnloTXlROWlW?=
 =?utf-8?B?TXFkMHhyV2Q4OHZJNkRubWtncTNJNkhwU3l3UUpsVnczZUcwNFpaWi9OQXFE?=
 =?utf-8?B?TGxKR0tPZGEzTnU0eE5BdVJWUnBOajdLTG5TK1ZSSS92UjJ6UkxCS2Z0TFdO?=
 =?utf-8?B?QlJnQmdCenN4V0l0dmF0TGl0R3ZyUlFWdnpWRWFuZk5iS1dwc3ZoTzBGMFZK?=
 =?utf-8?B?TmJhTm1EVklIK3poSkpuYk1BeFFnZWRxOTc0NHM5OHV4cmxjY0ozQWJJb0ZW?=
 =?utf-8?B?NDV3OFBQZ3ZyQjhlSncwRG14SUpGNklzUFo5VHJBOGdFdTBZd2I0dzlkdTdu?=
 =?utf-8?B?Z0dWalNhcmEwTGRhOVRUcmh4UFNCeUFVaFBKMHh3NVcyOFdXdlp0ZVBRN051?=
 =?utf-8?B?Smo3VEJDWVpMbGUwMm01UW10K2RiL3NTZlBNZHV1NFJxNG5hRnRpYlVIYlFY?=
 =?utf-8?B?c2RmT2k0VkphUEU2Vm5YS2hhekdQQ2ZYQklCSU04NXNBRyttSVhVZjdRYVRl?=
 =?utf-8?B?MW12NERFbXlEbWc1NUR6ZkVvcE94aHAxQmI1SmhBcWdla1g5TzlsakdldmpC?=
 =?utf-8?B?d25CMkVSUnR1ckxDRTE5ZUREN0E5OWlCTmtNY2hIN2NIMEJpL1dNOG5oMVRH?=
 =?utf-8?B?clY1VVUxU1E5UHpMZVhzZUR6a3FvSG5adU1mRHcvZ3p0clRZNnVxWlZCMDcw?=
 =?utf-8?B?NjlsNnNMeFBjSDVBaVBqNGNzeTZIVjJsODN4NjI4TklLOHZYajFMcjU2SEdO?=
 =?utf-8?B?UWhjcHFxUnZhdE5vMjdhdy9ZVE1GRDFXSS96Q0paS3lVT3h3UmtQYi9OTjd2?=
 =?utf-8?B?SnJlNWt5SEJrbnppbEMvR0pWRm9qUnd6RU82aGpCZHk1SFh0cTVWanRkM2Ju?=
 =?utf-8?B?V3lMazNRYWZYY05iSmIxRTZQSmtwQ0xkcGp0QmJvTEJ2VS9aQldnMTFWSE5W?=
 =?utf-8?B?cFJGQk0yaitaOFFmdGsxcDdDRlZtcTk2S0lyTVdZNWo0T3VXQ2hpTnRGeHQr?=
 =?utf-8?B?ODFjRzBZU3Rpd2ZJMk9jL0lTNWJiZkEvbWRQMm9JWDNqRUZ5YmxFQmJweU5T?=
 =?utf-8?B?TVZGSG9zNnVSTGFNc3RLQ1N0UHYvamtnM3BPK3hmbGZxYnFXZnhpN2FBY1gz?=
 =?utf-8?B?d2pRakhrTjlRVzFKQVMzNzVNNy9jZjlPNTQvdzcwcWlwSTMyam5Dd2tWdWVE?=
 =?utf-8?B?eVJGenNmdmFrbEhVbFRKcXRDYXNib1k4MXJLdzZzaGtzNHdjRjZ5dklDd1dm?=
 =?utf-8?B?L0J0ZEoxVStDdGZjWEN5Tk9aTllyaHcyOGo2SnFTcXM5SGlwcmlCQzhrRUly?=
 =?utf-8?B?T1VtUUdXdFJDYU9zamY1cXRpZmxkWHRJbHdjS3l5NndsU2JxajdCMFRtdytD?=
 =?utf-8?B?TldiMDJLa0N3S1lnbVhrcUY2TGFSelNBZ1Z2cW5QTmZ4TDJIM01JTVE3bktX?=
 =?utf-8?B?TE9VdmZpTnl4T0VZbUVUVkFiaWJtcU1JSGQybTlhRnpqWGw2aEE3YUZjZzNv?=
 =?utf-8?Q?iUfna2XSQ+bTTJaJm5uL3YQpIWhiLEBD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ym1TN3VkU1pZc1IxS3NGcVFGbTg3c0V2RXBqcjkwbzJKcTE0ZXN4WjZCRVNl?=
 =?utf-8?B?eUJwdGgwY1lWdng4ZzJWVUdVWVhaSjE1NnZXWHpib3RGZGE1U3JNVXY3RmZ3?=
 =?utf-8?B?M1BIcHBCQmg2cjF6aWFsUG9jOS84bk1sc3QwaEp2RTJRTHA1MjlERnRnb0NC?=
 =?utf-8?B?N2h2N0hlWTdtbUl0WnM3emlBbWkwUDdDb1hCWjJpSEt4Nktrb2RaN0VEV3Ju?=
 =?utf-8?B?blFBejhzYmdHOTNTOXgvUmVObWxpMnJEYWROYm16cEI4eS9aNDFSd2FHejNO?=
 =?utf-8?B?aTJMNDVkcTlCbmNPcEJ5WmhnbVl2WVhvTzcwQ3RhK2p1blh6VlNVR2ZnTGxw?=
 =?utf-8?B?UUhpUmJ3RGV3S2FIdSs5cUcraTNaa0p4cEVaZ3RiUGxPaGRmemZ4MVNOMEVR?=
 =?utf-8?B?emZJRHFqeFJaRUIzd2I3Nyt5RFJxZmxoTFJiQUdubElPYy9sZDRoVm9mYm0y?=
 =?utf-8?B?ckZNbG5aS0N5dmJ4c1FTTmtZaTNWMThlcXM0bzdjTmE5MHEvYmticGxieVBH?=
 =?utf-8?B?WDBlL0FkbzFJODVCOVV1elB2VTFuTmRxVVlnQXdFMXZhbFlzS2FMdFZkMk5t?=
 =?utf-8?B?cno2cW1tc1Z6QzNtREJ6U2F4dHpUcVdMcVMyMGRBai9FcFdJSFRmNm1uM0Jj?=
 =?utf-8?B?WFZ1SW1lZmdLb3MwSU43eXFlbkpjdWlXU3NnTDNSTDJSdTd1TnJZT3RXby9C?=
 =?utf-8?B?WTl5d0c2ajhOM0toODlwa1hrT2Y0dytsQ1hxM3g5c0lBSU1MRGNrSDNwQyth?=
 =?utf-8?B?TlE1b0RiSW9MVG90TE5MOWt3SVNtUmZsU2lWNkZLU3NMSm1Ec3loZVE0YzdW?=
 =?utf-8?B?NUZHWUUrSXlFN0JFd0VyTlkzTUl4KzVyTVJPOXc0UHF2UkVnYUFDeGdaUEJX?=
 =?utf-8?B?OXNLMHFVbVBCNXNZUEszY3RhbHdwbWpZUWsxc04wM2Q4WTRKUTQ4bVF5YlFM?=
 =?utf-8?B?bDNPSDB5ZzFDb0w0V05ZaFZEQzh5Z1dwQTFXazBHMjdVdVpoWUdSaEJJbi9N?=
 =?utf-8?B?ZDZDNkFwTG0yTjlRajkrdWlGc3R2a3FwSG9XQ0dvcXlwalNmZ0FnYnQzQVcr?=
 =?utf-8?B?azBCR1dXRFQzMDFHdkxwTHd6M3lrNk56dXpLOEdRNnRlVjVYcjhNWEx4SUFs?=
 =?utf-8?B?b3FETUhMbjFqdG45YmIrWE16WDhKR0drYjN1Vit1VkVvNE93YUxMdHNrTlpN?=
 =?utf-8?B?cDhUVXdaeG9DWmRvNm5FSEIvOStDSEtjM3M5NTJYbTlPQmhkeVQ0a0pvUldW?=
 =?utf-8?B?bkdubWphaEJETnNMY1VzakFxN1N6L0FrNGlYU0NIcHFYYk8rVFZDKzZLdXdZ?=
 =?utf-8?B?dUVtT3NGeFY4Z25mM3lOdUdrMjRidE5zditvMkFmdXVNdHNzWlpBb1FGeVVU?=
 =?utf-8?B?dWZBVG5CdlRUZWlQSnQyeGt2UVNrRlRvc280ejMvOXZ3dUJjajNHWTJpM3dI?=
 =?utf-8?B?UkhVUUgzMlRUeE9GTDdBTGtYODF5Z3liOEZBN3drN3pxTFlaeUphL0JPT0RZ?=
 =?utf-8?B?ZDlJdTg4NDlTMEVGTmZWTGI1bEo1cVNBSGhzbENidTdaTzVHSktHLzJKUkpp?=
 =?utf-8?B?Z2dEZ1FxeW1SVUw5bVREa2JHN0tNNVVyUlNKc25KV2l1cEkxQThmM3Z6cDRM?=
 =?utf-8?B?UnA5dGFkOVc0cG9Dc2VQYnlrZlRQMjRVSVljVHg2SU5LUXYvRjRObnlUL0pa?=
 =?utf-8?B?UFFkU2ZVSkRsSjcyaTViTkFVV2NvcUp2RzNZVE1udXVLVms5bmtFeE1qeXpU?=
 =?utf-8?B?MmxnYnkwVTAwbUxiR3NjQTlXR0ErTnMvTXhPazhHZk44SlpDNnhtSnFnL3A2?=
 =?utf-8?B?MFBLZXJ1eEdrSXFxRHlQME1QRU9MNVo5S3dVZlh0RDdkN3c1S2FzVXgzQzRT?=
 =?utf-8?B?dEo3SW1jMWhGSHUreU9CSEY4akh4ZTNjditpZnNwOFJxL25ocXNVUnNhdzd0?=
 =?utf-8?B?N1JrbU01TDg4cGFhRDdQL2p0eWh4V0FaTzBidkZCZkQvcVVzcmtUTlhwdVhR?=
 =?utf-8?B?NUxZUWxoRmRjYktvVFA1NkYyVmtCc1dpVjhpYzJkRjRpU0VxVVdMTWdPV2xr?=
 =?utf-8?B?S2h5VWhRcXEwekplaExXcG9wU1JiUjU0Sk9tcTZoU3NMWGpIOHRuS0cyZFRG?=
 =?utf-8?B?eVQrQkUxQ3hhZWIwVVFZKzFwcGM4MlhTRWpLcHYyeDVpQlJwK1cybnAzVG0z?=
 =?utf-8?Q?IWmnA8el3FoRCGEntmI/oYFhlLHqkGXmWjiRwuc1xbgu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a273279-d2a3-4217-fe92-08dd440c14e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 04:34:43.7261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 49kruJ/KgpZC5uyQjJnNr1iMMRsbDbsfgP9FfOeBSXAw8y8jDwoRK0GREIPqqsRI+VwJwPknQoMAYTUZKUJUvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4117
X-Proofpoint-ORIG-GUID: HrHrIe88Nn0vkEM5UK9wnlqREnrHnFPf
X-Proofpoint-GUID: HrHrIe88Nn0vkEM5UK9wnlqREnrHnFPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_01,2025-01-31_02,2024-11-22_01

VGhpcyBpcyBhIGZpeCB0byBhbm90aGVyIHBhdGNoIGluIHRoZSBzZXJpZXMuIEkgd291bGQgbGlr
ZSB0byBzcXVhc2ggaXQgaW50byB0aGUNCmNvbW1pdCAoIlBDSTogYXJtYWRhOGs6IEFkZCBsaW5r
LWRvd24gaGFuZGxlIikgbGF0ZXIuDQoNCj4gT24gTW9uLCBOb3YgMTEsIDIwMjQgYXQgMTE6MzI6
MjdQTSAtMDgwMCwgSmVuaXNoa3VtYXIgTWFoZXNoYmhhaSBQYXRlbA0KPiB3cm90ZToNCj4gPiBX
aGVuIHRoZSBhdHRhY2hlZCBkZXZpY2UgcmVjb3ZlcnMgdGhlIGxpbmsgZnJvbSBhbiBleHRlcm5h
bCByZXNldCwgdGhlDQo+ID4gZm9sbG93aW5nIGVycm9yIG1pZ2h0IGJlIHNlZW4gdXBvbiBwY2kg
cmVzY2FuLg0KPiA+DQo+ID4gT24gbGluay1kb3duIGV2ZW50LCBpdCdzIG5vdCBuZWNlc3Nhcnkg
dG8gcmVtb3ZlIHRoZSByb290IGJ1cy4gT25seQ0KPiA+IHRoZSBjaGlsZCBidXNlcyBvciBkZXZp
Y2VzIHNob3VsZCBiZSB3aXBlZCBvZmYuIEhvd2V2ZXIsIHRoZSByZXNjYW4NCj4gPiBvcGVyYXRp
b24gc2hvdWxkIGJlIHBlcmZvcm1lZCBvbmx5IHdoZW4gdGhlIGxpbmsgY291bGQgYmUgcmV0YWlu
ZWQuDQo+ID4gT3RoZXJ3aXNlLCBpdCBzaG91bGQgYmUgZG9uZSBieSBhIHVzZXIgbWFudWFsbHkg
YWZ0ZXIgdGhlIGxpbmsgaXMNCj4gPiBmaW5hbGx5IHJlY292ZXJlZC4NCj4gDQo+IFdyYXAgdG8g
ZmlsbCA3NSBjb2x1bW5zLg0KPiANCj4gcy9wY2kvUENJLw0KPiBzL2Jhci9CQVIvIChzdWJqZWN0
KQ0KPiANCj4gPiB+IyBlY2hvIDEgPiAvc3lzL2J1cy9wY2kvcmVzY2FuDQo+ID4gWyAgMzIyLjg1
NzUwNF0gcGNpIDAwMDA6MDE6MDAuMDogWzE3N2Q6YjIwMF0gdHlwZSAwMCBjbGFzcyAweDAyODAw
MCBbDQo+ID4gMzIyLjg2MzY4Ml0gcGNpIDAwMDA6MDE6MDAuMDogcmVnIDB4MTA6IFttZW0gMHgw
MDAwMDAwMC0weDAwN2ZmZmZmDQo+ID4gNjRiaXQgcHJlZl0gWyAgMzIyLjg3MTAzMV0gcGNpIDAw
MDA6MDE6MDAuMDogcmVnIDB4MTg6IFttZW0NCj4gPiAweDAwMDAwMDAwLTB4MGZmZmZmZmYgNjRi
aXQgcHJlZl0gWyAgMzIyLjg3ODM2Ml0gcGNpIDAwMDA6MDE6MDAuMDogcmVnDQo+ID4gMHgyMDog
W21lbSAweDAwMDAwMDAwLTB4MDNmZmZmZmYgNjRiaXQgcHJlZl0gWyAgMzIyLjg4Njg0NV0gcGNp
DQo+ID4gMDAwMDowMTowMC4wOiByZWcgMHgyNDQ6IFttZW0gMHgwMDAwMDAwMC0weDAwMGZmZmZm
IDY0Yml0IHByZWZdIFsNCj4gPiAzMjIuODk0MTkzXSBwY2kgMDAwMDowMTowMC4wOiBWRihuKSBC
QVIwIHNwYWNlOiBbbWVtDQo+ID4gMHgwMDAwMDAwMC0weDAwN2ZmZmZmIDY0Yml0IHByZWZdIChj
b250YWlucyBCQVIwIGZvciA4IFZGcykgWw0KPiA+IDMyMi45MDUxNTRdIHBjaSAwMDAwOjAxOjAw
LjA6IDQuMDAwIEdiL3MgYXZhaWxhYmxlIFBDSWUgYmFuZHdpZHRoLA0KPiA+IGxpbWl0ZWQgYnkg
Mi41IEdUL3MgUENJZSB4MiBsaW5rIGF0IDAwMDA6MDA6MDAuMCAoY2FwYWJsZSBvZiA2My4wMDgN
Cj4gPiBHYi9zIHdpdGggOC4wIEdUL3MgUENJZSB4OCBsaW5rKSBbICAzMjIuOTIxMzcxXSBwY2ll
cG9ydCAwMDAwOjAwOjAwLjA6DQo+ID4gQkFSIDE1OiBubyBzcGFjZSBmb3IgW21lbSBzaXplIDB4
MTgwMDAwMDAgNjRiaXQgcHJlZl0gWyAgMzIyLjkyOTUwN10NCj4gPiBwY2llcG9ydCAwMDAwOjAw
OjAwLjA6IEJBUiAxNTogZmFpbGVkIHRvIGFzc2lnbiBbbWVtIHNpemUgMHgxODAwMDAwMA0KPiA+
IDY0Yml0IHByZWZdIFsgIDMyMi45Mzc5OTldIHBjaWVwb3J0IDAwMDA6MDA6MDAuMDogQkFSIDE1
OiBubyBzcGFjZSBmb3INCj4gPiBbbWVtIHNpemUgMHgxODAwMDAwMCA2NGJpdCBwcmVmXSBbICAz
MjIuOTQ2MTMxXSBwY2llcG9ydCAwMDAwOjAwOjAwLjA6DQo+ID4gQkFSIDE1OiBmYWlsZWQgdG8g
YXNzaWduIFttZW0gc2l6ZSAweDE4MDAwMDAwIDY0Yml0IHByZWZdIFsNCj4gPiAzMjIuOTU0NjE0
XSBwY2kgMDAwMDowMTowMC4wOiBCQVIgMjogbm8gc3BhY2UgZm9yIFttZW0gc2l6ZSAweDEwMDAw
MDAwDQo+ID4gNjRiaXQgcHJlZl0gWyAgMzIyLjk2MjIyNV0gcGNpIDAwMDA6MDE6MDAuMDogQkFS
IDI6IGZhaWxlZCB0byBhc3NpZ24NCj4gPiBbbWVtIHNpemUgMHgxMDAwMDAwMCA2NGJpdCBwcmVm
XSBbICAzMjIuOTcwMTkzXSBwY2kgMDAwMDowMTowMC4wOiBCQVINCj4gPiA0OiBubyBzcGFjZSBm
b3IgW21lbSBzaXplIDB4MDQwMDAwMDAgNjRiaXQgcHJlZl0gWyAgMzIyLjk3NzgwNF0gcGNpDQo+
ID4gMDAwMDowMTowMC4wOiBCQVIgNDogZmFpbGVkIHRvIGFzc2lnbiBbbWVtIHNpemUgMHgwNDAw
MDAwMCA2NGJpdCBwcmVmXQ0KPiA+IFsgIDMyMi45ODU3NjZdIHBjaSAwMDAwOjAxOjAwLjA6IEJB
UiAwOiBubyBzcGFjZSBmb3IgW21lbSBzaXplDQo+ID4gMHgwMDgwMDAwMCA2NGJpdCBwcmVmXSBb
ICAzMjIuOTkzMzczXSBwY2kgMDAwMDowMTowMC4wOiBCQVIgMDogZmFpbGVkDQo+ID4gdG8gYXNz
aWduIFttZW0gc2l6ZSAweDAwODAwMDAwIDY0Yml0IHByZWZdIFsgIDMyMy4wMDEzMzFdIHBjaQ0K
PiA+IDAwMDA6MDE6MDAuMDogQkFSIDc6IG5vIHNwYWNlIGZvciBbbWVtIHNpemUgMHgwMDgwMDAw
MCA2NGJpdCBwcmVmXSBbDQo+ID4gMzIzLjAwODkzOF0gcGNpIDAwMDA6MDE6MDAuMDogQkFSIDc6
IGZhaWxlZCB0byBhc3NpZ24gW21lbSBzaXplDQo+ID4gMHgwMDgwMDAwMCA2NGJpdCBwcmVmXSBb
ICAzMjMuMDE2OTAzXSBwY2kgMDAwMDowMTowMC4wOiBCQVIgMjogbm8NCj4gPiBzcGFjZSBmb3Ig
W21lbSBzaXplIDB4MTAwMDAwMDAgNjRiaXQgcHJlZl0gWyAgMzIzLjAyNDUxMV0gcGNpDQo+ID4g
MDAwMDowMTowMC4wOiBCQVIgMjogZmFpbGVkIHRvIGFzc2lnbiBbbWVtIHNpemUgMHgxMDAwMDAw
MCA2NGJpdCBwcmVmXQ0KPiA+IFsgIDMyMy4wMzI0NjldIHBjaSAwMDAwOjAxOjAwLjA6IEJBUiA0
OiBubyBzcGFjZSBmb3IgW21lbSBzaXplDQo+ID4gMHgwNDAwMDAwMCA2NGJpdCBwcmVmXSBbICAz
MjMuMDQwMDc5XSBwY2kgMDAwMDowMTowMC4wOiBCQVIgNDogZmFpbGVkDQo+ID4gdG8gYXNzaWdu
IFttZW0gc2l6ZSAweDA0MDAwMDAwIDY0Yml0IHByZWZdIFsgIDMyMy4wNDgwMzddIHBjaQ0KPiA+
IDAwMDA6MDE6MDAuMDogQkFSIDA6IG5vIHNwYWNlIGZvciBbbWVtIHNpemUgMHgwMDgwMDAwMCA2
NGJpdCBwcmVmXSBbDQo+ID4gMzIzLjA1NTY0NF0gcGNpIDAwMDA6MDE6MDAuMDogQkFSIDA6IGZh
aWxlZCB0byBhc3NpZ24gW21lbSBzaXplDQo+ID4gMHgwMDgwMDAwMCA2NGJpdCBwcmVmXSBbICAz
MjMuMDYzNjAxXSBwY2kgMDAwMDowMTowMC4wOiBCQVIgNzogbm8NCj4gPiBzcGFjZSBmb3IgW21l
bSBzaXplIDB4MDA4MDAwMDAgNjRiaXQgcHJlZl0gWyAgMzIzLjA3MTIxMV0gcGNpDQo+ID4gMDAw
MDowMTowMC4wOiBCQVIgNzogZmFpbGVkIHRvIGFzc2lnbiBbbWVtIHNpemUgMHgwMDgwMDAwMCA2
NGJpdCBwcmVmXQ0KPiA+IFsgIDMyMy4wODE5MTRdIHBjaWVwb3J0IDAwMDI6MDI6MDMuMDogZGV2
aWNlcyBiZWhpbmQgYnJpZGdlIGFyZQ0KPiA+IHVudXNhYmxlIGJlY2F1c2UgW2J1cyAwM10gY2Fu
bm90IGJlIGFzc2lnbmVkIGZvciB0aGVtIFsgIDMyMy4wOTIzODRdDQo+ID4gcGNpZXBvcnQgMDAw
MjowMjowNy4wOiBkZXZpY2VzIGJlaGluZCBicmlkZ2UgYXJlIHVudXNhYmxlIGJlY2F1c2UgW2J1
cw0KPiA+IDA0XSBjYW5ub3QgYmUgYXNzaWduZWQgZm9yIHRoZW0gWyAgMzIzLjEwMjg1N10gcGNp
ZXBvcnQgMDAwMjowMTowMC4wOg0KPiA+IGJyaWRnZSBoYXMgc3Vib3JkaW5hdGUgMDIgYnV0IG1h
eCBidXNuIDA0DQo+IA0KPiBSZW1vdmUgdGltZXN0YW1wczsgdGhleSBkb24ndCBoZWxwIHVzIHVu
ZGVyc3RhbmQuICBXZSBwcm9iYWJseSBkb24ndCBuZWVkDQo+ICphbGwqIHRoZSBsaW5lcyBoZXJl
IHRvIHVuZGVyc3RhbmQgdGhlIHByb2JsZW0uDQo+IA0KPiBDb2xsZWN0IG91dHB1dCBmcm9tIGN1
cnJlbnQga2VybmVsLCB3aGljaCBzaG91bGQgdXNlIG1vcmUgdXNlZnVsIGxhYmVscyB0aGFuDQo+
ICJyZWcgMHgxMCIsICJCQVIgMTUiLCBldGMuDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEplbmlz
aGt1bWFyIE1haGVzaGJoYWkgUGF0ZWwNCj4gPiA8bWFpbHRvOmpwYXRlbDJAbWFydmVsbC5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtYXJtYWRhOGsu
YyB8IDE5ICsrKysrKysrKysrKysrLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS1hcm1hZGE4ay5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLWFybWFkYThrLmMNCj4gPiBpbmRleCBmOWQ2OTA3OTAwZDEuLmNhMmRl
ZGFhNjlhNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LWFybWFkYThrLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFy
bWFkYThrLmMNCj4gPiBAQCAtMjMxLDYgKzIzMSw3IEBAIHN0YXRpYyB2b2lkIGFybWFkYThrX3Bj
aWVfcmVjb3Zlcl9saW5rKHN0cnVjdA0KPiB3b3JrX3N0cnVjdCAqd3MpDQo+ID4gIAlzdHJ1Y3Qg
ZHdfcGNpZV9ycCAqcHAgPSAmcGNpZS0+cGNpLT5wcDsNCj4gPiAgCXN0cnVjdCBwY2lfYnVzICpi
dXMgPSBwcC0+YnJpZGdlLT5idXM7DQo+ID4gIAlzdHJ1Y3QgcGNpX2RldiAqcm9vdF9wb3J0Ow0K
PiA+ICsJc3RydWN0IHBjaV9kZXYgKmNoaWxkLCAqdG1wOw0KPiA+ICAJaW50IHJldDsNCj4gPg0K
PiA+ICAJcm9vdF9wb3J0ID0gcGNpX2dldF9zbG90KGJ1cywgMCk7DQo+ID4gQEAgLTIzOSw3ICsy
NDAsMTQgQEAgc3RhdGljIHZvaWQgYXJtYWRhOGtfcGNpZV9yZWNvdmVyX2xpbmsoc3RydWN0DQo+
IHdvcmtfc3RydWN0ICp3cykNCj4gPiAgCQlyZXR1cm47DQo+ID4gIAl9DQo+ID4gIAlwY2lfbG9j
a19yZXNjYW5fcmVtb3ZlKCk7DQo+ID4gLQlwY2lfc3RvcF9hbmRfcmVtb3ZlX2J1c19kZXZpY2Uo
cm9vdF9wb3J0KTsNCj4gPiArDQo+ID4gKwkvKiBSZW1vdmUgYWxsIGRldmljZXMgdW5kZXIgcm9v
dCBidXMgKi8NCj4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShjaGlsZCwgdG1wLA0KPiA+
ICsJCQkJICZyb290X3BvcnQtPnN1Ym9yZGluYXRlLT5kZXZpY2VzLCBidXNfbGlzdCkNCj4gew0K
PiA+ICsJCXBjaV9zdG9wX2FuZF9yZW1vdmVfYnVzX2RldmljZShjaGlsZCk7DQo+ID4gKwkJZGV2
X2RiZygmY2hpbGQtPmRldiwgInJlbW92ZWRcbiIpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgCS8q
IFJlc2V0IGRldmljZSBpZiByZXNldCBncGlvIGlzIHNldCAqLw0KPiA+ICAJaWYgKHBjaWUtPnJl
c2V0X2dwaW8pIHsNCj4gPiAgCQkvKiBhc3NlcnQgYW5kIHRoZW4gZGVhc3NlcnQgdGhlIHJlc2V0
IHNpZ25hbCAqLyBAQCAtMjc5LDExDQo+ICsyODcsMTINCj4gPiBAQCBzdGF0aWMgdm9pZCBhcm1h
ZGE4a19wY2llX3JlY292ZXJfbGluayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndzKQ0KPiA+DQo+ID4g
IAkvKiBXYWl0IHVudGlsIHRoZSBsaW5rIGJlY29tZXMgYWN0aXZlIGFnYWluICovDQo+ID4gIAlp
ZiAoZHdfcGNpZV93YWl0X2Zvcl9saW5rKHBjaWUtPnBjaSkpDQo+ID4gLQkJZGV2X2VycihwY2ll
LT5wY2ktPmRldiwgIkxpbmsgbm90IHVwIGFmdGVyIHJlY29uZmlndXJhdGlvblxuIik7DQo+ID4g
KwkJZ290byBmYWlsOw0KPiA+ICsNCj4gPiArCWRldl9kYmcocGNpZS0+cGNpLT5kZXYsICIlczog
bGluayBoYXMgYmVlbiByZWNvdmVyZWRcbiIsIF9fZnVuY19fKTsNCj4gPg0KPiA+IC0JYnVzID0g
TlVMTDsNCj4gPiAtCXdoaWxlICgoYnVzID0gcGNpX2ZpbmRfbmV4dF9idXMoYnVzKSkgIT0gTlVM
TCkNCj4gPiAtCQlwY2lfcmVzY2FuX2J1cyhidXMpOw0KPiA+ICsJLyogUmVzY2FuIHRoZSByb290
IGJ1cyBvbmx5IGlmIGxpbmsgaXMgcmV0YWluZWQgKi8NCj4gPiArCXBjaV9yZXNjYW5fYnVzKGJ1
cyk7DQo+ID4NCj4gPiAgZmFpbDoNCj4gPiAgCXBjaV91bmxvY2tfcmVzY2FuX3JlbW92ZSgpOw0K
PiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCg==

