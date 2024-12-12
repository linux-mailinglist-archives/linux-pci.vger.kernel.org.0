Return-Path: <linux-pci+bounces-18236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9241D9EE245
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 10:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85121674C0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 09:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC2520A5D1;
	Thu, 12 Dec 2024 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="i1ha+U4k"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9613E40F
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994549; cv=fail; b=UHyp533rIxSNGibG1vfO47wfq8pfCmWudl76HJc1JfzMC56Rcuf/s3mFhP7QyxHqJ98VuT3tu0/XI9285j0yrVw2DmEvY5DvlWtExkJn7NF41ceUEGNSxDG3r6EF/jSTGtrYhpch62cfEDWt6XUgUq7Ykn9mjMn9SmtHEkGHKqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994549; c=relaxed/simple;
	bh=aMRmRP0CqDr1xO6s9pCF6L8lS2SWzS8+EFFv+B529s4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sc4RMwoXskJ6/hHaWDNZzn2oM24wGE62EgszlRhT0HLQqW7JssPJLOZ3VTdT5AiKwYdiDzLoRMrEKfJZ32YmxVdfplPbArByR/WxWN+dVHCgaOrmcc8RAz9mgpziv62QCU2jK2DiFtjoUlDfIQeBjTc2yQDgu6kpSZ+H8L+LM8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=i1ha+U4k; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1733994547; x=1765530547;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aMRmRP0CqDr1xO6s9pCF6L8lS2SWzS8+EFFv+B529s4=;
  b=i1ha+U4kP6+ULOSU9SfMv3IATfcrX8tyql2D2cosRKFHWV23Fg4Anrer
   f93TxNWy+cdRhrp+9jzM6AThLBNWNftrCj9SXxcrwnMMoRFNt8VKI3Nrc
   AvmalIYIZ3Ve6ofciLDsj1nEEvQ9Zs/SAP4qSF74x6zPEcMWLkYIeuLpy
   zo5WDNViXMTwECF505NwGoicXKovXws0zqBl67N66Yhxk2BPA+Yrkliuh
   TK8Vjy0pT3DjQt8eE8IBk8xL0pNvaRGQR09D5MtZcQD9GToHe9UDAL4Hc
   99gQL5kT+W2Z4pfmjAeDL8ms8DAp/A47PFT2ZK5pwLSCaqL8rqoTuwKUH
   A==;
X-CSE-ConnectionGUID: gXLcY8l5Tr+yKWKnJSHNzw==
X-CSE-MsgGUID: iEDl3GvRRYmVf7QoubMdMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="139591541"
X-IronPort-AV: E=Sophos;i="6.12,228,1728918000"; 
   d="scan'208";a="139591541"
Received: from mail-japaneastazlp17010007.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.7])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 18:08:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dACMKC4OJVJDJ079yYx2t+fA0fcmjQEEEHaFJlmMHCQMnOlLY6Q8yathz+4WuoHWe5zePTL9iv7G2ySnd/ZS3VcEC9JLxs09T0MF7MywbFRq6akWTZrpbONMagDw/K7KGxOfThyoMZ7+X3rHKeHXU6dKeaX9+8kjYlMQXceAWG3FsEDVlHSm5zopgBBuKWv4OvkQJKfGi3eo7AFbdTXxdTbuUYCnoTPCa5F3blBWBafhiCkyFNZTqHrJpnuP2ZQfrFgkbOO9O6txvNApCfmboedkFmOfaMD6mSuuv8Fb2pyYK9AVbsad+tZuUGirAvVUlYlpKYFVt/uNT0Cd0miT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4837n0q84RFrTFydzc/a0tw7HY0tEgbR+l9LpXPuuko=;
 b=p08+lQ+jDWZnCLq7Ymht+BvpJ46AZyMX4tvwedHtGT5wPsKRgZ/0ZBNsOoEHMfbG0oxfVT3Usot8S3s6Eyz7ns+WGYMcEwNGPvlY2A0K+pdk6l8Tj4NUfAe3ErUJ5ZIc2tkzPva0kp8YA20JG7Gzo+sIz39YVWsO49ah32rZp/4D6DxGN3mBUL5acNwoY1Oye9R3739Ciyw9PPoZFGDJwheqmX0qWzZnDWPzLujxelTNiZdo0I4MrnV4CZsV8rqnbfHvHk1aqPMKeWhF8eVgMbU8bAKQ7X0ZRtNtBYHT0guvpgRcu80ohszDhH+Scaf+ARhsXFfYhjgOFNt58Y4Hvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OSZPR01MB8058.jpnprd01.prod.outlook.com (2603:1096:604:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 09:08:54 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%5]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 09:08:54 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Jonathan Cameron' <Jonathan.Cameron@huawei.com>
