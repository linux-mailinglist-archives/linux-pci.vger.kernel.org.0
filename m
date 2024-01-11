Return-Path: <linux-pci+bounces-2052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C08682AE18
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 12:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B1FB23234
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 11:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0762A156F7;
	Thu, 11 Jan 2024 11:59:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DADF156C7;
	Thu, 11 Jan 2024 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28ca8a37adeso4421349a91.3;
        Thu, 11 Jan 2024 03:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704974364; x=1705579164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2B3RdL+7tbmXrXWsW5P+Eh0Rvi86Sc7Lt214actT0w=;
        b=cAiJNk7M77x23qtlQffV4XWuujQbC86eSzCDRWw982E7pXKKv1ur4AAjV/VgOJPOMB
         AZIJtOpvyGGUyIC+1hIxpPgmJYW6xTj+ukFxEusAjiKGFsc84jS6qFZQ7lNQ9UotrypD
         1lWIjcO7dRRHW3KoZLhWGnoNaxctuhXkaM3NdNdT2YK/wdk/85pghVVQfXmJeEfe12xk
         R1iP8nkjiwTXI0IS6UjtIBWWiLoJ1x8MvkMjc1kDbZ3J9QygZ75TNNwTsdgZBw/c3NX/
         TcC1CU6coKpA13ysOD4VGEtZdOmE7jIxxUYGCfQOfkQzHnWkTOvPjR+3xjNE2YWdw5uX
         fgOQ==
X-Gm-Message-State: AOJu0Yy0TCYJ+UjEULwIJgK3iXrqgoleSLcDTBaQ/hz+wFxWnVVbOIAy
	QoBV7cAdUrNCjMFeYrWGt0Y=
X-Google-Smtp-Source: AGHT+IFUDXjiq70+RZxEzqU459peXqmTo1Le9iCSGpjzErTKvXMA6F9V4x+iBAUWAkD1AbnoosKDDg==
X-Received: by 2002:a17:90a:d187:b0:28d:19ff:5e3f with SMTP id fu7-20020a17090ad18700b0028d19ff5e3fmr875417pjb.86.1704974363859;
        Thu, 11 Jan 2024 03:59:23 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id sk3-20020a17090b2dc300b0028d276f078asm3603261pjb.43.2024.01.11.03.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 03:59:23 -0800 (PST)
Date: Thu, 11 Jan 2024 20:59:22 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jim Quinlan <jim2101024@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Cyril Brulebois <kibi@debian.org>,
	Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Phil Elwell <phil@raspberrypi.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 0/2] PCI: brcmstb: Configure appropriate HW CLKREQ#
 mode
Message-ID: <20240111115922.GB1443933@rocinante>
References: <ae49227b-5026-43a4-8e19-aeeb63865a6a@broadcom.com>
 <20231213195947.GA1056194@bhelgaas>
 <CANCKTBvaFBXAVTBtr4tpz5mYcyP1w84nAEGHbOnGJugogHx4fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCKTBvaFBXAVTBtr4tpz5mYcyP1w84nAEGHbOnGJugogHx4fQ@mail.gmail.com>

Hello,

[...]
> What is the status of this submission?

Looks good!  I apologise for the delay.

Bjorn is keen to pick this up for 6.8 with other changes, so it should land
there shortly, given that we have a merge window open now.

	Krzysztof

