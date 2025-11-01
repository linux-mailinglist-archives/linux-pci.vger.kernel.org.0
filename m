Return-Path: <linux-pci+bounces-39986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEA8C27601
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 03:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2ADE4E1A1F
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 02:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ACF253951;
	Sat,  1 Nov 2025 02:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="uNW/ynlE"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010042.outbound.protection.outlook.com [52.103.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1719B1519AC
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761963988; cv=fail; b=VePaEM7+4+P+y1NTnC0jD6IQGryWEspaTWWsrQ6AyYyUtlBeeLEjUGPUoEbAyMQoujhuGdcNP5ObgLF1qw+34cjulURXWKgHzaPV4MEwCcFwjc20hyZU7zS9gyzApYvk/V71KqEQup0oZofGAVfY4lJa7JvUkagJqJrguwHhURU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761963988; c=relaxed/simple;
	bh=Tb/Z1lI+8eicxVzkxf8zdVWz0NBT2L4aWahKbA3+Fs8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XHkHjg/1eBk3orXxfJRTWRAgW3HCypf72PlmcNT+9Mo7DfM5/tQLAO3BdugvFMLgWCswk2thYiA3r72PFcAwhMpShusaqEGz+VWWbqCLxo3zCzQSmo+bNJUMhxzjXNxFtmu8Sv53iUSrup2ngpMYuDPnAnM7KFIkmxOvqvDvVdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=uNW/ynlE; arc=fail smtp.client-ip=52.103.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOoXXzbdn600BN99t2YuYsDV/cdoYbzirCjR30q4vxr8ix9KKY7sInt99xiLJk1woE5BhhyAJuovKz7TK9NCu/bELfw/r1EByZwSvSV309SQD74nANzEIQqQ7Wex/8TjgfsxpzSxmpf2znIF7Z9xglhXR4apatB5wCMS3JB64uD6ydIEwpA5T/s4UNLsqE4RE6KRZZXSdbclai4b17+10bc0u+Fz9PW7vxWmZSx2QJfmrIkbHiuF0O7dWgU5LS542ChnVxYGXv+ZQ6PBFkfN8rZVOhkynkEGR/TkrRpA4cPA7YneR8zG18bZdaz5aZgz2L/JM3tQX6OjebyO+cd7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ELHh/4CC4lU5ByrRHEryThhZdDg9bLlY0xVymjzJ0c=;
 b=R3v70Wa75nzPqvQ00otrGLEE417oOpM0EIuZTGmYBA4xxhhq2fAAa8qJdhIc+TH8Gd1E7Kzs17KNeOCRkvtsDqf0salQbQZCIFmgVJvR3f47dHfWLLDFDDNqP7QzZa3icdAm7qdyW0QQ2QJKWqTSHDRdEQzwBOD5uzlnVSnh+dnCRo1Lo/irMlfbxfkjW9QjzL0cpar1o+oR5Emt237XeFovvauxcbIWz1AwcSvbLJQuTHrY0xVHQHRFICXWYxlfyEhUh8YiRz6oPmGmOt3bPy8K/dolXtwVrlmz1ySo2x19Al3Dq3dL5ZDhTkJcOl8kpbvTCR9XbIVBTU5LipWlXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ELHh/4CC4lU5ByrRHEryThhZdDg9bLlY0xVymjzJ0c=;
 b=uNW/ynlEADWJk9hfBOX0nVXmhmD31T97/xZJ9b6hmlzZeANF3no5BXIAXFWiO8JqgoB7M0xDc+AjCKBP3MQpqeY4nEHQT0B8okkAN5QWyF6qaWPSIAqOmUm7UdBzuAwd9gOO2SA/UmUkEd56Tq917jzFCd5emsYo8EOiLx1kg4nHWvR93Gbi47cyFluoqrwYrkiDduXLA9hs9iyNb0ECGeezCTJ6762FrPibd80yAY2ZyHLw+jLVesqprL7svdaGX7sVSnYQuL2GQfuDBjTyA1o2InPKjfofh7jCkB8Ue9FYWoyPTvzU7O8A62CTY3PLzx35gPplymj4k2IBzaO4aQ==
Received: from DM4PR05MB10270.namprd05.prod.outlook.com (2603:10b6:8:180::11)
 by DS2PR05MB998331.namprd05.prod.outlook.com (2603:10b6:8:32e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Sat, 1 Nov
 2025 02:26:25 +0000
Received: from DM4PR05MB10270.namprd05.prod.outlook.com
 ([fe80::76f2:11b4:e433:a65c]) by DM4PR05MB10270.namprd05.prod.outlook.com
 ([fe80::76f2:11b4:e433:a65c%5]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 02:26:25 +0000
Message-ID:
 <DM4PR05MB102703CA8E86DFA6C43B03582C7F9A@DM4PR05MB10270.namprd05.prod.outlook.com>
Date: Sat, 1 Nov 2025 10:26:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: PCIe probe failure on AmLogic A311D after 6.18-rc1
To: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 regressions@lists.linux.dev, Yue Wang <yue.wang@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <DM4PR05MB1027077E1F4CD8B1A7EDADF1DC7F8A@DM4PR05MB10270.namprd05.prod.outlook.com>
 <20251031161323.GA1688975@bhelgaas>
 <agqyqr7c6wwkr4fewt3szomd7c57eeujkal7modj46ssbngxf7@f7t56i723mvx>
Content-Language: en-US
From: Linnaea Lavia <linnaea-von-lavia@live.com>
In-Reply-To: <agqyqr7c6wwkr4fewt3szomd7c57eeujkal7modj46ssbngxf7@f7t56i723mvx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0238.apcprd06.prod.outlook.com
 (2603:1096:4:ac::22) To DM4PR05MB10270.namprd05.prod.outlook.com
 (2603:10b6:8:180::11)
X-Microsoft-Original-Message-ID:
 <58b9e249-ebb1-45b8-ab75-ec0164cc5729@live.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB10270:EE_|DS2PR05MB998331:EE_
X-MS-Office365-Filtering-Correlation-Id: efb8b267-8adf-408e-6eb3-08de18ee0e17
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799015|41001999006|12121999013|23021999003|15080799012|5072599009|19110799012|6090799003|1602099012|40105399003|440099028|4302099013|3412199025|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clY2Mjd3UXZackZEWkVvems1WFdMYm4zS0t4UjY3ZXZNVUd5cEY2OElRbHdq?=
 =?utf-8?B?NWtnWml0SExaVG5hT1k5enJoM1NrMCtwMUo1M3RlaTFHbk45cGZNREJ2S3lZ?=
 =?utf-8?B?RngybEF6dm12cjlhSEthaDVwWlJ1a1pLazVmRGg4ZkJYU3NvS2d5M2luYjdC?=
 =?utf-8?B?SWx0Qmt4STBORy9lQTF2UXBpWnFNVG0zRVBpbGcwY29YQXhsZmEwS0dxZWNz?=
 =?utf-8?B?UXRkWkFwSzQvOTVYTmhzbE4xT1l6SkZmRXJoQ3BONGYyci93N0VKQ3FIanpG?=
 =?utf-8?B?bUV6QUx6S21rZnNlZ21uemF4VGVoZC9tNXludGM1QzBTa01sQWpFRUIwbks0?=
 =?utf-8?B?YTY2UmN5MDZoZ0FsY1RzTmZ3bFhtZnlNTitYOUluVjl3cWpmb1hYUEZlZTRL?=
 =?utf-8?B?SFpJNmxUdHZhNExIdi9IbVpTaXJwUWs0WkxNWk5DeXdKR1VCbU1rTUJVZHlx?=
 =?utf-8?B?OFNmVWpBb1ljL2NhUjU3ZTlFY2RNWCtWbGlpTnF4ck12dkVjeWlwUnFNTE1x?=
 =?utf-8?B?a3IxYS9oajlWMEtkbElDRGF3dUVGL2xVK0FHZzVuZFVBN0haaHhHYzUrdkVT?=
 =?utf-8?B?WnF1S0cyWXlKRUoreTFUR1M3aEdKdEthWlBBUEwwbEVZTGtIKytnR1p6bGo1?=
 =?utf-8?B?VlIxZ0t5bDdPZ1dLTHFXQUovQThGMlgyang3QlpvTStrNkVoNGM2RTFtV0ZT?=
 =?utf-8?B?cUpIZXdUTEorbVhpeEJyU1NJTVBvZkxibkZCaWJaSnFOb293RnUvOFlQcWFK?=
 =?utf-8?B?cjNNZUpVb3RXZzRXZXp4NWIwREZXaURVanliTXYzSjlBS2dodEE2OTR2b1Zm?=
 =?utf-8?B?Vzh1b3doS3MxbWxPUDB6Y2xUam9adUJlVWpickJUMWVJdTVodnRNUjdYalJm?=
 =?utf-8?B?Q2d5M3FyUHJYRTdxUTA4WnFuYmV6MXR0OGJNdTI0Q1dNNjQzU2Mwd1pkbXRS?=
 =?utf-8?B?cFZXNkRDeVhUWVlzWjU4S1pYbjR4WTZad2hYLzM3dzRkSTA4VktVTXpHNDNN?=
 =?utf-8?B?ckF3TlpvVnZTN25yclJacThOY2VuUzg1OVpwTW45TFpGOUtSalJPNUlYUm94?=
 =?utf-8?B?UzV1TWdmdEkzVHJEZ1JlL1dhMDVvbTdTS2ZsR0hGUzd0OTlWdTAyYWM0b1pq?=
 =?utf-8?B?cVpmRzFCczhtVDIrWnIyMXlHVzNEcjFTWmRJc0tTNllMa0tVaFpEcEtiU2c5?=
 =?utf-8?B?Sm5pNEh4SHRidVJ3RzN0WnFDMEdkditYUmJQeDZDRmVyb2U4RXVOdkZKU3dD?=
 =?utf-8?B?aGp3ckdqTWJVL1Vod3l2NEFCaUNWL1FxWlB5elZkOFlGd1YyK0xEMkZadzg2?=
 =?utf-8?B?UVFhdDc5emRVSlRQQlVTVER4Sks4cGxJNm9objdvRW9leWxScFZyb1pZMEVV?=
 =?utf-8?B?NlZzamkySkZXc0pNRG50QnFVSHJQeUdKZjB0YUdMaHdmRzNyTFZLNEN5b05S?=
 =?utf-8?B?QWxHSm5xeTFMekF4OVdYcC9GZHFrYmc3TUNYVDZjVzFtQTlRaVZkVGQ0ZVZu?=
 =?utf-8?B?aDVTdTAvTG5pZXlCNWR4UFVQZU5CZ3BabzRlR2xFeDQ5UlVkWGw4VTI1ZVJG?=
 =?utf-8?B?cmZtWmdERjhxK0lZNndOMGl4dmxvdmFzTXY4TFdnK2tCb01pbW4xd3FwZGlm?=
 =?utf-8?B?T0J5YndvS21lOVFlUCtvSnpPYmVXYm5qaGJTVmlSU2FzOUt5cTlTVlFxaWxz?=
 =?utf-8?B?TllvZi9pZmdCSk1ZMlVrMGZsRDNNaDJjWVgxOTNsYjIwaUQwc21qTkNyN0NT?=
 =?utf-8?B?bFM3SERBRERUK3drTXZIMGk2aU43WUxUWUdtTXJ2Si81NHZVVEFGbVhPcUkr?=
 =?utf-8?B?NG5JNFFyV0E5NEdHbHQ2ZEY1dTkxbDkwY1NoMFRpaTgyaUN5TzQwcEhmK3k4?=
 =?utf-8?Q?brvNof98f6LcO?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW5ycG5kNlJMY2lKY1oxZFEwUTUzYVBHSjl3YkdnbW1JMGJOSTRibFkyaU9L?=
 =?utf-8?B?UFl1ZEhuQkZDaUJRZUtDTlFGUXBxd3lWeVpEUkNhVzBQVWw4V0Y5bTh0b0ts?=
 =?utf-8?B?Y1EzTHNvemw3S084ZGdVSGNJK1NvaDd2UCtwcjVTL2UzZWJQWmxqQmVab09U?=
 =?utf-8?B?SnNjRjN4UmVzNTZKWVpiZElYRXg5WHJIUU9kZHhBc2JqWHNUUzgxbEYxNFA5?=
 =?utf-8?B?akh3OUwzQUNLalR6NVByWCt0dWxpQmNkNkRSK3BpalliRTk1RXhhR1k1SHhn?=
 =?utf-8?B?R0ZkUERpQXE2cExvUlNQTHNDVW1VOWU3ZGUvTHdpMmc4M3U3WVZYRHNvR1Yz?=
 =?utf-8?B?b09GbzM2SWlqQlJwWEYyV0lIb1hUVWpkZzBVTmpibXo4cll4bDB5Wm9HZUJz?=
 =?utf-8?B?UDkwVHo4eVhCQUwrdmtTN2d1RFREZWVkUCtQR1F6c3I4UThmTEt0NUJsbDh3?=
 =?utf-8?B?Z292OHMxZHZnbEhLS1NiSm9XTDJPYXA5bTNvSk5jaDBadE54RklUVFBEMXJo?=
 =?utf-8?B?VXpHNUdoM2xmSXI5QTFQZjF5dXdmcHpteUswTFNBMFpCT1dqQkk5eWp4Um02?=
 =?utf-8?B?RzlkWE5yTGxmbE9VTHA1K2x5Y3lmbWJNVGIvUU96NXZpWjdUa1Y0Z3B2aVE0?=
 =?utf-8?B?SGh2TFF6ZCt4NStCdzl1MjNzaHFtVm9NRGV4VnExRUk4YTVoWVZtT3NUbUsx?=
 =?utf-8?B?TUdIMDhaUE1XTW9IbkUrWVcycis2aFBvQnpiTDZxd0c4bU1RdUVYZktrRzRB?=
 =?utf-8?B?cE5xNmpqbExuM2tZVGNMVlA0cUpteEswakpwdG42Nld5UjlaSVZZMHFNd3p4?=
 =?utf-8?B?NTZSd1ZvR1FZTWpZZE5YNzdzQjNmRm9nM2xpVUVMSjVVRkpPODRyVnZZYUx1?=
 =?utf-8?B?VUhkRGRaTW1WNnFmMStNZUpENE1STWtiblI4RnZidlJMVlcxcDF0Mm9Pa1Jl?=
 =?utf-8?B?UzNENmZ6QWZrc21MbEk2RExqM1FLakI5ZjExSFl0KzlPTndDa3FEZHlUQ1U3?=
 =?utf-8?B?N3NIK002cjZOMmpDQzI3b3JJQzBZNEhlS1cwc0cvUzVyRENDU3RaRTg4UHlX?=
 =?utf-8?B?NDVWS2lnT1RsbklPVm53TFNGc0Z4YTZkWDRkV3dOSVJYVmhwL2hkc1J0OHY3?=
 =?utf-8?B?U3VOelpHaXJqUWNaUW5GZ0VXcFlVOG0zTm50UC95UjU0VmlNYm4rbStic2NO?=
 =?utf-8?B?ZlZMT3RacHVPbVlzK2RnRERFM1VCSXFqRjkyZmNCVEZxejNUYy91K0R5Zzhm?=
 =?utf-8?B?b3VCUk4xTmYrN2s5SWN0THpmL1lES1V3ZlFHM20xeS9lTmNHNU9uQ09tcUpr?=
 =?utf-8?B?NWU5cTNtY0xpeVpVYm9uRnFZZnJyL0hZY2JaR2RZOGJ6RFhsdmcrT3NLWjBZ?=
 =?utf-8?B?M1pDSEMzM3FVUFNEYXE0dHI4U0VpRGxkZXVKNkNLSVMwem1NTllSMDRCMDBk?=
 =?utf-8?B?SExlWEFYU3pwYjNrYTkzZkFISmtUMlprZFJtc1kwMzJOWHRSQTgwSVpVbVh1?=
 =?utf-8?B?enRPOUd3NGhwWDlyd2RGRG9HUFcrYzE4anJKbDF1UzROdnFaUmNMWnhIb0lV?=
 =?utf-8?B?STU4L2FMbmNvMjhvOGFaaHk4bHAxQ2lSTWE4di9hamYzbVpDY1pyZGxRUWNs?=
 =?utf-8?B?RVdvVnlDWmZ2d3dCdmF2cmYrS28wckdSektXUERDT2ZXd3ltSlc2eXlYWEwx?=
 =?utf-8?Q?nRa6M4mCWgdQJqNOxzK/?=
X-OriginatorOrg: sct-15-20-8534-9-msonline-outlook-d08a8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: efb8b267-8adf-408e-6eb3-08de18ee0e17
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB10270.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 02:26:25.3209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR05MB998331

On 11/1/2025 1:47 AM, Manivannan Sadhasivam wrote:
> On Fri, Oct 31, 2025 at 11:13:23AM -0500, Bjorn Helgaas wrote:
>> On Fri, Oct 31, 2025 at 08:26:42PM +0800, Linnaea Lavia wrote:
>>> On 10/31/2025 4:50 PM, Neil Armstrong wrote:
>>>> On 10/31/25 06:34, Linnaea Lavia wrote:
>>>>> On 10/30/2025 1:15 AM, Bjorn Helgaas wrote:
>>>>>> On Wed, Oct 29, 2025 at 06:50:46PM +0800, Linnaea Lavia wrote:
>>>>>>> On 10/29/2025 6:16 AM, Bjorn Helgaas wrote:
>>>>>>
>>>>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>>>>>> index 214ed060ca1b..9cd12924b5cb 100644
>>>>>>>> --- a/drivers/pci/quirks.c
>>>>>>>> +++ b/drivers/pci/quirks.c
>>>>>>>> @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>>>>>>>>      * disable both L0s and L1 for now to be safe.
>>>>>>>>      */
>>>>>>>>     DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>>>>>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
>>>>>>>>     /*
>>>>>>>>      * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
>>>>>>>
>>>>>>> I have applied the patch on 6.18-rc3 but it's still trying to enable ASPM for some reasons.
>>>>>>
>>>>>> Sorry, my fault, I should have made that fixup run earlier, so the
>>>>>> patch should be this instead:
>>>>>>
>>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>>>> index 214ed060ca1b..4fc04015ca0c 100644
>>>>>> --- a/drivers/pci/quirks.c
>>>>>> +++ b/drivers/pci/quirks.c
>>>>>> @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>>>>>>     * disable both L0s and L1 for now to be safe.
>>>>>>     */
>>>>>>    DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>>>>>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
>>>>>
>>>>> L1 still got enabled
>>
>> Is that based on the output below?
>>
>>    [    5.445853] [     T48] pci 0000:00:00.0: Disabling ASPM L0s/L1
>>    [    5.560448] [     T48] pci 0000:01:00.0: ASPM: default states L1
>>
>> If so, this doesn't necessarily mean L1 was enabled.  It means the
>> quirk marked the 00:00.0 Root Port so we shouldn't ever enable L0s or
>> L1, and when we enumerated 01:00.0, we set its default ASPM state to
>> L1.
>>
>> But I don't *think* L1 should actually be enabled unless we can enable
>> it for both 00:00.0 and 01:00.0, and the quirk should mean that we
>> can't enable it for 00:00.0.
>>
>> This muddle of "capable" (per Link Capabilities) vs "disabled" (either
>> the Link Control shows disabled, or software said "don't ever use L1")
>> is part of what makes aspm.c so confusing.
>>
>>>>> The card works just fine. I'm thinking the ASPM issue is
>>>>> probably from the glue driver reporting the link to be down when
>>>>> it's really just in low power state.
>>>>
>>>> You're probably right, the meson_pcie_link_up() not only checks
>>>> the LTSSM but also the speed, which is probably wrong.
>>>>
>>>> Can you try removing the test for speed ?
>>>>
>>>> -                 if (smlh_up && rdlh_up && ltssm_up && speed_okay)
>>>> +                 if (smlh_up && rdlh_up && ltssm_up)
>>>>
>>>> The other drivers just checks the link, and some only the smlh_up
>>>> && rdlh_up. So you can also probably drop ltssm_up aswell.
>>>
>>> I can confirm that removing the check for ltssm_up and speed_okay
>>> made ASPM work.
>>
>> I don't think meson_pcie_link_up() should have the loop in it, so the
>> ltssm_up and speed_okay checks, the loop, the delay, and the timeout
>> message should probably all be removed.  That method is supposed to be
>> a simple true/false check, and any waiting required should be done in
>> dw_pcie_wait_for_link().
>>
>> The link was clearly up when we discovered 01:00.0, so the "wait
>> linkup timeout" messages from meson_pcie_link_up() after that must be
>> from dw_pcie_link_up() being called via the .map_bus() call in
>> pci_generic_config_read() or pci_generic_config_write().
>>
>> When meson_pcie_link_up() returns false in those config accessors,
>> the config accesses will fail (they won't even be attempted), so we'll
>> see things like this:
>>
>>    pci 0000:01:00.0: BAR 0: error updating (0xfc700004 != 0xffffffff)
>>
>> and "Unknown header type 7f" from lspci.
>>
>> Can you drop the ASPM quirk patch and instead try the
>> meson_pcie_link_up() patch below on top of v6.18-rc3?
>>
>>> We still need a solution to the original issue that's preventing the
>>> controller from being initialized.
>>>
>>> My kernel has the following patch applied, but I think it's not
>>> suitable for upstream as this changes device tree bindings for PCIe
>>> controller on meson.
>>
>> I assume the original issue is this:
>>
>>    meson-pcie fc000000.pcie: error -EBUSY: can't request region for resource [mem 0xfc000000-0xfc3fffff]
>>
>> and you confirmed that it wasn't fixed by a1978b692a39 ("PCI: dwc: Use
>> custom pci_ops for root bus DBI vs ECAM config access"), which
>> appeared in v6.18-rc3?
>>
>> If it's still broken in v6.18-rc3, and the dtsi and
>> meson_pcie_get_mems() patch below makes it work, we have more work to
>> do, and maybe Krishna has some ideas.
>>
> 
> We have two issues on this platform:
> 
> 1. DT represents 'dbi' region as 'elbi', which was wrong as both are different
> address spaces. ELBI is an optional region, whereas DBI has Root Port and
> controller configuration registers, which is mandatory.
> 
> 2. Driver parses/maps the 'elbi' region and stores it in 'pci->dbi_base'. So
> this made sure that the code depending on the 'pci->dbi_base' work as expected.
> 
> Commit c96992a24bec, moved the ELBI parsing logic to the core code, and it also
> removed the custom parsing from glue drivers. But since this driver was using
> 'pci->dbi_base' instead of 'pci->elbi_base', it was not caught during the move.
> 
> I've submitted a series [1] that hopefully would fix this resource parsing
> issue. Please test it out.
> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/20251031-pci-meson-fix-v1-0-ed29ee5b54f9@oss.qualcomm.com
> 

Applied on vanilla 6.18-rc3 with Bjorn's patch, PCIe now works out of the box on the board.