CC: "kw@linux.com" <kw@linux.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] Export Power Budgeting Extended Capability into
 pci-bus-sysfs
Thread-Topic: [PATCH v5 2/2] Export Power Budgeting Extended Capability into
 pci-bus-sysfs
Thread-Index: AQHbSrk6gqHOLc5m2EOlUHrscD022rLhUvMAgAD2PnA=
Date: Thu, 12 Dec 2024 09:08:54 +0000
Message-ID:
 <OSAPR01MB7182A97AD0B536DD214BCDEABA3F2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20241210040826.11402-1-kobayashi.da-06@fujitsu.com>
	<20241210040826.11402-3-kobayashi.da-06@fujitsu.com>
 <20241211174334.00002adc@huawei.com>
In-Reply-To: <20241211174334.00002adc@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=ec437024-31cc-4cad-a05e-964940a57f0f;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-12-12T08:25:01Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OSZPR01MB8058:EE_
x-ms-office365-filtering-correlation-id: 4938003e-5a44-48d3-fbd0-08dd1a8c9a6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?N2xXQndZZkZyNy9Hd0t1TkxCeE9pRFhlcThyRTlRU3ZBckdkcHFWMXUw?=
 =?iso-2022-jp?B?NVY2WkF6dHJHeHYwcUp0d0ZZTEVxZlc5bFMxTVRtMXZVOGNla3RxbW5s?=
 =?iso-2022-jp?B?OHdXTnJtV0dEL0QxUUQrRkhEVlhQUWdYZHhINnl5SVo4UzRrcjcyVVpH?=
 =?iso-2022-jp?B?dXBGTmxFd1kyNkhkMTRVdm51M1NBWHhiazlWWlRZSkwzVkROU3JpY2Mx?=
 =?iso-2022-jp?B?Nmp4Ukp2aHVsdUVObVRRTlVyVkxieWJKbjc3T3NMQk9mb1pIempNdzhR?=
 =?iso-2022-jp?B?TGIyWXZYRHRvVjZaeXNmclJaYkJQcU5FOUcrK2hmYks5TGJLdmVubFlI?=
 =?iso-2022-jp?B?NWtab0JSb3RZbjBUWWlsNjBLK0djQVd1YXNJMkRCeHJaTUlFRVRGaTNE?=
 =?iso-2022-jp?B?bGhnQlZZNTlScHViSUc4RU0yWHRqZmp3anlaYWltNVBDZlYvS2xQSndp?=
 =?iso-2022-jp?B?YU0wZlExOVlxQkhJZEc5eENjbGZjNTlkc2dzRmJ5WEVRaUUrVEdQVmVp?=
 =?iso-2022-jp?B?cHltSWFEbUdrYUpSR05sREVxS3RyN1k1bXovdjg4cU5PVUF5aEZNZHBC?=
 =?iso-2022-jp?B?dG51Z2xWeVZYS0V0QnQrT3JORk85dUROekwvV1lQb0lvS3U4MThldlBM?=
 =?iso-2022-jp?B?TFBaUGhYbUluWFVpNTFwL3JicmE0NGwreGxRZlNqcTBiby9DUzltaWhD?=
 =?iso-2022-jp?B?RDRlbThYL2RhaVh6cU5COTJQQnhSNUpFbkxjUmo5cEdpKzM2VFl3S2hs?=
 =?iso-2022-jp?B?bzVVL3ZjZWdlRG40ODFRL0hrN0tWdllsUUVWRVl6cHUzWGNwSVdvQ2Fa?=
 =?iso-2022-jp?B?dUEyaTgwRWo0dEU2b3hFaGQrSG5kNmpHWm1tbjNJNFlGRDE2Nk8xWXNy?=
 =?iso-2022-jp?B?bDNKZmZoSTErU1NzSHpXUlIyNE5nWDk3YmdQdHJsM2t5T09QdEIyRXVr?=
 =?iso-2022-jp?B?ei9sUzloTHpyVU5YME90b0xPSi91OHhSZkJieVlPbXE4b04ranFqaTBh?=
 =?iso-2022-jp?B?M0EvVCtzZDh4ZEJtM3lGQWhEYjFWRllaeXJDdTJRMGxUK3l6aTVCS2hR?=
 =?iso-2022-jp?B?a3hPYzZSVmRjUGthQXBneldPVUhBK1N6SDlxc0RVNVVLU3YwT2xadXpk?=
 =?iso-2022-jp?B?L1IyOHpDVFo4Z3BvUFdIOEVEZUc4REdvdmVCcDFkcmNlNjRHQlJudEM0?=
 =?iso-2022-jp?B?WnA5ZitKb010MjRvb2w2T0NpU2RJOWE3VkZQb0tLalFuVEwxdDNqUTB5?=
 =?iso-2022-jp?B?YmRCTGNyc1lML2tndm42Q3l6THI3bmFoNitYUG10a1FhbEhsQ1p6U3I4?=
 =?iso-2022-jp?B?Z0FhNGw3dk1CYWxaM2hqQ09TV1FNTWpNNUlZbDZ1bTU4ejVtTmxGMXEr?=
 =?iso-2022-jp?B?eUdJZ1JDM0N1K1dmNVN4R25oeW5sa3VPbXhNcFVyc252Z042SlQxNkJP?=
 =?iso-2022-jp?B?SVhQRE9MQ2ZIVkpid1ZQaFJ1NENEdDh6U2ZHN3lyQ2RGRkhqOXFjMlQ2?=
 =?iso-2022-jp?B?azJzT0ZsdmNnZmpoRWY3VUpQRU5neExNcGlXcUhKM2hWYWx5VUxBcytQ?=
 =?iso-2022-jp?B?RXluZnI1TmhWanF3NjMxM29OdGV3THRFQzZFTTdFWHYvTm5zeVhWNVhH?=
 =?iso-2022-jp?B?Y3BneUgwcnNXMFJ3OXJrVkJiYWZkUlN4MnN4eEN6cS9yaFVRb1E3TnpO?=
 =?iso-2022-jp?B?R3JIdndRVzZaakFyaWt0R0JES1RONEpMb1NIOVJ6Y2lvZWJ5eDRISEVa?=
 =?iso-2022-jp?B?QmZMcnRNRG5QdTQ4c3dJRVFHSGJoK25TLzJjeDVVL01XR2Y2V3hTZU9F?=
 =?iso-2022-jp?B?cVlSNVpIR1VOVmVkbnhNSi9va0VkUitsbXNOakZodE5xRDJPS2lQUlRF?=
 =?iso-2022-jp?B?RDBlY2d2eE81Q2ljSTBKNXlkZWxFbHlkbXZKVWR6OXRQSHg4cFQvSGZp?=
 =?iso-2022-jp?B?YXJNWDNNNzM1YmtPbURkOGxNWVhodER3RFQ0STJGb0IvZ2diN2czbWxT?=
 =?iso-2022-jp?B?S2lsUVIwMkxod3RoTmlyZlNXU3AySHpHVnEwL09mVHVYZ3NOL2FzZDda?=
 =?iso-2022-jp?B?T240OGpwbmFzdGhLMHdISlNsb2NrWmV3MklYcG5hMG5IWHpwMmtnc2dL?=
 =?iso-2022-jp?B?Q1o=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?amJxcGErMURaYUhiVXpmekdSbEV5N2JmTUcrMnRpa01RaCt2K3lxZGVP?=
 =?iso-2022-jp?B?UG8xRklSRlltZWdTaGttUGt6NWk4UGlFeTZMdjRkTDdtODcxL0Y3R3ZE?=
 =?iso-2022-jp?B?bGtVMFgxcEZ0UEdVblYrQ1Fwc3JBV3dteld1L2NDVVc3VUwxRzNLTzlC?=
 =?iso-2022-jp?B?bkl3TjRrSWwrNy93RnpRUExMZ0dvY2NxT2tJeWRnNHJnMGNsVW4wR0xS?=
 =?iso-2022-jp?B?YW5WQlFMS0hkSFBWNWtoTERJL3RvVGxPbHBlck43UVlGeHlHM0xWN1Rs?=
 =?iso-2022-jp?B?Y2RmallVUVpsSklWaURTTWs0ZDM1MFBidXNQUy9RWXJ2d1I3KzBJOFIr?=
 =?iso-2022-jp?B?YU9tUlcxWFBuNGFOL2c4a0tpa0dON0YrbGtiek9MNmM0UUVSZWs5VjRs?=
 =?iso-2022-jp?B?L0FDMitOUkl1K2pCRTlJanhndy9OdjRoc2Zzb2hPM3ZVZ0Z0dlRxdFFP?=
 =?iso-2022-jp?B?SFJacit1R2N1eDBReERQL1RIRlpUVldZMm5xRUVoMm1VSjI2cXZLNExX?=
 =?iso-2022-jp?B?V0J3Y2JkdTZtQmtTOXBkdmQwN0FoRkl6MmxSQnJ6eGtZZVNIbFFmZ2ZY?=
 =?iso-2022-jp?B?b3BZTlRFYzlCNFhvWXdMMm4wTEV5bHl4QXV6c2dQcC9yZVEzdTBXV0Jz?=
 =?iso-2022-jp?B?dElBQWdZd2NQclhLNmdxRnhuSmFGMllxaUlKbWRlSHRiSkhnQjkyYmZE?=
 =?iso-2022-jp?B?a2ZBcHNwcVFJQUVKM2FNdVVseFU5d0t3cVB4T2MxQmgrYkJDVWpmTGpO?=
 =?iso-2022-jp?B?M1YzUzJEQVVmMzl4TTFqY0lNa1ZtUUFMTGdjVmtxL2dDS09tSXI4b21o?=
 =?iso-2022-jp?B?S200WVZ4Rk93KzdNTTMyeFlUR3RPNW9yWG14NU5zVjhEdXVKUVpPZ1V3?=
 =?iso-2022-jp?B?RnhGR0RVcGU1bmR5OUw5ckNQQ1BGR2JlWXRuRFJVV25UMU84eWRWS1dr?=
 =?iso-2022-jp?B?NUVwUXBJVnV5dHdac04ra2g0a2JzZUlIRFVma1FvRmM2Q3VmVGN3SkRT?=
 =?iso-2022-jp?B?TjZoVU5uVTdUTGt6MVRHaHlkSDk3Z0hCa1cwU0ZLTnQ4cGZib3ltYjhP?=
 =?iso-2022-jp?B?UXVNdEl6WnY4b3lDUzZ6SDcrTlk5Wkx6c2o5Um8xaDJ4eHdyVE51bHR5?=
 =?iso-2022-jp?B?UnpJT01CMllUQlZUNjFMVjNlZ3hnU1VOdHQ4c3p1UXk4R0xja1krQUF1?=
 =?iso-2022-jp?B?Y0dwMzUyVlQyUlh5emFmYnMwWjV5S0NwSDlCaWZwVTgzWjMrRGRWMUNj?=
 =?iso-2022-jp?B?NXFBSm1xMGFrNTcvOVdram90V1M1NkMvM0NvbGdhb1g3TFErTE1zWC9t?=
 =?iso-2022-jp?B?MWlOdEkvS1c1S0xHVDlIbUhsWkV4dXRtdHJIZFlWM05QVERFang3NkYy?=
 =?iso-2022-jp?B?bU1VdTFoanJDdFVYMmdCTldjdzdtTHgzbEJkU3huTHU4K3lNTUFWN3BB?=
 =?iso-2022-jp?B?SU1QNG5jY3FxNkh3MHErVkVTV2Q0WkZjaVM0SnFwbDRmSlFnS2NJbnFI?=
 =?iso-2022-jp?B?V0h5aitUcXZMMVlsQTZaL1UzYnh5bkpVdXROTmFOVlZvNGh0eUNxbkk2?=
 =?iso-2022-jp?B?OHZnU1AxcUQ0cS85S2FFTVBKUEN5eVAyT1dyaVRhL01NMXplM2dOaXQw?=
 =?iso-2022-jp?B?TEV2TkhGRzhkWVpDMEMzUGNFN0FvZ096TmhnM3dLclJLQ1JYRjNOQkRo?=
 =?iso-2022-jp?B?eDNmUjhEb05GNktNbnN2ekdJREFKYS9sRXRtQ3laRDFiY1V3OHU5eWZi?=
 =?iso-2022-jp?B?SUdBMXhIb2RKMXpzbHdPdTFuajg0UWhIMm9CdlYzZ3FlVVVxRDZEZE1j?=
 =?iso-2022-jp?B?M2ovczRYbGhrUXBNemdVajl1a0NWSG5YenNwMGVvcGNwNW5RUlJQNVdB?=
 =?iso-2022-jp?B?UjhFTGdxb05IUlJZRTdGOFhPNWgyTHNKZDdFKzF4dXhFOHpFeFc4V3ZH?=
 =?iso-2022-jp?B?M1dlZktnMk9CKytVRDNnaVdoYURSa1UrMW1hSG9Xa3hoMENic0VqbTZD?=
 =?iso-2022-jp?B?QWUxdmtDdkJLSjFpKzdGUUFlTHFMRVl3TGxtSzZvRkJjdGtXa0pseUN2?=
 =?iso-2022-jp?B?cDFjaG9WaC83OFpBUGFvSUc4ekFBUndFTUY5VXB5KzhKMTF0aWVNZi9U?=
 =?iso-2022-jp?B?MThhUVY4T3lYV1MvZ0xabFRzRzhHR0txQlVVZVFqVEM1NFMxMFNBZk5Y?=
 =?iso-2022-jp?B?cjMvNGR0TU1FRnFpYUFkWTZmUURqclV1U2ZzMWRFWkpUbEtPTE1TVTFR?=
 =?iso-2022-jp?B?MGpyMGR3Q1JDbTBrcFdtYy93Q1oybGxBbWdqdGQrSTIwdTJtSWZ0NmZH?=
 =?iso-2022-jp?B?cVBWS3BHaU4yYzI2TmtuaWYwc3RYYVp2NFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t1zkT5Czbz5p2AL0sOZ7cVEpnZA6Z3jhCZO4iPE6ADSvxkHM1UhKIS0CKvdhUgiMNbTh1ga2CWEepqxWzvEi6IfmPNMf2HpWJEjAIH+6DciN6XKMJcyHX9g866u0dOZ/l8JCnEDHK6h7O9ODO0ZNPcOs/KxGP6nTECY4uMOCeiDX6/Zw0oU3JI3K8r8roQXWDJ5Pruiwp6S+iRZCyVZLWoHU1EZOrZ6fKRoJi9PRn4VwLR3bvmuHuEf5yuDqKU83w4FG/6TICBM4o+py6cFTE0Plc5R5loTXX82vTUZbIFDBamO92xaUqGSZStxV8teU4M5hFe6KP7oBen1Eksab52kFt5GyU2p1Oe3E4I3r4f6J8DwNkkG0JdpDENxaAIK6zvKTbBE6KpqvKbaHBs2rrbAvCMHa58uyTNuE9XGlRehvUQ5mjK+7fkkEJL/hi/GiZcMVwrMI4WivUOc5oPIy7+3kCwXGJ1uVF6LhZv8jxv50ntNhSfCnkfgcAbV/YyOfNaq2+HUCxbzkUDGvTTDkao/HniCwd9EG4IJpcd3QGS+PjaQ9xZP+kSyEmxg0YxxzNgk3N50hclO4zWv80V5Xaun1cMO0dTcpHBwiXo0FsqCzSQphzNFIhW51T89kBmmB
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4938003e-5a44-48d3-fbd0-08dd1a8c9a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 09:08:54.4711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1GSjEEJKwug+q5ngiLecXWGvB9d5O6PVMavaPhLtmYEjy6/+ifQFfUuAyE1LeaPIgxQD9eQMTgMS2d4AKY3/pR1EE5mGzzC1ZCzwAPgQql4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8058

