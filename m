Return-Path: <linux-pci+bounces-21032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ABDA2D80E
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 19:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA8F161633
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 18:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED5A241135;
	Sat,  8 Feb 2025 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/CANNVe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03BC24111A;
	Sat,  8 Feb 2025 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739040128; cv=none; b=UtV+5aV4LsELTNir47PQqbVDa2DwPemMWfksBbu9qMzCNhqtzUE+ctvV0z8YOPypnn0uCAmIypMwbPp0MDg/CTSVz1LL/cLtSz1AMwhYupSmhA6cB/CfriVYrw7ugjhHGBYaVP7AwF9LUyXNwiw3HQNmKzkn5A3zkhu+/7rjlos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739040128; c=relaxed/simple;
	bh=O5+f7g25dktPAuKcDwUZ3ZwwHa0/bFIM02gDm1CshkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bu+LXCljyBe8e2bBJtrQb9a/apqtjwdRvPkldIi4Moa77Vqo33q+VkeyoClpNscuTGXDXG8MFkY99fd4mJX/GFi6lWh2HI2fUgmkQukTnqRO9bGAaYrAICeYWuiChc8psOz7lSTcRP8DXxJwSeXtF9QleNhBmhqX5lWuSAFzDaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/CANNVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D60C4CED6;
	Sat,  8 Feb 2025 18:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739040127;
	bh=O5+f7g25dktPAuKcDwUZ3ZwwHa0/bFIM02gDm1CshkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=G/CANNVe3b+P0HG2JdJnbP+p82zP1iXNJuVwwzTFJ65/TDRvpX/L++I4pl43HvBRt
	 z4RY2iM6xrEJgsYM/4tsndY0kM9yaOp+fTPLLA3shNL6zyO/S2nPfQC7kQR427Ar4M
	 YjVhdHhodiX3YyDKS6MioxrWW/o7s6vcvHQ49thgzBo6IHE5B4+WXJhgkovEoP1svi
	 HOD5sY0ewGoH0MJ/wS+G4+7/HsLGHJmd73vHBFNbFPjxMboiqGq0+y8MzaJiz+r2lP
	 QXhMWU1WHKyfCFQCCugUmRpWFb0ipsRAYm+G05af6X7MRWsoKbN2+OwdU1qKXkTWWI
	 PydYygsdSOAGQ==
Date: Sat, 8 Feb 2025 12:42:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Cleanup dev->resource + resno to use
 pci_resource_n()
Message-ID: <20250208184205.GA1120420@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207162301.2842-1-ilpo.jarvinen@linux.intel.com>

On Fri, Feb 07, 2025 at 06:23:01PM +0200, Ilpo Järvinen wrote:
> Replace pointer arithmentic in finding the correct resource entry with
> the pci_resource_n() helper.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/resource for v6.15, thanks, Ilpo!

> ---
>  drivers/pci/iov.c       |  2 +-
>  drivers/pci/pci.c       |  2 +-
>  drivers/pci/quirks.c    |  4 ++--
>  drivers/pci/setup-res.c | 12 ++++++------
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 9e4770cdd4d5..121540f57d4b 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -952,7 +952,7 @@ void pci_iov_remove(struct pci_dev *dev)
>  void pci_iov_update_resource(struct pci_dev *dev, int resno)
>  {
>  	struct pci_sriov *iov = dev->is_physfn ? dev->sriov : NULL;
> -	struct resource *res = dev->resource + resno;
> +	struct resource *res = pci_resource_n(dev, resno);
>  	int vf_bar = resno - PCI_IOV_RESOURCES;
>  	struct pci_bus_region region;
>  	u16 cmd;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..c4f710f782f6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1884,7 +1884,7 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
>  
>  		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
>  		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
> -		res = pdev->resource + bar_idx;
> +		res = pci_resource_n(pdev, bar_idx);
>  		size = pci_rebar_bytes_to_size(resource_size(res));
>  		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
>  		ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b84ff7bade82..5cc4610201b7 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -621,7 +621,7 @@ static void quirk_io(struct pci_dev *dev, int pos, unsigned int size,
>  {
>  	u32 region;
>  	struct pci_bus_region bus_region;
> -	struct resource *res = dev->resource + pos;
> +	struct resource *res = pci_resource_n(dev, pos);
>  	const char *res_name = pci_resource_name(dev, pos);
>  
>  	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0 + (pos << 2), &region);
> @@ -671,7 +671,7 @@ static void quirk_io_region(struct pci_dev *dev, int port,
>  {
>  	u16 region;
>  	struct pci_bus_region bus_region;
> -	struct resource *res = dev->resource + nr;
> +	struct resource *res = pci_resource_n(dev, nr);
>  
>  	pci_read_config_word(dev, port, &region);
>  	region &= ~(size - 1);
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index ca14576bf2bf..ad6436007148 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -29,7 +29,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
>  	u16 cmd;
>  	u32 new, check, mask;
>  	int reg;
> -	struct resource *res = dev->resource + resno;
> +	struct resource *res = pci_resource_n(dev, resno);
>  	const char *res_name = pci_resource_name(dev, resno);
>  
>  	/* Per SR-IOV spec 3.4.1.11, VF BARs are RO zero */
> @@ -262,7 +262,7 @@ resource_size_t __weak pcibios_align_resource(void *data,
>  static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
>  		int resno, resource_size_t size, resource_size_t align)
>  {
> -	struct resource *res = dev->resource + resno;
> +	struct resource *res = pci_resource_n(dev, resno);
>  	resource_size_t min;
>  	int ret;
>  
> @@ -325,7 +325,7 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
>  
>  int pci_assign_resource(struct pci_dev *dev, int resno)
>  {
> -	struct resource *res = dev->resource + resno;
> +	struct resource *res = pci_resource_n(dev, resno);
>  	const char *res_name = pci_resource_name(dev, resno);
>  	resource_size_t align, size;
>  	int ret;
> @@ -372,7 +372,7 @@ EXPORT_SYMBOL(pci_assign_resource);
>  int pci_reassign_resource(struct pci_dev *dev, int resno,
>  			  resource_size_t addsize, resource_size_t min_align)
>  {
> -	struct resource *res = dev->resource + resno;
> +	struct resource *res = pci_resource_n(dev, resno);
>  	const char *res_name = pci_resource_name(dev, resno);
>  	unsigned long flags;
>  	resource_size_t new_size;
> @@ -411,7 +411,7 @@ int pci_reassign_resource(struct pci_dev *dev, int resno,
>  
>  void pci_release_resource(struct pci_dev *dev, int resno)
>  {
> -	struct resource *res = dev->resource + resno;
> +	struct resource *res = pci_resource_n(dev, resno);
>  	const char *res_name = pci_resource_name(dev, resno);
>  
>  	pci_info(dev, "%s %pR: releasing\n", res_name, res);
> @@ -428,7 +428,7 @@ EXPORT_SYMBOL(pci_release_resource);
>  
>  int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>  {
> -	struct resource *res = dev->resource + resno;
> +	struct resource *res = pci_resource_n(dev, resno);
>  	struct pci_host_bridge *host;
>  	int old, ret;
>  	u32 sizes;
> 
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> -- 
> 2.39.5
> 

