Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BD944E595
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 12:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbhKLLdU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 06:33:20 -0500
Received: from mail-bn1nam07on2080.outbound.protection.outlook.com ([40.107.212.80]:18756
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233619AbhKLLdT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Nov 2021 06:33:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk5m4kyaWly0PUdVRfedDy50MfYMbGSQwTPtSe5hSqaFRRETFX4pii1avXHyuthhOeoCauOo6HEamlg7OuIdZn+22JRe12IzCNzSeFB/+euwtimuCs0KHtG/9lYI7vVzkTiFRtmXwUWC6zmh0WyXU99AGJ6ToEHuxmohRZZ3SqNWlj8qaEXTEduuZmHVB0j98I0rH+1vtg1SAGdR4SVo5UN4Sz+dePQRlWk9WSd7F0up97M7P1wEeSLhwU6II9ypUb/X/qKjl6LeZrHQXyuHLueO6mDE6YWGCobOo9GCe0zJiOUhjEn0hvp1r2I4VEGrmA/+yucu9XXajp/WNoAR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOM9c7kSs/droLIMAw5RdA5nKDAUkULtkmO/P8GRjhM=;
 b=U3H4fDqCHKOjmS97Kl/MbefOQoofFAGT5F7kwcC5FDG/IfBj2Ffkg6ep03MntT4P7W/J9ix4liWKxpwah+XYi0TFTwCmeA1kJaCwGONwADqn6mnCIb6HKFHUU3PxklaVKTU4asutapGbd7oLZfWeQV+IdxfSDtrP7nN0Aq2zeJmtNY9JIWzjJXFtp1XJ8cTZnpR0taQbvZ2/yVjCdX17bUldfizuzMTk2J0uW9rwP3HxwRsjU7bpVQDAlD66vAieyEv4nDIOeKjOa8R5E2xS5kQh0LSPQinzIHj8qDUFoFfDToAFwHPhsfeRCybv+4pkpfT6UV2jPXnQqWo3D9OKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOM9c7kSs/droLIMAw5RdA5nKDAUkULtkmO/P8GRjhM=;
 b=ItTk7Aq5tF6UCtJvZkev8SbKalfFTWoDg7Zj/oXGW6HfS5CULaDps/iWjkuuI4wWGQn8Orjn5Ao8jG68CFoDS9NF4AHDyhQV3nBcnH6E0oEUgBOnzneevPnOaSoflSFXIXOdj9LpeCgwRe1mfJ21IQQRUPbHrGMnXv8xA7bfb/rT74kKnmB+rGGpasDcDBcOPh4lD7qUcNOfLxdOs+9SPdLmFKQUUgmNYvG5jc55UhfFoC9HLXKUR0HdKy/rBskuW7n1zRCNKLAcy/abvkdljydqzKhHLvD46YTbYJX00blNT825gu0t+xxeAyRmstWU0zoBNefka9r6g+LMYYqj3Q==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.15; Fri, 12 Nov 2021 11:30:26 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::c884:b4ad:6c93:3f86]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::c884:b4ad:6c93:3f86%9]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 11:30:26 +0000
Subject: Re: [PATCH 2/5] reset: tegra-bpmp: Handle errors in BPMP response
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mikko Perttunen <mperttunen@nvidia.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, thierry.reding@gmail.com,
        krzysztof.kozlowski@canonical.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20210915085517.1669675-1-mperttunen@nvidia.com>
 <20210915085517.1669675-2-mperttunen@nvidia.com>
 <397003f8-bf3c-68a4-828c-1254710f714b@nvidia.com>
 <276db30d95bf84cb31f9d9a6c029593fb0ccec21.camel@pengutronix.de>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <07341b12-3624-5cbe-8574-908139e905b8@nvidia.com>
Date:   Fri, 12 Nov 2021 11:30:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <276db30d95bf84cb31f9d9a6c029593fb0ccec21.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0085.eurprd03.prod.outlook.com
 (2603:10a6:208:69::26) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
