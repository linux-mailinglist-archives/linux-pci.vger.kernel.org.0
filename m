Return-Path: <linux-pci+bounces-35410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE769B42CCF
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 00:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A0E1BC4768
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 22:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9CF29827E;
	Wed,  3 Sep 2025 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nrz9NKhM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101233E7;
	Wed,  3 Sep 2025 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756938724; cv=none; b=UDyfNczqSbJrTRVzYTOpH4BbodQR88wNMPw0e4e92dnJmJ89v9jnOA27qW3P00Gm+iaSdxEXm5TGYSlhza7ckkLissvlTj6H1B0ah/IoQR03oyr4EY85IHCCi5BsDHpEagsFJHwwoOYkzER8UEaZKk+cQLR0jpPQrDmQc7y2fBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756938724; c=relaxed/simple;
	bh=0zNxbRiK/0aMy5wdBnW9WCgQpg46kf3uIF2gp8dwHmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tnFqHtAO2+j9/TbqYQK4UBV1UI7yZMEFghRCtik2vaztzjB9xbh1+W2Nk/HpHa37zpwAv/mkfCVERuhnzUkDXzEoT5wg0eOaHjRUpE5x2vuH5PCbXCMUo6b9gAZMwPmrdWrK0TqvLg84PCRD/yLDDBOGv8Ii5lGDuj0heKQcp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nrz9NKhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB75C4CEE7;
	Wed,  3 Sep 2025 22:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756938724;
	bh=0zNxbRiK/0aMy5wdBnW9WCgQpg46kf3uIF2gp8dwHmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Nrz9NKhMC5qUarkd7J+XDkSpZDWKsfS09dlIk7Cm6jJKudqb+qGchlrAH1B3u2qBH
	 NxOy+gtbBuB6w0bqYYfEWi6QfniE4omkp5oXpUbC7VLbCjyLivl1eW2YWrxQSCgOQn
	 VgGPsYF3+fxTUZ6f1T5fgq3F9L1J6DD5DIIzMXE1D8K+S5CpeYQAtX21OXz4pK8HK3
	 ucbSC3pRXndnyQYZVRe5JXO5apjS3rw8iMp5mtKLM4kbwKatUSPZcMYOaY0aSJMEtt
	 hOUFxBzIzmltmb5JpiQmUMLEbEuVkvToIWP1FFS3F4jtQfq9Hm+T16ydICw5SgYNLz
	 oybtOg+x53FlA==
Date: Wed, 3 Sep 2025 17:32:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, vkoul@kernel.org,
	kishon@kernel.org, linus.walleij@linaro.org, p.zabel@pengutronix.de,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 08/10] PCI: Add FMT and TYPE definition for TLP header
Message-ID: <20250903223202.GA1235935@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901055922.1553550-9-jacky_chou@aspeedtech.com>

On Mon, Sep 01, 2025 at 01:59:20PM +0800, Jacky Chou wrote:
> According to PCIe specification, add FMT and TYPE definition
> for TLP header.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/pci/pci.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 34f65d69662e..45d47d6c4f53 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -81,6 +81,18 @@ struct pcie_tlp_log;
>  #define PCIE_MSG_CODE_DEASSERT_INTC	0x26
>  #define PCIE_MSG_CODE_DEASSERT_INTD	0x27
>  
> +/* Format of TLP; PCIe r5.0, sec 2.2.1 */

Please update to PCIe r7.0.

> +#define PCIE_TLP_FMT_3DW_NO_DATA	0x00 /* 3DW header, no data */
> +#define PCIE_TLP_FMT_4DW_NO_DATA	0x01 /* 4DW header, no data */
> +#define PCIE_TLP_FMT_3DW_DATA		0x02 /* 3DW header, with data */
> +#define PCIE_TLP_FMT_4DW_DATA		0x03 /* 4DW header, with data */
> +
> +/* Type of TLP; PCIe r5.0, sec 2.2.1 */
> +#define PCIE_TLP_TYPE_CFG0_RD		0x04 /* Config Type 0 Read Request */
> +#define PCIE_TLP_TYPE_CFG0_WR		0x04 /* Config Type 0 Write Request */
> +#define PCIE_TLP_TYPE_CFG1_RD		0x05 /* Config Type 1 Read Request */
> +#define PCIE_TLP_TYPE_CFG1_WR		0x05 /* Config Type 1 Write Request */
> +
>  extern const unsigned char pcie_link_speed[];
>  extern bool pci_early_dump;
>  
> -- 
> 2.43.0
> 

