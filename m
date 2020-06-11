Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D231F6FC3
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 00:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgFKWQR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 18:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbgFKWQQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jun 2020 18:16:16 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F3E920656;
        Thu, 11 Jun 2020 22:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591913776;
        bh=MOjvZzTV4+z+ILXPK2bFLWrMi6nmwio8O8W2edEujbs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qPrZ2YbRdI5TTcDBxo0U2SWv7QaUclQ6J4Af6rJUFTH7r3zvuO03cFumzseQcoH80
         fCtCaVBd2YCS34LZDPDpIfLUYNpo9/QADR8ylU+tzPEO452NzqKtlmp5VQ08Lcw7b9
         ineCcXTthPJ61h92EUSF6/DCgMPvZx1dyBD5H1qM=
Date:   Thu, 11 Jun 2020 17:16:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     refactormyself@gmail.com
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH 0/8] PCI: Align return value of pcie capability accessors
 with other accessors
Message-ID: <20200611221614.GA1614292@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609153950.8346-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 09, 2020 at 05:39:42PM +0200, refactormyself@gmail.com wrote:
> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> 
> PATCH 1 to 7:
> 
> PCIBIOS_ error codes have positive values and they are passed down the
> call heirarchy from accessors. For functions which are meant to return
> only a negative value on failure, passing on this value is a bug.
> 
> To mitigate this, call pcibios_err_to_errno() before passing on return
> value from pcie capability accessors call heirarchy. This function
> converts any positive PCIBIOS_ error codes to negative non-PCI generic
> error values.
> 
> PATCH 8:
> 
> The pcie capability accessors can return 0, -EINVAL, or any PCIBIOS_ error
> code. The pci accessor on the other hand can only return 0 or any PCIBIOS_
> error code.This inconsistency among these accessor makes it harder for
> callers to check for errors.
> 
> Return PCIBIOS_BAD_REGISTER_NUMBER instead of -EINVAL in all pcie
> capability accessors.
> 
> 
> Bolarinwa Olayemi Saheed (8):
>   PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
>   PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
>   PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
>   PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
>   PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
>   PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
>   PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
>   PCI: Align return value of pcie capability accessors with other
>     accessors
> 
>  drivers/dma/ioat/init.c               |  4 ++--
>  drivers/infiniband/hw/hfi1/pcie.c     | 18 +++++++++++++-----
>  drivers/pci/access.c                  |  8 ++++----
>  drivers/pci/pci.c                     | 10 ++++++++--
>  drivers/pci/pcie/aer.c                | 12 ++++++++++--
>  drivers/scsi/smartpqi/smartpqi_init.c |  6 +++++-
>  6 files changed, 42 insertions(+), 16 deletions(-)

This is beautiful!  Tiny patches that are easy to review and verify,
and I think it's definitely going the right direction.

Nits that apply to all:

  - These are really fixing driver bugs (even though the PCI core is
    making it harder than necessary for the drivers), so make the
    driver subject lines match the individual driver history, e.g.,

      dmaengine: ioatdma: Convert PCIBIOS_* errors to generic -E* errors
      IB/hfi1: Convert PCIBIOS_* errors to generic -E* errors

    Find the driver or subsystem prefix by running "git log --oneline"
    on each file you're touching.

  - In commit logs, use "PCIe", not "pcie".  Also "non-PCI generic"
    might be a little redundant; I think "generic" is enough.

  - Order "Suggested-by" before "Signed-off-by".

When you repost this, be sure to include a "v2" in the subject.

Bjorn
