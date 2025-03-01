Return-Path: <linux-pci+bounces-22692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E80A4A8F7
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 06:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E55F3BCDE4
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 05:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EC31CB51B;
	Sat,  1 Mar 2025 05:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fHCSgJkw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FDA1CAA9A;
	Sat,  1 Mar 2025 05:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740807144; cv=none; b=EV2e7mjdr5srjRbQIzW08TdgL/uR8ujnHGCs8ZU4kwHZ1ZxzgUVrF9tsmIuVCtlgJS/LuCH+eLuaC5GQPWlRO23jQ5uEIqrpqfrvm60d7Bt9gMZj7Zs5tkrPWlayuzU1Gm/T6pbui1xYUC59in4fXD6auHXW0BaQ0xt34RvVWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740807144; c=relaxed/simple;
	bh=VEK9HYRYVkhasrLuuC7CBzehseqnultElL00wstGlwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICl2jHCtZwKROGjMNfdWS6B6CNocXIxOa1/tna34MYF5c3n348MRzJUH3vEjaFARHi+GOJmVlUfCSV6QwSFQTIR35c5WFonqdzReq4WFjVC8KDPb+BodbeRUo3Y4k8plwCMj7hheeT44MjAMarbEcDgTnEn8ukYSylYoyGKHLc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fHCSgJkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EDBC4CEDD;
	Sat,  1 Mar 2025 05:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740807144;
	bh=VEK9HYRYVkhasrLuuC7CBzehseqnultElL00wstGlwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fHCSgJkwctQ59gcgi5Fe+94hFZNealRW2wdDdFlZ8RBdtZ5IA7tjUh3jHxCty1NwL
	 u/BQl4JZ7UvkEEln0yu1zhSR6QF59UJ5bBWM0XFs+LwEgVxs7TY8tNpppjoz/C2+xN
	 lC+nE3/YIlBITuw6yzQl+Hl1szVZ5P1OCi56Osok=
Date: Fri, 28 Feb 2025 20:33:17 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	Alistair Francis <alistair@alistair23.me>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	Jonathan.Cameron@huawei.com, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com, wilfred.mallawa@wdc.com,
	aliceryhl@google.com, ojeda@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, gary@garyguo.net, alex.gaynor@gmail.com,
	benno.lossin@proton.me, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are
 authenticated
Message-ID: <2025022820-briskly-museum-c14d@gregkh>
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me>
 <2025022717-dictate-cortex-5c05@gregkh>
 <Z8DqZlE5ccujbJ80@wunner.de>
 <2025022748-flock-verbalize-b66a@gregkh>
 <CAKmqyKMHMo7_EeZ1fvSKKE0i1nm1QS5x4PYJBe1Yx8r4nqwpgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMHMo7_EeZ1fvSKKE0i1nm1QS5x4PYJBe1Yx8r4nqwpgA@mail.gmail.com>

