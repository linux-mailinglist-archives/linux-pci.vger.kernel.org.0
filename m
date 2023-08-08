Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5814774CDD
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 23:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbjHHVUJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 17:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbjHHVT4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 17:19:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5810C88B2A;
        Tue,  8 Aug 2023 12:38:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJV4jjf2ayUdLIin7goW+Za5sLkZb/jAwJditr60aVz3mtFv5P7ILVv0d5ux2y4Ya5XLP7GkonWWirP6ZAXu4q2c3/KWQfV0l99WOzG3rDdnwQqFV+Fm5+SAsWQJlmiYV5utX4UqGj3xfJH+nayuDK8sKeTSBmIDoQXzeasi24T2r+BXUEbD4W3E9puonzdQ81q67q2mdJ3TYUDxcjuzfuMRoVNVRYeH34Oek37mNzcUpJ08RjkYvlJnLfqw7jEWukELe5ztC8UCY8lrsl+10KMTJHPNq2eu7nHgqqNexzpORiSQWXiw6Scmxe0u7K7Jjk5dG/7kq5KjHj+Z0MKm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/PV5TPtDwG3HAGozQw1YzsmPpnv0YXhKsG0+VmUbZI=;
 b=HXMZniMuzOborOEbWZJrnxUKYqplyP/MdZMfsGICHDKRiKdGZG/dF9z9sTlputWlxy/MFWTsx3e/D6WHHXPVXCi6t1nggamG86yXAFDQTaeaKjNQAosEeDUGXypR1SBeNI6+NpS/rKuNmS9Gh9Y8e48h1ZS2pf7w9ld0VnIyKELA+cJtCNdAeamibeegDEqM0H2lLLbn5U2xC9VcnEkMTsWTllNFNJF4WJ54Q6F3/CYExqqpAfabydMp+kmysVrrMMGrmXhF0TM518AUMsKNJRDsp2xw3uMHH/n0LiYC0OXn8iLvrVS+B3KdTVkxnAhaxt6+g0rjuWwiyOtHmFC1uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/PV5TPtDwG3HAGozQw1YzsmPpnv0YXhKsG0+VmUbZI=;
 b=AE9t6VNFBk0u3KrMCfivtPUvdYFgb5Js3wzjVq8SYSCIa/hYCNY/47b+JLS2/YMzBqSxvWNB1k538L/VukxkP9n2Mum4Gkm2DfUfktlUfsAz93cv5VLBfi1YTc1wtVoBjXfGlf7N8k/VVOnLRP0ltdsY0MXWJXVeJrN252VwYCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Tue, 8 Aug
 2023 19:38:01 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::6d09:667e:d48d:dc1a]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::6d09:667e:d48d:dc1a%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 19:38:01 +0000
