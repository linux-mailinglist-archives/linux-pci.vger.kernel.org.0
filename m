Return-Path: <linux-pci+bounces-37180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA6EBA7980
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 01:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD80B175A1E
	for <lists+linux-pci@lfdr.de>; Sun, 28 Sep 2025 23:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFC121B9C9;
	Sun, 28 Sep 2025 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AKJGoMma"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010001.outbound.protection.outlook.com [52.103.67.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D13594C;
	Sun, 28 Sep 2025 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759103640; cv=fail; b=hT0vXNxTJa22MYDZ11KvcLNEc0rxE78qGF01uKAv29/KmnJ0FyNL6yYUeBk4vbPpeVvn6ewMbAAhU90i59ZTNby7VkpwW20i2Xaqnup6s6v7cKja7/9yuWmKje16+0bcxYUe4dDHtnZXIskE5mrTg5+mMWuZQM2+J6KbVITP5GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759103640; c=relaxed/simple;
	bh=BWbgxJLQHEUfxmu06FjIbPNpTlR50sJTIjUvgoOmz98=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sZFGTIxWhQTVfvZw6/Pikiltkf0zFQ3XCyvslidz3vsAfkKI3FeAu3Z5kWtJbalVKBSSp6xABKSJ61byBI8Wvl+71RGa1ekybJXfMwcLa0r2ZxwAg4kd3NvXjkwLFTnWePaaDwRXV0yfG0WpNLJDpr3hY+cUIXn+jsHklUxc3y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AKJGoMma; arc=fail smtp.client-ip=52.103.67.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U12Is00bWnzaf6Fpb7S+vvT6dF6UIppVukcbVsmclvJrgdolihkA3sV7DyFvbWtp3fGh7N6yllpLoA/uqyJRq5FypcHFNpcYWNBAv9qoJL50kV/QXyTii7A5cDEZIESV0U9aXf21IO8ATz6Z/h2Krj0ekQ6NVKfnlKearQHmyB+iXFucRYNbP8NpSC2KZfMb8hbljXUocoegaz8kJK5r4i6fpMXhQ0Zb0hqCV4/5ecGWGhyZs3NSPQLhQ8sGuIX8XXFPLsTOadElx332Yue5p/ldfv5vuTD+HF2j8+YJbjkursDVr58nqyBWzzQ7Idbf0huV1+Vpc+IgWkumoRoaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XB50IxKZ+HabXVHP+T9MSg7RdDv6EGit2ZyBL1rxpTs=;
 b=JiyNM8q2rKeMKAmKRS/iTQ7fVvLv7q79+9qDghI8PROvLFSJmIBEHWGb8WVSExBxbtYD9jIg891sS7AuI8aH8CvPyaNOAl1+IYUWkj6xa3eTNLVcmOMOHkehzqhIJbtBmln/jqNy9d1iytoLNjkUNfvacDJB4IwMcTbg/CraTZH4TXjhvVgW6h1G0IyLBQmjDkZ0yEwYRPopGbLTyja2alpzbSr2ypdpw6MQvwN97g6W0VITJJ5bf9jaArktvNcbA+iHTaRX+pEe3xvQhOv0+BioMuYzEdcYvEMRgQYSktnq3+FeF8w2WLENiOrQkHRYJwDxPjpFTg6bnkmpdp6rXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XB50IxKZ+HabXVHP+T9MSg7RdDv6EGit2ZyBL1rxpTs=;
 b=AKJGoMmaE1oYbldM4PHsqoymM9PGqwSYBre15us6P73RhUUtoqDKREXEplCoIg3GrDOmub7PV2QQHXmn71LAEfciawt/rBtz+WCFHMVhKA2ToEPXcnOi6mENI5dnjCPROpmI6P5pf7bwjql/jpTakVAsMuCyxEwLjFbeXPtZQ966TJyTdzUbyu01tqqn/Rf3IkGwWWmvHixo/VZ61D0fEw0AE7j2JnGI85RCinSl2/4yOx945pB/LGNV/DvvxO0qYBbv9kEDSNLODO5JdAHlNgRbdCP1XU4+ROm5ZPrPLYRzJyLVP+1zuhYoLcWco0MBu23vSKsXfmitX/yWWrkgkQ==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by MAUPR01MB11101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:170::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Sun, 28 Sep
 2025 23:53:46 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%5]) with mapi id 15.20.9160.014; Sun, 28 Sep 2025
 23:53:46 +0000
