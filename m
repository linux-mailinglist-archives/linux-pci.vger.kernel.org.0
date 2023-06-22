Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9C073A78C
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jun 2023 19:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjFVRoE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jun 2023 13:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFVRoD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 13:44:03 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ED01BD6;
        Thu, 22 Jun 2023 10:44:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+4OhhbikFfFal0bWONIcll1eCcZA0Egs7HyYw67yu94X9+7rmHOVdv5DtCCmUcZ7w7r1EO5mewrXx1VRdIakNQFv9FKyrtvX2Fc8p+zG/tazd+0ubZdyKHxzjlcsT3pzjNgOMww7lXZurnqItL6VNM/T/1kyXMf9KJx+BfftgeD3d+kzBxTHvQ5DvMlYafANH+x4Wlf0+oWwNeixIHlHnsK/rMOnT9OHUW6BuUGTQaCM8y8Ga8jvTMIAksBJ8URzJWxIcCvbKjMcgJOYBmYZcY8hHZjXEaVgkEXnozMFQct2Yul8y7zqcwEViIMeR+GSIdAqmMOrl6DlRKM0HnvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2F46NCMVyuOOf0Ijxktndjmzxkou34JWqbSi9rrUso=;
 b=gmBZqdLRo0CYnWYs9wIKSfcWzO9g+49i+cLbSCAYMT+J1I/aqMGtPx8WgxpEleaJGiB8xg0dfi/h55mVobOgdv/t5gO9gtboyOU9WVG4E/tHBt00UUmh6blJl8sPr9NuvHKJnghceB4NALw0Q3J27/nH9fQlnNgiKyEZ3pWeW5MNRrCJcCAKGMWI+++VYu7yipZ/O6lmmBP/agkTYlx6dNAGzGcxWO/v43CTK40QNwERBngm73fZeCu3u+oBxS6H0vOsRlggyHv+ZlnyHjEEYDZGbjWlW8UfOpm1VwACFXZtyiBAnZwxEqqvspvJme8C7ACxXhb4kBTW5ygwKtkufw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2F46NCMVyuOOf0Ijxktndjmzxkou34JWqbSi9rrUso=;
 b=NQ5fs7tS9+aaA/nhOnRA6l0EmTrUp+3AqGFlWZ8Yk7BOto43ypXxsrOCS2zWRNhmkpdkbWbZ/pgRlHj3nEfDUvl5vtiE5qKsjYZTKF5VmvZzOBKjuMrAOspyhgOkcG7gLVRXuFexDDyuKDDPy3uqXUnJqNnL3PRsBtrzCjU1/s0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Thu, 22 Jun
 2023 17:43:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 17:43:58 +0000
Message-ID: <d361edd0-18b4-b14f-0777-81fa20bb334d@amd.com>
Date:   Thu, 22 Jun 2023 12:43:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4] PCI: Call _REG when transitioning D-states
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <20230621222857.GA122930@bhelgaas>
 <03e5d343-848c-02c7-2deb-917d1b93ce8c@amd.com>
