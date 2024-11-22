Return-Path: <linux-pci+bounces-17216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 517DC9D62AA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 17:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B7B281D1B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 16:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CFA13B797;
	Fri, 22 Nov 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DzN8NUdD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED2F84D13
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732294641; cv=none; b=lTPrss56HbVFxsKsg1SdOmLXaORAd7ELhDUpQTbkhkVpgsxu3Z9pP8WDbMaaNeqizU/g8mcBmmGK7y3APAXDJQfR41o3Co68L9bH66CXYZsH/jpKcoU88DasAiQnutbxIqRzMewGAOUjL2tgqPxYfHI9oJkkuL5Ojsd1SDLEbto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732294641; c=relaxed/simple;
	bh=ZNhJ0AnnhsP1xQ5LpsDqA3efNo9VGhUGzrAteBE+23s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKk1FNXz+lcP9EHVKjdaC1uVcVMS8h8Nb85lG8HJGjqn7v+SFhDP/oriF9WCJTt3UZt6uM8S7qN6wCRe1VsbtiSrw2AEBz2lZ8gUkOqurxRoMPl0QeC/QBHGMZBiM6Al/4w9aGassJNpB49svoEE5ZOsEfhS+uqn+T4E/T7fU+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DzN8NUdD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-72467c35ddeso2593464b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 08:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732294639; x=1732899439; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FZwDSMvFnipM0RD36mLVFKH4L1T4MEAtnhkfsYAv+8A=;
        b=DzN8NUdDbQpmQAdaoEpIXWnp08e/npx6EmJAM8JakMqMmqIppy50mR9ngjEDIvaWIn
         5xM34u9ssPBDcvuhaHn+VcZC5j0VbJtDmQFJXJf4s1qf6I3rppcO/NIdalKYGx2n2voZ
         Nb5b4iBo0iEtVNRgXQEd+LgEl1A4/sGRs/7aL7H2HFVX70JoerR8+RMfzPu+2krn47jH
         fmwjOqZIdl2A2nED1Xgi+reld+CHBQwUAVVdIvGg8fJvpVV9SOTxJsHVINMofoxU7W1w
         FtJpmskiJmsaM1HAPGqW8BrJR8e8kQk5l6fxLn0p+k+UQI76KYVta+/GklsaBcL7oZLN
         kGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732294639; x=1732899439;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZwDSMvFnipM0RD36mLVFKH4L1T4MEAtnhkfsYAv+8A=;
        b=rG7CykxQOELHS/wiq+bH7rAh45p+kG3azRJ2XI8GJBeOm3XfUkn+bbadk4xEaTqFD/
         lJsU2oC6dpQgDzrwklbdlYIwJI5kMuSpxqsJjgZ9fl79bUg/mHRzTrqSLZpxeRyUpyQe
         2OwRyIr7pow5aXp5O/Gy6TPzRlpdqt6zDeHTak9TQgiQARFqojOLoLuwxRsmq1Osfxo2
         kzZ6vUd6qF5sU/20z2BPLG54g+QKUV8NfnooElouZPEeRNbIGRso2zmDNE1nH6Xkvq70
         OR53o7lLP/l0WBS/EYOOUdOGu0nqgKnrJRk+zPGH+vv5FLNcBxHjC7IS/AfSLUEd+540
         ji8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU18Z36IDF7q4rs1zYV8qFPehUxz07WQNxZyXV+BV6avEjMMdj1hn5qwTwp4mD5j9OVUtr358HEngo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjS6DFWX8LL1oQcSOFba2+Ql4pKc/DmB7zII6WeoQ8psUfrFHW
	X1mz0/LswDzIx7HZTaBbHlAAKEPF6jjoXOSRbcgKG7mbhK7PI3ADWj8m3O2hug==
