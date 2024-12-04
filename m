Return-Path: <linux-pci+bounces-17706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7328E9E4782
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A8E163FAD
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 22:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384F9192D61;
	Wed,  4 Dec 2024 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9Ndj2DQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD0A2391A0;
	Wed,  4 Dec 2024 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350130; cv=none; b=lML776LQzf3eV10jDE1Ko75WWN534xzzLu4aBxRy52uyWwPM/glk2MySGr6P8JZOCub3l1XavvLsylecXJQxqPqnaBYh7ElhxJoiBTtwN3rkvO1aJNx+XahVQJXkk7sgIvDWqim5C7FqeiscMsqZXTWvYvewIjziHJ892YMDdIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350130; c=relaxed/simple;
	bh=9WUkVEFFi58F5ojed1vxoss3U/Fr3/XFqUfdXLpl4nY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=g/y3h8Y8Zvkp/AG8I1a97Ig7UdaQcYQaMrBq8tB5jRW3HzTbWJAnOMNF6MUa7a8jZ/J4UHMqgCg6aysEJzXdxkAmCRG0FJixl2XBASSH536JpjFw2nz6pzGv4mkoysJMrurcvLPV/S0MzeF2VYYAw9qqmVSj6GVwGqSFWaOKkQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9Ndj2DQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE26BC4CED1;
	Wed,  4 Dec 2024 22:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733350129;
	bh=9WUkVEFFi58F5ojed1vxoss3U/Fr3/XFqUfdXLpl4nY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=J9Ndj2DQ0yXMfvB4oW8wKZ2I6S95iWRsxj7aeUISgdIvI3kr1PM68BVbX/ogdg8yF
	 XXV0jMJwCWnVJi08ql9b/dNg831wIRpM+0gCdGKi5QkxmrxuwfBgzMKdrbZsnHp35g
	 6p5YmWWCmuWbqsEQ2EI8aPV6TsjnwBdRCaHC+73LZpZx1HRUC2E+y6p5VDhvEAyHek
	 QpVBHnFwopMysRVv9IZ/y3DWky4tTb4I8f8gRIlDas+Z7okrKENoQpEzwCtixSpBjX
	 MFBLIAnrRKoTEQfSRHo6/sXJ5slvdBOf1EDSFZSd4wOcp1YYZCJL2E637MUxtZNCrg
	 sj8bKmOs++FpA==
Date: Wed, 4 Dec 2024 16:08:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cameron Williams <cang1@live.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-pci@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 2/2] serial: 8250_pci: Share WCH IDs with
 parport_serial driver
Message-ID: <20241204220847.GA3023286@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204031114.1029882-3-andriy.shevchenko@linux.intel.com>

On Wed, Dec 04, 2024 at 05:09:22AM +0200, Andy Shevchenko wrote:
> parport_serial driver uses subset of WCH IDs that are present in 8250_pci.
> Share them via pci_ids.h and switch parport_serial to use defined constants.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/parport/parport_serial.c   | 12 ++++++++----
>  drivers/tty/serial/8250/8250_pci.c | 10 ++--------
>  include/linux/pci_ids.h            | 11 +++++++++++

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci-ids.h

