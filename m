Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D957E7E49
	for <lists+linux-pci@lfdr.de>; Fri, 10 Nov 2023 18:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjKJRm7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 12:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjKJRl6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 12:41:58 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E2742C2A;
        Fri, 10 Nov 2023 09:02:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOEDTJUxnpcOi77H5Y4g60MAIIpM6dg2v6Y6tybIvl9iN7xEmcPv9YMh061sTjoRFUlUlP1rx8nkRD3YsfR/Pb00CFYODvD8adpzzaQW8dLBih7rt99riN+G6je8wWpf6eUAlovIDCayZGvV+GvF1ujBjurwrn7ybh9ABPfICZFacug9jM2AJuROA64c+kv8g1Gu6ETmY3A0v7eGzdRbbW3tFVk0Ejb/FjUP0qEF3C6foa9CoH68RXhDQFMKzsW7xLt/2Tz77nqaSBpMEZ39kv37fKZfsrQ43PF6cKtE6GjC3lZps3c9sBRbJWGhb3wZs8LQFzEV7/kaC+91hDC0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6ZeAeYNweg/E4GGDV9m0Qzg/b37PVwcP817yhlDu/Q=;
 b=e4dpQarv1fl6bGXo1FIq8/Lymn/8l6Ul5/Zpx4+MyOnLQ0mFzK0dKbtlJA0fXehzHKaxXkvesdn1EJLUgfyD0XLdLhktH26qPr6jnkJSc242W1AKydiOvbl9VPHcfI5oSbbYX2qfqVcLmS9BDmoQJcb65A1yWvS7luEV5Ocb4TBK7DG8DazMeK5HLq0yfw00H8ZL0OZMJPhu0zCj4OhLaosdybRudkY69pDXGPCMJFNmK659atYPbBa9a5in19ZYRp10oVHS4GB958QzX18Qupg4xLcb381uOya21Dh6CZQ3bzmiezwZX6aWYo231qFUmEXeFbvkvuoCZRGQ1EXQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6ZeAeYNweg/E4GGDV9m0Qzg/b37PVwcP817yhlDu/Q=;
 b=NOgsAT8xb/RLsYOSunCcNSqIDxFB/WkIeRusy6IFz1UG3BO9JkgTenRR/rNi6yShkj7ZaSCmifwmPQsZvknXPRju+8eoR9y6/z2i1O6vDEc7z4MnSXUNXKHfbRgdIEOKP4uFUKdgYR0VzV2gqbfuKmUE6u79AhlpEOtC6qFJ/a5jm4+ncvLvbXrvTh5gAhKzvGSXaN2x95Vf7ZYLbWrMy5xN3o4peVU6D1fMq5r+1qxrcdyYKpyKGt907O4ZETAMDd7dpKmFmC0tQNddx+opIYwz+QxbWlvfTHY9P+7BqwL29QlONYlJ3tOBqcDR7uk5tIlGA4tFVAirN2NdHC88Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 17:02:05 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::eda4:8c67:893f:3d13]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::eda4:8c67:893f:3d13%5]) with mapi id 15.20.6954.027; Fri, 10 Nov 2023
 17:02:05 +0000