On Fri, Feb 28, 2025 at 12:55:30PM +1000, Alistair Francis wrote:
> On Fri, Feb 28, 2025 at 11:41 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Feb 27, 2025 at 11:42:46PM +0100, Lukas Wunner wrote:
> > > On Thu, Feb 27, 2025 at 03:16:40AM -0800, Greg KH wrote:
> > > > On Thu, Feb 27, 2025 at 01:09:41PM +1000, Alistair Francis wrote:
> > > > > The PCI core has just been amended to authenticate CMA-capable devices
> > > > > on enumeration and store the result in an "authenticated" bit in struct
> > > > > pci_dev->spdm_state.
> > > > >
> > > > > Expose the bit to user space through an eponymous sysfs attribute.
> > > > >
> > > > > Allow user space to trigger reauthentication (e.g. after it has updated
> > > > > the CMA keyring) by writing to the sysfs attribute.
> > > > >
> > > > > Implement the attribute in the SPDM library so that other bus types
> > > > > besides PCI may take advantage of it.  They just need to add
> > > > > spdm_attr_group to the attribute groups of their devices and amend the
> > > > > dev_to_spdm_state() helper which retrieves the spdm_state for a given
> > > > > device.
> > > > >
> > > > > The helper may return an ERR_PTR if it couldn't be determined whether
> > > > > SPDM is supported by the device.  The sysfs attribute is visible in that
> > > > > case but returns an error on access.  This prevents downgrade attacks
> > > > > where an attacker disturbs memory allocation or DOE communication
> > > > > in order to create the appearance that SPDM is unsupported.
> > > >
> > > > I don't like this "if it's present we still don't know if the device
> > > > supports this", as that is not normally the "sysfs way" here.  Why must
> > > > it be present in those situations?
> 
> I do think there are 4 situations
> 
>  1. Device supports authentication and was authenticated
>  2.
>   a) Device supports authentication, but the certificate chain can't
> be authenticated
>   b) Device supports authentication, but the communication was interrupted
>  3. Device doesn't support authentication
> 
> Case 1 and 3 are easy
> 
> Case 2 (a) means that the kernel doesn't trust the certificate. This
> could be for a range of reasons, including the user just hasn't
> installed the cert yet. So it makes sense to pass that information to
> the user as they can act on it. I think it's a different case to 3
> (where there is no action for the user to take).

Ok, that's fine, but as a "default" you should fail such that the device
is not allowed to actually do anything if 2) happens.  I think you are
doing that, it's the whole use of sysfs as the user/kernel api here in
an odd way that I am objecting to.

> > Again, are we now claiming that Linux needs to support "hardware
> > glitching"?  Is that required somewhere?  I think if the DOE exchanges
> > fail, we just trust the device as we have to trust something, right?
> 
> This is case 2 (b) above. If an attacker could flip a bit or drop a
> byte in the communication path they could cause the authentication to
> stop.
> 
> The process to authenticate a device involves sending a lot of data,
> so it's not impossible that an attacker could interrupt some of the
> traffic.
> 
> If the DOE exchange fails I don't think we want to trust the device,
> as that's the point of SPDM. So being able to communicate that to
> userspace does seem really useful.

Agreed, but again, let's come up with a better api than "a random sysfs
file is present but reading it gets an error to convey this is an
unvalidated device" feels wrong to me.

Why not just report the "state" of the device?  You have 3 states, just
report that?  Should be much simpler overall.

> > > Of course, this is an abnormal situation that users won't encounter
> > > unless they're being attacked.  Normally the attribute is only present
> > > if authentication is supported.
> > >
> > > I disagree with your assessment that we have bigger problems.
> > > For security protocols like this we have to be very careful
> > > to prevent trivial circumvention.  We cannot just shrug this off
> > > as unimportant.
> >
> > hardware glitching is not trivial.  Let's only worry about that if the
> > hardware people somehow require it, and if so, we can push back and say
> > "stop making us fix your broken designs" :)
> 
> Hardware glitching is hard to do, but SPDM is designed to protect
> against a range of hard attacks. The types of attacks that nation
> states would do. So I think we should do our best to protect against
> them.Obviously there is only so much that software can do to protect
> against a hardware glitch, but this seems like a good in between.
> 
> I don't think the design is overall broken though. At some point when
> all devices support SPDM it becomes a non issue as you just fail if
> authentication fails, but in the mean time we need to handle devices
> with and without authentication.

Agreed, again it's the user/kernel api I am objecting to here the most.

> > > The "authenticated" attribute tells user space whether the device
> > > is authenticated.  User space needs to handle errors anyway when
> > > reading the attribute.  Users will get an error if authentication
> > > support could not be determined.  Simple.
> >
> > No, if it's not determined, it shouldn't be present.
> 
> That doesn't allow us to differentiate the cases I mentioned above though.
> 
> Another option is we could create multiple attributes "spdm",
> "authenticated" and "spdm_err" for example to convey the information
> with just yes/no attributes?

Yes!  Or a simple "spdm_state" file that has one of these values in it?
sysfs files do not need to only return "1 or 0", they can return
different strings, but only 1 at a time.

thanks,

greg k-h

