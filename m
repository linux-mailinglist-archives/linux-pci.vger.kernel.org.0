Return-Path: <linux-pci+bounces-34086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C511EB27233
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 00:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D397A9C34
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 22:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38D121ABA3;
	Thu, 14 Aug 2025 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcQ0s7/6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDE423185E;
	Thu, 14 Aug 2025 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211852; cv=none; b=RPybrw8gkZfc85S3USmpocrOK4F40UQtDI8AFjxzW2BrWk8bCml0WoAMEZW5XkGC8JqQqmLny9lQjqVTUoziTSvc3SRcQuKs5ZGBJZGP1wrJsDLxUQxxCpBwf77CJU/PQjuzkOpC7pOlrkHl1gQb3NLVsJmHt7CsCgirKy0Mba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211852; c=relaxed/simple;
	bh=k3g3av1ExpxSpGPQvhDqy0PXWfc84KcrITee0dOTqgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAOISnJXHSK6O6fPQVhkH+YU23V0jWHvrWAmVfjg7mw/cJQCv8JF3vmYHib/53A8zTnQUzqWoFaplbAIT23vYys32s4uI4TtWlve9Whq/Z45jIm2Aq4sAX3Cj1wyMTgu3Mq1Q+A8tbfVhUnVZeLiuU4BBsiSktifvOBkLLoV/5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcQ0s7/6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-323267adb81so1949081a91.1;
        Thu, 14 Aug 2025 15:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755211850; x=1755816650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WVawUElbuEdpT/L0IVDdSj9wdhwbVEtke7BFQtXU6aA=;
        b=DcQ0s7/6XGDmMx8IQ9ViQd6bimAQDM7N3nSNWqIykjLD4YZY0CkfGEbjoXblhrQq+3
         /nc65dV2pYz8aSvax4pJEGDIklXtXHBqCJSpXr7zX+ckwAEO4pTzR+OLa2NrZmxyE7zN
         EuLyUHE3pNIli4OHnPsbSx/u46l3Lf5jPY+UofRxMh+Yi71AyQzTeZuyTl4Nphs0pg8p
         8Js3bzk3nXIQtgYKfHxVkns3hJSZQWJnY4M/VndAHYmuf8e+kDsErb9uUEX2zmCR2m3p
         MPpW30Wf3TnHhzicW7OE5d+oAFeh0Z88IH1OcTX/3GkNcsgsBVtMdj3ELbOgWG4c3r6s
         WWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755211850; x=1755816650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVawUElbuEdpT/L0IVDdSj9wdhwbVEtke7BFQtXU6aA=;
        b=f975AEV4H3icfnVlbkWoF2CdAKEg7j8iRl1CCHwkfv2BSaViADo7mu/YezQUVsc0Qh
         CPPpjrQyp+HKQDg+dtTaNzqIt2nS5Ik+BQHzJ4BHeWTtTVsIhpV1srt/emI4EflL9mo6
         uk28CLfZEjKJ9XP+ePcMJ0DIYvonjk0CVa0hX6GkMIGsoO+YKFFkNVENlK/XP4EEAy+N
         zvAWw07OzH8aSABebJ43HqiDjDbfwL8ED2AdlqS8SOz72S175mUd+De4MuC3NbDexQwo
         iis0TQl6CifCQ9Quc6Y5krkNHG7RhFcqoGNLusmFLKVFBTwsJU1FDCI2Au/yY9nlAYi8
         gTow==
X-Forwarded-Encrypted: i=1; AJvYcCUA8e0I22tgfGhuMfA+xfXx6nBQgyDm5e4IW45k0R3iD+WzoJm5GQ3VTSuyWeAmUIUpRmsW8sBwTVr2@vger.kernel.org, AJvYcCUM1NiJWmf7Lo5XrOaX7oCbD81auEt3YK+oohX1GN0zswjFBObQzF9p7qaRpbe1MjaCL5WT6Ui0F4CT@vger.kernel.org, AJvYcCXy/I6c0usgVVyGSQ5LsjoxiC2YIXnCp7gG66Qv4zbTZ4WgulD7lGW1+XkvxocayutpbHGNUjNG07jm3aMm@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg5Sfj2jYCTrLWDgO1JDHrd8wDti9Lv/dsfvhrhorkHcy1oj0/
	toahmOezAWT0UZANH2pNXTaj1fZTLusPQm83VVkOAxo7jiF1hj7elTXi
X-Gm-Gg: ASbGncsAIIWC4445JwT9hw7Pd9IYxljcVX6/T8oMQXh3y10jVxQ/ZvNvC7yoxL3UFe9
	D+cFEuVH6v/DG2gqdXS/sOLIIib0cHMj6b5IoNamakYOlsI26mBcN6aV3+u2IN0+AHQy2R4+CLA
	fBYlPZNJ5tT9alND/fKenTI+KNcVB3t9Oa6uhLTa7rfLW1uWlPlmB/vQSka50LsyKUvEJ9jTTh5
	COQuLrn/CkUzk+rew2izvwpETRycesRh0k3HsI5JpiQfCn8FEIYkSlxcqeUXPvIlf6j9mJD0mQ2
	43GHB31T5R4wuvTbRr/yTW//gIwEQ4vrOrWPwTGj975y9FqWDlhGxBRXu03SZRWsi4b/XCnGNN6
	QE3XHTjI4DrMIzcry/TGX9mDVB4Yt9YvO
