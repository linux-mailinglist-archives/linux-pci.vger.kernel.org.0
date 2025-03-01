Return-Path: <linux-pci+bounces-22704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CDEA4AD31
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 19:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E04D1709FD
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 18:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433E81E0DE8;
	Sat,  1 Mar 2025 18:01:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2570A8BF8;
	Sat,  1 Mar 2025 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740852111; cv=none; b=Tbc+7cbQXv4+NmmjlU5lZhfvsOU1vdf+3GPRqCyGG4DqCWKFlzdAReIXhcSefckVsMwaKu8x8YnYc3WtdCQFS8qs1ljFpejsePly1J6uDP0YmoIAzGRlCoNwRqVp7S3hrUiOvFHHpX7VzFABNfjum9wlY8ZpErq9wIWKbvIgRAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740852111; c=relaxed/simple;
	bh=klqCN48Ny/H3BoJ3S0qc0BU0Owh8CJ6llnu/vJfC6BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9o8FeIGVgcSpcJWlXIJZJCAS9kuxGYt9nmQxxWGpu9engGSYC+iGhRhBQAF46IQXE6mDqzcN2IOb/0zqOX8DS+fsngSjCoXynw5fcQoknlECpJsQBhbiaA4TdJ8eng+tvMgr1ss79tIm3JqKR3hYp6J65Xy/1IKobMfeMM5FZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4A030280C374E;
	Sat,  1 Mar 2025 19:01:39 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 347955E0BCC; Sat,  1 Mar 2025 19:01:39 +0100 (CET)
Date: Sat, 1 Mar 2025 19:01:39 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alistair Francis <alistair@alistair23.me>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org,
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
	wilfred.mallawa@wdc.com, aliceryhl@google.com, ojeda@kernel.org,
	alistair23@gmail.com, a.hindborg@kernel.org, tmgross@umich.edu,
	gary@garyguo.net, alex.gaynor@gmail.com, benno.lossin@proton.me,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are
 authenticated
Message-ID: <Z8NLgxmDbcC9_C3F@wunner.de>
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me>
 <2025022717-dictate-cortex-5c05@gregkh>
 <Z8DqZlE5ccujbJ80@wunner.de>
 <2025022748-flock-verbalize-b66a@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022748-flock-verbalize-b66a@gregkh>

On Thu, Feb 27, 2025 at 05:39:53PM -0800, Greg KH wrote:
> On Thu, Feb 27, 2025 at 11:42:46PM +0100, Lukas Wunner wrote:
> > On Thu, Feb 27, 2025 at 03:16:40AM -0800, Greg KH wrote:
> > > I don't like this "if it's present we still don't know if the device
> > > supports this", as that is not normally the "sysfs way" here.  Why must
> > > it be present in those situations?
> > 
> > That's explained above.
> 
> Not really, you just say "downgrade attacks", which is not something
> that we need to worry about, right?

A downgrade attack means duping the victim into believing that only
a weaker security mode is supported.  E.g. only sha1, but not sha256.

In this context, downgrade attack means duping the kernel or user
into believing that SPDM authentication is unsupported, even though it is.

https://en.wikipedia.org/wiki/Downgrade_attack

That's definitely something we need to be aware of and guard against,
otherwise what's the point of authenticating in the first place.


> > Unfortunately there is no (signed) bit in Config Space which tells us
> > whether authentication is supported by a PCI device.  Rather, it is
> > necessary to exchange several messages with the device through a
> > DOE mailbox in config space to determine that.  I'm worried that an
> > attacker deliberately "glitches" those DOE exchanges and thus creates
> > the appearance that the device does not support authentication.
> 
> That's a hardware glitch, and if that happens, then it will show a 0 and
> that's the same as not being present at all, right?

No, the "authenticated" attribute is not present in sysfs if authentication
is unsupported.

The downgrade attack protection comprises exposing the attribute if it
could not be determined whether authentication is supported or not,
and returning an error (ENOTTY) on read or write.

User space applications need to check anyway whether read() or write()
failed for some reason.  E.g. if the device is hot-removed concurrently,
the read() system call returns ENODEV.  So returning ENOTTY is just
another error that can occur on access to the attribute.

The idea is that user space typically wants to check whether the attribute
contains "1", signifying that the device was authenticated successfully.
Hence a return value of "0" or any error code signifies that the device
is not authenticated.

