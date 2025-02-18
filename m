Return-Path: <linux-pci+bounces-21772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985E2A3ABF5
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 23:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E2D16FF7D
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 22:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D32199EB2;
	Tue, 18 Feb 2025 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDArOd59"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B662862B7;
	Tue, 18 Feb 2025 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918764; cv=none; b=IjsgszNkTt6VnUFyo1T2TcpTfs4FQqf6Y80UZaaMa4FecymiG6ScncxowmiA5+TUJ+9VtIKy8NRXgHhWJdE8tmwT6IGy6TDDY0kkXmHQ49mf9yfMLnJE9HANy4D7TYediyyjBGYywYjDCkOt/SbS/DcSbF320PH9dMDNUWjSaEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918764; c=relaxed/simple;
	bh=letCvaV1jqhQZFktQQueCdQ3ndWTH/7syDKJLMYcFow=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XzfTB+91bUKBoa7HJny39T5NFrHysXk2fVjI7ozeTQ3M8oaJNx6JsmmNhytbMIrlI6ELECaR9gYLirD07VoQu9LYBxQe5YllleXBJYc6fPqeAAKF3Ne9oS/9/k3fl/nAIyMX9ctqCB8DZM0dSmdIEM+G1qOAn0wDUjQG8rWJZgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDArOd59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF9FC4CEE2;
	Tue, 18 Feb 2025 22:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739918763;
	bh=letCvaV1jqhQZFktQQueCdQ3ndWTH/7syDKJLMYcFow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XDArOd59vmDswSOel36BhVsWJu59U0+Qn4VOTXSwNqeK0H60F7p5QOIJkO6uOzTMC
	 uvoVrm3j6Rolz+xNArseRL+UIi7JOXalupHSSGi2YsbrWtbD9voRG1I/o+9yupIb5S
	 m2G9AHD25yrRAJP0EbPPnof9VxsLhweo2/xozrtYfDO5Ql0HMGtU6I4RrkXbBAGKn5
	 o5euf72/umt2wKPLy+70WK4zvueCOMu7rRZHgfATaErt4qOQwV3cFmqLZTw6X9d/pK
	 UgsC0uJwWXY6VewUMacebdv0VRg3mtwjz40mGtEp52+PDU4eFQ6V9jv5ImiVOK3c2d
	 Ci4YrX8wRsChQ==
Date: Tue, 18 Feb 2025 16:46:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: shpchp: Debug & logging cleanup
Message-ID: <20250218224602.GA198344@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217095550.2789-1-ilpo.jarvinen@linux.intel.com>

On Mon, Feb 17, 2025 at 11:55:48AM +0200, Ilpo Järvinen wrote:
> Hi all,
> 
> This series cleans up debug/logging in shpchp driver.
> 
> The series is an update for the only remaining patch in the pci_printk()
> removal series. To avoid breaking build, pci_printk() itself will only
> be removed in the next kernel release because both AER and shpchp used
> it and are in different topic branches.
> 
> v2:
> - Split removal of logging wrappers and module parameter removal to
>   own patches
> - Explain how dynamic debugging can be enabled
> 
> Ilpo Järvinen (2):
>   PCI: shpchp: Remove unused logging wrappers
>   PCI: shpchp: Remove "shpchp_debug" module parameter
> 
>  drivers/pci/hotplug/shpchp.h      | 18 +-----------------
>  drivers/pci/hotplug/shpchp_core.c |  3 ---
>  2 files changed, 1 insertion(+), 20 deletions(-)

Applied to pci/hotplug for v6.15, thanks, Ilpo!

