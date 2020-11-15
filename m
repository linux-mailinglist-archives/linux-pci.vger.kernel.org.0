Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4E62B32A5
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 06:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgKOFvC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Nov 2020 00:51:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40590 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgKOFvC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2020 00:51:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id 33so14752945wrl.7
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2020 21:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Ar1HS0TIigbtEbbtbsrbeVh6VW06RBSYq0BlrEFWlQ=;
        b=sgkm1xLOZig6QWGEPSj/OBqZT3xXDgH6/SXFU+Z7XE+E3SICAgmcSN1+mYjg0NTUfF
         20KnRF+xgMESjgJXpc1SkSrulnixqMit27XfkUDPgcFqZo7uAJzGDPZ8kMdKVF/KbNzV
         W4Pwce2yZEdCGLVNmcyDOVc2d408iQJKF1/67EGTQumKdTs7pZ+0DqIOUY7Ueaqh5oLe
         ZiNBMZVmmoL7ebcLz1qGwD5bXXhValW9gzfI4fcXXxwrw1Er2MLYWta5edReZTxXLxBL
         SWNJyFQ9QRES3jkAoDr7M6tgtUtF8CNaj4kPHSmoMjKrQIMF4jrC1+Iuy/qL2a2aQjWG
         XOMw==
X-Gm-Message-State: AOAM531hWfZwTjjR6bGAFTbr2vAk/8YyHG6JecpTD/saXqYjdUXxuJsB
        1h2I8I16KZv0V3Zg4YEGIOk=
X-Google-Smtp-Source: ABdhPJyyWlqOi881rwwar8nssPXB4LzlZhjcTUAVcp2Ix24BVuoPkzt7VIFoWPh+xOxI1NRrikiLUw==
X-Received: by 2002:a05:6000:345:: with SMTP id e5mr12059182wre.333.1605419460016;
        Sat, 14 Nov 2020 21:51:00 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id g11sm17547121wrq.7.2020.11.14.21.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 21:50:59 -0800 (PST)
Date:   Sun, 15 Nov 2020 06:50:57 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
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
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v4] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <X7DBwZ5cJrbQspM+@rocinante>
References: <20201005003805.465057-1-kw@linux.com>
 <429099a8-5186-40c3-f5c0-f219b3e79f01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <429099a8-5186-40c3-f5c0-f219b3e79f01@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-10-04 19:53:06, Florian Fainelli wrote:

Hi Florian,

Sorry for taking a long time to get back to you.

[...]
> This appears to be correct, so:
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thank you!
 
> however, I would have defined a couple of additional helper macros and do:
> 
> 	idx = PCIE_ECAM_BUS(bus->number) | PCIE_ECAM_DEV(devfn) |
> PCIE_ECAM_FUN(devfn);
> 
> for clarity.
> 
[...]
> For instance, adding these two:
> 
> #define PCIE_ECAM_DEV(x)		(((x) & 0x1f) << PCIE_ECAM_DEV_SHIFT)
> #define PCIE_ECAM_FUN(x)		(((x) & 0x7) << PCIE_ECAM_FUN_SHIFT)
> 
> may be clearer for use in drivers like pcie-brcmstb.c that used to treat the
> device function in terms of device and function (though it was called slot
> there).

Regarding the suggestion above - it has been like that initially, albeit
Bjorn suggested that there is no need to reply on the macros that use
PCI_SLOT() and PCI_FUNC() macros, see:

https://lore.kernel.org/linux-pci/20200922232715.GA2238688@bjorn-Precision-5520/

I would be happy to put the macros back if there is a value in having
the extra macros added - perhaps for clarify, as you suggest.

Krzysztof
