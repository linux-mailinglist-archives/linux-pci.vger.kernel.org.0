Return-Path: <linux-pci+bounces-16694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3420A9C7D3A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8842B283C23
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 20:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F028D2076B9;
	Wed, 13 Nov 2024 20:59:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D015AAC1;
	Wed, 13 Nov 2024 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531544; cv=none; b=uDtAhnkE6g6AV4hyHpTH17WkI8cAViPbQl5D5+3TAtzCf0VYObM8o6YMaE8AVpbbCvrSXJgbOrQGxPihOEl9Ffq6gbK6Zi/iE0288KaJUsIbat70OClakBvCy5OXoq0IG11TTsZDwd+e8o2kxeuTxXr3WzwIBSM6Z6wF/pghFzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531544; c=relaxed/simple;
	bh=/3LbvgJd8vYu4lLFq2oufslnPGQfjx/yqOPqMvTNn7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RU5iKFfJIaSRgFNgFU9nIuNIcoUXEL0ftwzl7b8toMx6FF/WPqUvsESYBGmYcVHfu6gACVwjiJaP2fZw8qvSHOUZNsNEu6Ldr+xb9MhoYFdYb45VbUaCMk07psilqXCAB3hQ5kG4vAyhUS9LSL0NwdLSChgy1h/R7who67eGf7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e5a62031aso5869791b3a.1;
        Wed, 13 Nov 2024 12:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731531543; x=1732136343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9J4zvU9f0X+PlDgNJ1sENPy01zMEXJgST3zN9cLzi1E=;
        b=JLBz9Ohc+LFLrTLy62VNo0IrSs8//RLSbSs6JhDnfv3p1VJ8x4gT4HJKcFmtpaRqy4
         CONjdYccQYf1EO2XB0Hk1Bx+7CMUVsYj1nEskAK1gCZuVMUqLBpPr9b9+WvJbaCJfQAt
         8JOVeIiF7Xp8fw8wM72t/pqjGHyFrQosBkLO6chOod6RjouRfR6Hr4WlRfHelG8//S8C
         Z/tyU9aIMwQK00/xWmGQBcNk+auQd07jD7E4eljg0NsyHMrRFFgB5/llDDX+zY2aIfVe
         qgQIClcQKQPJYjuw5sRK+w1ilMPOPGHuXdvxzExZPvh7Evg5SwDmHs3MLC/P7rrNdSCB
         k2tA==
X-Forwarded-Encrypted: i=1; AJvYcCVBCh9RuR5S0IzRpNhpZx2iyc4wYZplZv+oBFzMlUhsdEe+979VPacJMRPwJ2Y8tNsrHhjRwf1jZj1l@vger.kernel.org, AJvYcCVuIoDV+8nF8gc9sNl9n4wU12ecne7TUnWJpPUkYEkCd176IflN+MPlOQQqPEcLJKniUN6ef/2qTRXD@vger.kernel.org
X-Gm-Message-State: AOJu0YztwUy0oyqbLTedwFYXuh1+m+WHkU/sYrX4OqCLyu9Wr7VU8lhR
	0i3idkxDN/9DiNc/2j/TwR7fQ7E5wr1X9ZTFj8kVmOuMz813uaRW
X-Google-Smtp-Source: AGHT+IHK77Wl4FhKcRILI7fsi3rFSgXTC8o7l11oge5mtuc26m0bP+byiMu9fj4txKIvj+uVPHcy6Q==
X-Received: by 2002:a05:6a00:1150:b0:71e:cc7:c507 with SMTP id d2e1a72fcca58-7241338bda9mr30364270b3a.23.1731531542802;
        Wed, 13 Nov 2024 12:59:02 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ec7sm13607982b3a.55.2024.11.13.12.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 12:59:02 -0800 (PST)
Date: Thu, 14 Nov 2024 05:59:00 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v5 00/14] Fix and improve the Rockchip endpoint driver
Message-ID: <20241113205900.GA1184086@rocinante>
References: <20241017015849.190271-1-dlemoal@kernel.org>
 <117828c6-92c4-4af4-b47e-f049f9c2cb7b@kernel.org>
 <ed723fe1-e243-4a9e-8d1c-f29461d07cb7@kernel.org>
 <20241113175222.eh76hksyj6sptwvo@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113175222.eh76hksyj6sptwvo@thinkpad>

Hello,

> > >> These patches were tested using a Pine Rockpro64 board used as an
> > >> endpoint with the test endpoint function driver and a prototype nvme
> > >> endpoint function driver.
> > > 
> > > Ping ? If there are no issues, can we get this queued up ?
> > 
> > Mani,
> > 
> > Ping AGAIN !!!!
> > 
> > I do not see anything queued in pci/next. What is the blocker ?
> > These patches have been sitting on the list for nearly a month now, PLEASE DO
> > SOMETHING. Comment or apply, but please reply something.
> > 
> 
> Damien,
> 
> Sorry for the late reply. Things got a bit hectic due to company onsite meeting.
> I'm going through my queue now.

Thank you, Mani!  I took this over and pulled this series.

You and Bjorn can have a look over the changes, if you have a moment.  That
said, at least to me, the changes looked good.

	Krzysztof

