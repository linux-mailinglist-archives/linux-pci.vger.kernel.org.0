Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9B2546F39
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 23:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350281AbiFJV0H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 17:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348721AbiFJV0G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 17:26:06 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB473207ECF
        for <linux-pci@vger.kernel.org>; Fri, 10 Jun 2022 14:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pt+Q0Rm9oHHSSuSTUT2crOYF63rHr9POgpVoWLcy6jxJeouzCZK16XPBQizmW2VZeEUlj+Na4s/Q/FJe6X9Ak0962p2N/V9RcBs5lyaDjtTDr+IlLeiC66M2XHswBDVfeDCLmmGNK8zLDtpJQH8CXx2AuyeewoAq0vzuATLTT8n2cXJK3S+V4+A/IoqmD+OkH00fiHU/atgLR7LralnBnteVvJLuL+3gulROUe1EirEwWIrI99vZ+NjxLxVu7J1gfji2GN8PNzsSxdYtO5RaTkAGWGo/+42hYrkP+5hPmH0DYt/loFSiNsGAjcRE0NYgbff09jA8xUCQI/2giuInMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLJkGe1BxpQwK/bVzqmWoChZ6QLiaFSihOSkMSPJfhE=;
 b=dhJcqQRtU2eKhY5G7/D11kXHMp/RrafYy4xQPvt7lrqJQV/LK+z2jCQaUyj+yVsVR1lpla2C5zNkzv+Qu/mfzOr2oCb3Ej8qnxWPfXMRo1RpbnomQ/3djHi5L2suRVDogyj+rlY10z6HwvyTEKwmp/ox9LzXHNEjdpKqXn/LEGWXNK1F7uFd0wZvZzBslzGMAa3E765J8j9DDwq0o5zkwjLg1m3yCQTUEoYl8KQ7wRw53JecCc37Fzs5VDHKVbuGEoJtAiDOp5LDSysxqO8HnmEn/VX8XMqxG7n2VxNKEVaO6QXKh0BWyQxkmPqYAFp/b0VRIeuk9YywvB9WTC36Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLJkGe1BxpQwK/bVzqmWoChZ6QLiaFSihOSkMSPJfhE=;
 b=Js77ShXqzk+bWyQ2Iz1/+fAmTM8Mxx/qprZSpPZJkb5rjaCfwBqosSs+0uL4mlzJIjnU/10WdRBiK6LcRcmwRBHl6xakZFs+CsogmhtcZpFdN/zlFTDw29jXxySfVmo9Zx60diZFw7MlXtt54SQC7UBVcgp0qjsKByWkpzz7f9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 21:25:59 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 21:25:59 +0000
Message-ID: <952f49bc-81f9-68d3-89a7-b89ea173f6df@amd.com>
Date:   Fri, 10 Jun 2022 17:25:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Question about deadlock between AER and pceihp interrupts during
 resume from S3 with unplugged device
Content-Language: en-US
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "Kumar1, Rahul" <Rahul.Kumar1@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
References: <0fc31d9a-f414-a412-3765-5519cbb9b7ff@amd.com>
 <20220210062308.GB929@wunner.de>
 <f3645499-f9ce-4625-60c7-a4a75384870f@amd.com>
In-Reply-To: <f3645499-f9ce-4625-60c7-a4a75384870f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0049.namprd18.prod.outlook.com
 (2603:10b6:610:55::29) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc1871f2-c960-4150-1860-08da4b27d032