Jonathan Cameron wrote:
> On Tue, 10 Dec 2024 13:08:21 +0900
> "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:
>=20
> > Add support for PBEC (Power Budgeting Extended Capability) output to
> > the PCIe driver. PBEC is defined in the PCIe specification(PCIe r6.0,
> > sec 7.8.1) and is a standard method for obtaining device power
> > consumption information.
>=20
> I'm curious why you chose to drive the interface from sysfs as opposed to=
 just
> querying how many there are boot and providing separate files for each da=
ta
> register, potentially a set of files for each one for better readability.
>=20
> Slightly irritating is that there is no 'count' register so you'd have to=
 walk up or
> bisect just to find out how many there actually readable.
> Then use is_visible() to hide the remainder.
>=20
> Look like it is an 8 bit data select register, so maybe 256 max?
> That would give you things like
> power_budget0_power
> power_budget0_pm_state
> etc
> Or maybe drop the leading power given where we are so budget0_power etc
>=20
> Mailboxes via sysfs are always a bit messy as there isn't really any lock=
ing etc.
>=20
> Sorry I'm coming in rather late with this query given you are already at =
v5!
>=20
> Jonathan
>=20
Thank you for your valuable feedback and for taking the time to review my p=
atch.

Regarding your proposed file structure:

budget0_power
budget0_pm_state
...
budget1_power
budget1_pm_state
...
budget2_xxx
...

