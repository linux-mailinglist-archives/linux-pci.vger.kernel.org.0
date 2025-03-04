Return-Path: <linux-pci+bounces-22924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F56A4F1DA
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 00:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24135188CECC
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 23:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA2F264FBD;
	Tue,  4 Mar 2025 23:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rNxM9CJv"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010000.outbound.protection.outlook.com [52.103.67.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365EABA2D;
	Tue,  4 Mar 2025 23:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132652; cv=fail; b=Ie/iiZFqthG8HpVUR/8U/5NMgKSL86pGLN8P3Y/n2YQxDHgHMqJElf8MD9iY6weJXIz0q/F3NhSo6LbRcQeh1SAgC9Ahy32Fu3LtNB9faTdbdtHA59GVgvzLN8iM+gHk7JMuIKEIHorj4XqOZclzF3mplBhefoMP4QgEI9SvhR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132652; c=relaxed/simple;
	bh=eumwEzCyd1JFhemT+jfRO/IybLYYPZroJuWj2+B1xc8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qe/6QuvMGilN2lSby5vagwue8v3Bj3bWR70vayPswdG42uye1/Gi9RRR7IZVUygheOcoHR4AoBnnRrvhjaj3DM3aYlzR/YAy5rimSi0NxlNamF9CNsLws0cnyFkITVoCQ1IRy7hH/xFNGSc3HCD2xaoSzzKxh6yfq7Gv8Ozt+gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rNxM9CJv; arc=fail smtp.client-ip=52.103.67.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCId0I6bIbMlZmoVUIy7e99wbQ8jBBvyiz1cvEbmcPKEFAEtilAcGixFb0LaPZIArJNYOrj4I8wcA9vIHBf1SyqtJbSmG0MDAj5ReiOcBpUV0O/GxzlSmvXE8OqU87KHVxaXx8wcATcJK/xY8uicE5kYOEv6fbSdOcmq9MMS/9ME74m8OJ+q5YqpWZgtdgYgDz+1ocdZkw5MRC9UxMNFuNntkQGv5bjGZLpFKj+wabYdpDtuwsD2jwVeSE1DRcIo0pzqK6OthyNYhghnCBUDc3XWGTCftmWqUwAOyeZzRKRuG/5MsLEhvhWIRAOqzdctYySnMIlP7TiMc5H9W1iUqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwg8qpLfcvyKyBeWSeOkf5dzZnC2G0K4QoN04PagT3w=;
 b=HLCVbK1cEKrRZrHWwAZb1vNS84zDJa9fwg52lirRT3hmTZJ8ZalzefvMY3sIOvmOFsB1XbbNvLu1NzLhQCtOhkkXRha5Z8a5lQzRK2c/eHzCVeJs6etjewmibyR31hBLyZuvvDJfvk2QipzB3WgjLlcvbd9rl29o+LOI4b4Fi6RFqAJ8iVV2gSLF34YlN9Z5R9CEKGZGErGncLcxCnq/VUWFnOQr04E1C62f80mNuOGjz1McYzXHD2F0QFLxGGms7o/Mfy+SkG0W96fJl3PXykYhTHwnGEIFcFMA3dcKIVLYxlrr/ulECwk1qsjFur775fsC6UbRUzy60+YTAl9RaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwg8qpLfcvyKyBeWSeOkf5dzZnC2G0K4QoN04PagT3w=;
 b=rNxM9CJvTgp4Uo0BSKHT4vQ4sLHmLBQ01XrbPlTE4hPhHRGiHTljDxfHQX2GcICh9YAOZoGsbQEaKH2Ovo50roC0E8MjennLbSFILNs2YYxeWX5VqPxzBd/fgD1R7+7RdiotfXGAhOMx0h+B5Qz+hsnyvbNVmcoUR/x+R/LxtJw+LisRwlUbIPK/LwETG0m0+jINL44SoAjDdkODZv9Dh/vloQYmZJWaY+N9qBlzJaeTSVcDz1qyUQi5RfEfQQGRIHelceIFfIAFxbdBb7VoE9bYmu+ns9DA8bWBbqzH5cj18Zvd1YdmgVfhl21Ci/Xs0mWsQy1AdhDGHR5PGER+gg==
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14) by PN1PPF0EE0B81A4.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04:1::306) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Tue, 4 Mar
 2025 23:57:20 +0000
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5]) by PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5%6]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 23:57:20 +0000
Message-ID:
 <PN0PR01MB10393134B6BD714C1F070F0BEFEC82@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 5 Mar 2025 07:57:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver
