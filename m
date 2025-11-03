Return-Path: <linux-pci+bounces-40120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F55DC2CDF6
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 16:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB62E4E6DB7
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776EA313E38;
	Mon,  3 Nov 2025 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fADXEzoR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C09A275111;
	Mon,  3 Nov 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184256; cv=none; b=TcB4SlhlBa3CIT7BEh/x3LzXC+Df0g253aJFidVXeVuigkk54sCKdX5MyO4BBHBU4095QPduVWS1QEvu9MQvZpJ2Y2k6mca0rXIc48mFn3YzGLAITozUPXWTAxPxvvWTU/Kya6UavSuARmBw3QJmxHKW6vrJyHqzrMFfFPb3RRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184256; c=relaxed/simple;
	bh=meaEHF0ix2sQz5h4e1TOFR7szY/djMrcczdvGBdBLWc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lhjMk5ZdLZzCZ6cAJvgzR7aBz4Cqrz5AHYNEWrTvF0JDlQATWA9p25xiNfCi72sNZI7E4FTtFQUBfB6yA3k7JlpiTJBHHanRpU4YIlRHFuFm9C6qIskewx5Nx51BsH98lLCk9WcnMeyV+sTaEXh1vJ+grt0Ns0sJPkpid7kMDyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fADXEzoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D84C113D0;
	Mon,  3 Nov 2025 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762184255;
	bh=meaEHF0ix2sQz5h4e1TOFR7szY/djMrcczdvGBdBLWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fADXEzoROovFa+6OT+bgCBNwaxZSWVUOYugecsCGjxOFUrhDE8BwVm/0QO7XmlAtN
	 0dKhN8TUO3FPr80tLL36qEdsOovsMQgi816gN8GPSFAiRp0/5e45yJSuYkbTeLWYdA
	 pasg38DsO13r1obgfDy1iiAAqZmlG2kyJ9bBHxAJuIJgIvC82gHdqqb+EN/dOcDvP/
	 GQrXmNfC9iWG8Y99zepWBnkZrNnMFYUOXGN7UHZsx/Y68tXHWeDGRiLMVfZF21JXrD
	 c6+SRGsq9sdUEk8NiHX6z4fQukoncCCvlkxKtxuR93uzfnFGvI0crT7tuA8wq+7KgN
	 +l2GROFeCduqw==
Date: Mon, 3 Nov 2025 09:37:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v4 3/4] PCI: pciehp: Add macros for hotplug operation
 delays
Message-ID: <20251103153734.GA1806239@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101160538.10055-4-18255117159@163.com>

[+cc Lukas]

On Sun, Nov 02, 2025 at 12:05:37AM +0800, Hans Zhang wrote:
> Add WAIT_PDS_TIMEOUT_MS and POLL_CMD_TIMEOUT_MS macros for hotplug
> operation delays to improve code readability.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index bcc51b26d03d..15b09c6a8d6b 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -28,6 +28,9 @@
>  #include "../pci.h"
>  #include "pciehp.h"
>  
> +#define WAIT_PDS_TIMEOUT_MS	10
> +#define POLL_CMD_TIMEOUT_MS	10
> +
>  static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
>  	/*
>  	 * Match all Dell systems, as some Dell systems have inband
> @@ -103,7 +106,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>  			smp_mb();
>  			return 1;
>  		}
> -		msleep(10);
> +		msleep(POLL_CMD_TIMEOUT_MS);

Lukas might have different opinions and I would defer to him here.

But IMO (a) these aren't timeouts, they are poll intervals, (b) the
values are arbitrary with no connection to a spec, so less reason for
a #define, and (c) the #defines don't improve readability because now
I have to look at two places to understand the poll loops.

>  		timeout -= 10;
>  	} while (timeout >= 0);
>  	return 0;	/* timeout */
> @@ -283,7 +286,7 @@ static void pcie_wait_for_presence(struct pci_dev *pdev)
>  		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
>  		if (slot_status & PCI_EXP_SLTSTA_PDS)
>  			return;
> -		msleep(10);
> +		msleep(WAIT_PDS_TIMEOUT_MS);
>  		timeout -= 10;
>  	} while (timeout > 0);
>  }
> -- 
> 2.34.1
> 

