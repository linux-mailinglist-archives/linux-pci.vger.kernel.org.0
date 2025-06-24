Return-Path: <linux-pci+bounces-30560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AA9AE7202
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 00:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2CE17D6DE
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 22:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800AC2550A4;
	Tue, 24 Jun 2025 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzwY3hrJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540C5248880;
	Tue, 24 Jun 2025 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802463; cv=none; b=rFmLLShxuPkVS/Xx4hDtTowtXkgDaNw5TI7l5FUeTrTmMKu9CE6QNpcX+UZUXcRXtGlxzQavbIxZIjwAXfp7w04mGbFKb0dhiISkkJw79GTpnMWc3/66/VCm/kIabgJOTvFNT3AEWiIcSzNg7xNL+g6m55sDIo0h4MarLYTAaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802463; c=relaxed/simple;
	bh=oMqP58jBtpzhindTCdhlaRR+YnhL9McdIKzis2Sd23c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l9xVfj8KlM8me7y5cLJTi6KkdbDX2aE6IrrIkAYHaVqtpCOYPc41p7pvviSlDo0uuGdC4KGGATfkGoqt2RFVg2tEeRqJE+68IXS39BDBejuov4fMnoOuS+nTEgaNYDWsnaqUUVsrTCtm0RoVriRP7Riqt6rpyyylIrgY/MwcTqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzwY3hrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55A9C4CEE3;
	Tue, 24 Jun 2025 22:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750802462;
	bh=oMqP58jBtpzhindTCdhlaRR+YnhL9McdIKzis2Sd23c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TzwY3hrJPk/8OWo+Z8/JCb/1jDkOJ6zOkhc4v9XufSwZJXJ+mru7NigLoLTQCZ9ol
	 Q8fbHYMyoFNK0ERXV+UYR/HjxPwGIhP7Q/9vsNy54QqCwxSHlfOqehw6UJRbGH3K5q
	 TV0xMxCQqLZf+6YMELdPSY1GYXwXqJjHBjxq5V20kqr0MYxoPA1cvlNC/6J8ZAc72K
	 QBYaYdJmonZJ0zTXZKv+Xk/DbC7U7sVMBqSKqxQCXDGMqmLc3enONWkYAMIKgZARAJ
	 I3g6WQ9hvVLxhLubYe2rTPHHZm5iyblrlQEBuUMDkSdBStTj7XNFlAf9RYLEZVUNEZ
	 TF+yL44fTk0xw==
Date: Tue, 24 Jun 2025 17:01:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: brcmstb: Use "num-lanes" DT property if present
Message-ID: <20250624220101.GA1532842@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530224035.41886-3-james.quinlan@broadcom.com>

On Fri, May 30, 2025 at 06:40:33PM -0400, Jim Quinlan wrote:
> By default, we use automatic HW negotiation to ascertain the number of
> lanes of the PCIe connection.  If the "num-lanes" DT property is present,
> assume that the chip's built-in capability information is incorrect or
> undesired, and use the specified value instead.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index e19628e13898..79fc6d00b7bc 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -46,6 +46,7 @@
>  #define  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK	0xffffff
>  
>  #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
> +#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK	0x1f0
>  #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
>  
>  #define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
   #define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK      0xf8

If you squint, PCIE_RC_CFG_PRIV1_LINK_CAPABILITY looks a little like
these standard PCIe things:

  #define PCI_EXP_LNKCAP          0x0c    /* Link Capabilities */
  #define  PCI_EXP_LNKCAP_MLW     0x000003f0 /* Maximum Link Width */
  #define  PCI_EXP_LNKCAP_ASPMS   0x00000c00 /* ASPM Support */

  #define PCI_EXP_DEVCTL2         0x28    /* Device Control 2 */

So I was hoping we had an opportunity to use PCI_EXP_LNKCAP_MLW and
PCI_EXP_LNKCAP_ASPMS instead of
PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK and
PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK.

But I guess PCIE_RC_CFG_PRIV1_LINK_CAPABILITY is probably not actually
PCI_EXP_LNKCAP, because PCI_EXP_LNKCAP being 0x0c into a PCIe
Capability would mean the cap started at 0x04d0, and
PCIE_RC_CFG_PRIV1_ROOT_CAP would be at offset 0x28
(0x04d0 + 0x28 == 0x04f8).

But offset 0x28 in a PCIe Capability would be PCI_EXP_DEVCTL2, not 
PCIE_RC_CFG_PRIV1_ROOT_CAP, and I can't squint hard enough to see
anything related to L1SS anywhere in the PCIe Capability.

So never mind ;)

Bjorn

