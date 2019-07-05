Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F18A602BB
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 10:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfGEI5c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 04:57:32 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8923 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfGEI5c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jul 2019 04:57:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1f10ff0000>; Fri, 05 Jul 2019 01:57:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 05 Jul 2019 01:57:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 05 Jul 2019 01:57:31 -0700
Received: from [10.26.11.221] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Jul
 2019 08:57:28 +0000
Subject: Re: [PATCH V3] PCI: tegra: Enable Relaxed Ordering only for Tegra20 &
 Tegra30
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>
CC:     <bhelgaas@google.com>, <treding@nvidia.com>, <swarren@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190704150428.4035-1-vidyas@nvidia.com>
 <20190704160948.GA28058@e121166-lin.cambridge.arm.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <310ce6f7-9379-9857-ac7c-53118b80966b@nvidia.com>
Date:   Fri, 5 Jul 2019 09:57:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190704160948.GA28058@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562317055; bh=Y65L4SlD3nFwcEsHObKuUGmbM8XzhhPABML9Lsxmtn8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Cwx9Rojuc+VqH0QwO2hYnig785gwggT/X/RQKsj0xG/cEOHcBp6cSDj1e6c5IHeLp
         2K0nViCrJhrTGMxxN4SVgREYD+uVkcd/Eg8Nq5Y2VgnVIHslDswvdS7c7sIdpSRlO0
         QJI1vi7O8a0D3D/fiVwVwx27fOnsDcqd5b4yvziIIiJCCp5G0KFf5VKlgK9ypIAbVl
         NPhVxnt00DBLY/m8HJMajVNT4mp3A+C834cxulU7LtD/7ejgsxWPXpKcRvjkliPjpZ
         BWdXkrNjHjFvEYpf3z+ZNX+FvyJNoF3lu1Ax3MHk5LUhn8/6wfUfby49GMq2fJnF4/
         YAXwNcptxIDcQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 04/07/2019 17:09, Lorenzo Pieralisi wrote:
> On Thu, Jul 04, 2019 at 08:34:28PM +0530, Vidya Sagar wrote:
>> Currently Relaxed Ordering bit in the configuration space is enabled for
>> all PCIe devices as the quirk uses PCI_ANY_ID for both Vendor-ID and
>> Device-ID, but, as per the Technical Reference Manual of Tegra20 which is
>> available at https://developer.nvidia.com/embedded/downloads#?search=tegra%202
>> in Sec 34.1, it is mentioned that Relexed Ordering bit needs to be enabled in
>> its root ports to avoid deadlock in hardware. The same is applicable for
>> Tegra30 as well though it is not explicitly mentioned in Tegra30 TRM document,
>> but the same must not be extended to root ports of other Tegra SoCs or
>> other hosts as the same issue doesn't exist there.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> 
> You forgot Thierry's ACK, I added it back but next time pay more
> attention please.
> 
> You should link the versions through eg git send-email
> --in-reply-to=Message-Id so that it is easier to follow.
> 
>> ---
>> V3:
>> * Modified commit message to make it more precise and explicit
>>
>> V2:
>> * Modified commit message to include reference to Tegra20 TRM document.
>>
>>  drivers/pci/controller/pci-tegra.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> I applied it to pci/tegra after rewriting the whole commit log and
> adding a Fixes: tag that you or someone at Nvidia will follow up;
> I will check.

I had a chat with Vidya last night to understand the issue, so now I
have a good understanding of the problem this has caused, which is very
unfortunate indeed!

Vidya mentioned that you would like us to get this backported to stable
branches. Please correct me if I am wrong here. We can certainly do
that, but I do have concerns about doing so, for non-Tegra devices
inparticularly, given that this has been around for sometime now. Hence,
I was wondering if we should leave this soak in the mainline for at
least a kernel release cycle before doing so. I really don't want to
break stable for anyone. What are your thoughts on this?

Cheers
Jon

-- 
nvpublic