Content-Language: en-US
In-Reply-To: <03e5d343-848c-02c7-2deb-917d1b93ce8c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:5:54::37) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: bd96acac-f697-461c-875e-08db7348420c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+8eJr35ZONh+y2DUnTAIWAJkn+khv7QBl9nXnwDS9WzqeV4iGanDG3kxRit4SXoq5AwvoPcW33mGf33bOeQ7Pu2IUHVhDPOnSYb6TlcUD31O44WqreyV66QsqnOIxl3XK/dazXLzlA0nAjepu6jcMvTrFJCfXqfl0FuDaOE7wML3MKzdUEsJhDSosE7KZtgRxP8RgdtWMkVcur4blPTAPuGJm+PzdbEnQA0AvhCqK9plFURS5BZadp1SVc70+5/Ook80qlJwXTUl6lGEIHKT2qKG+jYG3ffvuc3+y5fH3xNhPXOSh1AbZASOBtHXj8b0tS/HCQLvkY+4Q+ITe4u1rB5bibTADsPrxs5Sz5D5gnAUGTEFIyTm+dNaToEjNeV1Zz76/kT27UWICMe4RO+bReNqYmYiE6mVhwh507xRHlofZstmantYQ62OClOh0wYalIckJMNGNTxK/GLCmRDZ8C7JdiuY03xSZ7QFY3tcrqzDVxgRJdzuYMA3dVCEg/3JLTRG8AX+iMyC0oRN6RGyPdF4tyrm1LKeywgCS8ufWYIhMt2fePMMkeWQ1oCDAw5/N5K03sQrO3nfbwaEi66aPofEN7c8XcWn8ym/aZ58+5hGFiyjx2sU1J9mMflqeKtEQ7G1N7Kru1yj1xwIWudgNwf0cHSrfEBnVilXgJ+mMn6y3ACAZG0CGFRqWBSttNy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199021)(966005)(8936002)(66556008)(8676002)(186003)(66946007)(66476007)(5660300002)(4326008)(54906003)(6486002)(316002)(478600001)(41300700001)(36756003)(26005)(38100700002)(6506007)(6916009)(53546011)(6512007)(86362001)(83380400001)(31696002)(31686004)(2906002)(2616005)(30864003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajZXV1R3d3hzQ0xWZUZLYW9LbisyVXdqcUNZUUEvb2VvMHAweGNscXR5TzI2?=
 =?utf-8?B?OFd2TDZGaldXa2RES0dvcGJLS3hrK2c0QjkrSTArTjhSbitLaXlJc1pvZHZq?=
 =?utf-8?B?VVR5OWpKOEF2Qi9XMjRhRS9CaUR0eUNBRHFHb3lwVjVHcFNBZ0h5cjEzZVRE?=
 =?utf-8?B?T1V3T2lsNDNKRGgvTzNYRUhJbk5mTEY0c3IrNFZ1M3dlT3ZteDczUnFVWld0?=
 =?utf-8?B?cmovaFF4dllCMDdtZ01FS0hsVGYzazlXbVV6ZW13L0hPeXl0R3E5d05wSS9Y?=
 =?utf-8?B?VHZMcmNSTFZwelBUaGNXSGlZY3VtWDg2QTRtSERjWjRiNEFZZmdxQnVKd09L?=
 =?utf-8?B?d2c3amJ0dnRFM25VUUdBaWtjazNtaytJclZXU3FiTE5ndUhWZ0YvY1lleEVM?=
 =?utf-8?B?MlRXL25FL3FIZDhBQmkvanlhR1p5ZHdyU250UVNzNnl2MkhUTk0vM1VnSm1M?=
 =?utf-8?B?dzJDRGF4elVoTXBwVzN6MjVTR0RsWnlFQlNTWDBOa21rZDRvekxXZXhTNlVQ?=
 =?utf-8?B?SmcrTjlVRjArVHUrbG43WHpFRVFmeDUvQVFtVHFrN0xVTzd4R2FSWGs4eVlj?=
 =?utf-8?B?RGdoTVdHV2kxU0dSVkN3MElIc1YrMnR4MWRwR1E2STZJWXhKeXVmTVZvbm94?=
 =?utf-8?B?aWdPa0lDd2Z1LytHK1RWclhyZHFMck4xUzVUNDdNTzhJU1NBUmFIUkl5aGRh?=
 =?utf-8?B?Y2RWN0FMM24xM0hWazFxSURpRkRHRWlGeHZySmJEc2ZjdXdlYnQxZXMvRGRu?=
 =?utf-8?B?dEdCNWl1NGVBbTR1QVArd1lMQ3JSelp3TXE3dWlGdzQ5bUFKRzZxeGxOVjVG?=
 =?utf-8?B?UitGanRIVFd6c1FtSE9Dd0ZtMVJSTVljRFliR05LWXBpMWhlK3hkU1diVGp1?=
 =?utf-8?B?MDViWVZRWkRiczZudUhYdHJVemhEL2dpb1RIM1prTzdEQkVxZXJPZVBzUS9U?=
 =?utf-8?B?cWNQM1o2MGs1NTdhTTNBb3ZqbDluTXNTeWEyMTMxQk52YWtzbVUwTVV1ZlNn?=
 =?utf-8?B?NXkxTmMvYkR3emJWY1VCTGUzek5JZW5hYVFBdnZ6SGRoYXR1TWRXUjBLZ0Er?=
 =?utf-8?B?YW9CMEY1dWQrMGZjRkVYOGE3UWpKWTdDVU04bHhIZTR0bXNJcUdTVTdJNHNq?=
 =?utf-8?B?SUxnUVB5ZzNRVnNBb2dZWXJNU2g5dmdXby9aTWlYc2FYb0VvK01yaTNVV0V5?=
 =?utf-8?B?alpGaHJSeVl3Q3NKdHlPU2g0a2F3SWhTNVRyem5PY0tHSDErQzFUUEFnMjho?=
 =?utf-8?B?eVZQQzRUV01MRGVrVDFjclNQdUl2YWo4WmRWdjZRTzIzNm04eFZQVTY1d21F?=
 =?utf-8?B?SFd2elcrWThBczN2OXVGRGw1QW1DZ0hiU20yc0VxaWFJc2FvRE93WlJJaXFW?=
 =?utf-8?B?bElsOE5EcnVVYXpKazlibzhldWlHUDlnUUxUR1RVYWNOQkhlbTVZQkl5b0xs?=
 =?utf-8?B?SVZ4QzVVWmZWZ3phY25KRDdmOEVReWZVS0JPSTJJOGJVMFgxZHlEdXpGWlBV?=
 =?utf-8?B?aGNwZGdMNjN5ejNzaHB2bmp0bzR1RmFhT05VMnJ6K0Q2T2U1a0lNWmc4bERo?=
 =?utf-8?B?QXBsa0h4SXZEWWZMb21JVjZ1aHdqekc2MGNKMCt3a0RPWEFtWVEvT1crTFJM?=
 =?utf-8?B?MWl2Y0MrMWhYT205RU16TnhCVmQ2WXNiemdyT1F4WHNyUERnS0RkQVAwWUFp?=
 =?utf-8?B?K0d6T29UcFBiMGxXWVNIUjFTSWJ6dVNJNG1ISENrU2V5RDREQkEzS3Q3a0RS?=
 =?utf-8?B?QklTMkgza3hNZzZxWDJzc1RQV09TekptUFFWRm0xUTlhWnNVTGVqU3dMclBG?=
 =?utf-8?B?ekRvajBkWGYzbzQ5ajQrZGR0TFA0WWJwNTBFNDQvempvd3pQMzRxWWs4Q2sw?=
 =?utf-8?B?Y1ZyT0xVQ0ZBcGhHQlIzVWhhbm9qdCtRUWZ4dytIRURGKzB5dkZBNnhac0NE?=
 =?utf-8?B?ZXhFRkJyZWlxcGU5dHg4U0wzMHd5KzRBVzJKWGhFc2diZUwxWFR6MVhzSHV4?=
 =?utf-8?B?UXZnem1BM2tjSmV2N3drR1ZEbXl4ekR6ZHZMcmxaVVltWnVqMi9vQkxQTlZu?=
 =?utf-8?B?THp2a3JZYkJNbGRnaVVnWlU2bkhMSjFFUExVYjlZWm43NXQxakhhdDl6ZktY?=
 =?utf-8?Q?bJqbjKFtJ1qsVsuoIatQPazpr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd96acac-f697-461c-875e-08db7348420c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 17:43:58.7441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/FjtS62dIf/NEslcuRmTA4DfRsJi0XbOKrJ4gi4FD6QdCBcNbbn+kkCXkiI5KxY7RHZp3+OYyCYcOQTRgSC+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/21/2023 5:52 PM, Limonciello, Mario wrote:
>
> On 6/21/2023 5:28 PM, Bjorn Helgaas wrote:
>> On Tue, Jun 20, 2023 at 09:04:51AM -0500, Mario Limonciello wrote:
>>> Section 6.5.4 of the ACPI 6.4 spec describes how AML is unable to 
>>> access
>>> an OperationRegion unless `_REG` has been called.
>>>
>>> "The OS runs _REG control methods to inform AML code of a change in the
>>> availability of an operation region. When an operation region handler
>>> is unavailable, AML cannot access data fields in that region.
>>> (Operation region writes will be ignored and reads will return
>>> indeterminate data.)"
>>>
>>> The PCI core does not call `_REG` at anytime, leading to the undefined
>>> behavior mentioned in the spec.
>> I got lost in the maze of users of ACPI_ADR_SPACE_PCI_CONFIG, but is
>> it really true that we never call _REG for PCI config space at all
>> today?
> I double checked a BIOS debug log which shows ACPI calls
> to confirm and didn't see a single _REG call for any device
> before this patch across a boot/suspend/resume cycle.
>>
>> If so, I guess AML that uses ACPI_ADR_SPACE_PCI_CONFIG won't work
>> until after we set the relevant device to D0?
> The particular problem that that exposed this issue doesn't
> happen until suspend/resume time, but yes I think this should
> be called when setting the device to D0.
>>
>> Do we explicitly set devices to D0 during enumeration, e.g., somewhere
>> in the pci_scan_device() path?  If not, should we?
> AFAICT it's happening for PCIe ports as part of:
> pcie_portdrv_probe
> ->pcie_port_device_register
> ->->pci_enable_device
> ->->->pci_enable_device_flags
> ->->->->do_pci_enable_device
> ->->->->->pci_set_power_state(pci_dev, PCI_D0)


Just to add to this; I double checked and one of the devices that doesn't
have a driver on my system has the power_state set to "unknown". I don't
think it would be appropriate to explicitly put "all devices without 
drivers"
into D0 as this could block low power states for the SOC.

On the Intel side, there is some special stuff in intel-pmc-core for example
that explicitly puts specific driverless devices into D3 to ensure low power
states.  If we put everything without a driver into D0 we may break 
stuff like
that.


>>
>> If we don't set things to D0 during enumeration, it seems like this
>> AML won't work until we suspend and resume the device.
>>
>> Separately, I propose a minor restructuring to avoid the need for
>> mentioning PCI_POWER_ERROR and PCI_UNKNOWN.  Checking for those means
>> we need to look at the definitions to be sure we cover all cases, and
>> it also doesn't solve the problem that a caller can pass undefined
>> pci_power_t values that would index outside the state_conv[].
>>
>> Possible rework attached below.  I also like the fact that it makes
>> the _REG patch very simple and specific to _REG.
>
> I like your rework as well.
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> For the new patch.
>
>>
>>> The spec explains that _REG should be executed to indicate whether a
>>> given region can be accessed.
>>>
>>> "Once _REG has been executed for a particular operation region, 
>>> indicating
>>> that the operation region handler is ready, a control method can
>>> access fields in the operation region. Conversely, control methods
>>> must not access fields in operation regions when _REG method execution
>>> has not indicated that the operation region handler is ready."
>>>
>>> An example included in the spec demonstrates calling _REG when 
>>> devices are
>>> turned off: "when the host controller or bridge controller is turned 
>>> off
>>> or disabled, PCI Config Space Operation Regions for child devices are
>>> no longer available. As such, ETH0’s _REG method will be run when it
>>> is turned off and will again be run when PCI1 is turned off.".
>>>
>>> It is reported that ASMedia PCIe GPIO controllers fail functional tests
>>> after the system has returning from suspend (S3 or s2idle). This is
>>> because the BIOS checks whether the OSPM has called the `_REG` method
>>> to determine whether it can interact with the OperationRegion assigned
>>> to the device as part of the other AML called for the device.
>>>
>>> To fix this issue, call acpi_evaluate_reg() when devices are
>>> transitioning to D3cold or D0.
>>>
>>> Link: 
>>> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>>> index 052a611081ec..182cac535250 100644
>>> --- a/drivers/pci/pci-acpi.c
>>> +++ b/drivers/pci/pci-acpi.c
>>> @@ -1043,6 +1043,16 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>>       return false;
>>>   }
>>>   +static void acpi_pci_config_space_access(struct pci_dev *dev, 
>>> bool enable)
>>> +{
>>> +    int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
>>> +    int ret = acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
>>> +                    ACPI_ADR_SPACE_PCI_CONFIG, val);
>>> +    if (ret)
>>> +        pci_dbg(dev, "ACPI _REG %s evaluation failed (%d)\n",
>>> +            enable ? "connect" : "disconnect", ret);
>>> +}
>>> +
>>>   int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>>>   {
>>>       struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
>>> @@ -1053,32 +1063,36 @@ int acpi_pci_set_power_state(struct pci_dev 
>>> *dev, pci_power_t state)
>>>           [PCI_D3hot] = ACPI_STATE_D3_HOT,
>>>           [PCI_D3cold] = ACPI_STATE_D3_COLD,
>>>       };
>>> -    int error = -EINVAL;
>>> +    int ret;
>>>         /* If the ACPI device has _EJ0, ignore the device */
>>>       if (!adev || acpi_has_method(adev->handle, "_EJ0"))
>>>           return -ENODEV;
>>>         switch (state) {
>>> +    case PCI_POWER_ERROR:
>>> +    case PCI_UNKNOWN:
>>> +        return -EINVAL;
>>>       case PCI_D3cold:
>>>           if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
>>> -                PM_QOS_FLAGS_ALL) {
>>> -            error = -EBUSY;
>>> -            break;
>>> -        }
>>> -        fallthrough;
>>> -    case PCI_D0:
>>> -    case PCI_D1:
>>> -    case PCI_D2:
>>> -    case PCI_D3hot:
>>> -        error = acpi_device_set_power(adev, state_conv[state]);
>>> +                     PM_QOS_FLAGS_ALL)
>>> +            return -EBUSY;
>>> +        /* Notify AML lack of PCI config space availability */
>>> +        acpi_pci_config_space_access(dev, false);
>>> +        break;
>>>       }
>>>   -    if (!error)
>>> -        pci_dbg(dev, "power state changed by ACPI to %s\n",
>>> - acpi_power_state_string(adev->power.state));
>>> +    ret = acpi_device_set_power(adev, state_conv[state]);
>>> +    if (ret)
>>> +        return ret;
>>> +    pci_dbg(dev, "power state changed by ACPI to %s\n",
>>> +        acpi_power_state_string(adev->power.state));
>>>   -    return error;
>>> +    /* Notify AML of PCI config space availability */
>>> +    if (state == PCI_D0)
>>> +        acpi_pci_config_space_access(dev, true);
>>> +
>>> +    return 0;
>>>   }
>>>     pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
>>
>> commit 79d4fdf58711 ("PCI/PM: Validate acpi_pci_set_power_state() 
>> parameter")
>> Author: Bjorn Helgaas <bhelgaas@google.com>
>> Date:   Wed Jun 21 16:36:12 2023 -0500
>>
>>      PCI/PM: Validate acpi_pci_set_power_state() parameter
>>           Previously acpi_pci_set_power_state() assumed the requested 
>> power state was
>>      valid (PCI_D0 ... PCI_D3cold).  If a caller supplied something 
>> else, we
>>      could index outside the state_conv[] array and pass junk to
>>      acpi_device_set_power().
>>           Validate the pci_power_t parameter and return -EINVAL if 
>> it's invalid.
>>           Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 052a611081ec..bf545f719182 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -1053,32 +1053,37 @@ int acpi_pci_set_power_state(struct pci_dev 
>> *dev, pci_power_t state)
>>           [PCI_D3hot] = ACPI_STATE_D3_HOT,
>>           [PCI_D3cold] = ACPI_STATE_D3_COLD,
>>       };
>> -    int error = -EINVAL;
>> +    int error;
>>         /* If the ACPI device has _EJ0, ignore the device */
>>       if (!adev || acpi_has_method(adev->handle, "_EJ0"))
>>           return -ENODEV;
>>         switch (state) {
>> -    case PCI_D3cold:
>> -        if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
>> -                PM_QOS_FLAGS_ALL) {
>> -            error = -EBUSY;
>> -            break;
>> -        }
>> -        fallthrough;
>>       case PCI_D0:
>>       case PCI_D1:
>>       case PCI_D2:
>>       case PCI_D3hot:
>> -        error = acpi_device_set_power(adev, state_conv[state]);
>> +    case PCI_D3cold:
>> +        break;
>> +    default:
>> +        return -EINVAL;
>>       }
>>   -    if (!error)
>> -        pci_dbg(dev, "power state changed by ACPI to %s\n",
>> -                acpi_power_state_string(adev->power.state));
>> +    if (state == PCI_D3cold) {
>> +        if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
>> +                PM_QOS_FLAGS_ALL)
>> +            return -EBUSY;
>> +    }
>>   -    return error;
>> +    error = acpi_device_set_power(adev, state_conv[state]);
>> +    if (error)
>> +        return error;
>> +
>> +    pci_dbg(dev, "power state changed by ACPI to %s\n",
>> +            acpi_power_state_string(adev->power.state));
>> +
>> +    return 0;
>>   }
>>     pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
>> commit 746652bd0376 ("PCI/PM: Call _REG when transitioning D-states")
>> Author: Mario Limonciello <mario.limonciello@amd.com>
>> Date:   Tue Jun 20 09:04:51 2023 -0500
>>
>>      PCI/PM: Call _REG when transitioning D-states
>>           ACPI r6.5, sec 6.5.4, describes how AML is unable to access an
>>      OperationRegion unless _REG has been called to connect a handler:
>>             The OS runs _REG control methods to inform AML code of a 
>> change in the
>>        availability of an operation region. When an operation region 
>> handler is
>>        unavailable, AML cannot access data fields in that region.  
>> (Operation
>>        region writes will be ignored and reads will return 
>> indeterminate data.)
>>           The PCI core does not call _REG at any time, leading to the 
>> undefined
>>      behavior mentioned in the spec.
>>           The spec explains that _REG should be executed to indicate 
>> whether a
>>      given region can be accessed:
>>             Once _REG has been executed for a particular operation 
>> region, indicating
>>        that the operation region handler is ready, a control method 
>> can access
>>        fields in the operation region. Conversely, control methods 
>> must not
>>        access fields in operation regions when _REG method execution 
>> has not
>>        indicated that the operation region handler is ready.
>>           An example included in the spec demonstrates calling _REG 
>> when devices are
>>      turned off: "when the host controller or bridge controller is 
>> turned off
>>      or disabled, PCI Config Space Operation Regions for child 
>> devices are
>>      no longer available. As such, ETH0’s _REG method will be run 
>> when it
>>      is turned off and will again be run when PCI1 is turned off."
>>           It is reported that ASMedia PCIe GPIO controllers fail 
>> functional tests
>>      after the system has returning from suspend (S3 or s2idle). This 
>> is because
>>      the BIOS checks whether the OSPM has called the _REG method to 
>> determine
>>      whether it can interact with the OperationRegion assigned to the 
>> device as
>>      part of the other AML called for the device.
>>           To fix this issue, call acpi_evaluate_reg() when devices 
>> are transitioning
>>      to D3cold or D0.
>>           Link: 
>> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
>>      Link: 
>> https://lore.kernel.org/r/20230620140451.21007-1-mario.limonciello@amd.com
>>      Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>      Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
>>
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index bf545f719182..a05350a4e49c 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -1043,6 +1043,16 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>       return false;
>>   }
>>   +static void acpi_pci_config_space_access(struct pci_dev *dev, bool 
>> enable)
>> +{
>> +    int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
>> +    int ret = acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
>> +                    ACPI_ADR_SPACE_PCI_CONFIG, val);
>> +    if (ret)
>> +        pci_dbg(dev, "ACPI _REG %s evaluation failed (%d)\n",
>> +            enable ? "connect" : "disconnect", ret);
>> +}
>> +
>>   int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>>   {
>>       struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
>> @@ -1074,6 +1084,9 @@ int acpi_pci_set_power_state(struct pci_dev 
>> *dev, pci_power_t state)
>>           if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
>>                   PM_QOS_FLAGS_ALL)
>>               return -EBUSY;
>> +
>> +        /* Notify AML lack of PCI config space availability */
>> +        acpi_pci_config_space_access(dev, false);
>>       }
>>         error = acpi_device_set_power(adev, state_conv[state]);
>> @@ -1083,6 +1096,15 @@ int acpi_pci_set_power_state(struct pci_dev 
>> *dev, pci_power_t state)
>>       pci_dbg(dev, "power state changed by ACPI to %s\n",
>>               acpi_power_state_string(adev->power.state));
>>   +    /*
>> +     * Notify AML of PCI config space availability.  Config space is
>> +     * accessible in all states except D3cold; the only transitions
>> +     * that change availability are transitions to D3cold and from
>> +     * D3cold to D0.
>> +     */
>> +    if (state == PCI_D0)
>> +        acpi_pci_config_space_access(dev, true);
>> +
>>       return 0;
>>   }
