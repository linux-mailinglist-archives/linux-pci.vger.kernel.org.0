Return-Path: <linux-pci+bounces-2484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A8C8392C7
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 16:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA49293999
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 15:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638B65FDCD;
	Tue, 23 Jan 2024 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh6yeZGq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B50B5FDCC;
	Tue, 23 Jan 2024 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024045; cv=none; b=uiAc94v/3dQsviQnf/JCACdTxTHODeDsimZOsfAMMTmWP284lFASqmztqC5YUDF9aUiJbfcNiw/2m+t0UMMIo3md4grk5ZCJI3io5+QKhxFYqkouAEv1PiD+dfoPyJSSyjpu87N6EBgewxyGiJI985OjW9qCQpU8TCuIK0YTqng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024045; c=relaxed/simple;
	bh=eO93GGLHp0ZcnzDKSh3eiLP5th+pkR8mzGIZ1UxqY2s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mBprgUtmBPzP1m/nmUOohBHTiKefm620uklfBWkbL/GyFWE5sf+CmaSiLsAfdZa4b9YXxLIEuCcAnt4onP1WBo6HQvlHOGUaz2TqqNnM1S8wQItPaRpSvlBNlpEgEf6krxkbUF3sTT4q6/6N1Wlkf622/GTaQrL9cU2N0Eve4AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh6yeZGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3955C433C7;
	Tue, 23 Jan 2024 15:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706024045;
	bh=eO93GGLHp0ZcnzDKSh3eiLP5th+pkR8mzGIZ1UxqY2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kh6yeZGq4zV2F2DkqVWr5sRKJMQhnkJOH2C1lJjjw4hkrGLiYK3ds6LVWqHJP0Pur
	 GfK/XWsVfKDa2DAF80+W49Cmpln/YuFS4wEWGXjUppYMacm/iBzTymHO0el+9b3eH/
	 Asqwvgmnn/gYe9bulNgdcmiXEtOdOuOVWcPQWy7XDCJD9d6wYt3bo8XzT6+kppcgVp
	 FvPvHhEZUQgpcsZA57g+FkCg4VXq3wauOUisZQa3nvmMgDylaM6c2UQSABpjDWGgRr
	 ORLbicBWjldkWWmPbzICNkOyuFdbiN98oSpmONgc/xZAYG9nioHSgpVYccj/VCtojw
	 yBOEbenGnnmDA==
Date: Tue, 23 Jan 2024 09:34:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Athul Krishna <athul.krishna.kr@protonmail.com>,
	"corentin.chary@gmail.com" <corentin.chary@gmail.com>,
	"acpi4asus-user@lists.sourceforge.net" <acpi4asus-user@lists.sourceforge.net>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: ERROR: Writing to dgpu_disable cause Input/Output error
Message-ID: <20240123153403.GA290377@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56911b37-c316-43b2-8dc9-10f6fd0a398d@gmx.de>

On Tue, Jan 09, 2024 at 11:29:19AM +0100, Armin Wolf wrote:
> Am 09.01.24 um 01:00 schrieb Bjorn Helgaas:
> > On Sat, Jan 06, 2024 at 11:33:35PM +0100, Armin Wolf wrote:
> > > Am 04.01.24 um 03:50 schrieb Athul Krishna:
> > > > On Thursday, January 4th, 2024 at 1:05 AM, Armin Wolf <W_Armin@gmx.de> wrote:
> > > > > Am 03.01.24 um 19:51 schrieb Athul Krishna:
> > > > > 
> > > > > > Hello,
> > > > > > This is my first time reporting an issue in the kernel.
> > > > > > 
> > > > > > Device Details:
> > > > > > 
> > > > > > * Asus Zephyrus G14 (||||||GA402RJ)
> > > > > > * Latest BIOS
> > > > > > * Arch_x86_64
> > > > > > * Kernel: 6.6.9
> > > > > > * Minimal install using archinstall
> > > > > > 
> > > > > > ISSUE: Using /dgpu_disable /provided by _asus-nb-wmi _to disable and
> > > > > > enable dedicated gpu,
> > > > > > causes system crash and reboots, randomly.
> > > > > > 9/10 times writing 0 to dgpu_disable will produce an Input/Output
> > > > > > error, but the value will be changed to 0, half the time system will
> > > > > > crash and reboot. While writing 1 to it doesn't produce an error, I
> > > > > > have observed system crash twice just after that.
> > > > > > 
> > > > > > Steps to Reproduce:
> > > > > > 
> > > > > > * Remove dpgu: echo 1 | sudo tee ../remove (dgpu path)
> > > > > > * echo 1 | sudo tee /sys/devices/platform/asus-nb-wmi/dgpu_disable
> > > > > > * echo 0 | sudo tee /sys/devices/platform/asus-nb-wmi/dgpu_disable
> > > > > > 
> > > > > > * echo 1 | sudo tee /sys/bus/pci/rescan
> > > > > > 
> > > > > > After writing 0 to dgpu_disable, there's an entry in journal about an
> > > > > > ACPI bug.
> > > > > > Output of 'journalctl -p 3' and lspci is attached.
> > > > > 
> > > > > Can you share the output of "acpidump" and the content of "/sys/bus/wmi/devices/05901221-D566-11D1-B2F0-00A0C9062910[-X]/bmof"?
> > > > > The bmof files contain a description of the WMI interfaces of your machine, which might be important for diagnosing the error.
> > > > > 
> > > > Here's the output of 'acpidump > acpidump.out' and 'cat /sys/bus/wmi/devices/05901221-D566-11D1-B2F0-00A0C9062910[-X]/bmof'
> > > Ok, it seems the ACPI code tries to access an object ("GC00") which does not exist.
> > > This is the reason why disabling the dGPU fails with -EIO.
> > > 
> > > I am unfortunately not that knowledgeable when it comes to PCI problems, i CCed the linux-pci mailing list in hope that
> > > they can better help you in this regard.
> >
> > FWIW, I don't know enough about what's going on here to see a PCI
> > connection.  I do see a bunch of PCI-related stuff around rfkill, but
> > I don't think that's involved here.
> > 
> > I think the path here is this, which doesn't seem to touch anything in
> > PCI:
> > 
> >    dgpu_disable_store
> >      asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, ..., &result)
> >        asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS, ...)
> >          asus_wmi_evaluate_method3
> >            wmi_evaluate_method(ASUS_WMI_MGMT_GUID, ...)
> >      if (result > 1)
> >        return -EIO
> 
> The issue happens when a PCI bus rescan is done after writing to "dgpu_disable".
> As a side note a bugzilla bugreport for this issue was recently created:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=218354

Ah, the original email talked about dgpu_disable causing Input/Output
errors and random crashes just after using dgpu_disable, so it wasn't
clear to me that the PCI rescan was related.

Athul, can you capture any information about the crash, e.g., an oops
or panic message?  Possibly a screenshot or video?

Booting with kernel parameters like "ignore_loglevel boot_delay=60
lpj=3200000" (might need tweaking and depends on
CONFIG_BOOT_PRINTK_DELAY) might be needed to slow things down enough
to capture.

Bjorn

