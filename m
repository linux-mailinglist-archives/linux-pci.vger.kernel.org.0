Return-Path: <linux-pci+bounces-9340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A63AB919857
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 21:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E37B20F38
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 19:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E6719069C;
	Wed, 26 Jun 2024 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK9/T/Lf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26DA157A5B
	for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719430732; cv=none; b=mrz0+/VU37aNJHU9sAiRcJBbTuLZ6X9+6fj8Xe6nBkUMRUX+WEUXDLChxljbk4yZ6CJJ3JllK10d83a/IY3yOMbAyufu7cawRc1Yj9Lf+MocwYie6d9Potci2VqNLVTo51p1oD6LlrmPDNNMMsHcf+sKRDKpXNoVT/2yxCs8G18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719430732; c=relaxed/simple;
	bh=trvxvBLVZdv6nfWbDx7p13va+sWdWpQQvWqSJVZqFfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2obonaX2MO2P7logSt7a1WMaO/kKy0TT8AFeLwQKd1bDlEUL8ROZ4AMZt0+xumiQUPqzWT9wbCX0k9XSi+vYj9dHwMAEjyDX9I+leYC/GLpBeEdKSS5yHJnMCoE8KE9E1fo/IoK10YKGCwNlZ3LLXCdPbEBQCXngGH8q3mHnf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK9/T/Lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E7EC116B1;
	Wed, 26 Jun 2024 19:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719430732;
	bh=trvxvBLVZdv6nfWbDx7p13va+sWdWpQQvWqSJVZqFfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eK9/T/LfQ4eCOwGTmqxGgtd/PNpoOI5bgXwhVfi2M9kPhtswOg2RHaTBrSuOjMBnp
	 gmxnSyP+PK5J7SJi8+AI9B7QJa3GsfPdmNfih7Pw63BfNdxK2fnwcozMgy8NnE5Qhg
	 uj0HX3sRdFTxuwLc/k2Wj2nItrlFDnNto7aZa+4qsE/4Xc3cwZ0QAME0LdLLwdvR/h
	 AmoUY690jMVttjPYFPxrulqBwg2xgZWB4rCeFVd8B2fDEWH+nIotu93WgU3e2z1r2h
	 39l36hHshBJIaxjyo24Jm9N9j86nTjgYFAnex3coT+EoGD8fzSxjxi9wWfjGXMGq2t
	 AHr1Fkg/ZBV7g==
Date: Wed, 26 Jun 2024 13:38:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Fix use-after-free on concurrent DPC and
 hot-removal
Message-ID: <ZnxuSXnw5wenZ-Fi@kbusch-mbp.dhcp.thefacebook.com>
References: <8e4bcd4116fd94f592f2bf2749f168099c480ddf.1718707743.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e4bcd4116fd94f592f2bf2749f168099c480ddf.1718707743.git.lukas@wunner.de>

On Tue, Jun 18, 2024 at 12:54:55PM +0200, Lukas Wunner wrote:
> Add the missing reference acquisition.
> 
> Abridged stack trace:
> 
>   BUG: unable to handle page fault for address: 00000000091400c0
>   CPU: 15 PID: 2464 Comm: irq/53-pcie-dpc 6.9.0
>   RIP: pci_bus_read_config_dword+0x17/0x50
>   pci_dev_wait()
>   pci_bridge_wait_for_secondary_bus()
>   dpc_reset_link()
>   pcie_do_recovery()
>   dpc_handler()
> 
> Fixes: 53b54ad074de ("PCI/DPC: Await readiness of secondary bus after reset")
> Reported-by: Keith Busch <kbusch@kernel.org>
> Closes: https://lore.kernel.org/r/20240612181625.3604512-3-kbusch@meta.com/
> Tested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Cc: stable@vger.kernel.org # v5.10+

Hey, it's been some time, so just wanted to check on this patch status.
It's still a good fix.

