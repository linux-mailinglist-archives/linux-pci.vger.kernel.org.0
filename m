Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46B27B5827
	for <lists+linux-pci@lfdr.de>; Mon,  2 Oct 2023 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbjJBQ1q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Oct 2023 12:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjJBQ1p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Oct 2023 12:27:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7953D9D
        for <linux-pci@vger.kernel.org>; Mon,  2 Oct 2023 09:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOPvcbFX48UoC6wTKMpRWKfwataYpQUXTq6wOvVM0tQxYG0GiAWogHemW74ohyRYcuWZheyiVJQnwPEFuPj7jdztiC1yLYBphdqjFJM39uf4q4OlMscyUX+3BD/dy5i8GNsrvTp04mnobJz7W0WbzCzLMbY2aVRJbhWswhxRqFN5XWCf9ALa/kgBdElTOD0sbUrgRIXfD/kDL9F+XQ8iiIK05qxx+EBLVoH1pfrGgRm6d/i70lcXa33cEhRexqEdcjie96UBZr0npdQvOcgGYAXXqaUFcBLdFuwsbwROPbBCGBefQbGrgMft2XOw9lagvv5FKX8jztpaWSRgEPWd5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TplDaRu7rG3DTDVBj6ZBwAu4JS/HpVkXBaePZ9rX7Yk=;
 b=VYFbvqY+ykx0V4S1WPzcrN55umKE6t/oSrIwCUJEtQ1fhAkHzJgvQPCTKWLV+X9k8CiijYEs5pegnRCeQi8FKQ8KXydPhxg4K2Rk5yV+c1m0F3VxQ6q4Chl9D9+biNwg0OSnpP47KFC6i2Zm0F/sAwjTY5Mf75AOTO+JgzqddSh8beUFJhSBfPOttPWGvf7OC7ENE4pjH85k4wOILd1ROko5IkRTPJaMu3SJ2GuzmGdWtnusypuyaMemfwjj4to8Erx2P8EEIRNK3m8VUFMNEFDcpDLVlKTvD8SbHeS6jMK3mACHc2Ssc9UBvcOyGxVCOYaU0GWwV3kZXnMMq51qeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TplDaRu7rG3DTDVBj6ZBwAu4JS/HpVkXBaePZ9rX7Yk=;
 b=N745n9ldsxpysSqoP2IYTPLd/9VRUuC4gkMHUgEjuwyJ6ipwLUSRljygBf+08qSVtXqjUec+FqEefX9ZRJhMBKWaShfbRi6L4dAlOOijxTOBSgMloJPbO+XS7z0ewONkUlFJv9C4aiFgwtJ3iVyoqJVKvk5voUDUfA0QaKgnaN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 2 Oct
 2023 16:27:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 16:27:38 +0000
