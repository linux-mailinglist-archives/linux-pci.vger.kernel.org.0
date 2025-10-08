Return-Path: <linux-pci+bounces-37738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56565BC6B5C
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 23:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BFBE188C1F4
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 21:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC2325DB1D;
	Wed,  8 Oct 2025 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RimpMsks"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DFA1991D4
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960354; cv=none; b=r6KFKiv6CRB3XoU6lqJvb03+m/rp1j/QIie3Oz702UssWsxiVVOav9Ol0nxPhG1tRlkiEsGU/eCCukjRjO9FSHchJ3FTJLQtQ3YnmCJOux+ckA4+vaP9Kmw2VEy2w8cKEgechPkaQfnuaRKHSpiXunMfT0lKoyuhCfOurWkCb1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960354; c=relaxed/simple;
	bh=W+kv+eHZR0zp8QaEEErqhHZqhoaYA2/Qw0nf5SjNy28=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XHsf2ki3RcilD05XstTdnMwQVkG6NgY19O1GKxvJmrR76BNvNxtRp3gcBhNG7/Hx+3FE75omfhCiqe9vgpDBUSfK5UDHRuJk86z2/cVQdp4sOwXgrjGgXxW8LFu1nba3lDUTlFzOlB9P+Ppy74suzT7Low2/Z2nBO8/RKMonXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RimpMsks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46052C4CEE7;
	Wed,  8 Oct 2025 21:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759960354;
	bh=W+kv+eHZR0zp8QaEEErqhHZqhoaYA2/Qw0nf5SjNy28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RimpMsks3HtN3wFuxa9kCUdchmHk454Ktg8z5Y+hhZZPIs0itcZjihkFgOq0udC6g
	 m9J8vjnfRo/hNkHbS6RLwTVdahcEFSAbFjO3PqWQBI6Zr0uS9nzfjxfQzAw0YpvFzd
	 gU0KatPe+A7A2dXTtO9EAsRtuYvUMqZ94p4PNUTytZ1M9glt2VgYd+VkHioGNNulT0
	 4rwc6j+bkj8/DMB9dY8lSlbtIt3GeS1lTVccWEJkuURrW+W9KGq2S+1nGs+C2p/cWm
	 Sep+vc1G9wuj15ulIdbugDQfl78Sry6IK23802IkDDZWPg5+hztVdW9Q4sNMiQmcm2
	 xQeAAhE7iuwgQ==
Date: Wed, 8 Oct 2025 16:52:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kenneth Crudup <kenny@panix.com>
Cc: ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: Commit 4292a1e45fd4 ("PCI: Refactor distributing available
 memory to use loops") gives errors enumerating TBolt devices behind my TB
 dock
Message-ID: <20251008215233.GA645164@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b96b6c1e-a100-4eba-8efd-0ce4e8199356@panix.com>

On Wed, Oct 08, 2025 at 02:14:58PM -0700, Kenneth Crudup wrote:
> On 10/8/25 13:14, Bjorn Helgaas wrote:
> 
> > Can you try this patch, which identified the same 4292a1e45fd4 commit?
> > https://lore.kernel.org/r/tencent_8C54420E1B0FF8D804C1B4651DF970716309@qq.com
> 
> This fixes it, thanks!

Great, thanks so much for testing it!  Can I include a link to your
report and your Tested-by?

