Return-Path: <linux-pci+bounces-11347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBA794897F
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 08:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE65E1C22BE8
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 06:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79491BBBE7;
	Tue,  6 Aug 2024 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xe7kE6Jw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Qpd0OSnk"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30AC149DF0;
	Tue,  6 Aug 2024 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722926262; cv=fail; b=Thtle64U9MI7tgg+zfaaKJ2oJScVqeyetzosmbEaNntiz/NBt+e5vnKsL1s9xnXFfMSY3jxGrhiqYq06xdhmozExKMsfQ7WfoA6nQSaNa6AaycdEMA6PCnlKna1E0r5DMYDQsZ6lbigJ+22Uvi9OmSAYEZpvv377n8a8tPYM7tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722926262; c=relaxed/simple;
	bh=aFQ9FX6WkzU8MIljlW0JHxr1FIvAIOjNkhbxrUDuLqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ttyX8b7LFnqb8WndLpm6fPHwm42w1bk4DuQcoJpR3qrZBeKibKzcG1UUV3JCKvSKrzciLeRHtA9AeTdXRSbH+CjJWJc1RN60ba5KiWN1ArTZ+Z3Q4QBKhNxgusTf3wBucsXZtqqWycGcx/53RxT3U5NQBM7wcv6qEql6Wqp+uyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Xe7kE6Jw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Qpd0OSnk; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722926260; x=1754462260;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aFQ9FX6WkzU8MIljlW0JHxr1FIvAIOjNkhbxrUDuLqE=;
  b=Xe7kE6JwgQ8eYa0JxIpAhUlD5T3uoFhPtMrOl/O4MfTr0z70RQ/VauBP
   L5TqMjaSnEvMQtyd99u6BmBI0/8bWbt9VPBtTEwndIBAU34Zj4/vGvbYZ
   9SIhk+iu4zkjebzw3z5v0wi6wwj+d87q6ugYb277qsEDNmmVLC2PjxebG
   eJdQBP3IOcbtxBFgyxh9qTjrJcEYQq30QhoMO8rUOBGgLqREpF3SlrHye
   3pHf9n/KqVWkskrrJEf3oScLVFyvCe8hw3MEBlAlaU/v6appYEAmmzoZ3
   i58s7vApFKnWzesMAuXDopdL/BmN5NoioDxdSgVaeTDLQ3Ag0CDanCsPN
   Q==;
X-CSE-ConnectionGUID: TLONA636QU6eYIG5ipK/+w==
X-CSE-MsgGUID: qM9d5qxATUeu9xDN59W7+w==
X-IronPort-AV: E=Sophos;i="6.09,267,1716220800"; 
   d="scan'208";a="23858870"
Received: from mail-bn7nam10lp2044.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.44])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2024 14:37:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIAitiRC2GMLJRhZ3ecJGkriqQ9qrlgDMZ2rVSwHuNwLmWasi++X5BdeT/1tXNCqDbhDeLTHdtOuHqCmOkVL20toL+qF750yd/MwhWoxTs0habgIlj/XzRnYVO+VKkQUjnHO7toblVV3TYNy47dfVRMYXQd9lsdPWTkKfUXHX9PXrHlhZMLDgLQYraoTafa3+QwmwZa2WJA+AR/hvq31s1hOuaa7Ap8RcbB4C0W7HgaanC/bmkGDd3QD2HUaGijnpNwzYC0jYO3K2625egshHHlegeWTwWTCq46+p8PvC4QJtnGVJQDXthC9lyeSEzJ6kyV/YN7I9ZLZXLzU+rFQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFQ9FX6WkzU8MIljlW0JHxr1FIvAIOjNkhbxrUDuLqE=;
 b=h1W9FSqxfLGF26xHwfO+6IKslttiQ1g1Wi0LCnxmPWZ2IfoigZXfBuvxJ/gowOO6q3dJN7b27Mhyz0g94nb5AmvGniGeF/AmLYWQU+lIZjjU51OVpzHFAnWqg3AIGGz5HNY8YxgoPmfAr0EoReRa93PgcFhpZ2LqOu9x/YoZCZwJ4UC3sNzhtHTyyglrggFNhjgqUp/sRYurud2xtjKRxHRvqMPD1JM1PP6p6bl+ifKpg4E2ADBY3RQbD32T+AASJyZSkLe50a/GhjszbTv9/54i/y76cimciJnznCXSowYJribta2rV6zTUDYDBGxYt6AjlErh9+duv/qudWnnAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFQ9FX6WkzU8MIljlW0JHxr1FIvAIOjNkhbxrUDuLqE=;
 b=Qpd0OSnkZ9q+i9+8TCX284VqTiAXIciYKX8/MBZ3E63Pk/YUT+u1w3opfwSuYbP7p1eo0rsWuQxImAktCp36v03XQpWn5C3UEyhNAugpxpAWDB7oMq9RLxLF/WmRhWhHxhU1tB5g7/py/NAJzavOezK7JA2JCpns77M2RTx/Z5c=
