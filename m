Return-Path: <linux-pci+bounces-5080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA9B88A985
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 17:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE1C8BE70F9
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4DB15664B;
	Mon, 25 Mar 2024 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwDj2Klr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478A31892AE
	for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365011; cv=none; b=Dri3Sv8m9Eimlw9mVxijsT5gDuErNQ4FRg/y+qn9sNyHEeuikGSjnMUT8+zTfV3a2f0LSqAew0yusJQnDXy6KuSUlX8jlZQpQfi5UIv8LP8SDCnXAtFIVW5DQOCcRb9A6520Mns/xzfJWMidbs95H3dTGEb3/tEoN4F5QWiZXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365011; c=relaxed/simple;
	bh=Rc+odq6nTP1mMBoezv6+ZwOa9/3HoO8HhKhxFOFgY+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCV3JiCT8ahkjEuMk4Y2DQK35PUx+6q/YzoFa/PB9yJ4rFwcrxIIXGdH/xCAC7e5gEWJ5ZR/BgKl0H+2zgrvgmIP49DZuDlPZAlWN5bLgbGOMxZbNfZUzgR6ks++UZL5Md8OvPqoqL5Rz5OOI1dy0s7kFWuBQP3EJQ5vl1EvBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GwDj2Klr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0d6356ce9so1091425ad.3
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 04:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711365009; x=1711969809; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DMK3ylVrOqXacq37fn5lt279sbbZ046oVEG94OFFToQ=;
        b=GwDj2KlrKMGmp/ZeTEULcccs15XroTjeBUcToGmNFq35WP0qERLmgzwnx1KBAYX75I
         abC2dNhwFSRFp2eFBhPLCBDm/8Qr/BE7o+LjzNOsTotD2KN5VgaY7EeKVAns1EYY7O5P
         XybjzTgh0JnTfHiQNneudj1pMcKFiiKTRdyPrher2wzrWZh8y8tKcPf9VURBzmt6wf3T
         Pl/I2CtjPAze40Bsr8clKNevVBFhwWFRUb0DPVkG45ISx2i5E/H0DUBAcMcHj+BnKoz3
         +CKJf5ra3MgYR7pnc17BD93L6b7iEMfYb9tpE6qn1k35HHWyKh3ZHH1yKOSXgxRUWBQf
         Ejbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711365009; x=1711969809;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMK3ylVrOqXacq37fn5lt279sbbZ046oVEG94OFFToQ=;
        b=C7shLrJ/KA1FOBgI69f9ndXLTQ9LTteVOqU0Q7VPu++XuR++yz6M61nWuxvdTJRhkM
         ClZXmfD8/0Yx2tl5J81nJ+j2WqHd82qKMxbBCErU8cMlPAH8maH9iuP7oiHu0Ti0JSo8
         qo73tyWTwXz/0qM0789BdRXGy+8rEs0w8oTZWiwqmCnabVrMDNntYbddpYfykhdVezxh
         x1F9xla/C+/cV3tBSy013JyDTnpepc4HVx7scQCNIQEbdpcZ4vQKBvSGdaKk4WO6lO5Q
         CvJxQf+UgD/dQlOZBnABwKcshm38C16kA8Udp6SG+KdlDAmeE01rDifdanDme9PGqkZP
         GtBw==
X-Forwarded-Encrypted: i=1; AJvYcCW2byjI2kp+v06DuXgOLLxSla2TCQ2+B9dp1SQergQiv5sbnAbU4rCFnJjfjutQzoVkuLw6KA3ohFaRNeoTkZqAPian5cKrG8oJ
X-Gm-Message-State: AOJu0YzTMbqK+lcwwLsvZIRt6yUtW9GANISJw/3hmbaxHLuQy42mUnCi
	KA15HBWEk4WUuT3D+MwiLrJgTqT53cnAX1NPbjDBh8V39BfpmC3mBPhG2MTvyw==
X-Google-Smtp-Source: AGHT+IGtBw8y+ISB0QG/aOBJRFt3CS5tDDYGDGycdRZUdjUgutNoIxdX1Bhm+tcGWrIvnyHbhetZIQ==
X-Received: by 2002:a17:902:e84d:b0:1e0:bd7f:191 with SMTP id t13-20020a170902e84d00b001e0bd7f0191mr3108636plg.61.1711365009248;
        Mon, 25 Mar 2024 04:10:09 -0700 (PDT)
Received: from thinkpad ([117.207.29.15])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902ea0800b001e0294f17b7sm4472102plg.1.2024.03.25.04.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 04:10:08 -0700 (PDT)
Date: Mon, 25 Mar 2024 16:39:59 +0530
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
Message-ID: <20240325110959.GC2938@thinkpad>
References: <20240319111148.GF52500@thinkpad>
 <20240322220456.GA1379507@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240322220456.GA1379507@bhelgaas>

