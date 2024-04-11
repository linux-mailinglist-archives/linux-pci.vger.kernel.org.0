Return-Path: <linux-pci+bounces-6140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E80BF8A1C70
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 19:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9E01F21813
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 17:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B8B19DF68;
	Thu, 11 Apr 2024 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="Rp/6YmRb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB11199EAC;
	Thu, 11 Apr 2024 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852579; cv=none; b=c7/wCZiz5cRmRoCR0guReZpu/0RqPuSM3PrF+N3jV1m/NtHizGLhUN+vEXp9sTql9fvPX62bZAOYX5poQdie0PThoJ5ZCnkz72YLXHN7r4VeX3fKWSX8CsfkP4S3qfycRkNJe2OXETCXNjleh2TJ86lXX06RXG8CZNSbr02SXjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852579; c=relaxed/simple;
	bh=WvA6WiAIcx48MsampV65+//J153uNQiTZJE17RY9yfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrbjBNL5UpLJa0Z6j0mK5pvkjh73RMNPNWBSR9ZTBXx/FWPYLz4kaKOgVAb03r14nh8Kd/WBubSE8dIEWROLTynjo2P3MZZcnZo1W1/ruGhwyOGHa2iC5wBGf/aqjo9T70TtlJiN8tkH2H/dOz/sdf5bVWtNvuvTHw+9wmZpPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=Rp/6YmRb; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712852571; x=1713457371; i=parker@finest.io;
	bh=hwWgxxmXda6kOw96M4hFTIyZvfWGTAS0PHP54N9tvUg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:
	 References;
	b=Rp/6YmRbqNs6BYufkZOMf/ZBhld93ZsokpFJWV9mAHPrYVKs7MhkVLDvq5YCmif1
	 RqzAHrjFm5Vb84aeOgEKLl8ztAJwjJs/6kQE27EunsbyGc8wg6eur13Y2KCdjcKY3
	 dGwmSia9+bvPlniGSmeLeVcgksNmdutiulXashSe4wLx4ClaCAHYgaUx/SoXoExg0
	 5EMsab31nxRgGmcnJGj2V8mKKQt7gZYm9sS+Mus+ZHj2VJvvCkq6lGM7XXhp8AuNn
	 deB8eOYwHqlP/Hyb2W+qXbCry/ayESA8ZPN+mGEVL1GDwXz9ESdh9Cg0aeYDYPgJ0
	 eCPBmTUjL/2E/tuqXw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LlDCS-1sVvuX2GM2-00b6Km; Thu, 11 Apr 2024 18:22:51 +0200
Date: Thu, 11 Apr 2024 12:22:48 -0400
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH 1/2] serial: exar: add missing CTI/Exar PCI IDs to
 include/linux/pci_ids.h
Message-ID: <20240411122248.5070c840@SWDEV2.connecttech.local>
In-Reply-To: <2024041124-blah-obligate-5f6d@gregkh>
References: <cover.1712846025.git.pnewman@connecttech.com>
	<936439b200c810f83076a710eab81acd1e79ec83.1712846025.git.pnewman@connecttech.com>
	<2024041124-blah-obligate-5f6d@gregkh>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pjdGvLr/eoeXrJdCn078IyqSe+0HQmPzG1q90oBpDFWQRB32DH2
 cCIfMeB/FWtUc0oPDKcfbnOFdoJsQa8Qiwq++9A73Q8qv2WoiS7xepA6vBR55tn1FBxyfUd
 2jpbLou1RCA9z1rfgiE8xbUPOhAUUz3BhBh1+nALzi6HdTTnN5lkdTceinyaYT8avPkuB2t
 GOA2lYntt1PTE0dA9NrgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aqGDdD3EIFw=;0d/rEnUuyg9oWdY1xKNe5Pmvl2G
 WU7QwO4nHirmSzCqtDlmcV/WSXbBG7VJxtepxuiPwS8GwORoMCD9ZOGPAW9xvLkIJxJJONyXU
 8EcFP873ITtDy1J1V/jgGgRAWl7G9opSSwlE1VYVCphddQmbj1qKtIEcLZQrOCvaWGOxqMFoB
 8fx1fjjjlPrrsVzJHDrTU5Wtg/ZRWgnZtPbqCk7Yvx3OSvPfodBH8NozhaJ9i2LWdQh42vlpW
 4rGZVKzrsz7nNnBFME+InyMfwIQj7RumBNzbFCcFen0UZHJPSeQNv8SUJxa4E/HqaSrb8PUBJ
 Q0EgXFIngPygONnDfpwSu24npTFDyGqQ/p2KeOUZ8yn1hW2wkyq2YTRSCvuEFqCr75o7Objnm
 +B2I3EKSBg92jZP5gJWmoKBBkfrojUmaq8iYUeCcGZZFCPKos1vA6EwELt1yewjHjZBfPxywl
 zKvaq/+7wMD1s4BRkpLIt53PP018mzaFIKH8Nya+nu1jue2MhesiuGkzc4r3nEDLbud/AJBH0
 C2u7Cgx8a6iqHbVl1KmLVKdJ9EzJDa0y9w+04dIjibLCj6hPDGDMbWyeR940j+lqICrUIyzrb
 Gg3hve4K2vgO9iyt8G9BxQMBQJiqmTJWUB4BhSlK74t4drNqcUEXDOvkcveSGINONMJhSt78Y
 krDZWB5rGiTT7P28SGaHP2nwfwQqicGdPoS9LRJG5HyuwIz+s1IOeLZ4k04jUMiqC2TIg/Y/F
 XiWCDchRsD061WMxoIQ2OLAN0i9UXpKnFIOXCgbPxJURIjSZkbzPtE=

On Thu, 11 Apr 2024 17:54:45 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Apr 11, 2024 at 11:29:26AM -0400, parker@finest.io wrote:
> > From: Parker Newman <pnewman@connecttech.com>
> >
> > - Added missing CTI serial car PCI IDs
> > - Added missing Exar XR17V25X PCI IDs
> > - Moved XR17V4358 and XR17V8358 PCI ID defines to pci_ids.h
>
> Did you read the top of the pci_ids.h file?  Don't add new ids there
> unless it is going to be needed in multiple files please.
>
> thanks,
>
> greg k-h
No sorry I missed that... I was just trying to consolidate them all
in one place.

Would it be better to move all the Connect Tech sub-IDs from
pci_ids.h into 8250_exar.c? Or should I just add the missing ones
to 8250_exar.c instead of pci_ids.h?

Thank you,
-Parker

