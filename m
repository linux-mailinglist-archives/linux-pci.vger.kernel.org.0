Return-Path: <linux-pci+bounces-39985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C7AC275EC
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 03:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31413B85E5
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 02:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D161D17A309;
	Sat,  1 Nov 2025 02:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="LTueUBQI"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010000.outbound.protection.outlook.com [52.103.20.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E22222A0
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 02:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761963845; cv=fail; b=X/VsXszno7NxBbq69wEfTpsQx/cJ+AtOTqeuzLQse1JLgPQxkbrEevQWfz2Fx1sPa6if8uxe+RCCrjw4au5df76dE1WAwbOTqTYjMywIZXJoibQMh7oFtcqbw6hfDHZ9v0od6bUtWT86AlZKzaQsyBPaF1Squ7GcuRBR82jwQoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761963845; c=relaxed/simple;
	bh=xYZ9zsjw8+X9L45G9ZDvG5DbeLuJnecPQvi5QI0gIXI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sZgETv7PsLl/RJ+zH0YtPloofJzMFMobYy4NbPNU80bKNQ9oyWoVYUFigSbrOWbCF3nB9zLkaTBYabFZBXweX3DeRaGKFmd7JIAV+cNTOOnzPjQOpu3AG29lozcBQTJ1DbyYgal2oEP0DMtCJsa+HZX9Do9u/d+hN6T7pJwaQCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=LTueUBQI; arc=fail smtp.client-ip=52.103.20.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErOkVZdrkiAWjvVNa46uC0lULcYX1BLYFqY+3RZJq2PiodtVY9mPo/IFRwIPMk3aNOAflA2ymT21DrZDbo3n9crJvA9Iwdc3NsjLO8Ws3X4trpWAyMG4P4ijgHLZn8AIyakfWzDOwOd0wk/glkrj1GxY9uDG/8SYlsgBH4WsJ2infMwGrIfXqQx3ZQr/acI++fybGL94H1RX6mvryClaoE7McZvXYEkEptZWyEdZvJbdkOxdyT7yU8cefzCsIpF6lQOKIWKjwCzrHxIOGCAq0Hn/YTt8pgWGklP5TV5j1dg5Kxl9VoGLCu5JL4BGMuhWQ31FB4amo6DaFwvD37lB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exv8EwSIUVThm7FLYeZInjiQ+hhNfe/MlgGRwklS1DU=;
 b=a8qaJfuas1JbArjNxn13nDACFmKAZYVW/fyaZHADyNsNyAuqP+SYtg0jCw2g9N+C8nlAE4KwqCttBNoHLQ6gW0rxbTJVtDQd7TTxDAvSoKoAYpP4tqyBFFk856SQKXf7rsQyxVRVIOkfOCXvLFljGrIiIUpg6xFZY7jkAuS0JOTesfj8W6NFADV+QnW1RaJ+OQjnHHYwIPQwj3hBsTuyJ8A7vL+I/VnqalWJTLV0fQ5dnjt3dbm+hcqXfTzuerove8fcC+Q+Z5mcmS/iZwUDsyHWqUQ1RZj5CeCumPeQSgrtdFS2P2SfaaJFxxN41ZfiTBIs6OTohmJh7A9+2P7Vig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exv8EwSIUVThm7FLYeZInjiQ+hhNfe/MlgGRwklS1DU=;
 b=LTueUBQImT8nF3O5RTQCt9uw5x3LoZwOfZavL8lMyqJrrmajpLA40xex2X/I2KjEYvEtY8IkDCNK1O+5xvPtJy8Kz3QnpaY1MVlJ05PUgP+LDe41UbW4k8SCbhUkg+iZxCeKiaC2seGSDroxivAer2FAgrgX3pSIMX40MBvi4JbYIPwUnDUqid8ejbYaA4fmPP1BWh/lRNynIedXNrT06gPOnuBnJ4x0MNdviftebifZe+2JfBTZaxN5lqJDYTerO4RPIYUGQZmRnJKhoWNWz5M3cL87Rmy9HE+8KFxtK0Jj6iqWBVPXCiSLgQLyCVj+kkzFdYjFmjOx/syFvpQ7Pw==
Received: from DM4PR05MB10270.namprd05.prod.outlook.com (2603:10b6:8:180::11)
 by IA3PR05MB10967.namprd05.prod.outlook.com (2603:10b6:208:508::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 02:24:00 +0000
Received: from DM4PR05MB10270.namprd05.prod.outlook.com
 ([fe80::76f2:11b4:e433:a65c]) by DM4PR05MB10270.namprd05.prod.outlook.com
 ([fe80::76f2:11b4:e433:a65c%5]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 02:24:00 +0000
Message-ID:
 <DM4PR05MB102701671A4743DD0DB3D622AC7F9A@DM4PR05MB10270.namprd05.prod.outlook.com>
Date: Sat, 1 Nov 2025 10:23:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: PCIe probe failure on AmLogic A311D after 6.18-rc1
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 regressions@lists.linux.dev, Yue Wang <yue.wang@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <20251031161323.GA1688975@bhelgaas>
Content-Language: en-US
From: Linnaea Lavia <linnaea-von-lavia@live.com>
In-Reply-To: <20251031161323.GA1688975@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0123.apcprd02.prod.outlook.com
 (2603:1096:4:188::22) To DM4PR05MB10270.namprd05.prod.outlook.com
 (2603:10b6:8:180::11)
X-Microsoft-Original-Message-ID:
 <b1e0c887-34bc-4de6-8bca-25f9e1fa8e41@live.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB10270:EE_|IA3PR05MB10967:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ec455d-9bfd-4653-791d-08de18edb714
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|461199028|6090799003|5072599009|15080799012|12121999013|8060799015|23021999003|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlM2cUVKWXdLSVhVRWxXVnlQMGxEZGpJeDhFUkRGVmhEQlRhN0ZteG9MUWJy?=
 =?utf-8?B?ZmtrZ28yMXRReUxvQXVRQm5Mbno3MFhCWEJSZjlHNG1uODNQVVcycXpLOVJP?=
 =?utf-8?B?L29iWDBUU2NUWGxqOUIvV3FsY1JiMUpHNzluakh2emFpL1BqTTgyVDNUUWNl?=
 =?utf-8?B?S2Q5Z0RqT25EMTRwci9ZckF3WjJpNkZmNWRNdVk2YitHeVFuWEFaYlg5cXpt?=
 =?utf-8?B?MVpSSWl6cVVRTGxJVWJmSkdBZk1WVXgyZHRDZDZGOXdpeFZBeEFUNWpoUHZy?=
 =?utf-8?B?TXRUeDN3VURjMFRHdlVsYVU2ckw0REFtbTRlL2NzVEtZekxQUHlVQmhQL01M?=
 =?utf-8?B?ZVg0V1piNU5UWTF0RWl1eDdQd2lvQXR0L3JSZm1Wb1RQTitKaFJOcGlGM2VL?=
 =?utf-8?B?aVpvM3d1RUZ0RktxN3hQYVl6OHc1RktESVFnb3JaNHlJdGwyQUxlL2VMNDBl?=
 =?utf-8?B?RHFEQTdIdmNZcVQwTmExT28wcUkzTi9KRWp0aGdiU1JPMGxYck8xTkNqam9R?=
 =?utf-8?B?NEgrUCtieWtaYVVNUXI1WWdpMkg3RGltUS9ZQ2cvUElFUFNhd0IyelJpaTN2?=
 =?utf-8?B?R3lKSzZaZWtaTjdwNTVQYnlqd1E4MEhoVHk4a1Z2YjlmdGgvRHpNSldTZkJs?=
 =?utf-8?B?QVExbXBlL0V5QkZGbGdVbnhLNk5MRFA4ekg4bklJZ0dxUElyK1ZWWkhuVUdH?=
 =?utf-8?B?TE1lSFBSY2ZYQXhha1N2WDZzalpNU3ZNbEpkaGNPQzNZQlR3blM1VlZpdjRt?=
 =?utf-8?B?SDJRQjZIQjNvODlCQmw4dlFqeTlQaUs4NCtCTjgyLzJQd0ttTFVUOTZFaWxR?=
 =?utf-8?B?M0lxZ1hJTGJWTnpqTVQyTW45Z1VOOXVYUGNRR0t3Vnlqc3Uva3NrUjhoeGcw?=
 =?utf-8?B?cGhMWHZJcFFQMHVTWWtkMFFpWTBGbVVWYm15U1J2SmhMd3ZEWUVmWlhaYlpS?=
 =?utf-8?B?QTRrd0J0cURmMENnYjNkSTdXUDFQZHREb2tINHNLTE1Jallva2p6NFArcitJ?=
 =?utf-8?B?djZXQjlzNWNTWk1LWGcxZCs5LzNjY3ZjRVlRV2l2clc2SzBPYmFxcTZCL0Vp?=
 =?utf-8?B?eFU0dHdna3FQMUNYNG1MV3hHTEpkY3FPV1JqYnZzK0VNdTh1cVBVS25STldt?=
 =?utf-8?B?Y2ZtdnRLdWpPWkJ4OEtSdy9CejgrZmdIV1NtVGdzcWYycFMxWGdnd002SWV6?=
 =?utf-8?B?M2J6ZTRwRGtaMHNjSGVqRXVzUWs3NStrUTNjaytFaGphcCtmMEtIVDBVQ3BL?=
 =?utf-8?B?aldRaWRTeVAwUDY2cTd3ckNScEI4NUxPUTFSTmtNWTRnV001a04wVmo5WG1p?=
 =?utf-8?B?djMwcmRKaHpFaVhqSjFYZ3MyNThyU1dPcGlDbERoWDd2YytlZVdIYXJpTHFi?=
 =?utf-8?B?UWFlQnVrRFU1a2dKM01lTzZqbmdWeEhHbHAvdExnd2RGL25SdnNxTGExWFVH?=
 =?utf-8?B?MHhOQVIwdTJFWWVsRTNiWThUL3ZGTXhhOUlraG8vY0NHdkJ0WjROcCtKZS9s?=
 =?utf-8?B?QWtQZi9IVjlHU0FyVU9CL3NMcEpzMm93L0VRNkl6Nzh1elVBZTIyZEpVQ2hi?=
 =?utf-8?B?U0lQYjZiamQzanRUeTBUYWU3VDk5UlJJLzVOU1Zmb3V0UHVITCs5WmRYNWJq?=
 =?utf-8?B?UmpPTDNoZjBFTVJGbm5ZWmR0OEV0eXc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NG9QUDVtalpZc0hKdkxURkp0VW16aUdRNll4Y1B0OStVZUgyWFRXMHEybEM3?=
 =?utf-8?B?dEw2cGNRT3NFOU90Rm56YkZpRGw1QUt2U0F3aGRZWi8rOWNzMjZWamY1TlVL?=
 =?utf-8?B?djJ1UWw3UnJrTWJaOFZtRGZEc3djcFZ4VmM4OVdrV3VXNzduMXpHMEc1WWc2?=
 =?utf-8?B?L3Q4MUtqd3pJNFk0RHpTNGRtZmdIK0I0NVhwOE40WE5PeFZZc1BFZHg5dk0z?=
 =?utf-8?B?WXlDUUtENUZaRm14elRGVXFTRTZqSnlVbE9abUdFbGtrQlh3MFRBK3RkUXRs?=
 =?utf-8?B?K0RuekQ3T2ZDUFI2ZGhSYlJKYk9CdDhXdjlBNUN3bXlqZERvUDhEL3poWGFK?=
 =?utf-8?B?WWgwU3hLUmd5bDluY0dzL01yM2pZcmlvTkZaeFRlaUhDQmUwcHhkazZQakZ3?=
 =?utf-8?B?SUNSU2d1QzZNQURBQVBRaDJZdEZ3d3d4cGNBSHg2bG5qMEVxaWZML1Z5UDN6?=
 =?utf-8?B?Uk5BQ2pSYWxjWmtZOTdBR3pldFFjU292bWUzazVURnVtKzBraDExK2dEVlQ0?=
 =?utf-8?B?ak5XajFXS2hvclhCNjhlOHZHSVhaVXFmSnVraEdFYjdHdFA5cElnSXRLT2M5?=
 =?utf-8?B?OGFkUnBmSkx2TGFyLzAveXg4VEtaZThjTDM0WUtDeWs5bmtNd2pTOE8rcE9a?=
 =?utf-8?B?TjJwTHJxZmdDOTcxQTViYmhlWjgvMVh1dk9URitmVnY4YXkwK25aQlNLYnUr?=
 =?utf-8?B?aVhjc0JZNkNnNWdhakpkUkptTGpqdEtqNVI1TTlxRWlPUnVIRWxPRVBkdGZo?=
 =?utf-8?B?ZWlDb1dVVmJ3b1dJdnM5Mk4wVnduQlR4UVUvU3BSa21SOFN6ZVp6MnhEekFH?=
 =?utf-8?B?NnpHSGluTGVBTzNrYTluK3lseUphT2hsMklveEVTVk9Bb0t5NUVXWk9pM1c5?=
 =?utf-8?B?UFl2eldwNkg5QmZRL3hucGIwK1E1WmpqTzYxUC9VaG1EWDVhRjdObHhvUjgv?=
 =?utf-8?B?UlVKNmc5M0RHVTJBc2dKV2xnd2dxTDhVT0p1MlJhWER1WGVjNzR4blk5bHpj?=
 =?utf-8?B?STl5UTBVbDZaT1E5SXk2MkQxUFpJdWlGR2hyc2J0UXg2UC9KNFNXWTdrZ3da?=
 =?utf-8?B?cEhkL1BYNGZqaFBGNHBpUi9ldXlTNDhKcWJLalNLQlZFMDQ2SmZ4TUFRMHhp?=
 =?utf-8?B?OFNWeHBySkxSZVJwS2o5VlhJelhNeWplZmVveTE2clFJcFpxSWpNSGZ5UmFp?=
 =?utf-8?B?RytoZVZiaUlRcGVnN2NSRndlZWtqNnlLYXZUSlFSTHRUOTRJTlNMZDNKNGpY?=
 =?utf-8?B?dXlab2NhRDdrZkFUemNlT203NkFDcHhVK0hSdGg4KzJscEUrU0V6aDVUQTBt?=
 =?utf-8?B?N29GcWErc0xYVktneEtDNklHRjA0YkZWcTNKdVBGcVRIaWJicnpkRTVPczZo?=
 =?utf-8?B?TUJGMjVxWkNuSUFlSzB2dGZpTDJGcE0wNHlvZkw4QUdOL3MybW5hTGU2d0Zy?=
 =?utf-8?B?SFMrSnIvM0xTbjdJMkp4RWNjcEE1RXZxQ1lvOTdNbXVUNkRjTXJHb3VGbll3?=
 =?utf-8?B?VWw0K2JkZGlkSGpjUnk3NzlYOURFamk0MTZSSFE5aW5YYUl3dkxZSXdDenE4?=
 =?utf-8?B?T0E2Z01nQ2hsMEhRS0VyYXBmRHhUREVmU2lrL1ZaWkhYSEZDVzBCRnV6U3hN?=
 =?utf-8?B?Nk0zUm9qcW1IZjRGWExSWk5zd0lYVHRKbUd5NXB4S0UzNGZmbmdiSUVXOWRW?=
 =?utf-8?Q?ZbWm5ceYxOQcNGRnJsNH?=
X-OriginatorOrg: sct-15-20-8534-9-msonline-outlook-d08a8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ec455d-9bfd-4653-791d-08de18edb714
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB10270.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 02:23:59.8197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR05MB10967

On 11/1/2025 12:13 AM, Bjorn Helgaas wrote:
> On Fri, Oct 31, 2025 at 08:26:42PM +0800, Linnaea Lavia wrote:
>> On 10/31/2025 4:50 PM, Neil Armstrong wrote:
>>> On 10/31/25 06:34, Linnaea Lavia wrote:
>>>> On 10/30/2025 1:15 AM, Bjorn Helgaas wrote:
>>>>> On Wed, Oct 29, 2025 at 06:50:46PM +0800, Linnaea Lavia wrote:
>>>>>> On 10/29/2025 6:16 AM, Bjorn Helgaas wrote:
>>>>>
>>>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>>>>> index 214ed060ca1b..9cd12924b5cb 100644
>>>>>>> --- a/drivers/pci/quirks.c
>>>>>>> +++ b/drivers/pci/quirks.c
>>>>>>> @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>>>>>>>      * disable both L0s and L1 for now to be safe.
>>>>>>>      */
>>>>>>>     DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>>>>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
>>>>>>>     /*
>>>>>>>      * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
>>>>>>
>>>>>> I have applied the patch on 6.18-rc3 but it's still trying to enable ASPM for some reasons.
>>>>>
>>>>> Sorry, my fault, I should have made that fixup run earlier, so the
>>>>> patch should be this instead:
>>>>>
>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>>> index 214ed060ca1b..4fc04015ca0c 100644
>>>>> --- a/drivers/pci/quirks.c
>>>>> +++ b/drivers/pci/quirks.c
>>>>> @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>>>>>     * disable both L0s and L1 for now to be safe.
>>>>>     */
>>>>>    DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>>>>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
>>>>
>>>> L1 still got enabled
> 
> Is that based on the output below?
> 
>    [    5.445853] [     T48] pci 0000:00:00.0: Disabling ASPM L0s/L1
>    [    5.560448] [     T48] pci 0000:01:00.0: ASPM: default states L1
> 
> If so, this doesn't necessarily mean L1 was enabled.  It means the
> quirk marked the 00:00.0 Root Port so we shouldn't ever enable L0s or
> L1, and when we enumerated 01:00.0, we set its default ASPM state to
> L1.
> 
> But I don't *think* L1 should actually be enabled unless we can enable
> it for both 00:00.0 and 01:00.0, and the quirk should mean that we
> can't enable it for 00:00.0.

It's from the output of lspci -vv, even with the patch applied.

   LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
           ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+

> 
> This muddle of "capable" (per Link Capabilities) vs "disabled" (either
> the Link Control shows disabled, or software said "don't ever use L1")
> is part of what makes aspm.c so confusing.
> 
>>>> The card works just fine. I'm thinking the ASPM issue is
>>>> probably from the glue driver reporting the link to be down when
>>>> it's really just in low power state.
>>>
>>> You're probably right, the meson_pcie_link_up() not only checks
>>> the LTSSM but also the speed, which is probably wrong.
>>>
>>> Can you try removing the test for speed ?
>>>
>>> -                 if (smlh_up && rdlh_up && ltssm_up && speed_okay)
>>> +                 if (smlh_up && rdlh_up && ltssm_up)
>>>
>>> The other drivers just checks the link, and some only the smlh_up
>>> && rdlh_up. So you can also probably drop ltssm_up aswell.
>>
>> I can confirm that removing the check for ltssm_up and speed_okay
>> made ASPM work.
> 
> I don't think meson_pcie_link_up() should have the loop in it, so the
> ltssm_up and speed_okay checks, the loop, the delay, and the timeout
> message should probably all be removed.  That method is supposed to be
> a simple true/false check, and any waiting required should be done in
> dw_pcie_wait_for_link().
> 
> The link was clearly up when we discovered 01:00.0, so the "wait
> linkup timeout" messages from meson_pcie_link_up() after that must be
> from dw_pcie_link_up() being called via the .map_bus() call in
> pci_generic_config_read() or pci_generic_config_write().
> 
> When meson_pcie_link_up() returns false in those config accessors,
> the config accesses will fail (they won't even be attempted), so we'll
> see things like this:
> 
>    pci 0000:01:00.0: BAR 0: error updating (0xfc700004 != 0xffffffff)
> 
> and "Unknown header type 7f" from lspci.
> 
> Can you drop the ASPM quirk patch and instead try the
> meson_pcie_link_up() patch below on top of v6.18-rc3?
> 

I have tested and can report that with the patch ASPM works out of the box.

>> We still need a solution to the original issue that's preventing the
>> controller from being initialized.
>>
>> My kernel has the following patch applied, but I think it's not
>> suitable for upstream as this changes device tree bindings for PCIe
>> controller on meson.
> 
> I assume the original issue is this:
> 
>    meson-pcie fc000000.pcie: error -EBUSY: can't request region for resource [mem 0xfc000000-0xfc3fffff]
> 
> and you confirmed that it wasn't fixed by a1978b692a39 ("PCI: dwc: Use
> custom pci_ops for root bus DBI vs ECAM config access"), which
> appeared in v6.18-rc3?
> 
> If it's still broken in v6.18-rc3, and the dtsi and
> meson_pcie_get_mems() patch below makes it work, we have more work to
> do, and maybe Krishna has some ideas.
> 

