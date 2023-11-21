Return-Path: <linux-pci+bounces-63-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30D27F363C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 19:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F0EBB20A79
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 18:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A78051036;
	Tue, 21 Nov 2023 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECQJbYQf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6036151017
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 18:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DB5C433C9;
	Tue, 21 Nov 2023 18:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700592009;
	bh=scGvM5ZeLf2f5BF5h3F7rDzfO+6jGUYmP7jnnfz1ZUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ECQJbYQfr51w20CizN0ST5Vke0LzD38USn+LQOWwJC/LnsCqurDLEPEfj/uLjqeLE
	 IukULGSsYWAy1/Jdaxets4FkoIVJSaugXJ22zHZ4BkRZdMqyB9bATahcLaYUdTnSdF
	 HTsU9CKhlYQjSPExJPKDhrv2R44hCwfIihxUatm0Hd28cRHJW4h3CejCstNSd+TXc3
	 HpxhmHGPE1Y9LHoX1lyeHdmMdRe4hXdHhVNmejlqfyAKkXYG3a7gUPIusr/0br2trX
	 uaviinlHUnl/aOS/WX2ZxHi5iQN1FrCQM01Sh7g6jH2k5dupdPmlqw/UBJWi0Typbh
	 eTLy6I0DAYlUw==
Date: Tue, 21 Nov 2023 12:40:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Stodden <dns@arista.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] switchtec: Fix stdev_release crash after suprise
 device loss.
Message-ID: <20231121184008.GA249064@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BDEC1856-B689-433B-9227-4CCA5969C2F2@arista.com>

On Tue, Nov 21, 2023 at 10:23:51AM -0800, Daniel Stodden wrote:
> > On Nov 20, 2023, at 1:25 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Nov 13, 2023 at 01:21:50PM -0800, Daniel Stodden wrote:
> >> A pci device hot removal may occur while stdev->cdev is held open. The
> >> call to stdev_release is then delivered during close or exit, at a
> >> point way past switchtec_pci_remove. Otherwise the last ref would
> >> vanish with the trailing put_device, just before return.
> >> 
> >> At that later point in time, the device layer has alreay removed
> >> stdev->mrpc_mmio map. Also, the stdev->pdev reference was not a
> > 
> > I guess this should say the "stdev->mmio_mrpc" (not "mrpc_mmio")?
> 
> Eww. My fault. Could you still correct that?

Yep, I speculatively made that change already, so thanks for
confirming it :)

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=switchtec&id=f9724598e29d

Bjorn

