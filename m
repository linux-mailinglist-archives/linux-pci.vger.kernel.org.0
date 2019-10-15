Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFFED6F5B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 07:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfJOF7Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 01:59:25 -0400
Received: from mail-eopbgr720083.outbound.protection.outlook.com ([40.107.72.83]:22896
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfJOF7Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 01:59:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVqalrSrFp6+7ikmVUfHWZZ1pXcJVk5xNJuoi8XAHAuNBUf7Gka6AOydB+nlTd2fVKYwDDYic01n67KCN8M3nYnRVX5RNdb5GZ1bWtQPilmd9ouh4gbQUXVipO+F3MKzuxS+8pjZqpbtw72G2S2UafLkom3EVXVuAgg7kbwedLLrJg5pydh1PxWCr4dqh1HhSnQlhtXzlb0H/tzFTGKYMiFCkBtX+qIf0PD/VuIN0LzwetSOB61VGYraqtDGCRowmHHDvbg42by9C6VDYDr0LIkzwtJ+eN6NkvHDO2YLJMtKdxWfLL2bBU2SxYL8KF3nnFhFlsNZpbxG+7zpqdsplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gch6YVfyYZuYsX15PwK+/TgxGhvXHBW7TapWdpOXyoM=;
 b=m370o/60aigTQDQa9wVBqsZxzSHHAUM1TAkqBqiIqHHLeSjJh+jFro5yC4KEsKXQ8g6hrj/JzNcB2KkVhH6tdkC3fjn/sXSbPIuvU7NykQUzktAQeUS6v8Af++93cYdSW6RYKy7TZ6X04yVnj4NwkyJw+hsoyaIfh9HxZSi/kJkC6S+jnLnpk+8jAtib8a8uJw14r7ALhCoW3WY4mMtC+XMR0QavbOXhiTgpHONPcOqVJ3XwwXJzadEiTSoByHrwvPYI2V8Mt8vtnYFlue8BaXCeU/eIlkD0S3mbNvpMz0G3B2UU/tql/bU2OUoBCSYRJw/xaknT+FpdmeCnTQ/EkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gch6YVfyYZuYsX15PwK+/TgxGhvXHBW7TapWdpOXyoM=;
 b=JGIAXc4tz01Z85k44d6YP2mY1QkmD2e3pfEM1MjPVCY5QVWzUlGNM+tRt8rEGZkB0ULQ5jae+fJMfSagHoLxzXohP+EcBOepcVwif5LEjtziEqyZgu9JaU974UboD+sePQ2OeX2SbqEu4EK11bFaGuxjjXyErUCr9u0yzmdsoAQ=
Received: from BL0PR02CA0061.namprd02.prod.outlook.com (2603:10b6:207:3d::38)
 by SN6PR02MB4160.namprd02.prod.outlook.com (2603:10b6:805:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18; Tue, 15 Oct
 2019 05:59:20 +0000
Received: from BL2NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BL0PR02CA0061.outlook.office365.com
 (2603:10b6:207:3d::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21 via Frontend
 Transport; Tue, 15 Oct 2019 05:59:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT026.mail.protection.outlook.com (10.152.77.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2347.16
 via Frontend Transport; Tue, 15 Oct 2019 05:59:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iKFrb-0001ob-R8; Mon, 14 Oct 2019 22:59:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iKFrW-0001GV-N2; Mon, 14 Oct 2019 22:59:14 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9F5xBuo030875;
        Mon, 14 Oct 2019 22:59:11 -0700
Received: from [172.30.17.123]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iKFrT-0001Fm-9x; Mon, 14 Oct 2019 22:59:11 -0700
Subject: Re: [PATCH v2] PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for
 Microblaze
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Kuldeep Dave <kuldeep.dave@xilinx.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>, linux-pci@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>
References: <20191014232345.GA246093@google.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <fe37e872-09c7-7b60-cd3e-33228c740afc@xilinx.com>
Date:   Tue, 15 Oct 2019 07:59:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014232345.GA246093@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(189003)(199004)(23676004)(2486003)(478600001)(5660300002)(305945005)(65956001)(47776003)(50466002)(70586007)(7416002)(186003)(26005)(70206006)(81156014)(65806001)(31696002)(476003)(76176011)(486006)(6666004)(356004)(8676002)(81166006)(2616005)(126002)(31686004)(11346002)(8936002)(44832011)(36386004)(6246003)(2906002)(4326008)(106002)(54906003)(110136005)(58126008)(230700001)(336012)(446003)(316002)(229853002)(426003)(9786002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4160;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79c74e17-b857-4259-eb03-08d75134d260
X-MS-TrafficTypeDiagnostic: SN6PR02MB4160:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR02MB416005D85ABEBC954A79E85FC6930@SN6PR02MB4160.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 01917B1794
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: REpVFAM0fZ9M5YqGbaUd0Zin9r9SkqM4DOO2Q9t1qxzmhXVOUBizaIPcqbwlIOQ+xDGXR3rqegwipy/jImSFHFYtgBTYjoEBDimya9URX34zyABSx28kUJxiYmThgfzfaxm9GJYJtRmA00BLGj3SFt4djLoihheHAcYoeIgv07k+j0CIju+kwE8P36D7yKMejo3yQB2EvsjzQm0p0JaCmy2HbQERwCkd/O8772DuCMBV293U+vGFnCvJIRtP1oTfUahbAAfq9PQSgNhkp1INZGrdxWMHZrZd7Q1xy4yJR1hysR6EoLuQhQ+87UMrVEqjMbgPiHg2VxhhSM+o+/M+zcl/UGAr04ZhqN7+VNZz3k68qSEXPGMhf+gwZa5ZsSF4DIX/6fab3mD0OhqUxZL2fNeWZ4z9X6hBSeaVddlxC84=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 05:59:20.4195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c74e17-b857-4259-eb03-08d75134d260
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4160
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 15. 10. 19 1:23, Bjorn Helgaas wrote:
> On Tue, Oct 08, 2019 at 08:46:52AM -0700, Christoph Hellwig wrote:
>>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>>> index a304f5ea11b9..9d259372fbfd 100644
>>> --- a/drivers/pci/Kconfig
>>> +++ b/drivers/pci/Kconfig
>>> @@ -52,7 +52,7 @@ config PCI_MSI
>>>  	   If you don't know what to do here, say Y.
>>>  
>>>  config PCI_MSI_IRQ_DOMAIN
>>> -	def_bool ARC || ARM || ARM64 || X86 || RISCV
>>> +	def_bool ARC || ARM || ARM64 || X86 || RISCV || MICROBLAZE
>>
>> Can you find out what the actual dependency is so that we can
>> automatically enabled this instead of the weird arch list?
> 
> Hi Michal, I'll wait for your response on whether it's feasible to do
> something smarter than listing every arch here.  Please ping here or
> post a v3; since I marked this patch "Changed Requested" in patchwork,
> it's fallen off my to-do list.

I was waiting more for you to comment this. I was expecting that the
same question came last time when RISCV was added.
I am happy to investigate more about it but definitely some your input
would help.

Thanks,
Michal

