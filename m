Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58FF51195BE
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 22:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfLJVXC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 16:23:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:53090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728920AbfLJVXB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 16:23:01 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06E8D205C9;
        Tue, 10 Dec 2019 21:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012980;
        bh=jgZTmZ2JHLxkkhkw15N7CWxyAqm2EjktUnApqMjONyY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=X7ANq6rpHSZ3n/QITEPYW2/gTZgG9Llo1ZR//ZMXcNQPBid9RbsYMc323lO4z5Pz7
         C9ubTOu/wkaH9vJlvmYEpdTUinlko+x+8gj+JBgPql729UFvy2wMvFFXWD3TmpbcFS
         TfLEb0jw/zhoOcGY0FlaiW1hrY4Of5SqwGzyEZOI=
Date:   Tue, 10 Dec 2019 15:22:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Armen Baloyan <abaloyan@gigaio.com>
Cc:     logang@deltatee.com, armbaloyan@gmail.com, epilmore@gigaio.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Add Intel SkyLake-E to the whitelist
Message-ID: <20191210212258.GA144914@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575669165-31697-1-git-send-email-abaloyan@gigaio.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 06, 2019 at 01:52:45PM -0800, Armen Baloyan wrote:
> Intel SkyLake-E was successfully tested for p2pdma
> transactions spanning over a host bridge and PCI
> bridge with IOMMU on.
> 
> Signed-off-by: Armen Baloyan <abaloyan@gigaio.com>

Applied with Logan's reviewed-by to pci/p2pdma for v5.6, thanks!

Logan, the commit log for 494d63b0d5d0 ("PCI/P2PDMA: Whitelist some
Intel host bridges") says:

    Intel devices do not have good support for P2P requests that span different
    host bridges as the transactions will cross the QPI/UPI bus and this does
    not perform well.

    Therefore, enable support for these devices only if the host bridges match.

    Add Intel devices that have been tested and are known to work. There are
    likely many others out there that will need to be tested and added.

That suggests it's possible that P2P DMA may actually work but with
poor performance, and that you only want to add host bridges that work
with good performance to the whitelist.

Armen found that it *works*, but I have no idea what the performance
was.  Do you care about the performance, or is this a simple "works /
doesn't work" test?

> ---
>  drivers/pci/p2pdma.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 79fcb8d8f1b1..9f8e9df8f4ca 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -324,6 +324,9 @@ static const struct pci_p2pdma_whitelist_entry {
>  	/* Intel Xeon E7 v3/Xeon E5 v3/Core i7 */
>  	{PCI_VENDOR_ID_INTEL,	0x2f00, REQ_SAME_HOST_BRIDGE},
>  	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
> +	/* Intel SkyLake-E. */
> +	{PCI_VENDOR_ID_INTEL,	0x2030, 0},
> +	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
>  	{}
>  };
>  
> -- 
> 2.16.5
> 