>  3 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
> index 3644997a8342..24d4f3a3ec3d 100644
> --- a/drivers/parport/parport_serial.c
> +++ b/drivers/parport/parport_serial.c
> @@ -266,10 +266,14 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
>  	{ 0x1409, 0x7168, 0x1409, 0xd079, 0, 0, timedia_9079c },
>  
>  	/* WCH CARDS */
> -	{ 0x4348, 0x5053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, wch_ch353_1s1p},
> -	{ 0x4348, 0x7053, 0x4348, 0x3253, 0, 0, wch_ch353_2s1p},
> -	{ 0x1c00, 0x3050, 0x1c00, 0x3050, 0, 0, wch_ch382_0s1p},
> -	{ 0x1c00, 0x3250, 0x1c00, 0x3250, 0, 0, wch_ch382_2s1p},
> +	{ PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_1S1P,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, wch_ch353_1s1p },
> +	{ PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_2S1P,
> +	  0x4348, 0x3253, 0, 0, wch_ch353_2s1p },
> +	{ PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH382_0S1P,
> +	  0x1c00, 0x3050, 0, 0, wch_ch382_0s1p },
> +	{ PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH382_2S1P,
> +	  0x1c00, 0x3250, 0, 0, wch_ch382_2s1p },
>  
>  	/* BrainBoxes PX272/PX306 MIO card */
>  	{ PCI_VENDOR_ID_INTASHIELD, 0x4100,
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index dfac79744d37..df4d0d832e54 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -64,23 +64,17 @@
>  #define PCIE_DEVICE_ID_NEO_2_OX_IBM	0x00F6
>  #define PCI_DEVICE_ID_PLX_CRONYX_OMEGA	0xc001
>  #define PCI_DEVICE_ID_INTEL_PATSBURG_KT 0x1d3d
> -#define PCI_VENDOR_ID_WCHCN		0x4348
> +
>  #define PCI_DEVICE_ID_WCHCN_CH352_2S	0x3253
> -#define PCI_DEVICE_ID_WCHCN_CH353_4S	0x3453
> -#define PCI_DEVICE_ID_WCHCN_CH353_2S1PF	0x5046
> -#define PCI_DEVICE_ID_WCHCN_CH353_1S1P	0x5053
> -#define PCI_DEVICE_ID_WCHCN_CH353_2S1P	0x7053
>  #define PCI_DEVICE_ID_WCHCN_CH355_4S	0x7173
> +
>  #define PCI_VENDOR_ID_AGESTAR		0x5372
>  #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
>  #define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
>  #define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
>  
> -#define PCI_VENDOR_ID_WCHIC		0x1c00
> -#define PCI_DEVICE_ID_WCHIC_CH382_2S1P	0x3250
>  #define PCI_DEVICE_ID_WCHIC_CH384_4S	0x3470
>  #define PCI_DEVICE_ID_WCHIC_CH384_8S	0x3853
> -#define PCI_DEVICE_ID_WCHIC_CH382_2S	0x3253
>  
>  #define PCI_DEVICE_ID_MOXA_CP102E	0x1024
>  #define PCI_DEVICE_ID_MOXA_CP102EL	0x1025
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index d2402bf4aea2..de5deb1a0118 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2593,6 +2593,11 @@
>  
>  #define PCI_VENDOR_ID_REDHAT		0x1b36
>  
> +#define PCI_VENDOR_ID_WCHIC		0x1c00
> +#define PCI_DEVICE_ID_WCHIC_CH382_0S1P	0x3050
> +#define PCI_DEVICE_ID_WCHIC_CH382_2S1P	0x3250
> +#define PCI_DEVICE_ID_WCHIC_CH382_2S	0x3253
> +
>  #define PCI_VENDOR_ID_SILICOM_DENMARK	0x1c2c
>  
>  #define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
> @@ -2647,6 +2652,12 @@
>  #define PCI_VENDOR_ID_AKS		0x416c
>  #define PCI_DEVICE_ID_AKS_ALADDINCARD	0x0100
>  
> +#define PCI_VENDOR_ID_WCHCN		0x4348
> +#define PCI_DEVICE_ID_WCHCN_CH353_4S	0x3453
> +#define PCI_DEVICE_ID_WCHCN_CH353_2S1PF	0x5046
> +#define PCI_DEVICE_ID_WCHCN_CH353_1S1P	0x5053
> +#define PCI_DEVICE_ID_WCHCN_CH353_2S1P	0x7053
> +
>  #define PCI_VENDOR_ID_ACCESSIO		0x494f
>  #define PCI_DEVICE_ID_ACCESSIO_WDG_CSM	0x22c0
>  
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

