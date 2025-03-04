Return-Path: <linux-pci+bounces-22883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D96A4E955
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 18:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F84177699
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F832376E6;
	Tue,  4 Mar 2025 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="abSM0goa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2023E292FAE
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108064; cv=none; b=X7aGq+qyLrlRZyI+IUCxXX2mkF37/yuOYf2Wtw9qtN0SGmMPyZIvkhhM8WHEskrcElUxqh4Pvy0jHA8cIOL+T5dsPL1LKD7QSSH2xEKUoHoYfdPeDiEmWhlJqTBDtiDM0pBDjNhND4XmtOEZixVWqldKxDKTrHZQV4myzQlf+rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108064; c=relaxed/simple;
	bh=QHv5JCwHtgDm/Ul5VHa++1ruQ4G4MsndKdh1G1m7pDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiM8InTtl1IQop8BjrZxhWRue1/Upw2uG8rfFtLBe9XnrDnNeWCEGd1dxzAKZo2+vY3EIA++44vOgxGrXm5ZTw3gch2EwsFJlFoKmoXJ0QTu6IfCdx7TnInPEW5JsioJjuQvx1+ILplijXKsw/ZN7L8ki87i3oI9bB8/dYwSqK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=abSM0goa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223a7065ff8so67817765ad.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 09:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741108062; x=1741712862; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LA/gKQoFR6dHj4YM+SZIs58tGSpb3MhpX5oaTo2PxFg=;
        b=abSM0goanpsDmjrSzBLrQkIyUFXrKBoZCvyIlTeWoanmxO69DjIO3u/ev3mL63S4J3
         1OkzZFAwZsU0ZghEFuWZD+9WR8yjBlwWKQJQnNhZYisoqCfta5fHxbkKTE89v5kgfJMB
         moYR3Aw+CHbMW0AM8tg76pk8kNsHHnXSH6aIPJuuubElJz7e14H5iDD59wKCIF87cF3Q
         LeDAUiFSamt+x8V34CtpflIZTihuXlf437Eus+ZQQ3N8mhYoJ//bx9kx+anrGQA5hvpB
         lwIY3XNJzKLif1t4IMaQQIWrjDctmj0PDKBdWQsiRxEfMyy47hN8QT3FvmEZA4zx7M7/
         dV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741108062; x=1741712862;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LA/gKQoFR6dHj4YM+SZIs58tGSpb3MhpX5oaTo2PxFg=;
        b=iTjYZF8n03VvlaBxEDMoiHYS6fgEj56eZXWGMf1sfHGzVivh1OKY62xVDcpyF5rMGz
         fhpmh0TLmy3mnmqV3Q3POPaVGWA96A+7IE8yF+LEPhMLHQ5+CB0eUt4o4x4kGtKzMaRH
         F/JozdBySpbTJq1wURudJc1mrTgOCbtg0DK7da7Tls9T9nEbHNHwAky2aJQ2p2itvFnF
         uMh0xFzEPs5p2vedv2wt4F1O0amPKCsgouwS0TSBnM0093jjgY23Z07PyQBjAhLz2yMT
         F3Y5JxtZ3l3W/ReBovJKQ/c/hIfvpYo8TMFQnn0H46D+v55JND6GUFXFo3Og1HspQXmN
         P2zQ==
X-Gm-Message-State: AOJu0YxZREwCnDVxKFlYgxuoKUK7B7QYW1KP6bdwkcEf1G90ahxJktR7
	zUFA5JlQG0U6ZcqS9rkDfpBip0QMdOIWUjcLpBtLjlC9DNH6fcZfkjpacHgILw==
X-Gm-Gg: ASbGnct1oHBSXh554tdojyjgpFPG58bH8RyWt3iCleOjUGhPfBqFNvyH3gPoa3Rywvt
	JKE6+M25T/jJXijJABEXcwFgV30wm+iBL4waTLWA2rubRnJMOeHak8xWj56T3oju1ssPh2Y9OY0
	/+j11AWsWY6k4b9VhAYm8IEmc/TSda3tKXp/JpFFY7ouZ9gXbKDyBK4UQLG76Qb+lRCkZy4jiHZ
	6t+S5yfa6k3B9phGoVURskez7GGSuuJdGRexJ3JoeFftoCWPYROBPvZd5jyxpFSeJBG6WB6gAc7
	oLKBfWuyMBCZMGBo4VTNAtM8auH256gVKnenG/UTgB8yr16UjiFelBc=
X-Google-Smtp-Source: AGHT+IG9lPytOJ+a9BnKqGkMxxZf/h6DwbYyJiWJ/Q5mVWVtyO5FnvNkcSD22Lz3G7gAfZDKnHhRPQ==
X-Received: by 2002:a05:6a00:1250:b0:736:5664:53f3 with SMTP id d2e1a72fcca58-73656645c9cmr11645970b3a.15.1741108062382;
        Tue, 04 Mar 2025 09:07:42 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003fa5csm11529695b3a.145.2025.03.04.09.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:07:41 -0800 (PST)
Date: Tue, 4 Mar 2025 22:37:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/8] PCI: brcmstb: Fix error path upon call of
 regulator_bulk_get()
Message-ID: <20250304170735.x25c65azfpd7xmwv@thinkpad>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-5-james.quinlan@broadcom.com>
 <20250304150313.ey4fky35bu6dbtxd@thinkpad>
 <CA+-6iNyuQskVNjAuX1QcLTPetbfhogGYUTOA01QwNw9YcwAdNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNyuQskVNjAuX1QcLTPetbfhogGYUTOA01QwNw9YcwAdNQ@mail.gmail.com>

On Tue, Mar 04, 2025 at 11:55:05AM -0500, Jim Quinlan wrote:
> On Tue, Mar 4, 2025 at 10:03 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Fri, Feb 14, 2025 at 12:39:32PM -0500, Jim Quinlan wrote:
> > > If regulator_bulk_get() returns an error, no regulators are created and we
> > > need to set their number to zero.  If we do not do this and the PCIe
> > > link-up fails, regulator_bulk_free() will be invoked and effect a panic.
> > >
> > > Also print out the error value, as we cannot return an error upwards as
> > > Linux will WARN on an error from add_bus().
> > >
> > > Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
> > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > ---
> > >  drivers/pci/controller/pcie-brcmstb.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > index e0b20f58c604..56b49d3cae19 100644
> > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > @@ -1416,7 +1416,8 @@ static int brcm_pcie_add_bus(struct pci_bus *bus)
> > >
> > >               ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
> > >               if (ret) {
> > > -                     dev_info(dev, "No regulators for downstream device\n");
> > > +                     dev_info(dev, "Did not get regulators; err=%d\n", ret);
> >
> > Why is this dev_info() instead of dev_err()?
> 
> I will change this.
> >
> > > +                     pcie->sr = NULL;
> >
> > Why can't you set 'pcie->sr' after successfull regulator_bulk_get()?
> 
> Not sure I understand -- it is already set before a  successful
> regulator_bulk_get() call.

Didn't I say 'after'?

> I set it to NULL after an unsuccessful result so the structure will
> not be passed to subsequent calls.
> 

If you set the pointer after a successful regulator_bulk_get(), you do not need
to set it to NULL for a failure.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

