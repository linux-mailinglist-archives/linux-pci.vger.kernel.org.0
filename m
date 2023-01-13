Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAACC669557
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 12:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbjAMLRV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 06:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241530AbjAMLQf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 06:16:35 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538BF7A387;
        Fri, 13 Jan 2023 03:12:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRMnxsSpZT2BSAfeUnK2HFGmuhW3WjTntMhIVDwVhZlANpRBXyjWomneru7GQ5020MJgL4Q4pbQwMfwe1qwsEuUBNs9fyQ/I1XbjQQFOjBZczCLXpD8Z5yrjIRNNOByHgas6t+XPWJLGUtQkY800+sOONDVZj3yjjZ8qlVHpONYj9eeYcSDQQC6UZTy+GKKVWMRYcKWmf/STNcwHEgau9neR+E1VEZK5+mpikvjEDqtsTQ6j/PiQWM2utKUjRLcy670JKmuupBPNvcf0lTc5kJeqbEtcmLr5vbS0vNkngIetbzCTmjTin9zNtUb2+9UG/FrxwLnx3i2XiTWfbe1qXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rIlF54IUhhThyJdzDAxR6yoTRNno6meRuw28Yr0U+k=;
 b=E3hqv2jkk8f5U8ZgUIdq0WEYemTojxZRtjKLc3XGVYrqho4wBoeuwGm8mkxeS9wQbRikTZJbnBFdKIQR9egN83PdxeelVCueyj/jKdHAl7fWlD+vsf6T/apX4QME7cph82myalWJq+ij6JnO70tspq5oBAN4khcklTZx5iCQO79zgZOaA2rrxEWaFcQByZISgUDPFbg5t3DTkv0gVTbr/1a90Et6G7BgA/f8nAM2MWFXio7m/4Yd+0vbhI+Z36fY4LtzQ1UR9Y9xOhEujnjIHxKOXWrBLEya4iskIrQcYd0vCb2P4nND1dKuxIZcqTnirGXFBlEBkIJgYaDRtBH0Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rIlF54IUhhThyJdzDAxR6yoTRNno6meRuw28Yr0U+k=;
 b=gjs0lIHwPPedtZ0TvuGLeWJ3S9MmkXXcNC067gZ6+rYim/MTI5lDHtebH/TRfnHkcxvyMYQenl/wPDYBmJJlmKb1fHRQfTYo7Djbo6bQDgCT5uQsTjmoxSn19dG082IHIQfm0335DNGEac30av4VjjK4UHXzqXiBFFROJ4f51RIRWx6yZXiAQgAED9jghIP8sYhPhBCKMp4NiT/1mGunEYl8AKh2xvH7F1KUp+1J/8Um47KXLDsAnAZul2MJSS2t4H+mht1nXAxK3hBSqiGu0FYxcl0V9tsoNBH5i3ApAv5E5YincVRXhva9FiqJLuHh2hXSvQzevb2tweomhymWIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by SJ1PR12MB6291.namprd12.prod.outlook.com (2603:10b6:a03:456::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 11:12:26 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::8ae8:c68e:57a9:6dae]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::8ae8:c68e:57a9:6dae%3]) with mapi id 15.20.5986.019; Fri, 13 Jan 2023
 11:12:26 +0000
