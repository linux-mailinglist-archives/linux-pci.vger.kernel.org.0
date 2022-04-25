Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8C950D6B0
	for <lists+linux-pci@lfdr.de>; Mon, 25 Apr 2022 03:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbiDYBs6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Apr 2022 21:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbiDYBs5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Apr 2022 21:48:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4312213F8F;
        Sun, 24 Apr 2022 18:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3B12B80A2C;
        Mon, 25 Apr 2022 01:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B805EC385A7;
        Mon, 25 Apr 2022 01:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650851152;
        bh=M0wnHoRglVED43aA1R/OrSlNwqdq31WUhlL937Z+qHk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=O/uwSLvl85p5u8qu/yf7dbtAyytHaYmJBd7uTceQp6mPIeS3OVIrWLqEytC88JYAs
         U6/QZo1mACx7hXJbuUDr297qi33ELA/jxUhfQhqBZjI+JitjoWepkmLtssCaqaS8T+
         /5zM55huqbIprps1yyZrHzvJzxBhGUuy3NoZE3FKuRc7KLy5C5We7+b27QTQM5PqUb
         C6svzKrHcDv6mOCsNuTXAN4ibTBXm6hzvlZ39Vs1eaUqoReRKK017oj3LCf5t25pAX
         pbtBcS4Xg/Mzx++02OQW7JQMVoZquPJbqFOMPr+6H7M1fDWjVAKktW9fWShNWsSCLO
         JV0cEMr1XkvrA==
Date:   Sun, 24 Apr 2022 20:45:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        Peter Geis <pgwipeout@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] Enable rk356x PCIe controller
Message-ID: <20220425014549.GA1609905@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423152403.1681222-1-pgwipeout@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks like your cover letter lacked a "To:" line, which breaks group
reply, at least for mutt.

On Sat, Apr 23, 2022 at 11:23:58AM -0400, Peter Geis wrote:
> This series enables the DesignWare based PCIe controller on the rk356x
> series of chips.
> We drop the fallback to the core driver due to compatibility issues.
> We reset the PCIe controller at driver probe to prevent issues in the
> future when firmware / kexec leaves the controller in an unknown state.
> We add support for legacy interrupts for cards that lack MSI support
> (which is partially broken currently).
> We then add the device tree nodes to enable PCIe on the Quartz64 Model
> A.
> 
> Patch 1 drops the snps,dw,pcie fallback from the dt-binding
> Patch 2 resets the PCIe controller to prevent configuration bugs
> Patch 3 adds legacy interrupt support to the driver
> Patch 4 adds the device tree binding to the rk356x.dtsi
> Patch 5 enables the PCIe controller on the Quartz64-A
> 
> Changelog:
> v8:
> - add core reset patch
> - simplify irq enable/disable functions
> - drop spinlock
> - only enable/disable irq requested
> - only pass the irq register bits used to irq functions
> 
> Changelog:
> v7:
> - drop assigned-clocks
> 
> v6:
> - fix a ranges issue
> - point to gic instead of its
> 
> v5:
> - fix incorrect series (apologies for the v4 spam)
> 
> v4:
> - drop the ITS modification, poor compatibility is better than
>   completely broken
> 
> v3:
> - drop select node from dt-binding
> - convert to for_each_set_bit
> - convert to generic_handle_domain_irq
> - drop unncessary dev_err
> - reorder irq_chip items
> - change to level_irq
> - install the handler after initializing the domain
> 
> v2:
> - Define PCIE_CLIENT_INTR_STATUS_LEGACY
> - Fix PCIE_LEGACY_INT_ENABLE to only enable the RC interrupts
> - Add legacy interrupt enable/disable support
> 
> Peter Geis (5):
>   dt-bindings: pci: remove fallback from Rockchip DesignWare binding
>   PCI: dwc: rockchip: reset core at driver probe
>   PCI: dwc: rockchip: add legacy interrupt support
>   arm64: dts: rockchip: add rk3568 pcie2x1 controller
>   arm64: dts: rockchip: enable pcie controller on quartz64-a

Please make your subjects and commit logs match previous history:

  PCI: fu740: Remove unused assignments
  PCI: kirin: Remove unused assignments
  PCI: fu740: Force 2.5GT/s for initial device probe
  PCI: imx6: Assert i.MX8MM CLKREQ# even if no device present
  PCI: imx6: Invoke the PHY exit function after PHY power off
  PCI: dwc: Restore MSI Receiver mask during resume
  PCI: fu740: Drop redundant '-gpios' from DT GPIO lookup
  PCI: imx6: Enable i.MX6QP PCIe power management support
  PCI: qcom: Add SM8450 PCIe support
  PCI: qcom: Add ddrss_sf_tbu flag
  PCI: qcom: Remove redundancy between qcom_pcie and qcom_pcie_cfg

No "dwc:" (no need to include all path elements; "dwc" isn't relevant
unless changing the dwc core itself).  Capitalize first word after the
driver name ("Reset", "Add").

Wrap commit logs to fill 75 columns.

Use blank lines to separate paragraphs.

In subjects, commit logs, comments, log messages, etc:

  s/pcie/PCIe/
  s/irq/IRQ/

Wrap code to fit in 80 columns to match the rest of the file (except
things like printk strings where it would reduce greppability).

>  .../bindings/pci/rockchip-dw-pcie.yaml        |  12 +-
>  .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  34 ++++++
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  52 ++++++++
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 114 +++++++++++++++---
>  4 files changed, 185 insertions(+), 27 deletions(-)
> 
> -- 
> 2.25.1
> 
