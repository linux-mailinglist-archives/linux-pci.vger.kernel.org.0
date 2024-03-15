Return-Path: <linux-pci+bounces-4851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2678887CC28
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 12:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964EB1F21497
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 11:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2846A1AAD2;
	Fri, 15 Mar 2024 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuqHKnNi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651521CAA6
	for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501423; cv=none; b=COObGR19y8ldMjK6lRj7gndzF9mcayb2c5Oe9oQZQeIxqGds6tmUCgCgVk3nU0GIiqdwZPRbW4AfSDjDXIxo+I/+pnQvCYftSulHLc44jQJKnLaaUZwUzb2WSTDEjf/XWYH6c5XrKa62RH8NDMm31igF2WLnYD8IWKrfw0ZiRfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501423; c=relaxed/simple;
	bh=dy5cwDLufg7wxxCaD7noxLPHBv05JlTpNKDhZ2qTW4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJN4QnbNcUIZ41iza/SqrEUzj07+nomCnFxvWgoeBamidpUKGUhN/Bt7yjOxSFAG4y3gG88WlXB/I/K8AeCD0IgBzkLq3rWnLAm/wrIMADQKUB8G+6xKYl1RNoYNmaAy1GXu1ol1aHxSKW4SL75J3GU1HAhw8Wormd6648rzJ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RuqHKnNi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dd10ae77d8so13648245ad.0
        for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 04:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710501421; x=1711106221; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6thXPYH7LClGHgWcKL9h7zZt1TlMxpmVNK+Pq17t2X0=;
        b=RuqHKnNibQjibdxtlSCxX9VBfbMGHzJ0pZP7TywFvX4i3jlT8E4182jUkTjsslVtbk
         EpLL6j9bTPzNrqk7VkeOksX8f8sNs14tZlyQY1WcJ8yvYaaSupJ7P781YfY3wU7A+rOG
         iZHKGX6R8D1AT8/U483fQLqBVIBs8GXlb1T4mrnMOI2djTonRX/+MvgaOGufi/2n3v9I
         sgCbp0KkG56NAmRAQz16W79NfTSm9YjugaWduBiMH3KnpWFFm0CJRqby5wdsaX4jJC2Z
         co0pm3/tfHFsk520g39VxRNBQ0yAIx1JAt69n7MJm0nWSx0iS5RWpvDKimobEjJF0jz7
         1LsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710501421; x=1711106221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6thXPYH7LClGHgWcKL9h7zZt1TlMxpmVNK+Pq17t2X0=;
        b=Di2/NVcXwKAfirkf9WYfK0X4RbwoicseVEeIPMDWwV/nvm/eDmuF9p8hP+SsA2vurs
         iFqwA76ESjXKlvm9euV5lzheGR/6as7a2/1mI9Fg3IYqeup2S/mNRWGlHZDZTVSn00AJ
         4fce4pH2CFmm5FYfPnZnDoLpI+YAm5Xj7qNR4gOwUWpb3HGafDAfVPn32K4gb9+nZSGZ
         1rZ77n6DZ3qFu89gi77k1JUVAnxro85Ir8Jo4NzJw0E4Sj8I0b/zPNcdGsTC8s3u0hZt
         yzVXQNXFIu5DfKzNKm0Wv8psV4bNgQm/KwnnAkZhf6NbbU9KO1n5b4/VYEKLKjHb1mv6
         wUwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/2pwkLEKWtBVzPmPJ6cbU0EhC+F231xfezHGsXSXbw8Rjbjuvoi7T5WH5vpOBHJ97m0fnjN7o5dE2R0vJrAz8GCY2a8wZrG0M
X-Gm-Message-State: AOJu0Yw6UQdvueMBT2zsg+mAiywMe3Tn9GH5MUuYXwq6lAS6NhhXEary
	VkxYWWH0+9e6XmfPwNnWSncEkaoF1HV9p/UbGTvqFkd1/EKotsBo7jMllyJIPg==
X-Google-Smtp-Source: AGHT+IFf34WhzPmRgX8Nynn9KCi2nYLHvfYmTnrmUcYWFD3uvozcGhYEeRipTeVGDuCrwoz3xrAlHw==
X-Received: by 2002:a17:902:b78b:b0:1dd:819f:9503 with SMTP id e11-20020a170902b78b00b001dd819f9503mr4404314pls.12.1710501420484;
        Fri, 15 Mar 2024 04:17:00 -0700 (PDT)
Received: from thinkpad ([117.217.176.159])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001dd59b54f9fsm3502877plg.136.2024.03.15.04.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:17:00 -0700 (PDT)
Date: Fri, 15 Mar 2024 16:46:53 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2 2/3] PCI: qcom: Read back PARF_LTSSM register
Message-ID: <20240315111653.GK3375@thinkpad>
References: <20240215161114.GA1292081@bhelgaas>
 <bc7d9859-f7ec-41c5-8a9e-170ccdfff46a@linaro.org>
 <Zc8GHrgdF7jJBgyu@hovoldconsulting.com>
 <c1f85249-32b1-41e2-adc3-5aa4ad7609b9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1f85249-32b1-41e2-adc3-5aa4ad7609b9@linaro.org>

