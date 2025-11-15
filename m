Return-Path: <linux-pci+bounces-41295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ED3C602BB
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 10:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57E1034AD2C
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD290281525;
	Sat, 15 Nov 2025 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9bIyFi3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161BE281532
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763200298; cv=none; b=q5KmChrDMx4YkyDMzUXADZ3VtL0l3dChsTzQl9O+vzPMtXgo4PaaV2+dGljK5PUQXu8ZGEfZMicL1bx/1lqpfDnQ2DMxyX8ncveVBPU7anNtgh26CpcJLyHFqs3o4ZOQpePTs8oQFA/FId/9rXPemQcjfjCdFXM2pyJzBRjKvi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763200298; c=relaxed/simple;
	bh=CDcBesjBeDH8HiQdDnJyVwV7463lVlwERDCq6R1p72Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsmfhiUJF2SLIyH/8hH/O6gAj0xg++vvju7AE4XC5ZRf3v+CnJ7JUI6inC83pXab7lZJ3NkhTkYkvfkXAOsPX6pfl04DYad/1qhVEcYMv9F/8XRMx9Ak9UH08U9E7Pq5N9HnNB+En9Ml6p1bJ2KTYbuQdP/wBI4pYyD9xwk07jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9bIyFi3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-295548467c7so32648565ad.2
        for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 01:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763200296; x=1763805096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yRRIzPGF37+ZW/9QuVq1mSuHX636hF32XUa+RdwYXc=;
        b=k9bIyFi3ttsIsIuotUcvTVB/DpZb5VM+Jy+jtm+LjkVWVrPp+0VPzxKQ0He8Nm8Gmx
         yYA6PBdemeNmPwn1YuSdiinhTjlkSqwikz0r7BPWpHZSsn90B9i/HPGyM2GDZ2EH6mgE
         31sRP4yASEek9bJ6Xo/eMpZME4+lDWLukT73xtBul5JrhRNT+REBkYIwwibJAsfAQgIe
         1Nl+QQMNfM+Dk0qrqvhZGtk5BQc1gBI1PmRwF6+aKRaTtrfpZmdMN/pTaORKL9xJwgt6
         hai2lUvW3OwTzdk18yYh7aapvusV1iE4YjAYjb0aXyUtiyO2JJvMrae7CBd7fwrsSAb3
         xu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763200296; x=1763805096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yRRIzPGF37+ZW/9QuVq1mSuHX636hF32XUa+RdwYXc=;
        b=IGtJasF9cbCLnJB+OqBhdwibRF1ybgr/9pHzqBoqcR/Znk6U14wo1WV/CLLKK5JVCm
         N/kVpNnzSqnPuTKtNwSQiqjwv27k4L2fCD+KkB0owcja32qyDO2BNm76h/yuxY8max7K
         ARFxlT1W7MxlnwAc+XLpSBjUI5ilCpATPViDLljeG9w+ScJsvJmWYtgL2C2291ycADFr
         AOlkcg5KfrFxYvVSJeA+IAs96T8ZSBkABldUJG7r5RgT9FevP/0WRNenbMLNV9SebDHm
         lTwphNwd4xr1F0BRDh6AnFxtV2N0ePyQ5+eSGrUVHgBl5mW30oWEfGPy3exBtP5QK6bf
         dn9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSGLkvWo2zLtf6N+0iX5pMOuuTEvDgzSRkV+p/+4Ypy00aewfSvJvqAtww2yXmf55YdXd805t+D5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp5j/IbEELKE7nwWv5v3D6JN5evnBta0b2fmTbZkAkJetj1dVY
	UW8QTFneaZ/lV9KJVxmObaLpDgAdddo7gV/SEti+UpH4cbrfbZUyPlV5
X-Gm-Gg: ASbGncv8Eg0p3Tov9YnfPRMjqCguBPKQm97ikb091Xstlv11un39Ejadhc8gwVeqSX/
	ZSpxWZfRWGmbodPqPb5CP6IuZHcqN6wBp72ugGJ0fbjc2NxmZzPh6o/A00SC+kvw5aWuvZ4Q137
	A5BqqBzeBClpPQLRBMYaouVQfoY8CkpG0gs0KdQo2K29/LtHsQroaBXXm/2ej2heNznQ4/WF1Am
	Oc0UlhH5JYHmxQo9HqXkqdeZG94wmDe4IqabSK9X8Q9sHxxew86HbaRDnnNb4TH+WNHwq+xgewf
	Fl6g7EiEjPSzolYOHJOQ8kOGFmscEqEsErBqbcNmDtHFS474lKZ1OyTVbQdNxaHrrvgep1sw0ki
	K5Va/iRZSp95+DDWHW/huadkXlURy57YjynhCr5J+aEeLv5pOS4YcTMQqCNyaMOXIWCKbfrdRYQ
	==
X-Google-Smtp-Source: AGHT+IHDzihlPaHj5ciPC1avrMW/DUXWk3g/TfMMzpdbx9pWLRPYDr6Bl34n8EK+fex8PZCS0cSmgg==
X-Received: by 2002:a05:701b:2803:b0:119:e569:fbad with SMTP id a92af1059eb24-11b411fd316mr1430818c88.28.1763200296250;
        Sat, 15 Nov 2025 01:51:36 -0800 (PST)
Received: from geday ([2804:7f2:800b:a121::dead:c001])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db102f5sm16211340eec.4.2025.11.15.01.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 01:51:35 -0800 (PST)
Date: Sat, 15 Nov 2025 06:51:29 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH 2/3] PCI: rockchip-host: comment danger of 5.0 GT/s speed
Message-ID: <aRhNIcGcQKp2ylqN@geday>
References: <cover.1763197368.git.geraldogabriel@gmail.com>
 <b04ed0deb42c914847dd28233010f9573d6b5902.1763197368.git.geraldogabriel@gmail.com>
 <c8a6d165-2cdd-cd0d-4bed-95dfa5ff30d2@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8a6d165-2cdd-cd0d-4bed-95dfa5ff30d2@manjaro.org>

On Sat, Nov 15, 2025 at 10:30:49AM +0100, Dragan Simic wrote:
> Hello Geraldo,
> 
> On Saturday, November 15, 2025 10:10 CET, Geraldo Nascimento <geraldogabriel@gmail.com> wrote:
> > According to Rockchip sources, there is grave danger in enabling 5.0
> > GT/s speed for this core. Add a comment documenting that danger and
> > discouraging end-users from forcing higher speed through DT changes.
> > 
> > Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
> > Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-rockchip-host.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> > index ee1822ca01db..7e6ff76466b7 100644
> > --- a/drivers/pci/controller/pcie-rockchip-host.c
> > +++ b/drivers/pci/controller/pcie-rockchip-host.c
> > @@ -332,6 +332,11 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
> >  		/*
> >  		 * Enable retrain for gen2. This should be configured only after
> >  		 * gen1 finished.
> > +		 *
> > +		 * According to Rockchip this path is dangerous and may lead to
> > +		 * catastrophic failure. Even if the odds are small, users are
> > +		 * still discouraged to engage the corresponding DT option.
> > +		 *
> >  		 */
> >  		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
> >  		status &= ~PCI_EXP_LNKCTL2_TLS;
> 
> Looking good to me, thanks for this patch!  There's no need
> to emit warnings here, because they'd be emitted already in
> the rockchip_pcie_parse_dt() function.
> 
> Please feel free to include
> 
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
>

I disagree, I think the comment stands.

Even if we reduce to one line, ex:

+ May cause damage

Regards,
Geraldo Nascimento

