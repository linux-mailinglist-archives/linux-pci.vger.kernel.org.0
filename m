Return-Path: <linux-pci+bounces-27182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12336AA9AB9
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 19:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7852C168232
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333A126F46B;
	Mon,  5 May 2025 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="il761Ze+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3C726F461
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466413; cv=none; b=pQOGJFNLy2bdr7zr9JQju7PbzGBRnYpfJ7yKzmuJL1+LmllklttqP/TbOTVk80xmkNI9RFBbFKrJovEkp4WYSshwksqAXaGQMneT5iwB8A+KySmXuCOYN7HlZSNI9J8ACpcoQg/ZWvaYYleD+NCSeGMY8p/6CsKaAdRy4LfU/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466413; c=relaxed/simple;
	bh=A29R2zqGY5QIZy6gzFWvfQJONPdySnmxK8Gn5tA/uNc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TtEgCcmZlMbzfsuFnIuLUE73B7U9eUWS8TT7GVIBJ6IQN1Pgth9UwZgq2CqnWkAisZ1fBtnJqHmRqyFfeAO8qvRwpubXytmGwigPhFol38wsntfaRkwZ0a/p8LXC4xp5iI3PBg6uB4CE+zlD+eVnJFgVOLNbqCEJ2m21dlvDM0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=il761Ze+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2424C4CEEF;
	Mon,  5 May 2025 17:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746466412;
	bh=A29R2zqGY5QIZy6gzFWvfQJONPdySnmxK8Gn5tA/uNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=il761Ze+vlzrKCmODQ6YcZHIWyWC18tdyJkEUNCu/1pgMWDED/7SsfJIPn8tKUAf6
	 u5bsNX6BwaFSOoB1nYzaTRqEGW68X2Z0mzBd/SuVEjsxpgt2dKMqLApPmbqhke3LzN
	 niZVYOLljZzsNKKtyggJBT85NYxxp/wV2zwIfWuA0GJ1iY0bEzlNemkPURQdoxqVYj
	 tkZYrMYDTatAg7DKr7RqN0Cmtj/GnZQvxPASrgTCLaIfu68Wpk7zbcBr29FJJ9pVoP
	 CPdkkGlbwHTaLyzsQYlPQVgjSYRGAsA4nS2vd1g5/K8WISMlQkbImmh9VCYeITudJq
	 RWdxKB/JTwRVg==
Date: Mon, 5 May 2025 12:33:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Szymon Durawa <szymon.durawa@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: Re: [PATCH v3 5/8] PCI: vmd: Replace hardcoded values with enum and
 defines
Message-ID: <20250505173331.GA985055@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122085215.424736-6-szymon.durawa@linux.intel.com>

On Fri, Nov 22, 2024 at 09:52:12AM +0100, Szymon Durawa wrote:
> Add enum vmd_resource type to replace hardcoded values. Add defines for
> vmd bus start number based on VMD restriction value. No functional
> changes.
> 
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 42 ++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 24ca19a28ba7..1cd55c3686f3 100755
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -23,6 +23,10 @@
>  #define VMD_MEMBAR1	2
>  #define VMD_MEMBAR2	4
>  
> +#define VMD_RESTRICT_0_BUS_START 0
> +#define VMD_RESTRICT_1_BUS_START 128
> +#define VMD_RESTRICT_2_BUS_START 224

Oh, you added this in this series!  I assumed they were already there.
Please convert these to hex.

