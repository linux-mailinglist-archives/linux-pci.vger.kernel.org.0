Return-Path: <linux-pci+bounces-8068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B05B8D45A3
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 08:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915301F2297F
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 06:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FC115A86F;
	Thu, 30 May 2024 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1w9TYqL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0CA3207;
	Thu, 30 May 2024 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052012; cv=none; b=F0UMp9WQBysl75EdcaAM0SCKY/nIUMCs9qfOZ83ppafl/7xU9MY+EV6+q0k9Af/+s/RG+lJdaCkWEcBJzTR5oC47H3gsSpWF43fkG7QjiCVIaFcwyjlzM1wEt2YbpoyfPy3FBCZgBG1eRovoBWVBtnI1en6yfoTLemcPA0c40fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052012; c=relaxed/simple;
	bh=YivRkEe7rYoBFKl0+BZR93LLEk9IpGONpZAKzglbHXs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Cf34nNYBDLjNA3BnutkTTYtH+2epcV4pgB0+TeNVbpR3nm4pmsmLYWILTsmRkBzcK31pWC79rsgxWnFjHFnwYs6paeTtx5wQIQAHLwStXMhfTMnOLSxuOQOf0FiUKUCVbkwgLErLEbAfC33SjK//3P655td74D+FNUFgjLNVIs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1w9TYqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ACBC32782;
	Thu, 30 May 2024 06:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717052012;
	bh=YivRkEe7rYoBFKl0+BZR93LLEk9IpGONpZAKzglbHXs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=h1w9TYqLc+EMav3BOhfGxWUcC9ah2ZK/gIrpZw7dlayxFXTfzLiAs7mB7mojy82Wy
	 +JjpG8pjv/s9Qjfo9WkxaiDLVkg6lFKdSc1exbqRKXtLB9TEeUPsQR4WIzkAMKXbK4
	 hW2+I7t9G2SeXmL9aIAo46aiZpLeuhx/GlkIPfnCkgN924TRZSdAiK3JL9L/8Hhipt
	 JyYGtcSm0YEUgMEbmePfHq/IigYiEwH7O5y2Lb9RX4uBrFahCrkjb24Vzv6cKgYZtC
	 oFgA3k+KYvHpxTLQ0hbpimm43aoByP+sxqOFX28mqwn90h9dssQ0MR/mtjY+3v7J+J
	 W3c3rbzZ5ck4Q==
From: Kalle Valo <kvalo@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-wireless@vger.kernel.org,  ath11k@lists.infradead.org,
  regressions@lists.linux.dev,  Jeff Johnson <quic_jjohnson@quicinc.com>,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [regression] BUG: KASAN: use-after-free in
 lockdep_register_key+0x755/0x8f0
References: <87v82y6wvi.fsf@kernel.org> <87wmncwqxf.fsf@kernel.org>
Date: Thu, 30 May 2024 09:53:28 +0300
In-Reply-To: <87wmncwqxf.fsf@kernel.org> (Kalle Valo's message of "Wed, 29 May
	2024 18:58:36 +0300")
Message-ID: <87sexzx02f.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Kalle Valo <kvalo@kernel.org> writes:
>
>> Yesterday I run our ath11k regression tests with v6.10-rc1 and our
>> simple ath11k module reload stress started failing reliably with various
>> KASAN errors. The test removes and inserts ath11k and other wireless
>> modules in a loop. Usually I run it at least 100 times, some times even
>> more, and no issues until yesterday.
>>
>> I have verified that the last wireless-next pull request (tag
>> wireless-next-2024-05-08) works without issues and v6.10-rc1 fails
>> always, usually within 50 module reload loops. From this I'm _guessing_
>> that we have a regression outside wireless, most probably introduced
>> between v6.9 and v6.10-rc1. But of course I cannot be sure of anything
>> yet.
>>
>> I see different KASAN warnings and lockdep seems to be always visible in
>> the stack traces. I think I can reproduce the issue within 15 minutes or
>> so. Before I start bisecting has anyone else seen anything similar? Or
>> any suggestions how to debug this further?
>>
>> I have included some crash logs below, they are retrieved using
>> netconsole. Here's a summary of the errors:
>>
>> [ 159.970765] KASAN: maybe wild-memory-access in range
>> [0xbbbbbbbbbbbbbbb8-0xbbbbbbbbbbbbbbbf]
>> [  700.017632] BUG: KASAN: use-after-free in lockdep_register_key+0x755/0x8f0
>> [  224.695821] BUG: KASAN: slab-out-of-bounds in lockdep_register_key+0x755/0x8f0
>> [  259.666542] BUG: KASAN: slab-use-after-free in lockdep_register_key+0x755/0x8f0
>
> I did a bisect and got this:
>
> cf29111d3e4a9ebe1cbe2b431274718506d69f10 is the first bad commit
> commit cf29111d3e4a9ebe1cbe2b431274718506d69f10
> Merge: ed11a28cb709 e6f7d27df5d2
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu May 16 18:14:11 2024 -0500
>
>     Merge branch 'pci/of'
>     
>     - Check for kcalloc() failure and handle it gracefully (Duoming Zhou)
>     
>     * pci/of:
>       PCI: of_property: Return error for int_map allocation failure
>
>  drivers/pci/of_property.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> But that doesn't make any sense to me, I don't even have
> CONFIG_PCI_DYNAMIC_OF_NODES enabled in my .config. I guess I did a
> mistake during bisect, I'm now testing the parents (e6f7d27df5d2 and
> ed11a28cb709) and trying to pinpoint where I did it wrong.

I found my mistake and was able to finish the bisect. This seems to be
the commit causing my problems:

# first bad commit: [7e89efc6e9e402839643cb297bab14055c547f07] PCI: Lock upstream bridge for pci_reset_function()

I verified by reverting that commit on top of v6.10-rc1 and I have not
seen any crashes so far, normally I would have seen it by now. But I
will continue testing the revert just to be sure.

Adding people and lists involved with that commit. Here is my original
report:

https://lore.kernel.org/all/87v82y6wvi.fsf@kernel.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

