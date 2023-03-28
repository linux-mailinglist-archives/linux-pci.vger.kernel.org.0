Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A649C6CC06C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 15:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjC1NQv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 09:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjC1NQj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 09:16:39 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3040BDCF
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 06:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GF8+veqUiPCvXStIm+m0ZcLyW4En/lVyd2rQ1u/E3AYGsUleJ2m/E9u3ZfVau7pSOK3nuYABaDPqc7faX5p2aPhmpcW7BZD7CF3h/ip/DK2lhZPknlD7+cRymSQZsy5C+m4+8jFA5gvp7Y5sP1wx2yvpmUWIDHRf/4xI1MGdarKPfnvGJXfNXFRWRetNNOXcjL3BO4y3HaZfJvUwonjDeziHeiQr2KhY2yZY3ZIWIxa73XWyKXMLHCJHRHXlwkcrdWBBg2YrDld0zsT9sm+4A7V4O8gA6k49nKWRwUZfqQMQyo4QEaFiBS61wPWsvJnY0F46Jn1Ci5E81TEBADvmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehc1BGaVNRSbVpFBvNO88p7wOhwihI2WgweSkHuTLuY=;
 b=GsrLdh6TBz9UKP96UpAumoMHeMRbyPBdqKkQLqwwhaZZf8ob7y4he2xefgmlHIdm4aMW9BgAM/obhZPe/4tev/cNoTPOGHkGdVcsYQ2kJNooRIAoOzVjFElQxQLt/2lzjQU+TGHjpH+3+ukbBbVkbel5l3oVZX0ygcQc9YMtsy7vnTb8y63sxY6/mP3KsTYA5xQJbLxn/OAKu/RE2BfcUy/T/794AYPuv7wrWgCjSQ0/1BBaa9SY79TG4UUcXLziZeluwceGd+Syow+oM+tJXCi/3M9DL4WSGUIHBcjhxj6LcoR0B7Xfh3Uf/6wlm3iuaLTQyQSqJ4WBXTDQYYGuEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehc1BGaVNRSbVpFBvNO88p7wOhwihI2WgweSkHuTLuY=;
 b=J9r4nMLpsGOko6qB+XpGPqBR1u5Wn0I4sgwcu05whvCu287RmIOcFAaCiTVyF2nMtdv1VXRBSICD0idL3bCR3QfHORw09PayxlJyzgyrD9FVPg5d9jU2kug7LRmylvHovPrh4+500ZYzGqipVBIyWykWGidQ86mz2p780epVa8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Tue, 28 Mar
 2023 13:16:00 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fd7:f3a:3231:c8a6]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fd7:f3a:3231:c8a6%3]) with mapi id 15.20.6222.030; Tue, 28 Mar 2023
 13:16:00 +0000
