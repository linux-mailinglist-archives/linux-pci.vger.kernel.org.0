Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B149F25B4CA
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 21:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgIBTyG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 15:54:06 -0400
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com ([40.107.237.85]:60384
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726285AbgIBTyF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 15:54:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2jT0MTPjlrzhjbBCjmRJUoagObmQ3IK1JP3wh1mR/4cqPSotON5uqkyLw44UqCvReueRjeVMP0vdfW+J9eX+ZruZKj73DBcpTHwp9o/SN/TV86/s7iPumHeGjXRTUIr4KG318pFxV8jcnT14ChSrrNkp+egaVAH5kq+5OTIUYqgq/Nw1YnVnKzedyG624YJ5XOI1e+ixxsBnRXnhLl3OOxTwxq7xEqSCIN1/gzmamZmjK3tRbYexZ7y/v/QtBHftKl1P9mwso1zOkH35xhY3VTkmEnFVxGNUfCa3C6XxDO9tC7Kj6lpgtx6A3g4wTN3hhmWPPRKjs08hODf3ra+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4K3IrLlnGjgobFuDL7yLTgT0dWekAqobYsy6KcRvPM=;
 b=Xh2gq5rOIF3wG4hnmD21O4diYLVF4fS3+T5Fiv84SIUyjzvjmpXT2vrLGQ4RJsX7iMvQROQPDjd/nWALReKblDe6Iqo1ECbKPTtjh+QleHaYkaKk3H6BEQgxcFO4HjF/P4lSI1ZPV1LCk6jg/07SXvFk8Z46RJ+HZi3jy9uteww/IZ05TfkmNYJzFPzkb17We2zwiPSDhzZ4bdJvSEezs23IkIE+/yBTGykRE2IjzjtTrmc0sXEFBmsESlFWMzlCV8jt+E0otGXsYfzNvefrSEqakLs4Xthc3XGYhrbDHQ7a10KDaG1IyP1q5Ed8SdLmdwzVtTJ1KvWITwgdHH94qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4K3IrLlnGjgobFuDL7yLTgT0dWekAqobYsy6KcRvPM=;
 b=G0YiFkqybp+rB7t7/qqdoeMEndzIcGBSfX8sJ8GGJlLR3aH6HNaBwN//augUNi7itVGenhW8aZhnkp3vsHMDIba6ykdDtFa5LavQvnkYqSNt2pWUQlTeT7rbRCAm1gInuuz11apEiOLBXlmS4W1SDVQKUatBPwKlbiXlYXf5fmo=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Wed, 2 Sep 2020 19:54:02 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 19:54:02 +0000
Subject: Re: [PATCH v4 8/8] Revert "PCI/ERR: Update error status after
 reset_link()"
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org
Cc:     alexander.deucher@amd.com, nirmodas@amd.com, Dennis.Li@amd.com,
        christian.koenig@amd.com, luben.tuikov@amd.com, bhelgaas@google.com
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
 <1599072130-10043-9-git-send-email-andrey.grodzovsky@amd.com>
 <75db5bfb-5a53-31cf-8f89-2a884d6be595@linux.intel.com>
From:   Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <a3cadf36-d597-97fe-a096-83baa73c6f8f@amd.com>
Date:   Wed, 2 Sep 2020 15:54:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <75db5bfb-5a53-31cf-8f89-2a884d6be595@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::38) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 19:54:01 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81f6db2a-d652-4367-907f-08d84f79f092
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2485B89C30D029298F91E22AEA2F0@DM5PR12MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZXpEx0jTNYmo7yJsmBdr2mJ/wshyS4U72cFVisfIcLE1l+0J/l2u8aquSBot91ZbqCEwK+qy4USmO5SNaSszL3AAffPwRLKaJK7VV5lP1xXVEFx6OaR/XBC2nk79Ux19Z4xzmhW57QukCSYkwTJan0f9/k7zTutTxuUANn5jIYihxuxF8FLKAOVxFxcKy93sTzTvUXqPCLgNBD50nHBt2t/qxzT1g4j2QEyBNQ6uwRJKLheC2fh+WoJTB2nq2chCV8vOeYfohA4E3EMtmiuSHy/EOSuPq7QNjFYjD/GgnpwBnhk2Bc89tuaTOU+l209OJgksT9NGOOsWFZR99SRr9cqxCL907Caj8Kn66Bn0coppEZ2cgBv+LFHJUSQkFnd9J1u3GDxjXuDg6wSTvrDOM74XgYGEiLNOqcjZwXKvHKcRuTKEC8wcUAWfQXDx1Xs2XK2X83A9vIsmjIEkjPhkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4340.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(31686004)(8936002)(83380400001)(26005)(31696002)(45080400002)(478600001)(2906002)(86362001)(36756003)(8676002)(186003)(16576012)(956004)(966005)(5660300002)(2616005)(316002)(4326008)(66476007)(53546011)(6486002)(52116002)(66946007)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NepcBO5NPjxrtjG/eNe8zswI8EWyQt5GIWdAt1sXFxoQJxYKXwyVchbE6vtjlFPde8FJBHHNOavBVfnrlpcPwRrNVHM5jx3BXiuQzPzbumeTKqebOJY8pykyIMjESwQxmQ3UwW7AR8FfRhxoV2Kfer2BjS4fnA3DJK4gg3oK05yl02d/M4fo863kvnkLr+jmC2CTbq/tjUDErvf0KewZ5VDs+k+CQ/QzuGEaCvq59hTLXj3j/n7CAkxV7NskaZi05muDbNVLsRdE7i8ySM/WqUk2ImFGFckgVHon9Qhk3jsviOJqiUV9JjnNKm2xM1m7Eo0dNE1ioHvSoxx1PQWzbVlvaUsuZPazQ2eGu2bNes559zNJ1cLEGZGh0QHGMDucSaqIlgxzg//eivzcky5FPY+EcnNtbHTsek0D3cGh0Y6gXqbeC8GTnaAz5YZ6pfRvBjLLKT5WMfmgSxoQ4FBXIQchLzo8TIqWWQx/aqzmZiRmoIa1KtBAbFbsYnjOYm0uMpqVe1Vi8m+6Sn05+M/Ssa5E6i4MhmnHD44T9i2Apmx6ktT1L29PRMRdlaOZFqibrvkCPEsxf9mR8ehuVUxVYshISh4rEE/V/d2cNIBni19W2UxHPz2nxzi1BJMr9IFDnHSz8QSkkrlqzJI/XUGCKg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f6db2a-d652-4367-907f-08d84f79f092
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 19:54:02.0939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLNL3aFiaaP2ET0adVv4R7ZbAwcwT9H1osdGnm1CzCbdXhT3xHdyLT4DAyCeS0/uxqexkRiDUA1r7OHnWkPgxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Yes, works also.

