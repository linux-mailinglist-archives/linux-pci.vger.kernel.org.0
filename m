Return-Path: <linux-pci+bounces-1973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ABE82938C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 07:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4460A1F25B7F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 06:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D48DF69;
	Wed, 10 Jan 2024 06:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cqmx5cEY"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFBD8C1A;
	Wed, 10 Jan 2024 06:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40A65Vvi056970;
	Wed, 10 Jan 2024 00:05:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704866732;
	bh=yFsMpt0PZNf6JUgPlvVYPwAe1PAy39S8K8+Q7tYKhQA=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=cqmx5cEYvim8cKLqKbv9TH9RwTjaMw2oxjSZ62HszbJeeAd3bu4NNYF45bGJf4gGN
	 5nri+MnVNt17nUD/exe/Mpks5AoTLQbodqPs6+RMStGcEl0O1GQid8kjuOWPnF/SAc
	 GFy/t3PA52zbmZmyxrs7CwG7C6shMtS9BIGp6zlU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40A65VWs085615
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Jan 2024 00:05:31 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Jan 2024 00:05:31 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Jan 2024 00:05:29 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40A65P5Y095356;
	Wed, 10 Jan 2024 00:05:25 -0600
Message-ID: <f8dbbffd-c209-44bc-8d1e-42b6f1b08aef@ti.com>
Date: Wed, 10 Jan 2024 11:35:24 +0530
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
References: <20240109212326.GA2018284@bhelgaas>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20240109212326.GA2018284@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Bjorn,

On 10/01/24 02:53, Bjorn Helgaas wrote:
> On Wed, Sep 27, 2023 at 09:48:45AM +0530, Siddharth Vadapalli wrote:
>> The PCI driver invokes the PHY APIs using the ks_pcie_enable_phy()
>> function. The PHY in this case is the Serdes. It is possible that the
>> PCI instance is configured for 2 lane operation across two different

...

>>  
>> +	/* Obtain reference(s) to the phy(s) */
>> +	for (i = 0; i < num_lanes; i++)
>> +		phy_pm_runtime_get_sync(ks_pcie->phy[i]);
>> +
>>  	ret = ks_pcie_enable_phy(ks_pcie);
>> +
>> +	/* Release reference(s) to the phy(s) */
>> +	for (i = 0; i < num_lanes; i++)
>> +		phy_pm_runtime_put_sync(ks_pcie->phy[i]);
> 
> This looks good and has already been applied, so no immediate action
> required.
> 
> This is the only call to ks_pcie_enable_phy(), and these loops get and
> put the PM references for the same PHYs initialized in
> ks_pcie_enable_phy(), so it seems like maybe these loops could be
> moved *into* ks_pcie_enable_phy().

Does the following look fine?
===============================================================================
diff --git a/drivers/pci/controller/dwc/pci-keystone.c
b/drivers/pci/controller/dwc/pci-keystone.c
index e02236003b46..6e9f9589d26c 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -962,6 +962,9 @@ static int ks_pcie_enable_phy(struct keystone_pcie *ks_pcie)
        int num_lanes = ks_pcie->num_lanes;

        for (i = 0; i < num_lanes; i++) {
+               /* Obtain reference to the phy */
+               phy_pm_runtime_get_sync(ks_pcie->phy[i]);
+
                ret = phy_reset(ks_pcie->phy[i]);
                if (ret < 0)
                        goto err_phy;
@@ -977,12 +980,18 @@ static int ks_pcie_enable_phy(struct keystone_pcie *ks_pcie)
                }
        }

+       /* Release reference(s) to the phy(s) */
+       for (i = 0; i < num_lanes; i++)
+               phy_pm_runtime_put_sync(ks_pcie->phy[i]);
+
        return 0;

 err_phy:
        while (--i >= 0) {
                phy_power_off(ks_pcie->phy[i]);
                phy_exit(ks_pcie->phy[i]);
+               /* Release reference to the phy */
+               phy_pm_runtime_put_sync(ks_pcie->phy[i]);
        }

        return ret;
===============================================================================

> 
> Is there any similar issue in ks_pcie_disable_phy()?  What if we
> power-off a PHY that provides a reference clock to other PHYs that are
> still powered-up?  Will the dependent PHYs still power-off cleanly?

While debugging the issue fixed by this patch, I had bisected and identified
that prior to the following commit:
https://github.com/torvalds/linux/commit/e611f8cd8717c8fe7d4229997e6cd029a1465253
despite the race condition being present, there was no issue. While I am not
fully certain, I believe that the above observation indicates that prior to the
aforementioned commit, the race condition did exist, but there was a slightly
longer delay between the PHY providing the reference clock being powered off
within "ks_pcie_enable_phy()". That delay was sufficient for the dependent PHY
to lock its PLL based on the reference clock provided, following which, despite
the PHY providing the reference clock being powered off and the dependent PHY
staying powered on, there was no issue observed. Therefore, it appears to me
that holding reference to the PHY providing the reference clock isn't necessary
once the dependent PHY's PLL is locked.

...

-- 
Regards,
Siddharth.

