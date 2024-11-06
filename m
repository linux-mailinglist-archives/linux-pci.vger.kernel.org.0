Return-Path: <linux-pci+bounces-16160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AF59BF45E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 18:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CF91C21D32
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 17:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE919645;
	Wed,  6 Nov 2024 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HYuQmoUT"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0352038A6;
	Wed,  6 Nov 2024 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730914593; cv=none; b=XJZgO1sYqsTjzJfg9PVweQNwQfC0cgbdUSsfDvERfmvCQ7XHOwjL8Bx4xgy6FjWWTpW5n1PIy6AiUQyb0mgz93IcIHmceYTI+9ZggMjhvZbxPYuIwQrcZSVzQaKZnpQRIpIS1ERmdeHC6eb1w+Wn/sRrMy+NddwxBHD3C5TXKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730914593; c=relaxed/simple;
	bh=1pOmjwpfNyCJNXJY7y/BgWxROZPdpotF0MYZpYajSzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJ6TMou+MDL/Q0TeRcKPRGvelrNRr9kl+Qr4q+NL1PcI46c/lz89yrcblCgNaL/JF0X9IF6TTGuJdxIClmp7kwaqvEkUXHvavoVsjEe8z5PeUQ9c7kcC6yl3L4m8KqVqKynjDa3WXvdGiy89TQxNNpZQW3pgdqzOwYnwpjhZuco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HYuQmoUT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gxTmyUAb89AtPdb+rKahOvBdQ8TDjXHqHlVhRRQ/Uxk=; b=HYuQmoUTGKqkwWsdYILgYJo0bQ
	KCMaAFPzaF/zxbaCdhV2zLQIT6Hh5xA8tkxMhTcxm+zSV+/QFMgdCrLJxj15iXBKkKqeMWuPU0MtL
	kACNvID0k+hI99OFEjuyz+bHtAzO7ILoykpJY7mi/zzW//ZogxWkFbEuMWLYJn73kJE8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t8jx3-00CMX8-0D; Wed, 06 Nov 2024 18:36:17 +0100
Date: Wed, 6 Nov 2024 18:36:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org,
	alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, mohsin.bashr@gmail.com,
	sanmanpradhan@meta.com, andrew+netdev@lunn.ch,
	vadim.fedorenko@linux.dev, jdamato@fastly.com, sdf@fomichev.me,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
Message-ID: <76fdd29a-c7fa-4b99-ae63-cce17c91dae9@lunn.ch>
References: <20241106122251.GC5006@unreal>
 <20241106171257.GA1529850@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106171257.GA1529850@bhelgaas>

On Wed, Nov 06, 2024 at 11:12:57AM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 06, 2024 at 02:22:51PM +0200, Leon Romanovsky wrote:
> > On Tue, Nov 05, 2024 at 04:26:25PM -0800, Sanman Pradhan wrote:
> > > Add PCIe hardware statistics support to the fbnic driver. These stats
> > > provide insight into PCIe transaction performance and error conditions,
> > > including, read/write and completion TLP counts and DWORD counts and
> > > debug counters for tag, completion credit and NP credit exhaustion
> > > 
> > > The stats are exposed via ethtool and can be used to monitor PCIe
> > > performance and debug PCIe issues.
> > 
> > And how does PCIe statistics belong to ethtool?
> > 
> > This PCIe statistics to debug PCIe errors and arguably should be part of
> > PCI core and not hidden in netdev tool.
> 
> How would this be done in the PCI core?  As far as I can tell, all
> these registers are device-specific and live in some device BAR.

Is this a licences PCIe core?

Could the same statistics appear in other devices which licence the
same core? Maybe this needs pulling out into a helper? If this is
true, other uses of this core might not be networking hardware, so
ethtool -S would not be the best interfaces. Then they should appear
in debugfs?

	Andrew

