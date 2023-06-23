Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F6673AF3B
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 06:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjFWEAZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 00:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjFWEAK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 00:00:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E1C213A;
        Thu, 22 Jun 2023 21:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANAWKk2zrjYt56KzzEu8VFkJYdrcWqp34pzsYqwmSrIW3c22o7SSO+TZ7ZPkFoyPiqbnwqVk9qzNhGA70dX1Jc+jfyeQ5UeamdtVrCED+FHroEjn4lr78mva2f9Si8mhTiEiJ6RCSZjOkuiwEEPrPF3EqzzTj4K9OLfPCOEBVkaFwGUIJkdvd4b672dVBGP3AqOyyaxmEXm7BPdfxVFiRjpdlJB4yOcV86pIvSBV9CNXQngJiUwt2BqGW6UnffeLgLGSNYfYkPgwWUOs9BSdAMUZhzOYHbRVhLgnY1WAC2+5xArs1CC6iL1SWVgkDC8aOUYOuxR6Db9KO/cRIiohHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKoF2A39RMcrERphANb0fJ0JqmvytB8i+IeCTU79KSk=;
 b=APta/FWEIvauPawc9uSPTFpkOXQh3YKP3dnnjuq5OwXfZmVOiIQi00ROtVLbk04JgfUJywc97/zDpsX2mBqBMHyQlaw4gMp2AYaDEmBC13h39pfYDJDcgBr0RPp/xJOoPjPqcfBXcgCfktFrHiJEWRE95lchG0TGdzloNj4gKi8t/YzmhrtG3BpO/sKkXS27cYA3Ir8hHVefZeDG4mlYTY0SwRSNBWeO5ONGK5pjNaFU9MgavO4YUWhZdKte45VuOCdS+LN56DmtX67jEngKVOVVbW2//jE7eytzAsrZBM+maa3yNSe4uZ2V6l5ubFqWmS1hmLSLj+I5YJ8PZEv4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKoF2A39RMcrERphANb0fJ0JqmvytB8i+IeCTU79KSk=;
 b=hNtVV39ta7NvzpaXmUU/b1VtiIIvwS1qdpKLTMxJvDZFokRiZ+NnNFCJVfsOnIeb44HTem0PII7LVxgiKUWJ/my5/KwakwrO6iToH4h6vCeUlW2HIUDfNSpbdj21BArZQCSO/4svSE2quqjMuOCdOWVv2XCQWf5jAlrLZk92Ejw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 04:00:01 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da%5]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 04:00:01 +0000
Message-ID: <8bb20976-97ec-0c5c-adc8-183896de6768@amd.com>
Date:   Fri, 23 Jun 2023 05:59:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/2] PCI: pciehp: Clear the optional capabilities in
 DEVCTL2 on a hot-plug
To:     Lukas Wunner <lukas@wunner.de>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>,
        Jay Cornwall <Jay.Cornwall@amd.com>
References: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230621185152.105320-3-Smita.KoralahalliChannabasappa@amd.com>
 <20230622063105.GA624@wunner.de>
 <d64f8de4-cac1-ccca-33fe-1fda418837e2@amd.com>
 <20230622214247.GB11993@wunner.de>
