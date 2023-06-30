Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AF57442BE
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 21:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjF3TbD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 15:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjF3TbC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 15:31:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDC53AA7
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 12:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oenO8rJLy9/lgRnzRnXHF4kVYeZrSXzC1Iw2S4hmkCrY8Az/OnwgB+I/tpxtDgf/kCVnGgZN+9szJVgMphnYV7Sj5+uuN/m6diyCnUvNLcy5JItJsYMc9W4Udlhjm5m1Gewba3mqgnWRouv4Jym+OJr8lyRD6/L5n79UmIIMhBb8iroY2B5bM602+3W3aa22qDpe84B9XKuUlQQVHmyBGI48kmkZlSm84wCH6HIvvK3mmzMYbym8MY05oDU07dPgCh09UIpapST3D4XdzAoph0HiX4inejnfYQoCVosloFySfVtgdScihTzqP6+uo4Fh4ZKjZZMtiyOgFbCqs1NKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRsBW07TVFM+MBlrCYLsueFGoG+sV8NnagoV3dhc/ok=;
 b=FG0RzVk/gMBheu80DYtaoUOsGgXZ5ZVUuuNjTQSA1gyS3dBuqtNPrBFuAx7l/k0jZWR5FGL6qU5EiaJRwRmWMF7wxxiwuPztCCKkXOZntRWva/2cI2nDMR72HSG8JwprZNiCnzqz/fshNjsqDKgq+eD/NgkGW3T0zmco4tGSdbFQHZr0j1+JuY98ut/zi5rpdbxvdkKGafOKZ3wC1c93hYnD+hh0iMztcJ4+1O4S+R5z+R2adC/EjiiKcYmaHcrCFsbahv1HlvNBBfaw9Pk/ulB57BeoWurAyL6k89E+rltU86TRQLJ9txAi+MKnHaXQLJzHON/PH+Z3SX5LcLFmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRsBW07TVFM+MBlrCYLsueFGoG+sV8NnagoV3dhc/ok=;
 b=ARXvzFVeVeT3qf6hK73VosOy0DstffvNQsKV4FN7mA0IOLh4MamCb//32wnOfl1DxBJOf9YO+1z8MFVcL/LyGsCum0ZZOUYk3rXuPLNPYkZZdYfu6yIpkx03sFJ4GtPoCxlLglXItmFWEd94XETRcnFp4T4rxMNUM44zJlK3pAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 19:30:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 19:30:58 +0000
