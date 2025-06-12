Return-Path: <linux-pci+bounces-29615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3806AD7D4C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 23:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B707A1A27
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 21:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC53C229B13;
	Thu, 12 Jun 2025 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBXBUAc2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD8188907;
	Thu, 12 Jun 2025 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749763174; cv=none; b=iaSfgiD2HGT4dPl+XqzLm29+d8GnDKeVVmEfEnteV5qrfqBQpVe7yR4zw9F4e/iPo9nlDqmtDSRnllTIZAf5GG7E9brm4BmJhnOzfgW3Kuu9TwSiZz3P3XpvQ4FfpOAA7O+a6r4Ni35KhREDQtcjbp8jvvCF3MPmHDtvWfIrrM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749763174; c=relaxed/simple;
	bh=asF3MBeaikLl2WvHINP9H/yGSdNfVW5Eh24JvUta9ic=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L1L84ZoQv53t/K/5ieTBk/zqf4D1cOags/RsuxiKHL/ydrGejd3ZNctinasEJk3aCmHSW9cj62cECC6r+QcarCfkVz8vTJ1DmX0Aarrn2DVCx08QgVVQ2aTCAx1VT3jwdxtPIQD0cWMzgLarYHcHZoZWpluzHaa6gds32RQlQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBXBUAc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56009C4CEEA;
	Thu, 12 Jun 2025 21:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749763174;
	bh=asF3MBeaikLl2WvHINP9H/yGSdNfVW5Eh24JvUta9ic=;
	h=Date:From:To:Cc:Subject:From;
	b=nBXBUAc25ee8S/1Dsg5BinbTUhUXoPifIgWHAt5MfUpd4l42+UENrdX60UhMhbUc8
	 XOsFCCyMukrCcjy6HxeB25kaoP1ycc7LinJudwUiWJx0agZTTblIg8LmLxZcok4G+g
	 kgB5nmo81sgu4mKjLNuMWMnCr65unITAuO34RPeSUdOJTxxkBtUkyCOyhuoNrNw51/
	 ijPDMYKbCBc/Kioae0c6ItkJtI0r+n3mRETIALmoYC0jyDCaCJwKwpLi+1PfUgvlSh
	 KkfsjnfVFv/ioDXMwob3lPmHhI5AnETzEP2CLExxwkEb6UNg7rq+y+lP9PSHtyBBzN
	 DtsO++xVqUrvg==
Date: Thu, 12 Jun 2025 16:19:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	netdev@vger.kernel.org
Subject: [bugzilla-daemon@kernel.org: [Bug 218784] New: doc for bug
 https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2015670]
Message-ID: <20250612211933.GA928761@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[submitter in bcc]

This is an old bug reported on Ubuntu as "[r8169] Kernel loop PCIe Bus
Error on RTL810xE"
(https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2015670).

Seems like we're seeing about 10 AER Correctable Error log messages
like this per second:

  pcieport 0000:00:1d.0: AER: Multiple Correctable error message received from 0000:01:00.0
  r8169 0000:01:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  r8169 0000:01:00.0:   device [10ec:8136] error status/mask=00000001/00006000
  r8169 0000:01:00.0:    [ 0] RxErr                  (First)

This is on a Dell Inc. Inspiron 3793/0C1PF2, BIOS 1.30.0 03/07/2024
with Realtek RTL810xE NIC.

Submitter tested a patch
(https://bugzilla.kernel.org/attachment.cgi?id=306243&action=diff)
that just masked PCI_ERR_COR_RCVR errors, which masked the problem,
but that patch isn't upstream and seems like a hack.

v6.16 will include ratelimiting for correctable errors, which will
help but it's still not a real solution.

I'm not sure what if anything to do here, I'm just forwarding to the
mailing list so it's not completely forgotten and to make it visible
to search engines.

----- Forwarded message from bugzilla-daemon@kernel.org -----

Date: Sat, 27 Apr 2024 09:04:55 +0000
From: bugzilla-daemon@kernel.org
To: bjorn@helgaas.com
Subject: [Bug 218784] New: doc for bug https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2015670
Message-ID: <bug-218784-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=218784

            Bug ID: 218784
           Summary: doc for bug
                    https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2015670
        Regression: No

Created attachment 306225
  --> https://bugzilla.kernel.org/attachment.cgi?id=306225&action=edit
doc for bug https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2015670

As requested by bjorn-helgaas for bug
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2015670
attaching zip file with:
dmesg.txt - complete dmesg log (includes some Correctable Errors)
lspci-command - terminal message from lspci
lspci-output - output of "sudo lspci -vv"
grub-txt - grub default modified with "pcie_aspm=off" ... makes a difference
dmesg-2.txt - complete dmesg log with "pcie_aspm=off"
lspci-2-output - with "pcie_aspm=off"
inxi.txt

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----

