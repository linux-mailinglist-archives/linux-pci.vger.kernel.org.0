Return-Path: <linux-pci+bounces-7434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F568C4983
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 00:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA2B1C21509
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 22:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B5884039;
	Mon, 13 May 2024 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AL72AEaS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E92C1A9;
	Mon, 13 May 2024 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715638333; cv=none; b=HmrqHwaZJtHEJeWmukkiFOp3RlKge99xUttZnyIcg/e4uGNb9F54g5YpgQhbcIAw9u6RsbjpYZYhJDVtEL2/3VzqPpisSg8xUJcSb2K6nS8TbDbNTz3MV/Lf+/l1Z71iCMvi301dz6f/CkJjoKuHwtnrHiKcTNejV58X0ZGRuMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715638333; c=relaxed/simple;
	bh=6e/yLTrQMtNhfNwL8Ors8HlevGqOB1sqUACq6kkL7+o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s+/Nr8WpVLjAvVGULY/E35a3ct59wI9u3IhjC+pFpO4muoPgSlVinF8+cEm9lvfdIZqU13if/PZv5GZIAhpaO7n+NWgYE66uKHbfBJIdGqgyLrX57sbsSo3CSxSYCfOSsD5UBaaYerEHbJQMd7ZMqij1iHFKt11E/6SHBv89/Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AL72AEaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F539C113CC;
	Mon, 13 May 2024 22:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715638332;
	bh=6e/yLTrQMtNhfNwL8Ors8HlevGqOB1sqUACq6kkL7+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AL72AEaSF3Ty+xfdo6wDhLZ60CaxNoGxdwgGAaof7dR4Tjf1rVCmj//y7hB2gFSfi
	 MimSgaiIIwn9JrWMSUYljiMvCCGd5uKjoOetvWz5BuYrFjIdrN5lQGAccdhdDPgtig
	 SgET171Un4igID9RoQUmQtqCfg1os/9wTAtIA4ntUVrIwd31f+MNLlz46XAwYrN9mS
	 F1NcXhYKiWxd9NJl0V3+aIkvtDKn3VBspq5oVMSnmJa5BnmJWTFcx+4iH8KH75r5LW
	 dwXr/GBIeQfTtAwz3r0aOPrPSWIZHCBeRLOeUjO3Sss7m3bty1gTgxoZgn0KTEV86u
	 LQyBryIHNpx7A==
Date: Mon, 13 May 2024 17:12:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [GIT PULL] PCI fixes for v6.9
Message-ID: <20240513221210.GA1999213@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508013922.GA1745207@bhelgaas>

Sorry, evidently I forgot to cc the lists for this v6.9 pull request
last week.  This has been merged and appeared in v6.9:

  https://git.kernel.org/linus/1ab1a19db13c

On Tue, May 07, 2024 at 08:39:24PM -0500, Bjorn Helgaas wrote:
> The following changes since commit 4cece764965020c22cff7665b18a012006359095:
> 
>   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.9-fixes-2
> 
> for you to fetch changes up to f3d049b35b01fff656d720606fcbab0b819f26d1:
> 
>   PCI/ASPM: Restore parent state to parent, child state to child (2024-05-06 14:12:40 -0500)
> 
> ----------------------------------------------------------------
> - Update kernel-parameters doc to describe "pcie_aspm=off" more accurately
>   (Bjorn Helgaas)
> 
> - Restore the parent's (not the child's) ASPM state to the parent during
>   resume, which fixes a reboot during resume (Kai-Heng Feng)
> 
> ----------------------------------------------------------------
> Bjorn Helgaas (1):
>       PCI/ASPM: Clarify that pcie_aspm=off means leave ASPM untouched
> 
> Kai-Heng Feng (1):
>       PCI/ASPM: Restore parent state to parent, child state to child
> 
>  Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>  drivers/pci/pcie/aspm.c                         | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)

