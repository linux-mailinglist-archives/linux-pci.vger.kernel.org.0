Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637A07DF65F
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 16:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjKBP0o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 11:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjKBP0m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 11:26:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E0FDB;
        Thu,  2 Nov 2023 08:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVEl9BzrnYv9rpvxzBCOt/wyIT77Xz0P3QvuX1iLbEKC9JcruK3phyRjegL2LX34uJHiFwexSqeCsxuHpNUSdu7+20+vAz1i+fWqxh21JGIG6aUEfrDOS0gr7bcpMTtaA2XBbXrCAcfJ75pQqv6Y720ezxtJ2xnLsvKomcRXKoi8nWcMZaFiEv4HK4iedBJYuktNNSA4nzXnwEdtqT02StFp0iaTjKROQ3G0HLopi3L19Y5xSuO8/9jZqOkqO0xNGm8WTSwTttaMssPHzam4T0TpWbv5cPfyN30oUQo30JRzLHUUH2f/EPaAvL6bfpeoQYexT/rtbutFeH8gAixB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntSRagWpnhbw2ZWtqTpmFCbps66uDsH76GAuS+dj1kk=;
 b=kXdJC1ozxHp1+xgh8YoIJOONl8W+cP/yeFVN7RyuJUkPnOQ3q+tHXh0eecfRZRwPt0A6rfiwqMNgg91LbxudlSA812JuSSB8ZZbaFGl4SahC6AIl5UJcSyjWJ+o38aljzlNRjJ9rCancFqoMR7fr1lHJxc66/ymDAcSsPierCClsEE65esG09cfQmZwnalN7FaEcw7HNSdNmu37B4tGDpsGbfPG6I6kT2dWDA6ihlmBaVtUjdeupl8YdA43lURWkcHsMcJNs4VwGJbAFQMcZpMUBsMT8IbuRgiQtHetuRiZjPcHf10iOxktNjpMZXZwYUueq48P0TtweOlwT8fCIaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntSRagWpnhbw2ZWtqTpmFCbps66uDsH76GAuS+dj1kk=;
 b=XG09Bu1sIDCxcuRAL1yEx4ypiLn0weTX3/8p/sLfcRFWqdN+bTuRLZJ/BSLPJSgCYaoSeCzlcQBPTjq9uBUSASp943vF0mtNMeCjgZPEjyAPhDfmuBdpyDJhAosUGn6599WsfwPyTrJ+tuRDToJSew1WFYgXZJl6ngmlr0RzYP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 15:26:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Thu, 2 Nov 2023
 15:26:33 +0000
