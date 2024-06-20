Return-Path: <linux-pci+bounces-9022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4C9910871
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 16:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91664282473
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365E51AE850;
	Thu, 20 Jun 2024 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y08XFSve"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6B1AE083;
	Thu, 20 Jun 2024 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893933; cv=none; b=J8Xzav67QWbA4s59HXJSkGI/Bqx3AZ/5dthwDo6wzWgLRWN+QAXoJAcut+I3IAtaARjGTjsVsAfX2wXAzFqJCfLmYYPEbnOMdIIi8Zn2CaDUWg5IIiDx8wLCRXjBhTX2gKkoTUc2jzbevNukAZ3NX25Mdzp3athxcWaoK/q+Qk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893933; c=relaxed/simple;
	bh=y2Jq/1sTO9uEXgLFoMducQ8+q4wvZZdN/bxg//IxqLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVvOxYx5gJDcjWcJ00sSQkNdBXm3Ej+2wz65wM4noGVY1dcE2BiqCeiysXQagn72Ap5uBe+3UtSdNAN7P2twCYudCpkuYMDsSi30n2nIQaTucFFHaGCtHL8Vgn4QHaKWxAhM5G72ZcnlmY+nF5HGqQCQ6omcToqBLaWCOSOmUqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y08XFSve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0556CC2BD10;
	Thu, 20 Jun 2024 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718893932;
	bh=y2Jq/1sTO9uEXgLFoMducQ8+q4wvZZdN/bxg//IxqLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y08XFSvewUnpzNuPedzf0bqc0ZjgTBbQTowDvANWiu4srrh4v3ye2ZBkkzBUEk7K5
	 gdhMNU2pIB2jDOoL8lvWSZUiRgEntZtN55x14v1+PocjrHrvcp8FYZRMdGW+6ZpV4C
	 OUmKH1C+P1xCKl1yfcLo3OqVtncw+vwcwv+Pu1dI=
Date: Thu, 20 Jun 2024 16:32:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 04/10] rust: add rcu abstraction
Message-ID: <2024062048-uptake-urethane-1432@gregkh>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-5-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618234025.15036-5-dakr@redhat.com>

On Wed, Jun 19, 2024 at 01:39:50AM +0200, Danilo Krummrich wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Add a simple abstraction to guard critical code sections with an rcu
> read lock.

Why?  Why not add this when we have code that actually needs it?

The driver model sure doesn't :)

thanks,

greg k-h

