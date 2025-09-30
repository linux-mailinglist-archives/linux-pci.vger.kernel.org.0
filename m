Return-Path: <linux-pci+bounces-37237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457E6BAACFC
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 02:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF1C1C18CD
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 00:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994FA7261E;
	Tue, 30 Sep 2025 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mciW/yKD"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010001.outbound.protection.outlook.com [52.103.67.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AC8168BD;
	Tue, 30 Sep 2025 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759193002; cv=fail; b=WBHjMwcxOidY0ncoaC30AVWz0Ss4u+wow/zfrZ2lQ7nKI0H5JcbKZ+Z4j3ZXVAdkjce9GFA5LRKFhJn3fDRIO7UvrjF4CGNC7bZUew+wybM5nzV9o4FFleRUAXReH66AGe6TloBA2+xJmd4hBS//4U2x0AsBRZT7WNrac74aFyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759193002; c=relaxed/simple;
	bh=KWcjAwzJnEOm+LrabzMkReSrrx1oonWhX61Hg34hE3k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=djjuEFmbj9ZnBtQKamzE0I/cWg8B2bckxa238a1ArYHS09t4lh9q67F+b9Y/71vGtyHReJskuyC4XiE8tClDVl9YvIukEzA4DavwcluiGNn35ValPGQyjzeO64xffyM73k3+V5ckSmsAylnQNZdBUu8knJUsemqZGLRJ8A/mRx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mciW/yKD; arc=fail smtp.client-ip=52.103.67.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLIDC6dDVy8FAGzeLLZEL+FpRRS8cLNDYWqXxIjrR7Wa9VIiJdHGdmY1S6FoChTMO6sX7iwKClOb4Y661hB1VIBvMlcGgoyFiKqfWkbrUUcI6zfvY99aKYSASU8pccJA7RRUuBX1WkTeQMr8F45AjPZqRn6z01hE7DJ/wbNhkHRDlBGN+S39EBWVhXiU1Es7klIqIsAxwIWLNEK/25q4zckNJV9FIiEh+sxes9Tv1+EljGRDxD1vFzPPnsOhWMvnDlqMpgbJXbi5fAaUz0GV7vPTKXDmtgvrn+/negStCBG/QuoyMTKpVa17wGE8ymAtGmupY/evEm5TbE9fTjhnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wSDB9zlWNjiBfgr4k47x84jmi/L0ndv5v6T2wzoBDo=;
 b=s4fpF6Uhu6O4HRSdjZcif29BwOgljs2Kf0jpRUrp1qgRiUekF8DyfV3LhuA8+s1G+1J9nKJb8oA278MxrduYhxqg3AVfRkiSraJDrZKwjSZvlyIZgfzIcGClt6ULBfQXZ9EYJFMw9MfXaiOjU72qgPsY2ev0Is27GA0++35Jd/E4zCLIdnqcWOt6r9ZKWDzbMvHuojq9cPVqO86DQIAYGo/FrEr8vGe0UdbcJ7ldFZhExbHTBUtGqBw30Kae0vZ4gWnGxiQeLFuXwZXGy+Upjr/KQ5qh3p3YqNR2sg9At3vbmjEOMrx8Qqi7kkCQzJi6kBqAN2QufSp5jGGqpQbWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wSDB9zlWNjiBfgr4k47x84jmi/L0ndv5v6T2wzoBDo=;
 b=mciW/yKDp0mQCb2fBAuFfLTvPpxiEl/2n2mQHKHwR83nDtzJ3oVVCFho2N2ntCWvW4ZT0U3sr55s471M+DvIgCQ8CQPCcf7rD7MW0aONg7HA2Osjx/adp3UIQ7WNzM8YUngnkuOB9ZxePkZLjF323+B8/s39aQhM/uuxpq4FvTiG2qR0W8Ykz9Vm4jdfr1VTZHP/PIKDnG332at0ikGxK42cWjASx7MBWKc7M3XfMfSeB4SzVspRuhYLDwI38t8QT1XgI67gLp567jdlloaQJxSY0x10ltIaUSGJEdlv2YTorCQ5OwCI/j1RTidfdGk70OlNRTHDlCJp6FslCxrTSw==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by PN2PR01MB9601.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:fa::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 00:43:15 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%5]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 00:43:15 +0000
Message-ID:
 <MAUPR01MB1107269A4F21DE5CC8C575077FE1AA@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 30 Sep 2025 08:43:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: sg2042: Fix a reference count issue in
 sg2042_pcie_remove()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <242eca0ff6601de7966a53706e9950fbcb10aac8.1759169586.git.christophe.jaillet@wanadoo.fr>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <242eca0ff6601de7966a53706e9950fbcb10aac8.1759169586.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0113.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::17) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <f1887014-17b5-405c-bba2-1a441d50e1f8@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|PN2PR01MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e51795d-75c5-4cb6-4983-08ddffba5737
