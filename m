Return-Path: <linux-pci+bounces-10789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 959CD93C36A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 15:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E99B24048
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 13:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E16E19D077;
	Thu, 25 Jul 2024 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OSJeIfpY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC1219CD17
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915620; cv=none; b=sqeCen+CNe8sGMjrrNkQwXmtnYrKvifhy8cUuggpawrKdBD9m4es5VDqjNMMIPHc6d5mo36PglPzLr0qDPX7cTBezIMDWCluFkmzoBQP+KM6dyEUPBpy3eFyBoq1yX7c02H2fGLVChT0leZlkXcNF4sP0Ivea48acs1KAjbUKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915620; c=relaxed/simple;
	bh=waRrTO9DD5VynHOhWYHnhVJETQeekyhSd4eh2jilD3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aySZOTLuivWj9guf7lXspmDrFDH5A8bU1VSYPlNLr47s3R+QiG4gr6ETkBuzv1EdYHdjeYSCZscLDT2Ho/vh1kbcFmsVL+xhKPWzivNduzq/H46l2NEragbtwPBJEBVLRF74iIjMlkWToEcQ5KzI+Ku09NwPcZoBr3YxkB2P6qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OSJeIfpY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d1dadd5e9so828882b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721915618; x=1722520418; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HJB4XlzxFwVGN++iQ5ATIQ5vXnSodXfQe5qe9NiYd+U=;
        b=OSJeIfpYq5mh34uskAccyG451ot8TpKEnYr1JFnL1I2vJji7kRj0oGsq2YIoJ1p9Ta
         0J1730AkBcvMMn4dpLIcWQbBBkhvxs8PZTjVQIAQ4Lf8JN3nizbcjNev6HsoYjotJSRN
         N7eQrhSNa/j11QwHl7fu3NH855QfZeJqRerk2KGdWwPlyR8FPMwgcarLa/RSterXJc1h
         rwcDx5gyfByOSRF6PFaBgVOYLH0dspBFctOWTU32a8vhWsNaGH/uSTWgstUvqVSSFECI
         2T3OG0uv+WYwtMpuA7HXvjhRX/6Oe7Ja1BMA/dM2qhB79LP1ubDG/GWoiHac71jzF2yy
         Cr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721915618; x=1722520418;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJB4XlzxFwVGN++iQ5ATIQ5vXnSodXfQe5qe9NiYd+U=;
        b=Wi0ySojN5RiDbSbycVUPtaJHQRXStDFrlRDXMly/vTADo5XbIbkvOorkI9V9CxpV6X
         dOx+lIbDme3VMT5sRs3Psfqg9S3SzaBEUrGXNoBGp074v+a2CaxC8qavTuOEuAON3+JN
         bOeCx4VAz0ZRmrxRg3+nb917j7zDCc1kXHUBBTFCbvADwcY5bKl7MhfF54unNUVUhxJa
         T0z/fJPM/3ZYVqzEN2wcAwf9jR0zNm9s+9PQVmIvUjKTLp3LVBMrrQ7K7GWrBR/mPsrw
         jFqb/ZycbHKgIEOqqAMZk70LBYvwj4PKI98uBawFJG7+reeXrC/CWRQcHo722SJv/MLm
         h/rg==
X-Forwarded-Encrypted: i=1; AJvYcCXUhmYGbEAM/LphFB7gmeUKTa4ES+b0zzDN5SjP/AQnUqYXmqcsNIKgqvU1Egbq/teGthenyv1XZlE/NI9GQP4Bf3Ju5xvrTi5d
X-Gm-Message-State: AOJu0YxBASEqOlPkMu8u+ud/IkqvN9X8BrWxVgBZ/0pMGjDADkstaSbZ
	w/YZT1VmelSOIPRiLVes4YcyTuKRX7B2ihbgYnNRsgvuCc/2xk+vnUJFIrM0Wg==
X-Google-Smtp-Source: AGHT+IGtTpfD1RaA66Gx/ID0GTSPmTevYRrqHXez+GzWbZyFtmEmJNzXQjSnQS609+P1TF8R+3MgWg==
X-Received: by 2002:a05:6a00:10d3:b0:70e:92e1:1366 with SMTP id d2e1a72fcca58-70eae8f1565mr2160101b3a.16.1721915617789;
        Thu, 25 Jul 2024 06:53:37 -0700 (PDT)
