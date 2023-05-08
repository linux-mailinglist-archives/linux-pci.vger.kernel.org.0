Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22D26FA14B
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 09:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjEHHog (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 03:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjEHHob (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 03:44:31 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DCB1CFC9;
        Mon,  8 May 2023 00:44:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsfwBGQQ/sY/rV6oCJ5xKZxfA9lHBDQL4cro+8dE/F1EtY4ZCSkJbeDwlAE46eCFPGuQh1gsYTd1JHs5lvjliG2jB++KA/3KGM19HekP8aLEvKZz1cRoZ5EtFfeL2qwgyPBe39aG89TN961PUvsdU98oNhLGDbzizCwydpr7PID/k3JYlDOmEZKp4GRs+dUIwL+D545ZjTTbVRTg7to+241sQjYwzBkSuspLB2imGxnczOfLq09YSDJvb4shCpqVj0JYeB9qLzSl63M+AkA0SkHMDoXXd+IbFaOR2aC31Adz+u5OO+ANnu7wobnciJNC5KHgSA8ygj1Lrj4giTPUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTyz5nV97xIneqlBlI53GwPouhgm51IcTjcORd2Q1zA=;
 b=T2t9ZcYHrEjrCiDIe7QDnPNy9B+ocP6vLxvcuueY+W1r+dfOJD+RjVUbSkuLJxjo+g4juXDvTN2KenD1K6UpDKq5gmWUeXnitpnx8QMdxnux73UoplBqcGaLZMAHBgR4F11yHC25hO/fRGOIgPYPChwADY1CSgnFhhwc39q885pgoyTAxwK3q4Xs7F322GOz/gN3lxjS5DzlTG8IQ6CKcRIHVRZp0udnAtVKb3oBVsbvwemyfhfzzK/t6M9djMLlnt+KL8mTMA2+pZIIIC7eKrN0DkYxeUQOsTuL9H3Sp9buI6DcGBDSfVnysuwk0xS3U4UPBj0YhuHlUWiTCnSppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTyz5nV97xIneqlBlI53GwPouhgm51IcTjcORd2Q1zA=;
 b=OPTySp0L7eVzpkLTT/vyJX3NIx9tOl8ESR7bGLXkz5aT3Eku3SudE9lTmab/p82tSWNfTzcB6eC+nJ7y+Uy5nBKVhpC9TChxcKRuvjcZdQYm9XmQUdOt+ReJU2VecIZ3tSqtOh4D/WPIb+4+9wA8NQUi1i6o9iU8SkzQrOZqKptHCUWklLdb92DxpUnsCke5hvF7941e6g65AcPBMLweJ/JMUPzue0pKR4TLiuGWPjwWfs2mJtw9eD5kEfu4z8Y6+2Lx0V2cbHMgOsxKReAKh+R0zZa0MNembgyvIfFqOQsQAuWxmyMFPJuUMDWfWnnuYXGw8ZnDxTREnoEtVIHYXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by VI1PR04MB6816.eurprd04.prod.outlook.com (2603:10a6:803:12d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 07:44:17 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::6c14:307b:6fd3:3bfc]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::6c14:307b:6fd3:3bfc%7]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 07:44:17 +0000
Message-ID: <479acc85-2349-d0ac-851c-f57b1bf6aa9e@suse.com>
Date:   Mon, 8 May 2023 09:44:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] PCI: mediatek-gen3: Stop acquiring spinlocks in
 {suspend,resume}_noirq
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, ryder.lee@mediatek.com
Cc:     jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230504113509.184633-1-angelogioacchino.delregno@collabora.com>
 <20230504113509.184633-2-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20230504113509.184633-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::6) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|VI1PR04MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5f57e7-5c23-4ac1-e3da-08db4f9806d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8V2luW16lh1u89auLDT79x+/oWkKtZu6kFeIFKW40HOvUfbF5HmZjD7Sf+ljjLZwyBQqibFt8Tqh0SrwMj7JHmKyd+MHBti+p+nGIWMhREtK2krxCOLj+tgiJS9IOddDuZF5NvnSJsnISTIlW5DOXbKFgfmFgToAfyGA2SL/mGiB6PJD79LDAt3H/4s0HWyEKQuvzX8MsDiawy1uvI8vnpr1UrVz9FNfHQ4+WIxzIE8jlZONK4ojO00AX6c4BA9/ov6Kdv6JXlu5pezRC5FztFymg0Ew7zc5OUi2W4e1QpJTfDuVl0rMAak4Jx2rqnMFCX9tzJ2veW8fycZhaJGRWkUe3EsTSO8sjGF6ZrP1/oEG/cqk+nG9VvVHjBpxf0gIMEhg+XW1GYHfvf0A56HdQYhu3923663ODDWr1QmX1tAx/xFeTLr0g4Pucx1Dov9/oF+O1V2b6q5dQwmnTHEeTmVKG4/Lyi+LkJGynexCrXxclhA6L0v8e8q3omTmdrXlVnJJuHbh7O5JQQsf0E7kPcv0s7j8sjcp0nYZvepw4lWNiLXpy7C92qbXO25KtwMnSB9ofv1BqRZC53FehOhalVz/kwvFTJUdXKIfFq/E41oPoj81jgqYlIEqqS1IHPaWG8gfwAjM/tUJQeh0HoeeGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39850400004)(396003)(136003)(366004)(346002)(451199021)(31686004)(66946007)(66556008)(66476007)(4326008)(478600001)(6486002)(316002)(31696002)(86362001)(36756003)(83380400001)(2616005)(53546011)(6512007)(6506007)(6666004)(8676002)(8936002)(5660300002)(41300700001)(7416002)(2906002)(15650500001)(186003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGttRXBkYXpCUWhKb3FDQnB6MEd5YlFtSnkveGszaEFpN0ExY1JPY0VtcEkv?=
 =?utf-8?B?bDhhVHZCOTArQXlHQ0w3Tmc5WXFBMUdRdXdlVUxiUmRKUzBxTGdYSGhqTWhv?=
 =?utf-8?B?Q2ZiSmxaQ09IVmF4SCs1SWhjWlU0YWFSbTFwdWd5VUppZDhWb1RRSTFWNHhn?=
 =?utf-8?B?QkhPTGpSTm1PTFJURWd1b2ljbzhXNFNja2V2ZDZrMkVad09ES2ZScGpuUzJU?=
 =?utf-8?B?cVpKZmMwSzM2aXhzNU9XWm1LbmFKNUVyN2pyYXcrTzJlWWpxS21IL1V6N1JL?=
 =?utf-8?B?cUR4L1dFRmJqK3hjbDZKcGdVQUR5ZGJYRDBQVENoWjdscUdzaVFsRWFrWnc2?=
 =?utf-8?B?ZnVxRDhuVnkxL0NJRnpENFp2a3ZnODRFdzRRSFMvOWpkaks4SXJRcHBUQndx?=
 =?utf-8?B?dzU1R0U0ZlIreWxkRW9PMEt4dzJQMHNXZzFrclBKbzljK3NWcTFsbm91c1kw?=
 =?utf-8?B?U25GODJOVFJwS1FCd1Rlc0ZDSzNCNk95aWNNa2U1YmFqSnRHS0EyT0ZuTVU1?=
 =?utf-8?B?NTJoSVlCT1l5UDhKK0w2QjV3NkFlcnZQWENJTHorMWRwbXVLRDFQSVh5bTIx?=
 =?utf-8?B?UVdwRWpaWDF5Nm5nTkxrWFc0dEtmdjVsUjh3Y1ZuZDcwMjhNN09IM2lQayt0?=
 =?utf-8?B?UVpBVEFTTHRPY1R5MjRSeVQwaTVaR29tdUU2NS9NcVhNb0trcXY3czVZenQ3?=
 =?utf-8?B?RlRGTmhxZWgrd0VrcEZjTjEwZk80dnJDdEMrNzdNcURic09PTHNBSUEwZHpy?=
 =?utf-8?B?V3R1TUUzT1R1S1F2QW9ERDJIcXZKOGNESnJoU2MxeGpCdGpDOFg4QU9Bbmdj?=
 =?utf-8?B?VXV1SSsrdUllLzdodHVzSXovc21VVWpCZkdSV0c5Ri91QlNNZnpXRW91MUxN?=
 =?utf-8?B?TXVHMUFtZU41RjJvZ0xxSzhvNzBmdTFqWmtmZlYvVnl6T1pxM1RqcGZ4RFpz?=
 =?utf-8?B?UVFjbzJKT1l3N0c1L0N5eHp0Q29QWFNNQldVaHdxcGN6aWt3dU5MUmFEMExv?=
 =?utf-8?B?L0tsOVV6Mjd6dE4yWlIzaEcxenk1NHhZOUtZbFZUOGN6S1I0VmZpbTdEelds?=
 =?utf-8?B?Q2ZkcmF2cit1RVB0UlJINmEyaVBYcG1MazErZnZaTm9zazVzRVhsVGwzYXMz?=
 =?utf-8?B?MklhU3ZMUjRUNlZPcEpnV3h0Wk5sc1VFbmtXdGRuUXFaamtPZnVLenltRnVM?=
 =?utf-8?B?UmpnUTU2ODlBU2NCUEMzNjJGb2dNNXQwVG5FNmh4N0czUVY3a1IyMTJQbXFJ?=
 =?utf-8?B?S29JUkJ2aVRFNEF3SmNWS2gwUEcxU0gra2R4dnhESm9ZbGdBOXRXNlIzVG9w?=
 =?utf-8?B?czRkTHRPc2tIdFFkYjdtRG42azhYR2lsSzdOaGh6b3ZyRGVYeVlPMk04MFdH?=
 =?utf-8?B?bDB6WGl2UjFUeUFYT2V0Q25nS1Yvc0F6Q1c2R0w0Qk5oSDgwY3BEVzZUazJl?=
 =?utf-8?B?UGpreUN5MzRJbDBqd3pGOFJ3WTJ1YUs3L2ptUG5iMW96YWpYR2V1alRWZHdr?=
 =?utf-8?B?ZGczMjlneEw4bXdkUlljNEtScjlhUW1RSS9DWWU5azhnSWRCaWE0SGRxV3Mx?=
 =?utf-8?B?UzgwQXcrOGJWY1VhK0p5RWx2MW9Va200WE1BQ09NTy9XOFBhYnRqTXdCTU9R?=
 =?utf-8?B?dHpBQ3RINmdmeGU3TXpjTDBtVjY5RjdLQndoMEY5TnVodTRJbkk3VzVJclRU?=
 =?utf-8?B?dVFWaXBTMDI5U3RhWXVoMk5CV0ZYSldzSyt3M0RXQUZBVnp5YVFPNm5JYkJX?=
 =?utf-8?B?cFgwbmJDS1VZS21UZWFKT1BJaXRJaWdTZFl0RDFpZm01U2FSMkJWejZyVUg2?=
 =?utf-8?B?ekJ5b3RNN21Tc1EycnUrMmloYUt2M08zSnp2b1lEeTk5dFRmSGxHdXdpZTVj?=
 =?utf-8?B?KzBSWVhLTEZKT2FFczhldXBsNmtjTzVLRnVEUE9WcWFSM2ovWGtMTXlSeXN1?=
 =?utf-8?B?b05jK1lHMSttcDZSVDN3VnFMVTQrM00vL213REJremZPWjFaYXBZbXM0cmZV?=
 =?utf-8?B?VGtzc0hMWTVHQ3BqUnNNWmRvSVEwc2pFM0pSZlF6eUNmdExzWUk2d3lONEM5?=
 =?utf-8?B?ck5xbEUyMWVzcVpSU0U0WFVCdDNCQ1puOFFrZ3dkamZjdCs5UVM1dVF1TktO?=
 =?utf-8?B?a00xYUxTVzFCV09Wamt6Vk1SKzR4UWRXTW9xam5zV1B4cVdSdTBHQlI4NktX?=
 =?utf-8?Q?avcAuC2n6cX7ZTrI/lblcRulox6dKeCc1KHx6Nu7PwOh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5f57e7-5c23-4ac1-e3da-08db4f9806d0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 07:44:17.4418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJmfDuH8+sHJPzcl4u/4gIP+u/w2PXJroQfRmUrGxskrGK7iZRNu4xzb9ri+48pMRo5AOcEuqUCWJ641hehTmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6816
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04.05.23 13:35, AngeloGioacchino Del Regno wrote:

Hi,

looking at your patch I am afraid there is an issue.

> In mtk_pcie_suspend_noirq() and mtk_pcie_resume_noirq() we are,
> respectively, disabling and enabling generation of interrupts and
> then saving and restoring the enabled interrupts register: since
> we're using noirq PM callbacks, that can be safely done without
> holding any spin lock.

Why? You can still race with another CPU in task context.
That is if you say that you do not need locking to touch
PCIE_INT_ENABLE_REG that is fine, but then why do you remove
it from one place only?
It is also touched in mtk_pcie_probe() at a minimum.

  
> That was noticed because of, and solves, the following issue:
> 
> <4>[   74.185982] ========================================================
> <4>[   74.192629] WARNING: possible irq lock inversion dependency detected
> <4>[   74.199276] 6.3.0-next-20230428+ #51 Tainted: G        W
> <4>[   74.205664] --------------------------------------------------------
> <4>[   74.212309] systemd-sleep/809 just changed the state of lock:
> <4>[   74.218347] ffff65a5c34c65a0 (&pcie->irq_lock){+...}-{2:2}, at: mtk_pcie_resume+0x50/0xa8
> <4>[   74.226870] but this lock was taken by another, HARDIRQ-safe lock in the past:
> <4>[   74.234389]  (&irq_desc_lock_class){-.-.}-{2:2}
> <4>[   74.234409]
> <4>[   74.234409]
> <4>[   74.234409] and interrupts could create inverse lock ordering between them.
> <4>[   74.234409]
> <4>[   74.251704]
> <4>[   74.251704] other info that might help us debug this:
> <4>[   74.258785]  Possible interrupt unsafe locking scenario:
> <4>[   74.258785]
> <4>[   74.266126]        CPU0                    CPU1
> <4>[   74.270942]        ----                    ----
> <4>[   74.275758]   lock(&pcie->irq_lock);

Lock A

> <4>[   74.279627]                                local_irq_disable();

strictly speaking irrelevant

> <4>[   74.285836]                                lock(&irq_desc_lock_class);

lock B

> <4>[   74.292667]                                lock(&pcie->irq_lock);

lock A

> <4>[   74.299061]   <Interrupt>

You do not need that interrupt.

> <4>[   74.301960]     lock(&irq_desc_lock_class);

lock B

> <4>[   74.306438]
> <4>[   74.306438]  *** DEADLOCK ***
