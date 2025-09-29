Return-Path: <linux-pci+bounces-37226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AFDBAA42D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 20:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F277A291A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 18:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED78B19F13F;
	Mon, 29 Sep 2025 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCq1ym8k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FC3944F
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759169526; cv=none; b=H4XoFVas/QvpBX8L0NjjhR71IqRAgmjBVqn6qu0f3fhIa9otVQ/0uaht1KQUvtK3pzYKfFnBeluAflucLj39MRslyBNRTibJ+isEPqeVj5kLuWS23AEhWcjIDWnxnGhNODDtqwZPx9S5C3RrRLQzqhr2xHwYw8ZWhYnRM5GOncU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759169526; c=relaxed/simple;
	bh=E7HxvpD4V+N42NMQeOiwvjvpti75ReuRn7JHmnzFtTA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ln7wnGspmDHzZ7/gdZROY1KLcZAQSaHp6RvLjh6NFo4UGxwlqjy8Hfej6N/zS1whSkia8xfL/SCFOQZYJnVCVLKHnLVC45Fozzpa68X09xtKhtssUs1iBLCU9pSe5iQPbywu6vcWzg30tVEy7pfmFZkYI/U86rQcdxUnSX3psZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCq1ym8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B91AC4CEF4;
	Mon, 29 Sep 2025 18:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759169526;
	bh=E7HxvpD4V+N42NMQeOiwvjvpti75ReuRn7JHmnzFtTA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gCq1ym8kyN82Q0bVIvzNZUHFJ1XIM7xc6eq0G54qgg36pZUEoAFqfSqu9UFUnT+vC
	 4C699rWCPpkWQqtEdT4G2STeA+0sVXW2N6DfYdpjq69C7VpUtbtqP7oWxHb0+LJRWZ
	 fE9TFxL3gnSByrDC49DJn6NAnfq7k3R5OePwFKHaBJ6ZO9oYzk9gkKorfJnJq55kbY
	 p8IMms2tdUL6aBoM/bYl8GYGRnz7TD7UrdPeD6jeUDWc5TD9IlIaqD9B3kFQlh7XnG
	 3uqvNlI1xainyyf1HomM3arS/L4jfAmNBfF1n+/dtjO90ku47W2asIfIXH3aLB/7Sy
	 trxL3SmH/AORQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, michal.simek@amd.com, thippeswamy.havalige@amd.com, 
 kwilczynski@kernel.org, lpieralisi@kernel.org, robh@kernel.org, 
 Jani Nurminen <jani.nurminen@windriver.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <e83a2af2-af0b-4670-bcf5-ad408571c2b0@windriver.com>
References: <e83a2af2-af0b-4670-bcf5-ad408571c2b0@windriver.com>
Subject: Re: [PATCH] PCI: xilinx-nwl: Fix ECAM programming
Message-Id: <175916952065.22239.10260112301115518368.b4-ty@kernel.org>
Date: Mon, 29 Sep 2025 23:42:00 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 12 Sep 2025 11:09:48 +0200, Jani Nurminen wrote:
> When PCIe has been set up by the bootloader, the ecam_size field in the
> E_ECAM_CONTROL register already contains a value.
> 
> The value used to be 0xc (for 16 busses; 16 MB), but was bumped to 0x10
> (for 256 busses; 256 MB) by the commit 2fccd11518f1 ("PCI: xilinx-nwl:
> Modify ECAM size to enable support for 256 buses").
> 
> [...]

Applied, thanks!

[1/1] PCI: xilinx-nwl: Fix ECAM programming
      commit: 9f0fd0b2f7a4aa1925ddfa4aed537a195879e0fa

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


