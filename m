Return-Path: <linux-pci+bounces-11869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAD795820C
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 11:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E32B240C3
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C891318C000;
	Tue, 20 Aug 2024 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBFFp52l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A6318B493
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2024 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145856; cv=none; b=egDLO1IVBsab4D1tfKBSF81pUhWeYoJcMDUBGEEMajfuLJYPt5JDxmFDfx91neH3gRm0q5ytUJYU1OrM/HBOLqFwktUZJNrJlms4R5+bVOxLBsrH46riYxWBqUYrL0M2ZtWASIUQUn98xuelFf9vcZL8xZZPTNDhqH7ggm8zMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145856; c=relaxed/simple;
	bh=3BYyusPDgoFfSQEtg04SVUKbUSu2M8fQcJrEAygKbHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGTssdX+sNHfQb4GPbsFYLjQhaDEwjpus66lUPJqG3qqCDCkRywePSl60LEhYR6uH26LOu750UcdwQ9kjb+71ZYwwgtyF5qbNZGMHeHDDwAefeCRz+zyW7w6TdYGAQTLVRh/Gl6hqkpFZnWsHT/exYl3Hw0YHKjBkrO1d/tS1PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dBFFp52l; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-713dc00cf67so2620749b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2024 02:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724145854; x=1724750654; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MPOcC1lW7loqVOPhtqIT0kpIc2SFofY/nFqcF9Tz/Ic=;
        b=dBFFp52lHjFVZNkp3NNX0GCbcnphpbfhiRfTZ924oCyWLXkj+VEbHrAz+noscdaeEy
         kH0o7tFon6MFIV1f3W4IjKQ8eXEGjNV1E8EpFUOV7hshhNisdkFICCJkU0FCvLpeU3kA
         ytxO2PblgsCB4EA+iRCvT5LJzjD65NmkoyGH8iV8k+m2xEa+yQaUdtl38fiDTfV95wCa
         053nYyK15aIuAYw8K0xduyEBstWYU5gtgZpt31SSe77YWoThSHVwR+TpsO60Q9q0JNa/
         4y3h+I6gLFbJHTuQKTH1aFwQQRtGuDqzjWEsoJWK32og56WlT+/pYolgkvXE2pY0qDMj
         baNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724145854; x=1724750654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPOcC1lW7loqVOPhtqIT0kpIc2SFofY/nFqcF9Tz/Ic=;
        b=eOyHjDTUxEYujWXcEDZGZQpp6u/7GfIVQHV8ZYuQkPS9D1WyHF6FU6TH5i/xc/tSGQ
         x48K3cF9oh74PZSXAtXafDbRPg81XuNJaMc7X+/eKsG6YY2nFjyOy4Nkq5VdAMcTrlGf
         rMdQstWyWOdzLJOohjBDhZMKlIEB83P+FeApH59EDGu9F3ff+dw+2LpocGUexOHsz4Ga
         RX5hvhwBaoWkugSKBq58PuV1NkGECEU7Ndy2BHN0APW/HxfPFs8n91kvEZqflQeRQLG6
         Nh+2+zJ/PYFhjS9HiuJ+dDTDdRpCP7nJlle+ki9w6/I5H4umQ5RUpDauA5VkLJoHGp+2
         q2Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUfQQ8owP1GMeWuzNqIUwGktrcu5oZUYfI/l9k6NPWGHeoeAnQnxoQOKYm+55k6QYU9WuA/yXqKlVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjZYi+7NLYncJ+uiS+sT8O+RjNktI1OoOsXk0+e0YhXNN8Hwll
	a3rVW1HZjHLDxC0o6gWgUYD+a4KxoJI0EpEj4/fcRKHvKsxKIuIlYD7lh0miEw==
X-Google-Smtp-Source: AGHT+IFpVDZP72BhMHlHtYBPJ0ZhbeTQpOyKrXPpzfAnOhUFxzMS6JGnfTyJ+QURUXwd2WtKhUKS6g==
X-Received: by 2002:a05:6a20:d70b:b0:1c4:d4b2:ffe5 with SMTP id adf61e73a8af0-1c90507af96mr16175546637.54.1724145854425;
        Tue, 20 Aug 2024 02:24:14 -0700 (PDT)
