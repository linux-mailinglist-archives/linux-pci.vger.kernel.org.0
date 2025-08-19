Return-Path: <linux-pci+bounces-34316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5527AB2CAB9
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 19:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973525A7431
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 17:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A67630BF4E;
	Tue, 19 Aug 2025 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EI429pE3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qyt+SRxr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E152E22A7;
	Tue, 19 Aug 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625005; cv=fail; b=KQVwfLdz/0tB6xxVST+WK/l0ni+CON87vva2KzpibR1mUbJ49YShItBR4xFeiD8FvyhfqAePxj2Av8UIxVYa7qQgr5BYvrEgPqww9Ftx7P8ESoQUqcE13pjtCI5mgcHCi52asHSJOSMFCW7FF9w1apBJ6u2HcwnroJ9UTLyN/l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625005; c=relaxed/simple;
	bh=CmU1p4ZtSknANepA5sY9TGj6HgAibrj72Huzhd3cgtk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MKUBfPRqaxWsCt0DUG+s19VEIuUFsvHJ+TBad9vNTk3gDjM/3prOr4af2FMBZBaLjpuMuUVIS5dCTFaYPdsZSajSnoPL/gnN2G7HveONUHHLMb6lUsu6tBI2WNbcxqybP43Yy9KyOFxQhD0UqF5blY5ai1TkUIZi/pdE3s76YgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EI429pE3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qyt+SRxr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JDixLb018493;
	Tue, 19 Aug 2025 17:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4NbORkEiEgIido5vDqi72pKgeFsQ8Alw7iibdy3+Reg=; b=
	EI429pE3yXgqHPNtzcjk+x3ADF98gSWCFjsj98HSmknd2kP2zmqzBsTJpR5pqFu3
	oppSYNvG+EnudBpKLIN5e88KQvNv0oU9ikPH8lpAmbwyXfF7pKh8K7qspTubLAST
	/W1PlZpXuAPXEhy+qHiP3SFwiDEuPC5UcP4JvaRMb/3dHhnmQxkCaT953JIj+zuQ
	lwh5pbSfYys5vZDO5UUnZ4UfQyD4MNPF3qmcElJ1Lg4GmnQP5mfme59bRaf4W7HX
	32F1WTMvKCdzJQQ8I4NKBdEX1WNzHRYb23y2m+Ez6FRewDQPqhprKKCsHrMhldMD
	rP+Id1srhfLl5jXlvy0V9A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48m0ybue7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 17:36:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHJtlJ016786;
	Tue, 19 Aug 2025 17:36:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jgear824-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 17:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFcuqiWmqxO2/GEB3Biq/3mU4FCfTjah9XlhAI9v8RHw/JAUGv03ryMnKl0cimWXQILwEbJf5d+ImONEEhivy5ZhluIzBu+zV+g69Fj5Z1ZjF93vcOXDDHiNhrokgdYAILaRPF9F5tbVAXssbVbQduV6PPBpoPOV+dv7lGHasOD4M2cfcfOqrhPm0INxOBWfYIatVmIHN8VUf6SJ0lpWids9XaiCnWkFQZTiqqZ7cyS3O2b1K6zuvsBuhkg4NipeegWn7O5gAHjUcPd7y5xXkGPFh8UrThyqbZ+jjZG81p77aZFJHKUtXWsauH/RzmMm8VaAiSwUpn6See69mTj+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NbORkEiEgIido5vDqi72pKgeFsQ8Alw7iibdy3+Reg=;
 b=iSzp3DtRx9dxENi8HdnftY1HycH+aQLJTmnFOQxM6CWh5SjebLMSXT+s00ti4+yZbnsS9a2SuIz1cv/f/4smCvoIxaEvk1F0Vz+a9CbtdIWjO0pSYcYuNo7BqIa/5APw4hXR2gzMY3YtsImaOofdi9LtGu0v6G17LAtY93LiD5td4pAyrTmQEeqRIX4vx+eWY+UHe9HzwYLi18mug73VhBM06LM+BXn21Zv9cofDga+FJouChcEUMCwL2lxX4nwmNIfrl+yIqs1nRqzWOXQ99P9Oiii7FBTQaWPJBgOaMCyAN46+pBpq06bUizauqWkrnY8N1ZP4CxQeEUI1GOMlkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NbORkEiEgIido5vDqi72pKgeFsQ8Alw7iibdy3+Reg=;
 b=qyt+SRxrK6bClsanIuO4WGKvdYc+jKSfpJaX4Vdn/b+t5S7jVgq+NTj/+6oosRgzcs7xlgMRJCHZ9KmlgxdTmsKLU4m5J2tdJEtpJai6ZjiiyJh9HGYdjrzvZ9Ey/XKBj9cSMj/z8WQd46dimqjL4VVEG3ZIhwfiWswhVzRwU5k=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CH2PR10MB4278.namprd10.prod.outlook.com (2603:10b6:610:7f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 17:36:21 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 17:36:21 +0000
Message-ID: <ef115fd1-01e9-4d36-9c6d-37ea7516123c@oracle.com>
Date: Tue, 19 Aug 2025 23:06:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/15] PCI: cadence: Add register definitions for High
 Perf Architecture (HPA)
