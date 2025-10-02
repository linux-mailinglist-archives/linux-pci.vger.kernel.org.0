Return-Path: <linux-pci+bounces-37473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F64BB5753
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 23:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B55E3426DD
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 21:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E00A1A01BF;
	Thu,  2 Oct 2025 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9QPcHmg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105FE610B;
	Thu,  2 Oct 2025 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759439695; cv=none; b=BeQ5njeXKdb6V8BxkOBEKQg4ly1327A40xCN+8RZIk+DwlBuqJKVRjsKClFdnfQIr2zMY1xGoQuD2j9mBx//XSoRugbRToaPlZPBAtHMbyzLfeAWJ1qH/BcUlq5Mx861p6JER50/nWo8z41ZqvOwF5dYcO+t2oywb/z0yWy93qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759439695; c=relaxed/simple;
	bh=fEjxlXo9iGxGTGymMtJcGUd4ihSMkkTMFtMwsY3MTe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fsY/bpa5XJT5Y0fQT7/CiZ8P77F/NDQkKYbqIC2ci28gwW9IZf1F4Rn9RPHGguw0xrXeksMNZ0ZTKZNyQKwqqft8aW5JS/TfAxyL9B/na+NmS+j6RAILoLFf5NbjwwmgaF2Zo/zQBf8ucundNISuG1fNXQ6FqEHJrpM1kQtVOdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9QPcHmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE483C4CEF4;
	Thu,  2 Oct 2025 21:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759439694;
	bh=fEjxlXo9iGxGTGymMtJcGUd4ihSMkkTMFtMwsY3MTe0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c9QPcHmgH+iaGhQ9pFcH+PwurhmqcX2V055jstrUUj51qjzYRxN53YbQmjPJ5caxq
	 OlcB7ozpI4oWf/WkwpJBdaFycOGoDcTsGMNexHJXr12bXjxKN93cLK7pbaWPUqlApQ
	 TcmS+yItri3sP0PcQt6WtTwGaTfc8OHz+8T/NwF4r5fh/k/a+kMuMQQZhBfUSgTMsj
	 AIfhHTSBqFfhzkzPoWtcAxCuS+loWYqKfwbAOiqcbZUanbvZuMKDZVfgicrcHkbTiG
	 AjzfUeUL1XGrijOzY4BP9rv0MmQxHEvwjEuKxZsd13gdNupYJRPcws2hevKAqAlfUT
	 vjNOvbUg+y0qw==
Message-ID: <bba17237-2401-4e9b-912b-29d31af748e1@kernel.org>
Date: Thu, 2 Oct 2025 23:14:47 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rust: pci: skip probing VFs if driver doesn't
 support VFs
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Surath Mitra <smitra@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alex Williamson
 <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20251002170506.GA3299207@nvidia.com>
 <DD80P7SKMLI2.1FNMP21LJZFCI@kernel.org>
 <DD80R10HBCHR.1BZNEAAQI36LE@kernel.org>
 <af4b7ce4-eb13-4f8d-a208-3a527476d470@nvidia.com>
 <20251002180525.GC3299207@nvidia.com>
 <3ab338fb-3336-4294-bd21-abd26bc18392@kernel.org>
 <20251002183114.GD3299207@nvidia.com>
 <56daf2fe-5554-4d52-94b3-feec4834c5be@kernel.org>
 <20251002185616.GG3299207@nvidia.com> <DD837Z9VQY0H.1NGRRI2ZRLG4F@kernel.org>
 <20251002210433.GH3299207@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251002210433.GH3299207@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/25 11:04 PM, Jason Gunthorpe wrote:
> On Thu, Oct 02, 2025 at 09:36:17PM +0200, Danilo Krummrich wrote:
>> If we want to obtain the driver's private data from a device outside the scope
>> of bus callbacks, we always need to ensure that the device is guaranteed to be
>> bound and we also need to prove the type of the private data, since a device
>> structure can't be generic over its bound driver.
> 
> pci_iov_get_pf_drvdata() does both of these things - this is what it
> is for. Please don't open code it :(

It makes no sense to use it, both of those things will be ensured in a more
generic way in the base device implementation already (which is what I meant
with layering).

Both requirements are not specific to PCI, or the specific VF -> PF use-case.

In order to guarantee soundness both of those things have to be guaranteed for
any access to the driver's private data.

I will send some patches soon, I think this will make it obvious. :)
>>> Certain conditions may be workable, some drivers seem to have
>>> preferences not to call disable, though I think that is wrong :\
>>
>> I fully agree! I was told that this is because apparently some PF drivers are
>> only loaded to enable SR-IOV and then removed to shrink the potential attack
>> surface. Personally, I think that's slightly paranoid, if the driver would not
>> do anything else than enable / disable SR-IOV, but I think we can work around
>> this use-case if people really want it.
> 
> I've heard worse reasons than that. If that is the interest I'd
> suggest they should just use VFIO and leave a userspace stub
> process..

I'm not sure I follow your proposal, can you elaborate?