X-MS-Exchange-SLBlob-MailProps:
	9IecXKUgicBJ8NNsyPoVvrHIv5xlNgd3t/ebQooYZHhS6lYj5x7nUtVDjlQUf9yj1tbZ9yOHeBKKNn2CncyJ6ZySwTdRLZl1EH3oqRm/cdkzHc8n7Rxtm8YF7Igi8o1oUtcGC3I60wNYDfyWoVBmtG3fheJ+duhcd/9uCSOzO3hjO+zPerD1dXVCH3YrZn4Q7EGYeRmaMUYXF+vcVWkJ+TwEPeoZUKCtWtukTxBXWF9DwHiJGjW3cb25u6qhFfJ15apdo/jdAUsHqTDMEjuiygqQdRGi0n2ZITsUOug/9OknU5Jpci2BUUoxTgioIlJkb1mmBfd50g7546GYfNBehRA8ncL53byjoAXCfS0ohhQL8sEFhVkrS8WYLJHhWz88DqZCcXT91n5lC9nXZkZlnOOcT0l4qPSYQjRQUjFJ5KrxdC0ula+l+zG4pmw8IIR7noqJJRRaQFiVmo8xFagImq+QBuz0IVKP7oyEg10o48zW9GDXkgiK028mf4kdGIrnGm4vpnzPhvAsED27avwsbaWHcxGMRPEr+2lbloivW0T7zgamxrvIaq9S0nyfrQLvepZVxNH9gQAADm65IIIj/rIXgIWC95/vfgRPVnd+G3k07Nk0GpV51/l//5Siw/TcuuSfc1BN99vPL97QSfXpcUw21N6gIuC/jJqopzscqBx3fBifqCwQoVhIrLZJ7ly9JQwkB+HzC53b/0n6G/D9GDj+mPlhLyoWhlYGuhn0V5b1z9UkMM/Wwg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|23021999003|15080799012|19110799012|5072599009|461199028|6090799003|52005399003|440099028|40105399003|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDV5QzRoZDFUcXJ6eTdVN0NpSkZ4b1hlK3hHY2hMZ0hzOUZIbnIyVlRFSktE?=
 =?utf-8?B?VmdCY2g3RVd6a0JTc2RxYis2OWZQTndsTWNtOFBjVG5raFcvWGRtRXBPSFZ4?=
 =?utf-8?B?OXgwTzJxa1JVZk8yQzhsN2JSaGxub2piUFRYZjlHcVJVSVJkRzAxb0hNTDJD?=
 =?utf-8?B?RlljVlVDQTlsOTBaRVNIR1Z3MmlwQVpuMzVwTVhWWGJhdlAzRHhVeHZUSUpu?=
 =?utf-8?B?UGV0MU5yNlE2d0V2UHhmL0tkMVhnUWFLSmRNT1ZxY241YkdQc2JLNjgvdm1k?=
 =?utf-8?B?RnlodmVFQ2JzbHZSQlg0V3lXUlBBaFhLaUxEZG9ocFVDVTBtMG5waXhZSjBV?=
 =?utf-8?B?bG9qU2d5eVYwQlFUdFk0eU1EWU9VcXBuUVc0ZUtNdFlRZCtDNWhubzVrVU5z?=
 =?utf-8?B?SmxUamxKZVdFdUJlZVBJT3JWNDV4elBsem1Ta1FpeFZPWXQxVkpMODFJVlRL?=
 =?utf-8?B?NGJNcm52WENLbVVoVHlCQUl1MUtZamxDVHVtOHlNb04rMFFaRVRsT2d2N1Bv?=
 =?utf-8?B?TEYxZmp6VG1sWm9TL0RPNjIvTVE3K2FIRWdhOXRIcWlSK1hJa1B3M2RjeWFt?=
 =?utf-8?B?RlI0OHBzWGRSVTNENlYzRDduYktLZ0FHc25SR0lncG13ckN6VjRoNFlZOGp1?=
 =?utf-8?B?VWlnUFQva3VoQ0lnamhGN29ya2xMRkNBeVhNL3V4Z2htUmw2ZjF1T2RhK0ZX?=
 =?utf-8?B?WEJ5QmxKOGQxTzd4Mm1pak11TWY1di9maGFESzNXK0lNZ1NmOGllOExXOTlW?=
 =?utf-8?B?dXpmTDFMdDd6QldRdC9abFZKcjdOVkx5dnJ4cFAxVHlzRUVrMUgxK2VEczFk?=
 =?utf-8?B?c1Uwb0hobkYxMEJpZ1dpTFQzaXIyZ3NlSXJpcjF1VUhnaFBxRjE0L2doS012?=
 =?utf-8?B?TGJPRXl1YWlUVS9aQkZ1QnZwOUpIdlFiMHBPZVFoV1VnbFJMcitOODNYbDdm?=
 =?utf-8?B?YktibzAzSGU3Y3NycE41SDYwdGV5dnVkOVNFdGgvS3NmekpQN0pYOXJmMGN4?=
 =?utf-8?B?ZURIL3F1eHNqYlhSWklwUmpMeTl6bGE3SThsVXIxZ0hmcC9CMXVRY21GWDdC?=
 =?utf-8?B?bHg3RGVMRGhzSm5BTGpXb0toa1NQZzNjZTBhT2xaT2NvQjJVZ3ZqR2phdUJo?=
 =?utf-8?B?YzZxYVRaREc2dFVNYWQ5UjFxTWR4UnB2SHpOaVZ6R09SdGtBdGdhaVMzZXZC?=
 =?utf-8?B?dVY0L3Q2UnZxcThFNDJWZW8zNHFFQUpUdTRBRXAxKzJxUmh2ZTlxL1hLSm9V?=
 =?utf-8?B?d2dISzM2b3o1UXNLZnUxdSt2Z250M1RBMzl0Q1hQcTlrcVp1MTZ6WlpKc1V4?=
 =?utf-8?B?eXNUUndyZVl1dHY3UU03cno1K09LUlMyNXFGdkRxL3dGRE1QV2RlRk5TQzVm?=
 =?utf-8?B?SFlpWWJENGIrQ2grZ2pBTVRpd2l2VXBGK2s5OWdvSC8zQnZ0QmF3RE5ycEhY?=
 =?utf-8?B?Z2lwOUZCSjA1L0pYdW1NWXBUVkd1N1RWV05IcXZpaHBUWnZNYW5HVHVJUXJH?=
 =?utf-8?B?T2NTQW1WbHhUV0VETDVwVDhBMjJRZXFGblI5K1YzYVkzNjM1azdpOWJVTHFJ?=
 =?utf-8?B?SFNzRm91YlN3TnVmNERqWDZaMGhQRm5ud2pxaVd4NlVwSUFWWld6Nnhnc1N6?=
 =?utf-8?B?OHJPUjBFaG5qMzRiOXBSeXVQdHphZGc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVp3aFdSaUIrZGtTOHE5VkJwYWhiU1ptUmZPekxweTlIRmhSc09xclE4Q0VB?=
 =?utf-8?B?MTBtdW5mb1loQ1NBQUJPSVdlU0Iyc3NQS3FJTjFha0dNdVBZempFTkp5YXA4?=
 =?utf-8?B?S3Y2VFIweE84WWRvZDNGY3JXWE9EcEVJWXowRi8yd1VwaWUrU0VaLytnWmFs?=
 =?utf-8?B?Rjh3WTFyNjU0c2VNM0NhWUxpdVJlZWNRZWlTcWpEa0h5T1FMdGplY3c3Wi9z?=
 =?utf-8?B?Y0lTYWIrUnQxQTFkTThTZkMwNFlBK096Y0loeGUvUGk3MGpxV3lJU3VYRmUz?=
 =?utf-8?B?cXpwQU9qU2ZlNVRWbGZlZEJ4cXlJRUx3T2JOMnowU1VwVndUaE0vSGdsbWxF?=
 =?utf-8?B?UFJaYU1WWTZyVVJkSk5yQ28rOSszUXJvOWx5aTNUSGY1Wk9BYXZsczJZK0Fa?=
 =?utf-8?B?MlZlbXlpNElIMVFEenJLR1l6MGZ3U1JtdDlGS2oxSWZQUTNwVjlRMzBSRWNm?=
 =?utf-8?B?cFVSRkZaaUx1SExwQjVRd2JsSGpNL21EdmwyQzcrdXo3M2VVOVdadWJPODht?=
 =?utf-8?B?czZiN0hmTVNiWSt1eUkrNGRXek10cEZXVEYrZHdva1ZmKzd1WHdKNDZ0UXNi?=
 =?utf-8?B?WXFMdnBjM2VRc0s0MmxLOFRIY25XeGd1MjcxK3pvY1o4T3F6c200WEQzVktt?=
 =?utf-8?B?OHl4SWJCTkFrdkpoTU1SRTVaSnRva0t4RUlnMS9RVXlLVjlZMk1XUHRpOHAr?=
 =?utf-8?B?QlZwMStITEwwRXpUNVhnU3R3QThNN0pjK2pTSmZpQkVqMWpaMDVoSnRYdUVr?=
 =?utf-8?B?M3c5T1VuSlFtYWVxV0FoYVVDM3NzZzZpdW1iZEpMcFdyaStiaTZteFZJSlhF?=
 =?utf-8?B?NWh5UVovVU1XaVZjVFc2OFl0S1Avcy8wN29nTEJya2U1QkJDbTExenJFLzMy?=
 =?utf-8?B?V3J1ODNNYldycTlhMTI4a0pjVnRCNktwTUdpVDFrRnFHNkhBTzd2bGVsVlpt?=
 =?utf-8?B?TGk2Mndid25Xa2VWRGkrcDRVRHBFTGhLeG1nM3o2aUFjcFE3ZExXSGdsWlhL?=
 =?utf-8?B?Rm04Y2tjVXRFWVdBc2laWUdjeFFHYkZzYlJoODdtWm5MU3NmOENBOUxsWWNG?=
 =?utf-8?B?anI3UWpEMVhkbUZHaHFMQUpYNTlZMHp4WG1hOUtvZTRvSFg3SUNvdnc3VmtO?=
 =?utf-8?B?MVNuUUZNMWdUMkdXb2tTMG41dFRJNzFEZFkvRlN1ZHU2azJWUllicmlEMEJN?=
 =?utf-8?B?NDVlclhzdHFENEpRcWpOOVE5enl2THJYWFlqR2YvR1JtSDZUWTJwRHlNb1d3?=
 =?utf-8?B?dTZYM1daWUxqRHRKT2FXc3Y2RmhTNjc5c3ZEYk5yUERiYk1ISnlQRkp5clBo?=
 =?utf-8?B?TUtDdUs4NUFobnBhVVBvWGtMY2tZcGYxdGsvbjNQbjZlOW5qeDdjcU1yL3po?=
 =?utf-8?B?disxa3dJYjU0aFNKdzJibXU0ZmczSnN1LzhvejRlK1JXNk0weDhIVEZEOUps?=
 =?utf-8?B?VVhiZzVFbGdGRHBpZnEwaFZiV3dTczNIZEVzaWpBZ0hWSEhhdkpDU1JpdkJE?=
 =?utf-8?B?L3ZZTXdCcGY0aFpOaGhyRCtEUGx6R1ZUbmRiRFhGTmVkaTNxMnB1dlVUcE5V?=
 =?utf-8?B?ZnV2MERLdGs1QUMwTkE3RTB1SXA0TUZiVUEwWjlmN0tBMTBjNFE5dlhQZVNv?=
 =?utf-8?B?M3VmTWlmRE9zTlp4MHhGUGZ1SXcvQ3ZPUXBFbU5zMnhaZlEySlB1NmU5M0FH?=
 =?utf-8?B?VVI3R1lLM1h0RHlSd3ZBN3ArRDQwNCtaMUdRU3EreVh2Z09YM2ExZFkxdWdn?=
 =?utf-8?Q?reNMLwwoclphKKE7s2f6HbimjKzgg2lMDLL92TZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e51795d-75c5-4cb6-4983-08ddffba5737
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:43:15.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9601


