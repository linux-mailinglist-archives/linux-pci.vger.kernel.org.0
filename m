Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297F725FD15
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 17:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgIGPQm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 11:16:42 -0400
Received: from foss.arm.com ([217.140.110.172]:38200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730055AbgIGPQb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 11:16:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1502B31B;
        Mon,  7 Sep 2020 08:16:02 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DB493F73C;
        Mon,  7 Sep 2020 08:16:01 -0700 (PDT)
Date:   Mon, 7 Sep 2020 16:15:55 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI: cadence-ep: Remove obsolete path from comment
Message-ID: <20200907151555.GA10272@e121166-lin.cambridge.arm.com>
References: <20200623074851.7832-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623074851.7832-1-f.suligoi@asem.it>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 23, 2020 at 09:48:51AM +0200, Flavio Suligoi wrote:
> This comment still refers to the old driver pathname,
> when all PCI drivers were located directly under the
> drivers/pci directory.
> 
> Anyway the function name itself is enough, so we can
> remove the overabundant path reference.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
> 
> v1: - after the suggestion of Bjorn, remove the whole comment line related to
>       the wrong path
>     - add: Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> V2: - change the subject line according to the previous commits of the
>       same file
>     - remove wrong "Acked-by ..."
> 
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to pci/cadence, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 1c15c8352125..690eefd328ea 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -276,7 +276,6 @@ static int cdns_pcie_ep_send_legacy_irq(struct cdns_pcie_ep *ep, u8 fn, u8 intx)
>  	cdns_pcie_ep_assert_intx(ep, fn, intx, true);
>  	/*
>  	 * The mdelay() value was taken from dra7xx_pcie_raise_legacy_irq()
> -	 * from drivers/pci/dwc/pci-dra7xx.c
>  	 */
>  	mdelay(1);
>  	cdns_pcie_ep_assert_intx(ep, fn, intx, false);
> -- 
> 2.17.1
> 
