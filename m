Return-Path: <linux-pci+bounces-16911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CC79CF329
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F29EB2F1AA
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1AE1D618A;
	Fri, 15 Nov 2024 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIvA9dWo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D3E1D5173;
	Fri, 15 Nov 2024 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691795; cv=none; b=cB1hzP/3suJawduf60L8H3SP+wFlNmDpOXHA0wQWwK9s3Q6GzlDIElRxd5QHmqBBAkc+yYsoNOiHHJ27qUZJbF1geM6VFA1MRH5P7/Veqgl1yyZqEIiMPlS5v70bxb7+25PfWcDlJ3lQKvJd3muB4KrL4Cz9FustQEqd/7biJgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691795; c=relaxed/simple;
	bh=c22Rp9Y4CpepiHjjVTTOJhHJ8lV0+J+xtKFMTNd7rXs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J0WFcxH/N/nfpKwEU8j4dyKWzBSvDEWRmJz8I5hJfCDonT9vt5Pe5PTy0qoRCYsq14ANgmFEHP9gHsfix4uWWgH0E7p7Mu0vVizITNKMyniyKxBnJF2iu2xJxtE3HXCAPpNjvpB2NxaaKopq1yrRVjSngD3p27qCnA7KLpyhvsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIvA9dWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E33AC4CECF;
	Fri, 15 Nov 2024 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731691795;
	bh=c22Rp9Y4CpepiHjjVTTOJhHJ8lV0+J+xtKFMTNd7rXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qIvA9dWoAwrMPbXbU2jl2SZFnDgdT3C0jp+/a93mrtxU90nMWbp0Sd1qZQocAXcQn
	 z7QnzZ9tf0n2fg9dfA9Y/XYDvFp4qPGZ3q/GtHPMOk5Wj6DvOCdWfqI1aYYoPRsLAp
	 XYurJCkVWDsFsEYSwFFiGx63VmEkStRazSvLBIAJG3SBFU/+XemQMJLjtOc4Bi1I2v
	 kJwy8o3eRJBs4any1nxm1ywZiRbMmWmKCfVaWS+4/vMmEJqUrDliyjzhk4yVbU2Y5S
	 rqhu/gBckrgxntKfiVbFs2S3Drkv7gfs8MYbaCC+XUOAr/zQiiVQ2zCO0+oX2IFj0Z
	 Co5JQbm9K3sYQ==
Date: Fri, 15 Nov 2024 11:29:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	jiawenwu@trustnetic.com, duanqiangwen@net-swift.com
Subject: Re: [PATCH PCI v2] PCI: Add ACS quirk for Wangxun FF5XXX NICS
Message-ID: <20241115172953.GA2044981@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16053DB2B80E9A5+20241115024604.30493-1-mengyuanlou@net-swift.com>

On Fri, Nov 15, 2024 at 10:46:04AM +0800, Mengyuan Lou wrote:
> Wangxun FF5xxx NICs are similar to SFxxx, RP1000 and RP2000 NICs.
> They may be multi-function devices, but they do not advertise an ACS
> capability.
> 
> But the hardware does isolate FF5xxx functions as though it had an
> ACS capability and PCI_ACS_RR and PCI_ACS_CR were set in the ACS
> Control register, i.e., all peer-to-peer traffic is directed
> upstream instead of being routed internally.
> 
> Add ACS quirk for FF5xxx NICs in pci_quirk_wangxun_nic_acs() so the
> functions can be in independent IOMMU groups.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

Applied to pci/virtualization for v6.13, thank you!

> ---
> 
> v2:
> - Update commit and comment logs.
> v1:
> https://lore.kernel.org/linux-pci/3D914272-CFAE-4B37-A07B-36CA77210110@net-swift.com/T/#t
> 
>  drivers/pci/quirks.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index dccb60c1d9cc..8103bc24a54e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4996,18 +4996,21 @@ static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
>  }
>  
>  /*
> - * Wangxun 10G/1G NICs have no ACS capability, and on multi-function
> - * devices, peer-to-peer transactions are not be used between the functions.
> - * So add an ACS quirk for below devices to isolate functions.
> + * Wangxun 40G/25G/10G/1G NICs have no ACS capability, but on
> + * multi-function devices, the hardware isolates the functions by
> + * directing all peer-to-peer traffic upstream as though PCI_ACS_RR and
> + * PCI_ACS_CR were set.
>   * SFxxx 1G NICs(em).
>   * RP1000/RP2000 10G NICs(sp).
> + * FF5xxx 40G/25G/10G NICs(aml).
>   */
>  static int  pci_quirk_wangxun_nic_acs(struct pci_dev *dev, u16 acs_flags)
>  {
>  	switch (dev->device) {
> -	case 0x0100 ... 0x010F:
> -	case 0x1001:
> -	case 0x2001:
> +	case 0x0100 ... 0x010F: /* EM */
> +	case 0x1001: case 0x2001: /* SP */
> +	case 0x5010: case 0x5025: case 0x5040: /* AML */
> +	case 0x5110: case 0x5125: case 0x5140: /* AML */
>  		return pci_acs_ctrl_enabled(acs_flags,
>  			PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  	}
> -- 
> 2.43.2
> 