Message-ID:
 <MAUPR01MB110728EEF983FFA560BFEB0B1FE18A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 29 Sep 2025 07:53:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] riscv: sophgo: dts: add PCIe controllers for
 SG2042
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
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com, jeffbai@aosc.io
References: <cover.1757643388.git.unicorn_wang@outlook.com>
 <828860951ec4973285fe92fceb4b6f0ecb365a2f.1757643388.git.unicorn_wang@outlook.com>
 <cwc3hnre3s3rvzcgzjdbdrhlrizz4obifwragusrixa5owj5qg@yotfd3l3qxf4>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <cwc3hnre3s3rvzcgzjdbdrhlrizz4obifwragusrixa5owj5qg@yotfd3l3qxf4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0116.apcprd02.prod.outlook.com
 (2603:1096:4:92::32) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <11b01f33-8403-4ca5-981d-2d0aafccb49f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|MAUPR01MB11101:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0de959-7369-4698-986e-08ddfeea430e
X-MS-Exchange-SLBlob-MailProps:
	70qbaZjg4mvwrPi3JhjWAjxLXnlVV0q2y5QLusbMKmG80fjqYCNDX1r609Q2PpzeNyDHiai7d9aSVwDHuX/Oa1DB1+0uu4D1SmIPnn9UobizXLk2mhHNBvo29pwaU5xtODmi/CqMq5juAbTqaKr4F2u44cjLk4U7usnQnvYmFpW0RYoptX2LrcdTQ5/pWliq9h0L09rS7dnBn4Se8MNUcx/3Az1YOScvTTxaqXzlhQvGCAm0zdKJGtzhdaVCEpEteWhZz4Viea9Yq6jp5r27jFLOzApzZIlWUnaf6HHP70ksfZZMXbyHJrdREoKfcz/7nuJCktiGg6McB5ojFRVGdpAPUzL+bwATRO7Ap2mS7BP1r5vfEZGg6fjUj0KsSf+1Kt8tNSygw8Kb2DyZcfInxJBHnA97OgHf991hiY+xjEswXoOZgj/o8jQUdq4lGPblxalMcMyFIvLSMH4TexQUEFDeE3mZHwx1yHlon4Idb1O+2f2lC6BOr1oQS6PAoLo1pkz5L0C6Gdq+cFIsGHGu866aclDtcbW7jK6jDSDxOxj+cUoKZvQsr5X0uJnPx3RlTey9tZwY+8LfVxmVmTEW1EXcZFd/u7H4FyfKtdtrF1VzWPElkZEyO6jRrlemRWbB+Tw/ZWC2FGHVK2VI7y9Vi0JAmK9u93OosWsmNQP5nDnpya8d7IlaZRx4eI+UNYer0ojLIPhZTp6gTFb9Dey6irlt770k8YjVrDO3elBfPLKn/GbwRVXLvA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|5072599009|41001999006|23021999003|8060799015|15080799012|19110799012|3412199025|41105399003|40105399003|440099028|52005399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFZVVVpIdkpQeklkdmw3RUZzYVl4blhGNkhQL3VNSENCSEFsMk9JVW9oeEdo?=
 =?utf-8?B?N3NIOEc4TTlxNmh2SUdyWlNBQ2hGVzBxckkvenZ5MnM5OFBsQ1lrSHBKWEhL?=
 =?utf-8?B?MnNod0YxN2h4NTFySU5mMzVqOWdFN3IyQXpuNlJPcVgrSnJsSmZ5OGIxdjRE?=
 =?utf-8?B?RUhvelBaNmRHVHFhMFBRNVVYS2l4bU5iSG1oVXA0cVNOZkZXeURtVjA2bFNw?=
 =?utf-8?B?bEpkS3VqZUMxQ3pzYkZiWkRha3ZnQnB1Y3pQbC9yc0RaVkVoR3NLUmdGUXZZ?=
 =?utf-8?B?OW81R3hHbUtZNzFzVzFaeVdqcU5TdnBuTkF0bHFHTXgyV0xTcEE5T0tRYWtC?=
 =?utf-8?B?bnNEc2w2ZGhwTC8zUkVWTnJDOGlmZkxoK3Fka3dtY1MySnppSHdsNUJtZGFh?=
 =?utf-8?B?TWJUbWRCWHhlUG0xSnNPMitoU2NoSDFCdGdkbHJMcXIxb1libEVyc3Bxc2Nn?=
 =?utf-8?B?MGlIemlNZGp3VWhOQjNoUXFmcmRLLzZHbDJKNU9lNFFOa1AxOWk1RnBBYmwy?=
 =?utf-8?B?a2IwM2t5VWM0bGdnMFVNVXVJTFlwcVVpT01hUFcyUEZTWmt3RlhuVHo5RytV?=
 =?utf-8?B?OFJLOCtnQmc4SitnbmZSN0JzMlMxYy95TUdrWXJFUTJybEhGRHVWVzRyLzBB?=
 =?utf-8?B?K0FYN3NVZTZmN1NvdXZUUHRDaDgwRFpoSFJTWW9DelhiZ1dIWGFZRWpVWjFo?=
 =?utf-8?B?aXZTc3FEcC9ZZ2ZybXJ2YjVRbjBWa1oxeDE2ais3NlRsQzdCVTZoNVYydGdo?=
 =?utf-8?B?OXhJbGM3azRtVHlCZkdLVlZwcGw4UnQ1b28zTTA0TjViQVQzbExCczE4a0VB?=
 =?utf-8?B?ZlcvV2xQOExlL0VIdCtFRk1TOElqRDlXakQ2bkVSbUIvZjRlbThBYysySWtn?=
 =?utf-8?B?Y3BxNUkvN0RYYWpPMUk0R2FlQmNsOUhIcFRyMDF0TytKKzVYSHNEOEg0cVJt?=
 =?utf-8?B?R1RHWmRkUE1OYW1RbkJQM1R0dFdZWVJCNWNscVNyMHQvOFowOE8wZWlZMkU2?=
 =?utf-8?B?UDQveWJ6RWVyNHJNWnZxNmk3TnRMQk4xaTM2UVk2KzJwN3EyazJPcHJla1pD?=
 =?utf-8?B?MVI0emw2VG5YcUM3M1h1NEY0MXorRUh5N3doTGVXZTZGajNZVFNWMTRIa0xW?=
 =?utf-8?B?bUxUOXlHSzNBS1ZVRGNmQzVmbDkwbVdHTWRmUWxqWHBUaWFrTDJIN3R3N01X?=
 =?utf-8?B?Zzd1WGhoTDVTdHBFRlhuYWhvblRTVHlIa216NXJGOHRzYUlMaEprbFNidUdj?=
 =?utf-8?B?QzUzY3hPUjJuZnczM2k2WUdtWDlvQnFVNlA0SW0zNUN0MCt0VCtYK3lGalc3?=
 =?utf-8?B?ZzU4aUpsSGdDajcrazB2OThyNHZqUXMxRzZUSUpmUlplMHg2dUZLR2dvSnh4?=
 =?utf-8?B?cWQ0ZHR4cnl1WkdCSmNTeU9RMXZ3UjdYeklHQWNYakYvNDdrL2svSU1QT2dG?=
 =?utf-8?B?TGovSDZIZVk0cjZUODU1MjNneVcxM014WDJRdVVJd2NCbFZlZU5oY3RETzJn?=
 =?utf-8?B?eWdyejF2d2V3Ui9LZGNRMHV1bUlVWjRReHY5VU9WZXRtU3Znd2Q3emVGSkdk?=
 =?utf-8?B?NTRiRWFMZUxtdTRLVmp0aUJrTWx2NHFvUXhCOG1SQ1FxT2xsQUY2YXZXVXVU?=
 =?utf-8?B?c0dFaHpBUDlocENWTWszejRnOWhSYXVlWEFZNnVaU3FZTUtkWE1ReTBzWTlE?=
 =?utf-8?B?U0piSHZWOWVFVFkyY1h2QStwVm9TZDg4ZDZkdm5jZ0JDakhFWFNPbWVRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU5lNjVqajlRUngveUd3dnRWYTROMHZhcFFJQzQxQjIzOUhmVFErUjlyVXpF?=
 =?utf-8?B?WVpoUHIxblhQVmdXZ2U4MVptbFlDOFBwV2VKZS9jSHZ4R25lcVZRb3Ird0ZI?=
 =?utf-8?B?V1hoZjQzWlV1REVyMjN3WVhaSHZKQ3lDcGFMdk5FeEZ1ckhtRmlZSWU3ajAz?=
 =?utf-8?B?ZGoxaXA5eUJpZUpiVk1iZVVsT3V0Q3lTeTcrcS9wVExwY2ZwTm1HYk5GWkNY?=
 =?utf-8?B?Ny9NNlE0K00rSEpQRDQwb2RzMjNGdi93d2hrOVlJcVBqK0JZTjR1Ry9pSGFk?=
 =?utf-8?B?eE9qTjdzbHpQZU53S05CUG90YmdvTlk4UXVmSERESnhNSFc0UXpGSnB6MFIy?=
 =?utf-8?B?dUVDTVkxMUp0U1FoR3VlaythZXVBcnd1RWRGV2crUkt0OXdpZ1hMeVE1ck0r?=
 =?utf-8?B?bjFoZ2FhUG5VUjRnWCtnWmkzbS9FVkhGOGhJUFhVcFlBbUlOamJSZUlCbjAr?=
 =?utf-8?B?UXkwSzg0Wm16UnNYalBzQzF0RHRDMVRHWmFITnNNM1VDb2ZhbUlWWFd6cUpE?=
 =?utf-8?B?WjMxTkN6bCtYZlQ5eHdjclVmcmltUlp0ZFIwYkRtUklRa0dVVjczWlFxOWZQ?=
 =?utf-8?B?amphQjZjdzlxY3Z3Y0pvbk9zdVYvZWUxcHVNWUdFbnlpeS9XWWRDZExoM1A4?=
 =?utf-8?B?RmZ3S3E5WGk0c1BsbW16azJ1Z0R4alVKU0YwZkw1cWRJbDA0TitkVmlWWWsw?=
 =?utf-8?B?aHovUmU5TUVYTDQ3U09BRFN2OGo5aWNUZ3ptQW1pTU9MWStmNFB1c2JPVzNB?=
 =?utf-8?B?NktVRkpsTTRDVldiV2R0TnBqeUd4djlRS3VYbVBvU0Fob2FoOU9tbm40Tmdq?=
 =?utf-8?B?cVN5UnNFeXY0cUZ1MThMT2MxZGV6UVBJd21CWHFEZitDOWJWK0M3MHVZMWlL?=
 =?utf-8?B?aWFoMjN0ZUZMUVBXY3dVeWFWL1lKRS9HaEVNa1NyMVdORGY0MFlFdGRoOEkr?=
 =?utf-8?B?MDBhcW1sRDA4emxmOTZyS0VJOTJ1TStBcTJvZ2hTSHpRcnJQTHlIOWhqRklP?=
 =?utf-8?B?a2QrMjgyM1pYS2FJcnNVd1FQaWlKVzM2SkhhbHMyaDNSbGFnTGFkUi9IemFO?=
 =?utf-8?B?cXlpQitUbFVIS2k3a0NESS9tUXNPdG1ZZUtkaGpqM3FrWHAzcC9qZmNDa2Rp?=
 =?utf-8?B?dWhFdkRWdDd3aTlNVTgzU0syQlE0NmVqbkJ0S3NOQ3JBKy9sbTd6THJua3ho?=
 =?utf-8?B?Y2VwWlVLN0dXZDdkUnZuMURxMHNUWGYxTEZ4ZkxmbmwxRmdFRjJsRmxkYXEr?=
 =?utf-8?B?YmFMcHZZSEFNRmFJczMwOEpHdDB1SVZ6bldCVk9WYWdFbDV2bEZMK1pKcGJI?=
 =?utf-8?B?Ym5GOWhNQ2hXSER6SjdmS1Q2TUhxQjEySEZpUkpHYy9tZnpUYWR4aURwQ1Zz?=
 =?utf-8?B?WmduSlQ3QmRKWkl3T3BuUzNlb1o5elNvdndmVXo0cE5MTkJZVmVlTVB1dlFu?=
 =?utf-8?B?OFZtUFgwS2Q1OTRoZUozWlV2aC9UY0NXQ0FmUEp0NUhFeWVwcll1d0JDaFg1?=
 =?utf-8?B?YUFscWhKNnFjQWFqSmEzKzFJVytlVVcrV1IrdStaSUtqa3RSdUJsenRWVmsz?=
 =?utf-8?B?NnJHdlB2Y0ZoUmxrdFVXWEYyVDJaemh0aGJrNGFXS3lib2pVdW5HNjJjUmpl?=
 =?utf-8?B?OS9NZzFqM1M0T2M0VlNvdTdLZVZ5Y1YyN3dDYk11NzRNNE9remhkdHFsY2dG?=
 =?utf-8?B?MUc5M0FVVUtDL0kwdFE5eXJ5d0dYeWxsV1VsYmpKUUo2NzFndFAvQ0VZS3B3?=
 =?utf-8?Q?1dROavkxNtVPIJE/p8lUjLFfppCvmDJZ8D6WCgw?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0de959-7369-4698-986e-08ddfeea430e
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 23:53:46.1366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAUPR01MB11101