Is this the correct format?

In my understanding, implementing this would require 256 attributes corresp=
onding to
the DataSelectRegister, which seems overly redundant. Additionally, I was c=
oncerned
about the mechanism of changing the DataSelectRegister each time a file is =
read.

Therefore, I proposed this patch implementation, even though it might not b=
e ideal.

If you have a suitable implementation to achieve your proposed structure,=20
I would greatly appreciate it if you could share it.

Upon further reflection, the issue of needing to change the DataSelectRegis=
ter could=20
potentially be avoided by initially retrieving and storing the register val=
ues for all indices.

Thank you for pointing out the coding style issue, I'll fix it in the next =
patch.

> >
> > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-pci |  62 ++++++++
> >  drivers/pci/pci-sysfs.c                 | 179
> ++++++++++++++++++++++++
> >  2 files changed, 241 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci
> > b/Documentation/ABI/testing/sysfs-bus-pci
> > index 7f63c7e97773..ec417ae20bc1 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -572,3 +572,65 @@ Description:
> >  		enclosure-specific indications "specific0" to "specific7",
> >  		hence the corresponding led class devices are unavailable if
> >  		the DSM interface is used.
> > +
> > +What:		/sys/bus/pci/devices/.../power_budget
> > +Date:		December 2024
> > +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
> > +Description:
> > +		This file provides information about the PCIe power budget
> > +		for the device. It is a read-only file that outputs the values
> > +		of the Power Budgeting Data Register for each power state as
> a
> > +		series of 32-bit hexadecimal values. Each line represents a
> > +		single Power Budgeting Data register entry, containing the
> > +		power budget for a specific power state.
> > +
> > +		The specific interpretation of these values depends on the
> > +		device and the PCIe specification. Refer to the PCIe
> > +		specification for detailed information about the Power
> > +		Budgeting Data register, including the encoding	of power
> > +		states and the interpretation of Base Power and Data Scale.
> > +
> > +What:
> 	/sys/bus/pci/devices/.../power_budget/power_budget_data_select
> > +Date:		December 2024
> > +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
> > +Description:
> > +		This is an 8-bit read/write register that selects the DWORD of
> > +		power budgeting data that will be displayed in the
> > +		Power Budgeting Data. The value starts at zero and
> incrementing
> > +		the index value selects the next DWORD.
> > +
> > +What:
> 	/sys/bus/pci/devices/.../power_budget/power_budget_power
> > +Date:		December 2024
> > +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
> > +Description:
> > +		This file provides the power consumption calculated by
> > +		multiplying the base power by the data scale.
> > +
> > +
> > +What:
> 	/sys/bus/pci/devices/.../power_budget/power_budget_pm_state
> > +Date:		December 2024
> > +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
> > +Description:
> > +		This file specifies the power management state of the
> operating
> > +		condition.
> > +
> > +What:
> 	/sys/bus/pci/devices/.../power_budget/power_budget_pm_substat
> e
> > +Date:		December 2024
> > +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
> > +Description:
> > +		This file specifies the power management sub state of the
> > +		operating condition.
> > +
> > +What:
> 	/sys/bus/pci/devices/.../power_budget/power_budget_type
> > +Date:		December 2024
> > +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
> > +Description:
> > +		This file specifies the type of the operating condition.
> > +
> > +
> > +What:
> 	/sys/bus/pci/devices/.../power_budget/power_budget_rail
> > +Date:		December 2024
> > +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
> > +Description:
> > +		This file Specifies the thermal load or power rail of the
> > +		operating condition.
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c index
> > 5d0f4db1cab7..89909633ad02 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -238,6 +238,155 @@ static ssize_t current_link_width_show(struct
> > device *dev,  }  static DEVICE_ATTR_RO(current_link_width);
>=20
> > +
> > +static ssize_t power_budget_rail_show(struct device *dev,
> > +				       struct device_attribute *attr, char
> *buf) {
> > +	struct pci_dev *pci_dev =3D to_pci_dev(dev);
> > +	int pos, err;
> > +	u32 data;
> > +
> > +	pos =3D pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);
>=20
> IIRC, this is not a cheap operation. I'd suggest storing it like we do fo=
r aer_cap
> etc.
>=20
> > +	if (!pos)
> > +		return -EINVAL;
> > +
> > +	err =3D pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA, &data);
> > +	if (err)
> > +		return -EINVAL;
> > +
> > +	return sysfs_emit(buf, "%s\n",
> > +
> 	pci_power_budget_rail_string(PCI_PWR_DATA_RAIL(data)));
>=20
> Unusual indenting. Align it below b
>=20
> > +}
> > +static DEVICE_ATTR_RO(power_budget_rail);
> > +
> >  static ssize_t secondary_bus_number_show(struct device *dev,
> >  					 struct device_attribute *attr,
> >  					 char *buf)
> > @@ -636,6 +785,16 @@ static struct attribute *pcie_dev_attrs[] =3D {
> >  	NULL,
> >  };
> >
> > +static struct attribute *pcie_pbec_attrs[] =3D {
> > +	&dev_attr_power_budget_data_select.attr,
> > +	&dev_attr_power_budget_power.attr,
> > +	&dev_attr_power_budget_pm_state.attr,
> > +	&dev_attr_power_budget_pm_substate.attr,
> > +	&dev_attr_power_budget_rail.attr,
> > +	&dev_attr_power_budget_type.attr,
> > +	NULL,
> No need for comma on terminating entries as we will never add anything af=
ter
> them.
>=20
> > +};

