Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743D63A3810
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 01:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFJXsb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 19:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230493AbhFJXsa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 19:48:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A316F60FDA;
        Thu, 10 Jun 2021 23:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623368794;
        bh=Fte/fxSsKUBIfRBAj9Gt6AksHl3Dae1X6JkRiB+h5P0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tXoVvPwqy8F6VOVkBnr5r70zigpLzt5U6/GThCcJZ+ocvRZy9gXqTF5PrjwfW9OEM
         JtNYhRLBb9z5qzAVBUtSUu0Rqe1a4NT+EwpjH86Pph7F/MEo0SrkABUD/SK6nrHyzy
         4JX4CrwOnl+yDFJANatUQkkXw51um8R5f7AwvYDRaSgIgcIHb2kdGZ9AtE46wea8mO
         YqgCGjRSFSTlTnVbRS3YBOBcKAVWIB0Z00mC1vhNE6rtfXaesUNUs7yCMFx+nMIWZK
         7zCBv4k6j9AzXUG76v25CdEOLrHIJ0OaNw0V38sd70e3vWFVm9vw66+Cg9YZwYYOEA
         ex3ltVWyK2nbQ==
Date:   Thu, 10 Jun 2021 18:46:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 27/34] docs: PCI: pci.rst: avoid using ReSt :doc:`foo`
 markup
Message-ID: <20210610234632.GA2796244@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5f465357173f834709e467214f4842269815c05.1622898327.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 05, 2021 at 03:18:26PM +0200, Mauro Carvalho Chehab wrote:
> The :doc:`foo` tag is auto-generated via automarkup.py.
> So, use the filename at the sources, instead of :doc:`foo`.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  Documentation/PCI/pci.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
> index 814b40f8360b..fa651e25d98c 100644
> --- a/Documentation/PCI/pci.rst
> +++ b/Documentation/PCI/pci.rst
> @@ -265,7 +265,7 @@ Set the DMA mask size
>  ---------------------
>  .. note::
>     If anything below doesn't make sense, please refer to
> -   :doc:`/core-api/dma-api`. This section is just a reminder that
> +   Documentation/core-api/dma-api.rst. This section is just a reminder that
>     drivers need to indicate DMA capabilities of the device and is not
>     an authoritative source for DMA interfaces.
>  
> @@ -291,7 +291,7 @@ Many 64-bit "PCI" devices (before PCI-X) and some PCI-X devices are
>  Setup shared control data
>  -------------------------
>  Once the DMA masks are set, the driver can allocate "consistent" (a.k.a. shared)
> -memory.  See :doc:`/core-api/dma-api` for a full description of
> +memory.  See Documentation/core-api/dma-api.rst for a full description of
>  the DMA APIs. This section is just a reminder that it needs to be done
>  before enabling DMA on the device.
>  
> @@ -421,7 +421,7 @@ owners if there is one.
>  
>  Then clean up "consistent" buffers which contain the control data.
>  
> -See :doc:`/core-api/dma-api` for details on unmapping interfaces.
> +See Documentation/core-api/dma-api.rst for details on unmapping interfaces.
>  
>  
>  Unregister from other subsystems
> -- 
> 2.31.1
> 
