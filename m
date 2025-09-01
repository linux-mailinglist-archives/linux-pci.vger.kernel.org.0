Return-Path: <linux-pci+bounces-35235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A497B3D96B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 08:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB23F3BECBA
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 06:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F630212556;
	Mon,  1 Sep 2025 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uFKhJEHz"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010007.outbound.protection.outlook.com [52.103.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8D0A921;
	Mon,  1 Sep 2025 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706450; cv=fail; b=HiPLU0r0xzbAb/Clw68T1+KLakBHmufzX7r2kdB7F7Mum86vvXBHqPR8ukvZBYg6fFwSOxcdzAFcbirp2Uk0krx8nop0CxzfHil/2yE3uy5XrPtxz9qLLvjiJVcV6p0XE+BM0iyZOObvG5ei0VlTMNl03o6ZWj/+8TXbolsrn6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706450; c=relaxed/simple;
	bh=ZaT5x76CwmoBAZnXRGXF8BEoPD0znXtXUXZVevRx1lI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B/OMn5zBApofuntueFwe1sDdkRFa/lnKe7PYL1lfoiG2OPVYfcPbjDLX8ngCka9VEwSJdYSBTn/9ORlho2crkJ06UVZnpX4XMzlThd3I7oYxpXnIVbOgWS4BeGu9qGzZdIC9dbIP0TXGmfliTC5LPbnrOEHPyFWDpQH1hDClABE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uFKhJEHz; arc=fail smtp.client-ip=52.103.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnZVyyttCdQmaJVG/jLBgdsb6/U+H96vmUCbUmBBun/iLJ1YMJwSRDIGIfmCLjn0u6XUcE6Sd1lRVv/5697jCFNEqEEg0g6nTXLnaPD1anuaU2ouo6KCmlYVMCNbP4SC9KAM464b9lO65gyX7zD0ejBlh08sgCtpmoTTFIKCHA9SoCUFP5PL1oFB1YCoCl6Cr9bJGlypF+oOq63xEkZc5A57/dq5dD1/WLIhOy6IcnZcWfQmoeMmLR35r1EfmvhP9R+tpSt/u/8lqE1dBqodQBVqGUIaOHZgDfZ1A5uBL356xypvyO33btVEkupk01MYqyHYcnXYTQvOQl8Tj7ifQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hv+w2nqZ4LJJIA0JDUEAk+MrlrDBnbAzrM7LzkMym/Y=;
 b=dzrYvJFMf0NcOPgDjhWKL4CFNU6YJ7MHhe3S3Dz2N8i+Cr3AF8gqzMZ8+BztMWqAjoU1ga0SZOcgno8hns2q1iqxTNm9Abk3/JGOEGWy3OO6ziSYot5gDyZaQfKfWNYlk4Dy8tNbsuOMkpzkD17BKtI9ub8GVnJ9gssqCf1E2graFZ29BqfIue7QD0hIcMSLdZPBZx1EMGtFOcejEy59QfRULkWHmmbk7AVzMPHIGw/54HcKFoATUuIX4CGMgJBrgTq5taqXHvdpUur0Aa+GjUhSfVMGdMwefUFMOsMoCr4tirbmovj60Ij9PBmDRjEhXlkxMq+gBBacK5RfCsb2bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hv+w2nqZ4LJJIA0JDUEAk+MrlrDBnbAzrM7LzkMym/Y=;
 b=uFKhJEHzkSqkg2F+0FqYMo1Lg5DQ1TfQwzXX0gwKcop42TrQZXdFt/EdhPa+fCgMvNwf2sLV/YdYcs11GtA09xjomCemiHeWKFdc5qrF2H63MjXnWman8JQiqRJ4JDksrvCRnz02Tom4Tt2mlMeb343nOwrAbdS2bFeUtCnuOdi0Qj1IwVNmCAyRgF2+GiWPoeDNOnaGZCqVTxemdV6Lon65k+FVn01bR3qDKBp6r8bljUR+QS8R9VvQfBn7j6lFSERgGsbyBcKTFp/tta5yDYwz5EdMuCNdn9iLE1newYxhCgx2B5N5I1TP3/XS5TSmAfjel/0LqIElTPecwMNMuQ==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by PNZPR01MB4480.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:19::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 06:00:35 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 06:00:35 +0000
