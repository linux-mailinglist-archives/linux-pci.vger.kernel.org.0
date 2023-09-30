Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335447B3D7C
	for <lists+linux-pci@lfdr.de>; Sat, 30 Sep 2023 04:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjI3CGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 22:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjI3CGI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 22:06:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BB5FA
        for <linux-pci@vger.kernel.org>; Fri, 29 Sep 2023 19:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBWR/pXtE0LcGGmWwqtdIKoKfmTAvxkZ3ODvVCcCzRUrGWtVN1cFh1Gi6riSNbUeI5aotxtE1BWxZW0r8XxSuGLgfWRPzyho8scuvZNfQ9knx5grTirxFRS7HeCb+tDQzuUXI2iWZXM8taZTofnqYJA9o5bHQW5v6PM/BYAe/CJ1TUWbLN6WpkAzf1/C2BVQira4JqpU/5QNjVzOxgJ5uczz/EcosgeWUXg8tjtOhj2i7XCmsispTboFvBSwsk2jhr50DknC4cj+/RDGW2cIVQNydhAR75fDVbFUrT45qc5nXwLMVfUxn3zOsGAp3sq5TvtQtQxoP341Q4WrCPeipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZK5nsqduTFVdud8bsSXTEyRD4JACx9u35jQoRT5iV8=;
 b=OWCjS0YeDWPRsw0ne/uMT5e5v2oeWaV5laIvkGvSynV+k6bICDqaJ2YkzuIDShXT1RjOPC+XHX0GrLwpFLVuoqlv78/0QA/kTIOkH5dL+IbJKQaHfWls6XWABb6uSuIzBskABug4KqUM285zYTe+sq272exnB9XwLlA1xmBdNeeu5GaGZPmbCV4QBulJhJ2Rs3O04sHUxcYpvO6Wh8i6VbuAq3PIuEtgh9Juxdyup6NAg/uP1nxg+VVWtuciMKa1DEIgAw6qH7vk8wlB2A3xav9SROWeEJjjp10ICrwcoIkrq+j1R7NFjybiRlePnweJs95m+OF/JOt/zDiFzt0NBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZK5nsqduTFVdud8bsSXTEyRD4JACx9u35jQoRT5iV8=;
 b=xKLOU/u8nV7Yxqv85OvRkNIt1OwUfCcCRYEN1q7WjNYYhbhdQAawONebRIFlyKwCQTlcztyp+luNoAKTRWqzsGsFNVtKijQdUo7CsDf54Krtxl1e9TCtPkRtjxf4Y0i0E8aQYCj+2niYqR6RhEoNTldPQeqU9lyjhFHtVaMY+00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Sat, 30 Sep
 2023 02:05:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6813.017; Sat, 30 Sep 2023
 02:05:59 +0000
