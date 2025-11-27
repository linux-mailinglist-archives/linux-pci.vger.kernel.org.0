Return-Path: <linux-pci+bounces-42184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDD7C8CF7B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 07:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 454734E438E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 06:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41422D837C;
	Thu, 27 Nov 2025 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ii9VecIH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0322F1FC3
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764226404; cv=none; b=YrN7eLqyCgFNP77oGiKbRT2uEnXEh4f9A/CbdYpf/YlbY0KMpQT7zhF4X731cFKi4IwrEMCwJqOQu7bhdKKbrEwM/5BzyxjkeKlhofMXD/D57c57MEthfSwYcPMmsGjgNrWM2iRGGMhhy4GQJKUMlANcR7PV1qEJ+Cx71Rr/tHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764226404; c=relaxed/simple;
	bh=d7//LDXSumbJJihDYb9lQKXayXscyZUEfuYyatlPbBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p41J2Yt5jmZ/2cIv+L06+Y5IJWf0yIriU+nFtqZZGLYtned1Ggc1XkeMLDmYsK8++b70cgRKQcQc8oVYAH295ytR/wDiSRbOdQ0rd6m2LGzTH16+hj6r+tiRdWtVH5sT3pMZhY8XKasXdoRFNJ3omxGPTCTt50KEkRHxCRwFAnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ii9VecIH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso1019900a12.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 22:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764226400; x=1764831200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=amIVj6Ks/T19JV0gGyF2jbDkQIb/QLUq7CyFhU9t8+g=;
        b=Ii9VecIHteyNNorOsDsiWx99M11FUurqmHK0ZtmCRtlM9Dy0k9apEhvvHuowxEl/ob
         iQuwdxTCITH7ub0lAbVSYD2Jh7Hnnse6uD3bcIe5/WCyQOzRhAMEKEzzIr8OMkqjtWhE
         AbVKdD16docOC4RHzl+cj3epDzQfmEcceb08Izr8ByW/kH3sHjVegXJ2nUB2goL1LWX3
         f36FdB3UNGdGaDRu++5ObasowMbQJGBhcjPjt2uGZxsV3twcHxJ0C8PmB6/UjwVtQ+4q
         nTAvScMgLhjZOxnP+2cDXMMnOFhXny4hkYp2mLsiHsoEnbtp40Iq1nbGnpHiJFUrYwnA
         008A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764226400; x=1764831200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amIVj6Ks/T19JV0gGyF2jbDkQIb/QLUq7CyFhU9t8+g=;
        b=fV8Vgh9qESWUzR0IbtsZXf9w/97/px5ZpX0oGI943d4nPQiYqmPbbWQ/rdQhpBksDB
         bxP5a/QyS9Iqs9A6JRf+i/ijFembE89LywfuT4rCT+cuV+u94rGe9vXfWwO2QmpEMz19
         28IW4DALMdkSDWrC0VVw68qqheMEgeD2fcSwHIGitjVF2SfN6Md531A3N9lFvGLNntyw
         2h/5odVg92xuazGj0CsoG9DW0FEypKf3bRpB8vazwpcqR/yydXnb+bp0Bt3e4sEXZA++
         DSfPzBhVWa1++QNyN2Swr+BrIBIlHbhKDMzbz5N/zhuByN0g/5RkXOEfSfFIg84TTYt2
         37FA==
X-Forwarded-Encrypted: i=1; AJvYcCXA9wzHD1D1M/oTC6uEg7EevN492eWLO3QvFqKEbMQQrlv9uTB2IT82P1e7CxtrRjshnMmxylc4Ud4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4VMVRUhY/37SerXRcjDLw8rdktmeQFJVkfDffJDILDYGQj52P
	lc9qHhAyKDSjwcSfBxgkYnV8uAjS5AFLIF0/VZJ7LnNHjE1Zqv0zngzhMc1iOnhwlwzkZBC1ofo
	c4nwAHzQ4QV8tnx069eea0EIA9DA8zWY0FBi4KWcqwA==
X-Gm-Gg: ASbGncuR4M82xCRBAIKVgDgCqT8UEI7CaSSX0tlt2dHARyfNQkGeL40CJxEkutZ30bA
	wVY5ScwuPDT5ouGfJXXvXtaEJ0l3n1rNd+EzHeYAZboeLPq3iaNVl33LEwgU4thUYHu2xNCJWMO
	iZ8wgHXJblXn6+HH25/XZPF5d1rzSxaSJlTDGyAYx7ZF60WVekqDb6OfenQcjyTQ70+7/Lqkpbs
	9hdCj+xkWoQ3643dBEpXAHQG3JlfwmEjmneZ8VWU+LBv1rYCk6jB/8QlygHk2ePyk6MhTtmwGAH
	23+ACr6jb6EVpwYe1x+ivtlYnPwoLQgRArg=
X-Google-Smtp-Source: AGHT+IFLIn/EUIu7OxWHRGKTwIMu44EVUbsDDWFBWHXN/a3JCflama3pukcsqP1OVrFxH+zuhs1CaG1bDZ8ufGMAHn4=
X-Received: by 2002:a05:6402:51c7:b0:643:c8b:8d30 with SMTP id
 4fb4d7f45d1cf-645546a3a94mr21339934a12.30.1764226398995; Wed, 26 Nov 2025
 22:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f8170513-e08a-46ff-9fb2-310f3e9c1ba4@oss.nxp.com> <20251126220441.GA2853437@bhelgaas>
In-Reply-To: <20251126220441.GA2853437@bhelgaas>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 27 Nov 2025 07:53:07 +0100
X-Gm-Features: AWmQ_bn9e_5hK3VL0q5IanUqFHYeiwridGkV71hmaSPq62Kxvcuwrn80xW_IyF0
Message-ID: <CAKfTPtD3EsD6yPfnE2nbnyuSfFeOEGyLm5jTQaEZP6Ro85e4JQ@mail.gmail.com>
Subject: Re: [PATCH 4/4 v6] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>, chester62515@gmail.com, 
	mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, 
	bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, 
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

On Wed, 26 Nov 2025 at 23:04, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Nov 26, 2025 at 03:47:46PM -0600, Ciprian Marian Costea wrote:
> > On 11/26/2025 3:41 PM, Bjorn Helgaas wrote:
> > > [+cc Ciprian @oss.nxp.com, see email addr question below]
> > >
> > > On Fri, Nov 21, 2025 at 05:49:20PM +0100, Vincent Guittot wrote:
> > > > Add a new entry for S32G PCIe driver.
> > > >
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >   MAINTAINERS | 9 +++++++++
> > > >   1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index e64b94e6b5a9..bec5d5792a5f 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -3137,6 +3137,15 @@ F: arch/arm64/boot/dts/freescale/s32g*.dts*
> > > >   F:      drivers/pinctrl/nxp/
> > > >   F:      drivers/rtc/rtc-s32g.c
> > > > +ARM/NXP S32G PCIE CONTROLLER DRIVER
> > > > +M:       Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
> > >
> > > I'd be happy to change to
> > > Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> > > per https://lore.kernel.org/r/f38396c7-0605-4876-9ea6-0a179d6577c7@oss.nxp.com
> > >
> > > I notice that most nxp.com addresses in MAINTAINERS use "@nxp.com"
> > > addresses, not "@oss.nxp.com".
> > >
> > > Let me know your preference.
> > >
> > > Bjorn
> >
> > Hello Bjorn,
> >
> > I prefer "@oss.nxp.com".
>
> Done, thanks!

Thanks

>
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=c7533471578e

