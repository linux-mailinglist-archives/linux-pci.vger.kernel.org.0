Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2FC216194
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 11:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfEGJ6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 05:58:06 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13774 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfEGJ6F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 05:58:05 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd1568a0000>; Tue, 07 May 2019 02:57:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 May 2019 02:58:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 May 2019 02:58:04 -0700
Received: from [10.25.73.250] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 May
 2019 09:57:59 +0000
Subject: Re: [PATCH V5 11/16] dt-bindings: PHY: P2U: Add Tegra 194 P2U block
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
 <20190424052004.6270-12-vidyas@nvidia.com> <20190426154519.GA19329@bogus>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <c13db22f-0557-8e98-0a1d-00ee4405e6db@nvidia.com>
Date:   Tue, 7 May 2019 15:27:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426154519.GA19329@bogus>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557223050; bh=yMsBiV1fEe9A1TMMLA2KOVpdo0cNL5OaDWCKWRUAWd4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=E0KqgTbmZdwQUPOTRizQDdy3EywsHpf0ZNQ/rMVFPenqr4vkGKS9bmSfTG6rwBIk8
         Ea2Io3f6vj7Gdq3hXuiUi9RUu2bn5qCONy0tpr6/7sC6qPgGbCYmcTiZhAQKKm8WIs
         DO+utS9tWBXG+o3Vq/ntx5qhTKP9q+nI50yl5PduUNBKLegReyTi8J6oR/1Yem6a06
         swD6Gn+/eAKc6A8vdqurZvej2kDFZsRaonKz25ZUcLgKTjIV27zDa7Lf/CUMz+DDVD
         L4LPmCa17kdDUbPgdDFCOb99OidYusHCPLhppOtk6zIaLR4WVKV0WM2WvIpNz5lS51
         Rsx9dyningPNQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/26/2019 9:15 PM, Rob Herring wrote:
> On Wed, Apr 24, 2019 at 10:49:59AM +0530, Vidya Sagar wrote:
>> Add support for Tegra194 P2U (PIPE to UPHY) module block which is a glue
>> module instantiated one for each PCIe lane between Synopsys Designware core
>> based PCIe IP and Universal PHY block.
> 
> Missing Sob.
Done.

> 
>> ---
>> Changes since [v4]:
>> * None
>>
>> Changes since [v3]:
>> * None
>>
>> Changes since [v2]:
>> * Changed node label to reflect new format that includes either 'hsio' or
>>    'nvhs' in its name to reflect which UPHY brick they belong to
>>
>> Changes since [v1]:
>> * This is a new patch in v2 series
>>
>>   .../bindings/phy/phy-tegra194-p2u.txt         | 28 +++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
>> new file mode 100644
>> index 000000000000..8b543cba483b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
>> @@ -0,0 +1,28 @@
>> +NVIDIA Tegra194 P2U binding
>> +
>> +Tegra194 has two PHY bricks namely HSIO (High Speed IO) and NVHS (NVIDIA High
>> +Speed) each interfacing with 12 and 8 P2U instances respectively.
>> +A P2U instance is a glue logic between Synopsys DesignWare Core PCIe IP's PIPE
>> +interface and PHY of HSIO/NVHS bricks. Each P2U instance represents one PCIe
>> +lane.
>> +
>> +Required properties:
>> +- compatible: For Tegra19x, must contain "nvidia,tegra194-p2u".
>> +- reg: Should be the physical address space and length of respective each P2U
>> +       instance.
>> +- reg-names: Must include the entry "ctl".
> 
> -names is pointless when there is only 1.
I did it this way to make it future proof as there could be more regions that might get
added at a later point of time.

> 
>> +
>> +Required properties for PHY port node:
>> +- #phy-cells: Defined by generic PHY bindings.  Must be 0.
>> +
>> +Refer to phy/phy-bindings.txt for the generic PHY binding properties.
>> +
>> +Example:
>> +
>> +p2u_hsio_0: p2u@3e10000 {
> 
> phy@...
Done.

> 
>> +	compatible = "nvidia,tegra194-p2u";
>> +	reg = <0x03e10000 0x10000>;
>> +	reg-names = "ctl";
>> +
>> +	#phy-cells = <0>;
>> +};
>> -- 
>> 2.17.1
>>

