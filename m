Return-Path: <linux-pci+bounces-1606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5689C8220CF
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 19:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D9D283B9D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4778154B6;
	Tue,  2 Jan 2024 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgTqxqKu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42BE156CB;
	Tue,  2 Jan 2024 18:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCDAC433C8;
	Tue,  2 Jan 2024 18:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704219257;
	bh=8DwCqHqW6C3w7MqerTe/WE6rP9haUcotBb/k6Jw1nYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sgTqxqKuYX7Sh4UtRU+MMle3rriKJGsRKHgQ8RlyavtI8uFhvUiN+TxQgml+wJvPY
	 m6X5eU8bW4yAojCY6JG16YvfBKK7eLiwojjJhvaeK8j26FyQ79B7EBIumpSkgA8s3P
	 69rJaJVsSgA73b9CePQ3YmQvNbFqNRKNXOe8sDVn2dXErgpb9X10vDZyslYouIn9/l
	 l6NAY5ti1ApxXLFAE56CJTLAr6mGheDCD8U6vvKa408fVJ3ejT8y7eVrXLdTocq2Gu
	 lCYZBlm5oNvLB3Azb1gxn98aGXDsnqv+7KuZkoBhFj4HwAlV1I20zjrYJSJr8AVFJx
	 EaEjZvDLzVrLQ==
Date: Tue, 2 Jan 2024 12:14:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: 64GT/s uses 1b/1b encoding
Message-ID: <20240102181415.GA1732470@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240102172701.65501-1-ilpo.jarvinen@linux.intel.com>

On Tue, Jan 02, 2024 at 07:27:00PM +0200, Ilpo Järvinen wrote:
> PCIe 64GT/s Data Rate uses 1b/1b encoding, not 128b/130b (PCIe r6.1 sec
> 1.2, Table 1-1).
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/enumeration for v6.8, thanks!

> ---
>  drivers/pci/pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5ecbcf041179..d9132029d658 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -272,7 +272,7 @@ void pci_bus_put(struct pci_bus *bus);
>  
>  /* PCIe speed to Mb/s reduced by encoding overhead */
>  #define PCIE_SPEED2MBS_ENC(speed) \
> -	((speed) == PCIE_SPEED_64_0GT ? 64000*128/130 : \
> +	((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
>  	 (speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
>  	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
>  	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
> -- 
> 2.39.2
> 

