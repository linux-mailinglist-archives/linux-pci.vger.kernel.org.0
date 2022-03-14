Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB1D4D88F9
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 17:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242889AbiCNQXC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 12:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241710AbiCNQXC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 12:23:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC6B17E23
        for <linux-pci@vger.kernel.org>; Mon, 14 Mar 2022 09:21:50 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id o8so14281926pgf.9
        for <linux-pci@vger.kernel.org>; Mon, 14 Mar 2022 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qALLnaCSSKUHcfprNAAItch631Ge5KfRQPx2pUNLQTQ=;
        b=H7D/n0JbKj9EjOt8JtzKTXMQH0CNTpYB4I8wApB4Rmv61PHXEWj9mIPqgO05ZTyBRV
         gGQOTLYfGzzw1FdftrzkIh6XmORv26rbqjicyHqSgwyZQEb8kvdu+uMfyc1qS98htKOL
         qldzP/g9QTFXumZOPLV1iMBVFyiv24zQIs4wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qALLnaCSSKUHcfprNAAItch631Ge5KfRQPx2pUNLQTQ=;
        b=zAupPxu9oMS2NEa39RTXtnoQ/j4hYPNpI+P5fF+1FwRtmqeCVk6+1GElGVo6N/vUQX
         ZuqOBpSkR5INgazkgOGrTPBw6FnT9dwIA/oKVgVt3ENyxu1IxVr3LlKD6i6PedznbI+6
         1/lsTdwKUHQCvOe53I1pyoSqLaSMiVJ/NWMn9SGIRxzYlT/2dGVQ2BJERwk+OyoAne4s
         uyujnm9BqWfHr2oG4z0UNgmCscHzDxLFYAh6x5Drw4B8N/Ii0WW2rPLl8fOYyhZVHPlk
         etoYhuTmwgFL5tXI6Q8dLl2pT182+ajefdpwFdS8salykQyVilxS+i7VsZAE7NmxSJol
         ubzw==
X-Gm-Message-State: AOAM533B97Z7ekJUbTFoFrp6D6xiFWwPzyrgNBo81Mj5t2McmEAjAWaW
        AditkVeopZxrYNTQjanSPFzY3w==
X-Google-Smtp-Source: ABdhPJywlNfTDHCbCn7W5tk/3WvfHJOH4isiXUJsYK3fHzRwOBGDMLdgv9KHuQlVH/xNrUex2nFbYw==
X-Received: by 2002:a65:6091:0:b0:35e:d274:5f54 with SMTP id t17-20020a656091000000b0035ed2745f54mr20676714pgu.200.1647274910285;
        Mon, 14 Mar 2022 09:21:50 -0700 (PDT)
Received: from ebps (cpe-75-80-179-40.san.res.rr.com. [75.80.179.40])
        by smtp.gmail.com with ESMTPSA id c3-20020a056a00248300b004f6f729e485sm21916449pfv.127.2022.03.14.09.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:21:49 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:21:46 -0700
From:   Eric Badger <ebadger@purestorage.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1] PCI/AER: Handle Multi UnCorrectable/Correctable
 errors properly
Message-ID: <20220314162146.GA1439451@ebps>
References: <20220311025807.14664-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220313195220.GA436941@bhelgaas>
 <20220313214314.GD182809@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313214314.GD182809@otc-nc-03>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 13, 2022 at 02:43:14PM -0700, Raj, Ashok wrote:
> On Sun, Mar 13, 2022 at 02:52:20PM -0500, Bjorn Helgaas wrote:
> > On Fri, Mar 11, 2022 at 02:58:07AM +0000, Kuppuswamy Sathyanarayanan wrote:
> > > Currently the aer_irq() handler returns IRQ_NONE for cases without bits
> > > PCI_ERR_ROOT_UNCOR_RCV or PCI_ERR_ROOT_COR_RCV are set. But this
> > > assumption is incorrect.
> > > 
> > > Consider a scenario where aer_irq() is triggered for a correctable
> > > error, and while we process the error and before we clear the error
> > > status in "Root Error Status" register, if the same kind of error
> > > is triggered again, since aer_irq() only clears events it saw, the
> > > multi-bit error is left in tact. This will cause the interrupt to fire
> > > again, resulting in entering aer_irq() with just the multi-bit error
> > > logged in the "Root Error Status" register.
> > > 
> > > Repeated AER recovery test has revealed this condition does happen
> > > and this prevents any new interrupt from being triggered. Allow to
> > > process interrupt even if only multi-correctable (BIT 1) or
> > > multi-uncorrectable bit (BIT 3) is set.
> > > 
> > > Reported-by: Eric Badger <ebadger@purestorage.com>
> > 
> > Is there a bug report with any concrete details (dmesg, lspci, etc)
> > that we can include here?
> 
> Eric might have more details to add when he collected numerous logs to get
> to the timeline of the problem. The test was to stress the links with an
> automated power off, this will result in some eDPC UC error followed by
> link down. The recovery worked fine for several cycles and suddenly there
> were no more interrupts. A manual rescan on pci would probe and device is
> operational again.

