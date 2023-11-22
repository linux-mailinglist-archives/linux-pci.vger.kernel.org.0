Return-Path: <linux-pci+bounces-132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 299F17F4B83
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 16:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599711C209D3
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D8A56B79;
	Wed, 22 Nov 2023 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ux6qRL+E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646B56B72
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 15:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C26FC433C7;
	Wed, 22 Nov 2023 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700668085;
	bh=2D1FCAFapTYVgd9jQdUc8n6yGO0VVfuTIDKekhJKyM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ux6qRL+E6scgXFBdtIWFLAUhpZXtTNPWZiqzgAd5vwfput4l8y9Gwlwz0l8tIJMgN
	 HYZjuA1It0DMpQJZQCo4lgkTndyw2rEw78xsMz84hHEvKaYscW+HgXN4gloLzPMQ/L
	 B5WQT/wxT5wtTT5l/ajZZT8GfQlus90GVtNc01I6GXsGIr9aN+QFPpQvpIENQZkEm+
	 LAoWdR56jx4eXDpKTcR0+M1m393zYfFyo8OcxNoMcIjn+AzpmdD4poNVAIyXHP8IVR
	 8EtiuYosrRn921MmMJLxryfCsq7U8Mv+XBcpGNl/+s3M0HoQCW9RX4Ba2SIzdntWei
	 K08ll2tD1Qq0A==
Date: Wed, 22 Nov 2023 09:48:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Stodden <dns@arista.com>
Cc: Dmitry Safonov <dima@arista.com>, Logan Gunthorpe <logang@deltatee.com>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/1] PCI: switchtec: Fix stdev_release() crash after
 surprise hot remove
Message-ID: <20231122154803.GA300183@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122042316.91208-1-dns@arista.com>

On Tue, Nov 21, 2023 at 08:23:15PM -0800, Daniel Stodden wrote:
> Changes since v3:
>  * Restart from upstream f9724598e29df3acfcf5327df11aae2aba1b7f61
>  * Add missing pci_dev_put() to stdev_create()'s failure path.
>  * Reviewed-by: Dmitry Safonov <dima@arista.com>
> 
> Thanks for the patience.
> Daniel
> 
> Daniel Stodden (1):
>   PCI: switchtec: Fix stdev_release() crash after surprise hot remove
> 
>  drivers/pci/switch/switchtec.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)

Thanks for the v4, I replaced the v3 patch, so this is on the
"switchtec" branch for v6.8.

