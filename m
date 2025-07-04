Return-Path: <linux-pci+bounces-31549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8D1AF9AAA
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 20:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69233A6BC8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 18:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C07326232;
	Fri,  4 Jul 2025 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbp9Jy8g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93A12E5B2F;
	Fri,  4 Jul 2025 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653422; cv=none; b=cZdxLR8QnhA3FrxDByMHqxOxN7D9QYSbTdKa0/I6cb22VmTUfIAiRWjYlz/3wyEqVSMxT3k9o2bOV+6lBVWbLZKFH11pUcs1vbT4P1Lp4aisgbSJe4QJDjnEpZ9CCHOBMe8vDhNIhY+YpiUQmnMATnJnCx6ebaXHKfN53hUWmDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653422; c=relaxed/simple;
	bh=3pH+Y4O8bckOvutEYgAYJmeTwbmIePCo5O7dkXcpQgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOn8ovmGhIYL3AN2z9qKBRk1ez4WYbiQsXuQA65tsya5je+hq6zWxzROfjHHemvtBaFK0oQV08as7SM6wGLPvP4rBhOMuvh84qar0AHq9mFh+vEXowzc96M4c7vjYaQrgWuC/RRzeUmqP167n/Zj570zh4jDoMQKU7HPa4Hf75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbp9Jy8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9786AC4CEED;
	Fri,  4 Jul 2025 18:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751653422;
	bh=3pH+Y4O8bckOvutEYgAYJmeTwbmIePCo5O7dkXcpQgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dbp9Jy8g2stuA4FSJSZ99tWTyJk8s0xFMznY7pB194Y95hzin1KJ/Wi9a3R1Q6J/8
	 hX/fYkVdgQIPBnxu6ZXurRG1Gigp58+20L468kP55Tde7aEkZIKvdx4+VTQLvn80YY
	 hY4zKK5ixSpv79lGw8ZIzVAQJIgKuL7ngWWNqC1n5MfNmyptOLBtN7oqs2Kqqlt2YR
	 1QTiynfZBbdPR8VeGWOAJL1rcD6dJXeKd8ZsdVVmQ125OmozfxLiPAOXy/sSmTTKID
	 4LFasroPipk5H0/K/hCiXvex14LFnzL3b6ygno83PkNUXa2hyN6T38quvq9SDGzJNV
	 SL/023MiNLWDA==
Date: Fri, 4 Jul 2025 20:23:35 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Benno Lossin <lossin@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 5/6] rust: platform: add irq accessors
Message-ID: <aGgcJxM_nKkFGtGn@cassiopeiae>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-5-74103bdc7c52@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-topics-tyr-request_irq-v6-5-74103bdc7c52@collabora.com>

On Thu, Jul 03, 2025 at 04:30:03PM -0300, Daniel Almeida wrote:
> +impl Device<Bound> {
> +    /// Returns an [`IrqRequest`] for the IRQ at the given index, if any.
> +    pub fn request_irq_by_index(&self, index: u32) -> Result<IrqRequest<'_>> {
> +        // SAFETY: `self.as_raw` returns a valid pointer to a `struct platform_device`.
> +        let irq = unsafe { bindings::platform_get_irq(self.as_raw(), index) };
> +
> +        if irq < 0 {
> +            return Err(Error::from_errno(irq));
> +        }
> +
> +        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&self`.
> +        Ok(unsafe { IrqRequest::new(self.as_ref(), irq as u32) })
> +    }

Sorry that I didn't notice that before: Please just name the functions returning
an IrqRequest e.g. irq_by_index(), without the 'request' prefix. And instead put
the 'request' prefix in front of the methods that return a actual
irq::Registration.

This is more in line with the C functions being named request_irq() and
request_threaded_irq().

