Return-Path: <linux-pci+bounces-23070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1862A554DC
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 19:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA87188A6AD
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 18:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5A725C708;
	Thu,  6 Mar 2025 18:25:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEFD1A01B9;
	Thu,  6 Mar 2025 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285517; cv=none; b=ss/qSQBBflFOSFOYsEtIqJy59X3GDGazp+R2X0zXyDuXWbwYlH017TRHFX3OCqcTkcRTZ2isfLYtdsRdWKBoDlZyxfDAeiuMtn57iLrzrEVF/honIfnEpdJWr3Jzx2szzzsQqLUdLID/AF+1+MLHTHXL58Jzlzylh8JK/RlI2YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285517; c=relaxed/simple;
	bh=Xq+XQYMHYGkmTz8iLRFLigF6QisLFRgLCNzHoNhQ3cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C49A9wBjTKKbnVVd8EnJEm4wefI/G6TUsA+xVKi0lHoLWwa1cc7+crnEa+jHbOVWfUsP6t6GSJw7Rxa9nczODQd/pSl4cynPphkGt6l3U7+Bt7LDw98eRBAUJy9c1aeuYVcMjSdVebrWVpsjMDVuOrEG2s5+oOzAUGsx4wnS+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id C2547100D9429;
	Thu,  6 Mar 2025 19:18:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9AC1825EB1; Thu,  6 Mar 2025 19:18:53 +0100 (CET)
Date: Thu, 6 Mar 2025 19:18:53 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kenneth Crudup <kenny@panix.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, ilpo.jarvinen@linux.intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikl??vs Ko??es??ikovs <pinkflames.linux@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
Message-ID: <Z8nnDTfGCUvl8K9I@wunner.de>
References: <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
 <20250214162948.GJ3713119@black.fi.intel.com>
 <661459dd-67d0-4e1c-bb28-9adf1417f660@panix.com>
 <20250226084404.GM3713119@black.fi.intel.com>
 <Z77ak-4YsdAKXbHr@wunner.de>
 <20250226091958.GN3713119@black.fi.intel.com>
 <Z8YKXC1IXYXctQrZ@wunner.de>
 <20250304082314.GE3713119@black.fi.intel.com>
 <Z8nRI6xjGl3frMe5@wunner.de>
 <8d270603-4604-4c1c-b3a9-f596e2e8af6d@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d270603-4604-4c1c-b3a9-f596e2e8af6d@panix.com>

On Thu, Mar 06, 2025 at 08:56:44AM -0800, Kenneth Crudup wrote:
> On 3/6/25 08:45, Lukas Wunner wrote:
> > Thanks for testing.  Would you mind giving the below a spin?
> 
> Is this a separate commit on top of master, or along with your previous fix?

It's a separate commit on top of master.

Thanks,

Lukas

