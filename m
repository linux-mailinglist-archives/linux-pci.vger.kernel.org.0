Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024637392B8
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jun 2023 00:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjFUWxI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 18:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFUWxG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 18:53:06 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A89F19AC;
        Wed, 21 Jun 2023 15:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcdkRi+fVWHDHSuPczfG6rv6l+PIPVxMangMf7qhemfab00r3nKrgwFOdeNtXmZwwxOcbslLR1sDYeLDn3+gwpX2WqiPuH7bwClsRpO/ocru52J1Pu0CNweuFaclVMrl/Rr0krKrbWusfPsXBf+MiIWabViFoWH38CbzGj4BsYi+T1Dd9FC0dTC3adeG7yiUdB/KhiYRI0j7DW90ZnzmQY8RJLNe8bgdT5z2nhbOzNaRv7w/kH2oidqPvBrJ7H2FDH7+wbU1jCxxzjxiS/pz0KBDg9phHckHWJow5db25EsTqc8sn/lXyiOfpNF26BkWgpR7m+uZxqm201wo4HiY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SI9vq+0PjRHrMYw1UAulgu2pQuEfihDzO3LlqSWFObc=;
 b=g4u4Vw///a+ETVFXv2WzMZ7xff6NNurqAyLrgDMFGTK2OKLKU5jE3g7mFpiLw1L4PeGfVAG/hiZeD4/jqnmZPOvykYdEaQo/LPQ2QfXQsBWrgE/h2lb5n78MkGDtk42WQ1IMzNU+cqeGIs6+SDtdP5woG32s0CU/+J4KFDQC3L4xN2ujCJQAx4BhWNOsMAKJygAAsoG0y51F9z37owA9R9K2G+ASPwJDKfGFJkQANvb2b9aeuFo7LeAgxDP+fmPE6zc1VAVYotH1On1YVVPOJ40Grtsq3PjIycf9h4J3MMX59NCCP9Xd97mjMfN+i/PzvdQwpWqYA9lyB78Y9GBglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI9vq+0PjRHrMYw1UAulgu2pQuEfihDzO3LlqSWFObc=;
 b=nL1iKYDdw3uA+lRWNHMOGrBwoYNHXrdOw7Yg1uHCobiG8/2XErJRi/u8qqQylbSIhnmFHOasT/XaQjzr/uXakHkyu5+N93ukahFyRKy25IdrTh9yXWQmABspnw8S1kjYHh+9gveYlicrCSJJh3Bx/ODCfDwZwLyisMyDEGTd+3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5065.namprd12.prod.outlook.com (2603:10b6:408:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 22:53:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 22:53:01 +0000
Message-ID: <03e5d343-848c-02c7-2deb-917d1b93ce8c@amd.com>
Date:   Wed, 21 Jun 2023 17:52:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4] PCI: Call _REG when transitioning D-states
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <20230621222857.GA122930@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230621222857.GA122930@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0064.namprd04.prod.outlook.com
 (2603:10b6:806:121::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN9PR12MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cbc5d45-4fba-49f5-9481-08db72aa43cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4iSQCncIT/UCSU5g5/Hia7cdjgmtD+C/UxhvcGB74IAhO4bEesiISGiqvD9oLVtloOejCL38WSD5DJ05pTn7HGGf/TiKdyu0Wx3WOc5tSEYDWROwZkgbOEs94TnL2fMmWwIJlXifNZK/uQBXMWb28Gjvpi+qZDcz8+9hD3OqZw3YhFLrzMl/V3E8hwMI4O2RrLy8obDqH0GqmAKY9UVauioJbZelN1vQNNrxfzdP/YOxNgvil4MA+occmKFgQ6KI3L6WTdc1Xzs2TqRsasbZS3gtWLKf9CXusIMilqGPq+dnq97ZTHkNmn6QvdkyCVqJAgEsodmBp+xdqn5M2bk7ofCDpNbX9OON9Ly5WqUgQVyUrBLSxan5k78QlyT06R5+ggErGEogWFG390Xa/BFJFBJH3VAvqcdXPg3O9HEnmxtoHioiE4jop/oz0EA9St0XZM0oScIavOnk/n5T0R69RjeDVkFaw63c2mG8zLUf+sPMOtbnbZlCqn7Wlf4T/+jx56ZmemzFqq9AmkAxuZe7+7Ijo6BH/xHR+dZ2yta/otad/CB4RQe8gRV5KhrsQ75ALkD1b1JDmuf9WLdIp1OzDig9kULcQ13N+PiIDybIpNPFlDPLyBzbqDnmL8NoZ0CtEw8fY7rVRH15viRUAwc2aWHZTp3jie+uA6NyublalWp1/cs1R3QNX2+ew2k/L33
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199021)(36756003)(38100700002)(86362001)(31696002)(31686004)(4326008)(6486002)(41300700001)(8676002)(966005)(5660300002)(26005)(8936002)(53546011)(6506007)(478600001)(2616005)(30864003)(186003)(83380400001)(2906002)(54906003)(316002)(66946007)(6666004)(66476007)(6916009)(6512007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlNnYWdWeXJlNWs3YnozbHYzeEpxQWJlQkpyZ0FoaDVMbFpaVDBlWCs2ek84?=
 =?utf-8?B?WVdVQThUUTBBWkZHTkkrdXhSazB2dU81K3dRbjI2LzY4T3A1MWZNN2tobmZ2?=
 =?utf-8?B?Z3N4aXdrck9IcVNRU3BXbnRRRDhOaUxXRGRpSHB0eDRmakduaFB3TXB1TldH?=
 =?utf-8?B?U2s3ZEU2cnhLS3BkMWIrT1lLWWZBakxXYUtLM0hWcHVXNGhIY0dXc09ZeFhv?=
 =?utf-8?B?eURlM3VYK05oZVlmZXNSaDFUMVZwelpqcmorTVVzZ09pZmhuUTZnZ3g5UjR4?=
 =?utf-8?B?RHFLOEtjcno0SVNaVG56Ni9lbUxSQlJlZjEwR3FjeGRQWVBhcUNiZGc1NWNS?=
 =?utf-8?B?VnNVY1Y2NkR3ZEFmRWNtNThUUjVpSjZSdVc5bFVXbTZ5ZXEyTlYwaERnUStk?=
 =?utf-8?B?V0M1OXEva0t3N2U4b21pZ1lVMGtYeDF3NG4vOW1GMHRzMTFnMWg3YkRZcUta?=
 =?utf-8?B?ZkczQ05mUGJnY0JvY3EvRTl3aXNtZHJzbXEyVm04MlJYalZzaENxZ1drM3Qw?=
 =?utf-8?B?Ykl5QVpweTEwVnVRRnVHcXIvTjhOMzRYYS9OWHlQWHhoTURGeVFlQ2tpcHZB?=
 =?utf-8?B?REM4MTB3NzVqWWFZeWh5OVNqK1ZEUDBkbFZBdE1uQW8yeGpqd3dCV3hKRVlk?=
 =?utf-8?B?cGpnaGw3Zm5xYXZRNWhxS0ZJbDRCVkVCNHJTOW9kUUR5TVVCdG1LcDUwYmp1?=
 =?utf-8?B?MEVNMGVpSGRxR0RrQUh2d3ZEb2tPUlIxb2NXN21rUmJBaDVxK0FleXFJdzla?=
 =?utf-8?B?ZWd6SjZ4eVA2WUcvWFMyaWgxZjFSTnNlMHFUc09uMGxwV1k5MlpIVmVrY3BZ?=
 =?utf-8?B?WmZRdmJydG1MRHNhb0gxWXQ0ck5nVWRHb1MxSUZpSldtS2ZOR1NwdEtzTlQ1?=
 =?utf-8?B?QmV6cHdaMGoxa2RIUDVLNng3WGRMTkg1Y295Wlo4RzNSODN5Sk9wYWJnd2J3?=
 =?utf-8?B?b29sK1RMb2piQzVYb3ZGVDlidkNrUGlZMzh4dSthTno0N1VRaEJWemFZWUgv?=
 =?utf-8?B?bU5DbVUyTHYyOStOMFF0U2RjbVRuNTJ3Zi90YkFrTnkxN1RGWnBHN2MraThn?=
 =?utf-8?B?Qk12NjFqM1J4bXJJVGJHa2tMTmo0RkpGNmhlSld2clFMYmhBVFk1ZDVSUURr?=
 =?utf-8?B?VHRzL25jS1RPaDBNdDREcEFiT0JpazRVTE12eFoyaEN4WGNPZDhIeGRyWGhN?=
 =?utf-8?B?eDRxK2FhYWVUM1ZvMzJSOThxckpIQUZxZ2hVZmxXamlGN1RSTWlYY0RyOHBz?=
 =?utf-8?B?eHhOVEg0UHRKSnByQjR6cW9ESGVma2w3N0JBcGNaRFNWZ0dJRitIYTlrUExG?=
 =?utf-8?B?aDhTUmxRbzJ2ZHhNS1dwclpiSmQyU0o1NVhXejlHNzhjU2t2c2paMmJYWExN?=
 =?utf-8?B?c3p2TTdOaWNkY0FERkxBM3RTUXdaNWVnbE9vcDIySitYWk1qL2lKSGtPYTlP?=
 =?utf-8?B?SmsxWEJGSzJjRnVPWlNNZzN4MG1vRGM1VEpFdnZ5QmJXQTFmMUFTMTJ0b1Vz?=
 =?utf-8?B?MjdXK0ZYeTE1QkJIYzBsTXExclV4anl5SUs2dC9QSW1kcll0QWlnWjZXQ0Y5?=
 =?utf-8?B?T2I4RkswTlRLUStNdzdjUTFhRlgwZVVmQlhrbDJEQ0F1K1ZIaWVDbm5EUTJp?=
 =?utf-8?B?eDF3bmNuVXJPMW9sYk83NXQyZTlVVXovSmNzcCtpaTJZNStoazdhVE5mTnQ1?=
 =?utf-8?B?aXZZTmxPYXptcldkd21OMjFoUDQrTmVCL0FQSU92ellnTDV3LzdSTTdPZy9W?=
 =?utf-8?B?VUd2MWNJSmFndE51OWVnOCtJVTdlTW9KNlpWYkIyRTgwWHB3K0VET1pjUDZ0?=
 =?utf-8?B?QUVVSlFxZlNrZlpyRnhBcU50T2hPNFU2cElReUs1cVFKdXg1UHVPYmlCRWV6?=
 =?utf-8?B?eDJpdS9GZS9WWGplZzNJRzBNV3FnYXhXQm1kYnd5V2tuV1RPcUE1cU8wbmp5?=
 =?utf-8?B?ZFN1dHAwajU2cnV1S0ZmOFNYRXdXT2g0amI0YVlOUCtNMXB6dVRRRDVLZXZG?=
 =?utf-8?B?R09iTmpkeVhWTjh6NGw3MzExYmpFY3l4Z2k5MEt2RTBtYmh2Zjd2SU52MVZE?=
 =?utf-8?B?V1BVQ1JGSGR5eUcyb2ZtWVRNQm55a3ZkVzlOV2tJc29Zd1FzMkhyZ1MzdHd0?=
 =?utf-8?Q?oYQV25naElfOYujfl3vQeYajS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbc5d45-4fba-49f5-9481-08db72aa43cb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 22:53:01.1969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiAm4Zk8Bw2LbkDadiqgFQkZV72ybCJsj9nP3m1OeEn6PYAHq+CAGv9M0bZpILQo6Gdwr1mSoSKcIslUnPmiaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5065
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


On 6/21/2023 5:28 PM, Bjorn Helgaas wrote:
> On Tue, Jun 20, 2023 at 09:04:51AM -0500, Mario Limonciello wrote:
>> Section 6.5.4 of the ACPI 6.4 spec describes how AML is unable to access
>> an OperationRegion unless `_REG` has been called.
>>
>> "The OS runs _REG control methods to inform AML code of a change in the
>> availability of an operation region. When an operation region handler
>> is unavailable, AML cannot access data fields in that region.
>> (Operation region writes will be ignored and reads will return
>> indeterminate data.)"
>>
>> The PCI core does not call `_REG` at anytime, leading to the undefined
>> behavior mentioned in the spec.
> I got lost in the maze of users of ACPI_ADR_SPACE_PCI_CONFIG, but is
> it really true that we never call _REG for PCI config space at all
> today?
I double checked a BIOS debug log which shows ACPI calls
to confirm and didn't see a single _REG call for any device
before this patch across a boot/suspend/resume cycle.
>
> If so, I guess AML that uses ACPI_ADR_SPACE_PCI_CONFIG won't work
> until after we set the relevant device to D0?
The particular problem that that exposed this issue doesn't
happen until suspend/resume time, but yes I think this should
be called when setting the device to D0.
>
> Do we explicitly set devices to D0 during enumeration, e.g., somewhere
> in the pci_scan_device() path?  If not, should we?
AFAICT it's happening for PCIe ports as part of:
pcie_portdrv_probe
->pcie_port_device_register
->->pci_enable_device
->->->pci_enable_device_flags
->->->->do_pci_enable_device
->->->->->pci_set_power_state(pci_dev, PCI_D0)
>
> If we don't set things to D0 during enumeration, it seems like this
> AML won't work until we suspend and resume the device.
>
> Separately, I propose a minor restructuring to avoid the need for
> mentioning PCI_POWER_ERROR and PCI_UNKNOWN.  Checking for those means
> we need to look at the definitions to be sure we cover all cases, and
> it also doesn't solve the problem that a caller can pass undefined
> pci_power_t values that would index outside the state_conv[].
>
> Possible rework attached below.  I also like the fact that it makes
> the _REG patch very simple and specific to _REG.

I like your rework as well.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
For the new patch.

>
>> The spec explains that _REG should be executed to indicate whether a
>> given region can be accessed.
>>
>> "Once _REG has been executed for a particular operation region, indicating
>> that the operation region handler is ready, a control method can
>> access fields in the operation region. Conversely, control methods
>> must not access fields in operation regions when _REG method execution
>> has not indicated that the operation region handler is ready."
>>
>> An example included in the spec demonstrates calling _REG when devices are
>> turned off: "when the host controller or bridge controller is turned off
>> or disabled, PCI Config Space Operation Regions for child devices are
>> no longer available. As such, ETH0’s _REG method will be run when it
>> is turned off and will again be run when PCI1 is turned off.".
>>
>> It is reported that ASMedia PCIe GPIO controllers fail functional tests
>> after the system has returning from suspend (S3 or s2idle). This is
>> because the BIOS checks whether the OSPM has called the `_REG` method
>> to determine whether it can interact with the OperationRegion assigned
>> to the device as part of the other AML called for the device.
>>
>> To fix this issue, call acpi_evaluate_reg() when devices are
>> transitioning to D3cold or D0.
>>
>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 052a611081ec..182cac535250 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -1043,6 +1043,16 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>   	return false;
>>   }
>>   
>> +static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
>> +{
>> +	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
>> +	int ret = acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
>> +				    ACPI_ADR_SPACE_PCI_CONFIG, val);
>> +	if (ret)
>> +		pci_dbg(dev, "ACPI _REG %s evaluation failed (%d)\n",
>> +			enable ? "connect" : "disconnect", ret);
>> +}
>> +
>>   int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>>   {
>>   	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
>> @@ -1053,32 +1063,36 @@ int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>>   		[PCI_D3hot] = ACPI_STATE_D3_HOT,
>>   		[PCI_D3cold] = ACPI_STATE_D3_COLD,
>>   	};
>> -	int error = -EINVAL;
>> +	int ret;
>>   
>>   	/* If the ACPI device has _EJ0, ignore the device */
>>   	if (!adev || acpi_has_method(adev->handle, "_EJ0"))
>>   		return -ENODEV;
>>   
>>   	switch (state) {
>> +	case PCI_POWER_ERROR:
>> +	case PCI_UNKNOWN:
>> +		return -EINVAL;
>>   	case PCI_D3cold:
>>   		if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
>> -				PM_QOS_FLAGS_ALL) {
>> -			error = -EBUSY;
>> -			break;
>> -		}
>> -		fallthrough;
>> -	case PCI_D0:
>> -	case PCI_D1:
>> -	case PCI_D2:
>> -	case PCI_D3hot:
>> -		error = acpi_device_set_power(adev, state_conv[state]);
>> +				     PM_QOS_FLAGS_ALL)
>> +			return -EBUSY;
>> +		/* Notify AML lack of PCI config space availability */
>> +		acpi_pci_config_space_access(dev, false);
>> +		break;
>>   	}
>>   
>> -	if (!error)
>> -		pci_dbg(dev, "power state changed by ACPI to %s\n",
>> -		        acpi_power_state_string(adev->power.state));
>> +	ret = acpi_device_set_power(adev, state_conv[state]);
>> +	if (ret)
>> +		return ret;
>> +	pci_dbg(dev, "power state changed by ACPI to %s\n",
>> +		acpi_power_state_string(adev->power.state));
>>   
>> -	return error;
>> +	/* Notify AML of PCI config space availability */
>> +	if (state == PCI_D0)
>> +		acpi_pci_config_space_access(dev, true);
>> +
>> +	return 0;
>>   }
>>   
>>   pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
>
> commit 79d4fdf58711 ("PCI/PM: Validate acpi_pci_set_power_state() parameter")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Wed Jun 21 16:36:12 2023 -0500
>
>      PCI/PM: Validate acpi_pci_set_power_state() parameter
>      
>      Previously acpi_pci_set_power_state() assumed the requested power state was
>      valid (PCI_D0 ... PCI_D3cold).  If a caller supplied something else, we
>      could index outside the state_conv[] array and pass junk to
>      acpi_device_set_power().
>      
>      Validate the pci_power_t parameter and return -EINVAL if it's invalid.
>      
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 052a611081ec..bf545f719182 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1053,32 +1053,37 @@ int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>   		[PCI_D3hot] = ACPI_STATE_D3_HOT,
>   		[PCI_D3cold] = ACPI_STATE_D3_COLD,
>   	};
> -	int error = -EINVAL;
> +	int error;
>   
>   	/* If the ACPI device has _EJ0, ignore the device */
>   	if (!adev || acpi_has_method(adev->handle, "_EJ0"))
>   		return -ENODEV;
>   
>   	switch (state) {
> -	case PCI_D3cold:
> -		if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
> -				PM_QOS_FLAGS_ALL) {
> -			error = -EBUSY;
> -			break;
> -		}
> -		fallthrough;
>   	case PCI_D0:
>   	case PCI_D1:
>   	case PCI_D2:
>   	case PCI_D3hot:
> -		error = acpi_device_set_power(adev, state_conv[state]);
> +	case PCI_D3cold:
> +		break;
> +	default:
> +		return -EINVAL;
>   	}
>   
> -	if (!error)
> -		pci_dbg(dev, "power state changed by ACPI to %s\n",
> -		        acpi_power_state_string(adev->power.state));
> +	if (state == PCI_D3cold) {
> +		if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
> +				PM_QOS_FLAGS_ALL)
> +			return -EBUSY;
> +	}
>   
> -	return error;
> +	error = acpi_device_set_power(adev, state_conv[state]);
> +	if (error)
> +		return error;
> +
> +	pci_dbg(dev, "power state changed by ACPI to %s\n",
> +	        acpi_power_state_string(adev->power.state));
> +
> +	return 0;
>   }
>   
>   pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
> commit 746652bd0376 ("PCI/PM: Call _REG when transitioning D-states")
> Author: Mario Limonciello <mario.limonciello@amd.com>
> Date:   Tue Jun 20 09:04:51 2023 -0500
>
>      PCI/PM: Call _REG when transitioning D-states
>      
>      ACPI r6.5, sec 6.5.4, describes how AML is unable to access an
>      OperationRegion unless _REG has been called to connect a handler:
>      
>        The OS runs _REG control methods to inform AML code of a change in the
>        availability of an operation region. When an operation region handler is
>        unavailable, AML cannot access data fields in that region.  (Operation
>        region writes will be ignored and reads will return indeterminate data.)
>      
>      The PCI core does not call _REG at any time, leading to the undefined
>      behavior mentioned in the spec.
>      
>      The spec explains that _REG should be executed to indicate whether a
>      given region can be accessed:
>      
>        Once _REG has been executed for a particular operation region, indicating
>        that the operation region handler is ready, a control method can access
>        fields in the operation region. Conversely, control methods must not
>        access fields in operation regions when _REG method execution has not
>        indicated that the operation region handler is ready.
>      
>      An example included in the spec demonstrates calling _REG when devices are
>      turned off: "when the host controller or bridge controller is turned off
>      or disabled, PCI Config Space Operation Regions for child devices are
>      no longer available. As such, ETH0’s _REG method will be run when it
>      is turned off and will again be run when PCI1 is turned off."
>      
>      It is reported that ASMedia PCIe GPIO controllers fail functional tests
>      after the system has returning from suspend (S3 or s2idle). This is because
>      the BIOS checks whether the OSPM has called the _REG method to determine
>      whether it can interact with the OperationRegion assigned to the device as
>      part of the other AML called for the device.
>      
>      To fix this issue, call acpi_evaluate_reg() when devices are transitioning
>      to D3cold or D0.
>      
>      Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
>      Link: https://lore.kernel.org/r/20230620140451.21007-1-mario.limonciello@amd.com
>      Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>      Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
>
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index bf545f719182..a05350a4e49c 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1043,6 +1043,16 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>   	return false;
>   }
>   
> +static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
> +{
> +	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
> +	int ret = acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
> +				    ACPI_ADR_SPACE_PCI_CONFIG, val);
> +	if (ret)
> +		pci_dbg(dev, "ACPI _REG %s evaluation failed (%d)\n",
> +			enable ? "connect" : "disconnect", ret);
> +}
> +
>   int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>   {
>   	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> @@ -1074,6 +1084,9 @@ int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>   		if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
>   				PM_QOS_FLAGS_ALL)
>   			return -EBUSY;
> +
> +		/* Notify AML lack of PCI config space availability */
> +		acpi_pci_config_space_access(dev, false);
>   	}
>   
>   	error = acpi_device_set_power(adev, state_conv[state]);
> @@ -1083,6 +1096,15 @@ int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>   	pci_dbg(dev, "power state changed by ACPI to %s\n",
>   	        acpi_power_state_string(adev->power.state));
>   
> +	/*
> +	 * Notify AML of PCI config space availability.  Config space is
> +	 * accessible in all states except D3cold; the only transitions
> +	 * that change availability are transitions to D3cold and from
> +	 * D3cold to D0.
> +	 */
> +	if (state == PCI_D0)
> +		acpi_pci_config_space_access(dev, true);
> +
>   	return 0;
>   }
>   
