Return-Path: <linux-pci+bounces-1394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8425681EAD5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 01:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490E02832AF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 00:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0823622;
	Wed, 27 Dec 2023 00:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSiZLD5Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9176D5384;
	Wed, 27 Dec 2023 00:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34E4C433C7;
	Wed, 27 Dec 2023 00:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703635286;
	bh=QD6esAQC2zUHMhdcnID2iNc0cTpprT0pIKR+PaI0cRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nSiZLD5QD83Yy6uWll+7uVy99sjqNnEuLgMgpABkq6i3uMWNPE3XB3QOikJFnc/fh
	 9RuiSoI1eCn2DvOWLvslq20tdKiwOvJ45MO8ydwM6FRAM3krPe6ZQAHwPPFz5AUo3m
	 6kMOCWM0HYuYNqTCewW/7Ue41tgh6SjCPRw9Eyu4GcJ3TsxYZgozV4PvpJcjhb3ROz
	 TS89+/k8ZuYRr2lWCrcYT/G3kPvn5r55BGnAFievDz7kvA/LHE30rZa/oPpMQSECy0
	 PPzrb+8XBEXGFzYCxkSMx1hNEt7WmWnjjtsex4+HjzxxjLQAny7ZzkbjKkR6t4Zsva
	 mW1OYKrmCLBdQ==
Date: Tue, 26 Dec 2023 18:01:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>, linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	SHA-cyfmac-dev-list@infineon.com,
	brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH] PCI: Remove unused 'node' member from struct pci_driver
Message-ID: <20231227000124.GA1484252@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220133505.8798-1-minipli@grsecurity.net>

On Wed, Dec 20, 2023 at 02:35:05PM +0100, Mathias Krause wrote:
> Remove the unused 'node' member. It got replaced by device_driver
> chaining more than 20 years ago in commit 4b4a837f2b57 ("PCI: start to
> use common fields of struct device_driver more...") of the history.git
> tree.
> 
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>

Applied with Kalle's ack to pci/misc for v6.8, thanks!

> ---
> There is only one "user" that makes use of the 'node' member, which is
> the brcm80211 driver. However, its "use" is clearly wrong (a list head
> cannot be initialized this way) and, obviously, not needed.
> 
> If netdev folks instead want to split this off into a separate commit, I
> can do that. However, I don't expect any cross-tree conflicts regarding
> this change.
> 
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 1 -
>  include/linux/pci.h                                     | 2 --
>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index 80220685f5e4..d7fb88bb6ae1 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -2707,7 +2707,6 @@ MODULE_DEVICE_TABLE(pci, brcmf_pcie_devid_table);
>  
>  
>  static struct pci_driver brcmf_pciedrvr = {
> -	.node = {},
>  	.name = KBUILD_MODNAME,
>  	.id_table = brcmf_pcie_devid_table,
>  	.probe = brcmf_pcie_probe,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index dea043bc1e38..835a937fd233 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -885,7 +885,6 @@ struct module;
>  
>  /**
>   * struct pci_driver - PCI driver structure
> - * @node:	List of driver structures.
>   * @name:	Driver name.
>   * @id_table:	Pointer to table of device IDs the driver is
>   *		interested in.  Most drivers should export this
> @@ -940,7 +939,6 @@ struct module;
>   *		own I/O address space.
>   */
>  struct pci_driver {
> -	struct list_head	node;
>  	const char		*name;
>  	const struct pci_device_id *id_table;	/* Must be non-NULL for probe to be called */
>  	int  (*probe)(struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
> -- 
> 2.39.2
> 

