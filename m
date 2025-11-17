Return-Path: <linux-pci+bounces-41437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62148C65949
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 18:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B4363860EC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 17:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4C7301015;
	Mon, 17 Nov 2025 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGeQ9Bjj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29D52FD68D;
	Mon, 17 Nov 2025 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400544; cv=none; b=Nk5N9pKLm75JNFaOgWby1N8vfK4sNW6L7hsRpZa7CKA8PCM0cQ0Efusc7TJAh4d/27KE13SP7FH2ogSK8oopJWkZofyyUgWJ0pj/bVW3FTA0uNg7HLKisTbAdEr0WlRx9D0QEuuwy84tYgWC1PHXRaZjuo/pjgPvi4Jgx64QKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400544; c=relaxed/simple;
	bh=JlsE1lph8w0DMhM6j2h7RraWGmZuAIqFU+0dI5wpwmM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a65RBTFmdDP7oBdWNzqCW73ljuxYnmR6YLu5FkqQRVFPrTMlBa8ba/5i6WoyNmM/hgnZCUFRsGrL6yNDzbeUlml0f5pwt8MlaIbEfuzi4JVoG5hpxaITW+urw1izPC9TpV6gEYcuOgFQ8pYEllTjl+duVEbj6PacyIPr35AU+60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGeQ9Bjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF57FC4AF0D;
	Mon, 17 Nov 2025 17:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763400542;
	bh=JlsE1lph8w0DMhM6j2h7RraWGmZuAIqFU+0dI5wpwmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NGeQ9BjjDPbIlXZTF48buPSkHU3BW+jHvClesoPVMotHRkTEX5YtTu2a4msnQHZBn
	 U7+pR30mHcb3+UrpiDas9215oPGJDwBDcwbWPL9rayhMjRgkLfRovzamI0WxDZAmWR
	 ERy4qFZxO16ofbIotyielscmaIVagOGGr4gXZK9qOnwFjcl7pRvEoghMoB5ZRxqzEo
	 KaMY5tymug/UgzZtrTnzZfJuxHOUJaI+h75Vv5r7TOD6KKsgJKWNXgGbVWhS92/2sz
	 hEyDaM3YBYj6yZytFqOpmNVPPvtFzBthWMlEjsQCppWZ9fafXclCiQTZfztFwdfa9s
	 bv8t2f5tJFjGA==
Date: Mon, 17 Nov 2025 11:28:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 6/8] PCI: Add FMT, TYPE and CPL status definition for
 TLP header
Message-ID: <20251117172859.GA2466937@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117-upstream_pcie_rc-v5-6-b4a198576acf@aspeedtech.com>

On Mon, Nov 17, 2025 at 08:37:53PM +0800, Jacky Chou wrote:
> According to PCIe specification, add FMT, TYPE and CPL status
> definition for TLP header.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

OK by me, but it'd be nice to move up a few lines so this is with the
other TLP-related items and the unrelated PCI_BUS_BRIDGE_*_WINDOW
values aren't in the middle.

Might even consider moving these to be just above the Message Routing
constants so things are generally in the order they appear in the
spec.

> ---
>  drivers/pci/pci.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 36f8c0985430..3a075f77cf4a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -88,6 +88,21 @@ struct pcie_tlp_log;
>  #define PCI_BUS_BRIDGE_MEM_WINDOW	1
>  #define PCI_BUS_BRIDGE_PREF_MEM_WINDOW	2
>  
> +/* Format of TLP; PCIe r7.0, sec 2.2.1 */
> +#define PCIE_TLP_FMT_3DW_NO_DATA	0x00 /* 3DW header, no data */
> +#define PCIE_TLP_FMT_4DW_NO_DATA	0x01 /* 4DW header, no data */
> +#define PCIE_TLP_FMT_3DW_DATA		0x02 /* 3DW header, with data */
> +#define PCIE_TLP_FMT_4DW_DATA		0x03 /* 4DW header, with data */
> +
> +/* Type of TLP; PCIe r7.0, sec 2.2.1 */
> +#define PCIE_TLP_TYPE_CFG0_RD		0x04 /* Config Type 0 Read Request */
> +#define PCIE_TLP_TYPE_CFG0_WR		0x04 /* Config Type 0 Write Request */
> +#define PCIE_TLP_TYPE_CFG1_RD		0x05 /* Config Type 1 Read Request */
> +#define PCIE_TLP_TYPE_CFG1_WR		0x05 /* Config Type 1 Write Request */
> +
> +/* Cpl. status of Complete; PCIe r7.0, sec 2.2.9.1 */
> +#define PCIE_CPL_STS_SUCCESS		0x00 /* Successful Completion */
> +
>  extern const unsigned char pcie_link_speed[];
>  extern bool pci_early_dump;
>  
> 
> -- 
> 2.34.1
> 

