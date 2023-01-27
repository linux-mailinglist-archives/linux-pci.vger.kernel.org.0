Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D073267EA10
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jan 2023 16:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjA0P4H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Jan 2023 10:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjA0P4G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jan 2023 10:56:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AAD8497F;
        Fri, 27 Jan 2023 07:55:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8E44B80AF8;
        Fri, 27 Jan 2023 15:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F96C433D2;
        Fri, 27 Jan 2023 15:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674834954;
        bh=TD9Z1LDYEmj7oIuL5xM2XqnFzwsMUmAt2yOOCa2Lpm4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r0YhX9aPn1VearHX4n9CIIYmelJVHpX6YefoobdGtIRemFoYbYZ5fnBe/3FcnZW6O
         EkgxNNvdOg9QvRxtm3mPk4EmlGpDZyFzLYNT2oE46tDpZhuzMUQvVvAunjCdtmSsyk
         PNUiIIayS8YUphtRSEBG6XHiCrW+XeQXlNYNne/FR82jHra0ZidQiR5u3Ts0FiZd7E
         SwgKJxaoGRJKCXVnrTf2YsVK5Lj2957G7pGghHowRTgbyBTO//k9VKZ1VjiTKpyXJn
         zSB1bP3Tam/Jyfbw46IUOex7dT18X0Rzw31pjOtp2ByKmTc28axv4peOuBfgJbZxnY
         L3BAGFT+84LBw==
Date:   Fri, 27 Jan 2023 09:55:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 20/35] Documentation: PCI: correct spelling
Message-ID: <20230127155551.GA1387211@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230127064005.1558-21-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 26, 2023 at 10:39:50PM -0800, Randy Dunlap wrote:
> Correct spelling problems for Documentation/PCI/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Looks good, thanks!  I assume these will be merged all together, but
let me know if you'd like me to pick this up.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/PCI/endpoint/pci-vntb-howto.rst |    2 +-
>  Documentation/PCI/msi-howto.rst               |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -- a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
> --- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
> +++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
> @@ -103,7 +103,7 @@ A sample configuration for NTB function
>  	# echo 1 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
>  	# echo 0x100000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
>  
> -A sample configuration for virtual NTB driver for virutal PCI bus::
> +A sample configuration for virtual NTB driver for virtual PCI bus::
>  
>  	# echo 0x1957 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
>  	# echo 0x080A > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
> diff -- a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
> --- a/Documentation/PCI/msi-howto.rst
> +++ b/Documentation/PCI/msi-howto.rst
> @@ -290,7 +290,7 @@ PCI_IRQ_MSI or PCI_IRQ_MSIX flags.
>  List of device drivers MSI(-X) APIs
>  ===================================
>  
> -The PCI/MSI subystem has a dedicated C file for its exported device driver
> +The PCI/MSI subsystem has a dedicated C file for its exported device driver
>  APIs — `drivers/pci/msi/api.c`. The following functions are exported:
>  
>  .. kernel-doc:: drivers/pci/msi/api.c
