Return-Path: <linux-pci+bounces-34302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AC4B2C577
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 15:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E254D7261A1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B0D343205;
	Tue, 19 Aug 2025 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBWH+Oaa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA14341AD0;
	Tue, 19 Aug 2025 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609544; cv=none; b=DCQqrdd9CjfgbfUl1y+zLhehIR8zT1rKTDHBfghfZ/cfdGadY0faDR9fYSMPNG4t44BoGXXV8Vem+1tgLVihegGVpjniFW1GWVuxUd/m7fkVsbf8sQLVU59ILRnbhZpWS4FsGzbaueZPHYq3Ev1B5o0O1EJrvsAzGNb8xwdaazg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609544; c=relaxed/simple;
	bh=9Y9s9Kvi8cEa4WOZ8u9wTUuCxaq4lzwzCYjLfM+x3FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKdjGAtr4VIvXDwMD2m6srwQ+SM6guRPgTZW8dIP93hRdY4q6qQz6fuwEGHkOnB/34SC44z0WoTKQuLz99cQePFvxvcc0/Nfk2q7uOxgPgYu/wnz7Zk9hkiQ5QVeqjnR7PbJnSePOt41jsYTjqqmUreKqpqNw/gE7uTf7TcrNk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBWH+Oaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4E9C4CEF1;
	Tue, 19 Aug 2025 13:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755609543;
	bh=9Y9s9Kvi8cEa4WOZ8u9wTUuCxaq4lzwzCYjLfM+x3FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GBWH+OaaA87ky6Vocngl1VD0uMb5TR94CnxBnMZquK5Sn+R2/GB0qxPZPXuYvuNtG
	 w+dzmmLot07Ty/Kyzee0sFB5nc7prvYfxRf8X8o19PuSBxIiDEF6FC2w2/kfxZPIC+
	 yp0DHCdU53VYQot/I5H3pqUOOzCdDH5d8YMF5ic/ljc+EDKZGZ6mFbeleiqR761BG0
	 afZw1Rn2P95XnG5LheqcFrQq0OZwj8ERM4FLK7N8AxssClptRxS+Ln2yZMLDlA1pmy
	 EDs68z3KpIrII64lvZMGV4oB6EX2PksIzjjwqSO+xB7FDFP4AFY4Awkbwz1kJVD++l
	 mteRCbY3IohXw==
Date: Tue, 19 Aug 2025 15:18:59 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: Re: [PATCH] PCI: of: Update parent unit address generation in
 of_pci_prop_intr_map()
Message-ID: <aKR5w1QIqYUO2upd@lpieralisi>
References: <20250818093504.80651-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818093504.80651-1-lpieralisi@kernel.org>

On Mon, Aug 18, 2025 at 11:35:04AM +0200, Lorenzo Pieralisi wrote:

[...]

>  drivers/pci/of_property.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 506fcd507113..09b7bc335ec5 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -279,13 +279,20 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
>  			mapp++;
>  			*mapp = out_irq[i].np->phandle;
>  			mapp++;
> -			if (addr_sz[i]) {
> -				ret = of_property_read_u32_array(out_irq[i].np,
> -								 "reg", mapp,
> -								 addr_sz[i]);
> -				if (ret)
> -					goto failed;
> -			}
> +
> +			/*
> +			 * A device address does not affect the
> +			 * device<->interrupt-controller HW connection for all
> +			 * modern interrupt controllers; moreover, the kernel
> +			 * (ie of_irq_parse_raw()) ignores the values in the
> +			 * parent unit address cells while parsing the interrupt-map
> +			 * property because they are irrelevant for interrupts mapping
> +			 * in modern system.

Rob,

if you apply directly the line above should be "in modern systems" please.

Thanks,
Lorenzo

> +			 *
> +			 * Leave the parent unit address initialized to 0 - just
> +			 * take into account the #address-cells size to build
> +			 * the property properly.
> +			 */
>  			mapp += addr_sz[i];
>  			memcpy(mapp, out_irq[i].args,
>  			       out_irq[i].args_count * sizeof(u32));
> -- 
> 2.48.0
> 

