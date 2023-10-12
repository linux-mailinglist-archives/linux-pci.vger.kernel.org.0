Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859F47C6430
	for <lists+linux-pci@lfdr.de>; Thu, 12 Oct 2023 06:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343508AbjJLEpn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Oct 2023 00:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343500AbjJLEpm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2023 00:45:42 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB4FB7;
        Wed, 11 Oct 2023 21:45:38 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39C4jEiI043311;
        Wed, 11 Oct 2023 23:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697085914;
        bh=3z3Dl7sdMxUgldZpTazfQulIimDLU2A2/53W0dgTXho=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=Nb5BNrL8OS3NGsYI2tzGux/h/y3/umY2a3ynh2tXhd4QpOBDsKp/pY4Q5NBjWzu3n
         u+v+A0v3yHbGR869dmzSMzOprsc19YvQ+wnzqbsOUobPHlh5Y5fEMNPTKSNsqzaZtM
         70eljo1KX/VF+knBYVk5DYX1tUSm3bCGq2rlY/5o=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39C4jE20024355
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Oct 2023 23:45:14 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Oct 2023 23:45:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Oct 2023 23:45:14 -0500
Received: from [172.24.227.9] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39C4jAHh058287;
        Wed, 11 Oct 2023 23:45:10 -0500
Message-ID: <4e1f574c-6b36-c6e1-9153-90d599e2aaa7@ti.com>
Date:   Thu, 12 Oct 2023 10:15:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
CC:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] PCI: keystone: Don't enable BAR0 if link is not detected
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20231011134629.GA1029324@bhelgaas>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20231011134629.GA1029324@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

Thank you for reviewing the patch.

On 11/10/23 19:16, Bjorn Helgaas wrote:
> Hi Siddharth,
> 
> On Wed, Oct 11, 2023 at 06:04:51PM +0530, Siddharth Vadapalli wrote:
>> Since the function dw_pcie_host_init() ignores the absence of link under
>> the assumption that link can come up later, it is possible that the
>> pci_host_probe(bridge) function is invoked even when no endpoint device
>> is connected. In such a situation, the ks_pcie_v3_65_add_bus() function
>> configures BAR0 when the link is not up, resulting in Completion Timeouts
>> during the MSI configuration performed later by the PCI Express Port driver
>> to setup AER, PME and other services. Thus, leave BAR0 disabled if link is
>> not yet detected when the ks_pcie_v3_65_add_bus() function is invoked.
> 
> I'm trying to make sense of this.  In this path:
> 
>   pci_host_probe
>     pci_scan_root_bus_bridge
>       pci_register_host_bridge
> 	bus = pci_alloc_bus(NULL)    # root bus
> 	bus->ops->add_bus(bus)
> 	  ks_pcie_v3_65_add_bus
> 
> The BAR0 in question must belong to a Root Port.  And it sounds like
> the issue must be related to MSI-X, since the original MSI doesn't
> involve any BARs.

Yes, the issue is related to MSI-X. I will list down the exact set of function
calls below as well as the place where the completion timeout first occurs:
ks_pcie_probe
  dw_pcie_host_init
    pci_host_probe
      pci_bus_add_devices
        pci_bus_add_device
          device_attach
            __device_attach
              bus_for_each_drv
                __device_attach_driver (invoked using fn(drv, data))
                  driver_probe_device
                    __driver_probe_device
                      really_probe
                        pci_device_probe
                          pcie_portdrv_probe
                            pcie_port_device_register
                              pcie_init_service_irqs
                                pcie_port_enable_irq_vec
                                  pci_alloc_irq_vectors
                                    pci_alloc_irq_vectors_affinity
                                      __pci_enable_msix_range
                                        msix_capability_init
                                          msix_setup_interrupts
                                            msix_setup_msi_descs
                                              msix_prepare_msi_desc
In this function: msix_prepare_msi_desc, the following readl() causes completion
timeout:
		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
The completion timeout with the readl is only observed when the link is down (No
Endpoint device is actually connected to the PCIe connector slot).

The symptoms of the above completion timeout show up as a 45 second delay during
boot if no Endpoint device is connected. This 45 second delay is due to the fact
that each readl() which normally takes 4 milliseconds (in presence of Endpoint
device) now take around 40 milliseconds due to waiting for completion. Also, if
I disable Completion Timeout in the PCIe controller, Linux hangs at the readl()
mentioned above. That is the very first readl() causing the completion timeout.

> 
> I don't understand why the Root Port's BAR0 is related to the link
> being up.  MSI-X configuration of the Root Port (presumably using
> BAR0) shouldn't involve any transactions to devices *below* the Root
> Port, and I would expect that BAR to be available (readable and
> writable) regardless of whether the link is up.
> 
> If we skip the BAR0 configuration because the link is down at the time
> of pci_host_probe(), when *do* we do that configuration?  I don't see
> another path to ks_pcie_v3_65_add_bus() for the root bus later.
> 
> Do you know what exactly causes the Completion Timeout?  Is this a
> read to BAR0, or some attempted access to a downstream device, or
> something else?
> 
> Keystone is the only driver that uses .add_bus() for this, so it seems
> a little weird, but maybe this is related to some Keystone-specific
> hardware design.

Yes, I am not fully sure myself why BAR0 being enabled is causing the issue. I
will debug further within the function ks_pcie_v3_65_add_bus() to see which
section of it causes issues when the Link is down. What I am certain of however
is that exiting the ks_pcie_v3_65_add_bus() function if Link is down fixes the
completion timeouts observed above with the readl(), thereby making the 45
second delay vanish during boot when no endpoint device is connected.

Please let me know in case of any suggestions to fix this issue.

> 
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>
>> Hello,
>>
>> This patch is based on linux-next tagged next-20231011.
>>
>> Regards,
>> Siddharth.
>>
>>  drivers/pci/controller/dwc/pci-keystone.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index 49aea6ce3e87..ac2ad112d616 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -459,7 +459,8 @@ static int ks_pcie_v3_65_add_bus(struct pci_bus *bus)
>>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
>>  
>> -	if (!pci_is_root_bus(bus))
>> +	/* Don't enable BAR0 if link is not yet up at this point */
>> +	if (!pci_is_root_bus(bus) || !dw_pcie_link_up(pci))
>>  		return 0;
>>  
>>  	/* Configure and set up BAR0 */
>> -- 
>> 2.34.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Regards,
Siddharth.
