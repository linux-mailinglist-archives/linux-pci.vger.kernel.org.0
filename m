Return-Path: <linux-pci+bounces-14889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4649A4A1C
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 01:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9906283FCC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 23:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E93218C938;
	Fri, 18 Oct 2024 23:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+szYCv3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F76714F9D9;
	Fri, 18 Oct 2024 23:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729294678; cv=none; b=kLPqKkmZDdIGW/ecG3sV4PPlYLJNaD7tg119wFN2ternHf1gt7u6sTG1ict4AloIPZb5H7+txtZHB9hKm6DPNyHo8dyMiYkXwZ+464BhQtqdQvmsrEI4VglBJ71obiizK5bNLxRQ3xw1fY8x8nBl6dRPLsDNTMKHpgECdq5olcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729294678; c=relaxed/simple;
	bh=1Bfo14PFeZnolJT1s04bCHgEgycvWkvI1p5dF000Ycg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H7hSyBCaDbaEF7e4CiYY5xrGvYxoRVGKMx+4z5nXgdQlYxQrSQjk6zZ9KGI5mcWgH7hU2UhYfI7Mvqkfgk+tFFS6aCBKTdde+UDiBNyqAF6Btum2A5U59j10BjK19Foy73Up3wGUMQK8lnAc+a0ObiFFw2APx+3fIrWoTGAMB7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+szYCv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CE4C4CEC3;
	Fri, 18 Oct 2024 23:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729294677;
	bh=1Bfo14PFeZnolJT1s04bCHgEgycvWkvI1p5dF000Ycg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=k+szYCv3RLu+BCZBjAYRntcnnCVQeeCGLRnqhjL0dpQXsEPgkvD7cPHDNPeF9CvdR
	 2Rsr15OLoG58cdl8OrdNFKEvxv/Dd2NuZ6JAZ1QmjlaMIHZ9mmXTAHll/35T+Gh7Tf
	 N011jKY0EKXSSdClJSSJVUv7DVsAVvJBGNRDj9TlwEa5MKBxhdkO4LB+erK4KLNcM4
	 YycIIW3mRui4udBeF5xqJbnFjNdYJ82Flzm74WLB2kZQcheHmiuuqT/TAwtyjdXRb/
	 t1Vg3+gLDQxIGbc/YEFyHm1ukZNja05DXeHeXGRzM0qtf22sn7lR5ZJpTqqlt0yOJx
	 aQ1gXtRjIaaqA==
Date: Fri, 18 Oct 2024 18:37:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI: cpqphp: Simplify PCI_ScanBusForNonBridge()
Message-ID: <20241018233756.GA769880@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017143131.46163-5-ilpo.jarvinen@linux.intel.com>

On Thu, Oct 17, 2024 at 05:31:31PM +0300, Ilpo Järvinen wrote:
> PCI_ScanBusForNonBridge() has two loops, first searching for
> non-bridges and second that looks for bridges. The second loop has
> hints in a debug print it should do recursion for buses underneath the
> bridge but no recursion is attempted.
> 
> Since the second loop is quite useless in its current form, just
> eliminate it. This code hasn't been touched for very long time so
> either it's unused or the missing parts are not important enough for
> anyone to attempt to add them.
> 
> Leave only a simple comment about the missing recursion for the
> unlikely case that somebody comes across the lack of functionality. In
> any case, search whether an endpoint exists downstream of a bridge
> sounds generic enough to belong to core so if the functionality is to
> be extended it should probably be moved into PCI core.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/hotplug/cpqphp_pci.c | 30 +++++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
> index 558866c15e03..b2efc4a90864 100644
> --- a/drivers/pci/hotplug/cpqphp_pci.c
> +++ b/drivers/pci/hotplug/cpqphp_pci.c
> @@ -190,8 +190,7 @@ static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 bus_num, u8 *dev_
>  {
>  	u16 tdevice;
>  	u32 work;
> -	int ret;
> -	u8 tbus;
> +	int ret = -1;
>  
>  	ctrl->pci_bus->number = bus_num;
>  
> @@ -208,26 +207,19 @@ static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 bus_num, u8 *dev_
>  			*dev_num = tdevice;
>  			dbg("found it !\n");
>  			return 0;
> -		}
> -	}
> -	for (tdevice = 0; tdevice < 0xFF; tdevice++) {
> -		/* Scan for access first */
> -		if (!pci_bus_read_dev_vendor_id(ctrl->pci_bus, tdevice, &work, 0))
> -			continue;
> -		ret = pci_bus_read_config_dword(ctrl->pci_bus, tdevice, PCI_CLASS_REVISION, &work);
> -		if (ret)
> -			continue;
> -		dbg("Looking for bridge bus_num %d dev_num %d\n", bus_num, tdevice);
> -		/* Yep we got one. bridge ? */
> -		if ((work >> 8) == PCI_TO_PCI_BRIDGE_CLASS) {
> -			pci_bus_read_config_byte(ctrl->pci_bus, PCI_DEVFN(tdevice, 0), PCI_SECONDARY_BUS, &tbus);
> -			/* XXX: no recursion, wtf? */
> -			dbg("Recurse on bus_num %d tdevice %d\n", tbus, tdevice);
> -			return 0;
> +		} else {
> +			/*
> +			 * XXX: Code whose debug printout indicated
> +			 * recursion to buses underneath bridges might be
> +			 * necessary was removed because it never did
> +			 * any recursion.
> +			 */
> +			ret = 0;

I'm OK with this except that I wonder if we should leave an actual
info or even warning level printk here as a more visible debugging
hint if somebody hits this.  I'm not sure that simply returning 0
would be enough of a hint about why devices below the bridge weren't
found.

>  		}
>  	}
>  
> -	return -1;
> +
> +	return ret;
>  }
>  
>  
> -- 
> 2.39.5
> 

