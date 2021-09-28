Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA7B41B995
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 23:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242939AbhI1Vrk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 17:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242917AbhI1Vrk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 17:47:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38B7661368;
        Tue, 28 Sep 2021 21:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632865560;
        bh=7oA805K3psXa8o96mIPy2sYxmb7A2e2etuh13wuzoVQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YboRXMwe0m9mA1Za6Cd20gIqQH4IKkgly5jdOnA1OVz6Bmav6AfsRHoe5epjqK0YF
         ypz4SkbIevu4DUMe+6nq+zYBeYBtEiQf2HVmUTfe/OfKpmPk3LJ9Y6/nCAyrIRy/ha
         zrtANcAOy+miq89bf6zHNmA6wJ0cS6tgY5XTBvXT472YAZy2NIA/paIgD7y6LNIXtV
         2KLrCS3EN6ZJ0B6Q03K9zl1i2uwaNySkLfg7RW1+V5rA9Gz4sGLsN42Tgf5G4uGe8w
         yCfVJozWKtmZCiW8OA/KbdDf0fKudgNmE9ACPnyBmWgc3olBb8skmsUXvHs+UEMn7J
         gO149YgjANDNA==
Date:   Tue, 28 Sep 2021 16:45:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Jaundrew <david@jaundrew.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] Avoid FLR for AMD Starship/Matisse Cryptographic
 Coprocessor
Message-ID: <20210928214558.GA736874@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e30f1c18-3189-774f-054e-8499ade9e398@jaundrew.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 30, 2021 at 10:17:15PM -0700, David Jaundrew wrote:
> This patch fixes another FLR bug for the Starship/Matisse controller:
> 
> AMD Starship/Matisse Cryptogrpahic Coprocessor PSPCPP
> 
> This patch allows functions on the same Starship/Matisse device (such as USB controller,sound card) to properly pass through to a guest OS using vfio-pc. Without this patch, the virtual machine does not boot and eventually times out.
> 
> Excerpt from lspci -nn showing crypto function on same device as USB and sound card (which are already listed in quirks.c):
> 0e:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
> 0e:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller [1022:149c]
> 0e:00.4 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse HD Audio Controller [1022:1487]
> 
> Fix tested successfully on an Asus ROG STRIX X570-E GAMING motherboard with AMD Ryzen 9 3900X.

This is missing a signed-off-by and the patch is corrupted somehow:

  04:44:29 ~/linux (pci/virtualization)$ git am m/20210830_david_avoid_flr_for_amd_starship_matisse_cryptographic_coprocessor.mbx
  Applying: Avoid FLR for AMD Starship/Matisse Cryptographic Coprocessor
  error: corrupt patch at line 4
  Patch failed at 0001 Avoid FLR for AMD Starship/Matisse Cryptographic Coprocessor

Can you fix?  If you can add least supply a signed-off-by, I can apply
it manually if necessary.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.11#n361

> --- a/drivers/pci/quirks.c      2021-08-30 21:19:25.365738689 -0700
> +++ b/drivers/pci/quirks.c      2021-08-30 21:21:25.802031789 -0700
> @@ -5208,6 +5208,7 @@
>  /*
>   * FLR may cause the following to devices to hang:
>   *
> + * AMD Starship/Matisse Cryptographic Coprocessor PSPCPP 0x1486
>   * AMD Starship/Matisse HD Audio Controller 0x1487
>   * AMD Starship USB 3.0 Host Controller 0x148c
>   * AMD Matisse USB 3.0 Host Controller 0x149c
> @@ -5219,6 +5220,7 @@
>  {
>         dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
>  }
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1486, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
