Return-Path: <linux-pci+bounces-42884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D59CB2D49
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 12:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68EF6300CB98
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 11:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579B6258EC3;
	Wed, 10 Dec 2025 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kzOI3P43"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525D1304BAB;
	Wed, 10 Dec 2025 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765366332; cv=fail; b=qLewEeevkHdfC2jwv7p8lzDv5XpM153SCF/wX0GXB5PqpfS+S3UFo+8Hgsu1ogZ+tg0AIUw0AKpGgI9N2A6ILYjAGY04ts0/fO5T5DsNPRwL83q4nYtOsHRMVkMCQiCQgpn47GjgMnfjoUSVIDCGhbRWhS2cuaV8cIQms3OgqO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765366332; c=relaxed/simple;
	bh=bXsoLOUyFMVPB6LiqFmitg5SNaKusWOgN/Gn/7Fl+rQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=qPd/oE9VGYeqoCYNrfIjERnggt8peyKA5CUG3QIMwD47clR/kaNEV/2BOAl4y42Kl0PhCmGrM/yB+PrUjEeOP6aWrcSr83feqWFbwIiGi0t6PSBAKZm8d9JPBiLJCTaBewATwGlvWxdNBVQLULPOFQJ03JBFCOn9kXiMmnKkHGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kzOI3P43; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCC1U82dMJFiQWB+CaO9/0yTlzdMhG4wz8XmqmX5ZwRH0Rxd7lVaRY0MhyAowijYLlR6Evn+cZShR/XZYi9gVu9vvidLeFwD7hUYz5vd2jpgawRuXyagh6aObaXekXTXcTWEXfIwCKAGUy05HDA8r5XJhjwO1OdiuigbVj/+wflLzXkVCszcvheJeQJW6ha+eenP0dKda3MB0dOs1rqU3z4naaPnGhE1tc8g0fBz+vihTsSlqm9AfsTWVK1l/rw3eyhFQkrRSOMYcMenyiuwy+J+mIhf/bACmXTKurJorxqPHcIIjby1X7kYFaFNR4JI0Too3vyD5a0LpLSRYIWbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j7o0Prfsh7NtXNbuErFm0BSxYfqPwJoxWyD9hYrc4U=;
 b=u9QIgjbJYX6k3+AH+kIPYr4AwWMNedfMxr/xgNXxaA79KDa9MihLb2tOk8Mgjja/CXmo7gzXo5cvyuF8dNCbaAkO/budR/T0TAjQ/czOE+KHiPTXpYETXPlL2qH7nvoHFqA4loNtUS/v+uJjk3uBiNYeGxR8kJNQVxie0YJl06/v2nQmsm6PEumyhDn6r1tDgqvtDu11xs0RZcznqXTajxv/pOvTtK6x0YunYDQjIUmfJlILlOqIM6hef8yamd2XV0UqBYHHFNYmH4evDQHFuj1jbJcnpNayTShV0uLxvxfER91EHIQG4Ok4fYBEOasyz/s/9zKRj1R5WuCsS9K0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9j7o0Prfsh7NtXNbuErFm0BSxYfqPwJoxWyD9hYrc4U=;
 b=kzOI3P43gu8DtcTkmWKmkh30I/mGbHTgO1nD5UM9DfNl6ksV4EOVlM1vbwPv4AI0EjpI8IFPviN0G06yb80Kn20rdLY+zj+7PNKVaE5weB5cNM0P1PtaF0o+9fJmvfvPcnIsmXwv/WcxPH+7UH3QmFoVSC1y/s6w+AlXgMR2EMvP7U+aQgRZcLnQWavtrltLWIEHKJsMl+WAfDYbXtkrHGqa1n7kkwXQgSLkgU+3hbPfCxuDt+X0iB0KwLefo+CXWXEr6ciQ8eaw8bOKOANDdfmVi7GaZSWhLshEg+jgf564clitQWfBSucVy2jfXsbf/5t3gkOLnpDWLkv5Qu/XgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 11:32:04 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 11:32:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Dec 2025 20:31:58 +0900
Message-Id: <DEUI4QS4G4KA.3H4Z0MRF394FF@nvidia.com>
Cc: <airlied@gmail.com>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <alex@shazbot.org>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
 <jhubbard@nvidia.com>, <zhiwang@kernel.org>, "Nouveau"
 <nouveau-bounces@lists.freedesktop.org>
Subject: Re: [RFC 1/7] rust: pci: expose sriov_get_totalvfs() helper
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251206124208.305963-1-zhiw@nvidia.com>
 <20251206124208.305963-2-zhiw@nvidia.com>
