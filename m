Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604502667CB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 19:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgIKRwl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 13:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgIKRwj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2020 13:52:39 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1351C0613ED
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2020 10:52:38 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so2039204pjr.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2020 10:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=G/cqFZ314H6FObnkO5TrjYzO5FoUcHuv7k8XGD4n1j8=;
        b=JR5BulFZANaMOjpZlQwWRu37HmvKs4YsnQ5yLtojofdiN4HjPFjdyNtzaujsz2R3PN
         gFMpg34MwddgYzcE7dZBYyz91ySvPTx+5JB5Zva/qovVjZPvqg9MghYH2C0d3toMQFtA
         mkWahlNfwbwG1iPXYnu3B6u6BZgHekbn/a3OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G/cqFZ314H6FObnkO5TrjYzO5FoUcHuv7k8XGD4n1j8=;
        b=kftAlasWKRVFvbcmu8hY7h/4SAZ2YoVachcwiD2wRl42zSaoZp5dfPM5VUbUMoLBNR
         UkjGPLFEE4Oh76lIU2O4yVy57D/Nt7WxDoczMiI6oQl2sh/PDBPoSozdD5YcUYVoaIv5
         4HUVu+hvCd4nHlW1iawA9zeNl/MmQhiISP/BSgzjwL9rx6jPnDWUlLICJFZ6jllkjO4L
         ioaP3VPSjsTXYJ2zAwzs+UHFLbhzHNAB+e2EwO+jZWpN0xLCIQRA9AkZy0CPgN1Ec9X7
         IU3R5LLaF3JpEaGHgUHGPgw7RIXstMcdh8Q//O5U1tJxOHNULXVuqsPhK0fW0lpPW9NW
         RmLA==
X-Gm-Message-State: AOAM532KPcFKXZDrBTUK6CE5XTUYact5vekYAAqha5/qQPUXFv90xbFc
        oe1Z8QgIFCA4Imxt8cKE0GnwG0l67uARK4W2pUr6JaNsluQtIbX04KCkCb7cmAD0Jr1MOx7uS7+
        Rvbc+YFK0HA0uTvv7Hk0Yt4Ei+g/Y8G7SU/maWa6J2VJCua6dxobRY4PpJJ1oYGmOD7zS5J/oN/
        T5Rcwy
X-Google-Smtp-Source: ABdhPJxzd6d4OiDI/recEtTaB2egAA4JapjoK1NGwn7WUGC3ex42mN9vJDvYXUFNcT52ZYtt6+ZJKw==
X-Received: by 2002:a17:90a:d485:: with SMTP id s5mr3179386pju.193.1599846757338;
        Fri, 11 Sep 2020 10:52:37 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id d77sm2871963pfd.121.2020.09.11.10.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:52:36 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE), Rob Herring <robh@kernel.org>
Subject: [PATCH v12 00/10] PCI: brcmstb: enable PCIe for STB chips
Date:   Fri, 11 Sep 2020 13:52:20 -0400
Message-Id: <20200911175232.19016-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b666f905af0d59b4"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000b666f905af0d59b4


Patchset Summary:
  Enhance a PCIe host controller driver.  Because of its unusual design
  we are foced to change dev->dma_pfn_offset into a more general role
  allowing multiple offsets.  See the 'v1' notes below for more info.

v12:
  Commit: "device-mapping: Introduce DMA range map, supplanting dma_pfn_offset"
  -- This commit is in the process of being accepted and has
     subsequently been removed from this submission.  This
     submission is still dependent on said removed commit.
  Commit: "PCI: brcmstb: Add suspend and resume pm_ops"
  -- Use pm_ops suspend_late/resume_early instead of suspend_noirq/
     resume_noirq (RobH).
  Commit: "PCI: brcmstb: Set additional internal memory DMA viewport"
  -- Use a macro SCB_SIZE_MASK() for constants. (Rob)
  Commit: "PCI: brcmstb: Add control of rescal reset"
  -- Remove redundant dev_err() calls (Rob)
  -- Change initialization setting of 'val' variable (Lorenzo)
  Commit: "PCI: brcmstb: Add bcm7278 PERST# support"
  -- Use a per chip type function for brcm_pcie_perst_set()
     and for bridge_sw_init_set() (RobH)
  -- Remove the call to perst_set in brcm_pcie_setup() as all
     STB chips power up with PERST# asserted (JimQ)

