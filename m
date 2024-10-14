Return-Path: <linux-pci+bounces-14487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE5499D512
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 18:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3A31C2217F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 16:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534861C232D;
	Mon, 14 Oct 2024 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgiUybSY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241F28FC;
	Mon, 14 Oct 2024 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925075; cv=none; b=WIPNMuxytWDmEhJkB3iF9X+jlx/MkunaJdGqRbJSezKtCwgbYuE0bzYdDE7lLLtnvlLvsOJNpIkzoFkbJuWgiKjN9wtM4XkdCzYAc63lXwAfzz4RGsmYTpcm/crcZ7ZpZleh9z5Yd4DCrQD65WhA5DP3j88Fws7N/AiXRpKu4dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925075; c=relaxed/simple;
	bh=wXWzMdrUxolDFmjz40s5QfHgXPCyiA7KBOB9gExbNoo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YwlLSCdMaBWfPVcBDzb//4iKs0kK9DZwNk4AcwYxKP6vDSvgx7vmjI9XFjMYN1VgWYLECXPEUIJnSEPrel6v9ENSHGtSug7m/OFPrMxUITfKZWKet0swa/EcxtD/GluFZV/NgS7FVeT172jWJrMS3x1KEWa/NS/KBONXlrOkK20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgiUybSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C67EC4CEC3;
	Mon, 14 Oct 2024 16:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728925074;
	bh=wXWzMdrUxolDFmjz40s5QfHgXPCyiA7KBOB9gExbNoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GgiUybSYshbUNzejaSCnPLicOmznG3IXLZs0Ne0pYdd0FwUTMy5rnBRB7PvARVe7o
	 rgVV3XvNr15M+ceo4vir7M+oPOiSp4xszzdfBWjx3rHAW2eQts4smdBQDg3gxJscNB
	 rBvsube5oReuK32CkktFMqviLgNBavmqlYx7A0hrp7R4gC3SC/EunDoww1pBEnGS/q
	 UdiOS+236BW8VU4+kKTissW9IkdTxTFNihEBGNV+lhh7wOrDFsEby24zuexmXWbN/J
	 vu3uEBWPiZRON8OJlMqut4O8AWDxXj2rYe2orUSBQtHz81yPVo6LdnokYqDBH3DQJu
	 63NmYkBzN2d9w==
Date: Mon, 14 Oct 2024 11:57:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>
Subject: Re: [PATCH v3 04/11] PCI: brcmstb: Expand inbound size calculation
 helper
Message-ID: <20241014165752.GA611670@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014130710.413-5-svarbanov@suse.de>

On Mon, Oct 14, 2024 at 04:07:03PM +0300, Stanimir Varbanov wrote:
> BCM2712 memory map can supports up to 64GB of system
> memory, thus expand the inbound size calculation in
> helper function up to 64GB.

The fact that the calculation is done in a helper isn't important
here.  Can you make the subject line say something about supporting
DMA for up to 64GB of system memory?

This is being done specifically for BCM2712, but I assume it's safe
for *all* brcmstb devices, right?

s/can supports/can support/

Rewrap commit log to fill 75 columns.

> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> v2 -> v3:
>  - Added Reviewed-by tags.
>  - Improved patch description (Florian).
> 
>  drivers/pci/controller/pcie-brcmstb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 9321280f6edb..b0ef2f31914d 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -309,8 +309,8 @@ static int brcm_pcie_encode_ibar_size(u64 size)
>  	if (log2_in >= 12 && log2_in <= 15)
>  		/* Covers 4KB to 32KB (inclusive) */
>  		return (log2_in - 12) + 0x1c;
> -	else if (log2_in >= 16 && log2_in <= 35)
> -		/* Covers 64KB to 32GB, (inclusive) */
> +	else if (log2_in >= 16 && log2_in <= 36)
> +		/* Covers 64KB to 64GB, (inclusive) */
>  		return log2_in - 15;
>  	/* Something is awry so disable */
>  	return 0;
> -- 
> 2.43.0
> 

