Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E552E2D0717
	for <lists+linux-pci@lfdr.de>; Sun,  6 Dec 2020 21:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgLFURg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Dec 2020 15:17:36 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38866 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgLFURf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Dec 2020 15:17:35 -0500
Received: by mail-pj1-f66.google.com with SMTP id j13so6234151pjz.3
        for <linux-pci@vger.kernel.org>; Sun, 06 Dec 2020 12:17:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R+rjdl/kMmpfvATyyiBKTTDC7/ADOrYG2LQ26ycg4ts=;
        b=Fg5iNSadCdU0fE3KrYMtyWfsM7NrcfzglTVn0Nc8EsPkxuGpfn1nEXi2Jjvyat+dV9
         6D8pEsfdgDt15WHyOrgl2yt6aCT3ie5cYQJZ5EJPJ7r29qs3gX0Sg96to4lTEWOkx4W5
         ZQr28/EDjZ75bHaBkVaj38yuBzwuAfW/lrvG33K/csWEiPOfSjWlPXz7J+EU1FR/h/ax
         k/DyzvT0jKD0T8nOVaVjM01kwKfhH2nMZbfnv0JK0Rjp0TR3C5V/58MuOxUnB5NzJ6Hv
         KdWNkLlxNaib26Sc5l/byCeCJTLKHFeGkfix8znQaxoDH7aeJoFFbZbmVGC4DXOXQ1G6
         Rjsg==
X-Gm-Message-State: AOAM532OJbgoYlcm8+r5qmErUBHNnQIFdVW9ome2KKyvItbwL5h5+mYm
        zMI/2Fb9n2txIblIprf4sns=
X-Google-Smtp-Source: ABdhPJxpA9QCLH2CckDZiO4WQ7tusbQz3TsQfr9LJIt6xF7N6IQbRIyD2evK2VHZgjLCDBw3mAerWw==
X-Received: by 2002:a17:90a:990a:: with SMTP id b10mr2206383pjp.87.1607285815024;
        Sun, 06 Dec 2020 12:16:55 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id w11sm12784288pfi.162.2020.12.06.12.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 12:16:54 -0800 (PST)
Date:   Sun, 6 Dec 2020 21:16:36 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v6 1/5] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <X808JJGeIREwqIjb@rocinante>
References: <20201129230743.3006978-1-kw@linux.com>
 <20201129230743.3006978-2-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201129230743.3006978-2-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Nicolas, Florian and Florian,

[...]
> -/* Configuration space read/write support */
> -static inline int brcm_pcie_cfg_index(int busnr, int devfn, int reg)
> -{
> -	return ((PCI_SLOT(devfn) & 0x1f) << PCIE_EXT_SLOT_SHIFT)
> -		| ((PCI_FUNC(devfn) & 0x07) << PCIE_EXT_FUNC_SHIFT)
> -		| (busnr << PCIE_EXT_BUSNUM_SHIFT)
> -		| (reg & ~3);
> -}
> -
>  static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
>  					int where)
>  {
> @@ -716,7 +704,7 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
>  		return PCI_SLOT(devfn) ? NULL : base + where;
>  
>  	/* For devices, write to the config space index register */
> -	idx = brcm_pcie_cfg_index(bus->number, devfn, 0);
> +	idx = PCIE_ECAM_OFFSET(bus->number, devfn, 0);
>  	writel(idx, pcie->base + PCIE_EXT_CFG_INDEX);
>  	return base + PCIE_EXT_CFG_DATA + where;
>  }
[...]

Passing the hard-coded 0 as the "reg" argument here never actually did
anything, thus the 32 bit alignment was never correctly enforced.

My question would be: should this be 32 bit aligned?  It seems like the
intention was to perhaps make the alignment?  I am sadly not intimately
familiar with his hardware, so I am not sure if there is something to
fix here or not.

Also, I wonder whether it would be safe to pass the offset (the "where"
variable) rather than hard-coded 0?

Thank you for help in advance!

Bjorn also asked the same question:
  https://lore.kernel.org/linux-pci/20201120203428.GA272511@bjorn-Precision-5520/

Krzysztof
