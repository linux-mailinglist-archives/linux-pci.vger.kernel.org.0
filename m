Return-Path: <linux-pci+bounces-30470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4621AE58E5
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 03:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CC23A5C31
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 01:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D67FC0B;
	Tue, 24 Jun 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQ1viG0V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF79AD2D
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750726821; cv=none; b=hIwlT42qVnDhpJ8fJwJqXQA92hIDfa0E6YYU+KGzKRFxuSeUFpQ/Q4I3WAgQhgFqNYe/6eKQ8VRoj8THinWdu2tKo1krmyMfwlWmQIJEx2xwU926kMjT8hwKtzl0Bv3kv/O5WET1LlFon4ihbPbBauoNf5h/9UQCYwPnTlYm+EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750726821; c=relaxed/simple;
	bh=g01R52Sc8HcOF+ukJFY609flMCXpXy/nB4t4TOO8j9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWhLUiAO/OsQaI6XXV7NfgZO0uxKps2878+jvr0NvlOrUapiKPS6kmJuRbqEQWTXeTSrzDy2MB1pLX+/ahH+nVJDfD4zm5Zj47Bn42owQzwLlS1BNFtPHSHcwo+dIFM0aMc79Ra6xr9l+5TnAYotg8RcMvxBy5SN5ar/+o+5kwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQ1viG0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FC3C4CEEA;
	Tue, 24 Jun 2025 01:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750726819;
	bh=g01R52Sc8HcOF+ukJFY609flMCXpXy/nB4t4TOO8j9E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LQ1viG0VznQeXIPyUoqtE1sFSOfWRA1UHRJApw/OR/B+8SGQFCa6RYAttfvJEwjxU
	 5+so4Wd2bcUtLeTIyOHD52Auv3fIftlY9om5TNCnPufHSFQuPLn9tFdQDaVB8yENcO
	 6GN78WjDzc9OllqaeY38T6kWB0Gt9CAQMCEJ4JbHAwiKPJGuz/AmR/JJyYADGDhN/W
	 kJVCmZvc3gnZlcA4Sx1nStM4SHO1x/bslF2iLDejwMCkOIx+g4SLqzGdH8gOUF6qcp
	 8x7mwuK/+wu1bD8CmwmG8alq3wTBJdbGB/uJc+UzBmmz+Lso2+HICwBlopCkT3Qw9n
	 Gdbu5SGziEupQ==
Message-ID: <d6e06fab-2cb8-4645-93b9-e20a70f2aad1@kernel.org>
Date: Tue, 24 Jun 2025 09:58:14 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: Fix configfs group removal on driver
 teardown
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250617010737.560029-1-dlemoal@kernel.org>
 <aFklrtQTwqKhOl39@ryzen> <011c4c6d-ebff-46e4-b32f-f93eb88dd82d@kernel.org>
 <aFlYCRtF40Y2i7dX@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aFlYCRtF40Y2i7dX@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/25 10:35 PM, Niklas Cassel wrote:
> On Mon, Jun 23, 2025 at 09:01:53PM +0900, Damien Le Moal wrote:
>> On 6/23/25 19:00, Niklas Cassel wrote:
>>>
>>> I think it is a litte bit confusing that you attach a KASAN
>>> splat to a patch that fixes two different bugs.
>>>
>>> Surely this KASAN bug can be fixes with only:
>>>
>>> -     list_del(&driver->epf_group);
>>> +     WARN_ON(!list_empty(&driver->epf_group));
>>
>> Yes, with that, you will not get the KASAN warning, but you will get the
>> WARN_ON() to trigger unless bug #1 is applied first. But if you apply #1 first,
>> then any testing done with that bug fix only will trigger a NULL pointer
>> de-reference on the list_del().
> 
> Ok, let me rephrase :)
> 
> Surely this KASAN bug can be fixed with only:
> 
> -     list_del(&driver->epf_group);
> 
> As the bug is that the code is trying to delete a list head, which is just
> wrong.
> 
> 
> A patch 2/2 could add a list_del() to pci_ep_cfs_remove_epf_group() and the
> WARN_ON() to pci_epf_remove_cfs().
> 
> Considering that pci_ep_cfs_remove_epf_group() also frees the memory for
> the group, I think it is more correct to use list_del() rather than
> list_del_init(), as no one will be able to re-use this group after calling
> pci_ep_cfs_remove_epf_group() on it.

OK. Sending v2.


-- 
Damien Le Moal
Western Digital Research

