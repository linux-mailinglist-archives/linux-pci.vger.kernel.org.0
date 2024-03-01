Return-Path: <linux-pci+bounces-4350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56FE86EB19
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 22:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F232849C2
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 21:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C265D57896;
	Fri,  1 Mar 2024 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5wHWG/6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847356B8A;
	Fri,  1 Mar 2024 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328376; cv=none; b=pCcu9n83g9sA8Zh7t9E3xPiDq2kqquzJQ7e1Er8eZBGdvWXCWy2YRF0dfNYK1uWRHUnrue5CcACd8PBCUwPkBDPMoofQ2GUjDJg3vq1tw+g95H5qwVOfI0on76c2cExJpgtCZ6EhcepK8lDwYQ9ofJG9ASzTbYq0uUir8vK3YgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328376; c=relaxed/simple;
	bh=ZGfR2lf/9g8jp3nNVbb6uJipnnVk66kZABtn0lTE3+k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NqiL/4FHpghNOeRk+yPaKiKYA7S9yNeIJu1PHkUgzIs2jyafkY0wGZrLJ3Kq7O8vIt7XwMaCt3cPE8Tft6T25fGMCLiDLS4tWSvJ+xyj/MTYsFGxWttJn/6+HrUNBx5y5bOXtvzQzVjaBIPg1D6CMwbgTQOupLDfErnKUIgbVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5wHWG/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2095EC433F1;
	Fri,  1 Mar 2024 21:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709328376;
	bh=ZGfR2lf/9g8jp3nNVbb6uJipnnVk66kZABtn0lTE3+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=G5wHWG/68wnkT+Um/N/TS1FLL+VyJ+PLZjlwgwZbQdpYAxbZQ5vlZp5P2stx5wGQ7
	 FzlZb7a355Oo/C/Huex/uAjw2ZLzjRBnri75/reSyucLJ01Z3bjGdgCh30pn72Jq31
	 030n2wfCXsw8wfv2BolfbBnF9+ZcfPE02mvBt8xhW+MyMoTtjyypuc8I5Oz3Nj4ppU
	 b+xu/4d82vnpRGlwEnS6VI3HMqMeVcosy6fBP3j49tWCiAQ73bjHaj+Had2GjxKLQ2
	 Z22E9N+9RyjIDiXcd8XTNbQyujXwjWMP5ETcJjKNMbvFGnNCDttC6PI3SPYym9msdq
	 BCXaRL9xL4wmw==
Date: Fri, 1 Mar 2024 15:26:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@endlessos.org
Subject: Re: [PATCH v4 2/3] PCI/ASPM: Add notes about enabling PCI-PM L1SS to
 pci_enable_link_state(_locked)
Message-ID: <20240301212614.GA408494@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216062559.247479-3-jhp@endlessos.org>

In subject:

  PCI/ASPM: Document D0 requirement when enabling PCI-PM L1 PM Substates

On Fri, Feb 16, 2024 at 02:26:01PM +0800, Jian-Hong Pan wrote:
> According to PCI Express Base Specification Revision 6.0, Section 5.5.4:
> "If setting either or both of the enable bits for PCI-PM L1 PM Substates,
> both ports must be configured as described in this section while in D0."

"PCIe r6.0, sec 5.5.4" is enough.

> Add notes into pci_enable_link_state(_locked) for kernel-doc.

  Add note about D0 requirement in pci_enable_link_state() kernel-doc.

> Hope these
> notify callers ensuring the devices in D0, if PCI-PM L1 PM Substates are
> going to be enabled.

Skip this part.

> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>

With above updates,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> v3:
> - Fix as readable comments
> 
> v4:
> - The same
> 
>  drivers/pci/pcie/aspm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 7f1d674ff171..a39d2ee744cb 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1416,6 +1416,9 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
>   * touch the LNKCTL register. Also note that this does not enable states
>   * disabled by pci_disable_link_state(). Return 0 or a negative errno.
>   *
> + * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
> + * PCIe r6.0, sec 5.5.4.
> + *
>   * @pdev: PCI device
>   * @state: Mask of ASPM link states to enable
>   */
> @@ -1432,6 +1435,9 @@ EXPORT_SYMBOL(pci_enable_link_state);
>   * can't touch the LNKCTL register. Also note that this does not enable states
>   * disabled by pci_disable_link_state(). Return 0 or a negative errno.
>   *
> + * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
> + * PCIe r6.0, sec 5.5.4.
> + *
>   * @pdev: PCI device
>   * @state: Mask of ASPM link states to enable
>   *
> -- 
> 2.43.2
> 

