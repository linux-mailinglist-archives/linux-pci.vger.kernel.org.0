Return-Path: <linux-pci+bounces-19679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35193A0BD44
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 17:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5035D1889BF1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 16:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D44822BAA3;
	Mon, 13 Jan 2025 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDRweAaS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9432297EF
	for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785560; cv=none; b=l2t7tb8kP2ObPURkPlNPWECPXD1HvodHSde381fhufSG6BylqM8KalT4HqJUlOAq//+wSD60Cy+7zKtxBMfeMzFIIbZ+QSHUy6o/jXEnQlMhYzjhuOaxqwHrIGBKTco+xYXGHnBHqfjGbRJXLNDPW8J+WNfHJ/PuO7qse+rm2Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785560; c=relaxed/simple;
	bh=1kDW32MuSVAFdsYNImZqjgIN1GG6jDDnrmWQYE1QmXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGAZ8vYt5507B6IJVkjeUN1oBXWWgtX0tep+gbFE2X6oXB5ttq3igBKzlupHoo47ohBueO1RXPA5/Da3VshKNXxLcXalfyiQGuShnm9gsZPmUgecxiozmnURM98sM1fdrPs5hfs/ivi7hTG2DbgTmoF+bq1YaWjfvQbhBQZ0Qqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rDRweAaS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216281bc30fso94248605ad.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 08:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736785558; x=1737390358; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aT4ZLTVIwGUtbe1QI6YLbzJoKdwXpUmQWKkHVbvrXoU=;
        b=rDRweAaS1+mnvt/+zt085iHJ/Xo7Bw3gfXbfqwiZEYPL9qFl0VUxM7Wf8ObE7nFRTQ
         swj98ew2928kxDNEZVpiyDOZAYLKC94VlqJ1B1ScfZfC+Ig2GLBi9JjSj6nhvGgzWc44
         p043JrKUSgTn2xA6gZc8YigeLaawh3cUA5sgQaT+1BGm/yuePcbhFcQj5SuhgAnpxAxk
         7KRTUtxoDWCFLZ6sprFnVD5x3fQdSdXQBlTmB6ec7eQcrLdeqZygDYT6ZaLIo0Qch0AM
         ERnuyrR23uq2+WLDyG89RhHtnwBIyuWwGYkrf/qED6CXv/IV0OjPNk7UT4vS7SAf9ST1
         W6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736785558; x=1737390358;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aT4ZLTVIwGUtbe1QI6YLbzJoKdwXpUmQWKkHVbvrXoU=;
        b=m/IUJg1FR/5bM0xbUFnXno7smfqp7bhTD6HmRr7Zl1CV+1Yaw1aBbN6lARppDxylcx
         SUPaGdgcok3oFF+vCDHMGBcSyCQp5I0p/e4UWEszo5fISCQoS3givOytLc9gO1uiMksR
         nahwrwCOvuu64CetDxcMR1TVxQADsqj9KVJQmxH2JiiLJ6cDUKB+bgNFrLPfIBAi3GKC
         zLo/lBuDYAGqOs35Rwf5rMh370LOQpCOLhvg7wX12A8NRuJ9vvzeAuX+x5SF3kekXScM
         MZqmVGkKWbJyhC15dEDeNf2MkyUW6W1BC6hi+v9KBtN5xT9DtjLXM6EQl+u9OQOEBjnH
         DT4g==
X-Forwarded-Encrypted: i=1; AJvYcCVaLHEiOx9y/QhfmupP/CZUzvOoxC+co0dQAkvB+3Fkf48lt3yxaAfJYlzO3R5QUF4KV5bsg7UpUxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUhxKzpgfwSTtKm+v8zQOdd7Pl8xgPDRgHz2hJA/OhlDD8Egg
	8cs4G48q0Mq/5Tat4W9WDj0XeAmgcbHuvpMN/OLJw15+tEszfdifCuzC5TYbaQ==
X-Gm-Gg: ASbGncuXBhIjxim3sZ46LQEkzgd0Cktuaje2hSJR4R2YCLDK0MYkfPtN6D0g3u7p/Mo
	nOUjpmarcAlpK+Q2aUpvX8WvFC+VfUeUBBK2Xfv8GyjIgk9jpqqWrcqAlsMZsj3zQUiOMznotvh
	pYhVHq8eH1H1cfRXBMq0seLDy86ziSnmbuOv01S8rNVcATib7WXUFvKQWtzJWk9QYxyGbxCmDol
	CJOMtOzcmAeH/BfKvm62efx7s8oForiiTiFhKyUYn/Eg/cJhZqSwti/wNfEXjzFd6F/Zg==
X-Google-Smtp-Source: AGHT+IEyDmGykdg1IhscNzCDFazeYHBoOZhp/2iBInjICsQGaz0Y3A6UzMlVkKTjV+xfYdDVDaQJPw==
X-Received: by 2002:a17:903:234f:b0:216:1cfa:2bda with SMTP id d9443c01a7336-21a83fc3891mr365457255ad.43.1736785557828;
        Mon, 13 Jan 2025 08:25:57 -0800 (PST)
