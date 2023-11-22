Return-Path: <linux-pci+bounces-78-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 049D07F3AC9
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 01:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 887C3B21009
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 00:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1741138D;
	Wed, 22 Nov 2023 00:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7UnghtB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50CE1381
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 00:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0602AC433C8;
	Wed, 22 Nov 2023 00:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700613687;
	bh=9wAVw6Xk3yAeoIExgPDVCMk61Bjwcd9qqzsUBjlC2PE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=M7UnghtB0K73RXZARKg2WengCYwpv0HRjxkldD8ERA9O0rnfpMzCFYgO9k39luaxP
	 v69fXDJG96jzWLcNwTfkGMyLCyoWdv/jbRO8DKg8eD9FOwYiLkQNcIZiXLzhCqp8O9
	 86WFX8j8tgDy9k2krvMbVnev9MehafYfu2ifU4oVaV+9JlArw5SFQfkHk4323nnnvd
	 ktpoC7O5yhHCwo2ZtKmcuD59awn4Yfkn5INqd2bVLFKR5aiaOepQJSSmHJH9t+TiCU
	 BvcXOplyZVmHxh6ObvnFnoo+YHCHTXZwG3iYwuP1XrybnATIG2+G84Rl3yWzENgj7T
	 RAbE3WfCISO+Q==
Date: Tue, 21 Nov 2023 18:41:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: Daniel Stodden <dns@arista.com>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] switchtec: Fix stdev_release crash after suprise
 device loss.
Message-ID: <20231122004125.GA265607@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7058922e-9a55-47a2-b6fa-ea1cdade937a@arista.com>

On Wed, Nov 22, 2023 at 12:37:33AM +0000, Dmitry Safonov wrote:
> On 11/13/23 21:21, Daniel Stodden wrote:
> > A pci device hot removal may occur while stdev->cdev is held open. The
> > call to stdev_release is then delivered during close or exit, at a
> > point way past switchtec_pci_remove. Otherwise the last ref would
> > vanish with the trailing put_device, just before return.
> > 
> > At that later point in time, the device layer has alreay removed
> > stdev->mrpc_mmio map. Also, the stdev->pdev reference was not a
> > counted one. Therefore, in dma mode, the iowrite32 in stdev_release
> > will cause a fatal page fault, and the subsequent dma_free_coherent,
> > if reached, would pass a stale &stdev->pdev->dev pointer.
> > 
> > Fixed by moving mrpc dma shutdown into switchtec_pci_remove, after
> > stdev_kill. Counting the stdev->pdev ref is now optional, but may
> > prevent future accidents.
> > 
> > Signed-off-by: Daniel Stodden <dns@arista.com>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Just in case, duplicating on the patch.
> With pci_dev_put(stdev->pdev) on stdev_create() err-path,
> 
> Reviewed-by: Dmitry Safonov <dima@arista.com>

OK, I'm totally lost.  Please post a v4 with the content you want.

Bjorn

