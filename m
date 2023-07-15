Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56197545AB
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jul 2023 02:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjGOAqn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 20:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOAqn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 20:46:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32682D51;
        Fri, 14 Jul 2023 17:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CstvVxjatYTDi8ewkDDld2MtACgxu1IJVpfv8WkREgbMsyYvUaS/oJVnvYh1X9FdEl7gKWvPUu6EFqezM3LIlORVSQXHt9Bplh92EHV0As9q88QgCJv/09kMXuj6f6jxxmPt03ocqJb0XidwS7qC7b93zYl3d/9LloZZw3sa0plscWcC7OQaEcQCpNM03+wzl0N0Zv651NZ67HL8JZnZxqxG1iy0KkOLCzSfTphzeJdZMnsjN8ZVpkONE1X0KGM3zRiItsUk9VHJ3gAKOKa8FFN+p75PkquDZ1IMmWsfkD2929N9rj5NlYZKWi/sLXXXWYp/5hxHa3BynFqv1a9B+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNKZmNHWS117SpTRpYMD89dPlN9DL+w5ILiePP2niW8=;
 b=j79M2GYh9BIcm+iNiLX1scJme4Y660I6aHAxF8avPs5nfcpcL0g7L/Zv8+gWl5e44Dg/uDYAIMUUQYDY2oOVOBd5/gry1DLdZ5WXLNkkx6U4R5wLe8+UO+mPYUWd8FQDeLOotaDZ+w8IRd1WI9h1CgMTnMpTpNsPSJBmoIWkCyeKVOgmzHUz2DHyhOjVL2pgCKoULi82MS6Wr+xbV5G+9HAnvATlUL02YpW9RTiyIcS8OsNELGCyIf2tfKlVcmQ736gIQnr6QZU807sIMUjDRN+1uXzOKrYz+bKfjBRvosXmh2sYo+exVX1dD5cKNik1QbxRCaTrCJqwkpTDj5SfyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNKZmNHWS117SpTRpYMD89dPlN9DL+w5ILiePP2niW8=;
 b=Biz5CCkVyGK8yx+DE0LdNOavYUw70mJjdXcmAS4wvJK7nhZU2OSuWwzf5yTV5R/GWCZsfYo3kCMviRpITwRVfOJDHC5ldjmbmQHIosZl/4DngmPB0rhyz3HwVDVlWl/t0Jq4bvS4vZ/KNX6waIdnbkW1ClqUFdj+hXLu+1grKCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Sat, 15 Jul
 2023 00:46:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf%4]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 00:46:37 +0000
