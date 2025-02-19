Return-Path: <linux-pci+bounces-21835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F15A3C7C1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 19:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17703A9129
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6E51FCF57;
	Wed, 19 Feb 2025 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8Yxd6Fa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064C71B6CF5;
	Wed, 19 Feb 2025 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990067; cv=none; b=e+FkCKnYr+++rectbxW5qkcpnbThIbcCF8/AALoTplELnS93fkDXLhLcG0rdkMw8yMB07lvo3cxATuw3ebju8VdkdcdHDw8ksHISHmHSwF9huC5yAkI7HbE2brL4syH9j2hSUG3HYg0WFr05U5Uwv6PImCyJqtyuM5OJ+ok+v+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990067; c=relaxed/simple;
	bh=+Gr+W2xAk5kXofwASKJV74AOXYxt+u2fVkdtmo2iq4c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=vB0eqlmZDqVPeAGlNb+Esm+aO32v/Bo6WnlMrwcq0yrHaTu08M/N7nwTencziMZpNpJKuSNH2cUnuAQWfO/H3Z8h/9xL8cBUgdNugMGMc2mMQrmMMS/t+ja4toMSEh+E0XhBA7qrfLQ6opYznCeXzNyYuVXcjga+LXBixT+da4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8Yxd6Fa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52518C4CED1;
	Wed, 19 Feb 2025 18:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739990066;
	bh=+Gr+W2xAk5kXofwASKJV74AOXYxt+u2fVkdtmo2iq4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=V8Yxd6FaXP00CWUeQjcORtvaAd/A7zAI398we8dMQTCDRfYcaaPyAl9JJy9vndVpu
	 pL8WLa+nhsq0zsF/38OgxFK42CyEj00rhhXiC6FRmLd4Uv+5bikg8S2zmGYBAl5058
	 gifYePgTAvdYttlOxHOrTQNvV/ipNek/bmsYzV3k43xhnKYpDfZmFKHZNGSzHiheWf
	 RE5buoc1+lPE/NsWss+Q/LSK0e96MnipaIj8D3fi7JvkCQ9IiDBqgJpCX9qLsnnMRq
	 7lGSbni8ZgQ6IA2q59sqsrMfkeGqlx9cNF/8RYHpDsGGIbuKZcLsZ1RvoMpF3Ori26
	 i+kHtVtHo5mFQ==
Date: Wed, 19 Feb 2025 12:34:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Cc: bhelgaas@google.com, christian.koenig@amd.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Update Resizable BAR Capability Register fields
Message-ID: <20250219183424.GA226683@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219022712.276287-1-daizhiyuan@phytium.com.cn>

On Wed, Feb 19, 2025 at 10:27:12AM +0800, Zhiyuan Dai wrote:
> PCI Express Base Spec r6.0 defines BAR size up to 8 EB (2^63 bytes),
> but supporting anything bigger than 128TB requires changes to pci_rebar_get_possible_sizes()
> to read the additional Capability bits from the Control register.
> 
> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
> ---
>  drivers/pci/pci.c             | 14 ++++++++++----
>  include/uapi/linux/pci_regs.h |  3 ++-
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 661f98c6c63a..8903deb2d891 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3752,12 +3752,13 @@ static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
>   * @bar: BAR to query
>   *
>   * Get the possible sizes of a resizable BAR as bitmask defined in the spec
> - * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizable.
> + * (bit 0=1MB, bit 43=8EB). Returns 0 if BAR isn't resizable.
>   */
> -u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
> +u64 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)

Callers need to be updated so they're prepared for a u64 instead of a
u32.

If you don't actually need sizes bigger than 128TB right now, it's
fine to keep this as a u32, only add support up to 128TB, and leave
the >128TB support for later.

Bjorn

