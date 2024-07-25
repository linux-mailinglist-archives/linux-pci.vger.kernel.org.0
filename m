Return-Path: <linux-pci+bounces-10766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BFC93BD3C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 09:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86655B21318
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 07:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A633E16D9A3;
	Thu, 25 Jul 2024 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hqLki9ov"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C5D16F908
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721893241; cv=none; b=ayB3CR+sczBpybIkekYPVK1PU1KFb7g4ow2Dts2MbDmuBWIGvkez7bZnuIqqiQ+3/HW5EADDtBg0by9rkEOb7zyC/43aMAZhUIuaVSmXqODSmfwoSUF6nQ4I6iGECSP2//8v6lRAXx7Qrh8zyz/gXWOkKkGeEtgyj19njm8qdHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721893241; c=relaxed/simple;
	bh=uW0nDJWPRgUiqqErIzqEwn4nwCrm17Y7lCn1AxRs40M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnR4sXp6zsyKVGrpCTXE5AFEAPdZ//0rqp/qBUdKN92LmqQqW9oLlMj/0VTHyha7tjMKRXjAFvmMEUerAr7cBnFF0Q2+Td2rQdG/2QpYAPT2ZAC/rJaPgOfLfg5nxyxiziKUAIRc5fkMa8IjvGmRfAG4fQJ+FY0GCPeCNKjW4gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hqLki9ov; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d19c525b5so434527b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 00:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721893239; x=1722498039; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=reqU/HK+rBmf/ND7GZ96xuLWaeyl1ePjE+/4Jd13g2Y=;
        b=hqLki9ovb1FcOSR+td2dPMwciELp5dWSJuzm+1Wt+KasUrn3m/0MfvB3eQIRH8kOW7
         pxB9fl5+IqPiu+MO3syhCOgVF0m1o3Zzz+87MlUZluzgHiYQI5zPIhXFpvWZX++D09id
         0WpVbG1uRcpJt6JifgzFU/126R3vI8Nq4bfB6AO9OdHFa54Zns6egAHGb2yEVPpN+yoT
         Evi/pQ5miwFtQC5Muf0XPUDpcEwIiPBIlGttaXjYM7UfH32Ud8BHbDI5TY0q4Vk7zyxQ
         0ucOBcWtSXPR+w+JxGwbUn9ZHKH3oeBcrFSCaJSagEmaw9qVN7z6edMD1CSR8TsQX2K/
         9YBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721893239; x=1722498039;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reqU/HK+rBmf/ND7GZ96xuLWaeyl1ePjE+/4Jd13g2Y=;
        b=B0vXswMuQ4G/r/0GNU+NuBM8JdjCFZFZpaROJX12fOvQxw/DYFckbySGgK0VXL4ajj
         FFE0n0Dfq3OXWvGIQ+dgylN9wVQk5lMdLOhoJHhLHMxlFin2HGokXbtVk/F+V8alGSC0
         hajnRLMUstftZ1n2QaOfkF9kKlEHjYdHX3A5Ok7Gh3jgpioWoCHnr4lNHcb0rA9y8ika
         EbqP1rHuD5lYFGWTB5uwwK1xgI7+4Z8anMLF9U7FDJj9YvIyS6rSzZHwsOvmpYE/LieK
         ycTprdsx4X8r9u3EQYRrq9E5xi1vJuwgG+tOA0ALSc4Ek5S8HZZxX4pIe10jNxVKyqv7
         OU9w==
X-Forwarded-Encrypted: i=1; AJvYcCUqoiK3LrgjW08rE7y1P5/PYNNAh3Bjpy12N7iqjk+BQjViHBUPG3hEkW6fhfZdBkrsbOpeMYFrv81dabDZsyob/khglKCkK++k
X-Gm-Message-State: AOJu0YyNzTKqFLBSIfLjpcuPbe1pZHEsMYOvzoz7J3TzxKTOtacidqEc
	D2oUQZ2NbnpQKLGLGMUq/GwX6aHVx3XUsJqne0vrjj3FJjE6YHYxfUwei0jdag==
X-Google-Smtp-Source: AGHT+IHtiPlMyPT6k28NdzsaKIXkSRHui4+aED4yE+nGjF2qh6s5HOistxuF6S/ppRPYwwdLjMLLgA==
X-Received: by 2002:a05:6a00:22c2:b0:70b:20d9:3c2a with SMTP id d2e1a72fcca58-70eae97ce28mr1113486b3a.28.1721893239148;
        Thu, 25 Jul 2024 00:40:39 -0700 (PDT)
