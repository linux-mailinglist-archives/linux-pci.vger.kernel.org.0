Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1194B1093
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 15:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243021AbiBJOj0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 09:39:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiBJOjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 09:39:25 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DB4BD2
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 06:39:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FflBLX9b5guAiyHSMtDhIuNZ3rJl/Tr8GGrfFXYplUSZOE4ZmCqRdAYPMrsF+AhMvfRnLVwC17bXll2Ca6DCLhGFXDLh609dcSgJgLRIY8nnyBfvyWl2NqHOeGHpKoMWko0zgScaoQSr3LhAVMdST0qQVFiNFUtI9mLKk6eDOAxZ67mvmrtT1lTXgM3IE9PYjx9e9oFwKrU2gGrfPC0VED7BGcRNVW/q+HRxCnoknVWONpILXdOskQuFE4+qmE/e/9YvBfQWAorxqSS2TyDnadbV6d/Fu6fTD0Gn50+IxUCn5DA2t3M+dtJxeQM34mamE78NkeRtaGbBu+1CROvtyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PBMP6rPBHuIvcbf1E7JDNPGBGG5+M+34uFggXINowI=;
 b=fhkVXg1sbOLkU7mXbc5LwHnqi1XpLuK6VZc1RKFdpQha8UH0oP7mNknF5QedhAOW7tujcXxsUy88kxfgcH21ugQHYXC9AZag1BuRaVFyMwgtTpaiYNmnK+fIll1bTJEXwj3T8E3y9PRJ5TRHLl+A/5sMEUvYCRkqIlk41ASIbdd3anHCmggCdeyWwHtVwx5fXGQ051SZYbd38KBiiXES3dn0pZF8ANYKMIS+2LRHA0JizQZ/4DM7H/BF6p+zV63PBG/E3bBUmnfNRHgXowTbu6F9eqpIznIVqR1zPGRojnNGeR6xXU5PfDSXOh0fA1YOzTLvXvdVscpG34HvbObKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PBMP6rPBHuIvcbf1E7JDNPGBGG5+M+34uFggXINowI=;
 b=GtJJjpJ1WRPulrt8BOtvmeDs0mdPEUwx+ll+2RbOTDmlNtesia7U40xGo3B2IR5E0pP9hrU/7obXvUHGf3LgOY+0IsUXWgya2st5eHyVKwCzGsWsEyZuKvXh/gjW2/GscWGKow9nV+7r5UNXD7ZY71OoMkL0ROscrfcbU307gtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Thu, 10 Feb
 2022 14:39:23 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3%11]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 14:39:23 +0000
Message-ID: <f3645499-f9ce-4625-60c7-a4a75384870f@amd.com>
Date:   Thu, 10 Feb 2022 09:39:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Question about deadlock between AER and pceihp interrupts during
 resume from S3 with unplugged device
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "Kumar1, Rahul" <Rahul.Kumar1@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
References: <0fc31d9a-f414-a412-3765-5519cbb9b7ff@amd.com>
 <20220210062308.GB929@wunner.de>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220210062308.GB929@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0036.namprd18.prod.outlook.com
 (2603:10b6:610:55::16) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1b54033-8534-4a51-807d-08d9eca32150
