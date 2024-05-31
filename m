Return-Path: <linux-pci+bounces-8133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B618D6737
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 18:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD1B1C24FC5
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 16:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DBA17C7B4;
	Fri, 31 May 2024 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMZmCS90"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E4158204;
	Fri, 31 May 2024 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174057; cv=none; b=ne1wMzS226Zx4oqivCo3Di86pqM5yOr6auee0skVWgPGrFHeyw5kZA3gCzcl0bNW/plQ5K0ryd6Sl6cdLOnOXEit4wgzLHIMLd+QkunceafTBXFNdCCdvmmgjvjUaqBE+aJ4/y4BlAQCzrCqf6b3I+yFiU3FnqESDfUd2QzvAtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174057; c=relaxed/simple;
	bh=oqcC5FJvmRrpt+Q4bwnChJ2q35ucR7vYxjPB38IK/vk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FrpcuavoZwwWJWwMen1sJQbxuk959IkiUMHXT6UGeaY9OJ9s/uxBuPZtww/gGgZthITMwzgJVe3nz1FruXjF4y88rwALiZT5HpiBDDomsUliH84/bBDCZuS78uYqYFxq/HQ8GczE/OKvCizCYpD5inYQltDwXf1tGYiO9VUHVow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMZmCS90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BF6C116B1;
	Fri, 31 May 2024 16:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717174056;
	bh=oqcC5FJvmRrpt+Q4bwnChJ2q35ucR7vYxjPB38IK/vk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=RMZmCS90hvuAyg69z06WDbLwF228fxxOaWP0skxxUNsRpSZB9dwE7y4Dudwk9FYwk
	 gJyqQUGxNWCRvl9VIOoeGQDfALTKGloW3V94GTEtPUitX3Npki6BuZ0WF8xH8eN0zJ
	 9lX9AQbxRApKCdkRneS9NjCrGstD679r3O8b/5ygm2qPM6WOsTe6KjkPO93BtFhTu2
	 Bd6+BI/6RVeoMdCCN9nGCJ0MDDHSuZnhmwoldG0u+3iQvWsSYVLX7G7zKBQWfw9uaJ
	 h1qU9jOBj5zlPOdKnFoWc09uooaj4qj+285mcZ+yhLL42LIs4OKqllYoBiMzEkkpEU
	 +fp30/koV94Uw==
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
	<87jzjbwxin.fsf@kernel.org> <87frtzww57.fsf@kernel.org>
	<6659ee8b8dfd_166872941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Date: Fri, 31 May 2024 19:47:32 +0300
In-Reply-To: <6659ee8b8dfd_166872941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	(Dan Williams's message of "Fri, 31 May 2024 08:36:43 -0700")
Message-ID: <87y17qudwb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> Kalle Valo wrote:
> [..]
>> >> The proposed fix for that is here:
>> >>
>> >> http://lore.kernel.org/r/66560aa9dbedb_195e294b0@dwillia2-mobl3.amr.corp.intel.com.notmuch
>> >
>> > I get "Not Found" from that link, is there a typo?
>> 
>> I found this fix from for-linus branch:
>> 
>> # PCI: Fix missing lockdep annotation for pci_cfg_access_trylock()for-linus
>> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=for-linus&id=f941b9182c54a885a9d5d4cfd97af66873c98560
>> 
>> But at least that doesn't fix my crash.
>
> Sorry for the broken link I mistakenly used a message-id from an
> internal thread with the intel.com reporter. However, it is moot now
> because the new direction is to revert the lockdep infrastructure:
>
> https://lore.kernel.org/r/171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com
>
> (that link works...)

Thanks, that links works :) I did a quick test with the three patches
and I didn't see any crashes anymore. But to be confident I need to run
overnight tests, I'll provide my Tested-by after that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

