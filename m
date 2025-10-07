Return-Path: <linux-pci+bounces-37678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6102EBC1F8F
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 17:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC613C01D3
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 15:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B755E2D7DEB;
	Tue,  7 Oct 2025 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HeeNYQzL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dB5HIPBH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290501E4AB;
	Tue,  7 Oct 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851884; cv=fail; b=TS+MqwHUO+xAo6zhM6aIuFCX0zzQNG7b6ZrHqWsYJw20coSIS5K5wG7QRckQP6Z1urT4E9+2ep/KVRT8oszBGoOdgbJBb7E7qPG7Rk405t1wMwnjEMcswRG6v8XSqL7EDaKz5t7Hk4SApnUKHTyyvYClQBti+WmPBcqflkVBa/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851884; c=relaxed/simple;
	bh=rgMJ7L0XKB6kAaiX0PSBkmmYJp2tLz+cnCR0UN+5HWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KsSSPbc8pM+2HRUtnR+xPQ47kHbhcNPM+5TBCQ7pY1eZ7Fn+bHnkE4sHuHD+FFkgoNKF8ljhIbAj4uNmBfci36TkkfAQk9oQqW79m35HE6nli6TqAlUs/z3am6KvBfFmRN2VEY8Rw8lOOA673yAbNX/CWDZUkEzM1i53fBRn8fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HeeNYQzL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dB5HIPBH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597FOeTi012667;
	Tue, 7 Oct 2025 15:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZHlvcgjHGHHvME1jwZZPtAr15E390tZy+o/H+r2SMvI=; b=
	HeeNYQzLyQ9HoKs2nKON62ozRDBRfTao9XADGHHrH8KDNZX4uMyANHtNOlDcNUIO
	ATtknz+4uTEu0z6s5Mqk49Wekyo/u6BivLVOUDqft5+AEmec3D80i24VlQq/1Ssw
	s3x3Kg5atjvMASSobHiUVX91+HPUUPtBrpfIJSGiTUlR7kmDfM2NqBzL7pPqtl9p
	3/7TAmDMm7GCiqNaVULQuz9tvXRrr6S6+8I8U0bPM6W+S6kmdKV8F4AU61DHaoOd
	8l3sAsnYDrniDgTZy9nYDM3e68KTbDsTOePnotCg3NFH5fHZj0f62qlIXoDvIC/L
	FRPCGqgjEm+7C2RPkvpbyg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49n5fq81rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 15:44:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 597FJlbE004221;
	Tue, 7 Oct 2025 15:44:32 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49jt18ma2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 15:44:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ef8ylZh+pJeUs42xlAufE2pfNgYV7QqO0/+ST+rDHGUgW2vsTFa5ICH7TTKJADC1TXnVjsuO3Nx3yZmARGL3ZueNH/8W6GhWEsrwXG9vSWY1B/FjY/L07NzzXa2o9Q5EtCyPMJNPNa1MwYvQOPfhXXeeW8Vu4ve4KmHBcxqihaRYucphM5LwkZVhssE49ncf1vuJHTRImmWF/B7K+5c4TDO5rqXmatOKbiBZUD4ncQKUBdwZV9/YqRYa5Dbmt6NwRtwxNpVJihCryu8kkO9+k7cwn6gfpVdGkcR69Dybb5eoThAw3Oo4WahyXxxC846/kpBr0GtgQtUOFYwOXH3Cdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHlvcgjHGHHvME1jwZZPtAr15E390tZy+o/H+r2SMvI=;
 b=iu6H0ktugR3OGWV5EYoqrFdc3FwhYiTD1d+k3T3FsPqoObq2px2j1+woojM4O3Hx9OtZCsVOcgz9HkWNntWL4B4+zaCAKzt7cutjK4QNuKOJpEPZtzPNzRJ+RGGPCL4m8VtQn9sG+nos9iDeF4pNlKvsBfSh9AIDEqp30Zzvfq8rOj5CaJolsEs3oI9RBwFCwgLBoRLqPfUoClrEIkO45YcKhHK1BkbUxqx4Mv2rYz2LZDiQBhYkm7KtkyFamTcLmSNqkX9YiaPBnU5ibKg7bckyG0BoDj5FtqKVjfaF1tsnRpimRO7gSklA020sUf+hbjlqXxdMr4SdRC/5K0GkTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHlvcgjHGHHvME1jwZZPtAr15E390tZy+o/H+r2SMvI=;
 b=dB5HIPBHZAMaAN7IBFdTvOP6CPoZrAU8dsSw4xcyZ2fwMsQdZX4+8Sd2qMHxtFV00QANYhyerXRwXgNR/gFd6zffkA+9ICiSUCYQfxobjsmksNmhk4vBzvgtudGA9EoovNx0T9TQGx9I163ZdkRYrl5Qc80qq1tb9EfU51euQHM=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by MW5PR10MB5806.namprd10.prod.outlook.com (2603:10b6:303:193::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 15:44:20 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 15:44:20 +0000
Message-ID: <58752008-feee-4928-a9e1-1fdf5c01a353@oracle.com>
Date: Tue, 7 Oct 2025 21:14:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v4 2/3] PCI: endpoint: Add API
 pci_epf_assign_bar_space()
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, imx@lists.linux.dev
References: <20250930-vntb_msi_doorbell-v4-0-ea2c94c6ff2e@nxp.com>
 <20250930-vntb_msi_doorbell-v4-2-ea2c94c6ff2e@nxp.com>
 <c9efa64c-20d7-4aa6-815e-2be040480ff9@oracle.com>
 <aOUtlUIcHE8JIO4j@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <aOUtlUIcHE8JIO4j@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0046.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::12) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|MW5PR10MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 88aac014-271a-49e7-89c9-08de05b8612f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmZIQzNsUkRuZFdvdjlBMEJMWTM5Vis2amJ4RWJRUlB3bk90RitWWFZ4NVFj?=
 =?utf-8?B?RG8vYVluZ1VPbkdrdEtmQzRsMEdMTmxJcGw2dnJCUUVXdU9YekhlUnVPWDhS?=
 =?utf-8?B?MlMyWlpwckdpN1pkWmNGM0ZSSkNLN0JEZCsvMFl4ekQrSm5sdk11aHE2VHZo?=
 =?utf-8?B?bXYweE1mNnVnMFBkNGIxYTRUQjhwT3NuMTN0WGUzekFqL1Jmbm1HMklVdFFk?=
 =?utf-8?B?aTBOK0dHcXpFbGtDWlMwQ2dpdkVvamFIeXpCOGpTK0tsN1hhUnQxOUQ0RERU?=
 =?utf-8?B?dFBGQmYzNll2bWtRM0tseU83UzV3OE5rMjREazdTSzJTbHNFM2xKb1pRalBn?=
 =?utf-8?B?Y2Zmc0RXcWZFMk1zQ0l6aENDeWhhWFNvcGdCSVpNMU50clNnc2tmY0Evdmpq?=
 =?utf-8?B?RFk0UWRVZStmVjlldjUydzFHQStqTk50UnA0WG8zaFJBZkg4Rk03UmlRSndz?=
 =?utf-8?B?Ykd5WExwUXNWQzFRbGxmTlFpYmE0bXE5blNoUS9JdWdCTW1XOTBTNzhyOTFk?=
 =?utf-8?B?N0tCaEx0OGtucURVNmVtcmN3a21xaUZiSFJXandxSlQ0dllnRUl5U1A4aFl5?=
 =?utf-8?B?QXQvSGU0SmdFNVp2YXVQcTB2VVZRcDA1U0ZYYjRHSnhRcTV2K2NFK3phbWlT?=
 =?utf-8?B?dExMT3BCUlV1WmhVSkc0YWFISHU4cE9ibkZYRzJURFpWd2tQcnRXd243S3g4?=
 =?utf-8?B?NGNkTitnTi9mZXdjbitGWUlIU0tRKy92TTRSeWx2RC9BNVVhM2ZEenNmZG45?=
 =?utf-8?B?d2txRjFNTVRrSXAxU2dKWFlZUWdXcGRiSFBTSisxZSsvbk9wQ3BtVEZ2cTY4?=
 =?utf-8?B?dUE3M0pjWUJ4SFpUYU5nRGhKREJFUTRKSHd6dXlqSzhmSmVSNm5uV2FyWFBY?=
 =?utf-8?B?N1N0di91a1htaGN0WG11a1pWTW5lRit1R3ZERTdycVUzeGlyRnI2N2hMallp?=
 =?utf-8?B?ZkJiTlFwRzBuYzN6ZVJsVVoydmNQQzkwNUd4SGN6R0VGZWh2ejdBUHRlT3Jp?=
 =?utf-8?B?a1lpTnpXS2ZQSFd5MEZxMnRGdS9HM1pxbnQyZ3VZc2lmTGNPQjQ0RmhyUDNL?=
 =?utf-8?B?b2dyWW9tcVpFcVFyRWhSK1JUTnYzUXl2OGlZWEZFOC81VTl5S3J4RmtoanJT?=
 =?utf-8?B?S2hnRXJPalROM3dJSUZVNml1TlRBVWpjNWtTUm1RL2dISUZpZDArc1dVWEFC?=
 =?utf-8?B?YU10TkhSU2FYYW96K1hDTG1tTFM4T1Rqbk52a1pWZHliRFJxOGUzcVMvMW1o?=
 =?utf-8?B?Y2dBYy93QVIzeGRqMFMvT29Dak1tMXJ5QWZteEVXaGFkZ2w4a1NQT3JJUW54?=
 =?utf-8?B?RkVHU3doYTUrb1RQcS94WnpZRnY2bC9MU2plUnhPWDFOb2lWbmZOa3BZcitT?=
 =?utf-8?B?NnZqS0Zna213MHlBTlVuOHF5RFR2YUZKL25UMTNUQjRpaGNDeXE4b3VNakNL?=
 =?utf-8?B?VDN1WUYrR2x2dU9WUTY1VHFiUnhEcTFGaXp0RFVQclBWbCtCVGtBZzJ2eVl2?=
 =?utf-8?B?Q3VGQk9aS3pzWDJTcGsweE9tUTNFUER0ak0wSXQ1Q2c1emM0Wm1PQmpIRjEy?=
 =?utf-8?B?V3JqdTlaM2t1Ny8rRGdKMW90L2p5ekpCeVFpblRINE9KMjkwQTUxUTlhRitP?=
 =?utf-8?B?MkVyeGN0eExXTkZlN2dzTVQ5OXpQOU9PQk5lVmNzMHlONnp5ZFNBdXMwNkJl?=
 =?utf-8?B?RnQ2cDJURUc4SlNOSDJLd0wvRFkwMzU3OUlSZkZwRXRLZlBMcmdWYVl0RUNW?=
 =?utf-8?B?ei9DK3MxSnNwbHhBRjNWUFRHWnJsMlFRVnEzWlJhMDZENmtvZUNmWWVnU0dR?=
 =?utf-8?B?bG03clNyRlFqOWxhakNaajJZK2EwdkVlK0dhSFZxdkxvVzNoMGtlUDk0bU53?=
 =?utf-8?B?QmZnUXBvS0l0bXJLV244d3BGcWh3STFKK084V0VZQXBGOERaZ0dGMlU4cDYz?=
 =?utf-8?Q?3WX+3vpH/cuHaXyJkRky1dVGlT42CRKw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVdaeTZDNm5lUy9yNVRqek9hWlZLbm9lSVdza2t5WDNMYnZFNkpGRDl0Nmdh?=
 =?utf-8?B?SnlPaWdoWXFDZ2lxS2M5VmlrK2pQbW9vdWt0QXpEY0hPb2o1Y0xIVVRkWmo3?=
 =?utf-8?B?N3JiMUN3Sm1HME5DNjZzdUNlT0wyMmlET1Nnb0ZodXlBZFp0VG1kWW56T1A4?=
 =?utf-8?B?NU5ML1hTS3F1eFVxWXVsUDBTeVIwU1NlZ1hXK2xwR080c21DWWNWZDNYTjll?=
 =?utf-8?B?MWZHUnczenl3dEZKVkRITitCTGg0cEo4N3JGWUkxdWoxdWFVV3B4QXFNZjcy?=
 =?utf-8?B?K1I3R25aSDVMVVNzWndlUWJSdlBCUWE0NElCN3BzcVJvSko0K3R6MFp3dEtO?=
 =?utf-8?B?RWU2UisvWjFMLytxSkpLczQxQU0wUXhrQ01pMVNNdklwTjQwcVJVUXJoT3pF?=
 =?utf-8?B?c1ZqWW92MUYzdE80V293NW5EVktCZk1PWHJpdjdneVUyaC9QQytnSHJYbmR2?=
 =?utf-8?B?SG80NkVIUzZhK3ZLakcwVEJkNEN5ajlFRXMyT0lBeXEyclRMZnAvTjBCQU9S?=
 =?utf-8?B?TDRUdVh1eFVzWWthNEMrRWkzS0luU0dJSEtRZW1IZmc4NmNBcGVUano3SERa?=
 =?utf-8?B?aXlkeFVMZ1ovamZ6YVFBYnoybjJTUjI0UlZZTDNwd3cvd1AraHZkTGVtRUEr?=
 =?utf-8?B?eFI5SVBTa0lDaHN2MnYrSk5wcHVtRDg4V0JjcE5MUEEzUVNzSnJXS0FrbXZj?=
 =?utf-8?B?SmlMTDJ4Qno2ZkRnMTMvdmtTRE51U00zQk1LeFdJUGI3bHZ3WjVBbE0xTC9z?=
 =?utf-8?B?Z1BTb2E1b25tZ09WdkFJOHhpUGU3cTQ1amVVaVhYMDBsZWRjMWg5M1p4UVY3?=
 =?utf-8?B?YmQyYzN4cXBHWUVicFZZK3dUQVRPcDRmd1ErME5mQS9qNnNMV215YWNZWjRa?=
 =?utf-8?B?TXNzY2RrQXVlMGNqN1JRZTZBVkFvK1Z3ckhaS1VvQ1JOVzByQ1lyOFkySXRM?=
 =?utf-8?B?SXdkTFJabmloVkhWeStEVm1FRU10MTN0aVEyNVl5YThwRWdNTC9aUmJVVzR2?=
 =?utf-8?B?bko1WFpiN0EwdEloTTZ4c1F3WExERDZOcGhaM2hjdmhqZ0ZTaDlwWWJSYm9J?=
 =?utf-8?B?cW0wamQxaVdqVFA3Y1htL0J1YjBDdEhKanlFc2trNURkWXRtbUljZUxSdnNh?=
 =?utf-8?B?L2c0dXdUM0VjOSs4QkNrWlJnT1RxRTIvUHVxYjJaNFZLZFFBTUxsbVEwWXd3?=
 =?utf-8?B?NnZub2JFdERtVkx0Y20zR1dkTXF1TU9JVDFaVldybituZlBtQVBxbzB5M1U5?=
 =?utf-8?B?ZExRVWJxVnZ0eGdTaW5rMTNkMTdMM2lRajBwTnVwbnZGb25taXBkTmEySGFh?=
 =?utf-8?B?RE9NbUFOZE5JNGV0ZmMySkRGNmhPRlg0MjNyOGhraXQrK3ZEc3dZNmxtNnlJ?=
 =?utf-8?B?ZUVoZlVzMDNJdkNuT0MvTHRmaHhDUFFJeWlwdlNmQTc2N1V5VWMvem1UV1dn?=
 =?utf-8?B?bVhDZm1Xc0k0NDFGUXdkemZzRkhqQ29FR3dObFB3cWt3OWV2VWlQOEVMOTVl?=
 =?utf-8?B?cVkyRm5JbDJUczJDdTBLQlpmUUdJaXJyYjl2QU5nekZuQXhZeVhvRFNPVUxB?=
 =?utf-8?B?elh6bEtpQ2hhQnEzc1kzU3lkZVJpaTN5R0txK2hvZGJ6eVZLTFZGemxVS1pn?=
 =?utf-8?B?UnF5am9KZ2FzKzRHS3BVRE0vWkV0K2xjbU9yM3VLQVViSXV1OS94eHF3Q3BQ?=
 =?utf-8?B?YnE1NGUwUlpzZVpZVTdoaHJLYi9jTHIrQTFnRmk4a3U0Z1JGSVJoRXZuODBl?=
 =?utf-8?B?MFJDRTQ3VlJ4OUVnWFRuNC9aYXpNUS96bXhQSk9IeEtrYWowSCs0UUFzTVBJ?=
 =?utf-8?B?MktqcGlSMDZzUTdTMnVlRHlYWkhkcDVWTk92VXVNa2p3WkFJV3E0Rm1wMSsw?=
 =?utf-8?B?TTN3bUF5WGNTNDhxTURFLzJta2w0ZUhmY2dITDZsRHZ5RUE4VEF3SHhJSWRm?=
 =?utf-8?B?WjRxay81RjRRTEo1WEpuQ1VFV24vaGNZcG42WUZ1eWRUN3NZaUVGbUZOVWxU?=
 =?utf-8?B?RUk5RzY2YUZxQyt3OTRGQ3BHaGRIdzhwM0krV0wxWlBIcjZxME1PYjh0V2lC?=
 =?utf-8?B?K3hjRHZNZDcxMWVFS3pZRHV3ZDlMYm55VnppbGVjZGt4c3JlU3luY2orNm94?=
 =?utf-8?B?UzkxTzJ6enRTN3Z5RTh3Ni8ySEl6YzBTanhiNzJ1Y0t0QjYrekw3SUNadG1Y?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VL+QF576vUURxDWwOo6yTZkhRRrswEiRYc/Epz2mJ+qiCpdUQPwX3BNWsFdJP5cclPHNQWGcfW92k5EjyRz9eiu1yPzczsHSiiRCpIu+5CUQxuyvmsCvpL0oXMjAB6cxkSy0Ou3dvdf6oOvU96ksIiNY5cbiMgomj3qpWcJHGK2VN68JnN075cpdebQFvIuokHXpmLyH7noE9AeEDPOMAcLMeE6VVcQ5+ElO6j7FDqxsJDZc5/RcNhn3ByIcpGAb7Rs3oxN6wJdFXMGPot9YzX0tUfF3HnqmdY+Bo/BBMFIVikE4qlL4YhqT6vmAHoClJ6zHG5QBHEBu9JT3omMqWf2pKNtu3QfkEKSKI6Mk3qv3QIc9Y7LjkagfN1lDyj0lGAXrb2ASy8uhqoazOJ0Vzt67f/OVntXgVNCccK5+S7SdcmMJYYCjCLhJ9oujmpE/Lz6TpuhMi3zJrARqX5d7bE7OFlsyGgQdAcYBSKMVDcLZI1nk/EGdtZp2E9WJmjbr0x3s/FuvAkLD58x5UiOOZwSJjKwFuRV43b7dv+oaZGZMIr/3a1NFAlXRyDzeyRLJif7B23M11ihqvGUDQ6TUue5KPB/UYhrzczbHxte7HCg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88aac014-271a-49e7-89c9-08de05b8612f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 15:44:19.9625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QX8A9c3iQEcxBP4HXdPv8u0BMiQUSe+6r4rkiLzD0qDU8HmU1yx7xutzB4/Pozo1/vdJJjsByv23dpjPuINMbaPN65aPpg7cq8iPP0J16MA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510070124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDEyMiBTYWx0ZWRfXz/MIQYiAxX4n
 ls4EII3h+qQcJ7oHGdHEzwJ4xuSPKiCuZnSvF0FeU1oIoV8xDHeYcydVk1Qt1PyAewN0KtYwC4M
 GGfDVrHnjHIVWe//zTEavq0p6ABLDRvtet2nO9gKRtmjj9ZLijGjtlMRQ2iYdFB9NxRZ+nNdRxL
 O5YsZ+GyQqHwDaqSVjtVHBP/54bi1R6EnnyM5RG00ufXC4NhZ1MsRUJfCUEAS5HMaTEc6Dhz4BN
 BWaDNtAyu31lQj/Mx/1ll8T/LhHwc1j04sYjrYANxrvA41BE3n1QJlgnrVtVsGYHyUCOi6JDMhE
 Wc+95E//TfTtzHtLCdfmT0v3njqjMsmeyECDwvFSuMHVj/oZVBEH5KwfEti6OlqXYTWvTSMOlrc
 PbbNEez2XX3c4oEvC3iybw6IcWkRxw==
