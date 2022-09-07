Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CF65B0370
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 13:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiIGLzY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 07:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiIGLzX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 07:55:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399E872683;
        Wed,  7 Sep 2022 04:55:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBJ4xgMzmO68uEQNxiNlmf8hpVEsRI/ywy3GiDzwv47Rn6yL4DwiHIZZqy3KrDl4BrnEjpUzCL8fcgdPfyZEGALzmxBIla4yzgGXJkcF6UAuFPYKW5k1CN5dY28omES20PhPwS14USniMfpxNWm2LtllRHvYYXvYW1UN9syD0/27bfHBxOKyvJEyotNsiqqEMwSzQK/SjWZ6mtS8ZEv/v1D3hYg+GP4aaIneuDJ2bxu6ztKbeTWkaxcFfJEAQMiW8Vl9GN5rVH8P4XpwE6g1oxGWPA33gSY0HAsi6+HqgLbmlkGSuiJ7jqI+0nhdbcvpJXD3MrJDiWx5ubM1S2Omgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfZthBpnKqCoLmVose6nP1VObPoNHE1u5quuEun8O1M=;
 b=US5sSXqXQYgKAwJjKpHXvGPeBeiu34lisBz5l4LD8vCEVanbFYlXk2rJmii3xIuJS4aXpKeLG1BZVbeXNQRJAT+4YZJKD74KlkRcUDBL3FKVo1Zd/keVuaNMuvHQR0A9+zXi1JkosK5BOdRxRLFQn4veWxO8n+soP5w3YMjGyIOyRQgxK9zjTr2ZWITGdia9zzsFfmajvExsfDMNAEpFn2EkdwcFcTQP0hlG71NU8oXxdYL23W0yKhTWqOXElXb88h6FyaMb8AC/zmwVEWesJ7FKLT8CvAY8P47/dem6ARZcFPCfy4Exz060aoxiWkZgVHt/3gvEUhkW2bx6cFFp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfZthBpnKqCoLmVose6nP1VObPoNHE1u5quuEun8O1M=;
 b=am8rMQ44f7hVEh6JavVpvhesTzQ2Xh0GXTwMmsQS4rkC3l2ZWvuW5JXwHlck7Dug+43IL3+XhsF+zVmP7JP2u6hVAGHHhFCf2dPpQviL/hwdg0NeDh4lCkY9vSbm0EZWWZ9+PXTG+Um8f718fG+n/Jh7S5QQOblyAMoWhoHdfv0jbYGJAB0/GBo4VImj1eNCM6E4u68GHr/ZUGI0dsUNwQG2RoI/Xa4ZzhXKU0pElqVzPMQFX6MO/HgSsZib4TjSb40F28S4IsxhPfYsfIgt/rf2+d4amgszsEb4lGmUFyt3mm4Ki2RP+//B5qeRAoFKDoO1mfpqPKL+YlZa7jJx3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13)
 by BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 11:55:20 +0000
Received: from BL1PR12MB5304.namprd12.prod.outlook.com
 ([fe80::753c:8885:3057:b0a1]) by BL1PR12MB5304.namprd12.prod.outlook.com
 ([fe80::753c:8885:3057:b0a1%3]) with mapi id 15.20.5612.012; Wed, 7 Sep 2022
 11:55:20 +0000
Message-ID: <2bd71555-ad5e-601c-412e-851cf53b2716@nvidia.com>
Date:   Wed, 7 Sep 2022 17:25:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V3] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, refactormyself@gmail.com, kw@linux.com,
        rajatja@google.com, kenny@panix.com, kai.heng.feng@canonical.com,
        treding@nvidia.com, jonathanh@nvidia.com, sagupta@nvidia.com
