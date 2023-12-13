Return-Path: <linux-pci+bounces-832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB67810748
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 02:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9771F21291
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 01:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9094819C;
	Wed, 13 Dec 2023 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roeIl5ey"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B4A49
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 01:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E483DC433C7;
	Wed, 13 Dec 2023 01:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702429601;
	bh=18OvFtCPHEzgFYCKzEO5XOnskp9I3BqXX5OqbQiP1GM=;
	h=Date:From:To:Subject:From;
	b=roeIl5eyj4vEC2Ajq2DcoW4bg3XsE/jCRMHOUn9ujCWN08SBMAYX7F8iT4N7Zoc/H
	 10IW404o0JygVRvLnBmar4qN2EnPOPMPd6yqPhM1H7GADKYcaYLEN3cyHJW3jVXOFZ
	 hyO7JKdSQuohZ8RIWQa+PEx7Ma3kaQ78kZbVM1blRIs3aepeNdtA3b/WMpLzDhzaPu
	 PstbowQch4dy4FZapExEIiA0EpPp3zLtxaUkKyse4LQVlBMc4PcwKj7fgDsvT1lFtU
	 KqGBLn4HG2bgfm23YbyISqSb+TcZTbJOa0T+BXrXxhJHfNkJ0vX3RxS6afQyQwjgZs
	 c1WjWJc99R15A==
Date: Tue, 12 Dec 2023 17:06:39 -0800
From: Keith Busch <kbusch@kernel.org>
To: alex.williamson@redhat.com, linux-pci@vger.kernel.org
Subject: vfio memlock question
Message-ID: <ZXkDn-beoRjcRnjq@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I was examining an issue where a user process utilizing vfio is hitting
the RLIMIT_MEMLOCK limit during a ioctl(VFIO_IOMMU_MAP_DMA) call. The
amount of memory, though, should have been well below the memlock limit.

The test maps the same address range to multiple devices. Each time the
same address range is mapped to another device, the lock count is
increasing, creating a multiplier on the memory lock accounting, which
was unexpected to me.

Another strange thing, the /proc/PID/status shows VmLck is indeed
increasing toward the limit, but /proc/PID/smaps shows that nothing has
been locked.

The mlock() syscall doesn't doubly account for previously locked ranges
when asked to lock them again, so I was initially expecting the same
behavior with vfio since they subscribe to the same limit.

So a few initial questions:

Is there a reason vfio is doubly accounting for the locked pages for
each device they're mapped to?

Is the discrepency on how much memory is locked depending on which
source I consult expected?