Message-ID: <8c5ae6c4-c282-6273-34d8-2eb62a00d364@nvidia.com>
Date:   Fri, 13 Jan 2023 16:42:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: PCI ASPM regression resulting from commit 4ff116d0d5fd8
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Francis Enriquez <enriquezmark36@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>
References: <CAJZ5v0gKUq_A6mBC5stRo20G+Z=9v90AbAQ51c4uKm41OiCKVA@mail.gmail.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <CAJZ5v0gKUq_A6mBC5stRo20G+Z=9v90AbAQ51c4uKm41OiCKVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::21) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|SJ1PR12MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: ab254521-ffcb-415b-0273-08daf5570d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDR9t4JbikU7IU4oTWN/Lkh3xCE+vVThOZtHWYyBY5G+1iTJexH6MyFVj6S4lQ1cnD3rISbIAZ26BDE8L5AWfwFu+zHDkZBQW3tpKyAb5I6SEhf6w4zbqJhNXg+oqIN6TQG2e9cZRROkVgW+XWbNQ0zRexMkJeiPu0ZsLH4qe7bRPT6T88+4jkIgxZb8V/AmgagshERriC7IZrrgpaOWChiyPeswljFfzvo7l4kd2JQ3tUfH+FyZrsB/jh2ZE8CHf6NfiPPeuw3lWFZyPriJAc3NqCfC6RCaegzt4Ocq3cV/pQL32a1To0g887CNH3YMe6DN0UxQQ4uNZhyLs3kSn6QlBJw+Rdb6YUPpQzLJbklFYccW0v2dHJo3oGazA06Li4fcgyvEPr+kXTT7+TSRj5wbGDj9Wyqka7SsNuO2gDecq56gv92RZpsbclcO4BFyF6SwWDCg5B7Mnzzwf87dcQQxv/5cVF/NnmDIZ2MM01CtFvxky7/qYYga/FGd4D/Z3b8M1wOLeXZtjdxXRgGPMBc8cwqSGaCzWa8aDsurTH9Us0+TM+w9CHK7fgUSy0y7ycKjLIdgJJJxW534jeHCRzofFzTbVJKpx+rW5lYyq4tXx3zq/UpDyskbMEaZV515iE/UTdivZwbZTqpxvjUjw4p1MJikKL+KPNyLFsrE11fpDxbp10ZbTmPEmiqL+dn3oVYCO1NGtoMZUrZW/G5iC8YpQzFtbHwApEYWtTXx3a3BUy60Go/B0Qv9QRe4AHIk0BA6al8FZRQi5ufXGCZ3Ur4WtTcjI9BpGLlzQlNqTDTWciPUJ6FbU8uK1eNS7G0xKUjEYBTPwfU89s1UrLOkyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199015)(31696002)(41300700001)(36756003)(53546011)(6512007)(8936002)(26005)(5660300002)(478600001)(6506007)(6666004)(6486002)(83380400001)(2616005)(54906003)(316002)(66946007)(4326008)(6916009)(86362001)(66556008)(4744005)(8676002)(66476007)(966005)(186003)(38100700002)(31686004)(2906002)(98903001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnhJR0N6VXJhUGZoZGdCVjhDSGdYc1lHMGRGS1JSZ3ZCQTJsNlRLL0ZZR1E1?=
 =?utf-8?B?dVdqZGN1cjJLQ3dOMmhXYmdZNWFnYko0dUJubVA4OWlFaXNKdmV4SmovOVJG?=
 =?utf-8?B?OXNFblZCMkltanAxNTBjTm9uOGQrUXcwekJYb3JtVVExdGNWS0dTV2Y5b2Jm?=
 =?utf-8?B?MjZjdUhnUmVXaWwyNVMza2hzY3d5UUR1V01PWEMrRXRzMUk3Rkg1NG56VzJV?=
 =?utf-8?B?T1h2SU5YT2xTMGNUNnNHQ3R2VGMxOVg5K0dPdUtycjV0L0RwYmNBM0dEcmdB?=
 =?utf-8?B?REhwd3ptWktLUFNIaGxEWkRwTmV3MXNKZVJ4dythSzNycU9MZjAvZU9pdlN1?=
 =?utf-8?B?dzRYbzhPUE9VQWdLNk5PTXY3L2Z5OVR6WCs3VjZyMEEyREdsTzk3cUp5bnBO?=
 =?utf-8?B?enRXcFJXZVlQZXBHdUxIdXRkbmROMEkvRlg0N3pHU0lKTjQ5RUh5YmxIVjkx?=
 =?utf-8?B?WUsrNU5GRTgzbEgwMzBOOHd3Y0RnSjhIN05JdjE4TmcvQ0xETGtDZ2JQam1x?=
 =?utf-8?B?TjNEUUx1WEh3Yk9NSmxSMzI1WWRxaVZObWMrQURVZkhkWnBhdXlabmUvMUxt?=
 =?utf-8?B?SlpEQ0NQRDI3ZlkzODZmcE5rM2F0Q1Bmb1lHVmN4YnBSTVFYdWh6Rzd3YU41?=
 =?utf-8?B?dHViTlJpdy9FTm84VTZsamNyZ0ZHdVcvWTNyVVFoaFBSV21wVExJUzJvendq?=
 =?utf-8?B?QmV0SFJWc3RLNFZwSldRKzVETjRRVXowREdGbGFlTXdtUStkK2R6MnFwK0ow?=
 =?utf-8?B?dFIvTTQzT2lzM3VLaWtXTFFzZ0xBM091eDZMdEVLVG81YU1kMG1pbCtaTXZs?=
 =?utf-8?B?U29UUHM5TTVXQjNydmZWU2VKWk9vSDRsSE9FcWJRd3BJS3FtUU1RZU1QcmQ1?=
 =?utf-8?B?N2hCeHFQRmpnOUtoWXd2T0tObkxyNlJ3eTMwZHQ5ZzhNWXdpQklsYkNWN0FY?=
 =?utf-8?B?cDI0M0RHajBnYTZ0VVdPTFd5a2txMUNyV3hNV2dCd2daMVpyMTB0a1Z3cDJs?=
 =?utf-8?B?WEFLcmJ2dFVWdFlZM0I2MFUrODBWeEtTbHZ6WFhaRGZoVFQrWklGNXAyK3ZP?=
 =?utf-8?B?Z1VTakJ6TXpMMUVidWRZVW9EaCtFeHV1TmFISUlvTk5qUXJ0U2VDWUw4K1ky?=
 =?utf-8?B?eGpVRllsTzhyMVdXUlR0WUpmM3dsTzI2NjlyaGljV3R2N0p1cTJjNm16TnBs?=
 =?utf-8?B?VWJJeGt5c0N4eVUvcGEwVlpWdUJqRGgyc1ppand2Ni9TanlOWFNYdEY0WjBN?=
 =?utf-8?B?UVZwakl6Tm1jUE5iMnR6dDNMMGFtUWFWRUNkTXFiQWZjUGo0d0k5RHRHTnU0?=
 =?utf-8?B?eG9GUHRYNDlvM1BpZTFxUE1kbmNuQlRFVXlBeVdpMm5ncnFJenprOWd3QmVy?=
 =?utf-8?B?UzZDWGIycEJDRTY2ZkF4R2xEZ1A3eHJKTjFaOEhJYTVpejZFL1lEcE5EUTk1?=
 =?utf-8?B?RFhOcXJGRU9rYXJPTURielVFVnpjNVppbXpOZE5NUzFVTlhhWkowRnhjbis5?=
 =?utf-8?B?T3lGQS9qVDJ2TVhub1NFdGRubTlDbmpzWHhxMVJISFNDemQ5MkRKakZjd2JZ?=
 =?utf-8?B?aFNBOWZlRHNOdnlRcFFFOUYwWktkUFZ0aEkveGdyWkJGU0d1QkFqaHB1VjFu?=
 =?utf-8?B?TGNOZGo3ZmRadWlPajAyQm5qNmNjL0FjQm40djM4eUlDTVRETmpNcmI0bWxD?=
 =?utf-8?B?MDhjdFVLMzVLTThud3QxeUQwS3FnVFNxb3pzQ1owOEZIVGQ4b2JsNWpmSUVV?=
 =?utf-8?B?djQ3OUp2K0FkUmZpUDJzL1I4ckpkMTA5QTQxSWo4bFY4UWUzRGF1R2twY1V5?=
 =?utf-8?B?NGFRdnc1eVEwcWtOZkRJNEdSN2lnazJDM1pyb0NpT0p3WnA5YUFPbUN5alp3?=
 =?utf-8?B?TFZLcUtOQUoyN0R6Y1NlQ2RwcUxJRm9WY1dqZEJMdWF1U2xYQVYzZW05eXlL?=
 =?utf-8?B?b0p5NlNKN2ZEKzhib25rckRRQjd2bE5ZWGtZMGNFUWx5cE1ydktRRmtVdFZ4?=
 =?utf-8?B?cmdscjVJL2c2M2s5V2ZGRktrNElzM1MzUnlveFZITkEyZnNIWERaZDdabUpD?=
 =?utf-8?B?T1JRWklnUTBpYjBpTTR1S09hS0dTOG45K0xqSmxjMjg0dFlQaVZkYmZZRWxB?=
 =?utf-8?Q?2K15haWLyxvk7ddqqtB0P6Tzx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab254521-ffcb-415b-0273-08daf5570d35
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 11:12:26.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwomK2mCi2yJiqd3k4Fo8pOSBGSmgFZhVVa1DT9/imV0FnCVrF07jg0+AQ212loXsP7AHavbjgBFeAQMRDskmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6291
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for bringing it to my notice. I'll look into it.

Thanks,
Vidya Sagar

On 1/13/2023 12:30 AM, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Vidya,
> 
> Your commit 4ff116d0d5fd8 ("PCI/ASPM: Save L1 PM Substates Capability
> for suspend/resume") has introduced a system resume issue described in
> the bug entry at:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=216782
> 
> It looks like restoring the L1SS state during system resume has
> unexpected side effects.
> 
> Can you have a look at this, please?
> 
> Thanks,
> Rafael