Message-ID: <1f0829b5-09fa-54ec-f441-1bd7bd93b791@amd.com>
Date:   Tue, 28 Mar 2023 18:45:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20230321110747.GA2368837@bhelgaas>
Content-Language: en-US
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20230321110747.GA2368837@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::14) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: f20da307-db4a-46b0-e51f-08db2f8e92cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fuwHtTvKiipWsYJmZobtln7Xg7eulX1N37yWbe9ubDcBte3voaq6zvNuRqyz6i4ER+kCpLLZHfN6wiEpfVz7Oqw4G8dTtR3LLhb1uCThgN1MFnggMzVIIOgKW8L0qiZ01euU+Torfc81XJ4ZPbaZP1PX7PATuKSFycJYfdFz5i7wMe+LQ09NtDY3UFbyjNFiOVLulOjKShERvg21/hr11suoX6vKgk7vFo0qPub3w/eXHsB1pQ+Lwwnl9626nt1/YKjPDMxAM2YXMTd3hZQ3Jcis14UhBitY7cnL1P4+ZOh2+u0IEiswAIkEJq+FgKee2BU4bQ/6kk4FAz/tHyqlBxurOQQFbJymxvo9915dGYFuEPR/FShIwS5KruzfmmgHssqKVdZQW9YPO1WeQI1KaMJAJ9FiwmUKQl60Qmv3JdBtO9z608jcriiYmi+ZHjpruAelT9pB3EEt/mGc/9FITGML0PFcS++KxAF2XS+6n15UlAoi3e+iV8AH7gCII+8QGW/KEt89kBtR2Snumjlv32q9W/IHlRszwXSh5lv0OAYW4b/bv8Jb/A+MzzXfjA/YbSoinKu0ZFFaK7EIuMOGINpQaAQ80gM+5kWn+YlaeSr9xp5ENhOcvKB2hZjbZHONbO7DINxrHG2pqFErFuvXRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(2616005)(83380400001)(2906002)(8676002)(66556008)(66946007)(4326008)(66476007)(6512007)(478600001)(6636002)(54906003)(53546011)(316002)(110136005)(26005)(186003)(6506007)(6666004)(36756003)(41300700001)(31696002)(8936002)(6486002)(38100700002)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUdkOUFEYWZWbU91dG4ybjRieGhrOTUrY3RFUFdhNlMrYnVlMVkvK1FHTkE2?=
 =?utf-8?B?Qks0a0RBMHNHQmFtTHBKVURqdkhtQ05FMjcvN3krL3FvSjJxK2VCS0hXb1RB?=
 =?utf-8?B?ZVk0dXJBb0pYT0hYWkV0M2M1Tmh6MUNOQmpyOS9abG9VT3lCOStHR2drVEdE?=
 =?utf-8?B?Z3hCM1F4Z1BDQW9YcDdGLzdSR1NxQVRzaTFLbDV5S2dIbDhaSTcwbmc4cWR4?=
 =?utf-8?B?QXhqYnFuSFlRSTlJbTJ6bWJrL1dTaUIxWTE0bnpGTGxiYnczNFFkV2tIang1?=
 =?utf-8?B?S05PTnpSQzdmdGhsRzZ5anNKMDBwR1ZCbG4rZ3h1eGdFcnFIblNPc2lzUmtN?=
 =?utf-8?B?WFJvZmFiSjcxdTEwZ3lmdFRBZkptSGNOZ0dlODlnOUVCMGNQMWs2NG1YMWdP?=
 =?utf-8?B?VTlieGxvVWRaQnFMUndYdGVVYXdOVDhzN255a0RqdUVhQ1BvV211Mm16d3ZS?=
 =?utf-8?B?Ym1DVUgzdkJTbUkyK0tBbERtVlF6MFdyaWl5TjgwaytaU1BmR1c2YTdmdU1r?=
 =?utf-8?B?T2RnWmtDTmo1aHlibWtTVVdtc21QRk1Gb1d5UHJvVzVKb3pLZndSVm1FTUJn?=
 =?utf-8?B?UjVaQjBKaVdmSXRWU1hVZ1dKUnovaFh1VGZvdG5rUWNUc1p2cHlyS2pKM2t0?=
 =?utf-8?B?M05USW16VmZhSTJ1UjMvOGNJUjBnek8yekUxSWNXeENJTFRaVVZRdytNQW5F?=
 =?utf-8?B?ZUZUQU84dTdQcDhVc0h2bUFrS2VmbHlsdk1iK3hjZzkrNlZYVGEyMnNjZ1J6?=
 =?utf-8?B?WXRZbXJlMVFubjR4NFV1S1BjZHhEdlRvLy83T2pOcUpFTGxwOXZ6bkNLS2ds?=
 =?utf-8?B?MGlGRnJ0aG9ubmxkbXBOOFlnamZuYzJHNThSenhWZFZnV3MrMkgyanRnMUI3?=
 =?utf-8?B?V3JYTUhrb0kzYUtaOG45aWNWd053UkhpYXFGYjZGMW1Nc2FRSmpDWjZQZGI0?=
 =?utf-8?B?YXcyTjhza3RsTWpnK0Y3bXNjanNDdGpucmJPcnJ2QTdjczYxb0FCSHVwSFFI?=
 =?utf-8?B?VjlsaVFnemdueEFGcmNZaUlLYmR3UFc1Y1pZS2hGMnY5WjgzSDZ5YkZscWxE?=
 =?utf-8?B?WHlUU0RGSTJJcFNrS1hxTjFNR0N4U0RsV0V4Y001MUpIZk1zeHhJdmwyVkJu?=
 =?utf-8?B?cWgvamJzRVgzU09YYjBoQnYrMlhxa1JIYkNVWjNCZmR1UFh4VUg4ZFA0cXFK?=
 =?utf-8?B?cjZHOFRMaU8va1NDTExMVEVmTnVveVhNYXNzd0Q3d1c4L3duYzFBMitDTitF?=
 =?utf-8?B?OXVxYUEyWlg2NWhWdnZTWnRvU3dSZE5aMDhteWJaTGhrT2g2dFd6RC84STVl?=
 =?utf-8?B?ZFlMNXV2eEtyWG0xdXBCZVQxSHhlWXB6b3BuMVlzejNaVlJ3THJ2YS9iNVp5?=
 =?utf-8?B?cGo5MUdZWXRWQS9UWDI5V3VrdHR5dytKMEx6R2REdHpSZTRhTjcvMHJQeEZi?=
 =?utf-8?B?ZzlrMWQvaHoxS0NtbE1tdjFKMktFcWdhRDIzUDRsaFhLbHNRVG5UVmFhdStD?=
 =?utf-8?B?UGVuVHNyRlFYZFJ2WW5yY3hsR3hHb2ZmcFVYZ1B4eEFXTlZKMjFzcTEvTHd1?=
 =?utf-8?B?djl5WjFBcFp0aTQ0TEdndG9BNzFCRDVDN2ZsY291OGd5RFlrd3prdFBKeGFm?=
 =?utf-8?B?anEzSS9DbzhHWkZHTmQyd2ZHakg5UzdTUFRhVmcwYlpQN1g4Y3RPQmh5WW5o?=
 =?utf-8?B?QlZqMk9pNjlCYnp0dFVBWWdkb2V3clh6aW16aEk4NE9FVVkzL1liUFNPeUNn?=
 =?utf-8?B?RkJNYnlFL2JEVEZxV25WemkzUk5RQWZHQ0Q1UnBCWU5teU41Z1FBeVBJQ29n?=
 =?utf-8?B?UkxzRkk5YmVuOEd2N1RxYjFHUzNSUUttUVVTODVYTVp5ajRuNFZROVhKNEJI?=
 =?utf-8?B?ME9ENnhmRWN0VlYvOCtXK2tSRlJZM29IYnJsamlET0QxL2cyVFBNUXdRRlYr?=
 =?utf-8?B?SmJSbE1QTCs2dW1wV05TSklhakc0UUc1bXMwV2d2cGtFY0JybHlmRjEzS2Zs?=
 =?utf-8?B?ZEpZcjlBaFh4cXRhQnVNaVhtcmEzZStNeFZIOGdwVDBUSFlVSW54SmE1OTBW?=
 =?utf-8?B?NDI1c3hveERrNERaVTNkc0Ewc2xZWERlYTlXNzB5b3lYL0plUE81aXZCUjVD?=
 =?utf-8?Q?b54z72y9ZkV6uxQTG+RJD0Q4e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20da307-db4a-46b0-e51f-08db2f8e92cd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 13:16:00.1445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sK9cyBzfEsYNWjETz0uMRYN9BGva7Zyf0M4+67EBGO2mrZqTUU6WH8lU0Wbri1wqxj1/dE2ZT0tAd36p2W/Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/21/2023 4:37 PM, Bjorn Helgaas wrote:
