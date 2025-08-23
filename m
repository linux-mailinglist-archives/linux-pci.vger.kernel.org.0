Return-Path: <linux-pci+bounces-34622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2E9B3272D
	for <lists+linux-pci@lfdr.de>; Sat, 23 Aug 2025 09:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B44565EF3
	for <lists+linux-pci@lfdr.de>; Sat, 23 Aug 2025 07:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9976E2248B5;
	Sat, 23 Aug 2025 07:14:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4F51E260C;
	Sat, 23 Aug 2025 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755933257; cv=none; b=uof/18dFHM/E40gd1jW3VrgWj8V3LCfmQPWtBY6lr83i/il98tDPp358lSXEeJ+RmF2Hxx1tq6ow4MUyX1mIbV79tvoWQ8fZIGuRpvoJqnIdSB5rJN6/fSYAGRssYw+Bc43bk4KwejDNT7uu+5KAHhGLFfR2TMb7xo9VK1VFX78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755933257; c=relaxed/simple;
	bh=DZ3hYx1rkMQxEOBSciXm3TiSc5s1BU9Ol0clHp0RWfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiO3krQKw9CDKQ8qnxE3G5sOX2kh9luFrXJKPS8RvOcBakTnhHrbaR4bbQ9BE46y7HEneXs6jAH0ftqc3+T/IOTGBxtFWUgg1vsFjpta7IRTMzNFCCpvFWrp6gC42EdDHBcTSgxh96sW4D6TE+HxsbfOiho4Hvk7s927P/ITTgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 913522C06841;
	Sat, 23 Aug 2025 09:14:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7FC2C54C67; Sat, 23 Aug 2025 09:14:06 +0200 (CEST)
Date: Sat, 23 Aug 2025 09:14:06 +0200
From: Lukas Wunner <lukas@wunner.de>
To: liziyao@uniontech.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	niecheng1@uniontech.com, zhanjun@uniontech.com,
	guanwentao@uniontech.com, Kexy Biscuit <kexybiscuit@aosc.io>,
	Lain Fearyncess Yang <fsf@live.com>, Mingcong Bai <jeffbai@aosc.io>,
	Ayden Meng <aydenmeng@yeah.net>
Subject: Re: [PATCH RESEND] PCI: Override PCIe bridge supported speeds for
 older Loongson 3C6000 series steppings
Message-ID: <aKlqPoa6jeoNJEPc@wunner.de>
References: <20250822-loongson-pci1-v1-1-39aabbd11fbd@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-loongson-pci1-v1-1-39aabbd11fbd@uniontech.com>

On Fri, Aug 22, 2025 at 05:15:58PM +0800, Ziyao via B4 Relay wrote:
> Older steppings of the Loongson 3C6000 series incorrectly report the
> supported link speeds on their PCIe bridges (device IDs 3c19, 3c29) as
> only 2.5 GT/s, despite the upstream bus supporting speeds from 2.5 GT/s
> up to 16 GT/s.

I assume these bridges (Root Ports?) are only found on LS3C6000 CPUs?

If so, please put the quirk in arch/loongarch/pci/pci.c or
drivers/pci/controller/pci-loongson.c alongside the existing fixups there.

drivers/pci/quirks.c is compiled on all arches and if these bridges
only exist on certain Loongson CPUs, the quirk isn't needed on other
arches and wastes memory.

Also, please consider adding entries for 3c19, 3c29 to the PCI IDs
database:

https://admin.pci-ids.ucw.cz/read/PC/0014

Thanks,

Lukas

