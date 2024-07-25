Return-Path: <linux-pci+bounces-10790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDB493C3B8
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 16:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42491F22966
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 14:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C4D19CD0F;
	Thu, 25 Jul 2024 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZW0kiTc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B46F19CD0E
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916443; cv=none; b=Y0Ig9kZucj4LlQEMkvcHR45AaWcyXccV4gz4LWSzw/hnVwTjio0A8Km9MmNtbDfJE4pmjDzI74lh3FnDWW5xkeIRbx3JEX73nhawj0I8DQLXM2SWdTtBjqJclGHyE+31FvFIO+9qLbxPl330/vMOGLXyl3aREOcid0+HcWHH9us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916443; c=relaxed/simple;
	bh=pksET2uKbCnujR75iT+0cBqjz1m524Ir2g+SdXltX4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ph2/RP0oCj6Bllo1n+IUu/+5gT20L+Huvzq3ZPsJGr2U/ak30A93+XN1cTRajvPk72jGuuqZQpDoeLKtf6aMTRj/Vn4nvF3dyxAgMmJNXwEStj+1u0odh0YMt8VqUUjPx9po6RrNFAFWMoKocVcwnUL4ZtwtvdVmVhq+MN0+ueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QZW0kiTc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d2b27c115so751444b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 07:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721916441; x=1722521241; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a3AyL0HlCFj8TAMHagfyvA5AIVg3hc44mddnltY1Iss=;
        b=QZW0kiTc9n4grvZ2D0RgCSNPvpgUCUSpWZFbhgIqlWi9NsO7/N8Nu5dDkTJsit7u/T
         TC624i8LTi42QvlShYVs2MXxLy4L39MiEL8dFyNd3T7ZLCY9b7/w8epSc0jUw9X7l3m3
         DBZSczBgugtBWyg8kQG7bn/Z/sl9kQ5iU6/8keqZLYGrcqfz1lNOyl7XBu/uM3kp9OKM
         1jO9e+Z3x0JuCckwOJiANW7foH4xx4AT6PVdAHoE86y3ZFaOHRMSiVW4KF5uK5LgP7wb
         ATHL6X+oazBvhz2zdIGg/vEYMRdY3l2EC9iVLRNjUVkLr8HB66p/5EcAxyLyLyODuSPY
         9zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721916441; x=1722521241;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3AyL0HlCFj8TAMHagfyvA5AIVg3hc44mddnltY1Iss=;
        b=H9DdI8Pfx27fczVmcQ/5Q4dpjbq9JC8Kw/f9m4ZE1R6nxV2Clc9BaMMPdIil+aHvq9
         n8lQQ77eb1NrXEULnkdL9B0Tg2i6q6eIFsWVU/CSKTnbSwpbd3Jpujk7Sx+A27BzF6Zj
         eTMmwAETJolvX3ZSruMDyR2JH4GwEp42SklGKtmeskf87IpbKW7788QIZxhFt+UwWAgk
         ps81iwSNvDjODWjs7wKhlj0R3L9ekJUALclEAv8cOJBwhlUk/ZhQ9alheO7IOp2e2b33
         GpEO07+CJq0sd+DpOO3h+DuwGYya877BWaNoGXXswY9s1WZ0wwEztmlZ6lGGDBt/wf6A
         oeAA==
X-Forwarded-Encrypted: i=1; AJvYcCWb/+ly0MSFMo7MlBUfL5V5KqdpdNc5SsIkOi9cjyvfG2nj+DiwOaN1GSqIbZlDP06jxOomF/kmEJ6zzVkaqw/yf9e2zdsBpLjt
X-Gm-Message-State: AOJu0Yw8atkxsU3g7o1xRfFqol4IOf60cm6hhjcdHV7dQMKp9OMsDhsK
	m1jmZX8vJ0qDTyQTpsroBOmIqq717ZPeOr5JLiMSwm8l6LADi8dlEdHfOC8EwQ==
X-Google-Smtp-Source: AGHT+IGTByaLYvqaz+8FOAit23AMhCHovH60IZ7pQuKJeMbNd+SUp0ANSh1klXcJl1BPmRODoET20g==
X-Received: by 2002:a05:6a00:919f:b0:70d:2693:d215 with SMTP id d2e1a72fcca58-70eae906ad6mr2105027b3a.16.1721916440774;
        Thu, 25 Jul 2024 07:07:20 -0700 (PDT)
