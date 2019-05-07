Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB76B15F66
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 10:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfEGIbV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 04:31:21 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9684 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEGIbU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 04:31:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd1425a0000>; Tue, 07 May 2019 01:31:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 May 2019 01:31:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 May 2019 01:31:14 -0700
Received: from [10.25.73.250] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 May
 2019 08:31:07 +0000
Subject: Re: [PATCH V5 09/16] Documentation/devicetree: Add PCIe
 supports-clkreq property
To:     Rob Herring <robh@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-10-vidyas@nvidia.com> <20190426152229.GA8492@bogus>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <d8ef9c8d-031b-4c77-b225-4a1fef3bc9eb@nvidia.com>
Date:   Tue, 7 May 2019 14:01:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426152229.GA8492@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557217882; bh=E4R0bJaTc1XE8Bf2zvQbXuwPLi2Wnco5hGqGVqidxEo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=EjKMx+IrwLC7OlCn4DahxXHLMvnH1eWfEWPdkY/ioG3avM5ymJYSCMMugCZWV4n1x
         FsOJwNFO2fEcxle7Ne9WovuScxWqwRHx8lpa3BH6b5A5udhmvr0irtXmCru6Hy0Yj+
         ED+8LoEy0fZ9yJDTov8NGlEc5ExVyXI8sLRmBkfdsUftk4M49ons7tllllj0Ao4+Oe
         LOAiIjAeZxulLxMFTdZE5b+O4bXhiWyDQ+7rWqPnDr9cE9Ti4gLfT9GPKz0qwyUW5n
         cJYifvYWO84KI8RI3CC/5HLc5ZfUjYfPOLxSDFJM4BbzUCxT5FdeB/KHkV5KIq3TQV
         tkXX3FOplgwVQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/26/2019 8:52 PM, Rob Herring wrote:
> On Wed, Apr 24, 2019 at 10:49:57AM +0530, Vidya Sagar wrote:
>> Some host controllers need to know the existence of clkreq signal routing to
>> downstream devices to be able to advertise low power features like ASPM L1
>> substates. Without clkreq signal routing being present, enabling ASPM L1 sub
>> states might lead to downstream devices falling off the bus. Hence a new device
>> tree property 'supports-clkreq' is added to make such host controllers
>> aware of clkreq signal routing to downstream devices.
> 
> Please be consistent with subjects (Use 'dt-bindings: ...')
When I had made this change, I did a git log and saw 'Documentation/devicetree:' as
the prefix and hence added it. But, now, with linux-next top of the tree,  I see
two more commits with 'dt-bindings:' prefix. I'll change my patch also to the new
'dt-bindings:' prefix.

> 
> With that change,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v4]:
>> * None
>>
>> Changes since [v3]:
>> * Rebased on top of linux-next top of the tree
>>
>> Changes since [v2]:
>> * None
>>
>> Changes since [v1]:
>> * This is a new patch in v2 series
>>
>>   Documentation/devicetree/bindings/pci/pci.txt | 5 +++++
>>   1 file changed, 5 insertions(+)

