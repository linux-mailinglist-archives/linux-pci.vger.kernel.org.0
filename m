Return-Path: <linux-pci+bounces-2828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB87842C6B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 20:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C131C22859
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 19:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCA77AE43;
	Tue, 30 Jan 2024 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nzZ6vMMM"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D194071B23;
	Tue, 30 Jan 2024 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641817; cv=fail; b=pf8OJqFrGpWgAsXFo7js+XdfP7dHXxl/wgGABy48ayJSPpYuM5QoBNHpgqt/GkreFgx52+cHdqSSGpzwJFahWZ/RG8U1ssxA7G6CRuKcm+HELsaRYsHZ4kaCI6Vn/Cxex5SEx7mz8C1Av1BVxvA48e5xWGJnAl7jp/gWqXYrAFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641817; c=relaxed/simple;
	bh=RNMdBNWGRB9aozbl66V1Yjg1u7DDI2ivCHxYCVnPS88=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uV5QYpJ8JBXqpwMJh0TRvV+AufhlQW8eLSurMo0c2/V6DkkaCfWIae8tf1SrTk+Prh5PvFgAb+1IvW1TzIBXBiFIGkbVHSRhKr18KL8UQ0x+U31omPumbKsHvyywZ+suBvnpophhcAJ8VqWnteEVK7NZYV/pWXplgBeTVTxwedY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nzZ6vMMM; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTn93XM1G4V7A05dkXkYyW5YlTHqt4YvkH8mvcs+jXj1xwiNDQXurFEBT8ei2uof0EtGKK/rKSuAf8DZ+8kz3UqN6NNZbIQ8xaHw2mUJvlDKWYRRdA2v9lp+3JBT3bM2cZAbUjCeJW047FcALFZx8O/UZWKGlcxKaoAVYEOaDVMV7GBx9gma4pLjRm9o/zOFbKKbpaPFIxThcgOkGkGmmTWPJk9qh1ZGnQpURj9AVI9eUxXtqJl0DZiY3SnI8ZPkvNGndF8EC/RG+f5PetMkllvNBNOac0sBHKu3C6yg1bz9ADbbm3sCGY+gpkyZBzrFW2+gH1PnnoifNEkjy3bOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z28FGx7ELDyjyyzEPNk1nCypG88n6mEYl5VCOR55GhA=;
 b=ExGYIAsVWh7p3+tSGfI9sfdpFhlFo04TzivEtCbFyvyDkjfkJSJCQ7wF2/2UwKAC0i9CZKxkPxHA5zN1YYxEh7AVIxqpJc6SEmzIQ4fjmyK3cQrUoAIYdT1Io53n1sMPXUeAOMUrc+stRoZxoy0MxGPxeWmKIyx4NtOugKRqI8I30B+eiNUsLdtJqo4fLnbeMF5o/Lz6rmE7Zvm8QX4KExa/6KxadEee7WvDrU1f/dmgpHLiwSHxDWD/nfWitP5RLGMedfOc9pgBQZW7CrkN4rP9cMlOcteWLUUaozd1/FcFcRnvqam+gvbGBCajcXipvVs2exUBmgh7rZYssHzqBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z28FGx7ELDyjyyzEPNk1nCypG88n6mEYl5VCOR55GhA=;
 b=nzZ6vMMM0l4sxbUm50ZNKr5CKkNSM33wdGEr/BRlLhPIXVt0y6JP1P511D2Tv7jgU9MWkY2PdbU0SMDdqU1y/Xz/aIHkNjRhTIlkPcEtsXdqsgHHeKukbqKio7jMnMtj3uWZ5CC7yUlmXGoR84RoNcS/2rGmJajc2VZwnhPoLPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 19:10:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:10:11 +0000
Message-ID: <4478a4b0-fd17-4d5f-b11c-ba4a867bf92b@amd.com>
Date: Tue, 30 Jan 2024 13:10:09 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
Content-Language: en-US
To: Daniel Drake <drake@endlessos.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, david.e.box@linux.intel.com,
 Jian-Hong Pan <jhp@endlessos.org>
