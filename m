Return-Path: <linux-pci+bounces-17989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C2E9EA93C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 08:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026C81689A6
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 07:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C84022B5B9;
	Tue, 10 Dec 2024 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5gwMTiIp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11B57DA6C
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733814360; cv=fail; b=fPB7W9HHAiIwApXOTPcEEz8BrVng/8fNIKWa61zEJ2Hg0zwad1ZiD+OqiS7vZw9W27G+miXJgHkXwsExEOVprENVX+nJsZ0cDv1OcTxJYl/OFPMXAHzWAphYiXxu4SKLQZ5VYMrhdzIS5Dxw5W9DyqTTiXCBhDZCpA02WYn/3CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733814360; c=relaxed/simple;
	bh=lUcGqOudSwlmAgzBD3dbqdDx3hjSUkqbzl2iyzzqKaU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l280PIfJZBwZxT6r4kWQF3ZmnipXdO4iG8ExIy11YY2fKP2Gx8iR677/GS4nrQnfwmzPoK/ClrMX5suYUIYvYpyfCafiScREHpSvQV+VPoqVqgg5sy5Y0mgFjeSZsPnkNPg7p0XgiiRsRoZn89IYB5YglqHbdK0elxkWuF/APdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5gwMTiIp; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMm9dnynB9oztIKnt91KRp5tZWgIo7VW93M6V2Gg2iRNLghaDbIMItx+Ui6c79O2ROlkWeFEyucP5Sw36fuGR8glT9SZMJcqu29Ltu199gdzdg+twpmTMGt+/ObDYjwHj5h1o5FHSMnjHyk2hTjK9vLAflTApvsIne4A+FVcvT134KJKm/ohMPSQ3skmXkgW/yTxqFrj3H5M9XoAV/qKzHelF1iRQNFlADL8vVHMA/901FtMh+8VbS8I0Zj3eUyXr1gKBs7cPAyRdX6Mh5YTnkiWjkYENMtZUdSdapqFhbxd9mZ6j8tBbbMJtGovbE+LwjwyaLjRNE+a3NVff7j7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cx0bH2nvRWo0qM0OSi3L1NBdbxwzXXsO76kLhHjzQPY=;
 b=FAzBPEjiDhch3CGv1FMPm2sAKLWJg6mp8MAccl2wQCCxk0EFjVOK90mNvnMmg7AomEj4BBhtS5+4CnnoY+UullGp+AMwLYvX8sTdaD0cFmv8cVZwhjL/uIaQasFmMKgEebyu1/aXlU7UGI7VzpCu48zjHGXY95bvjlRSLQ385/r+h6Y9MHLkCO7f1G2cIot76ykHedPX1sez0g3g8kta3MOBpzcikUp/w3Y3WwAGxCrUalxcHGbrT6pjKrdfkYrwTMNjiBeVayFyB4OFzFh5rFFMBsDkEfZMisHXgqrfV7/azq6y0gf7c524Hrnjw+JRAnLaDOR2k8EttlL2leFxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cx0bH2nvRWo0qM0OSi3L1NBdbxwzXXsO76kLhHjzQPY=;
 b=5gwMTiIpELE2C/Lr0AR6pXjEIY58Lhx0AUSGu2g8yMZDd1cv8idsnQHwyjoJs8AH6g7w+3HsR2i9NzvJhZs7qQi1ir9Jh7Kv95xfYBmDmUIZaGWAoV7URcDVs4Yo0Cbk6/vO3f3dGnNjTj0EgPayOUzZo//2z/dx60J3zZ44apE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 07:05:55 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 07:05:54 +0000
