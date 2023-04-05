Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EF76D77F6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 11:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbjDEJYO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 05:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237148AbjDEJYO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 05:24:14 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F8449CE;
        Wed,  5 Apr 2023 02:24:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id C3F2D5823A4;
        Wed,  5 Apr 2023 05:24:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 05 Apr 2023 05:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680686647; x=1680690247; bh=WxqE12iPo4iuJMKHR9c3upfoqJnMRSFiAuV
        XqTKJZlM=; b=Kbpl/NR3BqdZ3LSKWGfqtg56f5ru9FAw1wPBRNpCHiqUxhmHEER
        YL/64IIS4HY9J/5Ad04tmrXUHnkvNWYjxsuZV/SuewSSCOpySFB85JdHjU5nGV/T
        69N3ScAdrPy9M//bzaJ7BRHNJlGgXahx6DVJmTemqmmaZWU/6CbvyBTxf1TAlZ+/
        gIIo23gcuPYlMDVTV3yEoU6iLDxfMO+uYpKCdaWmDXsU6pHJgepWfmakFR+3/Qcr
        53ibHiskzF3VStlPFSGjdMgC3LPAYIr/TqAn6stdgXRGIEBib6diid5rh07Ylacy
        K033kt2qwB5QaZSpL7OFS3In/caUlN9rLDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=i3db14652.fm2;
         t=1680686647; x=1680690247; bh=WxqE12iPo4iuJMKHR9c3upfoqJnMRSFi
        AuVXqTKJZlM=; b=i6Z8lvsTKQSwNDBarIvbZ5JO7De6Q9pLzSmiWOOBtdf+1yQX
        OSG2gtbzAqwqCp4SKZNE7jv1oA5rxIQ4eaRFetYIYATvVInGlwr1+ySDOgCC4ltU
        bVtqclknuDWTKR/LoXbA42ZR5kaWDZx1kLe4GWjS6HxaREpyREw/CyNCGpsTdMmf
        knPet+rAn8hnTHVdZZiVe0w0Sugic5VPeM1QITuD/gFyEyMmKOBJHY5O7KB7kvrj
        RAiUBk81BUyD8qJYvaT7MycHK1QU/zGLUJCrAp4kVtCQyJLlSUEnsukCnvm1oXJR
        eFNS+ed5QAxzvFq/0U6Qqam+0WI42wKTDg4LHA==
X-ME-Sender: <xms:Nj4tZE24w5--hnk8DmD0sU7vETAStNh8vgKWU9NUzZPtApn6TRRxbg>
    <xme:Nj4tZPHC3NLCrL8UbdRmYewNReaI0kuz9FZnUrywScnpftMdKgjuG7Q80iLdffZzf
    dC2UFeWvlIETMfmVi4>
X-ME-Received: <xmr:Nj4tZM7er8rqYNrxfG7f6cXWhCMipxTtYrKD7BSaAbE017Ln-TQZHaIjgbmDXyx2UVm3CA8nqx7iifEIxqikeQ4nxBRcJFB7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeffrghm
    ihgvnhcunfgvucfoohgrlhcuoegulhgvmhhorghlsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepgfevteegtedtueevvdefffevtedvveelffeihfeghfeuveet
    geeuffefhfelffehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegulhgvmhhorghlsehfrghs
    thhmrghilhdrtghomh
X-ME-Proxy: <xmx:Nj4tZN1d2p0yMoa0hq050mDZZ8BuZIFQtULiAQw1A2AXILPp_BJVEg>
    <xmx:Nj4tZHFJTtBCqBik_oY5_W3IbE-dPF8q8s2LJoH3q5DBf9STr_ROVg>
    <xmx:Nj4tZG9nYzr7ej6CoUSmv7woN3pInYJcZa6hrQdKdNso0OQsJHYgkQ>
    <xmx:Nz4tZA39Q7mid2I-Vb9k42xBGIQxQVA5JuloUmC3igKKNpectIGeJoK5AUI>
