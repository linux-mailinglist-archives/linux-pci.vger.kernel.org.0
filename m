Return-Path: <linux-pci+bounces-41448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 659E1C65C3A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 19:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31C134E7C15
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 18:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBF93009C1;
	Mon, 17 Nov 2025 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="PSlPF+ur"
X-Original-To: linux-pci@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE5298CBC;
	Mon, 17 Nov 2025 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405087; cv=none; b=kUUAELPFbqU2US30e6LOODka9K9mhwcpu+t4Z0FciGUZe7c0uT6mZy4np0PMI3KOxQ+iNq5nchKNVJ7aOI3fKQ+qi486XIcscMk4VmgFOpnaZ1clDY91unu9/QnH2TThECJFosfvLjcGW0S3o2lAAmuLPAYlY5CZJ4/ZiVH2JPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405087; c=relaxed/simple;
	bh=E6LDDGfIBEycsLJ0ksYW0ru1zh2YSo1plV9nK0+PWkg=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l8UA38SAUtc/r4mXhmG9cTToJNsae6d7a5qo8LKPRhEY08eeDwbPIMVV0cCFp40NkUehZ2GPLxxeFMW0PNH98n7zOO/NNRADBfShFuTQNl1cpI6XeeM92jJb91v6l2q7SvdB1136uEVDlyI6OhPhQcsgG/cxASKX+xj60GGEKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=PSlPF+ur; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=o2xg6bCdid28Z8ZpNmY1tlqGdTfaGLQwtHhYdveoaVs=; b=PSlPF+urT7LP0V0wh1HUxG+/+a
	Mq8iCUCyzAhFMUvEe9i7qgGFYCfRiFc5PFoudkNnegIMNOUn8OQqBfTdPcxlcmBTsyqwq8pYXlHNV
	1cfnLwUwtc20B2P2VqtVqdKeL0K3vZzFks6qesoBwWjpCHcIAOax+Lz/VyBRtK5FnwhpeIPqAN5yp
	efB+jclWgwkA3DIRTs+0Onc/JnoECorvxbUUObrCyULYdHWrB9sXP3MI8RusX7E8iE0Sf0oklrVfK
	dJRjhXXWjVCyaJprUp2k9O1r9iLHFqkLefuSdCVmWFfWKzenMFZPUBM1ay8Y4rlRmFy6CIY1FpAvj
	5wJK5Ihg==;
Date: Mon, 17 Nov 2025 19:44:54 +0100 (CET)
Message-Id: <20251117.194454.783008412765588450.rene@exactco.de>
To: linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org, linux-pci@vger.kernel.org,
 clemens@ladisch.de, bhelgaas@google.com
Subject: Re: [PATCH] hwmon: (k10temp) Add AMD Steam Deck APU ID
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
In-Reply-To: <3b28873f-e72a-4fba-854e-e1be4576a338@roeck-us.net>
References: <20251117.193725.1655587639439350088.rene@exactco.de>
	<3b28873f-e72a-4fba-854e-e1be4576a338@roeck-us.net>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

On Mon, 17 Nov 2025 10:42:03 -0800,
Guenter Roeck <linux@roeck-us.net> wrote:

> On 11/17/25 10:37, René Rebe wrote:
> > Add AMD Custom APU 0405 PCI ID as used in the Valve Steam Deck to
> > k10temp.
> > Signed-off-by: René Rebe <rene@exactco.de>
> > ---
> > Tested for nearly three years on my first gen Steam Deck.
> > index b98d5ec72c4f..1ab64adb63e9 100644
> > --- a/drivers/hwmon/k10temp.c
> > +++ b/drivers/hwmon/k10temp.c
> > @@ -553,6 +553,7 @@ static const struct pci_device_id
> > k10temp_id_table[] = {
> >   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M40H_DF_F3) },
> >   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
> >   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
> > +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M90H_DF_F3) },
> >   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3) },
> >   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
> >   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 92ffc4373f6d..d86b203de1df 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -573,6 +573,7 @@
> >   #define PCI_DEVICE_ID_AMD_17H_M40H_DF_F3 0x13f3
> >   #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
> >   #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
> > +#define PCI_DEVICE_ID_AMD_17H_M90H_DF_F3 0x1663
> >   #define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3 0x1727
> >   #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
> >   #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
> >   
> 
> Per guidance for PCI device IDs, this should be defined locally in the
> k10temp driver, similar to PCI_DEVICE_ID_AMD_15H_M70H_NB_F3.

Oh man, all the other IDs are there, but of course I'll happily do a
v2!

	René

-- 
  René Rebe, ExactCODE GmbH, Berlin, Germany
  https://exactco.de | https://t2linux.com | https://rene.rebe.de