Can you provide me a formal patch that i can commit into our local amd staging 
tree with my patch set ?

Alex - is that how we want to do it, without this patch or reverting the 
original patch the feature is broken.

Andrey

On 9/2/20 3:00 PM, Kuppuswamy, Sathyanarayanan wrote:
>
>
> On 9/2/20 11:42 AM, Andrey Grodzovsky wrote:
>> This reverts commit 6d2c89441571ea534d6240f7724f518936c44f8d.
>>
>> In the code bellow
>>
>>                  pci_walk_bus(bus, report_frozen_detected, &status);
>> -               if (reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
>> +               status = reset_link(dev, service);
>>
>> status returned from report_frozen_detected is unconditionally masked
>> by status returned from reset_link which is wrong.
>>
>> This breaks error recovery implementation for AMDGPU driver
>> by masking PCI_ERS_RESULT_NEED_RESET returned from amdgpu_pci_error_detected
>> and hence skiping slot reset callback which is necessary for proper
>> ASIC recovery. Effectively no other callback besides resume callback will
>> be called after link reset the way it is implemented now regardless of what
>> value error_detected callback returns.
>>
>     }
>
> Instead of reverting this change, can you try following patch ?
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F56ad4901-725f-7b88-2117-b124b28b027f%40linux.intel.com%2FT%2F%23me8029c04f63c21f9d1cb3b1ba2aeffbca3a60df5&amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7C77325d6a2abc42d26ae608d84f726c51%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637346700170831846&amp;sdata=JPo8lOXfjxpq%2BnmlVrSi93aZxGjIlbuh0rkZmNKkzQM%3D&amp;reserved=0 
>
>