Received: from thinkpad ([117.213.100.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219330sm55673625ad.132.2025.01.13.08.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 08:25:57 -0800 (PST)
Date: Mon, 13 Jan 2025 21:55:49 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: rafael@kernel.org, ulf.hansson@linaro.org,
	Johan Hovold <johan@kernel.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Markus.Elfring@web.de, quic_mrana@quicinc.com, rafael@kernel.org,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
Message-ID: <20250113162549.a2y7dlwnsfetryyw@thinkpad>
References: <20241111-runtime_pm-v7-0-9c164eefcd87@quicinc.com>
 <20241111-runtime_pm-v7-2-9c164eefcd87@quicinc.com>
 <Z30p2Etwf3F2AUvD@hovoldconsulting.com>
 <7882105f-93a3-fab9-70a2-2dc55d6becfc@quicinc.com>
 <Z3057yuNjnn0NPqk@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3057yuNjnn0NPqk@hovoldconsulting.com>

+ Ulf (for the runtime PM related question)

On Tue, Jan 07, 2025 at 03:27:59PM +0100, Johan Hovold wrote:
> On Tue, Jan 07, 2025 at 07:40:39PM +0530, Krishna Chaitanya Chundru wrote:
> > On 1/7/2025 6:49 PM, Johan Hovold wrote:
> 
> > >> @@ -3106,6 +3106,17 @@ int pci_host_probe(struct pci_host_bridge *bridge)
> > >>   		pcie_bus_configure_settings(child);
> > >>   
> > >>   	pci_bus_add_devices(bus);
> > >> +
> > >> +	/*
> > >> +	 * Ensure pm_runtime_enable() is called for the controller drivers,
> > >> +	 * before calling pci_host_probe() as pm frameworks expects if the
> > >> +	 * parent device supports runtime pm then it needs to enabled before
> > >> +	 * child runtime pm.
> > >> +	 */
> > >> +	pm_runtime_set_active(&bridge->dev);
> > >> +	pm_runtime_no_callbacks(&bridge->dev);
> > >> +	devm_pm_runtime_enable(&bridge->dev);
> > >> +
> > >>   	return 0;
> > >>   }
> > >>   EXPORT_SYMBOL_GPL(pci_host_probe);
> > > 
> > > I just noticed that this change in 6.13-rc1 is causing the following
> > > warning on resume from suspend on machines like the Lenovo ThinkPad
> > > X13s:
> 
> > Can you confirm if you are seeing this issue is seen in the boot-up
> > case also. As this part of the code executes only at the boot time and
> > will not have effect in resume from suspend.
> 
> No, I only see it during resume. And enabling runtime PM can (and in
> this case, obviously does) impact system suspend as well. 
> 
> > > 	pci0004:00: pcie4: Enabling runtime PM for inactive device with active children
> 
> > I believe this is not causing any functional issues.
> 
> It still needs to be fixed.
> 
> > > which may have unpopulated ports (this laptop SKU does not have a modem).
> 
> > Can you confirm if this warning goes away if there is some endpoint
> > connected to it.
> 
> I don't have anything to connect to the slot in this machine, but this
> seems to be the case as I do not see this warning for the populated
> slots, nor on the CRD reference design which has a modem on PCIe4.
> 

Yes, this is only happening for unpopulated slots and the warning shows up only
if runtime PM is enabled for both PCI bridge and host bridge. This patch enables
the runtime PM for host bridge and if the PCI bridge runtime PM is also enabled
(only happens now for ACPI/BIOS based platforms), then the warning shows up only
if the PCI bridge was RPM suspended (mostly happens if there was no device
connected) during the system wide resume time.

For the sake of reference, PCI host bridge is the parent of PCI bridge.

Looking at where the warning gets triggered (in pm_runtime_enable()), we have
the below checks:

dev->power.runtime_status == RPM_SUSPENDED
!dev->power.ignore_children
atomic_read(&dev->power.child_count) > 0

When pm_runtime_enable() gets called for PCI host bridge:

dev->power.runtime_status = RPM_SUSPENDED
dev->power.ignore_children = 0
dev->power.child_count = 1

First 2 passes seem legit, but the issue is with the 3rd one. Here, the
child_count of 1 means that the PCI host bridge has an 'active' child (which is
the PCI bridge). The PCI bridge was supposed to be RPM_SUSPENDED as the resume
process should first resume the parent (PCI host bridge). But this is not the
case here.

Then looking at where the child_count gets incremented, it leads to
pm_runtime_set_active() of device_resume_noirq(). pm_runtime_set_active() is
only called for a device if dev_pm_skip_suspend() succeeds, which requires
DPM_FLAG_SMART_SUSPEND flag to be set and the device to be runtime suspended.

This criteria matches for PCI bridge. So its status was set to 'RPM_ACTIVE' even
though the parent PCI host bridge was still in the RPM_SUSPENDED state. I don't
think this is a valid condition as seen from the warning triggered for PCI host
bridge when pm_runtime_enable() is called from device_resume_early():

pci0004:00: pcie4: Enabling runtime PM for inactive device with active children

I'm not sure of what the fix is in this case. But removing the
DPM_FLAG_SMART_SUSPEND flag from PCI bridge driver (portdrv) makes the warning
go away. This indicates that something is wrong with the DPM_FLAG_SMART_SUSPEND
flag handling in PM core.

Ulf/Rafael, thoughts?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

