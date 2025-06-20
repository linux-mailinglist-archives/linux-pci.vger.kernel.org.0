Return-Path: <linux-pci+bounces-30257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4EAAE1B33
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 14:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC370176F6E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 12:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855E028A1C2;
	Fri, 20 Jun 2025 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX+LT/oS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F92021C17D;
	Fri, 20 Jun 2025 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750423811; cv=none; b=U1CK81fkGRr36By0xr5aJqXZJEVRh0dMe1xTWKTGK2EPaL7n8s/qcrCSX6zPsciDT/wElOOrJQKAwoQHAzAjnewCAPBxYR2NH8cuTo6dSvLNgRLZ29+t1M5iwVGxw42UQNOrNsSwPlUDWi0BCi/EuJ615uXpntF2fQI3D9WJaQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750423811; c=relaxed/simple;
	bh=Kwv946pnQhs+0i4tof1+yJjt+sBgm/9UeR7RPmgYJ/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgGpRLuG0Sg98y3UHihJZgWBPBQix1JvriYQLjaXf7BFx45XqJYIBk5veejMwvIrUYlzfC/G5+ZB2E4vJeABqc/X9MRkKDMWvXRG4PDQlD6Ezraf5Y1PqfDYBmavH/QKJMU4HrtWVWWYdjb5CENd450rq1xIht6uRlvAsl8o1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hX+LT/oS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-747e41d5469so1778672b3a.3;
        Fri, 20 Jun 2025 05:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750423809; x=1751028609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NmLYBG24ijAXHoIQVzJvB+/26hO+EVlKH3Q7Q1ZOAU=;
        b=hX+LT/oSdsKDTKJ1J5l9T80bZtsNPhvINvRp6pWwN7vZrminiCO13/7Mdpta8ChkrG
         TuvZu/lvtVbVztNlkJTXUd7wbFk0RnXSaarNjIRb+Z57VxYldiVC/duHWyGFdzStPxWC
         eB8fwcwoxEDmaUEmCHD6x9tI4B7CA0Mdr8NaSlRffgS3ducxfip6xrnGRtOxAREr38qW
         eKnCziBUTAPex14+aeoCWrJJgFpN2YeGPKiITfb6+Rk/9Y4ZvyJ3zBG5DmL38PG3+xxR
         2nrCr0EAZRXrJLhQEqu4PF7B+gC/DFnlh18cdCo9vvS4TYYNelNDHiac4+StoixcrPSb
         cBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750423809; x=1751028609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NmLYBG24ijAXHoIQVzJvB+/26hO+EVlKH3Q7Q1ZOAU=;
        b=aoW9K1GXWhu9nqi/LgL7YNmtS6auu7Cbc39jpIppdqFjvljLACA5E4OwqPcktGZtq9
         1XFzuqYnMS+IrJkx8ix2kKiVi820ioR8hXoRmiSHYiSvSyxa0rabyx4Ryiogm/AlCnJx
         S+2Qw8h8E3e+pBjoKFNsXkHLl6hTgRTarF8+sLDp50FM9GP/D6k2+t7oyTIMDiInqCGE
         +GGJ+aTqBt2WAxZ/FAAE0bB/3pPZPVKEvivycbIRp4yL7GL2ClwdusvIEOkBY2l4+sGJ
         1f9Wq15Lpp+c83Z3FAQAe3WMoQm926SorHoPibgwArE0+KUW37RT+qv/VXG4/vupmCr/
         t6fg==
X-Forwarded-Encrypted: i=1; AJvYcCV3iX8rvTzvQWVjyvu9Vq4T06PCSqAJEFCREFtmaehsV4mnXqXoSvqob0cNj4hbr4NFDA9rBJnR3WNA8l0=@vger.kernel.org, AJvYcCVG1du2jf6JoKP+rBjIj/ocStOP7ZoR2J1Ep8//CdYuGYtwpbsC4UXoiHKFgYb72BU8R+l9PbhaxuaK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6uZqjvugWBh/gU1OTKrKIx5qH5LmHFBh3IW40noJ9ro54rtnK
	CvwkNDsjF0y+PURqLGB5YJaz4lu57UzqpS+nckBE43sayhx6VZq+6TOc
