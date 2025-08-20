Return-Path: <linux-pci+bounces-34386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBD1B2DE81
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 15:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BFE1890772
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 13:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D680021B1B9;
	Wed, 20 Aug 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gS3i7LWA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447821323C;
	Wed, 20 Aug 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698205; cv=none; b=YjlzgNBWQfrZOCqmXwe4fNsyB+1tc1mhbC9Cv5e5qAiFOP8BCqLcxB66j/AaL33QREq90Y09gkSIVbcMF63DCw7NE+f+6t2QZEkg/Wiu0Xr/fY5ugOvZO6fhpbKe+srqz+gZuAfR6Zddd/4X5aDzaHLLc2oGZEsJNIaEQjzfmT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698205; c=relaxed/simple;
	bh=piG/FiXhKiIArdVeFb0mh1k61fHGLdZsqcNNViU3X6g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=MOFQveTGKCvbPw/8HQmhIL4HSzD3SWGWzPs5NII2nQT8qdGCN+U7QwGvmrmf0y8Po9Dv1bpl+9/BLGGr2lS6afgeDKt+8O45CF+vYQD5ZTqorcxodHYfC/mZ8dHOCFg2+NduHBCjbW8qIpED7wVzVBBF7giPoYihlu9TMkvt7AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gS3i7LWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40983C4CEE7;
	Wed, 20 Aug 2025 13:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755698205;
	bh=piG/FiXhKiIArdVeFb0mh1k61fHGLdZsqcNNViU3X6g=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=gS3i7LWAe4EDXHuyD1/rYg1XqTVyLXT3pgtCd561jjf0M2wttckn8jFw7K1ssw01P
	 OYwpupj11qtsNrN7p+yNHNIvFuXz6aPnHOWDi9xiA+GoGfVq7tESKMibmKim8JoEzX
	 Q71d2WCaMAcPkQT90pVBimjKVPqecbTPqfFKlDz6rn5nraPOc2j6uVsZq4PwE3L09Q
	 HYc5MHkC07RR2yQ0EGghcVSF2RuUPATiv06yz9TPVzC7cSpOVVddod+EWVQbtUmFlH
	 XgUl3b7fqocDKrKRXHvp5ph1kXZ1wegx4Z9KMlg+d7U4409OrkpHd4Sql6aXsci0lj
	 iKsFtV/oUeQXA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 15:56:39 +0200
Message-Id: <DC7B2I88PS4K.TJAD25XWXK9K@kernel.org>
Subject: Re: [PATCH v4 2/3] gpu: nova-core: avoid probing
 non-display/compute PCI functions
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nouveau@lists.freedesktop.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250820030859.6446-1-jhubbard@nvidia.com>
 <20250820030859.6446-3-jhubbard@nvidia.com>
 <DC7AZL4OWXTY.2F7TRSCZYNK6S@nvidia.com>
In-Reply-To: <DC7AZL4OWXTY.2F7TRSCZYNK6S@nvidia.com>

On Wed Aug 20, 2025 at 3:52 PM CEST, Alexandre Courbot wrote:
> This is making use of `from_class_and_vendor`, which is modified in the
> next patch, requiring to modify this part of the file again. How about
> switching this patch with 3/3 so we only modify the nova-core code once?

I think that makes sense.

> I also wonder if we want to merge 1/3 and (the current) 3/3, since 1/3
> alone leaves `from_class_and_vendor` into some intermediate state that
> nobody will ever get a chance to use anyway, and one doesn't really make
> sense without the other. WDYT?

Let's not merge them please, the intermediate state is not that bad, curren=
tly
we deal with raw integers for representing vendor IDs as well. So, patch 1 =
is an
improvement even by itself.

