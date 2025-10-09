Return-Path: <linux-pci+bounces-37782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FC1BCB2FE
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 01:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A6C1A64147
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 23:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1F02882C5;
	Thu,  9 Oct 2025 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diANyS83"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17F42877DB;
	Thu,  9 Oct 2025 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760052112; cv=none; b=GhhckfJJS0uQruvy3p1TuF1x0MC2EqhIivnmpcHTwdiEO4CysodFLnHnz/KQmlK/M5cWo5pTBLp4bOITBSPly0udY6r6klKBmKqleYIbWV7koJvLN/w+3TSATj1Yp2jhjqghEvfPJgWxRHCnkbSLYdEgNHk2BdN96K2cytBIbq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760052112; c=relaxed/simple;
	bh=CoIyQA9k57VzU66YWcKfbRJ6JJw4qxvrKtowVP4IC/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MOzq8bYm5OrsA+U3IXdm+Si/9i64LelnkvlCMkTBa9iUR1zc91S9Wm9VuWn17KLMkXKcukDh0oFf1LLiLEtd8696N5ddEypwwrm5htnMYUWN98eqqEFiK8989YlkqDnLP6j3KVVfKI8Rmn37/8FCvvwjxoCM9JvXsRD3l+U3N7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diANyS83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45565C4CEE7;
	Thu,  9 Oct 2025 23:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760052110;
	bh=CoIyQA9k57VzU66YWcKfbRJ6JJw4qxvrKtowVP4IC/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=diANyS83OjHEakj4eOJU2n3yks5u5nK8hqkkMTvVAxrHqYLP2ZScE1jg2sJQdgk1Q
	 ZCAtMGf2uZxR3RwuDx6bSzzWx7r9zwpquuDySquxqzyzBjgajaUjF9lL5Lnp0QpIxD
	 Kes0gLHNrk6UGrJ5JP9MxyW7MwuUWzWcCs9B2R5GmQWhrc+NvGPd69rqct4h1XAtzb
	 VlXO8fY7nYUwpZrGHVhEX7Q7FxZyfMs56dB/HuSBSgzyYBDezn+1vtMOTPx5G6SHNv
	 PomVjOFInb6bTqxnpukKoXAQJGFfTJA6ZpCP9g//4sQC5Gus/ZPzpmkUSNzbk83r1O
	 piLe9JV1ekGuw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Chris Li <chrisl@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Bjorn Helgaas <bhelgaas@google.com>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Danilo Krummrich <dakr@kernel.org>,  Len Brown
 <lenb@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-pci@vger.kernel.org,  linux-acpi@vger.kernel.org,  David Matlack
 <dmatlack@google.com>,  Pasha Tatashin <tatashin@google.com>,  Jason Miu
 <jasonmiu@google.com>,  Vipin Sharma <vipinsh@google.com>,  Saeed Mahameed
 <saeedm@nvidia.com>,  Adithya Jayachandran <ajayachandra@nvidia.com>,
  Parav Pandit <parav@nvidia.com>,  William Tu <witu@nvidia.com>,  Mike
 Rapoport <rppt@kernel.org>,  Jason Gunthorpe <jgg@ziepe.ca>,  Leon
 Romanovsky <leon@kernel.org>,  skhawaja@google.com
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
In-Reply-To: <CACePvbUJ6mxgCNVy_0PdMP+-98D0Un8peRhsR45mbr9czfMkEA@mail.gmail.com>
	(Chris Li's message of "Tue, 7 Oct 2025 16:32:12 -0700")
References: <CA+CK2bAbB8YsheCwLi0ztY5LLWMyQ6He3sbYru697Ogq5+hR+Q@mail.gmail.com>
	<20250929150425.GA111624@bhelgaas>
	<CACePvbV+D6nu=gqjavv+hve4tcD+6WxQjC0O9TbNxLCeBhi5nQ@mail.gmail.com>
	<CACePvbUJ6mxgCNVy_0PdMP+-98D0Un8peRhsR45mbr9czfMkEA@mail.gmail.com>
Date: Fri, 10 Oct 2025 01:21:46 +0200
Message-ID: <mafs0a51zmzjp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 07 2025, Chris Li wrote:

[...]
> That will keep me busy for a while waiting for the VFIO series.

I recall we talked in one of the biweekly meetings about some sanity
checking of folios right before reboot (make sure they are right order,
etc.) under a KEXEC_HANDOVER_DEBUG option. If you have some spare time
on your hands, would be cool to see some patches for that as well :-)

-- 
Regards,
Pratyush Yadav

