Return-Path: <linux-pci+bounces-16581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817AA9C5F6B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 18:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472E3281DBF
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 17:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077C8213EFA;
	Tue, 12 Nov 2024 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXZ348Br"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C99213EE8;
	Tue, 12 Nov 2024 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433703; cv=none; b=ZxaZUTlzzK9PLFYx9wTdxEDs3l5O1adfdo/JYeiYf0E9peTr8VPADz2vuh7Eoi7xSdkBqD3LEf/jivssp/h8obnvIJd1Os9obISAd6Z05M3Ava+78J0bK0zKGjqhqZ/EGwIe8E/vd2ztqfnGNPQrKc3Nq7eU8kmkr4KOkQ2Krco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433703; c=relaxed/simple;
	bh=MK+ASg1m69L5TLSwqsabPOqvNcQt6Y5JecMXgxOWODc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CBTZKIYJBLjCnUp7OSo642GRsCMy/fYbDzyNgFAjNxHIKYHR/pNqIYMzHIjjYEkApjyrqxKoLUk7O480+B482NwML96oH9X50hb6bl3HJ5iRqAZM4f2My/1IOLbIbpl6AanmV/6JWQiI4l4Xc/7cDKfXVT+BkuVFF0u6E2DgKHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXZ348Br; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282DEC4CECD;
	Tue, 12 Nov 2024 17:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731433703;
	bh=MK+ASg1m69L5TLSwqsabPOqvNcQt6Y5JecMXgxOWODc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kXZ348BrVPRVtn0Qu3Mh0QMajTVjY8EdzMD88qXP5XBv7EcuJBGTy6emumzssWpA1
	 G+IUKTgLryZZX5UUHAyVTnv+9JOIrw/KZp++9aP030obPyXDtZqRrShCbMPxhNvoqV
	 BlSjJYVwBWby33XHrdUQJV3f8hAyO9Ly4XdW0IEC5W/hdFB5K/vRQWEre4fiBC6aq0
	 7gMutJa41lqQweacIx8+bPBtzq1QSiM9wGiF9ORI/nIA8I1YDMwQUCJgnLEkYTi1pS
	 Ct5IlsvKnuGQtdTQigXewm4wsdb1RAWdugsF9ZLAKDcVQ2YMuoh2FdGpOFzGFY6n9w
	 BTV/nuEt2C9JQ==
Date: Tue, 12 Nov 2024 11:48:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	jiawenwu@trustnetic.com, duanqiangwen@net-swift.com
Subject: Re: [PATCH PCI] PCI: Add ACS quirk for Wangxun FF5XXX NICS
Message-ID: <20241112174821.GA1849315@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B12683A3B81C24B5+20241112111816.37290-1-mengyuanlou@net-swift.com>

On Tue, Nov 12, 2024 at 07:18:16PM +0800, Mengyuan Lou wrote:
> Wangxun FF5XXX NICs are same as selection of SFxxx, RP1000 and
> RP2000 NICS. They may be multi-function devices, but the hardware
> does not advertise ACS capability.
>
> Add this ACS quirk for FF5XXX NICs in pci_quirk_wangxun_nic_acs
> so the functions can be in independent IOMMU groups.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

I propose the following commit log and comment updates to be clear
that the hardware actually enforces this isolation.  Please
confirm that they are accurate.

  PCI: Add ACS quirk for Wangxun FF5xxx NICs

  Wangxun FF5xxx NICs are similar to SFxxx, RP1000 and RP2000 NICs.
  They may be multi-function devices, but they do not advertise an ACS
  capability.

  But the hardware does isolate FF5xxx functions as though it had an
  ACS capability and PCI_ACS_RR and PCI_ACS_CR were set in the ACS
  Control register, i.e., all peer-to-peer traffic is directed
  upstream instead of being routed internally.

  Add ACS quirk for FF5xxx NICs in pci_quirk_wangxun_nic_acs() so the
  functions can be in independent IOMMU groups.

> ---
>  drivers/pci/quirks.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index dccb60c1d9cc..d1973a8fd70c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4996,18 +4996,20 @@ static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
>  }
>  
>  /*
> - * Wangxun 10G/1G NICs have no ACS capability, and on multi-function
> + * Wangxun 40G/25G/10G/1G NICs have no ACS capability, and on multi-function
>   * devices, peer-to-peer transactions are not be used between the functions.
>   * So add an ACS quirk for below devices to isolate functions.

  Wangxun 40G/25G/10G/1G NICs have no ACS capability, but on
  multi-function devices, the hardware isolates the functions by
  directing all peer-to-peer traffic upstream as though PCI_ACS_RR and
  PCI_ACS_CR were set.

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

