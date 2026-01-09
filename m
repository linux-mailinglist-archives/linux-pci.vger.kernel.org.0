Return-Path: <linux-pci+bounces-44407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDC4D0C2AF
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 21:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28E7430268E7
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 20:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB15366DDA;
	Fri,  9 Jan 2026 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoVLLnHE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8888F366DCC;
	Fri,  9 Jan 2026 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989929; cv=none; b=sDFuaeZLUrXQZzI4put+sf7Tvs+WjxfPATUZwyhGTJaGJEFvAI1irvwVaglz+nQEcNDWH5AHt3hUzLyaW9mUEveDHYjek5n31kAXZEfCl3PBfw5Aqw0JABkZffGj2MNVhE4bilo7Ct7fM1s4FCowZaL/z/S1NXwAaNdLTlHlKns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989929; c=relaxed/simple;
	bh=IJvX1ytDf67uxIGz3eh6b9Td+Lu9NTcFLmsU6lIzymQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LoILA64y76f0o1ABChxDfT7Ohg0+OszjNRL67u2YfxB6rTbcjXi6A7EDUQuhsCBFdsuFbU8z5evB2koz6eMqNWFoPj8YL8ZJtTAgVmeCo7BxbT3BAkm+C6y9cdF1poV48LAjqYzVw2YjJUk+P3vtsLj6njmf9Tn4kjCz1hppvfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoVLLnHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE10EC4CEF1;
	Fri,  9 Jan 2026 20:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767989928;
	bh=IJvX1ytDf67uxIGz3eh6b9Td+Lu9NTcFLmsU6lIzymQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DoVLLnHE+aJaKH0wUrFjsPtZUvY8uUnk6PzISQmstIJsaIclhuwlFqBXRyVLJVA3b
	 kqfPodxl+Cw3JnripYq8xKTQQBIM1Ats13wMcWW3vczIMRcfLRyjBkAA7rWxRp2QPT
	 JS4l9Hkgytg6jN9DZM6UfyxergTgu8rSStB6NdWuuGxJJtZ7qJuEo3QrntFMsWs/+Z
	 7fYCwib+N22UmQ3xmR6HeMPPBerZzM6V6xpyKouWJdMzi5NYd1jHQ21MRBNRbknvAQ
	 oXl3cjRvpkoJayUejC/RU3uo/96ZPcEu4Qx63J07dPMMxfxucSBb7M4JwI/gfZwTNi
	 jfocW8mmRtUXQ==
Date: Fri, 9 Jan 2026 14:18:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 2/3] Documentation: tracing: Add PCI controller event
 documentation
Message-ID: <20260109201847.GA561061@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1767929389-143957-3-git-send-email-shawn.lin@rock-chips.com>

On Fri, Jan 09, 2026 at 11:29:48AM +0800, Shawn Lin wrote:
> The available tracepoint, pcie_ltssm_state_transition, monitors the LTSSM state
> transistion for debugging purpose. Add description about it.

s/transistion/transition/

>  Documentation/trace/events-pci-conotroller.rst | 41 ++++++++++++++++++++++++++

s/events-pci-conotroller.rst/events-pci-controller.rst/

> +The PCI controller tracing system provides tracepoints to monitor controller level
> +information for debugging purpose. The events normally show up here:
> +up here:

Wrap text to fit in 80 columns (unless it's a command line or similar
that shouldn't be split).