X-MS-TrafficTypeDiagnostic: LV2PR12MB5727:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5727CE3D48E69D920759D2A1EAA69@LV2PR12MB5727.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RY9DVx83DavDlQKv1SOje3tBQaMJtGcBXzTq/VCMCp8Jj2us2d3AXl2FMaUHeAOXxcHNZR7SIcwHjP+ujo+m4CQWQGjkneqQziB03ShchWyg9aJTYC2NQxZ81XMVZ3Dicx6qwOYKMIrTFGn8sMRphadgtHlFtzkKn9XJk4CK+DbQ+vxZLnY+JRlTYK2mbUXeD+CSrSfY6LfMyGbDpfnbRlfFAkCfyoe4qDrkImDevz21GCAjzKOIp18jHTYT+Nenns+6gtWoiNPvbtF/GKbRCgTUVk8BKepRlt9txT2H1inGFXiYz89yBkjRmp9gfEjkk32fx59WmWG5r3Pu6adzmvsHtJiCxg1qQLhreaf2evBRcmd02vbmZ66vi6s5b5dRScHOtxKk8F4Cic5ar5lj+Ijusd0/nLd8nPJnm/QZ5qttAN5LRTtruonA6on8xG+TanocwDawBvc4JgSwrBJttikA7koAoe8myfL07jDyrsADn5xTTmFLv4uvZFOq/4WqYffsQ34AS1QZ8wiXJLzMyEEii2e/TGY7rrA84u9sM06ALGczLIYUFXDx251Qga9TkV95+GntdR7OdHGsWhdgx5IuCREJKPA0DulFto+2NXcLJAWbcu8yx3feUqJJiYCcFK1njaiiLzKMMu8OAgYta/wg8PdGRE9WZZ8cq/jpaXqsN44kAXC/3VgZqQ1D3dkwflLPM+tGztupxNZk0ex67tWk3xipReM6dJz+O6ZOa04wRYj7HruX+JR25AXGEL2/MIHo6WXIevWmhZi7t2UACyZlpna4UpJDMIdURqr6z9tKQRIqNHD/FbyFpETC0BvA5rAb47SjeXMgtGZ76Hqqfk5+eh1Hf7DnSFasxpILzEE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(2616005)(66556008)(186003)(38100700002)(31686004)(66476007)(8676002)(316002)(4326008)(36756003)(83380400001)(54906003)(6916009)(66946007)(45080400002)(31696002)(53546011)(8936002)(966005)(6486002)(44832011)(5660300002)(508600001)(6512007)(6506007)(86362001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVhHUlQ2RUZQeXJrc1JNV2J3NXNibjlsdklLa3ZFMG84dkRmSjNsNDJQbWtT?=
 =?utf-8?B?RDlNNzJzajA2TXNjaUt0d3pmYlAyS1gyRTB6eXI2N3N6bFZnRE03UkxUa1FS?=
 =?utf-8?B?V05zcHJWNjBEcklmd2creE0yTjJ6azFUMWFQeFpQWWZIY3JDWnZMRnBRZUo3?=
 =?utf-8?B?cmNsbVBKNnJ6cVU5VVZ4RXVRM1cvQzJzcUpYQXFsR1NzaVJUc0N0a29mdXBh?=
 =?utf-8?B?a1h1dURpTnRDbHE3U0ZWSzMvWVdRZWYvcDVrT0d6TkVCZnVvNFVHL1JlTWpo?=
 =?utf-8?B?L21GRGVKNnl3eitIbEJ2cHJ3dmJKY1lYNHFRaFc1UEhRTUlkb2RldUxXUU1s?=
 =?utf-8?B?OUtwbWxtMjFINXVhdUxjbENYVDhPY2lpM0U2cllRWHdKZEMrOW9yUnJzM0Iy?=
 =?utf-8?B?SjQyMityT0VORmZRb2pXRVF4b1pXaThBVUMwVkIvMHFOZFdWNzg1cXYxSURZ?=
 =?utf-8?B?RUtDSEpYSXloQURLOVF4YnQwcE9veUgxV1JNYitzVThLSFFia3IrMmJlaGIy?=
 =?utf-8?B?NW84cjdYbkVtTjFNRmRBVTJwNmhBNVJGbkNlSTAwUmZnYmlvT0U3aXUweDJx?=
 =?utf-8?B?VlYrZGVTVEJVaDV1RUlwL05TTGFxbHNzS2NDWHdDNjdyeENFamw3ZTkxUytQ?=
 =?utf-8?B?dlZFMlNwMXlkOGpSUmRaMWlSNERXOHAzdUNrNllVbGVubFZSUFBMZWVVRFM1?=
 =?utf-8?B?RUJMM2Fpem9RS0lKSFVwdm0wRWFaVWhQU1l0SCtNNWtQNmpZdStSUzJwWkZK?=
 =?utf-8?B?L1NYb0Jxa1RHRGtVcG81b2dVSDEycHA0MHIrSTR1bmZEUzFoSUdNUEZsQmFl?=
 =?utf-8?B?SUF5WWZyM3g3cEsyek5GdjlnWmJ1TTJoTnc1b2kvYVlBUzZySnhVcWd6d2lj?=
 =?utf-8?B?b2dIZnZ0OUFNOFJkakg0MW5aTW5QT0tDVHMwcG9YR1EzSXJzYUFiNXlkSHpU?=
 =?utf-8?B?cU1VdERtcFlhckVrbWdoYm5JSi9Qa3VmWGVoM2w3M3Fod0xyMTFkSU5qNURG?=
 =?utf-8?B?eVpnYzJkK1Frdk5QUStzQXhEcGdTMm9qVU12cStFdk1YdytXM1RvMC9pNHVl?=
 =?utf-8?B?R3grSDR4TXhiRU9oZHZyOE02VVM5TXk5eXByRVI0Y3NRd1d4cmJGUzRnQ2Yy?=
 =?utf-8?B?aDFGbjNKbmJMcUI1SDBBUGdJTGpzeVBmdjZXdmk2NkhKWVhocncyZjI5ek1E?=
 =?utf-8?B?ZXUvWFkzSTJEemtzZWRKMitDbkFPTEJYVXFnQUpOcjZKUE1NWUwxQlEyVWZJ?=
 =?utf-8?B?MWw2ek8xSUljVDdMenlBTmQ3a1ZkZS9PSFUwYUV2MHkrSGpOQnd2WGFNQWZ1?=
 =?utf-8?B?OE01Y3RrZXQxWm91ZFNBM1ZXNGFoNXYvdmFxZ3VMTEdiTncrb1V6a0l3cTFF?=
 =?utf-8?B?NDl2d1Vic1MzZW1NTW1PY3BFbTNNTCtvdTh0alVQblM2NmFqdThrdTg0R3Vh?=
 =?utf-8?B?THkwaDBIa2tGQ1dEencyUXFkNGI0clZmVjVyUnFQMjNoQVBMYzY4dmVXcDR2?=
 =?utf-8?B?M0dxYjcwZ1FjTFppNTY5VC8va0pMSXNXMTlKWDN3eHdUenFFVW1zUGx1VzVn?=
 =?utf-8?B?VGc1cDBiR0U3dStmQ2tFblk2Y0QyNjJPN1U0bmVWa3NKVzEzYnRkK0gyeGhT?=
 =?utf-8?B?N2M3c05mdEIwaUJ4L2VzeXFSd3NUb2F1Mmdqek9pQk5tZUk4aVdQaDZBeUF1?=
 =?utf-8?B?WXhUclkzOGJlYzJSUEFUSndheVVJU3QrWHlZeExkdXovWTNpMTlpSmo0eDNR?=
 =?utf-8?B?Yk9kQ1ZiRGJtUDlpNWxBWXV4YlpRZFMxUDNkSE9BZElCcWJQS0dPR21SaFFP?=
 =?utf-8?B?b3R2YnFZY3RORXI0aTJhTkdwTVhSdHU4QTNkZEdxVDFLR3kzMzJTV1ZMOWVO?=
 =?utf-8?B?YVFVbnptQ3hnZEExVm5leHhWbDMrTUtkdlpkWHl0VU4zbUZsbHdvMkR4U2Fh?=
 =?utf-8?B?MitHeThBVVJjY1BvR0NheHQvamdwQlRDSFFsYXJCL2o0ZlZuUHJMcDVGZkdL?=
 =?utf-8?B?aUo2NnhOdEFUT3FtL0RGajZiaGxyMk1rd2hPRzJTSlg2UU4rNks0SW5GUW1v?=
 =?utf-8?B?L1FjcDhKbzJWT2h6eEhEaDNWTnN0c3pBdmRkUVlqV3NhSmFzYXJPdzVJVGtq?=
 =?utf-8?B?SGVlL05senhFT0g0TVh2M1hHNjRqeEdxZXkvUkN5QlA3Vy9nMFRmaVZ1WS9t?=
 =?utf-8?B?dVNqNWY2bVJoRGhNTUw3bXdsZFg2c2Q3QXI5S3RMc1ZQRERQTzZyZ1dVaUhW?=
 =?utf-8?B?ZG43RVpWZ0taQXR3MXYxVmRlc1drQzBUSDNTZlNMdHJyOVhPRFJOQmFORjVY?=
 =?utf-8?B?ajVDRlh6ZUFTUDY2YU9tdzE2Zkk2Y3RyaEV3ZXZ6K0tXQkExRkNwK25GYjkr?=
 =?utf-8?Q?Vqf+VtrgFMqMm8meuwUov0OE3O71PXk5Qf74agX5cUUEz?=
X-MS-Exchange-AntiSpam-MessageData-1: NCil8hoYovHpgw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1871f2-c960-4150-1860-08da4b27d032
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 21:25:59.7285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpNopGZdqUHxawbS8I14zs3O9lKFpN974pNgnpSslK8vZeL+tylTo/J13e0h+9M9r5iKbzuhlm5JwBwo7EDEtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-02-10 09:39, Andrey Grodzovsky wrote:
> Thanks a lot for quick response, we will give this a try.
> 
> Andrey
> 
> On 2022-02-10 01:23, Lukas Wunner wrote:
>> On Wed, Feb 09, 2022 at 02:54:06PM -0500, Andrey Grodzovsky wrote:
>>> Hi, on kernel based on 5.4.2 we are observing a deadlock between
>>> reset_lock semaphore and device_lock (dev->mutex). The scenario
>>> we do is putting the system to sleep, disconnecting the eGPU
>>> from the PCIe bus (through a special SBIOS setting) or by simply
>>> removing power to external PCIe cage and waking the
>>> system up.
>>>
>>> I attached the log. Please advise if you have any idea how
>>> to work around it ? Since the kernel is old, does anyone
>>> have an idea if this issue is known and already solved in later 
>>> kernels ?
>>> We cannot try with latest since our kernel is custom for that platform.
>>
>> It is a known issue.  Here's a fix I submitted during the v5.9 cycle:
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas%40wunner.de%2F&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cba698967471548d739c108d9ec5dcf6c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637800710411446272%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=hrRVL77%2FNRvojfG2WDamDLO5dsqn3Cv6XxNbP0eGum0%3D&amp;reserved=0 
>>
>>
>> The fix hasn't been applied yet.  I think I need to rework the patch,
>> just haven't found the time.

Hey Lucas - just checking again if you had a chance to push this change
through ? It's essential to us in one of our costumer projects so we
wonder if have any estimate when will it be up-streamed and if we can
help with this. We would also need backporting this back to 5.11 and 5.4
kernels after it's upstreamed.

Another point I want to mention is that this patch has a negative
side effect on plug back times - it causes a regression point for the 
delay to light-up display at resume time related to back-ported AER

Anatoli is working on resolving this and so maybe he can add his
comment here and maybe you can help him with proper resolution for this.

Andrey

>>
>> Since the trigger in your case are AER-handled errors during a
>> system sleep transition, you may also want to consider the
>> following 2-patch series by Kai-Heng Feng which is currently
>> under discussion:
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F20220127025418.1989642-1-kai.heng.feng%40canonical.com%2F&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cba698967471548d739c108d9ec5dcf6c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637800710411446272%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=tnLUa6J%2FLqFrlm4CfZ9l26io0bOQ7ip30d26ax05st4%3D&amp;reserved=0 
>>
>>
>> That series disables AER during a system sleep transition and
>> should thus prevent the flood of AER-handled errors you're seeing.
>> Once AER is disabled, the reset-induced deadlocks should go away as well.
>>
>> Thanks,
>>
>> Lukas
