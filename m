Return-Path: <linux-pci+bounces-19926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FB5A12DA5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 22:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74238165337
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 21:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3131DA112;
	Wed, 15 Jan 2025 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHLyWmRt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B244D599;
	Wed, 15 Jan 2025 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976222; cv=none; b=MipfgNabt8ODMEKE944H3L+/BpZ0xM+M1M5OPE04UKVZW1FEJV1UoJqQ2uN1tLW9r1FiGwmjkOLhZCJdtKCv2lTpfvGOREym3OhhLDl7d9JU93irALh2nTSgIzPOrNggA6Q5UfDIZyrZGmv7s5+Igtg1WXB9YT/B9ZhjFjCv070=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976222; c=relaxed/simple;
	bh=K2m9OC0t+D/5gOvlpKoFmcb3wmh4UAlmgG0BMqkpBFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NCYNgoQD4QU/821mniNHtqrKUV1RWM+MlfQjFXdC3rYJ56XAN75BFajAfRjPV9Yyf3KFgoch4PtOIQhncP51onDEJzcsTb74eEobDlseeGVpXmkhVrwDEB1G4Qv4IGnHBM6O25tekPU9KMnfqKV/5xmh+kKnyvqdkDzWZc1TXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHLyWmRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB77FC4CED1;
	Wed, 15 Jan 2025 21:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736976221;
	bh=K2m9OC0t+D/5gOvlpKoFmcb3wmh4UAlmgG0BMqkpBFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BHLyWmRtkde/FoKt7h6/Mv4q/yl7rxtiQbctYq5R1R+PCTXP/ITqnNHWLI1bLCwbE
	 cjBmLvWq4tqiXvHA6ptCFbr/Q/yHzaKbapXq2drrgqTZ+p2V+4je5buShrds8gKamJ
	 FcsJ1wrEBU8D3xHYSiFCvvwsZBdwt0iNi5XBd0ZcqCRr+C4SnvmxoY6d4Y9zfoAHZs
	 y/MNGrFSLOn0rQ3qPIlE4kvzk/SuoD1wcrn2OSmHmXLn5kCUqK0+lbcYJgSI9V1qI4
	 QImxte/mz+xvHOo1pR6QZA0cLX7icWW1KUoyDIkchbMh/nkUTcEgrWWr/UiJaIFMf6
	 4TZS+csToBpwA==
Date: Wed, 15 Jan 2025 15:23:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Tsai <danielsftsai@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Separate MSI out to different controller
Message-ID: <20250115212339.GA553488@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115083215.2781310-1-danielsftsai@google.com>

On Wed, Jan 15, 2025 at 08:32:15AM +0000, Daniel Tsai wrote:
> From: Tsai Sung-Fu <danielsftsai@google.com>
> 
> Setup the struct irq_affinity at EP side, and passing that as 1 of the
> function parameter when endpoint calls pci_alloc_irq_vectors_affinity,
> this could help to setup non-default irq_affinity for target irq (end up
> in irq_desc->irq_common_data.affinity), and we can make use of that to
> separate msi vector out to bind to other msi controller.
> 
> In current design, we have 8 msi controllers, and each of them own up to
> 32 msi vectors, layout as below
> 
> msi_controller0 <- msi_vector0 ~ 31
> msi_controller1 <- msi_vector32 ~ 63
> msi_controller2 <- msi_vector64 ~ 95
> .
> .
> .
> msi_controller7 <- msi_vector224 ~ 255
> 
> dw_pcie_irq_domain_alloc is allocating msi vector number in a contiguous
> fashion, that would end up those allocated msi vectors all handled by
> the same msi_controller, which all of them would have irq affinity in
> equal. To separate out to different CPU, we need to distribute msi
> vectors to different msi_controller, which require to allocate the msi
> vector in a stride fashion.
> 
> To do that, the CL make use the cpumask_var_t setup by the endpoint,
> compare against to see if the affinities are the same, if they are,
> bind to msi controller which previously allocated msi vector goes to, if
> they are not, assign to new msi controller.

It's crunch time right now getting ready for the merge window, but
some superficial things you can address when you get more detailed
feedback later:

Add "()" after function names.

s/EP/Endpoint/ at least the first time it's used
s/msi/MSI/ in English text
s/irq/IRQ/
s/the CL make use/use/ ("CL" looks like a Google-ism)

> +	 * All IRQs on a given controller will use the same parent interrupt,
> +	 * and therefore the same CPU affinity. We try to honor any CPU spreading
> +	 * requests by assigning distinct affinity masks to distinct vectors.
> +	 * So instead of always allocating the msi vectors in a contiguous fashion,
> +	 * the algo here honor whoever comes first can bind the msi controller to
> +	 * its irq affinity mask, or compare its cpumask against
> +	 * currently recorded to decide if binding to this msi controller.

Wrap comment to fit in 80 columns like the rest of the file.

s/msi/MSI/
s/irq/IRQ/

> +		 * no msi controller matches, we would error return (no space) and
> +		 * clear those previously allocated bit, because all those msi vectors
> +		 * didn't really successfully allocated, so we shouldn't occupied that
> +		 * position in the bitmap in case other endpoint may still make use of
> +		 * those. An extra step when choosing to not allocate in contiguous
> +		 * fashion.

Similar.

Capitalize beginning of sentence.

Some of these are not quite sentences or have grammatical issues.

Bjorn

