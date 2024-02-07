Return-Path: <linux-pci+bounces-3204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA2A84CAC5
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 13:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736D028C77D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 12:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF57A76032;
	Wed,  7 Feb 2024 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNEXD5EA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3188F76037;
	Wed,  7 Feb 2024 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707309457; cv=none; b=e6HxcrAJc+pzrMiMMLnIylcircXAJP5eIAOzQtWxcLzgM3TvcoE68CaRAFCdNS9GCwsEQ7JzBLj9jLmq+5oCTopqjM9xH82UbYlgpKykLNTVVMBFN+fWMPhE6WFEWksyvRlg2C4NOy8WI/b8F9VK9dtoHEv4vXlksWMhKpi11j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707309457; c=relaxed/simple;
	bh=JYSGh6UALamju5u5Q0FvgbPBMp9aifKa7BR1nqjWr8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDXzj75nEDF06UBkSr6RG+/Ix2ZKJFZQ8VoZzGXXMqmG1qcrKK/Em/Xo3SVQ7L/KPDwpqz+OzkPqjWPd9105cGN85skex8TacQCdQVsRzKvv0nzs1T1Nqbh36O0Exv/6Vcx8pJPSK1DlWqtKPN24qZELcHJGQpDmWa4k6hn3/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNEXD5EA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51142b5b76dso947135e87.2;
        Wed, 07 Feb 2024 04:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707309454; x=1707914254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGCMNGG4Outy/qci7fXlqmZvH2mFLm4kVAJGLfS6kyc=;
        b=fNEXD5EAihREMOkKm+v+4oAemofj7IsWSwXB/Ur2Nhx7YwxkZHDKj2FuyhmAx1Nw71
         v0EvtfoQYmo/wlWGcPETmWch6C5HHybaFop5TgZp1uho/hGDv6AfZfxWoexvCQpv6cyd
         f/mXk+be8hTdv5Yn/qAOkR2WkpYWeq2413yXmFC8HUzuXHvgPih0G5h9dYcpVWReoH3C
         q2IobDppVbw3bKnHNCoh5dmYrR4mdVR9JONogW8iFJ87kfoPOc/zD34foH/0vDwmd8ln
         NbcZ/IhJF403oDhtF90bBzl15W8NAZkhWdY28HuJ6PeKLmpRivuvt9ApMbFWDfeAcMvR
         gPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707309454; x=1707914254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGCMNGG4Outy/qci7fXlqmZvH2mFLm4kVAJGLfS6kyc=;
        b=ZkxJk3ukxahIXMcqODjO7rtl6DEscRwP/hwAE28aKdM1c/8ONqp8ODYqL+93iVBupO
         kg5UmlQsRXfaUnWHRzpMzECLA4mWgiRWnOmyvOKXfNUDHyZprYGSolOPIJmwlCCUVasz
         KY0IFmHSSPHfZnQMHFa9kfZytSkUU+A+/DWTHWbVX71AlY9pBmTuSDxZZvp5QyFXJHLk
         +A4rHKg0+qX4bwzmXt+le9guoFRpBKRjMbQilo3asXe2ODZed7tat4ckcW7O1MiizD2d
         cGE53qBaKHjGoWj9U0mcPx4OTAnctkLmcWAmIm03uq+oGwfue8ruJE1RAsktaA1Stkyc
         g+BQ==
X-Gm-Message-State: AOJu0Yy9d1O8srwGg6/3nIiWEZWibSep6VSLlICp85P/9c1ifJyRQ418
	vSHQ9AZTgqK44KR9L9YnmKEgdaJi98KRnYxhr6QaQu9i9bSCNzbh
X-Google-Smtp-Source: AGHT+IFmdZIvSukjR3HB+CHNwYdlKLeGdKD2AlYJsMfK/dq72+aokU/wJNSuID6UbnlZyL1HjQOGFw==
X-Received: by 2002:a05:6512:32ab:b0:511:627e:36cd with SMTP id q11-20020a05651232ab00b00511627e36cdmr2765484lfe.24.1707309453846;
        Wed, 07 Feb 2024 04:37:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSR8gTLtdE6q+cbgDFP453ovI67jbu3o5RbMRzLK9RbioD1CNwftojad54BRvTf2dK3D9SdGo7Rz+RTI9YpNMInSGmopiV34RdOfeX4Vlkrczj7XDDus4iCEXTLj4Wu1Qu/t0651NhofHIbg2K4zm+4azluHsQ4Jl6tXb2b20jXcxzqmtsk0PuPqGeYzIVsJvoriQGSt7Qz0x4kkAg/ef+MXWD5MB9QVc0Eqk5Bv9TfXSI63HN6+l0mY9G1qfXbA+fyWii6uaXJMp30Q1DE8RTiUkTEVyg7RQhkvaCq2tvHgZ9ePJhCHvnkRd8jhZ5lQ/q34ZOprPVtsQXIf9pXQikeIkoHzC88Z8SaEc4ptRSffUA9JjYMoxpX4Qve8lqCoYqt7ag6AOSqgiKFYgV4vWONzD3k7z1HCIutWHGfZNjICvzNTPRzFn6s/1Y0OtDsvaGrlItGFnJKB/KrGE=
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 8-20020ac25f48000000b005114ee99515sm165135lfz.220.2024.02.07.04.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:37:33 -0800 (PST)
Date: Wed, 7 Feb 2024 15:37:30 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Frank Li <Frank.li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: PCI: dwc: Add 'msg' register region
Message-ID: <luk5hswq4wnk5p7axml73qih35hio3y3pfnklctbn6rwres62s@mumnvygjh5ch>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
 <20240202-pme_msg-v3-5-ff2af57a02ad@nxp.com>
 <eg7wrjp5ebz43g37fvebr44nwkoh4rptbtyu76nalbmgbbnqke@4zugpgwesyqd>
 <20240205183048.GA3818249-robh@kernel.org>
 <ZcEzYdZKotBJlR5i@lizhi-Precision-Tower-5810>
 <ZcK2/tmLG9O7CBEH@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcK2/tmLG9O7CBEH@lizhi-Precision-Tower-5810>

