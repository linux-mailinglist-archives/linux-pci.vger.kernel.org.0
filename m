Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26DD54D206
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 17:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfFTPWg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 11:22:36 -0400
Received: from foss.arm.com ([217.140.110.172]:44334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfFTPWf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 11:22:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEF0E28;
        Thu, 20 Jun 2019 08:22:34 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AD953F246;
        Thu, 20 Jun 2019 08:22:33 -0700 (PDT)
Date:   Thu, 20 Jun 2019 16:22:31 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     thierry.reding@gmail.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V6 06/27] PCI: tegra: Add PCIe Gen2 link speed support
Message-ID: <20190620152231.GB23729@e121166-lin.cambridge.arm.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
 <20190618180206.4908-7-mmaddireddy@nvidia.com>
 <20190620143251.GB31996@e121166-lin.cambridge.arm.com>
 <d46fbde3-1e42-e7b6-8926-efb599ad335f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d46fbde3-1e42-e7b6-8926-efb599ad335f@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 20, 2019 at 08:27:15PM +0530, Manikanta Maddireddy wrote:
> 
> 
> On 20-Jun-19 8:02 PM, Lorenzo Pieralisi wrote:
> > On Tue, Jun 18, 2019 at 11:31:45PM +0530, Manikanta Maddireddy wrote:
> >> Tegra124, Tegra132, Tegra210 and Tegra186 support Gen2 link speed. After
> >> PCIe link is up in Gen1, set target link speed as Gen2 and retrain link.
> >> Link switches to Gen2 speed if Gen2 capable end point is connected, else
> >> link stays in Gen1.
> >>
> >> Per PCIe 4.0r0.9 sec 7.6.3.7 implementation note, driver need to wait for
> >> PCIe LTSSM to come back from recovery before retraining the link.
> >>
> >> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> >> Acked-by: Thierry Reding <treding@nvidia.com>
> >> ---
> >> V6: No change
> >>
> >> V5: No change
> >>
> >> V4: No change
> >>
> >> V3: Added blank line after each while loop.
> >>
> >> V2: Changed "for loop" to "while", to make it compact and handled coding
> >> style comments.
> >>
> >>  drivers/pci/controller/pci-tegra.c | 64 ++++++++++++++++++++++++++++++
> >>  1 file changed, 64 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> >> index 5e9fcef5f8eb..5d19067f7193 100644
> >> --- a/drivers/pci/controller/pci-tegra.c
> >> +++ b/drivers/pci/controller/pci-tegra.c
> >> @@ -191,6 +191,8 @@
> >>  #define  RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE	0x20000000
> >>  #define  RP_LINK_CONTROL_STATUS_LINKSTAT_MASK	0x3fff0000
> >>  
> >> +#define RP_LINK_CONTROL_STATUS_2		0x000000b0
> >> +
> >>  #define PADS_CTL_SEL		0x0000009c
> >>  
> >>  #define PADS_CTL		0x000000a0
> >> @@ -226,6 +228,7 @@
> >>  #define PADS_REFCLK_CFG_DRVI_SHIFT		12 /* 15:12 */
> >>  
> >>  #define PME_ACK_TIMEOUT 10000
> >> +#define LINK_RETRAIN_TIMEOUT 100000 /* in usec */
> >>  
> >>  struct tegra_msi {
> >>  	struct msi_controller chip;
> >> @@ -2089,6 +2092,64 @@ static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
> >>  	return false;
> >>  }
> >>  
> >> +static void tegra_pcie_change_link_speed(struct tegra_pcie *pcie)
> >> +{
> >> +	struct device *dev = pcie->dev;
> >> +	struct tegra_pcie_port *port, *tmp;
> >> +	ktime_t deadline;
> >> +	u32 value;
> >> +
> >> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> > And the reason to use the _safe version is ?
> >
> > Lorenzo
> 
> This function is called in probe and resume_noirq. list entry is deleted in
> remove, I don't see any scenario where it can cause a race condition.
> It is fine to drop _safe. I will fix it in next version.

I will do it myself, it is not a fundamental issue, do not send another
version.

Thanks,
Lorenzo