To: hans.zhang@cixtech.com, bhelgaas@google.com, lpieralisi@kernel.org,
        kw@linux.com, mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
        peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-4-hans.zhang@cixtech.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250819115239.4170604-4-hans.zhang@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0160.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::19) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CH2PR10MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: a280063b-9bed-48e3-4240-08dddf46e950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEpOR2d3YWJLVFJRTS9XME9FTmIyd2hURUIyZFlwL3E2eit3VEFydzczblpK?=
 =?utf-8?B?OUJxMXdSNHJtTmJnQjBJemZocWcvbTZNQVZDMTIxRDJCV29FWUdOcFM1RFRt?=
 =?utf-8?B?dENIb3VidHBNSFoyc2M2d3NhT2ZYbG5pTEFMTXIrZnUyS3BPbnNhTEdNRXJh?=
 =?utf-8?B?dnVtQ0RkL3VROENEQVhVU1VqdlZiV0dsWitOdis4Nmt3bkxINXlhQWIya0ZM?=
 =?utf-8?B?R2VnYUwwSTRHTm1ZdEtkaHI3NlBpaWg1bEl4M24zQkZ4ZjBkMHl5WlVZOXlj?=
 =?utf-8?B?akU0d3dZbjUyWW9WYnpXOUNsSURSeWpCY0U3SVhLaFg5WDl4dnJtU1dZVDlI?=
 =?utf-8?B?dHo3ZzhtekhObGFkUjcxRWUyYkFyOEdhYnMybWtaMjN4UGZSRmgzVTlLd2tS?=
 =?utf-8?B?UG5HSERWd3dQSWJha1ovYTVQQTVYT3h5NXp0Y0syaDFsekdEYnR2M0lZWHdB?=
 =?utf-8?B?Vzg3dGIzazhhdVlucU5odFlOblRxdWd3N0lBRFRrdFB2NUY5cU1BWEhFYWpq?=
 =?utf-8?B?UlVkYXpWV2s5QjQvRC9QZUpJRHFIdzNGOWttL1VtbERCOW9ud2FwZ2RBZFlh?=
 =?utf-8?B?K2RBUHNTTng3S05aNDlRQWFnRHBqMWRoSmhBOTNNR1NHMnM0QzF2TThqYzFu?=
 =?utf-8?B?YkozR0p1Z0hOeEQwWmE1Q1RuTlE3d29pZ2NINkpHeTRnWmxKalpTSzRPVTNU?=
 =?utf-8?B?YmtibXZTRkFnN0s0Y0hVQ2hIQWdnZU5IdzYyYXNsTE1tN1NQUEdpc21TR0Nj?=
 =?utf-8?B?ZUlqeWRMWTNGZDcvOWZEbERGeFd2WUlLNHhUSCswRy93dmJvNWxqMFQ2ZTFR?=
 =?utf-8?B?dkR2OGtuWVg4SXhub21MNlBxaENUNC9LSnlTTzBrbDNQd0RZZHNwTUtacjFZ?=
 =?utf-8?B?TmZBVEZYei9XOFR3SHBrSDN3aTNEWVdoaWJONmxZNzl2R2U3eXVuWGxyU0tU?=
 =?utf-8?B?d3loM3hIb1FxZ0JjNUlSVGRSTFplU3pqVkEwdjZYNDl4aEg0RzluUlp3dENr?=
 =?utf-8?B?M0ErbDBxbkk3aGxORnVXZEQwR0ozMHMvL3BweGRFU2k4MGdVcVk4YU5tb2N5?=
 =?utf-8?B?U0YvWDFTOUJveGpZeUNHT1dFcnJrSVlQRWJTOXJqeHBhRnJ0MnNoSk84R1Bo?=
 =?utf-8?B?cVMzQk5jK3ozZUZaSk1KOVRtNWhyVjBtNnFaYmF3UmtpczhqUHlNQ2ZLcDJG?=
 =?utf-8?B?SEpiOHA1QnBWa2FkWUQ4ZFJaajJvMnhxVUY5ZFBNUXZrVWVzVkNhQ3hzWjdI?=
 =?utf-8?B?RWxVNXNPd3d2Vk5kejlIRXJaZnRCaDZQNkw3M0JoRjV2eCs2dy9jaTh2Vzg3?=
 =?utf-8?B?TVR1aC9oZmZDLzA3eExkYjh1bUo5dEpkcGlLbkJZR25zaXVyUVo4WGdWOG9y?=
 =?utf-8?B?b2ZpUmZyL0dJZEFzTjZkczE4a0gwU2xpZXI5bmJKUlBCUHphWml0NlpweFFK?=
 =?utf-8?B?NFV3RG1QTHphcXF4dkNpRWVadXdMT2NnTlBLaUtVbzBiUEpXNTJkclRqaWJo?=
 =?utf-8?B?eTB1OUNBaGtlZE9Mc0praDBLRzQ4YklWMTZTWlFzREFNM0QvR2ZmbjEwS3BW?=
 =?utf-8?B?dkZjU3NoZDFGcnUwZzZMYTlQUHFkeFdWdlZlWTBCRUFULzVwcEV0aW9EQ21l?=
 =?utf-8?B?eUFhc2liUzgyN1E2ZEJPRUF0NERNSjRVendTVkh4eWNEenNaRU5IZW55dkhr?=
 =?utf-8?B?eEJuUlVMUThmc2luUCtxU2xwYWRadDZwU2RNRG9oL2VBN0xGRmlWdm5ZOWJS?=
 =?utf-8?B?TGJMZUUyNHdOVnc0Y3ovRmNYZDZaWjE3WEFUUUc2Y2lQOUtLQm1rMk1XZ2Zk?=
 =?utf-8?B?MkExajFUZDhIVTBnZnZMUFV6MDB2ZXdQN3huWlE4ODlxdHVBY09lcGs1TTZC?=
 =?utf-8?B?d3RNUDFTM3Q1a2xVTHU0dXRSbGlMNGFQS05xVXF1YmJZVkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVBOdTdZV25NSmp1a3J0RWVSa0lGclBqMERuM0txV2V6Sk9kZTZoUWdQOXJn?=
 =?utf-8?B?akpYbUM0UnpuSlhlTG5zOFRhNytoUWswZDVmM2ZhL3czWjB6Y3FPSDRjcUcz?=
 =?utf-8?B?bk44TCtyWnQ0amlZNHF1b3lkY0tUUzRmMkkwY3l2SjlWakRZQUl5Z1JPc0Vh?=
 =?utf-8?B?dk5zNmtkWVpYbVRxYmUwcXlIMjZvR2gvN3NMM1ZZbmoyOWt2dGpRbUNvVm5y?=
 =?utf-8?B?alpIV01VVEhZYVBVSnZQdFNTS2RTSjdWeURBYXg4YWwwaGRvUVcvNGowRmln?=
 =?utf-8?B?bktZcjhZeE82ZXpROGt0TjJKUVdjb0hUTnQ4Ulk4MU9wS0t6Yko3aWxkeFFX?=
 =?utf-8?B?MFZHQ2o5T1R1eklFd3FkUWVycDk1T0ViY0xLWjI4WSs3VlVnUndMRUJhaXZT?=
 =?utf-8?B?b2EvMzlzbGJUYk9MM0FIQjkzS1V6cUFqSCtSL1RqY2lKakdlY0xvRHB0eWFs?=
 =?utf-8?B?TDlzZUpTSm44RGExRldzSDNCeE5VMERLa0F5MlBiRjl2NmZrQjZZRHRnM3A5?=
 =?utf-8?B?NTJTWC8wZUdua1p4Zjh0TE1xelZZQXpXakxROXZhTThtbmNEZUVTZGdyRXJl?=
 =?utf-8?B?bzdBM3NqdnRzeDZFUjJndTh1UjRXbUVWaXhSWWk0eWZxb29rOWdQYmp0N25j?=
 =?utf-8?B?am91cTNQOUlDMmcrKzRFUjBBTlFocGVSYlFRdHREbXhzWjFXUmxsVHVhbGRp?=
 =?utf-8?B?c09sdWMyanhEdVlOLzdHYmVIWWRDMkF2ZjVpRkRtZlAzcHRuUDg0c2dLZVda?=
 =?utf-8?B?MlNrb3BXdlZqUGlyWEgvYlIvWHVNNHVaUGllZEl1dmg1alRSUEdENk5xN2Ex?=
 =?utf-8?B?RUN5QWxRemwwQStmenY4WlZQak1qL1hXL0dDVTNhc1lKbHRQTTJFdjJIdStu?=
 =?utf-8?B?U3lFSVkvSi8remVicWhxQ3hISkhtSjJza1JiclErKzEzdFp3QkFnNzBlVVU3?=
 =?utf-8?B?NFFmbEhCMUlEanN1YXRKQWVrQlRHanFsM3VUOFp3MzUwbUFjUENteStncC9Q?=
 =?utf-8?B?SUJGRGpUMUxPeUQ4Tzc1N1hjd1l5d1o5bStZOWtlMElMaThLbmU4RUQzYzVI?=
 =?utf-8?B?TDI1ZG1SSU53NldmQ2dMOVVXZU9aZDlrZnJ5dmZ4eS9ab1l5ZjZOY0svdzhN?=
 =?utf-8?B?c2pnOFZNVU5sZG1oRmxTNUQ5bk5LK2VCYys2QTlVSVB4N1ZVY3ZNWGR5QldO?=
 =?utf-8?B?bHZ4cHN4d0ZjRTZ1U0I1WDRoRjRpN1pFSjNUQ2hKL25rZS9nbXBRa2t2MGpY?=
 =?utf-8?B?TTdxeXV1U1dzaVlUMlY4UWppdmc4MmJ3c0o5UEpjMW9tb3gxeXRySDk0OXlj?=
 =?utf-8?B?WjNmN0JmdTRUSDdmZlk1MjlYNjJWMVJBZVFRUWdUYmtZbjBmN0ZDNE53SEVW?=
 =?utf-8?B?cU42dk5SZzM4TGJKVEZOTEJrRlJQY053d2RGT2x2RFdrM2VWSmM0Sy9iZ3JB?=
 =?utf-8?B?RGZQZ1EwbXh0K203UTZlTWw5K0ZkY3RpUWorV2NVL2VJTXA3QmlEREdBUlc3?=
 =?utf-8?B?bjJsZVFUdC9GSE9WYUhZSHBqdmo1SnlXdWhOcEU4VmRxWmw4TmMyd0ZtZXlh?=
 =?utf-8?B?ZlhwZmZPSzVxZ2VvQ1puMjFXZTIwT0VNNTU0Wk5UcVlYbFo3cDdpTVRtQ21W?=
 =?utf-8?B?dkdRTEh2WFNlRjU3RVYyOWZmTURTc3BnVUdiSDFlSXJ6V0ZoTUxwWWF1bW9n?=
 =?utf-8?B?Q0N6bXZqbzcwSGloV29zSXB0OVVVYkpQWDBNU0RpN3Q0b0JmemtYbXJXbk0x?=
 =?utf-8?B?aWxlbVdOS2F0R3dFVjZ1eUc4RmhYM0tMVEZjQXM5elBxMjA4Wk05MUtyeGNC?=
 =?utf-8?B?emlqbTdGMXFQZ2drblR6ZGhBS1h1N2pYVGhRYzFzN0VFdFdCWE83ZTYwejNC?=
 =?utf-8?B?dmpZTVJkQXZZRXk1elZOVm9NU1hFMi9XZmw0b2xDNjRNRlowMk15Nm9RWURi?=
 =?utf-8?B?OTJjWk1heFljQmY1YW5iZnRCRE9heWF2S0Q4aHdyZXdYQ2Z3Skd1cU91cGpi?=
 =?utf-8?B?dDZ0M0xXamk0TTFUOTg3LzdOYmtVVmpRODdFWFVqQWNsejQ2a2Jmbm9tUTlW?=
 =?utf-8?B?YzB5VSt6b09PY2tmdVg1VXJPWU9wQUhWRDE0ZElBSllaa1pBQ3Y2RUtUR3Iy?=
 =?utf-8?B?M2JObkx6dXVYWGl6MkQrMU9KOC8rSERGQklXd3k2eWIwQ2RUTFk1V3htYUVF?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/nbd+FPBPVJ+hqQQlyHUcFSX54cmM879YFYDQzMeNwzk4HJqd4IQn3Ty5r2LZAilXPDWBSXgywec0/tVEQniIEBTI8VxztSWsEEJzM/mHyd+z5DpClX65j/Wan560ESGsV+aAJm0AikrAgDiJkyYLhvJuQl7e9StU+a6111iSav+GPslJWeBY6tdBkiv7hxs22Kd5nmtQqopAQ/aRVSUOqhSmVONuKYnebc/1LDEwZ8120kFYyON9xgDua74A/29lHxcA6kK2kNwO1mdtQ2BXuHcFQPM78km+mtZi4WDpT9K1HGiLmauJXw9FfzO0fJ/B4i8abiMPkUSUv017GTY58qTziwLKMMry/r63VRc+R2E4FQl6Wa+NJHPci9apT/4K3k+vyUb8o4pVxAMGpTKOxzpVo3Go8mDuaH+hRENhKdNXXJ6oAx1Z071iC9/e3ZlreWivnVbwsXauVv9mDElRl0UozWMzF1nDbpvDPQOt1KJiA0js5XwFZc37QeKG/iyNdrZyHaE/v7g+TMwsw3sylPfPcHtp70QaFWzR57bXKaLBkFSeCokYeRw2Xso0AqNjrHsMZQuwcBMETL/4melBIoFQJkE7cFKXONEa+24wGk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a280063b-9bed-48e3-4240-08dddf46e950
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 17:36:21.4722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTTwFg3KrfzxGkZkRDyGKJYcyI+swLIy4PzG1SVSv7c8KtRmRJ3uTS0H+VpVsxip9jRxdhKdC+OZG1EoWMjcrHYcu/YdSCIhoxbxZdb0eQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508190163
X-Authority-Analysis: v=2.4 cv=fcOty1QF c=1 sm=1 tr=0 ts=68a4b61d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=TAThrSAKAAAA:8 a=z6gJ4P3AfzaWYj7CBo0A:9
 a=QEXdDO2ut3YA:10 a=8BaDVV8zVhUtoWX9exhy:22
