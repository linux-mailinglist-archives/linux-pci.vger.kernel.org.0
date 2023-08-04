Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2321376FB6F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 09:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjHDHxU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 03:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjHDHxU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 03:53:20 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDEC12B;
        Fri,  4 Aug 2023 00:53:17 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3747r1lR025083;
        Fri, 4 Aug 2023 02:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691135581;
        bh=g8uzit682Uc1QI+ZIByUJ9wM9C2KZ2Ov7ypqL7jWhDo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=lu0gcYjtGILKpXqOOX9XQxvpsDZHSPNix+iZg4DfyGha8TASx6XG4hJoS3G56Cp1y
         AqWXkxlmeloup8mYyNO9CWl3phAi90tz8xcJLEQMI/WeydCPcf/lbq0IN7KRJobQ7n
         Dq5lbA39IaRdtbMI5V9p3bFB6bPZ6vcD8ekSK6ck=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3747r1e7008634
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 02:53:01 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Aug 2023 02:53:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Aug 2023 02:53:01 -0500
Received: from [10.249.129.145] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3747qvLm054544;
        Fri, 4 Aug 2023 02:52:58 -0500
Message-ID: <c95cd3e2-8cc0-cc65-9d62-2edb23adc292@ti.com>
Date:   Fri, 4 Aug 2023 13:22:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXTERNAL] Re: [PATCH] PCI: cadence: Set the AFS bit in Device
 Capabilities 2 Register
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
References: <20230802161953.GA60043@bhelgaas>
From:   "Verma, Achal" <a-verma1@ti.com>
In-Reply-To: <20230802161953.GA60043@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/2/2023 9:49 PM, Bjorn Helgaas wrote:
> In subject, "Advertise ARI Forwarding Supported".
Ok
> 
> It's not obvious that "AFS" refers to ARI Forwarding Supported, and
> the bit name is enough; we don't need to know that it's in Dev Cap 2.
> "Advertise" shows that we're just *advertising* the functionality, not
> *enabling* it.
> 
> On Wed, Aug 02, 2023 at 04:00:59PM +0530, Achal Verma wrote:
>> J7 PCIe Root Complex has ARI Forwarding Support, means supporting
>> forwarding of TLPs addressed to functions with function number greater than
>> 7 but some PCIe instances on J7 have this bit cleared which results in
>> failure of forwarding of TLPs destined for function number > 7.
>> Setting the AFS bit in Device Capabilities 2 Register explicitly, resolves
>> the issue and leads to successful access to function number > 7.
> 
> s/AFS/ARI Forwarding Supported/
> 
>> Some observations:
>> 1. J7200-EVB has single PCIe instance(PCIe1) for which ARIFwd bit is not
>>     set. Enumeration gracefully fails for funciton number greater than 7 but
>>     later read/write access to these funcitons results in a crash.
> 
> By "ARIFwd bit" here, I assume you mean PCI_EXP_DEVCAP2_ARI in the Root
> Port?  Maybe you can use the #define to make this more greppable.
> 
will replace with PCI_EXP_DEVCAP2_ARI
> s/funciton/function/ (twice)
> 
> If we don't enumerate function numbers greater than 7, we shouldn't
> have pci_dev structs for them, so why are there later read/write
> config accesses to them?
> 
> If the Root Port doesn't advertise ARI Forwarding Supported,
> bridge->ari_enabled will not be set, and we shouldn't even try to
> enumerate functions greater than 7.  So it's not that enumeration
> *fails*; it just doesn't happen at all.
> 
>> 2. On J721E-EVB, PCIe1 instance has ARIFwd bit set while it is cleared for
>>     PCIe0 instance. This issue combined with errata i2086
>>     (Unsupported Request (UR) Response Results in External Abort) results in
>>     SERROR while scanning multi-function endpoint device.
> 
> Is the SERROR when scanning under PCIe0 or under PCIe1?
> 
> I'm not clear on what's happening here:
> 
>    1) Root Port advertises PCI_EXP_DEVCAP2_ARI, we set
>       bridge->ari_enabled and scan functions > 7, we do a config read
>       to function 8, get a UR response (as expected during enumeration)
>       and that results in SERROR?
> 
>    2) Root Port *doesn't* advertise PCI_EXP_DEVCAP2_ARI, we don't set
>       bridge->ari_enabled, so we don't try config read to function 8,
>       and something blows up later?
> 
>    3) Something else?
> 
Hello Bjorn,

