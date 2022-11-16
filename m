Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6984062C494
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiKPQfr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiKPQfT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:35:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A33E59FD1;
        Wed, 16 Nov 2022 08:27:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBB4261EC4;
        Wed, 16 Nov 2022 16:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DCEC433C1;
        Wed, 16 Nov 2022 16:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616048;
        bh=r6evYLgCFK3vWA5BdOirS4iuO3KS6qHZMh2iJoUYxhg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lchBLUmINWLXBZZsz2dj+jHnFDfSkQsj4e76xKJFbZdSH9hWx3HeMQjZAaeAvIIWZ
         w/5RKX6PkoY9m75TXAkyzW36dFHpyKrwaSBlE9q5acW3K9OQjFnBWMqYCRk2W8WRDj
         Rg97dpmiBt0BAnZ9N3WUfV9y/fAKY/sSiwS6SLK5vtNUgo9tgvZ8SyUzGVnYsvPxW8
         48ihwzximGEEwJUlZZxdeqpUbsy0Szm1evRNcwkKFLaaGIrtf8iWpgwa86Lzg8RUVG
         8vT9gDdtLOL7rhIwsOF9TxBOXaMRUu+YRt6IYtKzUJpPAkrl+a6qtBc2ZJsTcY+DOo
         Td8hFPlIJALKA==
Date:   Wed, 16 Nov 2022 10:27:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch 31/39] Documentation: PCI: Add reference to PCI/MSI
 device driver APIs
Message-ID: <20221116162726.GA1116017@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221111122015.397739421@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:55:04PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> All exported device-driver MSI APIs are now grouped in one place at
> drivers/pci/msi/api.c with comprehensive kernel-docs added.
> 
> Reference these kernel-docs in the official PCI/MSI howto.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  Documentation/PCI/msi-howto.rst |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> ---
> --- a/Documentation/PCI/msi-howto.rst
> +++ b/Documentation/PCI/msi-howto.rst
> @@ -285,3 +285,13 @@ to bridges between the PCI root and the
>  It is also worth checking the device driver to see whether it supports MSIs.
>  For example, it may contain calls to pci_alloc_irq_vectors() with the
>  PCI_IRQ_MSI or PCI_IRQ_MSIX flags.
> +
> +
> +List of device drivers MSI(-X) APIs
> +===================================
> +
> +The PCI/MSI subystem has a dedicated C file for its exported device driver
> +APIs — `drivers/pci/msi/api.c`. The following functions are exported:
> +
> +.. kernel-doc:: drivers/pci/msi/api.c
> +   :export:
> 
