Return-Path: <linux-pci+bounces-40870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB09C4D1B5
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 11:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6684A0E46
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 10:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA093491F4;
	Tue, 11 Nov 2025 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGSNjMHn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86BA2E7657;
	Tue, 11 Nov 2025 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857084; cv=none; b=g2WrpC4iquWLEdEuSnccc7VLy2TNj+KiStquDAg2wpx6cLiWPOU6u6Plpzjat8PdPY3o4gHk/4ElCpk1P75KrEvUJshf9izNe7LXuMmjNn+karHZ8rWLe12dHjMdvg4RnwZiwBPExOzNtIv+oZAgDKHZdJkr7OoJYAQ6TOj2Tow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857084; c=relaxed/simple;
	bh=FdyK3R1uLhhpiUX2s0AYxH+SP22xPH3MI8OB6sUsbBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRtDEXtgTWNN2gLBolWfBrUqIcbxv0QknAAqodPOgDSSNgoPTpXS99P7FG+49pb1nMRCQWfnmWD5a/Kfs9t0KIHrNNPAgRbZH5WETmvIZixnChyN2RANtXwk+UDWKaFw8/4w+7KfByozChmZ0os2oK8jL6s6cVXTCcuYvmN4Xqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGSNjMHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44441C116B1;
	Tue, 11 Nov 2025 10:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762857084;
	bh=FdyK3R1uLhhpiUX2s0AYxH+SP22xPH3MI8OB6sUsbBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGSNjMHnF5CNakjul7e/EDvBtjHyB0f0exywKP1Tf5GQImEUstZwVRF3s+3lhr5tS
	 0AjcrVGPLnHhE9XyMNalT2rYu5md+RV0WWcDANcig4V4Il9YE5U03vXdH+6Z/JVOET
	 Uu0cTamzKZSRw7YwO3yMvl6lHgPgrjHtxWDrcmPC3HPSD1Ki1zYDMAX7wKqmiD5/XH
	 fS3Gf2tDExV2wBYY1tLQPGXwrNaVH/jsOKXYN58AHzZvOrjEoZWfRbx97HHMfhVf2D
	 aXeM2tjjrdyWt8oA+UQeNsUQI/NYmgxkLS3oMIhD7hPgadPdxBQ1o12feJh741pCO5
	 NKJCfMkH+da8Q==
Date: Tue, 11 Nov 2025 16:01:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, elder@riscstar.com
Subject: Re: [PATCH] PCI: dwc: Warn if the MSI ctrl doesn't have an
 associated platform IRQ in DT
Message-ID: <ylnaj2rxbuybocfc4dij7jjrumygens5dzr435dpbltjwzkygx@vjeakaqms3lw>
References: <20251030171346.5129-1-manivannan.sadhasivam@oss.qualcomm.com>
 <176259710138.9726.16225246756188234387.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <176259710138.9726.16225246756188234387.b4-ty@kernel.org>

On Sat, Nov 08, 2025 at 03:48:21PM +0530, Manivannan Sadhasivam wrote:
> 
> On Thu, 30 Oct 2025 22:43:46 +0530, Manivannan Sadhasivam wrote:
> > The internal MSI controller in DWC IPs supports multiple MSI ctrls, each
> > capable of receiving 32 MSI vectors per ctrl. And each MSI ctrl requires a
> > dedicated MSI platform IRQ in devicetree to function. Otherwise, MSIs won't
> > be received from the endpoints.
> > 
> > Currently, dw_pcie_msi_host_init() only registers the IRQ handler if the
> > MSI ctrl has the associated MSI platform IRQ in DT. But it doesn't warn if
> > the IRQ is not available. This may cause developers/users to believe that
> > the platform supports MSI vectors from all MSI ctrls, but it doesn't.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] PCI: dwc: Warn if the MSI ctrl doesn't have an associated platform IRQ in DT
>       commit: 571dd53fca80508de39cb2edc49a43be3ea5ae12
> 

Alex brought it to my attention offline that a vendor implementation may support
a single IRQ for all 256 MSIs. I checked the spec again and indeed they mention
the possibility in the Figure 3-24 of r4.30 of the DWC databook. It was not
mentioned in the wording anywhere, but the figure was explicit.

Hence, this patch is wrong. So I've dropped it now.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

