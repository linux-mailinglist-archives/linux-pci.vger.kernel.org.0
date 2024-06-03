Return-Path: <linux-pci+bounces-8192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658BD8D889A
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 20:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE4CB23676
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 18:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B0F1384B6;
	Mon,  3 Jun 2024 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkZuV1eV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF6132804;
	Mon,  3 Jun 2024 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439393; cv=none; b=gzwqarSgrj82kLq0M690jWVR8HoZdsJOazPJwPkbRfpqk477ReXQi0KcENemIvmnVwwz2Dhd7qRMmuGi3IDHMBN46XDySpbXD5wGvSnFdM3xVphvtUMjOu2lFKjKDFduMobZ6v6T+7qMf7jqEvc8eVDJHbskntfk1n9bwSDjl7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439393; c=relaxed/simple;
	bh=mNhvVNlm7lR5BWW0xTcHRwGUWRDr+XPiKpnaTJtSDTI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=reWDAwotov+xkrZ0wdw74Qk7bMJBlCg8vmnqM7p7YDPxO4z62vJqlGiLOtHTDjIN438CNIbTBLnm8C7n3PEBqssnYBwlQ5Pqil7K/3/YfsSIa9EZHU3FIGzAkVHeH93TjW++S8HPpMsdvKuVi1/bJMgbxnpQzVQubP4iK0ldZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkZuV1eV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECD0C2BD10;
	Mon,  3 Jun 2024 18:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717439392;
	bh=mNhvVNlm7lR5BWW0xTcHRwGUWRDr+XPiKpnaTJtSDTI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OkZuV1eVes1bmZwBJfIiWe1TuYU2eCulaWhDYbIQ6vzMFyaOAD8QPRxLbAyVHL9wa
	 aOkkSIhSzuJEqQBog1tDRdXeLpG0m/VC1G9Om4eLmdkgUqTbgYBXSXgzzzezGrrF0L
	 c2htHuvtT5if3G7uXQRjvkAhGsd9+9OwRi6wvWjUhRMoTbUvhi610iohydI++HjNHe
	 LpcZh2FSschBweqG/H5aKQNvQCEM8ZB9Ic02r9Fb67jykDi82yuxpgetbw8D0rIp/V
	 GTNZSGBtL1yRhYXTQypgCTgnc+OoLITtnoyQnItFbQw6FK/mcgi80sDmAmWTx7rS0H
	 9ignmGxUFxgZQ==
From: Kalle Valo <kvalo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>,  Dave Jiang
 <dave.jiang@intel.com>,  Bjorn Helgaas <bhelgaas@google.com>,
  linux-wireless@vger.kernel.org,  ath11k@lists.infradead.org,
  regressions@lists.linux.dev,  Jeff Johnson <quic_jjohnson@quicinc.com>,
  linux-kernel@vger.kernel.org,  linux-cxl@vger.kernel.org,
  linux-pci@vger.kernel.org
Subject: Re: [regression] BUG: KASAN: use-after-free in
 lockdep_register_key+0x755/0x8f0
References: <20240603165342.GA685076@bhelgaas>
Date: Mon, 03 Jun 2024 21:29:47 +0300
In-Reply-To: <20240603165342.GA685076@bhelgaas> (Bjorn Helgaas's message of
	"Mon, 3 Jun 2024 11:53:42 -0500")
Message-ID: <87wmn5ubfo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Sat, Jun 01, 2024 at 11:39:03AM +0300, Kalle Valo wrote:
>
>> Kalle Valo <kvalo@kernel.org> writes:
>> 
>> > Dan Williams <dan.j.williams@intel.com> writes:
>> >
>> >> Kalle Valo wrote:
>> >> [..]
>> >>> >> The proposed fix for that is here:
>> >>> >>
>> >>> >> http://lore.kernel.org/r/66560aa9dbedb_195e294b0@dwillia2-mobl3.amr.corp.intel.com.notmuch
>> >>> >
>> >>> > I get "Not Found" from that link, is there a typo?
>> >>> 
>> >>> I found this fix from for-linus branch:
>> >>> 
>> >>> # PCI: Fix missing lockdep annotation for pci_cfg_access_trylock()for-linus
>> >>> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=for-linus&id=f941b9182c54a885a9d5d4cfd97af66873c98560
>> >>> 
>> >>> But at least that doesn't fix my crash.
>> >>
>> >> Sorry for the broken link I mistakenly used a message-id from an
>> >> internal thread with the intel.com reporter. However, it is moot now
>> >> because the new direction is to revert the lockdep infrastructure:
>> >>
>> >> https://lore.kernel.org/r/171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com
>> >>
>> >> (that link works...)
>> >
>> > Thanks, that links works :) I did a quick test with the three patches
>> > and I didn't see any crashes anymore. But to be confident I need to run
>> > overnight tests, I'll provide my Tested-by after that.
>> 
>> Ok, I'm now quite confident that the issues I saw are solved so:
>> 
>> Tested-by: Kalle Valo <kvalo@kernel.org>
>
> Thanks for reporting the issue and testing the fix!  Can you please
> respond with your Tested-by to the actual patch(es) you tested?

Not easily as I'm not subscribed to linux-pci list and I haven't
researched how to import mbox files to my mailer :) So feel free to
ignore my Tested-by tag in this case.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

