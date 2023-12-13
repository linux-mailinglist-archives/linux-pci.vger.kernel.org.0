Return-Path: <linux-pci+bounces-907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4253811ED3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 20:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543F128290B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 19:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19CA63599;
	Wed, 13 Dec 2023 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skJ63w2J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74C653E10
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 19:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E92C433C8;
	Wed, 13 Dec 2023 19:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702495614;
	bh=vXpR4g1rcKpfov2gki4D3V32WfdQEc9ZzcOiXga2fos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=skJ63w2JJxY92R1Z/iMNX3UN2vkjIuGi7xe0eIiEDGCzoZfnWOh+K7I9tF3Y/giVv
	 B+T74AxmzdDjELcoGGBMyAZjh2MGPJkdqJhjcbNawRObyOQw8T4d/08NXz66xlvzlE
	 TOmLDfIH5PW56Gu78D53InFDdhKG+yxSvpjlkEGUn01f95XApJzRgaWsrv51LgCODX
	 rmR1xdkXMTKPnrnpDh6RmWr0uC//0cGKk/UrDT2M71UIDc3bLcshPpkTrBrEF4jxM6
	 MdyepV52qruZ0S8wnlSIEKRvuAgGinfP2ZQyTlRaO9Q8xbZQo7hdEkuHmnhApEFXnv
	 JGf8Exp+APwWw==
Date: Wed, 13 Dec 2023 13:26:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Harris <jim.harris@samsung.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] pci/iov: fix kobject_uevent() ordering in sriov_enable()
Message-ID: <20231213192652.GA1054534@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170249390826.436889.13896090394795622449.stgit@bgt-140510-bm01.eng.stellus.in>

On Wed, Dec 13, 2023 at 06:58:28PM +0000, Jim Harris wrote:
> Wait to call kobject_uevent() until all of the associated changes are done,
> including updating the num_VFs value.

This seems right to me.  Can we add a little rationale to the commit
log?  E.g., something about how num_VFs is visible to userspace via
sysfs and we don't want a race between (a) userspace reading num_VFs
because of KOBJ_CHANGE and (b) the kernel updating num_VFs?  (If
that's the actual reason.)

If there's a problem report about this, include that reference as
well.

> Suggested by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Jim Harris <jim.harris@samsung.com>
> ---
>  drivers/pci/iov.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 25dbe85c4217..3b768e20c7ab 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -683,8 +683,8 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	if (rc)
>  		goto err_pcibios;
>  
> -	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
>  	iov->num_VFs = nr_virtfn;
> +	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
>  
>  	return 0;
>  
> 

