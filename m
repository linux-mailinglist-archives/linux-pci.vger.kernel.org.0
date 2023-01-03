Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E0665C9C0
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 23:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjACWod (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 17:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjACWod (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 17:44:33 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4680E1182A;
        Tue,  3 Jan 2023 14:44:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUwGO6G9VfbICs7Bdu0Z+vZPqxtvVxFVEDHZ2DwjpKMEV2utMq5AyKw+nok+kjgIZDr4jJjP7siBdNebY/kuqh3rqdoIGB8iciDefWa/ygSAqKRuN6yLkkN2e0j1g1tPhYGE0gxwXd9qs9bQmY56BtpI5c6+CJp57S5w3kBUKJ5lWx4bl/6AfZXoBkT/hFjrSAq7cFpQohYYV7IpUPwXckeZgG+NiawgE3a0qkSXCSSKEBqS7Crx4/oa7tF6z86/tmF1aQmzJ1FY/nwxI4HrBU1rPWyHiHA3TWTZLPF4XpZSJKzXby48UIRs4gdtg74PdpqIXZQb/7lGTs38cfmXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NS3llZM8ncOwdlXpFRDLbyQHhjETp9XPdY4CIOWs44=;
 b=j5efV5fLZKAKyxRxH4exnGOlLLcwxZ/xsw4WrTU4zvpeUEQKXi4jiXpiDD8KCOTYk4M6N/JSqaLM5imK4HL8uH38+6R4WsRrL1vLvGWiOike7D9V9aRzxiGE2sWDa3Cp07xbB3241fkhOyZVVNmMJMVbCW8N2UCmoriKWTTNh5lu4E3RT9AA4rHqoffcAKBQIA93ynBksu1Ra9vfdqAbqpqW0Coua/BNLWo9kCtFX40pkNSEcVBzVZf+3I99PulV6m44ka8MJNb2K79NJreF0jmfu6MXH4qX22jpJwowGm8/edDk/yPhCMm1Zxci5/r6yBjzJBvh8uq96RPToUwt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NS3llZM8ncOwdlXpFRDLbyQHhjETp9XPdY4CIOWs44=;
 b=Rcq3rB23HGKy0XVsemIO2GJrvKQ3+OhXef5WIpOatbc0hxDczuLd3e9IQ6KyxW2ozUaXR6kxXGytv7UA2PFK7Ycdd1jU7VcuCBsDBqy/Ezi2ElRnSP6RWlkfU1ApKLhDk5I4uq7u/K3ZUvo62fKfKDdv6XaFRF8M5BwrMG2mfmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 22:44:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%6]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 22:44:25 +0000
Message-ID: <f25d3b59-92c5-342c-ceb8-7feed76ce77f@amd.com>
Date:   Tue, 3 Jan 2023 16:44:22 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221121221742.GA137841@bhelgaas> <8191575.T7Z3S40VBb@kreacher>
 <1945994.PYKUYFuaPT@kreacher>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <1945994.PYKUYFuaPT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0015.namprd05.prod.outlook.com (2603:10b6:610::28)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN9PR12MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: f36eadf5-16b8-4479-bf1f-08daeddc1055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCdHffDS/ghgAQyzZH6NJ2E4cEZvAsekcNh14hCSBS32z/C6TtzK2Q3bRpVp4LN6E6vhgHYK2iNyyjF3H9HZSI0jon7nXZZd1NaMuuz+6NT35dHzmR5h902qB8/psTgCmexsh1dWPxnT6+z+ejRzbQRzs4t8Dojiex3yRZrJ6EqP+8L6iAZxN1Nb39FJVVXmEUYVjHjHbfH6bTyehzqHXCqASGoM8gTFgNSzfR65OhCKQP/mP2U89ADPbkdsYNvIvXEVIF5XF7892qyNMQy40Haeg/5DQdiTXnobhU/wEsdlmCHYOKjgyMnoB74IwDMlj+Z0BkdaThbUE2p99dy5p7LD97/qgfWwpgAco7XxS7Ntmd7Tzl52B9d4HMkgBo92B+e2dFp/vAVmAcqlX3JVBG9pUS99j4IGRpptC0ncXCxI1ENHQPZkqLzXTaxcWKNwvjTOG7XBe/tXhAL+zIqXdGudZFScgHBHTfyfroHwvz6TbPAfZalMX9y7yC6Pv0/WEKFoBfS8UdUJAl2EPhn2v9w1sl9bgVbGRNEXf/r2qOtXe2jNAvtvNavAEHJWFE7mNeLyMvM38gwsu4OCgmZ3PwglSc/AA+Fb5sbtfTGTtOb6vjO2hvLnGHHBcuqNIPfxSpXR+N6V3qPtUHXyP7aoZhZcRFVjkP2T3dUVO3iYTtT8VdbKPqwIJhLQF81/I57RC3H7oJsbLO1f3vufrYPlBYwd6scNIz3aEHYOw+40vPYbDWg8nox57MxFO/hTBL/f9sZGNUMJK9CXWhB6O5qKHEMdbkJ3fW64zSUMcnK3czU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199015)(186003)(6512007)(2616005)(26005)(53546011)(38100700002)(31686004)(31696002)(83380400001)(86362001)(36756003)(30864003)(19627235002)(66946007)(316002)(41300700001)(7416002)(8936002)(5660300002)(8676002)(4326008)(66476007)(66556008)(6666004)(84970400001)(478600001)(6506007)(110136005)(54906003)(15650500001)(6486002)(2906002)(22166009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2FBMHVsQm1mOVd0cnJoTWZqbVJUejhISGVzeWdjRkdhK3ZJS0xvNzk4dW9Z?=
 =?utf-8?B?ZTdjOGxKRFhrZGpNeDZnUnkvUEtSL0tMU3I3UDBuSEFJNVY0eVpvZXlPZjZG?=
 =?utf-8?B?MUVEeU5HbHlOaCs2WnIxOGxXNEY3UDdRRVBUVlVKS1V4dUZrZFFLR0NLUHg1?=
 =?utf-8?B?Z1hZcHVuenFVTVN1bUNYWXIzMk1XYjREVlBKeUxab21BaTYrQ0E0YUgwSzky?=
 =?utf-8?B?UTlpR2llUFFEb3FzaGQ2c0pkY2ZUOEdNZzFMbWZub053UzRYMENnb2RzcHZu?=
 =?utf-8?B?TE1sdXlHNWxFVDhuMXQ1WENJNVdibmpHNXc2S3RKdHJKQS9XME9jVGNsS2ZE?=
 =?utf-8?B?byt2cnV2bXZyUHMzdVhKa20wSFpKcXZrVU1jY1pXT29UUTNSUDNQNWhGelJD?=
 =?utf-8?B?eDYyZlo1VEJ5Q1d3eVlLRHlOMUtBQVdJZFAycWdLZk1wU2JSRE9UQWltbGxy?=
 =?utf-8?B?SlBNUmY2M0hSN3RtR242bmFtSWd3VTIyWUNnRUxsMXZMSWZMRXZ5cUtUUTZa?=
 =?utf-8?B?UTc1Q1p3MlNLcGY1eTh1djZ1OE9mRmNHZTY4aWtud2QxdkJJYnQyYXNuTm5Q?=
 =?utf-8?B?MlJ0WFhXamE1WmJjMzFVK2o2NmlFa1BzMitiblpSUmdnQzFZd2VlblBPWDJZ?=
 =?utf-8?B?VHYrTWwxdDlKTHFXRW1OUmsvNlBYRFI0SS91UDEvTEhVdUQxSlI2Y0toNjhZ?=
 =?utf-8?B?c1pBMmVJclhBRFhvWkhlaWZPWUVrVjlEUjhEOEgxd0h2Ymt5RXhDZDNvS1ZF?=
 =?utf-8?B?TDJIcVBJN1pya2J4ZGNRTWJkSTFrMTVPcDhIWjJQTnpYSzBabGpENEtBekJo?=
 =?utf-8?B?ZllhRHlCYmJxdzRid2JaSXlTTjErN1B6a2N0bXZjV2JxcCtHTGFhRk1GOFlx?=
 =?utf-8?B?S0RrVGVWZjVpUmdrNWlUZ3BYcUJuTW51R0RtdGxpNFliZUtlU2VvWXZkcEx3?=
 =?utf-8?B?V3ZKc3pTZUJzeExaK0RabUllRmhqOUlpcFZuVGk4NmtvQzhjYmM1dExIa0Nw?=
 =?utf-8?B?NFYrTm5hMWN4VnhDbzhhUzlGRllIM3JCMHdLdVJKY1VYQ3dLWUdpSW1WNllk?=
 =?utf-8?B?SjA2emN4WHhaV2tFVjhUV1Z1RWMyWDdWb0RjdW41VkZOamVibzNUQ0ZONTU5?=
 =?utf-8?B?dTA5dUNQOThpeTNvc1pIaG1DYXN2T1RSeXg3SXBjbmRMbjc2bkF3SFIwOTJU?=
 =?utf-8?B?V2JjaDdHVExDWkFYU2NWT2Z5WVQ1RnFNbEVMblVUSnhINjN6M2I1UHExb1JW?=
 =?utf-8?B?M1FkamZHaXRxam10b245M041Vm5lMjE5NVRqYjlTMjNIalBOWlo2OW56aGJO?=
 =?utf-8?B?aVVjdEMwVjU3Zld4a2VwOERNa2oxMDhnekl5dXNRVjAzMEFHQWwwbzB1dGNU?=
 =?utf-8?B?UHdzY2tDeVVXU3gzdGFQbThtd0kxNllHcGJYUkU0azdxbVNEQm03NzZEOTJU?=
 =?utf-8?B?TExWcmxkeWJqTTdqaEthSXRSaFlwZWY5aUdFcXE0b05JSGJ1TUFqOHVndkx1?=
 =?utf-8?B?bHZsNFRnWlh6U2xFVkFhMlJ2RktpU3gwNFA4dFNlRXp2cnlXTkNZRzROd3Zt?=
 =?utf-8?B?Q0M0cmNmK0tOd1MrcStBeGNLbWdiT1lRSUJHOVdDT1BuemdNRm5YQ0JST3VB?=
 =?utf-8?B?djhWV3VlalEwbzdyRGxwSDdNVzBZdDlBTW1FZmRyVGZOT2Y3OFQyVWNHcDVD?=
 =?utf-8?B?Z3hRSnNZZmtlaWJwMkpYby9SdWxqOGYwcTN0eVBBTjh6TFEzYThwMU1tbmVt?=
 =?utf-8?B?RCtld2FoOVRiRmJCcitoNVo2TVBLdFc5UkIyK3g5NWlTY1lveDhKZnpWSU0v?=
 =?utf-8?B?Qy9LVHU1VGJRcnlDM04yWUp6N01Yb2JYaVFIU2IwbjZPclhSZENnZkVkYVho?=
 =?utf-8?B?bkRIU2NzLzI5MmJSUVAvR0lDVjc4MngyeTV3dWdTaUt2amc5NUQ4Y01EOWcy?=
 =?utf-8?B?VzF3RmtqTERWZUZ2ekE4dGx2eW9FYkJCSGtZZlJnN1BRcWdVUm1QMmlsNDMx?=
 =?utf-8?B?bk5URjZ0dzZIMDRaQXlPdFBpV3NpVGZkUUEvM0ltU25xeU5hbzhPcHNlRkZJ?=
 =?utf-8?B?OEZxakVuZzdLSXdmektpd3BjWFFqc2UxYUFONnl5bzVwcEs3clYwNnl4VzIx?=
 =?utf-8?Q?oaofWdNxaH3PESmKVoIeewc7h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36eadf5-16b8-4479-bf1f-08daeddc1055
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 22:44:25.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmVr81+3UpkZM0VU32djY/KpvdX3l4BRULaHX9Fit+GY0MUoutI92kULTheXbsMwRLbAJix+2odpLZqkn5Tjog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/2/2023 10:59, Rafael J. Wysocki wrote:
> On Monday, January 2, 2023 5:34:19 PM CET Rafael J. Wysocki wrote:
>> On Monday, November 21, 2022 11:17:42 PM CET Bjorn Helgaas wrote:
>>> On Mon, Nov 21, 2022 at 03:33:00PM +0100, Rafael J. Wysocki wrote:
>>>> On Friday, November 18, 2022 10:13:39 PM CET Rafael J. Wysocki wrote:
>>>>> On Fri, Nov 18, 2022 at 9:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>
>>>>>> Hi Rafael,
>>>>>>
>>>>>> Sorry, I'm still confused (my perpetual state :)).
>>>>>
>>>>> No worries, doing my best to address that.
>>>>>
>>>>>> On Fri, Nov 18, 2022 at 02:16:17PM +0100, Rafael J. Wysocki wrote:
>>>>>>> On Thu, Nov 17, 2022 at 11:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>>> On Thu, Nov 17, 2022 at 06:01:26PM +0100, Rafael J. Wysocki wrote:
>>>>>>>>> On Thu, Nov 17, 2022 at 12:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>>>>> On Wed, Nov 16, 2022 at 01:00:36PM +0100, Rafael J. Wysocki wrote:
>>>>>>>>>>> On Wed, Nov 16, 2022 at 1:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>>>>>>> On Mon, Nov 14, 2022 at 04:33:52PM +0100, Rafael J. Wysocki wrote:
>>>>>>>>>>>>> On Fri, Nov 11, 2022 at 10:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Fri, Nov 11, 2022 at 12:58:28PM -0600, Limonciello, Mario wrote:
>>>>>>>>>>>>>>> On 11/11/2022 11:41, Bjorn Helgaas wrote:
>>>>>>>>>>>>>>>> On Mon, Oct 31, 2022 at 05:33:55PM -0500, Mario Limonciello wrote:
>>>>>>>>>>>>>>>>> Firmware typically advertises that ACPI devices that represent PCIe
>>>>>>>>>>>>>>>>> devices can support D3 by a combination of the value returned by
>>>>>>>>>>>>>>>>> _S0W as well as the HotPlugSupportInD3 _DSD [1].
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> `acpi_pci_bridge_d3` looks for this combination but also contains
>>>>>>>>>>>>>>>>> an assumption that if an ACPI device contains power resources the PCIe
>>>>>>>>>>>>>>>>> device it's associated with can support D3.  This was introduced
>>>>>>>>>>>>>>>>> from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
>>>>>>>>>>>>>>>>> D3 if power managed by ACPI").
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Some firmware configurations for "AMD Pink Sardine" do not support
>>>>>>>>>>>>>>>>> wake from D3 in _S0W for the ACPI device representing the PCIe root
>>>>>>>>>>>>>>>>> port used for tunneling. The PCIe device will still be opted into
>>>>>>>>>>>>>>>>> runtime PM in the kernel [2] because of the logic within
>>>>>>>>>>>>>>>>> `acpi_pci_bridge_d3`. This currently happens because the ACPI
>>>>>>>>>>>>>>>>> device contains power resources.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Wait.  Is this as simple as just recognizing that:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>    _PS0 means the OS has a knob to put the device in D0, but it doesn't
>>>>>>>>>>>>>>    mean the device can wake itself from a low-power state.  The OS has
>>>>>>>>>>>>>>    to use _S0W to learn the device's ability to wake itself.
>>>>>>>>>>>>>
>>>>>>>>>>>>> It is.
>>>>>>>>>>>>
>>>>>>>>>>>> Now I'm confused again about what "HotPlugSupportInD3" means.  The MS
>>>>>>>>>>>> web page [1] says it identifies Root Ports capable of handling hot
>>>>>>>>>>>> plug events while in D3.  That sounds kind of related to _S0W: If _S0W
>>>>>>>>>>>> says "I can wake myself from D3hot and D3cold", how is that different
>>>>>>>>>>>> from "I can handle hotplug events in D3"?
>>>>>>>>>>>
>>>>>>>>>>> For native PME/hot-plug signaling there is no difference.  This is the
>>>>>>>>>>> same interrupt by the spec after all IIRC.
>>>>>>>>>>>
>>>>>>>>>>> For GPE-based signaling, though, there is a difference, because GPEs
>>>>>>>>>>> can only be used directly for wake signaling (this is related to
>>>>>>>>>>> _PRW).  In particular, the only provision in the ACPI spec for device
>>>>>>>>>>> hot-add are the Bus Check and Device Check notification values (0 and
>>>>>>>>>>> 1) which require AML to run and evaluate Notify() on specific AML
>>>>>>>>>>> objects.
>>>>>>>>>>>
>>>>>>>>>>> Hence, there is no spec-defined way to tell the OS that "something can
>>>>>>>>>>> be hot-added under this device while in D3 and you will get notified
>>>>>>>>>>> about that".
>>>>>>>>>>
>>>>>>>>>> So I guess acpi_pci_bridge_d3() looks for:
>>>>>>>>>>
>>>>>>>>>>    - "wake signaling while in D3" (_S0W) and
>>>>>>>>>>    - "notification of hotplug while in D3" ("HotPlugSupportInD3")
>>>>>>>>>>
>>>>>>>>>> For Root Ports with both those abilities (or bridges below such Root
>>>>>>>>>> Ports), we allow D3, and this patch doesn't change that.
>>>>>>>>>>
>>>>>>>>>> What this patch *does* change is that all bridges with _PS0 or _PR0
>>>>>>>>>> previously could use D3, but now will only be able to use D3 if they
>>>>>>>>>> are also (or are below) a Root Port that can signal wakeup
>>>>>>>>>> (wakeup.flags.valid) and can wakeup from D3hot or D3cold (_S0W).
>>>>>>>>>>
>>>>>>>>>> And this fixes the Pink Sardine because it has Root Ports that do
>>>>>>>>>> Thunderbolt tunneling, and they have _PS0 or _PR0 but their _S0W says
>>>>>>>>>> they cannot wake from D3.  Previously we put those in D3, but they
>>>>>>>>>> couldn't wake up.  Now we won't put them in D3.
>>>>>>>>>>
>>>>>>>>>> I guess there's a possibility that this could break or cause higher
>>>>>>>>>> power consumption on systems that were fixed by c6e331312ebf
>>>>>>>>>> ("PCI/ACPI: Whitelist hotplug ports for D3 if power managed by ACPI").
>>>>>>>>>> I don't know enough about that scenario.  Maybe Lukas will chime in.
>>>>>>>>>
>>>>>>>>> Well, it is possible that some of these systems will be affected.
>>>>>>>>>
>>>>>>>>> One of such cases is when the port in question has _S0W which says
>>>>>>>>> that wakeup from D3 is not supported.  In that case I think the kernel
>>>>>>>>> should honor the _S0W input, because there may be a good reason known
>>>>>>>>> to the platform integrator for it.
>>>>>>>>>
>>>>>>>>> The other case is when wakeup.flags.valid is unset for the port's ACPI
>>>>>>>>> companion which means that the port cannot signal wakeup through
>>>>>>>>> ACPI-related means at all and this may be problematic, especially in
>>>>>>>>> the system-wide suspend case in which the wakeup capability is not too
>>>>>>>>> relevant unless there is a system wakeup device under the port.
>>>>>>>>>
>>>>>>>>> I don't think that the adev->wakeup.flags.valid check has any bearing
>>>>>>>>> on the _S0W check - if there is _S0W and it says "no wakeup from D3",
>>>>>>>>> it should still be taken into account - so that check can be moved
>>>>>>>>> past the _S0W check.
>>>>>>>>
>>>>>>>> So if _S0W says it can wake from D3, but wakeup.flags is not valid,
>>>>>>>> it's still OK to use D3?
>>>>>>>
>>>>>>> No, it isn't, as per the code today and I don't think that this
>>>>>>> particular part should be changed now.
>>>>>>
>>>>>> But the current upstream code checks acpi_pci_power_manageable(dev)
>>>>>> first, so if "dev" has _PR0 or _PS0, we'll use D3 even if _S0W says it
>>>>>> can wake from D3 and wakeup.flags is not valid.
>>>>>
>>>>> Yes, the current code will return 'true' if _PR0 or _PS0 is present
>>>>> for dev regardless of anything else.
>>>>>
>>>>> The proposed change is to make that conditional on whether or not _S0W
>>>>> for the root port says that wakeup from D3 is supported (or it is not
>>>>> present or unusable).
>>>>>
>>>>> I see that I've missed one point now which is when the root port
>>>>> doesn't have an ACPI companion, in which case we should go straight
>>>>> for the "dev is power manageable" check.
>>>>
>>>> Moreover, it is possible that the bridge passed to acpi_pci_bridge_d3() has its
>>>> own _S0W or a wakeup GPE if it is power-manageable via ACPI.  In those cases
>>>> it is not necessary to ask the Root Port's _S0W about wakeup from D3, so overall
>>>> I would go for the patch like the below (not really tested).
>>>>
>>>> This works in the same way as the current code (unless I have missed anything)
>>>> except for the case when the "target" bridge is power-manageable via ACPI, but
>>>> it cannot signal wakeup via ACPI and has no _S0W.  In that case it will consult
>>>> the upstream Root Port's _S0W to check whether or not wakeup from D3 is
>>>> supported.
>>>>
>>>> [Note that if dev_has_acpi_pm is 'true', it is kind of pointless to look for the
>>>> "HotPlugSupportInD3" property of the Root Port, because the function is going to
>>>> return 'true' regardless, but I'm not sure if adding an extra if () for handling
>>>> this particular case is worth the hassle.]
>>>
>>> I think this has a lot of potential.  I haven't tried it, but I wonder
>>> if splitting out the Root Port-specific parts to a separate function
>>> would be helpful, if only to make it more obvious that there may be
>>> two different devices involved.
>>>
>>> If there are two devices ("dev" is a bridge below a Root Port), I
>>> guess support in the Root Port is not necessarily required?  E.g.,
>>> could "dev" assert a wakeup GPE that's not routed through the Root
>>> Port?  If Root Port support *is* required, maybe it would read more
>>> clearly to test that first, before looking at the downstream device.
>>
>> Sorry for the delay.
>>
>> I don't really think that Root Port support is required for a bridge below
>> a Root Port if that bridge itself is power-manageable via ACPI.  Moreover,
>> I don't think that the _S0W of a Root Port has any bearing on devices below
>> it that have their own _S0W.
>>
>> So what we really want appears to be to evaluate _S0W for the target bridge,
>> regardless of whether or not it is a Root Port, and return 'false' if that
>> produces D2 or a shallower power state.  Otherwise, we can do what we've
>> done so far.
>>
>> The patch below implements, this - please let me know what you think.

This looks good to me, thanks.

>>
> 
> And here's a v2 with somewhat less code duplication.
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] PCI / ACPI: PM: Take _S0W of the target bridge into account in acpi_pci_bridge_d3(()
> 
> It is generally questionable to allow a PCI bridge to go into D3 if
> it has _S0W returning D2 or a shallower power state, so modify
> acpi_pci_bridge_d3(() to always take the return value of _S0W for the
> target bridge into accout.  That is, make it return 'false' if _S0W
> returns D2 or a shallower power state for the target bridge regardless
> of its ancestor PCIe Root Port properties.  Of course, this also causes
> 'false' to be returned if the PCIe Root Port itself is the target and
> its _S0W returns D2 or a shallower power state.
> 
> However, still allow bridges without _S0W that are power-manageable via
> ACPI to enter D3 to retain the current code behavior in that case.
> 
> Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/acpi/device_pm.c |   16 ++++++++++++++++
>   drivers/pci/pci-acpi.c   |   34 ++++++++++++++++++++++++----------
>   include/acpi/acpi_bus.h  |    1 +
>   3 files changed, 41 insertions(+), 10 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -977,22 +977,37 @@ bool acpi_pci_bridge_d3(struct pci_dev *
>   {
>   	struct pci_dev *rpdev;
>   	struct acpi_device *adev;
> -	acpi_status status;
> -	unsigned long long state;
>   	const union acpi_object *obj;
>   
>   	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
>   		return false;
>   
> -	/* Assume D3 support if the bridge is power-manageable by ACPI. */
> -	if (acpi_pci_power_manageable(dev))
> -		return true;
> +	adev = ACPI_COMPANION(&dev->dev);
> +	if (adev) {
> +		/*
> +		 * If the bridge has _S0W, whether or not it can go into D3
> +		 * depends on what is returned by that object.  In particular,
> +		 * if the power state returned by _S0W is D2 or shallower,
> +		 * entering D3 should not be allowed.
> +		 */
> +		if (acpi_dev_no_wakeup_from_d3(adev))
> +			return false;
> +
> +		/*
> +		 * Otherwise, assume that the bridge can enter D3 so long as it
> +		 * is power-manageable via ACPI.
> +		 */
> +		if (acpi_device_power_manageable(adev))
> +			return true;
> +	}
>   
>   	rpdev = pcie_find_root_port(dev);
>   	if (!rpdev)
>   		return false;
>   
> -	adev = ACPI_COMPANION(&rpdev->dev);
> +	if (rpdev != dev)
> +		adev = ACPI_COMPANION(&rpdev->dev);
> +
>   	if (!adev)
>   		return false;
>   
> @@ -1005,11 +1020,10 @@ bool acpi_pci_bridge_d3(struct pci_dev *
>   		return false;
>   
>   	/*
> -	 * If the Root Port cannot wake itself from D3hot or D3cold, we
> -	 * can't use D3.
> +	 * In the bridge-below-a-Root-Port case, evaluate _S0W for the Root Port
> +	 * to verify whether or not it can signal wakeup from D3.
>   	 */
> -	status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
> -	if (ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT)
> +	if (rpdev != dev && acpi_dev_no_wakeup_from_d3(adev))
>   		return false;
>   
>   	/*
> Index: linux-pm/drivers/acpi/device_pm.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -484,6 +484,22 @@ void acpi_dev_power_up_children_with_adr
>   	acpi_dev_for_each_child(adev, acpi_power_up_if_adr_present, NULL);
>   }
>   
> +/**
> + * acpi_dev_no_wakeup_from_d3 - Check if wakeup signaling from D3 is supported
> + * @adev: ACPI companion of the target device.
> + *
> + * Evaluate _S0W for @adev and return 'true' if it is successful and the power
> + * state returned by it is D2 or shallower.
> + */
> +bool acpi_dev_no_wakeup_from_d3(struct acpi_device *adev)
> +{
> +	unsigned long long state;
> +	acpi_status status;
> +
> +	status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
> +	return ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT;
> +}
> +
>   #ifdef CONFIG_PM
>   static DEFINE_MUTEX(acpi_pm_notifier_lock);
>   static DEFINE_MUTEX(acpi_pm_notifier_install_lock);
> Index: linux-pm/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpi_bus.h
> +++ linux-pm/include/acpi/acpi_bus.h
> @@ -533,6 +533,7 @@ int acpi_bus_update_power(acpi_handle ha
>   int acpi_device_update_power(struct acpi_device *device, int *state_p);
>   bool acpi_bus_power_manageable(acpi_handle handle);
>   void acpi_dev_power_up_children_with_adr(struct acpi_device *adev);
> +bool acpi_dev_no_wakeup_from_d3(struct acpi_device *adev);
>   int acpi_device_power_add_dependent(struct acpi_device *adev,
>   				    struct device *dev);
>   void acpi_device_power_remove_dependent(struct acpi_device *adev,
> 
> 
> 

