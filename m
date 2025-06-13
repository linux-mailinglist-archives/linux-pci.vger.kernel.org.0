Return-Path: <linux-pci+bounces-29645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 472DDAD82F5
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 08:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618EC188D752
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 06:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5103A257427;
	Fri, 13 Jun 2025 06:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqG80Tbe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DEA1B95B;
	Fri, 13 Jun 2025 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749795131; cv=none; b=LGtGrUpJd47NHuxHxOVeP73Su/ONu65Qh2I05C3JuJOctO89Ha9fNuUDiPRT1+EYM/G9SgWhYPtzGsv2QlRQFXL308XEkKXJVc4omkbK9c7XzLlVFdtSRV3Nh7FX4Ww9o+7L6wPDNSSp/Xo8g0UYaJwOXK/ljDBN1ghiLMcC9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749795131; c=relaxed/simple;
	bh=xkYpzMUmOpY1cRCi/aFqu67aJwISXF0l+SAsHg0sZ6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gk/IxNKQkZCN6kPVWy+c9jkY6aYlgdVu7KtcJebFspZz1quJPFjDwORSh58wWuxgZie6Hp28YYemwhZDfbQ9R6bkR5cCTKEGwohv3p22FP9WtOXSHZsd6X+xO86OHAaJOaTpI6cRw5/LIQrjL4ThZyix3zAT8yBPkAFLt1wSh7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqG80Tbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FEBC4CEE3;
	Fri, 13 Jun 2025 06:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749795129;
	bh=xkYpzMUmOpY1cRCi/aFqu67aJwISXF0l+SAsHg0sZ6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AqG80TbevqI95q4rg/vd3Re6AvxNi3B/ZR/eNtrGI+flPrhTULQEjQojte3zWgT/M
	 EpfsbX94xA2R6Z6YdTGy8ROY8w5Uu2FWfliX8hg8SVSl+XuLh3W7cOIltWA0uf+wvd
	 lDrAWiAcUhV3RN+vwz0W0gzvOK1p9jXclh53SZzN6YwLojDVUliblGUvN+u6VvM1Cf
	 V59pJB6awEHfJHSvCykV0UREglW332I1QJuNgdFaymsd9qTmRRkvmPfmIK76FOAzef
	 ITpOsM/OupUl3/ul6t7hEXSUyqFmjLpalj8gHsLqAXFtX++3Q7mlejlKybBEFf1p1r
	 5J8EfoHZnGPBA==
Date: Fri, 13 Jun 2025 11:42:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ammar Qadri <ammarq@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Reduce verbosity of device enable messages
Message-ID: <56cc4h6daxofmooafh2ifquwtf37jajuaed7otdmkhozfnawz4@5zon6ttwegqf>
References: <20250507232919.801801-1-ammarq@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250507232919.801801-1-ammarq@google.com>

On Wed, May 07, 2025 at 11:29:19PM +0000, Ammar Qadri wrote:
> Excessive logging of PCIe device enable operations can create significant
> noise in system logs, especially in environments with a high number of
> such devices, especially VFs.
> 
> High-rate logging can cause log files to rotate too quickly, losing
> valuable information from other system components.This commit addresses
> this issue by downgrading the logging level of "enabling device" messages
> from `info` to `dbg`.
> 

While I generally prefer reduced verbosity of the device drivers, demoting an
existing log to debug might surprise users. Especially in this case, the message
is widely used to identify the enablement of a PCI device. So I don't think it
is a good idea to demote it to a debug log.

But I'm surprised that this single message is creating much overhead in the
logging. I understand that you might have 100s of VFs in cloud environments, but
when a VF is added, a bunch of other messages would also get printed (resource,
IRQ, device driver etc...). Or you considered that this message is not that
important compared to the rest?

- Mani

> Signed-off-by: Ammar Qadri <ammarq@google.com>
> ---
>  drivers/pci/setup-res.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index c6657cdd06f67..be669ff6ca240 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -516,7 +516,7 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
>  	}
>  
>  	if (cmd != old_cmd) {
> -		pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
> +		pci_dbg(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
>  		pci_write_config_word(dev, PCI_COMMAND, cmd);
>  	}
>  	return 0;
> -- 
> 2.49.0.987.g0cc8ee98dc-goog
> 

-- 
மணிவண்ணன் சதாசிவம்