Received: from thinkpad ([2409:40f4:1015:1102:1950:b07b:3704:5364])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead81272esm628822b3a.97.2024.07.25.00.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 00:40:38 -0700 (PDT)
Date: Thu, 25 Jul 2024 13:10:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
Message-ID: <20240725074032.GA2770@thinkpad>
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
 <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
 <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
 <Zp/e2+NanHRNVfRJ@x1-carbon.lan>
 <20240725053348.GN2317@thinkpad>
 <b2dab6f8-8d95-4055-8960-d2dabb5cf98d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2dab6f8-8d95-4055-8960-d2dabb5cf98d@kernel.org>

On Thu, Jul 25, 2024 at 03:30:57PM +0900, Damien Le Moal wrote:
> On 7/25/24 14:33, Manivannan Sadhasivam wrote:
> > On Tue, Jul 23, 2024 at 06:48:27PM +0200, Niklas Cassel wrote:
> >> Hello Rick,
> >>
> >> On Tue, Jul 23, 2024 at 06:06:26PM +0200, Rick Wertenbroek wrote:
> >>>>
> >>>> But like you suggested in the other mail, the right thing is to merge
> >>>> alloc_space() and set_bar() anyway. (Basically instead of where EPF drivers
> >>>> currently call set_bar(), the should call alloc_and_set_bar() (or whatever)
> >>>> instead.)
> >>>>
> >>>
> >>> Yes, if we merge both, the code will need to be in the EPC code
> >>> (because of the set_bar), and then the pci_epf_alloc_space (if needed)
> >>> would be called internally in the EPC code and not in the endpoint
> >>> function code.
> >>>
> >>> The only downside, as I said in my other mail, is the very niche case
> >>> where the contents of a BAR should be moved and remain unchanged when
> >>> rebinding a given endpoint function from one controller to another.
> >>> But this is not expected in any endpoint function currently, and with
> >>> the new changes, the endpoint could simply copy the BAR contents to a
> >>> local buffer and then set the contents in the BAR of the new
> >>> controller.
> >>> Anyways, probably no one is moving live functions between controllers,
> >>> and if needed it still can be done, so no problem here...
> >>
> >> I think we need to wait for Mani's opinion, but I've never heard of anyone
> >> doing so, and I agree with your suggested feature to copy the BAR contents
> >> in case anyone actually changes the backing EPC controller to an EPF.
> >> (You would need to stop the EPC to unbind + bind anyway, IIRC.)
> >>
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
> 
> EPF node ? Did you perhaps mean EPC node ?

No, EPF node. We already have the EPC node that is the PCIe controller node.

> Using DT for endpoint functions is nonsense in my opinion: if something needs to
> be configured, an epf has the configfs interface to get the information it may
> need. And forcing EPF to have DT node is not scalable anyway.
> 

Why? We are not using to DT to configure anything. If you try to use DT for that
purpose then it would be wrong. DT is meant to provide hardware description. In
this case, the EPF DT node can be used to describe the BAR address that is
allocated (fixed) in the hardware. I did propose this in the previous Plumbers
conf [1]. As I said earlier, this information is coming from the EPC node right
now for MHI which has a hardware entity, but moving it to the dedicated EPF node
would be the correct approach for scalability.

And ofc, that DT node *cannot* be used for anything else (like describing
VID:PID in configfs etc...). As a nice side effect of the EPF node, we can get
rid of configfs to create the link between EPC and EPF and start the controller.
Again, this won't be applicable to non-hw backed EPF.

> So assuming you meant EPC, I am not sure if defining a fixed bar address in the
> DT works for all cases. E.g. said address may depend on other hardware on the
> platform (ex: memory nodes). So the ->get_bar() EPC operation that Rick is
> proposing makes a lot more sense to me and will can be scaled to many many
> configurations. Given that the EPF will (indirectly) call that operation, some
> epf dependent parameters could even be passed.
> 
> And I agree (I think we all do) that combing alloc bar and get bar under a
> single API is a lot cleaner. Though I am not a big fan of the name
> pci_epc_alloc_set_bar() as it implies an allocation, which may not be the case
> for fixed bars. So a simpler and more generic name like pci_epf_set_bar(),
> pci_epf_init_bar(), pci_epf_config_bar()... would be way better in my opinion.
> 

Well, the EPF driver doesn't need to know if the underlying address if fixed or
dynamic IMO. It should just request BAR memory and the EPC core/controller
drivers should take care of that.

- Mani

[1] https://lpc.events/event/17/contributions/1419/attachments/1276/2636/LPC2023-PCI%20Endpoint%20Subsystem%20Open%20Items%20Discussion.pdf

-- 
மணிவண்ணன் சதாசிவம்

