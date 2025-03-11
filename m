Return-Path: <linux-pci+bounces-23416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F88BA5BD49
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 11:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 166AF7A3A17
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 10:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE97221F2A;
	Tue, 11 Mar 2025 10:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElSwj5Qk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D541E883A;
	Tue, 11 Mar 2025 10:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687870; cv=none; b=rJyZevypfA7Dp5WgrKebAL8yMraSGUkVUP0fnJwU8hsnC3902DhMFkZiuH8gns5Moz4ORFDha//j2ElTPpG80LeF4LVDS9zrVsdZxcrt/7cV5V1Zxw3m68MozSe2oXSKMLnxFV0P5ClfKq0Y61Bhj2bUngde145ZllcdBLlHh6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687870; c=relaxed/simple;
	bh=CTckZ7epoT1ghJ5aWpJlAtxZJq+ItRY/yYGHa0suNBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YY6E3wQZbQT6BrHXg1eYOwz81nyweF2xNHuA2gHBF82onwMVNGXSKhM+nhBVrwYpXgxc9iQSEWEOcx77txsclRXUoJgtsVOGI/cwwqFQ9IQKdotop99IcYx2OY0C+7omgqlE8c99VOM7yxP+bRYnWd2x+JNm1S0q97KqIpLcA/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElSwj5Qk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C51C4CEE9;
	Tue, 11 Mar 2025 10:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687870;
	bh=CTckZ7epoT1ghJ5aWpJlAtxZJq+ItRY/yYGHa0suNBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElSwj5QkgbSBLwC3K8n/3XoBXI2XEpmOs8L81V16ctzWWKDuOr8CllqFPbGix0ULH
	 U08b1Gsdody0XeIGGfl2m6yysqcgwlZpd+2l+RuZMql7VwJ58Ko1BGtkZfn7e6eZvv
	 /9/43ULkjwUaU9Qs06beLD16Jyp+1TYFJgPcydTO275L+JHhAtqXw7XZ7wtdUTiwhv
	 WQJrgvIllwBq15MjkcJ/1aFnC8+UHyDc3QDPS2+LUSJrjM5L7rVZkMZG4X5ueMvma5
	 LoRZJVnqLXVT2AAj343zlFBiQvg7E4dEUbPcdA5kd2mZG7ggLWoMigqiMSHJsLMmWO
	 P10wvTxkykO4Q==
Date: Tue, 11 Mar 2025 11:11:06 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [pci:endpoint-test 16/18]
 drivers/pci/controller/dwc/pcie-dw-rockchip.c:316:3: error: field designator
 'intx_capable' does not refer to any field in type 'const struct
 dw_pcie_ep_ops'
Message-ID: <Z9AMOhFy-igoJK_7@ryzen>
References: <202503110151.vQXf5yof-lkp@intel.com>
 <20250310182605.GA1179150@rocinante>
 <20250310184904.GB1179150@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310184904.GB1179150@rocinante>

Hello Krzysztof,

On Tue, Mar 11, 2025 at 03:49:04AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > [...]
> > > vim +316 drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > 
> > >    313	
> > >    314	static const struct dw_pcie_ep_ops rockchip_pcie_ep_ops = {
> > >    315		.init = rockchip_pcie_ep_init,
> > >  > 316		.intx_capable = false,
> > >    317		.raise_irq = rockchip_pcie_raise_irq,
> > >    318		.get_features = rockchip_pcie_get_features,
> > >    319	};
> > >    320	
> > 
> > I moved setting the .intx_capable property to false to the pci_epc_features
> > struct definition for RK3568, which is what I believe the intention was.
> > 
> > Have a look at:
> > 
> >   https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint-test&id=cb349262d9770e6478a7e91bdf438122b8cda44d
> > 
> > Let me know if this is OK with you.
> 
> Niklas, I saw your reply to this failure report.
> 
> Based on it, I fixed the patch and dropped any annotations added (since
> there was no need to do anything aside from retroing the code to its
> orignal form).
> 
> 
> That said, I didn't do any edits when applying the patch that I can recall,
> so I think something got its knickers in a twist when I was applying the
> patches.
> 
> However, I did miss that it got applied incorrectly when reviewing the
> changes before pushing them.  My bad.
> 
> Anyway.  Sorry for the commotion.  I am glad the fix was trivial here.

The patch looks correct on the endpoint-test branch.

Thank you for fixing it up so quickly!


Kind regards,
Niklas

