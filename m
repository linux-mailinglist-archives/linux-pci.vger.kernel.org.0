Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E866142C19A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 15:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhJMNnW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 09:43:22 -0400
Received: from foss.arm.com ([217.140.110.172]:39458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234903AbhJMNnV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 09:43:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8E5A1FB;
        Wed, 13 Oct 2021 06:41:17 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2C993F694;
        Wed, 13 Oct 2021 06:41:16 -0700 (PDT)
Date:   Wed, 13 Oct 2021 14:41:14 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: apple: Remove redundant initialization of
 pointer port_pdev
Message-ID: <20211013134114.GC11036@lpieralisi>
References: <20211012133235.260534-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012133235.260534-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 12, 2021 at 02:32:35PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer port_pdev is being initialized with a value that is never
> read, it is being updated later on. The assignment is redundant and
> can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pci/controller/pcie-apple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Squashed into the commit it is fixing.

Thanks !
Lorenzo

> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index b4db7a065553..19fd2d38aaab 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -634,7 +634,7 @@ static struct apple_pcie_port *apple_pcie_get_port(struct pci_dev *pdev)
>  {
>  	struct pci_config_window *cfg = pdev->sysdata;
>  	struct apple_pcie *pcie = cfg->priv;
> -	struct pci_dev *port_pdev = pdev;
> +	struct pci_dev *port_pdev;
>  	struct apple_pcie_port *port;
>  
>  	/* Find the root port this device is on */
> -- 
> 2.32.0
> 
