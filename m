Return-Path: <linux-pci+bounces-32482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FCAB09A2F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 05:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9D51793AB
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 03:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299D113AD3F;
	Fri, 18 Jul 2025 03:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrxfF9lY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EFF2E3701;
	Fri, 18 Jul 2025 03:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752809606; cv=none; b=jDmzXd2fHAtFuY8USB9cK7UIN4ol2FLIyaE4BgN6BFPUwjnqoQVS2gy6hsc0OnN7XdSxJlJ3byNBySDcNedUp/6z1Mpj16YHo6K15OcM2CFft12UeMRG83UCivS5j6RBh7Z/EW7kN7ZUuaGVIh25GKRNbNABRFU6LzlbNpNdicg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752809606; c=relaxed/simple;
	bh=AMSMj4ctsIaylYGk5+a6qH6cp7Shzrqrf/JgV6iMSAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgnekURVogI6jH2P0lF/hS4/A1K0J0EcbMaOeSCCYElIj+3ORJ/DRE5m7pCVJrD7+YW54HYBBZu+9LpNfHqAdFRVW4gt3lMrn1+mQXDdJFVu4NwmVAvqjUXTaXrMQzqlAJ+aOvXyKTCVZZFpHd/7k8AblfrkvdvHuCg14hh96v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrxfF9lY; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5347686c12cso753981e0c.0;
        Thu, 17 Jul 2025 20:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752809603; x=1753414403; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X4q0Q5EvAAnymgIMuX9CMnSNvFvZahS0xipjrXbSldw=;
        b=LrxfF9lYu7cCj3ry0QPGs7tI9u2/oPnnsVuAKt0VOKjpkHnc/ry0U9GHqpo/BG8pEK
         TYrPQoLDVl5zjubLye6PNyeYc0lCAkaM810U4U5tJxlMmViRBq4bALhzgaCZMNmbfrxQ
         HrWLX1f5rtJTYINtWI7pLwA3himzzQx0TLVXfsX0hYO1OT2nmC4v2lLy8L8E9/xub5Hq
         oZNprQXd/a0BKZooyc5wUS0x/qDS2TsZGzA94nttQGSzYa99HK/wDEFVbETVRjoIQPL8
         y3ZCLS+Ad5in5Y7mnsKBB36qjtN4umX/f4y5wMpam80OH/DUbIK9LI25nbWwL/WdpQzJ
         7HUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752809603; x=1753414403;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4q0Q5EvAAnymgIMuX9CMnSNvFvZahS0xipjrXbSldw=;
        b=syycCpTpV7BomyNkjWP1nplI44BzsHzZ6q6lwL5vJd2puqz6alOLh1OOIPENDrQP/o
         HBlbIwabI4KQSd36+OrYTYM67pd69yunsWYp+oS0+eOJLN8HpK0TZ3GTLqctS/jaxRnT
         pG15gdz+ih9nNObYgd6avdOoto2+ndTbmGsqmjbZCt6DFLWdiX9v092jJqlOgcITQlq9
         iz/+WmdOXJAjrsXLAFpGJzjf+SSHAoiqpIhFDeCCaSWJ28Pf8Zfu/MoZccaucTXXyphf
         GZY3JziybB62FnZ2Z0JdA5XodJVmLK7K3y1rUTu6U4WJAHYS4qbLDAtvWWRIn4L9YjEw
         jLiA==
X-Forwarded-Encrypted: i=1; AJvYcCUj2ekkyNfDMX8HS9W6sHeWOXlq6DeXbXWdQQshmHeQUXImy1ekftBJMRySdMfC2x0/qK24cidXmXjoFzA=@vger.kernel.org, AJvYcCWIVYKxeju9CEJn/SuUCaE0JNWwkzzpvNinOMkM7JvlJg4Fb6abA8OV28zQyNSnHp/OiP0beb3n5tYx@vger.kernel.org
X-Gm-Message-State: AOJu0YxqZsPPaKGgctGiLBlBrCeObCWp1eVmRIJqyYkrpKGrXoFTboRd
	UYiv6LqzIp2gqbUOyLz2ISaVJftAumdauLXkdG8dpeIngjeErWEKaOue
