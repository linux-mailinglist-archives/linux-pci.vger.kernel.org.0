Return-Path: <linux-pci+bounces-44681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D28E2D1B85A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 23:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E46430131D4
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 22:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73364318BAB;
	Tue, 13 Jan 2026 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gginygg8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC8E2ED164;
	Tue, 13 Jan 2026 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341793; cv=none; b=fhDOhLeErWDpS+cfL3ybN4CkgyOdNFtg0hmFme86blLcCfcVJL++dpz3VIGKjv4A6C0wk3sLtOFRa6a7MKOpaVOfDKivDvnX6butryrMpKt7Kj9/JF9a5KTkHnnvH6vc2iOs+GiXJdDES48QvnGN2hOIeggMJhekXD4nyv6srpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341793; c=relaxed/simple;
	bh=nief9n323/1os0uIPBw9I+JGlvYKhvBDE8nJXbETvfY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pZnrj1n+rOZq7cx84t5mxCM4+D0qHbCMa8AUtSA1oRh/ZH4OzJgd2ZelrmpJQbxnkEZz5/puQ7C/I8Bg6eP+x40Tf/o5Jj9CbQrKhme1QXC0IkGXbK8rRn1IlVPXfEeU65jcScYmjj7x0tROrDLbWwwL87jsemZL0ZX2Dxn7FXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gginygg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137A7C116C6;
	Tue, 13 Jan 2026 22:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768341793;
	bh=nief9n323/1os0uIPBw9I+JGlvYKhvBDE8nJXbETvfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Gginygg81xftxlqNavUsJxeeos3OT3NbnOVpOnuLxuKuvZJMOznHUpxkL7sdWO/bX
	 aT9lo8sZUGPsfUq+/972k7JA5UR983jmNeNOy3N85c0aXvJZTpEe9lP+lRZMKHn4Am
	 vPWe2gEq6Y7sAH98WehqpgAeBdi8GRORFmwBP+pI6XB+hjO0sEZfLXUtTjiQSW8pCm
	 kwGbqgdld2z1/lxzjHzV2t+1RS07CB3I099Aksa5/PPzi9CfIgHRcQl4kYwz1CVpAW
	 kQvZ0KL20onU9joRfc9fvAv/sGpKzb1D852bRmPlWVORm5CXgnd6YGP9omesVv8mBm
	 HsQjW1fzIkLIg==
Date: Tue, 13 Jan 2026 16:03:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 3/3] PCI: dw-rockchip: Add pcie_ltssm_state_transition
 trace support
Message-ID: <20260113220311.GA782180@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1768180800-63364-4-git-send-email-shawn.lin@rock-chips.com>

On Mon, Jan 12, 2026 at 09:20:00AM +0800, Shawn Lin wrote:
> Rockchip platforms provide a 64x4 bytes debug FIFO to trace the
> LTSSM history. Any LTSSM change will be recorded. It's userful
> for debug purpose, for example link failure, etc.

s/userful/useful/

> +		 * Hardware Mechanism: The ring FIFO employs two tracking counters:
> +		 * - 'last-read-point': maintains the user's last read position
> +		 * - 'last-valid-point': tracks the hardware's last state update
> +		 *
> +		 * Software Handling: When two consecutive LTSSM states are identical,
> +		 * it indicates invalid subsequent data in the FIFO. In this case, we
> +		 * skip the remaining entries. The dual-counter design ensures that on
> +		 * the next state transition, reading can resume from the last user
> +		 * position.

Wrap this to fit in 80 columns like the rest of the file.  Occasional
code lines that don't fit because of indentation or long meaningful
names are tolerable, but reading plain English text that doesn't fit
for no real reason is just annoying.

