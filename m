Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F86430592
	for <lists+linux-pci@lfdr.de>; Sun, 17 Oct 2021 01:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241109AbhJPXNc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Oct 2021 19:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241088AbhJPXNb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Oct 2021 19:13:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA66C061765;
        Sat, 16 Oct 2021 16:11:22 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d9so53615347edh.5;
        Sat, 16 Oct 2021 16:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J2JQmNO/WKtM8+yc+B5zMaoSG2Ge3HfYuxG1ybxKCbY=;
        b=S73xNgi2ovvKIZAyguk8jzSPTe942TNgZ173iQoY/803LOKm8p9H1setjGYmgVr8fY
         DplRVfh32KLHgA0ijsSqfi4OOiWE0JdhCUUB1+ItSOiMY9LI0zAggbjBwq1saAUWPPbV
         BSPo9MFocPWwjIU2Ly+TZmIn1KVQ20AeNo/jbjxb/oB/43xSA4iTgkNiA3/EptrY8ImG
         oNbYPcWCZnqW+muj4HE1xyXbnVP3P8aKfRm7VbCwbDXYpn65qtdHqHHvw+u3Ms+BqeYD
         DHplf1EETjN3vTXCxkaW81d/wakBdsjvV+z8T6hpMN0058kjALenbswwwxpHbMHYLN62
         2q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J2JQmNO/WKtM8+yc+B5zMaoSG2Ge3HfYuxG1ybxKCbY=;
        b=3S41MRb3bcWGhIWK8kH3mGfp4HqPmkE9lKPQfaXOS8P9L58pnSbrW1pJrq/jgFxUMc
         y9Fcbhgy2/q1wsoivtfO4Bk90u9j6NVUwqM3D6BLx0OtSGTanLpbRgt0mEyE1YJmWE+q
         BxUi1RINkrnGYJuQj/YdmweeCCLn1vztbqs/PV8ieqBaL9UBRgMWBTxew41kf1htt7h/
         ksxfIuym4n1VDjgtzHp7DdYqzEQVcn3rgEuJjw3PBqv7eLRuHB9Roy9VFoj3fZ7uwuPv
         ceEjI79WVXKRNjyAYBfJWs26yk3YSJE0N4aZ6UBMJl7VzGAYRFTc4jahVgeqKQyfQrmH
         w0Bw==
X-Gm-Message-State: AOAM53319klxapUhw4wu55Ntxy64ZGlvz9HmI5yiOVhSSP2NL6t+2fHV
        R7++OXkurtU2DzqtlQH2cmoi8uqqfQk6Nskk7U9lb+bkN2U=
X-Google-Smtp-Source: ABdhPJzZw6jcdrltDGnTU903o00+0XGgXoiWrlaHGPmaQNCmN9FkTgRUf2ONdqTsKFI/hJNMrMxgqGOs9Dmew5icmCM=
X-Received: by 2002:a17:906:94da:: with SMTP id d26mr18272941ejy.213.1634425881189;
 Sat, 16 Oct 2021 16:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210825102636.52757-1-21cnbao@gmail.com>
In-Reply-To: <20210825102636.52757-1-21cnbao@gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 16 Oct 2021 23:11:07 +1300
Message-ID: <CAGsJ_4y6gXDbO9XxbWeKwYcUViTR-dGquH3u-nBa98nWTNHJ5w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] PCI/MSI: Clarify the IRQ sysfs ABI for PCI devices
To:     Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, bilbao@vt.edu,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        leon@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Linuxarm <linuxarm@huawei.com>,
        luzmaximilian@gmail.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        schnelle@linux.ibm.com,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Barry Song <song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 25, 2021 at 10:26 PM Barry Song <21cnbao@gmail.com> wrote:
>
> From: Barry Song <song.bao.hua@hisilicon.com>
>
>
> /sys/bus/pci/devices/.../irq has been there for many years but it has never
> been documented. This patchset is trying to clarify it.
>
> -v3:
>   - Don't attempt to modify the current behaviour of IRQ ABI for MSI-X
>   - Make MSI IRQ ABI more explicit(return 1st IRQ of the IRQ vector)
>   - Add Marc's patch of removing default_irq from the previous comment to
>     the series.
>   Note patch 3/3 indirectly changed the code of pci_restore_msi_state(),
>   drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c is the only driver
>   calling this API. I would appreciate testing done from this driver's
>   maintainers.
>
> -v2:
>   - split into two patches according to Bjorn's comments;
>   - Add Greg's Acked-by, thanks for reviewing!
>   https://lore.kernel.org/lkml/20210820223744.8439-1-21cnbao@gmail.com/
>
> -v1:
>   https://lore.kernel.org/lkml/20210813122650.25764-1-21cnbao@gmail.com/#t
>
> Barry Song (2):
>   Documentation: ABI: sysfs-bus-pci: Add description for IRQ entry

Hi Marc, Bjorn,
I found there are more than 700 drivers which are directly accessing
pci_dev->irq.
Do you want to just take the documentation patch 1/3 as anyway we need the ABI
document, or do you want to continue changing all of the 700 drivers to use
pci_irq_vector(pdev, 0) instead?

