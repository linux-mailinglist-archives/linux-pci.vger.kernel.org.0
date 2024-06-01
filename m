Return-Path: <linux-pci+bounces-8155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C50288D6EEB
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 10:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5E71F23551
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 08:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F121CF8D;
	Sat,  1 Jun 2024 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmu1TjfA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A3A111AD;
	Sat,  1 Jun 2024 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717231148; cv=none; b=cQY6NzaupyTE6Q/UjB/DmXe4Sxv38WCU/DmjJPHDzzwMCtX53JNKjyshkgrq6erx8IIkv5eCSHUsWZecIAEFE5Zh0q7ZwXHBHvvu8ZkPIt9o6WJJRsOA1EY4E4TXVLjgI/fODzZLK9NJqNPIkYzg9KIdcKna4rVOpxXSItvg0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717231148; c=relaxed/simple;
	bh=O/cdpqT7qQihzPF3SYw3ffdjHn+vpQtcKKcbKkl2pXA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kPMjfVF7AfmyANxGiWWWBMdLV9cjXmhgIoK0JUwEqx214EJHFhvY80nbhsQPd+NaaEGzN2fR9Mc5VNHqq06p3KYwjGa9+w3dCF1H/OULDoKLqux4rFSPhpipuCC3K9Aw+NVq4QA7Gu9VEIWVCF0qL3upoRA/6BzqlqQxD4UjSBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmu1TjfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288E7C116B1;
	Sat,  1 Jun 2024 08:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717231147;
	bh=O/cdpqT7qQihzPF3SYw3ffdjHn+vpQtcKKcbKkl2pXA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=lmu1TjfAQQoBYhj/5tR7GS0uOuhgynxe5b8eTTxihKbYlFz9EB9BuMaGLeDxzIuQa
	 mPL1IUU24/j5KmRP7KUBe0uI7vvIS6NVX7i9Q3YerbU/Z3NPTj8MbRbneAyrTD41Ns
	 +xyUGP2pdDwyiS94iYPHYOSWOYwFHr7xM9UMtWUFO20gz1EReopk8uHvol1NzPcobS
	 lXYgd7nVOP7X8rb7cioKPkC2YQf1lIqdQPk4zPN5OLa/2Lr1c36cwTmNHFEp2BQ09M
	 Y6twVXL/tNg4qPu0VP9NjAWJCRtariHmDydaylbZd8zwK+h2jqVm/2nG+pUQt5shpx
	 JDfaxnwZkCo2g==
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
	<87y17qudwb.fsf@kernel.org>
Date: Sat, 01 Jun 2024 11:39:03 +0300
In-Reply-To: <87y17qudwb.fsf@kernel.org> (Kalle Valo's message of "Fri, 31 May
	2024 19:47:32 +0300")
Message-ID: <87a5k5ukew.fsf@kernel.org>
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
>> [..]
>>> >> The proposed fix for that is here:
>>> >>
>>> >> http://lore.kernel.org/r/66560aa9dbedb_195e294b0@dwillia2-mobl3.amr.corp.intel.com.notmuch
>>> >
>>> > I get "Not Found" from that link, is there a typo?
>>> 
>>> I found this fix from for-linus branch:
>>> 
>>> # PCI: Fix missing lockdep annotation for pci_cfg_access_trylock()for-linus
>>> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=for-linus&id=f941b9182c54a885a9d5d4cfd97af66873c98560
>>> 
>>> But at least that doesn't fix my crash.
>>
>> Sorry for the broken link I mistakenly used a message-id from an
>> internal thread with the intel.com reporter. However, it is moot now
>> because the new direction is to revert the lockdep infrastructure:
>>
>> https://lore.kernel.org/r/171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com
>>
>> (that link works...)
>
> Thanks, that links works :) I did a quick test with the three patches
> and I didn't see any crashes anymore. But to be confident I need to run
> overnight tests, I'll provide my Tested-by after that.

Ok, I'm now quite confident that the issues I saw are solved so:

Tested-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