Content-Language: en-US
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230622214247.GB11993@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::7) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c79b9d0-08f3-47dd-fff4-08db739e517b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MEdZ0yZjy46JNDpcoTJ7Hv5vsWO25+NjbEphAFY/AQbq862xGikKg7yBOXlVNljFp5YNEJ+VsAiOZ7gCYA5cg4A4ANrlEl/cgYeiiBUzJldGEMoo0IVc2M2bGda5wi2opGBxK1XwBfK1DH1dtiFblxqv8wXApqqNaDtA9GBbfB0iC1hexeZ1c70TUKCiZMxNEAWNXddanY2naHZY5VcLcRgoYtLh8/6uxwui9OrXHcNi2SF5YQvMDlcom5uOL8uhMStR+1ugy4gQqy1Rxw7MCCOQ4FwLBhn4OiQp0GMHwRrjy7abO9l3Nshf3Of4elHLwj2Q2q/BAldhOzK/iJG6PjPvPNqsSyW89or8EK8cVA1KgQ6BfwiYuBsiECrsMQJQbbXH4GsycHX8qR8xarT3j/O71SMflnfd6EIZtdHv+8ZrqL62NfXR9PeOlhiPjtFxYWMMb9uBAUm2OEhfg0DYnYEzCUhe7IWvVdDAzi1yJSTJI5UjlDvI5N19e9XarQhziYPKUDMUqBnina+WT0rRJONLdsUCD9z4y5WaQFv6x8A56GZXOsXoI7Ag2rNyTRmP0tX4KHhEhasRozz0V3wLdOAf6OEf+2MF6iKAzGOzmeWOkASHuqFaDJ65GiXyl6gtmgrOprcjW4BKAheBxOjJ9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5112.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(478600001)(31686004)(53546011)(26005)(6512007)(6506007)(41300700001)(38100700002)(2616005)(5660300002)(86362001)(66556008)(4326008)(6636002)(110136005)(44832011)(54906003)(66476007)(66946007)(31696002)(2906002)(6666004)(8676002)(8936002)(6486002)(316002)(186003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1FlMTM4NGpBVGxEUHNwWm5TRytUaS9RYjRXTVJNMDNDOHdYOUFYVFZ0NlV1?=
 =?utf-8?B?cEgxY24yb201MEVWLzl5WEFVbUFmYnFlU3VkZjhJWUpCOXJuQndNYTBxdGow?=
 =?utf-8?B?Rjd0bEJ3OUVKK2RRQmEwTkxiTC92eHF1a29BRk9OMUhUWFNrd1kvQXIzZWUx?=
 =?utf-8?B?RjJkTzcyWkxtMlRJWnpwRGJDUkVTYUVJcVJmOWU3Qnd5V28waEh5dVpIMUQw?=
 =?utf-8?B?VXBlWCt3YW9mT1NlVjB6WVlqL2dtT09CczBWallvQWV5V0xyTGxxUGFnbmQ2?=
 =?utf-8?B?c2FDeFRsdldZVmQ2RVh6UFlxbmVWMVkrZjA5MExHMTA4K1RhZFhMQ0lpKzgx?=
 =?utf-8?B?NHU4dTVlNXA5T2dROU0ySDd0WW5OWmQ5dHhDbnJLeEtCNUNrQUpFekZrcXV3?=
 =?utf-8?B?SDFsUjZOdjdmS1J5VkJEQnJlcGRwSmtjWGZ3TUNRekx6VVI4UzQxQllCbFVx?=
 =?utf-8?B?L2U0L01Bck5FOThQL1h4eWdHY3Z4OVRPaVU5aklzcmJVczZTcGd1eVNkbUU5?=
 =?utf-8?B?dkJ0UERKWkgrL2tCSVYyZ0VIeG50UVc0bVNJU2liVERYSVB1U25LbWJXeThU?=
 =?utf-8?B?MzJiRFNZRllqN2EyS3Q4U3BpamtUMnAvdmxvSDdPVmlRWmU4WGRHZm9ZemFV?=
 =?utf-8?B?QVVSZHlkUFU2U0lVUzFpcWR5OEMwL29GempvSXQ0eUZEb1FHZko1OXI5Z1l2?=
 =?utf-8?B?L0tZZGMwU0pDdVpWL0xaTkwrSzNWcTFLSUNna0R2NGZSb3I1eE45QitneHpr?=
 =?utf-8?B?T0hDSFlzYWZOOUZUS002L255TVd2NU00czB2b1Y4cHY4MndHN1M1bGtGSWJH?=
 =?utf-8?B?bWNhcU01dUI0MS8xR3psUVduVHVYYi9WTzZQa3J4YXJXVHF4VkVpQTRFbEw0?=
 =?utf-8?B?N054U0dVT3hlRTB4bnhHUmVxSEU2NmZYTi9PRkR6SlRURTN3M2ZkS1BJdGwv?=
 =?utf-8?B?Q1NNVERMTGlUamgvU3dZazZuaWovamwvTjNRYkZjRXNZNFBNeUw4VGZPRnF4?=
 =?utf-8?B?MUJDK1dKT3dseFZKei83cTVrUHJEV3hYd2hNd3NaUGJyVXNZQkk3VklBM1Ra?=
 =?utf-8?B?UVRvSk9PRDZDSDlBbWhqMm5Vc0I1TFJoNGsySkVncGFIbEwrSW1lZkVpQUkz?=
 =?utf-8?B?a0hsb1hHVmNpbnVmOGxDSHg1LzNxYkJTTVlOQlpPdTNlRXZmTEZUV1hlclUx?=
 =?utf-8?B?aCtrZmdHdmI5WDZURFFOa1R0MTVleGNFQURBdVE1VkhZQXRVMGtwd3dUelYz?=
 =?utf-8?B?QktFZDdzWWhPQi9QdlBEWW5WaDh1Nm4rb2JucmZnbUVxdnp3c0h3QnRWQXNh?=
 =?utf-8?B?aGJQbDZOa3Qzcm5XbEFmVGZ6eU1EbnZZSC9md01GaHZTZXFuQ1F1UmxCcndp?=
 =?utf-8?B?UUhKWU9yQmcxV0RwdW1JQkJlaW9yYjhWbWl6dVVlU2Qxb1l2eFZmOTBhc3hj?=
 =?utf-8?B?WENYRHV0U3pYOVg5dGtKQ0FyUzdLRDdUMHRpZ0YyUWNqYjlkT1NYdzl5RWti?=
 =?utf-8?B?QWJoekVYZkN0eDVreGhRVDdud3ZqcE4xN3M2RkdjM3pmQlM4c3BpMHp0M2V1?=
 =?utf-8?B?RUMwajhYZ3Q5RktxY3NKOU53VkFHOUlLQ1hIVUpEdGc0N2hsMWxvbVplQnJw?=
 =?utf-8?B?ZXR6OHB6ZFJQeXIzZTJlT0djdnl2bmhzSDBxeHlqRjNjbUhYajlxY1hJSkly?=
 =?utf-8?B?aWwwV1haNHF6djRaWUlGL2hDR2FNbjdvQUhDMUJNcSt2MDZsVkhQWUtZR1R3?=
 =?utf-8?B?Q04vL3NWUlZ2VmxOckdQZ2JNK2t5bDNIR1Z6TWtqR3N4eU1VVk8wSEN1UmFw?=
 =?utf-8?B?TGZkVVNNSU5rblRkVlBTVGptOWw5REluZW5hcDZvUy9qYlhGMmNacVk2S2Vv?=
 =?utf-8?B?eXNFYVlGUFBxTXNqNEREZ2VNTlZrMzVoTnA3azRXMUdNTkIycHg4aXBkWkww?=
 =?utf-8?B?c25lQ0dNZ2R3N3J2MnEwYm5xWlBha2hDRmpzTXZkdnk1U2pEWXhZdEVQYm5T?=
 =?utf-8?B?TjRSeFV2c1FoOWx6SDNMaFFFVlhJa2xTcjNkQ3FCaGhGOVdaWTJyOTFpcUhZ?=
 =?utf-8?B?VmJGMGlDRlUzVGZ2K0dYNnZBZnlFZTlXS1JtNTBvQUZWOGpFY3hCNW5YR3Yr?=
 =?utf-8?Q?HLmKffoycIMgO0YUoCJ55XQA3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c79b9d0-08f3-47dd-fff4-08db739e517b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 04:00:01.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRQdKGwzHt66iDQ5apP4vsnvgp/W2Cr7naqEuQNw4Wt1zUqZFcbPfnalK0qeU5bWzmdb6O79gtwybon/ldxvxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-06-22 23:42, Lukas Wunner wrote:
> [cc += Jay, Felix]
>
> On Thu, Jun 22, 2023 at 02:02:12PM -0700, Smita Koralahalli wrote:
>> Would it be fair to just reuse pci_enable_atomic_ops_to_root() for
>> Atomic_Ops configuration?
> Hm, that's a good question.  I'm not an expert on that corner of
> the PCI core.
>
> But indeed what you could try is amend that function to not only
> *set* PCI_EXP_DEVCTL2_ATOMIC_REQ if it's supported, but to also
> *clear* it if it's not supported.
>
> And you'd have to call pci_enable_atomic_ops_to_root() on enumeration,
> e.g. from pci_init_capabilities().
>
> That should obviate the need to call pci_enable_atomic_ops_to_root()
> from drivers, so you could probably remove the call from all the
> drivers which currently call it (amdgpu, infiniband, mellanox),
> in one separate patch per driver.
>
> An then you could drop the EXPORT clause for pci_enable_atomic_ops_to_root()
> and make it private to the PCI core.
Then our driver would need an alternative way to determine whether 
atomic capabilities are enabled for a device. We currently use the 
return value from pci_enable_atomic_ops_to_root to determine this.

Regards,
   Felix


>
> So that would be 5 patches (enablement/disablement on enumeration,
> amendmend of the 3 drivers, making the call private).
>
> I'm not sure if anyone will cry foul if you do that but if you want
> to give it a try, go for it. :)
>
> I don't now why commit 430a23689dea, which introduced
> pci_enable_atomic_ops_to_root(), chose to add it as a library function
> which is only called from specific drivers, instead of universally
> enabling the feature for all devices.  Adding the commit authors to cc
> so they can chime in.
>
> Thanks,
>
> Lukas
