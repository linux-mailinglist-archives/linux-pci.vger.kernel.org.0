Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951976B8C4D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 08:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjCNH5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 03:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCNH5r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 03:57:47 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAA921956;
        Tue, 14 Mar 2023 00:57:45 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id bo10so42411oib.11;
        Tue, 14 Mar 2023 00:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678780665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZ2y6YXjBcB55m4IIje1Vq9P9Kr6NH0ONrvz3KiI280=;
        b=V2hfKexvBFLZ9QaLRoUdmqpJhPEIEdtoFk47Ju2FKzGHCXmjfgYV5Ufn+YTH36DazD
         d4/eCtgEKcn8gOQmFQLklS4Wwbl7FJP+G7PttJqgDWT/DOW3rs7HE5dFtqcmFvD+kjcr
         NTi1oH6KAhdKQfrisaHId0gfntWQ1C+u2OWRT47SM8pjmHgLaOJ1KXvyD0/UVHwT1GyX
         nYB7DB/gI3PSqIkACEdHBcGzAdyneeEqOQWhVuINevoWzikTOJbcV4lT4Qh4SfKOqoWr
         sDrwWvmp1AMbq0ivHyt7t+jbb+0LiLn6moX7Ys9ch7n+r8+jbKbPsJ1afjXq7MYJYKcx
         /VeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678780665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZ2y6YXjBcB55m4IIje1Vq9P9Kr6NH0ONrvz3KiI280=;
        b=hipkEK3WHeeci3d8WpqflwMZ1niiah3iLdJqFb+AN56hGfIwikO777qJjKxBYaSjOz
         takYC6fmu/OWotT3lfTf3xwlSTNgThkLJuR2mMBqFNK/hZnkBpJm0CZZpDBaG498PRZf
         5Htr9Sr+aLxxNUBUyCfbw7ShWQ7408fjjHdqK64VxUXY14vWOl14k0101I20+GzlwCE/
         XSCy800f5dICTHKoze7EKFOUBp6HfM3zZJ9aI28OnkqKCaGMM/mIkQyzkgDTRKjAApSh
         Io09kfNLjOsr97wYDk6HMYC/gMwG9fBIIC8Jio3yPqJy9b0lymsS52yg6+mD71ClgDKL
         VHMg==
X-Gm-Message-State: AO0yUKV0gJ9d+62k5aIMpqL6bKf4AfPoZtxEFCxjZF7Ld3PrHwjHPw0v
        UbJVCWtWj9aomwkXSEQfVEpBVJvmvh4Ixw1raC7AztLfteU=
X-Google-Smtp-Source: AK7set/KndxTtDS5zLI4tIowQyl/Own7+YQKUliPxaNxg7G5gqYL2qyxQHcbH2EDUNKCuhrYekqITRvoDx+lGAScKEU=
X-Received: by 2002:a05:6808:2343:b0:384:11ed:a879 with SMTP id
 ef3-20020a056808234300b0038411eda879mr11130031oib.10.1678780664786; Tue, 14
 Mar 2023 00:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com> <ecd09f27-b799-4741-2c5a-a2de99776c51@opensource.wdc.com>
In-Reply-To: <ecd09f27-b799-4741-2c5a-a2de99776c51@opensource.wdc.com>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Tue, 14 Mar 2023 08:57:08 +0100
Message-ID: <CAAEEuhrk4cSC312UiAL3UwoDZ=urrdDcBThcNHd1dqnAuJTzAw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] PCI: rockchip: Fix RK3399 PCIe endpoint controller driver
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 14, 2023 at 1:02=E2=80=AFAM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 2/14/23 23:08, Rick Wertenbroek wrote:
> > This is a series of patches that fixes the PCIe endpoint controller dri=
ver
> > for the Rockchip RK3399 SoC. The driver was introduced in
> > cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controlle=
r")
> > The original driver had issues and would not allow for the RK3399 to
> > operate in PCIe endpoint mode correctly. This patch series fixes that s=
o
> > that the PCIe core controller of the RK3399 SoC can now act as a PCIe
> > endpoint. This is v2 of the patch series and addresses the concerns tha=
t
> > were raised during the review of the first version.
>
> Rick,
>
> Are you going to send a rebased V3 soon ? I have a couple of additional
> patches to add on top of your series...
>

