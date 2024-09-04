Return-Path: <linux-pci+bounces-12729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4385296B73C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 11:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A5D6B277B7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 09:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271C41CCEC7;
	Wed,  4 Sep 2024 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="O9yWe7Pr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8356145B35;
	Wed,  4 Sep 2024 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442778; cv=none; b=AYeMTHzUvmnUAWEMtNYCAN96kldMgtILbHCOqo52wOQwP/RqJDaCxhqaH0CEq0TBTWmv3Sx6awq0IcInqS9m5OnHEfaBBPksbbNXNQYEYfhQBDGjVIFYCuE5M7a0ZUr/Kh7h4bVTljGtm8GPV6X+vfRmJYY6V5a9WbD+Zei+3PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442778; c=relaxed/simple;
	bh=rTVxIyVb8WfSghHtgLOe2WXhLRycWpFL1ijDTqgz3u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYyhp0kuYgpTc2bfNmXCm8pOd24HmjpaMRFAN7q/si0Uvhv4WHpMBDx9wW2lKjB0umrWC7JRDGQ4viLyBDGFXKcEqLDyxNhhWPPuEq62NkewoYkuGxlG9457sY6hX08m/fceyQ8jMxyWU+bwd3kSbGuRMyJg+EGC/YblociQ3cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=O9yWe7Pr; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=EnnEk75hp1TcAJ6eMliXkp7tOpk4Gr347oVEU3a46cg=;
	b=O9yWe7PrV/9DEvqgVPdjqF0DQhtUWsjbGlqg2bKlF4Jih95Sg/9I1X7t4/rvUW
	Nl2tCJUsBGI1Yq48iHPMVZWT/m8dl6G7OuZiV8U/J4Bo+WZrK5wR41ZCYcM8k3qH
	tZUR/HLK9rBc/dGKfYQ5V/0RZdbjseC9hxz4DK263GRQ8=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXv02ZKthmMfVqAA--.4252S3;
	Wed, 04 Sep 2024 17:38:35 +0800 (CST)
Date: Wed, 4 Sep 2024 17:38:32 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, l.stach@pengutronix.de,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v5 0/4] Add dbi2 and atu for i.MX8M PCIe EP
Message-ID: <ZtgqmCbkD1ruZr4U@dragon>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
 <ZtMUbpBJscWlgkhW@dragon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtMUbpBJscWlgkhW@dragon>
X-CM-TRANSID:Ms8vCgDXv02ZKthmMfVqAA--.4252S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw1DXw48ZrW8XF48GF18Grg_yoWfurXEga
	yUAa4DGw45Aw10y3Wakr4Fk3y7AryUCFW5Zr9Yq3saqr47XF95GF97tr1rGw4UtanxtF4q
	vF9rXa4UJw47ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0zT5JUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEh9QZWbXxVi74wABsN

On Sat, Aug 31, 2024 at 09:02:38PM +0800, Shawn Guo wrote:
> On Tue, Aug 13, 2024 at 03:42:19PM +0800, Richard Zhu wrote:
> > v5 changes:
> > - Correct subject prefix.
> > 
> > v4 changes:
> > - Add Frank's reviewed tag, and re-format the commit message.
> > 
> > v3 changes:
> > - Refine the commit descriptions.
> > 
> > v2 changes:
> > Thanks for Conor's comments.
> > - Place the new added properties at the end.
> > 
> > Ideally, dbi2 and atu base addresses should be fetched from DT.
> > Add dbi2 and atu base addresses for i.MX8M PCIe EP here.
> > 
> > [PATCH v5 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and "atu"
> > [PATCH v5 2/4] arm64: dts: imx8mq: Add dbi2 and atu reg for i.MX8MQ
> > [PATCH v5 3/4] arm64: dts: imx8mp: Add dbi2 and atu reg for i.MX8MP
> > [PATCH v5 4/4] arm64: dts: imx8mm: Add dbi2 and atu reg for i.MX8MM
> 
> Applied 3 DTS patches, thanks!

I have to take them out from my branch for now.  Ping me when bindings
change gets applied.

Shawn