X-Google-Smtp-Source: AGHT+IEJqNeT1yM7BjiHaonVA76lx9wIv7oauipmGKTTR2d3Fa2Yg6FGWlZUCw2T0pv6BwK2DA17bw==
X-Received: by 2002:a17:90b:1810:b0:31a:9004:899d with SMTP id 98e67ed59e1d1-32327a4f242mr8445796a91.18.1755211850284;
        Thu, 14 Aug 2025 15:50:50 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b471519d8bcsm2721398a12.61.2025.08.14.15.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:50:50 -0700 (PDT)
Date: Fri, 15 Aug 2025 06:49:58 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alex Elder <elder@riscstar.com>, Inochi Amaoto <inochiama@gmail.com>, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org
Cc: dlan@gentoo.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de, tglx@linutronix.de, 
	johan+linaro@kernel.org, thippeswamy.havalige@amd.com, namcao@linutronix.de, 
	mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, quic_schintav@quicinc.com, 
	fan.ni@samsung.com, devicetree@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pci@vger.kernel.org, spacemit@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Junzhong Pan <panjunzhong@linux.spacemit.com>
Subject: Re: [PATCH 4/6] phy: spacemit: introduce PCIe/combo PHY
Message-ID: <mj5e6afmbqo2tpt3zjuebcfif3flvgqq663erv3xuvbg72nd6g@bapy44nobzyw>
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-5-elder@riscstar.com>
 <valmrbddij2dn4fjxefr46zud2u6eco2isyaa62sd66d27foyl@4hrhafqftgb5>
 <4eaa30bc-9a25-4fe0-b685-1d0d8fa503c2@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eaa30bc-9a25-4fe0-b685-1d0d8fa503c2@riscstar.com>

On Thu, Aug 14, 2025 at 07:15:43AM -0500, Alex Elder wrote:
> On 8/13/25 6:42 PM, Inochi Amaoto wrote:
> > On Wed, Aug 13, 2025 at 01:46:58PM -0500, Alex Elder wrote:
> > > Introduce a driver that supports three PHYs found on the SpacemiT
> > > K1 SoC.  The first PHY is a combo PHY that can be configured for
> > > use for either USB 3 or PCIe.  The other two PHYs support PCIe
> > > only.
> > > 
> > > All three PHYs must be programmed with an 8 bit receiver termination
> > > value, which must be determined dynamically; only the combo PHY is
> > > able to determine this value.  The combo PHY performs a special
> > > calibration step at probe time to discover this, and that value is
> > > used to program each PHY that operates in PCIe mode.  The combo
> > > PHY must therefore be probed--first--if either of the PCIe-only
> > > PHYs will be used.
> > > 
> > > During normal operation, the USB or PCIe driver using the PHY must
> > > ensure clocks and resets are set up properly.  However clocks are
> > > enabled and resets are de-asserted temporarily by this driver to
> > > perform the calibration step on the combo PHY.
> > > 
> > > Tested-by: Junzhong Pan <panjunzhong@linux.spacemit.com>
> > > Signed-off-by: Alex Elder <elder@riscstar.com>
> > > ---
> > >   drivers/phy/Kconfig                |  11 +
> > >   drivers/phy/Makefile               |   1 +
> > >   drivers/phy/phy-spacemit-k1-pcie.c | 639 +++++++++++++++++++++++++++++
> > >   3 files changed, 651 insertions(+)
> > >   create mode 100644 drivers/phy/phy-spacemit-k1-pcie.c
> 
> . . .
> 
> > > diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> > > index c670a8dac4680..20f0078e543c7 100644
> > > --- a/drivers/phy/Makefile
> > > +++ b/drivers/phy/Makefile
> 
> . . .
> 
> > > +static int k1_pcie_pll_lock(struct k1_pcie_phy *k1_phy, bool pcie)
> > > +{
> > > +	u32 val = pcie ? CFG_FORCE_RCV_RETRY : 0;
> > > +	void __iomem *virt;
> > > +
> > > +	writel(val, k1_phy->regs + PCIE_RC_DONE_STATUS);
> > > +
> > > +	/*
> > > +	 * Wait for indication the PHY PLL is locked.  Lanes for ports
> > > +	 * B and C share a PLL, so it's enough to sample just lane 0.
> > > +	 */
> > > +	virt = k1_phy->regs + PCIE_PU_ADDR_CLK_CFG;	/* Lane 0 */
> > > +
> > > +	return readl_poll_timeout(virt, val, val & PLL_READY,
> > > +				  POLL_DELAY, PLL_TIMEOUT);
> > > +}
> > > +
> > 
> > Can we use standard clk_ops and clk_mux to normalize this process?
> 
> I understand you're suggesting that we represent this as a clock.
> 
> Can you be more specific about how you suggest I do that?
> 
> For example, are you suggesting I create a separate clock driver
> for this one PLL (in each PCIe register space)?
> 
> Or do you mean use clock structures and callbacks within this
> driver to represent this?
> 

I think using clock structures and registering them is just fine, 
there are many phy drivers already do this.

> I'm just not sure what you have in mind, and the two options I
> mention seem a lot more complicated than this one function.
> 

Yes, it is more complex than just adding one function, but it 
make the code clean and easy to understand as the clock looks
complex. Also, register this clock allow us to know the state
of internal clock by looking clk_summary.

Regards,
Inochi