In-Reply-To: <20251206124208.305963-2-zhiw@nvidia.com>
X-ClientProxiedBy: OS3PR01CA0068.jpnprd01.prod.outlook.com
 (2603:1096:604:de::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 120befb5-7142-4c69-279a-08de37dfbdc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTJ1eTBTd2Y5ak1hb3Z2aHZJSm85aUw3MUxrVTU0NWIzd0JNalM2ZjFDcnhO?=
 =?utf-8?B?N1gzbldBN2I3NHJOdWxrQUZ6dVdsRjZ0YkI0TDJTaElZM2czQ09tQkRrOTFy?=
 =?utf-8?B?c2d5c1NFVGlNbmVBeWZ0M1NzTlFFUnlrb0J3Y3NlRkM3cUdSV0I1bkIrSDIy?=
 =?utf-8?B?L1RZVkhnTVVvTGdHZzhTVVRHSlVQaUI1c09vYXhGd1RXTmZ0NGpjdmhNS3hW?=
 =?utf-8?B?M3EyUHE4NGtaUmdhUk1RaGZwYS9JaHgyRVMrVVFDQTF1cExnL3JEamlMeUk2?=
 =?utf-8?B?NjJWVVpJdGtBTW9hVk5nZms5bXY3S0F6U05yOFp6YlNqcGszVU5EYUNQeUdO?=
 =?utf-8?B?Vk1McUhXU3kxc0RudGlBa0IvYzcvaGN6R3RCeXJTdTRuUmF5dVVQeHJqaG14?=
 =?utf-8?B?a05XVjNmM0RLWWVMdEZlM1ZVTFNqeGFEd1BQRVdyb3dxa0Y1ZFh6OFFteFBB?=
 =?utf-8?B?RU5iVjFVTEtvZVBza21OSThKNW42NzZZL1hXcXVZOU9nMzNyWFd0eWtPYjBh?=
 =?utf-8?B?YmFHMzZVT1dUeXBVTlUyeXkyMEw1ZVpSR0dZS2FSaGZYTkwzc1M2S2x1cEVv?=
 =?utf-8?B?eDBGWUk2UnUveXljNCt2VVFqR2pIb2xMbVRqY0U5UmIrU2pEVFJJdDc5Smti?=
 =?utf-8?B?ZHovbVNwNXZPUUcrb0N1RmY5dFRwaTVtOXF3SnNrYkh0N0xvemZGZGVtQ0Ru?=
 =?utf-8?B?MGV4a0pYQ3FLRVM3WTdOTXRZQlBFUmUya0JsdGsxc0NLN3BldmZjQW5LL3NT?=
 =?utf-8?B?RWNsdEVQTHJ1eHlPSGFxTStZdERVVnVVRzdzMFZBenNnNjdXVXQ4R09OQWNy?=
 =?utf-8?B?UnNRZUdlM1Z1QWEzc04rTzFvR0RqUU80ZnlMVTVJTDd1cHlDLzA0eHAwSnpE?=
 =?utf-8?B?dVBYeENySWtPVi9qNjJsNU1SN2UzWk93VldlOHgyR1JJZGVDVWZsR3dFdDdu?=
 =?utf-8?B?dTNmMkw2RXdTWlNnMXFQcGFRbStCUkFrbXBqUmNUdmV4cndTZTFaajkvMVIv?=
 =?utf-8?B?aHRneThodVVEblNkb3JkMEgzVzBHeHFCVVhUaFpxaDJhamU5OHJ2d21xOFp4?=
 =?utf-8?B?WFo5WmJqRTl1dUo5c0V4dWN1dE5CcnVoakhGMnRCTFhuYnVvQ1I2Wmg5WWNm?=
 =?utf-8?B?bGJDTVkwZ05KQmxmK2pCeTNNM1RhWGJOUzlYK1FTbVNtdEtZaWUvTlF1YWg0?=
 =?utf-8?B?dSt6b1dQTytUWi84TnAzdVA3cjRwUFpoYlBITmtZSFRRcGFmK05rRzE4WEhy?=
 =?utf-8?B?Yzc3dmZ6UmhwQ0w0S2pMTTlJYm5DdEI4Z0UramJVTi9vcFp2RS9WVXE3VkhU?=
 =?utf-8?B?SlM1cXhFNVBWbzNrbUFMT1hIV2wyMXh6WGFoV3c4OC9WcnRWNHFiZGhDdGtu?=
 =?utf-8?B?R0s2T0xUckFZaFFEd1ZKUTI5Ym90OVlEa3MzTzBnSnZXN05TMFkyVlp4Y1ZE?=
 =?utf-8?B?Q09hS1duNXNWV1p3UEJJaHRBOStZcHhQOXU0eGp0bE1TQWt0bXp4R3VKUmgw?=
 =?utf-8?B?WjJ6VEZFZURseGhDWmkwNmgxdWFNTXZxRjJobGlnQzlhUUNXVkNobmoyN3Rz?=
 =?utf-8?B?STRXM2tJMGtPUEZOWXB3ODhGT3VYV2xHMkpqYzFlYTN6Rlk3RzRJcHlhSGQ0?=
 =?utf-8?B?bUx0OU9mMjB3VmVGTTd6MnFXOW5nb2o4RWR5Rzg4ZCt5amk5b2xxSDhtZ2pX?=
 =?utf-8?B?Ym9uSVhFaE9YWGFxbmJoZWIwTmg0SkFiYVhVd2g3VWlPRWI5dDY0ZDUrNXJz?=
 =?utf-8?B?SjVWYWk1Snh4eDFzWFBnZjdJMkk0d0pHVlNqSjlOVVZ5bUdRalp5L2ZKeU9T?=
 =?utf-8?B?Q0d5c0JYU3lVVnhtamp0R0Q0SWFiRDdGWUFuakNPV05QNzNpVVRjOGhUYTM4?=
 =?utf-8?B?S21GVS9HaHYzUE1ORXZUcFkrZkNxdWRFckEwK2ZiZU9sVGw3V1BMOS9QaHhq?=
 =?utf-8?Q?90FwVgB896OseSwwdgUlNJi37UqptL0D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDU5bzV4R2JLOXIrb0h5aWl3bzRMODZJcVFFWmplTVpaMHY5QmxhQjcxeXZH?=
 =?utf-8?B?bEJxei9pd1NvcFJObmhESEdYSVBSeE5TWnJ5bXhlSU1ieUJxRGxXR2pDSjBm?=
 =?utf-8?B?ZU53UVI1bFZLb3hPM0k1SlhMejBmTHNBcURrY29MWGk1ZDVXbVArd2orSUwz?=
 =?utf-8?B?MUhqcjFMT1FJSk56SFhlaGZMN3dKQ1pkYUI0YlA0bStub0IveFg0OE1mVWhG?=
 =?utf-8?B?WkI1SGx0SjUrQ05pVisvOWNEN3FzWEt0VUJJd1E0Yk1aUk9LVExNNE5qNWJD?=
 =?utf-8?B?cERCamtmMlF5cnU1UmIwKzl4MGtXSFJLeTJmTnFaQXZnNUd4ZFo1bGJmS0tt?=
 =?utf-8?B?MGtPWGhsTHZ0M291UFltTzVNcTNpZ2ZCTk4wVXg3OFkzekc0VWp3ZDQ3SUhF?=
 =?utf-8?B?RDU4aDVXOVhJU3ZqcVNPdXFMamxNYUQzcGJ1OHNoOWs2dzhVTWg0WmhSN1Ix?=
 =?utf-8?B?RW5zUUo4YUpSODZ4NG9vbERPL1VwaVlBcDhFMm85THZObEV2VUkwNW5kc21z?=
 =?utf-8?B?dVRYN1FwTzNxSWUwQ3pXbWx5cEtLa1ZTUjBLMVRXQUUzYmdvYkRmckVHRVVw?=
 =?utf-8?B?cGg0dlFBZE9ZS0lIYTduU004emd1ZFZMWFpWS0RUWCtxcFdDOWRTVkZQQnpq?=
 =?utf-8?B?VnBRU3dNVVdIRlJlMGhnSEhkZHd4WmNGOC9JV2VsajZBdXhiY1VjMldYYVIw?=
 =?utf-8?B?cmR1bUZ3aEt0anlreXpBY0pxL3R0bkZ1SVVjandicy9DdUdVa0w5L2lnSFJz?=
 =?utf-8?B?eEdoU2lXRW9XbEVkMmY4dEt4cUp3M2RyYWd5NnpNMkk0ZjNkVndqQ3kxNCth?=
 =?utf-8?B?K3U0UEZpbkUzN2RGMWtmSnNtbC9jWVVkQ1FUZmNSc1JQSnZ3anBGbnltUThG?=
 =?utf-8?B?MWI1cTFRV2lEdVBTOHFIOEpPeHk1b2NtWUw1SWJqMTJTN2c2UXovb29lQzQy?=
 =?utf-8?B?dE1EYkE0UmdZZGgwZkxQUkdOa2Q0VzhWb2tSR1RQdUlJZGlkWDQ2TndmWmky?=
 =?utf-8?B?MXJBRkdlc1FpeEZQem9iOCtFTjV6R3JQVUR5UlZ6bEIrdEdnc0Z5UG0zN1dH?=
 =?utf-8?B?WjY1RVRQL2RZaVIxU21hZDFXYnJxclU3MVBWUEN4RTdkK3dXcDF2elVNb1lK?=
 =?utf-8?B?allrZlRYd3hGcXVFNUhIbEI2OWNvcDc2Z3d0WE54UzBqWHo3cFFuenhqU3FD?=
 =?utf-8?B?cmxvMy9PS2Z6VFRmcnptQ0JOclNRRTYzOWhpemptcFBTYjVoR2JpMHExWWZs?=
 =?utf-8?B?T1lCWlBON2dEbEdRUElKbDlGWGlSd1ZCRWlTWkQyKy9YSkhOWmIrSXZXdzJL?=
 =?utf-8?B?SmpiUG5QS1c1SzZKK0Q4dTNQd0VMSmVMaHJaR1MwTnIxVjVWOXZGUjZDTDlt?=
 =?utf-8?B?Vm1PdjQvWFUxSzgvdkltdnRIMmp3Z0pzUzNHd3pwaWR5ZHlVQjYyMms0UFpX?=
 =?utf-8?B?cEU2U2o0QzZDdm0vcHdtZE1XQ20xV0JUdWlMT2pLSFU4L00zV2tLUlhQd2tw?=
 =?utf-8?B?WjIxT211bHVkNGl6TFRLN1QrVjRQakMyTSs4V3dtRlBvOU9jNU9nbEtpdkhK?=
 =?utf-8?B?Z1RaUlAzajN6UmZ0bm94OE5yRzZUbHJ3ZWhJUmwwL0JmZGo1UDBMQklKdEFP?=
 =?utf-8?B?ak5CRWY5cDJjalNFcVVGNXN3R1lKMUlwSlFHb25vOGU2bTZ4QktDcm42TWFB?=
 =?utf-8?B?bmlIN3dyODV1VjdkaFZVaDlQeUlNeTVHZ0lkNDZTa29rbzdNMm51NDdWNjBL?=
 =?utf-8?B?U2dQYW05a1JPYll5RkNaMHEzc0pLb3dmQ25nZGkxU09MampuSzBkenA1VEYx?=
 =?utf-8?B?RWtXWm9sTnhTbUkrWEdNdzc2eW9DRkd2b25UTUtxcEZOem5EQVBscElBSE1r?=
 =?utf-8?B?WEJtZFNqc3Vmbnppa3hFYllyNEVMSlQyclg2QXVvbGJyNVNFT1hmbndMdEFr?=
 =?utf-8?B?dnpieno1WXVVVjVvSVNTemFCZ1pSc0FHM3AzT1NQSDJKTlJtbnh6MFZlb1Nk?=
 =?utf-8?B?cWxiMWl5S2pUWGZXRUxpTFYzZkxWVGpFN2dFYy9oUjh3YjVqVmFrdlVyZk4v?=
 =?utf-8?B?RHpiMmhBdCtkUTIwUEx5RnJTUXluQjJqeFYrOVVSWTNzOXc2cFlOcmZKTkRt?=
 =?utf-8?B?OXZlbzFpWjFScUQxSmdCUFVRYng3SU5uRzBPY3ZYVFhleDBVTDF5MG9tM2E4?=
 =?utf-8?Q?14xkkARdghGpQQgu9RID7jkTLi9NcTGs6kHu3FpEw22o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 120befb5-7142-4c69-279a-08de37dfbdc0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 11:32:04.1762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Jc3KjrNe1sVspNRFTZYKiTkulrRwXWyXNkk6WQrpDDQQ7vH5fwV+L1k8LgTvmcGzkim1WjjNc7pPsqoe8MP5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211

On Sat Dec 6, 2025 at 9:42 PM JST, Zhi Wang wrote:
> Add a wrapper for the `pci_sriov_get_totalvfs()` helper, allowing drivers
> to query the number of total SR-IOV virtual functions a PCI device
> supports.
>
> This is useful for components that need to conditionally enable features
> based on SR-IOV capability.
>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/kernel/pci.rs | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 7fcc5f6022c1..9a82e83dfd30 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -514,6 +514,18 @@ pub fn pci_class(&self) -> Class {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
>          Class::from_raw(unsafe { (*self.as_raw()).class })
>      }
> +
> +    /// Returns total number of VFs, or `Err(ENODEV)` if none available.
> +    pub fn sriov_get_totalvfs(&self) -> Result<i32> {
> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct pci_d=
ev`.
> +        let vfs =3D unsafe { bindings::pci_sriov_get_totalvfs(self.as_ra=
w()) };

This results in a build error if CONFIG_PCI_IOV is not set:

error[E0425]: cannot find function `pci_sriov_get_totalvfs` in crate `bindi=
ngs`
   --> ../rust/kernel/pci.rs:521:38
    |
521 |         let vfs =3D unsafe { bindings::pci_sriov_get_totalvfs(self.as=
_raw()) };
    |                                      ^^^^^^^^^^^^^^^^^^^^^^ not found=
 in `bindings`

error: aborting due to 1 previous error


