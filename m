Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9279C743145
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 01:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjF2Xz5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 19:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjF2Xz4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 19:55:56 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5AA102;
        Thu, 29 Jun 2023 16:55:54 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7836272f36eso56590639f.1;
        Thu, 29 Jun 2023 16:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688082954; x=1690674954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hco3GBCplDhEUQuXcF7xwdzFx9N07cdj82HcheoHCAE=;
        b=IBa9YENb5lyzjRdlcZLp5msKzZZMk/gJWCMQgql0joU8W3POtly9zo3IMqujNGfgRE
         MKwkWVeJnPgHKPWnY+pEiaDTi73TfohYVqqR6aFmvHBjyiNfSYHZS7rGc2dwk7nJHvir
         UKXSP58RBYmYQm78j3MVTMel4KL0hJEd5vNyaoeSRDggn7SCVmR+ei1gtmqNA8YSgJn/
         LQUtM3CLr+JTrLKYGlwwBiTrSLwBugpsrAJ9DaC1/7Hvx2EDKfcbKSJ4W/U7gnkl/opN
         5QakKgwyBSyQ/1cdD3BB1nBVJlm1R+g11Pal9ZwwbQloGDBs4d4xMLr02O+nIeKDBmFw
         Ictg==
X-Gm-Message-State: AC+VfDyMSHCzcdS2xYR+1h1ZZQYVbskw7JKVq5zYgSsGCyOGt/nh84Mi
        ZG8ZEPaTE20D1r7TpP07fcesiGzG3w==
X-Google-Smtp-Source: ACHHUZ4DsazPqj4iSeZUXwyxuCP6ikhXMNrQEqvy30Y8vGWwIpMvZz0QiWovPTiMUI66eF6/bqN/Cg==
X-Received: by 2002:a05:6602:2575:b0:77e:2883:13f3 with SMTP id dj21-20020a056602257500b0077e288313f3mr1049025iob.14.1688082954185;
        Thu, 29 Jun 2023 16:55:54 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id dq34-20020a0566384d2200b0042566919376sm4015422jab.30.2023.06.29.16.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 16:55:53 -0700 (PDT)
Received: (nullmailer pid 129695 invoked by uid 1000);
        Thu, 29 Jun 2023 23:55:51 -0000
Date:   Thu, 29 Jun 2023 17:55:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.zhen@amd.com, sonal.santan@amd.com,
        stefano.stabellini@xilinx.com
Subject: Re: [PATCH V10 2/5] PCI: Create device tree node for bridge
Message-ID: <20230629235551.GB92592-robh@kernel.org>
References: <1688059190-4225-3-git-send-email-lizhi.hou@amd.com>
 <20230629225631.GA446944@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629225631.GA446944@bhelgaas>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 29, 2023 at 05:56:31PM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 29, 2023 at 10:19:47AM -0700, Lizhi Hou wrote:
> > The PCI endpoint device such as Xilinx Alveo PCI card maps the register
> > spaces from multiple hardware peripherals to its PCI BAR. Normally,
> > the PCI core discovers devices and BARs using the PCI enumeration process.
> > There is no infrastructure to discover the hardware peripherals that are
> > present in a PCI device, and which can be accessed through the PCI BARs.
> 
> IIUC this is basically a multi-function device except that instead of
> each device being a separate PCI Function, they all appear in a single
> Function.  That would mean all the devices share the same config space
> so a single PCI Command register controls all of them, they all share
> the same IRQs (either INTx or MSI/MSI-X), any MMIO registers are likely
> in a shared BAR, etc., right?
> 
> Obviously PCI enumeration only sees the single Function and binds a
> single driver to it.  But IIUC, you want to use existing drivers for
> each of these sub-devices, so this series adds a DT node for the
> single Function (using the quirks that call of_pci_make_dev_node()).
> And I assume that when the PCI driver claims the single Function, it
> will use that DT node to add platform devices, and those existing
> drivers can claim those?
> 
> I don't see the PCI driver for the single Function in this series.  Is
> that coming?  Is this series useful without it?
> 
> > Apparently, the device tree framework requires a device tree node for the
> > PCI device. Thus, it can generate the device tree nodes for hardware
> > peripherals underneath. Because PCI is self discoverable bus, there might
> > not be a device tree node created for PCI devices. Furthermore, if the PCI
> > device is hot pluggable, when it is plugged in, the device tree nodes for
> > its parent bridges are required. Add support to generate device tree node
> > for PCI bridges.
> 
> Can you remind me why hot-adding a PCI device requires DT nodes for
> parent bridges?  I don't think we have those today, so maybe the DT
> node for the PCI device requires a DT parent?  How far up does that
> go?  From this patch, I guess a Root Port would be the top DT node on
> a PCIe system, since that's the top PCI-to-PCI bridge?
> 
> This patch adds a DT node for *every* PCI bridge in the system.  We
> only actually need that node for these unusual devices.  Is there some
> way the driver for the single PCI Function could add that node when it
> is needed?  Sorry if you've answered this in the past; maybe the
> answer could be in the commit log or a code comment in case somebody
> else wonders.
> 
> > @@ -340,6 +340,8 @@ void pci_bus_add_device(struct pci_dev *dev)
> >  	 */
> >  	pcibios_bus_add_device(dev);
> >  	pci_fixup_device(pci_fixup_final, dev);
> > +	if (pci_is_bridge(dev))
> > +		of_pci_make_dev_node(dev);
> 
> It'd be nice to have a clue here about why we need this, since this is
> executed for *every* system, even ACPI platforms that typically don't
> use OF things.
> 
> >  	pci_create_sysfs_dev_files(dev);
> >  	pci_proc_attach_device(dev);
> >  	pci_bridge_d3_update(dev);
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index 2c25f4fa0225..9786ae407948 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -487,6 +487,15 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
> >  		} else {
> >  			/* We found a P2P bridge, check if it has a node */
> >  			ppnode = pci_device_to_OF_node(ppdev);
> > +#if IS_ENABLED(CONFIG_PCI_DYNAMIC_OF_NODES)
> 
> I would use plain #ifdef here instead of IS_ENABLED(), as you did in
> pci.h below.  IS_ENABLED() is true if the Kconfig symbol is set to
> either "y" or "m".

Actually, IS_ENABLED() with a C 'if' rather than a preprocessor #if 
would work here and is preferred.

But this code and the "dynamic" property needs more discussion.

Rob
