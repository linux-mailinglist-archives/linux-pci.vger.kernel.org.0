Return-Path: <linux-pci+bounces-20925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A340A2CA9C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2717E167BCE
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACF6198A19;
	Fri,  7 Feb 2025 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjcYrz07"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C03C175D5D
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738951086; cv=none; b=PwHiRRRUNOAbG7ALwPwCWRtA5TNWntKk/y/grkugHCUAKKnYqsmqXhMcS5AStXG9sq2GdH3FMJpTFasOm+Ayiezvu/1HSwrIdozPWiAqtSQKcwv/5J+IrZCLx3j/9/fEa7djqlR0oAefhWC7Lo+YVleIKyb8WTObDTwC56J9yCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738951086; c=relaxed/simple;
	bh=4C1r4Ax3Bo4IScqjKAAkJcyCEdxfXBMWXoYARsYdzp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvW5lqVxR/o5/BHBBoL9rtod8dGqQv80yJVt43J5tMSC8OmSSwuCSZmzky4nFsMti1ItDxshMPvY+AAYJj+8ILO9qS6xq/EnWFXMoSbaLf3F6xJn6sJ7qzonWpectbsC1fLyD8xMnhnHYF0lLLzLb4oQqeE4+48FIfuCeAByTo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bjcYrz07; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f2339dcfdso38498825ad.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 09:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738951084; x=1739555884; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wJM77HZ1UmnRhLojKb2438RKQywcG1lAcAzGFls8E7A=;
        b=bjcYrz07b2rWZaeafKStqXTJqeCAwuAP8rfKRy69AAAJXCvEViwd5ZzhBKSrX8uR9J
         QgC963ooAB8UHeGSs0V/ehfweCtTuywdw+z5Su+fZ2s6cF5VtUEuiY+03OBjyvOcsukH
         Fi4BolVt7FbCYceqP8sq1fG2xUm3dWIm88WFhbA+Vpm8vfxizeekSBRawOsqnWw5quyO
         /pCt3b4Z/Mxmja60AwWCsNbMlq27yI7Zx+p5ahbcrh9o/n6lakGBZvXKLlS0YoBZyzFx
         Xk1Lr9aTErx3VorQEvYGGQ+5+AIdavjfN5/axaaWd2FuKflfDxZpHaSkOxakpf7i8TLA
         m3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738951084; x=1739555884;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJM77HZ1UmnRhLojKb2438RKQywcG1lAcAzGFls8E7A=;
        b=h2ouottBAZrYuwwaEqweTTiqt3oNgYv1dR6OoNaSyrKU7Dq7tAvRdIIhI94jeb10Fg
         camOpkzeajzG1qXx2bifbXLPYRmEDtKsubu0K00lVcXNZQgazFdiFjN773Bimv9/qqWd
         LMjEJzR+7BI5FadcGDD/NeavNURDlFIAVdCQC8ai+gast/1V9NXjOgDQCzE9oM/7NZx4
         cDvq8trJyAxMS6AjEmR7K9N9MQ//YOHZcFVpGR74wY8nZW0xT6dsUJBUpEBynE4r6Kec
         vI3Su0qvMa7vVZCHpIk1Gx4gAiprgY6yIcuOFo5zwmh2uU5lSE8hrGK33kyaEMnadRu8
         3Tyw==
X-Forwarded-Encrypted: i=1; AJvYcCWX1SKlzi1sLPaF6Nad41AzppiCC8xGXNT8bZhyT6U8ckARotetDeiD+fmYLu6W+SMBgbAusZ26p08=@vger.kernel.org
X-Gm-Message-State: AOJu0YziovQuNoPBNPBwZUWeznmIv/U47JgTQZtdw+tpnosnBHtS9Yzs
	OCMQ8pe03yKIr1tYOjANMce1AJJnS4k4ssZmjaQ5+HNqs9za2K77mczNeU0r0A==
X-Gm-Gg: ASbGncuaG88GomlVM4yAVxsBYnk2/Yk7x2c8E+eKg64sb1/oV4bjdVw8ls3ZZMmpCWE
	xvdxv4Rnu/eZopliQwbuXo/FD5vpiS0aFSCxW+dOkca3bjDn4QC/JDUwJmWZjPhZL/sY+S03sMv
	yqnAy4970HlP6mQsqPr9rckwMoN9BHUhYhtB33C1HSTFQ66fVP8RwbiuBA9Yii//mrHoOjTNKrw
	SfXP3tkth+B2h/yt653+2hu7bQmKmcsXoiXwyjHI30Pv09uZ7ccFjnfx3XeMr28WuUpZjU9z5I4
	UaAF1V19P2karhHtBJfOapnHVA==
