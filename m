Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4117F1261BD
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 13:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfLSMK6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 07:10:58 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55792 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLSMK6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 07:10:58 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBJCAm6A100054;
        Thu, 19 Dec 2019 06:10:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576757448;
        bh=v7Np/OFkk20fqw6MV6RMIPQQKnOLNyFYGAZXUuSYuis=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GyQUlmhVIxuCexAwcASlKaNdBf4wIzpZSBhv1Apxw/aaLiQRDVPrssznmXnsNX/eY
         5okO5d8vuR3DuOJtiuAdGVdMHZ0gU5mTeJp1hpz+D6NghP5Cjzr38iyopE6FnuZXZv
         a5+u5ytJzvZEpuRScDl0GmdeuUKn3g8nSko27ZZE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJCAmkd026460;
        Thu, 19 Dec 2019 06:10:48 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Dec 2019 06:10:48 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Dec 2019 06:10:47 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJCAiUg062952;
        Thu, 19 Dec 2019 06:10:45 -0600
Subject: Re: [PATCH 08/13] PCI: cadence: Use local management register to
 configure Vendor ID
To:     Andrew Murray <andrew.murray@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Tom Joseph <tjoseph@cadence.com>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-9-kishon@ti.com>
 <20191217124238.GE24359@e119886-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <cdb15479-6cc4-e00f-34a6-6cf191179bf7@ti.com>
Date:   Thu, 19 Dec 2019 17:42:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217124238.GE24359@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Tom

Hi,

On 17/12/19 6:12 pm, Andrew Murray wrote:
> On Mon, Dec 09, 2019 at 02:51:42PM +0530, Kishon Vijay Abraham I wrote:
>> PCI_VENDOR_ID in root port configuration space is read-only register
>> and writing to it will have no effect. Use local management register to
>> configure Vendor ID and Subsystem Vendor ID.
> 
> Is this a bug fix? Can you add a Fixes tag and make that clearer?

I think this might have worked in Cadence platform? Tom?

Thanks
Kishon

> 
> Thanks,
> 
> Andrew Murray
> 
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/cadence/pcie-cadence-host.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index cf817be237af..afb2c96a6538 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -71,6 +71,7 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>>  {
>>  	struct cdns_pcie *pcie = &rc->pcie;
>>  	u32 value, ctrl;
>> +	u32 id;
>>  
>>  	/*
>>  	 * Set the root complex BAR configuration register:
>> @@ -90,8 +91,12 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>>  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
>>  
>>  	/* Set root port configuration space */
>> -	if (rc->vendor_id != 0xffff)
>> -		cdns_pcie_rp_writew(pcie, PCI_VENDOR_ID, rc->vendor_id);
>> +	if (rc->vendor_id != 0xffff) {
>> +		id = CDNS_PCIE_LM_ID_VENDOR(rc->vendor_id) |
>> +			CDNS_PCIE_LM_ID_SUBSYS(rc->vendor_id);
>> +		cdns_pcie_writel(pcie, CDNS_PCIE_LM_ID, id);
>> +	}
>> +
>>  	if (rc->device_id != 0xffff)
>>  		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
>>  
>> -- 
>> 2.17.1
>>
