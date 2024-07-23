Return-Path: <linux-pci+bounces-10675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0963D93A951
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 00:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2941F21459
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 22:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11611487F9;
	Tue, 23 Jul 2024 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heXVl6jS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC271487D1;
	Tue, 23 Jul 2024 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773703; cv=none; b=KQEbNPZ+t5nvX0z+AVnOp8op+ilR6CqY/MIHDHKygBfGUDz1sXOt73gZvKusOoSKgFixjn9kjx7DhcxnymTocq7WcD/6qbOnss2fm6IUGINSj8FzUiqx/qKfMauNyXPEC6u3QgjGSbGdqPbIuaQfjKXyX3udEVRQXQHJfP8KgcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773703; c=relaxed/simple;
	bh=vhEw1nDBqH/khMJ/eiR0TLM75/0lf2uUyUBKQewwZzU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VE+Sp+Nuit0KqVnjlUebGwFWd9a6e1vCIZ2rHQkw8wMjSOdtl/wzM18yPdU8Jx50aUct5zcnzeSnxU9ZlBxXf5b1I9Myy3oim+d6v2pQKeh9ezr1nk73XURe6YtB489hhmSfzEouXgGdu4CzUU8xdtPfEUE3BpQOQq+eQM4kZlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heXVl6jS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30B6C4AF09;
	Tue, 23 Jul 2024 22:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773703;
	bh=vhEw1nDBqH/khMJ/eiR0TLM75/0lf2uUyUBKQewwZzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=heXVl6jS3m6TjPTuu8hwCG9LkYNSXM2Vl+bdRnNixEdHam4wSIDvUKVUtS9QRHsVE
	 /acPNsL/YlvJHcs6A9uiZ4p/nFZXJSNLszvMBSdTo/wEP4KH0i8ba++af1IxNPdSJ0
	 5SWi+wH/xzlCNGHmKPBVuqxZc6Waz2zSbgmdyqMiRDqvNZl93hMiLDccgmNUp1qATa
	 +hciYBamwxKMgNjH9su6B/PMOvXZw5pTYT5P/kX3qw0dNd4VSZjR5jy9PfYMTtmq9s
	 Gi7U/8Psqg9nhlMbMP1gPr0DigaqX6FzRke/Ssnwi8+zKH7Jr7mKOjLecmluADIVTy
	 CXK2VYmLiBmxg==
Date: Tue, 23 Jul 2024 17:28:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com
Subject: Re: [PATCH V3 05/10] PCI/TPH: Introduce API to check interrupt
 vector mode support
Message-ID: <20240723222821.GA779373@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717205511.2541693-6-wei.huang2@amd.com>

On Wed, Jul 17, 2024 at 03:55:06PM -0500, Wei Huang wrote:
> Add an API function to allow endpoint device drivers to check
> if the interrupt vector mode is allowed. If allowed, drivers
> can proceed with updating ST tags.

Wrap commit log to fill 75 columns

Wrap code/comments to fit in 80.

Here and below, capitalize technical terms defined in spec ("Interrupt
Vector Mode", "Steering Tag").

> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> ---
>  drivers/pci/pcie/tph.c  | 29 +++++++++++++++++++++++++++++
>  include/linux/pci-tph.h |  3 +++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
> index fb8e2f920712..7183370b0977 100644
> --- a/drivers/pci/pcie/tph.c
> +++ b/drivers/pci/pcie/tph.c
> @@ -39,6 +39,17 @@ static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
>  	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg_val);
>  }
>  
> +static bool int_vec_mode_supported(struct pci_dev *pdev)
> +{
> +	u32 reg_val;
> +	u8 mode;
> +
> +	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg_val);
> +	mode = FIELD_GET(PCI_TPH_CAP_INT_VEC, reg_val);
> +
> +	return !!mode;
> +}
> +
>  void pcie_tph_set_nostmode(struct pci_dev *pdev)
>  {
>  	if (!pdev->tph_cap)
> @@ -60,3 +71,21 @@ void pcie_tph_init(struct pci_dev *pdev)
>  {
>  	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
>  }
> +
> +/**
> + * pcie_tph_intr_vec_supported() - Check if interrupt vector mode supported for dev
> + * @pdev: pci device
> + *
> + * Return:
> + *        true : intr vector mode supported
> + *        false: intr vector mode not supported
> + */
> +bool pcie_tph_intr_vec_supported(struct pci_dev *pdev)
> +{
> +	if (!pdev->tph_cap || pci_tph_disabled() || !pdev->msix_enabled ||
> +	    !int_vec_mode_supported(pdev))
> +		return false;

IMO the int_vec_mode_supported() helper is overkill and could be
inlined here.  The other booleans can be checked first.

> +
> +	return true;
> +}
> +EXPORT_SYMBOL(pcie_tph_intr_vec_supported);
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index 8fce3969277c..854677651d81 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -12,9 +12,12 @@
>  #ifdef CONFIG_PCIE_TPH
>  void pcie_tph_disable(struct pci_dev *dev);
>  void pcie_tph_set_nostmode(struct pci_dev *dev);
> +bool pcie_tph_intr_vec_supported(struct pci_dev *dev);
>  #else
>  static inline void pcie_tph_disable(struct pci_dev *dev) {}
>  static inline void pcie_tph_set_nostmode(struct pci_dev *dev) {}
> +static inline bool pcie_tph_intr_vec_supported(struct pci_dev *dev)
> +{ return false; }
>  #endif
>  
>  #endif /* LINUX_PCI_TPH_H */
> -- 
> 2.45.1
> 