The problem was originally discovered while performing a looping hot plug
test. At hot remove time, one or more corrected errors usually appeared:

[256236.078151] pcieport 0000:89:02.0: AER: Corrected error received: 0000:89:02.0
[256236.078154] pcieport 0000:89:02.0: AER: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
[256236.088606] pcieport 0000:89:02.0: AER:   device [8086:347a] error status/mask=00000001/00000000
[256236.097857] pcieport 0000:89:02.0: AER:    [ 0] RxErr                 
[256236.152622] pcieport 0000:89:02.0: pciehp: Slot(400): Link Down
[256236.152623] pcieport 0000:89:02.0: pciehp: Slot(400): Card not present
[256236.152631] pcieport 0000:89:02.0: DPC: containment event, status:0x1f01 source:0x0000
[256236.152632] pcieport 0000:89:02.0: DPC: unmasked uncorrectable error detected reason 0 ext_reason 0
[256236.152634] pcieport 0000:89:02.0: AER: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
[256236.164207] pcieport 0000:89:02.0: AER:   device [8086:347a] error status/mask=00000020/00100000
[256236.173464] pcieport 0000:89:02.0: AER:    [ 5] SDES                   (First)
[256236.278407] pci 0000:8a:00.0: Removing from iommu group 32
[256237.500837] pcieport 0000:89:02.0: Data Link Layer Link Active not set in 1000 msec
[256237.500842] pcieport 0000:89:02.0: link reset at upstream device 0000:89:02.0 failed
[256237.500865] pcieport 0000:89:02.0: AER: Device recovery failed

The problematic case arose when 2 corrected errors arrived in a sequence like this:

1. Correctable error triggered, bit 0 (ERR_COR) set in Root Error Status,
   which now has value 0x1.
2. aer_irq() triggered, reads Root Error Status, finds value 0x1.
3. Second correctable error triggered, bit 1 (multiple ERR_COR) set in Root
   Error Status, which now has value 0x3.
4. aer_irq() writes back 0x1 to Root Error Status, which now has value 0x2.
5. aer_irq() triggered again due to the second error, but, finding value 0x2
   in Root Error Status, takes no action. Future interrupts are now inhibited.
  
My observation on Intel Icelake is that a new AER interrupt will be generated
when one writes to Root Error Status but other bits remain set. I concluded
this based on testing with ACPI EINJ and a hack like this:

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9fa1f97e5b27..5c9bbbe7887b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1196,6 +1196,10 @@ static irqreturn_t aer_irq(int irq, void *context)
 	struct aer_err_source e_src = {};
 
 	pci_read_config_dword(rp, aer + PCI_ERR_ROOT_STATUS, &e_src.status);
+
+	pci_dbg(pdev->port, "Root Error Status: %04x\n", e_src.status);
+	return IRQ_NONE;
+
 	if (!(e_src.status & (PCI_ERR_ROOT_UNCOR_RCV|PCI_ERR_ROOT_COR_RCV)))
 		return IRQ_NONE;
 
And then running these commands:

    # Prep injection data for a correctable error.
    $ cd /sys/kernel/debug/apei/einj
    $ echo 0x00000040 > error_type
    $ echo 0x4 > flags
    $ echo 0x891000 > param4
    
    # Root Error Status is initially clear
    $ setpci -s 89:02.0 ECAP0001+0x30.w
    0000
    
    # Inject one error
    $ echo 1 > error_inject
    
    # Interrupt received
    [  285.526275] pcieport 0000:89:02.0: AER: Root Error Status 0001
    
    # Inject another error
    $ echo 1 > error_inject
    
    # No interrupt received, but "multiple ERR_COR" is now set
    $ setpci -s 89:02.0 ECAP0001+0x30.w
    0003
    
    # Wait for a while, then clear ERR_COR. A new interrupt immediately fires.
    $ setpci -s 89:02.0 ECAP0001+0x30.w=0x1
    [  354.596748] pcieport 0000:89:02.0: AER: Root Error Status 0002


I've tried to track down some different hardware to confirm this behavior, but
haven't found any that can run this test.

My reading of the PCIe 5.0 spec, section "6.2.4.1.2 Interrupt Generation"
doesn't seem to describe the behavior I saw on Icelake.

	If a Root Port or Root Complex Event Collector is enabled for
	edge-triggered interrupt signaling using MSI or MSI-X, an interrupt
	message must be sent every time the logical AND of the following
	conditions transitions from FALSE to TRUE:
	...
    At least one Error Reporting Enable bit in the Root Error Command
    register and its associated error Messages Received bit in the Root
    Error Status register are both set to 1b.

This section of the spec seems to say that, if Root Error Status sees the
sequence of values described above (0x1->0x3->0x2), only one interrupt would
be generated, since there was no FALSE to TRUE transition at 0x3->0x2.  So you
would need something analogous to:

8edf5332c3934 ("PCI: pciehp: Fix MSI interrupt race")

However, this seems not to be the case for Icelake.

Cheers,
Eric
