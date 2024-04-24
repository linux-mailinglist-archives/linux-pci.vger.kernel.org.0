Return-Path: <linux-pci+bounces-6629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C2E8B0C6D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 16:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4071C21494
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C34215B996;
	Wed, 24 Apr 2024 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IpIL812h"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101D315D5C0;
	Wed, 24 Apr 2024 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968658; cv=fail; b=ternzyJTqTRMKLpERjwxwWz0nhYp7bQpCtErULxm0nJUuFgjysqhVUtCoFuBeVHmfE+sBAAreKLxKb0gLJfhMbs/dbSXuzuFfoPHpn/5RszXTXP0DLbdEI4tXFevraZCEzqLUg6aDZR7KYxZiHb0Iqd0ltx5G/VoT59dnwCq6Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968658; c=relaxed/simple;
	bh=ipanbeoynaCAbBDHNjc/qMwPJfTw4ofr7iD00vXilbc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SqNg4ku2WAl0NzzvUSKCSmeyinGs+66QOmAeMWe5gzID6D4gEdYLZKLDg+LXs71bcuTuCVIX5Pd1UAgk9guySD1S1mneK5A1W0Vkfgi61EGkqrn4iQ7meYjsLYmnhey+slypi+WZJPuZFdH8EiwncxEvtDRwWWGVUFm8PlCBgwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IpIL812h; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzrT1r1NsvurdXT1v0aCLl8SDYAadUVkCu/UhuC+8v33VmS3TgJarvQ9pfEV4wZLiAP/wIL4BIx1c+EAZQga5s/wlj0dr6xICJHCOW3P8zUKT31wCFf+QZ8cr0Ptb+AUY4t7cTUSZRH6VSrEkvDjTFc8kF0d2ZcT21A2adHCWeIjFIdyhi8mMl4HVo1wKTGEK0O/NSK/frS1QL3jzT5nG1qlnWGw2g0SXpoGndq/DqyVLwzkarj7agRD/yqYBqCefQUzmkrUTF9LHSiX5KYqCIgyuFdH/q8G/yxg0CEVTS3QWIYLmdwUZTPevSLTfHLggOXE6knVNOsYLLp9MoCfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ao2bbcIH7V68TQmz/2q+jGdDu/3LIg/fZoQcLDbZUA=;
 b=NVewU77DzaEkClMP2qxiA8cecXQA3VyQmB6/t2eMYNcr2vH2Za6xJhZr2DJB8hRYQPd+RPDNEUpTkjeyT+GaZzJNuLWligixC7FffuuTf6ZXpAe4YzpP6eNfmL44Z0wgBAXIJCLnffSZixQdqnVUuuNCp2Bil7UcR05JaVplYm9tBXLfZgYt+P7PhXAlID4gxzTehdpRUOUZltdBeq8tIakxCdjh9jJIG6cr4EFQPHJ2WqppThoohojYnndFvDqzL2RzeQBCRI4ckKMbcNvw1vB9CQWjdwVO1uPitWxuu3iz8OkPua8cxjzCVeu1+BESxuZuNSBBke+o1OZJFEJuRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ao2bbcIH7V68TQmz/2q+jGdDu/3LIg/fZoQcLDbZUA=;
 b=IpIL812hS6MvnwJY4PPxlLZQmox2WCtMcHrRrX1gobzPDAfFqBdNTVtYjJZGz0IrZUFH+djUtzDKNlHWna2N74XIu8X7pg8Lm7RVQuQHq7ZM5AItKDGWTTyFlOCwQD+bKHhtCSKjaz5RiN3RfdeheX6HLvoq01aWs8+p5pGtJJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 14:24:11 +0000
Received: from BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::ad43:48cb:df1c:c72f]) by BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::ad43:48cb:df1c:c72f%6]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 14:24:09 +0000
Message-ID: <b72349f5-7e9f-4b7d-9551-9ab8ce124a9f@amd.com>
Date: Wed, 24 Apr 2024 19:53:59 +0530
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] PCI: endpoint: Migrate to Genalloc framework for outbound
 window memory allocation
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>
 <37cfa724-f9ed-41ef-bad4-f00246a4ee8a@amd.com>
 <20240320112928.GB2525@thinkpad> <20240414130058.GA2231@thinkpad>
 <6984ee8c-7848-46f8-a421-1b31d8c2231a@amd.com>
 <20240418052429.GA2861@thinkpad>
