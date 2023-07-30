Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A2C7687C7
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jul 2023 22:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjG3UCp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Jul 2023 16:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG3UCo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Jul 2023 16:02:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78576C6;
        Sun, 30 Jul 2023 13:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNbaysWpLKGVJ/1zZbUOZKohh8LVgIC7tmfsvTHNYvQ88KHXwOUH7TlLa7W480TN5mmdx9G01gaiuXcrc+u0L23IcLGuIMBZqtDo5B5Cpw1gT7CF8cso3TllmfZXFEoqukl3RT5oQp67YnUUapdkAAPf36WfMFbrjlOYzmx07qlXT8n2nHqSzPaH64ek3tS2ZYiLCgwV+V1ZAO/f8JLB6yh/K4qFDF+Q/UAJaCkOQ0wRF7zA4KlRQVghGrP9c/+lGIr1fjhv0EIvoFSZzpe2vZtnicN3/z2MDVn8RuyGA2BRj+5QVgX8TAtkLaUJzDeIiFxhXMZuDSJ7NtIS2aPp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGxoxV2uXWm49e+9oHwb7KZkEaqzipbixEb0upNvKK8=;
 b=JlU1M9N8o7UObeq/C8sEIqo7KK2TwbdgAz8wH0AED71zicDsqPkb58hOWacJfSmXTN/bQnlku1r+7lla/Lnz414KoGH8Tf8kzYRSUozhHOZL5hxquf5+EU4tUbjSdiKibuYUtqp2wK4lq2gxq/yzO+jp2SNR1UZ5HXgxYzpGW33fQHxtOQSLwclSdeVJxJv7jonpp05bO55d1ojYcxFa8Vgb7kjA9R2kP8nuji5xvcRj2bjo+HeGfPYTaL56rl9mJcqZZuMqzNw3vvih6PH+N/dHR+rMGLiERMAT6bEU4vGjZWEFgJf+2/jDMWbJHP4B3fgERdIm78FNFLJkf76mzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGxoxV2uXWm49e+9oHwb7KZkEaqzipbixEb0upNvKK8=;
 b=rs5eg5JEHJlSPdwkZRHHO/IKQlrXMgBFUB3GDYGEaTgkkzXqz6Aw1dGKOqnNYpIO9WUppbHgzWQUxFo5aeQmZOpOoikFvjiX7ZAKNaSJh9lJ64j687YzAxHVCb29xXBhfsDkN5U6+sr45txNHKikjEwaPWIHTBHySHiQHusSzNpG/mQChmHsFElGFN9ik74qiQ6UtidlCEwjvM6L4o3HcTjZ2+6zyPKqbnPnRbrcpKjDW9GSN7LEnN6TwvJLh9YhwgIOkR2cIUhr0w/S1dJOcsmfKV5LkM5cZ0OXGIM1CE54/MU0DfDGa/6IC8oN9ceAkW2uRQgb3ZDj/4hMDUOmUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Sun, 30 Jul
 2023 20:02:40 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b1:f0a0:1b20:1bf5]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b1:f0a0:1b20:1bf5%5]) with mapi id 15.20.6631.039; Sun, 30 Jul 2023
 20:02:39 +0000
Message-ID: <7880aa6e-9fc5-c026-138f-42bef3c48b69@nvidia.com>
Date:   Mon, 31 Jul 2023 01:32:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3] PCI: pciehp: Disable ACS Source Validation during
 hot-remove
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     bhelgaas@google.com, alex.williamson@redhat.com,
        treding@nvidia.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        vsethi@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
        sagar.tv@gmail.com
