Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946BE4E55DB
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 17:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbiCWQCo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 12:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238342AbiCWQCl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 12:02:41 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461887B113;
        Wed, 23 Mar 2022 09:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofQ9Dsl84Gl0Z5qGhDGt4NWbxF7zM8zKSF0kmEcEH2kPjtq/UdYOIB1l73R+qU0s9yFjV5/Ms1cDQsrTUeXIp8zbH2RL/CzZRnQIs0TwwzQYxoJUyC16Lz/QRvZBLw+aMXYtEY+hC+c9pEIP6ZGc1RB6x3cyZw73G0r3HuyrWcNdzipeIYRcA2dcnOpi/EH5xl80kKL8zTskHJ87EcSdvy2t+ZjMo4WtNchuKM3tuWb8p6M/+981GBIBDwIvr/IfUpPlQmUw5WXqnwL4KwwiZHN3ogs3GsRqj19fcPSnKg3BgtgsjMw4WfqW+BIA4Io5NfFpyk9BqPzfmM483X5l1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvV7zlguYdg3T9kKjBmzWDYFyyM3ScUl36jPRj+U7/A=;
 b=DZbsKSmp2S6tip3fcsONCa1yYhifnOLj3M/YjBs2a/HrkOQfYkkBLpwUUwnX1ms7BLjrxgR6tDdbU/eX5yUoJEi5y2m69ARYC51P0Gcm2NoyfaJTU/778jALfswXGnLIsGzupp8lmktIaUIskk1qBpObQ/oCY+FNMS77d/NJOCnLs1LDgbXUHdIMcROLOqxKWKDh0w9tGvKJamGWupQ0cST3nBxjGEaxuR9LVpYXvX3j7DymAEt7zEeAexUKGpuyl+Ie9Wj3zjepXoJ+eKFRHqbZRCuKxUkS8eimV0jC/SoSy3tnxyWNrzLutzkZBBeJTDmXdENGjLd76tRNA1/uWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvV7zlguYdg3T9kKjBmzWDYFyyM3ScUl36jPRj+U7/A=;
 b=19F19X7pWxnzP+mHSkwlWwUDtHTRT/TRACTz5zQXo1YT+jk4vn2PEPrpiwVSvxHfhUV78Afo4ARexPkGWpV54LdNcQ/KEyc8GOBRHu1LpBhvrUCmEPDlHGwe/hi1Tf7+HtWPu4vLCa77RS8+/9QrLKny15kRmUg5hK2yldKo/BU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL0PR12MB4723.namprd12.prod.outlook.com (2603:10b6:208:8a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 16:01:07 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 16:01:07 +0000
Message-ID: <83aee1d8-5700-d2bb-fae5-d952240c6fb8@amd.com>
Date:   Wed, 23 Mar 2022 11:01:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if device
 can wake from D3
Content-Language: en-US
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220315153252.4880-1-mario.limonciello@amd.com>
 <CAJZ5v0hFGjGYeAbA93joobgw1RMSbBD77=3mAExLPQX-dn=xKg@mail.gmail.com>
 <CAJZ5v0jc5Wjap0qY9pqvkxCxbRFy10mZdq+JMtuWAY-v1Mk_Zw@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0jc5Wjap0qY9pqvkxCxbRFy10mZdq+JMtuWAY-v1Mk_Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0102.namprd05.prod.outlook.com
 (2603:10b6:803:42::19) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b81596e8-d075-4bce-d07a-08da0ce65761
X-MS-TrafficTypeDiagnostic: BL0PR12MB4723:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB47236D290676D1F81779F4DFE2189@BL0PR12MB4723.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Ugqn14d6Pm3bdcSH1blQjQow5vV/JUgdZQpAg6YBb2jGl438S/4r0vvnls3mvAJOti2qh+vXOPeC6rPeiV3uce2veV49dthMVO4+5/AgupsZienO3+tCzPzYdE4nfl+kzBinaVzbMGFLxqAFfmpULBw38aIOg8zcHIUZri5/yBjhygwOsyatvFMEkxp+JotA20pcUyuSrvCg2bLtOPXhQPlhRhXfjB970KeNTUJxKNxxRoA8U2WvIkwfElTLJ4P8c//8zEmZfBTJ6My/eZW7dIso4M3qn+Y0F1q0tA0g7BX8D8ZLNgGHgOObyuDlrHb5JBBMfsQkWU16mOEXoN9Ir64y4r9nUlVgn1D2GHPtus0uAPK6oELLcmjOWn10XzXAUYn5KzGgYWMRES50AzRVh0ePVIpI3ObssazYwiaMLB7Bxhjhy7zBJwfl2uUB4N7AKj1mxsr0YDIXOx/DrlSaxuGqO89jsb0ji5VXJ7XVye2k3ojwfIiVxfb8m/GEfYtI2D3UqEz6LRP6zqdjDqysOoAV6D5nvo+UxeO/4pwo4Nq5R3Gt/s+5ak/WTg36diPffmueGrODu7mUwzk36iZCOmUIc3wTSkUxDrS8hzg15gnLYUnQwh33OyMrjWwkZIDBQFcciDARb6owJjp3f2vzhnmi+p//5tF6zP/qly+hDoVVSWOKTNnfTmBDhczMgCEQ33thP2IhB884aqLpJeMTvHXh08GZEnT08VHaLsdPb62kXoApzd0CdAPA76X7RzkuFu+EK8tvCdgZ5j2AK4z5zOgWC7DtJTE+CGxZbPtxvu2wX5UYaNfHV8Vi8jM7NlRuOqX1xQO81UDo9SliLExA1/eaJnFulkoyxpV6bd1ormBJuRfX24iROY+C5aTciIi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(4636009)(366004)(83380400001)(38100700002)(86362001)(31696002)(4326008)(54906003)(6916009)(66556008)(66476007)(66946007)(8676002)(36756003)(316002)(44832011)(2906002)(8936002)(5660300002)(6512007)(2616005)(53546011)(6506007)(45080400002)(186003)(508600001)(31686004)(966005)(6486002)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkhvZTMyckVyWTR2M1djZUxPZU15NXFqb2xnVjBnR04waGJySFVvSXJnK08z?=
 =?utf-8?B?NUY0SU9qS29tWWU5clY2bU9ub0t6MDRRMzNHL3B2bUJBZXVwanJiZEZNNHdk?=
 =?utf-8?B?UVlIQm1TekI1N0p4L3VvZWpWcjFPV1ljc1RkUVhlZ09vVlB3ZmNXL2VCcDRM?=
 =?utf-8?B?UWlXMkZBUSthT0xqWU4vcUU1QkZIcnU3ajJYZXRPbDJYVjUyWjZza3BEemE2?=
 =?utf-8?B?RnNBZ1crVUJRMW1FQTNZU0xyT0RBdGlla1o0dE5YVEx6RFhEZ3FjaWovTmRr?=
 =?utf-8?B?MEM4MGJLZjZnUWIxOGxmSXozZmFBUWJ4SEF5YlU2UzVrY0RBZWM2TTMybk80?=
 =?utf-8?B?NUJpcXZiMVVYZXhmRkMzSzVScEdCSnA4Y0tYb1VQTEJhbkQveG5BMkpUakdQ?=
 =?utf-8?B?UzFWUnpOaXB2Y0IzcFcwbkQzTzNSNENGTm9rVzFWK3ZtekRZM3ZLbWhKNlVz?=
 =?utf-8?B?T29IbXVId2toenpPVzVlbkx0dGpUWGFiV09hZi9SY3l2MmR4Z3dscmQrdlZV?=
 =?utf-8?B?cVZZZG5KR2JjaHpBYlZoc0xvM0NQT1BDOHdNR1B1QlJSek9iRjNzSnFUOXo2?=
 =?utf-8?B?ZThUM2lMZkRsRUlyQTBEYWtqdWNMRWlaY2lkeEpwZ2IwY1B5V3ptYTJBV05v?=
 =?utf-8?B?NVdlRW5uUTYwN0x5RXY0MmxvbEcwZGw5eGc5TkNqeGRFUVFKYXUvUG5DdmJw?=
 =?utf-8?B?UFBmamIwSUgyNUlDcjNWbHpmSUdzMTUvRi9zSDFuTnFkTlBudWsyMDZHMk1a?=
 =?utf-8?B?dTJNTUdnOFd0bWlJbzIvZE9JRmpjU256aFNjZXdsZTZRYWh0d2pXdDRzcVdT?=
 =?utf-8?B?SXRERExhL2oyakIvbEQ4a0h4ZzNSYjgxUW9HcmN2MXNGK0E0TGhwbHZDbDJK?=
 =?utf-8?B?eWdZMzlabDA0enlYT2R6SFVhZ3QrM3oxS2RuS2lobklUUGc4NmVpbUtPSisy?=
 =?utf-8?B?TEtkeXZjR0NKeHUrT1IwcWE0Z2tYWUVRVU9xSlVoS0ZqWkdBVzhBaSt4ZjNn?=
 =?utf-8?B?ZG5PV2xudk4wWWVpdkx0SU5pSjVITytMbmVnWUtvVUYwZHg5QmRjdjlnMTV6?=
 =?utf-8?B?a0xRNzdqZjZQcTdJK1g4STBVWm1RSC8wem1qUDJYUzZVaWZocmRISExUMWx2?=
 =?utf-8?B?My9PZnZ3RXpVQWN1ckI5LzdQUFNUWTIxZld2ZW1uMVhnRE40S2RzelRKTmxG?=
 =?utf-8?B?YzJXRDRITlB6ZU0yWlRRcWt6NnhqR0NwMEpSN1VkZ1pWd3RFajUycGczbUYw?=
 =?utf-8?B?c1pwcFJRVWovUitXbG9uM052K1RhaUowSis1NEpFblBLTFFwd3NvaTR6QmJT?=
 =?utf-8?B?NVNOLzV4NENFT0tPRHhBUFhGVm1meTQrMGhRRW1WaFNyMy9WSGYyYlhGVUY5?=
 =?utf-8?B?K1FUNW1paGQ5SCthVzUvMXM1dzVwZWhyZ3UrYmV4SUo4ZG5rV0t5c0hsbVVF?=
 =?utf-8?B?NkpUbWZJT0Q0dWVVYTRmUVoxV2dwWFNFN2NFL2ZScUtySy9EUWJidFpsZHpN?=
 =?utf-8?B?NFVMZlRFTWFXSHdmTU1pQlYycU1YMnJOdFozeFNOcnB1TDE1S1ZkVTM5VW4r?=
 =?utf-8?B?dlhzVzVQdm1mVUQwRHJ2SVBtTXcxTVBVQkJWMXRqRkRGd3pOK0Y5emx0MHdl?=
 =?utf-8?B?cjRTNDR0dkF6SUFrZldEQldqZmhYVitWUkI1RFlFTTNSRlZuZjFTOFNFT1lq?=
 =?utf-8?B?VlR1aWFyeEhmT2xrUG92RmdxUWoxQkhyK0lvWUVMVUVXYlBSanpzclcyS1Yz?=
 =?utf-8?B?bU1YL29MdzdwemdmODZzM2lsY1dJYXFDTFZnejk3U1VKZTBvQm9NUVY5VUZR?=
 =?utf-8?B?a2pQMS93bFh3dS9aN1dhem1ZSmxYdXBVYmovRUx2Ulp5MmF4ZHRvTTY0Y3FF?=
 =?utf-8?B?eGMzRDV5QVVZM0dWWjB5clJ2Ty9uYjljZzdFVXJIMVpsWUdGcER1Yy9NeXY1?=
 =?utf-8?B?WkFJZFZ6NlVFcngzQmtGamhTaDdEOFhhQkEvK0FoQlhrbytnS3Q5aS9xMXRm?=
 =?utf-8?B?emlXdUR3a2I0d0FyMmRYcmNHcEdBM0dDL0o1Qjl3akdLR1NEclJLNjh1MTRH?=
 =?utf-8?Q?0fMYUm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81596e8-d075-4bce-d07a-08da0ce65761
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 16:01:07.7822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ek410/bdkAQuSz+F06Us0tGTkzfx9Z/FMWClYnbvsP//plbYsMLdEQIldmTW+mHca9HzMoaqnEZ2sNrVv4kHvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4723
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/15/22 11:36, Rafael J. Wysocki wrote:
> On Tue, Mar 15, 2022 at 5:35 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Tue, Mar 15, 2022 at 4:33 PM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>> According to the Microsoft spec the _DSD `HotPlugSupportInD3` is
>>> indicates the ability for a bridge to be able to wakeup from D3:
>>>
>>>    This ACPI object [HotPlugSupportInD3] enables the operating system
>>>    to identify and power manage PCIe Root Ports that are capable of
>>>    handling hot plug events while in D3 state.
>>>
>>> This however is static information in the ACPI table at BIOS compilation
>>> time and on some platforms it's possible to configure the firmware at boot
>>> up such that _S0W returns "0" indicating the inability to wake up the
>>> device from D3 as explained in the ACPI specification:
>>>
>>>    7.3.20 _S0W (S0 Device Wake State)
>>>
>>>    This object evaluates to an integer that conveys to OSPM the deepest
>>>    D-state supported by this device in the S0 system sleeping state
>>>    where the device can wake itself.
>>>
>>> This mismatch may lead to being unable to enumerate devices behind the
>>> hotplug bridge when a device is plugged in. To remedy these situations
>>> that `HotPlugSupportInD3` is specified by _S0W returns 0, explicitly
>>> check that the ACPI companion has returned _S0W greater than or equal
>>> to 3 and the device has a GPE allowing the device to generate wakeup
>>> signals handled by the platform in `acpi_pci_bridge_d3`.
>>>
>>> Windows 10 and Windows 11 both will prevent the bridge from going in D3
>>> when the firmware is configured this way and this changes aligns the
>>> handling of the situation to be the same.
>>>
>>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fuefi.org%2Fhtmlspecs%2FACPI_Spec_6_4_html%2F07_Power_and_Performance_Mgmt%2Fdevice-power-management-objects.html%3Fhighlight%3Ds0w%23s0w-s0-device-wake-state&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7Cae5d5d8f4ac1452dac0c08da06a200b2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637829590116901616%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3cTSyBgSEOBo5mPeUcNDrc9qhdMJeZ4cVtLqroDRZqY%3D&amp;reserved=0
>>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fwindows-hardware%2Fdrivers%2Fpci%2Fdsd-for-pcie-root-ports%23identifying-pcie-root-ports-supporting-hot-plug-in-d3&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7Cae5d5d8f4ac1452dac0c08da06a200b2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637829590116901616%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=rZHk%2FgII0qOvr9cmmB8N1auNc1nLSFViVTG9f%2FwEREY%3D&amp;reserved=0
>>> Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> No more comments from me:
>>
>> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Or please let me know if I should pick it up.

Bjorn,

Friendly reminder on this one.

> 
>>> ---
>>> changes from v3->v4:
>>>   * rework comment
>>>   * only evaluate _S0W if necessary
>>>   * drop static function with only one caller
>>>
>>>   drivers/pci/pci-acpi.c | 17 ++++++++++++++++-
>>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>>> index a42dbf448860..e535dab2c888 100644
>>> --- a/drivers/pci/pci-acpi.c
>>> +++ b/drivers/pci/pci-acpi.c
>>> @@ -977,6 +977,7 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>>          const union acpi_object *obj;
>>>          struct acpi_device *adev;
>>>          struct pci_dev *rpdev;
>>> +       unsigned long long ret;
>>>
>>>          if (acpi_pci_disabled || !dev->is_hotplug_bridge)
>>>                  return false;
>>> @@ -1003,7 +1004,21 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>>                                     ACPI_TYPE_INTEGER, &obj) < 0)
>>>                  return false;
>>>
>>> -       return obj->integer.value == 1;
>>> +       if (!obj->integer.value)
>>> +               return false;
>>> +
>>> +       /*
>>> +        * If 'HotPlugSupportInD3' is set, but wakeup is not actually supported,
>>> +        * the former cannot be trusted anyway, so validate it by verifying the
>>> +        * latter.
>>> +        */
>>> +       if (!adev->wakeup.flags.valid)
>>> +               return false;
>>> +
>>> +       if (ACPI_FAILURE(acpi_evaluate_integer(adev->handle, "_S0W", NULL, &ret)))
>>> +               return false;
>>> +
>>> +       return ret >= ACPI_STATE_D3_HOT;
>>>   }
>>>
>>>   int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>>> --
>>> 2.34.1
>>>