On Fri, Mar 22, 2024 at 05:04:56PM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 19, 2024 at 04:41:48PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Mar 08, 2024 at 11:12:48AM -0600, Bjorn Helgaas wrote:
> > > On Fri, Mar 08, 2024 at 08:38:52AM +0530, Krishna Chaitanya Chundru wrote:
> > > > On 3/8/2024 3:25 AM, Bjorn Helgaas wrote:
> > > > > [+to Rafael, sorry, another runtime PM question, beginning of thread:
> > > > > https://lore.kernel.org/r/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com]
> > > > > 
> > > > > On Thu, Mar 07, 2024 at 07:28:54AM +0530, Krishna Chaitanya Chundru wrote:
> > > > > > On 3/6/2024 1:27 AM, Bjorn Helgaas wrote:
> > > > > > > On Tue, Mar 05, 2024 at 03:19:01PM +0530, Krishna chaitanya chundru wrote:
> > > > > > > > The Controller driver is the parent device of the PCIe host bridge,
> > > > > > > > PCI-PCI bridge and PCIe endpoint as shown below.
> > > > > > > > 
> > > > > > > > 	PCIe controller(Top level parent & parent of host bridge)
> > > > > > > > 			|
> > > > > > > > 			v
> > > > > > > > 	PCIe Host bridge(Parent of PCI-PCI bridge)
> > > > > > > > 			|
> > > > > > > > 			v
> > > > > > > > 	PCI-PCI bridge(Parent of endpoint driver)
> > > > > > > > 			|
> > > > > > > > 			v
> > > > > > > > 		PCIe endpoint driver
> > > > > > > > 
> > > > > > > > Since runtime PM is disabled for host bridge, the state of the child
> > > > > > > > devices under the host bridge is not taken into account by PM framework
> > > > > > > > for the top level parent, PCIe controller. So PM framework, allows
> > > > > > > > the controller driver to enter runtime PM irrespective of the state
> > > > > > > > of the devices under the host bridge.
> > > > > > > 
> > > > > > > IIUC this says that we runtime suspend the controller even though
> > > > > > > runtime PM is disabled for the host bridge?  I have a hard time
> > > > > > > parsing this; can you cite a function that does this or some relevant
> > > > > > > documentation about how this part of runtime PM works?
> > > > > > > 
> > > > > > Generally controller should go to runtime suspend when endpoint client
> > > > > > drivers and pci-pci host bridge drivers goes to runtime suspend as the
> > > > > > controller driver is the parent, but we are observing controller driver
> > > > > > goes to runtime suspend even when client drivers and PCI-PCI bridge are
> > > > > > in active state.
> > > > > 
> > > > > It surprises me that a device could be suspended while children are
> > > > > active.  A PCI-PCI bridge must be in D0 for any devices below it to be
> > > > > active.  The controller is a platform device, not a PCI device, but I
> > > > > am similarly surprised that we would suspend it when children are
> > > > > active, which makes me think we didn't set the hierarchy up correctly.
> > > > > 
> > > > > It doesn't seem like we should need to enable runtime PM for a parent
> > > > > to keep it from being suspended when children are active.
> > > >
> > > > Here we are not enabling runtime PM of the controller device, we are
> > > > enabling runtime PM for the bridge device which is maintained by the
> > > > PCIe framework. The bridge device is the parent of the PCI-PCI
> > > > bridge and child of the controller device. As the bridge device's
> > > > runtime PM is not enabled the PM framework is ignoring the child's
> > > > runtime status.
> > > 
> > > OK, it's the host bridge, not the controller.
> > > 
> > > I'm still surprised that the PM framework will runtime suspend a
> > > device when child devices are active.
> > 
> > There is a catch here. Even though the child devices are funtionally
> > active, PM framework will only consider their runtime_pm state,
> > which is initially set to 'disabled' for all devices. It is upto the
> > device drivers to enable it when required.
> > 
> > Here is the initial runtime PM status of each device post boot:
> > 
> > Controller device -> disabled initially but enabled by pcie-qcom.c
> > Host bridge -> disabled initially
> > PCIe bridge -> disabled initially but conditionally enabled by portdrv.c
> > PCIe devices -> disabled initially but enabled by respective drivers like WLAN
> > 
> > Now, when the controller device goes to runtime suspend, PM
> > framework will check the runtime PM state of the child device (host
> > bridge) and will find it to be disabled. So it will allow the parent
> > (controller device) to go to runtime suspend. Only if the child
> > device's state was 'active' it will prevent the parent to get
> > suspended.
> > 
> > But you may wonder if this is ideal? IMO NO. But we cannot blame the
> > PM framework here. The responsibility is within the device drivers
> > to handle the PM state based on the usecase. Ideally, the host
> > bridge driver should've handled runtime PM state during the probe
> > time. Otherwise, PM framework wouldn't know when would be the best
> > time to suspend the devices.
> 
> My expectation is that adding new functionality should only require
> changes in drivers that want to take advantage of it.  For example, if
> we add runtime PM support in the controller driver, the result should
> be functionally correct even if we don't update drivers for downstream
> devices.
> 

Well, IMO PM framework should disable runtime PM for the parent if the child's
runtime PM state is disabled.

It'd be good to get the opinion of Rafael.

- Mani

> If that's not the way it works, I suggest that would be a problem in
> the PM framework.
> 
> The host bridge might be a special case because we don't have a
> separate "host bridge" driver; that code is kind of integrated with
> the controller drivers.  So maybe it's OK to do controller + host
> bridge runtime PM support at the same time, as long as any time we add
> runtime PM to a controller, we sure it's also set up for the host
> bridge.
> 
> Bjorn

-- 
மணிவண்ணன் சதாசிவம்