Content-Language: en-US
From: Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <20240418052429.GA2861@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::29) To BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 185dac54-e7d1-4780-ef59-08dc646a3497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TElXZU01cFdFM1htQm9na0ZJS2JYYTBSWGRYWXNMZkx4dFA3dHplMmJ5cFVl?=
 =?utf-8?B?ZmxjMjlJWlhGcXJpU2RnRnVyNENqZnlOYkNnaDZoZU8zWDBsWkxSWU9Icm5m?=
 =?utf-8?B?QW9VRzFZcGpBWXQxL3phY1MxeC9SLzZLMUY0dXpTam9YUUdSRi9lQUFvNU1h?=
 =?utf-8?B?Q080djlBMDk3eFhLaWJEb3JSUW9uN1Fxa2cwZ1dJZnNkR0sxbUg1WGZObFlo?=
 =?utf-8?B?ak1uOTh3UFdNZ0ljMFNOQmliU29SMjF4RlZHTGI5YjRUM2tnVE1TSzFhSS9C?=
 =?utf-8?B?R21VTzB5MmlFUjl0T2ROblhNa3hjN2c4c3dnT2cveGZYVkl5azVzWVhWWEVX?=
 =?utf-8?B?djRYdHBMa1JuVnFXRk5QQ0k5Z1Zqb2lTYWIrbThLVFFjdGtqZnFSakhkbFVB?=
 =?utf-8?B?TEpXTGdST0s0cVZENTU5UGVKNzZuL0dIQjdweGp3anFOMzlBdi9KQ2VmWm92?=
 =?utf-8?B?anBOSk5NTVJUWWJ6ZkNPUEFUeUF4ZGx0Ti93dk1oTEFFeTZKR1FrV2FZQmt5?=
 =?utf-8?B?c05Hejh3dVozL29aeVBJbWtpZ0Y5NmxqcE4wdngydHFNY05hbGpsWWRLZFBG?=
 =?utf-8?B?NXNVYjdvalc5MktocitPTjhIUHB1OE1kcW1KMTVqRkcvOVgzVU5icjhtMEVL?=
 =?utf-8?B?ZUZVOHJ3NUtnUzMrVDFxeG42ZWtOUFVmY1kwL2d2ODlGbTd6QWZKZisvajlj?=
 =?utf-8?B?d3BVNlB0ZHkrOFY3SnI1SlRiUXBITVJVRVZ0dkQva2RwK1c2b3h2Vis4M29y?=
 =?utf-8?B?Z1FBNmVjd2EzaVlXdkVKdDNwQ3FNVXA0UUROZ3g3bGszbXBOMmlaMFhYMFBF?=
 =?utf-8?B?ZlZ6dFJmOGQ3UEJkTm8vSVM1dkJIbHR1TXc0c0dlNTdEYmpkeFNZRGF6Y3E1?=
 =?utf-8?B?Y1VSOXN2M0Y1b3lORTRNSnZZWFdyVHVZU0hxb2ZZTHRVakNWWjJ3RXRHd0No?=
 =?utf-8?B?bnBsTGpMR1pKMlVYczJ1cjB0YTdONFdHNWlJU2FuMktCL2FabnNTcnVJYmQ3?=
 =?utf-8?B?bCtCbTlDd0pyZVZqcFNvbUlKaDJRaGpqaHRJbHlPSkMxWmRBSVFUSVBoUmRH?=
 =?utf-8?B?d0trMGh6dDRCTFhEQjQ5cnhhVHZ1YkRRVm5LU29nMHFwWjd6czJ1dnNwRit6?=
 =?utf-8?B?ZXQzUjhXQkppWFJRRWVMaU1TSzI0YytKemhwamJ5ZzE0eTRxQWl6QXd4THR6?=
 =?utf-8?B?OW53TE1paStvSEF6eE9xMS9aUncyNjN1TXVrRDVZZ3F2Rkd0WkVEUU9MczF2?=
 =?utf-8?B?ZWxDcTRLY0pUTEFBUnk0V1A5eUQxaDRRVE4wWTE0WUp4RU8zKy9wQi82Sk5E?=
 =?utf-8?B?Wm1ERUFNdXNSNzBiMWhSbk5iY1JXZTBKT1gxYW54cGM5ZGJlV1kvTWNSTmRv?=
 =?utf-8?B?a05QSms4NmthYkdLQTlYN2dNakZiUW1tTS83RVlUZjFlOXJaTnF2SFZnYTdn?=
 =?utf-8?B?NmVFZ3BkZG5sRUtnZVMwb2V5ZDgxSlp3bEljRTZLZGZqT0Y4YmViMXpCNDRk?=
 =?utf-8?B?MlVSN2dDVU5icUNGRkloODI2UHhyeUtFNXlwRmV3ajBVeVBPQ0g5SExESnpQ?=
 =?utf-8?B?TzJlV3hVc1RmdkNIZ05jaGVteDJ4Sm01UHNKZHFFMEgrVnVPbHl3dStKRTlS?=
 =?utf-8?Q?06uaPBE0ULFnldLy+QBbBj866m7kT9wfMRQidPz2wqoI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFFYTE1XWU1KQzQ4Y3lURnJVYUkxQnRTWTFWNVkyOGFXY04xcFowSWFqVW9a?=
 =?utf-8?B?clRYNG5zVldWQm9UWGxMOHlzcHhSWGpIQmQzSFY0M2xDTEg5UWF6N3huVStC?=
 =?utf-8?B?dkVMckswREJEWXhzSWhKMkZmZFMzNGx5Nkl0VDJnS2c2Um9kMmVwcUNGNTZp?=
 =?utf-8?B?OWZiU0VTZXFHTis5OHZCaU9CNmhyc0E0VVA4VHRSSUpqRlN6YnBTVFQrK3hw?=
 =?utf-8?B?aEJJR3FJMGZ4REJLcnY3TFF1QkE0NS9tSlpmYlJHRlVlMlhBelRNcmgvRlQz?=
 =?utf-8?B?d0UxblhRWGI1Snc4am5EbGZrYzVKYkhjM0lzQTl0NFAvR0RUdUQydFU0emFF?=
 =?utf-8?B?STVGY21yMTdMNHYxRUZHNDFOeHJzQTEveHZRTmwyOGdOd2lCWVExTzgrclFH?=
 =?utf-8?B?bUZGS2UwNGRhSEYvSFdzYXBvOFduRnloR3VXS0Q4djM1bW14SHFwSlRkU3Qz?=
 =?utf-8?B?U2NYNUUyN3ZXaFdzaGJVdkthSzMzYi9JMlVkWHd0VUc1ODdnejRXbzFyeUUw?=
 =?utf-8?B?RWJOZjZ4M1lpQ05URElJSVkrNnhrQmFrVVBTMVZOVzlVUlV5WlFkUHkwTklZ?=
 =?utf-8?B?UWpVUC9OYSt0VDI0ajVWZnBHeU52bThhRGxQc1YxR01MdUNjVmdsOFVCTmc1?=
 =?utf-8?B?M2hGWFN2dGZZT3BSTVpiQkU3azdERmVwbFNMK2cwVmFsdU9zZlJiVkhFSUdx?=
 =?utf-8?B?dlJtYXl4UTZzUUlvRDJtTU1QUWRiWExWTytGK3duZWtsMmlkakhuSkxiS09J?=
 =?utf-8?B?WERlMElWWEZOK21Qb1lOMU1rYkVIaFNab0Z5ZWYrNEVYM2xMRktHaGMweHpr?=
 =?utf-8?B?V0ZjVWRSUDVPZytVZytNOUJWcHdZelNySDFIZndqekJUbDhUd0cwODBlMFZT?=
 =?utf-8?B?Y0QvN1gxbnFMa2FrWDZsL1BaT0ZUbGU1N3VXTU5Xd2hpNVhXWDBMTDR0YnJP?=
 =?utf-8?B?SUsxZng4OWgzaThJaXZmTjJyWWExcHpYd3FEeGNkYjZxSUFYbFMxbnpDUGNi?=
 =?utf-8?B?cHY1aGo2TXUzV3ZrSUM4UG9SNUxDMnZQYmUzMnJGcFFFdTliYzBCNWMzU1dG?=
 =?utf-8?B?a1IyNjI2bzhzU2tmQ0hadFBoT0ptOUZWZ1lQMFQ0VTdXWFpTRCtlODYvaDE1?=
 =?utf-8?B?V2FiN0h1UmozT2ZYTXZBTUVmS3hqSmJaZFhMaEZLYmlkMDAvK3Y4Nlk3bTNP?=
 =?utf-8?B?SWpNVThVS2FSdmZmdjZlRENBRnVkYW5CdWxZUUhsWVRTNXJyVXNGSXN3dkRV?=
 =?utf-8?B?NGNNNDZPWUZuV2NNNTc3a3FYQnByQm9hbmVISEVHbnZjTnBhNmJHYm84ZXJp?=
 =?utf-8?B?L1VEQXd5ZlRMUUE1eXRNK1VHaDJtdk1jb2IyTW5KZjBjdGlyZ0dSQVZ2bmgv?=
 =?utf-8?B?RUdLNFlHTCsyNEhzdDV6NWdFMTBhOGpzb3RlbUx4VDBidE5PKzVuN0U3ei9W?=
 =?utf-8?B?OHlxbGRQMEZydWZSYjVEYmJqaytiRGV5TWpYRW85dG9sVy9qSThLK3Y5cEFV?=
 =?utf-8?B?RDZTaURWU0xzY0hTT3RqY2FTemNRUXZCaTlxcmRBMVU1UUhiQ1ZZQ0FoanZ6?=
 =?utf-8?B?QTM0WmhHMkRDTHNFOS84R21jOVJBMHRoVkZid3YxV0wvdGFzMXowVDl5cHNU?=
 =?utf-8?B?cUg0dldKOXNoRElCR1d4WlY2ak5Ic3RRdjRZVStCcklOci9SWjJZQnAwTXNC?=
 =?utf-8?B?SmNjS2dmUksvVE5aWVhqVlFmWURsdG8reWFGUXdZY3JSTEg3RkpzSjBFK0My?=
 =?utf-8?B?V3B2VDZuRkw1cjhtbjg0SVYvOE1GK2NTQVdpU1dvRHp4NzFLeWJXUi9KdFZ3?=
 =?utf-8?B?ZVlYS2hNVk1TZUJDMWpYRTlTRFptOElQbUtXaldadUNrd3RBUS9QU0hDY1Ev?=
 =?utf-8?B?cGhZSzhrN05LM3BIelpQc0VWRDM5anR2M05nVjl4bHN4S001YmVmTHYyMy9W?=
 =?utf-8?B?MjhubGN6SjRxZVZGYUoxMGZJMHFjSU9tMGk0MHEwUVBYQy95bHcyQm8rUDd6?=
 =?utf-8?B?eTFSVGFzNytyNVplaFI1NVhJRG8wMU5EV1N0UWpPL3hGSUx5dUxEdU4vNWRh?=
 =?utf-8?B?WGZrbi80TUYrRWdPdHlFdkdVOGl5aEJTZHZ1bXFEU2w4U3g2ZkF5VUFydkYy?=
 =?utf-8?Q?DOba984geIJiUsPPEaOlWBujS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185dac54-e7d1-4780-ef59-08dc646a3497
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 14:24:09.5599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKgJWRP+ge6AaGfYswCm4ioRppgLDnci7aXAGtT5A2vnsX076xuSQEEBR4ptOS8lE6GUTud6XKuDUVosrUZNRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229



