Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A916DA827
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 06:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjDGEKL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 00:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjDGEKJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 00:10:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C1C6E94
        for <linux-pci@vger.kernel.org>; Thu,  6 Apr 2023 21:10:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3D/5+nubVcff3FrMCHdW9A6grpLFJ+ErXr7S9mEC7iDQn+O+dTsJ7hRtluy0siaeixG2BNJCF7m9maMeaWIqM6T95NH4WNhdXjRWaaY5R6N429/zHep7G4C8uywW8rz00WoIANtniI6XIee77UGx8v2DvpinpAOJhykyiuqhI7ZgpF2Rh45UZe0A49iOe0ZhAhD3m1GhqjdS0mZA6iVcvyGS6VEwVBnkuVwx9aYL9hAZTCw46jnWySG4sxwUB6FZcqDvUxdqCwVfPDIeVE6pJDhGmElzOQZV+DxGcUnUwheN9580VUkuBz6zae8tqo1h6kjLkSW/I9vs/sdIxhg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKcbxx4pZtP4VgmnTOidbfRkrXCRSZzl0V97gS6GM6U=;
 b=FPgJ/FkaRU/3VdgEbaXkZGXvJ2DnCNIHALDm2x/c48YNuQnmulEXeayUBN2e9slmnILOz+vVBneAj3FN6H5uLUTM/AxrJIzcfq0gH0P8ATUeFzuYUdQm1myN8/Bg/e+fVW7SokwLrSDS4OSh6jqIEojjAvSovv5dx+YJ6xZ1UDUUiLiSm4J5FM0U78hG0N/59TymSUPobevWakp00lnKGwG25ljPUl77KoQDnHWSp37ykXd6pSYQKMzHsBAzTr3qaiLO+TKZT8EnVgdtDX+ILXYKZGYqZk4oYfYJZxTW+thV97hputuIaemUtVNWVrL/8C7fJmNyMd1EDae6GT7fwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKcbxx4pZtP4VgmnTOidbfRkrXCRSZzl0V97gS6GM6U=;
 b=gLXHcF2CHvvIjKJwTpg1H876Lsdx7Y0M41repWjFayv/CTOLA2ln/8pT37kGVqxnTY6WDYxXyzzEKkiEA/GKxQvatg7+s2WnPYZQUNkzTKAS58VkoAcDghzNtMQvXlWSBzAs/Gsap/mcZi+hXC7CZPvgio/wvLKWTGqo+b/6+b0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 04:10:05 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fd7:f3a:3231:c8a6]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fd7:f3a:3231:c8a6%3]) with mapi id 15.20.6277.031; Fri, 7 Apr 2023
 04:10:05 +0000
Message-ID: <1674a877-095f-6829-1f5d-c1cea6110831@amd.com>
Date:   Fri, 7 Apr 2023 09:39:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] PCI: Add quirk to clear AMD strap_15B8 NO_SOFT_RESET dev2
 f0
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        x86@kernel.org, linux-pci@vger.kernel.org,
        mario.limonciello@amd.com, thomas@glanzmann.de
