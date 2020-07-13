Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9338B21CF7D
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 08:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgGMGSl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 02:18:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39218 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGMGSl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 02:18:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06D6IP73016334;
        Mon, 13 Jul 2020 01:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594621105;
        bh=D5Sliar+y7yEU28bb90V7Ozp3UAZgIVTWqJbKqXmdvQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WS/g6GmXZkq+VG20d2LTXIUEqSWFliOQultgiQHpWsRPuBu0fpV9Ff5eFJzaM5FKe
         D+KbZzVG7r0bLrs4hv0k7NqtKvED5W4AQSf5OX7UkPmyPMP+k88wYgcB175k8kT9JF
         TI+C1v/M7NhNTNjgtBLTpfVJoprgVSntWPcamL4Q=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06D6IPgP103912;
        Mon, 13 Jul 2020 01:18:25 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 13
 Jul 2020 01:18:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 13 Jul 2020 01:18:25 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06D6ILWb050033;
        Mon, 13 Jul 2020 01:18:22 -0500
Subject: Re: [PATCH v6 08/14] PCI: cadence: Fix updating Vendor ID and
 Subsystem Vendor ID register
To:     Rob Herring <robh@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200708093018.28474-1-kishon@ti.com>
 <20200708093018.28474-9-kishon@ti.com> <20200709214555.GA939109@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9e9dd21b-7626-ef06-4b63-f801a297082e@ti.com>
Date:   Mon, 13 Jul 2020 11:48:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709214555.GA939109@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 7/10/2020 3:15 AM, Rob Herring wrote:
> On Wed, Jul 08, 2020 at 03:00:12PM +0530, Kishon Vijay Abraham I wrote:
>> Commit 1b79c5284439 ("PCI: cadence: Add host driver for Cadence PCIe
>> controller") in order to update Vendor ID, directly wrote to
>> PCI_VENDOR_ID register. However PCI_VENDOR_ID in root port configuration
>> space is read-only register and writing to it will have no effect.
>> Use local management register to configure Vendor ID and Subsystem Vendor
>> ID.
>>
>> Fixes: 1b79c5284439 ("PCI: cadence: Add host driver for Cadence PCIe controller")
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/cadence/pcie-cadence-host.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 10127ea71b83..8935f7a37e5a 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -82,6 +82,7 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>>  {
>>  	struct cdns_pcie *pcie = &rc->pcie;
>>  	u32 value, ctrl;
>> +	u32 id;
>>  
>>  	/*
>>  	 * Set the root complex BAR configuration register:
>> @@ -101,8 +102,12 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>>  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
>>  
>>  	/* Set root port configuration space */
>> -	if (rc->vendor_id != 0xffff)
>> -		cdns_pcie_rp_writew(pcie, PCI_VENDOR_ID, rc->vendor_id);
> 
> If this is read-only, then...
> 
>> +	if (rc->vendor_id != 0xffff) {
>> +		id = CDNS_PCIE_LM_ID_VENDOR(rc->vendor_id) |
>> +			CDNS_PCIE_LM_ID_SUBSYS(rc->vendor_id);
>> +		cdns_pcie_writel(pcie, CDNS_PCIE_LM_ID, id);
>> +	}
>> +
>>  	if (rc->device_id != 0xffff)
>>  		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
> 
> ...isn't this read-only too?

Apparently no. There is local management register only for vendor ID and
subsystem vendorID. It could be because this same IP is used EP mode and in
case of multi-function device, different deviceID could be required for each
independent function whereas vendor ID should be same, they could have given a
single local management register for vendorID and not for deviceID.

Thanks
Kishon
