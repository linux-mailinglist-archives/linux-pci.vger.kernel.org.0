Return-Path: <linux-pci+bounces-32783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3727CB0EAEF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 08:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E6B1C823C6
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 06:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CB826FA5E;
	Wed, 23 Jul 2025 06:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6JtxCOy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBEC26FA58;
	Wed, 23 Jul 2025 06:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253270; cv=none; b=FK6VsngzkL8diGQcOMulkFo00hXGPru2UgXz/yXv7UMnvqdNcvaAuBiWxBPoQbeBflUvw4mtyEbPZ2igsS0OoC/6U2KNkaJ6fBTd/TSV5YIiCSwGxv+Pgk6+3KJiaNppGhv06ytnycckFu1OmLQOMZLoEiapZ4PFt6K9SAbLfXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253270; c=relaxed/simple;
	bh=7zkhMiynmV7ttrTgKe2oO/0dCFzwTwF9NlgqRU5gQRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ribUil42PqJSMrLkPVCKUxGFdeDen4CvsFyD++U+hMG4NkgBSjV4TQZZbez62M6jvkXMf6NqPraQqoL+MyfPfs8qnTiESzE9vDMHChhJan3AwSSbz6t8U/3hw+P5dh2k7d3/iS66uv6hU+A881S237PEwmKg+VS4vAuD2dNDicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6JtxCOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB94C4CEE7;
	Wed, 23 Jul 2025 06:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753253270;
	bh=7zkhMiynmV7ttrTgKe2oO/0dCFzwTwF9NlgqRU5gQRU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f6JtxCOyTOCTAV0joAoGB9qRuxnyFsqVAyxJMOhwpH1lTZ44qqjv23vjn+8pfYXXP
	 1tCg2zSptxXTP0T6B9Z79B+RSDLY1LmSMV325PJcauJMWbPPgGrgfZ4/xNv6XF3/fB
	 as2omzTgBEYuUEFIRq1pMDwRmUSQMF9UETYLXHPTZM6BAz0way/OBw7/rQIX9VIV4l
	 IP41IQrbrVVyE5bKN+41+fbtnfbiab7c2U5TbcoTPVPfZY19Hv8j0uufOV3zmR1FUD
	 3D4hv5gBBiRIK3FDxINoCNOscJ0LEGkxxrcqcgKIsWjMic/3xUN/gsmM8LmzZyrSix
	 yCk5bKR/5DM3A==
Message-ID: <4ee9c7c0-4a3f-4afa-ae5a-7fd8a750c92b@kernel.org>
Date: Wed, 23 Jul 2025 08:47:46 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci/controller: Use dev_fwnode()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Nam Cao <namcao@linutronix.de>
References: <20250722232005.GA2863060@bhelgaas>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250722232005.GA2863060@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23. 07. 25, 1:20, Bjorn Helgaas wrote:
> On Tue, Jul 22, 2025 at 08:24:26AM +0200, Jiri Slaby wrote:
>> On 21. 07. 25, 19:08, Bjorn Helgaas wrote:
>>> Jiri, question for you below about more possible drivers/pci/
>>> conversions to use dev_fwnode() for struct device * cases.
>>
>> Sorry, I am a way too occupied :/.
>>
>>> Would like to get this in for v6.17 if these should be changed.
>>
>> It's not necessary, but a good to have cleanup (opposed to the posted fixes,
>> which were required). I will switch those eventually, but I don't promise
>> 6.17. (If someone does not beat me to it.)
> 
> It's not clear from the commit log:
> 
>    irq_domain_create_simple() takes fwnode as the first argument. It can be
>    extracted from the struct device using dev_fwnode() helper instead of
>    using of_node with of_fwnode_handle().
> 
>    So use the dev_fwnode() helper.
> 
> why the posted fixes are required (other than Arnd's change to
> altera_pcie_init_irq_domain(), which fixes an unused variable warning
> when CONFIG_OF is not enabled).

Sorry, my bad. These are a cleanup suggested in this series:
https://lore.kernel.org/all/4bc0e1ca-a523-424a-8759-59e353317fba@kernel.org/

I.e. series switching from irq_domain_add_*() (take of_node) to 
irq_domain_create_*() (take fwnode).

These days, fwnode is preferred and if there were no more users of 
of_node in changed functions, the series above even produced warnings 
(Arnd's and others' fixes).

> Since it sounds like no changes are required for the other ones I
> mentioned, I'm going to leave them alone for now:
> 
>    dw_pcie_allocate_domains()
>    mobiveil_allocate_msi_domains()
>    altera_allocate_domains()
>    mtk_pcie_allocate_msi_domains()
>    xilinx_pl_dma_pcie_init_msi_irq_domain()
>    nwl_pcie_init_msi_irq_domain()
>    plda_allocate_msi_domains()

Given fwnode is always used them, it's not necessary to use 
dev_fwnode(). But it'd be a nice cleanup. Provided the list, I started 
the cleanup now :).

thanks,
-- 
js
suse labs

