Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE626E9D69
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 22:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjDTUqF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 16:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjDTUqE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 16:46:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366D03C31;
        Thu, 20 Apr 2023 13:46:03 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ec88c67b2eso855385e87.1;
        Thu, 20 Apr 2023 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682023561; x=1684615561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3HvXNG8HE4oX+gnBq0w0JBEpyvYj5QUz9fmpVdva+2Y=;
        b=TlNOPgd6XkVV/LjxNy6ja9DVApsIbWjje9CK3ouHY8mEAVpQngejV/4o/ATPrMGfTS
         pYCRgsdLmOd8NjGSNalKLzGnJ+/P+UD1r8a6Uora1NkKxCjNYbCQfpJiGl3uYosuFu7O
         JnoNHRRpPB1xDL3WR8fyx2qilygUEa6WsmhdqL0aXHaUTCgXjPzdFHsQlNgPMGbXabwB
         u0TM1afVWQOOr8PyrdGvEhUupOFQuIRTKQUxuLEfuSrozseNwC+cvRzCl/ZWGg2dC837
         a14d+tZwu1cxtDw/pN05IGLSUBz06fhe3+VJ9N6XH22+YPxaPbzDG7+UBsiaetVyk6B/
         Issg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682023561; x=1684615561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HvXNG8HE4oX+gnBq0w0JBEpyvYj5QUz9fmpVdva+2Y=;
        b=Y3khXi3bH75IjUaW4y2nmO1TPAJk5jvLKtM3K2FsXpCNCL1d1wShcAXmz7KPwj63r3
         jJDskxLwceRmoNFTZ18s1b2EgJnKpJyR+PmdEo2mWklXFar81t8FCrxdvGV2mbCG3Oio
         VtDKAAxoOptPbJmTR7cF8wAeUFupgvqox6vVfgPulHkybwE/pAFjUFB6FT4zJjRV+IBr
         uBVOiUfPfRyFSXjWJK06VEFLSX1ZPI9EiFH9JTU9Nob8reb/AomsrMgm3j/FkFWIH39q
         QQZMzoaLgtSR02gzLsMfldA+wupXir9B9kenlLvu7iuCzuK45HUCOLORTTDA7sk0wRQ0
         Sxxg==
X-Gm-Message-State: AAQBX9eAWxZ4iweV3uFsBK43FQNxMI5JG647xmnjTj4XU7U5QvVH7Bdh
        FiQnRzuXwCyGf1Lm+cwIqiw=
X-Google-Smtp-Source: AKy350ZRzbjkSCdw4iQnpkNQMoASQhja28aHQA/mqXfAUUfa8Zmbp2cp9CIgyJK52bUkx/X1m83DFA==
X-Received: by 2002:a05:6512:946:b0:4ed:cc6d:61fe with SMTP id u6-20020a056512094600b004edcc6d61femr781237lft.24.1682023561122;
        Thu, 20 Apr 2023 13:46:01 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25a08000000b004ecb06acbb3sm321618lfn.281.2023.04.20.13.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:46:00 -0700 (PDT)
Date:   Thu, 20 Apr 2023 23:45:58 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v12 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Message-ID: <20230420204558.4csplhtkz2co4att@mobilestation>
References: <20230414061622.2930995-1-yoshihiro.shimoda.uh@renesas.com>
 <20230420204129.azbopwklu2yetfrf@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420204129.azbopwklu2yetfrf@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 20, 2023 at 11:41:32PM +0300, Serge Semin wrote:
> Hi Yoshihiro
> 
> On Fri, Apr 14, 2023 at 03:16:03PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
> > To support them, modify PCIe DesignWare common codes.
> 
> Thanks for the updates. I'll have a look at the series on the next
> week.

Oh, I see there is v13 already submitted. I'll send my comments there
then.

-Serge(y)

