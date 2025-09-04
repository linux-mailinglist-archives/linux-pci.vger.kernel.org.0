Return-Path: <linux-pci+bounces-35456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08644B44047
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 17:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4430D7BA2F0
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 15:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5940E1F3B89;
	Thu,  4 Sep 2025 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="YV5aWqfu"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A5C27442
	for <linux-pci@vger.kernel.org>; Thu,  4 Sep 2025 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998928; cv=none; b=Uln0pRBwr4q03m7tBqEFxY0d0TlaGmJizBBG8qHwSX9eMq6QXCfaJ1Kv+JJylXjP9utUEGnkdMw1KdA226g1PIZF5j83ud6KkLLTC5G9XrOrWqhn1JDZWDrAkB6zHmDaO0nT5zCzPcQ2LCNVxH7hfJhaK2e0zGKuW8YNxeVqfxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998928; c=relaxed/simple;
	bh=qYO1H34HCpj7HqtgcU6JjwfaeO/vE4IXiWXa5fNBJs4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=IYmJHA9R+P7Ks2AibDYYlpwWzqnAQHGjEQ3gd9GF33rcLA00bX0Iq+Jj+KtW9mt+YbQQV/VxpYoIxuMZP+KHmanhWrv3Ew67kRIZuoo/MhGkkVJdShhal01XzgYAatCRf5mNQvOMLxKfV2F4CYRfcKX6axjZAPCd9jWaU+j4M3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=YV5aWqfu; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=IKQDDvSx5KiQkDtirP4I1vd8wNU+lSEM/0uM6rLE0sA=; b=YV5aWqfuqp4bQXhSokJfg9J0DE
	w42OkyDIWIkdYkJbjw0uEfm801xiE4WtRQCqb+XcB9dMoE3cu/A80rezbEbkmPWnZmWCeYO3PJhfA
	yRGgJr0kngpXhYskmMLzGxMcBivC9lR+FkK83It/h/czV4qm/by7LQvHfcEsECTYFa9ddnMgrnbC5
	VqvtaqkoNFjouDBRaUjDLLReIDj4xmNKFhgVImbKJ8s31nAPkvL5KqSAUBVfqpZuQbVnx9+zSb9Tk
	F3uXX9rln8/QLiK80oyPGPWAD/01n1ACqyM4Lo0VBQS/fV/nSC1v+1+gcT3r/iQd1Pci70Rp8yXUg
	i5NqrT/Q==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1uuBgI-00DIjH-1Z;
	Thu, 04 Sep 2025 09:15:23 -0600
Message-ID: <f0479622-6f3e-4e86-95e6-61244053a8b3@deltatee.com>
Date: Thu, 4 Sep 2025 09:15:20 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20250903223403.1261824-1-vivek.kasireddy@intel.com>
 <20250903223403.1261824-2-vivek.kasireddy@intel.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20250903223403.1261824-2-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: vivek.kasireddy@intel.com, dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, bhelgaas@google.com, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v3 1/5] PCI/P2PDMA: Don't enforce ACS check for device
 functions of Intel GPUs
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-09-03 16:30, Vivek Kasireddy wrote:
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index da5657a02007..9484991c4765 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -544,6 +544,18 @@ static unsigned long map_types_idx(struct pci_dev *client)
>  	return (pci_domain_nr(client->bus) << 16) | pci_dev_id(client);
>  }
>  
> +static bool pci_devfns_support_p2pdma(struct pci_dev *provider,
> +				      struct pci_dev *client)
> +{
> +	if (provider->vendor == PCI_VENDOR_ID_INTEL) {
> +		if ((pci_is_vga(provider) && pci_is_vga(client)) ||
> +		    (pci_is_display(provider) && pci_is_display(client)))
> +			return pci_physfn(provider) == pci_physfn(client);
> +	}

Do we not also need to check that the client has a vendor of
PCI_VENDOR_ID_INTEL?

> @@ -705,7 +717,9 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
>  		return -1;
>  
>  	for (i = 0; i < num_clients; i++) {
> -		pci_client = find_parent_pci_dev(clients[i]);
> +		pci_client = dev_is_pf(clients[i]) ?
> +				pci_dev_get(to_pci_dev(clients[i])) :
> +				find_parent_pci_dev(clients[i]);

I don't understand this hunk. Why would this need special handling if
dev_is_pf()?. find_parent_pci_dev() looks like it will do the same thing
just look at the parents if it is not a PCI devices.

Logan