Received: from [10.26.49.14] (195.110.77.193) by AM0PR03CA0085.eurprd03.prod.outlook.com (2603:10a6:208:69::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 11:30:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c50834d9-d21d-4d79-3373-08d9a5cfd2d3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5133:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5133076E64A6DB34A953CA62D9959@DM4PR12MB5133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9bLTN1uOwZV8yR4AKrO+M4sBQZhfjH3ESx9oDe95vU6Tk4BNnsuleDT4fShFIhWFDcT3L4HF5Nzs6UWQPdrUUskmsKfjaUwX3CbjpGvqi4zyiKKc21l6pp13IdxSsPn8uEvdYglaVIc3PqprU2/4X5WhFaHBIyQIlLjHKSsT1QsSkEK6zpAE6OTVQyGZyAK9w5viDgenUHN8AHZijw0biSnKWhowUym2yPn+/GpBqjBpfeeexstcnjSGhPfSxjAQale1lD8vs5jASLgTtFOF/FTyifnRPcKcAtzV2CcqAXHitKE/bcKxSRJfQ51SJX0X0DKxLoakXG1NhIsSf5vQZPRslgi1K2UpL/TFCUTa3edGJRkU1lNfYdK9fApXCzLig3wfDLjxjlQsWxWgApnzDSZ46seHBK10wMLsV6xbRe5O/mhRoG0HvU7aLaI0/SfQN+3yEtUFzNVrn+z1gcGN+yi9Z4TYmmRFxaTUvPEJJEaL/UhynvlkBLE5GQ4kn0VbodEtGOAUKLfWVAR0yplc1shctSxdFy+ABEfs0gHMHG35KENr3uDzB6081/t0XfavA61lrnOk6SudJGyOpIa78DhlIQCzxJTyrsffCNulCnoRDnhd880dFGn0zTP4dfOO5fdfAZBdR0zq1icdwn1hq3ICM2eCXd3GDVrL5BkQMeRZyb+dAyd8bWsh3S9ToKC3502o5q4Ov1leT0N8DzDKqYLq29eh9vClslf/R+sc3Y7sMp2NfexcybTMU8HPJGsyDtILW0xGwmjFvcLZEMeeDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6486002)(4744005)(16576012)(86362001)(4326008)(508600001)(7416002)(26005)(66556008)(66476007)(8936002)(2616005)(316002)(66946007)(36756003)(956004)(186003)(110136005)(6666004)(921005)(5660300002)(31686004)(38100700002)(2906002)(31696002)(55236004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjFoSWswcWREbTk2Y0dTZTVadXVIQ0hUSk9RWS8wa0h2WEJGL1BXejhvSnJY?=
 =?utf-8?B?VC8wc1VtRThRdDFnZGpyUVlRcWlRUjlocTMrRTB2bThJNnFYRHdEMytHOEM5?=
 =?utf-8?B?QkkzOWJMRGN2eldZN0pGOGxhWWtkVmdyQ2tJdEl1Ymw0c2Q3QTAvdGI0ZlRB?=
 =?utf-8?B?aUlzRGZWZjRaOGJIVUlOT2o5YzBJdVF4VEhmbjNMVGw0dnVPUituaTh6ZVZh?=
 =?utf-8?B?cjdJUlIyZnU0bVVrd1BMUmQ0OXVsSTNUaERpVzZaZEEwYmlzS3BNS1M1Q0VZ?=
 =?utf-8?B?YTduVFkwRzBjSXNJeGFGcFNvSndDblBlbDhVQ0xha2VBLzZyM2Exb3RGZHM2?=
 =?utf-8?B?c1JsbHp0OFZyRkNPN21BSGd4RmlOa1g0OGM4L1hmVVBoZmlpVTNPeFgxT1VV?=
 =?utf-8?B?V05kV0d4ZXRhOXZEclArSUI3UEtTWFd4bFdvUk9Cb0F2K0NsT2ZHWVlXMklH?=
 =?utf-8?B?dWJJQWVRa2ZBdDJ0anVsejU0YzNYZVdCMjBuLzNxYXJ6TEIxaUovZ1RFVGd0?=
 =?utf-8?B?MXIwN2hJcXJSQkliS3ZxWE04dVFlZU4rUzFON3RmMEp2R2NBRldHUHREbG5u?=
 =?utf-8?B?NXBuWWRqL2NqOWgxQzVzbCtRWitKL1V5RUt3WEV2Q0VBOG9Pek5kdnR6MHZq?=
 =?utf-8?B?QXEyTVlCWHlCYUNjbHBOWVV1YWhtamFFZ20vWGdBRlc4NUppNHNPSzU1YVcw?=
 =?utf-8?B?c0NxUGtTM3hwZkRlOFJjcDRPTWlmUWppNFlLc25kamQvcjl1Wm1RK2Y1UG51?=
 =?utf-8?B?TzJsTk9HazFveGc0Q1JoYWc3SGpNMzdVQXV1dzZIT21kZ2tueFNQS1FKUWJP?=
 =?utf-8?B?ZmwrTTRnYURaV29pR3g4Nms2OHBMbFpvYkZNME1LU3V6cmNkN2E5bUhJOHdl?=
 =?utf-8?B?WkZ2OUM4Q3llUnB4UjZBaXNxcDZyQytOc1A4cG03dTFuM1dHTUVSZ1FkME5q?=
 =?utf-8?B?Sk9GZWFTUUVkY2dUY0hOcG05aEdENkNMVW5XUWpmemVrcU9IdmJKYXpaR3E1?=
 =?utf-8?B?TG1jdmlzWkhJVEluQllKTjkzNS9VVWQvd0VFUUlUeXBRU2tmYzY3bzNYVndL?=
 =?utf-8?B?dVVMMkxRRzNBRjJkWHBDbkpieTdMbzJMc3BiM21oeWxKOGRzMVVEdHA0c2RK?=
 =?utf-8?B?eCtJaHV2bWh1L0tabnl6KzE4MlBaemRkQ2xleDRKbFRrd1FwazBqaWY5empl?=
 =?utf-8?B?ak00KzhpNE1RTU1HNUc4R0FReHpGeXNPSmZWaEpDSDlXZHNYK2dzVjF1QTd1?=
 =?utf-8?B?a244MlRNaUZsMUx1YzdDWG1zamQxby90T3hYK2xCb0FsK2JnM1JrOXVqQmdG?=
 =?utf-8?B?YVdqaFFkTXNSODFpV0F6czk3Mmw2NTFuUTltWGpDOXZVYkx2M1k3TEcxbGQy?=
 =?utf-8?B?ZUU4alVFK1Z5UlVJZTV2NVZYN1ZHWXdCLzNyNGlYODJGWGpUekhtUFpNY0Fl?=
 =?utf-8?B?YmdPV3RhNTBBUHRsQ2ljcmRWM2NlNWxuRlRXb05vTnZmZ3Z6M3lrSWNMK0dQ?=
 =?utf-8?B?UTBFSzFGSXlZV0lCQWdMOXM3dlVXWVpSNjRLbVdKVzg0V1pYYmUvWHRTL2hW?=
 =?utf-8?B?WWd4VUlFS21hazE5bmpyQllaYTdobmZkbjdPeUlndG9ZSzIwZnF6WmZnNHJX?=
 =?utf-8?B?VVVycnUwOHozTm1zclRGRlRYUkxwOStiRTlrTTJrbCtBMUZ1S1FWTGFUMGlL?=
 =?utf-8?B?TklUd1d5eWRiS1dRQ0ZocnEvYWdqV0VLMmhkakpublVQMXFvN0ljcGJpOXJm?=
 =?utf-8?B?UzFId1VRd0c0WnFhZXNKVTR2UnpjYlJlbnA0bkJPd2xlM2E5T0RLN3FwWmV6?=
 =?utf-8?B?SEw4bndDWkNMTE8rUDRFbG4vUllLWFhxQjRQaTBQejNEWm05K2YzcHRwTVpQ?=
 =?utf-8?B?T0hzRW9hOUF0eEJmUFVlcVoxd3FxdE9uSUZyQXRaVlJtQUN4UHNlWkVGdDdX?=
 =?utf-8?B?MWQwZjJXSFhUTGQwRDBkUEpIMHhmc283dFhJNE45aExKd01ocnQzYndtL0hO?=
 =?utf-8?B?c2toZ2xPSmN4REFzRDVubVM0OFZHTjl6ak85VDBWRUdWWURVRFNUVkh0YUdp?=
 =?utf-8?B?aktqRWkvRDlFeSt5V1pwbFM5OFUzWXYzbTdDQm5IY0tGS3MwTkF2SkE5Rkd2?=
 =?utf-8?B?cndlNzF0YlM1YmRkWU1MRldSUndmRU1XWUNqYkh4SEFVZkRuMDJOL3lvZC9E?=
 =?utf-8?Q?FuIx4TwlEL+FIoIVBl2iPuY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50834d9-d21d-4d79-3373-08d9a5cfd2d3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 11:30:26.6811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6aR8aR9H/+DVyDkHIC3ysgH5+Ba9VsphxzUyL8SKS554KrqTMhB/hwTN6+gNOx4S+SsDYFBw1+qJ+7fbtk72w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Philipp,

On 02/11/2021 13:10, Philipp Zabel wrote:

...

> I'm sorry, I picked this up as a fix and went on vacation. Now that
> v5.15 has already been released, could you send a revert for stable?

No problem. I have sent a revert for this. If we could pull that into 
the mainline for v5.16 that would be great. Then I will get it 
backported to stable. We will undo this revert in the mainline once we 
have sorted out the problem with the HDA driver.

Thanks!
Jon

-- 
nvpublic
