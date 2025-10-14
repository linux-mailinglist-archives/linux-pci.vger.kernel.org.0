Return-Path: <linux-pci+bounces-38074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9669BDABD0
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 19:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C88B44E63C0
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 17:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BC33043B4;
	Tue, 14 Oct 2025 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ix1n2ti2"
X-Original-To: linux-pci@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4FB3043B3;
	Tue, 14 Oct 2025 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760461751; cv=none; b=P+Bhw7o4sHQ8KcVbaSuYjIODJ/BorPRzAjhlWuLHXZzWqpqT5D4XLdkiPBvwYJ2pw05z2GIOo84EIEfZHJU6dlumq7Y1MkL8l9Ma9Dgb9nea0xvi/mVkAQyo0qR/dAPiN0mt3hL3VWlAH1kDH+qLPsw5fklCUz757TnAaO77n0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760461751; c=relaxed/simple;
	bh=D5RNv6Lympg2EKcNdy//QfQ4OP1+anSrTZWzx6lRuhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOIPDVFYS5Qp5XcfMIMSkjSoYaJbf/MZkGex0ajlNU3ZWLo1Vu2ceBXkePxvul13n5XEWV8cQhin+u/0bVYC0z/ddPhwMBxpwji4c06kv+gUTvRB4Ol7VVwqJKcQEtIBO/W5sbWbMIi3ff5L+t7tRY5J5WsW/jD8fMtN52R9Hsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ix1n2ti2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=akANej3KnfR5Xc6slbiz9S+LMJbfcs8ehgT6M3+S6Yk=; b=ix1n2ti2DG9FaABLNWgSrQDGXI
	DwHazrHX/96rMxm96KA2xk1NIdXbB7uHtfXKD/zhXcDilhen6ATndJwA9j4Qpg2zZDsyHMycsJl20
	WHSjgtg+1UW0rZ98E+8XKKo49C0s9gZ9eou2HhsAa1QuoqT2yYRcqSoW1uwRRWoBZS9Ws+q7CFm9G
	omLZE6VUje0oait9q8HgM0JSaWmjuiYfUsoxac8stuXtaMfQ2ROz4kqu/G75/MOSJ5OmpApixKikx
	C16Lh8AaksqaKwsmqMaQu8BZchg5J5BJNn5efXv4ct1rmsfbedLcECD7osHx8CTQyrlSF5t4w9ZcU
	b2chNtWQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60862)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v8iVt-000000003an-33Dr;
	Tue, 14 Oct 2025 18:08:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v8iVn-000000001Sp-174h;
	Tue, 14 Oct 2025 18:08:35 +0100
Date: Tue, 14 Oct 2025 18:08:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yao Zi <ziyao@disroot.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: phy: motorcomm: Support YT8531S PHY in
 YT6801 Ethernet controller
Message-ID: <aO6Dk0rK0nobGClc@shell.armlinux.org.uk>
References: <20251014164746.50696-2-ziyao@disroot.org>
 <20251014164746.50696-4-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014164746.50696-4-ziyao@disroot.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 14, 2025 at 04:47:45PM +0000, Yao Zi wrote:
> YT6801's internal PHY is confirmed as a GMII-capable variant of YT8531S
> by a previous series[1] and reading PHY ID. Add support for
> PHY_INTERFACE_MODE_INTERNAL for YT8531S to allow the Ethernet driver to
> reuse the PHY code for its internal PHY.

If it's known to be connected via a GMII interface, even if it's on the
SoC, please use PHY_INTERFACE_MODE_GMII in preference to
PHY_INTERFACE_MODE_INTERNAL. PHY_INTERFACE_MODE_INTERNAL is really for
"we don't know what the internal interface is".

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

