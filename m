Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD0B3027CE
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 17:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbhAYQ1s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 11:27:48 -0500
Received: from foss.arm.com ([217.140.110.172]:50750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730716AbhAYQ0f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jan 2021 11:26:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 715041042;
        Mon, 25 Jan 2021 08:25:49 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 576B73F68F;
        Mon, 25 Jan 2021 08:25:48 -0800 (PST)
Date:   Mon, 25 Jan 2021 16:25:42 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jonathan Chocron <jonnyc@amazon.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH dwc-next v2 0/2] PCI: dwc: remove useless dw_pcie_ops
Message-ID: <20210125162542.GA5795@e121166-lin.cambridge.arm.com>
References: <20201120191611.7b84a86b@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120191611.7b84a86b@xhacker.debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 20, 2020 at 07:16:11PM +0800, Jisheng Zhang wrote:
> Some designware based device driver especially host only driver may
> work well with the default read_dbi/write_dbi/link_up implementation
> in pcie-designware.c, thus remove the assumption to simplify those
> drivers.
> 
> Since v1:
>   - rebase to the latest dwc-next
> 
> Jisheng Zhang (2):
>   PCI: dwc: Don't assume the ops in dw_pcie always exists
>   PCI: dwc: al: Remove useless dw_pcie_ops
> 
>  drivers/pci/controller/dwc/pcie-al.c              |  4 ----
>  drivers/pci/controller/dwc/pcie-designware-ep.c   |  8 +++-----
>  drivers/pci/controller/dwc/pcie-designware-host.c |  2 +-
>  drivers/pci/controller/dwc/pcie-designware.c      | 14 +++++++-------
>  4 files changed, 11 insertions(+), 17 deletions(-)

Would you mind rebasing it against my current pci/dwc branch please ?

I shall apply it then.

Thanks,
Lorenzo
