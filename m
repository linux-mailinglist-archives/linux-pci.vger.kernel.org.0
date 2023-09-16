Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F907A308C
	for <lists+linux-pci@lfdr.de>; Sat, 16 Sep 2023 15:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjIPNJl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Sep 2023 09:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238907AbjIPNJa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Sep 2023 09:09:30 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0526B1B5
        for <linux-pci@vger.kernel.org>; Sat, 16 Sep 2023 06:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlixWdAOxs1EKTSVxxt4MZpKjhqTfSs8xDbx/Rnub4IVEKPUn4IlMtjCiS+ipJDZWXJtQbpx9ky2oe8rf7qMSGulw8vy63osJxhZw5KKHxXbpvhCzRefr6hed8Iq27DyFgm7in5VwFWXEjwkQ3wSHsvcwSaI20U73kIRkOpiN0W+ChVlW2dBVhK5lQR9oy+vzajK13qCOBd1dAE5kJWJ0PDm0YGPmzD7P6ahJf/b7fNl6oGMpDdmV1TEXlgpxb/idwOSX2zA+UjQqqlGOSfXAAymgv14b3wRonXz6tEvb8LS8ezf0pVwoG3F90d/KfaBpkwQomu+l6JTq6YibYuCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJFv2bET0zYRpdnWH3RwTJ7RXczx09U6mfndzpRXqbY=;
 b=Y70Vfrg5rOHVLtTS/+jmlXhiaKge/0Yt4XKa5LdwVOoE78RnTlQ2Zd1GJrac7gpSnNAjEHZqOGmWUVJa9u+WNiipVjrp/HPu1ubbQlfldY5kONmDR5f+GO1Dlmww4bnfG4BNFzuDRJfN1epwEC+0yr+37F+AbCtDIJyHSDJJyLbq77BdXUR2xvSeDQjYWPifuETe6uPTbPerLA1uXhifblp3QZvfUwp/dcv2FGJHtqjcNuZglTl+YLiJrelocea9wVY9BbF6gEPfU4TSWfsyvjiILoyyMpYBL9ZN0WHACUacnWI+MGZbZ8AS/NjABJeXzvYHYlfuxRO6S7Tc842UaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJFv2bET0zYRpdnWH3RwTJ7RXczx09U6mfndzpRXqbY=;
 b=bVUyf0w6VyZL0T2CWAj8iXzQwLCT4FbNftsRN+/GKSWOT4jcYqvaiQI8dLrsPQepdjyc8b3RuvjlFyjbhf00X3ia0sU9Sku8oCtJb2bJkiizXP3KyPGBh0JxTDh9rvt28H/HBqVb0bjV9KcnGLg2U6o57zJckxCYwljCRYSjADk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19; Sat, 16 Sep 2023 13:09:22 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6792.021; Sat, 16 Sep 2023
 13:09:22 +0000
