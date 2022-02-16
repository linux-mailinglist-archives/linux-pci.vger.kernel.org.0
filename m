Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DAC4B888F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Feb 2022 14:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiBPNMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Feb 2022 08:12:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiBPNMG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Feb 2022 08:12:06 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF33E235B;
        Wed, 16 Feb 2022 05:11:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfAy3Lgn3ZKEWYFneldocoslzF7YOZjvQkgOTb++Ut9goLdQajbfJAmMizcJflkWD7ELma0MyS30zM53E8v0vMMdtb5nyq+F2NQpfn8Zt2qaZyqdWzV1N9xnoQolgsXajNCtVnQAzkFwRcAhdrwCeMyUbaXnp80UZ9Pwv4wwy4Hpzo7/MgnmVDYUCS2hb4DKnjg8Od9F6jm71ua3Y1nR1wLJfdH2QhT90KIG6zfRzqzkrbf8L78K4cvsb4ji9YBlgEo05+v1VL8Q1dKP/4aiupMIl1MgIBjeHawwtQG5JP3VDTumcStHrKrWJLE3BlbMiEb5lsUHHhXCMdCh1VyLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4YLcBvPvIhZRNGJVjbFR1p4ppgKGGjFgGbPr2RC7Ko=;
 b=jVA9ErMTIJCju7vywPe8QRlOw++eE9Jm2RFxpvxfwoykx8uVJKV5RYs2kzdtW0O7LcFKplSYWozNcb0BHmoyaWpnAWj56e6WbPx0Om44k0Rh3YKH/vdrPvuIA+Cz1wzi1cjXD8oGJpej9VXvjNCypm+onZpCDS7YzDGYBK+1huZXmRsvRC0VzxxkHil7ws19MM1PIiSUV5nsurC/ZFy1hsO/Y+qUMqEyYXJ7AeLHSYFng6XjQtIx60g5kHQxe+ZOYddpGnZ0ozGNjP9ku6SQ2oaNoLCj45vDBbLReIcWDPg8fRsG8WrYtc6sMmhTquZZXAI1nLao2/SLvE+UnioDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 12.22.5.238) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4YLcBvPvIhZRNGJVjbFR1p4ppgKGGjFgGbPr2RC7Ko=;
 b=GYm5VH0XTOFEjuCggcP7H+7zG7jvrH6vxstjIcx1h1ZVAeGSYY8HPND1UqRvrBvCvBWS5u6nM+7SRblc1NfavzCW7gILI3vqkrSFlR2K1QGPfTFuZk+rBtp0euvdBxYw0yt32qf0ddLx+MbWeIVBqPdhJNteggSL1uLcu1PEsz0BE6LY+ri7l/2Xo1xSlP5Gt/49lg4hKzV7473rE1+jzb1mdy8tBDsdFaEkfzcBZ4PxSNpIHl/xHWzJMjkF+k9/fk8bY0FA/rPduxBdECsWROfKK0MgbIHi9lYK5AWXiVM8LbAUPdffTTlmtkOLgipSpcoyssuIDYbCgEGNQJ37jQ==
