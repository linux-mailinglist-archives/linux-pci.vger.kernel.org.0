Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274634B571
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 11:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbfFSJu5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 05:50:57 -0400
Received: from foss.arm.com ([217.140.110.172]:58806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfFSJu4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 05:50:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2176A344;
        Wed, 19 Jun 2019 02:50:56 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 168763F738;
        Wed, 19 Jun 2019 02:52:40 -0700 (PDT)
Date:   Wed, 19 Jun 2019 10:50:52 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, thierry.reding@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        vidyas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V6 20/27] PCI: tegra: Disable MSI for Tegra PCIe root port
Message-ID: <20190619095052.GB10372@e121166-lin.cambridge.arm.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
 <20190618180206.4908-21-mmaddireddy@nvidia.com>
 <20190618194830.GA110859@google.com>
 <e06f85eb-be0c-c2a5-84a9-51aa9b8372c3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e06f85eb-be0c-c2a5-84a9-51aa9b8372c3@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 19, 2019 at 09:25:54AM +0530, Manikanta Maddireddy wrote:

[...]

> > s/msi/MSI/
> >
> > What's going on here?  Vidya posted a very similar patch [1] (although
> 
> This series is focused on Tegra20, Tegra30, Tegra124, Tegra210 and Tegra186,
> whereas Vidya's series is focused only on Tegra194. So I didn't include
> Tegra194 device IDs.
> 
> > his included nice spec citations, which you omitted), but his added
> > quirks for 0x1ad0, 0x1ad1, and 0x1ad2.  You didn't include any of
> > those here.
> >
> > Maybe Lorenzo will sort this all out, but it would make things easier
> > if you and Vidya got together and integrated your patches yourselves
> > so Lorenzo didn't have to worry about it.
> >
> > [1] https://lore.kernel.org/lkml/20190612095339.20118-3-vidyas@nvidia.com
> 
> I talked with Vidya, he will take this changes in his series if he needs
> to publish another version, or else he will publish a new patch to add
> quirk for legacy Tegra SOCs.
> 
> Lorenzo,
> If this series is ready for integration, please drop this patch.

OK, will do.

Thanks,
Lorenzo

> Manikanta
> 
> >
> >> + */
> >> +static void pci_quirk_nvidia_tegra_disable_rp_msi(struct pci_dev *dev)
> >> +{
> >> +	dev->no_msi = 1;
> >> +}
> >> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf0,
> >> +			      PCI_CLASS_BRIDGE_PCI, 8,
> >> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> >> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1,
> >> +			      PCI_CLASS_BRIDGE_PCI, 8,
> >> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> >> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c,
> >> +			      PCI_CLASS_BRIDGE_PCI, 8,
> >> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> >> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d,
> >> +			      PCI_CLASS_BRIDGE_PCI, 8,
> >> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> >> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e12,
> >> +			      PCI_CLASS_BRIDGE_PCI, 8,
> >> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> >> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e13,
> >> +			      PCI_CLASS_BRIDGE_PCI, 8,
> >> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> >> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0fae,
> >> +			      PCI_CLASS_BRIDGE_PCI, 8,
> >> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> >> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0faf,
> >> +			      PCI_CLASS_BRIDGE_PCI, 8,
> >> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> >> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e5,
> >> +			      PCI_CLASS_BRIDGE_PCI, 8,
> >> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> >> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e6,
> >> +			      PCI_CLASS_BRIDGE_PCI, 8,
> >> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> >> +
> >>  /*
> >>   * Some versions of the MCP55 bridge from Nvidia have a legacy IRQ routing
> >>   * config register.  This register controls the routing of legacy
> >> -- 
> >> 2.17.1
> >>
> 
