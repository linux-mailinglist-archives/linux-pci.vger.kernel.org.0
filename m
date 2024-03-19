Return-Path: <linux-pci+bounces-4892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A16887FC9B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 12:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4976AB21185
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 11:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F41B7E582;
	Tue, 19 Mar 2024 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rLek48J+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D716C7E575
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846717; cv=none; b=lwnUkx5yjyC/6meW8DP+7ycZMqyldaQmiuCS5ixucG0LEbeeSrH07g5B8Lv67REm+r6J46oBj6PFPrFmUEpjoChP/0L24bbJjkw48jv1pYNtfgLsclXISOrEJoBxpvyL5aSmx5obQKIrsflU6oIiVmIpfD6+8YgGb6adXfLcKwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846717; c=relaxed/simple;
	bh=5JmHxvmDPWbQTYeXB1OgMxbSaPC2ut8uFstyW5S3N7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXbz7raWeL41hPcmXCEo1F0OSYZbuJt2ngf178DD6PhDuZjhXrVpFQx0xEH8XWGNEDZ7tmDwEfM2BQQc/QTm0rybAegyjufu7EV6vItXhaYp9lPujBweQvdaqdOXTQIw4Us1/M075Dr9758g/CmQQWoyvqd9wmHS8Dow3iZnRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rLek48J+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1deefb08b9eso23320285ad.3
        for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 04:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710846715; x=1711451515; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OpV7V2XsbZLlejqNfMsqdQB5QkQ7j91cgGmJ1H2MAjQ=;
        b=rLek48J+tSnE7lyPk+xSOo/rhK3j4XjxxwYhDYD1YOaoxMb9IGjx6qXC4vjRElFOdY
         IQQWE8B9XgSurDSwxiPuROdjOGtEB67nlfThg7ke8bEZb+P7Cu3fNOsXv2K53GKBTTnu
         JOYnvdB69sWRl9DBQdDaNzdRgO8jxbZfhZwYzwg5o15HjOWfYZvtpF6QTcfEikgW+boY
         sSTzG4dcxyVljoUL1boiSm3v2HwgDUcpdZoupVZq1AeEnBOQhLpdsc7lELLV9+ln45yo
         2746r+9DqjvVALHMxy8Cg0YYVMAjcLZGXReiY8bJhiehOUZqz6DObCYmFweAV7OmkEkZ
         ImmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710846715; x=1711451515;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpV7V2XsbZLlejqNfMsqdQB5QkQ7j91cgGmJ1H2MAjQ=;
        b=oZzdBu1ME0BwX7HQVJT0HcJrCVq9JoIhCAAonrWzXUYluBm6iGllS4N4nY/OoTSac7
         ryauT8/7lXGY4L27uHHCKCnceeNCh+wRzUKKBW8yvSzMZ+ofNc3VK2jlYVXpxvsdFzJL
         mRr2VvhXl/72NjyiwqkMWX+tvUQrqqD6tnL4jBblDBHJjeRdhHHfpXug5II+qbcj7Fnz
         bGWrpnaZxSeg9vyXxiqChGK5JeFWr1o9Nwj6wjCOhWjTOA5DI4MBWuaFXdWXCTDq33GN
         GG6q60IGN+8hKgCq5biG9HF38yDWtSPxpQgSXsczOZn3OrxpnAXjjwrEdjcAF765mvLS
         Idug==
X-Forwarded-Encrypted: i=1; AJvYcCVrArweX9PhcfwC8m6d9zYifmEfNuwQmstQsxMA5MwMeNPaVtt6FUOwW7B1RQ7ndtfePP7p5C3BjlxhF5ay+j9LmlROTD7h1ytT
X-Gm-Message-State: AOJu0YyFRPXMPUOjdQoDh2t0wBPks2YPGZ6hDhjNZka8EkpjUBzsazr/
	68fPEr9mCS9qWyVwhLzzWIsVKGk04uqZf4wjdiGW8OlhFFa+GPX34OrwzCs4Tw==
X-Google-Smtp-Source: AGHT+IFHusYklygz2g3Ws/lW5ES/sszSMUZTHgrwuZgA5Hi2mGoMJraYAnwmjfQazDGUhJW9eB/5hw==
X-Received: by 2002:a17:903:244c:b0:1dd:2bc8:a56c with SMTP id l12-20020a170903244c00b001dd2bc8a56cmr2626047pls.7.1710846714985;
        Tue, 19 Mar 2024 04:11:54 -0700 (PDT)
Received: from thinkpad ([120.138.12.244])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b001dd8d7d4a5csm4884876plg.90.2024.03.19.04.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 04:11:54 -0700 (PDT)
Date: Tue, 19 Mar 2024 16:41:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com
Subject: Re: [PATCH v2] PCI: dwc: Enable runtime pm of the host bridge
Message-ID: <20240319111148.GF52500@thinkpad>
References: <e83ed3e5-0c31-cfae-6f75-211709e79aa5@quicinc.com>
 <20240308171248.GA685266@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240308171248.GA685266@bhelgaas>

