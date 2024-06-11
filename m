Return-Path: <linux-pci+bounces-8591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FC3903F72
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 17:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93740287138
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 15:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392E4171C2;
	Tue, 11 Jun 2024 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LO0ifl75"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12339A94C;
	Tue, 11 Jun 2024 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118097; cv=none; b=GAySNFE/ZFNDPYT/mgzO1lKKcxkD2fqpx4jFijbbJq4+/hxCs/T6CykOs6AvukzNiP1fXjHXNSUDLvfz38TWwDCLPO1dsGYPOF9zDqtmxUpgeiLyqm+FiHOnuMGqdEeusSccW1FyB/xM9lLmsDD8FO48trLd/NUCJBFLJ9PhEY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118097; c=relaxed/simple;
	bh=EBldb8eC9zZRVLdYxpQ3M9Qe3k8lhEojPVVggZFiHVA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Kl0AJ4Y56FiN3tzNfz+t/yW+N5LEAyhCUb7JAIRxsRPDGvIU7s/S1rSbUQYeyN1CQIRCSvSgYDhcriRv9cZHN5aso57E+rNG/3VRtMiBAUbBkVW0Vy65o213kvAV6EOKtin78L1g8tBbK88Z5v/OGknJ440EU/AFxJ7ktVSkbu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LO0ifl75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D5CC32789;
	Tue, 11 Jun 2024 15:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118096;
	bh=EBldb8eC9zZRVLdYxpQ3M9Qe3k8lhEojPVVggZFiHVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LO0ifl75iRSKuqvDdAVivkbflxKYF1SQExEuk8KYcrD0E0brJFhkWSTMYXcP70E/v
	 8hhFDVCL6kEKK9sTxZ1/FWO2jlzOIri7ojoFuOOF44QBeh2bakkgCObn2ZgSRlz7XM
	 bwZqoqOqPp9m/QyarfTfgBvV6Et602XNC4q9uoPIIeb2pwDnQ9uyXCFSSQnNVVU6j+
	 VfhAms6vx3vwS+eTC2nj49gYuAcP78q2n5oe1j7jJzx2JH//z0yhNeJEYwBIZ+05iG
	 9tZ2RpsRatvKUrpYgZC9n5+ElX7VWLrUp3a4lTS6dngt/9DxN+0sOV9FFtbjEfZfBt
	 fyVw8M/AHjMsw==
Date: Tue, 11 Jun 2024 10:01:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
	kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
	linux@armlinux.org.uk, hfdevel@gmx.net, naveenm@marvell.com,
	jdamato@fastly.com, bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next v10 1/7] PCI: add Edimax Vendor ID to pci_ids.h
Message-ID: <20240611150134.GA981546@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611045217.78529-2-fujita.tomonori@gmail.com>

On Tue, Jun 11, 2024 at 01:52:11PM +0900, FUJITA Tomonori wrote:
> Add the Edimax Vendor ID (0x1432) for an ethernet driver for Tehuti
> Networks TN40xx chips. This ID can be used for Realtek 8180 and Ralink
> rt28xx wireless drivers.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

If you have a chance, update the subject line with s/add/Add/ to match
history of this file.

> ---
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 942a587bb97e..677aea20d3e1 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2126,6 +2126,8 @@
>  
>  #define PCI_VENDOR_ID_CHELSIO		0x1425
>  
> +#define PCI_VENDOR_ID_EDIMAX		0x1432
> +
>  #define PCI_VENDOR_ID_ADLINK		0x144a
>  
>  #define PCI_VENDOR_ID_SAMSUNG		0x144d
> -- 
> 2.34.1
> 