Message-ID: <6faf3773-d974-4822-152c-0af2247cabec@amd.com>
Date:   Fri, 30 Jun 2023 14:30:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: When it rains it pours
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:5:134::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: de737797-7adf-4283-9cea-08db79a087fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LP0eXA05LpGVaM3qzZAvl1PYUr1CpTE+1cHEVDzcH/gqz7mz93KwCZtb1gWuD/Ll9UjbTUfz1O25yKatQ3hFAqejP3vAArrPxSz/80u2xuJbNRpjXc3BgDPwvF1mubWag0zp5ULnZbq2G2g3zcXbh3T+wAbdtSIV6oQm8v0VZA8qoSF0TR6Dg06E7GPdqxU3cGgUGg+v4A8qvSfYdH1VjCJxWlj/OLpJW+572XaMMrWXEMymtQhVwcX5ZuaArrmUEAb/aXIxgkPsrMr3pmbN+ZVDDvP9h6cu3iB+ecUAmQ9OiMjfdb1Tk+laR7AvnuNp/bkf97TuICaVYCAjRVHC1jH4MWlE2m3E1veAgrUxpTTGjmgEueElOABaB3S2vqSe78FiwV8fLl0pnXCygwn5b13Dyj4g+1dOkvKi/1Oy6qTFdOhfU8BhoGYx5k7WWWiHDVsIS1Sb4qWTd54rvsdl2fMs43OJLzEfDDoXtjFQyNDQUIWO6SkIfK52ACU29jVTSvuVlEZmM5ofobcyF7jTiByNT8+/QAckbHx3DqCQRJk0ue+fBQKR1gbudVjFJDe8eokFQhdgJ1Ol/a7E9DFrJi772BXfvYZ66k0GwwpXpCr6xR3sTFEm379sSB/uzm8CDVOT/yzFGNHKouNArdgGMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(26005)(66476007)(66556008)(8936002)(6506007)(36756003)(110136005)(478600001)(2616005)(83380400001)(186003)(6486002)(4744005)(2906002)(41300700001)(66946007)(316002)(31696002)(38100700002)(5660300002)(86362001)(8676002)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmV6RVA0bi9CVHY1YlN3dWJDQWloY29qWCt0TGN6OUxLOEttSDZsV3piZ0hG?=
 =?utf-8?B?TFlrcDJ0cjBlSHprZVBYMkVsdjV1dTIzRWdDMW51OXdlckpCS0k2aGxyMHlE?=
 =?utf-8?B?SWF1RGlSU1FLZVFpUk4xa2FFSU9lWWtZdVU1S0VKc3RBOGlHV3RHQ3ZCR01a?=
 =?utf-8?B?dFVKVWdjRDYwRFM2Ukt0V0IwR2Q4NVN5RVNGWXZ5TVNsU2FUSDdKNVh1bGJ2?=
 =?utf-8?B?TG5nQnhNOXlBUG1lcXdHRlRhM2tTV3NQNldtZVZydnpNK1daRnd5Mm85MU05?=
 =?utf-8?B?enk4djRPQUFLTThyemtBSkVkaHZKYXljbHpQLzlZV1ZtcVdxQmV4SEN2MEVJ?=
 =?utf-8?B?V3ZMVU5WQm82MThRaFo5UkdjcFFQS3NMMVJIOVZHdXZldkVYcGEwU25mM2NP?=
 =?utf-8?B?RThKOUxkWjBrSnIzeGhDYnlPK05UVERhak9yM3JGYWdpLzZ3THNieFUzNncz?=
 =?utf-8?B?azh0VlhMUzREU0lLb2tVQ3NiTkFlTEgzSzFnQjlEYjF5cmh5QkhyVVhIM0Zo?=
 =?utf-8?B?M3JHQXNESWlDOGcrRzZ0dkxTWVdOT29iR09sYkd2d1NPUGVSc2NCQ2pVejd6?=
 =?utf-8?B?UEdwZVJVOG1rd01YK3NUUWlTMmE0Yld1cVUzMnl1cWgxMmhrVTBvWFhrMmpQ?=
 =?utf-8?B?S1BsNWdUMWJobWQrUFo2cUZkV3AwM2pJbkdMVEVQQ1hVdUZaUDk0WGVrODR1?=
 =?utf-8?B?Z2VDNnF2VU55ZVZCV0F2dldvU0dWbHVUcG1WZTJodmlWemg3QnlpYkJWSlBj?=
 =?utf-8?B?QmFPUEZsS0xFV3VuMUVtQ3FMQkNncVVySit3R0c5b2ZrMWZFdHhnYWhydFhP?=
 =?utf-8?B?WHBTMFB1N3NXNmZ3dFY0UGNCdW9qTDF0UjYvd1JXUGRQL3BTWEJyS2ozY2dm?=
 =?utf-8?B?bDNnYWFxQWlXUXdxRHVIejZST1pnV0w3NVFHQzJ3WUtQOFovempSSGtUUmR4?=
 =?utf-8?B?RVNMYjFuemovME55U25aUFJHUnVkZ3ZvaERjaFJBd3VSdTlmcXBhbnM0Vk1O?=
 =?utf-8?B?QXpzOXFvR2MxbkNCSUZ3T3FrczZ6ckdrMVZ3RjJ2YmxRMkg0RDd4UmVHZUdU?=
 =?utf-8?B?ODdsR1NtSThLbWY4RnRWV3JqaENxR2FkUzZLYWF4QWF2VzNMckhDUzVqMEl6?=
 =?utf-8?B?SnByaG1BRTZnZERaL0t5dkhJUDVydVNUY2o0Vmx2Y2ZYYlllS3BUdlFZTTJw?=
 =?utf-8?B?SkRFTHUzZnNkSGtkdVZzYXJmeVVoRk1WcjV2b1l3TDZqb3Z3K3NPYnJWNzBu?=
 =?utf-8?B?UGNZWG8xV0NhYWJVRHJrQTRleWEvYlhjNTdaZCszRnY3Uk0xTXltaFlpYXRE?=
 =?utf-8?B?UmlpQ2pYcno4OUFDM2tPeUZNV0NpaDV4WWlXcThhdTRodGdNdTVnV2ZkbVdh?=
 =?utf-8?B?cHhRREtPWFM5S3BFZVNER25OblpUcWg4c1o2UnlYYTJ6ajlyMGlKWUxUTVBF?=
 =?utf-8?B?V0pEWGFBU2lNd2J0VWFVV3JPejZEa0QvbnVsMzd2ZFZ0bWJ0bGFtdUpscDQx?=
 =?utf-8?B?Sm5qY1ltMEduRzVkZWdNMHFKN3JKTCtSNFJMZGpXdlNLRis3elpVakVlUFpD?=
 =?utf-8?B?QklaTG5UOGMxWWxueklUc3llYTErUHJkV0JzekNKWStLYjBaaE92NHdPWXJE?=
 =?utf-8?B?WFdtUmUvaCs1Zm05Y2xYT01RK0xGU2RPTXpqMERvMmd6OStxc0ViN2RqRkZG?=
 =?utf-8?B?MjRhZlpSRFhBUWIyRzIreDJDdWpoZC9yMkNCM0cyWXJOeVQ3NnJXd1RSK3Vz?=
 =?utf-8?B?SXRuTTRGYWh1a1NsV2hGZ2JuZ2k3Y2dYa2Q1VXNvckJUOWdsM1VLVzJHR2Mw?=
 =?utf-8?B?S00vSTVmQitjRDNUQ3RMcFVsdFRHWlhKR1FOVkJ5SE9BZ3FxQjBFaStaejBI?=
 =?utf-8?B?c3JHWm04bmJoaWJwZUs0WHVvbFkzYjZUUmo3U1hEcnFXSDdVb285OW5KamxN?=
 =?utf-8?B?dXBjZ0V6eFB2T25nWklucG1EUGpqellkZCtXU2dxQ3YvalVuUUJCV1VhVVhG?=
 =?utf-8?B?UWtCempySEZVRGtUY1IrdW9Mb2FuSkFXRHBSRzlNUUozOFR5NERsVlVyKytk?=
 =?utf-8?B?aGdLUFRRbjFaS2FRU3lUVkordUpqeXY0ZXpPRUppQWN6R3c1ZENGSVJQcjNk?=
 =?utf-8?Q?BZlJ4fZmbTSyMU6zwZuTTzDPq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de737797-7adf-4283-9cea-08db79a087fc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 19:30:58.8497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgDlkxZyuMArd3kWYeWYEMzUUvrHgBpZ+FDjkunEiXDmZy5b8WkwlfbMPcSu7AcBwRXmC9WyM9pLD4UmkeWteg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

For the _REG change that went into Linus' tree I was recently made aware 
of another system that it helps.

This system was appearing to hang during bootup which evaluating the 
USB4 _OSC.
This hang happened on both the 6.1 LTS kernel and 6.4 final kernel.

In looking at the BIOS debug log shared by the reporter I noticed that
the kernel isn't hung it's just that the BIOS was waiting to be given 
the ability to access the config space.

Backporting just that _REG patch onto 6.1 LTS kernel fixes the issue.

I'm encouraging the BIOS team to try to come up with a cleaner failure 
path for the lack of _REG being called.  However there is always the 
possibility they can't or choose not to and people try to boot older 
kernels and fail.

Given how severe this boot issue is compared to the original suspend 
issue that prompted the patch I wanted to gauge how you feel about the 
risk of taking this change back to stable.

Thanks!
