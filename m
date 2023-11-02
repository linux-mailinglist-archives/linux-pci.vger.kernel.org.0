Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2707DE9E5
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 02:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345679AbjKBBOs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 21:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348147AbjKBBOr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 21:14:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC46FC;
        Wed,  1 Nov 2023 18:14:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sgej03euOlMjk2ftDQa5kL68HWc2Je9VoDRlJJ+IaSBAXd7V4ivZ4ydXRhG1d/c49NftFeKP3aP0vge57dAeuoNbfbTr+d+ADYxRDg3mKr/qwT0uxRL028ScS1GQt2WE7KcncyzSxltYdmF7/edk0DEoZAfTADVMkOuYefzYx9jGRF1s9PTaGd9POmnLpzFs8a94fa6Aa8a1m+MXxwGyRSp0c42PAqfU07Y+dbZsMQ4RHc1pWU72nbtefCE6JTopEPEYkckI2DB0zRr+ERZYd85ZJkOmPokNrgdOmMKlisUtv8KpJmDvaHQb4pkJrEmdt0GywXxWJ5kAa4Cy2Rd7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q/Z71deQ7J/xEcvR0+lxoqnzw2ubuoKlGHkRO3hgBc=;
 b=II4dJGpF6hrtfYV4qIVYaJ3uhQME0FFGSD+DW0Vu0jFlHHQNoilKBEKUE5dWt5mkn9/Sc3J1al3GvSPzIyuID6mH55GtrZnLL+VzSD/s/HHn2Lmzxq37YGc0CcHclQ2m7bFwxfXf5whEGQrOytpp69UXjyWDnMD51mhdSZ+Df4cIdNsvBXkpNV8sEQLQDAYmC8taqGIyJ8Ykt2pthgQhtC4zCEErbMHFTs/TT7GeXU+bTg5OcM4MCIwZ0Ojcdxx1BbhPdWsHxzCZQZ3yhu2DxVAUMSug8X4NITRyHBC/fUGLPUdJEWpi4l2HcLzH2O9Dm7PnKRwHkZLTLHnqgTGIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q/Z71deQ7J/xEcvR0+lxoqnzw2ubuoKlGHkRO3hgBc=;
 b=0Yj9y3I6pkmc4Mts4CR4YkRCSlnYFhSKInT9VbVsUatcZ8p0+swu09ThalgEkXkSDbfUgWVlAVOH4Ut2xqOAL2C8eYgureVdPuDoNueUhish1G4NNJEiyR3hItwiJlANr8v2V76vZSjaOs9vnZLeyFTlrO662a2LHBK51puNPM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 01:14:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Thu, 2 Nov 2023
 01:14:37 +0000
Message-ID: <928df647-5b20-406b-8da5-3199f5cfbb48@amd.com>
Date:   Wed, 1 Nov 2023 20:14:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: Ignore PCIe ports used for tunneling in
 pcie_bandwidth_available()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Alexander.Deucher@amd.com