Message-ID: <2e7f85ea-40ce-4b38-acd9-56c02718771c@amd.com>
Date: Tue, 10 Dec 2024 18:05:48 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P282CA0036.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:206::13) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe8189c-e743-4630-fe48-08dd18e916c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDNsc1lkbi81QUFQQ2hES3BqUzdiWlQ3a1VoMXdIYmNFVHZUckpnTjZMU2Ez?=
 =?utf-8?B?S2tlSjhCZysxbEdzcm92RUkzbE9iYUY5bWxSbW5QUkhxU2NvV2VVSnpUSTQ0?=
 =?utf-8?B?NjJlUEJveks4Nnl2QVNOY2szV1FXWEZMemhtRTRVemt5eHhubDl1ZzZRL2VW?=
 =?utf-8?B?VzRZQkpidXZ5OUtGUlZpRW9NNisxMVc3d1VkVzExR3dLdXZ0c0FjZklVYzNH?=
 =?utf-8?B?eTl0STFKbFJyYm85MzFHcjNSN09pUFYvYlFCWW5nTnNOWElCbnh3aitKbkJ4?=
 =?utf-8?B?cTNsTXl0a2lIMEsvNkl0cWtmN2ZOOHhpSzE2c2hQL3IxTC9Nc1hOTi8yQjV3?=
 =?utf-8?B?QTc3QXRMZWc5dTQzWC8xNDBBOUdockhVR3kwanhVeXF1d2pqb04rLzMwU3B5?=
 =?utf-8?B?MHlpMnVFVGxFdisyb29YTVpTZzJMUThEUHpsUnNETjdxZENiYy8vc2d2NFVy?=
 =?utf-8?B?dDNWNnBpTHN0ZkJoVlE1K3JZZ2FxejBheDVVN2ZmSjVvVUEwY291OXd1Skgx?=
 =?utf-8?B?Y2N5allkdzFwY3U2TzgyT05XT0V0NDY3R0xpZ1NuS2Vjd0oyVmRhV2w4dDZV?=
 =?utf-8?B?MjAzNFRFdm9TN2RmK1h2ZW5FeTlHTmZXck8ydFVtUmhzeHpEMEFiOG5xYVBm?=
 =?utf-8?B?Z1EwVDZCNlhnT2Ntd3lQZTZFQ3k3SDJseDB6ZUI3TWN6eS9PcS9YZUd5TjlI?=
 =?utf-8?B?VGI1RUVoQzBIbU1qSzZ4M1F5TzVSc0l5eDlQZU81SWJIYXlGS20xSjBJQU1y?=
 =?utf-8?B?WUU2NDBzSkxOd2lvNTJXc0FNTFhXZUNVbEQxTlhGTys0MzVjWHlUUFRVN01Q?=
 =?utf-8?B?ZGFiaUdWYXVxM2xnTXNOUzdtYmwrNjN0YXN2Rzg5dlVvR2l5amUwVkZFbFhu?=
 =?utf-8?B?MXF1WWFGditmaE8vQkVHMzgvWS9ncDZTaGxnQnBHVFJtKzZSMkhjNk9hVTNy?=
 =?utf-8?B?cm5la3k4WmZobFZqR1lNQ2UyNVJObEV6MVJQWWtiY2ZVcWZHbldNcnlIdlJH?=
 =?utf-8?B?aENjamRqZmpuRkxlLzZkOXA5c2F4RzdnUEt5MDF5TklXeWh2YkU1bVl1K2sy?=
 =?utf-8?B?Z3YvRlFWT0ZocldLdkhESXRrSjU3bFA0NEI1YWNTbzhzeHNPeEFnQTBsMmxt?=
 =?utf-8?B?R1lyalMwOFVzSEl0SW92cFZqQVc3bCs0d1hZUlNBaTdMYitwNFhUeUhwY0NB?=
 =?utf-8?B?cHdTV0ZuYXRLVWdWTVZmY2pyQlZXa2VxRUk2NnJ5Y3RBa2Njdm9zcDB0RFBu?=
 =?utf-8?B?UHpvL1BkazhUdmQ2SjNIN0RVWGs0OUE1VVYvZTB5a2lvSXRRZ0w4MFBKTnVu?=
 =?utf-8?B?dW1UcWpEdnVFSENPNU9zZGJ0dFAvL0xEazhXNlZPQURqQXlsRjd4cEZYL3Iz?=
 =?utf-8?B?UHB1em9BMnJEaEJkR1ZTMFVGWEpLQnJkcjg2NUEvYmwrbS9TY0tES2srY2V3?=
 =?utf-8?B?VXpWbU80WFZ4OUlLdlZzUUh0aWtqeFBCdEJmZFVjMXFXclFOZnFIb2tmaGlm?=
 =?utf-8?B?OE54Zi9UTEo1b0hxaWp4ZXo0YjEvYW5zWDNRSkpKYXVLclZZQzR6SkM2NmQ4?=
 =?utf-8?B?RmFxRFljQmRqczl5bmVZNkV1Vjhmb3pxajcwdFlJYW55YitaUmNyTVJ6WFE5?=
 =?utf-8?B?OU1yOXNNS1ZJK3puVzQzWFpDQVUyUCsyTzJqbHZLc3F6SzFjcEdUN1EwTDB1?=
 =?utf-8?B?U1NxVzdjNkRHNjQ0R2QwMkViVUd4QnRBV015YWpzbDlrRVZhWUE4UmVHTThT?=
 =?utf-8?B?MlgxbFF5K1MrWGVTend0amtiSWJjdnBNMXhickFxaFBGOUZKRVpiSzA4UFFI?=
 =?utf-8?B?WU43NjdqVWdhdGpMaERJZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHpIVjFHQlFDZ3kxSmlhMHV2TGV0NlRlS2Y1NHkyNXhLd3Y1Ym5Qa0kxR25U?=
 =?utf-8?B?Rm80TWJlSkNVV2hEZUE4ZUtuNnpsRkkvUE5FV1RGcXVRVVBwVjBMbzY3TUs5?=
 =?utf-8?B?VWZXdlM2VGNQMlFiWmd1SnZuZ21UQ0xUdzdiZDFNN0hPYUxKc29FR3J6REhv?=
 =?utf-8?B?SHovT2hiaEQ2cVg4aFRFSkE1TlBGdkhEaTYrYWYvSHl4OGJMemxXUWVZcDNt?=
 =?utf-8?B?eUhFTUhvbnp3M3JYSXBRR1BoMVBwSXk5WUpvOXoxdWpuNi9GYnkwN2Znelo0?=
 =?utf-8?B?RkpFL05YWnBCd3R2dWJBRDNDcnh1R2F4ZS91R0g0Z2s5Mkx4ZnpFaEdORmlG?=
 =?utf-8?B?SWp1WlUwZGlxZXArWllOS2JmcmJKNzJuWVhSZWdhNkRYdVJmbXYvZjVlWnFi?=
 =?utf-8?B?OXROVGY1TCtEeGNJdWsvajhVUFBGaGs1SHZpV2w3bGlSOXMzVFJHeDkyZUg1?=
 =?utf-8?B?NUcwK0dWa20va2R4OG9rYWNCOUo1QWQwTGZaMWppdzgvcjYwSEU0Y251RGlq?=
 =?utf-8?B?cGJaRzUybDFHK2FJejRjRksvMXRXemVOMm5VN04wQ1RFbS91OTZIaU1tQlhx?=
 =?utf-8?B?Qy9HQ0tSeHVyOUlORVlaekFnYUFwREVrazd4eVJMdmdvc0NpRjR5VTliSisy?=
 =?utf-8?B?N0hOcWt2YWlpemc4SnpMZkpHa1Ewa0pvRGh0MTZjbmZ6dVRBNGk5bllCdFZQ?=
 =?utf-8?B?ZTVJRXVoWWljSHJuWnIwWGhuS0llS2tVTVB0WDV6YUNSaUdheDRFRjdVN0Jk?=
 =?utf-8?B?TnU2MU95YmNNdTd4WGhPektSY2xBTmtVRGpnSnhaK1NIZjMwanRWbGtRVVN5?=
 =?utf-8?B?cUZHWVAxREtXZ3FOdjhVRGJ6WlVPb2EvNmZlNlovNjdhazR0Z2IrUGE4bStl?=
 =?utf-8?B?ZHpJM3ZhbnhCMzRmWHlxVnAwb0xyeTB3cXlpcW42RnJaTllnMFpaYmNJaGRG?=
 =?utf-8?B?VHJNa2FOS3BYVFJPY2twaUJHSjljTlQzYWxuRVZLRTVJU210dWxtbDJDYjBK?=
 =?utf-8?B?YUZTUm9LaS9Xa1JybUFJcWp2OHRpSUdRSU5iRnhMSUhxOHdnK3BqV2k2Uktz?=
 =?utf-8?B?S0czQ01McWQ3WWNUOVRhQlZ3NlJDeUROUHlwTFhqSUhDdGdKd0dNKzZ4V3Ir?=
 =?utf-8?B?a3dSMElqaW01T0U3amh6S3MzY3pvZXJ1Uk15NzNlT2tGenkzMlpFT0paTXl5?=
 =?utf-8?B?SFNjMi80b25GVTNPUTdEY203Vm94dm9mVERNZXpkME94TlpIRVY5anpwUU1Z?=
 =?utf-8?B?Uk01TmIzT2lQTWVrSE5EQ1ZiQ0pvalhzektXeFAxUWlLcWZ4RnE1R280RTRq?=
 =?utf-8?B?anVzeE5xa05nRWlLbElLN1czOTJyRXliZ014ZkNpZXhPRFlDSXFlcXV1c01n?=
 =?utf-8?B?ajVOdlgxZmRlZWdudU9mNU82YzJGaDAzeldsNkl3TGM2RDRoZENWWDQ3M1J5?=
 =?utf-8?B?WTN1NC9wdW9NeVRSY2JQeWpMamh5ZHdBQ1l1MHZQU25RYzY5ZGllKzJta0tC?=
 =?utf-8?B?dkJyMWQyYnk3L0NjdGxKWGxBZjB3MVZzSFF4SElUNk1UOE5VaU94dzlxQ1Er?=
 =?utf-8?B?UjBJdE40UGwzY3VsN1FXd083eDY2bzlZZGVxWnUyUE1IbndQcHBGV01ocjJG?=
 =?utf-8?B?dEZBM1pnQjJFVHUzRmVmaUdMR1ZjdVNtVHlCd24rTjN4Y3MwTEZqSlREbWtM?=
 =?utf-8?B?RFlFMkFLV1NnMC9XT3FLY2hsTTEwQXdDUjJXR2I4ZUtXN2oyTzZaTWZjSWIz?=
 =?utf-8?B?VTZIUEFCcjhrYURVQ0w0Y0FDM0wxTStISDAxcnBlTWZ4bmhUaUVWSk5BNUpN?=
 =?utf-8?B?bzJHZXg1ZDVMclBUN1JSL3dZZkJDajhkdlpQZnhhYmFWdjI0MWdWRzNaSTR1?=
 =?utf-8?B?dGczNlZSdnRKR05lbUxNeEE4Ung0YXB6cDNCRHBISWhSaG5hTEl2UHc3MzQw?=
 =?utf-8?B?U3NDRjR3RU5mOFM4bUdtS240bmxXb09pRFV2RWhTOGlyVlpjYU9yVmZscjI4?=
 =?utf-8?B?TkVGNFQ5a0VmNTRvaGRtSFZNN0d4M3RBb3NVbS82ZzM1SXI0VWVmK3FiNUpw?=
 =?utf-8?B?UkZjUmcwT0dROFA2WmNvcVZiZUdkL0MxbjBnUnFoV0xNSkNEeDdxb0JVMHJB?=
 =?utf-8?Q?MvxaPcNbhEfxtRfsVIRrO4dLB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe8189c-e743-4630-fe48-08dd18e916c3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 07:05:54.7962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwbCq7as4mK4xit76lOrjGHXLj38nGLauXhMh/GvbPnsmTOEdBR/2tjZYVWxxo9m39YFXjkok+K7lAeLCh7oSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872

