Return-Path: <linux-pci+bounces-3179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECE984BFD2
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 23:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81456B2631E
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 22:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630DE1BC3C;
	Tue,  6 Feb 2024 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGI2Eu0a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F841BF3F;
	Tue,  6 Feb 2024 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257266; cv=none; b=gdFlxF//Y9DTMtav8mUGIKPlE6EvQ2IbKA6pT6DNxTxR2AnU3I6KBt1j2SgjOUyWQdzfdOX3iW00R+NzhBcCgGP5qIk/TqGNGGCM7hJsJRoFUz6eSJ6xVPVMOuFrVsIqyGgV1Em4njCB/nKF6Mdm8nNLbR20BS9lCTdsK2plNRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257266; c=relaxed/simple;
	bh=0/6MC2aMjycIfS6ZKswfCIwCLI65FjgcigRwo+I1gYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z32rpwLt+MkdtwQoEXkhrPAWSazpJKGxeA0KE6Lmh9JKlVZU7J7Uq5S49myAtDCxqhfeif+SExPdjpM9tmw7qc3zYZmNtU+EkJMzesVyZHM/Kshz6tc9xYJMqLhUaJq7GZeUOyLefreOWZHGc31y5eGqzcHgOvSOwDdWFexIB8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGI2Eu0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BFDC433C7;
	Tue,  6 Feb 2024 22:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707257265;
	bh=0/6MC2aMjycIfS6ZKswfCIwCLI65FjgcigRwo+I1gYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGI2Eu0a99S043xEfShDNDrkzUC2wbr0WU1jY6Y7q9EM+ibdFGDZ8hId99Q8jc8Qb
	 icrY3YBo918r9N03xXE9NXYAM8ZQvPVTswNb229wmtYyB6Dr/t6zshCqHypyl4Dddp
	 qagxHoWkdV7hyxEbyDZqk3JEzCJoQ6imIKxsYNPFCloJQj7gQJv65cM9r3YDdrwMhM
	 Sn7oXkuSlhfpjESUh3yf+RDREarFiz+CpU2yv1us9KHioLy2+kjyPRbTjXY4TgCQUK
	 AGwZ0w34oMkoOT7JlZMcv4GRA6s+IVZEHbvoWrp5c1erAwF0hlMnxld6KyLZxjEg6t
	 U7sgS19WRok/A==
Date: Tue, 6 Feb 2024 23:07:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Jian-Hong Pan <jhp@endlessos.org>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Daniel Drake <drake@endlessos.org>,
	Vitalii Solomonov <solomonov.v@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-ide@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@endlessos.org
Subject: Re: [PATCH 1/2] ata: ahci: Add force LPM policy quirk for ASUS
 B1400CEAE
Message-ID: <ZcKtqs2Usj99FRPE@x1-carbon>
References: <20240130101335.GU2543524@black.fi.intel.com>
 <CAPpJ_ef4KuZzBaMupH-iW0ricyY_9toa7A4rB2vyeaFu7ROiDA@mail.gmail.com>
 <Zbonprq/1SircQon@x1-carbon>
 <CAD8Lp47SH+xcCbZ9qdRwrk2KOHNoHUE5AMieVHoSMbVsMrdiNg@mail.gmail.com>
 <ZbrNLxHL03R66PxQ@x1-carbon>
 <ZbuyVbMEBWKi729y@x1-carbon>
 <CAPpJ_efmzy_FU0urdHDmO5htOBCPaX-T5W+Er7AmWYhqUTwnyA@mail.gmail.com>
 <ZcDHjsYJNlJ/9nNT@x1-carbon>
 <CAPpJ_ec0H6zr6wcNstFn9dRcFgPXspU3MYvgGMNAS5wnw-0pTw@mail.gmail.com>
 <ZcIwMb0WPZLG85LR@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcIwMb0WPZLG85LR@x1-carbon>

On Tue, Feb 06, 2024 at 02:12:17PM +0100, Niklas Cassel wrote:
> On Tue, Feb 06, 2024 at 04:39:02PM +0800, Jian-Hong Pan wrote:
> > Niklas Cassel <cassel@kernel.org> 於 2024年2月5日 週一 下午7:33寫道：

(snip)

> 
> It seems that at least Intel AHCI controllers that also have Intel VMD
> enabled break when this quirk is applied.
> 
> I guess one way would be to do a:
> git show c312ef176399:drivers/ata/ahci.c | grep "PCI_VDEVICE(INTEL"
> and replace everything that is not: board_ahci_pcs7
> with a board_ahci_pcs_quirk, board_ahci_low_power_pcs_quirk, and
> board_ahci_avn_pcs_quirk, and after that change all board_ahci_pcs7
> entries to board_ahci, and assume that entries added since c312ef176399
> do not need the quirk.
> 
> But it would be nice if someone from Intel could clean this up.

While it would still be nice if someone cleaned up the intel_pcs_quirk.


Jian-Hong, perhaps you can try my series:
https://lore.kernel.org/linux-ide/20240206211352.1664816-1-cassel@kernel.org/

Also available here:
https://github.com/floatious/linux/tree/external-port-v2

With that series, you should not need an explicit "board_ahci_low_power"
entry for Tiger Lake to get working LPM.

If fact, you want to ensure that you do not have any Tiger Lake entry in
ahci_pci_tbl, as that will apply intel_pcs_quirk and break your platform.

Testing is appreciated :)

Let's hope that LPM is enabled and that you can also enter low-power
C-states.


Kind regards,
Niklas

