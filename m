Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1752D29E1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 12:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgLHLlQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 06:41:16 -0500
Received: from foss.arm.com ([217.140.110.172]:47738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbgLHLlQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 06:41:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82A201FB;
        Tue,  8 Dec 2020 03:40:30 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBDF03F68F;
        Tue,  8 Dec 2020 03:40:28 -0800 (PST)
Date:   Tue, 8 Dec 2020 11:40:23 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        truong@codeaurora.org
Subject: Re: [PATCH v5 0/5] Add PCIe support for SM8250 SoC
Message-ID: <20201208114023.GA31860@e121166-lin.cambridge.arm.com>
References: <20201027170033.8475-1-manivannan.sadhasivam@linaro.org>
 <20201208094712.GA30430@e121166-lin.cambridge.arm.com>
 <20201208104557.GA8081@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208104557.GA8081@work>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 08, 2020 at 04:15:57PM +0530, Manivannan Sadhasivam wrote:
> Hi Lorenzo,
> 
> On Tue, Dec 08, 2020 at 09:47:12AM +0000, Lorenzo Pieralisi wrote:
> > On Tue, Oct 27, 2020 at 10:30:28PM +0530, Manivannan Sadhasivam wrote:
> > > Hello,
> > > 
> > > This series adds PCIe support for Qualcomm SM8250 SoC with relevant PHYs.
> > > There are 3 PCIe instances on this SoC each with different PHYs. The PCIe
> > > controller and PHYs are mostly comaptible with the ones found on SDM845
> > > SoC, hence the old drivers are modified to add the support.
> > > 
> > > This series has been tested on RB5 board with QCA6391 chipset connected
> > > onboard.
> > 
> > Hi,
> > 
> > I would be merging this series, I understand patch {2) was already
> > taken by Vinod - should I take {1,3,4,5} via the pci tree ?
> > 
> 
> Vinod merged patches 1/5 and 2/5 as they belong to phy subsystem. You
> can take the rest of the patches via pci tree.

Would you mind rebasing them on top of my pci/dwc branch (with Bjorn's
tags) and resend them, I will apply them then.

Thanks,
Lorenzo