On 9/20/2025 3:42 PM, Manivannan Sadhasivam wrote:
> On Fri, Sep 12, 2025 at 10:36:50AM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add PCIe controller nodes in DTS for Sophgo SG2042.
>> Default they are disabled.
>>
>> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
>> Signed-off-by: Han Gao <rabenda.cn@gmail.com>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   arch/riscv/boot/dts/sophgo/sg2042.dtsi | 88 ++++++++++++++++++++++++++
>>   1 file changed, 88 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>> index b3e4d3c18fdc..b521f674283e 100644
>> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>> @@ -220,6 +220,94 @@ clkgen: clock-controller@7030012000 {
>>   			#clock-cells = <1>;
>>   		};
>>   
>> +		pcie_rc0: pcie@7060000000 {
>> +			compatible = "sophgo,sg2042-pcie-host";
>> +			device_type = "pci";
>> +			reg = <0x70 0x60000000  0x0 0x00800000>,
>> +			      <0x40 0x00000000  0x0 0x00001000>;
>> +			reg-names = "reg", "cfg";
>> +			linux,pci-domain = <0>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +			ranges = <0x01000000 0x0  0xc0000000  0x40 0xc0000000  0x0 0x00400000>,
> PCI address of the I/O port starts from 0. So this should be:
>
> 				<0x01000000 0x0  0x00000000  0x40 0xc0000000  0x0 0x00400000>,
>
> Same comment for other nodes.
>
> With this fixed,
>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
>
> - Mani

Thanks, I will fix this in next version.

[......]