References: <20230111190533.29979-1-vidyas@nvidia.com>
 <20230730191519.3124390-1-vidyas@nvidia.com>
 <20230730194026.GA19962@wunner.de>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20230730194026.GA19962@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::19) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d6f1a5-415b-4863-eb66-08db9137ed21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z98yOJmZA4OhZGXw+9skVV5+v15royormGRS8v+J6Bx360+w4/OpK4thlfh/vE8cKVhxMBoia8S3jyB//QQvzfXU9UPq88YFJFPkJE98jinQmXz+zHCsezkfoQfWMFalKXdKe4yAsMgUOSxav/w9O4MUePfTHsUSNc89KvQnbRsFTxel+2/fPH5AMFvB4WDpamYC8qP2GJKcuZZFxJFiIpqiutjQPu2y4JWIYYnzpdoI5t76DraJvqyV2wtY9P/GWTSryaF91Fg+RXqz2eg5QTJgDcWLfKtrGdNjO9Qrl84A3p+pHdldJx6vlxh7grJLTm5YTQJJGUi/BuWvTtKyXQTTlIHOnYibuy02DSC9TR1+D2cfOlXJR8x7ON4iXC/HMpWPj+iGxEvKzxM+F9MOzw9RSwZPP/OVwT9n0LP8Y/HL6UexxrEtWv/GGVBq6ShocxxyMyuPmZWc2cDLY7vncYz/652bLxK1FLCJpF8KhYeQCwghFLeo5vfaAYvBVB4vPhcZoprCBSRLkNtmhtXe7oF7yS3MO5qbgpqaVBSOnGF/QjEI/DcPGzJvUKwyk4DQACn3VVzyXEGUP9LzJrvWsrBgu6e1UTI5KyNc0+c+dnT83tztH6bGMPFBJ3a8AewFqIUS4fFfbYv645S61X/azg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(38100700002)(36756003)(86362001)(31696002)(6512007)(478600001)(6666004)(6486002)(2616005)(53546011)(186003)(6506007)(26005)(8676002)(8936002)(5660300002)(6916009)(4326008)(66946007)(66556008)(66476007)(2906002)(31686004)(41300700001)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG1EMzEzSno3TW13bkhYTktvZUJ0akNzSm50SUlKYldHMnBNNkNhcGNXVFdi?=
 =?utf-8?B?QWVkQWdrZ01xZG1NMnczQWMzK3laald0RU5DeXZLbldvTFM1SjY3QzAyd21J?=
 =?utf-8?B?SUpTVnF4ZFBEN1IyeStnVmZhUjVDSnVsa05UUWdSMjFGbVlYckZ4NStjLzB0?=
 =?utf-8?B?QkJ3U0wzNjl2enNTL2RaaXEzdEYxYVJNeDNzK1hhM3dpektlN245ZHl5c1Q4?=
 =?utf-8?B?VVpRZFlGVWVxRDNmU1dnU09aaWtUQ1c4V01pL0hTYzVBeG9YVUtkNkVFa3A2?=
 =?utf-8?B?VVkvU3BkR3RPTjlFeVpHcURDWC9YVlI5bW9GVytLcjhsbEFFNzZJZGVmUFY4?=
 =?utf-8?B?cWNkc0kxTmpTcWpvVWtpb1BoaXdrdi9tdjEwTjZ0aU1rcnhUcW9ha1R2a3pP?=
 =?utf-8?B?WFJyYjgreXFRdk0xK1BUZTFKUHBjQVlLS0YzeFRWMHhkcjEvT2hrRnlFSnMv?=
 =?utf-8?B?cUU0ZXd2bGFpSVlsVXVGUU52VDUrRDYrZTdnaXdNUTU2TTBQeXBlRHRicnYy?=
 =?utf-8?B?NXZlZk55M2NPRVAxaTNRQzliaHZtWUd2MDNSRlRZYXgvTHZxYUhxbWFmVG9w?=
 =?utf-8?B?eUo3Qk9la0hiODIzUTJUS053RkoweTkyZW93WmRaa0QyOXVRVzdQZlY4eXF4?=
 =?utf-8?B?TzFwOUNTUW9OT21TZUR6LzVESmZ2eEpmeDhVV1NrNEg4dmh5alZyVGx4V2R4?=
 =?utf-8?B?SVMwcVltaHh3c25vUmNJYnV4VUFwUTdPMnRWaVorT1QyU0hHK0ZuYjhVWmJR?=
 =?utf-8?B?TnpkZHpOSlA1OFRuMkh3VStRemRLU0hQRWYzT0xvWlRUNWRPS3lPT3V1UEY0?=
 =?utf-8?B?QnVET3A3K3RPelhhRkVyUWFLbkQwVVRiTUkzcFdzR005UXJYZHhQSE1aN3I5?=
 =?utf-8?B?Wmc5eVJFdDEzdnZKeGlHd0d3MmRrRUluTDNHZ3NJaVFvbE04cXpsMTR6bjFB?=
 =?utf-8?B?bExMTFNRUGU5elh5RjdkQ3BmK0U2bXBYSzNFcWtBRXdNR204cEV1MVhwSC93?=
 =?utf-8?B?TEJnZVJBcUZHL1MxQ2hWcEpvaXRKZnowZ082NW9uL0lTb3VXbEtpamJjUnBF?=
 =?utf-8?B?VktvbEVickdacDI3bEpTdUJPc2JaSlhDL2JuNkxTZVZZSEVNREtmN0RlSHds?=
 =?utf-8?B?dEpXL0tLb1pXU1lZZnVzTHJmazd1TUdXejlSSGFIelZZUm56QXh4Ymdvd1Fk?=
 =?utf-8?B?N2svNU9mRjMwTVk3Y25WVEx5ZjRLd1BhWDdXazBQd09zdjk5QjdEUFpTVHBH?=
 =?utf-8?B?ekVpeE5wTHk3bXE5SUpMcURsbkNxKzJwNlpHZjVRQkdPQUVmOUxqKzNTUS9L?=
 =?utf-8?B?UGhOWHdOTlQ0MzJjOGpMeUxWVFNud0JnS1dSUXREd2VxMGY4RTlrY0tBRnZT?=
 =?utf-8?B?Mng1SE9ERUtjYVpZakI0U3VYK3NGeTFVdFIwV25xdExucWxVTjVVbXN1MmxS?=
 =?utf-8?B?RWw3NnluRDRER0JhdHJmZHRQY0NocHZsNElrV3hQS29BU1lDTTQrYTdIOFFY?=
 =?utf-8?B?OEhwSXVObHp4YXllWmQxdDBnZ05UbE9vZTFhMEFDa3V2b0I3WW8vUEF4YTA5?=
 =?utf-8?B?cDZUdjdTUENNOCtNRDJseTZCTVBtTHg3Z2s1NGozM0V6OEZ2Z3VSbVVXcmxl?=
 =?utf-8?B?dEZIcG8xNk9PbStYMEkwM1E2Tk1wUkZyR29pMkVRcWVrU044TFZtVDFuSmt4?=
 =?utf-8?B?ak42OUZYU1RkZlJNUHpUMWFJejAyWWw0SjZWY0tWeGlER1lYNjk2Y2t3VzNG?=
 =?utf-8?B?SkNWMEZTT2lpNDlGSlRoak1LWk03bUZDNGN6Wlk0bTFLWFl4N3dpNFd2UGdp?=
 =?utf-8?B?azc1SGVyVWRCNWp3SUVPS2o4SEpJMktMRHdrRHZXQys3VytBNjZ0T2VOQUh5?=
 =?utf-8?B?OHJ5ODI4cUlQdmlKTFEwNkkybnBMMjNGV1k4WE42SzkwdDM2MktFdU5OTVNL?=
 =?utf-8?B?UVprR3lnNWhLMDhiNUpDTHY1TU9EazF5QzhqYVZrQnFuVVV4cGJEcHNwQTRy?=
 =?utf-8?B?eWpzeEFuMFRBckt1Qi96L2V0K3Z1MnlGNHczSEpIZ1Ewc1laZWwzUVNvMzZW?=
 =?utf-8?B?R3VVUUpsd3Y2MlFTWnRLRkZxaU43YWt6Vk5EbCtGbkF3ekhUNUptVkxQbUhH?=
 =?utf-8?Q?EeJlAiALYGSqXL2U16/B2h60M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d6f1a5-415b-4863-eb66-08db9137ed21
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 20:02:39.4393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niVvwFk+zAIC6qNNWbx31m0ITcG3ksBzK01PSkCkLWPMv+RtRf47VPogB0/qJ7fyHMPAN3ViXrEicLZZDycpEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Lukas for the quick review.
I commented inline for the queries/concerns raised.

