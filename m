Return-Path: <linux-pci+bounces-37896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B33BD34EB
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 15:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22623AB186
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 13:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E6423236D;
	Mon, 13 Oct 2025 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cR/pTLT/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE181D5CEA;
	Mon, 13 Oct 2025 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363926; cv=none; b=EWxUJDUBXNT+BBUZaYIa+zC6jyi8uAc7hFItT91RM3tc2nOgTUCjMSVg2B1WwFPUG+ZjS7sSiKuzRxhuuDpG6HcPKY/qfFzXsvVk8+db7iZuPdJNd/d3uzIwbOx7ecHzAuBomArxRG4WG3GKPR3kADQSkvt3G3Zp+A9bXik3XpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363926; c=relaxed/simple;
	bh=sMrKkgG+uTwi5sHHZ4cTtu282VBQzEJvwZ+YmNuz5MA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J/DEtL0gwJwMZjNHA5J1sSn8S5Y+fCo6q/aGFSSwSUdMsEfp0fKFLdor8SYuPnXSkx4d53aVj4q+6LGZdMJjFypIVsANsMA0ttardbAnPlqrLY3893Lpn6en8x8U/ZScP2I/TAcwNTTVtyn7WQenIEfY9vECnEo3fNN5zVtbJR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cR/pTLT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA587C4CEE7;
	Mon, 13 Oct 2025 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760363926;
	bh=sMrKkgG+uTwi5sHHZ4cTtu282VBQzEJvwZ+YmNuz5MA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cR/pTLT/vpOrz2kLrwv4bvlqQMcwjn6IYqZ77M8tIyBhGSIjXU3X+Ba6/VNChaLUS
	 CEeAm+egr1YfRdMKWvhXSh0yilyNV1WupuO++XCypFMdngsyBLKGOTlG1U6VciU4M0
	 NatKxXbZSLpFve4E67qR7QfTPy55ZSTtGIDs5Cd5qlvoFTHTYSMTOVjJTPd7ol6km2
	 RCVvDjevQI8YSSsP1eUbTUYs27I0ieyhoz5ldlds8Mc0Aq5Xqw2lHoCUGRgaZMJuEK
	 6zFI50ZCXW5jfCgBuovWZrCBeAqOkZLGvfM2rk5Ee50TFvugi1fdyAeT3vzVowZM8h
	 asxk7DceP6u1w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Miu <jasonmiu@google.com>
Cc: Chris Li <chrisl@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,
  Bjorn Helgaas <helgaas@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Bjorn Helgaas <bhelgaas@google.com>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Danilo Krummrich <dakr@kernel.org>,  Len Brown
 <lenb@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-pci@vger.kernel.org,  linux-acpi@vger.kernel.org,  David Matlack
 <dmatlack@google.com>,  Pasha Tatashin <tatashin@google.com>,  Vipin
 Sharma <vipinsh@google.com>,  Saeed Mahameed <saeedm@nvidia.com>,  Adithya
 Jayachandran <ajayachandra@nvidia.com>,  Parav Pandit <parav@nvidia.com>,
  William Tu <witu@nvidia.com>,  Mike Rapoport <rppt@kernel.org>,  Jason
 Gunthorpe <jgg@ziepe.ca>,  Leon Romanovsky <leon@kernel.org>,
  skhawaja@google.com
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
In-Reply-To: <CAHN2nPK34YfrysN+sraiFVjU_9Lw7E-yFVF-9x+nt1OUppZX8Q@mail.gmail.com>
	(Jason Miu's message of "Fri, 10 Oct 2025 16:49:42 -0700")
References: <CA+CK2bAbB8YsheCwLi0ztY5LLWMyQ6He3sbYru697Ogq5+hR+Q@mail.gmail.com>
	<20250929150425.GA111624@bhelgaas>
	<CACePvbV+D6nu=gqjavv+hve4tcD+6WxQjC0O9TbNxLCeBhi5nQ@mail.gmail.com>
	<CACePvbUJ6mxgCNVy_0PdMP+-98D0Un8peRhsR45mbr9czfMkEA@mail.gmail.com>
	<mafs0a51zmzjp.fsf@kernel.org>
	<CACePvbW9eSBY7qRz4o6Wqh0Ji0qECrFP+RDxa+nn4aHRTt1zkQ@mail.gmail.com>
	<CAHN2nPK34YfrysN+sraiFVjU_9Lw7E-yFVF-9x+nt1OUppZX8Q@mail.gmail.com>
Date: Mon, 13 Oct 2025 15:58:41 +0200
Message-ID: <mafs01pn6nbse.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10 2025, Jason Miu wrote:

> On Thu, Oct 9, 2025 at 9:19=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>>
>> On Thu, Oct 9, 2025 at 4:21=E2=80=AFPM Pratyush Yadav <pratyush@kernel.o=
rg> wrote:
>> >
>> > On Tue, Oct 07 2025, Chris Li wrote:
>> >
>> > [...]
>> > > That will keep me busy for a while waiting for the VFIO series.
>> >
>> > I recall we talked in one of the biweekly meetings about some sanity
>> > checking of folios right before reboot (make sure they are right order,
>> > etc.) under a KEXEC_HANDOVER_DEBUG option. If you have some spare time
>> > on your hands, would be cool to see some patches for that as well :-)
>>
>> Sure, I will add that to my "nice to have" list. No promised I got
>> time to get to it with the PCI. It belong to the KHO series not PCI
>> though.
>>

Right. It is only a "nice to have", and not a requirement. And certainly
not for the PCI series.

>
> Hi Pratyush, Chris,
>
> For the folio sanity check with KEXEC_HANDOVER_DEBUG, I can follow
> that up. Would you tell me what we like to check before reboot, I may
> have missed some context. Thanks!

The idea is to sanity-check the preserved folios in the kexec-reboot
flow somewhere. The main check discussed was to make sure the folios are
of the same order as they were preserved with. This will help catch bugs
where folios might split after being preserved.

Maybe we can add some more checks too? Like making sure the folios
aren't freed after they were preserved. But that condition is a bit
trickier to catch. But at least the former should be simple enough to
do as a start.

--=20
Regards,
Pratyush Yadav

