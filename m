Return-Path: <linux-pci+bounces-12539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0511966C79
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 00:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BA91F229EF
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 22:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33A21C2DC7;
	Fri, 30 Aug 2024 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IrI86eVD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6C1C233B
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725057120; cv=none; b=Ul4TamYplot5q62jAY964IZ4+x02URfmsBR4TraEvIC2SUs7SaqXu0weUxD/3uQlTsWk3o9NL7I4ZXYonTqE46v5gZOb+/3sKEomQzGuwoT0QEq0rNEwg2xsVu9a7D1BL8xErtEn2/IOnEDg8elIvBGUl4IOgjzXeNMDvdLH5nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725057120; c=relaxed/simple;
	bh=hHzLblhbrXJK+/G9raoIs399iqss/9FXwR5tgGPtjHI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlnyMXdlenhdG9zHBjdv1RSY+DGTIbwOt1ukS85aUXeQyoRH/Zh2pSJ7Y7fz66oIWRQy2AIthqUkButfr/73vWxv3oeeh/ibJHjdbhy8pp2whrFGap/TfBPwYm5EoSgWQXvVe6Bs+gTXtcR/IetILLQBNujDt9bBO97Oiry940o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IrI86eVD; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5334879ba28so3238714e87.3
        for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 15:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725057116; x=1725661916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FuOHjHN01pwLhTn870hGi0iyigFDRibUrDrwMdxDl98=;
        b=IrI86eVDg2/wYDZQDlPMxC9/wv3dhUk6p8jIbcb0ybgmlva31/PINL3i3+UDhiZqiP
         MVUt4Fnifkv1ske37BXvH3v9WBAxMv53Eztln2qqrTrxmE7TxOVdr4VbkqME4bEqNStj
         XO+R4S0AMifdsZEueHH8AQQOqlDtRL0RSGlvB78AgLE0v1OOyaVCmbnQufRuNt7kJAjb
         XD2k6NAJLCnHFEGStm/In2cnhT84ZannyVhPNt5lejbruB+WM/+h0En6qVZxkSW79teL
         JaKBuHDtxCuGT+YHO/ECn13UxmmJ/ult2z5vWtuSTBD62XlR8xS7WFBkjXdE+qNyppS1
         cx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725057116; x=1725661916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuOHjHN01pwLhTn870hGi0iyigFDRibUrDrwMdxDl98=;
        b=ZSCWx88HoSO22c5e8NSWtH/YGJF2D1CzfaAIQPjx1a0DjdIPtBSH/SamwzeUC3/L9R
         FCpQtMfVsXZSSdea79a7gQtstP00fPzBZBHT3A0GOhdZOR6JcZyEO1ZSdEY+MVkqH/AC
         4e1kkfj5nNsTFoHfPZBBIWpWo2rqkvSfaCtzR4wHi4nD2Y1OwOqachoiCjF9nNSweM11
         OvaKhRqryd1YLMqWkc/Bup5J6rFDU2WjvkcVHh4D3WiKEi3F9QP+PpXRxFVvzM0izq3o
         82vFVT4DRbLvc+el1387r/6KsUfpCMuXWYa75jg4pR8JXGbtb5luGcaMAMUsQqCtUnHM
         NSmw==
X-Forwarded-Encrypted: i=1; AJvYcCUItHwsEen3TCEdgLZ75uarS32ZYJKCLYZpoItnHY9BMv7kgnsHu2VXy4wuQRB++L2NwEk3p0eQ6yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn7FAlBX0DrnxWnZ+lrZWt3JAjLOZDup4vqwD9EQKqTDuYef7D
	An6R4v7fmFxPqIEI7DYRVgpWWu03+cnBviV4ObTRYLzelunG4gPd+vLU2y5reh4=
X-Google-Smtp-Source: AGHT+IGclcXXmfEYFitTuWbyIOxJTqBHu8I4vUSw06+6AvY4Xvz0PRfaVlPP3p7/PlrqVhE+LPRQGg==
X-Received: by 2002:a05:6512:3b11:b0:52c:e054:4149 with SMTP id 2adb3069b0e04-53546b052fdmr2712927e87.15.1725057115910;
        Fri, 30 Aug 2024 15:31:55 -0700 (PDT)
Received: from localhost (host-80-182-198-72.pool80182.interbusiness.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6f9esm260898466b.154.2024.08.30.15.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 15:31:55 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Sat, 31 Aug 2024 00:32:02 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 10/11] net: macb: Add support for RP1's MACB variant
Message-ID: <ZtJIYsBa07nJE6os@apocalypse>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <775000dfb3a35bc691010072942253cb022750e1.1724159867.git.andrea.porta@suse.com>
 <cfysm2r6sswmvrch34pk5dx4wum3rohcxdla7i5qoh6vizgklb@pk5i7nzlnp67>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfysm2r6sswmvrch34pk5dx4wum3rohcxdla7i5qoh6vizgklb@pk5i7nzlnp67>

Hi Krzysztof,

On 10:49 Wed 21 Aug     , Krzysztof Kozlowski wrote:
> On Tue, Aug 20, 2024 at 04:36:12PM +0200, Andrea della Porta wrote:
> > RaspberryPi RP1 contains Cadence's MACB core. Implement the
> > changes to be able to operate the customization in the RP1.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> 
> 
> > @@ -5100,6 +5214,11 @@ static int macb_probe(struct platform_device *pdev)
> >  			}
> >  		}
> >  	}
> > +
> > +	device_property_read_u8(&pdev->dev, "cdns,aw2w-max-pipe", &bp->aw2w_max_pipe);
> > +	device_property_read_u8(&pdev->dev, "cdns,ar2r-max-pipe", &bp->ar2r_max_pipe);
> 
> Where are the bindings?

As stated in the cover letter, this patch (and the dtb patch #11 for macb) is completely
unpolished and intended only for a quick test of the ethernet peripheral underneath
the RP1.  As such, it's not intended to be upstreamed yet.
However, your feedback is really appreaciated and will be used in a future patch that
will deal with ethernet mac support.

> 
> > +	bp->use_aw2b_fill = device_property_read_bool(&pdev->dev, "cdns,use-aw2b-fill");
> > +
> >  	spin_lock_init(&bp->lock);
> >  
> >  	/* setup capabilities */
> > @@ -5155,6 +5274,21 @@ static int macb_probe(struct platform_device *pdev)
> >  	else
> >  		bp->phy_interface = interface;
> >  
> > +	/* optional PHY reset-related properties */
> > +	bp->phy_reset_gpio = devm_gpiod_get_optional(&pdev->dev, "phy-reset",
> 
> Where is the binding?

Ditto.

> 
> > +						     GPIOD_OUT_LOW);
> > +	if (IS_ERR(bp->phy_reset_gpio)) {
> > +		dev_err(&pdev->dev, "Failed to obtain phy-reset gpio\n");
> > +		err = PTR_ERR(bp->phy_reset_gpio);
> > +		goto err_out_free_netdev;
> > +	}
> > +
> > +	bp->phy_reset_ms = 10;
> > +	of_property_read_u32(np, "phy-reset-duration", &bp->phy_reset_ms);
> 
> Where is the binding?

Ditto.

Cheers,
Andrea

> 
> > +	/* A sane reset duration should not be longer than 1s */
> > +	if (bp->phy_reset_ms > 1000)
> > +		bp->phy_reset_ms = 1000;
> > +
> >  	/* IP specific init */
> >  	err = init(pdev);
> 
> Best regards,
> Krzysztof
> 

