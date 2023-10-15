Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34D97C9AE2
	for <lists+linux-pci@lfdr.de>; Sun, 15 Oct 2023 20:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjJOSzu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Oct 2023 14:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjJOSzt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Oct 2023 14:55:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAA6B7
        for <linux-pci@vger.kernel.org>; Sun, 15 Oct 2023 11:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CST6pp2nyqirWKhcyfHLEdtCfIn1qipisKhZH/NM7o2IHEmtBMJovDHmbU2S/nFFJkEjw6iLhKKkkgQifODDqIl+ZnYUgzCr0Rad7m/Z1+lb60+TtfAaYsWJdZ8hdzvACRY3LFZqqxyCGalLLqus9dHpNvlJptYSDwS1BiNuGtmQLh1EU6MFWyy0DHoxlRIbtmcnSBUYuLLNBpCk++xwlIqlx2CPjT5lWgAb1CCt1eIqWqWXSEyeAKQUXu7DoWkj+Y8wjDCFFORzMJsZaF6QZ7wLmLLK74T0UkoOFE050riGI18hceJ294ln6mIlikz8gPfVRtWCQFuViBvn8uLeag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G43WjoCrdcR6LTuAUzgLug2JoniUiyvEJreGT0zrUFA=;
 b=FptjP/Fj5bKvytZlgPTfhXQtzjHzf/rCld8/DGQaiiJtFlDVWNUY6kmapGF00JJzQsdffiHS12DUG3WxtcfsjW6vBwoL0fiPOy5AICzDM6IdXxT4LVEjMXsnTyDneiLHlYZGkN2+5pNDipOU2lzwuBjR9lrA5VwnVBEezTbX9q91aTIFOwNOD5FDknym6vCiWZpMECJj8MkF03UuQdHuRAeuJHdDF0zCEOaTnJuY3NhVfZZZpkVibybMib7jjKM3x1PUV5E5Um3S7iWSIKu3g1+8BnCJE2l7bjGIt1ToCIK61iVlAWwIiy4cO3aBeut0uFsgmJlAAVCwE6UzDZfNXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G43WjoCrdcR6LTuAUzgLug2JoniUiyvEJreGT0zrUFA=;
 b=3Fi0ZjJFeLk9rQBdrtvqH/M25/Di/AKImdcVPieisRcoHSiDW2xkZ6J5xRk80qTLILHDvKhDrnnSyHVVkf8D7BevYY1eY7rcUW+QBJM/PuU9ZEVom2zuDS0gHIlcG/NC8sTIViPhld2GV+V7QM9GdIWOcH+MM2qwsK3V7ChlUq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Sun, 15 Oct
 2023 18:55:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6863.043; Sun, 15 Oct 2023
 18:55:41 +0000