Cc:     benchuanggli@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220826125526.28859-1-vidyas@nvidia.com>
X-Nvconfidentiality: public
From:   Abhishek Sahu <abhsahu@nvidia.com>
In-Reply-To: <20220826125526.28859-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::13) To BL1PR12MB5304.namprd12.prod.outlook.com
 (2603:10b6:208:314::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5304:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: c312e55a-8fbd-48d9-f216-08da90c7d675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QIXGrVp8c4kXomdwEOb+iwhkPrKHPTFBaXr5ASBr2bZCy0wsbZAcTQqsrTSEujfzyp8yCW5gv8/F2nqcTuHG0tceN5Z5E0ToFOXcPIPxAorE6osxqM9gb4cG+Q18kZlTL3rU3JMUzwwcbHhjnaRXyp/id5i2WplHnS0xLIkPLIVi9oU+Npc1D9eH85FmAzuofhfETz0UCmyEPhm5OwNd6Bs8WAJsr5wCRybLx9aODX5M2VScQWEBwEG6vjE0yTybbKWIbB04CcTmrZnKCoWftVmNEXnH94yde0P3BjqUTbM8ZvPJHoXDP010gPJds7nyZHoX6l9YXmr/x38Cw+UCA1GKMXSXppfJSsLLypPZdyHUZJLuMtgN1K44H6vF7HYHqYvInkTnv5rNrAO+k8b/f8WVjtxFWe8+naPY4t6jfViRYvIkBW6k9aym2UpTuND5aF/D0k581oqQV5Kh5jivwzlchGixjtXCaUHxfe1xwaELyoYzHSWmd2BUqfe8RfqLN0s1mYX95uHxPwJKEUBUjmCn4vL0L2VNLlhwxkcJQK9wKTw3CZDcK+0Qbxk32RQYGxBpPEa3ltVzynKQdpMILqnyKf0Wa9LyyPYY6t07gOMA+/ModN0qgTkwVqi+z9o61C0pwMYIpJVf+QhHvKukjAZNVVtIFAIVCRyPXA6WM7r8taHz4nFDXe5q1EJfetVjaG9dHzsqiUdowWUGtUfdA8rPIp9dyENwRkh6cXU0Lo9GsIDoTxYcvAkdeh2NAwcvtH6eUXuYK0yOpb26xp5EOxvTHLQZwtYzQUaSTtixV/USXfbL4LaTM1S9LGcuTuLEJTv14adNEXLrRDu/yNBZEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5304.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(921005)(186003)(2616005)(31696002)(86362001)(83380400001)(38100700002)(2906002)(6636002)(4326008)(36756003)(66946007)(66476007)(7416002)(5660300002)(15650500001)(8676002)(316002)(6666004)(41300700001)(478600001)(55236004)(53546011)(8936002)(66556008)(6486002)(31686004)(26005)(6506007)(6512007)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0dxT3lNY2Y3U3NkY2ZLY0QwR3A3Y0FMc3o3SmtVSy94MVEzL2VVaXU1VjJB?=
 =?utf-8?B?V1VGSmxpQmxRN0V2dVJCRm44MUxKdXh3SEdEbjJIaEZCNXM3NHNjb3Z2RERH?=
 =?utf-8?B?M2Q3NXNwNEg4VjdQZG9wSHE3Y3Z1S2FrK1pObm9vNHFNYkJGZ0FqYjh4cHB5?=
 =?utf-8?B?TWNBNEpVZG9kUTFYcXkzSzViR21tRFJ4bDBkNnYzOURnSGtOYmFDRW9LOFN6?=
 =?utf-8?B?UktkV3ZkR3JtUFRPd3RsMW1DZGZwbGk1bitOcXhuQW9qeDFLNktEV1dvd3pz?=
 =?utf-8?B?ZUcyMTZ2ays4ZmFvdE9HTHZjdlZpYjdkMEpyZzFGSEZ3M1JYcURpYXJxWUt6?=
 =?utf-8?B?ZU52ank4clpET0V0cVFZSjRiTkRyd0VnUFQ2Q2o3S2lCMkRSVkhBRzVZNkQr?=
 =?utf-8?B?L2c5WHcxY3ZCWW1xNG5iNlJtUnZCR05mMUV2NDV5TnQ3ZTBhRkZTVWxhWEJn?=
 =?utf-8?B?bFBVc3dwU2g4dU1Xa2tKb0FXYnl0VUNrM09CZzYrbytJYmFPREtFQktGM3Fp?=
 =?utf-8?B?QldXY1BxUUZBUjlTZE5QclpyWEtzaFg4dG5HTDNIVjBKWWZyd2pORVBKQmsz?=
 =?utf-8?B?VkY2U29qSkVXSHVRRElZSG5xeUwxRGdkdnJHZU8zeUlEanErSndoUEphRnJi?=
 =?utf-8?B?WDJ4ay9hTzltKzNRanNtNHpVRDNvSXNxamVKVWpEajhOaG11VlBOKzhnQTU0?=
 =?utf-8?B?d0QzOTlCTkRBeFZwa2hEaUtYZFllN3pva0t5ZkNWT2ZmSk8raFUydFEwMnE5?=
 =?utf-8?B?MW5jMGZlYTZwVVl4aEdmUW9xQ2E0WTZwRktpQitlVkIzRnJ2Z3YzU2FVZzlu?=
 =?utf-8?B?QTdKNjE0ZmhXMXJBR29LYm05dnFONlZLeEN4QzZsc2VsOGpqSUVLbmxnaWNZ?=
 =?utf-8?B?OUpZOFplekRKZG40clo4UFpXUjNOSkVhQ1NWMzVaeXlpQUtmUFlPQmN2MFhy?=
 =?utf-8?B?VXNnTGhQV1gzdkRkMytmdWN1MTB6b3R1T2VCRHR1NURpNjl6ZEQrSDlOZEZ1?=
 =?utf-8?B?R29UbVlBR1ppWEZFdU85cXhKcXRycnRzNU1MdGpxZWFWYmJxZkpzSDN3RXAw?=
 =?utf-8?B?VlQvWk5tUWJjVlBHZjRxZGpnVUtoMGsvZy9mK1lmOERzVHpCRW5LczVnYkxx?=
 =?utf-8?B?Y1ZVVVFyZ1VQUXZYWE8vYzNsNlRJRHoyb2xJVXJ1aHJpNGdndUl2U2o5ZmZm?=
 =?utf-8?B?MGd0ODVqVzduMFRubzlBZjUvK1ZRVlpiZ0k0cW43NndIOTkxNUh6Z1RIN2Qr?=
 =?utf-8?B?RkZyRU9NOGpsSXVlV29sNmpCN0JlRmlGRmkvNkJVaHZwR3RQeDZ4dSsrL211?=
 =?utf-8?B?bXlPRmZyOVF3SW9EVlNSU3p6ZXZLTW1peFRnVDJvOE44YWxpTzN5dTZFQjZB?=
 =?utf-8?B?amtzb3RXcE5GY1I0VURhQ2NuRERabjJzYWM2bXB0M08yczJUbVgraVArM1Jw?=
 =?utf-8?B?TFhaNnIycS9odlNwV2JPNC8zOVhEREFmcTBrcVRxQlRlL2R0VThvaHlIclBS?=
 =?utf-8?B?RDVVY2FXK0hXZHlDK2xCdXFwN3E4M0wrQjdXVFNGcnZrWGZMbzNNZGtuN3pF?=
 =?utf-8?B?N1Y0NCtSb09BbVNlOHBIQTRmRzgranA1Yk1nSlk4cXgzQzU2bnFPVjBUYjVw?=
 =?utf-8?B?Q3U5U1BKVU91RFFEQkdORFBTRzFLVjhtRG5lQUVtam9kUkw1ZjN0T1JvOE5H?=
 =?utf-8?B?RzdKKzVLa1pKd05aOFB3d3lWTzJJVG1OdmgxazVZcjNrclk4OHJ2MEQyRlRK?=
 =?utf-8?B?ZW9jU1J3QjZLUkswZC9HMVdvTW1aMTZ1WUJsUmc5NGRWMWgwUnZ0azYvbDY0?=
 =?utf-8?B?T0dodXZUNXdjak5rcUVDQzh2NnQ2QmJUU2VqUVJSZWNMciszdkdZZzRReVpE?=
 =?utf-8?B?K0FDQVlkM3V2T0RYVEFCOGVSc2dFOTdwb3BRTHJkRkVxQW54OW1jUmQ4aTZ4?=
 =?utf-8?B?anlLSS9ZSnNUYzEydnJxN2FPemhnaUJMSWt1dFF0RmM0U3ZaWkR2bnN5ajd3?=
 =?utf-8?B?VnVZaXZpRXZNMFpwQmpvdS9VZythUjdBSnVCYTI4RnM4NnM3KzhzUWdLZmJp?=
 =?utf-8?B?aldOK0NDMGlBNk1Qa3lVT3YxOEV5eDZ4VVRrcjhGUGlEa0FuMGcvaFkwSTJS?=
 =?utf-8?Q?ipej3kfyXSWIoB9zSleM1ez68?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c312e55a-8fbd-48d9-f216-08da90c7d675
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5304.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 11:55:20.0261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufdDoVQe5w2CdYUp1kMATBNPj4Qm6XsTeGwajVMVPmWwCkIyvAvoSlliVBaWtYSeKzf9p8hK2kXf8xuVAy2s4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/26/2022 6:25 PM, Vidya Sagar wrote:
> Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren't
> saved and restored during suspend/resume leading to L1 Substates
> configuration being lost post-resume.
> 
> Save the L1 Substates control registers so that the configuration is
> retained post-resume.
> 

 Tested-by: Abhishek Sahu <abhsahu@nvidia.com>

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V3:
> * Disabled L1.2 enable fields while restoring Control-1 register
> 

 Thanks Vidya.

 I have applied your v3 patch in 6.0-rc3 kernel and tested again.
 I did 100 cycles of suspend/resume in a Alder lake based notebook
 which has NVIDIA discrete GPU and it is working fine.

 # lspci -d "0x10de:" -vvv|grep "L1SubCtl" -A 2

 After Boot:

   L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
               T_CommonMode=0us LTR1.2_Threshold=753664ns
   L1SubCtl2: T_PwrOn=500us

 After Suspend/resume without this patch:

   L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
              T_CommonMode=0us LTR1.2_Threshold=0ns
   L1SubCtl2: T_PwrOn=10us

 After Suspend/resume with this patch:

   L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
              T_CommonMode=0us LTR1.2_Threshold=753664ns
   L1SubCtl2: T_PwrOn=500us

 So with this patch, the L1SubCtl1 and L1SubCtl2 settings are being
 restored back correctly.
 
 Regards,
 Abhishek