To: Inochi Amaoto <inochiama@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Johan Hovold <johan+linaro@kernel.org>,
 Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>
References: <20250304071239.352486-1-inochiama@gmail.com>
 <20250304071239.352486-3-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250304071239.352486-3-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14)
X-Microsoft-Original-Message-ID:
 <48fd9396-e6fc-4f1a-aaed-c626e7bbb8fb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB10393:EE_|PN1PPF0EE0B81A4:EE_
X-MS-Office365-Filtering-Correlation-Id: f93279ca-c3f0-4135-0f92-08dd5b784c4b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|15080799006|5072599009|7092599003|8060799006|19110799003|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bk0vbElxVUNTSjdjb3FQWnBDVndYcmdYTTRFa3JRNUw3NzYrTitIMTlXc3c5?=
 =?utf-8?B?bXE1RFczTWNhM1RDd2pBNWlQdTgvSW55SW1yekYzOE9ocmRzYzZWbXhoRHk4?=
 =?utf-8?B?c0k1YVFHRU8vZTBSYkRETlVEbWxzUVJJWk1qRGJOWEhOUXRZMWxIdHRYVFl0?=
 =?utf-8?B?RkJ6Vk80REFXUzVYeXBqL1gwWlVwWHBmQVdtRmhuZVlpZzdESGd1RVBiMVlr?=
 =?utf-8?B?YzRmbTBTZHRaUTZiYTJEZnpUSUtVUGFTUzl5TkZlbzIvMGhRc2dnWGh6YW5p?=
 =?utf-8?B?dlgrZjM3MHM2Q2wvQ3N3NW1jWXkxMEF0SVFOcCtJWVlWdUU1dndOejA3aW1z?=
 =?utf-8?B?T3R0L3FHNGpuam8xdzJYUTkzWmJDbzZTZUdUd3Z1M2dUbUg2bkdKdml3VjhQ?=
 =?utf-8?B?NHVpZ3lqSHZoYng3c2Q3czgrOFM1Y1p6dHUyVmZ1eDZsMzU4WXhjamNzemhk?=
 =?utf-8?B?ekRjaG9Md0FySUM3RzZQbnRzTVYrczVUMnZSQjRDcTZzZThlOGQwdFJ0SFdS?=
 =?utf-8?B?dE5GM2d4NktwZSs4SHdNTmszeXZDbURJbTlOR0VLTU9jLzc2bjlURjFHN1lO?=
 =?utf-8?B?NCs3bU02eE9NT09QV2J2NUhrVGt5LzBXclBiRzBSd09JWDZkNHRoRm9jdnY3?=
 =?utf-8?B?eG0zTmF3MnROMk9mbkNxYmN2a21xb2NDendlbWk0YTdtdk5vdFYzRFVSQlJG?=
 =?utf-8?B?V29wRGx6VmlHVy91SkdNZWdQb09VQ1BKMG05VlF2dWhVWXZpT1BLWkIyUG82?=
 =?utf-8?B?UmlYOFIybG5Lb1JScnNVS2ViMEtaYmZZV2FmSDBSeTlkL1Z1cityTjg2ZEVE?=
 =?utf-8?B?YnJHMWdQYkQ5b1F0dmFDMi8ybXhaZ3MvWTIwbE13bGc1ZVhuN0JKNTJFTVI4?=
 =?utf-8?B?TjBSdm9mZzdYMzhPdHIxQXZPNEFZdmJtSk1lQU9PUXFwWWl0dmNtUHVVUi9O?=
 =?utf-8?B?VEdnZ2RISDFuRDJTbmN0cWQ2U3g3dlA1U0wrV2JhdEFmM2YxRjZmUFc4T0Jz?=
 =?utf-8?B?Vi8vNWM4ODZKbytaZHJMd1ZGeU1MUnJWWDN1ZXBLUThIQUJ6em5VYTVsV2la?=
 =?utf-8?B?N0s3ZEFWWkFrUzhscjBkYXFpbXdlVGlPNHY4cFlXd3RMZUdaSFdqU0FGYUcy?=
 =?utf-8?B?K0NBd2U5M0hoQVhDRmloTmtpL09hcEU5bFhQZVFvMWdNMGJMUGp3enpyU0cr?=
 =?utf-8?B?QnFTejZiVkRwZ1BLN0pyN0R6c3N5Zzl4aExYbmgrZFYyeGU4d0hiQ2NHTXBl?=
 =?utf-8?B?blVoZUJQNWl1Qk5JeWtHeUc2N1JyZHA4eWk4aVpkT0VXbnFVVk14RGttWUVL?=
 =?utf-8?B?ejFtbFNxd3dhWlFtU2FlL0NPSitYazFTMkR5VHNDU28zSytTNkpwS3V3L2Y3?=
 =?utf-8?B?WmFkRW44UW1aV3VZdTZwUFA5dXNwc3VmV2lKSjlPLzk5ZHZQY1p6UTFMeWxt?=
 =?utf-8?B?TEJPYi9YVUE4c05Jb2xaYUJHbTkxNDYwMGdQM2ViMmxtZjFqZDhZNEtkTG5t?=
 =?utf-8?B?SjN3RmxPbVhzZFo5UzBRT09nUG5NRkhaWFNYeXRPZnZ3WmU4OE1HcklFbFAr?=
 =?utf-8?B?c01YQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1VVdnlVT2J5bVo4STNmQU52a0ZITVZ4QUxCS3dRdTkwdEp3cE5OR2ExeVNE?=
 =?utf-8?B?R0FCUlFyWHB1V0pvSlNHYUFCV01sSC9NUFVzWWNiYTU4cXk2ZVdQTVc5SmYw?=
 =?utf-8?B?VkRrS0VGTUtzbVZWMXlERmtsQ2gxVSs1WGZFcWFJR3FLYWp4U3g5SE5VcWVt?=
 =?utf-8?B?MUkvUWR5WGNWQmZoeitOc1BBK1Y5R1Frbm9laWd3bEp4ZnAyb2N0ZFIyR1Na?=
 =?utf-8?B?dmVScmcvYURyK050d2EwWDdEek8zWkQvRTJ5b0N0M2ltQXc4T2RhdFNDbWZG?=
 =?utf-8?B?YmpKbUxHVzlHblZudHkzZDZlTlRBQjNPZWZlc2lBVTRjMnZHYXE5MDNtaWlh?=
 =?utf-8?B?cVI4QjhyMUcyeDQ3NHRsaW9oNjVUVG84cGpnNXNPQWVZd1huZllZSGp6azFI?=
 =?utf-8?B?QVVxb2xIcjFCR0YvL1FXdWUrMlBEMUtkbkVoQzM0d2J6VEFydTh1SWNrSzdZ?=
 =?utf-8?B?b0dhNndXZk1jeGxTQXhqN0JxditFbVByTjNjZ0dmYmJFbTJCTU0vRDV5QkV1?=
 =?utf-8?B?L1BSbDhadEtBWHVBZGUyWVZLLzRZQmFQS3dzWGI1UGlwb0tCamFsQ2ZENDRz?=
 =?utf-8?B?aXdWVERmTnE5d1dBeDgvalczM0NFMXRud1MzbHJXSkxoeE00REtXT25OZzVK?=
 =?utf-8?B?QVRxSW9FSXA3RDQ0THZEcHZpVFhOS0NLZThSM1RUZDRXQnFqNUYzUUdETmxn?=
 =?utf-8?B?MTJDejJVRC83cWMvSW5yVGdiWXdOSkR2U0Jvc29lTWozWDF0d295Uk1Iem40?=
 =?utf-8?B?MFdEYUdiUXlkYjArVXN5N21JeStwQllSQlQ4NXB6Y3ptSkJ3d1hqUGlIV1Vh?=
 =?utf-8?B?UFdHa013cUV4UGQ4WjQyeE40azlYQlhhMVVFTmlGLzlFMkh5TUoxNjA5N29F?=
 =?utf-8?B?cExtYlZYVmZtK1VXNDdUNU9tQ0UrUGU1MEhsZGlGanNITjFLSWRSWnZNSzN4?=
 =?utf-8?B?YXUrSXZ2d3p3RnphK2JoUGFXSmhwLzcxUmR5NFVnUk5UQkFReXJrSkZkYWY2?=
 =?utf-8?B?em00NnRmT0JDSU82cHpzaFNCZlJnanVXejYvVGN2MXQvazZwSFlzTTFCSHZE?=
 =?utf-8?B?MmY1c0hCdW9VbUJ0R1gxRGVMcHNvMmNneG02aVFYUU1nM1lVYWtZMXZVTVZK?=
 =?utf-8?B?ak5FR3UzRXk0QUd4SnB6MW56OUptZVFkcnZ3bGV1NUFqYjVRaThJTERId2xj?=
 =?utf-8?B?RVdhMW9hT1AxWkszSW41QXYzK0NaTkFndHQ5YXlNL0Z2V2M0S1NNNzUrQ2Er?=
 =?utf-8?B?d21XMnFtTzg1YTdBbWhuK3RQYVlkZzVXUFl4MUZMcTJpN2hGWjZpOVQrMk54?=
 =?utf-8?B?WVFHRlR2Qll5M2FIaU1nOEM0eEFNVGRMMGkybGkzUzQvVXdVSzMxNzBLSy9i?=
 =?utf-8?B?V3Z1cWMwQk95elIxdksxRTh0TVhFR3BwQTJGWEdqVUYxNVduTTNDR0JsRGEw?=
 =?utf-8?B?VTl6dVNCbHZHS0pDbzdEQ1BrS2JneWdXS0s1YURWYlVPL0tkT2hUQWN1elA1?=
 =?utf-8?B?S2F3WVNqUHpMUSswTXYxVyt5SHVwbEZPblJsNEZjeWZqUllIL1R6SDVuVG0r?=
 =?utf-8?B?ZmVST3lLNjdPNkFJcC9MYVBLdCswcWxJcDFPQWhRLzV0V1M3ZitqdVJGMGZU?=
 =?utf-8?B?MnZ0VDh1VnF1eHVIazBEc1dDTUN5WFZrWkhBSEsvQTA5NkRoUWZNRTZzZ3hy?=
 =?utf-8?B?ZklrQnNkWEpyWkRWcno2RUpuRXpkTWJsdC9pRGEwaVU1b21ad2d3TDZMUXd6?=
 =?utf-8?Q?PiP1PQFI+SYqfP4YBh42bPxE8tXVbNTu3E+cvVC?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93279ca-c3f0-4135-0f92-08dd5b784c4b
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 23:57:19.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1PPF0EE0B81A4