On 4/18/2024 10:54 AM, Manivannan Sadhasivam wrote:
> On Thu, Apr 18, 2024 at 10:14:57AM +0530, Kishon Vijay Abraham I wrote:
>> Hi Mani,
>>
>> On 4/14/2024 6:30 PM, Manivannan Sadhasivam wrote:
>>> On Wed, Mar 20, 2024 at 04:59:28PM +0530, Manivannan Sadhasivam wrote:
>>>> On Wed, Mar 20, 2024 at 03:26:41PM +0530, Kishon Vijay Abraham I wrote:
>>>>> Hi Mani,
>>>>>
>>>>> On 3/17/2024 11:39 AM, Manivannan Sadhasivam wrote:
>>>>>> As proposed during the last year 'PCI Endpoint Subsystem Open Items
>>>>>> Discussion' of Linux Plumbers conference [1], let's migrate to Genalloc
>>>>>> framework for managing the endpoint outbound window memory allocation.
>>>>>>
>>>>>> PCI Endpoint subsystem is using a custom memory allocator in pci-epc-mem
>>>>>> driver from the start for managing the memory required to map the host
>>>>>> address space (outbound) in endpoint. Even though it works well, it
>>>>>> completely defeats the purpose of the 'Genalloc framework', a general
>>>>>> purpose memory allocator framework created to avoid various custom memory
>>>>>> allocators in the kernel.
>>>>>>
>>>>>> The migration to Genalloc framework is done is such a way that the existing
>>>>>> API semantics are preserved. So that the callers of the EPC mem APIs do not
>>>>>> need any modification (apart from the pcie-designware-epc driver that
>>>>>> queries page size).
>>>>>>
>>>>>> Internally, the EPC mem driver now uses Genalloc framework's
>>>>>> 'gen_pool_first_fit_order_align' algorithm that aligns the allocated memory
>>>>>> based on the requested size as like the previous allocator. And the
>>>>>> page size passed during pci_epc_mem_init() API is used as the minimum order
>>>>>> for the memory allocations.
>>>>>>
>>>>>> During the migration, 'struct pci_epc_mem' is removed as it is seems
>>>>>> redundant and the existing 'struct pci_epc_mem_window' in 'struct pci_epc'
>>>>>> is now used to hold the address windows of the endpoint controller.
>>>>>>
>>>>>> [1] https://lpc.events/event/17/contributions/1419/
>>>>>
>>>>> Thank you for working on this!
>>>>>>
>>>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>>>> ---
>>>>>>     drivers/pci/controller/dwc/pcie-designware-ep.c |  14 +-
>>>>>>     drivers/pci/endpoint/pci-epc-mem.c              | 182 +++++++++---------------
>>>>>>     include/linux/pci-epc.h                         |  25 +---
>>>>>>     3 files changed, 81 insertions(+), 140 deletions(-)
>>>>>>
>>>>> .
>>>>> .
>>>>>> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
>>>>>> index a9c028f58da1..f9e6e1a6aeaa 100644
>>>>>> --- a/drivers/pci/endpoint/pci-epc-mem.c
>>>>>> +++ b/drivers/pci/endpoint/pci-epc-mem.c
>>>>>> @@ -4,37 +4,18 @@
>>>>>>      *
>>>>>>      * Copyright (C) 2017 Texas Instruments
>>>>>>      * Author: Kishon Vijay Abraham I <kishon@ti.com>
>>>>>> + *
>>>>>> + * Copyright (C) 2024 Linaro Ltd.
>>>>>> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>>>>      */
>>>>>> +#include <linux/genalloc.h>
>>>>>>     #include <linux/io.h>
>>>>>>     #include <linux/module.h>
>>>>>>     #include <linux/slab.h>
>>>>>>     #include <linux/pci-epc.h>
>>>>>> -/**
>>>>>> - * pci_epc_mem_get_order() - determine the allocation order of a memory size
>>>>>> - * @mem: address space of the endpoint controller
>>>>>> - * @size: the size for which to get the order
>>>>>> - *
>>>>>> - * Reimplement get_order() for mem->page_size since the generic get_order
>>>>>> - * always gets order with a constant PAGE_SIZE.
>>>>>> - */
>>>>>> -static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
>>>>>> -{
>>>>>> -	int order;
>>>>>> -	unsigned int page_shift = ilog2(mem->window.page_size);
>>>>>> -
>>>>>> -	size--;
>>>>>> -	size >>= page_shift;
>>>>>> -#if BITS_PER_LONG == 32
>>>>>> -	order = fls(size);
>>>>>> -#else
>>>>>> -	order = fls64(size);
>>>>>> -#endif
>>>>>> -	return order;
>>>>>> -}
>>>>>> -
>>>>>>     /**
>>>>>>      * pci_epc_multi_mem_init() - initialize the pci_epc_mem structure
>>>>>>      * @epc: the EPC device that invoked pci_epc_mem_init
>>>>>> @@ -48,17 +29,11 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>>>>>>     			   struct pci_epc_mem_window *windows,
>>>>>>     			   unsigned int num_windows)
>>>>>>     {
>>>>>> -	struct pci_epc_mem *mem = NULL;
>>>>>> -	unsigned long *bitmap = NULL;
>>>>>> -	unsigned int page_shift;
>>>>>> +	struct pci_epc_mem_window *window = NULL;
>>>>>>     	size_t page_size;
>>>>>> -	int bitmap_size;
>>>>>> -	int pages;
>>>>>>     	int ret;
>>>>>>     	int i;
>>>>>> -	epc->num_windows = 0;
>>>>>> -
>>>>>>     	if (!windows || !num_windows)
>>>>>>     		return -EINVAL;
>>>>>> @@ -70,45 +45,51 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>>>>>>     		page_size = windows[i].page_size;
>>>>>>     		if (page_size < PAGE_SIZE)
>>>>>>     			page_size = PAGE_SIZE;
>>>>>> -		page_shift = ilog2(page_size);
>>>>>> -		pages = windows[i].size >> page_shift;
>>>>>> -		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
>>>>>> -		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
>>>>>> -		if (!mem) {
>>>>>> +		windows[i].pool = gen_pool_create(ilog2(page_size), -1);
>>>>>> +		if (!windows[i].pool) {
>>>>>>     			ret = -ENOMEM;
>>>>>> -			i--;
>>>>>> -			goto err_mem;
>>>>>> +			goto err_free_mem;
>>>>>> +		}
>>>>>> +
>>>>>> +		gen_pool_set_algo(windows[i].pool, gen_pool_first_fit_order_align,
>>>>>> +				  NULL);
>>>>>> +
>>>>>> +		windows[i].virt_base = ioremap(windows[i].phys_base, windows[i].size);
>>>>>
>>>>> Do you have to ioremap upfront the entire window? This could be a problem in
>>>>> 32-bit systems which has limited vmalloc space. I have faced issues before
>>>>> when trying to map the entire memory window and had to manipulate vmalloc
>>>>> boot parameter.
>>>>>
>>>>> I'd prefer we find a way to do ioremap per allocation as before.
>>>>>
>>>>
>>>> Hmm, thanks for pointing it out. Current genalloc implementation works on the
>>>> virtual address as opposed to physical address (that might be due to majority of
>>>> its users managing the virtual address only). That's the reason I did ioremap of
>>>> the entire window upfront.
>>>>
>>>> Let me see if we can somehow avoid this.
>>>>
>>>
>>> Looks like we have to introduce some good amount of change to support dynamic
>>> ioremap with genalloc. But IMO it doesn't worth the effort to introduce these
>>> changes for some old systems which are supposed to go away soon.
>>>
>>> So I think we can keep the old and genalloc based allocators and use the old one
>>> only for 32bit systems and genalloc allocator for the rest.
>>>
>>> What do you think?
>>
>> sure, that should be okay. But can we check with genalloc maintainers to see
>> what they think?
>>
> 
> There seems to be no maintainer for genalloc. It was written way back in 2005
> and improved by lot of folks. But there is no one to take care of it.

Ah ok :-/ We'll keep both for now as you suggested then.

Thanks,
Kishon

