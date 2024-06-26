Return-Path: <linux-pci+bounces-9319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDC29185B5
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 17:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95596288A99
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 15:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A4E18C331;
	Wed, 26 Jun 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dH/RABsC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B593418C326;
	Wed, 26 Jun 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415585; cv=none; b=dMxEnoHTlaQV5t4fPTBNVB1Dvl+eQ/zZdlgb0Yyw28X+uuWpdI2W9FT1nUFgGHoLhQITFh/2o6WwuMIPRF5x7AvZTT4A8PZajkHKTC2+LxDJAMwld0UllaaLJEMBk5gErieLk+/siSaTgK+LX/FYA95Lg7NBOJt4fzypnNMGXNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415585; c=relaxed/simple;
	bh=Vjs7X7CFQfPv2HEkHqohvw8nbnwTWiGv/wBrtk9rY9o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XOhIR3G1+KkQH3Wli0vjo0KHCQ0l0xscl1KG5oETwKTsuNG2t38VsogwTPdprqKBqiiUvjQXQ+m++KVDjuLYVwfxJ/riUpa5Z3zwGM+6N+pO01MC2WJgOobbZgDa/XgxkBTE96nlzy8orz3+5uM/qO3u5cJLznTWpR4O2Q7j25g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dH/RABsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A14C32782;
	Wed, 26 Jun 2024 15:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719415585;
	bh=Vjs7X7CFQfPv2HEkHqohvw8nbnwTWiGv/wBrtk9rY9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dH/RABsCM+va5O/7sr3s/Ukr/CWf+sJNt8VNd7EwxmXXbJTkWtxs39lZsuNde8xNY
	 BehY5BqJUnzymMdtf6ZZKi8z25A/Dv/tq7dDG1RGV+Of5T32Y06HC4gDL1vhpafpeE
	 rYUaA0OhgJs/rbTSOJFiGS80+rOhBInUv4g00/0A/6rx8cjvFh0FebY1iqosCljvS8
	 o2lb9IDgrnOPIJelovy6ckxMNBx7NCulPwOoOvkQKSMUVf9K277qH14LT7/NwJ8O7J
	 J/Cs1a/NLIq07X9DhS52hEOSb0r57Qr0vxeyka0QDIScZM/Ce2651B/Q2v5Ywz3Z/Y
	 he2XQ2H/ytxvw==
Date: Wed, 26 Jun 2024 10:26:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>
Cc: lkp@intel.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] [PATCH v2] PCI: Enable io space 1k granularity for
 intel cpu root port
Message-ID: <20240626152623.GA1467429@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626111947.367032-1-zhoushengqing@ttyinfo.com>

On Wed, Jun 26, 2024 at 11:19:47AM +0000, Zhou Shengqing wrote:
> Fix compilation error in drivers/pci/probe.c with commit
> 1f22711375ebe9fc95ced26c7059621c4d59b437
> 
> Changelog:
> v2:
>  - Fixed compilation error(missed changed).

Please post a v3 that is the entire patch including the fix.  Nothing
has been merged yet, so there's no point in making it a separate
commit.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406261735.9Fu2z2ic-lkp@intel.com/
> 
> Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
> ---
>  drivers/pci/probe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 3f0c901c6653..909962795311 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -463,6 +463,7 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
>  	u32 pmem, tmp;
>  	u16 ven_id, dev_id;
>  	u16 en1k = 0;
> +	struct pci_dev *dev = NULL;
>  	struct resource res;
>  
>  	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
> 
> base-commit: 1f22711375ebe9fc95ced26c7059621c4d59b437
> -- 
> 2.39.2
> 