References: <20230406213017.GA3739450@bhelgaas>
Content-Language: en-US
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20230406213017.GA3739450@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::21) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6dcf93-0e01-49bb-d0da-08db371df79d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qH17J1EVaw9JYXcMcf4+RT9s+AIkH7xw/s256TIW/+xmGaIMpTX0byiy5LCyJbEFM9I6YnqWqlCiQCGU674U4CGDR76kHhERlgzY61xnxVCXLeCe8cWE5YdeEoUQr+UnPswM7FkREHTTJEbFqHXt/5weCFJuml0+kmThjfbfLolKcMeQNH9aH2RqPSYGR2Mkr+x2ayLwWnzc88XjobUJ3Bt23ZG7/V//TyMCHlB42Gx5sAjN9NkMo/h57DdZYWO8l8qs9eFNm/fO1bW5AHKT7xt+baFgp+EXUQQur0JeHL3J8E9VZhDnyC1aF3HQR4lAGXjv1tb+W75LQelYt577Vxy1VJ41+Wo6+YbAvfym2/LyM/Ow+pYfyNe2KgGaIDrLorPZsMfr1S+u7UeuaN5/xUeSOrBeHxu+6gDO2S6LP2NzJr5QODzDRK82ICEPdk5us8GJrzPd5RyhcT/5cjLsljibtYvb6X4/w4u7EsER4fIX4/cM2RvmuSGBATZqiJVcCwMKrVSrVdhmUqCd/pEAkl2MGJmzby5xijpJlM/wf0azirXCg25e9SvNNr7TDCf8hRq6a+E3qM9JSHfyAIYvc7vNeHbB40MVlSJZXuxAtmxbtug3LTgZMfcJdOgLGEP69514U7MOB+9gplhGX0frUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(38100700002)(186003)(2616005)(26005)(6506007)(6512007)(53546011)(2906002)(5660300002)(8936002)(7416002)(8676002)(36756003)(41300700001)(31696002)(478600001)(110136005)(966005)(6486002)(6666004)(66476007)(66556008)(66946007)(4326008)(316002)(6636002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm9YcWRwOUZ5RmhaQUsySnIrazBJUm0rTmt3UVBsaGliRFlrWlBnVkJtMWt3?=
 =?utf-8?B?a1F3VmlHRzhFTmNYVlF3VEhrNm9GUGJXMStndzkvczdobi84elU5TDA0MG1U?=
 =?utf-8?B?Nnp0ZlhsdEl2R0lYcWEyZmoxdldVNWJCL0EvdDFEUnFJaXM4cDF5bVNBRnpG?=
 =?utf-8?B?eXpMVVQ3Q0U4bGRaMmpKVzkrbUtwQkFxLzhybU5VbTQ0N20vWm4zQTVENk5X?=
 =?utf-8?B?ZjV1Y1NsL2hKOWhHWDB1UFVKemx0UjkzdTlLaEZFZGZFY25jRU5KTDZpSSt2?=
 =?utf-8?B?WXE3bVVEQy9MTGRHTlZhTkdGVkhWQ0NaTlZ4T0VkMGlQSlFwdDhqQ0JXYUJ0?=
 =?utf-8?B?QlpVSWdNbkpMTUJhS3BoR3ZtWUtpT3lMcmlQQUhucC9kTlJjT3ljYUxEc1dF?=
 =?utf-8?B?QUJLUnNVVlFGc1NkOE03WVlaYllpcjNkL1o1SGF1RzFsYUlraGpLbXdKcG1K?=
 =?utf-8?B?ZHFVczYyUFZMQmU3TXFlNnF1TXV4M2VwVW5hZUpnS3hEVC81YWpIVVpmZzNW?=
 =?utf-8?B?U3BQSDJIOFgzbjNZZjI3eTlTbXpxSm9FVEhpc29rc2I3dVV0aDhiTEs3aXdC?=
 =?utf-8?B?bnRsR2lidGl1N3lvbkhrZElHcGlKci9aWWovcUJUR0w0TnFSU0tGRlpId29q?=
 =?utf-8?B?K3o0NitsM0ExZHc0NlNWd1FZL2lKNDJGaHVxNU5zeXA1Sm1ZTWRKVEZIWjN0?=
 =?utf-8?B?YmhVdU9veFRYQ1FEMmN2NE1JdmQ5RnhWRzhWUXB2VHU4b1drVEQ5WllXak1Z?=
 =?utf-8?B?WDNLZjBWUXpnNkZLSTdwWStVclphNzgzTzFDSFN4OUJ4dTdpRXFHZm94LzY5?=
 =?utf-8?B?cUNWMFAzaHlId0dvWHZGcUhTckpBajVVVU1Oa1ZLVnAyV0tyZVJ6RUtIdm45?=
 =?utf-8?B?V0o0U0FJSXlYVXFIVEhoV3U5MGdtRXNqV0g0dERKYk1jU0N2c0cybkxjbXNZ?=
 =?utf-8?B?T3dLTWJ6eUtqaTlQRlhFVGdKNFJWUTV5UXludXZiT3lZT2ZqanlIcWVXd1Bo?=
 =?utf-8?B?VzZmWVdZbjNNbEhuNnp5VHNYRDNaZjJCNWdGZU9LbWRSSDN2RGoyTDY0emZk?=
 =?utf-8?B?Smg3aHZCTHdDeEh4d3o1ZVdqeldqczlFcjN4L1hDZktISm93WW9uU3J2ekEw?=
 =?utf-8?B?d2RndnJxdHdJS3JCS3FPMHZpdElmNW1xM2dYTVBmWjNwYkludVNiZHoxK0Yw?=
 =?utf-8?B?dzhuQXA1Ni81ajZ4ZWtEOEEwdWR1NGNRcmc2WHIraXFydDdrZXlFRmlneGFr?=
 =?utf-8?B?UXN3MC9lUTJsaXhHZEQ0SmYxRHhDUkp4MTRrY0hFbTM4QU1qVU1oWWF1Nm1N?=
 =?utf-8?B?Z2hLbEorK050QVR1d1RzcVh3ZG9la3h1RklOSmdrNHowY3JBeUpSaGNEWFhP?=
 =?utf-8?B?RktPVGFnZG9GYW9XcTNyNjhlMXVsQTh4Ulh0QXIrOTdyMzVFUGFxTUtBL2Ry?=
 =?utf-8?B?ZG9BS0RjK2U4aENYNmNLVUJHTzlIVGpLVFl6VUQyUU1IU3J4STQreHRIWE1Z?=
 =?utf-8?B?YzllcGJlR1owMm5uLytVNmFwOEJQMEt1ZDJuSU5CSWJYME5DdmpUdjFsd0ts?=
 =?utf-8?B?VE5JTHBrcVcrdHBob3o4Vlc0THlpckVZQkQ1TTF5WEFhTDRpNXpUUGlWRVZt?=
 =?utf-8?B?OFJZS0NLVGh2Qk02ZGpDRU1BdHRwQUE4SFBWdytlRyswZ2pibFVMVUhnQm03?=
 =?utf-8?B?d2Rmem41TEozYTVjRDNxY2kxQU5GaDh5eVJZK0lrVjNRbU9BR3R4L1k3aEo3?=
 =?utf-8?B?QTlzQ3ZaeVRJUVA1dnlXYm4vaEUrQ0xEdjBMS05wL3VuM1MxRTYzYVVDRXMr?=
 =?utf-8?B?TVZlTlo4TU55S0t6Z1RxbjJRV0p3a3hNZXIwaGM2KzBoWUV3ZUdhcmJxMzNq?=
 =?utf-8?B?WlpsY2Z3VXdqa0hBMDYrUTZTY3N5NVFtdXVFYVhZQU14elhPQjEvRFB1YVpa?=
 =?utf-8?B?U3R3QXJFaHRlaVc4ZDY5KzEwOFVnY2JLVTdVbStzQjdSRDhSV1ViTE1YSDIx?=
 =?utf-8?B?cHZTclpBUXZ3ckcwcmdnQUJZc0lhUytZcmNMMU40Y1IrNVNaZ1NaL2ZIVUlz?=
 =?utf-8?B?bDArT2VsRXhCbDhtb01CVmcxampDWk1aK1BPSE14aXhtYnRzbEw0MWJBQXA5?=
 =?utf-8?Q?Yr9hG/aeq0+VjqVhSQLHnTG2L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6dcf93-0e01-49bb-d0da-08db371df79d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 04:10:05.4754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z84noFqJseueVKS8HoMOgZDFONlh/EdEEydbmcTLGb3lGJWxLo2kvTonwRSiiIuK72hdBoeiMKW9gdk5/3pbxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 4/7/2023 3:00 AM, Bjorn Helgaas wrote:
