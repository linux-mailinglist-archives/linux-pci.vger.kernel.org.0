Return-Path: <linux-pci+bounces-7142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACDA8BDC87
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 09:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1B3282172
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE9B13B798;
	Tue,  7 May 2024 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9gF+7FZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B3A59;
	Tue,  7 May 2024 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715067575; cv=none; b=b02KVfIbHs80DEWx0iGuZoVFV9LPsvtd3S1soAOaI53e6X7VYYb4Rd8wLVmgKr9J2ozR0dC/i4EbCj4gvXBqRZemjHQpumFpbDk0As8i/VdB9jGn8xHc3QQGpAvbcOW/K6is1wU7l5UdB5Nxz8SQX/Ts/nKa/rP7aNI/y2R8Zns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715067575; c=relaxed/simple;
	bh=rJpFn1AO9QkoOchyzDCE9TfU4pQm9RHy9KJ9ICU1PyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1EsRuKe4uhCEikRUaPWhztRojkrB7Z+GmIYLVPy/9hKsbuIgZVWN7EINiKkkjn375uOOklZW6OXiQQU8YKLY3nNGZJM6UtwxOY6cOw4KN6ZHNc1ANqAhcJtjPFACc0SZ5TWPbXofUylUbvxPonjL0grn4BKIC1ZPU19UvJ7HVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9gF+7FZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609DCC2BBFC;
	Tue,  7 May 2024 07:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715067575;
	bh=rJpFn1AO9QkoOchyzDCE9TfU4pQm9RHy9KJ9ICU1PyM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L9gF+7FZ6nHYPWp4shMqyCWwss9CfOmgX3yR+TzEemeEu6/MM9FfL5tmUoHUnJxC/
	 Ee0P8hN8UE31H1Lezd8mAQ/SOUYZfehRwVYz0o9KQthH2+fnknhPPlNdflrL1mruLJ
	 nPQTRja9UDNtTkqRDZH4yhbiJu9444DCGyxQFI/99Cuje6MKfp9Q3+9VuTAn+qIucx
	 6EPNF8uPXyEHP2vkM6Z6gfq7RcFbeES9fuwpjlpR/zdX0uS0HMV9vmRc0lPYOb63vU
	 P3oyxFFRNCb1sJvxbK/7Q9GJgE/cPxrWjBqzhBL2qSDgfGTUchkmFvdcE/O/uKkJVw
	 9G9UXN9PNqeLQ==
Message-ID: <41e54b6e-7848-415f-b913-d481509d5e8a@kernel.org>
Date: Tue, 7 May 2024 16:39:32 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: rockchip-ep: Remove wrong mask on subsys_vendor_id
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>, rick.wertenbroek@heig-vd.ch
Cc: stable@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240403144508.489835-1-rick.wertenbroek@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240403144508.489835-1-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 23:45, Rick Wertenbroek wrote:
> Remove wrong mask on subsys_vendor_id. Both the Vendor ID and Subsystem
> Vendor ID are u16 variables and are written to a u32 register of the
> controller. The Subsystem Vendor ID was always 0 because the u16 value
> was masked incorrectly with GENMASK(31,16) resulting in all lower 16
> bits being set to 0 prior to the shift.
> 
> Remove both masks as they are unnecessary and set the register correctly
> i.e., the lower 16-bits are the Vendor ID and the upper 16-bits are the
> Subsystem Vendor ID.
> 
> This is documented in the RK3399 TRM section 17.6.7.1.17
> 
> Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index c9046e97a1d2..37d4bcb8bd5b 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -98,10 +98,9 @@ static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
>  
>  	/* All functions share the same vendor ID with function 0 */
>  	if (fn == 0) {
> -		u32 vid_regs = (hdr->vendorid & GENMASK(15, 0)) |
> -			       (hdr->subsys_vendor_id & GENMASK(31, 16)) << 16;
> -
> -		rockchip_pcie_write(rockchip, vid_regs,
> +		rockchip_pcie_write(rockchip,
> +				    hdr->vendorid |
> +				    hdr->subsys_vendor_id << 16,
>  				    PCIE_CORE_CONFIG_VENDOR);
>  	}
>  

-- 
Damien Le Moal
Western Digital Research


