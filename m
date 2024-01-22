Return-Path: <linux-pci+bounces-2433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A31837288
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 20:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA456B39C92
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 18:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5764D3C693;
	Mon, 22 Jan 2024 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyTBGJ/R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7963A8C4;
	Mon, 22 Jan 2024 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947412; cv=none; b=MFHArN1UogRnw0oE85cesRDuAAA19cSqQTmymcEimh23QdVkkPch9mOKHKco7PP5+gW7P5qs5ZUCMA1oZ7kATuPs24k6CrriuTb0tL+T+esac7/4pEOLV6eAoNx3nZhEJWAC/d61zF8QsgiFh7E/uWieQHulo+Ar/GrHa0wWQT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947412; c=relaxed/simple;
	bh=zs4odd+WvZxxeJZAIgTFXLhjdsQ/+nQnKFxVYEnrn5E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QeNGMvgCWK1oy7KgEcf/LrW0kVD4wvk0TXW+oS6kY7TuLAPIjFq/CgTgn3JpIqnifUawX/2whVMTlSpzKc69UlSLR/mdRD3Bqqmqm2U4lXnjP2cK55xN4qNtBML2XAGYuS+RC2WINjQsSX6gCdPkwoY+opPr/WlAmtDrC+bQQ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyTBGJ/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC88C43390;
	Mon, 22 Jan 2024 18:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705947411;
	bh=zs4odd+WvZxxeJZAIgTFXLhjdsQ/+nQnKFxVYEnrn5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KyTBGJ/Roe52KXBtV6pUS2z2guHxTPRqLqAbKA7P7brGduEu6SHbdDU5jikzGQ/5+
	 W/ERfaZ450P+TB1QSC3SG27MfKirkVxWRso1UHQ/p1oLAZVJN8VzE2f2S4n/pA8tUn
	 /b3PDIfS7yt634Rv5MhUjn6h9gv497E7B3KbLq7lC8LF9EmkXW99PiE9fNJM2GbiPd
	 Jv3rzlMqRfUmSSN2WK60I0MrOXbj6Me1dPQSzYkJ+jn1IvJ0TKd+DMH7HoqiR6sDTe
	 pXxHDyvFAYvRvfk4SDDTLA3LrOVZxUFJ+2FjZWX46RAV2iV1vJzNfSiA2VPsXfY53R
	 maWi+q3muzhtg==
Date: Mon, 22 Jan 2024 12:16:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <kbusch@kernel.org>,
	Dongdong Liu <liudongdong3@huawei.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/DPC: Fix TLP Prefix register reading offset
Message-ID: <20240122181649.GA276863@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240118110815.3867-1-ilpo.jarvinen@linux.intel.com>

On Thu, Jan 18, 2024 at 01:08:15PM +0200, Ilpo Järvinen wrote:
> The TLP Prefix Log Register consists of multiple DWORDs (PCIe r6.1 sec
> 7.9.14.13) but the loop in dpc_process_rp_pio_error() keeps reading
> from the first DWORD. Add the iteration count based offset calculation
> into the config read.
> 
> Fixes: f20c4ea49ec4 ("PCI/DPC: Add eDPC support")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/dpc for v6.9 with commit log below, thanks!

    PCI/DPC: Print all TLP Prefixes, not just the first
    
    The TLP Prefix Log Register consists of multiple DWORDs (PCIe r6.1 sec
    7.9.14.13) but the loop in dpc_process_rp_pio_error() keeps reading from
    the first DWORD, so we print only the first PIO TLP Prefix (duplicated
    several times), and we never print the second, third, etc., Prefixes.
    
    Add the iteration count based offset calculation into the config read.
    
    Fixes: f20c4ea49ec4 ("PCI/DPC: Add eDPC support")
    Link: https://lore.kernel.org/r/20240118110815.3867-1-ilpo.jarvinen@linux.intel.com
    Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    [bhelgaas: add user-visible details to commit log]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pcie/dpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 94111e438241..e5d7c12854fa 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -234,7 +234,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
>  
>  	for (i = 0; i < pdev->dpc_rp_log_size - 5; i++) {
>  		pci_read_config_dword(pdev,
> -			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
> +			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG + i * 4, &prefix);
>  		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
>  	}
>   clear_status:
> -- 
> 2.39.2
> 

