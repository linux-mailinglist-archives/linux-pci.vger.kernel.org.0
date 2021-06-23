Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F193B1BD8
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 16:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhFWOCr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 10:02:47 -0400
Received: from mail-co1nam11on2063.outbound.protection.outlook.com ([40.107.220.63]:42955
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230402AbhFWOCp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 10:02:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfbF9TrIAlt+j7yaUSSdnxQkyMuig6POaD13ZQfd8KJ/gEANi/0P0cP0dO19MNzMfHrpMhg+zIm4RfNBczPnSjzwsSzO0sc6D4HFTaUZWj4RLHgrTqGopYlBZ5IATyQyzZokOtdfeFu//vIx27wzxBXU8lZR5SkvzJtUrxpbtl4BKU2RRjebIxuz2nrI8dUHVn0kMrOXP7Q9Kvle8JnYDnEVg+UBU8JIcaW6l37sF0bh5RyG7HCTd6hjF+TZZ1olfaT337AJHaNb/pmQjFJUZG2WJ8itmHWelrNhKzNBhSKZ0KoV6N1ImI1YPfUlI8w1NW8mjCUOIxH5/aJQYOFAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW++o6DoO4iLKR6TBA9UKy326xdyO/IIYSo0dApeKXQ=;
 b=hLSD90O4wSm0hICHkmDut7X2hAiclFp72qbUz+Gaj8QFnODNQj77m5tO5oEv43Nj39oGGq5viaSyRWmlwsh5VtqZBKzyU8d1Ewbijai0V/rnwvLeobdXD2/rcYT83qZZmJWFQqJcZLa1FFOAriZDRekRrVhT2mAexVmQCoeKk9HipKBoF8eH8s+SiFI6k29bnQSqtxP6sqZtVcLuuqidg30me369UJBcD62az2VBYwycZm+HwP4m1xtNUgdXay8AXlsV/fEiz5I0ht1OZilNs7vAukloQqB809WV4key/eQfACSWeeEg9iA17sS7bx1Xm5j9SiYmGgXSa3RiPC5aMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW++o6DoO4iLKR6TBA9UKy326xdyO/IIYSo0dApeKXQ=;
 b=EVuAjtrmMU/gCP8ieUmgJdiEv7/9/oyMKyGlw4EbEQCD9C0a/Fa0Xo/Udqabev69S4lE8e30U09OSqgvAa9aKyj7YJqPkT/wzES7DD481o2WnkDyH7JUh4dgso6jQTboaDG1pFy7R4//+7DD5ONUX02Q0gu07mrQXlUamCTkX0Q=
Received: from DM6PR01CA0017.prod.exchangelabs.com (2603:10b6:5:296::22) by
 SA0PR02MB7500.namprd02.prod.outlook.com (2603:10b6:806:e9::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18; Wed, 23 Jun 2021 14:00:25 +0000
Received: from DM3NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::76) by DM6PR01CA0017.outlook.office365.com
 (2603:10b6:5:296::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Wed, 23 Jun 2021 14:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT019.mail.protection.outlook.com (10.13.4.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 14:00:24 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 23 Jun 2021 07:00:09 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 23 Jun 2021 07:00:09 -0700
Envelope-to: git@xilinx.com,
 linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 sashal@kernel.org,
 robh@kernel.org,
 maz@kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 kw@linux.com
Received: from [172.30.17.109] (port=47614)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lw3QE-0004mw-Os; Wed, 23 Jun 2021 07:00:07 -0700
Subject: Re: [PATCH v2 2/2] PCI: xilinx-nwl: Enable the clock through CCF
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>, <bharat.kumar.gogada@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ravi Kiran Gummaluri <rgummal@xilinx.com>,
        "Rob Herring" <robh@kernel.org>, Sasha Levin <sashal@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>
References: <cover.1624454607.git.michal.simek@xilinx.com>
 <be603822953d0a815034a952b9c71bac642f22ae.1624454607.git.michal.simek@xilinx.com>
 <20210623135326.GA54420@rocinante>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <f15a9fca-0fb0-5f7a-e1c7-6c52df617a2e@xilinx.com>
Date:   Wed, 23 Jun 2021 16:00:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623135326.GA54420@rocinante>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be6f0d5f-17db-4643-992b-08d9364f3fc5
X-MS-TrafficTypeDiagnostic: SA0PR02MB7500:
X-Microsoft-Antispam-PRVS: <SA0PR02MB7500B60C815FE2F4991BD7D0C6089@SA0PR02MB7500.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQikXnoNILhtuuEqFhYxMl7ZhcZmc1YdXQySZx2A/blicUADNuDm2IKBdsOHn7LeUqtC1+t5Lv1EsN7TcsT3oHl8Ih1o2hUqZzvr2EFXzeSl1URt7LGgIchSsBK69wASn2EeBix+MKJHTFUoDkjuRjWPVZSj4olcRQsXWh2JkD6/1fcG2o0WDTF3ciF870A/kI+7FMH74aik0HPAf7jmfK5Su0fI9p/1A5KheJyFqFRgxtwi/OFJ1zIFPLMiIvbEmxjbQZGJDVFfJke8bIiJ/goL3yzBqjPLUlg3FOJLyMMMzLa1MxDAJ5KacOos8PFS8/i6cp+FCrHn5XVGvLYSJYayMyYKhKRzKm+7knxjaBhxs3bnJGbdmwXkT6N22tM/PgPiDBIPPhTTnDFQ/WpANC8zuucp6pz4uk1252iNI4Q/WpR0BLa4Ylh+/lLTVcY70VIaCAZUHr8iIw1IxBOkCVdSQDZERFMGeedaMsBWFP7qSwEu7kcPQwwkjxPzYKozZTyzTrNqOILUNH2NwlBol1p36wm4vJr8qArUgO6KD0AbiWAeezS/GKxlCTt2VhGIE9pccFdrmw1wAYtGh1jYsaeMG7qcKn1NLKz8Hww2kozFmRn18nCPrTHwryhlelsFUgWzOvU3Sbffn+w6trPSe52+ITBqOaxcay/QwOo8mRdaALNwScyZ/VMN80z47WBKPMezSM9AXwSGPMaiFitiiQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(346002)(376002)(36840700001)(46966006)(8676002)(36756003)(6666004)(8936002)(31696002)(9786002)(31686004)(44832011)(426003)(2616005)(316002)(83380400001)(336012)(82310400003)(36906005)(478600001)(5660300002)(70206006)(70586007)(82740400003)(356005)(110136005)(66574015)(2906002)(7636003)(36860700001)(54906003)(53546011)(186003)(26005)(7416002)(4326008)(47076005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 14:00:24.8966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be6f0d5f-17db-4643-992b-08d9364f3fc5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7500
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On 6/23/21 3:53 PM, Krzysztof Wilczyński wrote:
> [+cc Sasha for visibility]
> 
> Hi Michal,
> 
> Thank you for sending v2 so promptly!  And for all the extra changes and
> fixes.  Much appreciated!
> 
>> Enable PCIE reference clock. There is no remove function that's why
>> this should be enough for simple operation.
>> Normally this clock is enabled by default by firmware but there are
>> usecases where this clock should be enabled by driver itself.
>> It is also good that clock user is recorded in clock framework.
> 
> Small nitpicks: it would be PCIe here in the above and in the error
> message (this is as per [1]), and "use cases" also in the above. 
> 
> This can be corrected when the patch will be merged by either Bjorn or
> Lorenzo, to avoid sending v3 unnecessarily, provided that they would
> have a moment to do it, of course.

Ok. Will wait for them.

> 
>> Fixes: ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL PCIe Host Controller")
> 
> Thank you!
> 
> Does it make sense for this change to be back-ported to stable and
> long-term kernels?
> 
> I am asking to make sure we do the right thing here, as I can imagine
> that older kernels (primarily because some folks could use, for example,
> Ubuntu LTS releases for development) might often be used by people who
> work with the Xilinx FPGAs and such.

I think that make sense to do so. I haven't had a time to take look at
it closely but I think on Xilinx ZynqMP zcu102 board this missing patch
is causing hang when standard debian 5.10 is used.


> 
> [...]
>> +	err = clk_prepare_enable(pcie->clk);
>> +	if (err) {
>> +		dev_err(dev, "can't enable pcie ref clock\n");
>> +		return err;
>> +	}
>> +
> 
> As per the nitpick above, it would be "PCIe", but probably no need to
> send v3 to correct this.

I will keep my eyes on it and will update it if v3 is required.

Thanks,
Michal