Message-ID: <a2db379c-b5e4-4ccb-9f5d-15dd94600c84@amd.com>
Date:   Sat, 16 Sep 2023 08:09:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
References: <20230915023354.939-1-mario.limonciello@amd.com>
 <20230915023354.939-3-mario.limonciello@amd.com>
 <20230915070802.GA5934@wunner.de>
 <5a562f6b-6e4d-42a1-bbc1-08f7f3279dfd@amd.com>
 <20230916044851.GA8280@wunner.de>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230916044851.GA8280@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:5:bc::15) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a307f1-0f80-4e9e-4f5b-08dbb6b624e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04X0FcOsFyG9cm1+kzzBT47d7bD3oHR8GNXK0QsSUMC+2TAcDdTgrEHLIbz+23fc92gFywAxSLglnmS/XdARQlzbogSzXNT7NdvE/KsmQELg+CJmLkSZkVSeHgcpnGyFR1QEWia1JhNWrHCeJGtX2wybuZUCkixHCt27IvlAMsMY42w8usP8Vr58uJK3JJnQJWZHjTiSoqkQwATelVqw4nAZrhQ3QrqoCJ1ZvWUA1Pb40YvQF7f8tqDQA26h7Hxo5Lshbg11bomq/yMltkq8pZ1DXDxEXhO0juTMNvzY9mq+J0Xr7hOlPZBrdi79R/Dfrpr3RnpPg7nNHXq3lj3jK4KJwrcu35WocX6XW1I3/mDpxwpKLOGmdObYR4THYTx3cj3QaY1Ugy2hBKp66QzY5b7Y6YubZbeZihNcCYxOHtSyIbvo4txADEEvTYRwua8AxoHzYUqh2gGRLM4oCrHynzb1uMrhK8adWmNXgdG4kZf2MX7Qu2sc5DE83jX4aErvZq+xbNpOe1dBZ5zKE9Xzry2u4ocjVzNKvIEBLBOfLnABFMhbSFSOSpDNA37RORddzYuejPRDWfR+/yh2WCdgKYGDZm6F5TTN7dsjS5gG6Aq2ssVIOuvwimaG5G/bPHbTsvkfnHZMHBIMY16tCOATxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(1800799009)(451199024)(186009)(31696002)(2906002)(36756003)(86362001)(38100700002)(4326008)(8676002)(8936002)(2616005)(5660300002)(31686004)(26005)(53546011)(66946007)(6486002)(6506007)(54906003)(66476007)(316002)(6512007)(66556008)(6916009)(41300700001)(478600001)(44832011)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amtVZzVuc3ZzWHdDeW5KWUxKcmNGdnVKV2VHUXhHWGh0c0YyblQrcTB0OXBO?=
 =?utf-8?B?b1IyalRZVi84di80eGdmcXltR09JcWlrcVJXbWl4UkpYVkdPdTZaVm1YNjZw?=
 =?utf-8?B?a3NOUVF6QXhhai9kdW4yQUhXRi9sWHlHbVhPOVYwV1Jpem1PWkNvSmFOWkh3?=
 =?utf-8?B?b2JLaUppbkx6OGlEV1B1d1lXelJvN0xGcWxIR0VXQ2hmanBGRTVTV2R6MTRX?=
 =?utf-8?B?cEZHaTZzcU1TWTBQdjhPc0wrK0JRMVdBelJoZXdvdld4WlpvK1JVSlVFc0Rl?=
 =?utf-8?B?V2kzQU02VnhCb0c5TkxNK3JTUGowWFl1NGY0THB0RU1jRE90UmMrN2NnOVpm?=
 =?utf-8?B?Wlg0TWhWUUhrM2tYS2FNcGlzcUNHejlmcnh6Y1YvVm1CQWpMN2xzdHk1cXJJ?=
 =?utf-8?B?eUs5TXNZdTl5Yk5kNU94dThwYjJ2dE5Rb1Y2WjMwTlFsenZiVUxCZ2UrR1pn?=
 =?utf-8?B?VllvT0JYVi90NllRemw1TXVRUlJNcVJSTDZ6Mms3cFV2S0NFeUdaajZBY0hr?=
 =?utf-8?B?NzdvekJuOUlsRytQMys1WVdFM1FvWnA5V1BkNmFmYkNEZTdPYnlCS3hnc2xp?=
 =?utf-8?B?aUZGWUU0cWZWdy9xMWlMZWpmK0VWUlhRMDNkMlc1eDlPZU5FQnB6ZFozREM0?=
 =?utf-8?B?NVpvVVh6V3NtMGxGRjZIYXFrTVIzOEgvaWMxVjRMcldNTmgwc1hLQ0ExK0hi?=
 =?utf-8?B?TTZQOHRqRUQvLzEvdWZMQ1hXSzdtYkRXSGZjSy9nWW1IYXJ6QXJIMTg5TlVH?=
 =?utf-8?B?eHFSWVBZUlVocHpEdC81Mk56YnRHZ1VZYUFWOWVCTm9saENMZDc0YStCdFpn?=
 =?utf-8?B?REM1OXZjZVZiQ09CR3kzRjhxdmhwUklIeXZTNW51QWZNa2V4SnZ3anBURVUr?=
 =?utf-8?B?Q1ErYitkMVVNcXJDVjVOQk9WL250Z094YUxtN1RITDRRUjdla1EwWkVsY1Fa?=
 =?utf-8?B?Wms1RXJHNHIrcmRDUGVzaUdGcFVLOUhLNTliQ21rdXlhWnR1KzMyL1gxYUVv?=
 =?utf-8?B?WlV4Q2M3aVJlLzhrZkdYNFZ5UmNVc1RDbFVlQzJDcVV3NU8rSDlyVnpOMEkw?=
 =?utf-8?B?eWdVbE52WThtOG9ndTZtZUF2Yjl5dnhRVmJsamFCTVdlY2p1d25KMGU3amgr?=
 =?utf-8?B?OFMycS81VU1IZ0pCdDRqNlIyRGdFemh6dnJiZTE2MEZrOExHNVpPNmJIL1dZ?=
 =?utf-8?B?U2d3cmoyM3J0R3FKcGJGNjFaeTZYZmozcS94dml5MURvRWpxNjd4V0lkQUtV?=
 =?utf-8?B?MFNWSHhaSjhmVFZJUUFaTFVWVnoxNFppTmFJdW12czl2cmI3NUsrWG9HbjZk?=
 =?utf-8?B?Y2ZYTVNoQUlQZ0cyejBBZzZDcnBFdXcrVUliYTkwNFloRVhJaGJFN3AwWjR2?=
 =?utf-8?B?b1ViSlBPWUFVWlk1OGhnVTRYcEE1MkNYa0poWUVMeXdtdjZ0cGJ6Vzd1c0Fi?=
 =?utf-8?B?eTZVN05iSFM5WHkzT3dpWW5LK1liYi9NNTl0eGF4bGt4emdLL3kwNzRGZ1Vt?=
 =?utf-8?B?djd6NTJsRjg5aE1jc3pSbU1UTEVQcU44aFNWdk1lNFZOTURUTVFRcTM3TWV1?=
 =?utf-8?B?Q3lDU2IrTmxNOTdrRkdVRDJsOGxyTHV1dXlFQm9QMTY4a1dMQ2YwY05vOFJK?=
 =?utf-8?B?ZFlybk5EWGEyN2JOL1cwa0xtVitqU3ZtL1ovd3l3cStxUkVnK29BR2tYRGt6?=
 =?utf-8?B?UDZJNjhYY1VPOE52MlRiaXRFRktrMVBiMVNNakFJK1ZWMjFJaU5jRisyaXVx?=
 =?utf-8?B?bkt3aVpxd2ZsSSswV3QrVEZCYmdyOGRSZWdhZkxnVVMwOUIrQ0FRSFlhemtk?=
 =?utf-8?B?TURicEtwV2x2cEZ4NnIwSnE0K0JzcytTckdvbDhhU0NyRHE5cmw3czdqNHlw?=
 =?utf-8?B?bytzMUNzeHIraU5qRVBKRnorK04rdjJGU0JjNUpFMTIwZXlJVHVoRFpKSTAw?=
 =?utf-8?B?TlV6aTd2QVhBUEpGQnRsUWJObE1zTUFzdkpNY1dINjQ1UW1oZFNmUGFUK1Np?=
 =?utf-8?B?S0FPcGFUSi9QeW96emRoWldDMThkODdESEZmeUJFK2JoMktVbGFqOWp5bnNW?=
 =?utf-8?B?NGs3Mkk5ZnRTUWthZmY2NmMvakdiaFIrVERQUjIwME1BOGFuU0lHSGZaYkt1?=
 =?utf-8?Q?gA3QwqKQAZDTknQEWvIpG9hTq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a307f1-0f80-4e9e-4f5b-08dbb6b624e9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 13:09:22.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCO4JGMlZH1ttB3eInu3ZwH60aXXrziXfM072nXjd3YKQgvQ4hV8nKIscMmZpG9pq7jRLDdJl3nus7oAhCfwVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/15/2023 23:48, Lukas Wunner wrote:
