Return-Path: <linux-pci+bounces-35640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C43B48534
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 09:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6BF3B8DF1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 07:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868C62E6CC3;
	Mon,  8 Sep 2025 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8/g5uyV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFC72DEA6A;
	Mon,  8 Sep 2025 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316539; cv=none; b=R/0/D1/f88pqn9VFM/7b7s5FA63Q7SGhOnTjt/3P6IncvfXIdHGcdHlfru9qdnlHzULCadCaTB06itTFTJo8/QfRHjIL+DyNJZtveoXqWOeDiRhRA6o3UHJSbMmT7+4WDAj4jnC0K0e0xWE/cZBn/DD1vjk2M2OUTIM4MoMf6Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316539; c=relaxed/simple;
	bh=RDvvo3xdx4TsaQjK5xSMvu9RP3KZphhm9dRO9PYFaHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CY60jocSqb4vHmxusTFp2p1s/fRSSuo1oWiKwsvW/N6DWQcJND35g8wM5BmC24bN+nAaLLpKrK4gvDXU3NJoaBEhPBMrII0rRoTcrq0fOK3tm7fIWBXpXoBr2hvpLwTzRiodLXvqMfUtu+rKRpd9guwa16EBdDlPgJ0ZoOHmj50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8/g5uyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EB2C4CEF1;
	Mon,  8 Sep 2025 07:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757316538;
	bh=RDvvo3xdx4TsaQjK5xSMvu9RP3KZphhm9dRO9PYFaHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8/g5uyVIQHXN0e5mPL9I3N+5Fn6il5f2SU5KOSKgX89LWRmezpwmscDnBQlomDrA
	 aEBCNkVUN1lBdnEclWHE3VhOKuYCntWCldDEu7gJ74ZJ9iay1o8qfCECrOKrtsjbGl
	 bGirtqLfDtyXx11f2dN0SAZzmnwm/DDg3vBpdgF0GvG6VOktkr+VY9TvNLQVO7esmr
	 j0srYDy770j88l60UxOBdJi20ZbMBqydj40KYf73dg1BBvfz7YVDkKQ6iQegnXPX/f
	 9y4eynU6UU84qnbeQYveWvRhShVUzT4Fb/JsxJgLihah1qp66vbvLIcB1kCz9GfyQ9
	 RYU+pKsc7qzsg==
Date: Mon, 8 Sep 2025 12:58:51 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, helgaas@kernel.org, kishon@kernel.org, vigneshr@ti.com, 
	stable@vger.kernel.org, linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v3] PCI: j721e: Fix programming sequence of "strap"
 settings
Message-ID: <wvrouqouhrpoexmggwbc6vjz4xflnylzxrb2ffw3ai7656ehrt@keb53gb2tm2o>
References: <oztilfun77apxtjxumx4tydkcd2gsalsak4m2rvsry2oooqjna@2yvcx6cnuemm>
 <b2fb9252-6bfc-45da-973a-31cdfcc86b3d@ti.com>
 <z3ubracmtlq23yicbrhqjgnzrfoqheffm6cvhfnawlvbu4cmmp@ddu2o7xhw5tz>
 <48e9d897-2cd3-48ef-b46a-635ae75f5ac6@ti.com>
 <3wc3t6y5gzzspgfeklsqo3bupfp6gsfy6mls6t66hflcqlqsfk@cu26wv3sow4y>
 <9d2bba15-52e4-432a-8f7f-a0f5d7c2e4ad@ti.com>
 <7hxdcjm7evlphkldct7seytno4is7rjkx5vquvtfhpdkzxdhu6@yocrjgzciwu3>
 <08b87b5f-838b-4f40-ae90-10ded134356e@ti.com>
 <whinfqhjgqbbvlnuzgbukklqi6gocjji4gakqyycovrse4qq6s@6xq5imqbzvux>
 <a0e1d273-239b-44e5-8ccc-0ba83b2b5839@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0e1d273-239b-44e5-8ccc-0ba83b2b5839@ti.com>

On Thu, Sep 04, 2025 at 11:33:00AM GMT, Siddharth Vadapalli wrote:
> On Wed, Sep 03, 2025 at 06:51:14PM +0530, Manivannan Sadhasivam wrote:
> 
> [...]
> 
> > 
> > I thought put_noidle() will just reduce the refcount and not invoke the
> > idle/suspend callbacks, but I seem to be wrong here.
> > 
> > Anyway, I guess we have no option here other than to drop the
> > pm_runtime_put_noidle() call. This will keep refcount as 1 and will prevent the
> > parent (genpd) to not enter runtime suspend, but we have to live with it (this
> > was also the previous beahvior as well).
> > 
> > Btw, pm_runtime_set_active/enable change belongs to a separate patch.
> 
> I will work on and post the v4 patch with the following change:
> - The commit message and the comment in the code will be updated to
>   indicate that the runtime PM APIs are used to cause 'genpd' to power off
>   and power on the controller.
> 
> I assume that the driver changes can remain as they are in this patch given
> that the existing behavior has to be preserved. As j721e_pcie_ctrl_init()
> programs the strap settings, powering off the controller via
> pm_runtime_put_sync() and powering it on via pm_runtime_get_sync() shall
> be implemented within j721e_pcie_ctrl_init() itself leaving the rest of the
> probe function as-is. To summarize, the driver changes will be:
> 
> 	j721e_pcie_ctrl_init()
> 		...Existing code...
> 	+	Add pm_runtime_put_sync() here to power off controller
> 		...Existing code to program strap settings...
> 	+	Add pm_runtime_get_sync() here to power on controller
> 		...Existing code...
> 
> Please let me know what you think.

I would've preferred changing the runtime PM calls as I suggested initially, but
still we would keep it incremented which brings the net effect to the same.

So you can drop my initial comment and post just this patch with improved patch
description.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

