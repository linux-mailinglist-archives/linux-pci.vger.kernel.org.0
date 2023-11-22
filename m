Return-Path: <linux-pci+bounces-73-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ADD7F3AA1
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 01:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B994DB21707
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 00:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F248519A;
	Wed, 22 Nov 2023 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQhchbhE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D25188
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 00:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36240C433C7;
	Wed, 22 Nov 2023 00:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700612364;
	bh=aGgYrhljEDf4A6gUYwFO+ks8dbYuUHxfS3hIPewwNq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WQhchbhEu7vst8P3zBvMNuzsY9n6aYQXQ+pt8wwZ720fVYod/j+OB6FW0R1zM3OO7
	 8OXz6HFWvhEfgKpRyZEP4SXmtYJaes9K2ko5ihuQwcFi6IFrpV9otFL60IaPks0ejz
	 ktXZCFeP3Q45GADmDanzfBzmOTpTB+zYO2XxRuHtVKZ3wLjwPZVRbhgL0yeYyldq5V
	 wdeHfdPiDr6IYotGH5754md55zDLKRjNjXVmBEQOQBPJd4uKIdUEhKAK4ANFslOjiD
	 bi5dKkvzUEDu6QgxhvDnOQIHzlJQveFncLzFaRZaNBmJTN8Qpxq+k4HuhlfHKmanS3
	 ZYbG2skS60a2w==
Date: Tue, 21 Nov 2023 18:19:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Stodden <dns@arista.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] switchtec: Fix stdev_release crash after suprise
 device loss.
Message-ID: <20231122001922.GA264028@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D34BC819-ACC4-4709-8464-73EEDDC64328@arista.com>

On Tue, Nov 21, 2023 at 03:58:22PM -0800, Daniel Stodden wrote:
> > On Nov 21, 2023, at 10:40 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Nov 21, 2023 at 10:23:51AM -0800, Daniel Stodden wrote:
> >>> On Nov 20, 2023, at 1:25 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>> On Mon, Nov 13, 2023 at 01:21:50PM -0800, Daniel Stodden wrote:
> >>>> A pci device hot removal may occur while stdev->cdev is held open. The
> >>>> call to stdev_release is then delivered during close or exit, at a
> >>>> point way past switchtec_pci_remove. Otherwise the last ref would
> >>>> vanish with the trailing put_device, just before return.
> >>>> 
> >>>> At that later point in time, the device layer has alreay removed
> >>>> stdev->mrpc_mmio map. Also, the stdev->pdev reference was not a
> >>> 
> >>> I guess this should say the "stdev->mmio_mrpc" (not "mrpc_mmio")?
> >> 
> >> Eww. My fault. Could you still correct that?
> > 
> > Yep, I speculatively made that change already, so thanks for
> > confirming it :)
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=switchtec&id=f9724598e29d
> 
> Thanks. And sorry for what’s next. 
> 
> Look what I just found in my internal review inbox.
> 
> Signed-off/Reviewed-by: dima@arista.com

Happy to add that, no problem, but:

  - "Signed-off-by" has a specific meaning about either being involved
    in the creation of the patch or being part of the chain of
    transmitting the patch, see
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.6#n396
    Since I got the patch directly from you, adding a signed-off-by
    from dima@ would mean he created part of the patch.

  - I don't think it makes sense to include both Signed-off-by and
    Reviewed-by from the same person, since the point of Reviewed-by
    is to get review by somebody other than the author.

  - dima@ should include a name as well as the email address (I assume
    "Dmitry Safonov <dima@arista.com>")

So if you want to use a Signed-off-by from Dmitry, please post a v4
including that (ideally starting from the commit above because I
silently fixed a couple other typos (although I missed the
put_device() thing)).

If you prefer a Dmitry's Reviewed-by, no need to post a v4.  The best
thing would be for Dmitry to respond with the Reviewed-by on the
mailing list.  Some people do collect reviews internally, but I prefer
to get them directly from the reviewer.

Bjorn