And if user space wants to check whether authentication is supported at all,
it checks for presence of the sysfs attribute.  Hence exposing the attribute
if support could not be determined is a safety net to not mislead user space
that the device does not support authentication.

For PCIe, glitching the hardware (the electric signals exchanged with
the device) is indeed one way to disrupt the DOE and SPDM exchanges.

However the SPDM protocol has not only been adopted by PCIe, but also
other buses, in particular SCSI and ATA.  And in those cases, glitching
the SPDM exchanges may be a pure software thing.  (Think iSCSI communication
with storage devices in a remote rack or data center.)

Damien Le Moal has explicitly requested that the user space ABI for SPDM
is consistent across buses.  So the downgrade attack protection can be
taken advantage of by those other buses as well.


> > Let's say the user's policy is to trust legacy devices which do not
> > support authentication, but require authentication for newer NVMe drives
> > from a certain vendor.  An attacker may manipulate an authentication-capable
> > NVMe drive from that vendor, whereupon it will fail authentication.
> > But the attacker can trick the user into trusting the device by glitching
> > the DOE exchanges.
> 
> Again, are we now claiming that Linux needs to support "hardware
> glitching"?  Is that required somewhere?

Required?  It's simply prudent to protect users from being duped into
thinking the device doesn't support authentication.


> I think if the DOE exchanges
> fail, we just trust the device as we have to trust something, right?

If the DOE exchanges fail, something fishy is going on.
Why should we hide that fact from the user?


> > The device needs to be re-enumerated by the PCI core to retry
> > determining its authentication capability.  That's why the
> > sysfs documentation says the user may exercise the "remove"
> > and "rescan" attributes to retry authentication.
> 
> But how does it know that?

Because reads and writes to the attribute return ENOTTY.

> remove and recan is a huge sledgehammer, and
> an amazing one if it even works on most hardware.  Don't make it part of
> any normal process please.

It's not a normal process.  It's manual recovery in case of a
potential attack.  The user can also choose to unplug the device
or reboot the machine.  That's arguably a bigger sledgehammer.


> It's the error, don't do that.  If an error is going to happen, then
> don't have the file there.  That's the way sysfs works, it's not a
> "let's add all possible files and then make userspace open them all and
> see if an error happens to determine what really is present for this
> device" model.  It's a "if a file is there, that attribute is there and
> we can read it".

The point is that if the file isn't there even though the device might
support authentication, we're creating a false and dangerous illusion.
This is different from other attributes which don't have that quality.


> > > > Alternatively, authentication success might be signaled to user space
> > > > through a uevent, whereupon it may bind a (blacklisted) driver.
> > > 
> > > How will that happen?
> > 
> > The SPDM library can be amended to signal a uevent when authentication
> > succeeds or fails and user space can then act on it.  I imagine systemd
> > or some other daemon might listen to such events and do interesting things,
> > such as binding a driver once authentication succeeds.
> 
> That's a new user/kernel api and should be designed ONLY if you actually
> need it and have a user.  Otherwise let's just wait for later for that.

Of course.  Again, the commit message makes suggestions for future
extensions to justify the change.  Those are just ideas.  Whether
and how they are implemented remains to be seen.  Signaling a uevent
on authentication success or failure seems like an obvious idea,
hence I included it in the commit message.

I fear if I don't include those ideas in the commit message, someone
will come along and ask "why do you need this at all?", thus putting
into question the whole set of authentication patches.


> > > If an attacker can consume kernel memory to cause this to happen you
> > > have bigger problems.  That's not the kernel's issue here at all.
> > > 
> > > And "disable communication" means "we just don't support it as the
> > > device doesn't say it does", so again, why does that matter?
> > 
> > Reacting to potential attacks sure is the kernel's business.
> 
> Reacting to real, software attacks is the kernel's business.  Reacting
> to possible hardware issues that are just theoretical is not.

We have fundamental disagreement whether certain attacks need to be taken
seriously.  Which reminds me of...

   "the final topic on the agenda was the corporate attempt at
    security consciousness raising; a shouting match ensued,
    in the course of which several and various reputations
    were sullied, certain paranoid reactions were taken less
    than seriously, and no great meeting of the minds was met."

   [minutes of the uucp-lovers interest group, 20 April 1983,
    from "A Quarter Century of UNIX" (1994) page 113]
    https://wiki.tuhs.org/lib/exe/fetch.php?media=publications:qcu.pdf

Looks like we're just upholding the time honored tradition of
UNIX security disagreements!

Thanks,

Lukas