Message-ID: <529acc15-1932-4785-9edf-c5327db64ab1@nvidia.com>
Date:   Fri, 10 Nov 2023 22:31:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Race b/w pciehp and FirmwareFirst DPC->EDR flow - Reg
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Cc:     Vikram Sethi <vsethi@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sagar.tv@gmail.com
References: <BN8PR12MB290002441CA3C24D1FA742D2B8AEA@BN8PR12MB2900.namprd12.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <BN8PR12MB290002441CA3C24D1FA742D2B8AEA@BN8PR12MB2900.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::22) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 81320cca-c10f-4e61-8a0d-08dbe20ec3b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dE8d2Ijk/FnVFqx23gGpw8aBGZ3x9P1wB03SIAVpMxmwaduKVrk9GX122FRJQxa9eLBv+srhyZEzMFodlP3e0TUNXxiw/+FFV/tGEmEMLc6ClTe9DrkpD9lJzq7PCxGjw85dsFC3EUGuhUx3XTXisTIIpQvi7scDQJTAbpajkjI1v7l34hX7DIbHHREv1tpezbkxE3h/DcNep/scUIpAByWiuzfcT/Go59cYFLDsDta8/NjWlMG2Qi9NMJJoUdQIYmgscSAYFPZ1b+SuUqRa+sqL/CzsYNMTucKWa/FC/PaxdUA2sk/bjiCq/si2c0OZXikp6ci5r3xM9bMe87rbBkcyugjsVoTE45ZRPnI61saB14hsSwxHmGvWleIH6jagZGiGuRq4xCULQb1c8czUw1RfI0X2pnfmL5jEE4x2dQ3JcGpbazpk1vTREhhEDMe0936gRvBtNgTucILtCr1Of7POa7ot7YhcM0U77HBPIQxdBFb482LZpGb+sen8wfVck7VfiIO9IGgkvmtVukE/7GMfxgau4FyDjtlpHCeOtvU1pCCcXW3D0HQ0J/0jVqZ/kk5PvIYVqb8eeraby8TGy+rCOK4KXAQLf8fmX101AncX7W0KQ+Me4KYzT3Gx9ZL08EmnYc7ZkN5wgNUH9aRFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2616005)(26005)(66946007)(83380400001)(6506007)(478600001)(6666004)(53546011)(6512007)(6486002)(66556008)(36756003)(110136005)(4326008)(38100700002)(41300700001)(31696002)(5660300002)(2906002)(8936002)(86362001)(8676002)(54906003)(316002)(66476007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGVTdjV5NEJJQ2JXKzNPU1MxeHViVlV0aWo5Mk44NmFPVDdURm9FZEJERTZx?=
 =?utf-8?B?WUYrYU1xQThvdnUxNFlZaGNHNlZkaE5VUlM5YUo2ZmVaQzBtQVlzS2JKS2R0?=
 =?utf-8?B?akxTQW1pTnUwOXNOQTBBMXJ4ME95M2Fra2JDVmJyZk5lYjJaZFZ6eHROWU9s?=
 =?utf-8?B?MXF0bmFhSUJXV01XQ2xJUEZBUHl0a0tzbU42UlphRjZrL2VTTnlpR2V6VnFq?=
 =?utf-8?B?dVRrNFNoRjl2WTZ0VDBLejlGOWNtYmdWbFdGdU80dUVWS1laSTk3c1J1Z0Ft?=
 =?utf-8?B?YU5pT2NHRzZlT3FJd0lyZTNlOXV6ZFRnVzRkQWh0blBvTE56VElBaE43UUVW?=
 =?utf-8?B?ZTI4MjIzVjJsZEVlVzBQS0I2OGMrYmhWVnNYbWZxN2JmOG95ejlobWRpT2VC?=
 =?utf-8?B?RzJFZkdvTlkvUGttNEZFWWR1MVpJK0p2OTZvRGRFTkRyRkxncG1ISytSWmRF?=
 =?utf-8?B?bFUvZkNqaUhEeGpQZUxZeWttdWJTOE96ZkJCVitVNXhuekpzT2xSQjVxeERK?=
 =?utf-8?B?eG5IUk1iYy9OUyt0aGNtVEtWNm1xWjRRb0JEOVNOSGpjc2VMMys1WGtDMkpz?=
 =?utf-8?B?aldMVmJodFhJdEJJcEUyMmM4QzcwbTJmWWhBOUV5UjhIUXJtMEpKdDZDY1BF?=
 =?utf-8?B?RnNvUUNDZlZHZUhCMEZDdjl0QkM5dXBEUVBiNWRrbnV6TEkyRnFWT1QwTHVp?=
 =?utf-8?B?bUs2T1REYkFVeHNJa2Zoc04vN25QZk4wVjl5NktpNFVreHNkV0ROSFBYTUUr?=
 =?utf-8?B?QWtkUG5yU0lhcWg0VTNHdDNjcFpGMi9IR3hiV3U0T0J5TkZlNWttcXZUMFFN?=
 =?utf-8?B?VWVVaHRzSDB4bkd5OFZPWG94MHRFV1draVc3MDZib0J2VUY1ejh5bEcxOG1z?=
 =?utf-8?B?VUtpSmdDMWRSS29zeVFRQUhSaEphK2x6dHhBTDdEU0FYcmd5NktmN0gzWWVw?=
 =?utf-8?B?TExpOXdkTEVzU1NhemlIZWIxWnBvcFUzZzZNenA5R3ZFZUFDN1hUYWw5YWsr?=
 =?utf-8?B?eG1zdW8wNllQTnQ5cytEelh5MmV1RkU4RlNTQzdKZHVaM1FVcWpqZFZxM2x2?=
 =?utf-8?B?ODVKMW5CNkZQRS81cmhKYWxQZ2F3aFpxM2V3cmJBOFJjOFhtWVJHNzVDWEcy?=
 =?utf-8?B?L0t4Sm9MMjlVYWJnbmVaNjZyTEEvUW1GU0JwYkY1dlhUdzVyRWxVMHQyVUNL?=
 =?utf-8?B?S09lRFlaOXViYVJsMFp3TzFydHZaTHpiYVUvMDcvZUxKNlhXb3NNNURFMFdK?=
 =?utf-8?B?aHlueVVWdTdhYUN2NXdJZnhFMHp1WHVVblN5Q3E4UjRkMVE4dkxCSWVVUUhm?=
 =?utf-8?B?aitvR0JOU294eVZ3YlY3a1FLQ3d3Q0x1MkdselFmNkVFZ2Y2VWNCcGVwWUJ0?=
 =?utf-8?B?WjduUFNQRFZQNEZLcmpPVGhscUZQeVA5OHFqdUw0Y09ia3UzUEt2bjdRUnls?=
 =?utf-8?B?Ty9SU3A0elYxQzZETzcrUjdXbzc4aStYNE5ua09EOUFOL0VzYzlydnd6YWNs?=
 =?utf-8?B?bkRKWTQ1N2ZKbDRleGtVS0xDVXMzbitoQllkVmRGTi9oM1g3K1luSXp3VWgy?=
 =?utf-8?B?L2lzTWFCWTlPQTVBWXBzTzYzeWZNTzRzUXAwR1BzQmxobmZzcGFVdkN6ZnhU?=
 =?utf-8?B?Rms2bGx6ek9iWmltVk8xelVmK21relBuUXQ1WHlYZWdueXhHTHlUR01wMUs3?=
 =?utf-8?B?cDJYMHlUbHZVdjNBWm9zU2NDYkt3S2NUNy9vck1ubGFYVFM2VDhVazdIRy9I?=
 =?utf-8?B?bkF6MXBlck53cmlDUlE4aTd3R25jWWNnMUpBbzAzaGFmL1dJdEJCeHRzZ2Zw?=
 =?utf-8?B?bU9jWGJPSUtKVXkvNEhieFE4dTBRNEhxNDVyZ29GZi9mRUVka1F2UERxbnZn?=
 =?utf-8?B?RlhUODJ5TG5JazkyRjN4eXVxYUc2dWFiQk05TGxSVXVhOWI5NEpLeGdRYnBw?=
 =?utf-8?B?eVdTQlBPMUVZYnpjSU40Z3lHYUNaSHZsNWEwOUFidUg1OXlYQ1dLRVVZU2ZM?=
 =?utf-8?B?OVRqZmVkQUt5eklSRDBnVjMyM1hUVXpOZnJLQnpxYTMzbWZ1V0RmeDRBdjA1?=
 =?utf-8?B?YmMyaWlYaFMxMFI0R29zL01NbEthN0RmVllady9ZMlE5RlA0SFRGZVE1U0c5?=
 =?utf-8?Q?xNymSVWTXimFpbD2mrQWAJiIa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81320cca-c10f-4e61-8a0d-08dbe20ec3b5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 17:02:04.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtuEFpqh//0RV0nUiEG2zgQ1ZH+B3qknj5DB1gmtJU9l5OiPVU3KeNbuFaf+sVjyeuAzGAZyI4tgZY//EcR26Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There was a typo. Corrected it.

s/If DPC->EDR flow checks DPC also/If DPC->EDR flow checks 'PD Change' also

On 11/10/2023 6:30 PM, Vidya Sagar wrote:
> Hi folks,
> Here are the platform details.
> - System with a Firmware First approach for both AER and DPC
> - CPERs are sent to the OS for the AER events
> - DPC is notified to the OS through EDR mechanism
> - System doesn't have support for in-band PD and supports only OOB PD where writing to a private register would set the PD state
> - System has this design where PD state gets cleared whenever there is a link down (without even writing to the private register)
> 
> In this system, if the root port has to experience a DPC because of any right reasons (say SW trigger of DPC for time being), I'm observing the following flow which is causing a race.
> 1. Since DPC brings the link down, there is a DLLSC and an MSI is sent to the OS hence PCIe HP ISR is invoked.
> 2. ISR then takes stock of the Slot_Status register to see what all events caused the MSI generation.
> 3. It sees both DLLSC and PDC bits getting set.
> 4. PDC is set because of the aforementioned hardware design where for every link down, PD state gets cleared and since this is considered as a change in the PD state, PDC also gets set.
> 5. PCIe HP ISR flow transitions to the PCIe HP IST (interrupt thread/bottom half) and waits for the DPC_EDR to complete (because DLLSC is one of the events)
> 6. Parallel to the PCIe HP ISR/IST, DPC interrupt is raised to the firmware and that would then send an EDR event to the OS. Firmware also sets the PD state to '1' before that, as the endpoint device is still available.
> 7. Firmware programming of the private register to set the PD state raises second interrupt and PCIe HP ISR takes stock of the events and this time it is only the PDC and not DLLSC. ISR sends a wake to the IST, but since there is an IST in progress already, nothing much happens at this point.
> 8. Once the DPC is completed and link comes back up again, DPC framework asks the endpoint drivers to handle it by calling the 'pci_error_handlers' callabacks registered by the endpoint device drivers.
> 9. The PCIe HP IST (of the very first MSI) resumes after receiving the completion from the DPC framework saying that DPC recovery is successful.
> 10. Since PDC (Presence Detect Change) bit is also set for the first interrupt, IST attempts to remove the devices (as part of pciehp_handle_presence_or_link_change())
> 
> At this point, there is a race between the device driver that is trying to work with the device (through pci_error_handlers callback) and the IST that is trying to remove the device.
> To be fair to pciehp_handle_presence_or_link_change(), after removing the devices, it checks for the link-up/PD being '1' and scans the devices again if the device is still available. But unfortunately, IST is deadlocked (with the device driver) while removing the devices itself and won't go to the next step.
> 
> The rationale given in the form of a comment in pciehp_handle_presence_or_link_change() for removing the devices first (without checking PD/link-up) and adding them back after checking link-up/PD is that, since there is a change in PD, the new link-up need not be with the same old device rather it could be with a different device. So, it justifies in removing the existing devices and then scanning for new ones. But this is causing deadlock with the already initiated DPC recovery process.
> 
> I see two ways to avoid the deadlock in this scenario.
> 1. When PCIe HP IST is looking at both DLLSC and PDC, why should DPC->EDR flow look at only DLLSC and not DPC? If DPC->EDR flow checks 'PD Change' also (along with DLL) and declares that the DPC recovery can't happen (as there could be a change of device) hence returning DPC recovery failure, then, the device driver's pci_error_handlers callbacks won't be called and there won't be any deadlock.
> 2. Check for the possibility of a common lock so that PCIe HP IST and device driver's pci_error_handlers callbacks don't race.
> 
> Let me know your comments on this.
> 
> Thanks,
> Vidya Sagar