References: <20240130183124.19985-1-drake@endlessos.org>
 <7a8f3595-3efc-428a-852a-d9edc8ebb01b@amd.com>
 <CAD8Lp45ycrY-hkKVZGEQdeYmODauaShgFp2tj=QtEXK_C2tcYA@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAD8Lp45ycrY-hkKVZGEQdeYmODauaShgFp2tj=QtEXK_C2tcYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:5:174::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e84227-1c1b-4aea-a10b-08dc21c7152d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lcpTlnfxNJT6B3kxhfVOwV52/uSEk0kxIzHH51wp91XBZt1TdgNK6i/LBdjfqgdlrpgtaiDLO7IR1cZ8c0mJ+OWCkxX+9BOuEqTHuvZse9eV15C3+143skPTY4IgfXgOhFLlcJvj3I8yEoUuoRqdimZXXTwUWShBUNscOpePreiwED6nkmJRmzBZjL0kPDE/lzAVUNmg0zdbgpwJHLmmhCIgMUZLnMTtQgrKByGQRtLyTcXGJBEceAGsHXWka7VQdbDt26ZKloi3lwzQASW7RJ8n/3nGcOvs7uIarIThIGQlQOVS45jLGP970bFuDE3yNdZ7z0dZUlcMrvhR6ObpQo1IySfcaribi8h2EQ4MW4pR8yMXeDBDxTIOxAB+zNnaGJbNAMH+VzA/7OqXlPtlVcbTFjNnjBUWx1/Hbqk+i04eb8oWOUY2/Ak9W7S6g6brMyPDH6w1DWjPxZHT51XuTPhp9znuZAXZlfcv4q6x/heq0bQ/EecRFxfTDIxdXRfxLBx8MGSMyCVNGQ5TnyeXWDDxVSezRSCn5L9AU286pTuwE93MYircP5E5P5cDlwHd9AtzBSHltknM6EEit3Szawud9Gq5HbmTca+zm7C+3D+Bt+Fr/herc0QmTqL/Uv5SHWZUeVWxC3mga46ozrmYxfErp0tUVtkKnofqUAVtAWc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6506007)(6512007)(53546011)(478600001)(66946007)(38100700002)(2616005)(316002)(8936002)(41300700001)(44832011)(5660300002)(4326008)(7416002)(2906002)(8676002)(66476007)(6486002)(6916009)(66556008)(36756003)(31696002)(86362001)(31686004)(26005)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEpWbVB2M3JxQkNPc2RtU056M2RTV0VKV2l4NmRFcFRYVFQ0M1pzZEd2NCs4?=
 =?utf-8?B?d05malFvOEova3lNckFLQzhIY25RZU1ZeDVpMjRadVFVcUdtWDJMSUJYSkUv?=
 =?utf-8?B?S3hVdG1oZHRqSzlqK2w5RDFGei9ZcFhQMlg4KzI4OW5vWnJ4cGJObFZ2ekRv?=
 =?utf-8?B?dlFSalh4TE9jSHgwQVZhbmFiMnd0eTJKRmxITytNUzNMc1kyTVhLNUlRRkRk?=
 =?utf-8?B?NCtsNTJ3UGZxRmttWUIvUHRaVGVyaVlxTzNkdFVHTEs0cmpHWlR1aVlxb0RW?=
 =?utf-8?B?WFhWMVg2cVlnektTMXZNSE9uOE1uVnVMdEdHOS9WLzZyMzhVV3ZoN1paeHAz?=
 =?utf-8?B?NEI5UkZTRldNU2NrN0RoR2dvb01NWXN0ajVOcUxER25xWnZ3RnRvZ1orSEcw?=
 =?utf-8?B?NXlFT2h1K3pVOEt5WkdiQWVEUkpaL0x5Z2N5anhiazZaOGExaHJMd2o0dWVn?=
 =?utf-8?B?aWN2V2llem1ucGxiVndRQ1RkWGV5MVhGN09JUk9XbHhqdVkvd0h6V1pmSTIw?=
 =?utf-8?B?aE1pTzMxNi9PWW1lWDc4eGpxaUc0cjkxKzJUeUFPME1IZWxnNE02cHlPTHFD?=
 =?utf-8?B?OXlsNTNLTUdMN0E1cC8vQ0M0MUZldHBMNzBBR1dsNEUwbzlVeFpENnM0bExC?=
 =?utf-8?B?ZHVrbnZ4Zkdzb3UxcWRnSnhSaEZVUDVzbEx2dkNvd082T05vWVZuSGNlbVFL?=
 =?utf-8?B?dmcvbGlBUHhoREZ5TnFzSllDSmVzdHcxL0gzYnpLTklKa2tHamh3NytmSGpN?=
 =?utf-8?B?RGthT1QzaEpFdWcvRFp3aU83aHRPbXZWb012UDc1MkV5RWJYMmg1Tm5QRkRu?=
 =?utf-8?B?a0NQYndlZUVqMGhpY0VEZ2hZZlNDSmlpVlVpYnl2a2ZRZDdPcG5Ib3QrOXJ1?=
 =?utf-8?B?ckVjdEtpK3pNS0pCS1VYL1pna3A0cFZ4YUNzTHBBY2VWSjYwT0FmajZ3YnFP?=
 =?utf-8?B?RXBoTjhpd0xaZjY3ditqTUMweUhGWWM3eUlvWU1NK0FZYy9lOFBBa0RkOUFG?=
 =?utf-8?B?VGZEZ211b1FSWnluRFlxY0xKWXdwSU9RYjZIaFYxYXBGZThTSXVaSW51d0o5?=
 =?utf-8?B?c0M3ZlBWL2orT3lscEwvUVgxVThKdFZFSEpMTDdjdTdENnVMdS8rNFVsWUow?=
 =?utf-8?B?eE8wS2ZaenpSSmE4eE92c1psMmorQkl1czlKcEpwMCtzWEVkMzN5djFWUXkz?=
 =?utf-8?B?OHgxREpqcVNHcGdHTlBWa2pzTGprdm91VmhMRW5Ya2ZKRUFhQ3lSMy9ibWhv?=
 =?utf-8?B?dU50b0lnQ1BOL0NDd0l5YkNybngwSXVRaDBlWmhPRGlIZEVsWVZUSVdrNXQ5?=
 =?utf-8?B?Q0xmOUxGS3FQK0VSU2NwZWg2RG1FSXh0M0JuMWxhZTBSTC9OZCtPZ2ZJajdt?=
 =?utf-8?B?RGdtTXo0YWZFK2toL2FUWEtBb2xETFlIQlNkUnNYUjVLbFBwekZlbUxmbmNX?=
 =?utf-8?B?S1Q0MHZnQzBKU204cENZUEt5Uk00Tk9Id1B2UDFiOWJ5MlJiTHJFM2FWMkx5?=
 =?utf-8?B?T2ZmMXA3dWR4Rmx2QTZLQXljNlZqTkhMZ3JyWnBRVjNRbzdwbUdySEx1eC9C?=
 =?utf-8?B?TlpLcU1acDhiU2hWSVYrZFFkNGFORHBOQS9DMjBzbFFuQnducmF5czlST3B2?=
 =?utf-8?B?WDJpMVk4V0FkNFJUVFdDZHJKY1FTVXVKQjB5aXVEdUgvemNPTnN5OVhSREVZ?=
 =?utf-8?B?RUl0ZVdkZjdZU0V0SSs2Rm8ycXE0cFpzQXVNMldBRHJuOEEzRE04dGV5RlBy?=
 =?utf-8?B?eHBiRE9OZFg4V3pva0laUHRqdGdDS1BiTEhORVBqQURrNnhUKzBmUEx1amZn?=
 =?utf-8?B?R3hxT25Nc1p0WjZCOFpabnIrZDBIaDR1RS91MWlBcFFpVEZGZ0FvWlN6TUdD?=
 =?utf-8?B?YnBkOE02UEw0UU5zYWJuNlBTVWNqL29zcExZRkJBYnBaOUcyb0QzaG53cUZ1?=
 =?utf-8?B?OVdyaThYc2VUVG5ocWtQMkgzQ0p0YTNPbml2Q09uUU0vQ2lNU0lSSUlvYnll?=
 =?utf-8?B?aWh6NlFzazFGWkpQeG5UMVo2K21KV0VwanQyT0hpRVJKVThqQUszVHg4d3lR?=
 =?utf-8?B?ZHRpTXhQNUhIUGs0ZEtrbHNIRVBwYUF4TDRyTW4xSHJkSUg0S2tGS244OFI2?=
 =?utf-8?Q?8pEMd79LK7zGIx5ZD15TCWPrQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e84227-1c1b-4aea-a10b-08dc21c7152d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:10:11.8925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xohErMHQbTN284rUqFpD7GUWuOZdNjFwEXhcylpjfIMg76Dp9n/UUAONFSoJvu6fezsapjHIciB/pUYbht8Khw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883

On 1/30/2024 13:00, Daniel Drake wrote:
> On Tue, Jan 30, 2024 at 2:47 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> Has there already been a check done whether any newer firmware is
>> available from ASUS that doesn't suffer the deficiency described below?
> 
> The latest firmware does flip StorageD3Enable to 0, which has the side
> effect of never putting the NVMe device or the parent bridge into
> D3cold.
> However, we have shipped hundreds of these devices with the original
> production BIOS version to first time computer users, so it is not
> feasible to ask the end user to upgrade. And there is no
> Linux-compatible online firmware update for this product range. Hence
> a Linux-level workaround for this issue would be highly valuable.

Sure; it makes sense to me why to put a workaround in Linux with your 
above explanation.

Perhaps it make sense to limit the quirk to only the DMI version strings 
of the initial production firmware?

> 
>> Is this the only problem blocking s2idle from working effectively on
>> this platform?  If so, I would think you want to just do the revert in
>> the same series if it's decided this patch needs to spin again for any
>> reason.
> 
> Yes these could be combined into the same series, with agreement from
> the drivers/acpi/ maintainers for the S3 revert.
> 
> Thanks
> Daniel