On Fri, Mar 15, 2024 at 11:16:59AM +0100, Konrad Dybcio wrote:
> 
> 
> On 2/16/24 07:52, Johan Hovold wrote:
> > On Thu, Feb 15, 2024 at 07:44:27PM +0100, Konrad Dybcio wrote:
> > > On 15.02.2024 17:11, Bjorn Helgaas wrote:
> > > > On Thu, Feb 15, 2024 at 11:21:45AM +0100, Konrad Dybcio wrote:
> > > > > On 14.02.2024 23:28, Bjorn Helgaas wrote:
> > > > > > On Wed, Feb 14, 2024 at 10:35:16PM +0100, Konrad Dybcio wrote:
> > > > > > > On 12.02.2024 22:17, Bjorn Helgaas wrote:
> > > > > > > > Maybe include the reason in the subject?  "Read back" is literally
> > > > > > > > what the diff says.
> > > > > > > > 
> > > > > > > > On Sat, Feb 10, 2024 at 06:10:06PM +0100, Konrad Dybcio wrote:
> > > > > > > > > To ensure write completion, read the PARF_LTSSM register after setting
> > > > > > > > > the LTSSM enable bit before polling for "link up".
> > > > > > > > 
> > > > > > > > The write will obviously complete *some* time; I assume the point is
> > > > > > > > that it's important for it to complete before some other event, and it
> > > > > > > > would be nice to know why that's important.
> > > > > > > 
> > > > > > > Right, that's very much meaningful on non-total-store-ordering
> > > > > > > architectures, like arm64, where the CPU receives a store instruction,
> > > > > > > but that does not necessarily impact the memory/MMIO state immediately.
> > > > > > 
> > > > > > I was hinting that maybe we could say what the other event is, or what
> > > > > > problem this solves?  E.g., maybe it's as simple as "there's no point
> > > > > > in polling for link up until after the PARF_LTSSM store completes."
> > > > > > 
> > > > > > But while the read of PARF_LTSSM might reduce the number of "is the
> > > > > > link up" polls, it probably wouldn't speed anything up otherwise, so I
> > > > > > suspect there's an actual functional reason for this patch, and that's
> > > > > > what I'm getting at.
> > > > > 
> > > > > So, the register containing the "enable switch" (PARF_LTSSM) can (due
> > > > > to the armv8 memory model) be "written" but not "change the value of
> > > > > memory/mmio from the perspective of other (non-CPU) memory-readers
> > > > > (such as the MMIO-mapped PCI controller itself)".
> > > > > 
> > > > > In that case, the CPU will happily continue calling qcom_pcie_link_up()
> > > > > in a loop, waiting for the PCIe controller to bring the link up, however
> > > > > the PCIE controller may have never received the PARF_LTSSM "enable link"
> > > > > write by the time we decide to time out on checking the link status.
> > 
> > This makes no sense. As Bjorn already said, you're just polling for the
> > link to come up (for a second). And unless you have something else that
> > depends on the write to have reached the device, there is no need to
> > read it back. It's not going to be cached indefinitely if that's what
> > you fear.
> 
> The point is, if we know that the hardware is expected to return "done"
> within the polling timeout value of receiving the request to do so, we
> are actively taking away an unknown amount of time from that timeout.
> 
> So, if the polling condition becomes true after 980ms, but due to write
> buffering the value reached the PCIe hardware after 21 ms, we're gonna
> hit a timeout. Or under truly extreme circumstances, the polling may
> time out before the write has even arrived at the PCIe hw.
> 

You should've mentioned the actual reason for doing the readback in the commit
message. That would've clarified the intention.

> > 
> > > Generally, it's a good idea to add such readbacks after all timing-
> > > critical writes, especially when they concern asserting reset,
> > > enabling/disabling power, etc., to make sure we're not assuming the
> > > hardware state of a peripheral has changed before we ask it to do so.
> > 
> > Again no, there is no general need to do that. It all depends on what
> > the code does and how the device works.
> 
> Agreed it's not necessary *in general*, but as I pointed out, this is
> an operation that we expect to complete within a set time frame, which
> involves external hardware.
> 

As I pointed out in the review of v1 series, LTSSM is in PARF register region
and the link status is in DBI region. Techinically both belongs to the PCIe
domain, but I am not 100% sure that both belong to the same hw domain or
different. So I cannot rule out the possibility that the first write may not
reach the hardware by the time link status is queried.

That's the reason I gave my R-b tag. But I need to confirm with the hw team
on this to be sure since this may be applicable to other drivers also.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

