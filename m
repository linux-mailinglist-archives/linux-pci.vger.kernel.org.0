Return-Path: <linux-pci+bounces-5073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BA788A021
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 13:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4AD2A313E
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 12:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3921C12EBFE;
	Mon, 25 Mar 2024 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WG6Slrex"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8E74C00;
	Mon, 25 Mar 2024 04:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711342257; cv=fail; b=aX4bJuUoMplxFqSUR19TydLHy4jspDjn7HYkvXoWuojQFWGdXYVB0/DeF59s2YlYMNH0m8QKtffr59XDVuuQcrZulFbWHLp8kmbdtzZPOSvGMOCZcL7J6dU3LjCpfz5WEFyInpRFXBnLFbyRHCfXCA0XrTUQfMDAO0Zi0CNAKyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711342257; c=relaxed/simple;
	bh=dHEXHGIlfXEOsYWhnul67+pkqrT/S4FIyDfnWXMJwmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SrADjB8+ssxxRXtbuJuLTl6ME4grONieuVz4ZEDUG46/HYTxmCOpyUB4CZJIJgZi5ogJJLvcxI/FIU7ZFiSvglf+9iuInap7Gr6MbPTMvl9KbW9GCO8dpmt+MMpXHj/tHlhdJR0a+6W2TuCOVQGOvbwhz/huqLi8V4aL8OLxZus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WG6Slrex; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1711342254; x=1742878254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dHEXHGIlfXEOsYWhnul67+pkqrT/S4FIyDfnWXMJwmI=;
  b=WG6SlrexOxclWtw/Woo8DucRsIvVkoGAHkpv+J9iw5Woj+0ZY6VxN0jI
   qfd/tCFDG7YMWb+Oml9yi4V/H6fJ/U13HxinPjssEO580Q3+/CJB2d2bR
   R+/vqd5MLQ/JVzPKpHqr7RMz+yYwBR2bOuHbNXEtcdhcNRn+bF77L3BjA
   MHFOhHDMVpPJUrs/33KyRssYHC/FMfieaWWA4xUMhurKf/WPFgnsr7xKR
   sDpDhD4i4lZjm2+g2zRxw3IA4e25FoMK9DhiZAv8c54x682EkKsmMkaqV
   OlRMkkgvpnRihCW44rRP4w4RkB3ZJfK3WOk7fkchVv1HGCb3PS7IeBHjE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="115081201"