the list of involved drivers:
./sound/pci/als300.c
./sound/pci/ymfpci/ymfpci_main.c
./sound/pci/ymfpci/ymfpci.c
./sound/pci/aw2/aw2-alsa.c
./sound/pci/trident/trident_main.c
./sound/pci/trident/trident.c
./sound/pci/fm801.c
./sound/pci/lola/lola.c
./sound/pci/ali5451/ali5451.c
./sound/pci/es1938.c
./sound/pci/lx6464es/lx6464es.c
./sound/pci/mixart/mixart.c
./sound/pci/au88x0/au88x0.c
./sound/pci/ad1889.c
./sound/pci/als4000.c
./sound/pci/cmipci.c
./sound/pci/sis7019.c
./sound/pci/ca0106/ca0106_main.c
./sound/pci/ctxfi/cthw20k2.c
./sound/pci/ctxfi/cthw20k1.c
./sound/pci/via82xx_modem.c
./sound/pci/ice1712/ice1712.c
./sound/pci/ice1712/ice1724.c
./sound/pci/pcxhr/pcxhr.c
./sound/pci/maestro3.c
./sound/pci/rme32.c
./sound/pci/sonicvibes.c
./sound/pci/via82xx.c
./sound/pci/intel8x0.c
./sound/pci/riptide/riptide.c
./sound/pci/cs46xx/cs46xx.c
./sound/pci/cs46xx/cs46xx_lib.c
./sound/pci/atiixp_modem.c
./sound/pci/korg1212/korg1212.c
./sound/pci/atiixp.c
./sound/pci/es1968.c
./sound/pci/hda/hda_intel.c
./sound/pci/intel8x0m.c
./sound/pci/rme96.c
./sound/pci/emu10k1/emu10k1.c
./sound/pci/emu10k1/emu10k1_main.c
./sound/pci/emu10k1/emu10k1x.c
./sound/pci/oxygen/oxygen_lib.c
./sound/pci/rme9652/hdsp.c
./sound/pci/rme9652/hdspm.c
./sound/pci/rme9652/rme9652.c
./sound/pci/cs5535audio/cs5535audio.c
./sound/pci/cs4281.c
./sound/pci/nm256/nm256.c
./sound/pci/bt87x.c
./sound/pci/asihpi/hpi6205.c
./sound/pci/asihpi/hpioctl.c
./sound/pci/ens1370.c
./sound/pci/azt3328.c
./sound/pci/echoaudio/echoaudio.c
./sound/pci/vx222/vx222.c
./sound/soc/intel/atom/sst/sst_pci.c
./sound/soc/intel/skylake/skl.c
./sound/soc/sof/intel/hda.c
./sound/soc/sof/intel/pci-tng.c
./sound/soc/sof/intel/hda-dsp.c
./sound/soc/amd/renoir/rn-pci-acp3x.c
./sound/soc/amd/vangogh/pci-acp5x.c
./sound/soc/amd/raven/pci-acp3x.c
./sound/ppc/pmac.c
./arch/ia64/kernel/msi_ia64.c
./arch/x86/pci/intel_mid_pci.c
./arch/x86/pci/fixup.c
./arch/x86/pci/xen.c
./arch/x86/pci/irq.c
./arch/x86/platform/intel-mid/pwr.c
./arch/x86/hyperv/irqdomain.c
./arch/x86/kernel/devicetree.c
./arch/x86/kernel/apic/msi.c
./arch/arm/mach-footbridge/cats-pci.c
./arch/arm/mach-cns3xxx/pcie.c
./arch/s390/pci/pci_irq.c
./arch/microblaze/pci/pci-common.c
./arch/um/drivers/virt-pci.c
./arch/sparc/kernel/leon_pci_grpci1.c
./arch/sparc/kernel/leon_pci_grpci2.c
./arch/sparc/kernel/pci.c
./arch/sparc/kernel/pcic.c
./arch/alpha/kernel/core_marvel.c
./arch/alpha/kernel/sys_jensen.c
./arch/alpha/kernel/sys_dp264.c
./arch/alpha/kernel/sys_sable.c
./arch/alpha/kernel/sys_titan.c
./arch/alpha/kernel/sys_marvel.c
./arch/alpha/kernel/sys_takara.c
./arch/alpha/kernel/sys_cabriolet.c
./arch/alpha/kernel/sys_rawhide.c
./arch/alpha/kernel/sys_rx164.c
./arch/alpha/kernel/sys_noritake.c
./arch/alpha/kernel/sys_wildfire.c
./arch/alpha/kernel/sys_sio.c
./arch/alpha/kernel/sys_alcor.c
./arch/alpha/kernel/sys_eiger.c
./arch/alpha/kernel/sys_mikasa.c
./arch/alpha/kernel/sys_eb64p.c
./arch/powerpc/platforms/embedded6xx/mvme5100.c
./arch/powerpc/platforms/maple/pci.c
./arch/powerpc/platforms/cell/axon_msi.c
./arch/powerpc/platforms/4xx/msi.c
./arch/powerpc/platforms/4xx/hsta_msi.c
./arch/powerpc/platforms/fsl_uli1575.c
./arch/powerpc/platforms/powermac/pci.c
./arch/powerpc/platforms/pasemi/msi.c
./arch/powerpc/platforms/pasemi/dma_lib.c
./arch/powerpc/platforms/pasemi/setup.c
./arch/powerpc/platforms/44x/ppc476.c
./arch/powerpc/platforms/85xx/mpc85xx_cds.c
./arch/powerpc/platforms/powernv/pci-ioda.c
./arch/powerpc/platforms/pseries/msi.c
./arch/powerpc/platforms/pseries/setup.c
./arch/powerpc/platforms/chrp/pci.c
./arch/powerpc/sysdev/mpic_u3msi.c
./arch/powerpc/sysdev/fsl_msi.c
./arch/powerpc/kernel/pci-common.c
./arch/powerpc/kernel/legacy_serial.c
./arch/powerpc/kernel/eeh_driver.c
./arch/powerpc/kernel/pci_of_scan.c
./arch/mips/pci/pci-bcm47xx.c
./arch/mips/pci/pci-ar2315.c
./arch/mips/pci/pci-sb1250.c
./arch/mips/pci/msi-octeon.c
./arch/mips/pci/pci-rt3883.c
./arch/mips/pci/msi-xlp.c
./arch/mips/pci/pci-xlr.c
./arch/mips/pci/fixup-lemote2f.c
./arch/mips/pci/pci-mt7620.c
./arch/mips/loongson64/hpet.c
./arch/mips/netlogic/xlp/usb-init.c
./arch/mips/netlogic/xlp/ahci-init-xlp2.c
./arch/mips/netlogic/xlp/ahci-init.c
./arch/mips/netlogic/xlp/usb-init-xlp2.c
./drivers/uio/uio_sercos3.c
./drivers/uio/uio_netx.c
./drivers/uio/uio_aec.c
./drivers/uio/uio_mf624.c
./drivers/uio/uio_cif.c
./drivers/uio/uio_pci_generic.c
./drivers/ntb/test/ntb_msi_test.c
./drivers/ntb/hw/intel/ntb_hw_gen1.c
./drivers/ntb/hw/amd/ntb_hw_amd.c
./drivers/bus/mhi/pci_generic.c
./drivers/net/fddi/defxx.c
./drivers/net/fddi/skfp/skfddi.c
./drivers/net/vmxnet3/vmxnet3_drv.c
./drivers/net/wwan/iosm/iosm_ipc_irq.c
./drivers/net/wwan/iosm/iosm_ipc_imem.c
./drivers/net/hippi/rrunner.c
./drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
./drivers/net/ethernet/chelsio/cxgb/cxgb2.c
./drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
./drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
./drivers/net/ethernet/8390/ne2k-pci.c
./drivers/net/ethernet/ti/tlan.c
./drivers/net/ethernet/silan/sc92031.c
./drivers/net/ethernet/jme.c
./drivers/net/ethernet/neterion/vxge/vxge-main.c
./drivers/net/ethernet/neterion/s2io.c
./drivers/net/ethernet/mellanox/mlx4/main.c
./drivers/net/ethernet/sun/niu.c
./drivers/net/ethernet/sun/sungem.c
./drivers/net/ethernet/sun/cassini.c
./drivers/net/ethernet/sun/sunhme.c
./drivers/net/ethernet/toshiba/tc35815.c
./drivers/net/ethernet/toshiba/spider_net.c
./drivers/net/ethernet/atheros/atl1e/atl1e_main.c
./drivers/net/ethernet/atheros/atl1c/atl1c_main.c
./drivers/net/ethernet/atheros/alx/main.c
./drivers/net/ethernet/atheros/atlx/atl2.c
./drivers/net/ethernet/atheros/atlx/atl1.c
./drivers/net/ethernet/microsoft/mana/gdma_main.c
./drivers/net/ethernet/emulex/benet/be_main.c
./drivers/net/ethernet/tehuti/tehuti.c
./drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
./drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
./drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
./drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
./drivers/net/ethernet/netronome/nfp/nfp_net_common.c
./drivers/net/ethernet/brocade/bna/bnad.c
./drivers/net/ethernet/microchip/lan743x_main.c
./drivers/net/ethernet/dlink/sundance.c
./drivers/net/ethernet/dlink/dl2k.c
./drivers/net/ethernet/sgi/ioc3-eth.c
./drivers/net/ethernet/broadcom/bnxt/bnxt.c
./drivers/net/ethernet/broadcom/b44.c
./drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
./drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
./drivers/net/ethernet/broadcom/cnic.c
./drivers/net/ethernet/broadcom/bnx2.c
./drivers/net/ethernet/broadcom/tg3.c
./drivers/net/ethernet/marvell/skge.c
./drivers/net/ethernet/marvell/sky2.c
./drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
./drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
./drivers/net/ethernet/marvell/octeontx2/af/rvu.c
./drivers/net/ethernet/marvell/octeontx2/af/cgx.c
./drivers/net/ethernet/intel/igbvf/netdev.c
./drivers/net/ethernet/intel/e1000/e1000_ethtool.c
./drivers/net/ethernet/intel/e1000/e1000_main.c
./drivers/net/ethernet/intel/igc/igc_main.c
./drivers/net/ethernet/intel/i40e/i40e_main.c
./drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
./drivers/net/ethernet/intel/igb/igb_main.c
./drivers/net/ethernet/intel/ixgb/ixgb_main.c
./drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
./drivers/net/ethernet/intel/ice/ice_main.c
./drivers/net/ethernet/intel/e100.c
./drivers/net/ethernet/intel/e1000e/ethtool.c
./drivers/net/ethernet/intel/e1000e/netdev.c
./drivers/net/ethernet/sfc/efx_channels.c
./drivers/net/ethernet/sfc/nic.c
./drivers/net/ethernet/sfc/ef100_netdev.c
./drivers/net/ethernet/sfc/farch.c
./drivers/net/ethernet/sfc/efx.c
./drivers/net/ethernet/sfc/ptp.c
./drivers/net/ethernet/sfc/falcon/falcon.c
./drivers/net/ethernet/sfc/falcon/nic.c
./drivers/net/ethernet/sfc/falcon/farch.c
./drivers/net/ethernet/sfc/falcon/efx.c
./drivers/net/ethernet/sfc/ef10.c
./drivers/net/ethernet/sfc/ef100_nic.c
./drivers/net/ethernet/sfc/siena.c
./drivers/net/ethernet/huawei/hinic/hinic_rx.c
./drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c
./drivers/net/ethernet/huawei/hinic/hinic_tx.c
./drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c
./drivers/net/ethernet/synopsys/dwc-xlgmac-pci.c
./drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
./drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
./drivers/net/ethernet/qlogic/qed/qed_main.c
./drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
./drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c
./drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
./drivers/net/ethernet/qlogic/qla3xxx.c
./drivers/net/ethernet/qlogic/qede/qede_main.c
./drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
./drivers/net/ethernet/cisco/enic/enic_main.c
./drivers/net/ethernet/dec/tulip/tulip_core.c
./drivers/net/ethernet/dec/tulip/xircom_cb.c
./drivers/net/ethernet/dec/tulip/dmfe.c
./drivers/net/ethernet/dec/tulip/winbond-840.c
./drivers/net/ethernet/dec/tulip/uli526x.c
./drivers/net/ethernet/dec/tulip/de2104x.c
./drivers/net/ethernet/dec/tulip/de4x5.c
./drivers/net/ethernet/alacritech/slicoss.c
./drivers/net/ethernet/agere/et131x.c
./drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
./drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
./drivers/net/ethernet/cavium/liquidio/lio_main.c
./drivers/net/ethernet/cavium/liquidio/lio_core.c
./drivers/net/ethernet/cavium/thunder/nic_main.c
./drivers/net/ethernet/cavium/thunder/nicvf_main.c
./drivers/net/ethernet/micrel/ksz884x.c
./drivers/net/ethernet/realtek/8139cp.c
./drivers/net/ethernet/realtek/r8169_main.c
./drivers/net/ethernet/realtek/8139too.c
./drivers/net/ethernet/adaptec/starfire.c
./drivers/net/ethernet/3com/typhoon.c
./drivers/net/ethernet/3com/3c59x.c
./drivers/net/ethernet/via/via-rhine.c
./drivers/net/ethernet/via/via-velocity.c
./drivers/net/ethernet/smsc/epic100.c
./drivers/net/ethernet/smsc/smsc9420.c
./drivers/net/ethernet/natsemi/ns83820.c
./drivers/net/ethernet/natsemi/natsemi.c
./drivers/net/ethernet/sis/sis900.c
./drivers/net/ethernet/sis/sis190.c
./drivers/net/ethernet/rdc/r6040.c
./drivers/net/ethernet/myricom/myri10ge/myri10ge.c
./drivers/net/ethernet/fealnx.c
./drivers/net/ethernet/nvidia/forcedeth.c
./drivers/net/ethernet/alteon/acenic.c
./drivers/net/ethernet/packetengines/yellowfin.c
./drivers/net/ethernet/packetengines/hamachi.c
./drivers/net/ethernet/freescale/enetc/enetc_ptp.c
./drivers/net/ethernet/amazon/ena/ena_netdev.c
./drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
./drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
./drivers/net/ethernet/amd/xgbe/xgbe-pci.c
./drivers/net/ethernet/amd/amd8111e.c
./drivers/net/ethernet/amd/pcnet32.c
./drivers/net/dsa/ocelot/felix_vsc9959.c
./drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
./drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
./drivers/net/wireless/intersil/orinoco/orinoco_pci.c
./drivers/net/wireless/intersil/orinoco/orinoco_tmd.c
./drivers/net/wireless/intersil/orinoco/orinoco_nortel.c
./drivers/net/wireless/intersil/orinoco/orinoco_plx.c
./drivers/net/wireless/intersil/hostap/hostap_pci.c
./drivers/net/wireless/intersil/hostap/hostap_plx.c
./drivers/net/wireless/intersil/p54/p54pci.c
./drivers/net/wireless/broadcom/b43legacy/main.c
./drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
./drivers/net/wireless/broadcom/b43/main.c
./drivers/net/wireless/marvell/mwl8k.c
./drivers/net/wireless/marvell/mwifiex/pcie.c
./drivers/net/wireless/intel/ipw2x00/ipw2200.c
./drivers/net/wireless/intel/ipw2x00/ipw2100.c
./drivers/net/wireless/intel/iwlegacy/4965-mac.c
./drivers/net/wireless/intel/iwlegacy/common.c
./drivers/net/wireless/intel/iwlegacy/3945-mac.c
./drivers/net/wireless/intel/iwlwifi/pcie/trans.c
./drivers/net/wireless/atmel/atmel_pci.c
./drivers/net/wireless/mediatek/mt76/mt7603/pci.c
./drivers/net/wireless/mediatek/mt76/mt7615/pci.c
./drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
./drivers/net/wireless/mediatek/mt76/mt7921/pci.c
./drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
./drivers/net/wireless/mediatek/mt76/mt7915/pci.c
./drivers/net/wireless/cisco/airo.c
./drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
./drivers/net/wireless/realtek/rtw88/pci.c
./drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
./drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
./drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
./drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c
./drivers/net/wireless/realtek/rtlwifi/pci.c
./drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
./drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
./drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
./drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c
./drivers/net/wireless/ath/ath5k/pci.c
./drivers/net/wireless/ath/ath11k/pci.c
./drivers/net/wireless/ath/wil6210/pcie_bus.c
./drivers/net/wireless/ath/ath9k/pci.c
./drivers/net/wireless/ath/ath10k/pci.c
./drivers/net/wireless/ralink/rt2x00/rt2x00pci.c
./drivers/net/wireless/ralink/rt2x00/rt2400pci.c
./drivers/net/wireless/ralink/rt2x00/rt61pci.c
./drivers/net/wireless/ralink/rt2x00/rt2500pci.c
./drivers/net/wireless/admtek/adm8211.c
./drivers/net/arcnet/com20020-pci.c
./drivers/net/wan/wanxl.c
./drivers/net/wan/lmc/lmc_main.c
./drivers/net/wan/farsync.c
./drivers/net/wan/pci200syn.c
./drivers/net/wan/pc300too.c
./drivers/net/can/c_can/c_can_pci.c
./drivers/net/can/kvaser_pciefd.c
./drivers/net/can/pch_can.c
./drivers/net/can/m_can/m_can_pci.c
./drivers/net/can/sja1000/f81601.c
./drivers/net/can/sja1000/ems_pci.c
./drivers/net/can/sja1000/peak_pci.c
./drivers/net/can/sja1000/plx_pci.c
./drivers/net/can/sja1000/kvaser_pci.c
./drivers/net/can/peak_canfd/peak_pciefd_main.c
./drivers/pnp/resource.c
./drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
./drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
./drivers/media/pci/smipcie/smipcie-main.c
./drivers/media/pci/mantis/mantis_pci.c
./drivers/media/pci/mantis/hopper_cards.c
./drivers/media/pci/mantis/mantis_cards.c
./drivers/media/pci/cx25821/cx25821-core.c
./drivers/media/pci/cx25821/cx25821-alsa.c
./drivers/media/pci/sta2x11/sta2x11_vip.c
./drivers/media/pci/saa7164/saa7164-core.c
./drivers/media/pci/cobalt/cobalt-v4l2.c
./drivers/media/pci/cobalt/cobalt-driver.c
./drivers/media/pci/tw5864/tw5864-core.c
./drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
./drivers/media/pci/cx23885/cx23885-core.c
./drivers/media/pci/saa7134/saa7134-alsa.c
./drivers/media/pci/saa7134/saa7134-core.c
./drivers/media/pci/tw686x/tw686x-core.c
./drivers/media/pci/solo6x10/solo6x10-core.c
./drivers/media/pci/ngene/ngene-core.c
./drivers/media/pci/cx88/cx88-mpeg.c
./drivers/media/pci/cx88/cx88-alsa.c
./drivers/media/pci/cx88/cx88-video.c
./drivers/media/pci/dt3155/dt3155.c
./drivers/media/pci/ddbridge/ddbridge-core.c
./drivers/media/pci/dm1105/dm1105.c
./drivers/media/pci/b2c2/flexcop-pci.c
./drivers/media/pci/netup_unidvb/netup_unidvb_core.c
./drivers/media/pci/tw68/tw68-core.c
./drivers/media/pci/pluto2/pluto2.c
./drivers/media/pci/ivtv/ivtv-driver.c
./drivers/media/pci/meye/meye.c
./drivers/media/pci/bt8xx/dvb-bt8xx.c
./drivers/media/pci/bt8xx/bttv-driver.c
./drivers/media/pci/bt8xx/bt878.c
./drivers/media/pci/cx18/cx18-driver.c
./drivers/media/platform/marvell-ccic/cafe-driver.c
./drivers/media/common/saa7146/saa7146_core.c
./drivers/comedi/comedi_pci.c
./drivers/comedi/drivers/ni_pcimio.c
./drivers/comedi/drivers/amplc_dio200_pci.c
./drivers/comedi/drivers/rtd520.c
./drivers/comedi/drivers/gsc_hpdi.c
./drivers/comedi/drivers/ni_labpc_pci.c
./drivers/comedi/drivers/amplc_pci236.c
./drivers/comedi/drivers/me4000.c
./drivers/comedi/drivers/addi_apci_1500.c
./drivers/comedi/drivers/adl_pci9111.c
./drivers/comedi/drivers/ni_660x.c
./drivers/comedi/drivers/cb_pcidas.c
./drivers/comedi/drivers/adl_pci7x3x.c
./drivers/comedi/drivers/addi_apci_3xxx.c
./drivers/comedi/drivers/adl_pci9118.c
./drivers/comedi/drivers/addi_apci_1564.c
./drivers/comedi/drivers/ni_6527.c
./drivers/comedi/drivers/cb_pcidas64.c
./drivers/comedi/drivers/ni_65xx.c
./drivers/comedi/drivers/addi_apci_3120.c
./drivers/comedi/drivers/s626.c
./drivers/comedi/drivers/ni_pcidio.c
./drivers/comedi/drivers/adv_pci1710.c
./drivers/comedi/drivers/dt3000.c
./drivers/comedi/drivers/adv_pci_dio.c
./drivers/comedi/drivers/amplc_pci230.c
./drivers/comedi/drivers/addi_apci_1032.c
./drivers/comedi/drivers/addi_apci_2032.c
./drivers/comedi/drivers/amplc_pci224.c
./drivers/pci/quirks.c
./drivers/pci/controller/pci-hyperv.c
./drivers/pci/controller/pcie-mediatek.c
./drivers/pci/controller/vmd.c
./drivers/pci/controller/pci-tegra.c
./drivers/pci/controller/cadence/pcie-cadence-ep.c
./drivers/pci/controller/dwc/pcie-tegra194.c
./drivers/pci/controller/dwc/pcie-spear13xx.c
./drivers/pci/controller/dwc/pci-keystone.c
./drivers/pci/msi.c
./drivers/pci/proc.c
./drivers/pci/xen-pcifront.c
./drivers/pci/probe.c
./drivers/pci/hotplug/pnv_php.c
./drivers/pci/hotplug/ibmphp_core.c
./drivers/pci/hotplug/ibmphp_pci.c
./drivers/pci/hotplug/cpci_hotplug_core.c
./drivers/pci/hotplug/ibmphp_ebda.c
./drivers/pci/hotplug/pciehp_hpc.c
./drivers/pci/hotplug/shpchp_hpc.c
./drivers/pci/hotplug/cpqphp_core.c
./drivers/pci/hotplug/cpcihp_zt5550.c
./drivers/pci/hotplug/cpqphp_ctrl.c
./drivers/pci/pcie/aer_inject.c
./drivers/pci/pcie/aer.c
./drivers/pci/pcie/dpc.c
./drivers/pci/pcie/portdrv_core.c
./drivers/pci/pcie/pme.c
./drivers/pci/setup-irq.c
./drivers/infiniband/hw/mthca/mthca_main.c
./drivers/infiniband/hw/efa/efa_main.c
./drivers/infiniband/hw/hfi1/chip.c
./drivers/infiniband/hw/hfi1/init.c
./drivers/infiniband/hw/hfi1/affinity.c
./drivers/infiniband/hw/ocrdma/ocrdma_hw.c
./drivers/infiniband/hw/hns/hns_roce_qp.c
./drivers/infiniband/hw/hns/hns_roce_hw_v2.c
./drivers/iommu/apple-dart.c
./drivers/iommu/arm/arm-smmu/arm-smmu.c
./drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
./drivers/iommu/intel/dmar.c
./drivers/iommu/intel/irq_remapping.c
./drivers/iommu/amd/iommu.c
./drivers/iommu/amd/init.c
./drivers/dma/hsu/pci.c
./drivers/dma/idxd/device.c
./drivers/dma/idxd/init.c
./drivers/dma/ioat/init.c
./drivers/dma/ioat/dma.c
./drivers/dma/dw/pci.c
./drivers/dma/dw-edma/dw-edma-pcie.c
./drivers/dma/pch_dma.c
./drivers/mmc/host/sdhci-pci-gli.c
./drivers/mmc/host/sdhci-pci-o2micro.c
./drivers/mmc/host/dw_mmc-pci.c
./drivers/mmc/host/sdhci-pci-core.c
./drivers/mmc/host/cavium-thunderx.c
./drivers/mmc/host/via-sdmmc.c
./drivers/mmc/host/toshsd.c
./drivers/mmc/host/cb710-mmc.c
./drivers/mmc/host/sdhci-acpi.c
./drivers/acpi/apei/ghes.c
./drivers/acpi/pci_irq.c
./drivers/ssb/main.c
./drivers/ssb/driver_gige.c
./drivers/ssb/driver_pcicore.c
./drivers/thunderbolt/nhi.c
./drivers/tty/serial/icom.c
./drivers/tty/serial/8250/8250_mid.c
./drivers/tty/serial/8250/8250_pci.c
./drivers/tty/serial/8250/8250_lpss.c
./drivers/tty/serial/jsm/jsm_tty.c
./drivers/tty/serial/jsm/jsm_driver.c
./drivers/tty/serial/pch_uart.c
./drivers/tty/serial/serial_txx9.c
./drivers/tty/serial/rp2.c
./drivers/tty/mxser.c
./drivers/tty/nozomi.c
./drivers/tty/synclink_gt.c
./drivers/crypto/hifn_795x.c
./drivers/crypto/qat/qat_common/adf_transport.c
./drivers/crypto/qat/qat_common/adf_vf_isr.c
./drivers/crypto/ccp/sp-pci.c
./drivers/usb/isp1760/isp1760-if.c
./drivers/usb/cdns3/cdns3-pci-wrap.c
./drivers/usb/cdns3/cdnsp-pci.c
./drivers/usb/host/xhci-pci.c
./drivers/usb/host/uhci-pci.c
./drivers/usb/host/xhci.c
./drivers/usb/chipidea/ci_hdrc_pci.c
./drivers/usb/dwc2/pci.c
./drivers/usb/gadget/udc/net2272.c
./drivers/usb/gadget/udc/pch_udc.c
./drivers/usb/gadget/udc/net2280.c
./drivers/usb/gadget/udc/goku_udc.c
./drivers/usb/gadget/udc/amd5536udc_pci.c
./drivers/usb/dwc3/dwc3-haps.c
./drivers/usb/dwc3/dwc3-pci.c
./drivers/usb/core/hcd-pci.c
./drivers/ata/pata_sil680.c
./drivers/ata/sata_promise.c
./drivers/ata/pata_atp867x.c
./drivers/ata/ahci.c
./drivers/ata/sata_svw.c
./drivers/ata/acard-ahci.c
./drivers/ata/sata_mv.c
./drivers/ata/libata-sff.c
./drivers/ata/sata_uli.c
./drivers/ata/pata_macio.c
./drivers/ata/pata_legacy.c
./drivers/ata/pdc_adma.c
./drivers/ata/pata_ninja32.c
./drivers/ata/sata_sil24.c
./drivers/ata/sata_sil.c
./drivers/ata/sata_inic162x.c
./drivers/ata/pata_hpt3x3.c
./drivers/ata/pata_pdc2027x.c
./drivers/ata/sata_nv.c
./drivers/ata/sata_sx4.c
./drivers/ata/sata_sis.c
./drivers/ata/sata_qstor.c
./drivers/ata/sata_via.c
./drivers/ata/sata_vsc.c
./drivers/scsi/megaraid/megaraid_sas_base.c
./drivers/scsi/megaraid/megaraid_mm.c
./drivers/scsi/megaraid/megaraid_mbox.c
./drivers/scsi/megaraid/megaraid_sas_fusion.c
./drivers/scsi/megaraid.c
./drivers/scsi/dpt_i2o.c
./drivers/scsi/initio.c
./drivers/scsi/pm8001/pm8001_init.c
./drivers/scsi/wd719x.c
./drivers/scsi/ufs/ufshcd-pci.c
./drivers/scsi/ufs/tc-dwc-g210-pci.c
./drivers/scsi/am53c974.c
./drivers/scsi/nsp32.c
./drivers/scsi/mvumi.c
./drivers/scsi/be2iscsi/be_main.c
./drivers/scsi/fdomain_pci.c
./drivers/scsi/cxlflash/ocxl_hw.c
./drivers/scsi/cxlflash/main.c
./drivers/scsi/smartpqi/smartpqi_init.c
./drivers/scsi/lpfc/lpfc_sli.c
./drivers/scsi/lpfc/lpfc_init.c
./drivers/scsi/lpfc/lpfc_scsi.c
./drivers/scsi/lpfc/lpfc_attr.c
./drivers/scsi/a100u2w.c
./drivers/scsi/mvsas/mv_init.c
./drivers/scsi/3w-xxxx.c
./drivers/scsi/stex.c
./drivers/scsi/dmx3191d.c
./drivers/scsi/mpt3sas/mpt3sas_base.c
./drivers/scsi/esas2r/esas2r_main.c
./drivers/scsi/esas2r/esas2r_ioctl.c
./drivers/scsi/esas2r/esas2r_init.c
./drivers/scsi/hptiop.c
./drivers/scsi/bfa/bfad.c
./drivers/scsi/qla2xxx/qla_os.c
./drivers/scsi/ips.c
./drivers/scsi/mesh.c
./drivers/scsi/3w-sas.c
./drivers/scsi/myrb.c
./drivers/scsi/aacraid/linit.c
./drivers/scsi/aic94xx/aic94xx_init.c
./drivers/scsi/qla1280.c
./drivers/scsi/3w-9xxx.c
./drivers/scsi/sym53c8xx_2/sym_glue.c
./drivers/scsi/atp870u.c
./drivers/scsi/mpi3mr/mpi3mr_fw.c
./drivers/scsi/dc395x.c
./drivers/scsi/myrs.c
./drivers/scsi/ipr.c
./drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
./drivers/scsi/qedi/qedi_main.c
./drivers/scsi/advansys.c
./drivers/scsi/qla4xxx/ql4_os.c
./drivers/scsi/BusLogic.c
./drivers/scsi/aic7xxx/aic79xx_osm_pci.c
./drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
./drivers/scsi/hpsa.c
./drivers/spi/spi-pxa2xx.c
./drivers/spi/spi-dw-pci.c
./drivers/spi/spi-topcliff-pch.c
./drivers/spi/spi-pxa2xx-pci.c
./drivers/platform/chrome/chromeos_laptop.c
./drivers/platform/x86/intel_scu_pcidrv.c
./drivers/platform/x86/intel_ips.c
./drivers/platform/x86/sony-laptop.c
./drivers/block/rsxx/dma.c
./drivers/block/rsxx/core.c
./drivers/block/sx8.c
./drivers/block/mtip32xx/mtip32xx.c
./drivers/mtd/nand/raw/denali_pci.c
./drivers/mtd/nand/raw/cafe_nand.c
./drivers/mtd/nand/raw/r852.c
./drivers/parisc/superio.c
./drivers/parisc/dino.c
./drivers/parisc/iosapic.c
./drivers/firewire/ohci.c
./drivers/firewire/nosy.c
./drivers/hid/intel-ish-hid/ipc/pci-ish.c
./drivers/macintosh/rack-meter.c
./drivers/atm/nicstar.c
./drivers/atm/ambassador.c
./drivers/atm/iphase.c
./drivers/atm/horizon.c
./drivers/atm/firestream.c
./drivers/atm/zatm.c
./drivers/atm/lanai.c
./drivers/atm/eni.c
./drivers/atm/solos-pci.c
./drivers/atm/he.c
./drivers/atm/fore200e.c
./drivers/atm/idt77252.c
./drivers/parport/parport_pc.c
./drivers/pcmcia/cardbus.c
./drivers/pcmcia/i82092.c
./drivers/pcmcia/yenta_socket.c
./drivers/pcmcia/pd6729.c
./drivers/watchdog/wdt_pci.c
./drivers/vme/bridges/vme_ca91cx42.c
./drivers/vme/bridges/vme_tsi148.c
./drivers/input/serio/pcips2.c
./drivers/vfio/pci/vfio_pci_core.c
./drivers/vfio/pci/vfio_pci_intrs.c
./drivers/gpio/gpio-sodaville.c
./drivers/gpio/gpio-sta2x11.c
./drivers/gpio/gpio-pci-idio-16.c
./drivers/gpio/gpio-pch.c
./drivers/gpio/gpio-ml-ioh.c
./drivers/gpio/gpio-thunderx.c
./drivers/gpio/gpio-merrifield.c
./drivers/gpio/gpio-pcie-idio-24.c
./drivers/gpio/gpio-sch.c
./drivers/ipack/carriers/tpci200.c
./drivers/rapidio/devices/tsi721.c
./drivers/char/ipmi/ipmi_si_pci.c
./drivers/char/sonypi.c
./drivers/char/applicom.c
./drivers/char/xillybus/xillybus_pcie.c
./drivers/message/fusion/mptspi.c
./drivers/message/fusion/mptbase.c
./drivers/message/fusion/mptfc.c
./drivers/message/fusion/mptsas.c
./drivers/mfd/intel-lpss-pci.c
./drivers/mfd/intel_quark_i2c_gpio.c
./drivers/mfd/janz-cmodio.c
./drivers/mfd/sm501.c
./drivers/mfd/ioc3.c
./drivers/gpu/drm/drm_irq.c
./drivers/gpu/drm/vboxvideo/vbox_irq.c
./drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
./drivers/gpu/drm/r128/r128_state.c
./drivers/gpu/drm/radeon/radeon_irq_kms.c
./drivers/gpu/drm/radeon/si_dpm.c
./drivers/gpu/drm/radeon/ci_dpm.c
./drivers/gpu/drm/radeon/si.c
./drivers/gpu/drm/radeon/cik.c
./drivers/gpu/drm/radeon/radeon_device.c
./drivers/gpu/drm/radeon/radeon_kms.c
./drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
./drivers/gpu/drm/i915/i915_drv.c
./drivers/gpu/drm/i915/i915_irq.c
./drivers/gpu/drm/i915/i915_pmu.c
./drivers/gpu/drm/i915/display/intel_display_power.c
./drivers/gpu/drm/drm_pci.c
./drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
./drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
./drivers/gpu/drm/qxl/qxl_irq.c
./drivers/gpu/drm/i810/i810_dma.c
./drivers/gpu/drm/gma500/psb_drv.c
./drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c
./drivers/gpu/drm/gma500/psb_irq.c
./drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
./drivers/gpu/drm/mga/mga_dma.c
./drivers/gpu/drm/mga/mga_state.c
./drivers/isdn/hardware/mISDN/netjet.c
./drivers/isdn/hardware/mISDN/mISDNinfineon.c
./drivers/isdn/hardware/mISDN/speedfax.c
./drivers/isdn/hardware/mISDN/hfcmulti.c
./drivers/isdn/hardware/mISDN/w6692.c
./drivers/isdn/hardware/mISDN/hfcpci.c
./drivers/isdn/hardware/mISDN/avmfritz.c
./drivers/video/fbdev/matrox/matroxfb_base.c
./drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
./drivers/video/fbdev/cyber2000fb.c
./drivers/video/fbdev/via/via-core.c
./drivers/video/fbdev/aty/atyfb_base.c
./drivers/video/fbdev/intelfb/intelfbdrv.c
./drivers/video/fbdev/intelfb/intelfbhw.c
./drivers/virt/vboxguest/vboxguest_linux.c
./drivers/i2c/busses/i2c-pxa-pci.c
./drivers/i2c/busses/i2c-amd-mp2-pci.c
./drivers/i2c/busses/i2c-eg20t.c
./drivers/i2c/busses/i2c-designware-pcidrv.c
./drivers/i2c/busses/i2c-i801.c
./drivers/i2c/busses/i2c-ismt.c
./drivers/i2c/busses/i2c-nvidia-gpu.c
./drivers/xen/platform-pci.c
./drivers/xen/events/events_base.c
./drivers/xen/xen-pciback/pciback_ops.c
./drivers/xen/xen-pciback/conf_space_header.c
./drivers/xen/xen-pciback/pci_stub.c
./drivers/staging/rts5208/rtsx.c
./drivers/staging/media/ipu3/ipu3.c
./drivers/staging/media/atomisp/pci/atomisp_ioctl.c
./drivers/staging/media/atomisp/pci/atomisp_v4l2.c
./drivers/staging/media/atomisp/pci/atomisp_cmd.c
./drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
./drivers/staging/media/zoran/zoran_device.c
./drivers/staging/media/zoran/zoran_card.c
./drivers/staging/vt6655/device_main.c
./drivers/staging/rtl8192e/rtl8192e/rtl_core.c
./drivers/staging/qlge/qlge_main.c
./drivers/misc/pci_endpoint_test.c
./drivers/misc/phantom.c
./drivers/misc/cardreader/rtsx_pcr.c
./drivers/misc/cardreader/alcor_pci.c
./drivers/misc/habanalabs/goya/goya.c
./drivers/misc/cxl/guest.c
./drivers/misc/cxl/api.c
./drivers/misc/cxl/of.c
./drivers/misc/cxl/sysfs.c
./drivers/misc/genwqe/card_ddcb.c
./drivers/misc/genwqe/card_debugfs.c
./drivers/misc/tifm_7xx1.c
./drivers/misc/mei/hw-me.c
./drivers/misc/mei/pci-txe.c
./drivers/misc/mei/pci-me.c
./drivers/misc/mei/hw-txe.c
./drivers/misc/cb710/core.c
./drivers/misc/vmw_vmci/vmci_guest.c
./drivers/misc/bcm-vk/bcm_vk_dev.c
./drivers/misc/ocxl/context.c
./drivers/misc/ocxl/core.c
./drivers/misc/ocxl/link.c
./drivers/misc/ibmasm/module.c
./drivers/misc/hpilo.c
./drivers/mcb/mcb-pci.c
./drivers/ptp/ptp_pch.c
./drivers/ptp/ptp_ocp.c
./drivers/virtio/virtio_pci_common.c
./drivers/memstick/host/r592.c
./drivers/memstick/host/jmb38x_ms.c
./drivers/bcma/driver_pci_host.c
./samples/v4l/v4l2-pci-skeleton.c

>   PCI/sysfs: Don't depend on pci_dev.irq for IRQ entry
>
> Marc Zyngier (1):
>   PCI/MSI: remove msi_attrib.default_irq in msi_desc
>
>  Documentation/ABI/testing/sysfs-bus-pci | 10 ++++++++++
>  drivers/pci/msi.c                       | 12 +++++-------
>  drivers/pci/pci-sysfs.c                 | 23 ++++++++++++++++++++++-
>  include/linux/msi.h                     |  2 --
>  4 files changed, 37 insertions(+), 10 deletions(-)
>
> --
> 1.8.3.1
>

Thanks
barry
