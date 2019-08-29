Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45848A1EBF
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 17:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfH2PTZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 11:19:25 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13794 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfH2PTZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 11:19:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d67ecfb0003>; Thu, 29 Aug 2019 08:19:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 29 Aug 2019 08:19:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 29 Aug 2019 08:19:22 -0700
Received: from [10.25.75.254] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Aug
 2019 15:18:42 +0000
Subject: Re: [PATCH V3 2/6] dt-bindings: PCI: tegra: Add PCIe slot supplies
 regulator entries
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <jonathanh@nvidia.com>,
        <andrew.murray@arm.com>, <kishon@ti.com>,
        <gustavo.pimentel@synopsys.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190828172850.19871-1-vidyas@nvidia.com>
 <20190828172850.19871-3-vidyas@nvidia.com> <20190829120329.GC13187@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <cd106d64-e06c-e7a2-d807-f5f080625363@nvidia.com>
Date:   Thu, 29 Aug 2019 20:48:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829120329.GC13187@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567091963; bh=26NeoQlEq36/bfgv16BwS5qeIh/4BBTWDJHJLCUv198=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qD3OIyS/DUj7JJzCiNQrZXALOWvZUrW3IkW+LfcC2aBJi0hVvJ3ybkjO1QZletTa5
         xcoKk0bpSfnPkFNO6IKr/dXJlIV3ps1koC/7QqHqRnrEHH9+BMysNvxl0Ih2whZZF6
         bBsSdXcsH8DBcqgFjTJa8vgzjk5j2BVI9QHD1BVwGNWrcFT0XYIBhw4sWqnFmWsYAt
         ef+UmZetjTLW4UtCeAlGagfbpPDGf/Jsr8p7oEYFxhvvR56mE7wmWDDhOzjbKCJJcQ
         FY75nqBB+CZyocyU8VDhJQRb3gO7kZiBVmNPqmUZ9jC8ubUYGZEe9imw4xU5bj0OyQ
         RRwrhWYzA9KPQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/29/2019 5:33 PM, Thierry Reding wrote:
> On Wed, Aug 28, 2019 at 10:58:46PM +0530, Vidya Sagar wrote:
>> Add optional bindings "vpcie3v3-supply" and "vpcie12v-supply" to describe
>> regulators of a PCIe slot's supplies 3.3V and 12V provided the platform
>> is designed to have regulator controlled slot supplies.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V3:
>> * None
>>
>> V2:
>> * None
>>
>>   .../devicetree/bindings/pci/nvidia,tegra194-pcie.txt      | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>> index 0ac1b867ac24..b739f92da58e 100644
>> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>> @@ -104,6 +104,12 @@ Optional properties:
>>      specified in microseconds
>>   - nvidia,aspm-l0s-entrance-latency-us: ASPM L0s entrance latency to be
>>      specified in microseconds
>> +- vpcie3v3-supply: A phandle to the regulator node that supplies 3.3V to the slot
>> +  if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
>> +  in p2972-0000 platform).
>> +- vpcie12v-supply: A phandle to the regulator node that supplies 12V to the slot
>> +  if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
>> +  in p2972-0000 platform).
> 
> There's an ongoing discussion regarding the use of optional power
> supplies and I'm wondering if we're not abusing this here. Why exactly
> are these regulators optional?
I made them optional because, the number and type of supplies typically depend on the
kind of slot the controller is owning. If it is a CEM slot, then, it needs 3.3V & 12V
supplies and if it is an M.2 Key-E/M slot, it needs only 3.3V supply. Also, if there are
on-board PCIe endpoint devices, supplies may vary again from vendor to vendor.
Considering all these, I made them optional instead of mandatory.
Also, I agree that regulator framework supplies a dummy regulator if we make them mandatory
but doesn't supply one, but it does so with a warning print in the log which I feel is
an unwanted alert and to avoid that one has to supply dummy/fixed regulators which again
seems an overkill when all of this can be addressed by making slot regulators optional.

> 
> The distinction is somewhat subtle, but the other way to look at
> modelling this in DT is that the supplies are in fact required, but may
> be connected to an always-on regulator with a fixed voltage. Or in some
> cases they may also be shorted to ground. In both cases the PCI
> controller, or rather the slot that the controller connects to, actually
> "requires" the supplies, it's just that we can get away without
> describing them because they can't be controlled anyway.
> 
> Looking at the PCI connector pinout for PCI Express, I do see a bunch of
> +3.3 V and +12 V pins. To me that indicates that the 3.3 V and 12 V
> supplies are indeed required for PCI slots. I'm not sure about devices
> that are directly connected to the PCI controller, though. I'll need to
> go look at some schematics to get a better understanding of these.
> 
> Bottom line: I'm wondering if we shouldn't really make these supplies
> mandatory and in case where we don't care either just leave them away
> (the regulator framework will supply a dummy regulator in that case) or
> hook them up to a fixed regulator if that matches the hardware design.
> 
> Any thoughts?
> 
> Thierry
> 
>>   
>>   Examples:
>>   =========
>> @@ -156,6 +162,8 @@ Tegra194:
>>   			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>;  /* prefetchable memory (16GB) */
>>   
>>   		vddio-pex-ctl-supply = <&vdd_1v8ao>;
>> +		vpcie3v3-supply = <&vdd_3v3_pcie>;
>> +		vpcie12v-supply = <&vdd_12v_pcie>;
>>   
>>   		phys = <&p2u_hsio_2>, <&p2u_hsio_3>, <&p2u_hsio_4>,
>>   		       <&p2u_hsio_5>;
>> -- 
>> 2.17.1
>>