X-IronPort-AV: E=Sophos;i="6.07,152,1708354800"; 
   d="scan'208";a="115081201"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 13:49:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj0l3IIBfqvMC9rBH8IvTeyYCoUrRbPP6nSSv4xNr7zi31c6pwR9FnpzKJRM3BM6KSrkFuEQ9TdCycY5BBpiUnTAXU7lZjsxNWdKpZ/2IokU/nMLJrppXnB3uzCrzvoZ3BDGLhyVQ+7z90xmLpenoIxARWS1B6eJ4ej9MfhXuAh4gKRW0wukOhrJw7Ye7T9Pkyw4LErWHcUz4NsHxpt2ReonXiPJZmEaVDfnSwl7CWdH3UOgVSRSSpN0V/M3bytRSsQHpcxjsiGxIaaz0q01L1QZoAsdirnXuTZaLladKHbopTlqpzkNThyXKxSd+iJAH2Hgo2VPXxayYdZd5SB/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syN4cBrzSw2eddIysmpicjGJUayBgGlafO07UHZYyoY=;
 b=lBMUKd36oG4Kspbo1S1qbasWspCXq5LuyGRUZPEFwGnU+EDcFyNEy4adesl0mDigc8LMSdahlmAG8/32LWwnsEtmIEt5EbU5mHRBl35OjJuKzEKTSfn8x6EVwTIH5NHNdo05c1VtMGeV8D7PzsfrNHvWnXgRRXu73P/W16mLHTsD45nemC3NhzsVXGzU1ZZDfJZyZzMO6QXh4dG+jP78UQ4RZl3bp2E8Wk/iYZj4CeAH8SCoHmpzSRc27aV/zeDkiuFhc5EbETffYwdN1CSMbX9T6YF0CYsDhUdLwmkfWKcIvjNLyiF4qMcIeVKuDmhGN5c8Ng0I/rfObAHZAt1PEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OS3PR01MB6689.jpnprd01.prod.outlook.com (2603:1096:604:10d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 04:49:38 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 04:49:38 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mj@ucw.cz"
	<mj@ucw.cz>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: RE: [PATCH v3 0/3] Display cxl1.1 device link status
Thread-Topic: [PATCH v3 0/3] Display cxl1.1 device link status
Thread-Index: AQHadFO/DLT7o3hEPUOdByLFlXQIcrFH9FEw
Date: Mon, 25 Mar 2024 04:49:38 +0000
Message-ID:
 <OSAPR01MB71827C0F65B5FE6E24B86A7DBA362@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
In-Reply-To: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=48afc41f-0e8e-4076-a9ed-c51848c9bc32;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-03-25T04:48:07Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OS3PR01MB6689:EE_
x-ms-office365-filtering-correlation-id: c1dbecce-2830-4584-96c8-08dc4c86fa21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3RScr9FLKoEFJ2JZQ8i7uWdmeSKSGnbHmbB+4SshCEblXnS+e7hStsR1o1zOVApVjWLQ5aomxEWfV8recOB8ff/3q3I1qyQ7VKtpaB6G/p/Rt7oD8vAVNSaAQazxt4FFLEx9inD0FDHKDWiw7aQbPI9SOJYzFeasfNrdrr2YXDLglYq9aHduvQdZ+XulCfRPBy1eUgrn+KHuB1V3/k0jdPMbZTFV6tDGkIUbkD34eicHAtDldQVnOaZxdw6cFgD5nu1pJ5DnDFbdcbULrqgLntfbkg8yxJa9EtHx/qr0WSbf9iuXFfpXXbub96ldjvEkT1hNHMhzmgZ4C70s5ouKXW4SpeG0089Wm0e6o6ALvZ3eSHLkxxpefJdaLWFShizZEiDwq7Cy5WZZmx0C9/MqxjRjDvtLZwdFSBkQ+69yeKXr2+F4u8jVkxS20tv58acbdHlOwMM4biU7b5rBCFfmrHp7sacsH+sjlLBv27T+pss0tLQZ9xBHslPP+E7nXQfiLh3vCx0Qw/Selknzaolwkl5TQ2RM98joVoCxHdEbchS/jzX9tAoFLyVWyCvq3loEeSQZ1XbFxH5ucznFJVx37x9fqUnfexGmX89sv1B2+IdH4RzFttBzKdal0aFp4nfbbEEk9Fab396SpKsVtshoftj8gbqgyA4WZNp9PKkLJbSDtNeKhb/n3anyRE6NZ6wk1r0jE1D6Xrr35C69NHIp6w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?WGhSdE9WbUJVcFZIVGlXVWJRdm5oWXJibzQrK2g5TWhJM002M2YxeGlK?=
 =?iso-2022-jp?B?eGd2RzNUYXNiVXRHN2c2ZWVMRHRTNWdTRWZFd1d0c1k5MjFLOTRkNjdX?=
 =?iso-2022-jp?B?c1ltVGJnQjRlUEREZHcyNUVjdXRxN3M0dnpUUHpIdjNIaXBQdkU4bEZD?=
 =?iso-2022-jp?B?QmcyVTg1dENuRGZHWFdKcFlQRlBCVkc1dE02bjU0ZjNHT1g2OC81VUZN?=
 =?iso-2022-jp?B?THY2cDYyMnNvWU45L3owODd3bHIxc2w3Z3k5V2IzSGJiYWZIVzQzWDdF?=
 =?iso-2022-jp?B?SmVPOUljaFZUSFp4L2crazFzamsyV2kzNisyS3BvNGlJOWZld1BTaG9i?=
 =?iso-2022-jp?B?cVJyUDFLakt3Ky9aZy9UaHQzYklReldWcXlJVHlJcGN2L2M1RDdRYndJ?=
 =?iso-2022-jp?B?SXZZMjdJT3R3ZFFQZ2N0VUFUK1BOdjFLa2JaNWhZc1gzTEpJZXcvWE5y?=
 =?iso-2022-jp?B?NEFYREkycDFraGtDQjcvcUdwQnhIaEwzUVp5OWJLa1QvMWd0MGtFdS8v?=
 =?iso-2022-jp?B?aFZmbTFTZGRlM3JyK0lnK2ZUamVOTm1LaGx6MURmYnZZVng4c1FYb2dV?=
 =?iso-2022-jp?B?TVBzUWpvcXNRQjlZWDc0NEt6M2lNbnpwTWlod1dmZVM5NzhmTDBDMDcr?=
 =?iso-2022-jp?B?MVBRZWpZTFpTVXRDdS9SRmJ0TGIrcWdMcHNGNFNzSWZTajVJa3MwMkEy?=
 =?iso-2022-jp?B?eTIzS05kV3BBWkZiL2NTUUZvWUZuVjVWMXhacW0rOUllcG16RkVuTkox?=
 =?iso-2022-jp?B?ZmNqcS9nZUpiNkM1OFFXVmZrVXBlUDcrMWtvOHFuR0x0bWRNakNHNGkv?=
 =?iso-2022-jp?B?L21UQmROdTV2YUxqNURuSEJoTnhHQVJkNmVzRDcrbTVVVE5lSkd1NVhE?=
 =?iso-2022-jp?B?bTJidFByVEw0ckFOOTg2N01adEpNQkE1amZkMWk1cEhYOVhWZjA1RUYx?=
 =?iso-2022-jp?B?cVRiZGtHSGI3eExhaXNtbE9tdm9DTzZReFBieElLQ205RXpWUGVISlhD?=
 =?iso-2022-jp?B?SWRWaWUreGluTTdGditxTlFyUVQyMTZlY002clNVR3JtN1BLbWJVOU0z?=
 =?iso-2022-jp?B?YzV5OWZpYWdLZWtab0x4WUFtbzdsUVh0REc2VkdqUDJSZHVPTSs0RzZj?=
 =?iso-2022-jp?B?SWIzNjU0VzJJeFJxanV4TGhXRmJpVkJmOGR2NjdYUXBkZ25ycU9kRU8y?=
 =?iso-2022-jp?B?OTNPU1RRR2d0Rlc1Yk93TnB4SlgweXVXVU1OMW9TWjRXZVVFRHIvbFBT?=
 =?iso-2022-jp?B?WWFiakp5TFM0K01qSW1TTW05VUtkd3hXNXlNaWxybm5tR1JjZHpVRGVt?=
 =?iso-2022-jp?B?NW1LeU44QXF4bG1UbERVVkN3OHNMUFpWb1I0eStWNXU4cENRYkd6VEY4?=
 =?iso-2022-jp?B?aEtkWEFVNlpHL2dtZzExZXBZSENucUN5TUlZRkFFQ09qa0NCRFE5Y3pU?=
 =?iso-2022-jp?B?NmNmc2tLdlBXdW9HaWF4U1VPcXkyTkgrYWxLbldndFZpWEtwRDZyQVJQ?=
 =?iso-2022-jp?B?UzFRYm9vNnU5cVB6VXJsdGZCYXpxUFk0Q1Z5RWMzVHJINE9aeTZUMjky?=
 =?iso-2022-jp?B?QXEvZXlDYmZuR3VYUEREM25lQzFJNVMvU3B0dUFlaGlOc3lRNk9NNnEw?=
 =?iso-2022-jp?B?WVR1NHNPcE8zL1NDQ3VzKzRpcTdaNlBqVlQ3K29NaXNWSCtPUzFjdkFE?=
 =?iso-2022-jp?B?YzYvUWYvR3hJV3JoVzQvc29SQXR3ZlRNZCtYVE40ZE5kMXIzbi96c0hV?=
 =?iso-2022-jp?B?WEVyemh5Q0FId0xmOE5HY1N2WjRqbzJNRlprQ0Ixc3ZhS3pPK0RFdVZy?=
 =?iso-2022-jp?B?M0x1M2QxQ2t0SGRscXNzRy9hcEh1SEh1ZTUvTlpJZzRHd01SNng2TDdS?=
 =?iso-2022-jp?B?R0J1Z1ZQSkE4OTk1MGIyRjhuUlNOTGtFa2hDMk9nM0FlYnVvMzVQSkhs?=
 =?iso-2022-jp?B?NkNHTXFQeW9KbEx4aWlFSURmK3Z0ekc3Zjg4RGJvWmpnYzBMd3Rzcmxw?=
 =?iso-2022-jp?B?NjhuVVFLMFBJM0ZvVFl2bUxrK0RtZXBYcWUydVZ2Y2hHMmxVazBWbFV1?=
 =?iso-2022-jp?B?Z3JWK0RSNEFHWXN2d3hTdXltL1g4RFljZ0lmMFlKL09KQ0VteTI4RnVM?=
 =?iso-2022-jp?B?Ti9rTklnL3JIVENIRXlObkQ3T3pmcVo1bHZ2NUVaL3A3MFY0WFgzYW5S?=
 =?iso-2022-jp?B?SytSNkRJZHVFSUZJY2d5ZDNETm5ON21BMnUvVDVCbzcvZ2RQcVhxQXVy?=
 =?iso-2022-jp?B?QmFpRGRUbWdva0lISGlIN0JOK2hib0NNTUl6SUYzRnNDSWFUeXluOWRQ?=
 =?iso-2022-jp?B?ZVZ1ekt5M09wUklZNFF2OFpUbUswTGhrdkE9PQ==?=
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
	nwoSWiLANfMEG0F7OJitWlD1I4PIpnven9Z6xCMMWNu7pFOD37TsuLl06gjnEtNH21jrbk8bGSz/lb4hpG/hLkdiMTkMKXLnViILAdAT0MjW2rZaj71QIAxUh3wQ95a6c8oddW57MynbG/OFQVEpbznEKK1zXQJ1Me0mw29qVwZ8vVVdHw1J8JoSihmf7k39oqJGLfLI54F88nbz2DlTrR/hPrtU6U2/Im3lQ5Aqgi28A0M05jxepYkAs1G4rRbtda9xMvzlPhv0eLkfi4tqm5X7xr1tJfSqOctMwa2WSMYyMf5rd9Ru2zgvJVnGoxc3ahqrNqJawAFXI4uw98Sa2KZXeHLDvWMCRf9W9SHr/9M7a0ZX8fJjYCbuTYjcGqztWjXVizm7dxAsn7vH6lZaCyAm4zuP328W0EJNIsAo33Xawq9v6dtnLdaQR4E5FmvtBJEQusvVJ4vCwWolVjH5C+CY07ZGATnEHlZgN4N3aiPnKYpPlXYNw7LsjUhFhS7azALvWOVORnMHn1/ieIGhF3+QrgqtF90J+veGoh1Tds9gjLsrZl+H7tmFds9jCo7zV/EL9t+r9FiUlzOsF/5e7JGv/8JnDaiadgoOAsbMfRhApjy2m7Z7wWrGaxe34WUO
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dbecce-2830-4584-96c8-08dc4c86fa21
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 04:49:38.5573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oe+77X7V/QPP8XGSW2wo4soeHiC+w7msRxNBBZkJKGVWNVB5ZEFtE5F8wENjDeAt0ARsc3l+QiUR2Y9gGqEgFaRCUPyoAyCkPq2IrfLZVxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6689

Kindly ping

Any comment is welcome.

On Tue, March 12, 2024, Kobayashi,Daisuke wrote:
> -----Original Message-----
> From: Kobayashi,Daisuke <kobayashi.da-06@fujitsu.com>
> Sent: Tuesday, March 12, 2024 5:06 PM
> To: Kobayashi, Daisuke/=1B$B>.NS=1B(B =1B$BBg2p=1B(B <kobayashi.da-06@fuj=
itsu.com>;
> linux-cxl@vger.kernel.org
> Cc: Gotou, Yasunori/=1B$B8^Eg=1B(B =1B$B9/J8=1B(B <y-goto@fujitsu.com>;
> linux-pci@vger.kernel.org; mj@ucw.cz; dan.j.williams@intel.com; Kobayashi=
,
> Daisuke/=1B$B>.NS=1B(B =1B$BBg2p=1B(B <kobayashi.da-06@fujitsu.com>
> Subject: [PATCH v3 0/3] Display cxl1.1 device link status
>=20
> Hello.
>=20
> This patch series adds a feature that displays the link status
> of the CXL1.1 device.
>=20
> CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards,
> the link status can be output in the same way as traditional PCIe.
> However, unlike devices from CXL2.0 onwards, CXL1.1 requires a
> different method to obtain the link status from traditional PCIe.
> This is because the link status of the CXL1.1 device is not mapped
> in the configuration space (as per cxl3.0 specification 8.1).
> Instead, the configuration space containing the link status is mapped
> to the memory mapped register region (as per cxl3.0 specification 8.2,
> Table 8-18). Therefore, the current lspci has a problem where it does
> not display the link status of the CXL1.1 device.
> This patch solves these issues.
>=20
> The procedure is as follows:
> First, obtain the RCRB address within the cxl driver, then access
> the configuration space. Next, output the link status information from
> the configuration space to sysfs. Finally, read sysfs within lspci to
> display the link status information.
>=20
> Changes
> v1[1] -> v2:
> The following are the main changes made based on the feedback from Dan
> Williams.
> - Modified to perform rcrb access within the CXL driver.
> - Added new attributes to the sysfs of the PCI device.
> - Output the link status information to the sysfs of the PCI device.
> - Retrieve information from sysfs as the source when displaying informati=
on in
> lspci.
>=20
> v2[2] -> v3:
> - Fix unnecessary initialization and wrong types (Bjohn).
> - Create a helper function for getting a PCIe capability offset (Bjohn).
> - Move platform-specific implementation to the lib directory in pciutils
> (Martin).
>=20
> [1]
> https://lore.kernel.org/linux-cxl/20231220050738.178481-1-kobayashi.da-06
> @fujitsu.com/
> [2]
> https://lore.kernel.org/linux-cxl/20240227083313.87699-1-kobayashi.da-06@
> fujitsu.com/
>=20
> Kobayashi,Daisuke (3):
>   Add sysfs attribute for CXL 1.1 device link status
>   Remove conditional branch that is not suitable for cxl1.1 devices
>=20
>  drivers/cxl/acpi.c |   4 -
>  drivers/cxl/pci.c  | 193
> +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 193 insertions(+), 4 deletions(-)
>=20
>   Add function to display cxl1.1 device link status
>=20
>  lib/access.c | 29 +++++++++++++++++++++
>  lib/pci.h    |  2 ++
>  ls-caps.c    | 73
> ++++++++++++++++++++++++++++++++++++++++++++++++
> ++++
>  3 files changed, 104 insertions(+)
> --
> 2.43.0


