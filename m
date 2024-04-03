Return-Path: <linux-pci+bounces-5636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A08897A36
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 22:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31951F22CB9
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 20:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C52156998;
	Wed,  3 Apr 2024 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u01tbEWS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2839F14A096;
	Wed,  3 Apr 2024 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176954; cv=none; b=Egx3wr7Tn+HReR8usA8JM3rz4ft9frMu0QeyrgNFjZ0HhwI58+xWcW490H74Kh5hcLlkSwNRSgOHs4UjLTsnLBYFdFtQnvywEiwxhkAh63k+mnpKJ7yq3+kv38ZpIX7p8f4x6jYKzjrmTyxgsIk4ydL9OpArcQdAaxTj+wvF6RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176954; c=relaxed/simple;
	bh=gkCZ8Gqsb+rHCxtePN8Y9thSSB+jkdz1yRN2PxHLL7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=e9dyRXVXuCLyRCN0aHYga7XyaOBOyst3qRf2Q2Ldocr5/xIMBJJ+PxKWTMLsxoXkXgh69DCab4p0rtZYHby/wPoc9PGEKiYnTzwyCdeQuvxRW541OpeGrB/bvekBm8sEd/6N+Kh4tDZilFusCF4W0aaOs2uDMNaFyeeLMNAvvqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u01tbEWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEF5C433F1;
	Wed,  3 Apr 2024 20:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712176953;
	bh=gkCZ8Gqsb+rHCxtePN8Y9thSSB+jkdz1yRN2PxHLL7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=u01tbEWSwImRYXCgfQpc32YLsBz8Vr1/D8bWf5BC56MA6JPWtKspxi92RNMfa6Etp
	 A8iC+KTNN89uBknsYumCqa3R1r9KQ/IvkfcpGoVe2C0bOtDWjVFZFT6Ys9crARQ2YI
	 NJVxqQQwF4hFjs+r6avtAFDXZusRpuGC2xY+zHNN+a0G+FEcPNNGClo3slTYSj+Oqd
	 +hq1QO/Jd+0SqaU3srNDcWoLFCxS8eTmTVUNLeXi9ANBtIQvJU3QyuZfDRCSadr4o2
	 gCPbij8NRZlXND6fwtFIZz3IHoZJiUhjb9zrpOILxH+LIsI3huse8dw7sk5F7m2heF
	 Q1wMy3b9YufHQ==
Date: Wed, 3 Apr 2024 15:42:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240403204231.GA1887634@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>

On Wed, Apr 03, 2024 at 01:08:24PM -0700, Alexander Duyck wrote:
> This patch set includes the necessary patches to enable basic Tx and Rx
> over the Meta Platforms Host Network Interface. To do this we introduce a
> new driver and driver and directories in the form of
> "drivers/net/ethernet/meta/fbnic".

>       PCI: Add Meta Platforms vendor ID
>       eth: fbnic: add scaffolding for Meta's NIC driver
>       eth: fbnic: Allocate core device specific structures and devlink interface
>       eth: fbnic: Add register init to set PCIe/Ethernet device config
>       eth: fbnic: add message parsing for FW messages
>       eth: fbnic: add FW communication mechanism
>       eth: fbnic: allocate a netdevice and napi vectors with queues
>       eth: fbnic: implement Tx queue alloc/start/stop/free
>       eth: fbnic: implement Rx queue alloc/start/stop/free
>       eth: fbnic: Add initial messaging to notify FW of our presence
>       eth: fbnic: Enable Ethernet link setup
>       eth: fbnic: add basic Tx handling
>       eth: fbnic: add basic Rx handling
>       eth: fbnic: add L2 address programming
>       eth: fbnic: write the TCAM tables used for RSS control and Rx to host

Random mix of initial caps in subjects.  Also kind of a mix of initial
caps in comments, e.g.,

  $ grep -Er "^\s+/\*" drivers/net/ethernet/meta/fbnic/

I didn't bother to figure out which patch these typos were in:

  $ codespell drivers/net/ethernet/meta/fbnic/
  drivers/net/ethernet/meta/fbnic/fbnic_pci.c:452: ot ==> to, of, or
  drivers/net/ethernet/meta/fbnic/fbnic_pci.c:479: Reenable ==> Re-enable
  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:569: caclulation ==> calculation
  drivers/net/ethernet/meta/fbnic/fbnic_fw.c:740: conents ==> contents
  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h:19: cachline ==> cacheline

