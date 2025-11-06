Return-Path: <linux-pci+bounces-40442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9456C3876C
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 01:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEFD3AAFDE
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 00:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDE0282EE;
	Thu,  6 Nov 2025 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA2Z7qqi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6350820ED;
	Thu,  6 Nov 2025 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388627; cv=none; b=Bfv0tfpBdKgJd4++MXXpBFihfLrcHGwBprILLIDAvZK3V7TRCVbX5XNZ3NWpSCQVYjMbqUiMSwFpsylUwAsGZU3J5iGNrmWRuuqVcBQVHObK9k2fPr+K1NRC1PODzqj2vtDR0l2zhfXLvd6yKUwx+/9Njwi7cikaP7HiCJkglP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388627; c=relaxed/simple;
	bh=Ozvfio3vYr6iNgu6y1gyJfptAATCU0qaeXNG5pt/vvg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Z/uWTKj/bqr5AECgJKtCZSTSqbTxx7Es+VUXPhQbiFIbqpgd7QV0F40lI8z9Bt0c2BhilgL/b0yMCchnp0wJQVvLNWDohDn36R8X/MOfeJPi7lFGaX9KNDedavqPLVbj1cuJKwSQXRH4F70PgplIvtZoEG3vkEAfSVmc4PUxwec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA2Z7qqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCDDC4CEF8;
	Thu,  6 Nov 2025 00:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762388626;
	bh=Ozvfio3vYr6iNgu6y1gyJfptAATCU0qaeXNG5pt/vvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hA2Z7qqiigBYq0k9E8g9OHaaH1ACaN6nuQ9Rmp2BfpB1YvSCSB+5cr3WpzidVrxGM
	 bzefCrJ5X41IxxOxDWjGATzuYzi4fQp3QMHWqaAZ8zBbUfm9+haoUQnCF5tMenBC2Y
	 tOcRbGtGT4L547wHfWD6A7TueFec5K26i8htJqb4t++6XyoF8ZCCDAf87JUlyhJtEW
	 N2XHUwPdNzbvJpE7K9C5U3vmFInD3sfeSbL9+QDE1Rt3zypEYNJCnalhZ7b1j7ZsdA
	 DAY3BNnzZBFu1PJnC2LMkOTu6ngPbzHd1VZOAe4Zu3luygiPaX7zO5M0GnpJGyOLYW
	 PwAbssw32Yzaw==
Date: Wed, 5 Nov 2025 18:23:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mbrugger@suse.com,
	guillaume.gardet@arm.com, tiwai@suse.com,
	Lizhi Hou <lizhi.hou@amd.com>
Subject: Re: [PATCH v2] PCI: of: Downgrade error message on missing of_root
 node
Message-ID: <20251106002345.GA1934302@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <955bc7a9b78678fad4b705c428e8b45aeb0cbf3c.1762367117.git.andrea.porta@suse.com>

[+cc Lizhi]

On Wed, Nov 05, 2025 at 07:33:40PM +0100, Andrea della Porta wrote:
> When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error message
> is generated if no 'of_root' node is defined.
> 
> On DT-based systems, this cannot happen as a root DT node is
> always present. On ACPI-based systems, this is not a true error
> because a DT is not used.
> 
> Downgrade the pr_err() to pr_info() and reword the message text
> to be less context specific.

of_pci_make_host_bridge_node() is called in the very generic
pci_register_host_bridge() path.  Does that mean every boot of a
kernel with CONFIG_PCI_DYNAMIC_OF_NODES on a non-DT system will see
this message?

This message seems like something that will generate user questions.
Or is this really an error, and we were supposed to have created
of_root somewhere but it failed?  If so, I would expect a message
where the of_root creation failed.

I guess I'm confused about what the point of this message is.  If it's
just a hint that loading an overlay in the future will fail, I assume
we would emit a message at that time, connected with the user action
of trying to load the overlay.

What badness would ensue if we downgraded this message even further
and removed it completely?

> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
> CHANGES in V2:
> 
> * message text reworded to be less context specific (Bjorn)
> ---
>  drivers/pci/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f1198..872c36b195e3 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -775,7 +775,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
>  
>  	/* Check if there is a DT root node to attach the created node */
>  	if (!of_root) {
> -		pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
> +		pr_info("Missing DeviceTree, cannot create PCI host bridge node\n");
>  		return;
>  	}
>  
> -- 
> 2.35.3
> 