Message-ID: <b1560d56-881b-4f86-b25f-63f351d10b8d@amd.com>
Date:   Fri, 29 Sep 2023 21:05:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
References: <20230929194425.GA541906@bhelgaas>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230929194425.GA541906@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:806:d3::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4579:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e94b96e-e13f-439f-e240-08dbc159c9ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 857EiJ3OK6TiHbJ0MZnzCAuRNNkAKUrLh+AfDRtSfU8Hw7cWxZ6Xp2q5Pzr4Q13WLI78Gl4pJ21VALSJ1NL8g3L7I9FM7wgPzkNO4oNLlovhJWsZ4bGvor7pT1fBbkAk2GPBcZ2SowMXi0Y8l5JLaTjxJlqfoV8IDwOTa3tBZtXgee5GiayUxUy9aVMu5Ra92LvYSO9oSAjv6pWZKHGojpDM/GM0rHrD+COBjqIpg9Wf7Ig5pb4vHDR96E00B4/I9akCCEI+BrUQ+o+gEgfm4qXYqMIxz3LfTc9cKLr8EMsXXdFHUcjRCB9eDhpaYfKHJZSMVLH9LJJcUrJMF5Hvn9eDGrkPyUNuJst8eHCNwXMhm5wBFHUl+Vkcx1KewqOLOe4DXvFrryTYPhs/fO+T4lQLbIKN7jq9PIySDQKu+vaHhtLRP1E0wzL3tyDJ65AXkTScnyj1zclsIzW3iNsiumKGr9BFYF+PBoO3vKayETeySDQtIRkjGHbcHtL3k55480kUbHTf9RoDEqE9XifmLZ0Dw3N5CAk0GeLiuoA+qXT5SJyCLolD+AnLl7+lW1P5Vm1HRmZbpVQmX6uT9DbIsRPp87dGhaDp/tna2D0t9BonCV+HhcUemp8wzD3mmSj6h3KWJKwVJKXmwXNnnMx2mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(4326008)(83380400001)(26005)(2616005)(8936002)(5660300002)(44832011)(8676002)(6506007)(6512007)(53546011)(6486002)(31686004)(478600001)(41300700001)(6666004)(66476007)(316002)(6916009)(54906003)(66556008)(66946007)(86362001)(2906002)(31696002)(38100700002)(36756003)(30864003)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mlc2alkxcjdXZlNpdHRxRlpzdEJzS1FXN1BwZ1ZNOUxlU25La1ZRK1AwVzZV?=
 =?utf-8?B?elA4cE05QVpYSzM2MDUzMXhMR2JMdHRFYmNTbExlNzhzRzlkSU9Mem9laGVZ?=
 =?utf-8?B?ZEF3dlZFYzAzU3pzNmVib3dEaE9QKzR2SWhaYlF6eTVwS2J6UzczT2FZdjJE?=
 =?utf-8?B?TEQ4MnE4eXM3WVIxUzMyS0lLWGRkZXRkci9IZnM1UXZiQTZXV0xZYWN2TENO?=
 =?utf-8?B?a1ZDQ1c2SWNzb0tGVU9yanE5bGc1NjFNUWtOL1BjN2xNREhvNnE2MExvcDVp?=
 =?utf-8?B?SkRsNmV3endLOGhJSVByMHhBbm5iOWdlTU1qam9hdlZPd3VNMW9FSFF3MXVq?=
 =?utf-8?B?MGZ0YlBtQTJpRCs5ckZlbGR5SVJuNmJIQjE4U0tUdHNsQWwrOEM4K0xaUHR0?=
 =?utf-8?B?M2Y3aHRXSThuS1lIaW1vd3VmZ1NyUXdQdkdoNmxCOVlRVThweUttclFJenlj?=
 =?utf-8?B?TUpKZ2REWW9rMlRGVnJZeVEwZS9OTFBWc0swZGhvM0pRZHpqaWFWdVhPTExi?=
 =?utf-8?B?RDYyK1J3SnBsdXpOMzFQc2ZMN01jMUl1NjBvRzFMYXRJclc0ME0yMDU4d09w?=
 =?utf-8?B?djc2ZCtLVi9lZkNERm5oViszRVpwM1dabFVlbWJYd2VYNEJ4eTJ0VEw5L2lG?=
 =?utf-8?B?WXpiQU5Ra1dEQjA5aURCOGJqWHJlYUtieWxvTlhjdjFrYmZTN3Zhb2dlRHVt?=
 =?utf-8?B?MVd5bitHalBxSmhNK0pTajRnMVhxWnV3TkFUMUpwbWVsNEd5RlhNaDVIeFdx?=
 =?utf-8?B?NFFCNXVWZzJZN212bUptQzR0UTJJSWVkMkwxWCtsVHJ4Qk5ZY1Njb2tBNTAv?=
 =?utf-8?B?ZzcyRmVjanZUbjVIb2tYQzE0RTFCZjFCVlR3UTRtajlETTBHTStRMThDSDBt?=
 =?utf-8?B?YVoxZHVERE1CWFk2YnRueXEyVjFlTWFTdUJYSUZGRlRyTzRtMFBYQXJCaGo2?=
 =?utf-8?B?eDlyOHpWOFNNZTVWbUxkS1dsZ1NaMDF2Rit2Wlh3dXNOc0dQNE1xdmRuQzdo?=
 =?utf-8?B?YllkQmpoUDhKU1ZVNFAxN0J2WjF5Smc4OUpTQmhKZjU4Z1MzYmJqVkZaM2Rp?=
 =?utf-8?B?eWFKRTlxTlZoWWkzTENuSVlMRWxRZ0JuRXdsbXAzdE5SWFFycURTVGtrU0xW?=
 =?utf-8?B?WU4yVUN5U1dyZlZOMzg0SFdNRkp5d1lCYkdqbkFhclVPdTRNc25Xb3FVVzVU?=
 =?utf-8?B?bHJDeG5pZlF4UGRKL2Ezby9OTCtNemJjOWpVeVAwMitOeFhyTnJkRXpwK0dR?=
 =?utf-8?B?M2RJVFg2Q3hZZWdUOS9VMUpZWlMyOHl2WWFZajhaOXpVbi9kODRZem9Iajcw?=
 =?utf-8?B?NmpodWRJSzlPcnF1dUR6cm5ZYlNKUGgrVk1DUGdmcFdaWFd5YTdFRXFRSWZZ?=
 =?utf-8?B?aXZQSk5OVi9raitTblZGUVdJbVhOb0htNHM0K3hrMWtXVHliS21xUDFIVTBL?=
 =?utf-8?B?VmhSbk1SbmFuUzg0TUlKWXFjSUkwSEhCYXVrZGZSQzJTc2dNaDFheEZ1cHAw?=
 =?utf-8?B?L09JazR4TDFlVUlZSzNZbmFTYUtDZTIwOXY1dXJ5M1FlUFN5REdrYnZkTVFa?=
 =?utf-8?B?a2RMSXY5YWlyWWhUR2srbUxZUW1udGczNUNQVUdQY0pIem03d0w0RlI0RFcx?=
 =?utf-8?B?VnJmaGV3NExaR0JMWVlPVXJrR05kcE5iTGpaQVNHelVKZnY1WFptYW56cGsx?=
 =?utf-8?B?UG9hZ1lrZUR6Y2ZXenlTT1FSU2Q3OWtIMzFYUmYzbjZvWXRYTVdCWGxVVzBq?=
 =?utf-8?B?S01YbldVbytscXJ6QmMyelVuS2tGZnZHV2I5UzJOSFdoUFVJOU1pTjh3WVVr?=
 =?utf-8?B?bHZvNlVkK1pYNnE2aVY0VVJDSEdXUFdIV1FZUVlFdG45NFpvR3BoZHhjeWo5?=
 =?utf-8?B?SEFQa3l6Qy9JYnZRdWcvVTd6Ni9EUThRYXdGWXRXb3JJUjBCZ0V1K2ZCOXgz?=
 =?utf-8?B?ZllNbVBRd1lQUE1uM2Z3Tk9KQVV5WllpNllMSzg0MzNkKytmZmxOazNxZjFs?=
 =?utf-8?B?UkVHVE9UY0NyMmdKcnM0MFNZa2czZldBR25CWnBudkxPVDM1UTR3bUkwMnh3?=
 =?utf-8?B?QlJ1UDdyVnZ0dk5kc2lhSExxYlZzNzdvZ1cyTjllTGhnNW9ramwxTzR4L1Zj?=
 =?utf-8?Q?D+bh1xp7Cn4FpA/yz0IQHDVzn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e94b96e-e13f-439f-e240-08dbc159c9ef
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 02:05:58.9542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJyTt4cWb/EE1rMXcApBNEcxofMbzQGAQ1FXcz6UxEXYgbs8dZ7kasVtlx0vUx6+7DTlr7peRJ0TeTcVUs0nIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/29/2023 14:44, Bjorn Helgaas wrote:
> On Tue, Sep 19, 2023 at 10:27:24PM -0500, Mario Limonciello wrote:
>> Iain reports that USB devices can't be used to wake a Lenovo Z13
>> from suspend. This problem occurs because the PCIe root port has been put
>> into D3hot and AMD's platform can't handle the PME associated with USB
>> devices waking the platform from a hardware sleep state in this case.
>> The platform is put into a hardware sleep state by the actions of the
>> amd-pmc driver.
>>
>> Although the issue is initially reported on a single model it actually
>> affects all Yellow Carp (Rembrandt) and Pink Sardine (Phoenix) SoCs.
>> This problem only occurs on Linux specifically when attempting to
>> wake the platform from a hardware sleep state.
>> Comparing the behavior on Windows and Linux, Windows doesn't put
>> the root ports into D3 at this time.
>>
>> Linux decides the target state to put the device into at suspend by
>> this policy:
>> 1. If platform_pci_power_manageable():
>>     Use platform_pci_choose_state()
>> 2. If the device is armed for wakeup:
>>     Select the deepest D-state that supports a PME.
>> 3. Else:
>>     Use D3hot.
>>
>> Devices are considered power manageable by the platform when they have
>> one or more objects described in the table in section 7.3 of the ACPI 6.5
>> specification [1]. In this case the root ports are not power manageable.
>>
>> If devices are not considered power manageable; specs are ambiguous as
>> to what should happen.  In this situation Windows 11 puts PCIe ports
>> in D0 ostensibly due the policy from the "uPEP driver" which is a
>> complimentary driver the Linux "amd-pmc" driver.
>>
>> Linux chooses to allow D3 for these root ports due to the policy
>> introduced by commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during
>> suspend"). Since Linux allows D3 for these ports, it follows the
>> assertion that a PME can be used to wake from D3hot or D3cold and selects
>> D3hot at suspend time.
>>
>> Even though the PCIe PM capabilities advertise PME from D3hot or D3cold
>> the Windows uPEP driver expresses the desired state that should be
>> selected for suspend is still D30.  As Linux doesn't use this information,
>> for makin ga policy decision introduce a quirk for the problematic root
>> ports.
>>
>> The quirk removes PME support for D3hot and D3cold at system suspend time.
>> When the port is configured for wakeup this will prevent these states
>> from being selected in pci_target_state().
>>
>> After the system is resumes the PME support is re-read from the PM
>> capabilities register to allow opportunistic power savings at runtime by
>> letting the root port go into D3hot or D3cold.
>>
>> Cc: stable@vger.kernel.org
>> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v19->v20:
>>   * Adjust commit message (Bjorn)
>>   * Use FIELD_GET (Ilpo)
>>   * Use pci_walk_bus (Lukas)
>> ---
>>   drivers/pci/quirks.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 71 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index eeec1d6f9023..4159b7f20fd5 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -6188,3 +6188,74 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
>> +
>> +#ifdef CONFIG_SUSPEND
>> +/*
>> + * When AMD PCIe root ports with AMD USB4 controllers attached to them are put
>> + * into D3hot or D3cold downstream USB devices may fail to wakeup the system
>> + * from suspend to idle.  This manifests as a missing wakeup interrupt.
>> + *
>> + * Prevent the associated root port from using PME to wake from D3hot or
>> + * D3cold power states during suspend.
>> + * This will effectively put the root port into D0 power state over suspend.
>> + */
>> +#define PCI_PM_CAP_D3_PME_MASK	((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) \
>> +				>> PCI_PM_CAP_PME_SHIFT)
>> +static int modify_pme_amd_usb4(struct pci_dev *dev, void *data)
>> +{
>> +	bool *suspend = (bool *)data;
>> +	struct pci_dev *rp;
>> +	u16 pmc;
>> +
>> +	if (dev->vendor != PCI_VENDOR_ID_AMD ||
>> +	    dev->class != PCI_CLASS_SERIAL_USB_USB4)
>> +		return 0;
>> +	rp = pcie_find_root_port(dev);
>> +	if (!rp->pm_cap)
>> +		return -ENODEV;
>> +
>> +	if (*suspend) {
>> +		if (!(rp->pme_support & PCI_PM_CAP_D3_PME_MASK))
>> +			return -EINVAL;
>> +
>> +		rp->pme_support &= ~PCI_PM_CAP_D3_PME_MASK;
>> +		dev_info_once(&rp->dev, "quirk: disabling PME from D3hot and D3cold at suspend\n");
>> +
>> +		/* no need to check any more devices, found and applied quirk */
>> +		return -EEXIST;
>> +	}
>> +
>> +	/* already done */
>> +	if (rp->pme_support & PCI_PM_CAP_D3_PME_MASK)
>> +		return -EINVAL;
>> +
>> +	/* restore hardware defaults so runtime suspend can use it */
>> +	pci_read_config_word(rp, rp->pm_cap + PCI_PM_PMC, &pmc);
>> +	rp->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
>> +
>> +	return -EEXIST;
>> +}
> 
> This is a lot of hassle to look for USB4 devices below the Root Port.
> You said earlier that these Root Ports *only* connect to xHCI and
> USB4 [1].  

