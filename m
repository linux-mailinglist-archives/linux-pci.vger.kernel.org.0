Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8E3669419
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 11:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjAMK2Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 05:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbjAMK1u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 05:27:50 -0500
X-Greylist: delayed 481 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Jan 2023 02:27:25 PST
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E0F1A069
        for <linux-pci@vger.kernel.org>; Fri, 13 Jan 2023 02:27:25 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 22C14100E200A;
        Fri, 13 Jan 2023 11:19:08 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id ECC7DA460A; Fri, 13 Jan 2023 11:18:57 +0100 (CET)
Date:   Fri, 13 Jan 2023 11:18:57 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <bjorn.helgaas@gmail.com>
Cc:     Yang Su <yang.su@linux.alibaba.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>
Subject: Re: [PATCH 3/3] PCI/DPC: Await readiness of secondary bus after reset
Message-ID: <20230113101857.GB29495@wunner.de>
References: <20230112223533.GA1798809@bhelgaas>
 <15135d89-0515-d965-567b-79b3eca236e6@linux.alibaba.com>
 <CABhMZUWYxN0iuCJumGVH123E52L17Ow-De5FuX=bfDF3o6A_-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABhMZUWYxN0iuCJumGVH123E52L17Ow-De5FuX=bfDF3o6A_-A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 12, 2023 at 09:06:15PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 12, 2023 at 8:39 PM Yang Su <yang.su@linux.alibaba.com> wrote:
> > I also test pci_bridge_wait_for_secondary_bus in NVIDIA GPU T4
> > which bind vfio passthrough in VMM, I found the
> > pci_bridge_wait_for_secondary_bus can not wait the enough time
> > as pci spec requires, the reasons are described as below.
[...]
> I'll wait for you and Lukas to continue this conversation on the
> mailing list.

Yang Su reports that pci_bridge_secondary_bus_reset() is called for
an Nvidia T4 GPU.  That's an endpoint device but the function should
only ever be called for bridges.  It's unclear to me how that can happen.

The call stack looks like this:

vfio_pci_open()
  pci_set_power_state()
  pci_clear_master()
  pci_enable_device()
  pci_try_reset_function()
    pci_dev_trylock()
    pci_dev_save_and_disable()
    pci_dev_specific_reset()
    pcie_has_flr()
    pcie_af_flr()
    pci_read_config_word()
    pci_dev_reset_slot_function()
    pci_parent_bus_reset()
      pci_bridge_secondary_bus_reset()
        pcibios_reset_secondary_bus()
	  pci_reset_secondary_bus()
	    pci_read_config_word()
	    pci_write_config_word()
	    pci_write_config_word()
	    pcie_wait_for_link_delay()
	pci_dev_wait()
    pci_dev_restore()
    pci_cfg_access_unlock()
  pci_save_state()
  pci_store_saved_state()
  vfio_config_init()

Note that vfio_pci_open() was renamed to vfio_pci_open_device() with
commit 2cd8b14aaa66, which went into v5.15.  So apparently this call
stack is from an earlier kernel.

The GPU is located below a PEX9797 switch, which is connected to a
SkyLake-E Root Port.  So pci_bridge_secondary_bus_reset() should be
called for the Switch Downstream Port but Yang Su says it's called
for the GPU endpoint device.

pci_parent_bus_reset() finds the parent by following dev->bus->self.
I've suggested to Yang Su to replace that with pci_upstream_bridge(dev)
and see if it fixes the issue.  It does make a difference in SR-IOV
scenarios (see the comment in include/linux/pci.h above pci_is_root_bus())
though Yang Su reports that SR-IOV is not used on this machine,
only vfio passthrough.

I believe that endpoint devices don't have a Bridge Control Register
(Type 0 Config Space has Max_Lat / Min_Gnt instead), so setting the
Secondary Bus Reset bit should have no effect.  But apparently it
does have an effect because Yang Su is witnessing issues with the delay
after reset.

Specifically, Yang Su says that pci_bridge_wait_for_secondary_bus()
bails out because the GPU endpoint device fails the !pci_is_bridge()
check at the top of the function.  Also, the calculation of
pci_bus_max_d3cold_delay() fails because the GPU lacks a subordinate bus.
Apparently the unconditional 1 second delay in pci_reset_secondary_bus()
papers over the issue because it waits long enough for the GPU endpoint
device to come out of reset.

Maybe the information that pci_bridge_secondary_bus_reset() is executed
for an endpoint device is not correct and it's in fact executed for
the Downstream Port of the PEX9797 switch, but perhaps config space
of the port is broken and contains an incorrect Header Type field,
which would cause pci_is_bridge() to return false for it.  Though we
wouldn't scan the secondary bus below the switch in that case,
so the GPU wouldn't be enumerated.  I've requested "lspci -vvv" output
for the GPU and the Downstream Port off-list but haven't received it yet.

Thanks,

Lukas