v11:
  Commit: "device-mapping: Introduce DMA range map, supplanting ..."
  -- Rebased to latest torvalds, Aug 20, 2020.
  -- Minor change in of_dma_get_range() to satisfy the kernel's
     robot tester.
  -- Use of PFN_DOWN(), PFN_PHYS() instead of explicit shifts (Andy)
  -- Eliminate extra return in dma_offset_from_xxx_addr() (Andy)
  -- Change dma_set_offset_range() to correctly handle the case
     of pre-existing DMA map and zero offset.

v10: 
  Commit: "device-mapping: Introduce DMA range map, supplanting ..."
  -- change title of commit; "bus core:" => "device-mapping:"
  -- instead of allocating the DMA map with devm, use kcalloc
     and call kfree() during device_release().  (RobH) Also,
     for three cases that want to use the same DMA map, copy
     the dma_range_map using a helper function.
  -- added a missing 'return = 0;' to of_dma_get_range().  (Nicolas)
  -- removed dma_range_overlaps(); instead return error if there
     is an existing DMA map. (Christoph).
  Commit: "PCI: brcmstb: Set additional internal memory DMA ..."
  -- Changed constant 1 to 1ULL. (Nicolas)
  Commit: "ata: ahci_brcm: Fix use of BCM7216 reset controller"
     This commit has been removed from this patchset and will be
     submitted on its own.

v9:
  Commit: "device core: Introduce DMA range map, supplanting ..."
  -- A number of code improvements were implemented as suggested by
     ChristophH.  Unfortunately, some of these changes reversed the
     implemented suggestions of other reviewers; for example, the new
     macros PFN_DMA_ADDR(), DMA_ADDR_PFN() have been pulled.

v8:
  Commit: "device core: Introduce DMA range map, supplanting ..."
  -- To satisfy a specific m68 compile configuration, I moved the 'struct
     bus_dma_region; definition out of #ifdef CONFIG_HAS_DMA and also defined
     three inline functions for !CONFIG_HAS_DMA (kernel test robot).
  -- The sunXi drivers -- suc4i_csi, sun6i_csi, cedrus_hw -- set
     a pfn_offset outside of_dma_configure() but the code offers no 
     insight on the size of the translation window.  V7 had me using
     SIZE_MAX as the size.  I have since contacted the sunXi maintainer and
     he said that using a size of SZ_4G would cover sunXi configurations.

v7:
  Commit: "device core: Introduce DMA range map, supplanting ..."
  -- remove second kcalloc/copy in device.c (AndyS)
  -- use PTR_ERR_OR_ZERO() and PHYS_PFN() (AndyS)
  -- indentation, sizeof(struct ...) => sizeof(*r) (AndyS)
  -- add pfn.h definitions: PFN_DMA_ADDR(), DMA_ADDR_PFN() (AndyS)
  -- Fixed compile error in "sun6i_csi.c" (kernel test robot)
  Commit "ata: ahci_brcm: Fix use of BCM7216 reset controller"
  -- correct name of function in the commit msg (SergeiS)
  
v6:
  Commit "device core: Introduce DMA range map":
  -- of_dma_get_range() now takes a single argument and returns either
     NULL, a valid map, or an ERR_PTR. (Robin)
  -- offsets are no longer a PFN value but an actual address. (Robin)
  -- the bus_dma_region struct stores the range size instead of
     the cpu_end and pci_end values. (Robin)
  -- devices that were setting a single offset with no boundaries
     have been modified to have boundaries; in a few places
     where this information was unavilable a /* FIXME: ... */
     comment was added. (Robin)
  -- dma_attach_offset_range() can be called when an offset
     map already exists; if it's range is already present
     nothing is done and success is returned. (Robin)
  All commits:
  -- Man name/style/corrections/etc changed (Bjorn)
  -- rebase to Torvalds master

v5:
  Commit "device core: Introduce multiple dma pfn offsets"
  -- in of/address.c: "map_size = 0" => "*map_size = 0"
  -- use kcalloc instead of kzalloc (AndyS)
  -- use PHYS_ADDR_MAX instead of "~(phys_addr_t)0"
  Commit "PCI: brcmstb: Set internal memory viewport sizes"
  -- now gives error on missing dma-ranges property.
  Commit "dt-bindings: PCI: Add bindings for more Brcmstb chips"
  -- removed "Allof:" from brcm,scb-sizes definition (RobH)
  All Commits:
  -- indentation style, use max chars 100 (AndyS)
  -- rebased to torvalds master

