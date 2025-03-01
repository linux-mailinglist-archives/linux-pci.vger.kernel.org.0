Return-Path: <linux-pci+bounces-22691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F29BA4A8F4
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 06:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10993BAB99
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 05:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDDE1C5F22;
	Sat,  1 Mar 2025 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WkSu3mBR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101D71C5F18;
	Sat,  1 Mar 2025 05:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740807142; cv=none; b=tRNx2Lo33KvC4aa42QKV/UqqX6xhXzfVSDOi9DvBo53exv1+C33dFf97FQ0mr6rkr1kx30jMhedckxQGwLOhXeUsX5EwF+1rQJdG0iHFR8D3m7pjO1sn7Trz7wh0kqMvt6LXDlArxp5ngMsI6pSYPxHkasKnTF0+T0BT+M+VNkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740807142; c=relaxed/simple;
	bh=TdB0mwgEyxYmgov8Ed3f89rKpgIPCvGHHfJfd3FzNLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxVatbivLh7wJgdRzaGzmyahIbw+H/cEClZ3mPiUB0aWDN6giEvuz9Xr8yfu9HTVE4u7fE8ogMaU+jASahB1LT2cK4vxdaY0Sfsu/WXwDL62k4nfaFr4GPSMvE6Sgt4ujzRbYlaMk0U83u9A6eOCsyVdd7IGucPEDKhwRvBkL7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WkSu3mBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A866C4CEDD;
	Sat,  1 Mar 2025 05:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740807141;
	bh=TdB0mwgEyxYmgov8Ed3f89rKpgIPCvGHHfJfd3FzNLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WkSu3mBRdikSkb9e2lpn894O1h8MCoZmHitj20Na1smd1/rusQ3C11Atdytx0MgWQ
	 2qZcmsuLG7HPgFQZmdt1OKh1U7jHWkH+iGfxXkNJRLviDMx0qwkINqPdELznsYqjES
	 HJy+dm+OnOzrRz4uUGY4RwBPBi5oC67OLHzbyy7A=
Date: Fri, 28 Feb 2025 20:27:10 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alistair Francis <alistair@alistair23.me>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	lukas@wunner.de, linux-pci@vger.kernel.org, bhelgaas@google.com,
	Jonathan.Cameron@huawei.com, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com, wilfred.mallawa@wdc.com, ojeda@kernel.org,
	a.hindborg@kernel.org, tmgross@umich.edu, gary@garyguo.net,
	alex.gaynor@gmail.com, benno.lossin@proton.me,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are
 authenticated
Message-ID: <2025022851-usual-backshift-7ea6@gregkh>
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me>
 <2025022717-dictate-cortex-5c05@gregkh>
 <CAH5fLgiQAdZMUEBsWS0v1M4xX+1Y5mzE3nBHduzzk+rG0ueskg@mail.gmail.com>
 <2025022752-pureblood-renovator-84a8@gregkh>
 <CANiq72kS8=1R-0yoGP5wwNT2XKSwofjfvXMk2qLZkO9z_QQzXg@mail.gmail.com>
 <2025022749-gummy-survivor-c03a@gregkh>
 <CAKmqyKNei==TWCFASFvBC48g_DsFwncmO=KYH_i9JrpFmeRu+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKNei==TWCFASFvBC48g_DsFwncmO=KYH_i9JrpFmeRu+w@mail.gmail.com>

On Fri, Feb 28, 2025 at 12:27:36PM +1000, Alistair Francis wrote:
> On Fri, Feb 28, 2025 at 5:33 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Feb 27, 2025 at 05:45:02PM +0100, Miguel Ojeda wrote:
> > > On Thu, Feb 27, 2025 at 1:01 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > Sorry, you are right, it does, and of course it happens (otherwise how
> > > > would bindings work), but for small functions like this, how is the C
> > > > code kept in sync with the rust side?  Where is the .h file that C
> > > > should include?
> 
> This I can address with something like Alice mentioned earlier to
> ensure the C and Rust functions stay in sync.

Yes, that looks to be fixed up now and should not be an issue.

> > > What you were probably remembering is that it still needs to be
> > > justified, i.e. we don't want to generally/freely start replacing
> > > "individual functions" and doing FFI both ways everywhere, i.e. the
> > > goal is to build safe abstractions wherever possible.
> >
> > Ah, ok, that's what I was remembering.
> >
> > Anyway, the "pass a void blob from C into rust" that this patch is doing
> > feels really odd to me, and hard to verify it is "safe" at a simple
> > glance.
> 
> I agree, it's a bit odd. Ideally I would like to use a sysfs binding,
> but there isn't one today.
> 
> I had a quick look and a Rust sysfs binding implementation seems like
> a lot of work, which I wasn't convinced I wanted to invest in for this
> series. This is only a single sysfs attribute and I didn't want to
> slow down this series on a whole sysfs Rust implementation.
> 
> If this approach isn't ok for now, I will just drop the sysfs changes
> from the series so the SPDM implementation doesn't stall on sysfs
> changes. Then come back to the sysfs attributes in the future.

Please do that, we can revisit the sysfs stuff later.

> So the high level question, is "pass[ing] a void blob from C into
> rust" ok or should I defer for a future safer implementation?

I don't think we want random void * blobs being passed between C and
Rust like that as ensuring that both sides really know what is happening
and keep that in sync is going to be impossible over time.  Type safety
is our friend :)

thanks,

greg k-h

