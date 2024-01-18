Return-Path: <linux-pci+bounces-2306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EABAB831168
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 03:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633601F234BB
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 02:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570B233D3;
	Thu, 18 Jan 2024 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t+nmwcR1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B625B2115;
	Thu, 18 Jan 2024 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705544851; cv=fail; b=kjOL8tAVxnXNMdyas7YXwqV5oOTqShgGp2hWKvV2UapslafxkmnRIU51LoUVjYH+2oBNrTsv6Pe2Fy7BJLbgcyoWbDSz6Yf29O3pFYJ2khz7tLg4rXmlaLi19ar9vNuq6dKS1rIFPDpTprfONQKvGT1uRBwAR69wCvgI0qE8+DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705544851; c=relaxed/simple;
	bh=UVp+bxkaur2uiKDCE7nzJXjqcm0KNliPgG/S8UAboyo=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:From:To:Cc:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=XqCX1Zh6pfyRwSQ+FqZi1eOGNr6r/BXcJiaXVia9dyvdZs/Y0YEaD6Ps41SsNYk5VUaRFbwfFHkvxj2ZTw6g2RDEHi4MbC7yiETbJ2oLMN85WXim1hPOE45o9TnChSZTq3QYaaQpJgkcECqhaC9dKbq0TBfjCi4JzISPiYgzens=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t+nmwcR1; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTvCz/Z4TmBFQFhWtRFMAn5Yrj9TxTxw0g+i3EtEsrkoCvZ0jllqzTLgRm6cbIXzWMwKa+Nchz0ObRu47jBIIBc9Hqla/D392Q2CmTl0KMXlQDgCt9SoOzzFMxfjW1KGItOoEa1XMRESrMpvcQddrEfnzZqLwq5JUVb2ATX5bWf2jDyn4ezJCOLMXmit8JI4h9jnisIRMKeqlaABP65O+DdTQatYuIOkm3H2A5Ltl1TekCH3XtYvwePlauYzV17cSA8BlhCbgT6Py7p7ZzeC2X517YVHLqwVgTJnO+Yl75nQ21532Qpl/woKTPiaFIlK6AiJ3KY/wPHc6UqoZVVUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jW1+ydVm2jtXC9dpAjNj05uXV5F7SpkhbD2aBiExeyc=;
 b=EjEgdTqt71vBBbdQz00iyyuBrY2RGd4RHZPlQIUV7IM/eioBq2XQpqT20JW6xXg/WPJeOnG1UBdUdb3VPbILQHTGD/MsvqhbBmFcWjoctMlG8iUgYXT1cZHKh8ePVBfzPXPRW55v2fz7cSglihb9tIQvCw7rDI8xacnPGBIxgWVyqiF/4anv10hxB1RZtpsGrka3h7bWllGi7ophF+dMR6on3q0QIYpD7KnwubMcJnbsCwj0Ib6HJqhEYcOD+J9rItfNQY2ssCSoS/V3JSC4H0+Ep14BXoEHmDx3je99H1U9ggvepMFD8tcmBIZ4IpAWmTEhXocVThgp9BEBEC3W7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW1+ydVm2jtXC9dpAjNj05uXV5F7SpkhbD2aBiExeyc=;
 b=t+nmwcR1cKjdj4smur/oPfFVp6bBdG7jVax7xQ1TPazuGxX+IbigW+vrhRn/6qfXpHguo7wHmjLmmz0UYB0CCC0DPjLPW2nfl1Ew21wJq5ewa7htIOVLq0dZWMqUHzC0oJNpHYEZh+29ASx1/80QQv2rF7fV6zQZGuen84oo5m5+5AJbtfsIXwiawb3ZDo6z7XGW7acXdY8bSPLSTMgiQh8I3Rj/E6rop48y6uLkgvctNeLVzb3UmJXbEU7lY5ES3IOjj/PPa0J0osDL2GS4TIvVXymgYhXtPKk8SO0HsOFtsUe31YOVim6gKqgGfcO5Pha76HHAE4QCSLUm2x8YlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Thu, 18 Jan
 2024 02:27:25 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 02:27:24 +0000
