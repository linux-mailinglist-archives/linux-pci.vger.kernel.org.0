Return-Path: <linux-pci+bounces-42756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45365CAD196
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 13:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E955730141DB
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 12:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E71314A75;
	Mon,  8 Dec 2025 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VORRtjrG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7688314A6C;
	Mon,  8 Dec 2025 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765196007; cv=none; b=DHkD9ctP81vEF1xqR7zqrxPd5RRRiOAGPInz8RtVEsU1mis76S+kx2ZKJrqK/FAka/c/GdwP3ELdaGpqC2gSq6gPywLmBVMVvDLJpsPKZc6NHlHTfxo0pIk2jwUQqj/S98yQbpHRdyxH54+TisNhcB0mySSSYssbsHK2Ue0ArnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765196007; c=relaxed/simple;
	bh=QT1cYzJ0OCPEqCV4HiqaEUQCcHIt5O3Vx7pvI4RAA6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SS8TtZgCuoKeGCofaPL11BXIiJvUcaXzg38ejYdLEa+f5vqcvaQPV/LjO29Ea+gCCJyPpuHOXL9s+Tg/2p7HwzOyabePCUD4kU5xZ0rrs2tSr5oQt/r47tvNVGt1qLoFm+6gzmr4GRAjJLn3zC6QgeywnRK63r5XzhhmcPCNWks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VORRtjrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB81AC4CEF1;
	Mon,  8 Dec 2025 12:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765196007;
	bh=QT1cYzJ0OCPEqCV4HiqaEUQCcHIt5O3Vx7pvI4RAA6w=;
	h=From:To:Cc:Subject:Date:From;
	b=VORRtjrGBgyYSZTUDa8hj7y8yUSBEikYDCCdcsHvqjz490CpOcL0TprXOMf/yiDa5
	 mJ/hjAL+NAThm8XEY39oqfm9QqDVOhdae6mAw2526XenWRU9Lv2wr1DIQ9QALeB8NK
	 hBJL4Wv67gmSADTnM9VUqTXAveCgxsEUO1VppCAs4KvKJruH72SFIAuTr2Xy49ayAe
	 IzeC8gMl0enkzTZciKuLG4fM58OW3mU2cVInKw9kZNWlUNXKcso1N2POTtwXHUbol1
	 1RKl+QIl68uCZjHtBtz1VlkHXSawPPLsMqeGEVrZue4ONW+eWRVEmdqU/4AdKjjNAN
	 +R+VDGjpI2umA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 0/2] PCI: ACPI: PM: Rework root bus wakeup notification setup and
 wakeup source registration
Date: Mon, 08 Dec 2025 13:09:16 +0100
Message-ID: <2395536.ElGaqSPkdT@rafael.j.wysocki>
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




