Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40436B8686
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 01:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjCNADE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 20:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjCNADD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 20:03:03 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB4D8B312
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 17:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678752165; x=1710288165;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o1OcbpYDtCn8bpuI1Yx89Ke9JS/q7gUoWBOKl0Pp9qw=;
  b=Om5mvDouQp3VBeoSU6zU0Q3Hpdl72b4dmWJPPHISp9V1OnwLXlUXWt8N
   TqXnLY9A1k1A0aGs0umAbV7aw0M0y6WWhPWpKhdcmIR8ZHWnEW3+7KAZE
   d31z41iPgLqtGyXOsoCTFpGjTh5Vl3kM9+guHRx+oSSaUw5MNDCFZ0kal
   6V57llNq41nuKJI3l4B2aPBY1KsYvTBfPr+E1Ffmgp9ktoXSyNwvOGMen
   yc8lV3UN9rIILXyAkaPoLd4YlfUrgkiES4AvRfyjyY993rZ+5IjLVt32j
   Z9pyBPWlFwqlOoODG+U1pjCQYMvHmrGDKyUgGOWQ+tUaG5sOwxAOflXOF
   A==;
X-IronPort-AV: E=Sophos;i="5.98,258,1673884800"; 
   d="scan'208";a="337564673"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2023 08:02:44 +0800
IronPort-SDR: wpSfo5jy9oP1f9GOcp+2Qw1XQ2wQhooXPR3dUiPUSSRUWn7CdBKjZDnunpb770DPjJC5mFkYrR
 qyp5CgOJWvoKExRs+QE5tr7AXE2X0gcl5/2O1XItJbUsbM4dG4sEF5l6mkf9iwwMhulXTjXioH
 c2F7IXFrCHMF7M8Axj1JwDOPCoAmTA6KzSsC1mMXeKZXKuN6gOZaN2UjM+F0X8/mP8Pkcjorbr
 P/EHWqy3wa/6Bp0CtXrux6bhfXaagrdH/NP1kZARcUiUElZ2RAODPgOFf7JqVR/Oi2gOIpflsK
 MAk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Mar 2023 16:13:31 -0700
IronPort-SDR: lrsDngMJhmX1MvEoXy8Dk0MYiYOA/s8224cB2HXJTqsYX7oIOvS7UOAwuHkGtdClAu48Hk4eYx
 n/K5GYacy5J+Np7+XENwVzPZ8GGVgQoVPhgyAFDOD4/PFYoyUrQq17oopAukj8PuNM0J+IAPR6
 KIfdOtuSM/gZgA1i5mPwRl3vO0gCyeatBGoiG3nWihy8e08dgzTOkWJqFmh/uJGsf2DE+3JYA4
 t2Il7GdbQVkR5/H5ATOlK5jB0T0IRhImGqMGJcjQa5csFqukSZSwOXXnYSTmoIADMzNU52BK22
 v5g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Mar 2023 17:02:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PbDHR2hZSz1RtVq
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 17:02:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678752160; x=1681344161; bh=o1OcbpYDtCn8bpuI1Yx89Ke9JS/q7gUoWBO
        Kl0Pp9qw=; b=olQK+bAXDcDqz4kdXm5a0TP5frVQtRrQX3CHc5JqdErELDtD3Fa
        Bl28tW1BcSZ2gU/VjDAZUuwzSndS8JLeMS7b4AlhvM06bY72LqF7oziZAHg2KGUG
        83lMCnO0NDcpamRP8lBaGrzGDTpW7i8LLABzr3ymq/Mra0NdBIrUO48BG0QWAys6
        ru5tBcv5O8zq3h1hxj4Pr3YvI5t28wHDxNX5STeAN9d+DBOgWFmav1x5io5aLn1p
        DcCdQOeXFS/K8A+ceaY/MejzBrSp1ppJxzoWLjj+MVRhnlMgJ1ofWuOwHTs5gD6d
        Ca6Nm9TCNIIHH+Uodufxi+hbZr0cSo9geMw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HjSkp4o9zYLu for <linux-pci@vger.kernel.org>;
        Mon, 13 Mar 2023 17:02:40 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PbDHK3zdTz1RtVm;
        Mon, 13 Mar 2023 17:02:37 -0700 (PDT)