v4:
  Commit "device core: Introduce multiple dma pfn offsets"
  -- of_dma_get_range() does not take a dev param but instead
     takes two "out" params: map and map_size.  We do this so
     that the code that parses dma-ranges is separate from
     the code that modifies 'dev'.   (Nicolas)
  -- the separate case of having a single pfn offset has
     been removed and is now processed by going through the
     map array. (Nicolas)
  -- move attach_uniform_dma_pfn_offset() from of/address.c to
     dma/mapping.c so that it does not depend on CONFIG_OF. (Nicolas)
  -- devm_kcalloc => devm_kzalloc (DanC)
  -- add/fix assignment to dev->dma_pfn_offset_map for func
     attach_uniform_dma_pfn_offset() (DanC, Nicolas)
  -- s/struct dma_pfn_offset_region/struct bus_dma_region/ (Nicolas)
  -- s/attach_uniform_dma_pfn_offset/dma_attach_uniform_pfn_offset/
  -- s/attach_dma_pfn_offset_map/dma_attach_pfn_offset_map/
  -- More use of PFN_{PHYS,DOWN,UP}. (AndyS)
  Commit "of: Include a dev param in of_dma_get_range()"
  -- this commit was sqaushed with "device core: Introduce ..."

v3:
  Commit "device core: Introduce multiple dma pfn offsets"
  Commit "arm: dma-mapping: Invoke dma offset func if needed"
  -- The above two commits have been squashed.  More importantly,
     the code has been modified so that the functionality for
     multiple pfn offsets subsumes the use of dev->dma_pfn_offset.
     In fact, dma_pfn_offset is removed and supplanted by
     dma_pfn_offset_map, which is a pointer to an array.  The
     more common case of a uniform offset is now handled as
     a map with a single entry, while cases requiring multiple
     pfn offsets use a map with multiple entries.  Code paths
     that used to do this:

         dev->dma_pfn_offset = mydrivers_pfn_offset;

     have been changed to do this:

         attach_uniform_dma_pfn_offset(dev, pfn_offset);

  Commit "dt-bindings: PCI: Add bindings for more Brcmstb chips"
  -- Add if/then clause for required props: resets, reset-names (RobH)
  -- Change compatible list from const to enum (RobH)
  -- Change list of u32-tuples to u64 (RobH)

  Commit "of: Include a dev param in of_dma_get_range()"
  -- modify of/unittests.c to add NULL param in of_dma_get_range() call.

  Commit "device core: Add ability to handle multiple dma offsets"
  -- align comment in device.h (AndyS).
  -- s/cpu_beg/cpu_start/ and s/dma_beg/dma_start/ in struct
     dma_pfn_offset_region (AndyS).

v2:
Commit: "device core: Add ability to handle multiple dma offsets"
  o Added helper func attach_dma_pfn_offset_map() in address.c (Chistoph)
  o Helpers funcs added to __phys_to_dma() & __dma_to_phys() (Christoph)
  o Added warning when multiple offsets are needed and !DMA_PFN_OFFSET_MAP
  o dev->dma_pfn_map => dev->dma_pfn_offset_map
  o s/frm/from/ for dma_pfn_offset_frm_{phys,dma}_addr() (Christoph)
  o In device.h: s/const void */const struct dma_pfn_offset_region */
  o removed 'unlikely' from unlikely(dev->dma_pfn_offset_map) since
    guarded by CONFIG_DMA_PFN_OFFSET_MAP (Christoph)
  o Since dev->dma_pfn_offset is copied in usb/core/{usb,message}.c, now
    dev->dma_pfn_offset_map is copied as well.
  o Merged two of the DMA commits into one (Christoph).

Commit "arm: dma-mapping: Invoke dma offset func if needed":
  o Use helper functions instead of #if CONFIG_DMA_PFN_OFFSET

Other commits' changes:
  o Removed need for carrying of_id var in priv (Nicolas)
  o Commit message rewordings (Bjorn)
  o Commit log messages filled to 75 chars (Bjorn)
  o devm_reset_control_get_shared())
    => devm_reset_control_get_optional_shared (Philipp)
  o Add call to reset_control_assert() in PCIe remove routines (Philipp)

