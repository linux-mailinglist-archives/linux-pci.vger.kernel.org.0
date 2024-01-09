Return-Path: <linux-pci+bounces-1855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2972E827BCB
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 01:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE248B230D2
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6261844;
	Tue,  9 Jan 2024 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxRdJ08g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBDC623;
	Tue,  9 Jan 2024 00:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D0FC433F1;
	Tue,  9 Jan 2024 00:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704758435;
	bh=bo+EEbnDZ6aEvoH8pDPBhBD6o65eAEZe9b3YzZCPuak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QxRdJ08g6H2N5VN9xG4xxeL1z9ezvJZC2Dr3gXCKooQFSNDZdF6qR0VsagAuVwyXM
	 cUOedrIBMyaaT60j+JwAJ4fKxjvqY2UqWSsskHd5fb+8Si9HT+jP/CbS8PZuZs+wLa
	 Qiu+/pjOsFHqZrrfNePML+FcGsS17EP11+HQP50CGVkMbeaw7b0gYG9SFzQvY9FDFK
	 a7ZDZLSoaZK5fkmJVVgojsipB3ewoMWBARS3tYi2PSM0iBpgTGgPlxhCFbHQIGXWaP
	 eyrDV3fD4oD7dNywAa9ZDQotzIClTFv5/jQ7CcsN1EG9yaJqfPb7bIKc+Zdl7I9t6k
	 of6+h/xq9f2/w==
Date: Mon, 8 Jan 2024 18:00:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Athul Krishna <athul.krishna.kr@protonmail.com>,
	"corentin.chary@gmail.com" <corentin.chary@gmail.com>,
	"acpi4asus-user@lists.sourceforge.net" <acpi4asus-user@lists.sourceforge.net>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: ERROR: Writing to dgpu_disable cause Input/Output error
Message-ID: <20240109000033.GA1986948@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af094d61-eec0-456e-aeba-6e80c95424c5@gmx.de>

On Sat, Jan 06, 2024 at 11:33:35PM +0100, Armin Wolf wrote:
> Am 04.01.24 um 03:50 schrieb Athul Krishna:
> 
> > 
> > 
> > 
> > 
> > Sent with Proton Mail secure email.
> > 
> > On Thursday, January 4th, 2024 at 1:05 AM, Armin Wolf <W_Armin@gmx.de> wrote:
> > 
> > 
> > > Am 03.01.24 um 19:51 schrieb Athul Krishna:
> > > 
> > > > Hello,
> > > > This is my first time reporting an issue in the kernel.
> > > > 
> > > > Device Details:
> > > > 
> > > > * Asus Zephyrus G14 (||||||GA402RJ)
> > > > * Latest BIOS
> > > > * Arch_x86_64
> > > > * Kernel: 6.6.9
> > > > * Minimal install using archinstall
> > > > 
> > > > ISSUE: Using /dgpu_disable /provided by _asus-nb-wmi _to disable and
> > > > enable dedicated gpu,
> > > > causes system crash and reboots, randomly.
> > > > 9/10 times writing 0 to dgpu_disable will produce an Input/Output
> > > > error, but the value will be changed to 0, half the time system will
> > > > crash and reboot. While writing 1 to it doesn't produce an error, I
> > > > have observed system crash twice just after that.
> > > > 
> > > > Steps to Reproduce:
> > > > 
> > > > * Remove dpgu: echo 1 | sudo tee ../remove (dgpu path)
> > > > * echo 1 | sudo tee /sys/devices/platform/asus-nb-wmi/dgpu_disable
> > > > * echo 0 | sudo tee /sys/devices/platform/asus-nb-wmi/dgpu_disable
> > > > 
> > > > * echo 1 | sudo tee /sys/bus/pci/rescan
> > > > 
> > > > After writing 0 to dgpu_disable, there's an entry in journal about an
> > > > ACPI bug.
> > > > Output of 'journalctl -p 3' and lspci is attached.
> > > 
> > > Hi,
> > > 
> > > Can you share the output of "acpidump" and the content of "/sys/bus/wmi/devices/05901221-D566-11D1-B2F0-00A0C9062910[-X]/bmof"?
> > > The bmof files contain a description of the WMI interfaces of your machine, which might be important for diagnosing the error.
> > > 
> > > Thanks,
> > > Armin Wolf
> > Here's the output of 'acpidump > acpidump.out' and 'cat /sys/bus/wmi/devices/05901221-D566-11D1-B2F0-00A0C9062910[-X]/bmof'
> 
> Ok, it seems the ACPI code tries to access an object ("GC00") which does not exist.
> This is the reason why disabling the dGPU fails with -EIO.
> 
> I am unfortunately not that knowledgeable when it comes to PCI problems, i CCed the linux-pci mailing list in hope that
> they can better help you in this regard.

FWIW, I don't know enough about what's going on here to see a PCI
connection.  I do see a bunch of PCI-related stuff around rfkill, but
I don't think that's involved here.

I think the path here is this, which doesn't seem to touch anything in
PCI:

  dgpu_disable_store
    asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, ..., &result)
      asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS, ...)
        asus_wmi_evaluate_method3
          wmi_evaluate_method(ASUS_WMI_MGMT_GUID, ...)
    if (result > 1)
      return -EIO

But if I missed it, let me know and I'll be happy to take another
look.

Bjorn

