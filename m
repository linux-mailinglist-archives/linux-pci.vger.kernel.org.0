Return-Path: <linux-pci+bounces-38917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3F5BF7735
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 17:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8776734AF2D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E597333B951;
	Tue, 21 Oct 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roPlTOtv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A6224B04;
	Tue, 21 Oct 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061420; cv=none; b=YcuHORBrbvRtO+sBdcuLD2iaJSYzche5kXCqRngp2xUGM4fxV/4Zam57Lfb3MzSDmSjjvdN9LPoKYSKg3TWESp8/Yz8gM8r4oikjQSYRidZ47EigRZ0oJOj/hspglS60VpCM+AVnLQMCXIZkPPR3nE0zoCwiFSLSv+s+LtrKUkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061420; c=relaxed/simple;
	bh=SIfgMW6+1L99u8/WKIltT5QXdM0l7tjIz0tSRK9xgfU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LuCwmZXtjJRfd1myRGCbMNog0hgdcmxj3cJe797rfFE4maUhV8V/34mxuG2mgBj3yxOzGViX9X5sS/vfLoDiQ7YnZE0BbuYZzooo/G04iSqa9gZ5vpeh4p7Bji8xexFpIbVtEZYDQYQ7ggR4fXtD5UAnZ9bfMZZVC0fy3eST5HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roPlTOtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263D8C4CEF1;
	Tue, 21 Oct 2025 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761061420;
	bh=SIfgMW6+1L99u8/WKIltT5QXdM0l7tjIz0tSRK9xgfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=roPlTOtvA58TQApcmTx9G6kYiwG3eim7PDvttRJT8OmpSKYr9CBR4hU7r+Gm4+qKV
	 IySzVnMog2CMwwKQ4zgd795zCtNVakMpL8PBuFd+XWaX8A+cahew6LwBJYyg4XvNBA
	 YQ9Ifa2hvyWC+oGaRRbCrieHr2mkfhhrzncGXYtzyVM9OVB7w15zbOjZBUi+VPGGwD
	 0b7HtZJ+vlEdTDTErNHC3LJL9bPBOKVAs98Sqad4vvYh7A7EOZoi+HcW9RJ68K8oOE
	 3SocChZ6VTZaasCjzwQuQXMLeK7i6ZT1HioRgINBirFYt0UfoJdNM5V5egk9ERvzEw
	 HloS/yawaOsag==
Date: Tue, 21 Oct 2025 10:43:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mbrugger@suse.com,
	guillaume.gardet@arm.com, tiwai@suse.com
Subject: Re: [PATCH] PCI: of: Downgrade error message on missing of_root node
Message-ID: <20251021154339.GA1191348@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021153219.9665-1-andrea.porta@suse.com>

On Tue, Oct 21, 2025 at 05:32:19PM +0200, Andrea della Porta wrote:
> When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error message
> is generated if no 'of_root' node is defined.
> 
> On DT-based systems, this cannot happen as a root DT node is
> always present. On ACPI-based systems, this is not a true error
> because a DT is not used.
> 
> Downgrade the pr_err() to pr_info().
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  drivers/pci/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f1198..034486593210 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -775,7 +775,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
>  
>  	/* Check if there is a DT root node to attach the created node */
>  	if (!of_root) {
> -		pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
> +		pr_info("of_root node is NULL, cannot create PCI host bridge node\n");

If we're going to see this message in the normal course of events on
ACPI systems, I think maybe we should reword it so it assumes less
context.  "of_root node" is low-level technical detail that doesn't
even make sense to me without digging into the code.