On 7/31/2023 1:10 AM, Lukas Wunner wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Jul 31, 2023 at 12:45:19AM +0530, Vidya Sagar wrote:
>> PCIe 6.0, 6.12.1.1 specifies that downstream devices are permitted to
>> send upstream messages before they have been assigned a bus number and
>> such messages have a Requester ID with Bus number set to 00h.
>> If the Downstream port has ACS Source Validation enabled, these messages
>> will be detected as ACS violation error.
>>
>> Hence, disable ACS Source Validation in the bridge device during
>> hot-remove operation and re-enable it after enumeration of the
>> downstream hierarchy but before binding the respective device drivers.
> 
> What are these messages that are sent before assignment of a bus number?
One example is the DRS (Device Readiness Status) message.

> 
> What's the user-visible issue that occurs when they're blocked?
I'm not sure about the issue one can observe when they are blocked, but, 
we have seen one issue when they are not blocked. When an endpoint sends 
a DRS message and an ACS violation is raised for it, the system can 
trigger DPC (Downstream Port Containment) if it is configured to do so 
for ACS violations. Once the DPC is released after handling it, system 
would go for link-up again, which results in root port receiving DRS 
once again from the endpoint and the cycle continues.

> 
> Doesn't disabling Source Validation introduce a security hole because the
> device may spoof messages before Source Validation is re-enabled?
Agree, but this concern is already/has always been  there during boot 
scenario where the link-up happens first and the ACS is enabled at a 
later point and endpoint can spoof messages in between if it wishes so.

> 
> PCIe r6.1 sec 6.12.1.1 does indeed point out that the downstream device
> is *permitted* to send these messages but the Implementation Note
> does *not* prescribe that Source Validation shall be disabled to let them
> through.  It merely points out that the messages may be filtered if
> Source Validation is enabled.
Could you please elaborate on the filtering part. Do you expect this to 
be implemented in the hardware or software?

> 
> Thanks,
> 
> Lukas
