Return-Path: <linux-pci+bounces-2856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC488434E3
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 05:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEEF2898EE
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 04:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525423CF7D;
	Wed, 31 Jan 2024 04:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ytyFD4cH"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C763D0A9;
	Wed, 31 Jan 2024 04:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706676802; cv=none; b=UgZUdg/hhAypd96Kxg12zWLQ8lLj834WcJAN5goKscJ+efymTYokoo7St8yfPnQEiFYb/Y4cFrDrcrVeeTQeUYkK06mCahvjmQH+zGIFFBYkC7VZTpFlQR7QZ3dApJe89up+epHMhdIVIbNvpnkqJ9ctaTBUnpKs93v+P58xkIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706676802; c=relaxed/simple;
	bh=83vEIVIiRUom9n5l9Wa09T44oRPDaNBb4ZBKRZ8M/Uo=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Km06Z5vT/DvJDOcI13npCqUKbR+QR/ysOR9uUtVd+sqogqRic4A/eM8KEMAsYcKNaO+ZUszBOhv0oBIw09Vn1VnWwkr3Ydw421DT/C0BEM+wKhWXrUyurhJL6SuMqUXStX/iDfenPeOen2n3745SUsVgHpwQXo4pG032G82skwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ytyFD4cH; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V4r8ei052324;
	Tue, 30 Jan 2024 22:53:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706676788;
	bh=S5CDXwnWVi9SBaQus4QzH3o1wmOSFFe3GN7qWSYETTg=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=ytyFD4cHnN/gIXHJ+XP9Z0uz3p4rcCbvfDVdmFkD905njMdm5O8KEjwAoYzOnLA+Z
	 bVVY0YKexnmSATZPtuNn1YdUvPD64yNqxc1dKxQr3dYW9n7hlz0t4ByYCMvivoF9Tu
	 72HmunUFlWgZSiIc0t6Cb8JNqzt+EMOly/AUmQhE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V4r8xN039522
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 22:53:08 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 22:53:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 22:53:07 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V4r4uJ057488;
	Tue, 30 Jan 2024 22:53:05 -0600
Message-ID: <126d520e-bd00-467b-b5dc-3423cc405410@ti.com>
Date: Wed, 31 Jan 2024 10:23:03 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <vigneshr@ti.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] PCI: j721e: Extend j721e_pcie_ctrl_init() for non syscon
 nodes
Content-Language: en-US
To: Andrew Davis <afd@ti.com>
References: <20240129104958.1139787-1-s-vadapalli@ti.com>
 <077682de-7789-4f1f-8dcc-aa47f4fb2dff@ti.com>
 <792c972b-052e-4e24-a85f-9415fe02aa01@ti.com>
 <2a373360-9bf2-411c-a9aa-0a7451b9ba38@ti.com>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <2a373360-9bf2-411c-a9aa-0a7451b9ba38@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 30/01/24 20:30, Andrew Davis wrote:
> On 1/29/24 10:50 PM, Siddharth Vadapalli wrote:
>> Hello Andrew,
>>
>> On 29/01/24 20:49, Andrew Davis wrote:
>>> On 1/29/24 4:49 AM, Siddharth Vadapalli wrote:
>>
>> ...
>>
>>>>        int ret;
>>>>    -    syscon = syscon_regmap_lookup_by_phandle(node, "ti,syscon-pcie-ctrl");
>>>> +    scm_conf = of_parse_phandle(node, "ti,syscon-pcie-ctrl", 0);
>>>> +    if (!scm_conf) {
>>>> +        dev_err(dev, "unable to get System Controller node\n");
>>>> +        return -ENODEV;
>>>> +    }
>>>> +
>>>> +    syscon = device_node_to_regmap(scm_conf);
>>>
>>> Turning the entire "simple-bus" region into a regmap using this
>>> function is just as broken as having it as a "syscon". The core
>>> problem we are solving by getting rid of the blanket syscon nodes
>>> is that it causes multiple mappings of the same register. This
>>> can cause issues with regmap caching, read–modify–write, etc..
>>>
>>> What you want to do is add a subnode to the simple-bus, have that
>>> encapsulate just the registers used for PCIe, and have the PCIe
>>> node point to that. Then this patch isn't needed.
>>>
>>> For an example, see how it's done for DSS[0].
>>
>> Thank you for reviewing the patch. I will implement it similar to what's done
>> for DSS as you pointed out. However, what about the existing SoCs which make use
>> of the "ti,syscon-pcie-ctrl" property? Do you suggest that I add another
>> device-tree property for pointing to the PCIE_CTRL register within the CTRL_MMR
>> region, or do you suggest that I reuse the existing "ti,syscon-pcie-ctrl"
>> property differently in the SoCs like J784S4 where the scm_conf node is a
>> "simple-bus"?
>>
>> The "ti,syscon-pcie-ctrl" property as defined in the device-tree bindings has
>> two elements with the first being the phandle to the scm_conf node and the
>> second being the offset of the PCIE_CTRL register. The newer implementation you
>> are suggesting will either require a new property which accepts only one element
>> namely the phandle to the node within scm_conf corresponding to the PCIE_CTRL
>> register. Will adding a new property be acceptable?
>>
> 
> Why would you need a new property? If there is no offset to the PCIE_CTRL register
> in the new syscon space then just set the offset = 0x0, easy.

Seems like a Hack to me considering that the offset will always be zero for
non-syscon parent nodes (which will be the convention going forward), implying
that the offset might as well be dropped and just the phandle is sufficient. For
now I shall implement it as you suggested. Maybe once the syscon nodes in
existing SoCs are also converted to simple-bus, then the property can be
redefined to just be the phandle to "pcie_ctrl" register.

> 
> Andrew

-- 
Regards,
Siddharth.

