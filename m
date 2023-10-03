Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD9A7B6F1E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 18:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbjJCQ6T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 12:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240545AbjJCQ6S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 12:58:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CE4BD;
        Tue,  3 Oct 2023 09:58:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E52C433C7;
        Tue,  3 Oct 2023 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696352290;
        bh=CW7Wcm7sPLaG8k7fCB3cJgGleAH6htQf+NLDbGd1ww0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Mp8GhnsxJ7b8N3UyCEW0vldhx95rABa2K9SUw5GLOM6lphh+vhaFl3Q8pIztBNplq
         w3ebVYu9/QWtciSFaSoQur/H303AyR/dikGOohNpVsr/8vGN0yJtlDBUk/kIxw2g/f
         mfCvfsZHVj2Vs1mqXFNoJZcvHXAogBFoejJ3gIv5RfgVnpp8kOk7yWmo9c2TFk63jb
         +uFRj+o1laiDlaA1EKLAaeFuVDNXaASkuUyw8+wAUYm5zEi5JpJRbvgGfuh0m+IINp
         mk66GITkXha7HVVMkK2AD8UXDXVvsJxFfpiQ/R1vWwcKJ1ACApugY3t2SjAQe2Q7W3
         aoc6uBoOp2/zA==
Date:   Tue, 3 Oct 2023 11:58:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, jonathan.derrick@linux.dev,
        kw@linux.com, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        lpieralisi@kernel.org, marek.vasut+renesas@gmail.com,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        m.karthikeyan@mobiveil.co.in, nirmal.patel@linux.intel.com,
        rjui@broadcom.com, robh@kernel.org, roy.zang@nxp.com,
        sbranden@broadcom.com, yoshihiro.shimoda.uh@renesas.com,
        Zhiqiang.Hou@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: PCI_HEADER_TYPE bugfix & cleanups
Message-ID: <20231003165808.GA677787@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231003125300.5541-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 03, 2023 at 03:52:57PM +0300, Ilpo Järvinen wrote:
> One bugfix and cleanups for PCI_HEADER_TYPE_* literals.
> 
> This series only covers what's within drivers/pci/. I'd have patches
> for other subsystems too but I decided to wait with them until
> PCI_HEADER_TYPE_MFD is in Linus' tree (to keep the series receipient
> count reasonable, the rest can IMO go through the subsystem specific
> trees once the define is there).
> 
> Ilpo Järvinen (3):
>   PCI: vmd: Correct PCI Header Type Register's MFD bit check
>   PCI: Add PCI_HEADER_TYPE_MFD pci_regs.h
>   PCI: Use PCI_HEADER_TYPE_* instead of literals
> 
>  drivers/pci/controller/dwc/pci-layerscape.c   |  2 +-
>  .../controller/mobiveil/pcie-mobiveil-host.c  |  2 +-
>  drivers/pci/controller/pcie-iproc.c           |  2 +-
>  drivers/pci/controller/pcie-rcar-ep.c         |  2 +-
>  drivers/pci/controller/pcie-rcar-host.c       |  2 +-
>  drivers/pci/controller/vmd.c                  |  5 ++---
>  drivers/pci/hotplug/cpqphp_ctrl.c             |  6 ++---
>  drivers/pci/hotplug/cpqphp_pci.c              | 22 +++++++++----------
>  drivers/pci/hotplug/ibmphp.h                  |  5 +++--
>  drivers/pci/hotplug/ibmphp_pci.c              |  2 +-
>  drivers/pci/pci.c                             |  2 +-
>  drivers/pci/quirks.c                          |  6 ++---
>  include/uapi/linux/pci_regs.h                 |  1 +
>  13 files changed, 30 insertions(+), 29 deletions(-)

Applied to pci/enumeration for v6.7, thanks!