Received: from thinkpad ([120.60.128.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20232a7f60fsm35534055ad.242.2024.08.20.02.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:24:14 -0700 (PDT)
Date: Tue, 20 Aug 2024 14:53:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, rick.wertenbroek@heig-vd.ch,
	alberto.dassatti@heig-vd.ch,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: endpoint: pci-epf-test: Call
 pci_epf_test_raise_irq() on failed DMA check
Message-ID: <20240820092359.tfvmjadm6tfxyqvm@thinkpad>
References: <20240820071100.211622-1-rick.wertenbroek@gmail.com>
 <20240820071100.211622-2-rick.wertenbroek@gmail.com>
 <54451b81-b503-4072-807a-af2f0b914ec2@kernel.org>
 <CAAEEuhpt_WnxOZeYsMxjwTGZm-FJKoj3at-qPgyAH6D76P9wOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAEEuhpt_WnxOZeYsMxjwTGZm-FJKoj3at-qPgyAH6D76P9wOA@mail.gmail.com>

On Tue, Aug 20, 2024 at 10:43:56AM +0200, Rick Wertenbroek wrote:
> On Tue, Aug 20, 2024 at 10:18 AM Damien Le Moal <dlemoal@kernel.org> wrote:
> >
> > On 8/20/24 16:10, Rick Wertenbroek wrote:
> > > The pci-epf-test PCI endpoint function /drivers/pci/endpoint/function/pci-epf_test.c
> > > is meant to be used in a PCI endpoint device connected to a host computer
> > > with the host side driver: /drivers/misc/pci_endpoint_test.c.
> > >
> > > The host side driver can request read/write/copy transactions from the
> > > endpoint function and expects an IRQ from the endpoint function once
> > > the read/write/copy transaction is finished. These can be issued with or
> > > without DMA enabled. If the host side driver requests a read/write/copy
> > > transaction with DMA enabled and the endpoint function does not support
> > > DMA, the endpoint would only print an error message and wait for further
> > > commands without sending an IRQ because pci_epf_test_raise_irq() is
> > > skipped in pci_epf_test_cmd_handler(). This results in the host side
> > > driver hanging indefinitely waiting for the IRQ.
> > >
> > > Call pci_epf_test_raise_irq() when a transfer with DMA is requested but
> > > DMA is unsupported. The host side driver will no longer hang but report
> > > an error on transfer (printing "NOT OKAY") thanks to the checksum because
> > > no data was moved.
> > >
> > > Clarify the error message in the endpoint function as "Cannot ..." is
> > > vague and does not state the reason why it cannot be done.
> > >
> > > Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > index 7c2ed6eae53a..b02193cef06e 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > @@ -649,7 +649,8 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
> > >
> > >       if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
> > >           !epf_test->dma_supported) {
> > > -             dev_err(dev, "Cannot transfer data using DMA\n");
> > > +             dev_err(dev, "DMA transfer not supported\n");
> >
> > Should we set the FAIL status flag here ?
> > E.g.:
> >                  reg->status |= STATUS_READ_FAIL;
> >
> > Note: I have no idea why the status flags are different for the different
> > operations. We should really have a single SUCCESS/FAIL flag common to all
> > operations. So I think we could just do:
> >
> >                 reg->status |= STATUS_READ_FAIL | STATUS_WRITE_FAIL |
> >                         STATUS_COPY_FAIL;
> >
> > here, or go back to your v1 and handle the failure in each operation function to
> > set the correct flag.
> >
> 
> Good catch, indeed with the check outside of the functions, the status
> FAIL bits are not set. I think setting the status as a combined fail
> flag makes sense, however, it conveys the idea that read/write/copy
> failed whereas only one of them actually failed.
> 
> I agree that a single status SUCCESS/FAIL flag would be simpler. But
> changing this would require changes on both sides (EP & RC) and will
> reduce compatibility between EP and RC side driver versions, so I
> would refrain from changing this.
> 

I think it is OK to change the status flags and do the right thing. If someone
reports a test failure, then we can ask them to upgrade their kernel. Given that
this this just a test application, I don't think it is a big deal.

- Mani

>  I think I still prefer the v1/v2 code because even as it has a little
> bit of duplication it is clear and sets the correct FAIL bit without
> extra logic whereas here we either set all FAIL bits or have to add
> extra logic.
> 
> Thank you for spotting this.
> 
> > > +             pci_epf_test_raise_irq(epf_test, reg);
> > >               goto reset_handler;
> > >       }
> > >
> >
> > --
> > Damien Le Moal
> > Western Digital Research
> >
> 
> Best regards,
> Rick

-- 
மணிவண்ணன் சதாசிவம்

