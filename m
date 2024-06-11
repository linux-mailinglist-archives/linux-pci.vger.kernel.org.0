Return-Path: <linux-pci+bounces-8599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C2990421C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 19:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17854288FB9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E286F42058;
	Tue, 11 Jun 2024 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0rYQTa/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78503FB83;
	Tue, 11 Jun 2024 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125479; cv=none; b=DxcSsI9y1qBA2aruFY/s5wADJXlEn7wxEsbA9xR7OeYF9M1Y/cN0TI++looVwZR3mE04Qczv7lkxli/DN/Z1Q7ExAvESqW5jhcrloEMj7Eu9LmSEGkHRrvgAYOtA5fWMDmjAcEcHgEov0/AU+zwcRo8R8os4MkXQpPFjJxXar9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125479; c=relaxed/simple;
	bh=lqJhX3hH76dmmFicVO/WpvcL89wI/1+jJfKME2NrxwY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KqYfGPvAtpXfc9+fOgK+6xJIXqw441W8/Vhx/Of31p2Fp8nV6iJgJnz1YE1P1lDQAD1x/VPxAP9/nKzPNGSwoBuslI2QacYMNDgucZFaRZgaUroBxXt8EEwIPuMMcBOYFoVTCmQcM2VdWyuQ4Z2bBA/DInySxWpKvR6DI9uIPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0rYQTa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1179AC2BD10;
	Tue, 11 Jun 2024 17:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718125479;
	bh=lqJhX3hH76dmmFicVO/WpvcL89wI/1+jJfKME2NrxwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=t0rYQTa/LRnLznXbAnC8DdbHVFObu+ZoSZRHAQJ5Ug1eaRgslX2Wjc2eYKwylXfhz
	 2oGVqjTFxRL99WAndDKNEcoNavx0Fss2XtS8jsCAqgcfLYRlXB8l37cNRKmRDxDG4X
	 Ya/qU12w7G6Uo1zQlAf11YUPG0qWJS1Ozb1jAOTmqlQ3qhodAa2Jt4RHTm1VOFh4nW
	 1IvAUFCeVQlKMLZl/8EZq+yCGn5kfODAqHlVriMp5Qk/1477eW7SLznjkZMVGM5Whx
	 78vL5EDdRI96G+ijFSXRrcWJiDdLc5tGoPYcAGvaR6ur1j0ZLFBCBfYNT3RyKmihL4
	 zeZrWieix19xw==
Date: Tue, 11 Jun 2024 12:04:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] CREDITS: Add Synopsys DesignWare eDMA driver for Gustavo
 Pimentel
Message-ID: <20240611170437.GA989843@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611153059.983667-1-helgaas@kernel.org>

On Tue, Jun 11, 2024 at 10:30:59AM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Add the Synopsys DesignWare eDMA driver to CREDITS for Gustavo.  See
> 7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support").
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Added to pci/for-linus for v6.10.

> ---
>  CREDITS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/CREDITS b/CREDITS
> index 3a331f5fcd7a..8446e60cb78a 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -3149,6 +3149,7 @@ S: Germany
>  N: Gustavo Pimentel
>  E: gustavo.pimentel@synopsys.com
>  D: PCI driver for Synopsys DesignWare
> +D: Synopsys DesignWare eDMA driver
>  D: Synopsys DesignWare xData traffic generator
>  
>  N: Emanuel Pirker
> -- 
> 2.34.1
> 

