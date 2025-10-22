Return-Path: <linux-pci+bounces-38979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2B1BFB47D
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 12:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0423351325
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 10:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4F8314B86;
	Wed, 22 Oct 2025 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqgpcHEf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278783128AC
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127385; cv=none; b=SII2dU34A1wTa4UnmVX3pdFqYJyyRN40qZik/BwRrBunWmvjAO8xSWdLxFoFdcxdR8/OjdQMWUB61vIeX8JA3NhE2bHZBoeonb8kdoPzlgMsJ0hBmRy3+CBB4eQfqy+g6Oj3kACVxCx+X/7V7rXhtVBOwBiHnOolCaTZ/7RKB2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127385; c=relaxed/simple;
	bh=g2eQ/XRl5BAB5W6vH4Oc9qOLoxiOhuVNGppNMd8/IJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuycmz0BZhGJQ8CZgrrggjubn5ROss00zJHTofhnVmFJyVzYTn4S2GgzepkuC4GtJLyy+tg0gyDnR/6V2T1h89PRuqn9kjdEUKj+VaJfdPXD2ar54Wyq3RCj/lWKCdnuRvQuuEDPQO+L9IBG6bUqAUlYlJSQkeZdR/1iFeVaksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqgpcHEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FD8C4CEE7;
	Wed, 22 Oct 2025 10:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761127383;
	bh=g2eQ/XRl5BAB5W6vH4Oc9qOLoxiOhuVNGppNMd8/IJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NqgpcHEfGBRKySeZ21h5A8x8ZnywlgP2o7/HIVLL5MWt4WzFKjH8XdxVXPGsfQeyd
	 HXoq99H1HfgbuecSaGzWkaBa/NcMcWeeT1dLRnZ7ecCySB/JnYnUI+j/VXPQuJg5oO
	 J6HKMQUgAR4PgqmTwFo0mfqvSxfdUY5u74J4RVS0WW5U2hThDPrHXmJN7zZfMPHv9a
	 QUiebCCJP+V3lEwJcmarpyEBh8d5uWXRzQdBNZY0JNOecE7c2gZb3jxZAutfb25HbW
	 ZtThhy41S+1Uh22Jj97Xo1huK7+x7X2M+CWJAiZUyB3t8hacWDvbbRsTS7tVsLOzeg
	 MhP82qtL2bH1A==
Date: Wed, 22 Oct 2025 15:32:47 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-rockchip@lists.infradead.org, 
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: of: Add of_pci_clkreq_present()
Message-ID: <eorncfyktfdc33md7ogqccy5z2lsye7ew32wdy4sbegvjo2rdl@qp2zy7u75jqg>
References: <1761032907-154829-1-git-send-email-shawn.lin@rock-chips.com>
 <1761032907-154829-2-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1761032907-154829-2-git-send-email-shawn.lin@rock-chips.com>

On Tue, Oct 21, 2025 at 03:48:24PM +0800, Shawn Lin wrote:
> of_pci_clkreq_present() is used by host drivers to decide whether the clkreq#
> is properly connected and could enable L1.1/L1.2 support.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>  drivers/pci/of.c  | 18 ++++++++++++++++++
>  drivers/pci/pci.h |  6 ++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f1198..52c6d365083b 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -1010,3 +1010,21 @@ int of_pci_get_equalization_presets(struct device *dev,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> +
> +/**
> + * of_pci_clkreq_present() - Check if the "supports-clkreq" is present

I don't see a benefit of this API, tbh. The API name creates an impression that
the API will check for the presence of CLKREQ# signal in DT, but it checks
for the presence of the 'supports-clkreq' property. Even though the presence of
the property implies that the CLKREQ# routing is available, I'd prefer to check
for the property explicitly instead of hiding it inside this API.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

