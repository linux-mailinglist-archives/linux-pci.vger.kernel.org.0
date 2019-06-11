Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF6D3C831
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2019 12:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404468AbfFKKJT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jun 2019 06:09:19 -0400
Received: from foss.arm.com ([217.140.110.172]:57476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbfFKKJT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jun 2019 06:09:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C19D9337;
        Tue, 11 Jun 2019 03:09:18 -0700 (PDT)
Received: from redmoon (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E0923F557;
        Tue, 11 Jun 2019 03:11:00 -0700 (PDT)
Date:   Tue, 11 Jun 2019 11:09:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH v2] PCI: endpoint: Clear BAR before freeing its space
Message-ID: <20190611100915.GD29976@redmoon>
References: <1558648647-14324-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558648647-14324-1-git-send-email-alan.mikhak@sifive.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 23, 2019 at 02:57:27PM -0700, Alan Mikhak wrote:
> Associated pci_epf_bar structure is needed in pci_epc_clear_bar() but
> would be cleared in pci_epf_free_space(), if called first, and BAR
> would not get cleared.
> 
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/endpoint for v5.3, thanks.

Lorenzo

> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 27806987e93b..f81a219dde5b 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -381,8 +381,8 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  		epf_bar = &epf->bar[bar];
>  
>  		if (epf_test->reg[bar]) {
> -			pci_epf_free_space(epf, epf_test->reg[bar], bar);
>  			pci_epc_clear_bar(epc, epf->func_no, epf_bar);
> +			pci_epf_free_space(epf, epf_test->reg[bar], bar);
>  		}
>  	}
>  }
> -- 
> 2.7.4
> 
