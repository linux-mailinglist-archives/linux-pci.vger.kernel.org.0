Return-Path: <linux-pci+bounces-3556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B289C85707A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 23:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D394C1C21659
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 22:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145A513B284;
	Thu, 15 Feb 2024 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JPQdqeaZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFAE13AA23;
	Thu, 15 Feb 2024 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035713; cv=fail; b=VUORXslKanQ4TrqxLiWbyH3KzVCCpWw2pFI66sU83RcZ+mBq2jYtW5TDsuy/WqbGZB7S0vDbsfL2aWfH9S1Kk66hRa2R3XlSReL6NFEMgSztS2Y+HCo8nLc4lBBeT3o5OTmv15PUCHtxQX/WqR2qA53nQB136a0PWhXHvqLZT90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035713; c=relaxed/simple;
	bh=lrLFLH8xMMiRQyElQk6bRbpxdrMJwKSxtBaHVZt6wxc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jwjomqT7CyGmBzp5AgpjYDbDHM78W0kO/uJNSZpWcO5XtPTAmapRY63A45fWMg2Iat/BS4DkmoBZHRT1cCYnQeuR/oviDHwznxmB7wITnn7+q4kTm5J7oG5/q6wJN+XuXu6Cct5SBuHkRaGxcwMtsOCNijov9XRqJJ3u5CmUN4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JPQdqeaZ; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuOI3nNSsn8ZIkHD/kSjHf5+rax2NOm3H/vlOOhuRs6GGyVK3T5/D4scbZJYTJUECMfsv8R1igHUpJ/HSSNwafz37fg0vtdDwoBfy/mP8N5QuEXZrMzmrhG0k/evo9iGJupf3TlhQTNPt7gfJMq6yJf/HHC2Lz0VKx+3add/ulP7VRfXO/nKHqBBZTygV18kU74CctnPerUrVFoS5cn8w/uWR8oSBkGV7uJiVS20BH2DpwmRAKP7n+ePVI+zPuupBhgECFA3NSbsoH+iCOTYxfn5IepkuhnlM8sx46clNQL5T0LKA3DwFcrJ+MXz/rnP37rAN/OsNZ8QfdPRm9YV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Dl6Zqi5qKiuk188m6mlkdP7qhXqWmBP9NoFpJ2iwYg=;
 b=eUvYYs04Ygx/8Pnq1HxZ8YQAI9e9s9XdJAePONic/esyImzKWA1+JA25V6xODmB/vp4iwbXpvsrSbXBqwfWQq3elvnjlQaK/66+sTBPB/H4sjNUwTtSWwAGbI336uqKTUIv2Fv1e7WPoU0CQpglwa1d9a6daf/A75oToaozyv8xnvWL/7Uln1dnOYNzlYLAFNN1Ya5T0vvrOc6FDnQJGJHQ04OBeGXA6kx2r3IIurnBHLUePLuhRgg1Ev+esCDa027H0PUCGt11wkVRHo+nuzA0KmlqpIXppDCYaXzvUGXvEPtVvH0yD5eSPvoA9QcAIoVeeZdFnoFGIwUKSWyq+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Dl6Zqi5qKiuk188m6mlkdP7qhXqWmBP9NoFpJ2iwYg=;
 b=JPQdqeaZ1iLTZOdYlPBnGAj3BzY8NppdusRYl5ea1qDvmEODZ4VRFA0fwmXTiTzKgCn7fXoHI23FKSkQl/5To1nV+sOZEDwZ3QjrGnxZ8k6et8N2J8bSfqjTaQSx8NP+beNr43nbPFJjzsICvhCFIYCAmdqrdoACGDKw51YoGqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Thu, 15 Feb
 2024 22:21:48 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458%7]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 22:21:48 +0000
