Return-Path: <linux-pci+bounces-24454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E45A6CEF7
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 12:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95161188E623
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 11:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7187D204C23;
	Sun, 23 Mar 2025 11:39:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE70720110F;
	Sun, 23 Mar 2025 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742729959; cv=none; b=LIdobZS+LoLxvJfO/juVDo1Ssod3YsSggIQlgO1VN7MkWqHtL4WkEVBwfyMhq1Ogi7QuYGbiwuUWWxHyWHZ85cRyKiiY/LmPeVh0MbR/7OvMN+lIAAUyV48D/VZI8e2Mq8fcZIaXfUzkfR1b+13SymDUPZ7YvEHWPzEuVrTupO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742729959; c=relaxed/simple;
	bh=i62gdZQA88c6TBFXklIhRbPhLAK4Hq535EgiVcnKdyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlZ5oIt0VDtkVshvHr+IgnUzLSslwLNBa+cLGARmvqWmnq4DiyyGXtpCwWvyp0RAjfAl36WRuXw2ThuIRb6keBL77Iv4aI0oUB+lDNJTa39ia6w+iVY7+oOHQqUwUN8DRu30yoq04Q0D+CY7B692xgg6FfKlWpy6jcS8HhYIdnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225df540edcso87153815ad.0;
        Sun, 23 Mar 2025 04:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742729957; x=1743334757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umbyZX39Xy601g6OGF8b6eQwLE9V0tDY3oqiE70mc54=;
        b=GEC63tES0AOeU4Gct8aje5SIsaQFXUidy8yEoTqPRYh+c2FRrk0qLoBrNqMdm+MU8u
         OgkUztdAkXzPtPuxB5LgFDWQLcWw5VjYGp66wNmUQ4Pyl4AxQsL6EaxrGTsun4kE8ksd
         JqSgC3RSAL++lgN4uy68OCcBWo3LOohA6zL8HRjDmwAb07hvlhK86F81NXXFFjPUdV3M
         yPGbBUNUDfEORteknextEYnWhHIgMiSrJ6JQHg0RU0k5hRgkfnlqK7byysZeO+NKLfZP
         V03YHNWFSPE0ieymKCdcqsDGx3WvBOrWpBqmdkrypxk4HyhvECJ9lLX5HwWXOg9OLqhz
         xVNw==
X-Forwarded-Encrypted: i=1; AJvYcCUAK65hIXfkbMFuVbepkrTNI+ihjFB0MFJuKgCfNWuqueCOkj54Yj0CzGVvR5XmhtOlywuQo8qJiKkV@vger.kernel.org, AJvYcCUrXPcUuuB9fpaBvAfeJ/FjR46h4AgpcN9l13gwt9MVcevocgKvEyY+Y7FFyR1MZtqHGuHvEMn1A4NamcEz@vger.kernel.org, AJvYcCV17odd6Ox3ZX0Md43BeCWJvoSUTfWKcyUXL1N2xhlZ1r10XOpz5N0xIokhynrMOEGC/w9z7p8ZHOtpgQ==@vger.kernel.org, AJvYcCVsBpVeHxbmzgumncWBVhrTV02rKRR/klhK0/NiqypUjQQQ9B3lQz0OlcEQ8BsllijqlP2E7JyX3szg@vger.kernel.org, AJvYcCWFmkTu2gT61K2ZA/8+MjHrxyY6I1Azyz9uyRFt2cXlNRQho2w3MaLsSctK7bgAQGPsvEzzNfKqermR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2vxas5A/RhsTeIPGMOxZfx4EfzdoKIPVdo3geyU7M37wWSLYb
	Z87KNnsCt+v850m2rHaoIEh3kywRdfclx/yskTK+gQ5kCDrlh3uW
X-Gm-Gg: ASbGnct+1gXXOytY/zXWqjUDIYoLk5JB73ZrkHeFcOmRaL+0eAFIMKtW9z0IlYZ8Fwv
	z7JvlAnqeI3Ua0rDxQDaDJPO0waJSsaJ+TexbHTC3jYNnbfZjrBob/c1LowqlV6DUX5CPrhTCfB
	Jijo219I6uQd4S6cQLuuohw36D0hZajsrz0FHyIUhkLOhV5ZU6eQzsbWCKR3W7Beix6utXbc7Hn
	75HNRTZr1F4uHVH5yLDzYt1XgzIfK9aohyEGv4XfK/LuXBKzMN5bQil6BgbL2p1BfQy+G4kceTL
	cdj/0TTxjw/aVoV2jgbJ9l2wnPeqfLUiaNypbsUKLD25xkLqSNionx88/egXkqb1O2yGI5fkY+B
	u4kI=
X-Google-Smtp-Source: AGHT+IFJWx4DQdPuRy8xvpUazrhNKHbR0p3IdS7aCxYy6lnZCOKUux+yr5PQT4J2C1cwwOxmpwbt9w==
X-Received: by 2002:a05:6a21:1086:b0:1ee:5fae:8f6a with SMTP id adf61e73a8af0-1fd0855643dmr24347539637.1.1742729956766;
        Sun, 23 Mar 2025 04:39:16 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af8a2a24404sm4999600a12.51.2025.03.23.04.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 04:39:16 -0700 (PDT)
Date: Sun, 23 Mar 2025 20:39:14 +0900
From: Krzysztof Wilczynski <kw@linux.com>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com
Subject: Re: [PATCH v8 03/13] dt-bindings: pci: Add common schema for devices
 accessible through PCI BARs
Message-ID: <20250323113914.GC1902347@rocinante>
References: <cover.1742418429.git.andrea.porta@suse.com>
 <096ab7addb39e498e28ac2526c07157cc9327c42.1742418429.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <096ab7addb39e498e28ac2526c07157cc9327c42.1742418429.git.andrea.porta@suse.com>

Hello,

> Common YAML schema for devices that exports internal peripherals through
> PCI BARs. The BARs are exposed as simple-buses through which the
> peripherals can be accessed.
> 
> This is not intended to be used as a standalone binding, but should be
> included by device specific bindings.

Applied to dt-bindings, thank you!

	Krzysztof