Message-ID:
 <MAUPR01MB110724916F72E34B35E9E6361FE07A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 1 Sep 2025 14:00:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
To: Manivannan Sadhasivam <mani@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: kwilczynski@kernel.org, u.kleine-koenig@baylibre.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, arnd@arndb.de, bwawrzyn@cisco.com,
 bhelgaas@google.com, conor+dt@kernel.org, 18255117159@163.com,
 inochiama@gmail.com, kishon@kernel.org, krzk+dt@kernel.org,
 lpieralisi@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 robh@kernel.org, s-vadapalli@ti.com, tglx@linutronix.de,
 thomas.richard@bootlin.com, sycamoremoon376@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, rabenda.cn@gmail.com, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <cover.1756344464.git.unicorn_wang@outlook.com>
 <1df25b33f0ea90a81c34c18cadedd38526a30f01.1756344464.git.unicorn_wang@outlook.com>
 <xfu33ans5jaivwcadv6pjontvu5b4n42jjjtvqiqfhqxieoimg@2yaz75zsj7vf>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <xfu33ans5jaivwcadv6pjontvu5b4n42jjjtvqiqfhqxieoimg@2yaz75zsj7vf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <5536c75d-79b0-4510-93ae-2fb8b4eb2822@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|PNZPR01MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed304a2-86f1-45b2-8fe4-08dde91cde0e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|41001999006|19110799012|6090799003|15080799012|23021999003|5072599009|461199028|52005399003|41105399003|440099028|40105399003|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG1Ua01yMndHcWEzNVNrQUdLZGQzZVZKTUx3bzgrcEZBWUlITTZZOTNmSEFk?=
 =?utf-8?B?RmRvcDJMN3V6akcvRkZtNU5tMytWblV2R2t6Qll0d2I3TkV5bEhDNkdwVUFX?=
 =?utf-8?B?ZVhGS2hXNFlqcS82M2RGTkRFbGtwaVZpc0N2R2RsR2FjZ3E4RnZiRkJKR0hC?=
 =?utf-8?B?bXJLbXJWUWlrL2JHakFCbHQ1bFZHSGJ6eWxiVHNBU294d2M1Y3FpZHZySmRQ?=
 =?utf-8?B?b25DM3d6amtNM2RKWjZ3NzZBUjg1UWJmS2RaellES2R4VGE4THp1T0pBbFpm?=
 =?utf-8?B?WGtiZzBXamxnODNtK2czek9MRmpTeWtoaHJXOVJNN1BRcWZjN2xqd3ZCakIr?=
 =?utf-8?B?b2FzMkQzUUpNbkFWT21pcEtBQVJ4MlpsbFkwQ1dOYzc4WUhsVkEreUV3WVln?=
 =?utf-8?B?SzhNbFhTNmEyTVRjQ2pSK0Z6ZTBmRHBQUVFmMlZBa0k3Uk9rdkJjdnYraHFH?=
 =?utf-8?B?cEcvYlp1RWp3amRpMlNLTUlYOTNaR0xrcnFKWVU3aGhRdEpqOFpEdnNCRXk1?=
 =?utf-8?B?cENrNVdnalNOWFVNbS9hMTd5Vm96UlRBbDlEK3czNU1wQUlkVHBBQmd1V1E4?=
 =?utf-8?B?bGV4MVFyODI2S3UrckVrbVAwZjd2Wi8vRmQxeUk0OWJReTRPbkJ0UXR4azdm?=
 =?utf-8?B?ZStLUWIyekhOUnJ0VEsraVV1aXRpbm5EemM4RWNJNFJQQW1HNU44U1c2MUg2?=
 =?utf-8?B?ZWNUMzhRMUM1VUNlZWNsekp4Ykp4VjVXWkJGQmpvZXNQSkN1aWNpdFRiRlp4?=
 =?utf-8?B?MlNSc3RaLy9WcmdDMHcvM3FjQ056TTVlTHFla2xmaXljRCtvbEQrYjNzYUt5?=
 =?utf-8?B?eUV2bnhMNXdIaDZ6VXdHQXp0RkdGcURpeVBPTjkzM0Q0U0VQQmNNU0JESi8y?=
 =?utf-8?B?aFFIZGJhdUlSZDVxR1Z3eHk0UDA3Z2dsWm9UNmYxbk1MTU9mNWlVcmdRMmJi?=
 =?utf-8?B?NHNDQTZTVkZmRFM1T0xFOVozdjRmVnR0U2FhNTZqRjJxeTZTUlNrZ05OZytQ?=
 =?utf-8?B?d2Z1S2krU3lFR3VNV3l0em9HcXFnTVc0dHZURTlvUjVFUkdWTFhMTUpwQ21X?=
 =?utf-8?B?VFhxd21uVVRRYytrK0NHRWFhRjNnY05CV1ZtTFlJejgxYkRuOHNoOGE1N0g2?=
 =?utf-8?B?SitYK25xWmlCTzBOUWw5ZjJkUlBOZld4UU43ZG9vVDIzK2JMMHlYTEVjYUs2?=
 =?utf-8?B?SnF2NXBoc2RaMnJSZkxuRGc3TUJnd0cvTzFXTnNUclhFaDFDbWhpaEZWd2hh?=
 =?utf-8?B?ZVZMOVJJa1NpTXROaC9OV3FTejF2TUEvVUg4Y3poSE9LVUFKVTVYT1NZSHhk?=
 =?utf-8?B?eEU0dUV3c3lCL3d1NkhpZThnbGNuT1Q2QzhvRWs1aC9pcnVnSkVlcmMxcFpQ?=
 =?utf-8?B?U2cxMnNBay9JajVKS3hEb3VBcXpIdStxalZDS3UveXJ0R1RTcmlYRFZsS0ZX?=
 =?utf-8?B?M2F2ekxXSHNDQXZlaGxaK3lCVU03Nmc5a212YkI4NjUxZjZIeDZzTXdlNGNj?=
 =?utf-8?B?YXFOV3M2ckxKVUQwUmlvc3BBL1dqSGdSMElKUEpkV1daUEZXZ2JsOUhSd2pT?=
 =?utf-8?B?ekhvbEdRSmVySDJqcGJHa2VETGhjWkRIbzRwWHFKeVA3SE15KzNRbStDM2FF?=
 =?utf-8?B?TUhxQ1l3UXZ3RGdrL3hTaWdITzFwbTJKKy95UVBGOW1Mcytsb2Qxa2hzaGkv?=
 =?utf-8?B?a3NqRUE1dmxmbnRMRjVqWlVRMm9ZbTQyZDU1ZUxwdSs0dEJoMVVnak13PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXl5aE8zeWk0NndYdEcrME1qVlNNR3B4RWRZK2p5ak5HeXJtRmhjUVRCK0Z6?=
 =?utf-8?B?RWtMU3EvbkFGNXk1NkU1TCtrbm1HbFJYQm51UmZPTnIvWkR1eEl4RFRHR1E5?=
 =?utf-8?B?T3c3TG5CM0FJenhPTzVMMHpJVkQzdDV1dnhCSUl4N0d4OXk3cENkK281UG5F?=
 =?utf-8?B?YlppV3paMEVoV3JMWjYvMTJNd0RqU25hSmgrQ1ZxSDF3NGdUdGJadHlQVmk5?=
 =?utf-8?B?aVdKUGNNK3lLWFZ4WFJLUGtrbndXRHJtTW9FZXFldkJOeGQveTdrN0xld2ZN?=
 =?utf-8?B?OUk2NEQ4YlZEeml3N0pOcDdpaTIrRjRMZHdaRDFrdlkyRU92OHlnbnpMK0dM?=
 =?utf-8?B?MnFoMU1RSWRYQnI2dGRjYmQydnlUVnV3c2FhOVowMFM3UUtGKzVuQ0x3ZXAy?=
 =?utf-8?B?RXRkcHdNUjBzN0NCN09tSHBkRjE0YXhkeXNGODdPMWg3azJDdU9iS2tJaDkw?=
 =?utf-8?B?YkJRZzYrMkZOMS9XalZtNTlSYU1CTXBOQTFRNFVWTDZZRTV4RHFrK1pSbjZz?=
 =?utf-8?B?Zmt2bkhGeGdScXFTTGl0ZVlGRndaeHRCSFRnRm41SlAyd3RxOHR0L1Q2QmVz?=
 =?utf-8?B?dmZheHNBTFlPVzRXQnhzK2tZTDJXV3FHQ2M1cDd2d3RhSFp1R01QTnREQmpo?=
 =?utf-8?B?YnZiZTBiRWJ2bTRvcFAwVHlzYmZsMVdreVVScllZMVlKc3FDdktCU3h5R254?=
 =?utf-8?B?aVJIZFVrdUxSaDVWK2psVnFTWEg2WWdLbGxrTUt4clFZb1cvY1ZDbnExOUhx?=
 =?utf-8?B?RjhqOGxNMGJ2YTZHNDV2WkdrVUNhMVM1RXZuNncrUVBUT05mWWhRVzBRMHNw?=
 =?utf-8?B?SWRRdGdFalZmenF3dnE5Zmc4dFVUcStQUGR0S1JlTGpLa3FEWHZLR21QSVp6?=
 =?utf-8?B?THNqOXVHNFJiZHExNXBidHhmajd6VmxUK3R5TThBRzlqSms4ZzJYbkJMYlNN?=
 =?utf-8?B?Sm5JUU9aQ2QrUjB4RmNmM2sydnRxNHRxeVoycG8vRTBoNHJtcHhXcXNKMWFK?=
 =?utf-8?B?RkNuMXVzT1hnNzc3dW9HbEFZamF4aFVwSS84bXI1Zml3QnltZHRIQlFzNm5H?=
 =?utf-8?B?Tlh1cXhVSThneGlxYjQzUytuWTNhV3lGT2R3SFBUZFZSK1hZRkQrRXdJWmM2?=
 =?utf-8?B?cHJzOFROZHE5dDFna05LQzQyV2xjakRJZmZLbzBpK3JlQzkwbHhZL0RVY0Q1?=
 =?utf-8?B?T1hReEU4Q3I4Q1dWWDZwWUs5cU5ROGVqdVVkaW14Z0FkQ2REU003dllJa2d4?=
 =?utf-8?B?UGw5NnZjK1g3SWtSbEtHY1BKdUk3OEhIRC9PQzJIeGJHRTZoQU9PTVN6U2tP?=
 =?utf-8?B?MTB6cmo4NGlwQVlhcWREZk8rNWVzTno1Z2VDS2NsWTh2cktnckZ6Vk1mbThu?=
 =?utf-8?B?RjhuZ21iTWlidkVXZXdFSGJzR1gxUlp1U2Y5ZkF1Y1dqQzllc0pJdmpla0h5?=
 =?utf-8?B?dXZIOHo0OHlldnZCdU1icVlaYlJTcEI2dDVSWSt5bkRCazJQSFVFR0xsdmZw?=
 =?utf-8?B?ejVyaWRjbVBYVnNsdE9YOHlxMWpQUU5CZVlUOFNwUHFKWkRqUHY3M29MWWI1?=
 =?utf-8?B?R3NOVmxqWUZjRDB4aitkcTQvdTZxQ2RXWkRKcVh4MUdoMzlKYnRBZUdJcXJM?=
 =?utf-8?B?L1F5SGEwQktsT0xZV0dIOE02TUlGeXBKNkNEOWE2K0xycG9tSTNvcDNsM2di?=
 =?utf-8?B?N0UzRHZaekNRZzNDc2p3cWxCbVl2d2J0Tm9mVnhWWFd3K0JmREVJTjVtRlcz?=
 =?utf-8?Q?0SyzCYUJeI4xqJwvjkiimzjuvDtrN1iS1abUbDy?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed304a2-86f1-45b2-8fe4-08dde91cde0e
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 06:00:35.5151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4480