Message-ID: <bb4d8fad-dced-4fed-9582-2db50643e868@amd.com>
Date:   Thu, 2 Nov 2023 10:26:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: Ignore PCIe ports used for tunneling in
 pcie_bandwidth_available()
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Alexander.Deucher@amd.com
References: <20231101225259.GA101390@bhelgaas>
 <928df647-5b20-406b-8da5-3199f5cfbb48@amd.com>
 <20231102152154.GA22270@wunner.de>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231102152154.GA22270@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0175.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: fcfa0864-37f7-4d6d-34dc-08dbdbb81871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2EcWHNm9bJuUH/mAF33cvVEkgQC7sr8jHDDloGajZaTWAumEotsvbDhF0IzxN8/aIgUeIUwkjSlh4aB5lMNmfqEgAYEm4RVzTtZji2TgCPaF9vhBldq50kmG9LFq8VOQXA51kcyY3Za1K8fPvdDu4DM81Tqlztexw74lGxNSeoqxH/zfaR1BMcexrHGC6BKh7hAeMHZ37e1O9VGwf86h6nf4LfWnsgLxj8ROEMYNIAKwvO3O4+Xm3Jx5i8jQLFiebHSu6EFQxpdcjoY7fAqpQrz1bceQd5eDS7laRWC/lxnTCVzVOMHpJYB97UxdxPjR078VJCcjAxsKoCuL7kNEHTQ0N8XO+GzqrOeNNUtL2W2F0neO/HEaAIxD38YjgRd7tpEY2eiVAE5kKQj2QN2x9bTAxw234neqUEfc9d+ctRmvgvkI8sNGEBml9zSa8quGvk0FKCGLQWa6Ur+vAwTlq9UH0Rn58XzbxgEQqkxrFpX755XuCN0bq4oaRK0OmkUEvCpf7hw6B9+63+F5NUf1PPSTI4asLpIyorHON6HZqp9ECiQ/apxolOl1q5l/xx9wkr6aum8qsEKW017kdsUFCiMZYQetTEoV8TRP9pQmpW9Q1EWAmKUp2M4C9gM3bqEYikpT6TSmk08oOWpXqwDRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6486002)(4744005)(31686004)(66476007)(66556008)(5660300002)(66946007)(8676002)(8936002)(316002)(6916009)(4326008)(2906002)(7416002)(478600001)(44832011)(6512007)(2616005)(53546011)(41300700001)(26005)(6506007)(38100700002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzNkQVZ5M2oyVnI1dDI2TTRhN0hJeWRiWVlleDJBM2ZJRXByalNXemtuZDRv?=
 =?utf-8?B?R1A3VEtpcndqWVErcEN6TlJ2bXFCTjRwVWdZZVZKcUQrYlVYa09haitYbEVR?=
 =?utf-8?B?dVVOWnY4N3Rhb3lCalNxR3Q5bXJDU3ZEUnNiYjY2bVl5K0haOWxsTy9uZWNx?=
 =?utf-8?B?cXpCMkNJY0RnSGtDNUovR0FsSUJCVDN6UlNRYVl6bGt6SzUwY1V2OUsveXgy?=
 =?utf-8?B?TU9GT2ttV0RNS1U2cVVKWEdjR2wxczVwdVBuU2hJaXlDZ1lhZmRZQWh3VEcv?=
 =?utf-8?B?WllVeTAzYkRpYisyd1docGtoY0lVKzBVd0hobk11QVRtaFN2NEQ1Z1JNSHZZ?=
 =?utf-8?B?cVR6WG5YUGJCRjhKeVdqUXZaMnVyeUUzaGRvdGF0WkRFcFNiQnZscVNuUDBM?=
 =?utf-8?B?OTlvOXU3cWNnUUxRejN4dm9EL21pU1JjelV4Y0hpRTBwZ09JU3lxWjdoYmUx?=
 =?utf-8?B?bFRHaitxK1NOaWNneUQ0c1J4S2dXZWZac281VkVSeTFSK0pxN2RTSUM5eDEv?=
 =?utf-8?B?VmdOWmFDY0N5dk1tVUloODEyZEtiaGxGSXExZXRRcjBITzFJNU5nL0xWTU5o?=
 =?utf-8?B?K0FObTYrVDNIeFpSVUVjRVVVWDNMdlU4Qk1DOFRuR0syRXgzSlh6dW5qM1Fr?=
 =?utf-8?B?djBSMFZkM1Q4S0F5eFB5dE5LWGYxUlN0ZW9DZWp5ZjhHYUtYYjRtdGMrdTZH?=
 =?utf-8?B?TGx3TmVPMVk0dmFIYmk4ZGJrK2FQcWVxTFo5SVFaUXdhbW1nRHppR0VnZms3?=
 =?utf-8?B?bXhpQzFWZUZrYjFZMVF6UzIyYTdicE1HSERvVVljRzI3WGVjYXVGS1dKT0g5?=
 =?utf-8?B?TnlnVS8veWFVVnRsTGw2QVNEdG1qZTdrSURZeDVVdE1jV3dzV0l1Y21ZUDBS?=
 =?utf-8?B?YXJkNWZlQ2pjSm0yRlIyOS9CSXJ1ZkFHUnhqekdyR1o4ckpBdGdRRWtadHBL?=
 =?utf-8?B?eVd4cm9wVjVUdGt6T0FPQThlM2NIbW51cjFqbmdDTmUvdGZkWUZ5YUxuTlVE?=
 =?utf-8?B?L3B0UFN5U3JUT1MxbEZ3Wlc2ellIR0ZnK3BZVnBUOUF0RkNLblFobTcyYjhw?=
 =?utf-8?B?NjVMdkhCbEQzUyszMWNwcVkwS3FxWmFDRSs1UHcxV3hzUGNQMEhEWmRNWDNT?=
 =?utf-8?B?NGFxV2pKbXFqY245aUJibWJxbU5IZnZvMldxWnY3bkN2MVUrQUJMTCtwVk9x?=
 =?utf-8?B?QUtuSUZkVGcyUmtnbU9VOTdKcFlmNDJJMllnVGZzNU9lcURuZllnNzcvcWt1?=
 =?utf-8?B?bUFKOHhXaGhhOVhGQmVKQmZJTHl1VGhBVTVhcDI2V3B5R3Y3aGsySlMvTUdk?=
 =?utf-8?B?UUR5NnVoLzFvVktiZ1piM3k1Tk1mQjhoSUdJRlJZNXg2NzM5MmRmdWV1dFJw?=
 =?utf-8?B?cGdxVU9yTmhwQUdTdkpQUXlxZ1VrZnRLbW1UUm00OElHNStTYThEbVozc1RD?=
 =?utf-8?B?VlFuK0Q2SUU0WmFWSFpzNWtaajNPSUY2Nk04bEVLdzQ3dU1CM29lSTRuUjR6?=
 =?utf-8?B?TzdIcnNzY2xENmtyb2xDTEtGbzc1Ky9xQXYvdEErczRGcVlXUEdyK1JnNTJy?=
 =?utf-8?B?N1U5alFpbTNGMnNrS3BaajRSeUJEZE4zR3NUVmQ1em5CZlB0VmZPYkxnM0ND?=
 =?utf-8?B?eFNJWUp4dWVMT3VTS2p1K0NCMVlIclF6dnhhN1duZUtSajlkbDlra3l3MmVM?=
 =?utf-8?B?ODlLSS8vV2s2ZFVLWFFmdjIvRUFMdTlKM0lNUkRXMVBEbXlkdVRXeUpXTldI?=
 =?utf-8?B?c2ZtWlc5Ti90OG11VTVROW42L01PNlBPdTlhZGcrVEt0Q1F0M1ZTdDFBMnhv?=
 =?utf-8?B?VzhVMk1Ya254bGNBZWJzV2EvVjFMS25XQTJtVU03L0M5YXVQV20zV0J5QnA3?=
 =?utf-8?B?a0NIcGU4Z3NpOGwxTGVYTmlyTW5tRnRFYS9HMU9HV0g2bDNaRzh6WGd6bVUw?=
 =?utf-8?B?ZlZHQVNDNXZiQkE1SEVleEZ1dlMzdUExU0lsaWpTdWh1SjRvV1E1UmU5ZEJB?=
 =?utf-8?B?WEZKeEQyR2VHUndpTkNxeWFDZkdxQjVLOCtzdC9pN2xUZEF1WStmemtIN2Zl?=
 =?utf-8?B?ZTVZY1hOMTdaSUMzWkxpMGdxOS9WcTA0RUo4TXg2WFc5cmlCK0FNR0JyUXk4?=
 =?utf-8?Q?xfS9bYkmKj7AE4GQBA1nK2dyr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfa0864-37f7-4d6d-34dc-08dbdbb81871
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 15:26:33.5035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVKyBNk10PittUy9j44v1PVAh+dQAO5/reHI/yzqOJklUvrtkL9Oe3wNjneFMCp0xCRMARKcNFEbCmmX8NpAJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/2/2023 10:21, Lukas Wunner wrote:
> On Wed, Nov 01, 2023 at 08:14:31PM -0500, Mario Limonciello wrote:
>> Considering this I think it's a good idea to move that creation of the
>> device link into drivers/pci/pci-acpi.c and store a bit in struct pci_device
>> to indicate it's a tunneled port.
>>
>> Then 'thunderbolt' can look for this directly instead of walking all the FW
>> nodes.
>>
>> pcie_bandwidth_available() can just look at the tunneled port bit instead of
>> the existence of the device link.
> 
> pci_is_thunderbolt_attached() should already be doing exactly what
> you want to achieve with the new bit.  It tells you whether a PCI
> device is behind a Thunderbolt tunnel.  So I don't think a new bit
> is actually needed.
> 
> Thanks,
> 
> Lukas

It's only for a device connected to an Intel TBT3 controller though; it 
won't apply to USB4.
