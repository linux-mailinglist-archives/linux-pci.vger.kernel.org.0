Return-Path: <linux-pci+bounces-24834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B7EA72F0A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061E9189CEA9
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 11:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C02212B35;
	Thu, 27 Mar 2025 11:25:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D730F19D88F;
	Thu, 27 Mar 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074704; cv=none; b=cfVlDd8nCLA4iWd3wZIFrxqfWn8hpXQEoUWPX8fNMQio8CiT4ZpRGKnaGtxChDIybyUfZyOxO5kUK0WoXrndhiR25OkN+mvZBik0HTrklfAcDDfSj7tHnQugvgHA9tQ17XarG142RkXNIahMPJpsQ7t/+jdMA2p/xoolsOaVx/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074704; c=relaxed/simple;
	bh=xNEJGvolYtK1Skck/AARiHgntbdJWOBW+iw/bO4sqow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gd3l383dSgPiAogcNjW5dKube0p7mX3+DT+xOQn95oxbIATasnC1Em0N0eL5OpCDDFLlszpA2sAKrbwCBQtNTcyk8oMJ+onHZ0bYvdFA7GDacH7kLbMawX7l+akKwPFZv72BiU17vDxbyJRx3DXTE37inxVjtogbnChRZx/91uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: bizesmtp83t1743074667ta4suz20
X-QQ-Originating-IP: C9bYwwGjtIIR1ZI4wF0sfJ4mGucg6QVP1LES2zf8J90=
Received: from localhost ( [103.233.162.252])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Mar 2025 19:24:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8515293745481605160
Date: Thu, 27 Mar 2025 19:24:26 +0800
From: Yibo Dong <dong100@mucse.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add MUCSE vendor ID to pci_ids.h
Message-ID: <1835B10BD36E99AC+20250327112426.GB468890@nic-Precision-5820-Tower>
References: <20250325065718.333301-1-dong100@mucse.com>
 <20250326165728.GA1339144@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326165728.GA1339144@bhelgaas>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MUtpDbzatTjwKerDep8phZQLNLW17fdSbInUx9hTVMNnphu8ifUPLZoM
	vTeE45DnNoJgh4XOoSlCpjdohuUFzfDZKYzgwsqPDYVmCe6VyXLL/CivLpSi4o+OigxK7Cu
	WuViwH0WX5VTp/PWrP8uFKcbrlR9BtvI3S5PfTVVM46AkbqZ7XbVMzSBjQk4qm1Zi9wSk8x
	j9Knt2VVrO1navhUpQsfKsoqRI15teiNPXKQs8BcIyGw8XM4+6z7dL/OKoLd6e7I/RypN1J
	Mz1wCklCcCOPUq/WrgqB61KTntQO/VSoj0QNZgdNpaXJM7V1oFWA+TnAoT9b/OaM1vfV1pl
	Nwbl2ZN7tS+V+vG1APu6ZT+IYno4nrGZXcPeg2E0hHvjBnEdxQrmJu2EQ7Mte30GMJEjydk
	IkDyQfG0wvzd+yzMSd8ponWi15PVXjMWF2+hq8279p0Tu5FkY8SWrdyWLOe2JSKN+is+mua
	VGw/NYyqHKDO9Rr33QzfEeNLCa3DJYAyvM5XREW/6iGEXb3K2cZ5TKdCbFQ2S92fgQRwH56
	yMnFPOlqcTCsDs3mW/iOzX5gJWcGRagbH1CQkmoxnx7jHcsCwlqjej8TfuaQy69L3fury2I
	rRIYRf0QgvNCtSyj1tctN0F4zkWgl0d95Y1vLquKIk3+q2EhPMzvYv/jO0nYUJdoB2Z4qvG
	4dC57v1aZpXvvzGdoNjnK+pPy6W+AlD8pT6hFZtbIxNh4ZVQ0+M0ks/+RLDy8upWH8OglbJ
	ltVDnnoC9aCKXwtPZ/+eeS8+5H7MMTt9fkYI/MUjZcqATBSKQ/SPanDzuPjm7i/vHjZQT80
	lk5MG0XftBkqlhDutXrnxBKjB60UaeUEtP2gLYYjp9/3E5fOdJC2K49WimsP18QELBG579F
	fLKocc06PS6rsTFWr78IrsgWHgWqPRgG0+xTyT89/XdyBvMivGPh6ntW8hF9TI6RTA1Eplg
	bDfoGHt8x1cf12l0oFAu6Rdsup1iKwT56IT3FaSSU7nPCZFfwFa5mkz5ZYNSdkegoaMt3x9
	SgF/fl2wwcspYnl23JXve6YAHXJmJEGuDf9murvQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Wed, Mar 26, 2025 at 11:57:28AM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 25, 2025 at 02:57:18PM +0800, Yibo Dong wrote:
> > Add MUCSE as a vendor ID (0x8848) for PCI devices so we can use
> > the macro for future drivers.
> > 
> > Signed-off-by: Yibo Dong <dong100@mucse.com>
> 
> Please post this in the series where you add the future drivers.
> 
> We don't add new things to pci_ids.h unless they are actually used by
> more than one driver because it complicates life for people who
> backport things (there's a note at the top of the file about this).
> 

Thanks for the reminder; the drivers maybe use 'the define' are netdev drivers,
so, I should first send patches to netdev subsystem, and re-send this patch
to pci subsystem after my patches is applied by netdev subsytem? or I should send 
this to netdev subsystem along with the drivers?

> > ---
> >  include/linux/pci_ids.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index de5deb1a0118..f1b4c61c6d3c 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -3143,6 +3143,8 @@
> >  #define PCI_VENDOR_ID_SCALEMP		0x8686
> >  #define PCI_DEVICE_ID_SCALEMP_VSMP_CTL	0x1010
> >  
> > +#define PCI_VENDOR_ID_MUCSE		0x8848
> 
> https://pcisig.com/membership/member-companies?combine=8848 says this
> Vendor ID belongs to:
> 
>   Wuxi Micro Innovation Integrated Circuit Design Co.,Ltd
> 
> I suppose "MUCSE" connects with that somehow.
> 
> It's nice if people can connect PCI_VENDOR_ID_MUCSE with a name used
> in marketing the product.  Maybe "MUCSE" is the name under which
> Wuxi Micro Innovation Integrated Circuit Design Co.,Ltd markets
> products?
>

Yes, MUCSE is just abbreviation for “Wuxi Micro Innovation Integrated Circuit
Design Co.,Ltd”

> >  #define PCI_VENDOR_ID_COMPUTONE		0x8e0e
> >  #define PCI_DEVICE_ID_COMPUTONE_PG	0x0302
> >  #define PCI_SUBVENDOR_ID_COMPUTONE	0x8e0e
> > -- 
> > 2.25.1
> > 
> 