Message-ID: <37b005d5-68fb-f8dd-67e2-c953d677fca2@amd.com>
Date:   Fri, 14 Jul 2023 19:46:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] PCI: Don't put non-power manageable PCIe root
 ports into D3
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230711221427.GA250962@bhelgaas>
 <b82a50eb-8182-84ca-5b24-dbe8870fa871@amd.com>
 <CAJZ5v0i6PviqW7u3i8hmvSCvR_VHqP-mWRy3Da8Ev_1vi9qBQA@mail.gmail.com>
 <a309e3fe-b1f9-e269-cb97-8af87c8d483b@amd.com>
 <CAJZ5v0jvxrDMR6YHFpYZ4yYpp82-3TtrH==SMRFtUMJsv7=i=g@mail.gmail.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0jvxrDMR6YHFpYZ4yYpp82-3TtrH==SMRFtUMJsv7=i=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0183.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b35f79d-9431-45cb-54f4-08db84ccf188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EROSiJP0Es5oKGHrWYARrnfyLFsAuV5SaArDM+QmcxlG6/Ag55pZEnZ4k2XEd0T0bnEADkQ8LoDdgG4WNoabxN2ynfRM/TM1HG3QtYViCKQuaU/OnDmBCej2Rr9N41v9U7z7pgN3WqsJdiHr+5JMl9WrQeRETRB6z64zWm1A04vkC53Im1W4spen1Z5KUv589fEOIGDO7nMy3S4ejuL4N5qcZ1urEly9I7Uzul83c5nYnjYjsjG5vAAgPLOoxsmre90Xk0ETgy9g9MbJoHK6GbVSogzRavBCs3J/vnUvFH991vZntgk4fpbB4PxauxEfyCYUGJJ8e0BECTKxGygfCwn0SdzFrxB8/WWeHB5IhCAVCI7/Ws1B4lOEghKDkVzK77zwWBxYB3oeLasTgIQf2jAHjlknka4PorvsseX/laItA8j+qxPg4tht2R4+Gv4F3AIzXmvwl4CONvM8pnfsGQ66S/XEutBAjIJpPV2Frr+UKIeIM4XVPu61LquK+vu6SjC7TWKR2jp7V6sEytoOcUlQIPkcBXlyGvhYb8sQFVH3HZvBTYrrI/1X229sMn3Fq7hJ9kkNsKWBgeS/4cw3H3GgwCVykRoKp3w9GknrFJColdt+ZLn5G9I1C04kaQegGLUdO7KmNHxuh0tr1PqWpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(6512007)(6486002)(6666004)(83380400001)(186003)(2616005)(38100700002)(36756003)(31696002)(86362001)(6506007)(26005)(53546011)(66556008)(66476007)(4326008)(66946007)(7416002)(54906003)(41300700001)(6916009)(31686004)(5660300002)(316002)(8936002)(8676002)(2906002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDJpL0VlaVgyWmRSVFcyeUJaMGNZbDNDemtXeC9tRVlEZlRZU0Z6ZmFjZlhX?=
 =?utf-8?B?d0IrWEhxV3ovazBKYTl1KzdQUDh4TzZZOVhNVTF2d04zY3Z2WUJyZlo0RFYr?=
 =?utf-8?B?Y0VqcXYzVWNQWGl4ZVkxV1Z1cy9IREY4b0JCcXNJUmpHZFBwNC9tamcvRHJx?=
 =?utf-8?B?ZGVVOTJrRjIydSt5MzVjczZmY2ZyeEdQbWZzVFBJWGR1eVAvZkRjdkxrOHVs?=
 =?utf-8?B?R3FlUGRCN0d1eWtNUExsK2xPd2dCdlkrVlRFb25RRE1FaXJvSEQ3eHFTWk8v?=
 =?utf-8?B?cWVkZzJnYlNHWmlLNklmR2hLY0huZnpzcVd0aEtyK1FPck03cTdQbXQ4Yk9q?=
 =?utf-8?B?U2JOV2tsNUxGdUxHcnlTUzhuNjNuTHNBR3hlZ3VJR04xdVV0bUdmcUs2anZk?=
 =?utf-8?B?cVRpSFN5U3cvQjVQSEkwWFJWNEFPMXZmcTR4VkVaQTgvaFlrd0tEUUhYRlc5?=
 =?utf-8?B?QXBMU1lmbFp4WUMxQzhXaDZGdkVWdWRwZ1pmTklWTTRJS0xnVWVtNk00M3Ro?=
 =?utf-8?B?cmRLSWV5YUp1TjRUbXZZcWRkM0xmMXI4NEZpS3ZrbzBDa0o2dTlmelRHQ1VM?=
 =?utf-8?B?cy85eG92VkRKM3lpMjBZTjUrQ3pSaFIvNFk5dlhUNXBzbXI1dVZ6Umd0cWYv?=
 =?utf-8?B?ekZJUXJKQnc1dnJFL29VVHUrU2NpT1VSTkZneUV1d3ZyTkl5dCtsRmgzOFhV?=
 =?utf-8?B?OFcxQUoxazk1MlhPcktPRk9JS00yNDZHTjUrUkt0REdDVVIyRTN6TndVbHlr?=
 =?utf-8?B?bnYvUzlhMGE0QXJCQVQxYUtsdDV4MFZzZU80WGxsYWFzekliaGFraVJTeW5M?=
 =?utf-8?B?dEE0VlF3ZDdoUlVNaW90ZDBzU1NOV05Xejg5ZUxhM2NybndxRGJzZ1UzeTZm?=
 =?utf-8?B?ZkNPZDd0RGZ2V2lrNlphbnRlQkVrV09YejBNc2NYRnQrUTFBUnRaK1h2WndN?=
 =?utf-8?B?RlJQVGlsVkp3dVVQZTJkb3FxRnhOTUdTKytUcG55TlpsYU5sOUpjQk4xSU45?=
 =?utf-8?B?QXBVRDRVZUErZlZpbE5udDMyc3hGa2hEYVd0QXNiaERrcXZTUkNjUkFnaGNv?=
 =?utf-8?B?dlJOWFZDZ3FLOVR2NGFMaEV2V2J6RjlsblFGb0dpcndRdzBDMU5ra3BPWU9j?=
 =?utf-8?B?OHJSS3JrM3VXSUd5RUFPenVpL0hQakVBZDR1U01DKytLYjN6YnNJSUlCWFlT?=
 =?utf-8?B?QndwNUF0QlVoVDJCUVNxT2pueW90WWdndFhMNDhhUFBRUEMvdUFia0dCQm4x?=
 =?utf-8?B?V0FDaUU3c3NDVW9MVnAxOWJnVndVZ2twRmtMNURpRCtZMHd0a09mKzdUa1lJ?=
 =?utf-8?B?bWNBTnFKcHJmakljaHI0SzNhR0Y4b051VStZM1hlZXROUzJoUnFWbDBEWVZq?=
 =?utf-8?B?U2JBcmFORDRJZmxCaVl4cnpETVhGQjlTZmgzL2lwU05jdFh3S0dKUmQ3YUh5?=
 =?utf-8?B?OEhzYXhTcklwR0tmcjVNYkI4SFNnd0tRSUdJN2ZaaFhDaURxSHhVY0hIQy9k?=
 =?utf-8?B?bzBBTytIaHFhbVhRM09UeW96MS9MaDlwK3dVUURja1pUeTIrM2tpaVd0NVhp?=
 =?utf-8?B?ZXIxWWUxLzh3UklaaVZ2eldPNUVVWEVBOUJPZW9hTld3MlA2SzhscHlSTXdR?=
 =?utf-8?B?UE04ZGcxaUxDQ1B1MitWV0QrZ3RwR3hlRTFMaDNRVWl4VE43citJVUx0YVlR?=
 =?utf-8?B?emFTbGpoTElWOVpWNktHYVJZY2cxV3JVUWdnNVBtTk1WeWY5MUZYY21rN1ZJ?=
 =?utf-8?B?L0EyUFg4M1M4UkpTbDZCd3ZoQlZvYXJoZytlbWZkazFtYTQ2V1pvTWVvQUFt?=
 =?utf-8?B?TWQ1UEE1bmhTaUIwemtmYVNsWUVnUHZDcEo1OEpya2RvSllTNzJ3elA2ZTh0?=
 =?utf-8?B?OVNiZzkycHluOVFwMFh4d1kxY0lPdnlDMC9sWURQcTQ0enlWT2lJbWZWNHlm?=
 =?utf-8?B?bnlCbXBzVlNVczc1andGL1hSYlVUcTZXNklWUUtjd0h6UjBIOHp3QzlraktX?=
 =?utf-8?B?ei9YeHNXT25YeTVIZk5LNW5wMVE1OU5BTlZuK2ZQdzMzcGhhVnRxOEVEUDlG?=
 =?utf-8?B?blJHdWE2d3lnK241aVZPWkl1VXkxWEYxUmEzYUlmNm5Ma0tWaHl6UE45TkJF?=
 =?utf-8?Q?MlBDScfSDdmxWkzMTzT5O0NDa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b35f79d-9431-45cb-54f4-08db84ccf188
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 00:46:36.6662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLf5HiBTljc1+p1UJoPvjbtaYUVMRT3flMAzkSoh0ON3CvwMWL7e2kFKO73RJicPvVwPGHkH4x3zfEbVjz9s0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/14/2023 2:17 PM, Rafael J. Wysocki wrote:
>>> Generally speaking, pci_bridge_d3_possible() is there to prevent
>>> bridges (and PCIe ports in particular) from being put into D3hot/cold
>>> if there are reasons to believe that it may not work.
>>> acpi_pci_bridge_d3() is part of that.
>>>
>>> Even if it returns 'true', the _SxD/_SxW check should still be applied
>>> via pci_target_state() to determine whether or not the firmware allows
>>> this particular bridge to go into D3hot/cold.  So arguably, the _SxW
>>> check in acpi_pci_bridge_d3() should not be necessary and if it makes
>>> any functional difference, there is a bug somewhere else.
>> But only if it was power manageable would the _SxD/_SxW check be
>> applied.  This issue is around the branch of pci_target_state() where
>> it's not power manageable and so it uses PME or it falls back to D3hot.
> Well, this looks like a spec interpretation difference.
>
> We thought that _SxD/_SxW would only be relevant for devices with ACPI
> PM support, but the firmware people seem to think that those objects
> are also relevant for PCI devices that don't have ACPI PM support
> (because those devices are still power-manageable via PMCSR).  If
> Windows agrees with that viewpoint, we'll need to adjust, but not
> through adding _SxW checks in random places.
I think that depends upon how you want to handle the lack of _S0W.

On these problematic devices there is no _S0W under the PCIe
root port.  As I said; Windows puts them into D0 in this case though.

So acpi_dev_power_state_for_wake should return ACPI_STATE_UNKNOWN.

Can you suggest where you think adding a acpi_dev_power_state_for_wake() 
does make sense?

Two areas that I think would work would be in: pci_pm_suspend_noirq() 
(to avoid calling pci_prepare_to_sleep)

or

directly in pci_prepare_to_sleep() to check that value in lieu of 
pci_target_state().

