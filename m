Return-Path: <linux-pci+bounces-40820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B16C4B8C2
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 06:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB873ACF66
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 05:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA161A5B9E;
	Tue, 11 Nov 2025 05:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="f8k+f7Ie";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="rDunH+4s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC4D192B75
	for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2025 05:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762839210; cv=pass; b=kkI+fRTUKZTp1p6OD+X+KUu5Bd/K+nwjEG5PrraHGiOZStGA+fOxtx9XZBzffcgEYnAoHRjw6Eymf0pTMQKDUPf49QbSi0y52KSjWImWL6EKvm9zRPkN0m7d1rGRcMQkJGGqAuKsEf6Z7WYTUuw+0HHQagYcHOmplkop4mB0XC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762839210; c=relaxed/simple;
	bh=e0T6Eg5+354yvr2SvdbepArM/7XH7CHlBxA9pQkTOeI=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y9yFFErYJve421NE3MzIJGUFYR8qaKbtCjcu69RtrAQCnp1ejdw1IBUG9uw+DN3tNBgahzWxOQbkU+f5J7KZu9RS7zqj5h0oN1yUcpjrhzE/gq5UkRqYxn6aFh7yR9l+gXQ0pojl0aIxGNaG+b2b87DKIzy8VLUMDaA7STWC12E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=f8k+f7Ie; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=rDunH+4s; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1762838122; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LfLIjviE1tbZSSPoCIlJKbBFhJ1YofGAtO2bpz8rGBzrhlzsRS+/I9kCe0XiUk0dzu
    c+Uh9pZTpCFX24Z64FzLKERaFohCIJK6jd3dHUuYVV4ZMyAWtKYWoluwFUxhQ8AVRgp3
    XRK+FbXPdj8OebACmpj7MOA7rWq1p8marOsDFn319O7h6bzvIfBXhr6R9fO+Ht6s9qEg
    75vTRGO8vXnNubQFFQ8eaIhxxWn0sw3atZ12hcq2+SIkZ+WznfOcgkJroldWJ5Z2HRLn
    TmBlBVS5Ao0EFhibxcVdV9Hom9tMCxIi0ltori5l1E2mk/u3OfMHPWpA5K4FkEenvUgv
    0StA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762838122;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=jKBUuUa4oR7Nvr5P+NYccWwL8x0fRGPM+IBOcI+Nhd4=;
    b=kofvY7jgAIQZLhmSdoSYcxWwMFO0CRpYRXBrb8zR3BnAS1RpIkjgw2+6TL1x/L9aF8
    ajj7Bg9pvqR6t2bFNFoBjfoSKA+qamLAfrQvLOYHcC04TBlYk/cHQF/1e/UnXaCytCiF
    A8K81XIEBJc/fgwOul2wo8BrMXA2QduumtPUly8JbIZdFK2LBD+aqUFpEH30A+qz+q0u
    iFQzY3KuweWY60KQZ6Lj4LV/ae5a5hSk2MfWq7ufT8CXx/rz0a7qTUXCIy5YEjkkChU+
    c3mMmxxudNCewKvDbvSYwKR6U1wlJ86U7eFM4U1vAC/nI7vNJXxzX5FE7YRDSsvBdbwT
    1KHw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762838122;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=jKBUuUa4oR7Nvr5P+NYccWwL8x0fRGPM+IBOcI+Nhd4=;
    b=f8k+f7IezPmXZR+XJb6PDZnJPMgGoU+MybdSqIyBGfWYfS6ap6Fsb/SJNsTiFxmcvI
    oVKYrGBHsTYlIXSRTHN3j1zio1TESF45LNqj4BZRpr5LcRO59bc1rlcb1/Hvzt8Imw8a
    1UcxAybR99eR4IU+8+T7eAmwpL+FC98ybV/WqyRwfL5Alcx/PimiExW8ewmrck4+Sm7D
    j8kaZcglFRlI7OKCxjiFIURvhYk2NAHURx/h4wV6XVdZaV2/KVeswOSlhFsIdaVIbJYD
    t/QsCkuqjp1Vaay8okDAKa5q5vaLua0IDRCdTQHffJ1EdAlVUf4S6XLc0xRwdVv7LmoN
    dFpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1762838122;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=jKBUuUa4oR7Nvr5P+NYccWwL8x0fRGPM+IBOcI+Nhd4=;
    b=rDunH+4se3mh0PITDkhoPuUC4sZRtr2Gx3SewEDZaSZ3fstrtYXaWfQQnwVW6dD5J4
    kp0Pj6bKkeHBMRDrFLDA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIS+m7xLg"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 54.0.0 DYNA|AUTH)
    with ESMTPSA id ed69d81AB5FLE2r
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 11 Nov 2025 06:15:21 +0100 (CET)
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Lukas Wunner <lukas@wunner.de>, regressions@lists.linux.dev,
 luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>
References: <20251105220925.GA1926619@bhelgaas>
 <3a384a25-0256-e827-2d66-9efc5723965d@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <a41d2ca1-fcd9-c416-b111-a958e92e94bf@xenosoft.de>
Date: Tue, 11 Nov 2025 06:15:20 +0100
X-Mailer: BrassMonkey/33.9.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3a384a25-0256-e827-2d66-9efc5723965d@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/07/2025 06:06 AM, Christian Zigotzky wrote:
> On 11/05/2025 11:09 PM, Bjorn Helgaas wrote:
> >> I tested your patch with the RC4 of kernel 6.18 today. 
> Unfortunately it
> >> doesn't solve the boot issue.
> >
> > Thanks for testing that.  I see now why that approach doesn't work:
> > quirk_disable_aspm_l0s_l1() calls pci_disable_link_state(), which
> > updates the permissible ASPM link states, but pci_disable_link_state()
> > only works for devices at the downstream end of a link.  It doesn't
> > work at all for Root Ports, which are at the upstream end of a link.
> >
> > Christian, you originally reported that both X5000 and X1000 were
> > broken.  I suspect X1000 may have been fixed in v6.18-rc3 by
> > df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree
> > platforms"), but I would love to have confirmation of that.
>
> Hello Bjorn,
>
> I will enable CONFIG_PCIEASPM and CONFIG_PCIEASPM_DEFAULT for the RC5 
> of kernel 6.18 and test it with the X1000.
>
> Thanks,
> christian
>

Hello Bjorn,

I tested the RC5 of kernel 6.18 with CONFIG_PCIEASPM and 
CONFIG_PCIEASPM_DEFAULT enabled on my X1000 today. Unfortunately the 
boot problems are still present.

Cheers,
Christian

-- 
Sent with BrassMonkey 33.9.1 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_33.9.1)


