Return-Path: <linux-pci+bounces-39667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 692DEC1C159
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0F635A8F86
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 15:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D27E32C941;
	Wed, 29 Oct 2025 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0R0rVrL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51942DF13B;
	Wed, 29 Oct 2025 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752621; cv=none; b=ifaMXGnR0Z8gDn9CGGjvDuSsvOeH0bemuK4DcdGDFHOuwrtgcL1/iEZDmgoaqEyX1frZWWzXtZEnM7AYyN8PWydZCG6HBV8PyPFHrQ8h8QHXwPicuKvcizMHsKGHdY7d9EJQJwu37RcZw/XEzIfkbFwubp03HDzMa5WtSUkJw8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752621; c=relaxed/simple;
	bh=Mac34jN3xSgbU/HpUoUOGaIlA/dO/3VH1nbx6I1T5kk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=KPiAFxi8ip1akLCCtJJnt7KjddE2oiGOlZmnTAXHQWzJTjKpDsSWtvwfeHPKB4nANx/GGX9XzwAkmB1eEN6l4YJOMU+N98uD4cAqNYL600nWcsEkpLBY9YknXDgOieuPz2HhhmvJjfmhi5TZDmSnAmAI4IiSTlGc/VAC0Swcbns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0R0rVrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87608C4CEF7;
	Wed, 29 Oct 2025 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761752621;
	bh=Mac34jN3xSgbU/HpUoUOGaIlA/dO/3VH1nbx6I1T5kk=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=b0R0rVrLWksvZBAWwzNs4Xnt6Zrent63NG3Cy8CXDn/7TlvNdGQTlRuVsLK1wa4NB
	 yWLTWRKpGR0uNnhZ4rBmgGe/iinWHH4g5VfVazhq6DZoJhzIJH62aumNaPPZD98rLp
	 WqT7jK20I4SyhA/XhE6f24KuS5/wH3XOflgho56vNDHn1N87RwJfOt8SXPgJmWFMYw
	 OyNNdAEjpOKp50Mdidmqmx6s982Ryqx36HODeqNWkQ5OZUtmJtbsjutNUt6tbsFU9B
	 6gOhZxzZa+lf4cD0m9QQTDZB/vbeou8IXRcIL7K6UVSVHXEG8/dSzoAbOXQq1EqIdr
	 kUwlvrrTqQ2oQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 16:43:35 +0100
Message-Id: <DDUX6IP1JMI2.3EFTY8PNDJW4V@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 0/8] Device::drvdata() and driver/driver interaction
 (auxiliary)
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <acourbot@nvidia.com>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <pcolberg@redhat.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251020223516.241050-1-dakr@kernel.org>
 <aQIQl8lMhztucZhK@google.com> <DDUWYNJTZ7RT.3ML0O9UNX5LON@kernel.org>
In-Reply-To: <DDUWYNJTZ7RT.3ML0O9UNX5LON@kernel.org>

On Wed Oct 29, 2025 at 4:33 PM CET, Danilo Krummrich wrote:
> On Wed Oct 29, 2025 at 2:03 PM CET, Alice Ryhl wrote:
>> It looks like there are some patches that add code that doesn't pass
>> rustfmt, which are then fixed in follow-up commits. You might want to do
>> a pass of rustfmt after each commit.
>
> Oops, thanks for catching this -- my apply scripts will do exactly that. =
:)

Actually, all patches do pass rustfmt on my end.

I assume you did not run rustfmt yourself, but spotted something that looks=
 odd?

