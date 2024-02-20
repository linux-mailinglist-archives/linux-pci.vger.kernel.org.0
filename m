Return-Path: <linux-pci+bounces-3794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B92CE85C69F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 22:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB58A1C2175F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 21:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D60E151CD8;
	Tue, 20 Feb 2024 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRDUXE4O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BEF151CC4
	for <linux-pci@vger.kernel.org>; Tue, 20 Feb 2024 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463012; cv=none; b=PYNG7JdEv0dGwwchNzP7icLpojySxIM6hdSvCZVK2ClT89/XG944won3wP75pb7Sfiv4Vpuc8J8ObMbgoMQMTIk3DkYEkbTpwpBbuvqT37Rns1FtQg/2IJdfkFBkHOiVD2t02AkGlq3aTYZrghTzlP3RDG1/xEFHPsyXo8vbeSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463012; c=relaxed/simple;
	bh=DTj5N2livwF+s0oD5CccQoLjKfkfpeU0TF0gSYXmVLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=g/nE1W87M+kJhYHeanAwBUcPy95Uq/hLkOzkHGvdn33eOgRFAxfhtHUZK0trw24+qcG89xxcaeOkC/4LLpbuJO7plOeB8Foy4JbWAMoDbdVswnxXBZYSF6D4lgZvyjbAQt0oDwg9ZQdLSxzA2dQq1sdp22sv3sM6yjT+wLRcjV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRDUXE4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC4DC433F1;
	Tue, 20 Feb 2024 21:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708463011;
	bh=DTj5N2livwF+s0oD5CccQoLjKfkfpeU0TF0gSYXmVLI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sRDUXE4O9mKg0a3aY3lvhh/rxwIfUPHloAWYWUuhw0T6ga5+5iY6rIhPpDEmYLcZy
	 Ktv0tfnlq2cCfi+yW9HC3Bu6b3G0zi1h10OLT1UBlPv/CnB6ONvpmR8PnkNroXc33a
	 Z+EE0fARX2JIT1B32+aeUlLlEgS1hPbh9mhUb5u/yWwlXt4ruaBZ5Jpo0slMvzsDP7
	 54WX766ssGT1xsKJCUH2xfiEXSpnO5RLB3+Kk6eQnWmvZLIkn+vwWJT0BW9Xw/hM4p
	 QjL0gSojY+cx8qQ0x9Fqlqeb/2bdxUaMo23D/MdvLV+Luv77yqe4iWsbl1hwuMeBiO
	 h8HTIe4iZvjpg==
Date: Tue, 20 Feb 2024 15:03:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?SsO2cmc=?= Wedekind <joerg@wedekind.de>
Cc: linux-pci@vger.kernel.org, aradford@gmail.com
Subject: Re: PCI: Mark 3ware-9650SE Root Port Extended Tags as broken
Message-ID: <20240220210330.GA1505965@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219132811.8351-1-joerg@wedekind.de>

On Mon, Feb 19, 2024 at 02:28:11PM +0100, Jörg Wedekind wrote:
> Per PCIe r3.1, sec 2.2.6.2 and 7.8.4, a Requester may not use 8-bit Tags
> unless its Extended Tag Field Enable is set, but all Receivers/Completers
> must handle 8-bit Tags correctly regardless of their Extended Tag Field
> Enable.
> 
> Some devices do not handle 8-bit Tags as Completers, so add a quirk for
> them.  If we find such a device, we disable Extended Tags for the entire
> hierarchy to make peer-to-peer DMA possible.
> 
> The 3ware 9650SE  seems to have issues with handling 8-bit tags. Mark it
> as broken.
> 
> This fixes PCI Partiy Errors like :
> 
>   3w-9xxx: scsi0: ERROR: (0x06:0x000C): PCI Parity Error: clearing.
>   3w-9xxx: scsi0: ERROR: (0x06:0x000D): PCI Abort: clearing.
>   3w-9xxx: scsi0: ERROR: (0x06:0x000E): Controller Queue Error: clearing.
>   3w-9xxx: scsi0: ERROR: (0x06:0x0010): Microcontroller Error: clearing.
> 
> Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202425
> Signed-off-by: Jörg Wedekind <joerg@wedekind.de>

Applied to pci/enumeration for v6.9, thanks!

> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d797df6e5f3e..2ebbe51a7efe 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5527,6 +5527,7 @@ static void quirk_no_ext_tags(struct pci_dev *pdev)
>  
>  	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
>  }
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_3WARE, 0x1004, quirk_no_ext_tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0132, quirk_no_ext_tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140, quirk_no_ext_tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0141, quirk_no_ext_tags);
> -- 
> 2.35.3
> 