Message-ID: <f044379c-f363-0c94-cde3-8b062f1628ee@amd.com>
Date:   Tue, 8 Aug 2023 12:37:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] cxl/pci: Fix appropriate checking for _OSC while
 handling CXL RAS registers
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
References: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230721214740.256602-2-Smita.KoralahalliChannabasappa@amd.com>
 <64d1b3e78629f_5ea6e2944@dwillia2-xfh.jf.intel.com.notmuch>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <64d1b3e78629f_5ea6e2944@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::30) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc1b9bd-a746-49c6-cfa0-08db9846f9cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6nFJbYohz/5qMo0mfGlMEEe5q+Fp5mWNGk+4syUq/a587KY1/tRLdeK73Z++iw7ZD8wY95d6vOBPwZF4wSozR6BRfLxv41Kve4nvKgHamjqOMyGlI8X8AmH8tMYaZyxMBdN5LeoD3aYhDzKDK9OEfC/ZmiQE3LIQgXJACblkrRHxy4sBqRQ41YD6q9yptJDwwivAJi6EcdqZkjIOt9qG3XaS2mwxGUO5/QtiZGioSowbBRgSR82dTM5a2xvY7xnYoZA/O9X9lYLMYGtgWu5MkAHnNlwk0OAqOfG3jjvGiXXYSKrT/whXyIPambOXYdlQOKiZy9pNURw2pH9DlBMUKk43aEuOolxqyUczR9A5V65VTQiF47DFt6S4GTNkIXjGIHaGCpEZewDMrBx+4fHuH3gXDyh86rM9JeCoiK8tO1GMwTqXYj6UrKVWTJjw9nZx8CkpFjYWLRzjTAMhA3svzuihfO5gSjuqHPsE8Pux9+ywCcbwEUoKON+ZjOCTmy6uYsszrRZ/B8tN9oTSVQeaQLrbpsTEu1RkK8ytJWijqb7M9aBqm6Esx9nQcx0nt5IukzXqm3Cr7BFv2z/yaHzJeUNOEGCJ5nKtw1QG6q/LNTAvu7LzlOVfrLIfkbRCoU1Po1SLvPLRYwVubV5VItb8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199021)(1800799003)(186006)(66899021)(2616005)(86362001)(6486002)(6666004)(966005)(31696002)(6512007)(478600001)(26005)(6506007)(36756003)(53546011)(54906003)(41300700001)(7416002)(316002)(5660300002)(4326008)(2906002)(8676002)(38100700002)(66556008)(66476007)(66946007)(8936002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2d6NExRdEpSamVVcjJoYUlBdkdUOVJaWmtVcFNsVTRmemdCZUI2ZWpaam1n?=
 =?utf-8?B?T0lDQi8xOEZPWmdWNkcyaVVoY0RnVHl3UnZKejB4aTllZ2xzSk9HYzIwdEVM?=
 =?utf-8?B?WFJaWXFYZE5IMXJTR09DeUg5RmNiMWVMTzJWeXVBTDVzKzJueDVnVEo3d1da?=
 =?utf-8?B?NE9qaFdWU1J4TzdhOUxYaU10c2lvUUhjWU5CNktJaWF6bXZrSk4xcWw3ajJB?=
 =?utf-8?B?cmtKOS9aWjRVbXJsMmw2OFJpTFVHUnpyT0lEQkxuTkpUZjBoTlRTMjVZemFs?=
 =?utf-8?B?NUc3empkTklSM1FaZ2lTbUxHZkl1bnJHR1A5eFNPcCtISDZLUTVUQ1hYcU45?=
 =?utf-8?B?YzUyMVhXVXloRXRyYkFDSlVkNDlpSDQ1Y3QxeVlERVo3MEZYOFhQT2MxZDgz?=
 =?utf-8?B?R2xJVHVsZ2k0QjlnRjI5RUpWK3U4aXhycytlYU9tejJDbXR6ckF0M3Z2U3No?=
 =?utf-8?B?NENialN5NlYxa0taT3VWR2t1U09EWWoxb0ZOSUpCTUw3YTRlTGxRZVhNeGgw?=
 =?utf-8?B?WHNxU2hhbzJaMTFIRzgvNURuVnNCK1RGakJ0RWNwMTBNM2pyOUM5dVE4QW1o?=
 =?utf-8?B?d0FMeTAvUmh0QllKSEhBT1RSaUNjc0l5b0tOcEd6OFJRb0VsbVRZeXJUYk13?=
 =?utf-8?B?Z2ZROXlrS3FuSTd1a2drYTFERm9tTWI2aHJjalhyemo0YnR2ZmhNYnU3ODU0?=
 =?utf-8?B?R1hKT3BDUjcwSG8zdGVCTzZFb2I3ZEJoQVpCYnJicXNPUldMVWRkVTlmc2FC?=
 =?utf-8?B?SktnZEhuK3pxc3ppRFdIQkNWcVJON1N5bm83a0RmTUs0dDNjQnlueVlxUmdK?=
 =?utf-8?B?b1MwTzN6aFNFZHhaSVNlMGlGOFJhdGxFaWtWQndneml3bG11MHpaaGhITWZX?=
 =?utf-8?B?d0VCMUhtN0VOaFlQOVF2MTA4aUREOGJBTWNaTjVTUGNLSXNVSEJ4aElvOVZ4?=
 =?utf-8?B?MlE5QjBIQkUyUExPVjVvYTR5L0ErMnY1YUlpS0lKZ25vUW1oVVpWWFlqSGhn?=
 =?utf-8?B?UFg1RVpJc0k3ckVkdHFJWFRnb0ZUVUsxbzRwL01kZWVtVC85NkZvQ1J3bWlE?=
 =?utf-8?B?Ly9xdUsveTFmdE5TUE5uUTlmbUxJUUhTSGNqZlNqS1Z4b1RlYlNwZDJMMTdS?=
 =?utf-8?B?WEJVczlEeG5kRytsRFd0ZkpDc25hbWdOYUV4MHZtMElTem9BcGpqeW1RNHEw?=
 =?utf-8?B?amN0MGhlVTVGaThkSUUwdWVKOGJUWWNnREN3djEycVZHb2wyZFk0c2JKWDZr?=
 =?utf-8?B?Sll0SnViSVcxTDMrdTNTZEJ6UndCa2dBVGJjWmxqdmFZYzkvbGltSFZWNXVk?=
 =?utf-8?B?ZFFkTEZTcXhxZnU2Vi84TWdBVmY3NVRnTU9RN2IxSERORm1BbDhvZHluQWtH?=
 =?utf-8?B?OUVYZjRldWdoNVNZNStEeXF5WDVkMTJpYmtYRWhaU05xdENZQlI0Y1ppd0I4?=
 =?utf-8?B?MFlLV0dOblM3QTRMczBENkRtYVEzeUFuVW9MUkM1VmhlVDIvUTdXVWtrbjl6?=
 =?utf-8?B?bmk4bHhGdlNpUzdINnJybjhWd0lpaXhxdTBZOEF6M0NoOW10QzNVb3hiR1BO?=
 =?utf-8?B?bThGTjdMVktDaUxPT09UaGRUVWpwc0dBck5ITFRwd1BqTUxOOW0xQUEreWww?=
 =?utf-8?B?RUFLL2grci9RblYxR1h6c2NkMG5La2N3MUI2eHFPNXRLZ0tiZXdhRzQ0Wk9Y?=
 =?utf-8?B?Tk11dWdWNEt1Z21jc2tkUExyVDhSQU9ScXRQOWhkbXgwYmtmOTlnRmZ1K3NG?=
 =?utf-8?B?NVhZTWY0UGFRMy9ER3Y4WjNGd2xncXJwQWRLb1dmMGgvZ0xGSWg3VEpJRnE0?=
 =?utf-8?B?Zk5TMkUyYUtOSzFQM1hEZEpMZE1lQ2k2RXhHVWFaanlzR2ROejdZMDNTWEpw?=
 =?utf-8?B?cGl4NHFieUhNNmlCVDE5UnJEczhvakV5U2U2UmF3eEtRcHQ4OVY4Q2Z3OFNG?=
 =?utf-8?B?NFBXWXhNRG9RMnpQalNVQWEvT1pkb3l4b05peHgxWU1NeDVJQ0pDSzQ1NUla?=
 =?utf-8?B?Ykw3cmk5TEM2anZjSXM2WlUwTDNuRW9KTi9HbXJ5Uko1cTd2eEVRbzZrNEFT?=
 =?utf-8?B?Y1c5SG9yZ00rTUVPVlAvRHRBODZoVGVOYWVjaWJpenJwaDF1c2MwWGhvQjFj?=
 =?utf-8?Q?//vgrcdb4VZhNUUfOLqxa7NVs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc1b9bd-a746-49c6-cfa0-08db9846f9cf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 19:38:01.1480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWKwyjQk8RCOXeG+y5pobstPjuY+zJqwIZMEHYJUzw1UsMYcspo0Xhzho2kWDGymHyXh1hZGRGZ7h3u0ZoZQrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/7/2023 8:17 PM, Dan Williams wrote:
> Smita Koralahalli wrote:
>> According to Section 9.17.2, Table 9-26 of CXL Specification [1], owner
>> of AER should also own CXL Protocol Error Management as there is no
>> explicit control of CXL Protocol error. And the CXL RAS Cap registers
>> reported on Protocol errors should check for AER _OSC rather than CXL
>> Memory Error Reporting Control _OSC.
>>
>> The CXL Memory Error Reporting Control _OSC specifically highlights
>> handling Memory Error Logging and Signaling Enhancements. These kinds of
>> errors are reported through a device's mailbox and can be managed
>> independently from CXL Protocol Errors.
>>
>> This change fixes handling and reporting CXL Protocol Errors and RAS
>> registers natively with native AER and FW-First CXL Memory Error Reporting
>> Control.
> 
> I feel like this could be said more succinctly and with an indication of
> what the end user should expect to see. Something like:
> 
> "cxl_pci fails to unmask CXL protocol errors when CXL memory error
> reporting is not granted native control. Given that CXL memory error
> reporting uses the event interface and protocol errors use AER, unmask
> protocol errors based only on the native AER setting. Without this
> change end user deployments will fail to report protocol errors in the
> case where native memory error handling is not granted to Linux."

Sure, will make the change for a more clearer description. Thanks!
> 
>>
>> [1] Compute Express Link (CXL) Specification, Revision 3.1, Aug 1 2022.
>>
>> Fixes: 248529edc86f ("cxl: add RAS status unmasking for CXL")
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>> v2:
>> 	Added fixes tag.
>> 	Included what the patch fixes in commit message.
>> ---
>>   drivers/cxl/pci.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 1cb1494c28fe..2323169b6e5f 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -541,9 +541,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>   		return 0;
>>   	}
>>   
>> -	/* BIOS has CXL error control */
>> -	if (!host_bridge->native_cxl_error)
>> -		return -ENXIO;
>> +	/* BIOS has PCIe AER error control */
>> +	if (!host_bridge->native_aer)
>> +		return 0;
> 
> The error code does not matter here and changing it makes the patch that
> bit much more noisier than it needs to be. So just leave it as:

Doing this will return an error from cxl_pci probe thereby failing the 
device node creation in FW-First AER/DPC. I cannot think of other places 
where we reference the device node in FW-First mode but I have a place 
where this could potentially be a roadblock.

I'm trying to add trace events support for FW-First Protocol Errors. 
https://lore.kernel.org/linux-cxl/D9381C12-A585-4089-873B-3707C17823D3@fb.com/T/#mcaf8a78c1295372ab811be7e1ccb6a8a4d99f3e9

And we already have an existing trace_cxl_aer_correctable_error() and 
similarly for uncorrectable error for native protocol error reporting. I 
was trying to reuse the same function for fw-first as well. This 
function references cxl memory device node which will be NULL in 
FW-First if this returns an error.

I don't mind having a separate trace event function for FW-First mode as 
it would simplify things especially when dealing with RCH DP.. But there 
may be other potential places where we might reference this device node 
in FW-First. Please advice.

Thanks,
Smita

> 
> 	return -ENXIO;
> 
>>   
>>   	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
>>   	if (rc)
>> -- 
>> 2.17.1
>>
> 
> 
> 

