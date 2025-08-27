Return-Path: <linux-pci+bounces-34936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9B5B38A30
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 21:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6AC91668F6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 19:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECB92E7F30;
	Wed, 27 Aug 2025 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrMRCa8B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90482D97A6
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 19:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756322782; cv=none; b=r3dLny0bP++KftejKZs6vVL0ruRWZQLjg4bPJUZ0Tln/V/sevDdxMrd6hU10cP0QC1YO5252pfB/dNkBvuCxltDo8mOxCnJoXRcGUsVmjYdUrqm9DzRWt722KaJRrn3bhiSNRtyxAIatwsY2p3kYcqLWcNMmZD0MCnuPgT2HeMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756322782; c=relaxed/simple;
	bh=LsA7ZOxoBvYSNrrcpvDmb056rLUcRAIeEvgBLT/jOP8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DV8163PXNDrGQShfj+WyrtVhuQUsH9O1cg1Apkl9+0c8RtlA1iDPosdgGPDg4+gDoQoG09Bw3dDhSs4T3Yu09n1ssPOWpmnV26ZFgEnxBnFmiJ7QyUbmbcCTR/Bo5EOieNEaC7ICln/o3kL6srBES5NFovBmHWSOXRLlUjbZPQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrMRCa8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20924C4CEF4;
	Wed, 27 Aug 2025 19:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756322781;
	bh=LsA7ZOxoBvYSNrrcpvDmb056rLUcRAIeEvgBLT/jOP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mrMRCa8BgGthZWppKJVQhU2g5bmIIf9uvfJelrBiPml0sWYGWybHeNVkKKUMFTeWb
	 3jhF9XvQmLNoj81iZ7AysmkLVtmehHGU6s2CbtcFvsgPeo+KGQ5QPxKEZeTLqmI8AT
	 w6/hWGAasWUszW3G85lzIdpn1NvTp4cn6CTm2aiouIZfuFou7iD3QgAEuy9tg2QLIE
	 YU25hLJz7beNnwaaUo2mtLd6smZ7w9ysYG+w6P3O1Aachxs58HUCZ6lMDAFQeJmhL6
	 XmZTe30eLCnmsAJrTsg26IZID9NlOi7PZ9pUKbuL13S8JRzMH2Bew8CQl6vCxb+W8A
	 NDPdu3rwJlQcw==
Date: Wed, 27 Aug 2025 14:26:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Support errors introduced by PCIe r6.0
Message-ID: <20250827192619.GA896720@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21f1875b18d4078c99353378f37dcd6b994f6d4e.1756301211.git.lukas@wunner.de>

On Wed, Aug 27, 2025 at 03:41:09PM +0200, Lukas Wunner wrote:
> PCIe r6.0 defined five additional errors in the Uncorrectable Error
> Status, Mask and Severity Registers (PCIe r7.0 sec 7.8.4.2ff).
> 
> lspci has been supporting them since commit 144b0911cc0b ("ls-ecaps:
> extend decode support for more fields for AER CE and UE status"):
> 
> https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/commit/?id=144b0911cc0b
> 
> Amend the AER driver to recognize them as well, instead of logging them as
> "Unknown Error Bit".
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org

Applied to pci/aer for v6.18, thanks, Lukas!

> ---
> Last amendment of aer_uncorrectable_error_string[] was in 2019 for an
> error introduced in PCIe r3.1, see commit 6458b438ebc1 ("PCI/AER: Add
> PoisonTLPBlocked to Uncorrectable error counters").
> 
>  drivers/pci/pcie/aer.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e286c19..15ed541 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -43,7 +43,7 @@
>  #define AER_ERROR_SOURCES_MAX		128
>  
>  #define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
> -#define AER_MAX_TYPEOF_UNCOR_ERRS	27	/* as per PCI_ERR_UNCOR_STATUS*/
> +#define AER_MAX_TYPEOF_UNCOR_ERRS	32	/* as per PCI_ERR_UNCOR_STATUS*/
>  
>  struct aer_err_source {
>  	u32 status;			/* PCI_ERR_ROOT_STATUS */
> @@ -525,11 +525,11 @@ void pci_aer_exit(struct pci_dev *dev)
>  	"AtomicOpBlocked",		/* Bit Position 24	*/
>  	"TLPBlockedErr",		/* Bit Position 25	*/
>  	"PoisonTLPBlocked",		/* Bit Position 26	*/
> -	NULL,				/* Bit Position 27	*/
> -	NULL,				/* Bit Position 28	*/
> -	NULL,				/* Bit Position 29	*/
> -	NULL,				/* Bit Position 30	*/
> -	NULL,				/* Bit Position 31	*/
> +	"DMWrReqBlocked",		/* Bit Position 27	*/
> +	"IDECheck",			/* Bit Position 28	*/
> +	"MisIDETLP",			/* Bit Position 29	*/
> +	"PCRC_CHECK",			/* Bit Position 30	*/
> +	"TLPXlatBlocked",		/* Bit Position 31	*/
>  };
>  
>  static const char *aer_agent_string[] = {
> -- 
> 2.47.2
> 

