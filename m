Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9948120B398
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jun 2020 16:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgFZObo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jun 2020 10:31:44 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3396 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgFZObn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jun 2020 10:31:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef606700001>; Fri, 26 Jun 2020 07:30:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 07:31:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Jun 2020 07:31:43 -0700
Received: from [10.40.205.13] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jun
 2020 14:31:37 +0000
Subject: Re: [RFC] PCI: tegra: Revert raw_violation_fixup for tegra124
To:     Nicolas Chauvet <kwizart@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20200420164304.28810-1-kwizart@gmail.com>
 <680b456a-b1ed-45f6-aa38-6ec49783af6d@nvidia.com>
 <CABr+WT=Gy6vmB-GdCeR_q8ogB4b19LDqQV5mjNh5VvZ0BUJKig@mail.gmail.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <4acabca8-e2fc-b660-0c37-c5f332b99084@nvidia.com>
Date:   Fri, 26 Jun 2020 20:00:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CABr+WT=Gy6vmB-GdCeR_q8ogB4b19LDqQV5mjNh5VvZ0BUJKig@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593181808; bh=rfotPtR65lcNl8JsC77pG5+W18C3D6C7K31DVG1cqEQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=BJ+boJUZ2JgAN8Pial9Ox17ZWvxk19YuxM+bOK1vwqZw5u7fBJKnrqEsAS197WEZ/
         I4IS/urUZl0KRlpbEZK9wvCthhZ0Yb+QMbaTnReCYzaIlYgI6kv4D0/00YKSazu87Y
         htxWG4jpN1TAfvDmn/QN07y+wsDaCe81QfyGBlBxAeKJpnji7EISfMpOf/Hc38pXlT
         ODRrqSMhoMCZrgOWqlmLGJVssZvm3if/2/boJUjK/jd4j7dM6ygbGK7HjmGDWbcq4C
         MS/SiKM5p5miq/3k35CMPb995VGze1hO34xnN663W73Zg2NMuWocdlU8lElCpeCfRT
         7g1hB/FJdgUAQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 26-Jun-20 6:52 PM, Nicolas Chauvet wrote:
> External email: Use caution opening links or attachments
>
>
> Le lun. 20 avr. 2020 =C3=A0 20:16, Manikanta Maddireddy
> <mmaddireddy@nvidia.com> a =C3=A9crit :
>> Thank you Nicolas for identifying the patch which caused the CmpltTO.
>>
>> Little background on the fixup,
>>  In the internal testing with dGPU on Tegra124, CmplTO is reported by
>> dGPU. This happened because FIFO queue in AFI(AXI to PCIe) module
>> get full by upstream posted writes. Back to back upstream writes
>> interleaved with infrequent reads, triggers RAW violation and CmpltTO.
>> This is fixed by reducing the posted write credits and by changing
>> updateFC timer frequency. These settings are fixed after stress test.
>>
>> In the current case, RTL NIC is also reporting CmplTO. These settings
>> seems to be aggravating the issue instead of fixing it.
> Seems I've lost track of this  issue.
>
> @Manikanta Maddireddy  Do you plan to have some time to work on this ?

Unfortunately, I don't have access to T124 platform because of lock down.

> If going with the revert I wonder if I need to revert more completely
> the original patch ? Since only tegra124 used the raw_violation_fixup,
> should I remove this case and the related function completely or leave
> the code as is ? (there will be few unused functions maybe). Given
> other fixup have been added at a later time, the full revert is less
> trivial.

There are no unused functions, small piece of code under raw_violation_fixu=
p
check will become redundant. Yes, revert will give conflicts.
I may not get a chance to work on this bug in coming months. If possible,
please do complete revert. Once I get a chance to work on this bug, I will
send out new patch.

-Manikanta

>
> Right now this partial revert is enough to work reliably with the device.
>
> Thanks for your advice.
> I will send a non-RFC version then.