Message-ID: <b746288b-32f0-4f08-8c9a-6adbe195d429@nvidia.com>
Date: Thu, 18 Jan 2024 07:57:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] PCI: pciehp: Disable ACS Source Validation during
 hot-remove
Content-Language: en-US
From: Vidya Sagar <vidyas@nvidia.com>
To: Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com
Cc: alex.williamson@redhat.com, treding@nvidia.com, jonathanh@nvidia.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, vsethi@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20230111190533.29979-1-vidyas@nvidia.com>
 <20230730191519.3124390-1-vidyas@nvidia.com>
 <20230730194026.GA19962@wunner.de>
 <7880aa6e-9fc5-c026-138f-42bef3c48b69@nvidia.com>
 <20230731195930.GA13000@wunner.de>
 <f7324ca4-2c57-459c-a9e8-aac09ba65e87@nvidia.com>
 <20240108141901.GA17779@wunner.de>
 <7345c2d2-5446-49a6-9ceb-0f1b9ee4ec18@nvidia.com>
In-Reply-To: <7345c2d2-5446-49a6-9ceb-0f1b9ee4ec18@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::9) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e99be52-8b2a-41cd-12c7-08dc17cd019f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yIPphASds4uer+Xilo8hKLbili2GAGtdWLcCEa+XcqyJlpPWdJaxbYbAZLVVPyMpIvFxEBhgAOMs3Ug8K4+wq3Gb6N5AriqDeOWexxE6VaHynecaB9hJCB/1n4OwlMJ8IpGRevwgFA+f9CRwyIKK1JTeOqx9qXM22/59ucknOhpU4Y910bRjm5GgUcRzjmJ5hOhcfc7zo8XZWe+bdOoCJq2IwdJyDKkv5/0sc7qcTSfGhq6fZN0LDeIuQdaln9RL1H0FzhfcAczI5Ji40noraPJwZVIgw0O7uFl8mEAff6xzJeo96DnIo/zyMEJxtX7/H1sclbeM9+WuRwo4ePp8KP0DZNiEYDwTHbH6On3pN4r02EQRaoJvaF2ioNEFawfBsB7+xYUhtpZMMnp+OVW2FxDZY0m/zsykNBNXVdJpwFbCcmvdgtApmS+WexHFu5QNZB/K/2DgXerQpZ8Z326BT+ZJiMEDrRRCwfPE5ifl9uFJa8rTLUtrCfCIof92bEIa01e8/waX1g4sLQrx1von7Xv1MokljNX+aqJx2E6aCnZpkZp43Z981oj8Qrr6tquAhXmng3iRWYzTz7PDyA3XyJIWqbC35V6BxGWiZt1VPugD3QdT0XQ25r0lbpPkH00OEvWCPlST8a706imYvrHoGocXgZjPun8qxovWFDaXcOXEM5THNAqoEaECPtgQouog
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(230173577357003)(230273577357003)(1800799012)(64100799003)(451199024)(186009)(2616005)(26005)(83380400001)(41300700001)(6486002)(31696002)(31686004)(36756003)(5660300002)(86362001)(53546011)(6512007)(6506007)(316002)(66946007)(8676002)(8936002)(66476007)(66556008)(4326008)(2906002)(6666004)(38100700002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejdYRHBUWjNLSWhTN3lEbDZRcTNQVmhZN0xFT01zUTI0Y05EWWY2K2oreis5?=
 =?utf-8?B?eHBmMTg3QXh2cDdGaDBub0tGZkdObGNSYVhvTlZGUGIzWk9iMjc3R1hkRXBL?=
 =?utf-8?B?dS9taDd1QWRlOXNWam9wd3pxRFltdUowQjRsNlhmZjE4NXFMV3FFUTdUOUNR?=
 =?utf-8?B?YzBMQTBIbjBpd1RhRks1QmNMMmhlakpZMDZ1TXdXZ2RkcVF4dWwxQzYxT1JB?=
 =?utf-8?B?ek9OaHl6MHhPRUZjMFVPL0tDejQ3NlpXTTNOYzFLRFRoR3RFU1hSQzNDVWxM?=
 =?utf-8?B?NVVQbCtSaCs0UGkwTDJWUi9haElKOXNiVUVGQWs3azhWNkdkV29DTnFQUWFp?=
 =?utf-8?B?VWdwSDAyQkFEUmZra29ZVDdCUVViVVk4RWZtVGNBSWM4OGlBcHN0N0JaczIy?=
 =?utf-8?B?SkZISjFYb3B2eHRhdDJqZHRSc1BzQTU4LytkL3lQZW5JSE1JbkIvcWNXdHpX?=
 =?utf-8?B?SDRMVWVHRmlxMmlJNGZseStZZkZDZkZsSWtIc2lFcjhwN0RmdW80bkczcVQ0?=
 =?utf-8?B?QUU1ckRSbEhXU2hzSzByUnhaRkVXOHhGclNKUitNby8zSmN3eTZ2K0Fqb0R6?=
 =?utf-8?B?bFhhVmRHaXNCY1EzakdaQ0hjY2srOFIzZTltdnRDd2NRWCtKK1RvVk0ycWFY?=
 =?utf-8?B?c1dhMVhDMlh6aE5VOG1kcTZVL2NLbXpta2pqWUF1Q1pHanFxR3U0RitoRCs2?=
 =?utf-8?B?dVMrMUFXREZtSGFWYTZBb2RUVFJZayt5ZTUydHJWbXdGU3lsRjNrbzM2WkNr?=
 =?utf-8?B?MUdjWE1Bck5lcEFEUG9iUTM2OWxmditTZ0t0UHlvdTVsWndLYnFsUkZxTHJL?=
 =?utf-8?B?WVd3anFhdXA4RXc2azVNdzJ0VWJLZHVQeUZlcWVSeUxaVGNIa0t4Z0ZIWkh3?=
 =?utf-8?B?cDBob0hFa3hMZmtWNDYzb3dGZGVoVWhIMGo1UzRuRExvL21SK3J0U0xmSjBl?=
 =?utf-8?B?VW9UZDg3VzNsR0NwMzZ6Rjd4YlN2MFJCOHh2VEFack5rdEZyek94QzREOXNO?=
 =?utf-8?B?bzliWkxXeHpkem40eUFYT0JFVTRFK2ZBQUZ2OUhxaStvR2cwWWJweUNxRXAy?=
 =?utf-8?B?Wi9ZalNzTGxram5zNWlhSHVBWENINTg1QU5QOG1sczRtelpqWDdsTU1xc2pu?=
 =?utf-8?B?dkM4YW1od3hWcTdmekFuVm1LNUpvRGU0OWZCaUVTQW1TbjZaV1JuSVZURmdP?=
 =?utf-8?B?cERMNEV6MG1mVi9xUUVqU09oTnFDUlhycGJCNmhTU0UwSEt4cWtpYkIxbGR2?=
 =?utf-8?B?TncySEJXSGY1SDU1VzhCcU1FNUFMUGc1dDNFaGVleWlvVEFJZnd6WHhTVDNH?=
 =?utf-8?B?cDJEYU5LKzZnWGZCZ1F4dzIrcVQvL3dDc2ZIUmpwU2RKM0R6NVZGZlk1OFlo?=
 =?utf-8?B?ZDNhUXZlTWVXb29VRkdtYzdnQVltT2JLTVEzaVppbkUvTW04WGxhNitLaTlp?=
 =?utf-8?B?cUw5bU5YUDYyd2dWTFhxKzZnek5mRit4Q2p1a1dHTkFzczNBYy84c09FalJB?=
 =?utf-8?B?aHpuWlg5dnViQk04MFVOY3o2WGJwY2Y0MjlhMGZ3RTZxUk9TaE9IMitsbEpS?=
 =?utf-8?B?WithZkE1aHR3TWtWMUtrQ1ljN3V3QTIreFhjOG5KaWsvdkYvUXZjVW9uZ0Jv?=
 =?utf-8?B?SWNTaHdjT1FHczVEbGZLSk9iZllhZU5XRnErS0ZBeVAybnlyZTBaenJkeTMr?=
 =?utf-8?B?SEdPQ0pEOFRIQVlWcnRVbmV1QmtKSjY2UFJTQWxWM3Q2Y3dOYVdsMDZYdFUy?=
 =?utf-8?B?UzFWQnVNNDBCdXd6SUVNZ1ZCWXh3MHdreUJkNytORDhiRmgzRmk1dG9lbFMz?=
 =?utf-8?B?NzdYeW9nVVloRWlyUGlRUzBhT0p4ME1FbVdtZGI4ek5MV3FYa3FydHp4TVB3?=
 =?utf-8?B?L29TcHU5c1Y5L2NNVVBLNFFYdzdmNktCR05IMnRSRE1UYVlKWG9EdWhmZDdC?=
 =?utf-8?B?QWx0R2NCUzR4TWs3R0M0QnJnV01hWlJ3VVhnaTlrWGhmZTJZL213SnNGZW5h?=
 =?utf-8?B?MldmVnFpMnlOblFiN3VJREpzVTRBR0xNWDFaUk9BTFdEMm0yeGdwY0hSY1Jl?=
 =?utf-8?B?SGxkbDErU2J1U3RzWElya25PRytoM0xOVXoya2NUdXl1WWI5VTBiQmN2K0gy?=
 =?utf-8?Q?gDmji3Czp8v8UKJERBXuprcgE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e99be52-8b2a-41cd-12c7-08dc17cd019f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 02:27:24.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqI5FTBJQ8C4brX3kEkKNwQNf8yGUpPQYXxULUDBSAMM+13FUQJrFK2JmDnysAjKJevL2uNrEHXL03tjAluMxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267

Hi Lucas/Bjorn, any thoughts on this?

On 1/11/2024 7:14 PM, Vidya Sagar wrote:
> 
> 
> On 1/8/2024 7:49 PM, Lukas Wunner wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Thu, Jan 04, 2024 at 08:01:06PM +0530, Vidya Sagar wrote:
>>> On 8/1/2023 1:29 AM, Lukas Wunner wrote:
>>>> As an alternative to disabling ACS, have you explored masking ACS
>>>> Violations (PCI_ERR_UNC_ACSV) upon de-enumeration of a device and
>>>> unmasking them after assignment of a bus number?
>>>
>>> I explored this option and it seemed to work as expected. But, the issue
>>> is that this works only if the AER registers are owned by the OS. If the
>>> AER registers are owned by the firmware (i.e. Firmware-First approach of
>>> handling the errors), OS is not supposed to access the AER registers and
>>> there is no indication from the OS to the firmware as to when the
>>> enumeration is completed and time is apt to unmask the ACSViolation
>>> errors in the AER's Uncorrectable Error Mask register.
>>> Any thoughts on accommodating the Firmware-First approach also?
>>
>> Are you actually using firmware-controlled AER or is it a theoretical
>> question?
> Yes. We indeed have a system with Firmware-Controlled AER.
> 
>>
>> PCI Firmware Spec r3.3 sec 4.6.12 talks about a _DSM to disable DPC
>> on surprise-hotplug-capable ports.  Maybe that would be an option?
> It looks like this _DSM is totally dependent on the port having SFI
> capability implemented and unfortunately our system doesn't have
> SFI implemented.
> 
>>
>> BTW what happens if the system resumes from sleep and a device in
>> a hotplug-capable port doesn't have a bus number configured yet
>> (because it's been powered off and is now in D0uninitialized state)?
> Theoretically the answer seems to be yes, but, since the platform we
> have is a server platform, there is no support for sleep and resume on
> this platform and hence can't really confirm this behavior though.
> 
>> Could the ACS Violations then occur as well?  Do we have to mask
>> ACS Violations *generally* on Root Ports and Downstream Ports when
>> going to system sleep and unmask them after setting a bus number
>> in the attached device on resume?  And I suppose that would not
>> only be necessary for hotplug ports?
> Again, how to do that in a system where AER is not handled natively in
> the OS? AFAIU, there is no mechanism for the OS to inform about the time
> it updates the bus number.
> 
>>
>> Thanks,
>>
>> Lukas

