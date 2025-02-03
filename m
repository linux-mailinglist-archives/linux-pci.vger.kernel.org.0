Return-Path: <linux-pci+bounces-20676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708EEA26445
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 21:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC197A3162
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 20:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527F81DACB1;
	Mon,  3 Feb 2025 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUvrNH8v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B0B522A;
	Mon,  3 Feb 2025 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738613570; cv=none; b=jhn+igES6wkEXr0P7u5pl3M7Ez9pySzMw4IIkK/oH9dRgakFeGmZcLqya1ga4Rq3i6gU3u03dgl0JBVmUE8PfFxkvyhtOTcS35RHWeZfh1UKQ/BK50H/VkIqrIvNbyST5myhW5qswnKb6m2rGv2fRZSh0AxPj9w8huaq/biXXVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738613570; c=relaxed/simple;
	bh=eG2IPK5sPmlrFBWUFh+RLYKGrlmKlAjDRe5QcO5P5GI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rz4bnVjvPh97yNKxM2mKiU1k0B1KbV12ZmCO77W5gjdqLOHRSLlJwOzVoG9w7Tk/CSYpG+xkIZ4fuKVaHbCZZK+oiRXaOQog9fNuaOyVlm5YGkJt1LpAZhD5uMvo5nbPc3S1T7oAdl/CezXy1B1+NPpD7k2EMkxhQplKjLruDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUvrNH8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8726AC4CEE5;
	Mon,  3 Feb 2025 20:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738613569;
	bh=eG2IPK5sPmlrFBWUFh+RLYKGrlmKlAjDRe5QcO5P5GI=;
	h=From:Date:Subject:To:Cc:From;
	b=eUvrNH8vZx4QvXbGaLJSOP/oGTGtQzUzDuwspkYhOOOWhwVidxK92O4KNRyHK/91Q
	 uRpJ7Sp8TDy+7RG6iUxQUBo7yROijvNTgxBwpS96YfJurmXnFNfF+n9+LaYleFHdSg
	 YVQMYWLvlQfaN+wqKGFLKnneOMwHxddm6WOXrAy5nSu0C6xFMy66oco6O0SgDVPWD8
	 /m7DAowV8RcRK4ZmRiiF79WR9Je1D2f1UmJZVTGibLsPelNBG0sFrIxrm+f/B7xRQ/
	 dE2iId4QASVHZ9TwSQuBkP7RX6EnrJmLy7cRBfcP/clMW7EokbXaFS6dlYnyJ9Xkj+
	 ltGD9nVD++MLg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5f321876499so2535256eaf.1;
        Mon, 03 Feb 2025 12:12:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9WjvqfSJg9vXrc6evEFLXaRUUWRZUull+9+b3wUq4aJzmM0Ijd+ukbg0J2cDOZAmYorCw11Gw/NlEE2g=@vger.kernel.org, AJvYcCXq5RNMSlW2MhHrQBnhhYLhrvkkAXSnFvcimiM9RkibSYRjwLbUtKPWEFqXGloywoenG19dJf+Yd08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfmWXDcsnFAGo2p9nWgY3onBVmOuuaLHoK2U+R8DGQN+BtzzOS
	zdU0zv/xSMcGD8mQg/fWnNSkQsQB4TyTz0KbX16CzpAo5mWruYZOE2YntTasidpDc3XIoHr55Qm
	JKI3yIqNZpCTD2E2Lanca6/vVg1U=
X-Google-Smtp-Source: AGHT+IFvlcyI88YyxfQjmWaIJxi8/D3mhhw/h/Xarh0sXbPC6zgrTUKXc7dWN9ur49vtzFJmYvzJdmhEg0leG78Mr0o=
X-Received: by 2002:a4a:d08b:0:b0:5f2:c0df:7ed5 with SMTP id
 006d021491bc7-5fc3bf5874fmr386760eaf.3.1738613568803; Mon, 03 Feb 2025
 12:12:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Feb 2025 21:12:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iKmynOQ5vKSQbg1J_FmavwZE-nRONovOZ0mpMVauheWg@mail.gmail.com>
X-Gm-Features: AWEUYZlg0pfw8ANAD7dIS37BOlgitXSC9gnRxIBpuMXS1W0hQkz8dJAWXX3S_UY
Message-ID: <CAJZ5v0iKmynOQ5vKSQbg1J_FmavwZE-nRONovOZ0mpMVauheWg@mail.gmail.com>
Subject: [Regression in 6.14-rc1] System suspend/resume broken by PCI commit 1db806ec06b7c
To: Bjorn Helgaas <bhelgaas@google.com>, Jian-Hong Pan <jhp@endlessos.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

The following commit:

commit 1db806ec06b7c6e08e8af57088da067963ddf117
Author: Jian-Hong Pan <jhp@endlessos.org>
Date:   Fri Nov 15 15:22:02 2024 +0800

   PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()

   After 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for
   suspend/resume"), pci_save_aspm_l1ss_state(dev) saves the L1SS state for
   "dev", and pci_restore_aspm_l1ss_state(dev) restores the state for both
   "dev" and its parent.

   The problem is that unless pci_save_state() has been used in some other
   path and has already saved the parent L1SS state, we will restore junk t=
o
   the parent, which means the L1 Substates likely won't work correctly.

   Save the L1SS config for both the device and its parent in
   pci_save_aspm_l1ss_state().  When restoring, we need both because L1SS m=
ust
   be enabled at the parent (the Downstream Port) before being enabled at t=
he
   child (the Upstream Port).

   Link: https://lore.kernel.org/r/20241115072200.37509-3-jhp@endlessos.org
   Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for
suspend/resume")
   Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
   Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
   Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
   [bhelgaas: parallel save/restore structure, simplify commit log, patch a=
t
   https://lore.kernel.org/r/20241212230340.GA3267194@bhelgaas]
   Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
   Tested-by: Jian-Hong Pan <jhp@endlessos.org> # Asus B1400CEAE

broke system suspend/resume on my Dell XPS13 9360.  It doesn't even
pass suspend/resume testing after "echo devices > /sys/power/pm_test".

It looks like PCIe links are all down during resume after the above
commit, but it is rather hard to collect any data in that state.

Reverting the above commit on top of 6.14-rc1 makes things work again,
no problem.

I'm unsure what exactly the problem is ATM, but I'm going to check a
couple of theories.

Cheers, Rafael

