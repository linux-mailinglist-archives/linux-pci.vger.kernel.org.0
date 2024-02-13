Return-Path: <linux-pci+bounces-3421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1300F85405E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 00:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413441C26407
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 23:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFDE6313D;
	Tue, 13 Feb 2024 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEAGqcCb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC16313A;
	Tue, 13 Feb 2024 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868353; cv=none; b=RZhXWWatORf9gF7jUC0sjHrtGQ9DYtA50nUHY4qGyUenPdl7LJAvevF4CRCueC9+ER6vby4VSLdBtonsIamtqxAroOl9ePPm+ibbojR3Z4uVV1nw9LC9Pjs1oD0miNKmXazi9ZeVHlY+/k4mx+qpWhxyQjKXoRt7+GEPne2XvM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868353; c=relaxed/simple;
	bh=f9SkOanpk9cjbIEF9cgwCrbTjfeHhRN/JwWknwHbfoE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GsUdm8F1ijrYSxIjwX+gCOZ2fg/usfOSZYY20PEpavuP032E5vLz02QSB4sOYL4MlG2oov2wZcJwgRqXyMFlAUDOZwlTgEhr+cyVTRhnrVekCmd06GTW4khxjsQXA9HTWCuYj0kunAmREQGmk95CH11vf9lTke7EOb9dtbVZwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEAGqcCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB0DC433C7;
	Tue, 13 Feb 2024 23:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707868353;
	bh=f9SkOanpk9cjbIEF9cgwCrbTjfeHhRN/JwWknwHbfoE=;
	h=Date:From:To:Cc:Subject:From;
	b=IEAGqcCbe1uaHY/rXDR9LgRIEQRRtw7GKf0pWvhaMTddMNAlvTvmGtStrydIW5Mwu
	 hHhC3qrnvfO8DMlwFB8GeoL1V03Rwu2OhjqdKzJ00IKRin7tgsvJKN6Dnds8/pETNn
	 MbxtGrNtUmDlAXuoTu4LQGXCpF1nvi6YjlMNYecbmpLYathVoY9mXFPIFTXxQAHUBR
	 qUokDMyzFfwd6MAmxsZG8gXVPyx02FjqGlcle+qcjRGsxuAMZYkMCMeYdYTH05OBMF
	 ZZV4kv7I3/gddTjxbfhVjJkG5iaZ+Do61hDn7XnDYhqaYw9+LDUILFIGGlhCRNoGlE
	 VLMvQFc7XpVPA==
Date: Tue, 13 Feb 2024 17:52:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "Wang, Qingshun" <qingshun.wang@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: ixgbe probe failure on Proxmox 8
Message-ID: <20240213235231.GA1235066@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Just a heads-up about an ixgbe probe failure seen with Proxmox 8.  I
suspect this is a PCI core problem, probably not an ixgbe problem.

The ixgbe device logs an Advisory Non-Fatal Error and it seems like
subsequent reads from the device return ~0:

  pcieport 0000:00:03.1: AER: Corrected error received: 0000:05:00.0
  pci 0000:05:00.0: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
  pci 0000:05:00.0:   device [8086:1563] error status/mask=00002000/00000000
  pci 0000:05:00.0:    [13] NonFatalErr

  ixgbe 0000:05:00.0: enabling device (0000 -> 0002)
  ixgbe 0000:05:00.0: Adapter removed

The user report is at
https://forum.proxmox.com/threads/proxmox-8-kernel-6-2-16-4-pve-ixgbe-driver-fails-to-load-due-to-pci-device-probing-failure.131203/post-633851. 

I opened a bugzilla with complete dmesg log at
https://bugzilla.kernel.org/show_bug.cgi?id=218491 with some
speculation about what might have caused this, e.g., an ACS
configuration error or something.  It's lame, I know, so this is just
a shot in the dark.

Bjorn

