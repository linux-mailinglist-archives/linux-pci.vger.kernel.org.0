Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 683BF8CCFE
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 09:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfHNHgI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Aug 2019 03:36:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfHNHgI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2019 03:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/9vf3+fl+e1zoOcbUV8lxlGbJPXutwl+wZG2EQhhqm4=; b=ZyMfyP3oWYGUfjB7y7gL1xans
        /Ee0nnIGoncTJrGUFJ6RmlhBfHZ0fPZLzFR2QQiWSQ0j5l5+a/niHqLxe/z2pDYq59dmTQHX3JYmV
        9/4DPd/8naL5dsxRR51RAa/vWUABkiybdpJkKNF8rsSymNdm5NchKjsAo7F+hHDKgbOazOuYBrqhM
        nLRDPMYGQTI1Ro1GD4loGCVdPXhJzaTpnTsw8oTrKl0c6mhztBUXIwqv7S5mlPeg4tiu/2cX2APfg
        SLu5oztA/ZuUI5656XFIVHQu3Qh6+BvKSteYzc7EsYmC2CZy9m9D0DSBg+/qEfdaV8zoW6R2wDDAJ
        dUPxbYttw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxnpF-00016n-DB; Wed, 14 Aug 2019 07:36:05 +0000
Date:   Wed, 14 Aug 2019 00:36:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com
Subject: Re: [PATCH] PCI: dwc: Add map irq callback
Message-ID: <20190814073605.GA31526@infradead.org>
References: <333e87c8ea92cd7442fbe874fc8c9eccabc62f58.1565763869.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <333e87c8ea92cd7442fbe874fc8c9eccabc62f58.1565763869.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 14, 2019 at 02:56:49PM +0800, Dilip Kota wrote:
> Certain platforms like Intel need to configure
> registers to enable the interrupts.
> Map Irq callback helps to perform platform specific
> configurations while assigning or enabling the interrupts.

This seems to miss the hunk that actually assigns the map_irq
callback.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f93252d0da5b..5880d2b72ef8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -470,7 +470,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	bridge->sysdata = pp;
>  	bridge->busnr = pp->root_bus_nr;
>  	bridge->ops = &dw_pcie_ops;
> -	bridge->map_irq = of_irq_parse_and_map_pci;
> +	bridge->map_irq = pp->map_irq ? pp->map_irq : of_irq_parse_and_map_pci;

Pleae just use a classic if / else to make the code a little easier
to read.