There are multiple issues which are leading to different behavior on 
different platforms.

1. PCI_EXP_DEVCAP2_ARI is not set.

Consider scenario:
J7200 (RC) --- J721E (EP with 1 PF and 4 VFs)

PF enumerates successfully on J7200 but bringing up 4 associated VFs 
(echo 4 > /sys/bus/pci/devices/<device>/sriov_numvfs) doesn't workout. 
First VF gets devfn = 6 and then +1 for next one on wards. 6 and 7 are 
setup fine but 8 and 9 fails and UR is received while accessing them. 
Accessing VFs > 7 doesn't go through the ARI support check and directly 
calls pci_setup_device(). So, since PCI_EXP_DEVCAP2_ARI is not set, 
unable to access VFs > 7.

do_serror+0x34/0x88
el1_error+0x8c/0x10c
pci_generic_config_read+0x90/0xd0
cdns_ti_pcie_config_read+0x14/0x28
pci_bus_read_config_word+0x78/0xd0
__pci_bus_find_cap_start+0x2c/0x78
pci_find_capability+0x38/0x90
set_pcie_port_type+0x2c/0x150
pci_setup_device+0x90/0x728
pci_iov_add_virtfn+0xe4/0x2e0
sriov_enable+0x1f0/0x440
pci_sriov_configure_simple+0x34/0x80
sriov_numvfs_store+0xa4/0x190


Same issue happens when J7200 RC is replaced by J721E PCIe0 in above 
setup but because of errata i2086 in this case, UR response results in 
SERROR too.

2. PCI_ARI_CAP_NFN field in PCI_ARI_CAP for last function is not set to 
0 which marks current function as last but instead set to current_fn+1, 
which leads to reading of vendor ID for current_fn+1 which doesn't 
exists, giving UR response.

Consider scenario:
J721E(PCIe1 as RC) ----- J721E (EP with 1PF)
PCIe1 has PCI_EXP_DEVCAP2_ARI set , so it reads the PCI_ARI_CAP_NFN 
field of EP to get the next function number, now since at last function 
(PF=0) PCI_ARI_CAP_NFN field is set to 1 and not to 0, RC tries to 
access devfn=1 , which results in UR along with SERROR because of errata 
i2086.
For this I had pushed the workaround
https://lore.kernel.org/all/20230316065455.191785-1-a-verma1@ti.com/

do_serror+0x34/0x88
el1_error+0x8c/0x10c
pci_generic_config_read+0x38/0xd0
cdns_ti_pcie_config_read+0x14/0x28
pci_bus_read_config_dword+0x7c/0xd0
pci_bus_generic_read_dev_vendor_id+0x30/0x1a8
pci_bus_read_dev_vendor_id+0x48/0x68
pci_scan_single_device+0x74/0xf0
pci_scan_slot+0x70/0x118
pci_scan_child_bus_extend+0x50/0x290
pci_scan_bridge_extend+0x294/0x578
pci_scan_child_bus_extend+0x1dc/0x290
pci_scan_root_bus_bridge+0x60/0xd0
pci_host_probe+0x14/0xc0
cdns_pcie_host_setup+0x52c/0x8e0
j721e_pcie_probe+0x48c/0x818
platform_drv_probe+0x50/0xa0


>> @@ -507,6 +507,7 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>   	struct cdns_pcie *pcie;
>>   	struct resource *res;
>>   	int ret;
>> +	u32 pcie_cap2;
>>   
>>   	bridge = pci_host_bridge_from_priv(rc);
>>   	if (!bridge)
>> @@ -536,6 +537,12 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>   	if (rc->quirk_detect_quiet_flag)
>>   		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
>>   
>> +	if (rc->set_afs_bit) {
>> +		pcie_cap2 = cdns_pcie_rp_readl(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_DEVCAP2);
>> +		pcie_cap2 |= PCI_EXP_DEVCAP2_ARI;
>> +		cdns_pcie_rp_writel(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_DEVCAP2, pcie_cap2);
>> +	}
> 
> This seems like a j721e defect; why does the workaround need to be in
> the generic cadence code?

This register setting has to go between 
devm_platform_ioremap_resource_byname(pdev, "reg") and 
cdns_pcie_start_link() which is in pcie-cadence-host.c

And this will be done only if private data field set_afs_bit is true, 
other quirks are also done in similar way.

Regards,
Achal Verma

> 
> Bjorn
