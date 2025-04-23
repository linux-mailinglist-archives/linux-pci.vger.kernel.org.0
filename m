Return-Path: <linux-pci+bounces-26618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE38A99A8F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 23:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27173BC4E1
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 21:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E97627E1D0;
	Wed, 23 Apr 2025 21:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCaMBBWy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CF226F44A;
	Wed, 23 Apr 2025 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745442772; cv=none; b=Yk+PX3fgVTRwC4miBCdY3AHshfw53M4RJlkj/RexqluUMwINPc4V+qk+IOxnAIlEfqb+hOqCsu4ewa+SZ2+xzu8nCdhef4Lokk+eEkweJO4BJGkJbC43g+Jbv7eiKfrreHV6W9twEgov/pZWuTZ44EIlZc42RFVHhoO7VGnhJ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745442772; c=relaxed/simple;
	bh=+QpdkPd9IJUMukQW+lJ8RRDAEMZr2tgENTUSXcm6iu4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A+h16sLk29a//X+5i+jEwiago39Rj700JKi0jOUBadlXWszhN9U01TNfneDT20M39Xk5atNoG8om18HXUlSsYGOz6MzSZMsaY1/zSexrMF2zG7Ri2TfwSNcz/u/trIaYjcjdUSICQp71MZzBo0Y132OrcxHrCC8eXuB9QEN/Y6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCaMBBWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CB8C4CEE2;
	Wed, 23 Apr 2025 21:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745442771;
	bh=+QpdkPd9IJUMukQW+lJ8RRDAEMZr2tgENTUSXcm6iu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QCaMBBWyTej2O8IAJD8y+vZa2WLchPCLcJmpfh1msoiYkLbesSFQV9/JAqwens0f6
	 lNaYCxqQ/tAr/8HpdtxcMsaETU1h52LGnQqagiGD152wr2U9VrGYgw+1zsg2AUwtTW
	 ReDuGUJRhMEhMGgcCc1iULGKtgQcqBxbM/+WW36dYzqgTJCYaJGN6vgFRbvyxdF50N
	 kztfKrhdOMO7CQcCXh/hZz5m1vG+EOYWxLsMy5p3/ibUOA8ZfJ41hEPDvTkyCQwzWa
	 S9GhSuA9NlwbJ6PKf3E67FYx/ByY8TWXSyr6/GUa/7oIeIVWWG1WP5YGWwPfOriIE3
	 OkdEVkYQzDGSQ==
Date: Wed, 23 Apr 2025 16:12:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix path for NVMe PCI endpoint target
 driver
Message-ID: <20250423211250.GA456226@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423095643.490495-1-rick.wertenbroek@gmail.com>

On Wed, Apr 23, 2025 at 11:56:43AM +0200, Rick Wertenbroek wrote:
> The path for the driver points to an non-existant file.
> Update path with the correct file: drivers/nvme/target/pci-epf.c
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

Applied to pci/misc for v6.16, thanks, Rick!

> ---
>  Documentation/PCI/endpoint/pci-nvme-function.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/PCI/endpoint/pci-nvme-function.rst b/Documentation/PCI/endpoint/pci-nvme-function.rst
> index df57b8e7d066..a68015317f7f 100644
> --- a/Documentation/PCI/endpoint/pci-nvme-function.rst
> +++ b/Documentation/PCI/endpoint/pci-nvme-function.rst
> @@ -8,6 +8,6 @@ PCI NVMe Function
>  
>  The PCI NVMe endpoint function implements a PCI NVMe controller using the NVMe
>  subsystem target core code. The driver for this function resides with the NVMe
> -subsystem as drivers/nvme/target/nvmet-pciep.c.
> +subsystem as drivers/nvme/target/pci-epf.c.
>  
>  See Documentation/nvme/nvme-pci-endpoint-target.rst for more details.
> -- 
> 2.25.1
> 

