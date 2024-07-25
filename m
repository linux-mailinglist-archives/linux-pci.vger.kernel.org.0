Return-Path: <linux-pci+bounces-10762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD4393BC0D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 07:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1708D28437D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 05:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D9D23D0;
	Thu, 25 Jul 2024 05:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YEAVhneD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F25B1C6A3
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 05:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721885635; cv=none; b=SjSdXzpRk36uZgTvms1Dq8ICXPR1vdn6D512Ezo8FrUFVAlIdw0OVXUS7BMN8/Q7RJMx1WrxnOAsFzJvk9nztxVC2BxvWufipUZBXjOnvFw9/HAT+aGT1mNj1qrxoKzDOfNIxZNXgJ8vL+X57KapcSFFW6yZKVw/T8FXJvVZ5OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721885635; c=relaxed/simple;
	bh=2tGfEYHwzW/wGfMKg0R45p2xryVYT+n7SGr2VPkgruw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7ZNwILUZd98gJhBHOq0CdaoPCNaRjlp1/GFf+nqUEq0crFLx5Skg5wWMkTrVLoaQoCKgUXa4pvbPf9kQ5fxBpju+ccBgUsj4cr3C6kIgdcnDkvtpxVo4dOcqBewh0Np/5kvgYGE26ByMfttsVwGCPNrnZjOF6Xhh3EzjhmB9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YEAVhneD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc566ac769so3921425ad.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 22:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721885633; x=1722490433; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WvP5xv6a5VWVYL+E3TZ2I1foLVXzeCPYT1zO1NeZJnc=;
        b=YEAVhneDK1ImT5x4ovFQlcTHpQZxZGz0hDAYSbXkTrPuHQSftcYsRehne9NAKa5sgi
         weuH3IouNNlV35CRTmW9WzRJyt11Lbb6MgeEYrf2S0/E+NgP4xhv2j0/Xw+c6MtkIS2O
         40PvKICQfwD0Q0015MfFbRU67C4gO2fqWLelLJug2bq9/cyBzOdkGkfMMiyv4Zh9Xc2q
         cIKtP26uEEQ/xQJLMHGufbEaxeDkBLh+h9CgWNS6Tom+C02TyNUg93WjtinoIFEYjY1A
         q/GdQ+fY6Y81RAYUKoLV6iwoYhLD/Ld7h/J0X3DFFtodYcsDwEBUDZjhbIWPtxKsFb/g
         FIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721885633; x=1722490433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvP5xv6a5VWVYL+E3TZ2I1foLVXzeCPYT1zO1NeZJnc=;
        b=SpVhrJjC5d6at87nf9d8t6IK1n9LIZk/mw/7OBcfSMJrYiwSoZukDMuN65Or1n3L31
         kt5ar/gr5JrJFDfXZdipOg2JLNaTlF8pFZOMvLT1JYBb44jo6aueQrIkCfZ78evQxTpv
         NfIAYuIi6avRAvqHvATyCcaAtpY/9zh78HkB5xNKA6tCZWEgXURvD85rZpugR0knpHJz
         iTfoQFeYWF281R+JfVqzuh1LkNNFqZ1wp7lMDwa/ye7i/6WFueK2gYGYffGsmhh30JqW
         aemZiegchW3QVjBVBoyld1Z+8Ki7OyDo9hCVxSthwuUqXPGdrZdQrlzTmoXfXtH7Xu8L
         BWpA==
X-Forwarded-Encrypted: i=1; AJvYcCWkA2VIeyxslhxZ+s9RBdxA5/bXddA2VGHwQugwoe+wTS7uSg/IKzY9wqUCPRMLSjVRL0YpnAvbSOn+3yISBVv1tWquyPLYFQK5
X-Gm-Message-State: AOJu0Yzd9br69hz3KHPeM8b0ECdYok5KKnKR4YmXu9Gj54ouACXiWn2v
	skLYaXd5R7LIhJ3IZy3SHqyXZ8fKrUPX8ru4yvy0cD+sTvdgEAzQw0AEn7UNbw==
X-Google-Smtp-Source: AGHT+IG+Jz8QIIFB7Xv4Jj0Zdf+JcdD4DBAsUgPPRHwYyUzYcZicmU3kuQE8eB0QN6KEdH4/zv41pA==
X-Received: by 2002:a17:902:f68f:b0:1fd:a7a7:20b7 with SMTP id d9443c01a7336-1fed389fd3dmr24712335ad.30.1721885633089;
        Wed, 24 Jul 2024 22:33:53 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f6dc27sm4984275ad.237.2024.07.24.22.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 22:33:52 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:03:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
Message-ID: <20240725053348.GN2317@thinkpad>
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
 <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
 <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
 <Zp/e2+NanHRNVfRJ@x1-carbon.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zp/e2+NanHRNVfRJ@x1-carbon.lan>

On Tue, Jul 23, 2024 at 06:48:27PM +0200, Niklas Cassel wrote:
> Hello Rick,
> 
> On Tue, Jul 23, 2024 at 06:06:26PM +0200, Rick Wertenbroek wrote:
> > >
> > > But like you suggested in the other mail, the right thing is to merge
> > > alloc_space() and set_bar() anyway. (Basically instead of where EPF drivers
> > > currently call set_bar(), the should call alloc_and_set_bar() (or whatever)
> > > instead.)
> > >
> > 
> > Yes, if we merge both, the code will need to be in the EPC code
> > (because of the set_bar), and then the pci_epf_alloc_space (if needed)
> > would be called internally in the EPC code and not in the endpoint
> > function code.
> > 
> > The only downside, as I said in my other mail, is the very niche case
> > where the contents of a BAR should be moved and remain unchanged when
> > rebinding a given endpoint function from one controller to another.
> > But this is not expected in any endpoint function currently, and with
> > the new changes, the endpoint could simply copy the BAR contents to a
> > local buffer and then set the contents in the BAR of the new
> > controller.
> > Anyways, probably no one is moving live functions between controllers,
> > and if needed it still can be done, so no problem here...
> 
> I think we need to wait for Mani's opinion, but I've never heard of anyone
> doing so, and I agree with your suggested feature to copy the BAR contents
> in case anyone actually changes the backing EPC controller to an EPF.
> (You would need to stop the EPC to unbind + bind anyway, IIRC.)
> 

Hi Rick/Niklas,

TBH, I don't think currently we have an usecase for remapping the EPC to EPF. So
we do not need to worry until the actual requirement comes.

But I really like combining alloc() and set_bar() APIs. Something I wanted to do
for so long but never got around to it. We can use the API name something like
pci_epc_alloc_set_bar(). I don't like 'set' in the name, but I guess we need to
have it to align with existing APIs.

And regarding the implementation, the use of fixed address for BAR is not new.
If you look into the pci-epf-mhi.c driver, you can see that I use a fixed BAR0
location that is derived from the controller DT node (MMIO region).

But I was thinking of moving this region to EPF node once we add DT support for
EPF driver. Because, there can be many EPFs in a single endpoint and each can
have upto 6 BARs. We cannot really describe each resource in the controller DT
node.

Given that you really have a usecase now for multiple BARs, I think it is best
if we can add DT support for the EPF drivers and describe the BAR resources in
each EPF node. With that, we can hide all the resource allocation within the EPC
core without exposing any flag to the EPF drivers.

So if the EPF node has a fixed location for BAR and defined in DT, then the new
API pci_epf_alloc_set_bar() API will use that address and configure it
accordingly. If not, it will just call pci_epf_alloc_space() internally to
allocate the memory from coherent region and use it.

Wdyt?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

