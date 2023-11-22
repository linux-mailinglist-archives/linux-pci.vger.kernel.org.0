Return-Path: <linux-pci+bounces-133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D40BA7F4BB2
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 16:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C911C208C8
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 15:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583604F214;
	Wed, 22 Nov 2023 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4D4LUP5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A22056B70
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 15:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEB6C433C7;
	Wed, 22 Nov 2023 15:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700668533;
	bh=CWJ5p+rT213wURJZz02b91YWbWg9xKJpIOSNB5Xslu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b4D4LUP5/1D4F5qwjXJVEaqeHwoQR4DD75uk9eIG5X+HvROiVH+hUPYK15eiD05sm
	 Lr9jGgHpZAgfTe539AG5eYTbqa2eZ9V2pxk+MhW5qmTmBZyzr/bR9pF8DQbCJ76VLh
	 tRYIJGuNgJe+z94ifxLzhg7Sby2nz9KqT6OsqT72uKz7fYi0IBHCCiixgL15z3bKQ7
	 uy1xhK4GMx+DcZNq871WRdkBf8HKr3UypUZfpLDR+ALVz93k1wuxJDxiqr8icroMJl
	 GX4JOj94vmRIf8X3kPhVurzgw5AcATyNOtvLQQkac5ar8195+sIf2Gd8ZUsKeKlQBD
	 Ex6guHvG6TH6g==
Date: Wed, 22 Nov 2023 09:55:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Stodden <dns@arista.com>
Cc: Dmitry Safonov <dima@arista.com>, Logan Gunthorpe <logang@deltatee.com>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 1/1] PCI: switchtec: Fix stdev_release() crash after
 surprise hot remove
Message-ID: <20231122155531.GA300313@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122042316.91208-2-dns@arista.com>

On Tue, Nov 21, 2023 at 08:23:16PM -0800, Daniel Stodden wrote:
> A PCI device hot removal may occur while stdev->cdev is held open. The call
> to stdev_release() then happens during close or exit, at a point way past
> switchtec_pci_remove(). Otherwise the last ref would vanish with the
> trailing put_device(), just before return.
> 
> At that later point in time, the devm cleanup has already removed the
> stdev->mmio_mrpc mapping. Also, the stdev->pdev reference was not a counted
> one. Therefore, in DMA mode, the iowrite32() in stdev_release() will cause
> a fatal page fault, and the subsequent dma_free_coherent(), if reached,
> would pass a stale &stdev->pdev->dev pointer.
> 
> Fix by moving MRPC DMA shutdown into switchtec_pci_remove(), after
> stdev_kill(). Counting the stdev->pdev ref is now optional, but may prevent
> future accidents.
> 
> Reproducible via the script at
> https://lore.kernel.org/r/20231113212150.96410-1-dns@arista.com
> 
> Link: https://lore.kernel.org/r/20231113212150.96410-2-dns@arista.com
> Signed-off-by: Daniel Stodden <dns@arista.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Dmitry Safonov <dima@arista.com>

Oh, I forgot to mention: for future reference, you should only add
Signed-off-by when you create the patch or you receive it from
somebody else and are passing it on.

You should not add the Signed-off-by of the person you're sending it
*to*, because that person will add their own Signed-off-by when they
process it.  E.g., I apply patches with "git am --signoff" which adds
my Signed-off-by, which would result in a duplicate.

No worries, I took care of it so there's no duplicate for me :)

Bjorn

