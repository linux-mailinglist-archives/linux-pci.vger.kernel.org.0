Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F441634B6
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 13:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfGILDE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jul 2019 07:03:04 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9353 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfGILDE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2019 07:03:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d24746a0000>; Tue, 09 Jul 2019 04:03:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 09 Jul 2019 04:03:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 09 Jul 2019 04:03:01 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Jul
 2019 11:02:59 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V3] PCI: tegra: Enable Relaxed Ordering only for Tegra20 &
 Tegra30
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Vidya Sagar <vidyas@nvidia.com>, <bhelgaas@google.com>,
        <treding@nvidia.com>, <swarren@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190704150428.4035-1-vidyas@nvidia.com>
 <20190704160948.GA28058@e121166-lin.cambridge.arm.com>
 <310ce6f7-9379-9857-ac7c-53118b80966b@nvidia.com>
 <20190705093859.GA17491@e121166-lin.cambridge.arm.com>
Message-ID: <c3168cfd-69f5-b51b-6ec6-c64d447efe13@nvidia.com>
Date:   Tue, 9 Jul 2019 12:02:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705093859.GA17491@e121166-lin.cambridge.arm.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562670186; bh=duxsM4jaiCIGu9f68Hhmt/737H3A12RFzUMlXOvrCvE=;
        h=X-PGP-Universal:From:Subject:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=EYFLVwpiCs217ROg5nwsOsO905r5vdJiu/rSh0V3XuQpv44jB2LPAy+dzoe1CiKf7
         e2ksdTAuA8YyioUmF3FaQuoaOzr5Dbv7FEOe1DKS/IPP8fIANC/017l/hk7WrkiegD
         yQwi5w4d1eE7yBdUExKhHKequtdox44WIx3WYwIrflqeED0vCDIIXi/c3L7fvHR8fs
         zatwhGqH7rQOl4ps9URRYMDM74ly4F9nMEaQRAPAt0r/4FDfibAHeHQ9wcY0KviAWu
         CSKKKSleCgh+/GXTQ3T2mr3Kwr8nvs0zRtJ7HXRZq3kadmV/IGYQxVvY+aIFANXmPz
         h+67Lq3aiRsgw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 05/07/2019 10:38, Lorenzo Pieralisi wrote:
> [+Greg]
> 
> On Fri, Jul 05, 2019 at 09:57:25AM +0100, Jon Hunter wrote:
>> Hi Lorenzo,
>>
>> On 04/07/2019 17:09, Lorenzo Pieralisi wrote:
>>> On Thu, Jul 04, 2019 at 08:34:28PM +0530, Vidya Sagar wrote:
>>>> Currently Relaxed Ordering bit in the configuration space is enabled for
>>>> all PCIe devices as the quirk uses PCI_ANY_ID for both Vendor-ID and
>>>> Device-ID, but, as per the Technical Reference Manual of Tegra20 which is
>>>> available at https://developer.nvidia.com/embedded/downloads#?search=tegra%202
>>>> in Sec 34.1, it is mentioned that Relexed Ordering bit needs to be enabled in
>>>> its root ports to avoid deadlock in hardware. The same is applicable for
>>>> Tegra30 as well though it is not explicitly mentioned in Tegra30 TRM document,
>>>> but the same must not be extended to root ports of other Tegra SoCs or
>>>> other hosts as the same issue doesn't exist there.
>>>>
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>
>>> You forgot Thierry's ACK, I added it back but next time pay more
>>> attention please.
>>>
>>> You should link the versions through eg git send-email
>>> --in-reply-to=Message-Id so that it is easier to follow.
>>>
>>>> ---
>>>> V3:
>>>> * Modified commit message to make it more precise and explicit
>>>>
>>>> V2:
>>>> * Modified commit message to include reference to Tegra20 TRM document.
>>>>
>>>>  drivers/pci/controller/pci-tegra.c | 7 +++++--
>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> I applied it to pci/tegra after rewriting the whole commit log and
>>> adding a Fixes: tag that you or someone at Nvidia will follow up;
>>> I will check.
>>
>> I had a chat with Vidya last night to understand the issue, so now I
>> have a good understanding of the problem this has caused, which is very
>> unfortunate indeed!
>>
>> Vidya mentioned that you would like us to get this backported to stable
>> branches. Please correct me if I am wrong here. We can certainly do
>> that, but I do have concerns about doing so, for non-Tegra devices
>> inparticularly, given that this has been around for sometime now. Hence,
>> I was wondering if we should leave this soak in the mainline for at
>> least a kernel release cycle before doing so. I really don't want to
>> break stable for anyone. What are your thoughts on this?
> 
> I looped in Greg to pick his brain, since it is unclear how we should
> apply the stable kernel rules on this specific patch. Basically, this
> technically is not a bug, it is just bad code that forces a feature on
> ALL kernels that compile the PCI Tegra Controller driver in the kernel.
> I would really really want to have this patch applied to all stable
> kernels but first as you said it is better to apply it to mainline and
> check it does not cause any issues on any other arch/platform then
> we can think about backporting it to stable kernels.
> 
> I am not happy to force Relaxed Ordering on any PCIe device on
> any platform/arch compiling PCI Tegra controller in, so somehow
> we must rectify this situation, this is gross as I said before.

Yes understood. Let's plan to sync up on this once v5.3 is out and see
how the land lies. We have an internal issue filed to track this and so
we should not forget!

Cheers
Jon

-- 
nvpublic
