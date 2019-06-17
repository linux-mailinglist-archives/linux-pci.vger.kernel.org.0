Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBAA048101
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 13:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbfFQLjS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 07:39:18 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9415 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfFQLjS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 07:39:18 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d077be50000>; Mon, 17 Jun 2019 04:39:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 04:39:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 17 Jun 2019 04:39:17 -0700
Received: from [10.24.192.33] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 11:39:14 +0000
Subject: Re: [PATCH V4 26/28] PCI: Add DT binding for "reset-gpios" property
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <20190516055307.25737-27-mmaddireddy@nvidia.com> <20190617113038.GK508@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <bc6a3de8-89b0-41a8-006e-0db85fbb4d4d@nvidia.com>
Date:   Mon, 17 Jun 2019 17:08:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617113038.GK508@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560771557; bh=ILp6LOiI3Dxw0ENn5jtgndqoLvRyJ01HjrvcVbb4CL4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=V8y+elGVZ24mYQRILlEF590P5XxQ/5NVaNCJ2tnRGVLMux2r0955+jUZhtO19n1OK
         lz6TAW1Zf62BuBPXcSzEbrQpRl1yvqMOfMKG7/vpEkFQk64bNJL12+v+O2gdpY6Lsp
         5c6qx0pJlyOyTCtzpk8VhKJwUT7J2vdHdZ1EuZErPV4S+19YKWCbhn8hhzHP4JNlQM
         v1bGFEcnKWwNHKnzMFaSnN12wWo2bjifuERB5M7gK87Ebzpz17s+FDznPPpbg45XaO
         RlJG0Z4QU5+xRe3DgA8HM6iUd6FQFzLEsiixpMY9/x20Amw5gH4tGFuWKOxbv45wLK
         HxAPBolpFh3zg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 17-Jun-19 5:00 PM, Thierry Reding wrote:
> On Thu, May 16, 2019 at 11:23:05AM +0530, Manikanta Maddireddy wrote:
>> Add DT binding for "reset-gpios" property which supports GPIO based PERST#
>> signal.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> ---
>> V4: No change
>>
>> V3: Moved to common pci binding doc
>>
>> V2: Using standard "reset-gpio" property
>>
>>  Documentation/devicetree/bindings/pci/pci.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
>> index c77981c5dd18..79124898aa5b 100644
>> --- a/Documentation/devicetree/bindings/pci/pci.txt
>> +++ b/Documentation/devicetree/bindings/pci/pci.txt
>> @@ -24,3 +24,6 @@ driver implementation may support the following properties:
>>     unsupported link speed, for instance, trying to do training for
>>     unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
>>     for gen2, and '1' for gen1. Any other values are invalid.
>> +- reset-gpios:
>> +   If present this property specifies PERST# GPIO. Host drivers can parse the
>> +   GPIO and apply fundamental reset to endpoints.
> As mentioned in patch 27/28, maybe mention here that this is only a
> workaround for bad board designs and that it shouldn't be necessary in
> the majority of cases.
>
> Thierry

This is common DT binding doc, I cannot add Tegra specific here.
reset-gpios is common DT prop, so Rob asked me to add it in common file.

Manikanta 

