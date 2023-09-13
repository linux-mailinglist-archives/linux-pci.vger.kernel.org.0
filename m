Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD09D79EE5F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 18:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjIMQhA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 12:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjIMQg7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 12:36:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432A3198B;
        Wed, 13 Sep 2023 09:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0DAi/fvriDpV4SuJVh0h/PU/VMxGgNgoDFyZzXtX34WQi6RuN4btaNYrd3sUkNjYf/mYcyoAfghkFlyjBRCNkdygFpHvvXPzxlRKkxqHvciOFXBtQNQRPxd0MLOdomLL1X1cuXD8trIrROYUMn2NqZ3k1hWG4HVJWqU1VqZsvSt0vt5YaB0M6l1zCPAvCiS/0FRmPg8xfc+0kXhO/MyzjQvjgoJWzcg1PnIqde1m6SbLKnkT5evO8cvIuWMB8/q0ZkQkJ9IvX2nsB9eP3Nmnjisg+wRyfYTTpWOJ7OGJbho355+XfjhTGV5L1qPHbO8mWrS+6Vseuhf8fFjmJyCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hywa7xHlVikW9i+OB0PO6UJ6zcSXPrueDuDL8IE6hG8=;
 b=hLr+gLo9iyaZMJ1a8PIaxhON4l7lJslV7WL+MCAXEZJp2oSWIPLqRbj52st1ybLlvCjd6HaZXjs9Nrwi2j56xyYP/d0GAO3TnQq1zinl6nGQ1SNoxy4H0nWUrq3y/xmimNzy2KIQSFew9rdmA1Ulgpp6V/ZuDbBOOhahwPQ+aOzxtpy/Z9diVFqR1PLqT8T/QjXtCmIOI+rf1muglQSCSBZwFoq/Ka6hSkMeyKDvv9tEwzGKxuXWTCRHmKboS5zE3eaUVH9QFbQIsBXpc0y8r7xxa0IUK1lzDWQLAu0A9ZCLz9vmHfqLe5yHrJAlWshjRjJePsUTsAlKdE9RDhxGTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hywa7xHlVikW9i+OB0PO6UJ6zcSXPrueDuDL8IE6hG8=;
 b=XUL6euHVQsHL0wI6pgMwUcsTI2w5WBc0GvzwWMvo7vlIfOqUT3n9N1MsQUkcTVcvVPfIHHfc2vo+2YdFr3Msodm2pLMacyMmtfxTfxTZpIshNG0ZB2r7Oz9/CJbFO/+9RIcL9HoR6QBk8G3IG854Oi7pgsvJtX7Nzx6xz9iPFf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 13 Sep
 2023 16:36:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 16:36:50 +0000
