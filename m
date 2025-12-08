Return-Path: <linux-pci+bounces-42790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A30CAE110
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 20:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A0DF3036A3D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 19:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455572DF154;
	Mon,  8 Dec 2025 19:24:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B93B2D1913;
	Mon,  8 Dec 2025 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221874; cv=none; b=JRE7L7A+ChWdPCWoAyodGRXCpcIFl+atBLD2AskKIZyKiJns9oieZPQ4NoDyQMo4a3EYXWH/k4GelneLwQl5IfOBB8mRlfgJWDHEv/Ka++qxGZMikGVN7kA3MOHFnhf4fJENL0YBnhBRvOSV4byjPMzkIUTEseF9gED1D+OJCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221874; c=relaxed/simple;
	bh=3E3N1XVHNA9+Igs2y4sx7H1DPE5OngWT/ynyAwD7AlU=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=pYV3yaz99yZ2SNyqXJFYKDvZeY932ENCt/6RwMR/Izwd6V8s1wqJHk3lXte6/CIlSmTCEvOTHA2fosdCQSD3QC8TOTFKDwiVeGubgL150uaMF5u10B0ROrty/YaiFVNrf0L1QFSWRZ4swW5QsdLxll4lp6ZDifWd61tXGoPw0NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 13FD192009C; Mon,  8 Dec 2025 20:24:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 0D6D392009B;
	Mon,  8 Dec 2025 19:24:24 +0000 (GMT)
Date: Mon, 8 Dec 2025 19:24:23 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Bjorn Helgaas <bhelgaas@google.com>, 
    Matthew W Carlis <mattc@purestorage.com>, 
    ALOK TIWARI <alok.a.tiwari@oracle.com>
cc: ashishk@purestorage.com, msaggi@purestorage.com, sconnor@purestorage.com, 
    Lukas Wunner <lukas@wunner.de>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Jiwei <jiwei.sun.bj@qq.com>, guojinhui.liam@bytedance.com, 
    ahuang12@lenovo.com, sunjw10@lenovo.com, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] PCI: Always lift 2.5GT/s restriction in PCIe failed
 link retraining
Message-ID: <alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

 I've figured out that backporting will be less intrusive if an update to 
use `->supported_speeds' is posted as a separate follow-up change.  So it 
is now 2/3 in this series, after 1/3 comprising the original patch, only 
trivially updated.  Then 3/3 moves the maximum link speed determination 
earlier on for an early exit in the PCIE_SPEED_2_5GT case; maybe unlikely, 
but essentially free now, now that we retrieve the speed anyway, and makes 
code a little simpler yet.

 Please let me know if you'd prefer me to fold 2/3 into 1/3 after all.

 Previous iterations:

- v1 at: <https://lore.kernel.org/r/alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk/>.

  Maciej

