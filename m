Return-Path: <linux-pci+bounces-37596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D82BB89B5
	for <lists+linux-pci@lfdr.de>; Sat, 04 Oct 2025 07:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D334A4859
	for <lists+linux-pci@lfdr.de>; Sat,  4 Oct 2025 05:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681D754774;
	Sat,  4 Oct 2025 05:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f6c3GYRl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rc5AM0WS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA033594B;
	Sat,  4 Oct 2025 05:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759554429; cv=fail; b=vFzRTZ+l5Qoj1oKSRnmGt/Nwa/9DzDgtfToNgJDlHxuZiTLxVAWTEf0m2NjBU66qgysy5R60j/GrjnnNsgo7nuI3PXviYjcWFnHWkDAOu0n+gFfZCdHCrTTJ0SaLOStRdLB1BoIMH0yghtTRtHx4yrlf7YTTaEQFd6PeQqQoo2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759554429; c=relaxed/simple;
	bh=OWx5mkn2/+L7IUUqtVWavLjBCU5Y9/Awg9OJH6EMFrE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OARYK4we2IoCfex7vr46/QoE+P0Z9TfF9e9PYsDEbs3rMEO59lA1FKPuy7CGy2/Z/2GrZbWJL24OXLVStdtzmzXC53KTtY46G0fNkCUfuQDEV4M29djOZfxr2PNgR/z+1JKWlE5MTqFhrdGrA/8GRTCju/R0mahi5A+zRM4MWg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f6c3GYRl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rc5AM0WS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5944j2gu011859;
	Sat, 4 Oct 2025 05:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CRgS2ztSMshi2BOmUL6QubPlP5++zY83D7ZtDn5z7i4=; b=
	f6c3GYRlfLluBuPJCV1LM90B24SpM+DkRD6nnJWcYJfRcsSFFvxkAkrHMw+MUC7d
	PT/5L4dhBnBFs6/Tb6Ah9tH0LMI5yKyuI41HhsqF54Vo917KhXsZ/M22fmlfyFdX
	xbILaq0EGBom9xlOSm5iMqwuEx85JjDi5XJEVulitTbF/NGWMT5ga1xLkd74zUcC
	zSUmD03b71Q2pS6oneCvEXselEBI0EulDBMwgvwD0EIEQYkX09d5AnII/mXiwTMY
	xArwQer5EJFyZ5KGIUV70y8aW4WOzkRgoeoFy1PJ6OkEs+NsEoFTIK5myJZ3b0ur
	dQ6G5ewmnUhjab+MYnNDQQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ju6rg1ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Oct 2025 05:06:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5941XOjq040890;
	Sat, 4 Oct 2025 05:06:42 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49jt15bf7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Oct 2025 05:06:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3//pyoB/Hk63uhddHMcrizWz1yzZ8oRyqJ7DOTcGxkV8tBVqLwuwc38aRhtpiPjnyuaWM0IWCbvf+Y6txfaLyHIa4oz/L4OaNADbX7/P9oN+9WTQffdzUxQwf+TbDFxyNgRKc4G1NaAUq570gwdtHrRfCnbIlFgxeWb4JT1VAASzbWnK65eZ+sTNezORRpptVSjsWT68bfBAJTsvZ8eeE9s5y3WUyLMDcVX2lsmwMd7BfYDBcKb8pgG9RfSQYD/edWX+OTTpbT2WDj16GwAK2XfAmQyYQWXElzXipSOCSDSI7OCAnbJIy0VPfMRbyuClyynFZOPZ+76l5iHTIl0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRgS2ztSMshi2BOmUL6QubPlP5++zY83D7ZtDn5z7i4=;
 b=gFoMRNi5AczE3bFar0u9IRzQ6ofX+Yq1tAnzurr0+a58SEOQm2b3msSXYf959GPJdJobe5i9YuUWsgAZdy4baCDVp5KVAT4Bfe9Te8VCt4Zxv0mXmKEtfu3KijWm2ru6M6Hq4Ce9oajKdkRpNdyayeKwVru7rRfDB5Q/ZXdQn1+XYXi/WoCTjZpbflIA5VRlGmkxyu2gG5pgxU2e1dKnhq0n7jtBaDa5A9cLEbyQrswlIfj83o3V/AFKaVfrKV72Eq1EZNFgm8LCJHX84pPc0bEkEPKAJM3NOY5uBFTfHjt0ps40eA8bJ0N4nW11Dbil2Ftlpg6e8oTO+Xj6pj4eEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRgS2ztSMshi2BOmUL6QubPlP5++zY83D7ZtDn5z7i4=;
 b=rc5AM0WSfEKXRC7Ck0mn7kD67E3AHpG6GSWOs9dIEG+jLuKtLeUk8J8feQEkAjaKPSfPmaeeMfhzYwKBhe3lexBim9yM0XuN+f6CsK/2R7iCGa/SwgDUOqZY82DXczxEthqaYt7XjCijiLz8Yxwn3omXPg0MtdnYpJBVARoKlDE=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM6PR10MB4379.namprd10.prod.outlook.com (2603:10b6:5:21e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Sat, 4 Oct
 2025 05:06:36 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9182.015; Sat, 4 Oct 2025
 05:06:36 +0000
Message-ID: <7efe5f81-aaa7-45b3-97d0-469ffeb35e5f@oracle.com>
Date: Sat, 4 Oct 2025 10:36:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v3 2/2] PCI: brcmstb: Add panic/die handler
 to driver
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20251003195607.2009785-1-james.quinlan@broadcom.com>
 <20251003195607.2009785-3-james.quinlan@broadcom.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251003195607.2009785-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0447.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::13) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM6PR10MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5caa55-18a1-413a-c6ed-08de0303ca9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2JhRmV4b1RYNlJ6VU83eXlHZkx5VVdRSFBVYlprVVp3L0FrVFV4dXhTczdq?=
 =?utf-8?B?dngySFY0cUQwUG92RVhlUUVOUXdVSG5GOVNpUmZXNXNrKytHSytEd3VXc2x1?=
 =?utf-8?B?NTI4VHQwRXhiOHgwUGJQNXRmWGo5MXE0d0k3RXJvYXUvNjFkaWJuOGpTdkNs?=
 =?utf-8?B?bVRTbncwdEpSMmtMTGVYbjN0dkxHRVdSRUJlcEVaR2NxbzdWYlJ1RFFXcDVq?=
 =?utf-8?B?Y2lxbm5paW1SV2xDSHYyRThpV1RUQW1ldkFUVVp4ZU43ZzZwNHBORGVSbXNq?=
 =?utf-8?B?NFVrbG1sd1ZzWGJzaHNIcnpiMmsyL1paaUw4c0wrUlZ6cHVvRHFIRGgxOU90?=
 =?utf-8?B?N3M0cnNUb25Lc0RYcnRMVURiR3JuMS83d3FWb3gxaW51V3E3SEpTZTNlOHFJ?=
 =?utf-8?B?RFNtdFhUQ01heHk2K2xTR3B5dC9QS0ZZR0dkR3NIRm9sb2MzZWFDM3ZEeGJG?=
 =?utf-8?B?N1daZzFGZ1p3SEJ5OURidFo3d1BocDc2WFA1anZnbVA5Y0l2aGlyKy9aWW9L?=
 =?utf-8?B?N0EvZEY2UXpKMXkzNVdmNWFJdGxTVHdMVHpZbTBFMTRZdzkrZzhCWWhsVnd6?=
 =?utf-8?B?aEhRM1F1aEhoQU1PaGFLSGJKeGx1dUd2dGdxWE9UTm15ZGpLVS9IM2YwdUpC?=
 =?utf-8?B?aCtmeHliY3pZN3hydzhSWjFkNnlMSTA3VTRpc3U1VTNiWG5WZTRBajJnbnFK?=
 =?utf-8?B?V3ZPbi9GYnR5M1BsOWxWc0l0WXVuNU51WHNta3BNMjlMU1V0MGxOeW1kcCtO?=
 =?utf-8?B?alpYT2NZem1FWUg3UkYyM29VRVNWQ0F0a01mbHE2U1ZWOFFOd3lKVFhPMmJN?=
 =?utf-8?B?b0Y3RmdkbTI3RXNHMURWMWppNFVBZ1E5aXN3NFArK3NQOEJQMHZ1Nno4THo4?=
 =?utf-8?B?NHBpRVI2T3pSNGllbEJLSUJFSENkOHF0VGFMTlBHb1d4eEhIelFhVFpSSXZy?=
 =?utf-8?B?LzZTZ2U3RHNQanJoN0JhVWR2d0NEeWJXckdjeTA3NWR5WS9GNEt5WEVBOHZK?=
 =?utf-8?B?NFZoc01KMXYwMkRzNTFGSzBSa0VNRGNkblRqVWdpS3lsc25XUUZQN1cwL3Rw?=
 =?utf-8?B?YkxTWGRGMlkxS1p6T1ZralYvYjUyV1cvNnY4blE3NWNyUHpEb0luYU1Saitk?=
 =?utf-8?B?L0dOS0tlRHdRQ0F2T09mM0JRSmcrUXd6U2lFaTFKYzZRa2lTUXVBL3d3N3M5?=
 =?utf-8?B?TkVSaDBycEJyK3gyQndueHVmMnMxV2RiUTNZcmg2TWY0ZXVyRlNSRGRjR3Fz?=
 =?utf-8?B?N3NVSnp6aHd6ZVVsYXRDeXpjVTlCQkhHTHBrdElyTGNwTEhUc2JnTGc0Y0dS?=
 =?utf-8?B?STNoZ3lzQzVYRldidGROZ2o3V0F6M1BIV3dxVlRDU1dyN0pHMUJzTHRmOG5t?=
 =?utf-8?B?VXJPVTFpcVRxK2Q1UTRGaE1CTXdwRk4zdjEyd05EMmllNWhYeTR6WXFsWTdW?=
 =?utf-8?B?TjZMQTRlZzcxR0N0T0RmMWNWREhpbDVTeGV6Q0dFK0pvamMxekNrNUVqVm1R?=
 =?utf-8?B?cDlSWjU4eERiRTdTVTM5YmpWQ0ZycDRvQmlSNzVhUngzTllicFhVMkJHNkV5?=
 =?utf-8?B?RWhudzFaWTFVNUpuNmpvSkJxSFRGZUlmeXAzTjVLU0RjVEJWUURwTGpGa3RJ?=
 =?utf-8?B?RTF0L1g3MGJWdThZN0xnT3AwY2RIQXRNSzhjOXRiOTVYSW5WUEZRMFZFVkNk?=
 =?utf-8?B?d1ZBbTJBMTZYWm1ucStvV3JTS1BxbkpKQTdTczhoY0VrWjFLUWF2aWpLQk1p?=
 =?utf-8?B?VEt0b0N3VFhSVVY3MHZOK0hCclFCV3NDWG9VVTJROWZVVW5ZN3FvRHhidEVQ?=
 =?utf-8?B?R1ZKOHpHRVdUWDJWcmxZMFRxUFBydkFWT0d2YUQxYnp5Y21CVHVHVjRoNFhB?=
 =?utf-8?B?cWcvK1lBY0Y0bjBGcWZtOHRTZ0pOSUtFcXBSS0J2N0ozWUlQei9mbldmMTUz?=
 =?utf-8?Q?Ji/LN05YQtG+0jwb7Rnr9LlFpXshwQXg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjlVcnJ0eXhrelRXSHFHZWlMOFlVa0VWYjkvS0ZRWmUvWkJCRzdhWk5ZSEt0?=
 =?utf-8?B?UjF2ZmppVjRzYVhjMWRJVk9pSWxFZ01ZUnM1Um5CQTRYeU5FNjR2elBkckxL?=
 =?utf-8?B?eWp6V01HdktVRG4rYVY4RkxKMXNXa2VGVUdmeXB4Z1hPenBBM0hmeFMyZDhx?=
 =?utf-8?B?ZGZ2eWhpTW00Z3NDWVJLcnZQUkZsYzI4OEk0NkVTTzVoZjd4TFA5T0R6OE5D?=
 =?utf-8?B?b24vY3ppQThSSElhdTljaDZuWTlzUk5BT3NyOXc3ZUt4QzN4aHBNVFVSVjZD?=
 =?utf-8?B?UHd5aU9xVjlzb2FuNWtLZGR4ZE5tNEQxeUtScUZYRHVhMjBQMW5zdGsvb3Vh?=
 =?utf-8?B?eVRnNHM1TzVmeVc0eFQ1N1IyYmMvM1BOYVZDV2dST3lTNE4rQnE1M1lQczZG?=
 =?utf-8?B?TVJtVlJ5K1oxWnR0aFB5bjJZa3NsT0dTa0RuRUNtaTY1V1EzMVY5bTk5eWVP?=
 =?utf-8?B?THhZeUcwUlFXTy83TzVyM3JVd09zOVg3S0pmQWdtRmltWnVoSGo3T293SjFL?=
 =?utf-8?B?TFpabUo3Y2g5OWtuSGlnMmVUUmw4YlRnRkR5akt5UC9JRXhoek00amhSaTZY?=
 =?utf-8?B?eW1BRU5ubTl0ODR4UUtYWGoxaEJYVGlEWEpybEs5TWNJYjlXSzFucHFERWE0?=
 =?utf-8?B?aExyM2Y0UEV5K2g2ZE1YOWttQzhhM3dHekJyNWF4UkJFWXZaUzZScmR3ZU1q?=
 =?utf-8?B?aXdyb3I4Qys3UjdGMW5jeStoU1hUMFZOS0pFM2QzUXp6YlkzUlRybHhFalh3?=
 =?utf-8?B?YlRwcVZmbFA5UGp2eGlBdGFQTkI5aHpvNkc5T002R2xtelE5dXROaW9INndU?=
 =?utf-8?B?SEdMd21ZUEkzclpoeis4V3JkSURJVzVRNHFkeWoydTAxVlU1QVVpbzBqSS93?=
 =?utf-8?B?Q2V2Yit2RmdEZlN5QSt1aTc5ODFnS05WeEx6NWhvc2NleGRwbzVJUjZuaHhp?=
 =?utf-8?B?SHpQa1JHZjFVMC85Mi94cmJnNEQ3WURuRUcvenhwL0cvbGNML0RyVUsrdWNR?=
 =?utf-8?B?SHdCVjZZUnVQQTd3VjJ5cTg0aXl5MzlwMDB2ZTZSOWorZyt1MHJ5MVJhMVJj?=
 =?utf-8?B?djFYMjFoZS94NGRDTzY0WUFyQy9FZWpJRkJFVHBqMVdxNzRYR1p3Z00renJO?=
 =?utf-8?B?NTNaVFU0eWZwaFdCcjRIRkZUQUxwTDRXRTZacW9rMUg2a1hoMnZtYXpGbHYr?=
 =?utf-8?B?WHd1WDhRTHFROExBYVRtSlF4UE9uWmpOWGVvdUJleVdtY0pmUWlpRm9VNEgr?=
 =?utf-8?B?VUFpaklUVUJycm0zOXJUMTNnTDloYzd1eU9UdmpTd3QyL1hMZngyV291ckdM?=
 =?utf-8?B?eWRMU2gycEY0RHVqRit1ekJlbjFIbXR2MmJtYWN5WDNDeURQM0JnSFdSWVNk?=
 =?utf-8?B?NE9OYk5CaGQ5NUZjMmFteWd0c1dmV0NNb2s5YTYxU3NlcmcrNlpuak93QjQ0?=
 =?utf-8?B?NUtVN3hENjJnRGhwc3gwbXBEMFpRUWtzYTUzTmFRQ1FDd01oUmErTjBZcEMy?=
 =?utf-8?B?TmdYeENlQnJmVFgwTHJYRjh3ejhUdmpBOWJyZHRyU042VEZVNFlZM0V3S1dj?=
 =?utf-8?B?RnZ5YVRsVUcrQzVnMSt5U016UzhNYlhYbEV4MDNta2pIcWRzTzlvK0FpU01o?=
 =?utf-8?B?d3JrUXJUcm13aUQzZklBTEJvQ0l3ZE9WaE9NM3VuRzBOd2J0QXozRjVia0tN?=
 =?utf-8?B?Qi9sUHBPYml5VS9BUHkvUm9hQVJUS2NZRGlDeTlWekZoYitBWk5qV2RpVDhP?=
 =?utf-8?B?aUJEYVFHWUY1QzdJanZVMmZzeUg4ZG8xRUFaQ1FDSVNtWnNGWG9vOW5EMHJF?=
 =?utf-8?B?M2pPUjhBMVR2Zm9yTXJoeDRhTlJzeXhDV0E4R1VkdzZ4bngyWSs4ZnMzY3Fs?=
 =?utf-8?B?MXhrUDlLSHNBWDFkRVhzRmhncGVwTEl4SXFqWGQwODMxeWFYUjljVE1PYksx?=
 =?utf-8?B?endXbXJUci9ndmFqL1dhYXJDYTBpeEtKODRjZU5TZ3VLN1poVlVuM3RVOXNG?=
 =?utf-8?B?RDVBNENucnZMMWpRRlBSa0RDN2w3T2VkOXcycHcyRlROM0hybzFEc2VnMTR3?=
 =?utf-8?B?YzdUcWlMMU1ZRXpmdTVVemRvQWxKWVh2aHl2WmF1d3ZVNWd4akZsckN6L2Iw?=
 =?utf-8?B?Z3dpY2RCZSt0bnJPTHdYZG9TeXFtNHlYZmhJeEdseHdwTW56ZFBpcjRhS2ZB?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K/uty9E66Ii3IVzurxG0pYjuaPv3CgLbHe8kQkHkr0+3dRDU2TAswp0Q0wOwAwn0/h8jcY/FlU6Y1uj/SvlkdXzab/3hI/hn17k5BkBfnwS4ZnbQ/E10FSCRFmVVd1p+EkAQCr6C+Nsvx20txTxjPJaqviYPWQ9ZD54zquuXjwE2xOj2MWAArKBCH/e7FJFos0PsoAOMD+PkUr1rPcCyM1ozCGOqNuWzrCPxxD5F3XKFw2zYUkkUrXNMAHKVzGvnz9iA8vgP48WSqDCFPVRrJutyTj7oDYesS0+VXZxk39adufUBBdlnW60hIQljBfcpy6dSMCg/p36hlQy9RjnFCP5gPghdG4vAK1W51+kF3sDoDaz1j/6XIl7JKqCFkUCX7yQRND8zMR9G5NnPpy0GnF5gURJjiPYHOBEODNt+IEIh2Q8e2Vtyh/UaM8Wm2Rv6mqD2c8rKkzYlMLXyeqsAiL4KhnKfdyNINANMOYHr7GWRP2ksdK0khhoSSx0v9iAgAqfX52jtCD0yPi4aQ1w4oU1AJjr5jenw4clBjO9jl4Cm9wDNSv7JLheItr8o+YL2tsElvm90pCpdJAYBLlrwNMF10ioNZxcTSnbet1TNCPs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5caa55-18a1-413a-c6ed-08de0303ca9e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2025 05:06:35.7949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGmjcBgEXhxKBtK2HdXOQXMIAicjc/Yjndl7jq5mzuI9sQqEm+YwEjEe4V5zBdn6wuFcJxf/MaikhDOE3/ox0jztT8Dlwb8BlGDN0LNkKTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510040040
