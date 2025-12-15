Return-Path: <linux-pci+bounces-43047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E46D4CBDE64
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 13:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 595A5303C988
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 12:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4303376A5;
	Mon, 15 Dec 2025 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GA8Q0wmO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4AB3375DD;
	Mon, 15 Dec 2025 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765802996; cv=none; b=jvH54FavhcZKTINkTC+gln1yJOo0goSYNOL3eUHCsW+szhxiS24fKkaJR76HaBbSz1AjX5rihWRoApkhdAdP0sGlWd1AQkVX8JU/7HPCjw2IS9bBOeuCC/8u1SzCkpD2Mlotuyxxvqx7+lax+tCIxzSvzGBX1B6SsN7Wrg7oQP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765802996; c=relaxed/simple;
	bh=fCCPr5iQvOB2jjge0tog4UECpwiMHqoqKpApNJcabb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fip5qbmVJ+Zwe/TlfoMzGZMwyD14gt5nIHcfsZxQe+TllJlimTNlcb7a6U2dESxYC+kIC1TGh4GEhMteC8j2TU7RtdB8wv8FYwcmu6ke/azeFIUv4W2ePc08vkCI23AXYHr+B/Q7O8iFQ1uMe37kNAvCe6yFmT7Yht0zmNCVfbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GA8Q0wmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE11C4CEF5;
	Mon, 15 Dec 2025 12:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765802995;
	bh=fCCPr5iQvOB2jjge0tog4UECpwiMHqoqKpApNJcabb4=;
	h=From:To:Cc:Subject:Date:From;
	b=GA8Q0wmOEV44uQVrc75rz5gFl4wARSf5ea7fxJaEA6Up0vYKAeCAb9xrIrkXDXzs2
	 uIisWGQOyqegvv/DT+sPM4jXDWNt9It0KxvW3ZZAdOx2+CsFXltARyjZthzgsMrTgh
	 J+UJE+wr1gGEWqgBcHlLurtwMGNnsz82X/XeVQc+BRN5s00kuJ1zbcHOMdd5UqHc3n
	 WFVuy0eyOqzZSlueOJ3/J7dAKDgr5XKe/HXpfi5N0FBPKF2Zzh2ftSRa2/8eLQgQ5M
	 DwW1rFs+vcE36NPjV/fL3PK1WK3Xo5j5BSGkbZXvwaBXQxr0t6V92Y08rLiHH7c/Me
	 WKlUEMNLbjPlw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [RESEND][PATCH v1 0/2] PCI: ACPI: PM: Rework root bus wakeup notification
 setup and wakeup source registration
Date: Mon, 15 Dec 2025 13:45:17 +0100
Message-ID: <6223429.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This is a resend of

https://lore.kernel.org/linux-acpi/2395536.ElGaqSPkdT@rafael.j.wysocki/

which was sent in the middle of the merge window.

I have added R-bys from Armin to both patches, but otherwise there are no
changes, so the version is still 1.  I'd appreciate feedback, but if there's
none, I'll be queuing up these patches for 6.20.

The description below still applies.

Patch [1/2] updates the registration of PCI root bus wakeup notification setup
in order to simplify code in pci_acpi_wake_bus() and to prepare for the other
change.  This is not expected to affect functionality.

Patch [2/2] modifies the ACPI PM notifier registration to add wakeup sources
under devices that are going to be affected by wakeup handling instead of
registering them under ACPI companions of those devices (rationale explained
in the patch changelog).  This will change the sysfs layout (wakeup source
devices associated with PCI wakeup are now going to appear under PCI devices
and the host bridge device), but it is not expected to affect user space
adversely.

Thanks!