Received: from thinkpad ([220.158.156.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ab97sm1174992b3a.92.2024.07.25.06.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 06:53:37 -0700 (PDT)
Date: Thu, 25 Jul 2024 19:23:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>, rick.wertenbroek@heig-vd.ch,
	alberto.dassatti@heig-vd.ch,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
Message-ID: <20240725135332.GA2274@thinkpad>
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
 <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
 <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
 <Zp/e2+NanHRNVfRJ@x1-carbon.lan>
 <20240725053348.GN2317@thinkpad>
 <CAAEEuhpH-HB-tLinkLcCmiJ-9fmrGVjJFTjj7Nxk5M8M3XxSPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAEEuhpH-HB-tLinkLcCmiJ-9fmrGVjJFTjj7Nxk5M8M3XxSPA@mail.gmail.com>

On Thu, Jul 25, 2024 at 10:06:38AM +0200, Rick Wertenbroek wrote:
> On Thu, Jul 25, 2024 at 7:33 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Jul 23, 2024 at 06:48:27PM +0200, Niklas Cassel wrote:
> > > Hello Rick,
> > >
> > > On Tue, Jul 23, 2024 at 06:06:26PM +0200, Rick Wertenbroek wrote:
> > > > >
> > > > > But like you suggested in the other mail, the right thing is to merge
> > > > > alloc_space() and set_bar() anyway. (Basically instead of where EPF drivers
> > > > > currently call set_bar(), the should call alloc_and_set_bar() (or whatever)
> > > > > instead.)
> > > > >
> > > >
> > > > Yes, if we merge both, the code will need to be in the EPC code
> > > > (because of the set_bar), and then the pci_epf_alloc_space (if needed)
> > > > would be called internally in the EPC code and not in the endpoint
> > > > function code.
> > > >
> > > > The only downside, as I said in my other mail, is the very niche case
> > > > where the contents of a BAR should be moved and remain unchanged when
> > > > rebinding a given endpoint function from one controller to another.
> > > > But this is not expected in any endpoint function currently, and with
> > > > the new changes, the endpoint could simply copy the BAR contents to a
> > > > local buffer and then set the contents in the BAR of the new
> > > > controller.
> > > > Anyways, probably no one is moving live functions between controllers,
> > > > and if needed it still can be done, so no problem here...
> > >
> > > I think we need to wait for Mani's opinion, but I've never heard of anyone
> > > doing so, and I agree with your suggested feature to copy the BAR contents
> > > in case anyone actually changes the backing EPC controller to an EPF.
> > > (You would need to stop the EPC to unbind + bind anyway, IIRC.)
> > >
> >
> > Hi Rick/Niklas,
> >
> > TBH, I don't think currently we have an usecase for remapping the EPC to EPF. So
> > we do not need to worry until the actual requirement comes.
> >
> > But I really like combining alloc() and set_bar() APIs. Something I wanted to do
> > for so long but never got around to it. We can use the API name something like
> > pci_epc_alloc_set_bar(). I don't like 'set' in the name, but I guess we need to
> > have it to align with existing APIs.
> >
> > And regarding the implementation, the use of fixed address for BAR is not new.
> > If you look into the pci-epf-mhi.c driver, you can see that I use a fixed BAR0
> > location that is derived from the controller DT node (MMIO region).
> >
> > But I was thinking of moving this region to EPF node once we add DT support for
> > EPF driver. Because, there can be many EPFs in a single endpoint and each can
> > have upto 6 BARs. We cannot really describe each resource in the controller DT
> > node.
> >
> > Given that you really have a usecase now for multiple BARs, I think it is best
> > if we can add DT support for the EPF drivers and describe the BAR resources in
> > each EPF node. With that, we can hide all the resource allocation within the EPC
> > core without exposing any flag to the EPF drivers.
> >
> > So if the EPF node has a fixed location for BAR and defined in DT, then the new
> > API pci_epf_alloc_set_bar() API will use that address and configure it
> > accordingly. If not, it will just call pci_epf_alloc_space() internally to
> > allocate the memory from coherent region and use it.
> >
> > Wdyt?
> >
> > - Mani
> >
> > --
> > மணிவண்ணன் சதாசிவம்
> 
> Hello Mani, thank you for your feedback.
> 
> I don't know if the EPF node in the DT is the right place for the
> following reasons. First, it describes the requirements of the EPF and
> not the restrictions imposed by the EPC (so for example one function
> requires the BAR to use a given physical address and this is described
> in the DT EPF node, but the controller could use any address, it just
> configures the controller to use the address the EPF wants, but in the
> other case (e.g., on FPGA), the EPC can only handle a BAR at a given
> physical address and no other address so this should be in the EPC
> node). Second, it is very static, so the EPC relation EPF would be
> bound in the DT, I prefer being able to bind-unbind from configfs so
> that I can make changes without reboot (e.g., alternate between two or
> more endpoint functions, which may have different BAR requirements and
> configurations).
> 
> For the EPFs I really think it is good to keep the BAR requirements in
> the code for the moment, this makes it easier to swap endpoint
> functions and makes development easier as well (e.g., binding several
> different EPFs without reboot of the SoC they run on. In my typical
> tests I bind one function, turn-on the host, do tests, turn-off the
> host, make changes to an EPF, scp the new .ko on the SoC, rebind,
> turn-on the host, etc.). For example, I alternate between pci-epf-test
> (6 bars) and pci-epf-nvme (1 bar) of different sizes.
> 

Ok, clearly the usecase I have for MHI is not the same as yours. MHI is a
hardware entity and it has the registers at a fixed address. So defining it
in the DT node made sense to me. But I haven't followed up with my proposal
since I thought it is not worth the effort until I see more usecases for DT.
That's why I was interested for a moment as I thought I got one :)

Anyway, thanks for clearing it up. I now agree that we don't need DT node for
your usecase.

> However, I can see a world where both binding and configuring EPF from
> DT and the way it is currently done (alloc/set bar in code) and bind
> in configfs could exist together as each have their use cases. But
> forcing the use of DT seems impractical.
> 
> For combining pci_epf_alloc_space and pci_epc_set_bar into a single
> function, everyone seems to agree on this one.
> 

Yes.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