Received: from SJ0PR04MB7872.namprd04.prod.outlook.com (2603:10b6:a03:303::20)
 by PH7PR04MB8946.namprd04.prod.outlook.com (2603:10b6:510:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Tue, 6 Aug
 2024 06:37:29 +0000
Received: from SJ0PR04MB7872.namprd04.prod.outlook.com
 ([fe80::3c90:f146:c39c:33cc]) by SJ0PR04MB7872.namprd04.prod.outlook.com
 ([fe80::3c90:f146:c39c:33cc%4]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 06:37:28 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "lukas@wunner.de" <lukas@wunner.de>, "alistair23@gmail.com"
	<alistair23@gmail.com>
CC: "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "christian.koenig@amd.com"
	<christian.koenig@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kch@nvidia.com" <kch@nvidia.com>,
	"logang@deltatee.com" <logang@deltatee.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v14 3/4] PCI/DOE: Expose the DOE features via sysfs
Thread-Topic: [PATCH v14 3/4] PCI/DOE: Expose the DOE features via sysfs
Thread-Index: AQHa0nGe7PV7ewLG1EWp9KW8wvvpqLIWyzcAgAMmGoA=
Date: Tue, 6 Aug 2024 06:37:28 +0000
Message-ID: <54a52dc904e1df812683b38d8fa534f5c4466bda.camel@wdc.com>
References: <20240710023310.480713-1-alistair.francis@wdc.com>
	 <20240710023310.480713-3-alistair.francis@wdc.com>
	 <Zq8gciQnRjDZwSTK@wunner.de>
In-Reply-To: <Zq8gciQnRjDZwSTK@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7872:EE_|PH7PR04MB8946:EE_
x-ms-office365-filtering-correlation-id: 249b8d76-fbdf-42e8-d635-08dcb5e23dfe
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnhudzBrZytPNXYwMkg3bVdPWWZ0VXdibWI1dkp1NlVqamZwRWsxM0VRcmI2?=
 =?utf-8?B?NXc3SWJnazdJaElpQlJSNmtJWitFc0RJVVhUZVltQlJ2OFZVc0xNTCs0ZlQx?=
 =?utf-8?B?ck52MUNOV3BEaTFVUGlsTGI5Q2crelhMeitsYnFidUtMRmZxcllFSHBuZ2Rq?=
 =?utf-8?B?VTZzditxNUp3RXlXTVBseDhFbnBtNVR6TEo0aGd2bktjK3VkZ1dYTnpTRExq?=
 =?utf-8?B?bTV6Z3BhVW5VUC9rM2h1MUxUNXFqUFV0dlJTOU5Sc1lKOGphbEQ4WEVTR213?=
 =?utf-8?B?Qmp2TFBXSUZxcDdjRDNnbHRJeS9waTB4b04zQVB6NTZZcEM5ZXRYSlAvMTZ0?=
 =?utf-8?B?Y2tGOHBMNU50b3VKNUw5alFDcm9GVEFaaGk1NDhGbTFQcFloMHhjTHh3TUtC?=
 =?utf-8?B?d3Bob0VOdnB0TEgxcmRhR0p0ampDRU5IQUpuQ09uMDkvNkdmM1JVczByeGZo?=
 =?utf-8?B?bzlMU2hLbjlybEh4ZWZlZUplRGlWemtSU2V0NG9nOWpuclJsZTFoVmY3TW1J?=
 =?utf-8?B?UElhTnRBOTNib3BaUFNIc3hPUlRaMEozUldyUEowaTYxYkdGOWFTUmRnbVoz?=
 =?utf-8?B?dFo1alRQZjRYeXlwRjZBTzViRGlzZmpMRWNEcXI3YU9iTXArOFEzV090S3Fy?=
 =?utf-8?B?dlZhcHNPV3lVSkxrSnl3dEc1NzBrUjgvcHNaOTZiTEM3SjNHNFhXVjFnQmJD?=
 =?utf-8?B?R2lCSGdQMFQzbkRuazZ3T1hQblBOcVVXd25lODRBeW5aQ3hUU2QvY1ZCbE4v?=
 =?utf-8?B?cDlQOXQwNkQrY1M4bTRxZFUzUlh0bHpOa2doZjNnRTgxTURCcElZOS80THBI?=
 =?utf-8?B?cHFCYUZQL2paVEw4R0hjeHdMcHBBeXd1Zjcra2RTREYxN3pyMjMrL3JTVlBO?=
 =?utf-8?B?S3hoUmRTVGtnck9nM1RhcnpKdEUrM0dYYi9MRVc3YnJCMXNJR2VVRDMzZTZ4?=
 =?utf-8?B?aktESFFQNG85V0tZSjF5UE5zK29xM2t4UWI5TU1WaE1za3RMSXhiRHlaR3RJ?=
 =?utf-8?B?RVljVFQ4SG1WeXVMZnczY2ZpeVNtOEQ3dXAyK2RicCs2M0FWRmVEYTZCZUpU?=
 =?utf-8?B?bWxNUzZXM21paTJRYjMzdjcvSEtEZ1hSaXlkTFB5aFpZWXp3MkY1cjJzTXJx?=
 =?utf-8?B?L1BTZHE0V2ZBZGdQc3g5d294VGlGWVl4Q2pxaHVOc1l5SEtLYkFaRDVJNUZU?=
 =?utf-8?B?U2cydFo4RWJGYTYvRGdVbnZMTG5tcFdLVmpWdXdhZXhPR2Q5NkR6WCt4Tzhk?=
 =?utf-8?B?OEFFV3NJaGpwV0lRNlgyazZNdTFCUGZHM3EvMG95NjZMaktNakpybEtaYWRX?=
 =?utf-8?B?RXB6TWVxL2poeTJ6WTZ1WmFYWm8vVGdnWXh6NlZpWXNyT01OMmhNQ3FvVXpW?=
 =?utf-8?B?aEtYN0xvc2VQNHRYUFhiZ0VYZDBhWVZEOWpYeDMrOUlqTTRGK01KWS9aRVU3?=
 =?utf-8?B?dm1veW1tMFI4L2dGbWNXL2RVTzlSeHlZSTFIZ01OZzZGVzlNNysybC9GVUY4?=
 =?utf-8?B?N0xxM0NXVlVGYXRaNjcxcms3MmNJM3kvaEI0K2d0SThIV3lCUmtlNFFCYWww?=
 =?utf-8?B?T1ZtWGlsMVZrSVRXcUhkODl0NHdibjJQSElvSHNLbTVNUlR2RTJESUo0dm1H?=
 =?utf-8?B?U0QwWVlxOEdDS2I4QkgrMHQ4dFh0M24zRUpNbVBiRmYzVkI3b1gzNzVwcSs5?=
 =?utf-8?B?b0U2SEY5UWNaUVdCSUswNE1vNHJ4NUFKM2xzYTdEYmt0eCsrOWxlOXM5ZDdF?=
 =?utf-8?B?T01ERnFwRk5QMURkT0dlUWk2RHgzcWt0R2ZDMktWY2lEYzVlZTEzRzdIYlk1?=
 =?utf-8?Q?bSLiBiFYlNftF9YqyN9rnsKRfL8Kbi3uI9xSM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7872.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1ZaTXhOMEQ5L2RuTTBWbmh0WG1WbWU5bUk3Q2tRbkVwSHprUFhmcVRnTUF5?=
 =?utf-8?B?YzdEbHVJejNQUFcrQ3NhQmQ3UG5WdDJCZGZESGRTVWdlaDdtdVlCcTNpSnJH?=
 =?utf-8?B?RDVtRE0vZFplanhIVU9aeEVpSzgrM212L1lEdUJ4WWN4Z2VDVWVJS0ExMDYr?=
 =?utf-8?B?Q3lydTB2V1hwb0xtaW43dXk5enhNS2RUOUdCOUdvZ2FMcGtpTTFQSytBZ0Zp?=
 =?utf-8?B?N2xPaDVMcU11OXVaNytKbDVkSXg2QlhlZFdrZFM0NjdpNkkwLzlyTk83aXlU?=
 =?utf-8?B?ajVycjRBazdjWWlxY2lRMGlvell3blVRdDJZWXdwNHg5R01HbVhWb25US00r?=
 =?utf-8?B?SUMxSlpMUTNOa1lFMzMwM0tjVWVYVCtiRDF2QUVrd0hTa0QyS1o2aldXRDd6?=
 =?utf-8?B?MEZqWU5JRGJiWmxEODljUWtmUWdRR25RRjV6K0xhNitMbUFsNHVQL09HUUxR?=
 =?utf-8?B?OFV5OGlzSFg1cTZWOG1ZUXVkRGJZWnhqNlk2OHBjNWYycnJIRGQySy9tQnZu?=
 =?utf-8?B?WThSVTJvaHRJMUdNQU8rVWJJbk5xRWNSUGM5QUNsTTBLeU9RSngwbUVXNnZR?=
 =?utf-8?B?WWx1Y3c0ZUhJd3VYUzkzODhWcTlYb2g5OGhETmtWYnpQR25mWFBOd0FhTGU5?=
 =?utf-8?B?dlZreXpNanM1Q2tORzhTc3l1YnNuRGdrMEtIMDlvV1pGWEFGQ05jdFZCTzJ5?=
 =?utf-8?B?dWMrREhNSjNTZS9Kc3BQcjRWOTFZM0cyRDhUdlNGc09kSkFvbW1UczdnNzBM?=
 =?utf-8?B?SnYyMDdVOXZJWWw2WnVMQkp1NFgveS9TU1hpTnhuUmRxSlZBWC8vcDRYamNU?=
 =?utf-8?B?SnNraDAzdlF2eWptcFc2SktpU2wwMXhHOThwVkJ3SFpGN2pxU2NUUk5JYjZK?=
 =?utf-8?B?SXZuTVpZR2UzazBjQjkxTnFSVFFvNDI3M0FwejFUdDJweityV1lvY2IzbGVF?=
 =?utf-8?B?L0xMZ3lpQkNjcHBucEFYUnMxY21qUjFsOG5NN2hQVDZNNE0zS1ZORm4zbDM0?=
 =?utf-8?B?LzV6UmVtVDduTSttblZEVXNHbXdtc2xraEUwZnJOL20vMHU5bnZSeTVVREZv?=
 =?utf-8?B?S1VxVVRDRUJFeUFodGRXWjBld0x0M2REUVRpOFp0RE9Ka1NrbGY5WFhGakMz?=
 =?utf-8?B?V0lvSGVzbm41QTVQNUpzQzlVK1gzVkVqR2owL1ZkQnJZd1VoTmlmZ1RoZ250?=
 =?utf-8?B?eG1DUnVzVFQ5MmdzOG1Bd0VLTFNVbnVzWGxOc2JBbThpSVdPRk5uYVJvUmxU?=
 =?utf-8?B?RWdqWmxXWTE1TkpueXdFVlJWWTlYSWhrTTJOVlVVaFVtTytpL0dFUEVUV0hH?=
 =?utf-8?B?NFBiK0dFeExzdlRoTFFCRkRoSTh1YjNQWERQQW5NK2JwdWczd3kvQk9JZFh4?=
 =?utf-8?B?M1hVdW1xcnlVTVZvL3BpYTBQMXVhazU4ejFNcm5oUjhCdDJCV1NJRjlKNDdY?=
 =?utf-8?B?RVh6YndNYllrTGZIRk1EZ25hRS96MkpEK1lZUnZvM1ZJSFVSNTBub25IK2J3?=
 =?utf-8?B?OC81aVYrTloydWJYSlVsTlFDaW5EcCtqQ1NGSWwzUUhIK0psajJIazR6U2Zy?=
 =?utf-8?B?VE0veEx5bUtjU0hCRTRrd3YwVkUzSy9GcGlSSDNYMlN2R3BxblkzcU9QeXAx?=
 =?utf-8?B?ckpYaHBRa3BjNnZtNWpldEdieGJsY3RzdWdWZTV2ZzQ3MnhYcHRIcXJiRjBQ?=
 =?utf-8?B?ZG9wNTkzOU1QcTRGbFN2QUlnKytnWUEyQ0tyYlNmNm40VndJS2I3UDNjaXV6?=
 =?utf-8?B?NG0ydzJJY2tPRklkeVVMOUk5SVdqVjgraVpyQ2xVdWJoWHVFVCtjbE02TmNJ?=
 =?utf-8?B?ZjNvNTZjRzM2Yy81OGpCVVZkRXJrSG5HRnpQcmdBdGxGeHhrU1N0UHZkQmVF?=
 =?utf-8?B?V2tlSGlFZ0xjS2FKKzhVOEhna3ErYUJSMXpJNFhyK0d4VlJHZHlWdklPd2lp?=
 =?utf-8?B?amNHbmtUdXZNT050ZElrRTV2TDgrc0tRbnBKNmRib2tibkRCSDd0Y2wydWVZ?=
 =?utf-8?B?TmNqZ09FWWc3enZ5dzRzTVM4VEdFRDRTeko4clZNRGprNVp6YStraHJiM1dQ?=
 =?utf-8?B?U3VXajB6OHlVNHpMSVlyY0dQUytpV2tESkRDZ09pdk8vOWFwalRMSTc5Wmpj?=
 =?utf-8?B?czVYb3p1ZmhKblVFNHVHRTYrNmxQS1FjZzNpM0NhYlQ2SGNnWWFUSU45cEJo?=
 =?utf-8?B?WXZtYVVHUjNiTDE3aU81Yi9ydkV2UUdZN3QyTmc0N3RSUGJjU0xmTC9GYTF0?=
 =?utf-8?B?QUJSUmFhSFFUYTU3QmJhOVIvcXlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <283A3B75B4A5DD4984C26FB6489153BD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YCkM7BaAPz5Ml/ZUjx7dnwTJkaRl2UbOCXw8k+JjMYrbD9akev/yBMZ5DSynidccMj8twI+AMtGLEUhIh6TmxNcnYbbQodipR5YSTjhqOt/Ak7H7C5zw38SMCsyNyrSNjeHRLpxF2E5Ky37sqSR4iZde7Hx4oBAwetXUpG5+R+awtD1BS6BN63ZosFokUDYjA7xrEK6jC3grTK9S+51IqOu02JpwiVnnA6qZT2eDW49ohesOaAxRZqz2n2ga+awMGWm6U692LBq6Ik4E1tIqUyIVyAavzaQ2TXJZlDZYhqUOFAhainzMmeMCO4C2q+PFfCpTl9ue9SfZZnDMx17UUP/nwIcJf/V8IV7awrKcjHIT9bUkhpsCtsic4VQY0nCT7IMs+Nh8K+XRshdRjuNRpmiNEbbSXJ1rzmdhYhYpLk/RLm4DtBrXuO6ob8EyG+JoamdyHYdK0qxcz8IbcRqq9gYUVTgKCoV+i/rkyQTzHSDuznWTWS8NGMU8E5bPWNvB0eWFoXD97uoem8sW1i4uZDE1Xa4NTQCaxxiaFEBKGsUE4+7V0AFuiCGsQ3Rz/fzRsNmYW4mmfQFunGtSIAURuWtPYSJb9DvoGmKJD6f5czBiurTxQ72njJO+0Tb4d41C
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7872.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249b8d76-fbdf-42e8-d635-08dcb5e23dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 06:37:28.6540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CH9WYOcgaIonIE7DiYOLsNJW7+JignKd4D/6BJO0/HMUKt9clKeWU5LV0E7DUp8ztoguPe3HG0dFykLy7O2Js7bLKo7B2m9fdhktjx7xYBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8946

T24gU3VuLCAyMDI0LTA4LTA0IGF0IDA4OjMyICswMjAwLCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+
IE9uIFdlZCwgSnVsIDEwLCAyMDI0IGF0IDEyOjMzOjA5UE0gKzEwMDAsIEFsaXN0YWlyIEZyYW5j
aXMgd3JvdGU6DQo+ID4gdjE0Og0KPiA+IMKgLSBSZXZlcnQgYmFjayB0byB2MTIgd2l0aCBleHRy
YSBwY2lfcmVtb3ZlX3Jlc291cmNlX2ZpbGVzKCkgY2FsbA0KPiA+IHYxMzoNCj4gPiDCoC0gRHJv
cCBwY2lfZG9lX3N5c2ZzX2luaXQoKSBhbmQgdXNlIHBjaV9kb2Vfc3lzZnNfZ3JvdXANCj4gPiDC
oMKgwqDCoCAtIEFzIGRpc2N1c3NlZCBpbg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDIzMTAxOTE2NTgyOS5HQTEzODEwOTlAYmhlbGdhYXMvDQo+ID4gwqDCoMKgwqDCoMKgIHdl
IGNhbiBqdXN0IG1vZGlmeSBwY2lfZG9lX3N5c2ZzX2dyb3VwIGF0IHRoZSBET0UgaW5pdCBhbmQN
Cj4gPiBsZXQNCj4gPiDCoMKgwqDCoMKgwqAgZGV2aWNlX2FkZCgpIGhhbmRsZSB0aGUgc3lzZnMg
YXR0cmlidXRlcy4NCj4gPiB2MTI6DQo+ID4gwqAtIERyb3AgcGNpX2RvZV9mZWF0dXJlc19zeXNm
c19hdHRyX3Zpc2libGUoKQ0KPiA+IHYxMToNCj4gPiDCoC0gR3JhY2VmdWxseSBoYW5kbGUgbXVs
dGlwbGUgZW50cmllZCBvZiBzYW1lIGZlYXR1cmUNCj4gPiDCoC0gTWlub3IgZml4ZXMgYW5kIGNv
ZGUgY2xlYW51cHMNCj4gDQo+IEhtLCBpdCBsb29rcyBsaWtlIHRoZSByZXZpZXcgY29tbWVudHMg
SSBsZWZ0IGZvciB2MTEgd2VyZSBuZXZlcg0KPiBhZGRyZXNzZWQgOigNCj4gDQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC9abXh2bkxEQmhrV1ByWEdLQHd1bm5lci5kZS8NCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1ptMlJtV25TV0VFWDhXdFZAd3VubmVyLmRlLw0KDQpObyB0
aGV5IHdlcmVuJ3QhDQoNClNvcnJ5IGFib3V0IHRoYXQsIGl0IHNlZW1zIGxpa2UgSSBkcm9wcGVk
IHRoZSBjb21tZW50cyBzb21laG93Lg0KDQpJIGhhdmUgYWRkcmVzc2VkIHRoZW0gaW4gdjE1DQoN
CkFsaXN0YWlyDQoNCj4gDQo+IEluIHBhcnRpY3VsYXIsIHBjaV97Y3JlYXRlLHJlbW92ZX1fcmVz
b3VyY2VfZmlsZXMoKSBpcyBub3QgdGhlIHJpZ2h0DQo+IHBsYWNlDQo+IHRvIGR5bmFtaWNhbGx5
IGFkZCBhdHRyaWJ1dGVzLsKgIE1vdmUgdGhlIGNhbGxzIG9mDQo+IHBjaV9kb2Vfc3lzZnNfaW5p
dCgpDQo+IGFuZCBwY2lfZG9lX3N5c2ZzX3RlYXJkb3duKCkgdG8gcGNpX2RldmljZV9hZGQoKSBh
bmQNCj4gcGNpX2Rlc3Ryb3lfZGV2KCksDQo+IHJlc3BlY3RpdmVseS7CoCBUaGlzIGlzIGFsc28g
d2hhdCBJJ20gZG9pbmcgZm9yIGR5bmFtaWMgQ01BIGF0dHJpYnV0ZXMNCj4gYW5kIHdoYXQgTWFy
aXVzeiBpcyBkb2luZyBmb3IgTEVEcyBhZGRlZCBvbiBlbnVtZXJhdGlvbjoNCj4gDQo+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC83N2Y1NDk2ODVmOTk0OTgxYzAxMGFlYmIxZTkwNTdhYTM1
NTViMThhLjE3MTk3NzExMzMuZ2l0Lmx1a2FzQHd1bm5lci5kZS8NCj4gKHNlYXJjaCBmb3IgcGNp
X2NtYV9wdWJsaXNoKQ0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwNzEx
MDgzMDA5LjU1ODAtMy1tYXJpdXN6LnRrYWN6eWtAbGludXguaW50ZWwuY29tLw0KPiAoc2VhcmNo
IGZvciBwY2lfbnBlbV9jcmVhdGUgYW5kIHBjaV9ucGVtX3JlbW92ZSkNCj4gDQo+IFRoYW5rcywN
Cj4gDQo+IEx1a2FzDQoNCg==

