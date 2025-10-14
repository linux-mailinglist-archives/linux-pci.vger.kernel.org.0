Return-Path: <linux-pci+bounces-38076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86478BDAD45
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 19:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459A4546968
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 17:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40EE2FBE01;
	Tue, 14 Oct 2025 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBu/yDl9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8824221555;
	Tue, 14 Oct 2025 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760463832; cv=none; b=dJSRtNs9ne62ucmtR8xvJhUqwPk1v6X5SHQWuKosRKKobc9yB7JB3OqkPbBObZbeU9SI2J+otmJ4gTlCCFQyRzsLBuxhSDZ5hGewTHZ6aX5ZpLIwDcBQ297xOSM35h+wyK96hkGl193hgLb7xTa5jZZ/YOeebO+V9VoEesgunHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760463832; c=relaxed/simple;
	bh=Qj9F9oPwsMZi//F1Yf1CYFenbsd0elLCIUlVgkFyfuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8blVqX/2vLeltycB7SoMcXPac5JabzWvocDCx/TbEoAbYm1KAM1IF7veozot70aKtJGaAqiJAn5otd48j/ZgBYMfyodwR6b2+AXfOtTpU2FnUL8TQFSvIk5Q2pSB6QKAKy6WTbOFNwXoATMA3DRxyXTM0isdToOwX5oTYdPjYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBu/yDl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E376CC4CEE7;
	Tue, 14 Oct 2025 17:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760463832;
	bh=Qj9F9oPwsMZi//F1Yf1CYFenbsd0elLCIUlVgkFyfuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBu/yDl9xonPjSRqKRS4NHzJ2UKIC3XLtPhtWAerjwGGjfdkipHLL5cvHxz8WgV8L
	 F/mjBQ5QcGzewZXo9dQ5z48LX107YQfUuxHWaNFvYwcNB9pgoA55ulxiG5r5BgdsF0
	 1nARnJ5CsYiDdbrMQSv6DVorY4QFC7K5DZMldFPCkauojwWwPFLRSEfGjXzSkKxLkW
	 YaanZ+PJsxq+I2ecUi/httb651Omst2R0jx0GMpsfxsxomiQukw1v5I3gtGRb0eMGQ
	 IppErgD/9c7puBkt/6zJkNfe506aMoqeIudm8L57N1So2fViqt7KFnLXgO0sEAoe9x
	 7fdAB1FoKYyCA==
Date: Tue, 14 Oct 2025 10:43:45 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel test robot <lkp@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH] PCI: rcar-host: Avoid objtool no-cfi warning in
 rcar_pcie_probe()
Message-ID: <20251014174345.GA3062995@ax162>
References: <20251013-rcar_pcie_probe-avoid-nocfi-objtool-warning-v1-1-552876b94f04@kernel.org>
 <CAMuHMdXZvoTyWcgRp6TnkybnKY4ekfO9aB33iumPVaR7wvEXkw@mail.gmail.com>
 <20251014083209.GA2696801@ax162>
 <uebexl7d5gfjopb26gstftahu2ouab3ekonw4dzgegw3on5cwr@vqc2zmxiluvt>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uebexl7d5gfjopb26gstftahu2ouab3ekonw4dzgegw3on5cwr@vqc2zmxiluvt>

On Tue, Oct 14, 2025 at 06:32:59PM +0530, Manivannan Sadhasivam wrote:
> TBH, I hate both of these CONFIG_OF checks as most of the controller drivers
> are just OF drivers. If we were to sprinkle CONFIG_OF check, then it has to be
> done in almost all controller drivers (except VMD, Hyper-V).
> 
> If compiler is getting smart enough to detect these NULL invocations, then it
> may start to trigger the same issue for other OF APIs as well. So I'd prefer to
> have the OF dependency in Kconfig, sacrificing COMPILE_TEST on non-OF configs.

Alright, fair enough. I will send a v2 soon just adding the dependency
on OF.

Cheers,
Nathan

