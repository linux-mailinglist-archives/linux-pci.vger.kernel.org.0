Return-Path: <linux-pci+bounces-35237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F90B3D9B6
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 08:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF133A5C33
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 06:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B21242D7F;
	Mon,  1 Sep 2025 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OKhu0GzP"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010013.outbound.protection.outlook.com [52.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA9E140E34;
	Mon,  1 Sep 2025 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707463; cv=fail; b=RsbKdWUtnMj923sBuBf/lanHDPcSfBU9d0IaPw85/qcGMUhl83xAnGK2nunsk1YiPhnFbpjvu8xWNzIq353+lG10LMpPmAc7rSTPdunf38t+vrU0PvZOYH21DZIv54rOYTVXaLKC2HXjnN3STcx/6rwdsGkyud7EtaKfZFBFyUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707463; c=relaxed/simple;
	bh=aTbT/seEDugKB8gdgFPmACJ/8OetDsJ224e0N6KxcEs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JOIzHvP6t8Loy6OcArUIfI+giIz49YdXTg8RTcKlT/A3tozyQY4RgU113BHTlMbxg2nAWf9nWnMVP1V8KaSbiWLSahVi03t9z0OOfRna99oiD8X2brDWt4HHq0JNT9g72qOkA0e2A55rD0zurL/J4FRxV9SkxAjn94VZxGxkhVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OKhu0GzP; arc=fail smtp.client-ip=52.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3stKJGfjp0uRps0rYoPA6vGI+I1ppu9CULqd5CGbqwVvpuAEpnjTm3JdgOTGHfgM90lxIMfGzKwuA5lXk59/bJWe+jYJ1DGt/IydzcWxNEj5m513xjN750T5mHh/GgWk2KAJ6O55I+192PXrOMxk/hweCbwxLs3BxW7eSa9ZoP71BwNCVSirgkKUb0wGM5xluOCzUBS0gYjKRr7SJrqXsE8n7Dy/ezk40K5K1re0JHkXdMjjxzS6Nx9PjMaJI1f6VqopFVmaCfSHPT9EgE1iCgX9w0DdBAwuwR2ng5daLbObpK+FZyblKRaoTSlwaBAr25VXtr38ARuNCYKhM3ElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0sQ/YWSc3YerEz0WsTYRsyDXkTQWbh6ko/XayijswE=;
 b=x6qMZaA01I80eSajO8vhDKG/BXCrhre9D1tdyIeZMMiyz3i3L35vr+r0T0FeaMJKvg5ZBCCC9GpbUHzCxM7CJklDxrL26jqeZ7kF3p5PoJKJTqNPut+X2cN4tYDQX1AzprZ3hceXhZyfGW5qG12JPD4wHPv+aGFUQC0tHiip856ZTy8qfxlnVYljEWykSi7dpFePCOISaFQxzAcvHqVlhGEOWRgCIvivAR5vxVRRxmfwR4ghHor9Y3LlQM5zb//5KgckKlmQnMBxDfq9hC4lYjbTjbB0Ee6huiguu0UW9evqICZ3zfeUpfGy0K3wopVh54Se8+xWXb0YWEE8P3KLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0sQ/YWSc3YerEz0WsTYRsyDXkTQWbh6ko/XayijswE=;
 b=OKhu0GzPgjiSqKkO4kfhy2tEf9uRyvdOM+B2b5casSA6JJv03ZJLWjlbFn09xl6fRqhsLNREBmgXd7Mj81mmS7gLWYTITBYAz2K0ZVi03GBZ3wQK6fye2S6WSAYeUFv0TYybPwD4nLMAwVFkksYpMy0i7rMb4EFk4Rsmf8aFASZnOqcSFn5bZLLdYX4nMZ+2iBz9aGjxkSgsNQZrt1/jAfbTt+GFoBVGWQjk/s0AkuObnQKtr+mVqmBuoTO9JhKDN0K9hSM/hwG9HnhiRJa+85h9yuaEe8mcc6VLSTVIO04glUxbyhu6xbcw1s0sm29bqGTKmLyRbgYJbttAKB15QQ==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by MA1PR01MB4130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.23; Mon, 1 Sep
 2025 06:17:27 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 06:17:27 +0000
Message-ID:
 <MAUPR01MB11072CCB9E907768E89660F2DFE07A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 1 Sep 2025 14:17:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
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
 <c9362bb49e4d48647db85d85c06040de8f38cb83.1756344464.git.unicorn_wang@outlook.com>
 <qyr73crraruct5dgxfko75gv2mrrxxolkzqnu3bngfelcobgfa@wc4rrzfs27gp>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <qyr73crraruct5dgxfko75gv2mrrxxolkzqnu3bngfelcobgfa@wc4rrzfs27gp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <1ab4867b-7f1f-4ecd-bdf2-b004e3e6bfee@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|MA1PR01MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: ee70d066-3a76-4730-5047-08dde91f394b
