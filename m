Return-Path: <linux-pci+bounces-21256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1A8A31ABE
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 01:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8072E167F76
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 00:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536ECC13B;
	Wed, 12 Feb 2025 00:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XUU/pvga"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011027.outbound.protection.outlook.com [52.103.68.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055F17993;
	Wed, 12 Feb 2025 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321336; cv=fail; b=gsd70YLPmn9HARYNqlSS9XHnY/qa36COvRRPcTPu4Hok9JEXRVL09Ceo3ypDCyCP6aUTpUsvdaMD8j3Et/pj6A3EJ+lWIneDPb5A9ggF+Wy1r9jBqUw7iWbulpYmYAhAlRyBQCjLop1ciiLA56BxNysuNMm3S3+8NoB/2LHusH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321336; c=relaxed/simple;
	bh=UiY8HYhSEQFwOzNfoKEreJHaaAbFhnec/nnn4r9rEjY=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hpStCQiGE8PNEn0axMkGRlukezj20BoD3qerwGmeY+gauokiic4HKhfIyl3YWtTrsSHpUic6ycL4bVTzGjjwTrjbofF3lfAriz2d0iaZY2Io269yIbLtC45xU5cfSmlvYLzFzvAl9HnQzUKA1EzOJ8pgPFNCZX68W6cvXs1m1T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XUU/pvga; arc=fail smtp.client-ip=52.103.68.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5roPhW3sSFmxRgc9qMA0ycuE8F1mKsqYU1Dknm4/Jr23GoqPJUVUrMeEeHeKhQNYHt5x1BLofAzuApHlmfUtEP340/GZn2fr2sHet4I2dr2I/g14vNRK0n2MpUrqDuE+Ebl5gNC+ocYgwKIpGgr5JPO6F24RP31o9qn8Q+hAjZ6QPjRPz/uwh+rGY6ZKZuFtbz5ulkcC7cfp+Z4v6pu6RTtWC7+S0FW8LJKR+MqqGrYskuKY9PdCmmwEtTGhH/yek8KskC8krywzCLocHlZcp6vrZGekoDarrofg3Vq1nbnQ0KrL2QeXJRL4NV1LYFZtf0+fGZpJs/IbKIe8JWdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJTAVo8XLvaV4p3g0lsAxkhxxUYBtvDlaDz1qIlIDY0=;
 b=llvxkPDlJl0Tnd1D6llJo2b+EEWpEFyEq6Vr3waLsPNwYMC7cw1re3HPiX053SO9ycgmM3D1OyVcDzzTmv9txCAeZ9GzkBF7eFijVVkS4AQld5TCYIaZOk3SRfygj354d+GHEUdrqAPWIUAkNJMkiaNm5PIwb0vSUeMGUi0r8dLmjncKUt5S4CsXJPPLpaeXPZUbnm2fCrhakPuTb4kT0pTSFQjZcR5+wFCI+GLhrkUf4w1CkMQgjV50V4FYckx6hvdwvg6w4yVK1THOkfX4+9nprm9avcDCIbXYqEurb/JkZHWrpu8T0s0gTTjeajV888RFnGz5+Gxp1VfV70RJEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJTAVo8XLvaV4p3g0lsAxkhxxUYBtvDlaDz1qIlIDY0=;
 b=XUU/pvgaN/t07nHxJQkUDZiI1PYqin/xD7jT90CrSUboYOPyVEGUK22Lab2qvH+ORX+GJk3sjTbS87O5X5vPLCMM6wOFVE5JLA5UstIxaqNtxnY/HoFfp96JcODAM3HfTwkIksRZO+FiVF5DbTlH+n9ffBZoFCAqXEWS+YXUmxdF4s7fh1fMSnd3vk22nL/qGbpXJYG5WbhK6BI+TI9R8EbyNkHcQgEo3TEmPYKVSXj9pmoha3uqmoowF/u7rMiFv7Ro8/14q45zgPN6S3ErKFXym6dl3BNkvDN2eOWxD5SIMehm7o5E85NuqtRlxXtPTNTYWy/UOCQtkTfWY2RXLg==
