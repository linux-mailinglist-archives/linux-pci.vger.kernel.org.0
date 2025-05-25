Return-Path: <linux-pci+bounces-28384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6994AC32B7
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 09:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68038177710
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 07:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1DC1CCEC8;
	Sun, 25 May 2025 07:26:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB6C2F5E;
	Sun, 25 May 2025 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748157981; cv=none; b=VVB0BY7Yf/7Guyg8JaQChGtW7dx+ntUEj13keOP0WsdMkxySLLjJAw3k4F71E6rdNZwTyuE4OUonksZWIjlXUgC2GMnFwot6ra1ZFTeMl7q+BXvHuA2T26EZXy88cvu53FEfO6OJVdJSnvvnO5vGJa7Mk/oKjxSduHyYDqehBPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748157981; c=relaxed/simple;
	bh=A7c3C86HSRycHnJNwy3scJDbgoCIJ5mbBh5V35009Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fn9bR3RApq66RfJN0L1v6vXa9c6sCr3LwUIpVKIeMgN6T0TKLxy+RZzurcHTOYWF9cRu5yYdSr/76bRoybxI7ELusP0xxZr8vpwpge3naXWKTXTGyTImtUup0HNAqMDRNqo0p+hy0bC17gWkPbzroJTEbhpgPbiRLmAFY33Cn/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1BB222009199;
	Sun, 25 May 2025 09:26:16 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0557E184F9F; Sun, 25 May 2025 09:26:16 +0200 (CEST)
Date: Sun, 25 May 2025 09:26:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, cassel@kernel.org,
	wilfred.mallawa@wdc.com
Subject: Re: [PATCH 2/2] PCI: Rename host_bridge::reset_slot() to
 host_bridge::reset_root_port()
Message-ID: <aDLGF8znWih9308o@wunner.de>
References: <20250524185304.26698-1-manivannan.sadhasivam@linaro.org>
 <20250524185304.26698-3-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250524185304.26698-3-manivannan.sadhasivam@linaro.org>

Eight more occurrences where "Root Port" should be capitalized:

On Sun, May 25, 2025 at 12:23:04AM +0530, Manivannan Sadhasivam wrote:
> @@ -759,7 +759,7 @@ static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
>  
>  	/* Ignore errors, the link may come up later. */
>  	dw_pcie_wait_for_link(pci);
> -	dev_dbg(dev, "slot reset completed\n");
> +	dev_dbg(dev, "Root port reset completed\n");
>  	return ret;
>  
>  deinit_clk:

> @@ -1589,7 +1589,7 @@ static int qcom_pcie_reset_slot(struct pci_host_bridge *bridge,
>  
>  	qcom_pcie_start_link(pci);
>  
> -	dev_dbg(dev, "Slot reset completed\n");
> +	dev_dbg(dev, "Root port reset completed\n");
>  
>  	return 0;
>  

> @@ -99,22 +99,22 @@ void pci_host_common_remove(struct platform_device *pdev)
>  	ret = pci_bus_error_reset(dev);
>  	if (ret) {
> -		pci_err(dev, "Failed to reset slot: %d\n", ret);
> +		pci_err(dev, "Failed to reset root port: %d\n", ret);
>  		return PCI_ERS_RESULT_DISCONNECT;
>  	}
>  
> -	pci_info(dev, "Slot has been reset\n");
> +	pci_info(dev, "Root port has been reset\n");
>  
>  	return PCI_ERS_RESULT_RECOVERED;
>  }

> @@ -140,17 +140,17 @@ static void pci_host_recover_slots(struct pci_host_bridge *host)
>  
>  		ret = pci_bus_error_reset(dev);
>  		if (ret)
> -			pci_err(dev, "Failed to reset slot: %d\n", ret);
> +			pci_err(dev, "Failed to reset root port: %d\n", ret);
>  		else
> -			pci_info(dev, "Slot has been reset\n");
> +			pci_info(dev, "Root port has been reset\n");
>  	}
>  }
>  #endif
>  
>  void pci_host_handle_link_down(struct pci_host_bridge *bridge)
>  {
> -	dev_info(&bridge->dev, "Recovering slots due to Link Down\n");
> -	pci_host_recover_slots(bridge);
> +	dev_info(&bridge->dev, "Recovering root ports due to Link Down\n");
> +	pci_host_reset_root_ports(bridge);
>  }
>  EXPORT_SYMBOL_GPL(pci_host_handle_link_down);
>  
> @@ -4985,16 +4985,16 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
> +		ret = host->reset_root_port(host, dev);
>  		if (ret)
> -			pci_err(dev, "failed to reset slot: %d\n", ret);
> +			pci_err(dev, "failed to reset root port: %d\n", ret);
>  		else
>  			/* Now restore it on success */
>  			pci_restore_state(dev);

