Return-Path: <linux-pci+bounces-6408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2009B8A94FD
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 10:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A29CEB2220B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 08:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326BE145B17;
	Thu, 18 Apr 2024 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjD/4+e4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C0B12FB00;
	Thu, 18 Apr 2024 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428983; cv=none; b=ozzeS2VEXknQJ+MDB2XHjuGdHfl+JAyc4LRPo59VSoidrstAFo3AsIkcl57uMUm6YBoCMOQbq1PCNAcQ+A885alcrEKyPgXdiP7K4qzpQmQ3cKJvzbF2hlXR9vMO1hX+vSyyf5VV+J1ImyM8JQHnsTwWs7nnZcANkvbLLzmvXuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428983; c=relaxed/simple;
	bh=epqtCU7cHFg6qcrksoflXTGplFleqVGd4CaEPMYW1d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQhfNovP+f2gfn5p8G4qlDL6ML8gQgffOGDD0nGdMhm15lzDBxZq+AcBprDac/xzRDq1Dh7g6Lrn5wiMVYIpUXksEY/CWsbNK8ONLNVVq07t54Nfz0nPZJ93ZjpLx76j2pnPJKsEgsP89qPSl0Xkb5xT55SFAzyRuVJAxTjjKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjD/4+e4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AF8C32781;
	Thu, 18 Apr 2024 08:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713428982;
	bh=epqtCU7cHFg6qcrksoflXTGplFleqVGd4CaEPMYW1d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tjD/4+e4vSScmvSoEvYQoRNeiQAYlbYXzasd0/Rl0orlzzFKkOvIvRkR8cKoA1I6Q
	 dposssKjjyWT4Y52T/bz7YfGNkxruHcxz33+n9Y5snKbqpZSQRVtQYJuPZuZs/Sg1R
	 k3Q1Q8Cfm38H26kT6/1vhLW7dXnRqNGxRM0FYxj4PAMYa6gVM5YzFxdCc5LtBPHJAq
	 lLX/ybDMiolc5dRUDXD4x5k7nGsRUGoh7yYT+wUwLOcGRYQr1vyKeUAtwk/cEQkanK
	 SqwWXSqmEU8tVYaicFqMnxbDR/TyD5fnpaFWwCWkX4rbRrIchayKcN3MKMr0wCwVpM
	 AbvDMyzTJWhfw==
Date: Thu, 18 Apr 2024 10:29:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: endpoint: pci-epf-test: Use 'msix_capable'
 flag directly in pci_epf_test_alloc_space()
Message-ID: <ZiDZ8Rwe-3JQWQ1E@ryzen>
References: <20240418-pci-epf-test-fix-v2-0-eacd54831444@linaro.org>
 <20240418-pci-epf-test-fix-v2-2-eacd54831444@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-pci-epf-test-fix-v2-2-eacd54831444@linaro.org>

On Thu, Apr 18, 2024 at 01:29:59PM +0530, Manivannan Sadhasivam wrote:
> Instead of using a local variable to cache the 'msix_capable' flag, use it
> directly to simplify the code.
> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

