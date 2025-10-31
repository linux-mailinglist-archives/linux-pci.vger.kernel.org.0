Return-Path: <linux-pci+bounces-39930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23262C2520F
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 13:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE0874F5ADF
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 12:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA5B33E37D;
	Fri, 31 Oct 2025 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmVE9Qoj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F96931D75D;
	Fri, 31 Oct 2025 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915357; cv=none; b=nWOSqYcLmp235+PQxQKak5RTv2tFYCQAS5ii9l5Ebfc1MjErvr9iS1c1w8Qxv1zTgXfNZruv+M0GYerAVKcPWpwGUXF8lu9lVB9MLB8yPpVKIUzMN7yVRUT2Zuv+W0ROB1AlOPdy/vfmY7Lg+nYrC7w7S5F2BZHw6JQ+q59TuhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915357; c=relaxed/simple;
	bh=wpbMLJkDrZSL8FdFeIkpX490OB0NbAa89VqXaDbtY3c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=TF3Kl8iBgXWiZJm3+zoMkENJepXOoRlo9/ebRqTpLygVL0iyQ+xCr8NJWk88yCfT3QPcfKs2y8azhEfpMyW0yzOB637UCMtg0Ta+9RGq3MG9YT08OpU2UaqljlE1ee/l7jLIoYq9+JmilX5OIYt/zrNEeK/+dYnaoi7L7/PKUvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmVE9Qoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D099C4CEE7;
	Fri, 31 Oct 2025 12:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761915357;
	bh=wpbMLJkDrZSL8FdFeIkpX490OB0NbAa89VqXaDbtY3c=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=fmVE9Qojv+dWz/YnymzYvcRPk8vrxUTkrBoM4A0g0/mNK/DjcpQco3hJafWdJpEsf
	 Ud/bS/fua0H1Bo0HCOPThys1Pet58MrABcOYYOpWQ/87W/1r3w+32WJXVZkDmr7oj+
	 54xZx/smZZWWGXalcf+dZF5Ewde68fnHbfy+RXzDDLXU78sKojIEubFYn+KMC1nL14
	 0JzSKSrA2TrV1/FyK3qvUXSPbgCDh1zG3WA5ouvCJkcPGiMFSsNc3WG8wv+yxgj2+y
	 SQuwEbejcZvRZZXIkIRQPVDJZpAYH26tqV+83hdfRRDZtN00Ejys9SPnoJrjE9H4NQ
	 4qbM3ENB2jxLA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Oct 2025 13:55:50 +0100
Message-Id: <DDWIV5V651WF.2A0O2XQX5G01H@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, <rust-for-linux@vger.kernel.org>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>,
 "Bjorn Helgaas" <helgaas@kernel.org>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 1/5] rust: io: factor common I/O helpers into Io
 trait
References: <20251030154842.450518-1-zhiw@nvidia.com>
 <20251030154842.450518-2-zhiw@nvidia.com> <aQR8OPVnU_fPJTCI@google.com>
 <20251031144836.110ac310.zhiw@nvidia.com>
In-Reply-To: <20251031144836.110ac310.zhiw@nvidia.com>

On Fri Oct 31, 2025 at 1:48 PM CET, Zhi Wang wrote:
> Yeah, I actually tried that in an earlier version.
> I noticed that each backend is a bit different =E2=80=94 for example, the=
 PCI
> config space routines don=E2=80=99t have read64()/write64() either.

We can split it up in multiple traits if necessary, e.g. have a separate tr=
ait
for 64 bit operations.

> By
> design, we don=E2=80=99t provide infallible versions for the PCI config s=
pace
> backend (unlike the MMIO one). Other backends might have similar cases
> as well.

That seems wrong: For the PCI configuration space we can almost always do
infallibe range checks, i.e. the normal range is always guaranteed and exte=
nded
can be asserted as described in [1].

[1] https://lore.kernel.org/lkml/DDWINZJUGVQ8.POKS7A6ZSRFK@kernel.org/