X-Authority-Analysis: v=2.4 cv=Zojg6t7G c=1 sm=1 tr=0 ts=68e53561 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=eUXDsfDUolzc4ERvz1cA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: dQDX_mPkUmszaGn9SROxa7b6YCX5JKRN
X-Proofpoint-GUID: dQDX_mPkUmszaGn9SROxa7b6YCX5JKRN



On 10/7/2025 8:41 PM, Frank Li wrote:
> On Tue, Oct 07, 2025 at 12:25:59AM +0530, ALOK TIWARI wrote:
>>
>> On 10/1/2025 2:09 AM, Frank Li wrote:
>>> +int pci_epf_assign_bar_space(struct pci_epf *epf, size_t size,
>>> +			     enum pci_barno bar,
>>> +			     const struct pci_epc_features *epc_features,
>>> +			     enum pci_epc_interface_type type,
>>> +			     dma_addr_t inbound_addr);
>> nit: Any particular reason for using inbound_addr instead of bar_addr ?
> bar_addr is easy to confuse with RC side's bar windows's address. This one
> means the ATU convert bar's inbound transfer to what EP side's address.
> 
> The below API also use term 'inbound_addr'.
> 
> It is not big deal. Manivannan or Niklas Cassel, do you have any perfer?
> 
> I am okay for both names.

It is not a major issue, just noticed that the .c file refers to 
dma_addr_t bar_addr while the .h file uses inbound_addr.
Just curious to know the reason.

> 
> Frank
>>> +
>>>    int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
>>>    			       u64 addr, dma_addr_t *base, size_t *off);
>>>    int pci_epf_bind(struct pci_epf *epf);
>>
>> Thanks,
>> Alok



Thanks,
Alok