References: <20231101225259.GA101390@bhelgaas>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231101225259.GA101390@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aea99fc-62a8-4f42-9579-08dbdb411446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6HnpA9f1vE3eLxljYjEw1Ui61EfakvJEN00g78H2Tk5sKSMaRsjoX4VRp1fsYeBij9ytqoWNlijR4SQH2Dt6iapxAyIBPJl82Z4MoWJCD+eMkZsazYxRU7IcefShFqHkPcRS5WBIj+x0IvoGla+lx2TUr0wG5H41ceGXPKQch5nJlNVbdZ+Oqw+AuWUQaeLRySp7BRhL2EDGIkuKH6Pst+u/UaRL36dghyKeI7OxYondsH/bB/ktfbB2mI/f5v2AyC4uCz9P9Mxyye8tq7Gh0e5itce9xqX1bRdC7LepYoVZ+LciN3f0vh2e2afrazRb9a4fmotn99+xC7dXZyQMfEQRN54TCwogOS1tfbV3+MCP2+pc92u81iyCsLRAulsn6xxuwArCXwYhHcBUktNIYCWvyeL6Tp+etM/uNC65oahNxYjDJCdMrBxPYPlt77FcEeB8OgPhtknQJ9akVliPDKlAeK7FCRrnaBOxOP+LFLlo3N2CZBqhMko8Qlbi59d1TYkBPECv4xpu9K5qyLd0b+QaZScmo8HIH87f0tJNFecK3Zg3UvHRdCOicRH+aoJepw8s6xUUwcTrdUCwtvicREdKvBlDIWmPhkmHUtPbXMsqP32AevflqP0bNBHTJwk2dPV8zGPR0tPJherxD4/TO5kxcpvrK61epsdPyibZ8JizcxJDt5Ek+q+kc1BM6iNqBR2EnOFN+Wvtn5o2raVXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2616005)(5660300002)(66574015)(86362001)(31696002)(26005)(6506007)(6486002)(966005)(478600001)(6666004)(66556008)(53546011)(36756003)(66476007)(66946007)(6916009)(316002)(38100700002)(41300700001)(31686004)(6512007)(44832011)(2906002)(83380400001)(8936002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUoyczE3OGlCU1g5eDRFd2d4YnhOUGo5UEw5L0hyb1FhQW1ibDN0T2hCQTJw?=
 =?utf-8?B?bnBWbWIvN0prMDRZbUlaRUVhT0JwSUwyekJJeGdOdllVV2x0SmU1WGc1bUI4?=
 =?utf-8?B?RE9NV0R5eFo1K1lUc3ZkTEQrNnpSdlU1cXlXTVRNUlBuaTd0S0RVWnlpWDdW?=
 =?utf-8?B?cFVwbEhqWmQrSE9sUXZ3OE5oN2paWUFzbkF4ZHJVMktjYTB2NG9nTUxSTHhp?=
 =?utf-8?B?Z1czOUxkcUhuZ3hrQ29YV0lvby9nR1haK1Z1YXd6VTZjY3J0SUYvZ1haeVhq?=
 =?utf-8?B?TUhSREYxc1d2Q1RBWStxZFNWSW9qV2ZuV2tTaXNvUjFJejYwa1lHTkZzRUYz?=
 =?utf-8?B?T1dtYnVOWTJJRnhZSjBRbmdRQzJ1ZGtDSTQyMXFoaEhpZTNnQW5lSzR1aWJY?=
 =?utf-8?B?K0pQNXZWR0xJbUFubzNaS2M5VWZqeGVwMGlSRzlCMmRmajcvdW1xZmQ3Q25I?=
 =?utf-8?B?cWR5OVd1ZGlGZjhjbU9veWx3dlBDQzEvWUQ1OTNJd2poWWhacUZHTnQyME15?=
 =?utf-8?B?N1RnWUNsbllwUTRsd0ZLdlNmL3puNW1FMVlSdTRaSHREU1VYMEtZaTFXSERi?=
 =?utf-8?B?ekJWTWJmd0kxQ2tyVWFCKzR0bnFOK1orN0crNjRyYkVLZDdybGtVcGlVcmc0?=
 =?utf-8?B?NHJ2YzVQUnExanFwRnhpaWpENkZwS0hjc211dk14aXBZUEhhNG1YQzkxVVRv?=
 =?utf-8?B?UldvSURvU2E0TlJHWEM2UE1XQlFzN3RsT2huaFFxZVZxa0liNTdJaThXYU4r?=
 =?utf-8?B?YW5WTXZHU1J5V2dqYjFOR2xWT1QzNE9tN2ZncXIzK3daUWJYamVIR05xUzFj?=
 =?utf-8?B?TjJudVF2QklpenByS1BKNEJLeWF1enZlM3Y1SG85ckFNWG5LVjFnS1dmbTNU?=
 =?utf-8?B?VnEwUmJ6NUw1R3RMWFBoK0gyYk5PME1MT2lOU1E5azdRKzhjN2UzR2FTQXZR?=
 =?utf-8?B?T3RFa2FnUzB1OTBacHJsSDluc1dVMVg1ZTcyZ1pnUGJscnpUNVUzbGhwTTRh?=
 =?utf-8?B?RG9Fci9FQXpwTUdLRHZLREZxdEJlWnkrU3JxMWUzQVIrNWYzUlg0MUdMOXBB?=
 =?utf-8?B?MnoraGVZb0lEM3dIR3ZvaThteWxaUldaaTlXWDF1T01yNFY2QTVxdFdGUGYw?=
 =?utf-8?B?SWVHTGZ3RVllK2tpK0xxQ0ROUHFQZjRHY04veEE0NWFQbzJMSG1McGRLNTVp?=
 =?utf-8?B?eXo2UWpHQTlndTR6V3RoYWY4LzFFSjhxZ3lBZHVVOUZ1M0wrOEhnR1F2eSs2?=
 =?utf-8?B?eXk0UERQMVB4TmxYQWg5Tk80Z0hNdGRJMXpkQzVIZzJEM2UrVzk3ajBVQ1RM?=
 =?utf-8?B?Y3dwZHZnenlpaHlVUHY1aWgzUnVRaGpycDE3NzFlT1Z3OWVoajN4a1BMT3NH?=
 =?utf-8?B?Q0N3eUQ2ZkJPUHVnYU5DRmZkTWZKMnJhandXVVg1YzVxb3BzMWhpNUdlZWxM?=
 =?utf-8?B?K0JpVmsxaitBck9uV0k1UEJSNW9XM3lVRHNrZHhTZUdsQS8zSmVmT0U1QndY?=
 =?utf-8?B?bHJ6YVdHSjdqcmloeWRlS0VUcWp5TzdWVEZId0NYMmhMbjFJa1lmaTVIVTdx?=
 =?utf-8?B?MFpUU1NZTVMvK3hOT2QyOFFYdnArZTFiK096S0ttMENpT2hhR2NTS040TEVs?=
 =?utf-8?B?R0lrTnpFYXRXaW9DNXhUSHR5NHhEUXYrTXhOZ0VzNzNYa0FlQlpjaWVpdE5u?=
 =?utf-8?B?elQ2UkhWMFV3SkY0aWVtSHRjaXRobHExYjZvdkY3OFlmTXhMQmp0QnZkL1Fw?=
 =?utf-8?B?TTl1Yk90NG5MZWpYenBoc2FCSmpLNTVRYUpyWHczMXhEa3FwSTlNMVM4ek1i?=
 =?utf-8?B?Y0FwR3N1VkIxa00ycFdSQTJQZ1E4a1E1TTVGZ1diNVg4MDZXMzhqczhmbDZk?=
 =?utf-8?B?bWRNNTl1NHdnSEx0NUxYUG1MaEc1VVhwOVczVHhkdkFHN2EvS3JXUjg0N2Q4?=
 =?utf-8?B?dXpwc0lXNy9mbFFtcjN2b1lUZU53Uko1WHVBR3FEVHZHTzBnRXplUkdGK0U3?=
 =?utf-8?B?TUsrK2FEUDVtTkxsWkZIWjhwcWpXOWFYbVMvYlNJUGlSV0YyUDNpUnZVVW53?=
 =?utf-8?B?TDB5aWxRZEZWRlVGYlpxRlVPNFg3ZjFzcWJNbEJ1ZFd1cllGeGN5VmJuMjli?=
 =?utf-8?Q?1cofZaFOkyouW5JCBxNtVQrCD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aea99fc-62a8-4f42-9579-08dbdb411446
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 01:14:36.5973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2WdCTUIQ4GowMRuLtwNdVA0fMDofchArzKGZqAQg0jBWJK+P94BmRpBiEOJCNdZdTdCWC9qXdxS1/TwjNP71g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
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

On 11/1/2023 17:52, Bjorn Helgaas wrote:
> On Tue, Oct 31, 2023 at 08:34:38AM -0500, Mario Limonciello wrote:
>> The USB4 spec specifies that PCIe ports that are used for tunneling
>> PCIe traffic over USB4 fabric will be hardcoded to advertise 2.5GT/s.
>>
>> In reality these ports speed is controlled by the fabric implementation.
> 
> So I guess you're saying the speed advertised by PCI_EXP_LNKSTA is not
> the actual speed?  And we don't have a generic way to find the actual
> speed?

Correct.

> 
>> Downstream drivers such as amdgpu which utilize pcie_bandwidth_available()
>> to program the device will always find the PCIe ports used for
>> tunneling as a limiting factor and may make incorrect decisions.
>>
>> To prevent problems in downstream drivers check explicitly for ports
>> being used for PCIe tunneling and skip them when looking for bandwidth
>> limitations.
>>
>> 2 types of devices are detected:
>> 1) PCIe root port used for PCIe tunneling
>> 2) Intel Thunderbolt 3 bridge
>>
>> Downstream drivers could make this change on their own but then they
>> wouldn't be able to detect other potential speed bottlenecks.
> 
> Is the implication that a tunneling port can *never* be a speed
> bottleneck?  That seems to be how this patch would work in practice.

