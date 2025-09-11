Return-Path: <linux-pci+bounces-35953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D33B4B53D63
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 22:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF4648837A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 20:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2039A2D8379;
	Thu, 11 Sep 2025 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z8Nvya0A"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E96B2D7DD1;
	Thu, 11 Sep 2025 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624306; cv=none; b=aSPhxaSFuSEWLeTXIgJaqU4+1BlzCBYAxrBhc8jKSrFto9XSOWTwoulMTZUde6Z/7K49SR7BnCGtsck4QDuLuEMYtp43/u1+LPZwAKjUizlZzal4Wlgj+Fj32lwl31obLv+sfTiRyg5wR5stAsavqka3tY/FnzqkShFx4jl7+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624306; c=relaxed/simple;
	bh=9xTFYBpfVXgAIAe+xeFobNHCnzAp2klE/GvShxlxQmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGkktsSe4URgDACTNUC80XpHiqjZvIHUBZ7LWp1YT8/iHnrhz8BooVtFpN2AaO0YbS18MjVYPi3o5+sJ/Bnl+P0p2c1AJP8r/1x+huyjvkF8lUFSd6upkoxV1u6b8LNZdO3f861BBpg2eiQYL8d02Ol7EoNoMMVXLO22y2dR+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z8Nvya0A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0qy55m6NltHy97e3BgE53LDGV8tmJEWe7HuI0Fh9fMU=; b=Z8Nvya0A5h9hSajXA7XhLa9YNA
	QznMZ9P5uW4O+XyH9XMxoco14sEFcjkDwyxUJygW9N3DquMGnIX6CPuHYhFFxp+hjeAXvsm/eZWzJ
	oh9q5JXsCQSQnuFocm241p2ZLwpgI+LENLStiQlj9eMaCe29iy8gW2XTTAsw4VEPJg76mIVhcSktQ
	MhzchP7Hbft3zhwnkDSGjCoF25c1SpfIjSDAXI1U60vAMzwAV8EJzka/VlUSFaymc3I/4eadTfkCq
	E2AbrSPZxbho7Gtdtrh8tnL7G77PQTHysIq5t/lf+PGHytQ5vGmyicqgXKIWNv3ala9/xIhf+Xtd7
	/G5j8JXQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwoN4-00000005LTR-0IIn;
	Thu, 11 Sep 2025 20:58:22 +0000
Message-ID: <8be02c33-b659-4999-8408-2bd939009e82@infradead.org>
Date: Thu, 11 Sep 2025 13:58:21 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] PCI: Improve Resizable BAR functions kernel doc
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 ?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
References: <20250911075605.5277-1-ilpo.jarvinen@linux.intel.com>
 <20250911075605.5277-5-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250911075605.5277-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/11/25 12:55 AM, Ilpo Järvinen wrote:
> Fix the copy-pasted errors in the Resizable BAR handling functions
> kernel doc and generally improve wording choices.
> 
> Fix the formatting errors of the Return: line.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/rebar.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
> index 020ed7a1b3aa..64315dd8b6bb 100644
> --- a/drivers/pci/rebar.c
> +++ b/drivers/pci/rebar.c
> @@ -58,8 +58,9 @@ void pci_rebar_init(struct pci_dev *pdev)
>   * @bar: BAR to find
>   *
>   * Helper to find the position of the ctrl register for a BAR.
> - * Returns -ENOTSUPP if resizable BARs are not supported at all.
> - * Returns -ENOENT if no ctrl register for the BAR could be found.
> + *
> + * Return: %-ENOTSUPP if resizable BARs are not supported at all,
> + *	   %-ENOENT if no ctrl register for the BAR could be found.

These 2 lines will run together in the (html) output. They could be
made "prettier" (IMO) into a 2-item list if you choose:

 * Return:
 * * %-ENOTSUPP if resizable BARs are not supported at all
 * * %-ENOENT if no ctrl register for the BAR could be found


>   */
>  static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
>  {

-- 
~Randy


