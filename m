Return-Path: <linux-pci+bounces-77-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4927F3AC7
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 01:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C866B20FD4
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 00:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E983310F9;
	Wed, 22 Nov 2023 00:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOF8yntc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB1A10E5
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 00:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D69C433C8;
	Wed, 22 Nov 2023 00:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700613582;
	bh=ypgj0naTh7lXivf/86J/jva03+J1Pu/p9mvEkASbsnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nOF8yntc3BuaNsTCxhISvemRJzx2IbUWD07C9znDJGvjgoMYGQv8PdUT8l8jOM2St
	 wf6/VHr4StrwJaDxz1TCz7eQEZbNXhri7S/pcY0uEq4OMPEKx1MPE2XlSJsA+nLInX
	 BLReKo/qL2su4b/P4B15jzaD7HfUgwFrcj4UWmue6khQ3g4fhShPtuzxfzGqLVzyTh
	 e5bqAoLeMtTa8qR0jl/m/wLznvW5F0RrxZZhFEew5DLrie9mEBeAILJF/7of6zt+PQ
	 V4zwCp1B2QQWMZ2Waqko05OdG+l5gkzWuQWBjcUwpFWxJINpc+fPCWk+WBrGKGowGA
	 gyt7te+IL1/YQ==
Date: Tue, 21 Nov 2023 18:39:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Stodden <dns@arista.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] switchtec: Fix stdev_release crash after suprise
 device loss.
Message-ID: <20231122003941.GA265415@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <581038D0-C2B6-431C-BC67-5DDE9458FACA@arista.com>

On Tue, Nov 21, 2023 at 04:02:12PM -0800, Daniel Stodden wrote:
> > On Nov 21, 2023, at 3:58 PM, Daniel Stodden <dns@arista.com> wrote:
> > 
> > +       put_device(&stdev->pdev);
> 
> That was just a sketch. Actuall pci_dev_put.

Can you clarify what I should do with this?  The current commit log
reads like this:

  A PCI device hot removal may occur while stdev->cdev is held open. The call
  to stdev_release() then happens during close or exit, at a point way past
  switchtec_pci_remove(). Otherwise the last ref would vanish with the
  trailing put_device(), just before return.

Are you saying it needs a change?

Bjorn

