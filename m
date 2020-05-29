Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772921E85A7
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 19:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgE2RtC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 13:49:02 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39959 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2RtC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2020 13:49:02 -0400
Received: by mail-io1-f65.google.com with SMTP id q8so233545iow.7;
        Fri, 29 May 2020 10:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BLn5568WhOcT6+u2ym9/jBhSyqxnYH4n/L9rj2t60QE=;
        b=d54Y283E1oQ+RjivvIpjdY9uNABr5wdispcYRSKOHcKa9/rUU34cTLD3XdajfnzzhS
         FDFS/frsja7WGqBBmoDx9cvAp/dh+A9b504SX8x3NwTQJcGDnOoI5tU3AA5Nb6HvUvQy
         QlJ0a578sr6ytgdqOzjJ2VyU7DUAwz5FNQOgQPuyy55+kdT5gYl64R8oB7BI+SIbsJDh
         Fn4HG7ms2wSFzurdV6NebxCkPVzOI3HUPUZkHnya7L93gsW6w57D7iJeIBYnoLfxaYVD
         4+yScvvXkk5+NO6LukXr9A1qjTJYWg7XJUryX0UOxCdjzquhBvW46DLWD1Z+pjd/liYF
         NyiA==
X-Gm-Message-State: AOAM53259brQHbu8tkTd9wo8PEiTLcvulzL/TY3G9AXUwJ3Ct+a1SEk9
        JP1MuK57hR+lwPpywtMsxg==
X-Google-Smtp-Source: ABdhPJy7YUF3lpxrD7YMnpI0UvB3HdDPYFVO6rRfufgNQwXAXOB9FeWO8U/8UblJM9K1CPtEmWfdwQ==
X-Received: by 2002:a02:1443:: with SMTP id 64mr2603674jag.43.1590774540749;
        Fri, 29 May 2020 10:49:00 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t22sm4001987iom.49.2020.05.29.10.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 10:49:00 -0700 (PDT)
Received: (nullmailer pid 2643995 invoked by uid 1000);
        Fri, 29 May 2020 17:48:58 -0000
Date:   Fri, 29 May 2020 11:48:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Corey Minyard <minyard@acm.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
        Julien Grall <julien.grall@arm.com>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v2 00/14] PCI: brcmstb: enable PCIe for STB chips
Message-ID: <20200529174858.GA2640397@bogus>
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526191303.1492-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 26, 2020 at 03:12:39PM -0400, Jim Quinlan wrote:
> v2:
> Commit: "device core: Add ability to handle multiple dma offsets"
>   o Added helper func attach_dma_pfn_offset_map() in address.c (Chistoph)
>   o Helpers funcs added to __phys_to_dma() & __dma_to_phys() (Christoph)
>   o Added warning when multiple offsets are needed and !DMA_PFN_OFFSET_MAP
>   o dev->dma_pfn_map => dev->dma_pfn_offset_map
>   o s/frm/from/ for dma_pfn_offset_frm_{phys,dma}_addr() (Christoph)
>   o In device.h: s/const void */const struct dma_pfn_offset_region */
>   o removed 'unlikely' from unlikely(dev->dma_pfn_offset_map) since
>     guarded by CONFIG_DMA_PFN_OFFSET_MAP (Christoph)
>   o Since dev->dma_pfn_offset is copied in usb/core/{usb,message}.c, now
>     dev->dma_pfn_offset_map is copied as well.
>   o Merged two of the DMA commits into one (Christoph).
> 
> Commit "arm: dma-mapping: Invoke dma offset func if needed":
>   o Use helper functions instead of #if CONFIG_DMA_PFN_OFFSET
> 
> Other commits' changes:
>   o Removed need for carrying of_id var in priv (Nicolas)
>   o Commit message rewordings (Bjorn)
>   o Commit log messages filled to 75 chars (Bjorn)
>   o devm_reset_control_get_shared())
>     => devm_reset_control_get_optional_shared (Philipp)
>   o Add call to reset_control_assert() in PCIe remove routines (Philipp)
> 
> v1:
> This patchset expands the usefulness of the Broadcom Settop Box PCIe
> controller by building upon the PCIe driver used currently by the
> Raspbery Pi.  Other forms of this patchset were submitted by me years
> ago and not accepted; the major sticking point was the code required
> for the DMA remapping needed for the PCIe driver to work [1].
> 
> There have been many changes to the DMA and OF subsystems since that
> time, making a cleaner and less intrusive patchset possible.  This
> patchset implements a generalization of "dev->dma_pfn_offset", except
> that instead of a single scalar offset it provides for multiple
> offsets via a function which depends upon the "dma-ranges" property of
> the PCIe host controller.  This is required for proper functionality
> of the BrcmSTB PCIe controller and possibly some other devices.

If you can enable the h/w support without the multiple offset support, 
then I'd split up this series. The latter part might take a bit more 
time.

Rob
