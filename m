Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2894316E1
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 13:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhJRLLK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 07:11:10 -0400
Received: from foss.arm.com ([217.140.110.172]:35624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhJRLLK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Oct 2021 07:11:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33A1E101E;
        Mon, 18 Oct 2021 04:08:59 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2D8C3F882;
        Mon, 18 Oct 2021 04:08:57 -0700 (PDT)
Date:   Mon, 18 Oct 2021 12:08:52 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] PCI: apple: Add of_node_put() before return
Message-ID: <20211018110852.GA17623@lpieralisi>
References: <20211015080920.17619-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015080920.17619-1-wanjiabing@vivo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 15, 2021 at 04:09:20AM -0400, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/pci/controller/pcie-apple.c:771:1-23: WARNING: Function
> for_each_child_of_node should have of_node_put() before return
> 
> Early exits from for_each_child_of_node should decrement the
> node reference counter.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/pci/controller/pcie-apple.c | 1 +
>  1 file changed, 1 insertion(+)

Squashed in the commit it is fixing, updated my pci/apple branch.

Thanks,
Lorenzo

> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index b4db7a065553..13101389e988 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -772,6 +772,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
>  		ret = apple_pcie_setup_port(pcie, of_port);
>  		if (ret) {
>  			dev_err(pcie->dev, "Port %pOF setup fail: %d\n", of_port, ret);
> +			of_node_put(of_port);
>  			return ret;
>  		}
>  	}
> -- 
> 2.20.1
> 
