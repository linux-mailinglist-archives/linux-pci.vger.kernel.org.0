Return-Path: <linux-pci+bounces-2404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7594D835A19
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 05:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE991C21977
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 04:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5591103;
	Mon, 22 Jan 2024 04:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DuLqF5t4"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8BF23B1;
	Mon, 22 Jan 2024 04:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705898344; cv=none; b=HH/XkXpYFan47F6uCxNrLgQzSNKT491SQbRQZdelK+PepB2hxZE9f59zahuJcjkzoylr4IPv8zLQaUG7qa9LVrQLWT00r7i0DjTzAHC0Zj405iDWhgIZPvZb3L08OXZJD8W9JkQLe+VXHTCec9kHXGY/BmD9SFLXFoVVOPlrv6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705898344; c=relaxed/simple;
	bh=aZ4eJLzvRgDUu8SK8sH2BMSXOYwnC9Jn38nluLPfSL4=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CoKQCY0Ojlcg7HrpC8CaMW8oayfEyrgQ9lha7kRnchC8JGXIylW+90DP9eBV75tunDXbGi2yrUFC9WbNLRBURml34YBRJ91KeKI2kzqDjFCSOILUp8GSBbizrft12xofzzXn//Lh5gLb81hHBEc4o4tWYP/LnwMbvUUrq9QrKwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DuLqF5t4; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40M4cQp3003682;
	Sun, 21 Jan 2024 22:38:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705898306;
	bh=Yv2nSf8N9CL9Pd+LiNW9j/JB6/vZI1vHFGPJonKLe/Y=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=DuLqF5t4Xn6B336Glo9YIVrMn1yjHSnjWm/6a/AGr9TLuRLstdDl20s87afXH3AxS
	 ghNL9O9fk0dGF8HJxVl7aY3lki6hZ9DGA+/yKPaqV8O8bAlkn1zda4/v6IMRrDh+3p
	 QrhuIcnmSxCdbozlmKPZuPvzmrHzC7J+4CkRybAQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40M4cQAk007632
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 21 Jan 2024 22:38:26 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 21
 Jan 2024 22:38:26 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 21 Jan 2024 22:38:25 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40M4cLO5106030;
	Sun, 21 Jan 2024 22:38:22 -0600
Message-ID: <230c2000-1510-4da2-b5b7-df363cd9a45d@ti.com>
Date: Mon, 22 Jan 2024 10:08:21 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <ilpo.jarvinen@linux.intel.com>, <vigneshr@ti.com>,
        <r-gunasekaran@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3] PCI: keystone: Fix race condition when initializing
 PHYs
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20240119232032.GA192245@bhelgaas>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20240119232032.GA192245@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 20/01/24 04:50, Bjorn Helgaas wrote:
> On Wed, Jan 10, 2024 at 11:35:24AM +0530, Siddharth Vadapalli wrote:
>> Hello Bjorn,
>>
>> On 10/01/24 02:53, Bjorn Helgaas wrote:

...

>>
>> Does the following look fine?
>> ===============================================================================
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c
>> b/drivers/pci/controller/dwc/pci-keystone.c
>> index e02236003b46..6e9f9589d26c 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -962,6 +962,9 @@ static int ks_pcie_enable_phy(struct keystone_pcie *ks_pcie)
>>         int num_lanes = ks_pcie->num_lanes;
>>
>>         for (i = 0; i < num_lanes; i++) {
>> +               /* Obtain reference to the phy */
>> +               phy_pm_runtime_get_sync(ks_pcie->phy[i]);
> 
> I thought the point was that you needed to guarantee that all PHYs are
> powered on and stay that way before initializing any of them.  If so,
> you would need a separate loop, e.g.,
> 
>   for (i = 0; i < num_lanes; i++)
>     phy_pm_runtime_get_sync(ks_pcie->phy[i]);
> 
>   for (i = 0; i < num_lanes; i++) {
>     ret = phy_reset(ks_pcie->phy[i]);
>     ...
> 

Yes, the above implementation seems better. The strict requirement will be that
post initialization of the first PHY (Serdes), it remains powered ON so that it
can provide its reference clock to the second PHY (Serdes). Therefore, getting
the reference to the PHYs within the loop will work too since the reference is
being release only outside the loop. Nevertheless I shall go ahead with the
implementation suggested by you since that looks much better and cleaner.

>>                 ret = phy_reset(ks_pcie->phy[i]);
>>                 if (ret < 0)
>>                         goto err_phy;
>> @@ -977,12 +980,18 @@ static int ks_pcie_enable_phy(struct keystone_pcie *ks_pcie)
>>                 }
>>         }
>>
>> +       /* Release reference(s) to the phy(s) */
>> +       for (i = 0; i < num_lanes; i++)
>> +               phy_pm_runtime_put_sync(ks_pcie->phy[i]);
>> +
>>         return 0;
>>
>>  err_phy:
>>         while (--i >= 0) {
>>                 phy_power_off(ks_pcie->phy[i]);
>>                 phy_exit(ks_pcie->phy[i]);
>> +               /* Release reference to the phy */
>> +               phy_pm_runtime_put_sync(ks_pcie->phy[i]);
>>         }
>>
>>         return ret;

-- 
Regards,
Siddharth.