On 2025/3/4 15:12, Inochi Amaoto wrote:
> Add support for DesignWare-based PCIe controller in SG2044 SoC.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>   drivers/pci/controller/dwc/Kconfig          |  10 +
>   drivers/pci/controller/dwc/Makefile         |   1 +
>   drivers/pci/controller/dwc/pcie-dw-sophgo.c | 270 ++++++++++++++++++++
Will this driver work for all sophgo chips using dw's IP? If not, it is 
recommended to rename it to "pcie-dw-sg2044.c".
>   3 files changed, 281 insertions(+)
>   create mode 100644 drivers/pci/controller/dwc/pcie-dw-sophgo.c
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index b6d6778b0698..004c384e25ad 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -381,6 +381,16 @@ config PCIE_UNIPHIER_EP
>   	  Say Y here if you want PCIe endpoint controller support on
>   	  UniPhier SoCs. This driver supports Pro5 SoC.
>   
> +config PCIE_SOPHGO_DW
Similar to the above question, would it be better to change it to 
"PCIE_SG2044_DW"?
> +	bool "Sophgo DesignWare PCIe controller"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	depends on PCI_MSI
> +	depends on OF
> +	select PCIE_DW_HOST
> +	help
> +	  Enables support for the DesignWare PCIe controller in the
> +	  Sophgo SoC.
> +
>   config PCIE_SPEAR13XX
>   	bool "STMicroelectronics SPEAr PCIe controller"
>   	depends on ARCH_SPEAR13XX || COMPILE_TEST
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index a8308d9ea986..193150056dd3 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
>   obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>   obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>   obj-$(CONFIG_PCIE_ROCKCHIP_DW) += pcie-dw-rockchip.o
> +obj-$(CONFIG_PCIE_SOPHGO_DW) += pcie-dw-sophgo.o
>   obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
>   obj-$(CONFIG_PCIE_KEEMBAY) += pcie-keembay.o
>   obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
> diff --git a/drivers/pci/controller/dwc/pcie-dw-sophgo.c b/drivers/pci/controller/dwc/pcie-dw-sophgo.c
> new file mode 100644
> index 000000000000..3ed7cfe0b361
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-dw-sophgo.c
> @@ -0,0 +1,270 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sophgo DesignWare based PCIe host controller driver
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/platform_device.h>
> +
> +#include "pcie-designware.h"
> +
> +#define to_sophgo_pcie(x)		dev_get_drvdata((x)->dev)
> +
> +#define PCIE_INT_SIGNAL			0xc48
> +#define PCIE_INT_EN			0xca0
> +
> +#define PCIE_INT_SIGNAL_INTX		GENMASK(8, 5)
> +
> +#define PCIE_INT_EN_INTX		GENMASK(4, 1)
> +#define PCIE_INT_EN_INT_MSI		BIT(5)
> +
> +struct sophgo_pcie {
> +	struct dw_pcie		pci;
> +	void __iomem		*app_base;
> +	struct clk_bulk_data	*clks;
> +	unsigned int		clk_cnt;
> +	struct irq_domain	*irq_domain;
> +};
> +
A similar question is, can structure names and function names use 
prefixes like "sg2044_"? This also makes it easier for other sophgo 
products to reuse this driver file in the future.
> +static int sophgo_pcie_readl_app(struct sophgo_pcie *sophgo, u32 reg)
> +{
> +	return readl_relaxed(sophgo->app_base + reg);
> +}
> +
> +static void sophgo_pcie_writel_app(struct sophgo_pcie *sophgo, u32 val, u32 reg)
> +{
> +	writel_relaxed(val, sophgo->app_base + reg);
> +}
> +
> +static void sophgo_pcie_intx_handler(struct irq_desc *desc)
> +{
> +	struct dw_pcie_rp *pp = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct sophgo_pcie *sophgo = to_sophgo_pcie(pci);
> +	unsigned long hwirq, reg;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	reg = sophgo_pcie_readl_app(sophgo, PCIE_INT_SIGNAL);
> +	reg = FIELD_GET(PCIE_INT_SIGNAL_INTX, reg);
> +
> +	for_each_set_bit(hwirq, &reg, PCI_NUM_INTX)
> +		generic_handle_domain_irq(sophgo->irq_domain, hwirq);
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void sophgo_intx_irq_mask(struct irq_data *d)
> +{
> +	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct sophgo_pcie *sophgo = to_sophgo_pcie(pci);
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&pp->lock, flags);
> +
> +	val = sophgo_pcie_readl_app(sophgo, PCIE_INT_EN);
> +	val &= ~FIELD_PREP(PCIE_INT_EN_INTX, BIT(d->hwirq));
> +	sophgo_pcie_writel_app(sophgo, val, PCIE_INT_EN);
> +
> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
> +};
> +
> +static void sophgo_intx_irq_unmask(struct irq_data *d)
> +{
> +	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct sophgo_pcie *sophgo = to_sophgo_pcie(pci);
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&pp->lock, flags);
> +
> +	val = sophgo_pcie_readl_app(sophgo, PCIE_INT_EN);
> +	val |= FIELD_PREP(PCIE_INT_EN_INTX, BIT(d->hwirq));
> +	sophgo_pcie_writel_app(sophgo, val, PCIE_INT_EN);
> +
> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
> +};
> +
> +static void sophgo_intx_irq_eoi(struct irq_data *d)
> +{
> +}
Why define this empty callback function? Please add a comment if it is 
really needed.
> +
> +static struct irq_chip sophgo_intx_irq_chip = {
> +	.name			= "INTx",
"INTx" --> "SG2044 INTx"
> +	.irq_mask		= sophgo_intx_irq_mask,
> +	.irq_unmask		= sophgo_intx_irq_unmask,
> +	.irq_eoi		= sophgo_intx_irq_eoi,
> +};
> +
> +static int sophgo_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> +				irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &sophgo_intx_irq_chip, handle_fasteoi_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops intx_domain_ops = {
> +	.map = sophgo_pcie_intx_map,
> +};
> +
> +static int sophgo_pcie_init_irq_domain(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct sophgo_pcie *sophgo = to_sophgo_pcie(pci);

"sophgo"? This variable name looks a bit strange, why not call it "pcie" 
directly?

I have seen similar naming in other functions, please change it as well.

> +	struct device *dev = sophgo->pci.dev;
> +	struct fwnode_handle *intc;
> +	int irq;
> +
> +	intc = device_get_named_child_node(dev, "interrupt-controller");
> +	if (!intc) {
> +		dev_err(dev, "missing child interrupt-controller node\n");
> +		return -ENODEV;
> +	}
> +
> +	irq = fwnode_irq_get(intc, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "failed to get INTx irq number\n");
> +		fwnode_handle_put(intc);
> +		return irq;
> +	}
> +
> +	sophgo->irq_domain = irq_domain_create_linear(intc, PCI_NUM_INTX,
> +						      &intx_domain_ops, sophgo);
> +	fwnode_handle_put(intc);
> +	if (!sophgo->irq_domain) {
> +		dev_err(dev, "failed to get a INTx irq domain\n");
> +		return -EINVAL;
> +	}
> +
> +	return irq;
> +}
> +
> +static void sophgo_pcie_msi_enable(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct sophgo_pcie *sophgo = to_sophgo_pcie(pci);
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&pp->lock, flags);
> +
> +	val = sophgo_pcie_readl_app(sophgo, PCIE_INT_EN);
> +	val |= PCIE_INT_EN_INT_MSI;
> +	sophgo_pcie_writel_app(sophgo, val, PCIE_INT_EN);
> +
> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
> +}
> +
> +static int sophgo_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	int irq;
> +
> +	irq = sophgo_pcie_init_irq_domain(pp);
> +	if (irq < 0)
> +		return irq;
> +
> +	irq_set_chained_handler_and_data(irq, sophgo_pcie_intx_handler,
> +					 pp);
> +
> +	sophgo_pcie_msi_enable(pp);
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_host_ops sophgo_pcie_host_ops = {
> +	.init = sophgo_pcie_host_init,
> +};
> +
> +static int sophgo_pcie_clk_init(struct sophgo_pcie *sophgo)
> +{
> +	struct device *dev = sophgo->pci.dev;
> +	int ret;
> +
> +	ret = devm_clk_bulk_get_all_enabled(dev, &sophgo->clks);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to get clocks\n");
> +
> +	sophgo->clk_cnt = ret;
> +
> +	return 0;
> +}
> +
> +static int sophgo_pcie_resource_get(struct platform_device *pdev,
> +				    struct sophgo_pcie *sophgo)
> +{
> +	sophgo->app_base = devm_platform_ioremap_resource_byname(pdev, "app");
> +	if (IS_ERR(sophgo->app_base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sophgo->app_base),
> +				     "failed to map app registers\n");
> +
> +	return 0;
> +}
> +
> +static int sophgo_pcie_configure_rc(struct sophgo_pcie *sophgo)
> +{
> +	struct dw_pcie_rp *pp;
> +
> +	pp = &sophgo->pci.pp;
> +	pp->ops = &sophgo_pcie_host_ops;
> +
> +	return dw_pcie_host_init(pp);
> +}
> +
> +static int sophgo_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sophgo_pcie *sophgo;
> +	int ret;
> +
> +	sophgo = devm_kzalloc(dev, sizeof(*sophgo), GFP_KERNEL);
> +	if (!sophgo)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, sophgo);
> +
> +	sophgo->pci.dev = dev;
> +
> +	ret = sophgo_pcie_resource_get(pdev, sophgo);
> +	if (ret)
> +		return ret;
> +
> +	ret = sophgo_pcie_clk_init(sophgo);
> +	if (ret)
> +		return ret;
> +
> +	return sophgo_pcie_configure_rc(sophgo);
> +}
> +
> +static const struct of_device_id sophgo_pcie_of_match[] = {
> +	{ .compatible = "sophgo,sg2044-pcie" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sophgo_pcie_acpi_match);
> +
> +static const struct acpi_device_id sophgo_pcie_acpi_match[] = {
> +	{ "SOPHO000", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, sophgo_pcie_acpi_match);
> +
> +static struct platform_driver sophgo_pcie_driver = {
> +	.driver = {
> +		.name = "sophgo-dw-pcie",
> +		.of_match_table = sophgo_pcie_of_match,
> +		.acpi_match_table = sophgo_pcie_acpi_match,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = sophgo_pcie_probe,
> +};
> +builtin_platform_driver(sophgo_pcie_driver);

