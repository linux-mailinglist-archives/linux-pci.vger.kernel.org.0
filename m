Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0420D293896
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 11:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404822AbgJTJze (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 05:55:34 -0400
Received: from foss.arm.com ([217.140.110.172]:48878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404533AbgJTJze (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Oct 2020 05:55:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2061B101E;
        Tue, 20 Oct 2020 02:55:34 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D95F13F66E;
        Tue, 20 Oct 2020 02:55:32 -0700 (PDT)
Date:   Tue, 20 Oct 2020 10:55:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
Message-ID: <20201020095527.GA21814@e121166-lin.cambridge.arm.com>
References: <20200916054130.8685-1-Zhiqiang.Hou@nxp.com>
 <20201015224738.GA24466@bjorn-Precision-5520>
 <HE1PR0402MB3371CD54946A513C12A5ABC2841E0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <7778161f-b87c-5499-b4e6-de0550bc165c@ti.com>
 <HE1PR0402MB337161161D04C34247C1D876841F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0402MB337161161D04C34247C1D876841F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 20, 2020 at 02:13:13AM +0000, Z.q. Hou wrote:

[...]

> > > For NXP Layerscape platforms (the ls1028a and ls2088a are also NXP
> > Layerscape platform), as the error response to AXI/AHB was enabled, it will
> > get UR error and trigger SError on AXI bus when it accesses a non-existent
> > BDF on a link down bus. I'm not clear about how it happens on dra7xxx and
> > imx6, since they doesn't enable the error response to AXI/AHB.
> > 
> > That's exactly the case with DRA7xx as the error response is enabled by
> > default in the platform integration.
> 
> Got feedback from the imx6 owner that imx6 like the dra7xx has the
> error response enabled by default.  Now it's clear that the problem on
> all these platforms is the same.

On IMX6, enabled by default and read-only ? Or it can be changed ? What's
the plan for layerscape on this matter ?

Lorenzo