Received: from MN2PR12MB3597.namprd12.prod.outlook.com (2603:10b6:208:cf::25)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 13:11:52 +0000
Received: from BN9PR03CA0175.namprd03.prod.outlook.com (2603:10b6:408:f4::30)
 by MN2PR12MB3597.namprd12.prod.outlook.com (2603:10b6:208:cf::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 13:11:50 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::fe) by BN9PR03CA0175.outlook.office365.com
 (2603:10b6:408:f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Wed, 16 Feb 2022 13:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 13:11:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 16 Feb
 2022 13:11:48 +0000
Received: from [10.25.73.191] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 16 Feb 2022
 05:11:42 -0800
Message-ID: <0d8cc8c0-31a1-0290-5aa5-0c7b16db1edb@nvidia.com>
Date:   Wed, 16 Feb 2022 18:41:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Content-Language: en-US
To:     "Kenneth R. Crudup" <kenny@panix.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <hkallweit1@gmail.com>, <wangxiongfeng2@huawei.com>,
        <mika.westerberg@linux.intel.com>, <kai.heng.feng@canonical.com>,
        <chris.packham@alliedtelesis.co.nz>, <yangyicong@hisilicon.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <abhsahu@nvidia.com>,
        <sagupta@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20220207163332.GA397884@bhelgaas>
 <79a41832-12e2-2ed-f3af-da3bac90d941@panix.com>
 <3ca14a7-b726-8430-fe61-a3ac183a1088@panix.com>
 <0ccd43af-0293-521b-86d3-ea2ea1c70e5c@nvidia.com>
 <75a48fb6-3913-ccaf-3c-6d41bbbda533@panix.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <75a48fb6-3913-ccaf-3c-6d41bbbda533@panix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28daed99-0dde-4d35-8772-08d9f14de429
X-MS-TrafficTypeDiagnostic: MN2PR12MB3597:EE_|CH2PR12MB4245:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3597F00BC1A3B5E3635ADA97B8359@MN2PR12MB3597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sX7jbpc/pslZ/8smySL/l5hBCwxjr841STW5RPlUsshu9nL1bS8pV/6z07Ij2EeUnYSfAQ1mOUQmAFQ2Qi25tx0TlTUsPc+ZBhkW4vsJhYBLFHI+hYGiZWg8M7GxmhTzDbkbFU7L1QdXmfewgSDYJnq/qP4RRFXMXn+VTEJIJoyQ66Uu1zSNsA+Da5b5vyQEFPjcugx8tl0RcwuVF7BIPP7g3iurtqFWogOLyMHadsGXLlocJwNcVyxdnBeHS8eMA8CGO1tCesKU1KXKrO8ATGAFg4e1RxajoAWn45BmB9LBagrEYPivN3JTLtr80/BWUXW0fqB8DNjk3qc25TmVXoh+RDqKpWsajyBHpGr/nzycYFS7cTRrzc41p8Ba4cGa75pxYIlFSKe/gr2JdgAlvajLweb6rlligCgFxuZUPhkCR11mUfUQdC+MAOphIvyOOOdQtOoXZi5T0ZJVqtJ3eq7t0hHYX2I6ysuTEdsx7AiJTmps9fvTeTAnIs38ch6wQmrWUnWAMEHuEj10rUNrvFP0uq9AaSwJqexcXfyMXivVeoOd33hEF2+t5qZ+2InwWOknCpB+QBYDGAv9SLyNTeGIXzVAqLVJHmscqmNFW5076MEOqs8YJ2l1/ZT4/CRyxLTNvBMxK1mW+UYYMltwC+hIw4g3S3MbHf18vA9lALhfnps+0+SEEqfW7TeW3g52Ie1o7InAo5bLBFAVahFlWyR+UgfViVz/dxJoAraqROy6Urui5TG9Czk0GOJMYdyiWAUQyC70v7a/ods68udt6w==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(316002)(53546011)(8676002)(6666004)(5660300002)(36860700001)(82310400004)(70206006)(4326008)(70586007)(2906002)(16576012)(86362001)(36756003)(26005)(63350400001)(63370400001)(7416002)(426003)(336012)(186003)(508600001)(31696002)(47076005)(356005)(110136005)(54906003)(83380400001)(16526019)(81166007)(8936002)(2616005)(31686004)(40460700003)(32563001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 13:11:49.0776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28daed99-0dde-4d35-8772-08d9f14de429
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/16/2022 11:30 AM, Kenneth R. Crudup wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, 16 Feb 2022, Vidya Sagar wrote:
> 
>> I see that the ASPM-L1 state of Realtek NIC which was in disabled state before
>> hibernate got enabled after hibernate.
> 
> That's actually my SD-Card reader; there's a good chance the BIOS does "something"
> to it at boot time, as it's possible to boot from SD-Card on my laptop.
> 
>> This patch doesn't do anything to LnkCtl register which has control for ASPM L1
>> state.
> 
>> Could you please check why ASPM L1 got enabled post hibernation?
> 
> I wouldn't know how to do that; if you're still interested in that let me know
> what to do to determine that.
I would like Bjorn to take a call on it.
At this point, there are contradictions in observations.
Just to summarize,
- The root ports in your laptop don't have support for L1SS
- With the same old code base with which the errors were observed plus 
my patch on top of it, I see that ASPM-L1 state getting enabled for one 
of the endpoints (Realtek SD-Card reader) after system comes out of 
hibernation even though ASPM-L1 was disabled before the system enter 
into hibernation. No errors are reported now.
- With the linux-next top of the tree plus my patch, no change in the 
ASPM states and no errors also reported.

This points to BIOS being buggy (both old and new with new one being 
less problematic)

Bjorn, what are your comments on it?

> 
>          -Kenny
> 
> --
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
> 