Message-ID: <76dfea89-e386-45e9-851c-8e87f9470c4f@amd.com>
Date:   Wed, 13 Sep 2023 11:36:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        iain@orangesquash.org.uk
References: <20230913040832.114610-1-mario.limonciello@amd.com>
 <20230913040832.114610-3-mario.limonciello@amd.com>
 <20230913042522.GB1359@wunner.de>
 <fd981219-d864-4c46-a348-61f73a9df596@amd.com>
 <20230913143128.GA29059@wunner.de>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230913143128.GA29059@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bde4f6f-a128-46ce-9ac4-08dbb477a15f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgShTSQ8sSri5DeYLozp7AnaAcnN0a5r2j2W5gODCPvC7pjyZuCWE0Wkoi4+yT/9VYSqASZnEVq02mM/V2C2JKVjT9PZvgX29p8QhSX5DZh28ucvOOaw6yaQOCZm2p3lCA7KgWIbke49wHgXKsMvzk4uwKSlB1c1tQwxAkhfq4qkJAjgiwrpeq7NoSCgElrNYVaW0GlJIO4Kmw2WXJZ1XL+aKrYIwfo9KxUU6g9Hkhuww1xGzV7jBi4p9ptXrmH6l/qeuSHizRsjqBv7pf+R/vg9bChuXfVBlSU6lwpqd0vOfL+spKtCL3ifaPFZ/Bnd2Zr2Wo9o6nlAd1neUHHhi7TEB1gifFma5hHeJH4iU+FEkI44EQZF9uW06p/vzqLeRvP2icPZ/6zNBaCrwoMmE/UOaP3vJcZV8pLL8L2skGFnzubxpjWO8HCDLi+3aw5E3L/1jMD/SpIzXe94kprS2y1JJyJM8+cyWeMxu72UAPA0eqioNCH7sf4idDhAGmh+zUX4LXkXqV45E5mAs/W54JhqUjvieBnKc42EyRHxcgQqe7TK1qFG7q8Uk6uOm0RMJZcVgFcTbGE9jmuLD+6ixHFpeL0i3S24dSyNZUwq9DzlmfiXU5GqqETEiYbmSmFzyQ0lT4kaEcaGY9DMcWjeNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199024)(1800799009)(186009)(2616005)(31686004)(44832011)(5660300002)(8936002)(8676002)(4326008)(83380400001)(6486002)(6512007)(26005)(6506007)(53546011)(478600001)(66476007)(316002)(66946007)(6916009)(41300700001)(54906003)(66556008)(86362001)(31696002)(36756003)(2906002)(38100700002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE1mRk0rK2xLUGk2WmhEUEJ6bzBlYTBTMnhMcU5USVAya0xtWkhCb0dMY2g1?=
 =?utf-8?B?aElMVy96aWtUSDh5aGx1TC90TWszVnpEU2Z4SjFLbTZDaTVVYnJFcFR4YWdO?=
 =?utf-8?B?TUtSZG5ZMThtd0l5RXVkSUlVdmQyV1ZXcWp5Y3lQWGt0ejJ2WE4xVENsRGVX?=
 =?utf-8?B?TlU2TmlGVys2VEdYRjY1c1NlWkhSQUsrNWRkaXJRdnZFekJpbWFTeXl6NW1E?=
 =?utf-8?B?Nzc4dDJlQmJXS016dTZBejNhOFg2b3Rza2pmYUxMZmo4cmsxMmhXdWVvYUxP?=
 =?utf-8?B?ZzBCSWZBcUptSmJENTZlNitaOGJsMGJ0c3N2WmhJNTh1ZCtRZGh6ZHFrdFky?=
 =?utf-8?B?S0pIekxndm5ETHV6N0g4ektibFYzQytCZUdiOXZVeHVjRnZONkdZcUxQdXVo?=
 =?utf-8?B?dUN6S0V0Slc4REJxUWQrcGxPZEorQjJJVkVjeVl3VThJTVRRR1l5NzU1YlBs?=
 =?utf-8?B?eUI5Sm51VmoxZ1lkdUFzVHJLaXpnMEVIM20xU2JXbXJrKzJ6UC8xQThOLzZG?=
 =?utf-8?B?Wm1qc0UyZC9zaHlIcTI4bnZpQm9mNHA4emtPRGxGK251c0ZNc3V1MEpiSVB5?=
 =?utf-8?B?elhzRnJOUHNBODVjUU4vYlpPVEo1MW5FNWxLQ0JJRS9xMzdTK1F1Wkxqa2V1?=
 =?utf-8?B?TWRrd3hYQ0xsbjBKZDI3VWxWbG41QXRKa2ZuQlUzeFlhM2w0cWVNNEFrTjRY?=
 =?utf-8?B?dUFGMGFrQXVGSU9BeW5xZFhEeWhPM29Qb0psRzZMTTNpMlNIbnBaN1l3ZkFH?=
 =?utf-8?B?WjVVcDk4QVZNK08vTWJHS3dEUjlYVWh1NnZFWVB4K0lya3l0by9Xakcva3o3?=
 =?utf-8?B?cjZ4ekdYZm1sOHp6dStSMEpvSGZrS01oNzhNd0dMZ0EwMWdsRW9pM1piY2tZ?=
 =?utf-8?B?RjM0cHFaRXNuRDJIYzJhemlWbTByNDZpNHlBUlFkNk43d1hHMFd5Q2JLV2ZD?=
 =?utf-8?B?MGowSURDSEhoOHAvOUVOMzFwYTlCNU0ySXFIRUFsZU1JU1VVZkFNU25TbnZP?=
 =?utf-8?B?aHczdzVGejk0WDhGclpidDNYdGx3VGxsTldpd1dSeDFCZyt3blkzZUYyVGZS?=
 =?utf-8?B?Yk5MODlrQlVkVVhsZk9KWHRodWhuNG10SzZjQTZHa0l3Y2xpaHZtVU9zdDJt?=
 =?utf-8?B?RHZ4ZDJKejlMN0dNMjIwTmxlYlgyeVJrWk0wQWxyOEI3MjI4cElVZTlPZjJw?=
 =?utf-8?B?ZyticEtXUm1KaktGZFU0YzBDNXdLNmFYNWJ1TDZTbkxDWXozYnJSalE1WUEr?=
 =?utf-8?B?MzdPdXBHT0lSQWk5dWZMYm1mdzhsU2RwQkhBYzZZd2d3QnZHSkVvUENXSUQ1?=
 =?utf-8?B?eUNiQjlybFpDUG4vajhxZld0aUpLQkVhek9TRWZZRVhqOVQ0N2xTbGdNRTl6?=
 =?utf-8?B?WXNHVlBBTTk2cE9kN3BVWjZmUW1tRTlQeVZoTXp1all2dzFnSXFFOGVYeTB6?=
 =?utf-8?B?elZtdjdnaUpVY09NSE9qeVpQSWhrOSsreForWnAvdjUvV2RsMFZQQXhFTTJa?=
 =?utf-8?B?ckd2WjNIUDE5c01QdDFSZFJYeFdQaHB2Z0hjcTBFd3ZpY1R3Q3R5OFhGeUhT?=
 =?utf-8?B?VHVucEJ3MkVCQkxnZGJ5czZKTTV6blA0S20vaTYzdWcyRVl4MFVYMUVqZGFE?=
 =?utf-8?B?UFRCUERxdXAwbi9rMTgvMXhlWklDUEN2ZXcza0V1QW93clJjRVRXLzUvdmlF?=
 =?utf-8?B?ckxTUnlMeEN5bnF1RU5EMUpjOXhjMytyd1gwdW5yUjdidzdnMWdicW1LRVJa?=
 =?utf-8?B?TUt6VlBoZWFjMW5la0szTUFiQWs3YU1WWmY3T1N0Q3YrcnpDZ3o2Y0d0eTdi?=
 =?utf-8?B?US9MU0R2UENHclhvUHJKRGU3aElMZWRIeHJya2xrTVIxcmpiMHc4WUxUVXZG?=
 =?utf-8?B?K09RazR0cnVzeWVYWnMvekNCdVJGKzN2TGNCVEVqY1BKc2hadlN4citiNDZs?=
 =?utf-8?B?bjRvMm8yVnFJMU4vNFhqNlR0cCtiNUxaekR2Y21TVHVuREI4T1M1M3dMMlhH?=
 =?utf-8?B?eUYwMElWWHFrV3p6OEF3R3NRK1daNHpURTdyMGRUVkhycmE5RWp5MVltUDAz?=
 =?utf-8?B?Q0l6MHA1aGhWOWh3d3liZjRoRUV0cUdmOGovUHBZYXd2ZjJCdVlwbjFDczlS?=
 =?utf-8?Q?qATraCguSlgzaaEz5PPkDxKJS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bde4f6f-a128-46ce-9ac4-08dbb477a15f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 16:36:50.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zy7mo1ca6SIBbg4di8Y30opLBIncgZ5fKVUkrObCu79KcrHL/gjM9DhL7joXZcojq8IkYPp5SX5D1pb1hncVCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/13/2023 09:31, Lukas Wunner wrote:
> On Tue, Sep 12, 2023 at 11:43:53PM -0500, Mario Limonciello wrote:
>> On 9/12/2023 23:25, Lukas Wunner wrote:
>>> There's already PCI_DEV_FLAGS_NO_D3, would it be possible to just
>>> reuse that instead of adding another codepath for D3 quirks?
>>>
>>
>> The root port can handle D3 (including wakeup) at runtime fine.
>> Issue occurs only during s2idle w/ hardware sleep.
> 
> I see.
> 
> If this only affects system sleep, not runtime PM, what you can do is
> define a DECLARE_PCI_FIXUP_SUSPEND_LATE() which calls pci_d3cold_disable()
> and also define a DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY() which calls
> pci_d3cold_enable().
> 
> And I think you can make those calls conditional on pm_suspend_no_platform()
> to constrain to s2idle.
> 
> User space should still be able to influence runtime PM via the
> d3cold_allowed flag (unless I'm missing something).
> 
> Thanks,
> 
> Lukas

The part you're missing is that D3hot is affected by this issue too, 
otherwise it would be a good proposal.
