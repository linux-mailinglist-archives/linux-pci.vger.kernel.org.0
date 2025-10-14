Return-Path: <linux-pci+bounces-38065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F395BDA93F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 18:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D4C1920377
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 16:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3E8302162;
	Tue, 14 Oct 2025 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWTUAqm0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B8E3019A6;
	Tue, 14 Oct 2025 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458278; cv=none; b=RHIru9LJWTeg/GCeQe/Sxx8ykc0BndePWZhAexWChcfOrBlIfLW9I+Oqq8PRZZOkzNzS5jd5mhNo+Sh1nDL6rECfytOVbXhuGzdYVoFPKjpWRCqH4RuRCLHCi5Q77kM4M2Wc9uUI4RE13KUPaOI1qPhcrrV3GpAd8DmgK4KJB20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458278; c=relaxed/simple;
	bh=xagAxPrd6zG7Djil6CYxWyxvbfl7KZqOc3GZdkKkIAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dWOWpmRFAaEuQ5spSEfzYNjy9elmPL3qzOAiofdlHBJKrLabQr+ZDsci3vo5UR3Jcgcv0ispmee9NLEapnckmoD/oZDFUbvS78GntKFha3TUhtBEvRyNp5ia3VRnPzOWPKooW3mas749snsodJmAUtZRWcHldun9yep0vlAedKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWTUAqm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1B8C4CEE7;
	Tue, 14 Oct 2025 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760458278;
	bh=xagAxPrd6zG7Djil6CYxWyxvbfl7KZqOc3GZdkKkIAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uWTUAqm0xXN1mbnYILy5rL2HVLdV2ve/FXOweq5pKife38/ITUDe75qbj4u3VOTud
	 yJqNi+N75XBYiFY1dNfxwKnf1NyDEaEK17/L1hAAGxpdgA9lARd9cU9LqOebap7I6d
	 ohLR8v5vlAl/0LP9XSa9qhPs0SsA0tlr2MpU9r/Lgz4WWV8eW4pC7K+YYaW74dQhpm
	 iTuwJ0VXJew9+yBMkiZGpuRSIOvUnhDhq9qfQMBijCVZAO9KWIIQ+s62gtDVf67L49
	 53QYqOCDIMVH+Zt3AS1oQYutIrfVwht39r+2gxFGWV0RXqpC2StLzHtl7lguq09vkW
	 3b0LYBWLZxHnA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Jason Miu <jasonmiu@google.com>,  Chris Li <chrisl@kernel.org>,  Bjorn
 Helgaas <helgaas@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Bjorn Helgaas <bhelgaas@google.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  Danilo Krummrich <dakr@kernel.org>,  Len Brown <lenb@kernel.org>,
  linux-kernel@vger.kernel.org,  linux-pci@vger.kernel.org,
  linux-acpi@vger.kernel.org,  David Matlack <dmatlack@google.com>,  Pasha
 Tatashin <tatashin@google.com>,  Vipin Sharma <vipinsh@google.com>,  Saeed
 Mahameed <saeedm@nvidia.com>,  Adithya Jayachandran
 <ajayachandra@nvidia.com>,  Parav Pandit <parav@nvidia.com>,  William Tu
 <witu@nvidia.com>,  Mike Rapoport <rppt@kernel.org>,  Jason Gunthorpe
 <jgg@ziepe.ca>,  Leon Romanovsky <leon@kernel.org>,  skhawaja@google.com
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
In-Reply-To: <mafs01pn6nbse.fsf@kernel.org> (Pratyush Yadav's message of "Mon,
	13 Oct 2025 15:58:41 +0200")
References: <CA+CK2bAbB8YsheCwLi0ztY5LLWMyQ6He3sbYru697Ogq5+hR+Q@mail.gmail.com>
	<20250929150425.GA111624@bhelgaas>
	<CACePvbV+D6nu=gqjavv+hve4tcD+6WxQjC0O9TbNxLCeBhi5nQ@mail.gmail.com>
	<CACePvbUJ6mxgCNVy_0PdMP+-98D0Un8peRhsR45mbr9czfMkEA@mail.gmail.com>
	<mafs0a51zmzjp.fsf@kernel.org>
	<CACePvbW9eSBY7qRz4o6Wqh0Ji0qECrFP+RDxa+nn4aHRTt1zkQ@mail.gmail.com>
	<CAHN2nPK34YfrysN+sraiFVjU_9Lw7E-yFVF-9x+nt1OUppZX8Q@mail.gmail.com>
	<mafs01pn6nbse.fsf@kernel.org>
Date: Tue, 14 Oct 2025 18:11:13 +0200
Message-ID: <mafs04is1lazi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 13 2025, Pratyush Yadav wrote:

> On Fri, Oct 10 2025, Jason Miu wrote:
[...]
>> For the folio sanity check with KEXEC_HANDOVER_DEBUG, I can follow
>> that up. Would you tell me what we like to check before reboot, I may
>> have missed some context. Thanks!
>
> The idea is to sanity-check the preserved folios in the kexec-reboot
> flow somewhere. The main check discussed was to make sure the folios are
> of the same order as they were preserved with. This will help catch bugs
> where folios might split after being preserved.
>
> Maybe we can add some more checks too? Like making sure the folios
> aren't freed after they were preserved. But that condition is a bit
> trickier to catch. But at least the former should be simple enough to
> do as a start.

Also perhaps check in kho_preserve_folio() that the preserved folio is
not in scratch memory? This can be a non-debug check as well I suppose,
though looping through all scratch areas every time might end up being
too slow.

-- 
Regards,
Pratyush Yadav

