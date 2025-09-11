Return-Path: <linux-pci+bounces-35922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 647D3B53A40
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 19:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EFB3AE978
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663233191BF;
	Thu, 11 Sep 2025 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PldjBc3C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F822AE45
	for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757611227; cv=none; b=Qzv78/uHfDxnivD8FA+T7y49J0mtS0acXWJVOeOPKWj7DCHnAWD9u5BIJa63oM8O+XNGWtDUICvmIXy4EMbtFSiW1DgD84s/vbtgzwIeQX/SMB0HXQ2HbpzXW57FYhA07gQ+Cw/GSbN2vGxymaZgapLid2YE7acbcfGD0balkyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757611227; c=relaxed/simple;
	bh=hbEhwJDIl/jgi841TWjZImwF6JaKqpAARbu0N3Inwbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVNPzUeXpan8J8RAo7zjFZDTLXz7Lhlrb8Sg23A1Nak5I8jWw45Ax5hpBOzOS/m9qtsrJzLBG9tq1/8R8B/1ABN7fUp8zoBFBqS0C2dFBbos0hzJzcUy86ni36W2ke+9c2KMcMHVrkOYdHSlklX/15u3dWgbrL6LfPbQDcLjYNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PldjBc3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428D2C4CEF0;
	Thu, 11 Sep 2025 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757611226;
	bh=hbEhwJDIl/jgi841TWjZImwF6JaKqpAARbu0N3Inwbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PldjBc3CYZ8MjhOcwtVoext5JLpteZfnQt22F21O9Q7GjPDFgwJk3eQayWzCAOh+V
	 9/JVj4IGY4lvaCuvlF91LU2S9Fp/UYBYkUQHR3xfOLX1+PGBrSYFvvCczmJZ06Zm5p
	 gwJ2u7NrMKk/Hi9DrVe8MA9bIPw+150ESoyaQehbxPvZPGyA0D5F8RYM9ZRpRpBLVV
	 PxH3Io5hpcw3g9A01LhoIfhg30hGuvJVAEuRJsLKlCUY74K+QOxuGAB542Z62HsqAC
	 g3oScBP04vGENm5U0+v79Z6GDUYNsJHdrARlvdMRBQGvxYHS8kqg3eQAR9jaTi7eYr
	 atwTvJuydg4OA==
Date: Thu, 11 Sep 2025 22:50:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Fix doorbell test support
Message-ID: <bim7bvdqkoezqabg4u7qumqoykdf6gsjyvwly4hp677gzdci5u@xmyygmpfrnd3>
References: <20250908161942.534799-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908161942.534799-2-cassel@kernel.org>

On Mon, Sep 08, 2025 at 06:19:42PM GMT, Niklas Cassel wrote:
> The doorbell feature temporarily overrides the inbound translation to
> point to the address stored in epf_test->db_bar.phys_addr.
> (I.e. it calls set_bar() twice, without ever calling clear_bar(), as
> calling clear_bar() would clear the BAR's PCI address assigned by the
> host).
> 
> Thus, when disabling the doorbell, restore the inbound translation to
> point to the memory allocated for the BAR.
> 
> Without this, running the pci endpoint kselftest doorbell test case more
> than once would fail.
> 
> Cc: Frank Li <Frank.Li@nxp.com>
> Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Note: this is actually how the code looked like when it was submitted by
> Frank, see pci_epf_test_disable_doorbell() in:
> https://lore.kernel.org/linux-pci/20250710-ep-msi-v21-6-57683fc7fb25@nxp.com/
> However, the code was modified, without notifying the list of this
> non-trivial logical change, before being applied.
> 

Yes, it was my mistake. I did some cleanup while applying, but since I didn't
had access to the board, I couldn't test it. Anyhow, I should've notified the
thread.

- Mani

>  drivers/pci/endpoint/functions/pci-epf-test.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index e091193bd8a8a..b6ca1766a4ca9 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -772,12 +772,24 @@ static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
>  	u32 status = le32_to_cpu(reg->status);
>  	struct pci_epf *epf = epf_test->epf;
>  	struct pci_epc *epc = epf->epc;
> +	int ret;
>  
>  	if (bar < BAR_0)
>  		goto set_status_err;
>  
>  	pci_epf_test_doorbell_cleanup(epf_test);
> -	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
> +
> +	/*
> +	 * The doorbell feature temporarily overrides the inbound translation to
> +	 * point to the address stored in epf_test->db_bar.phys_addr.
> +	 * (I.e. it calls set_bar() twice, without ever calling clear_bar(), as
> +	 * calling clear_bar() would clear the BAR's PCI address assigned by the
> +	 * host). Thus, when disabling the doorbell, restore the inbound
> +	 * translation to point to the memory allocated for the BAR.
> +	 */
> +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
> +	if (ret)
> +		goto set_status_err;
>  
>  	status |= STATUS_DOORBELL_DISABLE_SUCCESS;
>  	reg->status = cpu_to_le32(status);
> -- 
> 2.51.0
> 

-- 
மணிவண்ணன் சதாசிவம்

