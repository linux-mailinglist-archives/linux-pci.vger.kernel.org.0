Return-Path: <linux-pci+bounces-15331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E917C9B07F4
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 17:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD08B283B6E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 15:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18562161E4;
	Fri, 25 Oct 2024 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="QnvAp3tY"
X-Original-To: linux-pci@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD320F3F1
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869496; cv=none; b=J/aQKwhN8R5T8oCUGTFusmncDp1fubmIwcr5pACA8mjsHqTnu/g/6gBMfJU3gdN4X2GJg0YN5TRyVpUlEXxmNtHQqXIAMlI1Z3UUCXR9EgwpVNVzWUvsZd+0r3/rjGX07rCDCB/1PNR0m850YDUL2ep/Z7fb7sRnAZe3BUpUJng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869496; c=relaxed/simple;
	bh=Cp9FSnTlH6bdvVMpEKMvRbQ5i2H60iAjX87XIB2uWE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkPAMMlnlsu2iJgZnALNlO3JpxVruMQAPvZPEc6w7PdQTAaiBH5QjQG5XJBpYWxSlmdlkSmk6TpqJLv1sX9brtsyvyYV4y2WpMRHp3sC6xZe+MIr8soz7+L3Z10tb4BtkQSqNLBBNPe/wVg340kkwhQf4z6+ikIduWpfKFapW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=QnvAp3tY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49PFI2wH026442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 11:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729869484; bh=+3/YlMW+NiPuVTOTB6zPtTx6MGg/Ovh8Uq4NZbG/uyg=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=QnvAp3tYpFsuWp5t6MYLl3aEfmGEHnXsYn3xojrYaP7hfyadCIz6ul249CuoovpUA
	 Q/ZRiCbCtkKpoJEewwmK2oksxGgkoj3gUKwI7DC4VLXKsTjZXxCNiFBKejH61UoH+w
	 yXYNJeGvoLFpeWlnvQmGzEgkqKKOo75fOmihQOlVnvaN5Hmky+GtPAnVjY7KvA0sIa
	 SF7vmZc+rwxBiLglrVldK+znmbyAG3zk3UsAId0ihgwylnx0dNRsY+PBDDgF8UZ3u1
	 N73wPFu6LL8zbXNfiMp33II4/Lo2dHic7WcScSjWD9siXkJD7Cag6J82MmmeHDnDly
	 NMT9//KY/BIxw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 28BF715C0329; Fri, 25 Oct 2024 11:18:02 -0400 (EDT)
Date: Fri, 25 Oct 2024 11:18:02 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: Hantong Chen <cxwdyx620@gmail.com>, james.bottomley@hansenpartnership.com,
        ajhalaney@gmail.com, allenbh@gmail.com, andrew@lunn.ch,
        andriy.shevchenko@linux.intel.com, andy@kernel.org, arnd@arndb.de,
        bhelgaas@google.com, bp@alien8.de, broonie@kernel.org,
        cai.huoqing@linux.dev, dave.jiang@intel.com, davem@davemloft.net,
        dlemoal@kernel.org, dmaengine@vger.kernel.org, dushistov@mail.ru,
        fancer.lancer@gmail.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, ink@jurassic.park.msu.ru, jdmason@kudzu.us,
        jiaxun.yang@flygoat.com, keguang.zhang@gmail.com,
        kory.maincent@bootlin.com, krzk@kernel.org, kuba@kernel.org,
        linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux@armlinux.org.uk, linux@roeck-us.net,
        manivannan.sadhasivam@linaro.org, netdev@vger.kernel.org,
        nikita.shubin@maquefel.me, nikita@trvn.ru, ntb@lists.linux.dev,
        olteanv@gmail.com, pabeni@redhat.com, paulburton@kernel.org,
        robh@kernel.org, s.shtylyov@omp.ru, sergio.paracuellos@gmail.com,
        shc_work@mail.ru, siyanteng@loongson.cn, tsbogend@alpha.franken.de,
        xeb@mail.ru, yoshihiro.shimoda.uh@renesas.com, phoronix@phoronix.com
Subject: Re: linux: Goodbye from a Linux community volunteer
Message-ID: <20241025151802.GC3307207@mit.edu>
References: <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
 <20241024165650.174-1-cxwdyx620@gmail.com>
 <20241024173504.GN3204734@mit.edu>
 <cc264780-0c16-4209-8736-ada156994eaa@metux.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc264780-0c16-4209-8736-ada156994eaa@metux.net>

On Fri, Oct 25, 2024 at 03:35:37PM +0200, Enrico Weigelt, metux IT consult wrote:
> 
> Okay, great. I'm fully on your side: let's sanction all countries that
> like to wage wars of aggressions against other countries and kick out
> all maintainers from there.

Sanctions are imposed by Governments --- for example, the US,
European, Japan, Switzerland, Norway, etc.  Not Linux developers, nor
Russian troll farms, nor Russia's useful idiots on the internet.  It's
not up to anyone on this mail thread.

I see from your country code in your signature that you apparently
live in Germany.  Please note that if you violate Germany's laws and
regulations, whether it's by supplying bomb-making technical
assistance to a terrorist group, or lending technical assistance to
sanctioned entities directly or indirectly controlled by the Russian
Military-Intelligence, you could be subject to civil or criminal
penalties.  And that's not up to me; it's up to your elected leaders
and Germany's judicial system.

If you don't like this, I cordially invite you to exercise your
democratic rights and make your opinions known to your fellow citizens
and to your elected politicians.

      	      		       	       - Ted

