Return-Path: <linux-pci+bounces-2807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EE4842768
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 16:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817681F28A25
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 15:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FBB7CF2D;
	Tue, 30 Jan 2024 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T/qAWyz2"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18D37CF08;
	Tue, 30 Jan 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626833; cv=none; b=U1rjDTwT2f3pfbmBSeybHJaGv4DZB1+rjiLueiKDKh2PROnQjxZ88UYIFd8XKqV2mRU9raA/yvhVMDt/1W1KWuvLakcHRMxCsE+ndi+EAtb4nzvz16B4aIMDqttTPQuKVpwqJoK7JojvvxqcV5P2p8ca/0mGmg6MHhB8pppQ3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626833; c=relaxed/simple;
	bh=yf/E+KrZm1v3DbFb8PD3BM4OlyyFjS4+n1tQ1b2z4Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ljv3ypSs+0b7tnSS995OzDo2xLcCR+C63iOkr9iPDU5W4eeKS2kVMN9IehSMor29sKNvpya/i62W8Z1Q/k3YXlr/sY6XlpXFpL/KcNT5+wnsHG+Jzti7m8F6PrdpRTdyAJ4lkofGUW/5tJZ16YpCoOXdgLvve3Le++T+PXK0ytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=T/qAWyz2; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UF039E005424;
	Tue, 30 Jan 2024 09:00:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706626803;
	bh=cLew7QEnbGPCJQBzmHXkmCYYlM0RwNdCJ9orZc+7ESg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=T/qAWyz2n4znNZBy/rurIjG4AgjwQjl8Ci0wQii/S/bySa4NSLuX+6dh5mjGvZTWp
	 k/uxK1zbXdJaICGbIL8YmHzp0h6BmiPs5gW1Y5z6/42PznGuZHhb+R/cDPpPmiaOOV
	 pxpk2jZMHRLFiZkwsyitZps6rn3x7t1ujjar3smM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UF03AD115946
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 09:00:03 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 09:00:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 09:00:02 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UF02vC014189;
	Tue, 30 Jan 2024 09:00:02 -0600
Message-ID: <2a373360-9bf2-411c-a9aa-0a7451b9ba38@ti.com>
Date: Tue, 30 Jan 2024 09:00:01 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: j721e: Extend j721e_pcie_ctrl_init() for non syscon
 nodes
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <vigneshr@ti.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
References: <20240129104958.1139787-1-s-vadapalli@ti.com>
 <077682de-7789-4f1f-8dcc-aa47f4fb2dff@ti.com>
 <792c972b-052e-4e24-a85f-9415fe02aa01@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <792c972b-052e-4e24-a85f-9415fe02aa01@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/29/24 10:50 PM, Siddharth Vadapalli wrote:
> Hello Andrew,
> 
> On 29/01/24 20:49, Andrew Davis wrote:
>> On 1/29/24 4:49 AM, Siddharth Vadapalli wrote:
> 
> ...
> 
>>>        int ret;
>>>    -    syscon = syscon_regmap_lookup_by_phandle(node, "ti,syscon-pcie-ctrl");
>>> +    scm_conf = of_parse_phandle(node, "ti,syscon-pcie-ctrl", 0);
>>> +    if (!scm_conf) {
>>> +        dev_err(dev, "unable to get System Controller node\n");
>>> +        return -ENODEV;
>>> +    }
>>> +
>>> +    syscon = device_node_to_regmap(scm_conf);
>>
>> Turning the entire "simple-bus" region into a regmap using this
>> function is just as broken as having it as a "syscon". The core
>> problem we are solving by getting rid of the blanket syscon nodes
>> is that it causes multiple mappings of the same register. This
>> can cause issues with regmap caching, read–modify–write, etc..
>>
>> What you want to do is add a subnode to the simple-bus, have that
>> encapsulate just the registers used for PCIe, and have the PCIe
>> node point to that. Then this patch isn't needed.
>>
>> For an example, see how it's done for DSS[0].
> 
> Thank you for reviewing the patch. I will implement it similar to what's done
> for DSS as you pointed out. However, what about the existing SoCs which make use
> of the "ti,syscon-pcie-ctrl" property? Do you suggest that I add another
> device-tree property for pointing to the PCIE_CTRL register within the CTRL_MMR
> region, or do you suggest that I reuse the existing "ti,syscon-pcie-ctrl"
> property differently in the SoCs like J784S4 where the scm_conf node is a
> "simple-bus"?
> 
> The "ti,syscon-pcie-ctrl" property as defined in the device-tree bindings has
> two elements with the first being the phandle to the scm_conf node and the
> second being the offset of the PCIE_CTRL register. The newer implementation you
> are suggesting will either require a new property which accepts only one element
> namely the phandle to the node within scm_conf corresponding to the PCIE_CTRL
> register. Will adding a new property be acceptable?
> 

Why would you need a new property? If there is no offset to the PCIE_CTRL register
in the new syscon space then just set the offset = 0x0, easy.

Andrew

