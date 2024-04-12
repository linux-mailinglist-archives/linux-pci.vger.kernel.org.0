Return-Path: <linux-pci+bounces-6182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB68A2F3D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 15:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCA6282B85
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 13:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB48F82892;
	Fri, 12 Apr 2024 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMStQqxS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88082883;
	Fri, 12 Apr 2024 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927963; cv=none; b=VBxFq2enrn0fdRHKSNFBGXeXjSX6PREf5ws2D2QTgG/r+kBYgxNSdDwJTXehpmVLghWIA8oAwXJ8VbNPwR5jmyqJfXZnXOryTHFqw62aLwdflAStCfd6gvvDKcifuxi6lA0iPCXqidqVKQp4gTzNnUR5FjOvhyWms1Sulz8FeqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927963; c=relaxed/simple;
	bh=v7yDfXdGtUw89/5GbhmOHtChgqA0aA+RkQQTkojn9CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNOwdJ8H4TA8smKzHO2bQoSx7OypGC+twcwHp/2wofGfubvgElvfwwiz4/k9vuDU0SIkukTIHCUqxDxuZB+v3l4WhtQmln12nOAkmMWi3BA7eEUCk7lCaUbZQOtQ1nR3C4uAijQ7cSuiauawFB9Jn7CAPDXAoPzP6Ssy2ZlNDAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMStQqxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BF0C3277B;
	Fri, 12 Apr 2024 13:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712927963;
	bh=v7yDfXdGtUw89/5GbhmOHtChgqA0aA+RkQQTkojn9CI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMStQqxSco8CFI5JI1wHWcnj+jsuZIdu1UBt62gcX8aFu0wcJU5o59tJGNgjZpR80
	 nwNRy8/gfrJMpa3tqKkznNm3s09i7jegekk2DradJ9tK+/hDXdvvmiuWBEePDW5emE
	 a8CXYn4XcmX1eo9Q3R15cuv/+u5zuUaBX8DRPSU0kXAaSIVPJnMJreYMHg7IMaY8Tz
	 hW+5Gi3PIhkL4oFRmN++lfAq3SIXYItPaRaWw+jf9pBF4oH8XgwYsrw2YiHtloggn7
	 LaR9Vbikf2m9Mg+qpBtjlOwYpck+GjHNJ6P17qn5woOyoQZNPp4tEoqVJ/ygj7N7DS
	 6te7oLKfAMIAA==
Date: Fri, 12 Apr 2024 15:19:18 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Documentation: PCI: pci-endpoint: Fix EPF ops list
Message-ID: <Zhk01vZODbh0bRBH@ryzen>
References: <20240412095031.256163-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412095031.256163-1-alexander.stein@ew.tq-group.com>

On Fri, Apr 12, 2024 at 11:50:31AM +0200, Alexander Stein wrote:
> With commit 5779dd0a7dbd7 ("PCI: endpoint: Use notification chain
> mechanism to notify EPC events to EPF") the linkup callback has been
> removed and replaced by EPC event notifications.
> 
> With commit 256ae475201b1 ("PCI: endpoint: Add pci_epf_ops to expose
> function-specific attrs") a new (optional) add_cfs callback was added.
> Update documentation accordingly.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Changes in v2:
> * Separated paragraphs by blank line
> 
>  Documentation/PCI/endpoint/pci-endpoint.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
> index 4f5622a65555..3961ff4e5beb 100644
> --- a/Documentation/PCI/endpoint/pci-endpoint.rst
> +++ b/Documentation/PCI/endpoint/pci-endpoint.rst
> @@ -172,8 +172,7 @@ by the PCI endpoint function driver.
>  	 * bind: ops to perform when a EPC device has been bound to EPF device
>  	 * unbind: ops to perform when a binding has been lost between a EPC
>  	   device and EPF device
> -	 * linkup: ops to perform when the EPC device has established a
> -	   connection with a host system
> +	 * add_cfs: optional ops to create function specific config attributes

I think it is much clearer if you:
s/config/configfs/
here.

With that:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