X-MS-Exchange-SLBlob-MailProps:
	iS5pQZgsAQAQzPBsqL0qQYWYJhuVqIOiTqeUhPaEtTtH1d3Zatb8sjoZAGPEstOCKd901t+9miGHP/jENic3zGyMwbj41iAN8oV626akDJeUdVaWk/CCiC0IfBlrYAdL5qjV4Q80w2Ho84GsZ3FB9hlcuJ+aERwpn95frPRS6qIKei9PrgxLy2BuUCt+DVbyaHW+JaaGTBkSim35/1yk6/FXfR71OUMZXlZcZ2jlJQpIgSZ2Q0kCMpzVElyftylpHUcFxmoD6paKAw/sjmBxEizs3tVuX7FZQrIRUaFvqy71m864nAyhO5j7AUJjn8xTscoBhgtCCm2FH6ieNs3Riq7kbALgbGEsd248Kx7VqOC4FvZXQ6+i+Nbf2D7lbnFLXuYv4fD/IwzUCdIYSXACMHe31apHsmpUPxbHUJbHzCRqwBYptFqGpIOtFIwU0Opuk+qIYJSjkBQytrPFwILiy4bL7tt8o7z1+HpCAWPpLQRE2MTEoKbvpTdouhL4EDXf5pVE2mKa1NWTranJvS49yZ16Yfpsrnqz/g+JI3jWjgBZwSr5CzzPlU+kLVmI/yKNhJrJs9fERgkTx6J3JD4XSKgm944cA5OY1tOk2L7yS/s6uAWSddTZvbnkdv/kpuKSMzUIdB/AO+NnVgaT3Ye/+WfPHYX6EBe6aulh9OTFFDQlwGLWUCGbQk3JivheUJYY/ARdiLLv2kD5hrAjnOSbUrk7yKGzcRVMRp2YBVq6jpkWnhIDpdmle9sHd7JiQGRFTullC3Rlb3siJQf0NQUdoQfNj6pNJoFdEUY8CLlcBHLf7oVurPfYd2vGCs/WX+YR
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|23021999003|15080799012|461199028|8060799015|19110799012|5072599009|52005399003|3412199025|440099028|41105399003|40105399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUNYL0JISEdKS3RlTnYwNTVnMEtkbllLYXMwZ281NUlrNW9yc1QzM2lTdUhJ?=
 =?utf-8?B?Q0N4ekhBVnNINkhyMEJGRDA2OVFxT0V6R0NvQUJvY3RjRU4rTWZhN2dqRGRE?=
 =?utf-8?B?VTRRSUhMWXJNK3A4djVxSmJtaVhaOGlqOTRTb0c2MnFoTTJUa1I0QlJUdm1D?=
 =?utf-8?B?cFZVLzIwcks5Q045TEVPY25YV2RnQXNDZlFzNjVJbWdmWkt3dm1xNkRVQzRU?=
 =?utf-8?B?MXoyeFRuRDJ3QUhZQk9KN29FZFV4RG9OWjNSajJXaG5DcWk3eENhSHc4ZE1M?=
 =?utf-8?B?aVlLc1djQjRXK2prMzQ4NTZEN0FlSFl5LzVhTm9MS0s0c0Ftemk3SDJONVJw?=
 =?utf-8?B?RmdiNkRwQzYzL2U5TDVUSnZiZEF5aUVXdktGT0t6ODMvY28vaDJZQmpvaGgr?=
 =?utf-8?B?cUI5YURtQTBhaGlsVmVkbUxkWmpRSWdnMytqaVpwc1Z3Wk1vbXRVSUJRU1JI?=
 =?utf-8?B?TEdHOTJ3ZWovem1KWmpSa0pPOU9TNVhyMW8zdjM5cmdhZDMrUHU3dHBWM2dW?=
 =?utf-8?B?eCtDdkQ3RzVqT0ZtWWJtY2didnI1eDM4aWkvNnh2REFDSVlZVGI0N1RjUE5q?=
 =?utf-8?B?dXZESER6TEd4aEpHK3BoZzZNbDY2Rm9kNzhpTlFCTk5ob2VlTDFTTGZQUHpH?=
 =?utf-8?B?L2R3bEw5MTlRaVJxMW9UZ3YvaEpsZlZsNVZ4UzhaVExoTmtObDJOdFNJSW56?=
 =?utf-8?B?cXhjRm96RFNRNTJ6TlNYSUdKbXZIT016YVhpeWNKYjJtaDhtSFV2dHhabmlp?=
 =?utf-8?B?TDZVZGVmVkRIWjEyT3RyT3ZDa3p5SkV5bVpFTktwS21rNStwQ1A5RC9GRlRN?=
 =?utf-8?B?SHFTMVJnV0Zyd2xYUnNFZFFjMy9BTlNjcWUzR0NnVktHclhPcTJLQlNLcDR5?=
 =?utf-8?B?eFphdFlZYURuN1J6TXdISGwzWEdiSjNjNks3anI1blVjanMzNFF3eHBlL0xk?=
 =?utf-8?B?R1N3dnJwUFhFYzV5d0o3ZXhBMHFSRXNQcHdzcmwzeTgyVDR2aDRYaHZLa1B0?=
 =?utf-8?B?NTZJeFdFUjdhOU8wa00rbkRyQXcrY29CUGhUd1EwYzhtNkJUTElCZnpIdXBK?=
 =?utf-8?B?bDNGUVJZU1BKcHNQWHkvZ1l4YXNCemI2WFQxWG9wdW1sK3hyUXg3djBtSU9U?=
 =?utf-8?B?RFFQSjJwbE9nQVh4Y0lTUWNmWmtsd0FwY3R4cGhyNFJFRkZUWmZPdy9WK3ZZ?=
 =?utf-8?B?b095eEpjTy93Ritaa3pJUlZkR1g5cCsrTVZTVzdxcDdteWZvdGM5MGxraXJR?=
 =?utf-8?B?eks5L1RIaXBLc0h4RmQyZ09WYndranN1VnZUbHhnN1laWDR5ZDgzZWJWekhB?=
 =?utf-8?B?TW5PY1g0Y0lXb1EzZDlzNjhrbCtaejkvS3RjNmtJam5jNEthbXBNbHAzRytq?=
 =?utf-8?B?RHpSbUExU1RQWWhNQW81Ym1OUlhFWUdlcmZ1eHhSQ1p4dUhtVVY4Vmd6akFD?=
 =?utf-8?B?Y3Zic1E5Q1UrQWFDWlZHZW1FdGg5cjgyYUhHc2NtOFFUUUkwOW5ubVdTMkRJ?=
 =?utf-8?B?c2xDMEtjS0tzWnZPb0w2MlhCS3NsZGplQi9WVFpqNWU3bDY2aFNNWHdMNFFU?=
 =?utf-8?B?YVlRSm9pMGpkRGQ5ZS9tRkMwaTVuUU5kSUM2cWVGS1JVMmpGYmQyR010Z2g0?=
 =?utf-8?B?TGNtY21aUTRoS1hNbkczaXZwRm5tTFpNYy9DeDUyRW16NWNzVEc3d05SdmI1?=
 =?utf-8?Q?rpGyr1ipsSZH0asJDhOs?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTdXUUJES2RkamEwZlJJSTkwMXZJUE96L2J4U0g0UUl1TDBWbnJseGpoenc0?=
 =?utf-8?B?ZXFHS2FlSmh0eXpsMUdzOU9ObDVGYWRvU21WOE00ck5jY29teFdWdXczNWNj?=
 =?utf-8?B?cXdGd2phU2gwaS9OZEZiRFZoVkExTGtyWURrVVhPQ0NGZkVUTm44RVYyaG5H?=
 =?utf-8?B?LytLNHN6Ym5KaTFxQzhLSUZkTklSa2VvSzJGSnRsYm41UnNwUGxWdlZrSXJw?=
 =?utf-8?B?eW83a1hPSGVDWmwzT0g5K2c4cEpra0VOVWlERG5sbmhNOFlSZTlabUFNbEpp?=
 =?utf-8?B?b0lCSkovL0JpQzNlUWtWNW9wRjUvMnpZTTVCQkRla01Hd3RFZTNoTkh3OVk3?=
 =?utf-8?B?aGFtSTd6Wk9tSXpYYitSNnNseEJrSW5ObVhtajBWSHpQYlZjRG5COWpiL0lW?=
 =?utf-8?B?M1NWcmNXSHh3QnViR29FazNSQWZSYzF6bm42SnpKV0JCQ2w0UUJuRnkzUWVq?=
 =?utf-8?B?TUN0Q3FRSlNvU1lCdHBJMEQvL1NvUkYxdVJBdEVSNG11WUE2QWdlb2RyeWln?=
 =?utf-8?B?cGJ5NUo1bjd1bnBodU1iYlRGd2d3MHVTZnVWQ2NiQWpjMEhDc05zeS9Ydm0y?=
 =?utf-8?B?WHVqL3VhTW8xL2piak1GQ29tNFIvVmd2SmxRZnF6YWxBcUo3ZG5RamhVMFJX?=
 =?utf-8?B?NUpyWFE4aWM1ZTdhNmY0WkFzeWtjUGF0bUFjc1FsS1JMeGdmS0VVaXhDMEE3?=
 =?utf-8?B?TVhRYlkvWUdRUHlqaVhLRlhzazI5bTE5VGVUbjF2NGV4cVYxQkdaMC9MYk1v?=
 =?utf-8?B?Tjc2QVJVNTQ0T2xMcmN0Q0tGNy9KajFxVUlmanp5SThwOUlyUHNaVm5hSnY3?=
 =?utf-8?B?NTd6SmF4T0RwcytwWTBneStWYzEvRDgxTnpEemo5Zy9sUjNTNEx6TkRldzZH?=
 =?utf-8?B?NGJCM1BYS3JmREFxOHFoUlR0VkdvcWtHcS9sSWtvUzlLTG5YU3R1Yk1CRTBX?=
 =?utf-8?B?Y3lKRFdnQ0lGN0RHako3RzdvUkZETVlrQlVYU3d5QldmUjUvT2k3TEVTbytD?=
 =?utf-8?B?V3IrMm1mcFcwLzRPMnZLUjRQSi9YbHdjWVpvKzNvSnBFdjJ4cktiMWoxdzE3?=
 =?utf-8?B?eUpUUVJuTjRKTE9TMGhqN2F6YzJDUHNXellMS0F4enp1ZXJWL2xDWUk5WHV2?=
 =?utf-8?B?M0daRWpHa3UycHhaS3ZTSHNGWUpaVTI3ZjBoN0Q1eDVnTkVKR20reThDY2Va?=
 =?utf-8?B?dWNrYUljdDZweXBNVk5zWW5EN1VKWUNsSVRkOC8vUTg0MzFucWJHdEk4V0FU?=
 =?utf-8?B?YlZYdUtBZGR3Q1lkVmFiVGQxRnJFMStlZ0hCMzRYcVkrWGltd1grTEh0TjZH?=
 =?utf-8?B?azhySWlaWDFFc0hEOHdmYjYyMDdqM1FiTW93S0xXeFMya2JBWWlkSHlUQzJT?=
 =?utf-8?B?SGwrbC92dmdvbkR2OEZHcW03U0xpbzVJcmF2OHlyN1dKNnI0NytQZ2R4MG1D?=
 =?utf-8?B?WVRycHVFdkxoMFJrTitoa2ROZ2ovVXhwRXR0NkVuUHduMGorL1lJQmIvOWNT?=
 =?utf-8?B?eWtsYWVzWWlYRStqUGltMkl5cjdyWDFjT0NFQUNVNWxPeVNONkFuSVo0akRi?=
 =?utf-8?B?RElwblEwQ3ZBK0N3U2Z2aThCS1YyY04vWkZsSEM2MEVvTE4wbGhSbmNURnZh?=
 =?utf-8?B?ZEdlVmh4Qm1veHNndFN6Y2N5UEV4MW80Y3JBZ2ZXbmUwQ1p2RUFHcWYyc2wr?=
 =?utf-8?B?TVdyUTNTUHFqS0ZFVWFuTTYycXBwYmhHL1hZM21vdjA4cHVSSklIVXVCNlN4?=
 =?utf-8?Q?v7vPanJ0rBuFCEwjhoJU/4nV0y+bxk+mO23MuvI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee70d066-3a76-4730-5047-08dde91f394b
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 06:17:27.7305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR01MB4130


