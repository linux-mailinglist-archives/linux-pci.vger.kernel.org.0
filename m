Return-Path: <linux-pci+bounces-37377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBC8BB205E
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 00:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE7C188AA85
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 22:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1627228D8CC;
	Wed,  1 Oct 2025 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib5MtBt0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8541EDA0E;
	Wed,  1 Oct 2025 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359138; cv=none; b=q8Qb77sVbhNnVXx/BcvDtvAK0yAJZbzv/Ums3uus6FwXDM30HxWMrrx5Pq73H2dKs39HrEqs9Je3aUjF7pimtcKO46x2XCTtsK+XdL415S1GsVnlGkJumLQkbSDHqISJqL6NXH8IFSdCHyZPdwZkxTvWe5uweBUsKJUjviHgwrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359138; c=relaxed/simple;
	bh=3PdOFINQw3jijXpyTPI1RPhSJnvlq3NzijpY3jqVyzE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=A/ODexsgc+nZNnhwWFegwerl1KuJfFXIEjf0Pzfgwor39NF7uVKQACPzHkE/EMiO3pGXboSON0lSWuCS6vJvh0lcK+8Y3kqnMlDxVjg03Tyl21HtwdP57MR5i3HF3H1RtK3M1oEq7G014pWcRXLRP/M9T/LZeIPhVsQrhx5h28A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib5MtBt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0B5C4CEF1;
	Wed,  1 Oct 2025 22:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759359137;
	bh=3PdOFINQw3jijXpyTPI1RPhSJnvlq3NzijpY3jqVyzE=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=ib5MtBt0JkdO40bRNwqfWdPTurb+ijtNRok25qAU14CNWYlkw+9nzwd20NxoyLbMt
	 m4bP3fN03qrJQLQ6OelkmojOYwvzUodpeswGm0d3Jt6PitfFlKTW3Bh3w1VRr/TgWe
	 OspwUtKYcD7BLwA1k3KPijUqB0hJB/46RHItumjGkW5k7Jt5BRoRmhJW3Q72NbatRz
	 SELrIRj5mb8AyUCOQZPGbyxp2Fyzee3HW4991mPP8F9+J/7NmM+9xdqhwk3hnWZQEc
	 5EJD5IKKzH8cII+33HqyO5JbDKLrQ6pFZlzNZdsfOcccRbdmdOM8NLMF9MkPnzhyIn
	 xHJpNSRledf+w==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Oct 2025 00:52:10 +0200
Message-Id: <DD7CREVYE5L7.2FALGBC35L8CN@kernel.org>
Cc: "Zhi Wang" <zhiw@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Surath Mitra"
 <smitra@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "Jason Gunthorpe" <jgg@nvidia.com>, "Alex
 Williamson" <alex.williamson@redhat.com>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <h6jdcfhhf3wuiwwj3bmqp5ohvy7il6sfyp6iufovdswgoz7vul@gjindki2pyeh>
 <e77bbcda-35a3-4ec6-ac24-316ab34a201a@nvidia.com>
 <DD6X0PXA0VAO.101O3FEAHJUH9@kernel.org>
 <f145fd29-e039-4621-b499-17ab55572ea4@nvidia.com>
 <ae48fad0-d40e-4142-87d0-8205abdf42d6@nvidia.com>
In-Reply-To: <ae48fad0-d40e-4142-87d0-8205abdf42d6@nvidia.com>

On Thu Oct 2, 2025 at 12:38 AM CEST, John Hubbard wrote:
> On 10/1/25 6:52 AM, Zhi Wang wrote:
>> On 1.10.2025 13.32, Danilo Krummrich wrote:
>>> On Wed Oct 1, 2025 at 3:22 AM CEST, John Hubbard wrote:
>>>> On 9/30/25 5:29 PM, Alistair Popple wrote:
>>>>> On 2025-10-01 at 08:07 +1000, John Hubbard <jhubbard@nvidia.com> wrot=
e...
> ...
>>> So, this patch series does not do anything uncommon.
>>>
>>>>> I'm guessing the proposal is to fail the probe() function in nova-cor=
e for
>>>>> the VFs - I'm not sure but does the driver core continue to try probi=
ng other
>>>>> drivers if one fails probe()? It seems like this would be something b=
est
>>>>> filtered on in the device id table, although I understand that's not =
possible
>>>>> today.
>>>
>>> Yes, the driver core keeps going until it finds a driver that succeeds =
probing
>>> or no driver is left to probe. (This behavior is also the reason for th=
e name
>>> probe() in the first place.)
>>>
>>> However, nowadays we ideally know whether a driver fits a device before=
 probe()
>>> is called, but there are still exceptions; with PCI virtual functions w=
e've just
>>> hit one of those.
>>>
>>> Theoretically, we could also indicate whether a driver handles virtual =
functions
>>> through a boolean in struct pci_driver, which would be a bit more elega=
nt.
>>>
>>> If you want I can also pick this up with my SR-IOV RFC which will proba=
bly touch
>>> the driver structure as well; I plan to send something in a few days.
>
> As I mentioned in the other fork of this thread, I do think this is
> a good start. So unless someone disagrees, I'd like to go with this
> series (perhaps with better wording in the commit messages, and maybe
> a better comment above the probe() failure return) for now.

Indicating whether the driver supports VFs through a boolean in struct
pci_driver is about the same effort (well, maybe slightly more), but solves=
 the
problem in a cleaner way since it avoids probe() being called in the first
place. Other existing drivers benefit from that as well.

Forget about the SR-IOV RFC I was talking about; I really just intended to =
offer
to take care of that. :)