v1:
This patchset expands the usefulness of the Broadcom Settop Box PCIe
controller by building upon the PCIe driver used currently by the
Raspbery Pi.  Other forms of this patchset were submitted by me years
ago and not accepted; the major sticking point was the code required
for the DMA remapping needed for the PCIe driver to work [1].

There have been many changes to the DMA and OF subsystems since that
time, making a cleaner and less intrusive patchset possible.  This
patchset implements a generalization of "dev->dma_pfn_offset", except
that instead of a single scalar offset it provides for multiple
offsets via a function which depends upon the "dma-ranges" property of
the PCIe host controller.  This is required for proper functionality
of the BrcmSTB PCIe controller and possibly some other devices.

[1] https://lore.kernel.org/linux-arm-kernel/1516058925-46522-5-git-send-email-jim2101024@gmail.com/

Jim Quinlan (10):
  PCI: brcmstb: PCIE_BRCMSTB depends on ARCH_BRCMSTB
  dt-bindings: PCI: Add bindings for more Brcmstb chips
  PCI: brcmstb: Add bcm7278 register info
  PCI: brcmstb: Add suspend and resume pm_ops
  PCI: brcmstb: Add bcm7278 PERST# support
  PCI: brcmstb: Add control of rescal reset
  PCI: brcmstb: Set additional internal memory DMA viewport sizes
  PCI: brcmstb: Accommodate MSI for older chips
  PCI: brcmstb: Set bus max burst size by chip type
  PCI: brcmstb: Add bcm7211, bcm7216, bcm7445, bcm7278 to match list

 .../bindings/pci/brcm,stb-pcie.yaml           |  56 ++-
 drivers/pci/controller/Kconfig                |   3 +-
 drivers/pci/controller/pcie-brcmstb.c         | 436 +++++++++++++++---
 3 files changed, 424 insertions(+), 71 deletions(-)

-- 
2.17.1


--000000000000b666f905af0d59b4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOxPm7sNHsn0TVdPryi9+T2d8fVC/kUmuEdTYP/Hdu4W4b4T9BcW57fInYrmaJ+uotS6X59rAgMB
AAGjggHRMIIBzTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAC
hkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEy
ZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVy
c29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8E
PTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJn
My5jcmwwJQYDVR0RBB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFNYm4GDl
4WOt3laB3gNKFfYyaM8bMA0GCSqGSIb3DQEBCwUAA4IBAQBD+XYEgpG/OqeRgXAgDF8sa+lQ/00T
wCP/3nBzwZPblTyThtDE/iaL/YZ5rdwqXwdCnSFh9cMhd/bnA+Eqw89clgTixvz9MdL9Vuo8LACI
VpHO+sxZ2Cu3bO5lpK+UVCyr21y1zumOICsOuu4MJA5mtkpzBXQiA7b/ogjGxG+5iNjt9FAMX4JP
V6GuAMmRknrzeTlxPy40UhUcRKk6Nm8mxl3Jh4KB68z7NFVpIx8G5w5I7S5ar1mLGNRjtFZ0RE4O
lcCwKVGUXRaZMgQGrIhxGVelVgrcBh2vjpndlv733VI2VKE/TvV5MxMGU18RnogYSm66AEFA/Zb+
5ztz1AtIMYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEcz
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIESVlOth/n3Q
TXgscAvEnhYuayUGBRT9TjowtKi7bTOcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMDkxMTE3NTIzOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBH87DbKStv/pgu+VE+AHX1ffpEmkSE
NII1LZq/Q4Awq64+fBZpq/WYpF5dFBC2KF6rsdiQTzXME+LdZ82eFTe6rFhglB+8tkYyASeAocc2
COAhB2RoJiPMoXLJCnCtWHI9bAr56ygtgNDj7OlZvb2/3CPF1s73FmJ9BCaThh4l/OvQs3nUmFJ0
q8QYAJJm/lk8l2YESdhT3HGtlnstgND9wH4mCZvxbcyHpfAv7IMf6ai9LP1O0gsG9snGySv32M7Y
kKVx0XSAZReCeECuqd5Da8YikrhYLEV0Z098egCTK+8RTrhZuB6KA99kqG5+7NHKgjTmN9pkwKsU
Xt+fdAmJ
--000000000000b666f905af0d59b4--
