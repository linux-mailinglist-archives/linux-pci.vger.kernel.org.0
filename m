Return-Path: <linux-pci+bounces-33779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC22B213BF
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 19:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06938188C426
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 17:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D132D3ED2;
	Mon, 11 Aug 2025 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVuIKbzh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C729BD8E;
	Mon, 11 Aug 2025 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754935079; cv=none; b=C7RwzLG8GO2+Ks28bM3VTGFMChldLC+1u0PAjQ9HRsJeTIthFHN+YUT4QJ38DDNrwVYiXdGUHfP0mgNFr5+nj53iz/2PWf/ah/wSuE8g/s2YkbcQTYOnc9OkD0uX8wQCZ84uvOH+tpidtFCBZ2N15yhbIUA/43LADgVxrj00imA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754935079; c=relaxed/simple;
	bh=KbGUxirDtI9Kf68XjvOl3ppeB/LXHzVpRLMz2spyTb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWg0eQ/h5WlE/nKjER0ufQhWsoW6wSEN00V/qxXcLI9ardazDdzHF6KVkTzQ6Dztze4b0aNlKVSSD5j6+IjJgIti41MdTFnojzblFtfhWm7lVGGGmgHmNDWaXcJ935HckXw86Q3CPqDT+w3jf+qTdLypaXBMfT9jV5PZZxHIXBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVuIKbzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC404C4CEED;
	Mon, 11 Aug 2025 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754935079;
	bh=KbGUxirDtI9Kf68XjvOl3ppeB/LXHzVpRLMz2spyTb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVuIKbzhtlF6OI9V/9kf/kvds8f25VeYa/vZWvIcf0ONaWhw7Wuk1dk9BjuXTHEir
	 VhTzK3zrzG06kDp83jwIIup4O6mFFXHabztuhzC+t4u89OGThqmhOJZuQTLDqag3t5
	 OrGcOxUzqgczU6hCXnjfj3+eOB9SEiSwMKRCcrd1UIRw3faBbwau8wZsEeuQCfMLH6
	 XAVRguj6Y4J5Brp1cQV5979z2yz/d/Yh+CMUgFZ7+kgjTDhXzObxFklbmOsm0gSjE4
	 z/701wFvNHkrrs5zTfZmS2OuFBpd7uZ6C+BUw0cS6oA4CeED3IqdKEC0Zt1p9hMLWp
	 tbX+vKXiVPGxQ==
Received: by pali.im (Postfix)
	id 68C69730; Mon, 11 Aug 2025 19:57:56 +0200 (CEST)
Date: Mon, 11 Aug 2025 19:57:56 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Rostyslav Khudolii <ros@qtec.com>
Cc: Ingo Molnar <mingo@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Filip =?utf-8?B?xaB0xJtkcm9uc2vDvQ==?= <p@regnarg.cz>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
Message-ID: <20250811175756.kqtbnlrmzphpj2lm@pali>
References: <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local>
 <20241219164408.GA1454146@yaz-khff2.amd.com>
 <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
 <Z78uOaPESGXWN46M@gmail.com>
 <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
 <20250621145015.v7vrlckn6jqtfnb3@pali>
 <CAJDH93vTBkk7a5D0nOgNfBEjGfMhKbFnUWaQ1r6NDLqm0j3kOA@mail.gmail.com>
 <20250715170637.mtplp7s73zwdbjay@pali>
 <CAJDH93uXuR8cWSnUgOWwi=JNuS543mHLPJb9UUac2g=K4bFMSQ@mail.gmail.com>
 <20250716181320.rhhcdymjy26kg7rq@pali>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250716181320.rhhcdymjy26kg7rq@pali>
User-Agent: NeoMutt/20180716

Hello Rostyslav, I would like to remind the previous email.
I still do not know which bit in D18F4x044 represents the
EnableCF8ExtCfg config.

On Wednesday 16 July 2025 20:13:20 Pali Rohár wrote:
> On Wednesday 16 July 2025 10:03:40 Rostyslav Khudolii wrote:
> > > Hello, thank you for information.
> > >
> > > Just I would like to know, where did you find information that the
> > > EnableCF8ExtCfg register was moved to D18F4x044? It is documented in
> > > some AMD specification?
> > >
> > > I did not find anything regarding this change.
> > 
> > I mentioned the exact specification in my first message. It's under
> > NDA, unfortunately.
> 
> Do you know if this applies only for AMD family 17? Or also for later
> fam 18, 19 and 1a?
> 
> And for confirmation, which bit represent the EnableCF8ExtCfg in PCI
> config space register D18F4x044? It is still 14th bit like in family 16h?
> 
> 
> Just for explanation, in your first message you wrote:
> 
>   "register still exists but is now located at a different address (see
>   the "Processor Programming Reference (PPR) for AMD Family 17h", Section 2.1.8)."
> 
> Document named "Processor Programming Reference (PPR) for AMD Family 17h
> Models 01h,08h, Revision B2 Processors" with revision information
> "54945 Rev 3.03 - Jun 14, 2019" is publicly available at AMD web:
> 
> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/54945-ppr-family-17h-models-00h-0fh-processors.zip
> 
> I looked into that document into section 2.1.8 "PCI Configuration Legacy Access"
> and there is not related to EnableCF8ExtCfg.
> 
> So I was somehow confused to which section / document you are referring.
> And now if I understand correctly, you have NDA documentation with the
> same title as the above public one, but with the different content, right?

