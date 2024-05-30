Return-Path: <linux-pci+bounces-8072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880748D46E0
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 10:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39211283FA2
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 08:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED5814B967;
	Thu, 30 May 2024 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfU1jynA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBB914A615;
	Thu, 30 May 2024 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057096; cv=none; b=S2PZgwuRRbbnWirqlW1l26BSdrVTk/tkjs/CjpKuM8WXMMzMuQxuc6fNpMXLu90Y53mhOkzyrgrV8AjZx0dN0qD403GGbYJfRLItlexTxkLaXrsyG/gnyf3PcuwulT64TOMr/s/nzSNWQRmsQDOSfN4o2BdUUVosi36bUBldoD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057096; c=relaxed/simple;
	bh=LLoCHtazLklqSTo51kZD1rOstdZdBmD8nkBBghMcTi4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=CJU5yYlQjHoDGEQxR8gl2py1CD9d3aVI95StekMcd84uE73nL0wbcb5csfN7iLrjUQbCUAjLDHLAWdxqKshh5t1ZB8yBnXv2J00Pz4E7D/h5eVXJpgpDX/TihdNx5vZSBeHgAgUUcAkdVJ6vT9Erh9ra2FuoyrUHLR2cnTpVEBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfU1jynA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1FEC2BBFC;
	Thu, 30 May 2024 08:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717057096;
	bh=LLoCHtazLklqSTo51kZD1rOstdZdBmD8nkBBghMcTi4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=BfU1jynABdejcfPhHA29dQ+oPfGqOdMCRhwsYiCuOTSAI57JG6/7ULl25M79r3U2I
	 E8P7k8piRx5OYN2BMivUHzX80VgYR4fASP2JFI7GYBPbZkmQnXA/OFrCtS4lZpfCTa
	 oGV/SOVfbmyZe6Rgdm/ZfhW78oSeWxEEvUSEB9KadvOEMMsTH9xrt82Nu4MZl+/aEQ
	 VLJCqrdKRyx+ZZGP7oLhuIBGlQVAj4jINQ/ghGJwTgwD7y9KNL48MMANpHyV6pOpom
	 BfjikRWj9tXRbCykmUSeEQMIyhsAAsFeOEzozOdzgB8d3qPxCvStsIxt0TmdWaqihx
	 60pJTNBqYkwlw==
From: Kalle Valo <kvalo@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,  Bjorn Helgaas <bhelgaas@google.com>,
  <linux-wireless@vger.kernel.org>,  <ath11k@lists.infradead.org>,
  <regressions@lists.linux.dev>,  Jeff Johnson <quic_jjohnson@quicinc.com>,
  <linux-kernel@vger.kernel.org>,  <linux-cxl@vger.kernel.org>,
  <linux-pci@vger.kernel.org>
Subject: Re: [regression] BUG: KASAN: use-after-free in
 lockdep_register_key+0x755/0x8f0
References: <87v82y6wvi.fsf@kernel.org> <87wmncwqxf.fsf@kernel.org>
	<87sexzx02f.fsf@kernel.org>
	<66582bee45da8_6ec329496@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<87jzjbwxin.fsf@kernel.org>
Date: Thu, 30 May 2024 11:18:12 +0300
In-Reply-To: <87jzjbwxin.fsf@kernel.org> (Kalle Valo's message of "Thu, 30 May
	2024 10:48:32 +0300")
Message-ID: <87frtzww57.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Dan Williams <dan.j.williams@intel.com> writes:
>
>> Kalle Valo wrote:
>>
>>> Kalle Valo <kvalo@kernel.org> writes:
>>> 
>>> > Kalle Valo <kvalo@kernel.org> writes:
>>> >
>>> >> Yesterday I run our ath11k regression tests with v6.10-rc1 and our
>>> >> simple ath11k module reload stress started failing reliably with various
>>> >> KASAN errors. The test removes and inserts ath11k and other wireless
>>> >> modules in a loop. Usually I run it at least 100 times, some times even
>>> >> more, and no issues until yesterday.
>>> >>
>>> >> I have verified that the last wireless-next pull request (tag
>>> >> wireless-next-2024-05-08) works without issues and v6.10-rc1 fails
>>> >> always, usually within 50 module reload loops. From this I'm _guessing_
>>> >> that we have a regression outside wireless, most probably introduced
>>> >> between v6.9 and v6.10-rc1. But of course I cannot be sure of anything
>>> >> yet.
>>> >>
>>> >> I see different KASAN warnings and lockdep seems to be always visible in
>>> >> the stack traces. I think I can reproduce the issue within 15 minutes or
>>> >> so. Before I start bisecting has anyone else seen anything similar? Or
>>> >> any suggestions how to debug this further?
>>> >>
>>> >> I have included some crash logs below, they are retrieved using
>>> >> netconsole. Here's a summary of the errors:
>>> >>
>>> >> [ 159.970765] KASAN: maybe wild-memory-access in range
>>> >> [0xbbbbbbbbbbbbbbb8-0xbbbbbbbbbbbbbbbf]
>>> >> [  700.017632] BUG: KASAN: use-after-free in lockdep_register_key+0x755/0x8f0
>>> >> [ 224.695821] BUG: KASAN: slab-out-of-bounds in
>>> >> lockdep_register_key+0x755/0x8f0
>>> >> [ 259.666542] BUG: KASAN: slab-use-after-free in
>>> >> lockdep_register_key+0x755/0x8f0
>>
>> The proposed fix for that is here:
>>
>> http://lore.kernel.org/r/66560aa9dbedb_195e294b0@dwillia2-mobl3.amr.corp.intel.com.notmuch
>
> I get "Not Found" from that link, is there a typo?

I found this fix from for-linus branch:

# PCI: Fix missing lockdep annotation for pci_cfg_access_trylock()for-linus
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=for-linus&id=f941b9182c54a885a9d5d4cfd97af66873c98560

But at least that doesn't fix my crash.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

