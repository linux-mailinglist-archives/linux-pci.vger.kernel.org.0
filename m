Return-Path: <linux-pci+bounces-5011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE1288708E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 17:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2261F24189
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7861A5A4D5;
	Fri, 22 Mar 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzzeQePB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D056B7A;
	Fri, 22 Mar 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123849; cv=none; b=ahO/lHpaxWrDvcz5ht07U8Nbziy9+J02DBpYrDLs5is7jnYFGC/hq8zywbkotkC2HzPnHpzbOcHCADmJpY6W+udt1DVaAJ7KdceJKYZe7sRLq3D6qFWiCHMgphRfO70m4BIJ3hBpHnG06QxMDk7H290AbQYBtIP0VOQPI+cUxwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123849; c=relaxed/simple;
	bh=wnXnzIzMjqIeOSx2R+ckSe9WQAcO+DmN0P5bRnwI08Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAP2F7D65xSmGNzna5/5AhnQbHK3+OzQ67q7yGYpY6IsiFQsLW+16lWzDhOpGtrU1g8lDdU/d1kZKn5+XBIo8zed4I5CyqLw7BKK2fhZimeTEH+CQSIRN45CiBZ+7YFsTcXdIk4i/Lho2b8nzQOUYN0r1sxSts1YEZntWnmX1/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzzeQePB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6C5C43390;
	Fri, 22 Mar 2024 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711123849;
	bh=wnXnzIzMjqIeOSx2R+ckSe9WQAcO+DmN0P5bRnwI08Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NzzeQePBQ5WorR+piyK1EUN1fQPTi4wGf+hss+zKlVWLr+TCyYKrL286biy/wewVJ
	 XOBnIt3VVer6985KDVCRpEMy9onAVVqHPYW5HgBdGbRBnMjEF9KIcR8gs25IGqPOBa
	 YmTdj2kg7zmk8De/tNLoBsTbiE8Cuzw7jzMxxq3975TflkJCzzTvMpCJeXnhKTEy7R
	 t/AsNMUNBkS87/PQjCySHfJyWYaYR8RYMharpU1HthE6HH9sqWp0GRMurccC5GElF/
	 N+fFdo5xlTvul7wELAiOkd0xwZX37PzrDTkNM/8W02C9r5g7yPxKOmKYfY3tsFCgYX
	 9vRLcUMhYpFgg==
Date: Fri, 22 Mar 2024 17:10:43 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 09/11] PCI: epf-test: Handle Link Down event
Message-ID: <Zf2tg9I6ZBxp7asU@ryzen>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-9-6134e6c1d491@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pci-epf-rework-v1-9-6134e6c1d491@linaro.org>

On Thu, Mar 14, 2024 at 08:53:48PM +0530, Manivannan Sadhasivam wrote:
> As per the PCIe base spec r5.0, section 5.2, Link Down event can happen
> under any of the following circumstances:
> 
> 1. Fundamental/Hot reset
> 2. Link disable transmission by upstream component
> 3. Moving from L2/L3 to L0
> 
> When the event happens, the EPC driver capable of detecting it may pass the
> notification to the EPF driver through link_down() callback in 'struct
> pci_epc_bus_event_ops'.
> 
> While the PCIe spec has not defined the actual behavior of the endpoint
> when the Link Down event happens, we may assume that atleast the ongoing

Nit:
s/atleast/at least/

Reviewed-by: Niklas Cassel <cassel@kernel.org>

> transactions need to be stopped as the link won't be active. So let's
> cancel the command handler work in the callback implementation
> pci_epf_test_link_down(). The work will be started again in
> pci_epf_test_link_up() once the link comes back again.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 84cd47ebac22..97245228c9eb 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -823,6 +823,15 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
>  	return 0;
>  }
>  
> +static int pci_epf_test_link_down(struct pci_epf *epf)
> +{
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +
> +	cancel_delayed_work(&epf_test->cmd_handler);
> +
> +	return 0;
> +}
> +
>  static const struct pci_epc_event_ops pci_epf_test_epc_event_ops = {
>  	.init = pci_epf_test_epc_init,
>  	.deinit = pci_epf_test_epc_deinit,
> @@ -830,6 +839,7 @@ static const struct pci_epc_event_ops pci_epf_test_epc_event_ops = {
>  
>  static const struct pci_epc_bus_event_ops pci_epf_test_bus_event_ops = {
>  	.link_up = pci_epf_test_link_up,
> +	.link_down = pci_epf_test_link_down,
>  };
>  
>  static int pci_epf_test_alloc_space(struct pci_epf *epf)
> 
> -- 
> 2.25.1
> 

