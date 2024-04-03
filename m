Return-Path: <linux-pci+bounces-5634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D398979B6
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 22:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD0128D9FC
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D73615574B;
	Wed,  3 Apr 2024 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLIqwQOC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2469B155301;
	Wed,  3 Apr 2024 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175641; cv=none; b=AiEL0Qat9N/fkLfXcu2kY6Ti5S3j0nWOjOVFRwzgcvPj1Vs2GjT3VfkwxU/49wFDKv/wONZ1ygfpTthjQdL8pbWdFehS/dowRjTpKDJGI/NYGc0ChfqPtSo04RCwo3Sx1k2YQxKapCspiremgwQGUL6hfBZgbSVYIe7q3ZMthM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175641; c=relaxed/simple;
	bh=8vgEXwRI6K2kcfIj/P9t20Vpnvs8E6Z2halTW65+44U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WhWA+tY3pbc7CNejveKwg2ddyC5IHCusGMlawZhM/VsfP1EuiaYN6Awt+QmTHznb+AnhOPyaNmYGsQNml2Rh8JhDJVsCmtuMbZXvTWjDcFVra0wUobQYE0mnrCAPXO4l2p1xEqtnrQt/jo9oRG+eLaJI+vPUzQtB+BNiZw+1a3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLIqwQOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44761C433F1;
	Wed,  3 Apr 2024 20:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712175640;
	bh=8vgEXwRI6K2kcfIj/P9t20Vpnvs8E6Z2halTW65+44U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SLIqwQOCGAT2EG98/3gl7YQMgnkxgTh80+q8B4Uz5N5N4nsvr1QW7k5PbgM+qxHVg
	 z3dXy3KZWfWaeK0rMXUuwlKf4II/gZocum7qYe1vw/cOjEuFKT+Yg1R7/h5iJt3iNa
	 DQEg2dUFbPW4XjdLG48gX6UQk77VwIyGwLDfZ0ZmWjcX77RBGa8uuBt590QnOb7IZW
	 jSEO/jzqHNn6mYvrRGBBCpBrjj1VfzMs5WtnxFR1YWzGsbaZRQQT4bo1weniG4ppSa
	 YNBtc/GO68kYuYGonN9hJhwk8cVzkcQwKylHxrktHQtroZWTvbfgKZXuOsYL2b9uT3
	 VeOtvYGb+/JZw==
Date: Wed, 3 Apr 2024 15:20:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 01/15] PCI: Add Meta Platforms vendor ID
Message-ID: <20240403202038.GA1886507@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171217490835.1598374.17542029177954737682.stgit@ahduyck-xeon-server.home.arpa>

On Wed, Apr 03, 2024 at 01:08:28PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Add Meta as a vendor ID for PCI devices so we can use the macro for future
> drivers.
> 
> CC: bhelgaas@google.com
> CC: linux-pci@vger.kernel.org
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci_ids.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index a0c75e467df3..e5a1d5e9930b 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2598,6 +2598,8 @@
>  
>  #define PCI_VENDOR_ID_HYGON		0x1d94
>  
> +#define PCI_VENDOR_ID_META		0x1d9b
> +
>  #define PCI_VENDOR_ID_FUNGIBLE		0x1dad
>  
>  #define PCI_VENDOR_ID_HXT		0x1dbf
> 
> 