I think that's a stretch we should avoid concluding.

IIUC the fabric can be hosting other traffic and it's entirely possible 
the traffic over the tunneling port runs more slowly at times.

Perhaps that's why the the USB4 spec decided to advertise it this way? 
I don't know.

> 
>> Link: https://lore.kernel.org/linux-pci/7ad4b2ce-4ee4-429d-b5db-3dfc360f4c3e@amd.com/
>> Link: https://www.usb.org/document-library/usb4r-specification-v20
>>        USB4 V2 with Errata and ECN through June 2023 - CLEAN p710
> 
> I guess this is sec 11.2.1 ("PCIe Physical Layer Logical Sub-block")
> on PDF p710 (labeled "666" on the printed page).  How annoying that
> the PDF page numbers don't match the printed ones; do the section
> numbers at least stay stable in new spec revisions?

I'd hope so.  I'll change it to section numbers in the next revision.

> 
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2925
> 
> This issue says the external GPU doesn't work at all.  Does this patch
> fix that?  This patch looks like it might improve GPU performance, but
> wouldn't fix something that didn't work at all.

The issue actually identified 4 distinct different problems.  The 3 
problems will be fixed in amdgpu which are functional.

This performance one was from later in the ticket after some back and 
forth identifying proper solutions for the first 3.

