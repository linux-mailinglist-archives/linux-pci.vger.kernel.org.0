Return-Path: <linux-pci+bounces-2753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32024841B1A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 05:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E07EB232FF
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 04:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B82D374D4;
	Tue, 30 Jan 2024 04:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ouYYuY3/"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6B31A94;
	Tue, 30 Jan 2024 04:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706590255; cv=none; b=gqs9Iloep2dAF9uXAtywu+I3VhZ8+G1XL6cH+I1S8YljfjPCMzVlpTFt2bmJI2gglHJHbdzJWayeq3o59tnlELw0D+/uUePEjTCPn8dEcG18GkH0n/Xu9YKHmxLFsYtIc/LICDG6p379AYXKmooGq+hOVa2YT2kJmmDcfPAHxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706590255; c=relaxed/simple;
	bh=8+PJVPKpGoMmgsmvr4m4hAW0aVwtWAKbHXQgUXDQXFk=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OLBtWGATwtT0V3IfSWckL+SpNHBPU99WS9UEDaWzrJ0R7zOMllnUHVg6oJmNYHdQttZwiZMgwOWbwSY6DJMEmdL/StU35vMaQ6KHgLocFwnnVRfCbP6eNb4dF0A5gFfxLqrue2MXYD+zibVr3iaSxEyyfod2Qq6ZU8tLJIghGlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ouYYuY3/; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40U4ogB7076774;
	Mon, 29 Jan 2024 22:50:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706590242;
	bh=vmGKrfrWi8SefWO6YoNfrdoCFyUMhSYtQu4hGG9FAWQ=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=ouYYuY3/Y+PpQCTRFXPUYsFkt2Senq+YIR5spb9PSyFXsOOBepuyPeV6WA08cje40
	 wYYMpZsxSivPM25ICTQC2NRp/YpNyop2P7kxh/ADZXaTPKslp5mXz6HS0dr3x4+O8i
	 YUkIhn3kYOG9aG+CyzE4h7re47WbRa9QfRimNUkk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40U4og4l047898
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 22:50:42 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 22:50:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 22:50:41 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40U4ocXI093764;
	Mon, 29 Jan 2024 22:50:38 -0600
Message-ID: <792c972b-052e-4e24-a85f-9415fe02aa01@ti.com>
Date: Tue, 30 Jan 2024 10:20:37 +0530
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
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <077682de-7789-4f1f-8dcc-aa47f4fb2dff@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Andrew,

On 29/01/24 20:49, Andrew Davis wrote:
> On 1/29/24 4:49 AM, Siddharth Vadapalli wrote:

...

>>       int ret;
>>   -    syscon = syscon_regmap_lookup_by_phandle(node, "ti,syscon-pcie-ctrl");
>> +    scm_conf = of_parse_phandle(node, "ti,syscon-pcie-ctrl", 0);
>> +    if (!scm_conf) {
>> +        dev_err(dev, "unable to get System Controller node\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    syscon = device_node_to_regmap(scm_conf);
> 
> Turning the entire "simple-bus" region into a regmap using this
> function is just as broken as having it as a "syscon". The core
> problem we are solving by getting rid of the blanket syscon nodes
> is that it causes multiple mappings of the same register. This
> can cause issues with regmap caching, read–modify–write, etc..
> 
> What you want to do is add a subnode to the simple-bus, have that
> encapsulate just the registers used for PCIe, and have the PCIe
> node point to that. Then this patch isn't needed.
> 
> For an example, see how it's done for DSS[0].

Thank you for reviewing the patch. I will implement it similar to what's done
for DSS as you pointed out. However, what about the existing SoCs which make use
of the "ti,syscon-pcie-ctrl" property? Do you suggest that I add another
device-tree property for pointing to the PCIE_CTRL register within the CTRL_MMR
region, or do you suggest that I reuse the existing "ti,syscon-pcie-ctrl"
property differently in the SoCs like J784S4 where the scm_conf node is a
"simple-bus"?

The "ti,syscon-pcie-ctrl" property as defined in the device-tree bindings has
two elements with the first being the phandle to the scm_conf node and the
second being the offset of the PCIE_CTRL register. The newer implementation you
are suggesting will either require a new property which accepts only one element
namely the phandle to the node within scm_conf corresponding to the PCIE_CTRL
register. Will adding a new property be acceptable?

...

-- 
Regards,
Siddharth.