Message-ID: <ef8a06e2-dca3-419a-9b36-710f81da1f44@amd.com>
Date:   Sun, 15 Oct 2023 13:55:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 2/4] PCI: Add support for drivers to decide bridge D3
 policy
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <20231009225653.36030-1-mario.limonciello@amd.com>
 <20231009225653.36030-3-mario.limonciello@amd.com>
 <20231014105338.GA3223@wunner.de>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231014105338.GA3223@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:8:55::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ace2a1-f505-4ef8-623f-08dbcdb05419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9avjLeOJDZTRcx2PdRG+w5+LeUMpK2TZFg/pi996l7nfqalYiF4v6WnaD1tlBoQKe3toMae3EXCBA/hTwGX1hND9WjW0AsEz5DYpiub2PkvzDjL+vRqY1jT+zOVyYVdnvk353QD5tdTyHQgXlI+rDImYopzYSJ8A6oLGGnog7pOmRMbhEvx3BzjU3RannLiRdLJMv3EAmZbdY17O3cGNMflK+MkAv7uHVsGJQ7hwXW0jtnruzy9IphbFZY9moYzrrzZti5wQ5HxVxpxyPgmxJJbEcfmL0OP5bxjwpjMUokeDmbqNl7zNbxP9Lm09uFagtGneuKflf+PMtcyyVZIXq+Kgc/qZZa8V+JuG6WXI3d5kM3C4ZvhvrwZlbmk4PLX1QIMxKgYq8jIcOU8fNJMkGj7rg8XXl7XElPhTK3B49M/8uLun+SjBc5RPcMNpspdiTpiLIEDf0N1IgRTxmCIEEPIleY1B5gVV7/6xwEFwuOh92MzxJ161GN0wDKLsC9uMZakkTsygUalh6uGf2shKta59ghEPIboIbrrzYhdkz2DnO9yKenv9v1iF+GLOe1hs2NzVkW3Jtlzv/JOKOuA0o7xMVyWfaknWioQ19ORB70ScJFqwht8j7gFEfmb5OcusayKVl1nARnhtztbrNueQnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6512007)(2616005)(6506007)(6666004)(53546011)(83380400001)(6486002)(44832011)(4326008)(8676002)(5660300002)(2906002)(8936002)(478600001)(41300700001)(316002)(66946007)(6916009)(66476007)(54906003)(66556008)(38100700002)(31696002)(86362001)(26005)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1k3L0V0aXZWSmQwVTNLc2RoVVdSZXBGNkY0TFlnR0pETG5DczRCWDFlbVdn?=
 =?utf-8?B?Q2hPNWJJN0VFOFhqbEVkUzN6cUd2U1g4bFpsNHVIVm14MVE5SEo4TkFTWmFx?=
 =?utf-8?B?VXN3UStZc2RwRk0vc0ZkWG1CWE43b0FRWG9FeWQ1cnZJeUNoZUw0Q1JMQkZS?=
 =?utf-8?B?cTQycytNQjd3RDZLTWFxMWJJNk9sVm5KS2JaVFQ0amN6a2JmMGpBZjlnU3BS?=
 =?utf-8?B?d3Y0L3pqTWg4VS8zT1Vra1lPTDkxOEZPRHVPVUVOYVo1MjdHbVpkdGVtSVZZ?=
 =?utf-8?B?WmRIczJjY0NOelRIMVBkMEhyUGlBSWREUlovTmJ4ajQ0MTAzVWtrTnRNMFdj?=
 =?utf-8?B?TURaZVBCVUpNTjhJdTRIUjdmWFVnZXpqWkkzaFBLbjNCaEZ1Uyt3V044TmJs?=
 =?utf-8?B?QkRjYUlpN05kc3loZ1hFUFd5RjRUcks0WitKY2o5WGo0ejlET25sbGNhUnhl?=
 =?utf-8?B?Vy9wbHowYWt4L1owN3ZwZ2RmcStoVjNFYzBhZXlIUmRBN0cxYVd5WFA3Skww?=
 =?utf-8?B?YkM5WktpYTJ2elJRQUlEZkNJVjQrcG9aa0NBWmk4Q0pya21UQnRXUTVZRzBX?=
 =?utf-8?B?VUpiWVM2amZHUWY3YkFsR0lnSW9CZ2xlTHVOSnVLdXltdXZJU0d0RmNrcjBu?=
 =?utf-8?B?dzBJM3VwUHhLYTNiV25ST1V3L1I3VHFxWGo5VmNMamt6OWRZaS9vT2tKZlVP?=
 =?utf-8?B?SUZkOFhGOGRVNDhGUmxzYzhMY2N0VzQ1WGxVNmVEWE4rcUZzZ1lGRGpxL0dZ?=
 =?utf-8?B?cXFieGVlNE1SQ2ZLSzdrTkd3aVNGWFJOQnI4OHYvR3pPb3o4TjhqUG9oQXd5?=
 =?utf-8?B?V1ZteDgyU09ndkFKa2RUZ3A4MHhOOFRlUWFtbkx2ZERVcGIrcHFMalVFVS9t?=
 =?utf-8?B?anVQbXRpRDUvK0NRVnR1L2UreHNJcWZSVjZzTDdJdDlEeFV1anhFN05HREln?=
 =?utf-8?B?TnFJd0VkY1h2Vng5YlYzUklaamkySDBuWEp3UEhGbjQ0OEpRcG93b2dSNG16?=
 =?utf-8?B?cm5xTmRVTVAzZTQyZTlQQmZ1cEE5QXJiZmd1OHgxMVZrYzB1WE5ubjBpMFlO?=
 =?utf-8?B?REVIQkdtL0hxRVNGSThycEhMSGlhOTJaVk5pWE5HOTI5S3pZcVRIOXRSYkdt?=
 =?utf-8?B?M2NSRUhkVDJ0bnhqV3phTXpRd3piMDdKdXJvakxCb1FsWmMyclJLUkhPdjFO?=
 =?utf-8?B?T1lEZkJhU0lRUmN5OXc4cGs5Q3pMRWQ5OUdSREJsM29sbm1CRmkxVm53RzZn?=
 =?utf-8?B?bUNkMWNzNXhnbG5ESlFPS0lZUjB2TUpxOFZmc2p0VjdBSzRiaXBXRWM2WEZK?=
 =?utf-8?B?amJBQkErb3FBaVFpMy94cWdITzl0Uk43TkRMb1RnY09oSDRmZ2xoU1gwclVY?=
 =?utf-8?B?WjJvUk52Y0lFazR4OXJxV2pNbEJzOS8wb0UydlVJTElkc0Ria0FsbDdFVElk?=
 =?utf-8?B?aWdhelkzdElqc0c5QVc0WlpyTlNELyt3a1B0YktHaE41d1FUMjBNSEdpNjQ5?=
 =?utf-8?B?Sit0R1NkcXFnNk4vYm1Wbk15Ukpac1VEaU9ZVGxXT3FKemJyZVhiUk11dUxT?=
 =?utf-8?B?NjhIaXNQWkpXOXRTenU2cUR0VlhLNWNvZG53K1d0S3ZQUHgvY0JoV1NOcnow?=
 =?utf-8?B?V1AwUzhqQjVoMUhIaVlwbFozRThpV0JZd1BZZzhadUozcjFQb1VqN0hMYkZu?=
 =?utf-8?B?K1JCSUxIZDY4Uld3eENuZDRTZjhLb3FsVWg5em9xMVJoeXZKV3dBQWlqWEtY?=
 =?utf-8?B?T04vWGUrOWR5SzZ1YU1zS0VUeEFRK2hiVlpCK1lRQ0thWVBReVF0K1lnenFI?=
 =?utf-8?B?KzNqbHZVV0FLMSsxRnp1QlNmcDB2cjZ0UjBYOWxrd0pISEFwYVlURUVhYVpz?=
 =?utf-8?B?WURITTBvQWgzYUtiWGc3V1ZqQVNWNk1tWFM2ZmpwbVhSWXlSZE1oSmxNcFFW?=
 =?utf-8?B?R1pQanV4eFgxSkg5S3hDVnIwR1VHbm9ZZ1E2Z3VjWXJjNTBSNFo4b3RIRE1n?=
 =?utf-8?B?YXluSFViQmRuU3B0bkNIK0JPVW8vMlY1SG9GcDcxS01zRmVqbFhydGloak1m?=
 =?utf-8?B?R1NQM256SFNHWmZYTXhHMUxQL2NhS0kxTjlNcnZhUWVTaFFsTldnalRqLzds?=
 =?utf-8?Q?l6VjI13svG/1sjN8J8bHsK43v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ace2a1-f505-4ef8-623f-08dbcdb05419
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 18:55:41.3365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njvVmaSKpe2Iajv1PE5wRykbAnTvEQD6WYp1C0Y0l+u/655m+Iv5zX76bUbdEMUEU12ybH0jh/yJjDbUsEW+0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/14/2023 05:53, Lukas Wunner wrote:
> On Mon, Oct 09, 2023 at 05:56:51PM -0500, Mario Limonciello wrote:
>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> changed pci_bridge_d3_possible() so that any vendor's PCIe ports
>> from modern machines (>=2015) are allowed to be put into D3.
>>
>> This policy change has worked for most machines, but the behavior
>> is improved with `pcie_port_pm=off` on some others.
>>
>> Add support for drivers to register a callback that they can optionally
>> use to decide the policy on supported machines.
> 
> I would assume that drivers can decide the policy already today through
> pci_d3cold_enable() / pci_d3cold_disable().
> 
> Why is this not sufficient and what's the benefit of the more complex
> approach proposed here?
> 

This approach allows multiple drivers to participate.  Realistically 
however I don't know "many" drivers will participate in the first place.

 From our earlier conversations on the quirk thread I think your 
proposal will work as well for this, I'll try it.  Thanks.
