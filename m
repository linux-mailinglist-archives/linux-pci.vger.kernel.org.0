Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697247804BC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 05:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357687AbjHRDdn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 23:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357793AbjHRDdJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 23:33:09 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F833A95;
        Thu, 17 Aug 2023 20:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nqi3w4vJQcNp+ZZK3FLH1230a9o0Cb+N8NVFv9pibvaRoRc0jHPcZ5Rsle7FcT/0Y5SoXXp+AyYTOGfvqm9U/mRL1yNvxLKMcabY4g0sTn+XkeSPiCUxcxU8odXTqySMu0tG864d+ZxFeuQWyX8Mw0DRaBVFgvbioS9x6ADbG2HetIJaXtArWFZtjHu6F087loSXsSZlxENmGpFCXT2Tbxr4SvPo2+2OJI4OjbZ3eEo0BN3Vs+HwXnunf38bYtfc19/3XYZrH+40fxZLCVkgyDmCkFxhfo/BO88fmlrH8QhohJdSBDUsji1mOMscdfKeDcoYHYU1cUX/hyKB0qxLSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a683Xk3OuK2flx+oavRh0wRK4GbvEUgvUROgPI4ZCRY=;
 b=EGcSqSpPBlBtO0E8XDLMw7Le2IlxI1KPmqjZSp1L5JVeDO8/ypJ+mYxjJSfj/yGQqLEm83D+zPgwkx5tIqWSeLFNVnWLlMFhttTLzFmuZ635+mOY/47lV+HHfWjNVWmRKv/TfG6UD+/GhHYh4QCBpM8ypnHuH8Yzu0ekJND7GyUdAau31i31iT9BNOTBdpuRaoGmyS6gZ9YnO5WgYAZ7SscsrzssHduIiuK8ujQDKJZTSfF4lnA2rnzJoNocLAZhIr78s/ErnzIcW4kCF+BrzLCqRN1OtfXUG0ggnaBfkH9HH+7bdlq4XjBFHc+uthLVlT14Daw0HnFhiwid/pKBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a683Xk3OuK2flx+oavRh0wRK4GbvEUgvUROgPI4ZCRY=;
 b=5m0iWDiHq1JQPZqvPHGXJEivsfCTGEUTNjL97ckgYB+tmt1+JLqxmme2y4M/77t7gU+CP6gn7I7QL2rByGx9yUmt65bRfBKZNpuzhKTwJFj6Z5aQfrNV1zPQ427cCaBWhZAXlyuhtATOAcQ/U/N4Bde2lSSyPSyw+D5k7+YMxIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 03:32:02 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::f26a:5d9c:cace:19aa]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::f26a:5d9c:cace:19aa%7]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 03:32:02 +0000
Message-ID: <0aa6cb16-27af-345d-7e6c-cf985290d1b4@amd.com>
Date:   Fri, 18 Aug 2023 09:01:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] PCI: Allocate maximum available buses to help extending
 the daisy chain
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        Sanjay R Mehta <sanju.mehta@amd.com>
References: <20230816051923.2287912-1-Sanath.S@amd.com>
 <ffd5401b-400b-79e2-51f2-e6866251000f@amd.com>
 <20230817102430.GD3465@black.fi.intel.com>