Received: from BM1PR01MB2433.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:51::16)
 by PN3PPFB4730D036.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::4a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 00:48:45 +0000
Received: from BM1PR01MB2433.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d0a4:2dc3:d695:8317]) by BM1PR01MB2433.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d0a4:2dc3:d695:8317%4]) with mapi id 15.20.8422.012; Wed, 12 Feb 2025
 00:48:45 +0000
Message-ID:
 <BM1PR01MB2433B351262A2963B192F0A8FEFC2@BM1PR01MB2433.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 12 Feb 2025 08:48:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v3 3/5] dt-bindings: mfd: syscon: Add sg2042 pcie
 ctrl compatible
To: Lee Jones <lee@kernel.org>
References: <cover.1736923025.git.unicorn_wang@outlook.com>
 <a9b213536c5bbc20de649afae69d2898a75924e4.1736923025.git.unicorn_wang@outlook.com>
 <173928439078.2206727.3592689089610946034.b4-ty@kernel.org>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
 arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com,
 helgaas@kernel.org, Chen Wang <unicornxw@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <173928439078.2206727.3592689089610946034.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To BM1PR01MB2433.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:51::16)
X-Microsoft-Original-Message-ID:
 <9008cc2a-eb11-4ae7-a7f3-a4a54363f9a4@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB2433:EE_|PN3PPFB4730D036:EE_
