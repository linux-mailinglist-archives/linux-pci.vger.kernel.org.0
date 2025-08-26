Return-Path: <linux-pci+bounces-34782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D34CDB371F3
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 20:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9202D7A4753
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 18:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB96314B98;
	Tue, 26 Aug 2025 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJSadCMP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549712F744D;
	Tue, 26 Aug 2025 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231789; cv=none; b=hITgdXmVPUYrvoPosvcuSWCYH+ezyT/eRtzD06D4PDb0T9nLn6LYC0VTNzlTf4SnIlTTfZ6ssW6KcHtCagrsS/404OmUVItlv1xU3BZw3+yNcD8DnMaJUMWsuEFe6QQzHZJcJ4VNWSYEbyzVInJNLCIHaZ+u9fBekJJ++zrE4ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231789; c=relaxed/simple;
	bh=+OJvOthCryzhiPhifEPAEL1YeW9cy6IV0fKD+1t7Nv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D669K5zz/tCAGkZzUi3sRPCFsvIkwFizr4gIYAuQnWBdoSfSLQbdbux4a2C3K67Cz6akt4cRzyGQAjZVz15jBvnpxe1KP3SxUJSBVGwm7HYSHcfSsLP2sVsPqhdVnZmyYzyjVe011nN7A3tVJAaUFNlZ+NQDNAVxydHnT6KJQ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJSadCMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D69C4CEF1;
	Tue, 26 Aug 2025 18:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756231788;
	bh=+OJvOthCryzhiPhifEPAEL1YeW9cy6IV0fKD+1t7Nv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJSadCMPYLH3+XxsmFfw+6zi01oqoC7D+mmiVjIBFPdI3dliV+lk6bkJnYO1TDVZi
	 pswwcpl+lWK4AjNtCqQadK6oZKPnJ4rDukM6Zo9z1lp39ipuq2uZNepbHlI8fMwXD8
	 MkXd/AK0PNBsUi6fJV4A0CGsq0wMqjaif9bBEuw/wrCYmTZ3pELj9LWVKgIaBlONEB
	 WeD+1wBtAtAXCukt0G3kY6c4wEmXH5hqLab/DtHlM/QTKoPTJeIvM28vn6R1tVuvES
	 /hkPW1Uo3055rq0JVpv8gq6oNXHqmB38S9QSyWsjcU4MyXBKoCPZDhWn4slPT7g4kj
	 TXJmej9tCBjtA==
Received: by pali.im (Postfix)
	id A7E77692; Tue, 26 Aug 2025 20:09:45 +0200 (CEST)
Date: Tue, 26 Aug 2025 20:09:45 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Rostyslav Khudolii <ros@qtec.com>
Cc: Ingo Molnar <mingo@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Filip =?utf-8?B?xaB0xJtkcm9uc2vDvQ==?= <p@regnarg.cz>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
Message-ID: <20250826180945.6o2xfhadv6a2c36i@pali>
References: <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
 <Z78uOaPESGXWN46M@gmail.com>
 <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
 <20250621145015.v7vrlckn6jqtfnb3@pali>
 <CAJDH93vTBkk7a5D0nOgNfBEjGfMhKbFnUWaQ1r6NDLqm0j3kOA@mail.gmail.com>
 <20250715170637.mtplp7s73zwdbjay@pali>
 <CAJDH93uXuR8cWSnUgOWwi=JNuS543mHLPJb9UUac2g=K4bFMSQ@mail.gmail.com>
 <20250716181320.rhhcdymjy26kg7rq@pali>
 <20250811175756.kqtbnlrmzphpj2lm@pali>
 <CAJDH93svLMPM0O_Lq=EgfH6dxXXbnq4QkM6ye_8tyvsRYs8dug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJDH93svLMPM0O_Lq=EgfH6dxXXbnq4QkM6ye_8tyvsRYs8dug@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Tuesday 26 August 2025 17:07:38 Rostyslav Khudolii wrote:
> >
> > Hello Rostyslav, I would like to remind the previous email.
> > I still do not know which bit in D18F4x044 represents the
> > EnableCF8ExtCfg config.
> >
> 
> Hi Pali,
> 
> Sorry for the late reply again. So in D18F4x044:
> - bit 0. EnableCf8ExtCfg. Enable PCI extended configuration register
> access for CFC/CF8
> accesses;
> - bit 1. DisPciCfgReg. Disable CFC/CF8 Accesses to IO space. When set
> to 1, CFC/CF8 accesses are treated as
> PCI IO space accesses and not PCI configuration accesses.
> 
> Unfortunately, I don't know if this also applies to later families.

Thank you very much for the info. I was missing the information about
the bit 0 offset.