On 9/30/2025 2:13 AM, Christophe JAILLET wrote:
> devm_pm_runtime_enable() is used in the probe, so pm_runtime_disable()
> should not be called explicitly in the remove function.
>
> Fixes: 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

LGTM.

Acked-by: Chen Wang <unicorn_wang@outlook.com>

Tested-by: Chen Wang <unicorn_wang@outlook.com> # on Pioneerbox.

Thanks,

Chen

> ---
> Compile tested only
> ---
>   drivers/pci/controller/cadence/pcie-sg2042.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
> index a077b28d4894..0c50c74d03ee 100644
> --- a/drivers/pci/controller/cadence/pcie-sg2042.c
> +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
> @@ -74,15 +74,12 @@ static int sg2042_pcie_probe(struct platform_device *pdev)
>   static void sg2042_pcie_remove(struct platform_device *pdev)
>   {
>   	struct cdns_pcie *pcie = platform_get_drvdata(pdev);
> -	struct device *dev = &pdev->dev;
>   	struct cdns_pcie_rc *rc;
>   
>   	rc = container_of(pcie, struct cdns_pcie_rc, pcie);
>   	cdns_pcie_host_disable(rc);
>   
>   	cdns_pcie_disable_phy(pcie);
> -
> -	pm_runtime_disable(dev);
>   }
>   
>   static int sg2042_pcie_suspend_noirq(struct device *dev)

