Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF04DA9B0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 12:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408756AbfJQKSd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 06:18:33 -0400
Received: from [217.140.110.172] ([217.140.110.172]:38176 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1731515AbfJQKSd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Oct 2019 06:18:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 867E91BB2;
        Thu, 17 Oct 2019 03:18:10 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E4093F718;
        Thu, 17 Oct 2019 03:18:09 -0700 (PDT)
Date:   Thu, 17 Oct 2019 11:18:07 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: make mvebu_pci_bridge_emul_ops static
Message-ID: <20191017101806.GB9589@e121166-lin.cambridge.arm.com>
References: <20191015160930.22899-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015160930.22899-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 15, 2019 at 05:09:30PM +0100, Ben Dooks (Codethink) wrote:
> The mvebu_pci_bridge_emul_ops is not exported outside
> of the driver, so make it static to avoid the following
> sparse warning:
> 
> drivers/pci/controller/pci-mvebu.c:557:28: warning: symbol 'mvebu_pci_bridge_emul_ops' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/pci/controller/pci-mvebu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/misc, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index d3a0419e42f2..ed032e9a3156 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -554,7 +554,7 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
>  	}
>  }
>  
> -struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops = {
> +static struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops = {
>  	.write_base = mvebu_pci_bridge_emul_base_conf_write,
>  	.read_pcie = mvebu_pci_bridge_emul_pcie_conf_read,
>  	.write_pcie = mvebu_pci_bridge_emul_pcie_conf_write,
> -- 
> 2.23.0
> 
