Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1DA1B973
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 17:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbfEMPEa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 11:04:30 -0400
Received: from casper.infradead.org ([85.118.1.10]:53256 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbfEMPEa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 11:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lmw8m2PcC49iVQvnEnxuI/mETRA7iB8j56Jy/bAQ+Wo=; b=Q1jTmjhz40l91KdKl+IJkHGplw
        ym+QdE1zGPpm/ylCVzlMkanuTYV43agbp+BADE5rmLYvBSWdsvGZFheRLtIyVmpf2YQJ7O4BEG7Kh
        aKjwdG4wa1FWaacy23Nq2G3buC+XyLLZoMSgvc2cnz7UNn/K9B5Sc+RHvWemCDREkXbT1HQ2MUfRg
        BqfqtT3SgkLQCOxvsVKP73MexrsvPOMF8WIs4O3TVUhtLfSERdx+8tQEAK7WZ1RuF/FWAVwlJqD/m
        2U9gY3DmYc8LRA8v/FgzZSSI1algA/nk16BIik5ih+A3tQ6qvnK2XQlElCCOVPA7Hr/69AAhMgU+h
        4pz3Q33g==;
Received: from [179.179.44.200] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQCV9-000331-I0; Mon, 13 May 2019 15:04:28 +0000
Date:   Mon, 13 May 2019 12:04:23 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     bhelgaas@google.com, corbet@lwn.net, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/12] Documentation: PCI: convert
 endpoint/pci-test-function.txt to reST
Message-ID: <20190513120423.159b971f@coco.lan>
In-Reply-To: <20190513142000.3524-12-changbin.du@gmail.com>
References: <20190513142000.3524-1-changbin.du@gmail.com>
        <20190513142000.3524-12-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Mon, 13 May 2019 22:19:59 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/PCI/endpoint/index.rst          |  1 +
>  ...est-function.txt => pci-test-function.rst} | 34 ++++++++++++-------
>  2 files changed, 22 insertions(+), 13 deletions(-)
>  rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (84%)
> 
> diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
> index 3951de9f923c..b680a3fc4fec 100644
> --- a/Documentation/PCI/endpoint/index.rst
> +++ b/Documentation/PCI/endpoint/index.rst
> @@ -9,3 +9,4 @@ PCI Endpoint Framework
>  
>     pci-endpoint
>     pci-endpoint-cfs
> +   pci-test-function
> diff --git a/Documentation/PCI/endpoint/pci-test-function.txt b/Documentation/PCI/endpoint/pci-test-function.rst
> similarity index 84%
> rename from Documentation/PCI/endpoint/pci-test-function.txt
> rename to Documentation/PCI/endpoint/pci-test-function.rst
> index 5916f1f592bb..63148df97232 100644
> --- a/Documentation/PCI/endpoint/pci-test-function.txt
> +++ b/Documentation/PCI/endpoint/pci-test-function.rst
> @@ -1,5 +1,10 @@
> -				PCI TEST
> -		    Kishon Vijay Abraham I <kishon@ti.com>
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +PCI Test Function
> +=================
> +
> +:Author: Kishon Vijay Abraham I <kishon@ti.com>
>  
>  Traditionally PCI RC has always been validated by using standard
>  PCI cards like ethernet PCI cards or USB PCI cards or SATA PCI cards.
> @@ -23,30 +28,31 @@ The PCI endpoint test device has the following registers:
>  	8) PCI_ENDPOINT_TEST_IRQ_TYPE
>  	9) PCI_ENDPOINT_TEST_IRQ_NUMBER
>  
> -*) PCI_ENDPOINT_TEST_MAGIC
> +* PCI_ENDPOINT_TEST_MAGIC
>  
>  This register will be used to test BAR0. A known pattern will be written
>  and read back from MAGIC register to verify BAR0.
>  
> -*) PCI_ENDPOINT_TEST_COMMAND:
> +* PCI_ENDPOINT_TEST_COMMAND
>  
>  This register will be used by the host driver to indicate the function
>  that the endpoint device must perform.
>  
> -Bitfield Description:
> +Bitfield Description::
> +
>    Bit 0		: raise legacy IRQ
>    Bit 1		: raise MSI IRQ
>    Bit 2		: raise MSI-X IRQ
>    Bit 3		: read command (read data from RC buffer)
>    Bit 4		: write command (write data to RC buffer)
> -  Bit 5		: copy command (copy data from one RC buffer to another
> -		  RC buffer)
> +  Bit 5		: copy command (copy data from one RC buffer to another RC buffer)

Why not use a table instead?

>  
> -*) PCI_ENDPOINT_TEST_STATUS
> +* PCI_ENDPOINT_TEST_STATUS
>  
>  This register reflects the status of the PCI endpoint device.
>  
> -Bitfield Description:
> +Bitfield Description::
> +
>    Bit 0		: read success
>    Bit 1		: read fail
>    Bit 2		: write success
> @@ -57,31 +63,33 @@ Bitfield Description:
>    Bit 7		: source address is invalid
>    Bit 8		: destination address is invalid

Same here.

If you replace the two bitfield descriptions to table:
	Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

>  
> -*) PCI_ENDPOINT_TEST_SRC_ADDR
> +* PCI_ENDPOINT_TEST_SRC_ADDR
>  
>  This register contains the source address (RC buffer address) for the
>  COPY/READ command.
>  
> -*) PCI_ENDPOINT_TEST_DST_ADDR
> +* PCI_ENDPOINT_TEST_DST_ADDR
>  
>  This register contains the destination address (RC buffer address) for
>  the COPY/WRITE command.
>  
> -*) PCI_ENDPOINT_TEST_IRQ_TYPE
> +* PCI_ENDPOINT_TEST_IRQ_TYPE
>  
>  This register contains the interrupt type (Legacy/MSI) triggered
>  for the READ/WRITE/COPY and raise IRQ (Legacy/MSI) commands.
>  
>  Possible types:
> +
>   - Legacy	: 0
>   - MSI		: 1
>   - MSI-X	: 2
>  
> -*) PCI_ENDPOINT_TEST_IRQ_NUMBER
> +* PCI_ENDPOINT_TEST_IRQ_NUMBER
>  
>  This register contains the triggered ID interrupt.
>  
>  Admissible values:
> +
>   - Legacy	: 0
>   - MSI		: [1 .. 32]
>   - MSI-X	: [1 .. 2048]



Thanks,
Mauro
