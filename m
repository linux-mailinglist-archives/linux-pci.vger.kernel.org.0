Return-Path: <linux-pci+bounces-38892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4F3BF68A1
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3A83BB525
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11A01F956;
	Tue, 21 Oct 2025 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ANx7ein1";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="G764CjK0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F72E090E;
	Tue, 21 Oct 2025 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050971; cv=fail; b=WIcjpxGSboc3WrQBm26u1vkbvnfeuJBYsJlduj8zoDnEXXWduchoyGQ597hCXvSprdpR6ZjbkTkydI1SHl68KMbXHALtsiDv7shEK5P+9THFTHBmxeuXv2y2HhDHsfE11ehJRI7R0lOn3u+i6v4tX3QpwLpjXUmyc1DQJJLVi+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050971; c=relaxed/simple;
	bh=yncf8ySVPmcRjCVEHQpR+9/h195wUV51CfoNwioWizk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CillH78Clg+rL9/EcNE2n/GrX2rTDOVrsu/f0E46Vda4g0fQOnP1FTck21Pvy0mmd5D2Kh6c5x8e3o9z2bw/yvSp0Ij2s20/uZRfBo+N9StlgMMyUFStt4T2FJYU6+TN8iM2oiR8caDDGWo6ii9jgrTaqrWlEw5qBLolpQf/u6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=ANx7ein1; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=G764CjK0; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59LCXEZf2111551;
	Tue, 21 Oct 2025 05:49:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=yncf8ySVPmcRjCVEHQpR+9/h195wUV51CfoNwioWi
	zk=; b=ANx7ein1moZ0vYvBuaDXVnwwgRDTolW69JcPXndgNyvQUOCkpbBOqcmqH
	a2DaGyJrNVHYGU4olB+AWiwKdbYdaBuEzqArkNUZ/8LUArLHnj5ZvoT2Ywlh5YX/
	qfUwF4cBdevxs+AaGh9HjdyyLTXJv3JxR3MdIR+635WfJLkwIv01YDjMkUOeb5fn
	bx/K0aoC2ziw1C7VL+NWdw+bjWOFafciTA2r1rGq023VXiWjUaHFm/NCaLHBq19C
	Hm+GdeFjQuto4aaVgT1WqWD8KfGcz15AvjXowzjpma/8UDYvhwMRZJpyMVasCwHU
	0HkbiPdTQ8TJeg1XuvuNSvmGA2Hew==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020113.outbound.protection.outlook.com [52.101.61.113])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49xa9080y0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 05:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCRKS2NeJosD/c1Td18V+3Gb+XqABx1I3fJYvpr0sOI3xC77ZQqOo6/pgHk+5BZ1FQuqLu19M3ojtbaqyFrmZGCMWF3zWqxA0exb3dhVqhp0/ZprK0f9LhMhIZA4AKLYtr+7vXCXMCjhZSiw1as6O78S/mrTd1CpatiEKlWk15M0MZXGSKY78hRuixUHbPld0mUnx7Hq7lKvdlgsGYHaVQKyCsmkeOxBcV86NZhOosM++DvatiG/lJ3arSkxSCuZ7Uw64nuY2GX1QiPw+wytXjrnrZbsL1zrAjZ6/17W7hupOukU1EigxCyXY4IHemlZ+O++K+quV9SZ7VGKO9ZarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yncf8ySVPmcRjCVEHQpR+9/h195wUV51CfoNwioWizk=;
 b=kUnPunCSUyJmR+1QYNlvNCctX8PLUe44EqlmjrxM0et/5L7L3zJ0qF622TVbPeOpZqxn7OBpLaQlErvi3vVL9U4P8w8vB+d3UbZeOwiD4SjdpJ1BO3TP52Mt7C/gxbGBp9AKLcpkf7CB099/vml+bclukpkR+o44OJgl3z2MomKLYCUyJPQDcrJNjhqPXAMN2XLjvZhHLMi+Ta8UNXIhBvf7kwEDWFDO+jE2iUYlV+lYAk+frGFWqYfoiCVH3KiiDnk6vPGLo0d6DXSDy8eIW40mSjqRXXvnZjNcONFqPG7KWM+ZOl+/OEKmYfvBP1UNJTj7AngU4UV1mXz+Fj77DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yncf8ySVPmcRjCVEHQpR+9/h195wUV51CfoNwioWizk=;
 b=G764CjK0zbqYHDHh+slfHS954rXldE29QcTOonCCs1p2HmAc/OZD8Dn4VTitP0hjm7dhyyVQZ/KAQNQvSRI3WA6345ju//LBNn8p903sz6UNXoQbV2UlEteneBjfmOXgUYccxSbbOO4FO16dr88WlJJwNju2ZzrtS0mLx8mV7sisByGFgbq/I51chFxq3HN5RTNq2IAoIfhAYFqXxvd1XFSoIw4bzUsBdpOLPuNq9fN78KdtLia7PTJVGzKgvl6amFejMd40Cn65ldjyQg/5mWrrcwWI9mk7kjZRDLMyBtv5cAVQEsP7dfJRB2vRauUNAxfSc08pd1zCyKnduI9hrA==