X-Google-Smtp-Source: AGHT+IHJs/XZ6CiTFau0hB0u90Lhs4NJaZOV00tEkIwNjsA+gYtKS4ULQ+Eo/VyD0QJD/a9Hbkubyg==
X-Received: by 2002:a17:902:d4c9:b0:21f:3352:8f64 with SMTP id d9443c01a7336-21f50158c3emr64628165ad.26.1738951084262;
        Fri, 07 Feb 2025 09:58:04 -0800 (PST)
Received: from thinkpad ([120.60.76.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368cd38esm33196655ad.240.2025.02.07.09.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:58:03 -0800 (PST)
Date: Fri, 7 Feb 2025 23:27:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Wilson Ding <dingwei@marvell.com>, cassel@kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanghoon Lee <salee@marvell.com>
Subject: Re: [PATCH 1/1] PCI: armada8k: Add link-down handle
Message-ID: <20250207175759.jzmoox5mke3rachy@thinkpad>
References: <20241112213255.GA1861331@bhelgaas>
 <AD287CCE-9FFE-49BC-B9CA-B5CED4F05AF1@linaro.org>
 <BY3PR18MB46737FB5FDBD75CF31B505B8A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <BY3PR18MB4673207A36B2CD7C3B75EBA0A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY3PR18MB4673207A36B2CD7C3B75EBA0A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>

+ Niklas (who was interested in link down handling)

On Sat, Feb 01, 2025 at 11:05:56PM +0000, Wilson Ding wrote:
> > On November 13, 2024 3:02:55 AM GMT+05:30, Bjorn Helgaas
> > <mailto:helgaas@kernel.org> wrote:
> > >In subject:
> > >
> > >  PCI: armada8k: Add link-down handling
> > >
> > >On Mon, Nov 11, 2024 at 10:48:13PM -0800, Jenishkumar Maheshbhai
> > Patel wrote:
> > >> In PCIE ISR routine caused by RST_LINK_DOWN we schedule work to
> > >> handle the link-down procedure.
> > >> Link-down procedure will:
> > >> 1. Remove PCIe bus
> > >> 2. Reset the MAC
> > >> 3. Reconfigure link back up
> > >> 4. Rescan PCIe bus
> > >
> > >s/PCIE/PCIe/
> > >
> > >Rewrap to fill 75 columns.
> > >
> > >I assume this basically removes a Root Port (and the hierarchy below
> > >it) if the link goes down, and then resets the MAC and tries to bring
> > >up the link and enumerate the hierarchy again.
> > >
> > >No other drivers do this, so why does armada8k need it?  Is this to
> > >work around some unreliable link?
> > 
> > Certainly Qcom IPs have this same feature and I was also looking to implement
> > it. But the link down should not be handled by this in the controller driver.
> > 
> > Instead, it should be tied to bus reset in the core and the reset should be done
> > through a callback implemented in the controller drivers. This way, the reset
> > cannot happen in the back of PCI core and client drivers.
> > 
> > That said, the Link down IRQ received by this driver should also be propagated
> > back to the PCI core and the core should then call the callback to reset the bus
> > that I mentioned above.
> > 
> 
> It's more than a work-around for the unreliable link. A few customers may have
> such application - independent power supply to the device with dedicated reset
> GPIO to #PRST. In this way, the power cycle and warm reset of RC and EP won't
> have impact on each other. However, it may lead into the PCI driver not aware
> of the link down when an unexpected power down or reset occurs on the device.
> We cannot assume the link will be recovered soon. The worse thing is the driver
> may continue access to the device, which may hang the bus. Since the device
> is no longer present on the bus, it's better to remove it. Besides, in order to bring
> up the link, the only way is to reset the MAC, which starts over the state machine
> of LTSSM.
> 
> Well, we also noticed that there is no other driver that did this. I agree it is not
> necessary if the power cycle or warm reset of the device is done gracefully. The
> user can remove the device prior to the power cycle/reset.  And do the rescan
> after the link is recovered. However, the unexpected power down is still possible.
> Please enlighten me if there is any better approach to handle such unexpected
> link down.
> 

There is no issue in retraining the link. My concern is that, the retrain should
not happen autonomously in the controller driver. PCI core should be made
informed of it. More below.

> In the meanwhile, I am quite interested the callback implementation suggested
> by Mani. But I am sure if we have such infrastructure right there. Mani, could
> you please elaborate a bit more, or is there any examples in the existing code
> and patches.
> 

There is no such implementation available right now. This idea is on my mind for
quite some time, but never had time to do it. Maybe this gives me motivation to
do so.

Niklas: Did you get a chance to look into this? Else, let me know. I'll take a
stab at it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

