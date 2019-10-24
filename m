Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6CF4E2E8F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 12:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392115AbfJXKPc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 06:15:32 -0400
Received: from mail-eopbgr760074.outbound.protection.outlook.com ([40.107.76.74]:34302
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391807AbfJXKPc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 06:15:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6n3FoTW17o4ngYJOW2CGnYzJGSK1eWG0lpeLi3ES+7dyMoSDsLteqK7UGMqrvxl2QXjPdb9vNHokUz2EiiwVu68I9+Zz/XkRYJecQfxSobdxbxQqSnxGH0RosePS5GQYx/GWOt1DzCMHI1EvPeV+oy8zmPJSW0fcZFJpJj2wOtSt91i+DmLRARgxwCmH5KjVlAE7FnI+yQeToA8ykexYO3bfKPW/jcwvpglLlzPoawKwC0Ef7roCWrvUzBioJw61R5QLILe6hfKK0Js4WmhtOVOCVNvEvUWT0p7sJt29zycupHbyunkbKbA6xAQpNseBfLia26bdEXZaNBBfkW4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyQrpDY5cfAfSPWZ9zZ5gTliieV77+oz4TLkQISVfFg=;
 b=Nc3Yfz+79942vjiF2vbMJ45SQ7isS5tN+BwJCfFUMVmd3eOuwr35oZgvyqsETy9gcDBGtesWBx+O7+1sFpfqrCoqWXZqWKTjFWV0FdWAsd8w2Jyg7aJKqUKEX4jTCpqTeuPNsFEeEtxvmod/fF/eE4n3SI0+n7dAQtXquBsGmk5gpacqAVWwAN4jBrfNWWjqSZOa65gJJr7OC9fFCjBjwD7B6Q5QhPx4rslQ7YlR4WzX1vAdN6/pGqTAX33TbYulwjGk2NL0NnRp/9LLpN5wnR95ZdMoeJOv92HO7MRbSSjE5BARXHhcwLCt01LIA2RI+RX0bzWEQ7Kpi/yXbjes+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=sifive.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyQrpDY5cfAfSPWZ9zZ5gTliieV77+oz4TLkQISVfFg=;
 b=L1UofcnwC7mVuOzOYN1T3KXMhpJm1ASagmUEOuxojqc3YJ5xU7rm9xIyWnmdiGvwkb0bX/MjJNGALK2V51ldxZHnxNUiUF/sTJEIJq0XXMttuDrugjPlGOWjVUnl+JjEsk8VhYeeesijsEKYkdWXs8N3MbITtm7FsW5I6vW5H6k=
Received: from BL0PR02CA0065.namprd02.prod.outlook.com (2603:10b6:207:3d::42)
 by SN6PR02MB4607.namprd02.prod.outlook.com (2603:10b6:805:b0::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20; Thu, 24 Oct
 2019 10:14:48 +0000
Received: from BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BL0PR02CA0065.outlook.office365.com
 (2603:10b6:207:3d::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20 via Frontend
 Transport; Thu, 24 Oct 2019 10:14:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; sifive.com; dkim=none (message not signed)
 header.d=none;sifive.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT008.mail.protection.outlook.com (10.152.76.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Thu, 24 Oct 2019 10:14:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iNa8l-0000Zo-G6; Thu, 24 Oct 2019 03:14:47 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iNa8f-0004Ta-KL; Thu, 24 Oct 2019 03:14:41 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9OAEbHp022665;
        Thu, 24 Oct 2019 03:14:37 -0700
Received: from [172.30.17.123]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iNa8a-0004Qt-He; Thu, 24 Oct 2019 03:14:36 -0700
Subject: Re: PCI/MSI: Remove the PCI_MSI_IRQ_DOMAIN architecture whitelist
To:     Palmer Dabbelt <palmer@sifive.com>, michal.simek@xilinx.com
Cc:     Christoph Hellwig <hch@infradead.org>, helgaas@kernel.org,
        tony.luck@intel.com, fenghua.yu@intel.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, bhelgaas@google.com, will@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, pbonzini@redhat.com,
        firoz.khan@linaro.org, yamada.masahiro@socionext.com,
        longman@redhat.com, mingo@kernel.org, peterz@infradead.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
References: <mhng-d42f23ae-e51f-49cd-9533-a4c793cd70fe@palmer-si-x1e>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <9ec42e0d-d999-d59c-628a-b7678f132f73@xilinx.com>
Date:   Thu, 24 Oct 2019 12:14:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <mhng-d42f23ae-e51f-49cd-9533-a4c793cd70fe@palmer-si-x1e>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(396003)(136003)(346002)(39860400002)(376002)(199004)(189003)(70586007)(36386004)(47776003)(65806001)(65956001)(356004)(6666004)(478600001)(966005)(4326008)(6246003)(70206006)(7416002)(58126008)(229853002)(31686004)(6306002)(316002)(54906003)(426003)(4744005)(2616005)(8676002)(11346002)(126002)(476003)(5660300002)(446003)(106002)(36756003)(26005)(2486003)(76176011)(23676004)(305945005)(186003)(336012)(81156014)(81166006)(31696002)(8936002)(2906002)(2870700001)(486006)(44832011)(9786002)(50466002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4607;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca3b4c95-9845-47c5-a933-08d7586b002e
X-MS-TrafficTypeDiagnostic: SN6PR02MB4607:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <SN6PR02MB4607E29B77667CEB752A726DC66A0@SN6PR02MB4607.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0200DDA8BE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/0DJp7Zn4W2Qv7czSrq+yqpBf0idzLYvkBHGihb2FS8jUoy4iO3Byegf29I0SnCoPeiRUC3+X8SxZ3BvZdg7f5uyaulv2oTmxhuloW/+yBoWOTVcrZLSZfDE9NopxI/gjHyTEMn+XIvmlee4asLAW9vAURTNxSehtmnofZzTpHbmQbuNNgvaSxwcOEBUWCBJuaa7Ij1OHJLMuKt3RAXMpEifHG0Pi9FNB4B/niAD1dptkY5TUHj4UtTeomoxYba0TGt5GWf5QzQ3rjARwMYlpPop+kl9hMvW1DmSua2HyP59jdiILMeioeUjy9a+xXnhsCiJowDQZoxVLNrAkw6c4ittgWSrFF4K04sQJ9XuJOw3iFyz4b57/uB+74nO2VTwQc9wcjwobCcFZ3COqgbgTAVNt08Ffap5Uydw2+KjGgpKnvjrqsGOCHz1TqGmmR4UNYjZuz1GULNZ59+kBfBSu8bIhYxH1O+LSaNLI4/z/k=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2019 10:14:48.2273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3b4c95-9845-47c5-a933-08d7586b002e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4607
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22. 10. 19 17:10, Palmer Dabbelt wrote:
> On Thu, 17 Oct 2019 23:20:09 PDT (-0700), michal.simek@xilinx.com wrote:
>> Hi,
>>
>> On 17. 10. 19 20:19, Palmer Dabbelt wrote:
>>> This came up in the context of the microblaze port, where a patch was
>>> recently posted to extend the whitelist.
>>
>> I hoped you were aware about this discussion we have with Christoph.
>> https://lkml.org/lkml/2019/10/8/682
>>
>> It means 1/3 and 2/3 should be replaced by mandatory-y and I expect
>> msi.h can be removed from architecture Kbuild too.
> 
> I'd missed it, but that seems like a better way to do it.  I'm going to
> assume you guys are going to handle this, so feel free to drop my patch
> set.

Ok. I have sent it with ccing you.

Thanks,
Michal
