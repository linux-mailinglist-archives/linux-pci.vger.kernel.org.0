Return-Path: <linux-pci+bounces-20098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01AFA15ECB
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 21:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367C61886DC3
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 20:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA273398B;
	Sat, 18 Jan 2025 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJWbtYzw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1CC1A304A
	for <linux-pci@vger.kernel.org>; Sat, 18 Jan 2025 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737232464; cv=none; b=uZXCKGI53BHDPqA9dSabfOB3DJis9tkfwab1blhoGW4cjvo8cMYKBbDw++OB2t7Jpf12EL9YE3gNRJJNqgEgF4t9EOoXyHpqPIvdWaK4mvwMbJVFnAlHHuAsu2gw6chW/bQU9A6L43P/RTStPWF4VnVJfWxa63OsKzSKukrUfzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737232464; c=relaxed/simple;
	bh=eiD4UGClhjsiTVa/nd6yhJ1rkdaTST+Rd+5CMAJzpWM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T0gnfmRePUtFejjfEKYlmrlDXxX/+G2AX2vwNdHv+8SyXalJEArEvoVyj3Vuki64iCZsUtkGA7FRU0PjtAeLVWagQ6BXh/UHhKS6uLW4Rg6Y8JcnNVd+x8YmElTZg2VF+VCOupLJufg72wOzvvwur4xaChUuzuwQ4uFt9C4SzRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJWbtYzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1EBC4CED1;
	Sat, 18 Jan 2025 20:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737232464;
	bh=eiD4UGClhjsiTVa/nd6yhJ1rkdaTST+Rd+5CMAJzpWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GJWbtYzwrplGyZ/tWSMYVWjKX8kveXj+mpCOoYQy5hS7MJjuVlW9gpDxP1vUykBf+
	 XizyoEs+ii9/bVKhkIZqSYuMdkFVh6kLdZTv719NEWq8e3/8ZXpfOSKza0vqQhBTKd
	 bECApajAghu0xMYcdWUlY+J3VKwHHtAqKfr+oEocmTJ57tZabbmpi9Ecpqp9BpGDmw
	 6hbNl5Lk944SnsXIxmlhuq4AaNYZ1Zwmo8gQZwO5VjuxbQC7ELnu/T9932QKTpjodV
	 /PL6NE8oVOG/kpySDoUsXT1iysV615RFP4DKoD+TExq9yisyYTjjv9Cv8fhf1Z61iM
	 R0wuwuR59M6uA==
Date: Sat, 18 Jan 2025 14:34:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 1/2] PCI: endpoint: pci-epf-test: Add support for
 capabilities
Message-ID: <20250118203421.GA790917@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203063851.695733-5-cassel@kernel.org>

On Tue, Dec 03, 2024 at 07:38:53AM +0100, Niklas Cassel wrote:
> The test BAR is on the EP side is allocated using pci_epf_alloc_space(),
> which allocates the backing memory using dma_alloc_coherent(), which will
> return zeroed memory regardless of __GFP_ZERO was set or not.

> +static void pci_epf_test_set_capabilities(struct pci_epf *epf)
> +{
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> +	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	struct pci_epc *epc = epf->epc;
> +	u32 caps = 0;
> +
> +	if (epc->ops->align_addr)
> +		caps |= CAP_UNALIGNED_ACCESS;
> +
> +	reg->caps = cpu_to_le32(caps);

"make C=2 drivers/pci/" complains about this:

  drivers/pci/endpoint/functions/pci-epf-test.c:756:19: warning: incorrect type in assignment (different base types)
  drivers/pci/endpoint/functions/pci-epf-test.c:756:19:    expected unsigned int [usertype] caps
  drivers/pci/endpoint/functions/pci-epf-test.c:756:19:    got restricted __le32 [usertype]

