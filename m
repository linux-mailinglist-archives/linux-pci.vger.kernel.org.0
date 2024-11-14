Return-Path: <linux-pci+bounces-16766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F60B9C8DF4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 16:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CECEB2DA32
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 15:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8B8153803;
	Thu, 14 Nov 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T0lJt+QV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78B13AD29
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731597978; cv=none; b=J8OPhemlk4TuKTajwO9xoSTUtiU5O1HVhXvhx9vzftaS3wN/M9xbS4l9jWNq5KnBxEZRPc2DdHOlFYkFNLF7Y+Qt7UkT+jdDmozVIUh9Iy6rQQH7E2YIAFWjZEiWikXTEOYi1l2XTd+XMLnwinRyqTzL7yWkoXHOGDXGT9aalrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731597978; c=relaxed/simple;
	bh=OXm964+HL/oy8I5JgLPsZUm+UieJrQIuj9T2oe/JmoI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plX3pgPkUzeRI5kW05PcSk7utvd16mrNhDkZOw2sb7O4YAtpjWNqs9FY1wdLZAO6r8KD1EmU6RtJN89/tYwDLjobH+H4lYXUqjo1A0M1Map8IWU0r1VKn8rQ2XbOVgBMr7gkMo6HyALOc1GZkBRMN76U5lb0WIXCMQhVLfwO1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T0lJt+QV; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a99f646ff1bso105301766b.2
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 07:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731597975; x=1732202775; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BXfRuwtCQesbb+rpbVIxn9Ia55XQqIa+ED/3SCVnO+4=;
        b=T0lJt+QVOgMpe98LyY/OQg5CauvRzz5aZotWG53qpiINIQPfuqm94oJDgqqTpxKQpy
         VyPY7U+5O+0dC4OqfQqxD7ygF8MN4l31p3AAOahmwrJO8Jd/Zp5t1lx1dUKasPaKePKz
         5u2zO7f6XsMG7Q/iCIl6hgyDRzi9MNPi/u0NjMCu8GgXrYxT4s+qzsU/tdKaHPLlG1TH
         VTNCP7uaedHsnu4AIbUmGkCMNKJZTqEaX58qEthYKW73qRLo4BdAvR/OenXR7qAz4bQm
         Jtb8z+RKl38uYnU4VOuJcnn7WfXWidfo4zsFFj8ZlEIoPZdxRc6NBYqiOkUt4Vg7iFb9
         JjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731597975; x=1732202775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXfRuwtCQesbb+rpbVIxn9Ia55XQqIa+ED/3SCVnO+4=;
        b=jbN+ifEiNvK/+ZcLVlENl4sPE+2KZQQR+elvw+d1hjuhJV6G9/VQaWDNLjEixAeq4N
         RTnT7X+HH0N5sDdfboAB5lTSm3MXzilR+yZCg5Ih/gKswUa4S4ltDzyVIvxEyyFcsj1k
         6dyXuZX+39MYdxKzmSNZqyv2Q8EHyqAII/xex28uXMZO65dSrt6YOj3v8fChAH1eYBIZ
         QPGhps/muZL/0Cp5g8nSxRqkVSd+Yt+fAtofEQ3U50GSRlj1tpm+dU1EgmRePBA3xaBP
         kk3sHGYxolSS6AN6NzjfcgZi05M0dm5z1Xhf8t8fhjnz5z+nEmAiO4bfGFVAv8G2K4vF
         MppQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6FnqGEVjfon9IfYA/oONuIXl5J3BQKioFdQZUVAZhGdraLmCUs9uiN9iGYUyM+aHruNWZYHyqpSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziVjDWr6+6O4Hv94h0D+otl4HETriwqAAtXy6vRG0Sp6rkSFrb
	ljvcBLfRicqvcoSNG+YpAUqM+5AtMvOGUDez3OITWnTINiOow+jGD8lAC4X6lRY=
X-Google-Smtp-Source: AGHT+IGhM6/BPmoBjuRiiI1ewZRW9R+eE3BQ4H3+p/OJfSdyeRMIoasVpFD+sR2v6s9C5C6vSshsww==
X-Received: by 2002:a17:907:7b95:b0:a9a:c691:dcbc with SMTP id a640c23a62f3a-aa1b1024b29mr1127309766b.12.1731597974922;
        Thu, 14 Nov 2024 07:26:14 -0800 (PST)
Received: from localhost (host-79-19-144-50.retail.telecomitalia.it. [79.19.144.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e086ad4sm73543066b.199.2024.11.14.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:26:14 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 14 Nov 2024 16:26:42 +0100
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
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
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: of_property: Assign PCI instead of CPU bus address
 to dynamic PCI nodes
Message-ID: <ZzYWso5jLkUMehQ6@apocalypse>
References: <20241108094256.28933-1-andrea.porta@suse.com>
 <20241108110938.622014f5@bootlin.com>
 <Zy3koxz4KnV39__V@apocalypse>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zy3koxz4KnV39__V@apocalypse>

Hi,

On 11:14 Fri 08 Nov     , Andrea della Porta wrote:
> Hi herve,
> 
> On 11:09 Fri 08 Nov     , Herve Codina wrote:
> > Hi Andrea,
> > 
> > On Fri,  8 Nov 2024 10:42:56 +0100
> > Andrea della Porta <andrea.porta@suse.com> wrote:
> > 
> > > When populating "ranges" property for a PCI bridge or endpoint,
> > > of_pci_prop_ranges() incorrectly use the CPU bus address of the resource.
> > > In such PCI nodes, the window should instead be in PCI address space. Call
> > > pci_bus_address() on the resource in order to obtain the PCI bus
> > > address.
> > > 
> > > Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > Tested-by: Herve Codina <herve.codina@bootlin.com>
> > > ---
> > > This patch, originally preparatory for a bigger patchset (see [1]), has
> > > been splitted in a standalone one for better management and because it
> > > contains a bugfix which is probably of interest to stable branch.
> > 
> > Nothing to say for the patch itself.
> > 
> > Just here, you mentioned "see [1]" but you didn't provide the link.
> > 
> > IMHO, this is not blocking for applying the patch but, just for other people
> > looking at this email in the mailing list, can you reply providing the link?
> 
> Thanks for pointing that out, sorry about that. Here it is:
> 
> [1] - https://lore.kernel.org/all/f6b445b764312fd8ab96745fe4e97fb22f91ae4c.1730123575.git.andrea.porta@suse.com/

Do I have to resubmit the patch with the referenced url fixed or is it
ok as it is?

Thanks,
Andrea

> 
> Many thanks,
> Andrea
> 
> > 
> > Best regards,
> > Hervé

