Return-Path: <linux-pci+bounces-29670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1840AAD889D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 11:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D4E17DCB8
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 09:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F922C1592;
	Fri, 13 Jun 2025 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7w1JVc7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8698E279DDE;
	Fri, 13 Jun 2025 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749808684; cv=none; b=Ip4k/766VFC16IWXvg5BYg2pRggmrPHjmr1YR3SDKqFPpquxE4efzTbgeQ+P5zhLEAv3Ns7SON34WUtJ7R6ulPclvSOTk52HwhLz3nZurBRV66Qd3Fv6vfrPptOLeTjf/lUsvJLMfdT1eLmiEQg/T9wr9rltMvoagOvyImv5yFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749808684; c=relaxed/simple;
	bh=G4mozzSNIL8M7xSC9LEkjGkxAQgotznIv+DroF8BTDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTNmAmkvEv2Ik7CuIBl068oCWHOxvQbAms+htPgVU6iK4uPkjaLss7Upqq9k8Pa5VpNIZ+sYcvPz3WfpZ0n4Q2KB4SikN2KCRXtDVabDU/VBRhWA1BSwRwaIUhFjlkBvKExBv44LAbnsI91pTTbTRVkSpcfqXSDTjbhkiQ8z4EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7w1JVc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D30C4CEE3;
	Fri, 13 Jun 2025 09:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749808684;
	bh=G4mozzSNIL8M7xSC9LEkjGkxAQgotznIv+DroF8BTDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g7w1JVc7Tc2664a27eZLT59peh+8XEmKqmHkCDRrIshy+A4zt41dqM57oAd+TAza0
	 DDL3nk9a+8Xe7NPthgr+a02ZMfd3a7r6ROpg6p0ScbNp6tkO2yRYWUJsQgy/cLhjq+
	 b86sHC3RGA62011YFuc2CnqoJXlkimvr5C76s/1XlACValJYfWV+X2GhckMI58S9io
	 +D1vVeBK6tVJmSRlavnBAXOk+emLGtfLxAxEfO4mPeN/mBKKiVWYZlzD4sPOw7lHsa
	 RP+C+z296QYx400YlNfApbIduwyBaTZ0XTv9IeQKddWHm33fWgkpXhStHqUA7TM+Wt
	 eIJMh9rB3VKsw==
Date: Fri, 13 Jun 2025 11:57:59 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, mani@kernel.org, robh@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Simplify boolean condition returns in debugfs
Message-ID: <aEv2J7Or8zWgoKHy@ryzen>
References: <20250612161226.950937-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612161226.950937-1-18255117159@163.com>

On Fri, Jun 13, 2025 at 12:12:26AM +0800, Hans Zhang wrote:
> Replace redundant ternary conditional expressions with direct boolean
> returns in PTM visibility functions. Specifically change this pattern:
> 
>     return (condition) ? true : false;
> 
> to the simpler:
> 
>     return condition;
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  .../pci/controller/dwc/pcie-designware-debugfs.c   | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index c67601096c48..6f438a36f840 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -814,14 +814,14 @@ static bool dw_pcie_ptm_context_update_visible(void *drvdata)
>  {
>  	struct dw_pcie *pci = drvdata;
>  
> -	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
> +	return pci->mode == DW_PCIE_EP_TYPE;
>  }
>  
>  static bool dw_pcie_ptm_context_valid_visible(void *drvdata)
>  {
>  	struct dw_pcie *pci = drvdata;
>  
> -	return (pci->mode == DW_PCIE_RC_TYPE) ? true : false;
> +	return pci->mode == DW_PCIE_RC_TYPE;
>  }
>  
>  static bool dw_pcie_ptm_local_clock_visible(void *drvdata)
> @@ -834,35 +834,35 @@ static bool dw_pcie_ptm_master_clock_visible(void *drvdata)
>  {
>  	struct dw_pcie *pci = drvdata;
>  
> -	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
> +	return pci->mode == DW_PCIE_EP_TYPE;
>  }
>  
>  static bool dw_pcie_ptm_t1_visible(void *drvdata)
>  {
>  	struct dw_pcie *pci = drvdata;
>  
> -	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
> +	return pci->mode == DW_PCIE_EP_TYPE;
>  }
>  
>  static bool dw_pcie_ptm_t2_visible(void *drvdata)
>  {
>  	struct dw_pcie *pci = drvdata;
>  
> -	return (pci->mode == DW_PCIE_RC_TYPE) ? true : false;
> +	return pci->mode == DW_PCIE_RC_TYPE;
>  }
>  
>  static bool dw_pcie_ptm_t3_visible(void *drvdata)
>  {
>  	struct dw_pcie *pci = drvdata;
>  
> -	return (pci->mode == DW_PCIE_RC_TYPE) ? true : false;
> +	return pci->mode == DW_PCIE_RC_TYPE;
>  }
>  
>  static bool dw_pcie_ptm_t4_visible(void *drvdata)
>  {
>  	struct dw_pcie *pci = drvdata;
>  
> -	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
> +	return pci->mode == DW_PCIE_EP_TYPE;
>  }
>  
>  const struct pcie_ptm_ops dw_pcie_ptm_ops = {
> 
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> -- 
> 2.25.1
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

