Return-Path: <linux-pci+bounces-36174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AA3B5802B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 17:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4512A0903
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AE231D756;
	Mon, 15 Sep 2025 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="igEDSQdc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S0mHlJmK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848DD3191AB;
	Mon, 15 Sep 2025 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949276; cv=fail; b=A6EJZMMijdwcSI42jNQwn0s8KKZujUT/6WrjWsXjOh7/+VKIK8cun8eR2O9oxnabr6VgAdmt9/u+v6ztLl1aCcJDnizuehoK1IAm/tpLRH+hAhuN6gtVfQiezLT9e8VIbxU9c4TDYuREh7TVdA/2UArRGmvGLxN9Cp8gfdEjjgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949276; c=relaxed/simple;
	bh=O15tWtYkFrUd7lpRtTuR+Q6p8cJwVedHtFTLnJNuR3Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rBu6dwMbyHU3Y3WPdSz4dX5nBQfSiCLgPNTjDXn0FTxH+3ApXM6wyp7uxkPeFIjubehNEnioejgVnzliknMkYOK18eyx7sRyp5PaM74wW/MTZLOgLwLyghyPE6n5JOEQpceOmsLipPzNm3588QRIhJYKVskzzpjyyA2WElcuXIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=igEDSQdc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S0mHlJmK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FEMiqo019902;
	Mon, 15 Sep 2025 15:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pwrkzCggQuPmENi77EVZKy8tQuTw5Us30ynCmnR3ES0=; b=
	igEDSQdcn7/aJpzEDG2o8qEVehk60AgldLZFLgQvnHwbVv40/A/9p25KBSnR96TB
	xbNzXCytenCDpyivKIqOEGiqHLPhGx6emiHjUI804OU2w6msJtrZxJsnuSZX1xyM
	ia4DrPND57p5RqbHOdPuNOR3HWREN248fRs38um6jQnSHdMpgH4xvoKW9fuY9Ya6
	S4hQleHb+fWnvCpwr9Go7RqZKKzoxJa5aIpNcSxAJH+tbnWR8Ci/aq2JZYT7EBYL
	HlV3upwCKSKLDF6729Hstbo3GiVLH7Y9Yv1LRhQLYtzL+Sfq+oe1LLPTO9pAgn69
	/ZhORQTfI87sastgUSWkPA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494yhd2p7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 15:14:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FF1xbs011168;
	Mon, 15 Sep 2025 15:14:20 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2b5h3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 15:14:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tg4lM3t95DfY9I0itwwFXjP6qKQJmEqe+c6hKh0ug7EfmD2pIUW/BmxUaRAvg4c7GWUHeJBajbIbHaUimvB1DSUvzb5Xz8HoYv4UV8KI7A2Ts0hilGumXM42yN3qCaPnJyVKQropoDQ2X4zAj2RXxaUIPoilOkB867pB23cIzBcx9MnyoCLCae6ilBL0aCpsJDnpe5QklEpeQV+dvRPhJamSe8HFzA2Mbzvh7wrlVjdrb+5QqNhoF2IkTPfHUVvMHz8iOWuyi7CWS20UMDazuYsPe2U727I+ySQowu3+zCkieZrRDuXb0OQjdDJ1oYThxKqcv6STNU23TkcHvCp7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwrkzCggQuPmENi77EVZKy8tQuTw5Us30ynCmnR3ES0=;
 b=DUJhqJ+UuvL1oxrFugAGvGad12HcAR6Cy3My8ev9T/hSi21icA/8e/HKej2I1iclc7Sig6rMPJnUNSUeFLhY7zi0RVAgOifvhvPLFeMmrIvEuYJaqyEsOdcZGTPAqoELYmbeVuwmwg/sjdV7j1ZDJwCNG2vc6Fv3Fjibp0+fUQNT/utslENjsHc49YwdiOms/Vn7z4X0Nhq5YJayCk/7GgZkibuY+MiIeZYwVzukR9O34nhOiIcGUrCtIOZhShRgm6nIk1E1oW+s9gDTCKcR+au3nuDpsamjpUD+DaMoKcbGFLP7x1Gz0D6T58a/b38bKPq4rPO8ZeK2J713k7D+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwrkzCggQuPmENi77EVZKy8tQuTw5Us30ynCmnR3ES0=;
 b=S0mHlJmKg+NONG1fRV+1dA0Hde9FVT05YGQwE/Hj+pNv2sJ/hu+GzNlxP6uttvJRg2Ax5udv4zWITzwcqbYfE4l1sF3K1wMvs/oeAMT4CTJ1U4TF5N8k1A8h2Do4kEd7tUXatNo0puY/ho13LmTb3cViwGokt15UlDvHstqC3TY=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SJ0PR10MB6349.namprd10.prod.outlook.com (2603:10b6:a03:477::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 15:14:17 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 15:14:17 +0000
Message-ID: <74ccc612-beee-42a3-9ce3-947e59988f90@oracle.com>
Date: Mon, 15 Sep 2025 20:44:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] PCI: dwc: Support ECAM mechanism by enabling iATU
 'CFG Shift Feature'
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jingoo Han
 <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar
 <alim.akhtar@samsung.com>,
        Jonathan Chocron <jonnyc@amazon.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <20250909-controller-dwc-ecam-v9-0-7d5b651840dd@kernel.org>
 <20250909-controller-dwc-ecam-v9-4-7d5b651840dd@kernel.org>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250909-controller-dwc-ecam-v9-4-7d5b651840dd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0227.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::16) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SJ0PR10MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: e9608b26-af1b-4b3e-4a1f-08ddf46a89db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDg3eXBKWkVEVXUrZk1iMWlUV3loVDhWbXJtaE9wWlIrZkdBUUFRcHlhTVV5?=
 =?utf-8?B?ODc1SER6K0x0dFpVSTBxQVBua0JqcFdqRlJ5QTZBdFRkRkdkYWk3NmpJT0hj?=
 =?utf-8?B?b1F5WHVMd25ZK0lkVHo5Z2ZVaEI5Y0MvTlo2MktZV0txbDY1N29TMnRJRjdN?=
 =?utf-8?B?dkFZakFUeWViTE1tS3dRbDU5OVBVR09hc09kUDlCT2lOdlpFTFJyZGFOVW9p?=
 =?utf-8?B?akh2YlNQaGswdWsvR3Y5SVI3NDlNZCttR1R0c1lOaUs3K29rRFhyRXkvY3J5?=
 =?utf-8?B?WjlBVnFjQzJYdFlqYnNrNmhYYlU5Zi9GL21QSzZPUFdSdWUzWHJ2VC9BMWhO?=
 =?utf-8?B?QXpEeFUzcXdEeXYxakJsb3p5NzBzWVdzZDNJWU9VWm1zVkpjcXJ3TTRsMDBh?=
 =?utf-8?B?M1RQR2JVMlhGR29TSWhmYmlsaE9wb0pleEswYjJRdUxHZWFUNlBSTnB6OE9u?=
 =?utf-8?B?aUtsK2FDWXNGckE5eDVHa203cExidVkyaTB5NHVhd3VoRUJ1NmJXVU54MWw4?=
 =?utf-8?B?WkwrNlRQbUhaS0U3R0JVSVV2MkY1My9qWjYyOUxXdjUxQ2xvUnBya0puWHd5?=
 =?utf-8?B?dEd3M2pEQmgwRmN0VHBhLzRlUnBqeTFkMlhDczRXdEdqOE12Y2wvWXE1NjdV?=
 =?utf-8?B?MjdGMnp3WXR5TEhwTGZqQ0VaenEwWXRuUTJ3eDh5amZxaTUzRlRQeGFyWnNy?=
 =?utf-8?B?QmZqMTZzTCtpS3FwaGNVNFpscXlpcG5YeStabzJCckNSNDdZTzk5c1BWUzlk?=
 =?utf-8?B?eE9oV2xaWW90L2RuT0hYRkM0VkdqeDAzbFh5L1FoRUd4M1k5WHNFV3J5dytJ?=
 =?utf-8?B?bVNtK3I2Qkh3OXFQcmphZWZ1UG9URWszLytaeGw5aWpXOVhZRlpjWlorYktU?=
 =?utf-8?B?L1NZajAwZXR5Yy8wVFd2dzlLbHNlQmtUekZTbkdWazY5QVdUZ3FBWHJFRmx2?=
 =?utf-8?B?dzdHUVUvdm1vL01DZW9KWm43S284YzJlb3prMnM0RUVSSUl0QnBDS0ZIM1JW?=
 =?utf-8?B?MkhtSTI5dEd4K2RwbHdSOWVNNW9naE91M1Y2eUNNMFd5N0xkUlJNbGc3SGh4?=
 =?utf-8?B?Rlh5UFk2SDVMbTIza1ZIQ29HazBNamEyNWxyWHFjS1AvL3ppL2dTR0kzWlYw?=
 =?utf-8?B?czFSd2c0b1lSb1R5dFQ3TVRkL3dIcmUramN4Z05TcHR6aHYwekpyYlFRQS9O?=
 =?utf-8?B?ZGJ5TDIrTnBkNzlSeithNjV3bCs3Y1dzeEpZZ2ZJR05iUFpKYmxiR0RpSUhP?=
 =?utf-8?B?K1l2cVl3RlV2UHU4ZXNvcUUwSW00c1hqaEVIdkYzMmVjK1prakYyWVEvbG1W?=
 =?utf-8?B?ampFbUduWE5iWjAyWEwrdUx2RFZGaWtIR2FtdHNxcFZhMnpsaUxoelVUK1Jo?=
 =?utf-8?B?YTRzaEZ5NXd4T2RFc0pTUlo4Q1FxOFpPaHNuc2dHZElma1Zyc0xrL2NlZWs4?=
 =?utf-8?B?L0IrdjlUdDhmYkkrY1VOK05Sc0M0MUFNRGVVL0VWUGVFWXcxTHpMNmFpR1ZV?=
 =?utf-8?B?N0xCZzhETHZ4eGtiN2piMGhzY0tXSnBhOUZBZm44MFcxU1NDSkZTdG5iNkh5?=
 =?utf-8?B?WmpEYkRiRjFzUTZycUwvU1E1UlFoUUtJdkRLd0FLQlF5S1k3SkxJejdjVXo5?=
 =?utf-8?B?V0s5L3NSUit2cGRraTdmeC9ZNWFBMGZQWVRCWk1sRXRqa0VNeXpwREQweW5q?=
 =?utf-8?B?dlBQcHVhaVhJVUtIb3ZhMENlNUhGRXA1ZkFjTHo4UzZkTm40Y1BRZWFhZHh1?=
 =?utf-8?B?YzFaVUhYQTNkczhHTUxIb0NRT1lHS0JKOThrVm5WcmJURjQxUkVQWHFDT2c3?=
 =?utf-8?B?OVM1bnYxUHIyNFd2OVJUNlcxTk9XcXQ2SEJydFNaNWxIL2tFa0Z4Q3JZd05z?=
 =?utf-8?B?dW44MklMaXdpMGtja0M0NFZqQkRGREdzQnZnaXptY2NESDRVYWpBUURGUzRY?=
 =?utf-8?Q?lwiAUciyOaw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Si9GdVFlM2RSTUNBcXZQZHV5K1RVWStuRXE0NUhpSkhMY09iNEhoRXdZcTlJ?=
 =?utf-8?B?cHVTWC92cmtHK1lKYUYvWFNpYzJmS1k5L0ZiaU1FenJ2RjgzMVowd2Z4TTBE?=
 =?utf-8?B?K3hKbUxuTGlGTnZuVTJaY1N4ZXg3ZnhHVml1emU3Z2M0cDBHcnJ3YXp3Q1E5?=
 =?utf-8?B?RUhBQjhmUi9qWkFKdU01VHkweTQyTU1nemtCeWVrb3NTQjgxTVdtTlExUzRS?=
 =?utf-8?B?VnpzMXZYYkdOOUJiUGUwR2ZhaTMyWXpIYmRXaEEyZ2J6ZGlEd25SNGxkSnd3?=
 =?utf-8?B?aTdMa1VXOXFDeVRmdGNqWEFWcUxVQnBDbVRpZFlLQzVRVGM0OHpHaHg3N0ZU?=
 =?utf-8?B?aWZ5V1pwUWpjdGJzZEtFVk1rQ2xvN3plY25vRFdMa3dOLzNzelJUOWVxeHdU?=
 =?utf-8?B?NVdwaHF4a3VDZlZDV3drc3RkZXdPQzZMQ0RTZVVnWUZJVHZMNkRGQU9LcW90?=
 =?utf-8?B?RUUwTTVoU2IySVUwY0UveVpodzFOSU9YeVU2Q1lmRkdFTjkwUFRpN051a2N5?=
 =?utf-8?B?NWtPeFkxSTkyelBHNkdpc3pZcDBvbjRwWnNndHk2dVRjMy9GN0FRbnhNZ3Jl?=
 =?utf-8?B?VUZ1emRXYitSWWo0bjJnd3RwT21hekhaaFNhcE9WNzZWK1FDcFRqTnZJUHNx?=
 =?utf-8?B?ODQycDZQZGZGaWR0RldPR2JmcWV0UEx2dXdhQnFNYk56YjRGVjJUVkgxMElN?=
 =?utf-8?B?dlJKY3BZajJLdnE2Q3dnSmIzS24vOUcvRjNRWWpzT2dST2dhcitqTzFPalNv?=
 =?utf-8?B?YXVQVU9SV1k1YnZON29QVVRQL2pqa1ZiZVFYM2RnenNzODNaQzVRYTNvWEMx?=
 =?utf-8?B?dmdQY1Z5TlNLSUdvRkZnaUZCYUU5TVBheUg4aFdlTlpwditydEJRSVlBcHZH?=
 =?utf-8?B?b3QvQWpBbzdMZDhKMUVVQVo3M21hSmljaTdBV3FlOWg5VDV2d3I3RGdHOFQ5?=
 =?utf-8?B?ZitES1B5Y1J3THVXRWxDb0tQZWhwOHBmTmNmRUtIMUpaQXhSSjR3UFVaeWdZ?=
 =?utf-8?B?VUlnU3pDdzVBbzZlRWVEMG1NalNjRERoZEwvNDZ2cno0d2t2UFpPQnJySVVV?=
 =?utf-8?B?TmdIWVpIMTFNc1Z2U2FvaU1tZWRETDlWYWdSL244TkVkenQ3ZEFDNHJDd2RS?=
 =?utf-8?B?VFlpUWF1T2d4THZEemNaVVpkSytNbVBneWw3NHpTQUNZVk5sWklCN3VWbGVm?=
 =?utf-8?B?ZFJZQ24vbEdheVZnM0JPZFBKdTlNRFZlbk84eDVFMGxOeU1vYzdyOXhTUUpK?=
 =?utf-8?B?WnV2K0oyZzBkZDJaNnhZTCtnRFN6dVpEUDNvY3UwbkQyZDFHN29NVFRsL2RI?=
 =?utf-8?B?VTRLejh6NytpQk51U09HZU9UWDdCMXRpaXVZdDRNdlNrbVFQa0cyZWNzbVhr?=
 =?utf-8?B?NUVUZGR6UlhTeEJ0cHRjbG5qS3hLL1NkQmJoUkgwZm5IZWMrZGUzL2RMQmRt?=
 =?utf-8?B?TWgxczJBUmkyOVdud3F4YmMrciswMFh1NjRRZWtyOFZyRDNqQXBWUm54NndK?=
 =?utf-8?B?MEYyUzRKWTl4M2xBL1prZmlNSkYvdmYyaVNDZVhobEtoK0h5dlVaTWNQWmpN?=
 =?utf-8?B?RkhmNzhJeUw1cyt4OE56RWI0d0NUNVBqMm1uL1I4ejlULzVhN0JTaGU1TTNH?=
 =?utf-8?B?RHBIZTBkZW1jR05Xa2IrM1MvcHVMamIzOTE5RGpJR1lCeEFnSUIxR3hpTWdz?=
 =?utf-8?B?UC8zdHBaVWFuWnRsUC9ETklIMFBFMnRTalZYMTlTUEhnaWR3R0dsMytja3Jo?=
 =?utf-8?B?ZmorZ1VZcTN2bjhwRWl5NlY4VUh5b1lMak1pRm5OeExPTzc0N3owRkM0TStW?=
 =?utf-8?B?bldxQUpYRmx5enNlZlFieEJUbjJhMExpL2tOdmx3YmVuUS9BcGw1eC9hVk5q?=
 =?utf-8?B?aER6alVHbEdVSDRKUWdFWEZhb05rcEhIdENxZGlDK3d1bHk0Mk5KRzcxOThi?=
 =?utf-8?B?R0VNVWtTRGhkVElKTEtTOHpIdlpKUXExbDZOT2JUVUFRSVBsb2FxL2FER3FQ?=
 =?utf-8?B?eTZramlabm9nOFRPNTR6MlZWQ1B2WVQ1cjJncUpVZWZXRE1XVTE3QmdkQm04?=
 =?utf-8?B?ZW5oZm12LzlXakR4d290R1NLZEhJZWttNEhDNEM2bnYzbnJzdTk5eE1TMW5l?=
 =?utf-8?B?V2c4WURZVEc3Skc2NEwzdVFFbGtSMGN5eUNDd3dnUHpucUEwYU1BNytPcWdh?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c2BHnrSdUeal+CNx7oo3CSaD8ynIK7yYFqtp7MKx+DkyioCOi/JIokM1x8L5P6+KxjhTo7jNS/bzUlcvXH21bq3hqPPUo2KO/zd6NwZOPXRMCgNcg2mRwwy/WKe9tGIxJA9q8ilmYPMbhB64HbccovA5DLSxfUPxlkblnG6vDP2RTOx6snV7SpM4P3xruwkIDLoQ5daBARZHVqjB3FxhxK/MNG8/xjjB7LZBs704N5gKzMk5DfDqNs2W17A8VJ1UGQ0s5aW7+j5y+5LMFgKpGbuEqNFTcQ2JMI7PwKG/ml3ZiYCwifimbSO4jImGvPV1LT4wGCH4wxbteHCqtF4K8btZ79NR8Xz+f7yHYxDEyiYjXQitf8FAnD4zUtQ7U3FVOM5KrBwG7PBvzGSiGMY3YiUz9RB3r97jZATyCMo9MaOTsSvxPzGnodEj7XU31M3i/vnjw2XYHUOVJBP89vFXJinTre+OVBNU3dLLm8E3K3SZLD7fq1Ut/E9YJLuHkS3yMpgAVgnhxjj1gJMEbUYe/PxTBfsSAm00uZWcrI+Ynv+CI7ttj3v6zCWfYXKV87BcI9W7MC1Hqum8lvMvzPqFjw+8DlNrQl7R8V06fXRXI9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9608b26-af1b-4b3e-4a1f-08ddf46a89db
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 15:14:17.4646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRmS5qs1zizkyA5A7vKkYIbmqRtTrRoxb9J4iIVj50tZ6bTIuO4ErgXZ6Gc9PgCu6ss+1a7SB75gEGzuZlWFInFzzOy9IJflmc6+uv3z4pI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6349
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=684 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOCBTYWx0ZWRfX9THMO5pIw2SC
 1/96FNgbHN+NVkJAPcurK8UUT2hk5b7loZ3y5sWV9UVxLALkrQa7OMTa2eNbWGlY1PPpWm5Vfez
 9N/+zyy3MRSLPBsceOBG/t0JG9jg2wH2iewEI2ztfjc2xkbUJnig8gx8fbhTzGY6Vg42/hzepqX
 ZTdoX/LZu+hE6ppMQmaGmw6HAo7N/XVs536xxcNYgL95UmKKGF8b7frwIFyCTli+CNlP5tPgeYi
 0Ygtd5AF+4b3Oqo/HDHf3Zerk/c3Ddh/NKm0OjejkoofjLUSPbDwKv+q9MmgjyuREBwKSrSbRx6
 QvPYSGGGkUMGlqvocPwbBod24XK2R3mWsoecX83wItjEvmscsE62miFSr70LO8OzL7UCWe8Guof
 2e+vE3A3
X-Proofpoint-ORIG-GUID: ICoGWk3fWDXV46iZ_XItRny0rt4WEod3
X-Authority-Analysis: v=2.4 cv=YKafyQGx c=1 sm=1 tr=0 ts=68c82d4d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=KA5JyWV0K4rStvnKX18A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: ICoGWk3fWDXV46iZ_XItRny0rt4WEod3



On 9/9/2025 12:37 PM, Manivannan Sadhasivam wrote:
> Currently, the driver is not making use of this CFG shift feature, thereby
> creating the iATU outbound map for each config access to the devices,
> causing latency and wasting CPU cycles.
> 
> So to avoid this, configure the controller to enable CFG shift feature by
> enabling the 'CFG Shift' bit of the 'iATU Control 2 Register'.
> 
> As a result of enabling CFG shift (ECAM), there is longer a need to map the
> DBI register space separately as the DBI region falls under the 'config'
> space used for ECAM (as DBI is used to access the Root Port).

nit : there is no longer a need

Thanks,
Alok