Received: from thinkpad ([220.158.156.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e15e2sm1168645b3a.3.2024.07.25.07.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 07:07:20 -0700 (PDT)
Date: Thu, 25 Jul 2024 19:37:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>, rick.wertenbroek@heig-vd.ch,
	alberto.dassatti@heig-vd.ch,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
Message-ID: <20240725140702.GB2274@thinkpad>
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
 <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
 <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
 <Zp/e2+NanHRNVfRJ@x1-carbon.lan>
 <20240725053348.GN2317@thinkpad>
 <CAAEEuhpH-HB-tLinkLcCmiJ-9fmrGVjJFTjj7Nxk5M8M3XxSPA@mail.gmail.com>
 <04b1ceb2-538e-4b1b-be5c-5a81d7a457ad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04b1ceb2-538e-4b1b-be5c-5a81d7a457ad@kernel.org>

On Thu, Jul 25, 2024 at 05:20:00PM +0900, Damien Le Moal wrote:
> On 7/25/24 17:06, Rick Wertenbroek wrote:
> > On Thu, Jul 25, 2024 at 7:33 AM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> >>
> >> On Tue, Jul 23, 2024 at 06:48:27PM +0200, Niklas Cassel wrote:
> >>> Hello Rick,
> >>>
> >>> On Tue, Jul 23, 2024 at 06:06:26PM +0200, Rick Wertenbroek wrote:
> >>>>>
> >>>>> But like you suggested in the other mail, the right thing is to merge
> >>>>> alloc_space() and set_bar() anyway. (Basically instead of where EPF drivers
> >>>>> currently call set_bar(), the should call alloc_and_set_bar() (or whatever)
> >>>>> instead.)
> >>>>>
> >>>>
> >>>> Yes, if we merge both, the code will need to be in the EPC code
> >>>> (because of the set_bar), and then the pci_epf_alloc_space (if needed)
> >>>> would be called internally in the EPC code and not in the endpoint
> >>>> function code.
> >>>>
> >>>> The only downside, as I said in my other mail, is the very niche case
> >>>> where the contents of a BAR should be moved and remain unchanged when
> >>>> rebinding a given endpoint function from one controller to another.
> >>>> But this is not expected in any endpoint function currently, and with
> >>>> the new changes, the endpoint could simply copy the BAR contents to a
> >>>> local buffer and then set the contents in the BAR of the new
> >>>> controller.
> >>>> Anyways, probably no one is moving live functions between controllers,
> >>>> and if needed it still can be done, so no problem here...
> >>>
> >>> I think we need to wait for Mani's opinion, but I've never heard of anyone
> >>> doing so, and I agree with your suggested feature to copy the BAR contents
> >>> in case anyone actually changes the backing EPC controller to an EPF.
> >>> (You would need to stop the EPC to unbind + bind anyway, IIRC.)
> >>>
> >>
> >> Hi Rick/Niklas,
> >>
> >> TBH, I don't think currently we have an usecase for remapping the EPC to EPF. So
> >> we do not need to worry until the actual requirement comes.
> >>
> >> But I really like combining alloc() and set_bar() APIs. Something I wanted to do
> >> for so long but never got around to it. We can use the API name something like
> >> pci_epc_alloc_set_bar(). I don't like 'set' in the name, but I guess we need to
> >> have it to align with existing APIs.
> >>
> >> And regarding the implementation, the use of fixed address for BAR is not new.
> >> If you look into the pci-epf-mhi.c driver, you can see that I use a fixed BAR0
> >> location that is derived from the controller DT node (MMIO region).
> >>
> >> But I was thinking of moving this region to EPF node once we add DT support for
> >> EPF driver. Because, there can be many EPFs in a single endpoint and each can
> >> have upto 6 BARs. We cannot really describe each resource in the controller DT
> >> node.
> >>
> >> Given that you really have a usecase now for multiple BARs, I think it is best
> >> if we can add DT support for the EPF drivers and describe the BAR resources in
> >> each EPF node. With that, we can hide all the resource allocation within the EPC
> >> core without exposing any flag to the EPF drivers.
> >>
> >> So if the EPF node has a fixed location for BAR and defined in DT, then the new
> >> API pci_epf_alloc_set_bar() API will use that address and configure it
> >> accordingly. If not, it will just call pci_epf_alloc_space() internally to
> >> allocate the memory from coherent region and use it.
> >>
> >> Wdyt?
> >>
> >> - Mani
> >>
> >> --
> >> மணிவண்ணன் சதாசிவம்
> > 
> > Hello Mani, thank you for your feedback.
> > 
> > I don't know if the EPF node in the DT is the right place for the
> > following reasons. First, it describes the requirements of the EPF and
> > not the restrictions imposed by the EPC (so for example one function
> > requires the BAR to use a given physical address and this is described
> > in the DT EPF node, but the controller could use any address, it just
> > configures the controller to use the address the EPF wants, but in the
> > other case (e.g., on FPGA), the EPC can only handle a BAR at a given
> > physical address and no other address so this should be in the EPC
> > node). Second, it is very static, so the EPC relation EPF would be
> > bound in the DT, I prefer being able to bind-unbind from configfs so
> > that I can make changes without reboot (e.g., alternate between two or
> > more endpoint functions, which may have different BAR requirements and
> > configurations).
> > 
> > For the EPFs I really think it is good to keep the BAR requirements in
> > the code for the moment, this makes it easier to swap endpoint
> > functions and makes development easier as well (e.g., binding several
> > different EPFs without reboot of the SoC they run on. In my typical
> > tests I bind one function, turn-on the host, do tests, turn-off the
> > host, make changes to an EPF, scp the new .ko on the SoC, rebind,
> > turn-on the host, etc.). For example, I alternate between pci-epf-test
> > (6 bars) and pci-epf-nvme (1 bar) of different sizes.
> > 
> > However, I can see a world where both binding and configuring EPF from
> > DT and the way it is currently done (alloc/set bar in code) and bind
> > in configfs could exist together as each have their use cases. But
> > forcing the use of DT seems impractical.
> 
> I do not think using DT for configuring an EPF *ever* make sense. An init script
> on the EP platform can take care of whatever needs to be configured. DT is for
> and should be restricted to describing the HW, not things that can be configured
> at runtime using the HW information.
> 

No, MHI is a hardware entity. So atleast defining it in DT make sense. But as I
mentioned in reply to Rick, I haven't implemented it since it is really not
required now (MHI just needs a single BAR and right now the address is derived
from EPC node).

But for Rick's usecase, I agree with you/Rick that DT doesn't make sense. Thanks
for clearing it up.

> Doing it this way also makes the EPF code independent on the platform. E.g. if
> we ever add an EPF node in the DT, that same EPF would not work on an endpoint
> capable platform using UEFI. That is not acceptable for HW generic EPFs (e.g.
> nvme, virtio, etc).
> 

Well, those anyway cannot be defined in DT as they are software implementations
around hw.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

