Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536C23A9D66
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 16:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhFPOTu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 10:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233854AbhFPOTt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 10:19:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 600A461076;
        Wed, 16 Jun 2021 14:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623853063;
        bh=BZr1kLu0kTw4uOHStX/yZhqy79lxqVneeCZEus9LxIw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mCA9gyu6gccO/Pr6AY+yPwkyFrJQW3bTVmEmonccEUgGqZsZJKzzKYg4O4E6QaDUB
         dRkeYHR7FbA9SYvPVN3JAmH5m+g3Qs/z6a3K9vl7DeFUP2WPmM99FzPbyoQDlLvgJd
         jjDaBuazyB9A88FnkgXBrsTlqaAVuLtnvx1sGKj4KgONs/6J4rXbsfcMC7byC8Njbt
         +QDh5dFNU9Ij2mgEjYWixqhV3emmvFdrpVkf+swUF3u1hpLIXfv4UhC0pynjTQdSs2
         JjyOldNhNZzQUxWR2toXlU/dEFLSsU5oBWqrTE1P4IJDa/xdm3D7o7u8cJ27Bof8iu
         +8xVr+7O7pTag==
Date:   Wed, 16 Jun 2021 09:17:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 22/29] docs: PCI: pci.rst: avoid using ReST :doc:`foo`
 markup
Message-ID: <20210616141742.GA2973725@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8697cf945390f6b45fefb4c5fe22ed1c8070e32e.1623824363.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 16, 2021 at 08:27:37AM +0200, Mauro Carvalho Chehab wrote:
> The :doc:`foo` tag is auto-generated via automarkup.py.
> So, use the filename at the sources, instead of :doc:`foo`.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I do still think it would be nice to have a hint in the commit log
about *why* we're doing this.

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