X-Proofpoint-GUID: AEId8Vqot2aTeySDj8c3YrBkXOJSZZAr
X-Proofpoint-ORIG-GUID: AEId8Vqot2aTeySDj8c3YrBkXOJSZZAr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE2MyBTYWx0ZWRfX6J6ruFCB4ye1
 ySKRvLuPKXuyr7I0v30r7rY6GkoaeS7lxo/ezSHE2fH0dUt8RHxG2sKdagnzZcwLTQv+P3yzoSC
 CRQEkOYEC2+yOYgKyj8CyrTf1pNNdQqoB9aG1dMf3uZ1eeR/+FtHfZGhd8+FwRA/qZUlpDUj6bF
 1t8lc3DSizDUsx8oqOL8vC8oWsoHu9kH+mpVLqOs/KyMei6cZCTTIE9LqatfAxbdC+gErrbLxrD
 0xutKAWltrRj91fP2IlDPXJP5KPp7gUqvt3NQo0P7MWBpWOXPGvttUCvIkHJdrVtQ8jSQTaAaBI
 t11rgxDsIW5SV7gD2B/XY+o2ixQhBqG/8braAjib8KCA8P0E13U66JZtq2ly1rl8dpEdIY5H0YE
 pyrTiv3PaNGEyF0eX4kRAEwcKSbW+TtCjrfX8p3wrjOQDFLgbzp3R8xQIjaaUeLuySJ3yliE



On 8/19/2025 5:22 PM, hans.zhang@cixtech.com wrote:
> +#define HPA_LM_RC_BAR_CFG_CTRL_DISABLED(bar)                \
> +		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED << ((bar) * 10))
> +#define HPA_LM_RC_BAR_CFG_CTRL_IO_32BITS(bar)               \
> +		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS << ((bar) * 10))
> +#define HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar)              \
> +		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS << ((bar) * 10))
> +#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) \
> +		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS << ((bar) * 10))
> +#define HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar)              \
> +		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS << ((bar) * 10))
> +#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) \
> +		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS << ((bar) * 10))
> +#define HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture)           \
> +		(((aperture) - 7) << ((bar) * 10))
> +
> +#define CDNS_PCIE_HPA_LM_PTM_CTRL		0x0520
> +#define CDNS_PCIE_HPA_LM_TPM_CTRL_PTMRSEN	BIT(17)

Is that TPM intentional or a typo?

Thanks,
Alok

