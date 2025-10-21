Return-Path: <linux-pci+bounces-38947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3846FBF8D9A
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 22:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F3774E473B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 20:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC73283151;
	Tue, 21 Oct 2025 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5DNhDs8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C269328031D;
	Tue, 21 Oct 2025 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080354; cv=none; b=PAqkvkQuVjejF/CWqHjO/Ij2jPOcpe/wtaOP6O2ejrXjjLESQ9fm+vf8XRL86O6Q31HNrW7xi3rHBN3dRys81e2EulHgrRzFYTIIJzQQODikVe8iJ6UL4nuGi9UFER0E68vjPfO1+zsN8awrCVTxwOOZy6L/fzhrxY+Ibrc5zW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080354; c=relaxed/simple;
	bh=37w12AMXAmUXQs2Vivzb46c6O8IH2Ji7lfrgc0inC1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VMmokpLMT+SMmMUzJXnU/m70MBN3b9/bNgdIKez/QaG1wTZy/wp6/IoTd+sQChwOv68Fabwg6xulpUeywIHC0vYOeyA3qewqDFlCJRWwKKAZxqtAtkVDrmUITW/45XLOonIaY+dLryePW0gaLUkQcc7wQO+JJd91JiT2vYT4jRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5DNhDs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F6DC4CEF1;
	Tue, 21 Oct 2025 20:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761080354;
	bh=37w12AMXAmUXQs2Vivzb46c6O8IH2Ji7lfrgc0inC1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=E5DNhDs8cJBLFrgwJF5CfqBjXXmdLLlDe7NkacOS8UqY5j4e5IWELDSocM3yW8K6K
	 d2tsYlNFkw1JwIUyp6+QQQcV9lcQEbcjPnG+/+qwz+8Ct3Rv8ZZQE0LquKTF1BaZ1C
	 v+25PGQnDU4rxyl7EevhVCRhzAFZkoYsKr2XBn2jyB+lJw6gLtqxEWv/JpK7bmCQN7
	 ESs3Xc97LwJjEcCHI0ypq+l3VHsA4lEJX4gSBlEN/tdBsE/4G/UjoH2h37e4Nix+rP
	 f4oAxKyYu5vAJRfiWk+IB9q1DooGLO9KNl8VTlqUKXz1Im6rK6EO2zO0Rt4r4BA3kD
	 nf12DS37yCEaA==
Date: Tue, 21 Oct 2025 15:59:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] MIPS: Malta: Fix PCI southbridge legacy resource
 clashes
Message-ID: <20251021205912.GA1223028@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2510211901530.8377@angie.orcam.me.uk>

[+cc linux-pci]

On Tue, Oct 21, 2025 at 08:38:15PM +0100, Maciej W. Rozycki wrote:
> Hi,
> 
>  This mini patch series sorts out issues with southbridge legacy resource 
> management on the MIPS Malta platform.  Two changes turned out required, 
> because merely removing the clash would regress the PS/2 interfaces, fixed 
> by accident with the PCIBIOS_MIN_IO fix.
> 
>  This does prove nobody has used these interfaces since forever, or most 
> likely since the move to the new serio driver.  Things most likely worked 
> fine with 2.4 and I still have such old Malta kernel builds lying around 
> (though sadly no hardware to try with), although I do know I've never used 
> the PS/2 stuff with this platform, e.g. quoting an arbitrarily picked 
> 2.4.19-rc1 bootstrap log:
> 
> CPU revision is: 00018101
> Primary instruction cache 16kb, linesize 32 bytes(4 ways)
> Primary data cache 16kb, linesize 32 bytes (4 ways)
> Linux version 2.4.19-rc1 (macro@macro.ds2.pg.gda.pl) (gcc version 2.95.4 20010319 (prerelease)) #1 Fri Aug 23 02:55:02 CEST 2002
> [...]
> parport0: PC-style at 0x378 [PCSPP,EPP]
> initialize_kbd: Keyboard reset failed, no ACK
> Detected PS/2 Mouse Port.
> pty: 256 Unix98 ptys configured
> keyboard: Timeout - AT keyboard not present?(ed)
> keyboard: Timeout - AT keyboard not present?(f4)
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ DETECT_IRQ SERIAL_PCI enabled
> [...]
> 
> However to prevent the PS/2 interfaces from getting fixed and then broken 
> again with backports in a random fashion I have marked both changes for 
> backporting as appropriate.
> 
>  Bjorn, may I request that these changes be placed, with Thomas's ack of 
> course (hopefully a formality), ahead of Ilpo's commit 16fbaba2b78f 
> ("MIPS: Malta: Use pcibios_align_resource() to block io range") (or 
> whatever the latest version is, as said commit seems to be missing tags 
> updates you mentioned), and then merged via your tree?  That will prevent 
> things from breaking just to be fixed again shortly, and overall getting 
> out of sync.
> 
>  See individual commit descriptions for details.
> 
>   Maciej

Applied with Thomas's acks to pci/for-linus for v6.18, thanks!

