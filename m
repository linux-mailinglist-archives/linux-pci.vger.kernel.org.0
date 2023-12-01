Return-Path: <linux-pci+bounces-344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AC9800ED6
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 16:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47F0CB20E19
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0554B5AD;
	Fri,  1 Dec 2023 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of7zrhHZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2084AF78
	for <linux-pci@vger.kernel.org>; Fri,  1 Dec 2023 15:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7D5C433C7;
	Fri,  1 Dec 2023 15:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701446004;
	bh=Z0b5BVslyfrqgtbZ4YRuZ38WQuFzRRb7gFv+mS/ELXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Of7zrhHZR3zdxbtwFj8w34us/XZGonkVZ/fs9bneTntO9uhsXiCFrRvxdW/Rg5s03
	 GOo5jrIiVMBqPXHNhL6acynkOhY5UcwdFkn+DZM+fADd70DPOhi3ptTbRF6rJQ1VMD
	 ge/NiHq+q1zm2REY4ynj2v8//wjdsIZJiXoYwkDKZZfWgmG+eJGfWc937bbhpP73dH
	 83T0HaWcXr0paSmHw5rv03VsTRcWA3+4me/W1Z132BiR9abcAEoHjP/OAMmCBF+Eqq
	 fyX2H72S63kQvmHc/rIVlpUBkQQXx5UhaGPMHBxqWOVD3gtTU5gCiXb8KLH3LaJYwR
	 a7OXWIciSztsw==
Date: Fri, 1 Dec 2023 09:53:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
	TonyWWang@zhaoxin.com, YeeLi@zhaoxin.com, Leoliu@zhaoxin.com
Subject: Re: [PATCH] PCI: Extend PCI root port device IDs for Zhaoxin
 platforms
Message-ID: <20231201155320.GA518898@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201120942.680075-1-LeoLiu-oc@zhaoxin.com>

On Fri, Dec 01, 2023 at 08:09:42PM +0800, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> Add more PCI root port device IDs to the
> pci_quirk_zhaoxin_pcie_ports_acs() for some new Zhaoxin platforms.

Can you please add a note about the plan to deal with this for future
devices, e.g., something like "future Zhaoxin devices now in
development will advertise an ACS Capability as described in the
PCIe spec"?

The point of quirks is to work around hardware that is broken or
doesn't conform to the spec in some way.  We have to add quirks when
broken hardware is already in the field, but we should have a plan to
fix newer devices so they don't require quirks.

> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
> ---
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ea476252280a..db74f8f07096 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4709,7 +4709,7 @@ static int  pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
>  	switch (dev->device) {
>  	case 0x0710 ... 0x071e:
>  	case 0x0721:
> -	case 0x0723 ... 0x0732:
> +	case 0x0723 ... 0x073b:
>  		return pci_acs_ctrl_enabled(acs_flags,
>  			PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  	}
> -- 
> 2.34.1
> 