Message-ID: <3b151040-1345-4cd5-ab94-a6ef89762ed9@amd.com>
Date:   Mon, 2 Oct 2023 11:27:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20230920032724.71083-1-mario.limonciello@amd.com>
 <20230920032724.71083-3-mario.limonciello@amd.com>
 <20230930092423.GA6605@wunner.de>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230930092423.GA6605@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0049.namprd05.prod.outlook.com
 (2603:10b6:803:41::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: a34eff4d-fdc2-49e3-d6c5-08dbc3647e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oA2qI+k9hyNGAg7Lh8zapXzTh74EJ4tf3V1AxCB7uPBfCOK9vyzeo+X1oLT92x+kT1r3HO3Y1+Auk+AvHo/Ax1aKgg7FJ0R49bP5buNrwur6KqTS/IPYIueVeFenBp3GmM+L7AcNGOzXPQZzgWNCnIelAmCOnp/Ed5ZAeH81AmPDBm/7ZAzksY4RoGfVix8wBoneGeEDuW/PRowGFkUc8uxEdzlSJ8mFfJ4pyFH/8QA0q71GDrBslgD9WYe9Ii4mjbsIlvlhp6gmkAqMjshqDKQ75r71PFapygPmr3DkAfTSJL2mbYvOJMm9zANPieTRaEgA19Lz+o4Xbm+d5dPWyx3GSd5Ojy4dkZ0Vbh3bJ2Qp89NbQwCX8XIyaVwYGmwvt6P+P1tdMw4x3oGCnuVXTVXQZoNakrEtpDTTEXevXRroiAraYq3kZdeSEDJIrSvkPaK5+Hh9htYitGCclrbr2XoK2wunEgdO9dzVVsyy3U4ePYC9+kjpS4xvpiUAhXNpe7q7UevxASs7q3FVqfOPlVU/tn4GAiOCRUJjLPRP89KPD1hB3RI1Uvrh0pPq+pVcbNVEQPjcAkA8rzTNVHKd+7E+m0aqZL0aT99A+AaZVdtwe8nUo/anqBPicvh44HGZO55SOT37Qaq3AGF5UrMvZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(31686004)(6512007)(6506007)(6486002)(53546011)(2616005)(478600001)(6666004)(36756003)(38100700002)(31696002)(86362001)(26005)(2906002)(83380400001)(66476007)(8936002)(316002)(8676002)(41300700001)(66946007)(44832011)(66556008)(5660300002)(4326008)(54906003)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0dJWHhUNDhvUEdLZEVFZGk4V2ptUk5ra3BINFRtQTk1S0MxWTRlcGE5Q0RW?=
 =?utf-8?B?RHZ4VzltcExQQ1R1aHF0dlFHTWhNS1YvSmRhd2FsZnJGTWQ1S2hLejdrVEdD?=
 =?utf-8?B?cEYvd2c4dmVxUHN6WWNxbVlWem9XUTgzeEdSeWdoWDRGeWxOSWwxV0t6ZUFJ?=
 =?utf-8?B?UkVYbUVyRVRDVUZJZEFDRDVIcVRHRGxOcnB5RllMdVgwNGpzdW0ra1dtQnJm?=
 =?utf-8?B?TDZQaXlwa3pMNU5oUU94R0tzSkZEZXhoaWQvOFg3cmgxQmh4ZXlyM3lPamJa?=
 =?utf-8?B?U1RxS0lyTy9WV0NoeDdQNWJSaDVHYUNSR2tNT2VrVTZ5bkplV3UvWW5mZ3p0?=
 =?utf-8?B?dkZhS3RkMGpsQmh4WFVVRWl1U2NVL0hhSkZZbXBHRkZPOFcyRTNQZ2pRVWFC?=
 =?utf-8?B?ZUUrRytBa3hoclMvNklxWVZ3RkNPSEdSLzVKeDBSUWZZMVJhYkdEVkM0dmor?=
 =?utf-8?B?cHN3MUdPTmNINHJHeEx5MHpIUG9jcEE0ZXBlMVBUbkRTeERjcEFIRUlVL3pZ?=
 =?utf-8?B?dkkwaVI1MzZXSTgrWVhaemNrejIvdW5zUTJqa2g5cHFOUTVVNFo2QUFLV3NH?=
 =?utf-8?B?RDN2VkYyZ1pNUDBGZkZ2YU0zNW14M3dHVUxaOHJmSW9ZTHdlZFRCQTE2cFZN?=
 =?utf-8?B?QU90Q2VtbmZZVjgweUhZK3lRakJYcW91VDFhOGwvNlk4blRPVWhGY0dBRjkw?=
 =?utf-8?B?K0FMU1pqczR0c1ZSa2JwNldhdWh5Q0ZYREt2WFdLa2dVcU0yTGxNTys1WnBV?=
 =?utf-8?B?OFVhUmpDVHBNTFBML3pRckV1UHNCMEpPUUtoNVN0NGlVcW1lbmdacmlyeFdI?=
 =?utf-8?B?dzRlVDhkY0d3Vlk1YzJCZG9uZ0ZGZXUrMXdHMTRERFovdjRtN0d3alFjM1Y5?=
 =?utf-8?B?WWdBYVB3dHFqWjJGdFo0dWFBKzA5LzBYaDJWeUV2S0lIcTFoVEFxaE1naUVQ?=
 =?utf-8?B?K0owVzFGOHE2Mm9IcmlDMnlVK0ZqY3dzeWN4VkFBaWVKVWgzbmtPREZidUt1?=
 =?utf-8?B?ZVRYb0hsUG9rYkZKWVAvZGdBNTR1NG9CSTlHNkVtbzYwSkRwcEFROGJFYm5x?=
 =?utf-8?B?VCs2N1BBaXhxOCtxc0MzYVNmWFdsL1U5KzN5V2xIZWM0ejZ0eHlwUTRTZEdr?=
 =?utf-8?B?SkZtRXoxRmdGdWl3QW9GQy9LZ0psNzkrbENlUVprVEVBRVhBYVk2akdhdU9T?=
 =?utf-8?B?eThOTkIrd2xHNy9xTkpVK3M4N0NZQVd0eWhnYStCMkEvMktWNFNLMjBvd2Z6?=
 =?utf-8?B?dmFxVmROdVpaaENGS3QxeElUTFQ5ZHVTclJ0QTJ5VXpITkNFaUVXbkY3NjNn?=
 =?utf-8?B?L01vRGZBVGJyZ2ZXUVMwZHduMFU4ZVZzc3htVDRjdEdxYXZ2aWwrQ2JIc0NL?=
 =?utf-8?B?S2hpUk9oK2ZmMVhobThWNi9naFVGZnBuS3NtbHQ2NFVDaHN3M2M2VTFISDR0?=
 =?utf-8?B?Q1JFVUNxNnZlUW02aWpST2s2QU9PdmdKOG81b2t1SENmcktJb1ppMlV6ZFpR?=
 =?utf-8?B?TlZKTHJIeDZSdjRBazRkS2l5TVN2NWhsOTJaOU4xRWlzZGVXN1ByRUJkem5J?=
 =?utf-8?B?ZnRNbVJYS3FWRkovWWE1WG44cksraTBNTUdPcjJhK0xnQWZaUDFUNXVCODgz?=
 =?utf-8?B?bkR3cGlKWmE3LzFyN3lIZmZCYm4wVWo1Ujl2d090YzRTbVMrMkFBanUxTzNH?=
 =?utf-8?B?SFl0V2pNU2h3aEt1akl3NWFyYm5QTk1GMExCS01YNTdVOTJIa3gxaGt4ZjZZ?=
 =?utf-8?B?NEpyYkJLeHhWNTNCeklJSTYzZWNLeCt5c3BIVFpKN1dESVkwR1VBUWdoQjNy?=
 =?utf-8?B?bFVQMHdyTGlPVXRXZ2VnZkdWZm5Ea1o4Wmk0d2xyOEt2aXFQVlBXKzhZd3Rm?=
 =?utf-8?B?ZDVScDB6NjVCOGdhTDZlVHE3Rk44aFR2bko5dWFZa0VyR3BwUGVldk1mWVFa?=
 =?utf-8?B?UWhCakZNR2hzMlBjME04MW8raHBGRlBDWFZZRjZCVjNoUE9xN0twcS9LT3ZK?=
 =?utf-8?B?dTBpSkd1TDNmWUpLNnJIVHZhb01DWmlkUDJGcDNlaWlxNkNRUk1MVzFZNUc2?=
 =?utf-8?B?Zm5lbndZU1cyVDlhZmZxUUk0QzJCbVRMVzZhNHJjZDVRMThxTEZuZDhRWVhH?=
 =?utf-8?Q?KZA0duggAWwJVpActgrTzYJPx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34eff4d-fdc2-49e3-d6c5-08dbc3647e13
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 16:27:38.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMXZ3PBS+b5gIoNB1Kx63z86hIK/PXIWS5I4kBDJbOaJ9bNbK9x4pOmZlhg0ORCxWoamAsjJ4S+oNLykIiafUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/30/2023 04:24, Lukas Wunner wrote:
> On Tue, Sep 19, 2023 at 10:27:24PM -0500, Mario Limonciello wrote:
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
> [...]
>> + * When AMD PCIe root ports with AMD USB4 controllers attached to them are put
>> + * into D3hot or D3cold downstream USB devices may fail to wakeup the system
>> + * from suspend to idle.  This manifests as a missing wakeup interrupt.
>> + *
>> + * Prevent the associated root port from using PME to wake from D3hot or
>> + * D3cold power states during suspend.
>> + * This will effectively put the root port into D0 power state over suspend.
> 
> IIUC, the quirk matches for a Root Port, then searches for a
> USB controller below the Root Port, and if found, searches for the
> Root Port above again to clear or reinstate the PME bits.
> 
> That seems like a roundabout way of doing things.  Have you
> considered matching for the USB controller's Device ID in the quirk,
> then checking whether the Root Port above has the Device ID which
> is known to be broken?
> 

Yeah; this suggestion works.  It's 8 quirks instead of 4, but it's much 
cleaner and easier to follow.  I will send a v21 with this later on.

> Also, since pci_d3cold_enable() / pci_d3cold_disable() are now fixed
> (can no longer be interfered with from user space), you might want to
> consider using them alternatively to clearing PME bits.  They don't
> require access to config space.
> 

I still don't like that userspace can potentially influence state 
selection policy.  Separate from this quirk I'm going to send another 
patch for that.


