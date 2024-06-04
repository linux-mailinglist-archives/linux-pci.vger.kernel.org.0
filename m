Return-Path: <linux-pci+bounces-8231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D4A8FAD1C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 10:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439EC283E9E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 08:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0264C14037D;
	Tue,  4 Jun 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1MRxCEM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24EA446CF;
	Tue,  4 Jun 2024 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488571; cv=none; b=u90VSFXbC2w8XD4K5+zCaEm1tRw1txKl8Hko9r4xJit5luxFwjJNZVtbxPxSheid9waEYOV3LVQD7dvtmJUqEh1wzI23IjyvpvIi3t3gIhaDRtobKEqGIkyiGvYMSnp9jIMw1u1u7nSa6Ecdk9rge2hENdsBT8hR6kVTBMHrgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488571; c=relaxed/simple;
	bh=Ks/5HXLLA3BlNGAruV2BQLpNqH2NplEnN5LmiJ/z4Cg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qlddUFXb1BHDdZpwva5vcDXzVGaAeFDJovvGTWBoYeS1E1m9ptc8zZbplWspTF4FIopAntocAtfMDUMHA1sEwA31qwJPeKsoWDNWEDL1FUcjoZWFl3WzjuzTlJuGKgCE8olQA08iu4waJTuwjrO0IWEN4a/XTlhnTX7rs4SKJpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1MRxCEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6ECC2BBFC;
	Tue,  4 Jun 2024 08:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717488570;
	bh=Ks/5HXLLA3BlNGAruV2BQLpNqH2NplEnN5LmiJ/z4Cg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=o1MRxCEMsm/rvMeAAJBPCYWpYQyAFd8BIGgeQvMSn7f/STx63dNix0p3AdGHdZgHO
	 VpJz0TOInXj39V5PtD1yEF+NaPIlHvxQyN6RxRjF55oj3yFnPSF6kAdy6xZoSDHHF8
	 uFmfQLaIUcNUKv1NYmxjir4bIWQYSbjQb2VcekRvPSTuUmUGpobXBYYjpH/pVzZSO8
	 5mj4vvnZes5pcoFC9qdoLII1gSie8vbQ6FVHKFbBDT3w6IZIgxBPY/CwY/WAR1Th7W
	 PGtpqFlZXM5ZneNCb8ZcE0Ar/w4EbNdRtAHV6nqSQqZJm6gZrHzagtxpP5PSB2kX/I
	 mykRDonmv/rmQ==
From: Kalle Valo <kvalo@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,  Dave Jiang <dave.jiang@intel.com>,
  Bjorn Helgaas <bhelgaas@google.com>,  <linux-wireless@vger.kernel.org>,
  <ath11k@lists.infradead.org>,  <regressions@lists.linux.dev>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>,  <linux-kernel@vger.kernel.org>,
  <linux-cxl@vger.kernel.org>,  <linux-pci@vger.kernel.org>
Subject: Re: [regression] BUG: KASAN: use-after-free in
 lockdep_register_key+0x755/0x8f0
References: <20240603165342.GA685076@bhelgaas> <87wmn5ubfo.fsf@kernel.org>
	<665e162ec4b2d_2a90e294c8@dwillia2-xfh.jf.intel.com.notmuch>
Date: Tue, 04 Jun 2024 11:09:26 +0300
In-Reply-To: <665e162ec4b2d_2a90e294c8@dwillia2-xfh.jf.intel.com.notmuch> (Dan
	Williams's message of "Mon, 3 Jun 2024 12:14:54 -0700")
Message-ID: <87cyoxt9hl.fsf@kernel.org>
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
>> > Thanks for reporting the issue and testing the fix!  Can you please
>> > respond with your Tested-by to the actual patch(es) you tested?
>> 
>> Not easily as I'm not subscribed to linux-pci list and I haven't
>> researched how to import mbox files to my mailer :) So feel free to
>> ignore my Tested-by tag in this case.
>
> I have had success with "b4 mbox" and importing that into Evolution, but
> your mileage may vary with your mailer setup.

Heh, I'm old school and don't use anything modern like Evolution :) But
it was actually really easy with Gnus ('G f') and looks like I managed
to do it succesfully now:

https://lore.kernel.org/all/87h6e9t9qt.fsf@kernel.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

