Return-Path: <linux-pci+bounces-34084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B35B27192
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 00:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707666822C4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 22:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68BA25DD0C;
	Thu, 14 Aug 2025 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2wqNAu3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9930C1F9F7A;
	Thu, 14 Aug 2025 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755210240; cv=none; b=j2nLgU1fg2xbQ6tBC+ZZw5ZCBxuG8KqX5F5nDjIrqv0fAHD+/DFCll5W/pMZmkeS3c0c+NG7kuvgVjGvdYrVQcT3r71yBzuZqZ5yrdzXyYx3vSfARrLih9IcetJMAQB2cpDXmagB3mAJS9+UosgRFxP5r2PK6yD0EHQipK9ma2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755210240; c=relaxed/simple;
	bh=9nNK2GZJp/6YMNjyc1o+May6E5+AHlSqTjcQABBkbUk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KPXxbsyaU0gzOO0mAaIKmnBifYrEv0SkApWIdnhO7nh88z2EfgDkrLc26M1oFUcukIezJYgIAlf0HghXMYSGAZcIOmR9XTZI2pSh0IF6mhDS/GKlnYSlMo9LHuNQt1/uLc/MJ1YCudNY3jHJk7/yiDASxhQ9QxbEmFo1bR1sIBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2wqNAu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F321CC4CEED;
	Thu, 14 Aug 2025 22:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755210240;
	bh=9nNK2GZJp/6YMNjyc1o+May6E5+AHlSqTjcQABBkbUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=i2wqNAu3IYAc7L6irrKKHDiJ6B+hr9TwRDgBIBXEiJD9CTW3OzV3y04ErMbf4tpk+
	 R73sJwFdLuelOrrQiO3CTSQiT6XHc0kd+pgjyWBjN3d2rpVnq7JPTyOBe5ERRKXsQN
	 5sGQu8o58ymBNu7a0MOs7dG8zPh7vTxKO3buYY8rwDT8QmrSxOr9lJRBRrOGiZSFw7
	 j/zRlFu3sJOkx0l0Offd52Fia1J1+h1msYQr8i2KhFs4bzfMIVAPe1k0ozFRF0WoF9
	 krqzJklVzabK3GKADm4gmsNuNQ6rllSd8QjgFrewiATsR+4pgBdJo4RJgCgP1d3gf7
	 ObuiaHvmBjX0g==
Date: Thu, 14 Aug 2025 17:23:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
	fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/13] PCI: Add Cix Technology Vendor and Device ID
Message-ID: <20250814222358.GA352330@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813042331.1258272-10-hans.zhang@cixtech.com>

On Wed, Aug 13, 2025 at 12:23:27PM +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Add Cixtech P1 (internal name sky1) as a vendor and device ID for PCI
> devices. This ID will be used by the CIX Sky1 PCIe host controller driver.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
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

I only see these used once in this series, so they probably should be
defined in the file that uses them, per the comment at the top of this
file.

Also, https://pcisig.com/membership/member-companies?combine=0x1f6c
doesn't show 0x1f6c as assigned to CIX.  That database often seems
incomplete, but please double check to make sure the ID is actually
reserved.