X-Gm-Gg: ASbGncsIeenmTM7YD+sEQHUfcR36ywVIxQjbeDaByZPQgiu5nXX0hWQnOmkPCXhx0zJ
	o4gYGbg79BjivNKUF2+UdQnqxSi56zBm+Bfh7fYl4uotMMSm9NL2he2Lz+9KwTTHfKNivJWsPTO
	Ybps12ro1oOPp2lk1v+hLnW4+8VZrzkKlEu4I/0U47XdjT+cpXt90zV3+GUBIl+rezcoEg2H/dF
	IJwJL6X8IeLgiOMH5bgKayUS9ZOW+OMblJIvtwYmPAf3rL0v2WlYXvhVUtb
X-Google-Smtp-Source: AGHT+IEBQTm+mdF5/l17srn1QQIlJ8cpbCtyU3PjuFrTHKPmmM8RGnmeO63H3UfI8TU8tQ6zNeMktQ==
X-Received: by 2002:a17:902:d2c3:b0:20c:6bff:fcb1 with SMTP id d9443c01a7336-2129fe0903emr55796195ad.1.1732294639012;
        Fri, 22 Nov 2024 08:57:19 -0800 (PST)
Received: from thinkpad ([49.207.202.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc21a1asm18338035ad.222.2024.11.22.08.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 08:57:18 -0800 (PST)
Date: Fri, 22 Nov 2024 22:27:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/10] PCI: imx6: Use dwc common suspend resume method
Message-ID: <20241122165712.5m7xuycxzjzatf35@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-9-hongxing.zhu@nxp.com>
 <20241115070932.vt4cqshyjtks2hq4@thinkpad>
 <ZzeHGd/vfNFgsID2@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzeHGd/vfNFgsID2@lizhi-Precision-Tower-5810>

On Fri, Nov 15, 2024 at 12:38:33PM -0500, Frank Li wrote:
> On Fri, Nov 15, 2024 at 12:39:32PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Nov 01, 2024 at 03:06:08PM +0800, Richard Zhu wrote:
> > > From: Frank Li <Frank.Li@nxp.com>
> > >
> > > Call common dwc suspend/resume function. Use dwc common iATU method to
> > > send out PME_TURN_OFF message. In Old DWC implementations,
> > > PCIE_ATU_INHIBIT_PAYLOAD bit in iATU Ctrl2 register is reserved. So the
> > > generic DWC implementation of sending the PME_Turn_Off message using a
> > > dummy MMIO write cannot be used. Use previouse method to kick off
> > > PME_TURN_OFF MSG for these platforms.
> > >
> > > Replace the imx_pcie_stop_link() and imx_pcie_host_exit() by
> > > dw_pcie_suspend_noirq() in imx_pcie_suspend_noirq().
> > >
> > > Since dw_pcie_suspend_noirq() already does these, see below call stack:
> > > dw_pcie_suspend_noirq()
> > >   dw_pcie_stop_link();
> > >     imx_pcie_stop_link();
> > >   pci->pp.ops->deinit();
> > >     imx_pcie_host_exit();
> > >
> > > Replace the imx_pcie_host_init(), dw_pcie_setup_rc() and
> > > imx_pcie_start_link() by dw_pcie_resume_noirq() in
> > > imx_pcie_resume_noirq().
> > >
> > > Since dw_pcie_resume_noirq() already does these, see below call stack:
> > > dw_pcie_resume_noirq()
> > >   pci->pp.ops->init();
> > >     imx_pcie_host_init();
> > >   dw_pcie_setup_rc();
> > >   dw_pcie_start_link();
> > >     imx_pcie_start_link();
> > >
> >
> > Are these two changes (dw_pcie_suspend_noirq(), dw_pcie_resume_noirq()) related
> > to this patch? If not, these should be in a separate patch.
> 
> 
> Sorry, this patch have not touch dw_pcie_suspend_noirq() and
> dw_pcie_resume_noirq()'s implement, just call it. I have not understood
> what's your means.
> 

Sorry, I got confused. Please ignore above comment.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