On 8/31/2025 12:47 PM, Manivannan Sadhasivam wrote:
> On Thu, Aug 28, 2025 at 10:16:54AM GMT, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add binding for Sophgo SG2042 PCIe host controller.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   .../bindings/pci/sophgo,sg2042-pcie-host.yaml | 66 +++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
>> new file mode 100644
>> index 000000000000..2cca3d113d11
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
>> @@ -0,0 +1,66 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/sophgo,sg2042-pcie-host.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sophgo SG2042 PCIe Host (Cadence PCIe Wrapper)
>> +
>> +description:
>> +  Sophgo SG2042 PCIe host controller is based on the Cadence PCIe core.
>> +
>> +maintainers:
>> +  - Chen Wang <unicorn_wang@outlook.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: sophgo,sg2042-pcie-host
>> +
>> +  reg:
>> +    maxItems: 2
>> +
>> +  reg-names:
>> +    items:
>> +      - const: reg
>> +      - const: cfg
>> +
>> +  vendor-id:
>> +    const: 0x1f1c
>> +
>> +  device-id:
>> +    const: 0x2042
>> +
>> +  msi-parent: true
>> +
>> +allOf:
>> +  - $ref: cdns-pcie-host.yaml#
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - vendor-id
>> +  - device-id
> Why are these IDs 'required'? The default IDs are invalid?

I find the default IDs I read from the SoC is still that for Cadence, it 
would confused when I run lspci, so I replace the IDs for Sophgo.

Anyway, it's ok for me to remove IDs as "required" in bindings but still 
set it in DTS.

Thanks,

Chen

>
> - Mani
>