> On Mon, Mar 20, 2023 at 05:52:58PM -0500, Mario Limonciello wrote:
>>> If Linux *could* do this one-time initialization, and subsequent
>>> D0/D3hot transitions worked per spec, that would be awesome
>>> because we wouldn't have to worry about making sure we run the
>>> quirk at every possible transition.
>> It can be changed again at runtime.
>>
>> That's exactly what we did in amdgpu for the case that the user
>> didn't disable integrated GPU.
>>
>> We did the init for the IP block during amdgpu's HW init phase.
>>
>> I see 3 ways to address this:
>>
>> 1) As submitted or similar (on every D state transition work around
>> the issue).
>>
>> 2) Mimic the Windows behavior in Linux by disabling MSI-X during D3
>> entry and re-enabling on D0.
>>
>> 3) Look for a way to get to and program that register outside of
>> amdgpu.
>>
>> There are merits to all those approaches, what do you think?
> Without knowing anything about the difficulty of 3), that seems the
> most attractive to me because we never have to worry about catching
> every D state transition.

Sure Bjron we came up with below solution without worrying much on very D state
transition and works perfectly fine.

PCI: Add quirk to clear AMD strap_15B8 NO_SOFT_RESET dev 2 f0

The AMD [1022:15b8] USB controller loses some internal functional
MSI-X context when transitioning from D0 to D3hot. BIOS normally
traps D0->D3hot and D3hot->D0 transitions so it can save and restore
that internal context, but some firmware in the field lacks due to
AMD_15B8_RCC_DEV2_EPF0_STRAP2 NO_SOFT_RESET bit is set.

Hence add quirk to clear AMD_15B8_RCC_DEV2_EPF0_STRAP2 NO_SOFT_RESET
bit before USB controller initialization during boot.

---
 drivers/pci/quirks.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44cab813bf95..0c088fa58ad7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -12,6 +12,7 @@
  * file, where their drivers can use them.
  */
 
+#include <asm/amd_nb.h>
 #include <linux/bitfield.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -6023,3 +6024,21 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 #endif
+
+#define AMD_15B8_RCC_DEV2_EPF0_STRAP2                                  0x10136008
+#define AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK       0x00000080L
+
+static void quirk_clear_strap_no_soft_reset_dev2_f0(struct pci_dev *dev)
+{
+	u32 data;
+
+	if (!amd_smn_read(0 , AMD_15B8_RCC_DEV2_EPF0_STRAP2, &data)) {
+		data &= ~AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK;
+		if (amd_smn_write(0, AMD_15B8_RCC_DEV2_EPF0_STRAP2, data))
+			pci_err(dev, "Failed to write data 0x%x\n", data);
+	} else {
+		pci_err(dev, "Failed to read data 0x%x\n", data);
+	}
+
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b8, quirk_clear_strap_no_soft_reset_dev2_f0);

 

>

