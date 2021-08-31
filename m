Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26163FCDAC
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 21:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbhHaTV4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Aug 2021 15:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240524AbhHaTVk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Aug 2021 15:21:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 731F761057;
        Tue, 31 Aug 2021 19:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630437642;
        bh=mpMX8Xf2sVBwZlFZXTZ3fErgmBY+D8wS/gwbOJfTovM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AChNj6wd3g18DihD9keAdBmS+TSkRSSb66vXopjNuNIlmt39LgAZPDNqu/LeCg59P
         9bJTp5I6RLc4Sg+8Jzxz2dggnZeFtxHnBD6KJBoKLNZz7V4SHTonJc8AQSahk8tp7P
         T1FISyn0hZwsDJCmGpeLc7QTPayyfGJG8yg5YA/Z/+W3jeLJPwe0/bCzsbKW0fZO47
         3avk4ARkpGeWfU6Dt96ftt+jWZR1j+KF4BoEdC0+eK21XwF/xIMVugCHPWj9R8Rikg
         yQ/pzOEIIVgIjwy3uPymAWmkDZgX5CNlTnpB/Ql2t+d87arTLj2b5oVXcmxsOuSgGe
         mKd1gkhkeD7GA==
Date:   Tue, 31 Aug 2021 14:20:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     stuart hayes <stuart.w.hayes@gmail.com>
Cc:     Krzysztof Wilczy??ski <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Use link bandwidth notification
 capability bit
Message-ID: <20210831192041.GA124936@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53c92c86-5fd9-5db4-eacf-954f1f07cecb@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 26, 2021 at 08:12:04PM -0500, stuart hayes wrote:
> ...
> I made the patch because it was causing the config space for a downstream
> port to not get restored when a DPC event occurred, and all the NVMe drives
> under it disappeared.  I found that myself, though--I'm not aware of anyone
> else reporting the issue.

This niggles at me.  IIUC the problem you're reporting is that portdrv
didn't claim a port because portdrv incorrectly assumed the port
supported bandwidth notification interrupts.  That's all fine, and I
think this is a good fix.

But why should it matter whether portdrv claims the port?  What if
CONFIG_PCIEPORTBUS isn't even enabled?  I guess CONFIG_PCIE_DPC
wouldn't be enabled then either.

In your situation, you have CONFIG_PCIEPORTBUS=y and (I assume)
CONFIG_PCIE_DPC=y.  I guess you must have two levels of downstream
ports, e.g.,

  Root Port -> Switch Upstream Port -> Switch Downstream Port -> NVMe

and portdrv claimed the Root Port and you enabled DPC there, but it
didn't claim the Switch Downstream Port?

The failure to restore config space because portdrv didn't claim the
port seems wrong to me.

Bjorn