Received: from BYAPR02MB5016.namprd02.prod.outlook.com (2603:10b6:a03:69::27)
 by CO6PR02MB7505.namprd02.prod.outlook.com (2603:10b6:303:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 12:49:21 +0000
Received: from BYAPR02MB5016.namprd02.prod.outlook.com
 ([fe80::c759:bef6:2ea6:d47a]) by BYAPR02MB5016.namprd02.prod.outlook.com
 ([fe80::c759:bef6:2ea6:d47a%5]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 12:49:21 +0000
From: Vincent Liu <vincent.liu@nutanix.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "dakr@kernel.org" <dakr@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] driver core: Check drivers_autoprobe for all added
 devices
Thread-Topic: [PATCH v2] driver core: Check drivers_autoprobe for all added
 devices
Thread-Index: AQHcPG1tSNyf7ChLs0Krp+ls3jbtF7TBGfiAgAB0NYCACwspgA==
Date: Tue, 21 Oct 2025 12:49:21 +0000
Message-ID: <6ECEA944-12A6-43C0-A4F4-F73F73FDDACE@nutanix.com>
References: <20251001151508.1684592-1-vincent.liu@nutanix.com>
 <20251013181459.517736-1-vincent.liu@nutanix.com>
 <2025101452-legacy-gizzard-5bd0@gregkh>
 <8B3127BD-2892-46D5-8EE9-C75D812466DB@nutanix.com>
In-Reply-To: <8B3127BD-2892-46D5-8EE9-C75D812466DB@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5016:EE_|CO6PR02MB7505:EE_
x-ms-office365-filtering-correlation-id: 5988f49a-03d7-439b-d5da-08de10a041bc
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YW4vdGhhemJ0MmpZbFNFQ05wcEZMU21nT0VYcUlCVVNlOENNVU4zMHJQL1Vi?=
 =?utf-8?B?dk10T2FGYmJtbGxYRXMzaFlnZ2F6YzlzMVZmVHc5bDI2VlpjL2FJZGQ4Y2JD?=
 =?utf-8?B?aU9VL2NiYTJGNjlwNnczVGJ4cTFQSkdTVGUwZ2t0NGJzN2tjUVhlenRjZjZH?=
 =?utf-8?B?QUZOQTE2bXdVeHJNZ2VqQjBPTis1N2xrekFMTW5tTmRLck5IcE9xbW5KTm4r?=
 =?utf-8?B?VHJTejhxODNWWERHVnRxTXJ1UnJ3T0IwaWlWUFgyNlIxZVVFblUxNnJkWVV3?=
 =?utf-8?B?OWFpV2h0ckc0Z1RoQmRLWG5keExucGtyclZkYUh3RXc3Y3M5eGNnREY0UHZV?=
 =?utf-8?B?bGxlbWp1N1VZdmJxY3hCa1B1M2YzVXVndnJaU3JOOGRvK2c2b3JrVlkvVE5v?=
 =?utf-8?B?UEZxSmZaczl0bDUwSG9saDVua01GVUdHRVZOWklHaXYzKzFOaUVFb0xETDNQ?=
 =?utf-8?B?YklVSVZiNncvcm1sejl0dTI5YmUrOE5PcnBjWjE2R3F6ZFhDQ1ovZFBjZGFR?=
 =?utf-8?B?cWxzMkNobVhZR2JlSjZuSmR1K1M4cG1qUTNiMnovSVo0MlhjS0NQY29FY0Fq?=
 =?utf-8?B?SytWaU1PRnVzMmtBTmtkaVh1NWdOOTl4WmZLbzhUVnJBZ0ZVUWJWUjZ3czFo?=
 =?utf-8?B?cmxEWmk2YjFISkMrNkFlQXQ4QzNRc3plSnZmaDZVQXkwQy9JT3NwZTZGeFpC?=
 =?utf-8?B?S3VJK1hwSDI5eHNBMUwrVFV5N0hZU3Q2VEhnaUN6cFU4K3BjNUhCcjF6NUJI?=
 =?utf-8?B?bVN1TDZGdy9YeGJObTBuM0dBMDBXQ280MVk1ZU9uMFlRN25IeWtFNnFwZE9D?=
 =?utf-8?B?NGh4UDNidEZxdHBvNFFmdi9qalpxVHM0WFJGb0d6UDNXV09lakpNSzBqK1g5?=
 =?utf-8?B?Y2xKMUUyakFUSDFucm5uUStzZ3BaeHpnT1JXQ0ZTUWpqY29iaWRTTFZjbGZy?=
 =?utf-8?B?SEtSTDB4V243c3RiczhXakQ0ZDJldkkyN2ZZenZtVzR6UmtIcmI2SHE3Q0dH?=
 =?utf-8?B?aE5IOTRYbHVsdkF0WVFtNjhWSnArSnRoN3hvWGV2a3BBVHU3RDB1Y0ZmOEtK?=
 =?utf-8?B?WnZHRHdMV09Zcm9Xb3dFZktvZ3J1aGJUK0tUWDFTVGdJek9NZWVPZGd5eFFa?=
 =?utf-8?B?bHh2bFpnNVhmN3ZaaWpxOS8vTUJ3QUZlQlcwekVna1M1YnhJQUxiUXhVNGZj?=
 =?utf-8?B?M080SWM2MTkvYnJKeHJTRkgxUEVIMm9XTDRXbHo0Wm9sc2lVNGUwcDNHR3JY?=
 =?utf-8?B?a3dOcG5MZXdXWG8vbWVsNHdkUDZXK2JyMjhTZUF4VGh4byt1T0R2YVplTVJu?=
 =?utf-8?B?K011c2xadWplZlVQMVI2QUQrVVBjK1o1SkpGR2VzNUg3N2xRQUZQSVJCTWJr?=
 =?utf-8?B?aXlXZ0FZR3dTNWRjK2hBSWdBTmd5Y0lzK3NGRjVrM0VsQ1VFN1V3ZXZJM3JT?=
 =?utf-8?B?bGF0QUtHUUJZTXpqMVI3Q2RSM0RLMEgrZUozSTVDSEdiU1hLbVRVaC9NUXpq?=
 =?utf-8?B?VjFidi8xTGFaZ2M3WHRJMGlaRlNJb0ZDNS8xTWlwKzQybVBsK2poaUphdy9n?=
 =?utf-8?B?T2NROEI3WjBOUUV1TXZ5a0tXMUhDaWk5STRYVU9UWWY0bUtPbythUlc2OEhW?=
 =?utf-8?B?MFlDZjN4dEFOWnNKUlg1bmVMRXFQTVdKNGM5aEorbUc4L3dteHdkUEtpQ3ZK?=
 =?utf-8?B?WmpSeTllQVZlU1BFaWJTU0ZZd1NlMzljS3NTaGJUUFQyeFowOXpYMnJ3SE1W?=
 =?utf-8?B?NitrSVFla1JLd0xZMzFhWFg4ZkVwMHR2VVNsVnNpQ2VQbjRkNXl0UVhINEY4?=
 =?utf-8?B?SDlHK1poV3pSMUdxZTJiNjlwWEUwQkZ3NEJ5a1IySEVCeUVUVlJPNVFYVlhV?=
 =?utf-8?B?T1hDWFYySVlxa29pdWF0bVI1dFMwWG5qMENNSUlvNlFOZTR5NUVYMDg0YnhF?=
 =?utf-8?B?aXYwbXZpbEhnWWVWaWtWbTY3Ly8wM2oxcmVlUlRLMlFncU1uOW4yZHRaVllP?=
 =?utf-8?B?cDMvVU1LMmNDamovUXJxYm1kZlNGcXRJb0syeU9wbVQzTTVrZjd1OVBWaktq?=
 =?utf-8?Q?UfmSJr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5016.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUtkVjd5a0xoeEwzellZUzYySmkya0FnZ3ZtRisvT1g4djAyYzkwVUQrN1NK?=
 =?utf-8?B?alBMTnovT3pOK3NkZEExNHpKVFdEMW9IS3FSYkRrK0IyNHRKTHN2RFg4UCtj?=
 =?utf-8?B?WlIrQUJDVE00Y0lNQWNrWFRHUVMyMXRoNUpjYWR1R1pnVWRrN2hJNVc5OHdC?=
 =?utf-8?B?YU53dXFLeFNBYm4wdXQvZXhuVFN4aFNJWjFhYVRLYjMzSm80b01PdmZmTE91?=
 =?utf-8?B?VmgySTlDaFRQUkhHNTNwUVBvNEZHY01yQ0lYSGFPQ3pTczUxclArYWdHQlhI?=
 =?utf-8?B?V2dKODYyek0wSlV0VUU3K1VSYmRqcjNxMlptLys1WEtHTDdOS3lJcWVIOTIr?=
 =?utf-8?B?S2JpdlZnVHpMd1FhWmowQ3BHT1Q3Y1ZnU0NlbTY2NVFBUzl5cVhsQ08vMEl6?=
 =?utf-8?B?K2VjeUJ4d0Y4aFVVM0JMTGs4TjYyaDk2eERzYjVWbmhWc1lpNm55bUtIQVhH?=
 =?utf-8?B?R3R1emdPZ0U5MmR4dm1OalFjSnpDa2lqUmZ2MjYyUTJObHJaTlJlU0NUSnhH?=
 =?utf-8?B?cVAzZFdxeXkxYUlqclZSM2hMVkhoYzdIcEUrYUcvYVZMMXRWUDJBWW1ycmlV?=
 =?utf-8?B?dzJKZGEycUFIK2ZwV1lURk5tK3FkRi9xZmsvQWtJVk5lVVJIT1JBWHdxNDN5?=
 =?utf-8?B?KzlYOTJTaW4wNjVMSXRRYzZHc1ZEU2M5RVlUa3pnQUpYSWViblVncUhLc1BB?=
 =?utf-8?B?SkV6NTExcFlYamI2NEVKOGtEaHowS2xTQWtuS2hXWTI0MzVuYzNaREJIL2R3?=
 =?utf-8?B?SlFIcSswZ1QwUUYvQkxkVzh2Si8vclZKSFJuQXFHc1lydWNOcG0rQUJmNjZr?=
 =?utf-8?B?dDBSOWRYRGlBSGRBT09lVTg4dkFTcWhKU0s3ZHVGUHNMd0Y3eEVqSkw0U2ox?=
 =?utf-8?B?UWloWGJWRVUzanA2OXVsZ0pWbk5oOExXK3Y3TFVZZElvVDBwd3cwRWdBSGlK?=
 =?utf-8?B?bzZqeDltczIrZmp3bWYzRmZoeTVUeXIyU0FNUk1yakFEa3BiakZYSEJBbW9D?=
 =?utf-8?B?MExaSjBaenh6UkN2T3JhOGdVUkUyYVY5N2xldGVTRkhDclc4WW8zaldxdktG?=
 =?utf-8?B?MEpHTStKK3p0OVlpM3U5dkNkbVVkQVpIT2NPOUg4R3dKK3BnQm4wZnU4dms1?=
 =?utf-8?B?T0s0TzJVVXpsWVh4ajBic3A0NFc1SzRRc0FDYjhWY0dSc0dGVUdlVzNqRmpY?=
 =?utf-8?B?d3RWSWdTVVgxdGczRm1pUi9MOU5xMDJhSEo1MENvNlhuUVd5TDdlTlE2ekxM?=
 =?utf-8?B?dkJDaDZnK012UzRZRUFjdTh2WGpTWU9UZVhmRVE2TTlyUkQyMk8ydWdiWjZG?=
 =?utf-8?B?eG43ZzhwVmNiRHlSTVVMNzJGZ01mT0ZqNDFTcFJGcHFJNnk2VEVFMWYzcnl4?=
 =?utf-8?B?OXZsUVI0NHk0WHkwZVJidjZQWmlUUDVncCtEcjFqb0tIM2REai92amdUcXJK?=
 =?utf-8?B?dmNkWU5DSy9xZjN1STVtbGREQ2F0eFhsQjJzRk1YdzFMdVRyVUJLRmhOc05F?=
 =?utf-8?B?YmZoY1YrME1tNnYrS3ZkVFNvS3I5RnRTT3F2WmNyalNEN3RyTUVQbHFZV1JO?=
 =?utf-8?B?eEtnTDFTeWZ1aFRQVmI2SWp2Z29wcnl2cld2b1JnYy9Nd2h3RlV6T0VjWGhU?=
 =?utf-8?B?WjBUZWV2ODNMaTRubVovUFFnaWJ4dmxWb2xjY1NwS3A3NXJDZ2FQcllLaXJ2?=
 =?utf-8?B?QXIxTjhQMDRseVdPeUFmWm4vRXB2T1lROVZjWkxvempLZUtCL0I4UjNGelZY?=
 =?utf-8?B?T3A5c0hkVnpGZ1VCYnJDT0lnbVB5VmU2cE5tK3VGUERsS0MvdU5NNTNCcFZ4?=
 =?utf-8?B?VFEvMks5T2pzU1lxWERhQmN0ajBlTWgrK0owTitoS0tpekZISVNybndjN21r?=
 =?utf-8?B?ZzkraTZNcmR0SjcvQlI0SXM2MHdsOGNBM0Y2aGdkYUUxL01TVjFSNzNqU0ZU?=
 =?utf-8?B?cXBUOHo4YkpFYXc5TWtpazFnSTdpMTBsTUtJd2tRWWduMFVoV0FmeWdpdHIv?=
 =?utf-8?B?NFBDRHNtSkZkTHZwOFNaUDh2bVZiRkZQME04NlJ0a1BtYkZMTXUrMGNlcmtV?=
 =?utf-8?B?UWFrSVZRcTNDS3c0ZzE3cWdmNjZGVU9ldFdwS0lEeFBzcTJPb3lVcThzb2ov?=
 =?utf-8?B?RzlrU2JrRDUwa1lJUXBKY3YwZXU0cklHL0hVeStweFZXeHcvY0Rrc2wxbkFR?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB4EC11A5BE4C842973990BB289D04AC@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5988f49a-03d7-439b-d5da-08de10a041bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 12:49:21.6360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZInOHrA3ERjW6zn3tp78GOrdMzylFCewFykByN4cRl1YUmZsttBhfvq3nbI1e3QSkeh0t6A3+S5jSO4zalXJ8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7505
X-Proofpoint-GUID: yhYlTewoXTKtUo5x1ld3f7UeIiqndgov
X-Authority-Analysis: v=2.4 cv=ZLbaWH7b c=1 sm=1 tr=0 ts=68f78154 cx=c_pps
 a=CAOigU3XQIFPQhMveDrRuQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=64Cc0HZtAAAA:8 a=ag1SF4gXAAAA:8 a=8nle1F3SnOJu3uuTRTQA:9 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: yhYlTewoXTKtUo5x1ld3f7UeIiqndgov
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDEwMCBTYWx0ZWRfXwM6KUqGE4Z3Q
 IvLjiFEVqdK20i6uDEcmMmj+6Y7GmQVTj60QR7r8Rcuhwe20jP+ZdFKMw0cBOTVnWzhIWlK1SWD
 IzjRtsBOGBaTCwuFjkLOfnMc8s9L89aMj0pYhuoiSfzs8ThcNN0bq6hWuaHWSUn1dszw8Rn5s4a
 mSLGui6ehc3WgzvWJo4sY9zGQPB7tOTzV7tuFH1z2GPNaGNAr/rg4OkTrLiIe7Aoi3Bdig68XfL
 zOkQ/iSJwMasbM87Jl+s9F+rHpO/Ovlr3YKpjDkduiSb0ZUS3t6S9pyBwjwxnSAhoAekPh1apWt
 hWnZ8ipdif2P2cY+/HTkzV96HXagqCRL2+HqfqsrZ/kbM7Oy9KexNOIFx2AzfsMM2MjNYnV2QoV
 +etTIQ2ygu8zTM+zlOHt5QHyVt9lCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

PiBPbiAxNCBPY3QgMjAyNSwgYXQgMTM6MTAsIFZpbmNlbnQgTGl1IDx2aW5jZW50LmxpdUBudXRh
bml4LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAxNCBPY3QgMjAyNSwgYXQgMDY6MTQsIEdyZWcgS0gg
PGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+PiBXaGF0IGNvbW1pdCBp
ZCBkb2VzIHRoaXMgZml4Pw0KPiANCj4gSSBhbSBub3QgZW50aXJlbHkgc3VyZSBpZiB0aGVyZSBp
cyBhIHBhcnRpY3VsYXIgY29tbWl0IHRoYXQgY2F1c2VzIHRoaXMgaXNzdWUsDQo+IHRoZSBkZXZp
Y2VfYXR0YWNoIGNhbGwgd2FzIGFkZGVkIGluIHBjaS9idXMuYyA1OGQ5YTM4ZjZmYWMsIGFuZCB0
aGVuIHRoZQ0KPiBkZXZpY2VfYWRkIHdhcyByZW1vdmVkIGluIDRmNTM1MDkzY2Y4ZjYuIEF0IHRo
aXMgcG9pbnQgSSB0aGluayB0aGUNCj4gZHJpdmVyc19hdXRvcHJvYmUgc3RvcHBlZCB3b3JraW5n
IGJlY2F1c2UgZHJpdmVyX2F0dGFjaCB0aGF04oCZcyBsZWZ0IGluDQo+IHBjaV9idXNfYWRkX2Rl
dmljZSBkb2VzIG5vdCBjaGVjayBmb3IgdGhhdC4NCj4gDQo+IFRoZSBkcml2ZXJzX2F1dG9wcm9i
ZSBjaGVjayBpbiBiYXNlL2J1cy5jIGhhcyBiZWVuIHRoZXJlIGEgbG9uZyB0aW1lIA0KPiBzaW5j
ZSBiOGM1Y2VjMjNkNWMuDQo+IA0KPj4gV2hhdCBkZXZpY2VzIGNhdXNlIHRoaXMgdG8gaGFwcGVu
IHRvZGF5IHRoYXQgYXJlIHNlZWluZyB0aGlzIGlzc3VlPw0KPiANCj4gSSBhbSBvYnNlcnZpbmcg
dGhpcyBmb3IgaG90LXBsdWdnZWQgUENJZSBkZXZpY2VzIGFuZCBWRnMuDQo+IA0KPj4gU2hvdWxk
IHRoaXMgYmUgYmFja3BvcnRlZCB0byBvbGRlciBrZXJuZWxzPw0KPiANCj4gSSBzdXBwb3NlIG5v
dCBzaW5jZSB0aGlzIHdhcyBub3Qgd29ya2luZyBmb3IgYSBsb25nIHRpbWU/DQo+IA0KDQpBcmUg
eW91IGhhcHB5IHdpdGggdGhpcyByZXBseSBHcmVnPyBEbyB5b3Ugd2FudCBtZSB0byB1cGRhdGUg
dGhlIGNvbW1pdA0KbWVzc2FnZSB0byBpbmNsdWRlIHNvbWUgb2YgdGhlc2UgY29tbWl0IGlkcz8N
Cg0KVGhhbmtzLA0KVmluY2VudA==

