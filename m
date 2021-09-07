Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A175402CB1
	for <lists+linux-pci@lfdr.de>; Tue,  7 Sep 2021 18:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhIGQPc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Sep 2021 12:15:32 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:21778 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232103AbhIGQPb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Sep 2021 12:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631031263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LcbSHEuJ/n74+zmRLZEo33hTo1f5VMgflTIa8T0fZDo=;
        b=awOxYUlK1ZNufIwFjdxTMmqQAM3jdP9MYKCQ52OAXAic1RTyE7d3Haiv/dRnuXZfK+OptC
        nmi/xn7aUPerdG+kqbRnC6bh/LB++13qBa+S87eaPLFE/xd5F0p2Ft1cBpCJNOF2sKRYBw
        yU0tfPIG8oFBNnRIF3GLnofmTjhj/J0=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2053.outbound.protection.outlook.com [104.47.8.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-16-YfMEg0chOuetOUYREYE7pg-1; Tue, 07 Sep 2021 18:14:22 +0200
X-MC-Unique: YfMEg0chOuetOUYREYE7pg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3x2M6ZNPBorl0v/ebyO/SUSa6mf94oeLXF8VSaWjisitGFKx+VnZOSNKsjdeK+OC8gssgIH3Ttl1UQcogKgGCqqQ55wppPCifo4NAZnBe0QovFu1L4bnMkC8+jjgaSK4uedNlZxj/ZJvcXPadD99Vwb0BMvUhtYksdm4XWeb2QaVHHDKq5GZcvT1/r+yV8YUw+nd7lokoJZQRl6TU5JKZ1zQ61NrPIMct5rp+oiHMqRODHvkrnG/Na2W6D/5Nm4RXfA6urjYvf5+wLnNMVOw6l1Q05eqGnagKOVCza2VWG8wmSWLsMbxMfVUEanRhaGuIvQcYQPogs5UpES9zJszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LcbSHEuJ/n74+zmRLZEo33hTo1f5VMgflTIa8T0fZDo=;
 b=hlECaybXcC4+Gqa0ZwV4tIXbyv1K0tcfdO0905bXclPl03sBWJcmqDkXofYLTXOiRZCev3CIIUjEWvaCGMgUx5itykjLU1t4uj3MH88agT3otTrO5HMq/hdDybDiIXoUQxsff0qlygti68A/W6WFnfr9lsEIZi49N9RTKQBnGzzAf9I49ITsZt6TEfTSz2Iqg6KeazRxE908KkzLP3V5XHt4K9ftHh2t1d2UfM3okwqUjBWq75LEtJ5GD2rneVlrOrX1il9gcbm9f9+sd9QVY0VI83KkeC4CMydYFbKyXn+pwb6uSJt/Eav8rwAixcpaJidFN+DKIEBIGHS7D2amOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by VI1PR0401MB2448.eurprd04.prod.outlook.com (2603:10a6:800:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Tue, 7 Sep
 2021 16:14:18 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b%7]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 16:14:18 +0000
Subject: Re: [PATCH 10/12] xen-pcifront: this module is PV-only
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20210907153017.GA741607@bjorn-Precision-5520>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <82a99bb4-85bd-61cc-85de-f8dd9d1f98ed@suse.com>
Date:   Tue, 7 Sep 2021 18:14:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210907153017.GA741607@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3PR09CA0027.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::32) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.156.60.236] (37.24.206.209) by PR3PR09CA0027.eurprd09.prod.outlook.com (2603:10a6:102:b7::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 7 Sep 2021 16:14:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5aaa3d38-b7b0-47bc-14cd-08d9721a8b62
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2448:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB24488025797F5C4F35645645B3D39@VI1PR0401MB2448.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7vEub8SuX+2Mjk/NCi6siHY+3n/JlgiU+KUsKWvwv0WFWAz7osXDXOUwYpnA2VEZppgAB7SxdGkSWpGfJkjhLccjlp2S8zMfr2WS9ybDVvyMUZTyaATFXy4dr2JGV9OJTu0//fR098gSXBeXNkMpyCgVm15Y3XwSXoc+kVt/meF+kaQHIM/dljJll7pel0H+dEpgsrOav7gjhCSb/15B03cYQxvOHkiOn8ziNP0t+fy5m5Ymjr/J2+9xvJEM7GGf9y+T+lKnyBsw2/7KLkF8jLUdtHlWR3TAsh+NJAGNCD4UGOcBzIs/379IGogu+RBPXHi2eUahtSrdz/jX2rHkSEQQeoTHcBZ+d8GpbwX3ZCJ0NSv8QjhcZmAyAGp8LpCFQ9XAuAdfgAfBfMD3g4xZHZuTKcG29bm4BMMTynwmbN6cH/VWauVfQwm5lUwtrfdY9YoCkCkbQkcDnaW0md0O+sKwza/lEn7YSwDO86eIfgnV006xwd4D449TT8VqXB40AAsDYO3uFhm0EJPtk2JPiMm+rF/j3YoMjslrFhfID0BgIhuPaIVZqystPZ1DufuemK0dd2X/P3buPdYNZ/qQ76c3GFF/UV7tGx2rcFXniTHAQZN03I3INVB1AeyHoZZCqMeglk8KC/xG1zI1t6ntSjDO7jlNjje6YEtGNXy4aLOx2RNkg4In1HNhqaIRNr4RC5BM/4rTrHIPWA0f6V/drfSZNS/8/zOCFN2H4g7CP6CK1X1aIMm/r6X4raCLYu2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(396003)(136003)(6916009)(316002)(38100700002)(478600001)(5660300002)(86362001)(26005)(53546011)(31696002)(186003)(2906002)(6486002)(8676002)(66946007)(31686004)(8936002)(66556008)(66476007)(83380400001)(2616005)(956004)(4326008)(36756003)(54906003)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjBNdHRlVUI4VEZiYTJGUTg1dVcrRjMzalZ3WlNIN1FReStpTm5LbnQ1U1Nn?=
 =?utf-8?B?NlhjVENFM3EvOEhyenhiU05xaTI2eTlYUTl3WkFwTnF1VmNQenBMdS9UZU9u?=
 =?utf-8?B?VzFLNEJuZkhNTERWM1B1QWtyanBFa0dUT2Iyemx2aC9xS21YeFovcjRPTk5p?=
 =?utf-8?B?ZGRwNEpiY0ZzMFNxS1VxQ3J0WXMydm1OSUlaUFczWFZuUXo1Y2dkRkh0NVB5?=
 =?utf-8?B?emc1Q0ZuMmY3dmVqZmVPS3BVYUpOWGtKRmh4TzlrMmlhZ1d1RjFCL0xWMnpE?=
 =?utf-8?B?NUVGalU0OWx2clhveTFuQVptS0J5ZXNrYXpqajF6cmtpQlNPa1o4Rk4zTkNx?=
 =?utf-8?B?QlZwcjljLzZsQTJUb3NGaEw5Z0d4bjNvdjJMTWlLQ0Z4ai9ycG8xa240OVBF?=
 =?utf-8?B?Tmh4ZTBySktZYTJNVVJrMmFSdzdHaGhEZHY0UWZ2SXdFaVZ5aXd4QmU3Rndr?=
 =?utf-8?B?Tms5VStGbVFsTUNjTCt5bUw3SmwvcHRILzdKRjVxZXBrZHNxZDc5SlN0eDRR?=
 =?utf-8?B?Z28rTG1oWnlHUVhsQ1dhVHc0U1J3bjZYQVZ2a1ZNL3AxaEJybUZOcW5DQXZz?=
 =?utf-8?B?VldqWXBINjltVlZrYlJySFROb29wRjBZeThKangrWG9ZSE9ZSXB4RFU0cGxh?=
 =?utf-8?B?ZW1RM1RQelM3N3JLREt3WTFKdkNGL0NRWlYwbHMrK3o1cUtZM2NEdERVbDBD?=
 =?utf-8?B?QmJEZ1FxaGphVUgwaFE5NnJ1eUxScmtMekgzM3BtMFBpUkxhd3c3VjNaMGMw?=
 =?utf-8?B?ckhpdzF2Ui9TQnJQRFF6ZU9WdzRKaVRWMVIxMDY3UXlxOHpoQUk0YmhZWkp2?=
 =?utf-8?B?TDUwejBHbi9Lb0tIOE5QZDRjV3o3UEJvT3dHS1RJLzVXRFJyUnN6OUJyNXNB?=
 =?utf-8?B?VVBFRFpnc0FsLzhhK3EyMi8veG44TkJJUXloMVhTY0FocUtwdnpTSTROWVJN?=
 =?utf-8?B?SENGNSs2OEVWYUVaNFRSYVlLSW9qS051cU5qckJQTnZjZVZYWlhCZ2JGUDZr?=
 =?utf-8?B?MWVMdERYWk1rTTh0RE5KNzNuU2E0d1VnRjRrK1hkSkIra1lyNm1zN2xkUThU?=
 =?utf-8?B?U0Jtd1FhRGxGR1ZLeDNtKzNEcTI3SkNMZWRjTGE2bnkyaXZPa2FFc0U2N1lz?=
 =?utf-8?B?QTN6Rjk2VTRzVzh5WWNYUmI1WDkrckpkQ1hpM1FXZUcxRHRCUHNPQmVyYnFE?=
 =?utf-8?B?Y0gzVzVBUThVVnpUL1JyMitPYUVnTlZjQXZwWWg5c2VjZ2gwVnJkcU1pT2ZL?=
 =?utf-8?B?alZYaFJaa2JhcmpiR2ljMnRNU1hXejJRSlo5ang3M0dhdXZKcE5lUE01b3Zn?=
 =?utf-8?B?SGVWK2pWQk84bFE4Ukd4cXdDZXBiSUpxc0llSzRCb0FoQlpLZTlvTE95eGlW?=
 =?utf-8?B?aGxnSkNGRzRCSTVQc1lEeEdQM2FLNXNXakw1TWZPdjdMQktHeDFlN1JtQTN2?=
 =?utf-8?B?RzNXSG9Halp1MGNzNUVZd2lqeGxCRldTZXJpRXB1Y3FQN1ExUHBvV3ViMUVV?=
 =?utf-8?B?QlFGdHc2cTV0blkwb3pxemNCdW1XSGxuMGFXUmRZODJuQkJMemZDOUI4Y0ll?=
 =?utf-8?B?cWdOQmpRY1Jyc0E4Y1JCVjdES0E5bWE1dXV6K0tDajRLQ1d6ZENxOHJPSkZW?=
 =?utf-8?B?SER0by9Bd1ZKSjY1aktWQmpOUDdONjdpZDFTaXcwQVlmWmdpSFpiMXY4YVFK?=
 =?utf-8?B?MTh5Z25zM3EwcDYwV3ZVd25MVVpaT3c5Q055L085UDd3a3ZyWE82NWwxTFJJ?=
 =?utf-8?Q?uVv0HZ/5AMd9M47xGdt8+xVYzo0SEtzUVzXw9ST?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aaa3d38-b7b0-47bc-14cd-08d9721a8b62
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:14:18.3962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pso7JENlOr8XTGDxqLt62uiVP6Bzb2jYhXKVqkYKWnLwQSThe9r8WdSzfRPA5JEpJJyUnTREAqf8EKvPoTNP6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2448
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07.09.2021 17:30, Bjorn Helgaas wrote:
> Update subject to follow conventions (use "git log --oneline
> drivers/pci/Kconfig").  Should say what this patch does.

I can change that; I don't think it'll carry any different information.

> Commit log below should also say what this patch does.  Currently it's
> part of the rationale for the change, but doesn't say what the patch
> does.

"There's no point building ..." to me is as good as "Don't build ...".
But oh well, I can adjust ...

> On Tue, Sep 07, 2021 at 02:10:41PM +0200, Jan Beulich wrote:
>> It's module init function does a xen_pv_domain() check first thing.
>> Hence there's no point building it in non-PV configurations.
> 
> s/It's/<name of function that calls xen_pv_domain()/   # pcifront_init()?

I don't understand this - how is "module init function" not clear
enough?

> s/building it/building <name of module>/               # xen-pcifront.o?

The driver name is already part of the subject; I didn't think I
need to repeat that one here.

> I see that CONFIG_XEN_PV is only mentioned in arch/x86, so
> CONFIG_XEN_PV=y cannot be set on other arches.  Is the current
> "depends on X86" just a reflection of that, or is it because of some
> other x86 dependency in the code?
> 
> The connection between xen_pv_domain() and CONFIG_XEN_PV is not
> completely obvious.
> 
> If you only build xen-pcifront.o when CONFIG_XEN_PV=y, and
> xen_pv_domain() is true if and only if CONFIG_XEN_PV=y, why bother
> calling xen_pv_domain() at all?

Because XEN_PV=y only _enables_ the kernel to run in PV mode. It
may be enabled to also run in HVM and/or PVH modes. And it may
then _run_ in any of the enabled modes. IOW xen_pv_domain() will
always return false when !XEN_PV; no other implication is valid.
I don't think this basic concept needs explaining in a simple
patch like this. Instead I think the config option in question,
despite living in drivers/pci/Kconfig, should be under "XEN
HYPERVISOR INTERFACE" maintainership. I realize that's not even
expressable in ./MAINTAINERS. I wonder why the option was put
there in the first place, rather than in drivers/xen/Kconfig.

Jan

