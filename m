Return-Path: <linux-pci+bounces-35970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07486B53F89
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 02:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A91D1CC21E1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 00:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239CA2030A;
	Fri, 12 Sep 2025 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rPJV8mCE"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010015.outbound.protection.outlook.com [52.103.68.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167482DC784;
	Fri, 12 Sep 2025 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757638376; cv=fail; b=KodGJaDzATKfAouequCbYf/7G5kvGXR8Hl1N3H8uzBM8BtFsusJgT2o7gk2vUFvnLm6YhHOyD+x2YFDLl66/19Q+Fb50iPYHzsiVxB0rIL99oZLYCqAUfbCEQ0eHp1HWHTx5XgqH3YoypvcNvjhwdqrlxGt34LnAsOiAQOnJ44U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757638376; c=relaxed/simple;
	bh=nzsP0OSZDHDGmxiDK6uIiriqY9nm/mFSXeCC6LQNeiM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RtiGTEYafFhmygxWidxMceVLlUC6WXHx5x0HP2iLHAQCMqAQXCPF5QROMNBXI1KdKDcoaIRbacH06GsTgzfI/SEwuyAnMGdcaV1TPpJ9h3Y9Zv988Nja1oxAhNIO4LkjESDWrKbpZnKkgxfAHcZoid7hcq/cDwbNRpzvEy9I7Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rPJV8mCE; arc=fail smtp.client-ip=52.103.68.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwnSYYF1GV+yDEhaDOU5fh+gUmFFWD0ppMHgwou7wLSs9CxNxvrUgS4gzU7B5Zxw01K38d/550eHvQ82jjE5pt+6Whkkun6I/gZhFHWJIqkBy+v7dfiC/8U4G2fcmowbIlJC8i1s7lnVKHghciage405zAz3lG1Pf3yzVuuPpi+hVsWv1PlXAuI26qff8vM0wU7U2ddJThhbZakoTOdXSL9/MqM+EKQwJMhqGjORE1MWmKVXs/IH16IpaD4Z4EMvo4bt2ec4GtfYqOYJcLpMsOl7F+eF4x/DyR+f4kX9m0jI1jdA4pPrWFQ8Gp/iRWkth6ng03GYk0lLr+rUptGDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PZiunQQhYoddhB7VtpKOQHxcmiwCRo05CXFAsw3IuA=;
 b=PJPE03jvoLbhlDEIq3pb2gGIZjy/hS+pi56o9JLkwO8b53E0TJfLguyZk8axLQ0mHhUmTmSCX7XfYubYvgxvYRl1VSQ2AqmI7bjuqLFDzwiEm9q0PvpWoMwDd7otKgxDRBLJG0bvFEduphfXyCRYyyJL4R0JGCOp5FG0bmDy5wF/absLNrBkZM49xHRvHAVKq9ouEKr9e7cGOz7/T/QE33PBEwGFWMbYl7BM3pSGe7LsFvwOba1l0OZLIAFM3ca/uYYv5v+ZJs7UHW5/Czckzw7kTvBNMXgBt4/mcSw1rMyFaqm8UTRtv6jNtgC4sg4Ujl1FbyPHABeGHbkyDMQZDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PZiunQQhYoddhB7VtpKOQHxcmiwCRo05CXFAsw3IuA=;
 b=rPJV8mCEyq+NGh3TbvPTjkrfTjSkHxIHMpC3I+Gi5vF0usYgB9X292RyK8PtJif1eQ2448bUHDjl/nKSwenc0P9WTjCWUReg6pAyQ54FQf/X9TYgzdZxcYX69+cFX5xCTGPcoQcEt9P7Rmj9K66g+dFc+etC6cdIMqz8b4mM8NkwFC5tEkvJipj4vFPVcN28UXndXKcjWwluSOLgQVrlLKPXSCYDD+F+TLC0T3PRI0fugEW0CK1tT2A2f8nHjk4aL6hK+juFgtT5jqQVltCjpfoYiGSmk/5gQdogsBCj8JycSLBY0d8VJMsIVjspGRqH+VD23D9AM6mTffF2p60QxA==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by PN4PR01MB11915.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2da::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 00:52:40 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 00:52:39 +0000
Message-ID:
 <MAUPR01MB1107222DD9BBA9349C3907E21FE08A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 12 Sep 2025 08:52:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] PCI: sg2042: Add Sophgo SG2042 PCIe driver