Feedback-ID: i3db14652:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 05:24:01 -0400 (EDT)
Message-ID: <29a5ccc3-d2c8-b844-a333-28bc20657942@fastmail.com>
Date:   Wed, 5 Apr 2023 18:23:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 00/11] PCI: rockchip: Fix RK3399 PCIe endpoint
 controller driver
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     damien.lemoal@opensource.wdc.com, xxm@rock-chips.com,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Lin Huang <hl@rock-chips.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230404082426.3880812-1-rick.wertenbroek@gmail.com>
From:   Damien Le Moal <dlemoal@fastmail.com>
In-Reply-To: <20230404082426.3880812-1-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/4/23 17:24, Rick Wertenbroek wrote:
> This is a series of patches that fixes the PCIe endpoint controller driver
> for the Rockchip RK3399 SoC. The driver was introduced in commit
> cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
> The original driver had issues and would not allow for the RK3399 to
> operate in PCIe endpoint mode correctly. This patch series fixes that so
> that the PCIe core controller of the RK3399 SoC can now act as a PCIe
> endpoint. This is v3 of the patch series and addresses the concerns that
> were raised during the review of the V2.
> 
> Thank you in advance for reviewing these changes and hopefully
> getting this merged. Having a functional PCIe endpoint controller
> driver for the RK3399 would allow to develop further PCIe endpoint
> functions through the Linux PCIe endpoint framework using this SoC.
> 
> Summary of changes to V2 :
> 
> * Fix issue with memory mapping from PCIe space to physical space
>   There was a small mistake with the number of bits passed from the AXI
>   physical address to the PCIe space address.
> * Disable the advertisement of MSI-X capabilities by the endpoint
>   According to the technical reference manual the controller cannot
>   generate MSI-X, so the controller should not advertise this capability.
> * Add the alignment value to the endpoint attributes.
> * [minor] Clean code (line length, variable names, small refactorings).
>   As pointed out by reviews on the V2.
> * [minor] Fix error in variable name.
> * [minor] Remove a patch that introduced unnecessary late parameter checks.
> 
> General problem statement and overview of the patch series :
> 
> Problem: The Rockchip RK3399 PCIe endpoint controller driver introduced in
> commit cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe
> controller") did not work.
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
> * MSI-X capabilities were advertised but the controller cannot generate
>   them according to the technical reference manual
> 
> The problems have been addressed and validated through tests (see below).
> 
> Summary of patches :
> 
> This patch series is composed of 11 patches that do the following :
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
> * Update the RK3399 example in the documentation to a valid one.
> * Fix legacy IRQ generation for RK3399 PCIe endpoint core, the legacy IRQs
>   were not sent by the device because their generation did not follow the
>   instructions in the technical reference manual. They now work.
> * Fix window mapping and address translation for endpoint. The window
>   mapping and address translation did not follow the technical reference
>   manual and a single memory region was used which resulted in conflicting
>   address translations for memory allocated in that region. The current
>   patch allows to allocate up to 32 memory windows with 1MB pages.
> * Use u32 variable to access 32-bit registers, u16 variables were used to
>   access and manipulate data of 32-bit registers, this would lead to
>   overflows e.g., when left shifting more than 16 bits.
> * Don't advertise MSI-X in PCIe capabilities because according to the TRM
>   the controller is not capable of generating them.
> * Set address alignment for the endpoint mode.
> 
> Validation on real hardware:
> 
> This patch series has been tested by me with kernels 6.0.19, 6.1.21,
> and 5.19 on real hardware, a FriendlyElec NanoPC-T4 RK3399 based single
> computer board connected to a host computer through PCIe x1 and x4. The
> driver was also tested by Damien Le Moal <damien.lemoal@opensource.wdc.com>
> on a Pine Rockpro64 board [1].

I retested this series on top of rc5 with the patched epf-test RC & EP drivers
with a Pine Rockpro64 board. All good, no issues detected.

Feel free to add:

Tested-by: Damien Le Moal <dlemoal@fastmail.com>

> 
> [1] https://lore.kernel.org/linux-pci/20230330085357.2653599-1-damien.lemoal@opensource.wdc.com/
> 
> The PCIe endpoint test function driver was loaded on the SoC and the PCIe
> endpoint test driver was loaded on the host computer. The following tests were
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
> * tested larged transfers e.g., 100kB with and without DMA
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
> I have tested and confirmed all functionality required for the
> endpoint with the test driver and tools. With the initial driver commit
> cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
> the device would not even be enumerated by the host computer (mainly because
> of CRS messages being sent back to the root complex) and tests would not pass
> (driver would not even be loaded because DID was not set correctly)
> and then only the BAR test would pass. Now all tests pass as stated above.
> 
> Best regards
> Rick
> 
> Damien Le Moal (1):
>   PCI: rockchip: Set address alignment for endpoint mode
> 
> Rick Wertenbroek (10):
>   PCI: rockchip: Remove writes to unused registers
>   PCI: rockchip: Write PCI Device ID to correct register
>   PCI: rockchip: Assert PCI Configuration Enable bit after probe
>   PCI: rockchip: Add poll and timeout to wait for PHY PLLs to be locked
>   arm64: dts: rockchip: Add dtsi entry for RK3399 PCIe endpoint core
>   dt-bindings: PCI: Update the RK3399 example to a valid one
>   PCI: rockchip: Fix legacy IRQ generation for RK3399 PCIe endpoint core
>   PCI: rockchip: Fix window mapping and address translation for endpoint
>   PCI: rockchip: Use u32 variable to access 32-bit registers
>   PCI: rockchip: Don't advertise MSI-X in PCIe capabilities
> 
>  .../bindings/pci/rockchip,rk3399-pcie-ep.yaml |   8 +-
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  27 +++
>  drivers/pci/controller/pcie-rockchip-ep.c     | 193 ++++++++----------
>  drivers/pci/controller/pcie-rockchip.c        |  17 ++
>  drivers/pci/controller/pcie-rockchip.h        |  44 ++--
>  5 files changed, 162 insertions(+), 127 deletions(-)
> 

