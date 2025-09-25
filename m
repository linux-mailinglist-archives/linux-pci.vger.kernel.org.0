Return-Path: <linux-pci+bounces-37007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A148BA0AF6
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 18:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158793A406E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AEF1EDA2C;
	Thu, 25 Sep 2025 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAe2Y+Xf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A782AD25;
	Thu, 25 Sep 2025 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818713; cv=none; b=b0lYGqW8tOy7J+RSa+907TSTsAdSMv9qyGQrcnaeOpSl7IuUF8BXNWUnM5Tz6dak2Gfl3nL3hOUfZnx2wBH6aYYRhUG4NW1NCsnYuCSa1VT3uPkBLtpwy9RwdK0tnviCveuVarFf/YQ/Dlo5gXsIRPTEam+tASuKzVM8y9sxfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818713; c=relaxed/simple;
	bh=7elF26Ve0F+Q3ywVODITsdvGWDRWqWm36UM6j8I3SsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCGSvP4aYgRfqRLk5JNXQPpZ+UuNljQ7tp+569bJJHVQ1bAdpewmkiwRmjULrjwxECu9RkfoSgtdTkdF+e3dGukmxvzk19Umy1Rdk1EhGTYWxdNUeCobdjJXW052oQGUZoHD+cecB/50iDVc3X54YeAlWiVz7VzGZTPr2N1GBLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAe2Y+Xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A047C4CEF5;
	Thu, 25 Sep 2025 16:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758818712;
	bh=7elF26Ve0F+Q3ywVODITsdvGWDRWqWm36UM6j8I3SsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAe2Y+XfLGw8ezGLmJQPvcRPz8r7cF5kqq+YWqLlb91oiUusYo4U/WAEgFIuN5Dl4
	 SLFmvWeW7KtxhCwOzhEIkd7Jp2J5F294napTDCYr2oaKRDOggWEC9mlHSh+t80sWbq
	 KbEPmxQWsDesKAir3uPhaWhmr4EzDF9w1Z7fykLSTNVL/udUl+1IDlxXHV4iTgQXDD
	 lJK1L2uoG+U539wlftgeuZLT6zHF4/FTeFqoeIChJauq1/qJ+QcJkDxT/EjdL10s00
	 0tnzjpS/tcwX/+T8xjmOupfTCb3D5pwiZazIkP/ClZtaD4J8R/T31UT5NZlP3cO1Gv
	 3iNQr39tuwwZw==
Date: Thu, 25 Sep 2025 22:15:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	linux-pci@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3] PCI: rcar-gen4: Add missing 1ms delay after PWR reset
 assertion
Message-ID: <befzloabtpkvgcehzllqa7iy7657citnge7zzoq6kqbbsvy32d@hxhlyoltqvp4>
References: <20250919134644.208098-1-marek.vasut+renesas@mailbox.org>
 <20250919141340.GA709855@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919141340.GA709855@rocinante>

On Fri, Sep 19, 2025 at 11:13:40PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
> > Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Missed a tag from me. :)  But we can add it when applying, no worries.
> 

I've added your tag while applying:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/rcar-gen4&id=23291403391180b0312405bb3d8fa8546124c643

Thanks, Krzysztof!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