On 6/12/24 09:23, Dan Williams wrote:
> Link encryption is a new PCIe capability defined by "PCIe 6.2 section
> 6.33 Integrity & Data Encryption (IDE)". While it is a standalone port
> and endpoint capability, it is also a building block for device security
> defined by "PCIe 6.2 section 11 TEE Device Interface Security Protocol
> (TDISP)". That protocol coordinates device security setup between the
> platform TSM (TEE Security Manager) and device DSM (Device Security
> Manager). While the platform TSM can allocate resources like stream-ids
> and manage keys, it still requires system software to manage the IDE
> capability register block.
> 
> Add register definitions and basic enumeration for a "selective-stream"
> IDE capability, a follow on change will select the new CONFIG_PCI_IDE
> symbol. Note that while the IDE specifications defines both a
> point-to-point "Link" stream and a root-port-to-endpoint "Selective"
> stream, only "Selective" is considered for now for platform TSM
> coordination.
> 
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/pci/Kconfig           |    3 +
>   drivers/pci/Makefile          |    1
>   drivers/pci/ide.c             |   73 ++++++++++++++++++++++++++++++++++++
>   drivers/pci/pci.h             |    6 +++
>   drivers/pci/probe.c           |    1
>   include/linux/pci.h           |    5 ++
>   include/uapi/linux/pci_regs.h |   84 +++++++++++++++++++++++++++++++++++++++++
>   7 files changed, 172 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/pci/ide.c
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 2fbd379923fd..4e5236c456f5 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -121,6 +121,9 @@ config XEN_PCIDEV_FRONTEND
>   config PCI_ATS
>   	bool
>   
> +config PCI_IDE
> +	bool
> +
>   config PCI_DOE
>   	bool
>   
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 67647f1880fb..6612256fd37d 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>   obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>   obj-$(CONFIG_PCI_DOE)		+= doe.o
> +obj-$(CONFIG_PCI_IDE)		+= ide.o
>   obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>   obj-$(CONFIG_PCI_NPEM)		+= npem.o
>   obj-$(CONFIG_PCIE_TPH)		+= tph.o
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> new file mode 100644
> index 000000000000..a0c09d9e0b75
> --- /dev/null
> +++ b/drivers/pci/ide.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> +
> +#define dev_fmt(fmt) "PCI/IDE: " fmt
> +#include <linux/pci.h>
> +#include "pci.h"
> +
> +static int sel_ide_offset(u16 cap, int stream_id, int nr_ide_mem)
> +{
> +	return cap + stream_id * PCI_IDE_SELECTIVE_BLOCK_SIZE(nr_ide_mem);
> +}
> +
> +void pci_ide_init(struct pci_dev *pdev)
> +{
> +	u16 ide_cap, sel_ide_cap;
> +	int nr_ide_mem = 0;
> +	u32 val = 0;
> +
> +	if (!pci_is_pcie(pdev))
> +		return;
> +
> +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> +	if (!ide_cap)
> +		return;
> +
> +	/*
> +	 * Check for selective stream capability from endpoint to root-port, and
> +	 * require consistent number of address association blocks
> +	 */
> +	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
> +	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
> +		return;
> +
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
> +		struct pci_dev *rp = pcie_find_root_port(pdev);
> +
> +		if (!rp->ide_cap)
> +			return;
> +	}
> +
> +	if (val & PCI_IDE_CAP_LINK)
> +		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM +
> +			      (PCI_IDE_CAP_LINK_TC_NUM(val) + 1) *
> +				      PCI_IDE_LINK_BLOCK_SIZE;
> +	else
> +		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM;
> +
> +	for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val); i++) {
> +		if (i == 0) {
> +			pci_read_config_dword(pdev, sel_ide_cap, &val);
> +			nr_ide_mem = PCI_IDE_SEL_CAP_ASSOC_NUM(val);
> +		} else {
> +			int offset = sel_ide_offset(sel_ide_cap, i, nr_ide_mem);
> +
> +			pci_read_config_dword(pdev, offset, &val);
> +
> +			/*
> +			 * lets not entertain devices that do not have a
> +			 * constant number of address association blocks
> +			 */
> +			if (PCI_IDE_SEL_CAP_ASSOC_NUM(val) != nr_ide_mem) {
> +				pci_info(pdev, "Unsupported Selective Stream %d capability\n", i);
> +				return;
> +			}
> +		}
> +	}
> +
> +	pdev->ide_cap = ide_cap;
> +	pdev->sel_ide_cap = sel_ide_cap;
> +	pdev->nr_ide_mem = nr_ide_mem;
> +}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2e40fc63ba31..0305f497b28a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -452,6 +452,12 @@ static inline void pci_npem_create(struct pci_dev *dev) { }
>   static inline void pci_npem_remove(struct pci_dev *dev) { }
>   #endif
>   
> +#ifdef CONFIG_PCI_IDE
> +void pci_ide_init(struct pci_dev *dev);
> +#else
> +static inline void pci_ide_init(struct pci_dev *dev) { }
> +#endif
> +
>   /**
>    * pci_dev_set_io_state - Set the new error state if possible.
>    *
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2e81ab0f5a25..e22f515a8da9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2517,6 +2517,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>   	pci_rcec_init(dev);		/* Root Complex Event Collector */
>   	pci_doe_init(dev);		/* Data Object Exchange */
>   	pci_tph_init(dev);		/* TLP Processing Hints */
> +	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
>   
>   	pcie_report_downtraining(dev);
>   	pci_init_reset_methods(dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index db9b47ce3eef..50811b7655dd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -530,6 +530,11 @@ struct pci_dev {
>   #endif
>   #ifdef CONFIG_PCI_NPEM
>   	struct npem	*npem;		/* Native PCIe Enclosure Management */
> +#endif
> +#ifdef CONFIG_PCI_IDE
> +	u16		ide_cap;	/* Link Integrity & Data Encryption */
> +	u16		sel_ide_cap;	/* - Selective Stream register block */
> +	int		nr_ide_mem;	/* - Address range limits for streams */
>   #endif
>   	u16		acs_cap;	/* ACS Capability offset */
>   	u8		supported_speeds; /* Supported Link Speeds Vector */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 1601c7ed5fab..9635b27d2485 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -748,7 +748,8 @@
>   #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
>   #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>   #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
> +#define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE
>   
>   #define PCI_EXT_CAP_DSN_SIZEOF	12
>   #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> @@ -1213,4 +1214,85 @@
>   #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>   #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
>   
> +/* Integrity and Data Encryption Extended Capability */
> +#define PCI_IDE_CAP			0x4
> +#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
> +#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
> +#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
> +#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
> +#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
> +#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
> +#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
> +#define  PCI_IDE_CAP_ALG(x)		(((x) >> 8) & 0x1f) /* Supported Algorithms */
> +#define  PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
> +#define  PCI_IDE_CAP_LINK_TC_NUM(x)	(((x) >> 13) & 0x7) /* Link IDE TCs */
> +#define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	(((x) >> 16) & 0xff) /* Selective IDE Streams */
> +#define  PCI_IDE_CAP_SELECTIVE_STREAMS_MASK	0xff0000
> +#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
> +#define PCI_IDE_CTL			0x8
> +#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4	/* Flow-Through IDE Stream Enabled */
> +#define PCI_IDE_LINK_STREAM		0xc
> +#define PCI_IDE_LINK_BLOCK_SIZE		8
> +/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
> +/* Link IDE Stream Control Register */
> +#define  PCI_IDE_LINK_CTL_EN		 0x1	/* Link IDE Stream Enable */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR(x) (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_PR(x)	 (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL(x) (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
> +#define  PCI_IDE_LINK_CTL_PCRC_EN	 0x100	/* PCRC Enable */
> +#define  PCI_IDE_LINK_CTL_PART_ENC(x)	 (((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
> +#define  PCI_IDE_LINK_CTL_ALG(x)	 (((x) >> 14) & 0x1f) /* Selected Algorithm */
> +#define  PCI_IDE_LINK_CTL_TC(x)		 (((x) >> 19) & 0x7)  /* Traffic Class */
> +#define  PCI_IDE_LINK_CTL_ID(x)		 (((x) >> 24) & 0xff) /* Stream ID */
> +#define  PCI_IDE_LINK_CTL_ID_MASK	 0xff000000
> +
> +
> +/* Link IDE Stream Status Register */
> +#define  PCI_IDE_LINK_STS_STATUS(x)	((x) & 0xf) /* Link IDE Stream State */
> +#define  PCI_IDE_LINK_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
> +/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
> +#define PCI_IDE_SELECTIVE_BLOCK_SIZE(x)  (20 + 12 * (x))
> +/* Selective IDE Stream Capability Register */
> +#define  PCI_IDE_SEL_CAP		 0
> +#define  PCI_IDE_SEL_CAP_ASSOC_NUM(x)	 ((x) & 0xf) /* Address Association Register Blocks Number */
> +#define  PCI_IDE_SEL_CAP_ASSOC_MASK	 0xf
> +/* Selective IDE Stream Control Register */
> +#define  PCI_IDE_SEL_CTL		 4
> +#define   PCI_IDE_SEL_CTL_EN		 0x1	/* Selective IDE Stream Enable */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR(x) (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_PR(x)	 (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL(x) (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
> +#define   PCI_IDE_SEL_CTL_PCRC_EN	 0x100	/* PCRC Enable */
> +#define   PCI_IDE_SEL_CTL_CFG_EN	 0x200	/* Selective IDE for Configuration Requests */
> +#define   PCI_IDE_SEL_CTL_PART_ENC(x)	 (((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
> +#define   PCI_IDE_SEL_CTL_ALG(x)	 (((x) >> 14) & 0x1f) /* Selected Algorithm */
> +#define   PCI_IDE_SEL_CTL_TC(x)		 (((x) >> 19) & 0x7)  /* Traffic Class */
> +#define   PCI_IDE_SEL_CTL_DEFAULT	 0x400000 /* Default Stream */
> +#define   PCI_IDE_SEL_CTL_TEE_LIMITED	 (1 << 23) /* TEE-Limited Stream */
> +#define   PCI_IDE_SEL_CTL_ID_MASK	 0xff000000
> +#define   PCI_IDE_SEL_CTL_ID_MAX	 255
> +/* Selective IDE Stream Status Register */
> +#define  PCI_IDE_SEL_STS		 8
> +#define   PCI_IDE_SEL_STS_STATUS(x)	((x) & 0xf) /* Selective IDE Stream State */
> +#define   PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
> +/* IDE RID Association Register 1 */
> +#define  PCI_IDE_SEL_RID_1		 12
> +#define   PCI_IDE_SEL_RID_1_LIMIT_MASK	 0xffff00
> +/* IDE RID Association Register 2 */
> +#define  PCI_IDE_SEL_RID_2		 16
> +#define   PCI_IDE_SEL_RID_2_VALID	 0x1
> +#define   PCI_IDE_SEL_RID_2_BASE_MASK	 0x00ffff00
> +#define   PCI_IDE_SEL_RID_2_SEG_MASK	 0xff000000
> +/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
> +#define  PCI_IDE_SEL_ADDR_1(x)		     (20 + (x) * 12)
> +#define   PCI_IDE_SEL_ADDR_1_VALID	     0x1
> +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK   0x000fff0

0x000fff00 (missing a zero)

> +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT  20
> +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK  0xfff0000


0xfff00000

31:20 Memory Limit Lower – Corresponds to Address bits [31:20]. Address 
bits [19:0] are implicitly F_FFFFh. RW
19:8 Memory Base Lower – Corresponds to Address bits [31:20]. 
Address[19:0] bits are implicitly 0_0000h.


> +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT 20

I like mine better :) Shows in one place how addr_1 is made:

#define  PCI_IDE_SEL_ADDR_1(v, base, limit) \
	((FIELD_GET(0xfff00000, (limit))  << 20) | \
	(FIELD_GET(0xfff00000, (base)) << 8) | \
	((v) ? 1 : 0))

Also, when something uses "SHIFT", I expect left shift (like, 
PAGE_SHIFT), but this is right shift.

Otherwise, looks good. Thanks,

> +/* IDE Address Association Register 2 is "Memory Limit Upper" */
> +/* IDE Address Association Register 3 is "Memory Base Upper" */
> +#define  PCI_IDE_SEL_ADDR_2(x)		(24 + (x) * 12)
> +#define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * 12)
> +
>   #endif /* LINUX_PCI_REGS_H */
> 

-- 
Alexey