X-Proofpoint-ORIG-GUID: nJdfZextnme96IFQTp4hjXFu-9QEtCBp
X-Authority-Analysis: v=2.4 cv=bIsb4f+Z c=1 sm=1 tr=0 ts=68e0ab63 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=Lch536HccL4jK6MYNDAA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: nJdfZextnme96IFQTp4hjXFu-9QEtCBp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX7GYN66xVwKmi
 4CR+M5XUMBFNTZEyOlhU6zrB1P0AOfU4KTJm34Z3YGizxNFtAvzgtiCw7pAPjkfJAR/qQo135pC
 6BtP8Nxkg+9YdKuYPaKH/8Cc80Lb1ldG2WenAgtEbWQsFlSa7szEbvuLm2iFBZV0QiJEqulzsqC
 6vEMSylT7V9BBm966iOPHLhsjUHuPMabJYstBiEeR7XmFV5wOq7If2VJIfW9mkMqnxMGX6/wc3M
 fb5M1Gwxx3lx9zIv2UtgNM4E8VRrJe5ihGKN2aawhNdBX5LRR2bXMdhRKmUexELovIYJZwhEB1d
 qrrqiQt6npHjzjhizGcCLNJENZlSpZLEoPsQI3AUTDOj5i2y/CmE4lC6yCBLw2ikkF/PZGOnOry
 S1tTFAmeMqOyMLjTxQQfLZEmxP5swQ==



On 10/4/2025 1:26 AM, Jim Quinlan wrote:
> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK		0x20
> +#define  PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK	0x10
> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK	0x4
> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK	0x2
> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK	0x1

typo __MASK -> _MASK

> +#define PCIE_OUTB_ERR_MEM_ADDR_LO			0x6018
> +#define PCIE_OUTB_ERR_MEM_ADDR_HI			0x601c
> +#define PCIE_OUTB_ERR_MEM_CAUSE				0x6020
> +#define  PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK		0x40


Thanks,
Alok