On Fri, Mar 08, 2024 at 11:12:48AM -0600, Bjorn Helgaas wrote:
> On Fri, Mar 08, 2024 at 08:38:52AM +0530, Krishna Chaitanya Chundru wrote:
> > On 3/8/2024 3:25 AM, Bjorn Helgaas wrote:
> > > [+to Rafael, sorry, another runtime PM question, beginning of thread:
> > > https://lore.kernel.org/r/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com]
> > > 
> > > On Thu, Mar 07, 2024 at 07:28:54AM +0530, Krishna Chaitanya Chundru wrote:
> > > > On 3/6/2024 1:27 AM, Bjorn Helgaas wrote:
> > > > > On Tue, Mar 05, 2024 at 03:19:01PM +0530, Krishna chaitanya chundru wrote:
> > > > > > The Controller driver is the parent device of the PCIe host bridge,
> > > > > > PCI-PCI bridge and PCIe endpoint as shown below.
> > > > > > 
> > > > > > 	PCIe controller(Top level parent & parent of host bridge)
> > > > > > 			|
> > > > > > 			v
> > > > > > 	PCIe Host bridge(Parent of PCI-PCI bridge)
> > > > > > 			|
> > > > > > 			v
> > > > > > 	PCI-PCI bridge(Parent of endpoint driver)
> > > > > > 			|
> > > > > > 			v
> > > > > > 		PCIe endpoint driver
> > > > > > 
> > > > > > Since runtime PM is disabled for host bridge, the state of the child
> > > > > > devices under the host bridge is not taken into account by PM framework
> > > > > > for the top level parent, PCIe controller. So PM framework, allows
> > > > > > the controller driver to enter runtime PM irrespective of the state
> > > > > > of the devices under the host bridge.
> > > > > 
> > > > > IIUC this says that we runtime suspend the controller even though
> > > > > runtime PM is disabled for the host bridge?  I have a hard time
> > > > > parsing this; can you cite a function that does this or some relevant
> > > > > documentation about how this part of runtime PM works?
> > > > > 
> > > > Generally controller should go to runtime suspend when endpoint client
> > > > drivers and pci-pci host bridge drivers goes to runtime suspend as the
> > > > controller driver is the parent, but we are observing controller driver
> > > > goes to runtime suspend even when client drivers and PCI-PCI bridge are
> > > > in active state.
> > > 
> > > It surprises me that a device could be suspended while children are
> > > active.  A PCI-PCI bridge must be in D0 for any devices below it to be
> > > active.  The controller is a platform device, not a PCI device, but I
> > > am similarly surprised that we would suspend it when children are
> > > active, which makes me think we didn't set the hierarchy up correctly.
> > > 
> > > It doesn't seem like we should need to enable runtime PM for a parent
> > > to keep it from being suspended when children are active.
> >
> > Here we are not enabling runtime PM of the controller device, we are
> > enabling runtime PM for the bridge device which is maintained by the
> > PCIe framework. The bridge device is the parent of the PCI-PCI
> > bridge and child of the controller device. As the bridge device's
> > runtime PM is not enabled the PM framework is ignoring the child's
> > runtime status.
> 
> OK, it's the host bridge, not the controller.
> 
> I'm still surprised that the PM framework will runtime suspend a
> device when child devices are active.
> 

There is a catch here. Even though the child devices are funtionally active, PM
framework will only consider their runtime_pm state, which is initially set to
'disabled' for all devices. It is upto the device drivers to enable it when
required.

Here is the initial runtime PM status of each device post boot:

Controller device -> disabled initially but enabled by pcie-qcom.c
Host bridge -> disabled initially
PCIe bridge -> disabled initially but conditionally enabled by portdrv.c
PCIe devices -> disabled initially but enabled by respective drivers like WLAN

Now, when the controller device goes to runtime suspend, PM framework will check
the runtime PM state of the child device (host bridge) and will find it to be
disabled. So it will allow the parent (controller device) to go to runtime
suspend. Only if the child device's state was 'active' it will prevent the
parent to get suspended.

But you may wonder if this is ideal? IMO NO. But we cannot blame the PM
framework here. The responsibility is within the device drivers to handle the PM
state based on the usecase. Ideally, the host bridge driver should've handled
runtime PM state during the probe time. Otherwise, PM framework wouldn't know
when would be the best time to suspend the devices.

> And further confused about managing the host bridge runtime PM in a
> controller driver.  Which other callers of pci_alloc_host_bridge() or
> devm_pci_alloc_host_bridge() will need similar changes?
> 

This scenario applies to all host bridges. So I think we should enable it inside
pci_host_probe().

- Mani

-- 
மணிவண்ணன் சதாசிவம்