On Tue, Feb 06, 2024 at 05:47:26PM -0500, Frank Li wrote:
> On Mon, Feb 05, 2024 at 02:13:37PM -0500, Frank Li wrote:
> > On Mon, Feb 05, 2024 at 06:30:48PM +0000, Rob Herring wrote:
> > > On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wrote:
> > > > On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> > > > > Add an outbound iATU-capable memory-region which will be used to send PCIe
> > > > > message (such as PME_Turn_Off) to peripheral. So all platforms can use
> > > > > common method to send out PME_Turn_Off message by using one outbound iATU.
> > > > > 
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > index 022055edbf9e6..25a5420a9ce1e 100644
> > > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > @@ -101,6 +101,10 @@ properties:
> > > > 
> > > > >              Outbound iATU-capable memory-region which will be used to access
> > > > >              the peripheral PCIe devices configuration space.
> > > > >            const: config
> > > > > +        - description:
> > > > > +            Outbound iATU-capable memory-region which will be used to send
> > > > > +            PCIe message (such as PME_Turn_Off) to peripheral.
> > > > > +          const: msg
> > > > 
> > > > Note there is a good chance Rob won't like this change. AFAIR he
> > > > already expressed a concern regarding having the "config" reg-name
> > > > describing a memory space within the outbound iATU memory which is
> > > > normally defined by the "ranges" property. Adding a new reg-entry with
> > > > similar semantics I guess won't receive warm welcome.
> > > 
> > > I do think it is a bit questionable. Ideally, the driver could 
> > > just configure this on its own. However, since we don't describe all of 
> > > the CPU address space (that's input to the iATU) already, that's not 
> > > going to be possible. I suppose we could fix that, but then config space 
> > > would have to be handled differently too.
> > 
> > Sorry, I have not understand what your means. Do you means, you want
> > a "cpu-space", for example, 0x8000000 - 0x9000000 for all ATU. 
> > 
> > Then allocated some space to 'config', 'io', 'memory' and this 'msg'.
> 
> @rob:
> 
>     So far, I think "msg" is feasilbe solution. Or give me some little
> detail direction?

Found the Rob' note about the iATU-space chunks utilized in the reg
property:
https://lore.kernel.org/linux-pci/CAL_JsqLp7QVgxrAZkW=z38iB7SV5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com/

So basically Rob meant back then that
either originally we should have defined a new reg-name like "atu-out"
with the entire outbound iATU CPU-space specified and unpin the
regions like "config"/"ecam"/"msg"/etc from there in the driver
or, well, stick to the chunking further. The later path was chosen
after the patch with the "ecam" reg-name was accepted (see the link
above).

Really ECAM/config space access, custom TLP messages, legacy interrupt
TLPs, etc are all application-specific features. Each of them is
implemented based on a bit specific but basically the same outbound
iATU engine setup. Thus from the "DT is a hardware description" point
of view it would have been enough to describe the entire outbound iATU
CPU address space and then let the software do the space
reconfiguration in runtime based on it' application needs.

* Rob, correct me if am wrong.

On the other hand it's possible to have more than one disjoint CPU
address region handled by the outbound iATU (especially if there is no
AXI-bridge enabled, see XALI - application transmit client interfaces
in HW manual). Thus having a single reg-property might get to be
inapplicable in some cases. Thinking about that got me to an idea.
What about just extending the PCIe "ranges" property flags
(IORESOURCE_TYPE_BITS) with the new ones in this case indicating the
TLP Msg mapping? Thus we can avoid creating app-specific reg-names and
use the flag to define a custom memory range for the TLP messages
generation. At some point it can be also utilized for the config-space
mapping. What do you think?

-Serge(y)

> 
> Frank
> 
> > 
> > Frank
> > 
> > > 
> > > Rob

