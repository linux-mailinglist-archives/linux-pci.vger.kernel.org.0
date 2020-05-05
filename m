Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877971C5458
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 13:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgEEL2C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 07:28:02 -0400
Received: from foss.arm.com ([217.140.110.172]:37734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgEEL2C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 07:28:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7500330E;
        Tue,  5 May 2020 04:28:01 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA6E83F305;
        Tue,  5 May 2020 04:28:00 -0700 (PDT)
Date:   Tue, 5 May 2020 12:27:58 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: functions/pci-epf-test: Avoid DMA
 release when DMA is unsupported
Message-ID: <20200505112758.GD13446@e121166-lin.cambridge.arm.com>
References: <1587540287-10458-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587540287-10458-1-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 22, 2020 at 04:24:47PM +0900, Kunihiko Hayashi wrote:
> When unbinding pci_epf_test, pci_epf_test_clean_dma_chan() is called in
> pci_epf_test_unbind() even though epf_test->dma_supported is false.
> As a result, dma_release_channel() will occur null pointer access because
> dma_chan isn't set.
> 
> This avoids calling dma_release_channel() if epf_test->dma_supported
> is false.
> 
> Fixes: a1d105d4ab8e ("PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer data")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied (with the proper Fixes: SHA-1 ID) to pci/endpoint, thanks.

Lorenzo

> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 60330f3e..c89a956 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -187,6 +187,9 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
>   */
>  static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
>  {
> +	if (!epf_test->dma_supported)
> +		return;
> +
>  	dma_release_channel(epf_test->dma_chan);
>  	epf_test->dma_chan = NULL;
>  }
> -- 
> 2.7.4
> 