To: Mingcong Bai <jeffbai@aosc.io>, Chen Wang <unicornxw@gmail.com>,
 kwilczynski@kernel.org, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, arnd@arndb.de, bwawrzyn@cisco.com, bhelgaas@google.com,
 conor+dt@kernel.org, 18255117159@163.com, inochiama@gmail.com,
 kishon@kernel.org, krzk+dt@kernel.org, lpieralisi@kernel.org,
 mani@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 robh@kernel.org, s-vadapalli@ti.com, tglx@linutronix.de,
 thomas.richard@bootlin.com, sycamoremoon376@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, rabenda.cn@gmail.com, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <cover.1757467895.git.unicorn_wang@outlook.com>
 <162d064228261ccd0bf9313a20288e510912effd.1757467895.git.unicorn_wang@outlook.com>
 <35447ba0-21c2-4a12-9d27-033a7be0af3e@aosc.io>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <35447ba0-21c2-4a12-9d27-033a7be0af3e@aosc.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0019.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::6) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <d6f1156d-a438-49ff-a287-6bc029f588f5@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|PN4PR01MB11915:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd1babf-94f7-4190-848f-08ddf196abff
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|23021999003|8060799015|19110799012|461199028|5072599009|6090799003|52005399003|41105399003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2F0bk04M3dremZ2M1czdEpMLy9Kakg4WXBNVURDbWlhbVh3N0ViWE8vWmdx?=
 =?utf-8?B?aGMxYXB0RU5lTTFYMUUrZkx3QjQzUVJLS1VPN2ZaSFVrS2F6VDB5cGJibmhQ?=
 =?utf-8?B?aThnWlhIREZBWWZSck5iSE9QdmNnTEVFUm1BenE5OXdHR2JVbDR3eTdwQm0r?=
 =?utf-8?B?eXluMkExK0tSSzFvNWlqSHZVNW9nVzhpU0JOU3dEVFVFc01zdUJzLzRwYW5z?=
 =?utf-8?B?MFQvMHF1MDdaU0dvbWZKamF5K1c4Mk9MNFNMNWdzbUZoTDd2b1RuNjJvWi84?=
 =?utf-8?B?b1VVQ3BtMmlSVC80Z1J4V2ZyQ3JQbStwQ1dYUXhsTTZ4dGNLSkU1RVJNWVcy?=
 =?utf-8?B?L1VBamNEZERvL1F5M0tpclVub2NVbWJURVlEUGxXV2pqWFY0VUxhSlpab21r?=
 =?utf-8?B?NjB2VEd1UGVwVjdwbEpDMU5Fd2M5eFd4d0wra0t5Ykc3SXYwNHAvVHIrdG13?=
 =?utf-8?B?ZVpSNWpsczFuMDFUcWRFalEvaHFiYkovdlVlNjBGQUtUMHFRM0xHVENaMzBN?=
 =?utf-8?B?QWhFanhYOUVGa3hnRmVLZ0d1ci9SajJaR25iSW9zei9zTDhDT21SK29VUWda?=
 =?utf-8?B?UWI2UVg4eTgxQ1JPbTJQdHdwQWplOW5pOWpLRkZwN1JvbkZJclBZN1EvcUZn?=
 =?utf-8?B?VmR2d1BuT1ZDV2pKR0ZCT3dveHJtUzVrWmlNM3k3UWQ0TldBblZOZXdzZy83?=
 =?utf-8?B?K0MzUEpTSzhZWFFVS1FNVGhQOWhoU05GSTRtR1orWUtsTm04WGpYMGFFamlp?=
 =?utf-8?B?YWVPWVQrSE1ndzNCQ1NmeTZHMGJqN3pBVCs5c2xGUkdxRVJWVDZvazZxeExX?=
 =?utf-8?B?OWU1cWhXYTVDWHJTSkFIUXF2ZnZ6ODBERS9mZGlvV0J2Q0ZZK0dnajA0Umh2?=
 =?utf-8?B?Q2k0ZUtrSVEzK0VZMkgvTFdyZzhwS0IzdFBrN1dNckdSMWdNRG5LZjdrd1du?=
 =?utf-8?B?VUkwV2dKL0tMY1JyYXNZZGJ3UUxWLzhBK2MvT0JVcHNESDczWjJ1Ym9aUU9S?=
 =?utf-8?B?YmF5NXBGRHBLbjBKTW1GN2htbmpFUHJtM0s3YUlQQ05zbkF6VEVyQ0dSOWxM?=
 =?utf-8?B?NENmOUxqeTFqQW9CVHB3YlFLM1pMdW02T2hSYnN4YmZIUEVydTVUNy9nd3Bq?=
 =?utf-8?B?R1BKWVR4WUt2enJYRDF1Q1lTQTBnWW5Na3cwZnYyRGtWMi9mNG5CTFRaU0p6?=
 =?utf-8?B?REZMSEN4ZEVDYnFxeFEyOGRTRDdMeENGNmZOVnR3VG9jOS9LODB2d0REVmtU?=
 =?utf-8?B?M05MYkxOa1hVeFNKOU1STVlJTkRxOS9qRE9ZenlYQXBHbHhOTWpUUGY3ZHFF?=
 =?utf-8?B?OG96b05semRQbjZTb3JvdDNjTmhSQWRLemRkOEh0a040eUs2NUtqK2N2SjNV?=
 =?utf-8?B?QS9YMkJTNkNOdXhYdk9NdVFzVDIzT0JjSlFlbG5mYWl3elBmZnYrVWxHbFpM?=
 =?utf-8?B?U2lRUlV3OFRDM0hTVVRuVTg3TFhESU8vRE9rdG9YRzNwR240S2wwazg4dDZy?=
 =?utf-8?B?djhaanE0TDhUUEtUclpRM0RHTFgxdWpwMXIwMXRzcDk1V1lkS1JKZTJMRG1h?=
 =?utf-8?B?T25nS1R5RzZxNG5YclBSSlN0a2V0TDdkSGE3c3Fmc3F5RnNBZEovcTNWZHdH?=
 =?utf-8?Q?OljsJPB4n2IUWfWLXV2xV3eW6aL21q3aEzM08PXmg43w=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkdaTFlqbEFyQlNKUWg0VlE5Szg2ZUsyNklxRmtWcnpVbGtCTkNYSGg1c2d4?=
 =?utf-8?B?TWkvVXYzQ2VaWTJhV3psYlJqYlBPZnViMHY3SG9PM1J5MlJxMmIzK05zMlBH?=
 =?utf-8?B?SGJTYVpxL09TOGFqalV5cmgvS0V6cEFzTVNyV2paYzIzQmFkSlFVdGd1aXhR?=
 =?utf-8?B?ZjduRW9EQkRZSTd1YzRFSFZHdHJmZ1ZRZVZnY0ozdHFhTEp6dENOV2VnUE5P?=
 =?utf-8?B?UjVXQjE0RmV4QXh5dXMzbTZnZ3J3eHlrWFRQYWxReVJiWnpNOWtXTS9lNEo1?=
 =?utf-8?B?N1ZqUDRkTlZlZTFqVUI2eU9pQWs5QXZlQmVRYUMwbkFtb2xCbXg1RGlnVkds?=
 =?utf-8?B?RWVTWHM4UFZFaTluT1Q4b3FybUdkSFMzS3FLWGFWYThFT2d6T2M5emtIWFcw?=
 =?utf-8?B?K0M2MXdOZ0t0eklJLy95RzNIZkZsQnZHdXJJS1cyS1ZSSXM0dURnTDRCdTFv?=
 =?utf-8?B?MHFnV0N0ZXh0NmdkbStCSW45eGV1a2IwSlFGRkl0emlpNjVXbzdaaTBLbERB?=
 =?utf-8?B?WG83cGRXWlpaNTJsYWd6RTJTcG4xeGZYai9tVjBWcnBKWVZUYzNDRWdPWHlK?=
 =?utf-8?B?aEhkaHRiZndlYjArM2xMTDFQQ1FGZEY3WTM0Z0s3OVJxQ3FSOTlqZ0xqYW5m?=
 =?utf-8?B?V0lIQUJtK2pYNHlsa1ZXY2lCQ1kyTjBMa244YmROSmNqNTBNdHpkWEhidmdm?=
 =?utf-8?B?SnBnT3dSSDY2aUtDR3RSRmRyNXJqQm5ZWWdUSEpWeldKWFZFcUwydFl4cE5M?=
 =?utf-8?B?ZDBvRXh5M3EzYzEyYXBwZHRCWTYyM0tyV1V3Y2pGL0lEeGdTaUdyZ0VPU0VP?=
 =?utf-8?B?OGY3MlFaeDV0U0d6VTV5TjhBZWJPcS84d0F2NHhGK2l6RmJQMzRiTitCRXRJ?=
 =?utf-8?B?dGFrcjRrWDBVTGc1NlRvOSthNURoUTVxOCtRMkVQRzl4YjB6bEZCbG9mcGtK?=
 =?utf-8?B?eTYyVjRRZVFBQXBFZTh6dkhjZUdOUUtId1psU0JoTWs2OWRKNExDQ3I5TnpP?=
 =?utf-8?B?UUNyUUVOTzFJN0Q4R2lHWkVyRFRaZjNhUy9kL1BsYW41T3F2QTh4N2p3YmRP?=
 =?utf-8?B?T3pLdVJCRXF6YW9OUWhxUDJqRDRjQll5NFZPMDMzNzFKNHlRbUpxeGg4dWQy?=
 =?utf-8?B?MWFmR21KN3BndlhEMXdKR0dFQXB6TWUxRHV2R0NFQkpuR2VYWVJpVVgxemNS?=
 =?utf-8?B?RmVRd2ZYUEgybEluL0VteGRDQ1dhUUJwZXJUdjRmSDdCd3ZhT1RSUDhkS1c5?=
 =?utf-8?B?VDV1eWNrdVg3eURpQlNyUldKdVNDUDdhYkRFTkEydDRvMHVESW9ya2dKNlBq?=
 =?utf-8?B?YUdEbytScENJbGk1eW9JRXN2TjRMeWdWUXhCNnh0Qi92N1hNSjk0WkVSb2tL?=
 =?utf-8?B?Z213dFptQTY3OEF6MXdJWkJMdnNERDdvdXFPYUxOcTlGb1NNbGRJc1NSKzlX?=
 =?utf-8?B?MWpQWVc0dzE5RkpFR1hGakNYV1BXNy8zNmhSbU1lckp0MkkwNFUwVjV3aGtW?=
 =?utf-8?B?emEzazBFMWpUT051TkVlcVM2MWFBcjhndG44SEZVTlEvZUdFczM3Q2lkbEQ1?=
 =?utf-8?B?R1NNNGRReVYzV2k1dUhJcHYrTnExcDFLc3A3Wk9jdDFnaFhJMDEwUXdWUWF3?=
 =?utf-8?B?dy9kelZKNDFHcVo3TGlDTmRRVCtDWEc3UmkwQmdLSUtsT1NrSGRwMW44QnZZ?=
 =?utf-8?B?Sk9ZM1ZpYlBteE5BbTRVTWpuREZ3LzR3ZUNoWDlnWFQ4K2JwekVHeCtiTXVH?=
 =?utf-8?Q?FyMM4SNaoTSakLacudaZeF6xF9rzrvDuDlUAtWM?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd1babf-94f7-4190-848f-08ddf196abff
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 00:52:39.6040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN4PR01MB11915


On 9/12/2025 12:17 AM, Mingcong Bai wrote:
> Hi Chen,
>
> 在 2025/9/10 10:08, Chen Wang 写道:
>> +config PCIE_SG2042_HOST
>> +    tristate "Sophgo SG2042 PCIe controller (host mode)"
>> +    depends on OF && (ARCH_SOPHGO || COMPILE_TEST)
>> +    select PCIE_CADENCE_HOST
>> +    help
>> +      Say Y here if you want to support the Sophgo SG2042 PCIe platform
>> +      controller in host mode. Sophgo SG2042 PCIe controller uses 
>> Cadence
>> +      PCIe core.
>> +
>
> While build testing this patch against v6.16.6, PCIE_SG2042_HOST is 
> set to "M", the kernel would fail to build during MODPOST:
>
> ERROR: modpost: "cdns_pcie_pm_ops" 
> [drivers/pci/controller/cadence/pcie-sg2042.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> make[1]: *** [[...]/linux-6.16.6/Makefile:1953: modpost] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
>
My fault, seems there were some problems when I submitted the driver 
code. I will correct them immediately and submit a new version.

Thanks,

Chen


> Best Regards,
> Mingcong Bai

