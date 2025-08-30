Return-Path: <linux-pci+bounces-35179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02337B3CB23
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 15:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BF71BA40FF
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 13:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D93275B1A;
	Sat, 30 Aug 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XchFXlDY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154C936124;
	Sat, 30 Aug 2025 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756560029; cv=none; b=F4xJZnn+yPBQ9tJ/TIfo8YEhSjWhgFSOajij+Lh8VJ92p53JMgSXL0M4Ad7LqaFJutUlCMgynDFuTUgTUSC2XEUs+TIGbur14RQlNTcuUMkoyKZM1BgkM6NtDN7F5Q9yIbef84KSF2chTs4CTHJeTKzDKg94vqhia+TFbstCOEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756560029; c=relaxed/simple;
	bh=WokOP+UzIJ/WLJ6+9ulhSYng2UWT8l+toQjgxO3X2gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBND6T4vdv7luN5rQ5rd4/I2J9UJZIDX4e7EAnKrta2kUdnppC9s9hj96OslNudH4oCKSoGYdTPQYSD10GvTP6l3wTzvTwpM2+C/3ZDxYYoEozS7bCn/h5JJc2zAkclGCXNG7Ank3mH7Y75o128+O/GSWHBhySG8kdH7FP6LtOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XchFXlDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C62C4CEF1;
	Sat, 30 Aug 2025 13:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756560028;
	bh=WokOP+UzIJ/WLJ6+9ulhSYng2UWT8l+toQjgxO3X2gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XchFXlDYumDjvgqa/p7dUSTf1u6U5rZgr46PI+1fB1DVO43EdzwzRo5hfaXf4RDnB
	 il5sfRDknmVFcPqBPgjpwVhnpvF3GNrEatlnEox/+uDx/ExW+k13NORzOZ8ubafrRO
	 6rDz9J6kIZk27EzxFpkvJkceJ85pM4zkWNP/lhP63G74G641BN+KmIxSUJAWujLvEJ
	 DnXcP/Ey7gZuKgDIaiNcBq/6pxmfD3bRb8zQhdKh2gw88Ph5ErZZ4CXONpyr+iqJB+
	 PRAg9DgXjCy9q0svCm+Eppygr9w317sPcvFe1ZNoVYFlf8gZFFnO6E7QLXZXcAnIW9
	 iNzimI094b+6Q==
Date: Sat, 30 Aug 2025 18:50:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com, 
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/15] PCI: Add Cix Technology Vendor and Device ID
Message-ID: <p66xwu2ttyk4v4pfo4a7ib37oqdvo6vfdfuws6567tfep4shtv@t6rxrarbpbkg>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-12-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819115239.4170604-12-hans.zhang@cixtech.com>

On Tue, Aug 19, 2025 at 07:52:35PM GMT, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Add Cixtech P1 (internal name sky1) as a vendor and device ID for PCI
> devices. This ID will be used by the CIX Sky1 PCIe host controller driver.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  include/linux/pci_ids.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 92ffc4373f6d..24b04d085920 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2631,6 +2631,9 @@
>  
>  #define PCI_VENDOR_ID_CXL		0x1e98
>  
> +#define PCI_VENDOR_ID_CIX		0x1f6c
> +#define PCI_DEVICE_ID_CIX_SKY1		0x0001
> +
>  #define PCI_VENDOR_ID_TEHUTI		0x1fc9
>  #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
>  #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
> -- 
> 2.49.0
> 

-- 
மணிவண்ணன் சதாசிவம்