That's correct, but the part that I believe you're missing is that there 
are multiple "instances" of this PCI device ID on a failing system.

On an OEM Phoenix laptop in front of me I see 3 instances of 1022:14eb:
00:08.1, 00:08.2, and 00:08.3.

> If that's the case, why even bother with the search?
> Why not just clear PCI_PM_CAP_PME_D3hot and PCI_PM_CAP_PME_D3cold
> unconditionally, e.g., the possible patch below?

Only the one with the USB4 controller (in this system it's at 00:08.3) 
has the problem.

So I believe the proposal you have below will apply the policy to too 
many ports.

> 
> I have no idea whether it's even possible to have a device other than
> xHCI/USB4 below these Root Ports, but I don't think we have any
> evidence that the PME failure is specific to USB4, so if it *is*
> possible, it's likely that PME from them would fail the same way.
> 

On some OEM system they only have type C ports wired up (to the USB4 
controller), but on a "reference system" I have a USB-A ports that are 
connected directly to the XHCI controller available as well.

These work fine for wakeup without a quirk.

> [1] https://lore.kernel.org/r/4a973fe7-e801-49cc-88b8-77d3d0ba3673@amd.com
> 
>> +static void quirk_reenable_pme(struct pci_dev *dev)
>> +{
>> +	bool suspend = FALSE;
>> +
>> +	pci_walk_bus(dev->bus, modify_pme_amd_usb4, (void *)&suspend);
>> +}
>> +
>> +static void quirk_disable_pme_suspend(struct pci_dev *dev)
>> +{
>> +	bool suspend = TRUE;
>> +
>> +	/* skip for runtime suspend */
>> +	if (pm_suspend_target_state == PM_SUSPEND_ON)
>> +		return;
>> +
>> +	pci_walk_bus(dev->bus, modify_pme_amd_usb4, (void *)&suspend);
>> +}
>> +
>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14b9, quirk_disable_pme_suspend);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14b9, quirk_reenable_pme);
>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14eb, quirk_disable_pme_suspend);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14eb, quirk_reenable_pme);
>> +#endif /* CONFIG_SUSPEND */
> 
> 
> PCI: Avoid PME from D3hot/cold for AMD Rembrandt and Phoenix
> 
> Iain reports that USB devices can't be used to wake a Lenovo Z13 from
> suspend.  This occurs because on some AMD platforms, even though the Root
> Ports advertise PME_Support for D3hot and D3cold, they don't handle PME
> messages and generate wakeup interrupts from those states when amd-pmc has
> put the platform in a hardware sleep state.
> 
> Iain reported this on an AMD Rembrandt platform, but it also affects
> Phoenix SoCs.  On Iain's system, a USB device below the affected Root Port
> generates the PME, but there is no reason to believe PMEs from other kinds
> of devices would work differently.
> 
> To avoid this issue, remove D3hot and D3cold from the Root Port's
> PME_Support mask when suspending if we expect amd-pmc to put the platform
> in a hardware sleep state.  The effect of this is that if there is a wakeup
> device below the Root Port, we will avoid D3hot and D3cold.
> 
> Restore the advertised PME_Support mask on resume so D3hot and D3cold can
> be used by runtime suspend.  The amd-pmc driver doesn't put the platform in
> a hardware sleep state for runtime suspend, so PMEs work as advertised.
> ---
>   drivers/pci/quirks.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eeec1d6f9023..cdf03eb610b0 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6188,3 +6188,57 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
> +
> +#ifdef CONFIG_SUSPEND
> +/*
> + * Root Ports on AMD Rembrandt and Phoenix SoCs advertise PME_Support for
> + * D3hot and D3cold, but if the SoC is put into a hardware sleep state by
> + * the amd-pmc driver, the Root Ports don't generate wakeup interrupts from
> + * those states.
> + *
> + * When suspending, remove D3hot and D3cold from the PME_Support advertised
> + * by the Root Port so we don't use those states if we're expecting wakeup
> + * interrupts.  Restore the advertised PME_Support when resuming.
> + */
> +#define PCI_PM_CAP_D3_PME_MASK ((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) \
> +				>> PCI_PM_CAP_PME_SHIFT)
> +
> +static void quirk_amd_pme_unsupported(struct pci_dev *dev)
> +{
> +	if (!dev->pm_cap)
> +		return;
> +
> +	/*
> +	 * PM_SUSPEND_ON means we're doing runtime suspend, which means
> +	 * amd-pmc will not be involved so PMEs work as advertised.
> +	 *
> +	 * The PMEs *do* work in D3hot/D3cold if amd-pmc doesn't put the
> +	 * SoC in the hardware sleep state, but we assume amd-pmc is always
> +	 * present.
> +	 */
> +	if (pm_suspend_target_state == PM_SUSPEND_ON)
> +		return;
> +
> +	dev->pme_support &= ~PCI_PM_CAP_D3_PME_MASK;
> +	dev_info_once(&dev->dev, "D3hot/D3cold PMEs don't work in hardware sleep state\n");
> +}
> +
> +static void quirk_amd_pme_supported(struct pci_dev *dev)
> +{
> +	u16 pmc;
> +
> +	if (!dev->pm_cap)
> +		return;
> +
> +	if (dev->pme_support & PCI_PM_CAP_D3_PME_MASK)
> +		return;
> +
> +	pci_read_config_word(dev, dev->pm_cap + PCI_PM_PMC, &pmc);
> +	dev->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
> +}
> +
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14b9, quirk_amd_pme_unsupported);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14b9, quirk_amd_pme_supported);
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14eb, quirk_amd_pme_unsupported);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14eb, quirk_amd_pme_supported);
> +#endif /* CONFIG_SUSPEND */

