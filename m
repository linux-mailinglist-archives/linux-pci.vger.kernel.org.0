Return-Path: <linux-pci+bounces-18049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4F69EBA53
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 20:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13524282E9C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 19:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89A51D90CD;
	Tue, 10 Dec 2024 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcgeKpQ6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BBA153BF6;
	Tue, 10 Dec 2024 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860203; cv=none; b=IpraTqIK766KGAmSPzuHxoe2NJa3cT1xZkK2pz1/Gv/ewSF3rTgUX29g5lggQ0N25sVchBOxTXlStsIR5VYw5GucxQssTlaTm3GuA+OTjwvy15MqdmDhxctVJhLBHT4I8Z1UcvMA2FFwZagyC7GvjGPMT0acXxEQ0CHY/NL2yzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860203; c=relaxed/simple;
	bh=nXb2KRfSy8/JFRr7iLRBAg1k7V69SNd0c789LpVFGq8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GTUTwYalXYkUrEpP7oCQPYBFfQDCTThhwgyQJbIR+P/2Mh3KzcqIIaZ6C7na0/ZTUeyS57xB6boh9Fv1OKquHoBA/QcnnAsqbTB8VazCvfWb+6BTTKuzIUjOrVnAUUepSXR2lrlTUetYEBoKoSCNB1RQjSzzjERZOs/XwTDwbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcgeKpQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22067C4CED6;
	Tue, 10 Dec 2024 19:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733860203;
	bh=nXb2KRfSy8/JFRr7iLRBAg1k7V69SNd0c789LpVFGq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VcgeKpQ6Etbkt5LQKDGNP+cLb912M7CAg03Xl8PySB2KiDZ8GTDoTVdlfyLNbBRGT
	 JO2l9iEBSXbt6BjyuET/a7a59pc/AMx5wNSgk6ySL21kyEnr8IukB4+cKXm1SITVtO
	 g/GyF0REa6vrvP2RLOJJGW8+tdC29HxnXCvx4JNdX02LOKrorajnT+DDmFPFkLK7UI
	 pp6cCG+BPiid7bBU9rDUXLONrUO5l1k5tOr0NkRfSMe+pYigmUz7gEgiua2BE0Hb4l
	 BrFa176rLqhFroMPhzGuxBnVSa/XPGpDm5Z1/lN/w6SrZS2Q0gmXxUj8fm0iy3TOw3
	 BkxpQCKYxqu8g==
Date: Tue, 10 Dec 2024 13:50:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHv2] PCI/ACPI: _DSM PRESERVE_BOOT_CONFIG function rev id
 doesn't match with spec.
Message-ID: <20241210195001.GA3254053@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114030424.45074-1-zhoushengqing@ttyinfo.com>

[+cc Ben, original author of a78cf9657ba5]

On Thu, Nov 14, 2024 at 03:04:24AM +0000, Zhou Shengqing wrote:
> Per PCI Firmware Specification Revision 3.3 Table 4-7 _DSM Definitions
> for PCI. Preserve PCI Boot Configuration Initial Revision ID is 2. But
> the code is 1.

This _DSM function 5 was added in PCI Firmware r3.1, released Dec 13,
2010.  It's listed in sec 4.6 with Revision 2 (as *all* the defined
functions are, even functions 1-4, which were included in r3.0 with
Revision 1).

But the actual definition that was added in r3.1 is in sec 4.6.5,
which specifies Revision ID 1.  

PCI Firmware r3.2, released Jan 26, 2015, was the newest available at
the time Ben implemented a78cf9657ba5 ("PCI/ACPI: Evaluate PCI Boot
Configuration _DSM"), and sec 4.6.5 still specified Revision ID 1.

So I think Ben's addition used the correct Revision ID (1).

PCI Firmware r3.3, released Jan 20, 2021, changed sec 4.6.5 to say
"lowest valid Revision ID value: 2"

I think it's a mistake to make the kernel change below because
platforms in the field implemented function 5 with revision 1 (per the
r3.1 and r3.2 specs), and we have no idea whether they implement
function 5 revision 2.

It's quite likely that newer platforms following r3.3 will implement
function 5 revision 2, but NOT revision 1, and the existing code won't 
work for them.

I think the fix is to try revision 1 and, if that isn't implemented,
we should try revision 2.  The semantics stayed the same, so they
should both work the same.

> Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to pci_register_host_bridge()")
> Origin fixes: a78cf9657ba5 ("PCI/ACPI: Evaluate PCI Boot Configuration _DSM")
> 
> Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
> ---
>  drivers/pci/pci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index af370628e583..7a4cad0c1f00 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -132,7 +132,7 @@ bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
>  		 */
>  		obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
>  					      &pci_acpi_dsm_guid,
> -					      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
> +					      2, DSM_PCI_PRESERVE_BOOT_CONFIG,
>  					      NULL, ACPI_TYPE_INTEGER);
>  		if (obj && obj->integer.value == 0)
>  			return true;
> -- 
> 2.39.2
> 