Message-ID: <ecd09f27-b799-4741-2c5a-a2de99776c51@opensource.wdc.com>
Date:   Tue, 14 Mar 2023 09:02:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/9] PCI: rockchip: Fix RK3399 PCIe endpoint controller
 driver
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/14/23 23:08, Rick Wertenbroek wrote:
> This is a series of patches that fixes the PCIe endpoint controller driver
> for the Rockchip RK3399 SoC. The driver was introduced in
> cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
> The original driver had issues and would not allow for the RK3399 to
> operate in PCIe endpoint mode correctly. This patch series fixes that so
> that the PCIe core controller of the RK3399 SoC can now act as a PCIe
> endpoint. This is v2 of the patch series and addresses the concerns that
> were raised during the review of the first version.

Rick,

Are you going to send a rebased V3 soon ? I have a couple of additional
patches to add on top of your series...


> 
> Thank you in advance for reviewing these changes and hopefully
> getting this merged. Having a functional PCIe endpoint controller
> driver for the RK3399 would allow to develop further PCIe endpoint
> functions through the Linux PCIe endpoint framework using this SoC.
> 
> Problem: The Rockchip RK3399 PCIe endpoint controller driver introduced in
> cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
> did not work.
> 
> Summary of problems with the driver :
> 
> * Missing dtsi entry
> * Could not update Device ID (DID)
> * The endpoint could not be configured by a host computer because the
>   endpoint kept sending Configuration Request Retry Status (CRS) messages
> * The kernel would sometimes hang on probe due to access to registers in
>   a clock domain of which the PLLs were not locked
> * The memory window mapping and address translation mechanism had
>   conflicting mappings and did not follow the technical reference manual
>   as to how the address translation should be done
> * Legacy IRQs were not generated by the endpoint
> * Message Signaled interrupts (MSI) were not generated by the endpoint
> 
> The problems have been addressed and validated through tests (see below).
> 
> Summary of changes :
> 
> This patch series is composed of 9 patches that do the following :
> * Remove writes to unused registers in the PCIe core register space.
>   The registers that were written to is marked "unused" and read
>   only in the technical reference manual of the RK3399 SoC.
> * Write PCI Device ID (DID) to correct register, the DID was written to
>   a read only register and therefore would not update the DID.
> * Assert PCI Configuration Enable bit after probe so that it would stop
>   sending Configuration Request Retry Status (CRS) messages to the
>   host once configured, without this the host would retry until
>   timeout and cancel the PCI configuration.
> * Add poll and timeout to wait for PHY PLLs to be locked, this
>   is the only patch that also applies to the root complex function
>   of the PCIe core controller, without this the kernel would
>   sometimes access registers in the PHY PLL clock domain when the PLLs
>   were not yet locked and the system would hang. This was hackily solved
>   in other non mainline patches (e.g., in armbian) with a "msleep()"
>   that was added after PHY PLL configuration but without realizing
>   why it was needed. A poll with timeout seems like a sane approach.
> * Add dtsi entry for RK3399 PCIe endpoint core. The new entry is
>   in "disabled" status by default, so unless it is explicitly enabled
>   it will not conflict with the PCIe root complex controller entry.
>   Developers that will enable it would know that the root complex function
>   then must be disabled, this can be done in the board level DTS.
> * Fix window mapping and address translation for endpoint. The window
>   mapping and address translation did not follow the technical reference
>   manual and a single memory region was used which resulted in conflicting
>   address translations for memory allocated in that region. The current
>   patch allows to allocate up to 32 memory windows with 1MB pages.
> * Fix legacy IRQ generation for RK3399 PCIe endpoint core, the legacy IRQs
>   were not sent by the device because their generation did not follow the
>   instructions in the technical reference manual. They now work.
> * Use u32 variable to access 32-bit registers, u16 variables were used to
>   access and manipulate data of 32-bit registers, this would lead to
>   overflows e.g., when left shifting more than 16 bits.
> * Add parameter check for RK3399 PCIe endpoint core set_msi(), return
>   -EINVAL when incompatible parameters are passed.
> 
> Validation on real hardware:
> 
> This patch series has been tested with kernel 6.0.19 (and 5.19)
> on real hardware, a FriendlyElec NanoPC-T4 RK3399 based single computer
> board connected to a host computer through PCIe x1 and x4. The PCIe
> endpoint test function driver was loaded on the SoC and the PCIe endpoint
> test driver was loaded on the host computer. The following tests were
> executed through this setup :
> 
> * enumeration of the PCIe endpoint device (lspci)
>   lspci -vvv
> * validation of PCI header and capabilities
>   setpci and lspci -xxxx
> * device was recognized by host computer dans PCIe endpoint test driver
>   was loaded
>   lspci -v states "Kernel modules: pci_endpoint_test"
> * tested the BARs 0-5
>   sudo /usr/bin/pcitest -b 0
>   ...
>   sudo /usr/bin/pcitest -b 5
> * tested legacy interrupt through the test driver
>   sudo /usr/bin/pcitest -i 0
>   sudo /usr/bin/pcitest -l
> * tested MSI interrupt through the test driver
>   sudo /usr/bin/pcitest -i 1
>   sudo /usr/bin/pcitest -m 1
> * tested read/write to and from host through the test driver with checksum
>   sudo /usr/bin/pcitest -r -s 1024
>   sudo /usr/bin/pcitest -w -s 1024
> * tested read/write with DMA enabled (all read/write tests also did IRQ)
>   sudo /usr/bin/pcitest -r -d -s 8192
>   sudo /usr/bin/pcitest -w -d -s 8192
> 
> Commands used on the SoC to launch the endpoint function (configfs) :
> 
> modprobe -i pci-epf-test
> mkdir -p /sys/kernel/config/pci_ep/functions/pci_epf_test/pci_epf_test.0
> echo 0xb500 > /sys/kernel/config/pci_ep/functions/pci_epf_test/pci_epf_test.0/deviceid
> echo 0x104c > /sys/kernel/config/pci_ep/functions/pci_epf_test/pci_epf_test.0/vendorid
> echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/pci_epf_test.0/msi_interrupts 
> ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/pci_epf_test.0 \
> /sys/kernel/config/pci_ep/controllers/fd000000.pcie-ep/
> echo 1 > /sys/kernel/config/pci_ep/controllers/fd000000.pcie-ep/start
> 
> Note: to enable the endpoint controller on the board the file :
> arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
> Was edited to set the status of &pcie0 to "disabled" and &pcie0_ep
> to "okay". This is not submitted as a patch because most users
> will use the PCIe core controller in host (root complex) mode
> rather than endpoint mode.
> 
> I have tested and confirmed all basic functionality required for the
> endpoint with the test driver and tools. With the previous state of
> the driver the device would not even be enumerated by the host
> computer (mainly because of CRS messages being sent back to the root
> complex) and tests would not pass (driver would not even be loaded
> because DID was not set correctly) and then only the BAR test would
> pass. Now all tests pass as stated above.
> 
> Best regards
> Rick
> 
> Rick Wertenbroek (9):
>   PCI: rockchip: Remove writes to unused registers
>   PCI: rockchip: Write PCI Device ID to correct register
>   PCI: rockchip: Assert PCI Configuration Enable bit after probe
>   PCI: rockchip: Add poll and timeout to wait for PHY PLLs to be locked
>   arm64: dts: rockchip: Add dtsi entry for RK3399 PCIe endpoint core
>   PCI: rockchip: Fix window mapping and address translation for endpoint
>   PCI: rockchip: Fix legacy IRQ generation for RK3399 PCIe endpoint core
>   PCI: rockchip: Use u32 variable to access 32-bit registers
>   PCI: rockchip: Add parameter check for RK3399 PCIe endpoint core
>     set_msi()
> 
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi  |  23 ++++
>  drivers/pci/controller/pcie-rockchip-ep.c | 143 ++++++++++------------
>  drivers/pci/controller/pcie-rockchip.c    |  16 +++
>  drivers/pci/controller/pcie-rockchip.h    |  36 ++++--
>  4 files changed, 128 insertions(+), 90 deletions(-)
> 

-- 
Damien Le Moal
Western Digital Research