> 
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/pci.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 59c01d68c6d5..4a7dc9c2b8f4 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6223,6 +6223,40 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
>>   }
>>   EXPORT_SYMBOL(pcie_set_mps);
>>   
>> +/**
>> + * pcie_is_tunneling_port - Check if a PCI device is used for TBT3/USB4 tunneling
>> + * @dev: PCI device to check
>> + *
>> + * Returns true if the device is used for PCIe tunneling, false otherwise.
>> + */
>> +static bool
>> +pcie_is_tunneling_port(struct pci_dev *pdev)
> 
> Use usual function signature styling (all on one line).

OK.

> 
>> +{
>> +	struct device_link *link;
>> +	struct pci_dev *supplier;
>> +
>> +	/* Intel TBT3 bridge */
>> +	if (pdev->is_thunderbolt)
>> +		return true;
>> +
>> +	if (!pci_is_pcie(pdev))
>> +		return false;
>> +
>> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
>> +		return false;
>> +
>> +	/* PCIe root port used for tunneling linked to USB4 router */
>> +	list_for_each_entry(link, &pdev->dev.links.suppliers, c_node) {
>> +		supplier = to_pci_dev(link->supplier);
>> +		if (!supplier)
>> +			continue;
>> +		if (supplier->class == PCI_CLASS_SERIAL_USB_USB4)
>> +			return true;
> 
> Since this is in drivers/pci, and this USB4/Thunderbolt routing is not
> covered by the PCIe specs, this is basically black magic.  Is there a
> reference to the USB4 spec we could include to help make it less
> magical?

The "magic" part is that there is an ACPI construct to indicate a PCIe 
port is linked to a USB4 router.

Here is a link to the page that is explained:
https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/usb4-acpi-requirements#port-mapping-_dsd-for-usb-3x-and-pcie

In the Linux side this link is created in the 'thunderbolt' driver.

Thinking about this again, this does actually mean we could have a 
different result based on whether pcie_bandwidth_available() is called 
before or after the 'thunderbolt' driver has loaded.

For example if a GPU driver that called pcie_bandwidth_available() was 
in the initramfs but 'thunderbolt' was in the rootfs we might end up 
with the wrong result again.

Considering this I think it's a good idea to move that creation of the 
device link into drivers/pci/pci-acpi.c and store a bit in struct 
pci_device to indicate it's a tunneled port.

Then 'thunderbolt' can look for this directly instead of walking all the 
FW nodes.

pcie_bandwidth_available() can just look at the tunneled port bit 
instead of the existence of the device link.

> 
> Lukas' brief intro in
> https://lore.kernel.org/all/20230925141930.GA21033@wunner.de/ really
> helped me connect a few dots, because things like
> Documentation/admin-guide/thunderbolt.rst assume we already know those
> details.

Thanks for sharing that.  If I move the detection mechanism as I 
suggested above I'll reference some of that as well in the commit 
message to explain what exactly a tunneled port is.

> 
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>   /**
>>    * pcie_bandwidth_available - determine minimum link settings of a PCIe
>>    *			      device and its bandwidth limitation
>> @@ -6236,6 +6270,8 @@ EXPORT_SYMBOL(pcie_set_mps);
>>    * limiting_dev, speed, and width pointers are supplied) information about
>>    * that point.  The bandwidth returned is in Mb/s, i.e., megabits/second of
>>    * raw bandwidth.
>> + *
>> + * This function excludes root ports and bridges used for USB4 and TBT3 tunneling.
>>    */
>>   u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>>   			     enum pci_bus_speed *speed,
>> @@ -6254,6 +6290,10 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>>   	bw = 0;
>>   
>>   	while (dev) {
>> +		/* skip root ports and bridges used for tunneling */
>> +		if (pcie_is_tunneling_port(dev))
>> +			goto skip;
>> +
>>   		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>>   
>>   		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
>> @@ -6274,6 +6314,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>>   				*width = next_width;
>>   		}
>>   
>> +skip:
>>   		dev = pci_upstream_bridge(dev);
>>   	}
>>   
>> -- 
>> 2.34.1
>>