On 8/31/2025 12:45 PM, Manivannan Sadhasivam wrote:
> On Thu, Aug 28, 2025 at 10:17:40AM GMT, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add support for PCIe controller in SG2042 SoC. The controller
>> uses the Cadence PCIe core programmed by pcie-cadence*.c. The
>> PCIe controller will work in host mode only.
>>
> Supported data rate, lanes etc...
OK, I will add these descriptions in next revision.
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   drivers/pci/controller/cadence/Kconfig       |  12 ++
>>   drivers/pci/controller/cadence/Makefile      |   1 +
>>   drivers/pci/controller/cadence/pcie-sg2042.c | 134 +++++++++++++++++++
>>   3 files changed, 147 insertions(+)
>>   create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c
>>
>> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
>> index 666e16b6367f..b1f1941d5208 100644
>> --- a/drivers/pci/controller/cadence/Kconfig
>> +++ b/drivers/pci/controller/cadence/Kconfig
>> @@ -42,6 +42,17 @@ config PCIE_CADENCE_PLAT_EP
>>   	  endpoint mode. This PCIe controller may be embedded into many
>>   	  different vendors SoCs.
>>   
>> +config PCIE_SG2042
> PCIE_SG2042_HOST
ok
>
>> +	bool "Sophgo SG2042 PCIe controller (host mode)"
> Since this driver doesn't implement irqchip, you should make it tristate and as
> a module.
Yes, I will implement it as a module.
>
>> +	depends on ARCH_SOPHGO || COMPILE_TEST
>> +	depends on OF
> 	depends on OF && (ARCH_SOPHGO || COMPILE_TEST)

