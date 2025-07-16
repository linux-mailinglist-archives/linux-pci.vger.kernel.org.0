Return-Path: <linux-pci+bounces-32314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 938C7B07C8D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 20:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5E1189F9A1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D4F293C4E;
	Wed, 16 Jul 2025 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUJXRjU9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA70B293B7E;
	Wed, 16 Jul 2025 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752689603; cv=none; b=XDQvvHscSh6u3l/4RIFa3kA2RQ481QzDYP2Mgz5MpUiD6oYz6vSnJ1lRoPsihVh50R/GZw0DpBRzq7W4seNJFvGKcj8HfavdLpXBiNOrA8c+HMRnydtAbLPiNjA0NiIH/me9KkbUuwYpxvJWRzQA1KYKUW8BOlphIdsYMhBrcJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752689603; c=relaxed/simple;
	bh=dREUMcPf1l4JS8L+ZumcOozisp+811Y3gf1kVvHAHno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHizJdGAZ0p3wzme2FVKaDMs3GzgdmwF/1ngVt9dTRTb6jOcu2yPJz18wIS8NbFdQP+GhZvOV3gEO1X0Dgp3cyw2SpTRXGPm8svXYuOcRs4YoHpcp3H6DdJGSQwLIIWNowUCrMBtGpLDUwFhmyz+gTZSJJRx0LNig5rIW9D1+Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUJXRjU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE95FC4CEE7;
	Wed, 16 Jul 2025 18:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752689603;
	bh=dREUMcPf1l4JS8L+ZumcOozisp+811Y3gf1kVvHAHno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUJXRjU9ZZo+m8e6d6y80I026kBsfv0GbcoVj/6k/zGnpHVhBIlh2dKtq6qvX2Ewz
	 Qk+R/4aIrhfI1wCA+eraaA6RZB+SCYpv0M48CWNE0L1TLAQ9ns8jc5W6Y2CvZbIVRd
	 UjxFSc9MMsQAoyfFZ1Ttiy+FTl5yRJxtNzr6w3+fQY/LZcz32e8Qpo3eMjr2P9c9ZC
	 D53tnmnZtrJOjhKrAXFkZSATFceE/UKbsORYtDG3DGL+UbfhXGgTesbEWnZLzj2Zql
	 3VMjPoK5xZEb1pFaPQd1lLfvDMl582nDxzewBUyPf/VaQHshIdnL9fzdcurKYPEnnU
	 OsSALM6Vw2H2Q==
Received: by pali.im (Postfix)
	id A2312811; Wed, 16 Jul 2025 20:13:20 +0200 (CEST)
Date: Wed, 16 Jul 2025 20:13:20 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Rostyslav Khudolii <ros@qtec.com>
Cc: Ingo Molnar <mingo@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Filip =?utf-8?B?xaB0xJtkcm9uc2vDvQ==?= <p@regnarg.cz>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
Message-ID: <20250716181320.rhhcdymjy26kg7rq@pali>
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
 <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local>
 <20241219164408.GA1454146@yaz-khff2.amd.com>
 <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
 <Z78uOaPESGXWN46M@gmail.com>
 <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
 <20250621145015.v7vrlckn6jqtfnb3@pali>
 <CAJDH93vTBkk7a5D0nOgNfBEjGfMhKbFnUWaQ1r6NDLqm0j3kOA@mail.gmail.com>
 <20250715170637.mtplp7s73zwdbjay@pali>
 <CAJDH93uXuR8cWSnUgOWwi=JNuS543mHLPJb9UUac2g=K4bFMSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJDH93uXuR8cWSnUgOWwi=JNuS543mHLPJb9UUac2g=K4bFMSQ@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Wednesday 16 July 2025 10:03:40 Rostyslav Khudolii wrote:
> > Hello, thank you for information.
> >
> > Just I would like to know, where did you find information that the
> > EnableCF8ExtCfg register was moved to D18F4x044? It is documented in
> > some AMD specification?
> >
> > I did not find anything regarding this change.
> 
> I mentioned the exact specification in my first message. It's under
> NDA, unfortunately.

Do you know if this applies only for AMD family 17? Or also for later
fam 18, 19 and 1a?

And for confirmation, which bit represent the EnableCF8ExtCfg in PCI
config space register D18F4x044? It is still 14th bit like in family 16h?


Just for explanation, in your first message you wrote:

  "register still exists but is now located at a different address (see
  the "Processor Programming Reference (PPR) for AMD Family 17h", Section 2.1.8)."

Document named "Processor Programming Reference (PPR) for AMD Family 17h
Models 01h,08h, Revision B2 Processors" with revision information
"54945 Rev 3.03 - Jun 14, 2019" is publicly available at AMD web:

https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/54945-ppr-family-17h-models-00h-0fh-processors.zip

I looked into that document into section 2.1.8 "PCI Configuration Legacy Access"
and there is not related to EnableCF8ExtCfg.

So I was somehow confused to which section / document you are referring.
And now if I understand correctly, you have NDA documentation with the
same title as the above public one, but with the different content, right?