From:   Sanath S <sanaths2@amd.com>
In-Reply-To: <20230817102430.GD3465@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::18) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: fba88045-25d2-4fa7-b0cb-08db9f9bafa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TyQO1YU/ppmDbMv0IfyqC+TSOsXbM8dUGaK9khbzEvM0GfhNg70P46YPms1XUGr5NIs6qooFq9w1jmvO3H42aSqVKKaDYU/RBHT2z2OQsJx5dqP1/HLS4GoPG+VAHHQFncG5ic1DINbPCH0ohqjgE9a0kCQ+0C9WLV52TSMW1YqXoWhyNRfQEWPFGo/SxS6fvZ/1XVpCxoUmPLTpG2F7SPh6imwmbp5v4totUvU3gv9/4Eo6xYDJHr6lgloxXm/p1+iIE+aOE0r0dXuyGtgKSTpPdETH8j9msHbrEm3mDR7mdTrjnogDQ0a1S/e0YHeqNnFsXeqmGVptKEhiNVbIhkZoKeBrBxSjlkSIjtYfUHLMgkmGAlB6CCF1TR5CcOkx7xWJ7oFZNVDR/TTI4e2gtl39yXSVKD4AX9Q//OMvaEoGLouKNEugK9oud0I7E1KFd5AGnQae2VWa2FUXGJzt+aO1PLaHxWpOwP2xo+Q26mUNpQ+PWrQrd3e8BXATJMpDYAQlWId/SN0XySre8tj39sUAw8oRFQDHMFiFVcFbupA6pEA/zqv0+T27Xm7GCXJGCwqkwGwAOsZjFxPSkvw3Ic1rFMqSmLyHl15AfHvHhBLT9Z/09oUisMA9hbdC3NgAIh0146Pz3byWZq8/HqT9MAMfW21vGpz9qPb01bfxR6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199024)(186009)(1800799009)(31686004)(31696002)(36756003)(38100700002)(478600001)(5660300002)(2616005)(6486002)(6506007)(6916009)(66476007)(66556008)(66946007)(966005)(6666004)(26005)(316002)(53546011)(4326008)(6512007)(8676002)(8936002)(41300700001)(2906002)(83380400001)(131093003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDVyeFJDVnRVM3ErbExyZ29aYS8vQks1enhtV3Z0SE53RncxS0dOMmR6ZkZj?=
 =?utf-8?B?c29UMHdONVNCREorSnJ1dzd5c2RKZXZSS3lTMVIydStYOVcvdUI2N3dSZjh3?=
 =?utf-8?B?TkJYb3dWanZUYU5VTjQ5dk8rUGpzT0hwRlRxU3l3UW14UHhWYXV6UDVaRDBX?=
 =?utf-8?B?eWtqNVlUYnNVQmRDZGFvMUFBeU52YXd1eUhFMmIvRkVZSStGNHM5d2xhRFk1?=
 =?utf-8?B?d0x2T2tsVXlJaDBOeW03ckp4SS80V0xHeEgxdGFxdENnMmlXOVY4OGR2SVpZ?=
 =?utf-8?B?eGZjRlMzT2swUnVuTndwSlBZWTlYcGR2cWJyNEh3Zncybkg4eXFqRGh2Nmtj?=
 =?utf-8?B?WTMvdy9CRmZoSkVwNHdTWkxzSnozTzBiSFh3UytrczRrRnVJa1FINnVORUQy?=
 =?utf-8?B?V3NSYUpKd3RZUjYzNUVRTFRoSi9EMWhtZWtOQnFxM0xNRUJTek5iaHdBS1l2?=
 =?utf-8?B?czQrcmw4ejh5VDFRcFpQVmc5YnpHQnlnTVB5cUd5ZnFqNmFvallydE9nUU40?=
 =?utf-8?B?Yi9NL0VFNERkY2RnNTdsNUtoU3ZCT0xGRGlQM1ROT0ZzUnFoN0E4MVlidUE3?=
 =?utf-8?B?MWJhUXJqNWg0Zlp2d2ovTHlYZlFXbmNhNjJhOTFQdFlJc2gyK3UzWEFyMnQx?=
 =?utf-8?B?MDFEVE5hNGN3MHJJcUZHQmQzT1FwbS9hRmsxSXltRURjV3NqT1JVYmhxVjIx?=
 =?utf-8?B?VTEyMnpPU2hOOHpsYnFlYXoyT2JkYVMyUVJZQ3ljRStjS1ZjRjFEOTJBNUlH?=
 =?utf-8?B?bmhFbHlTbDBYRW5EV0YxcjJFcnlqaHBpb29UYm1QZE1jM2QzQTVUa25BZVBN?=
 =?utf-8?B?bHBiU1g2VTEyS2xBZWFycDV3VmloVThNSmRwcS8vbFAram1SdHlLRjlhM3JE?=
 =?utf-8?B?YlB2dGtGN09adU9tYk9aa2VwejQwdzVISE1YaWk4azNSWXBiOE1DeUJRc0h5?=
 =?utf-8?B?dTFnTko5eFpWN05OL0xEQW1WVkxEM1VDKy9nbTFvRmJMU2svMU9TMkJBTWtZ?=
 =?utf-8?B?QkFQdTRrWElFcjI5M1ZhZC9TRXJ1aktpYi9PWWV2aTJxNElPc1FnUHh4cWll?=
 =?utf-8?B?NWo3dmhJVUFnYzRiZUI4V2pEOXBtWUt6SmYrMTFWMEVpdEJ5dTRRTzdsQkdu?=
 =?utf-8?B?K2JOdWZ6c1R1b1hja2JxdmFEVXIxSVJuWVhmR25tMEFXMHlFRm9od1ROdy9u?=
 =?utf-8?B?dFBlNDA0QUlyZGdoZXN4K2pqVHdQM1A0bzN4K2VYWmJvRnp2Tzh3VjRWelNF?=
 =?utf-8?B?M2syc3p1UEJZRjVSeFhNRWYvTWtqVkxtcEt2TkpSUm5ydmIyNVZ4VWJ3NHJj?=
 =?utf-8?B?OWczSGFKRnJjcVk3WlRJNHFXVnEvWmtwNG4wTFY2dkt3eDkxK0tHRmdOUXU5?=
 =?utf-8?B?Y1FUcGR0RUNnNlNvNG5Jbm1HdWVGSUttL3RhRDRmSGFSVnpkc09xL1M2cEQr?=
 =?utf-8?B?R2NCeFdiRnRGL2pjMFBERlZWenRjTjQ5UmpaUmNucXVtNTZNQ3dMUkpvblh0?=
 =?utf-8?B?aEFxOTJUb1VxYWh4NXErNnI3L0REeHZzUDdJRGx0OFFUQ2JMUk0wMXRJMTdE?=
 =?utf-8?B?alNLTHIrTjdzcE1WbHhMcnpVT0N1WXNjODhWUVZCTkdRMEFBemtmclNScXRt?=
 =?utf-8?B?YTRacVY2bGhXTWw2Z2NvSk1VT3NOUEdUaDFtVnFjRGNxUlRIdDRLU3JSUDdR?=
 =?utf-8?B?c2RNcStvdXk3bEVra2lIdWRuVmhIaEsxNFhxS0toeGVDb3A1bm9ZVGZQNVU3?=
 =?utf-8?B?RzBmbDl5czlia2FNRjBpVzBacnVxMVJTdEQxWnA1bElPRGpxeDUrRlRzeVYw?=
 =?utf-8?B?dUlpN2NDZWJDR2hQYU44QU9kUDRzQktuZGVHSlhKd1NKNnowanVDR1RDNVVC?=
 =?utf-8?B?TkZkOUtxMmdaVnFJTWJlK0hUNFNMeFNvRGpsVzJJaVNsT1NoS0IzOWZ2MXFw?=
 =?utf-8?B?Y1BZbG1GMTJQT044Z2swWFRzK1U0cHExd2RZSkdzdTcrVWdPc0cyUGxIdFVL?=
 =?utf-8?B?UjVENHR1Sm1ETXlOTUQyRGgxZUVTbUJMMVZiUXVDM3RQdGkxRnpFZVdtRkRz?=
 =?utf-8?B?c2xJUUl1SDV6NXhwL1ZWOVppUnFzdFJmMytXRnVMTURFVGZoYzBpT2RvR25W?=
 =?utf-8?Q?Rm5qYPU5Vi+IleJsmkF40SAtT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba88045-25d2-4fa7-b0cb-08db9f9bafa3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 03:32:02.1753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/gHtR5whDwAeEOdsrac3VCKTjGO9NZbpogXfpsCyoEppeXwytHMqfjBL9YJppCJ47VwHu4+Mjlq/PIzRd9CeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/17/2023 3:54 PM, Mika Westerberg wrote:
> On Wed, Aug 16, 2023 at 06:48:35PM +0530, Sanath S wrote:
>> Adding Mika.
> Thanks!
>
>> On 8/16/2023 10:49 AM, Sanath S wrote:
>>> In the case of Thunderbolt, it contains a PCIe switch and one or
>>> more hotplug-capable PCIe downstream ports where the daisy chain
>>> can be extended.
>>>
>>> Currently when a Thunderbolt Dock is plugged in during S5/Reboot,
>>> System BIOS allocates a very minimal number of buses for bridges and
>>> hot-plug capable PCIe downstream ports to enumerate the dock during
>>> boot. Because of this, we run out of bus space pretty quickly when
>>> more PCIe devices are attached to hotplug downstream ports in order
>>> to extend the chain.
>>>
>>> Before:
>>>              +-04.0
>>>              +-04.1-[63-c1]----00.0-[64-69]--+-00.0-[65]--
>>>              |                               +-01.0-[66]--
>>>              |                               +-02.0-[67]--
>>>              |                               +-03.0-[68]--
>>>              |                               \-04.0-[69]--
>>>              +-08.0
> This is something the BIOS should be doing but for some reason it is
> not on that particular system.
Yes, BIOS should be doing it. Idea here is if BIOS has not distributed 
it correctly, OS
can reallocate and distribute it correctly.
>>> In case of a thunderbolt capable bridge, reconfigure the buses allocated
> Thunderbolt
Will correct it.
>
>>> by BIOS to the maximum available buses. So that the hot-plug bridges gets
>>> maximum buses and chain can be extended to accommodate more PCIe devices.
>>> This fix is necessary for all the PCIe downstream ports where the daisy
>>> chain can be extended.
> This is necessary only when there is no proper BIOS allocation for the
> resources.
Yes, will send out a v2 with updated commit message.
>
>>> After:
>>>              +-04.0
>>>              +-04.1-[63-c1]----00.0-[64-c1]--+-00.0-[65]--
>>>              |                               +-01.0-[66-84]--
>>>              |                               +-02.0-[85-a3]--
>>>              |                               +-03.0-[a4-c0]--
>>>              |                               \-04.0-[c1]--
>>>              +-08.0
>>>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216000
> Did you get confirmation that this actually solves the issue?
I've tested this on my setup, it is resolving the issue.
>
>>> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
>>> Signed-off-by: Sanath S <Sanath.S@amd.com>
>>> ---
>>>    drivers/pci/probe.c | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index 8bac3ce02609..ab7e90ef2382 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -1263,6 +1263,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>>>    	bool fixed_buses;
>>>    	u8 fixed_sec, fixed_sub;
>>>    	int next_busnr;
>>> +	int start = bus->busn_res.start;
>>> +	int end = bus->busn_res.end;
>>>    	/*
>>>    	 * Make sure the bridge is powered on to be able to access config
>>> @@ -1292,6 +1294,13 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>>>    		broken = 1;
>>>    	}
>>> +	/* Reconfigure, If maximum buses are not allocated */
>>> +	if (!pass && start != 0 && end != 0xff && subordinate != end) {
>>> +		pci_info(dev, "Bridge has subordinate 0x%x but max busn 0x%x, reconfiguring\n",
>>> +			 subordinate, end);
>>> +		broken = 1;
>>> +	}
>>> +
>>>    	/*
>>>    	 * Disable Master-Abort Mode during probing to avoid reporting of
>>>    	 * bus errors in some architectures.
