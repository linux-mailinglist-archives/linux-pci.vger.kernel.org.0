Return-Path: <linux-pci+bounces-31145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB70AEF274
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 11:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A213BEECB
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 09:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80DF25B2FA;
	Tue,  1 Jul 2025 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yskdiSO8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804BB22259D;
	Tue,  1 Jul 2025 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360679; cv=none; b=Lh4jZ5ybB60M+ZV0Lw1ux78Mi1aPQXY0V0vAXMNj51jjM2je8WG0QYdxRXRx81PY4yBxragT9YqDuBwPwS9gZ33hSctx2BZsklKe6DwWpBVlHW67bKPlyp6BAuMvRPNFbBurdGhGj4h+Vwz3dvZI25FJHKBb9Z8Nqzi8xZ98PHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360679; c=relaxed/simple;
	bh=Cm8dQ0str3Y8uvQypv77L9VD2Tc5Zq1hjX5dkLtqbjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/WHalUr/a54z4wbMbxAQZvMcCZmF969xiA1LV0opXI6SJfiguc1YcC8BGG4vBWMi8xsc2ikPYtkAenR3zjZweu8fnFNtFkzImnBXK30o4s4oGTpRKVoJOBVOji91xZk2IHc3I7cCRlkfbJ/UIgXNW9e1QmkbFbjkz9gtIhU87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yskdiSO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47F2C4CEEB;
	Tue,  1 Jul 2025 09:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751360679;
	bh=Cm8dQ0str3Y8uvQypv77L9VD2Tc5Zq1hjX5dkLtqbjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yskdiSO8mSuCQUPGWXBuRtXf5ft+toHSAr2+xtrIRblukTub0y5qUFe5fVxZvRtMD
	 /njX/e+8uSwJOMYBeJsbgOlEcOQSZuEMbZQGm3j8WZsJU1zGxwvoTo2Lneycn1p5cq
	 yF+mXdq8BzwlthYmYo1ciSTWCMqpCCtrJe7XbJ40=
Date: Tue, 1 Jul 2025 11:04:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, alex.gaynor@gmail.com,
	dakr@kernel.org, ojeda@kernel.org, rafael@kernel.org,
	robh@kernel.org, saravanak@google.com, a.hindborg@kernel.org,
	aliceryhl@google.com, bhelgaas@google.com, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, devicetree@vger.kernel.org, gary@garyguo.net,
	kwilczynski@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lossin@kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v1] rust: fix typo in #[repr(transparent)] comments
Message-ID: <2025070126-dreamboat-striking-c698@gregkh>
References: <20250623225846.169805-1-fujita.tomonori@gmail.com>
 <CANiq72kR=yFrMUtvOVp__QSNT574f+HwwbpVAvw7D8LeBs1pmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kR=yFrMUtvOVp__QSNT574f+HwwbpVAvw7D8LeBs1pmw@mail.gmail.com>

On Tue, Jun 24, 2025 at 01:15:18AM +0200, Miguel Ojeda wrote:
> On Tue, Jun 24, 2025 at 12:59 AM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
> >
> > Fix a typo in several comments where `#[repr(transparent)]` was
> > mistakenly written as `#[repr(transparent)` (missing closing
> > bracket).
> >
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> Thanks for fixing the typo!
> 
> Looks fine to me.

Thanks, I'll take this through the driver-core tree.

greg k-h