X-MS-Office365-Filtering-Correlation-Id: 561b5e34-77a7-44f6-c16d-08dd4aff00bd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|461199028|8060799006|19110799003|5072599009|7092599003|6090799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGtNQm4vcVFhemFPRDlINDg4ZmJ0bzF6SktxTEE0QUhCcldZUTZUYWwvOUtY?=
 =?utf-8?B?bEpJY0s3aTBoNnBmZ3UrSkdBbHR4RXF5OC9OcG5ET0k0RitPOXdXLzdoQVBC?=
 =?utf-8?B?d3JrUjBQcFc2MVlid0dDaWkzZWRhRU1HSTRjWk9HRC9Delk0T1RhSjlndkhG?=
 =?utf-8?B?MkdMdlNncmRJMlRuMGh3WUU5ZzNIYVZLUEpQWktMdlBsWXdxV3BIaGpGTUIw?=
 =?utf-8?B?ZFc3TVkyTytPMHhFTTlzYlJVSGFOTFpjR05aa3dqMlhra2NpV09Ka28zY09r?=
 =?utf-8?B?b2VKNE5yc1pUTEt4ZHE0cXR3c3F0TG5KQ1JCcFRtOGJ4MUhKSThOT0wzQTV3?=
 =?utf-8?B?Vk8rK2ZNSXFEK1EvSDNuakNWMk9yUGh0TWRIOWxMc2Rlb3g4cW5qeEx0eXU2?=
 =?utf-8?B?VTkrYmt2dEpBc3crK3RnRWFqUklBY1pkNnc5NFRVNDVSS2dDU0tsc1E0Q0Vm?=
 =?utf-8?B?azBEZFhyTjYzejhoOXZyN3c2ckI1QmZ6cmNiVlpSMFp4enIveEs0UlRuV2dl?=
 =?utf-8?B?ZklRTk1Ia0FtM2F3eGNzZDV0ZzBEbnNEelhoVkVPUDZSbGdJVjJqL2hhM2tq?=
 =?utf-8?B?VTVRZGxKcXZ0aUs5LzZwc1I4NlFWVStHa2Yyeit5ZnZrMUw2THhpZWZqOGtE?=
 =?utf-8?B?VFFRNmVsVjlsYkxBdG1VcHI3dlZaaFQrSk5wYTBpclNhWGxhczd3MTVVMTRy?=
 =?utf-8?B?ZFBqVUl1ck5tOWtUdXZjWURpcVlRdlk1YmJSWG9sRHhkaEppSk5WQWV6VUlC?=
 =?utf-8?B?eG5ZYzVybmRPdUZ3aVlKMjQ3anlyMmRCUVRTUzZPNUpDQ1ZjZkk5RXFkclcx?=
 =?utf-8?B?dXNDdlM2cmF1aUE3V0hSRkxNSDd2d1JydzJGV3grRWJWK0dGcWc5N0tsWmFL?=
 =?utf-8?B?NHRoNGozZWc4Vm5kRThhejNjZmpyS0l0ZHBHM3dFZTZtamlhQkkzODQ0b2p4?=
 =?utf-8?B?V0ZxelF0ZWtkdnUyUWp0bG5ZZTNJaEFQTEpYUm1UVCtBRVNTUTJsK0hCZnVB?=
 =?utf-8?B?MFFUWS93RWpqb1RpVkVZRURQSVJ4YllBMXc3ZTVDL1JsTnhnYXRNTnR2NkJ3?=
 =?utf-8?B?SThyK2tCcU1UUVpLUGJYT2dOams1UDJ1QmFUUmVkTWFjVXZjYnRvTHE2U3ZR?=
 =?utf-8?B?b0VNQzRMZVU4SEFvanFTZ1NDZUgyM3BDZnllU05zanFiUzNxOS9zalhORVJO?=
 =?utf-8?B?bVZ2eTBUbkxXZlR4VGxFMGxXR2Z1V2hOQVJaVmVzTUpnT0dmd2U3YnVjbVgx?=
 =?utf-8?B?eU5PSmM5U1pTRFc0TmZpOWFydHAyeVhqQWFFN2JOUi9YVjByS3NZWXRIc2R6?=
 =?utf-8?B?MTNsUC9rSDdCblQ1ZUppU3FhUjl6NWNpUXk5c0hHN1NYZUlnaGtqL3NYMnBs?=
 =?utf-8?B?eENLQkI0cEhqNnYyRkhMOE8zVlBOREJCelY4TFhYcVNJcEpUUEM0VUNrQTFK?=
 =?utf-8?B?SjhHTHppL0U2NXFVVFAybWlSNW5paEk1eUhWME4xVVVockVNWVYzQkV4dnpM?=
 =?utf-8?Q?LjYh+0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2g1R210NDh6RFZaS3oxK0hSY1RYeDFJR0x4eUJsQ0lNTHVIZHV5eHVDbkxz?=
 =?utf-8?B?WnU3Ky8vRi9nYk9WdngzUGRrQVNzejZacjg1bXRadGlHc0NLYjMzOCtvemx6?=
 =?utf-8?B?eTdsRG5BeW5PWm00YXJ1RFpCUk1PRGVBUzhVYlhxQ0gxSkMvNUNQVXpnVzhp?=
 =?utf-8?B?NU9keXk3U0FyWklBVWRBdTRiZHhwZzhDSVFDd3lhUnZzSnV0WDlTZU1aMXhk?=
 =?utf-8?B?dnNTWmRqK0h3N2l0VlgycUZKR05FSWRNTXBQN0Nrek5QclZ6TjR5b1pDeXRm?=
 =?utf-8?B?M256M2gybmJzWkUvK0pONW55MHJ6ZmY4VzcvYVYrZTF2czRLa3RlMytFU2p6?=
 =?utf-8?B?c0NvK2RGQzNRQnhTZ1F5ZERUZVBZY0k0d2p3eEh5djRaSVdtcXowTStMRngy?=
 =?utf-8?B?N3VXQTN4a3ZHZDlTYUtSYjRpYlptandVYk0rQ2FvMjNQVVNtMTdNWDVKSkFv?=
 =?utf-8?B?Sk1wWHl5K1RkbVljZ0VLeWE2K1JyblJqcUJSOG9hbldSVGhPVEdtV0xueHk5?=
 =?utf-8?B?Tnd0QmRWdFI3dS81SWdmYWxmSWRMNExFYmJZcXlYRHM2ejBPNEdvT0VoRkIz?=
 =?utf-8?B?L1J2U0Zza0lnUUpydElhY3VaZUVmVzZnVnVHSWdZVERKSHB5eld4T1F4cnBE?=
 =?utf-8?B?YjNKUm56RGlFbHdYT3Yrd3ViSjBqVURIRHE3SkhTbFFpK2x5dGlWTjNPc1Iy?=
 =?utf-8?B?alV1RGk0MnlkWlVqeG5sRjRXQ1orUlc4Sy9DbXlhNXZuR1ZZYjE5NlZWZ2Rh?=
 =?utf-8?B?QURuQ243c2RpMGlqNTRaS3gxczYzakdGTkFVNHY0M0R0UkN2Z1h2aFpiTUpi?=
 =?utf-8?B?ZUxiMVlRVDlkK0tka1R2ZEY4VU55eFdCbGwrYVMyNlNOZUdqMHMvR0JscXB4?=
 =?utf-8?B?M3U0T3pZeWNQV1RYcFB5bjRmZXJsSWN5am01alJJTUFyaUtjNmlSTHloSmdC?=
 =?utf-8?B?LzBPZmZCeDRxejNZRU5WK3FlaFBkd2hNNWNFeVlwTHR2NytCbXZTMXBXbVpr?=
 =?utf-8?B?MnNtSzNQNDhFd0tTbVRnZVJVbUtKNGlaK3lrbklEbDNyRjVDSERPR3J5WnQ5?=
 =?utf-8?B?NFBvV0szL1VxK2t1aG15K3BjODA3c0NteVBwbHhCcTlObWNOUlF2QldaMm1Z?=
 =?utf-8?B?bnViakgzdkRBZ2hCaEUwVjZtM0ZiNmx4ajNySGhBVDd3WWFpTWJiVmphN3k5?=
 =?utf-8?B?bDNhMHVjQklwTnZ6VlVWRmVtUWd1SFVldllTZUdPYXU4M2hyV3RFMWlmUzgr?=
 =?utf-8?B?NDBEWFEvc0EyZDBuRjM2L0lLVzBiQnFuazdwbU1CVkY1SDlJa3BqQzZCbDd3?=
 =?utf-8?B?RXA4VnZhQjR6U0VvZ2M5bDhWbVBESS8xblk2U0QvOGc3OFZuTVNBTGJyR1VP?=
 =?utf-8?B?MjUwYmJtcDdWRWNSdm5LK0lFZHlvdUpodWZld0Jwa2s2cVlUR3M2N1ptdWti?=
 =?utf-8?B?SVBjaHJwd3dyenpZVXhWVi9IWUtSenZtcWlnTjFhYVgxWVJoMmRiMTRsRStD?=
 =?utf-8?B?blhpajlQYnQzRWJBUUVkUkFlTWVGTVRhU0dwTndEL3NKTHNST3IrRnRQVlFo?=
 =?utf-8?B?WnZGOUd6U1pWaWRZcGRrSVZGOWFBOFIyZ0hkYVVrRmppTVRXWW05SVlYRWs3?=
 =?utf-8?B?L3cySzk4N1pJMEJ0TVNtTFN1MkVXdDk5QXlHVzRvN0luZTFOTERzS0hWWThn?=
 =?utf-8?B?dGZRNktmUXR1MFNnV0ZuNUIySmNtc3dkdjNaTFFQVTZwT0UrejZreUFtYzFD?=
 =?utf-8?Q?zQEfzJZB8DNurNwmy6jr8ZzObsz7z5YnIM5wbFV?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561b5e34-77a7-44f6-c16d-08dd4aff00bd
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB2433.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 00:48:44.9285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPFB4730D036

Hello, Lee

I would request that this patch not be merged yet, because it is related 
to PCIe changes, and the PCIe changes (bindings and dts) have not been 
confirmed yet.

Although this patch is small and will not affect other builds, it is 
best to submit it together with the PCIe patch after it is confirmed.

Sorry for the trouble.

Best regards

Chen

On 2025/2/11 22:33, Lee Jones wrote:
> On Wed, 15 Jan 2025 15:07:14 +0800, Chen Wang wrote:
>> Document SOPHGO SG2042 compatible for PCIe control registers.
>> These registers are shared by PCIe controller nodes.
>>
>>
> Applied, thanks!
>
> [3/5] dt-bindings: mfd: syscon: Add sg2042 pcie ctrl compatible
>        commit: 28df3b1a6aeced4c77a70adc12b4d7b0b69e2ea6
>
> --
> Lee Jones [李琼斯]
>