X-Gm-Gg: ASbGnculhZyLgYutylNeGqddDBKO7XzRyNxLtvJDriLU0/fkdDv2SFzhre1MLy3WzL2
	N51n5qICmjOz42t4/ZXRhi5eTUBvklXzjFjW/kXdEDzuHdzHA2OG6XawtDv8uxpkIcSNkipJun+
	rW3W0Yx6K7DVF8sKdvsJk8uutA86WrD4FtVln1N6yin+icEhue1SuLLRA26bZcnFA6cXSIUHAsO
	hHhkzCPpPrw1jWd0S2ri5T0K0INW2HVO7H/0wUd2AgO4KsHFW2xnLXgBUQ09f+SR4lSgPUEQUD1
	MiP+xPoFwdClR75NBdbTOcrYehQvOOIW8kLVA1tglma/JQ5Ygg==
X-Google-Smtp-Source: AGHT+IFHPYDIR4or2vPqPU1VUvmiA2iVM69SFwDRvDzb2cK3GvAtLoyB4Hkk467Mv/TfqKSO9XUqHw==
X-Received: by 2002:a05:6a00:1a88:b0:748:2ac2:f8c3 with SMTP id d2e1a72fcca58-7490d6bf6d6mr4497789b3a.24.1750423809249;
        Fri, 20 Jun 2025 05:50:09 -0700 (PDT)
Received: from geday ([2804:7f2:800b:cab9::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a69bb99sm1950566b3a.155.2025.06.20.05.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 05:50:07 -0700 (PDT)
Date: Fri, 20 Jun 2025 09:50:01 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 3/4] phy: rockchip-pcie: Enable all four lanes
Message-ID: <aFVY-YtSTxUpJkIa@geday>
References: <cover.1749833986.git.geraldogabriel@gmail.com>
 <ce661babb3e2f08c8b28554ccb5508da503db7ba.1749833987.git.geraldogabriel@gmail.com>
 <4c2c9a15-50bc-4a89-b5fe-d9014657fca7@arm.com>
 <aFVTdYWxuq9YzVQR@geday>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFVTdYWxuq9YzVQR@geday>

On Fri, Jun 20, 2025 at 09:26:36AM -0300, Geraldo Nascimento wrote:
> On Fri, Jun 20, 2025 at 01:04:46PM +0100, Robin Murphy wrote:
> > On 2025-06-13 6:03 pm, Geraldo Nascimento wrote:
> > > Current code enables only Lane 0 because pwr_cnt will be incremented
> > > on first call to the function. Use for-loop to enable all 4 lanes
> > > through GRF.
> > 
> > If this was really necessary, then surely it would also need the 
> > equivalent changes in rockchip_pcie_phy_power_off() too?
> > 
> > However, I'm not sure it *is* necessary - the NVMe on my RK3399 board 
> > happily claims to be using an x4 link, so I stuck a print of inst->index 
> > in this function, and sure enough I do see it being called for each 
> > instance already:
> > 
> > [    1.737479] phy phy-ff770000.syscon:pcie-phy.1: power_on 0
> > [    1.738810] phy phy-ff770000.syscon:pcie-phy.2: power_on 1
> > [    1.745193] phy phy-ff770000.syscon:pcie-phy.3: power_on 2
> > [    1.745196] phy phy-ff770000.syscon:pcie-phy.4: power_on 3
> > 
> 
> Hi Robin, and thanks for caring, it's excellent to rely on your
> extensive expertise on ARM in general and RK3399 specifically!
> 
> However, on my board I'm positive it does not work without proposed
> patch and I get stuck with x1 link without it.
> 
> There are currently very similar patches applied downstream to Armbian
> and OpenWRT so at least I'm confident that is not only my board which is
> quirky and other people experienced the same problem.
> 
> Thanks,
> Geraldo Nascimento

Hello again Robin,

for reference, here's the commit for OpenWRT, originally from Armbian:
https://github.com/openwrt/openwrt/commit/2dc9801fe81ab3c092d2ca75e4c63f8d5eea46f5

Please note that the author of that commit specifically mentions a warm
reboot is needed to trigger the "stuck on x1" behavior. That author took
a different strategy than me, just reordering instead of using for-loop.
I'm open for different strategies, but the report is real I assure you.

Geraldo Nascimento

> 
> > Thanks,
> > Robin.