X-MS-TrafficTypeDiagnostic: CH2PR12MB4247:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4247A5239FED47DB70EEFBABEA2F9@CH2PR12MB4247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dp4wjx1XLCTg1auZ/mjWb0Mb0WCFvXxv9FEFX0fap7/pqfuRyfWGDDL7UGRih/Z6qEBBnk6hHiEkE+diE5qdUV6nf5RUxWkVt6nbqcsscTwMz+NIN9PtGj0ItEf+lWIXh0MnZ+5LjsHcpuQA3OfLgDElYWlVGO8NfM3QAqtYxCPJI9mqK0pOwfdreNiiijw5rZlzOSBPBv84H26JPVwvQANn2djJjWDoPR7dHwV8CZq43vRurD4njwXrAAmv+6q2hATwxnNSggY3t3lSr/ix+1m4syzazfQNEo1f5AAA4shmt1sSDo+oFpuy0ceR8ldPMBCjt6ZbvpADb693lPzgL1dvlk4qUYP8cwOpsVDBlO1OpMej0nh6y4/2j0I7n60XoHYZ6vKBd/jHMoaHb3sEC1edmtDGLznt29IEpgi/iWnJv1Wy7anpDh9pq0EQpgCNcFYtAyCZDsI518cHRSUdPAiBD0x6H8aqmHwvZLAHkIaZOCIl0HC4A6DhjyvZ/YH8qj7ZFYDvi0Su1hVrmVIvQxicWjKHZW9vbYdRw5pRQz+7RRZ4JQvBiHhKroIGMu022C3lZpWWI59at8eGWI1LrJAO3K6Hcpwzlw6FCGEH3cccT1kIn91rsRQFktD/HAFdM8wN0UZBDfT05UlT1dLxIMfHhm9o39+3cywZrivrauF4q3+d2pZWUrbGLO+OCM+a409taDf4cS8v/sQlUKTca4S546mgopSUm8vrIPWwaFZv0C05T04AQij3l5HgA++K3ExEvhQ2i5xItA3PQIig9aVY0KgLsbtcbGtJwhxMQ6FvppCohqZ696c1A0nLEeqFpl9bc7cTRRVyqDlQAOobdcYlAN6fXIZTy08Ty3UOiao=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(53546011)(2616005)(966005)(316002)(6486002)(86362001)(6916009)(31686004)(36756003)(54906003)(31696002)(38100700002)(4326008)(6512007)(6506007)(66946007)(2906002)(66476007)(66556008)(508600001)(45080400002)(44832011)(8936002)(83380400001)(8676002)(186003)(26005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmpkTzl0OFI5cm9PUTN1ZW1CMHNBZlN6STNYR2ZzN1ZKWkVnVUhLU08ra2Nw?=
 =?utf-8?B?Rk5JbXU3OEtCUDlMYmFTb2Y1bE1oZFVpdkkydHNlT3hTa0g4RGNaZ0tLeEZV?=
 =?utf-8?B?SlBQU2laQVYrOE9yT0RTWG1MdFdqSkZoSHdvbHp3RDlYL21iZzFpUUlUcmVw?=
 =?utf-8?B?akdTQkFNazdtOWxocnh0dHoxT3hDMTZ1NS9YYmQ5NzNZRlQvcG1RN3I5Yitt?=
 =?utf-8?B?MUR5L3kwT2F4VGFIQkRuQ0RkVWJLQkNvNzE5ZCs2TWg4ZzI5N3hGNDRaSEsv?=
 =?utf-8?B?d25JSnRJSGpOb2RWWWN5aHhzZmpkaWluREZWdkNENllnNnNuQkZ1N2o0c3VM?=
 =?utf-8?B?OEs3aWhPUy9lMVYrWTNxTUpDMVpncWJyYzQ5U2pHdFM0Ump3aHFCZVE0ZmZM?=
 =?utf-8?B?K1YrZDlVSnN2ZjROZllMMFh0T3paSHNyTHh5R285bVdFVFo5U0FvQkRydlhx?=
 =?utf-8?B?bDBTVk1Yb3Bna3ZGZHc2KzBHdlZFVEdlMFhSbW1ReU5IWFVVRmsrSi9VdjRk?=
 =?utf-8?B?MTVaZXQwRFV0cDdWUEEwdmV6dUpXQ1ExNWFzY0hkbkNvSCtISFNMRnMrYStC?=
 =?utf-8?B?bEplai92ZitZZ1AvOGVyckt5ZVFNNzVqOGRIbFA3dGNFV1VnMVMycUhqUHNa?=
 =?utf-8?B?N3dRanliYVJXUGZ3ZitUOHM3bWFkNzNBenF6dmtLcEZvcWFjVmNNL2hSaEhQ?=
 =?utf-8?B?aklSTXFYRFN5VVhFdS9mdFYwZHg4ckFqVlhldXZDd2x4WiswYTF3OTBONzk5?=
 =?utf-8?B?Z29TSUkwdGZWblEwNjQwRVVFY09UbXJxK25QdjdMaE1sODJDdVp2c2orYm5W?=
 =?utf-8?B?V09wbXI1RUw5a3FsY1BrdW9IRTFKSkdlNHM5YkZqdWZ5a2lSd3dlRytOQmFw?=
 =?utf-8?B?M1JyWkVlRnJhOEw5Q01HU2YweGlKU1p5UGR0QW1WLzJsbkVFSkRKZlg5dFp4?=
 =?utf-8?B?dG1rOCsvaEF3OG90MFNxL0hJNlpRalRMc3R4empDcUd1MmNDZFVRZ3A4QWp2?=
 =?utf-8?B?OGdMWlN5Q2l6QkpDWC8xaThWOTdTSmpOZnc4SC9VZzBXRHgwZm1wZUI4c1JZ?=
 =?utf-8?B?a0NLSHdWQXZLVGs0L2VncU5aZkMvTjVPV254cWtsV2dXbUFwNkw0bmIrYnZP?=
 =?utf-8?B?dzRQSXoxb1I0Q2lnZnZzVFNnUmhwd290OFlDOXhLL0wwRWNMS3p2NUZxSDdV?=
 =?utf-8?B?elltNUdqVE5sTytoQ1FWVmRXZHhZMnV5dm1pMDMzMXA0ckp0d0RlbWlHS0p5?=
 =?utf-8?B?d094WlZ0Tnh6QWdyTTRDTVlBNUkycXVJZi9XaDdvNkNVWnlVV0d3azU1QXlw?=
 =?utf-8?B?dUxFVERNeS91TUwrZ2dKTWhRZisrdjJBSWNReWRNaFh4SkxQSG92RTNIb3kx?=
 =?utf-8?B?MDkwV2FlRHJtY3hvZGc1Yi9VMWw2MEpBOENKczRMWlJPd2toV21RSjVIc0E5?=
 =?utf-8?B?dXc3OUJvUHNXUmxUOXpNUDl4ZnU5ODVOQ2VLSWJYeUI4Q3FreHdFb2k2ZWpG?=
 =?utf-8?B?cUVPK3laZUNxWnVhNk1CL2t0bjgvTHJBalBEVWlhQk5rUEtIWGdkdkdRSnN6?=
 =?utf-8?B?S1FmaVlQUlBQTlR1dzRpa05JR3J4VFoyNWhpSnp0TmdVUnhJZTM1MmdkVjdr?=
 =?utf-8?B?dUZld2NVSml0ZXpkSjM2SlBNOG9MWGcvWURYb0I5UDkzdEMvajFGb1VWTE1C?=
 =?utf-8?B?SHVRcHhQNlJJTUEyVWwxZXRtYXUwVEVESGJ5SSttRzN0MXB4dUV4M0h4WElC?=
 =?utf-8?B?WVpQRnRsQ25mbUJKR2p6TFlHalcyalJUaTVXSE1xZ0xsa1I4RTQyKzJ3NndO?=
 =?utf-8?B?YVZITWJDSS9Tc1FDeXFVTzgxOCtxckg3bUFtL3M0QWppeU9iZXowVll6L1Zv?=
 =?utf-8?B?R0VoSjk0cW93T2R3OFRYUWkrNVhmV0pTcVFVaXVVTHJiVWlWeUptZ0JwSlFK?=
 =?utf-8?B?dVF0ZTBwRDdxc1pOWHlybGRUaUxlUFBMaEo1clR0Nk5VMWU1WnN0a1E5d2xx?=
 =?utf-8?B?KzcrL0J4SVphUy9keVpCbklQdVFrVjE0bVF3dk9sZFpiekwzbVBpSC96WlEx?=
 =?utf-8?B?LzhBclIvYUxuSnB4QmsxUDdReThFZFdFalRteVAvZ0sxd0hxM0x5azdEUlpl?=
 =?utf-8?B?VkpudlQrbWVRY2FRRUF2Tk9FRzhQMVhtTlE1bFVwclBnOHAzZ1NxUGVlcVl5?=
 =?utf-8?Q?9D+phAnsQC6pABRhZyzmRfM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b54033-8534-4a51-807d-08d9eca32150
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 14:39:23.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7+3Q322nBNq/SZ1aryr5wMdMelHYO4yQ9bge0AkzGXy6qUp6RqA5mCXYak4fb4oGa1lVP4MTo4irT3jcm9ysg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks a lot for quick response, we will give this a try.

Andrey

On 2022-02-10 01:23, Lukas Wunner wrote:
> On Wed, Feb 09, 2022 at 02:54:06PM -0500, Andrey Grodzovsky wrote:
>> Hi, on kernel based on 5.4.2 we are observing a deadlock between
>> reset_lock semaphore and device_lock (dev->mutex). The scenario
>> we do is putting the system to sleep, disconnecting the eGPU
>> from the PCIe bus (through a special SBIOS setting) or by simply
>> removing power to external PCIe cage and waking the
>> system up.
>>
>> I attached the log. Please advise if you have any idea how
>> to work around it ? Since the kernel is old, does anyone
>> have an idea if this issue is known and already solved in later kernels ?
>> We cannot try with latest since our kernel is custom for that platform.
> 
> It is a known issue.  Here's a fix I submitted during the v5.9 cycle:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas%40wunner.de%2F&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cba698967471548d739c108d9ec5dcf6c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637800710411446272%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=hrRVL77%2FNRvojfG2WDamDLO5dsqn3Cv6XxNbP0eGum0%3D&amp;reserved=0
> 
> The fix hasn't been applied yet.  I think I need to rework the patch,
> just haven't found the time.
> 
> Since the trigger in your case are AER-handled errors during a
> system sleep transition, you may also want to consider the
> following 2-patch series by Kai-Heng Feng which is currently
> under discussion:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F20220127025418.1989642-1-kai.heng.feng%40canonical.com%2F&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cba698967471548d739c108d9ec5dcf6c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637800710411446272%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=tnLUa6J%2FLqFrlm4CfZ9l26io0bOQ7ip30d26ax05st4%3D&amp;reserved=0
> 
> That series disables AER during a system sleep transition and
> should thus prevent the flood of AER-handled errors you're seeing.
> Once AER is disabled, the reset-induced deadlocks should go away as well.
> 
> Thanks,
> 
> Lukas
