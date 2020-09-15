Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8321269C30
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 04:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgIOC4x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 22:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgIOC4x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 22:56:53 -0400
X-Greylist: delayed 372 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Sep 2020 19:56:52 PDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A157C06174A
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2020 19:56:52 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id CDAA7100DA1BA;
        Tue, 15 Sep 2020 04:50:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 63CFE1D2EAD; Tue, 15 Sep 2020 04:50:33 +0200 (CEST)
Date:   Tue, 15 Sep 2020 04:50:33 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/2] PCI/portdrv: Remove the .remove() method in
 pcie_portdriver
Message-ID: <20200915025033.GA20456@wunner.de>
References: <20200913050129.GA10736@wunner.de>
 <20200913154235.GA1188391@bjorn-Precision-5520>
 <MN2PR12MB44881AF114C47613285A083BF7230@MN2PR12MB4488.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR12MB44881AF114C47613285A083BF7230@MN2PR12MB4488.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 14, 2020 at 08:34:03PM +0000, Deucher, Alexander wrote:
> FWIW, our newer GPUs have both upstream and downstream ports that are
> part of the device.
> 
> Slightly off topic, but does the current pm code handle these cases
> correctly?  ACPI related power handling doesn't seem to work correctly
> for these devices in laptops where the GPU power control is handled by
> ACPI.

PCIe ports are only suspended to D3 if pci_bridge_d3_possible() in
drivers/pci/pci.c returns true.  In particular, if the downstream
ports are hotplug-capable, they will *not* be suspended to D3 unless
"pcie_port_pm=force" is specified on the command line.  There was a
report of MCEs on Xeon-SP servers if hotplug ports were runtime suspended,
hence this rule.  Also, non-hotplug ports are not suspended if the BIOS
is older than 2015.

If the downstream ports are not suspended, by consequence the upstream
port above them isn't either.  So if the GPU is powered down by an ACPI
_PR3 method for the upstream port, that method may not be executed.

I think the _PR3 method for GPUs was located in the Root Port's namespace
so far.  If it's moved to a port below that, then it may be necessary to
adjust GPU driver code, e.g. where pci_pr3_present() is called (but that's
only called by nouveau and hda_intel.c AFAICS).

Thanks,

Lukas