Message-ID: <ca61e1cc-5c72-4c56-b5d4-7442f25119a2@amd.com>
Date: Thu, 15 Feb 2024 16:21:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] pcie/cxl_timeout: Add CXL.mem timeout range
 programming
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com
References: <20240215213519.GA1309984@bhelgaas>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240215213519.GA1309984@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:5:74::43) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: d93e2032-951b-4e7a-944a-08dc2e748085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yBSVTMSKklKrhTts1G0mzD6+l6uOJZePsNegnCsayxckY/RE0jHbsgosrIVc1jMrj8KptTpUjb/C/WD2jraynFZ7frlXgeMp8OqyvtVAEcJFyCFdmjw24ViOnTvUBHq+McAi7jLJI7WGBvASfENcXw7GCDFCqL6EbC+LkaHGWT2ugPAytLZ3kSGyjYIO/H2A1MzOOPAiqSWYalMKyORSeYc02tvNs8nCbly8Ai9JEPdssY7UhcQvYdQNNrikeCGezubFQKwTE42q+e/xWim6y5XsNKAbqSwLPs9TEqUypPSn+z1iHsQeU0tZp5TJmX4WodRtrUunao0tnm9US/JieDBAbkhPxto0w95BtVpf1pL5H9JC3iJRmAWGGeq0+eB4aJiN791sRlRJjxNcxtyioHyILhm49Ff3P3iYr7E6MEBV15Y6p2y1QA/+xzncHFPyAfk7NznpiNSJWpM7IH2nlTeTwPioXkQ58gcIcVJ7eQ31OMnyyFIMKB4a1FbxQyiYW6/tv+Vpf2rk/z/BGygG2k+6dbwA5GK0XRek3lVTlwSN0PG++fA+1G2Isu1m4XDJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6512007)(478600001)(2616005)(41300700001)(53546011)(31686004)(2906002)(66476007)(8936002)(4326008)(8676002)(7416002)(5660300002)(6916009)(66556008)(66946007)(6486002)(6506007)(316002)(83380400001)(36756003)(26005)(38100700002)(31696002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnZBUXArT2xaV2cvNWM3OTYrUlBWVC9ySlBBTUpjckMvV1lELzJEMWs0NmZR?=
 =?utf-8?B?UzFTc0JhQm1wZ2JxV0RWWDcxVVR2anZia2VMZk50ZnFHTGtPdFI4VmlnUnVq?=
 =?utf-8?B?K1hHRW1qc3Vja2VMdGM4MjZDWTJmSThtS0NQUjlDWVJNSnZNZDBQaWFyZ0pp?=
 =?utf-8?B?RGpwdEdPTGxIdndYNGsvZVpXNGg5VU56emZ5a0ViajBvWHlJcWsyOHJjWWsv?=
 =?utf-8?B?MmlSVUhaYjBXZHl5RS96QmRuUCtEbXhScU5DR0c2ZkRmR1Q3UWg5bWhrVHdI?=
 =?utf-8?B?aFc2SVNmc0h6U1FnaGp3UmFSeXBKZjEwaE1DSjYzWlVscXowdWY2UlA2b2Ny?=
 =?utf-8?B?bDBEMW1udWpwYWhxVy9nUFVieEM4eHhXb3ZzcDU1S0NqbWd1WFJEYmltTG5S?=
 =?utf-8?B?bzQxdHVoUnhENGRWcyticGV2Vzc2YmlvRk93dUFNcTFzUmx4Skdod214SVNj?=
 =?utf-8?B?VjJpcC8vY2h1Rk5kUVZ4REJXK3BwWUZuVDhXY0MyUy9WZ05oWmdvMGJSTWtt?=
 =?utf-8?B?VTB1NTA2Rm5OOVJTTjNKT3Q5K2tycnZTaC9KTDFmaTN6VVhVV3hxOGJnNVpw?=
 =?utf-8?B?ZTVsWHpjUXc3UzlYNlRVMUEraitnNUhJcUhSbG5PcnZFeDQ3WG9rRWFNcEI1?=
 =?utf-8?B?a0xJSmM0NFlIdUl0N3RMbngwbkNRNFg2Wld6KzR6QkJzY3RldmxTazFrTWhh?=
 =?utf-8?B?d28vNElmSnNUNlpndEVqdFlzMmsvUER6K3I2czIxMUMyQTlCTVEyV2l5ZUhz?=
 =?utf-8?B?dVJRODFZT2I3RjJhMHd1ZFVwNCtKamNKbjEwb2N3ei9rRUs3cVAzM0l1Rjcv?=
 =?utf-8?B?KzhWU09NQm1IVW85S0ZCTVh1OG9pYXY5R3dIeFduV1Mra01Yb3MxQ3RkUUsy?=
 =?utf-8?B?WjRlalZ3SW5MSmRyWXl5ZGpaYnZBYW5HU01VMGdDb1NvWnVlVHNWbGdsME5J?=
 =?utf-8?B?OGpEbUpFc0ZicFg0aXlJd3RNK2pacVBzK0pXMzZCRlVtSlhKd1NNQ1Nyc1Qv?=
 =?utf-8?B?akpVQUpyMkcwV3dxeUI3ZnlMcXE4KzRnZUZvTTVnaXZqMUkveU41cEZUSVNC?=
 =?utf-8?B?NGRlQnJ1T2VBWmJhU1NyYU5VQ1NjV2J2eXlaYm42d2ZlSGdYakI2SUwxcnla?=
 =?utf-8?B?ZzZweS82eVcvdGpGeUxQbjhFelp6RVptL1E0YUt5bktTdU1xOU9VUUVXMU1Q?=
 =?utf-8?B?cmxiMmRDbEx5R3ArekUwRTZQSTlvZ1ZSL0xQT3hQVHliWUpIUktpU3Z1ZUoz?=
 =?utf-8?B?bzhjYVZTTzU5dFM1RWpKeEk0Z1NKREZUNXphc2QzcE9EMGs2ZllPQnlMQmx5?=
 =?utf-8?B?K1JlSU5EQlVNTjhzOGN1aWVRRlZYYnlZd0ZuaFVtN2lkcW5qanQ5UnpLK0c2?=
 =?utf-8?B?MzNIcktQdUtvYkZaejFLeHVFYUZ1VlI2aWhnd2lUZmQzOG5QYVNwajI4RWpH?=
 =?utf-8?B?a2pIUERIM0ZQWWY3R0VyTm9OM3RzZHFibW1vbGxCM21YWUw1UTE2dVVjbCtC?=
 =?utf-8?B?MlFyTFAwdWpZWUk2M282Rm1vK1RqQTZNTStTWG1ET2VEZVlFOGxFQ0d3Mzcv?=
 =?utf-8?B?eEVTUkcxL0x0dVl0eFcxODliMk1DZGlUazNObVJLcW1ZT2lGZG9XS2x2Nm4y?=
 =?utf-8?B?Zjlab3QzTFgxU1pYTHZrLy9IajQ1Szk5UUN2Z091RzhrMzNYWHJ3NkFhNWNN?=
 =?utf-8?B?TXkzdHl0TUI0L0ZnNkducDVCRUZocXdWUnp6N3RJbU5taVNqM3M4MHdHVGJW?=
 =?utf-8?B?NGZpdUx4Z21tdHNLT1FBT2pCV0NzNWM0bzBhTXZZL2JxK1UwbC95N3B3aVRN?=
 =?utf-8?B?czByT05mNmNYUWhKNTJBaU0veTVpYi83Y0JjeDV0RzllaW9ldFNycU9JOVRm?=
 =?utf-8?B?bERicWZNVDNKamU5YVJiNWpxV3grbnJpQU5Pdk05K3dJOSs4RWg1aEcwUnRx?=
 =?utf-8?B?eW1OcWk1aGVBb2tsNG84ZjJVZGIveU1GVFJ6Yndmd3E5Z0pHK05tbURnVXBh?=
 =?utf-8?B?bjcwbjJKU0d5UzVWemMyREZVb3NOMFllM0M5Tjd1WUY4TGhOckpyRGZVZldD?=
 =?utf-8?B?YXphb1F1VmdGOSszbGJSTnVNcWZYOHdUQXhJWmNuWmcrcVVFeENmcHRNaHlO?=
 =?utf-8?Q?YseWJgL1En22V2iclglXu5b6u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93e2032-951b-4e7a-944a-08dc2e748085
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 22:21:48.8305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKOBzL09+wAMk3KVsKQlsp+Rps59P/L44YtP+aXITMPlHjPO2UCMI/Z1hjhP52gBkykMzUv7+DbJoGmZKhlSjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916



On 2/15/24 3:35 PM, Bjorn Helgaas wrote:
> On Thu, Feb 15, 2024 at 01:40:45PM -0600, Ben Cheatham wrote:
>> Add programming of CXL.mem transaction timeout range (CXL 3.0 8.2.4.23.1
>> bits 4 & 11:8) through sysfs. To program the device, read the ranges
>> supported from "available_timeout_ranges" in the PCIe service device
>> directory, then write the desired value to "timeout_range". The current
>> value can be found by reading from "timeout_range".
>>
>> Example for CXL-enabled PCIe port 0000:0c:00.0, with CXL timeout
>> service as 020:
>>  # cd /sys/bus/pci_express/devices/0000:0c:00.0:pcie020
> 
> I would really, really like to avoid adding sysfs dependences on
> portdrv.  Is there any chance these files could go in the normal
> /sys/bus/pci/devices/ hierarchy instead?
> 

This was just the first place I tried putting it that seemed ok. I'll take a look
at moving them over to pci/devices instead.

>> +/* CXL 3.0 8.2.4.23.2 CXL Timeout and Isolation Control Register, bits 3:0 */
>> +#define CXL_TIMEOUT_TIMEOUT_RANGE_DEFAULT 0x0
> 
>> +#define CXL_TIMEOUT_TIMEOUT_RANGE_D2 0xE
> 
> Looks like the single other example in this file of hex constants
> using A-F uses lower-case.
> 
> Does "TIMEOUT_TIMEOUT" add information over just "TIMEOUT"?
> 

TIMEOUT_TIMEOUT is supposed to specify transaction timeout, but I'll agree it is
confusing. I could try changing to CXL_TRANSACTION_TIMEOUT_RANGE_* instead, but
it would break the convention of CXL timeout & isolation defines starting with
CXL_TIMEOUT.

>> +#define NUM_CXL_TIMEOUT_RANGES 9
> 
> I don't think we actually need this constant, do we?
> 

Not really, just gets rid of a magic number (as well as makes sure anyone who
changes that array remembers to update the array size).

>> +static bool cxl_validate_timeout_range(struct cxl_timeout *cxlt, u8 range)
> 
> "validate" is not a very name for a function returning "bool" because
> you can't tell what true/false means from the name.  "valid" would be
> fine.
> 

Will change.

>> +	pci_dbg(cxlt->dev->port,
>> +		 "Timeout & isolation timeout set to range 0x%x\n", range);
> 
> I don't know CXL, but "timeout ... timeout" reads sort of strange.  Is
> it actually a timeout for a timeout?  Maybe it was supposed to be
> "transaction timeout"?
> 

Yeah it's the same as above. I'll change it to "Timeout & isolation transaction timeout ..." instead.

>> +const struct cxl_timeout_range {
>> +	const char *str;
>> +	u8 range_val;
>> +} cxl_timeout_ranges[NUM_CXL_TIMEOUT_RANGES] = {
> 
> Static?
> 

Yep, I'll change it.

> Bjorn
> 