> On Wed, Mar 29, 2023 at 10:58:59PM +0530, Basavaraj Natikar wrote:
>> The AMD [1022:15b8] USB controller loses some internal functional
>> MSI-X context when transitioning from D0 to D3hot. BIOS normally
>> traps D0->D3hot and D3hot->D0 transitions so it can save and restore
>> that internal context,
>> but some firmware in the field lacks due to
>> AMD_15B8_RCC_DEV2_EPF0_STRAP2 NO_SOFT_RESET bit is set.
> This part doesn't have quite enough words in it.  Does the following
> sound right?
>
>   ... but some firmware in the field can't do this because it fails to
>   clear the AMD_15B8_RCC_DEV2_EPF0_STRAP2 NO_SOFT_RESET bit.
>
> If not, let me know and I can update it.

Thank You for updating. Looks good to me

>
>> Hence add quirk to clear AMD_15B8_RCC_DEV2_EPF0_STRAP2 NO_SOFT_RESET
>> bit before USB controller initialization during boot.
>>
>> Reported-by: Thomas Glanzmann <thomas@glanzmann.de>
>> Link: https://lore.kernel.org/linux-usb/Y%2Fz9GdHjPyF2rNG3@glanzmann.de/T/#u
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Applied to for-linus for v6.3, thank you for all your work on this!
>
> I updated the subject to:
>
>   x86/PCI: Add quirk for AMD XHCI controller that loses MSI-X state in D3hot
>
> so it has a little bit of context.
>
> I also added a stable tag since I assume the same problem will occur
> on older kernels.  Let me know if that's not appropriate.

Looks great. Thanks a lot Bjron for updating subject and adding to stable tag.

>
> Bjorn
>
>> ---
>>  arch/x86/pci/fixup.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
>> index 615a76d70019..bf5161dcf89e 100644
>> --- a/arch/x86/pci/fixup.c
>> +++ b/arch/x86/pci/fixup.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/dmi.h>
>>  #include <linux/pci.h>
>>  #include <linux/vgaarb.h>
>> +#include <asm/amd_nb.h>
>>  #include <asm/hpet.h>
>>  #include <asm/pci_x86.h>
>>  
>> @@ -824,3 +825,23 @@ static void rs690_fix_64bit_dma(struct pci_dev *pdev)
>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7910, rs690_fix_64bit_dma);
>>  
>>  #endif
>> +
>> +#ifdef CONFIG_AMD_NB
>> +
>> +#define AMD_15B8_RCC_DEV2_EPF0_STRAP2                                  0x10136008
>> +#define AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK       0x00000080L
>> +
>> +static void quirk_clear_strap_no_soft_reset_dev2_f0(struct pci_dev *dev)
>> +{
>> +	u32 data;
>> +
>> +	if (!amd_smn_read(0, AMD_15B8_RCC_DEV2_EPF0_STRAP2, &data)) {
>> +		data &= ~AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK;
>> +		if (amd_smn_write(0, AMD_15B8_RCC_DEV2_EPF0_STRAP2, data))
>> +			pci_err(dev, "Failed to write data 0x%x\n", data);
>> +	} else {
>> +		pci_err(dev, "Failed to read data\n");
>> +	}
>> +}
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b8, quirk_clear_strap_no_soft_reset_dev2_f0);
>> +#endif
>> -- 
>> 2.25.1
>>

