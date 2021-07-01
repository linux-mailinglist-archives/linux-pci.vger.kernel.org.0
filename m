Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA4E3B988C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 00:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbhGAWZE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 18:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234270AbhGAWZE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 18:25:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 246E660FEF;
        Thu,  1 Jul 2021 22:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625178153;
        bh=vHv2EmVbmoccIEw3MnI/N38IXw9z66PK+b14NXf/dXI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gemx/2iUrYpN84KVj+anuEwN/8nHXK+/RcBU6rNLNBH4ckKg5pQs833U3Z/wKvKxd
         inKFmkq1rbdEiAWa1DAgATbEaGQ4UMOmVEXx/f4Y1bRmRq5ij8P70isa6TqnP5CMyF
         c2Lf4CPTYzDaEo8CwfT96i/PvBauV4u7ho8Nh+Qp5pmczTJpNCiOYY3iiFHnsLoP49
         sza0B9nHEObfVd60VG24CKuc4VkrnEi0afpvCV5WkVqGsjuFS40WT+HX6clRDRfEDV
         wKKWQbMpuJAy/NgsvqZ6kxE2dOy7zqw2lNkbumI8xrwxqYESsiHbBC3lGYo3RbQCPf
         YpYEIB+L6JHkg==
Date:   Thu, 1 Jul 2021 17:22:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wesley Sheng <wesley.sheng@amd.com>
Cc:     linasvepstas@gmail.com, ruscur@russell.cc, oohall@gmail.com,
        bhelgaas@google.com, corbet@lwn.net, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wesleyshenggit@sina.com
Subject: Re: [PATCH] Documentation: PCI: pci-error-recovery: rearrange the
 general sequence
Message-ID: <20210701222231.GA102933@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618060446.7969-1-wesley.sheng@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please make the subject a little more specific.  "rearrange the
general sequence" doesn't say anything about what was affected.

On Fri, Jun 18, 2021 at 02:04:46PM +0800, Wesley Sheng wrote:
> Reset_link() callback function was called before mmio_enabled() in
> pcie_do_recovery() function actually, so rearrange the general
> sequence betwen step 2 and step 3 accordingly.

s/betwen/between/

Not sure "general" adds anything in this sentence.  "Step 2 and step
3" are not meaningful here in the commit log.  It needs to spell out
what those steps are so the log makes sense by itself.

"reset_link" does not appear in pcie_do_recovery().  I'm guessing
you're referring to the "reset_subordinates" function pointer?

> Signed-off-by: Wesley Sheng <wesley.sheng@amd.com>

I didn't quite understand your response to Oliver, so I'll wait for
your corrections and his ack before proceeding.

> ---
>  Documentation/PCI/pci-error-recovery.rst | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
> index 187f43a03200..ac6a8729ef28 100644
> --- a/Documentation/PCI/pci-error-recovery.rst
> +++ b/Documentation/PCI/pci-error-recovery.rst
> @@ -184,7 +184,14 @@ is STEP 6 (Permanent Failure).
>     and prints an error to syslog.  A reboot is then required to
>     get the device working again.
>  
> -STEP 2: MMIO Enabled
> +STEP 2: Link Reset
> +------------------
> +The platform resets the link.  This is a PCI-Express specific step
> +and is done whenever a fatal error has been detected that can be
> +"solved" by resetting the link.
> +
> +
> +STEP 3: MMIO Enabled
>  --------------------
>  The platform re-enables MMIO to the device (but typically not the
>  DMA), and then calls the mmio_enabled() callback on all affected
> @@ -197,8 +204,8 @@ information, if any, and eventually do things like trigger a device local
>  reset or some such, but not restart operations. This callback is made if
>  all drivers on a segment agree that they can try to recover and if no automatic
>  link reset was performed by the HW. If the platform can't just re-enable IOs
> -without a slot reset or a link reset, it will not call this callback, and
> -instead will have gone directly to STEP 3 (Link Reset) or STEP 4 (Slot Reset)
> +without a slot reset, it will not call this callback, and
> +instead will have gone directly or STEP 4 (Slot Reset)

s/or/to/  ?

>  .. note::
>  
> @@ -210,7 +217,7 @@ instead will have gone directly to STEP 3 (Link Reset) or STEP 4 (Slot Reset)
>     such an error might cause IOs to be re-blocked for the whole
>     segment, and thus invalidate the recovery that other devices
>     on the same segment might have done, forcing the whole segment
> -   into one of the next states, that is, link reset or slot reset.
> +   into next states, that is, slot reset.

s/into next states/into the next state/ ?

>  The driver should return one of the following result codes:
>    - PCI_ERS_RESULT_RECOVERED
> @@ -233,17 +240,11 @@ The driver should return one of the following result codes:
>  
>  The next step taken depends on the results returned by the drivers.
>  If all drivers returned PCI_ERS_RESULT_RECOVERED, then the platform
> -proceeds to either STEP3 (Link Reset) or to STEP 5 (Resume Operations).
> +proceeds to STEP 5 (Resume Operations).
>  
>  If any driver returned PCI_ERS_RESULT_NEED_RESET, then the platform
>  proceeds to STEP 4 (Slot Reset)
>  
> -STEP 3: Link Reset
> -------------------
> -The platform resets the link.  This is a PCI-Express specific step
> -and is done whenever a fatal error has been detected that can be
> -"solved" by resetting the link.
> -
>  STEP 4: Slot Reset
>  ------------------
>  
> -- 
> 2.25.1
> 