I'll try to send a V3 this week. The changes to V2 will be the issues
raised and discussed on the V2 here in the mailing list with the additional
code for removing the unsupported MSI-X capability list (was discussed
in the mailing list as well).

>
> >
> > Thank you in advance for reviewing these changes and hopefully
> > getting this merged. Having a functional PCIe endpoint controller
> > driver for the RK3399 would allow to develop further PCIe endpoint
> > functions through the Linux PCIe endpoint framework using this SoC.
> >
> > Problem: The Rockchip RK3399 PCIe endpoint controller driver introduced=
 in
> > cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controlle=
r")
> > did not work.
> >
> > Summary of problems with the driver :
> >
> > * Missing dtsi entry
> > * Could not update Device ID (DID)
> > * The endpoint could not be configured by a host computer because the
> >   endpoint kept sending Configuration Request Retry Status (CRS) messag=
es
> > * The kernel would sometimes hang on probe due to access to registers i=
n
> >   a clock domain of which the PLLs were not locked
> > * The memory window mapping and address translation mechanism had
> >   conflicting mappings and did not follow the technical reference manua=
l
> >   as to how the address translation should be done
> > * Legacy IRQs were not generated by the endpoint
> > * Message Signaled interrupts (MSI) were not generated by the endpoint
> >
> > The problems have been addressed and validated through tests (see below=
).
> >
> > Summary of changes :
> >
> > This patch series is composed of 9 patches that do the following :
> > * Remove writes to unused registers in the PCIe core register space.
> >   The registers that were written to is marked "unused" and read
> >   only in the technical reference manual of the RK3399 SoC.
> > * Write PCI Device ID (DID) to correct register, the DID was written to
> >   a read only register and therefore would not update the DID.
> > * Assert PCI Configuration Enable bit after probe so that it would stop
> >   sending Configuration Request Retry Status (CRS) messages to the
> >   host once configured, without this the host would retry until
> >   timeout and cancel the PCI configuration.
> > * Add poll and timeout to wait for PHY PLLs to be locked, this
> >   is the only patch that also applies to the root complex function
> >   of the PCIe core controller, without this the kernel would
> >   sometimes access registers in the PHY PLL clock domain when the PLLs
> >   were not yet locked and the system would hang. This was hackily solve=
d
> >   in other non mainline patches (e.g., in armbian) with a "msleep()"
> >   that was added after PHY PLL configuration but without realizing
> >   why it was needed. A poll with timeout seems like a sane approach.
> > * Add dtsi entry for RK3399 PCIe endpoint core. The new entry is
> >   in "disabled" status by default, so unless it is explicitly enabled
> >   it will not conflict with the PCIe root complex controller entry.
> >   Developers that will enable it would know that the root complex funct=
ion
> >   then must be disabled, this can be done in the board level DTS.
> > * Fix window mapping and address translation for endpoint. The window
> >   mapping and address translation did not follow the technical referenc=
e
> >   manual and a single memory region was used which resulted in conflict=
ing
> >   address translations for memory allocated in that region. The current
> >   patch allows to allocate up to 32 memory windows with 1MB pages.
> > * Fix legacy IRQ generation for RK3399 PCIe endpoint core, the legacy I=
RQs
> >   were not sent by the device because their generation did not follow t=
he
> >   instructions in the technical reference manual. They now work.
> > * Use u32 variable to access 32-bit registers, u16 variables were used =
to
> >   access and manipulate data of 32-bit registers, this would lead to
> >   overflows e.g., when left shifting more than 16 bits.
> > * Add parameter check for RK3399 PCIe endpoint core set_msi(), return
> >   -EINVAL when incompatible parameters are passed.
> >
> > Validation on real hardware:
> >
> > This patch series has been tested with kernel 6.0.19 (and 5.19)
> > on real hardware, a FriendlyElec NanoPC-T4 RK3399 based single computer
> > board connected to a host computer through PCIe x1 and x4. The PCIe
> > endpoint test function driver was loaded on the SoC and the PCIe endpoi=
nt
> > test driver was loaded on the host computer. The following tests were
> > executed through this setup :
> >
> > * enumeration of the PCIe endpoint device (lspci)
> >   lspci -vvv
> > * validation of PCI header and capabilities
> >   setpci and lspci -xxxx
> > * device was recognized by host computer dans PCIe endpoint test driver
> >   was loaded
> >   lspci -v states "Kernel modules: pci_endpoint_test"
> > * tested the BARs 0-5
> >   sudo /usr/bin/pcitest -b 0
> >   ...
> >   sudo /usr/bin/pcitest -b 5
> > * tested legacy interrupt through the test driver
> >   sudo /usr/bin/pcitest -i 0
> >   sudo /usr/bin/pcitest -l
> > * tested MSI interrupt through the test driver
> >   sudo /usr/bin/pcitest -i 1
> >   sudo /usr/bin/pcitest -m 1
> > * tested read/write to and from host through the test driver with check=
sum
> >   sudo /usr/bin/pcitest -r -s 1024
> >   sudo /usr/bin/pcitest -w -s 1024
> > * tested read/write with DMA enabled (all read/write tests also did IRQ=
)
> >   sudo /usr/bin/pcitest -r -d -s 8192
> >   sudo /usr/bin/pcitest -w -d -s 8192
> >
> > Commands used on the SoC to launch the endpoint function (configfs) :
> >
> > modprobe -i pci-epf-test
> > mkdir -p /sys/kernel/config/pci_ep/functions/pci_epf_test/pci_epf_test.=
0
> > echo 0xb500 > /sys/kernel/config/pci_ep/functions/pci_epf_test/pci_epf_=
test.0/deviceid
> > echo 0x104c > /sys/kernel/config/pci_ep/functions/pci_epf_test/pci_epf_=
test.0/vendorid
> > echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/pci_epf_test=
.0/msi_interrupts
> > ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/pci_epf_test.0 \
> > /sys/kernel/config/pci_ep/controllers/fd000000.pcie-ep/
> > echo 1 > /sys/kernel/config/pci_ep/controllers/fd000000.pcie-ep/start
> >
> > Note: to enable the endpoint controller on the board the file :
> > arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
> > Was edited to set the status of &pcie0 to "disabled" and &pcie0_ep
> > to "okay". This is not submitted as a patch because most users
> > will use the PCIe core controller in host (root complex) mode
> > rather than endpoint mode.
> >
> > I have tested and confirmed all basic functionality required for the
> > endpoint with the test driver and tools. With the previous state of
> > the driver the device would not even be enumerated by the host
> > computer (mainly because of CRS messages being sent back to the root
> > complex) and tests would not pass (driver would not even be loaded
> > because DID was not set correctly) and then only the BAR test would
> > pass. Now all tests pass as stated above.
> >
> > Best regards
> > Rick
> >
> > Rick Wertenbroek (9):
> >   PCI: rockchip: Remove writes to unused registers
> >   PCI: rockchip: Write PCI Device ID to correct register
> >   PCI: rockchip: Assert PCI Configuration Enable bit after probe
> >   PCI: rockchip: Add poll and timeout to wait for PHY PLLs to be locked
> >   arm64: dts: rockchip: Add dtsi entry for RK3399 PCIe endpoint core
> >   PCI: rockchip: Fix window mapping and address translation for endpoin=
t
> >   PCI: rockchip: Fix legacy IRQ generation for RK3399 PCIe endpoint cor=
e
> >   PCI: rockchip: Use u32 variable to access 32-bit registers
> >   PCI: rockchip: Add parameter check for RK3399 PCIe endpoint core
> >     set_msi()
> >
> >  arch/arm64/boot/dts/rockchip/rk3399.dtsi  |  23 ++++
> >  drivers/pci/controller/pcie-rockchip-ep.c | 143 ++++++++++------------
> >  drivers/pci/controller/pcie-rockchip.c    |  16 +++
> >  drivers/pci/controller/pcie-rockchip.h    |  36 ++++--
> >  4 files changed, 128 insertions(+), 90 deletions(-)
> >
>
> --
> Damien Le Moal
> Western Digital Research
>