OK

[......]

>> +
>> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
>> +	if (!bridge) {
>> +		dev_err(dev, "Failed to alloc host bridge!\n");
> Use dev_err_probe() here and below.
OK
>> +		return -ENOMEM;
>> +	}
>> +
>> +	bridge->ops = &sg2042_pcie_host_ops;
>> +
>> +	rc = pci_host_bridge_priv(bridge);
>> +	pcie = &rc->pcie;
> You are setting drvdata only below.

Sorry, I don't understand your question here. I guess you are confused 
about the statement `platform_set_drvdata(pdev, pcie);`. Let me explain 
why we need to do like this.

Originally, I defined a drvdata stucture:

struct sg2042_pcie {
     struct cdns_pcie    *cdns_pcie;

     // other properties
};

But after code cleanup, I find there is only "cdns_pcie" left, so I 
remove the `struct sg2042_pcie` and directy set `cdns_pcie` (in new 
version, it is renamed to pcie) as drvdata.

>> +	pcie->dev = dev;
>> +
>> +	platform_set_drvdata(pdev, pcie);
>> +
>> +	pm_runtime_enable(dev);
>> +
>> +	ret = pm_runtime_get_sync(dev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "pm_runtime_get_sync failed\n");
>> +		goto err_get_sync;
>> +	}
>> +
> Why do you need pm_runtime_get_sync()? DT binding doesn't provide a
> power-domain, so you just need:
>
> 	pm_runtime_set_active()
>          pm_runtime_no_callbacks()
>          devm_pm_runtime_enable()
OK, I will improve this.
>> +	ret = cdns_pcie_init_phy(dev, pcie);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to init phy!\n");
>> +		goto err_get_sync;
>> +	}
>> +
>> +	ret = cdns_pcie_host_setup(rc);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to setup host!\n");
>> +		goto err_host_setup;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_host_setup:
>> +	cdns_pcie_disable_phy(pcie);
>> +
>> +err_get_sync:
>> +	pm_runtime_put(dev);
>> +	pm_runtime_disable(dev);
>> +
>> +	return ret;
>> +}
>> +
>> +static void sg2042_pcie_shutdown(struct platform_device *pdev)
>> +{
>> +	struct cdns_pcie *pcie = platform_get_drvdata(pdev);
>> +	struct device *dev = &pdev->dev;
>> +
>> +	cdns_pcie_disable_phy(pcie);
>> +
>> +	pm_runtime_put(dev);
>> +	pm_runtime_disable(dev);
> You don't need these as per my above suggestion.
OK.
>> +}
>> +
>> +static const struct of_device_id sg2042_pcie_of_match[] = {
>> +	{ .compatible = "sophgo,sg2042-pcie-host" },
>> +	{},
>> +};
>> +
>> +static struct platform_driver sg2042_pcie_driver = {
>> +	.driver = {
>> +		.name		= "sg2042-pcie",
>> +		.of_match_table	= sg2042_pcie_of_match,
>> +		.pm		= &cdns_pcie_pm_ops,
>> +	},
>> +	.probe		= sg2042_pcie_probe,
> Why no remove()?

OK, I will replace shutdown with remove when I implement it as a module 
in next revision.

Thanks,

Chen

>
> - Mani
>