> 
> -Serge(y)
> 
> > 
> > Changes from v11:
> > https://lore.kernel.org/linux-pci/20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com/
> >  - Based on next-20230413
> >  - Based on the following cleanups patches:
> >    [PATCH v4 00/14] PCI: dwc: Relatively simple fixes and cleanups
> >    https://lore.kernel.org/linux-pci/20230414021832.13167-1-Sergey.Semin@baikalelectronics.ru/
> >  - Drop a fixed patch of pci-epf-test because I have submitted it independently.
> >  - Split patches about adding dw_pcie_link_set_max_* functions.
> >  - Split patches about modify __dw_pcie_prog_outbound_atu().
> >  - Add description about num lanes into the commit log.
> >  - Add some macros into pci_regs.h and pci.h.
> >  - Add comment about disabling bars in pcie-rcar-gen4-host.c.
> >  - Set MAX_MSI_IRQS to num_vectors for handling 32 MSIs.
> >  - Add .ep_deinit().
> >  - Add retrain link handling of PCIe Host mode for detecting PCIe Gen4.
> >  - Modify some minor things.
> > 
> > Changes from v10:
> > https://lore.kernel.org/linux-pci/20230308082352.491561-1-yoshihiro.shimoda.uh@renesas.com/
> >  - Fix dt-bindings doc for endpoint (reported by Rob's bot).
> >  - Add reg and reg-names to the dt-bindings doc of host.
> >  - Fix examples in the dt-bindings docs of both host and endpoint.
> >  - Add R-Car S4-8 device ID into the pci_test_endpoint driver.
> > 
> > Changes from v9:
> > https://lore.kernel.org/linux-pci/20230210134917.2909314-1-yoshihiro.shimoda.uh@renesas.com/
> >  - Based on next-20230306
> >  - Add bug fix patches into this patch series.
> >    https://lore.kernel.org/linux-pci/20230216092012.3256440-1-yoshihiro.shimoda.uh@renesas.com/
> >    https://lore.kernel.org/linux-pci/20230222015327.3585691-1-yoshihiro.shimoda.uh@renesas.com/
> >  - Add maximum for max-link-speed and num-lanes to dt-bindings of both host and endpoint.
> >  - Add max-functions to dt-bindings of endpoint.
> >  - Use reg-names "app" on endpoint.
> >  - Remove unnecessary linkup and wait process in rcar_gen4_pcie_host_init().
> >  - Remove unnecessary macros in pcie-rcar-gen4.h.
> >  - Use dbi2 to write BAR mask registers.
> >  - Remove no_msix and intx_by_atu flags.
> >  - Reduce __dw_pcie_prog_outbound_atu() arguments.
> >  - Add dw_pcie_num_lanes_setup() to setup num_lanes.
> >  - Refactor dw_pcie_setup() to avoid PCIE_PORT_LINK_CONTROL writing twice.
> > 
> > Yoshihiro Shimoda (19):
> >   PCI: Add PCI_EXP_LNKCAP_MLW macros
> >   PCI: Add INtx Mechanism Messages macros
> >   PCI: Add PCI_HEADER_TYPE_MULTI_FUNC
> >   PCI: dwc: Add dw_pcie_link_set_max_link_width()
> >   PCI: dwc: Add dw_pcie_link_set_max_width()
> >   PCI: dwc: Add dw_pcie_link_set_max_cap_width()
> >   PCI: dwc: Expose dw_pcie_ep_exit() to module
> >   PCI: dwc: Introduce struct dw_pcie_outbound_atu
> >   PCI: dwc: Add members into struct dw_pcie_outbound_atu
> >   PCI: dwc: Change arguments of dw_pcie_prog_ep_outbound_atu()
> >   PCI: dwc: Add support for triggering legacy IRQs
> >   PCI: dwc: Add EDMA_UNROLL capability flag
> >   PCI: dwc: Introduce .ep_pre_init() and .ep_deinit()
> >   dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
> >   dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
> >   PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
> >   PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint support
> >   MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4
> >   misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller
> > 
> >  .../bindings/pci/rcar-gen4-pci-ep.yaml        |  98 +++++++++
> >  .../bindings/pci/rcar-gen4-pci-host.yaml      | 109 ++++++++++
> >  MAINTAINERS                                   |   1 +
> >  drivers/misc/pci_endpoint_test.c              |   4 +
> >  drivers/pci/controller/dwc/Kconfig            |  18 ++
> >  drivers/pci/controller/dwc/Makefile           |   4 +
> >  .../pci/controller/dwc/pcie-designware-ep.c   |  93 ++++++--
> >  drivers/pci/controller/dwc/pcie-designware.c  | 201 +++++++++++-------
> >  drivers/pci/controller/dwc/pcie-designware.h  |  27 ++-
> >  .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 166 +++++++++++++++
> >  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 134 ++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 187 ++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  49 +++++
> >  include/linux/pci.h                           |  18 ++
> >  include/uapi/linux/pci_regs.h                 |   7 +
> >  15 files changed, 1020 insertions(+), 96 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h
> > 
> > -- 
> > 2.25.1
> > 