X-Gm-Gg: ASbGncstQZuzbbWJr3Klg4lyknlW0NiV/d5tZhizInzVgi9PTLcOdcyPgmrYgIGg+6a
	J9iGOqzLjuJ4kCgekPqJ38jTQFSIkvaxPVKAhMh/pr6LJNWPVYZJcM536CreNvTcw7/3ZPNF7sN
	W0LGXTIC4JJjoD1ipeQSjfDvjTbfNpqE/MoiEhcJVlOmUwHU4re2eeYwXqZbNzJuxuNBd5x9n+v
	s8bUQFBBaZy9BJX1v+L/yGXJnVkvmfl3B/XGUI+VC0Zhjn9WgWh4U84V+7MaYmmkvu+D+Mbdv+W
	VfN6GalJn658S/f2AlySy1HOPfJ8WNgSYgkI5xqWSNBMsi/aJ0qjLkipnuACQwpvA1aMS2Rdp2j
	wzlvfHNJh+/fO1jJe5j37
X-Google-Smtp-Source: AGHT+IFG+rqRc1GS9r7vH4lNCHz/0iF5wqAzIkwI4O1lQJw5WIt9L0WOWQNLdU0Vc6VPuIyzNQyhDA==
X-Received: by 2002:a05:6102:3053:b0:4f1:7946:ed52 with SMTP id ada2fe7eead31-4f89996c9f6mr5408257137.12.1752809603242;
        Thu, 17 Jul 2025 20:33:23 -0700 (PDT)
Received: from geday ([2804:7f2:800b:2246::dead:c001])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4f9ad094fadsm138027137.16.2025.07.17.20.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 20:33:21 -0700 (PDT)
Date: Fri, 18 Jul 2025 00:33:05 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Hugh Cole-Baker <sigmaris@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [RFC PATCH v3 2/3] PCI: rockchip-host: Retry link training on
 failure without PERST#
Message-ID: <aHnAcbXuFqcMXy_5@geday>
References: <cover.1749582046.git.geraldogabriel@gmail.com>
 <b7c09279b4a7dbdba92543db9b9af169776bd90c.1749582046.git.geraldogabriel@gmail.com>
 <ac48d142-7aec-4fdd-92a4-6f9bc10a7928@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac48d142-7aec-4fdd-92a4-6f9bc10a7928@rock-chips.com>

On Fri, Jul 18, 2025 at 09:55:42AM +0800, Shawn Lin wrote:
> Hi Geraldo,
> 
> 在 2025/06/11 星期三 3:05, Geraldo Nascimento 写道:
> > After almost 30 days of battling with RK3399 buggy PCIe on my Rock Pi
> > N10 through trial-and-error debugging, I finally got positive results
> > with enumeration on the PCI bus for both a Realtek 8111E NIC and a
> > Samsung PM981a SSD.
> > 
> > The NIC was connected to a M.2->PCIe x4 riser card and it would get
> > stuck on Polling.Compliance, without breaking electrical idle on the
> > Host RX side. The Samsung PM981a SSD is directly connected to M.2
> > connector and that SSD is known to be quirky (OEM... no support)
> > and non-functional on the RK3399 platform.
> > 
> > The Samsung SSD was even worse than the NIC - it would get stuck on
> > Detect.Active like a bricked card, even though it was fully functional
> > via USB adapter.
> > 
> > It seems both devices benefit from retrying Link Training if - big if
> > here - PERST# is not toggled during retry.
> > 
> 
> I didn't see this error before especially given RTL8111 NIC is widelly
> used by customers.

Hi Shawn, great to hear from you!

Notice that my board exposes PCIe only via NVMe connector, and not
directly via a proper PCIe connector, so it is necessary for me to
adapt with inexpensive riser card that exposes proper PCIe connector.

I say this because while I don't doubt that the RTL8111 NIC works
out-of-the-box for boards that directly expose PCIe connector, the
combination of riser card plus NIC has a similar effect - though not
entirely equal, as described above - of connecting known good SSDs
that simply refuse to work with Rockchip-IP PCIe.

I admit that patch 1 looks a little crazy, but is has the effect of
enabling use of presently non-working devices or combination of devices
on this IP, at least on the board I have access to.

> 
> Could you help tried this?
> [1] apply your patch 3 first

Sure, I'm always open for testing, but could you clarify the patch 3
part? AFAIK this series of mine only has 2 patches, so I'm a little
confused about exactly which patch to apply as a preliminary step.

Also, since you're asking me to test some code, I think it is only fair
if I ask you to test my code, too. It shouldn't be too hard for you to
find a otherwise working NVMe SSD that refuses to complete link training
with current code. Connect this SSD please to a RK3399 board and let us
know if my proposed code change does anything to ameliorate the
long-standing issue of SSD that refuses to cooperate.

Thank you,
Geraldo Nascimento