> On Fri, Sep 15, 2023 at 07:04:11AM -0500, Mario Limonciello wrote:
>> On 9/15/2023 02:08, Lukas Wunner wrote:
>>> On Thu, Sep 14, 2023 at 09:33:54PM -0500, Mario Limonciello wrote:
>>>> +static bool child_has_amd_usb4(struct pci_dev *pdev)
>>>> +{
>>>> +	struct pci_dev *child = NULL;
>>>> +
>>>> +	while ((child = pci_get_class(PCI_CLASS_SERIAL_USB_USB4, child))) {
>>>> +		if (child->vendor != PCI_VENDOR_ID_AMD)
>>>> +			continue;
>>>> +		if (pcie_find_root_port(child) != pdev)
>>>> +			continue;
>>>> +		return true;
>>>> +	}
>>>> +
>>>> +	return false;
>>>> +}
>>>
>>> What's the purpose of the pcie_find_root_port() check?  PCI is a hierarchy,
>>> not a graph, so a device cannot have any other Root Port but the one below
>>> which you're searching.
>>>
>>> If the purpose is to check that the port is a Root Port (if the PCI IDs
>>> you're using in the DECLARE_PCI_FIXUP_* clauses match non-Root Ports),
>>> check for pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT.  (No need to
>>> check for that in every loop iteration obviously, just check once in
>>> the fixup.)
>>>
>>> Thanks,
>>>
>>> Lukas
>>
>> The reason to look for it the way that I did was that there are multiple
>> root ports with the exact same PCI ID.
>>
>> The problem only occurs on the root port that happens to have an AMD USB4
>> controller connected.
> 
> Yes but what's the purpose of the pcie_find_root_port(child) check
> quoted above?
> 
> Thanks,
> 
> Lukas

You're right that if you look at this system alone that the check isn't 
strictly necessary.  It's to future proof the quirk.  If a discrete USB4 
controller was connected to the system it would be connected to a 
different root port (the one that is used for PCI tunneling).

AMD doesn't have any of these devices, but if some day one was created 
it could trip this codepath.

If you feel it's better to remove the check unless such a device is 
created sure I can drop it.
