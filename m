Return-Path: <linux-pci+bounces-13676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5189298B9C0
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 12:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E87281EA7
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 10:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4935C193429;
	Tue,  1 Oct 2024 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/vakxwD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3F24594C
	for <linux-pci@vger.kernel.org>; Tue,  1 Oct 2024 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778671; cv=none; b=YOeX7JkL5GVw+jQnSvS9Bqyt88zR1AhOscWA+7yk001CUJVSbH1oEFSP4tH+/miHXzsRzck96kM8RXqucvf8ahiSRWkTNslH+K4hZOM2E5MbSc3mKGJ39NwRaxAZF8lnC7eP9H+hbzdrAFrB1WXtdRr+VuZP4Ffy7eU63tTzKfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778671; c=relaxed/simple;
	bh=yAGmCdd75QeGH57D0Rkzl9n6Wfz8ZCLvGKoFlHP6kwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jycpAwJHenLiEjOHvO89J/ZEyJTfl14nj3IkxDRCgKtmqDsQHp5i0XC0nHRmQIe2mDxcAoC9ES34YsHSbsZr10sIeFeTCA1+4dg0ZSzQ/BLxgvTjBwMIhtkr9SAPXaVJmbLFQHjuFUbVgkpXnX3vWRVFga+u5//awRB+wQwvyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H/vakxwD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b90984971so19672145ad.3
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2024 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727778669; x=1728383469; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Dw4l+G9an39KsWSxDP94YiTolCS89KFp0iqjxw1BCE=;
        b=H/vakxwD1bog1BTb3X0nLZ/k3Kp6E+krMYILAJVyphCBQM1N7yCLUAu/qXciOHb5f2
         NU7uvFZmI28dEBj1e0J8GCOMc6Ml9/K1G8BrK0H7mutT1mwPD3b+eLj5bBGIatOomBbP
         mj95kDCmPfxK8moaG6S62ZspywmeM/33Xdcd1uXoCc+hZJUaO/SBsSYe/LyM6YDFxHsR
         fHnmyuivJFHE3seXbiXMGjTGK7MCaGm0WiD8VQ7w4gwwkdXbDMpmx0sL8YxdicL1OUwH
         84rKHkmMayv9WRmJqSmQfgNODc1IHi+boDleybrfe/2UodIsiDW2yWk7t8o3NZB640lx
         z7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727778669; x=1728383469;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Dw4l+G9an39KsWSxDP94YiTolCS89KFp0iqjxw1BCE=;
        b=I47tDm1ZFjhvpSVS4m4J3AjUqYhMBVpO8NIgO4Wm13EDFLwmM6i84knlhFQBHATvI3
         sDNor/Yk5JwLOVLH+Dn1Lwc1shEYH5rgCRDpzzGyngIqij2kc7vWriBLldxJnm1f2T/V
         5IUA8SNZee4FMedfHZ5jdD5tRIOe1E2XzZ2Dsd1zLb1vMTVa5pXGuSgvcgPCv4j+ziU3
         BGo2HDs/vmAgV7wgodNUrt4Yh3VvGPFe4RTxJcIsq2ST3aNF+FMUUlhU6ggQ6YA+ABHX
         C4j9+KqoJOsMbuQOTT1hEc2KXIAyHRDKhoOCkmfTCGp7U2mg+MFm+XdVpthnKVrrWVEA
         LFLw==
X-Forwarded-Encrypted: i=1; AJvYcCVxTT9LInXT1dXtt8mI1FIqoV63r9mpEcM9eY5j1gvA1JVjAJC90IkVacaqu8pfjx0L7YDZl6t++1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoNLgUTrwrLfbsSjIMMb3ZTILXVN/WkBxIvGsfTAEBNlOBPdMm
	nICRJCvcnrsUfGFSs3vFWwPXVU4ZUu03XIy1m7Quv1Jsyv5Yt7UFSPtbb2Nhtg==
X-Google-Smtp-Source: AGHT+IHqO9KzY9cSNcbXgmO/4uNrXciRkUPaBdjGBGmaPpdZ66MJOhRQSux7SW0iEBiaCBGsg5MTmQ==
X-Received: by 2002:a17:902:ecc7:b0:20b:5fb1:ea52 with SMTP id d9443c01a7336-20b5fb1ee30mr173097865ad.21.1727778668557;
        Tue, 01 Oct 2024 03:31:08 -0700 (PDT)
Received: from thinkpad ([36.255.17.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e629acsm66932665ad.270.2024.10.01.03.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 03:31:08 -0700 (PDT)
Date: Tue, 1 Oct 2024 16:01:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Mayank Rana <quic_mrana@quicinc.com>,
	Markus Elfring <Markus.Elfring@web.de>, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4] PCI: Enable runtime pm of the host bridge
Message-ID: <20241001103100.ewzgmq3apmxtrsr7@thinkpad>
References: <20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com>
 <20240816204539.GA73302@bhelgaas>
 <CAJZ5v0j0ck2yKPzisggkdKTFz-AVKG7q+6WnBiiT_43VT4Fbvg@mail.gmail.com>
 <b0d8e51d-cf53-dc75-0e57-4e2e85a14827@quicinc.com>
 <CAJZ5v0jMSrkH7jCk0Ayb21vdXjCnYHHiSqdbifNFwq2OucEMtQ@mail.gmail.com>
 <bfdc6c20-926e-533b-a8e3-0d5a3ef8be8c@quicinc.com>
 <CAJZ5v0gHw=BUGn7MkRaLnAQ9ki-YDOL3SpNxd0X9YmTVG-ofzw@mail.gmail.com>
 <0506433c-62c5-e7c0-8c8a-55744a5e87d6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0506433c-62c5-e7c0-8c8a-55744a5e87d6@quicinc.com>

On Fri, Sep 27, 2024 at 09:26:51AM +0530, Krishna Chaitanya Chundru wrote:
> Hi Bjorn,
> 
> when you get time can you look into this.
> if there are no further concerns I will respin this patch.
> 

Please do not top post.

FWIW, suggestions from Rafael makes sense to me. Thanks Rafael!

- Mani

> - Krishna Chaitanya.
> 
> On 9/12/2024 9:00 PM, Rafael J. Wysocki wrote:
> > On Thu, Sep 12, 2024 at 2:13 PM Krishna Chaitanya Chundru
> > <quic_krichai@quicinc.com> wrote:
> > > 
> > > 
> > > 
> > > On 9/12/2024 5:27 PM, Rafael J. Wysocki wrote:
> > > > On Thu, Sep 12, 2024 at 1:52 PM Krishna Chaitanya Chundru
> > > > <quic_krichai@quicinc.com> wrote:
> > > > > 
> > > > > 
> > > > > 
> > > > > On 9/12/2024 5:12 PM, Rafael J. Wysocki wrote:
> > > > > > On Fri, Aug 16, 2024 at 10:45 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > 
> > > > > > > [+cc Rafael, Mayank, Markus (when people have commented on previous
> > > > > > > versions, please cc them on new versions).  I'm still hoping Rafael
> > > > > > > will have a chance to chime in]
> > > > > > > 
> > > > > > > On Mon, Jul 08, 2024 at 10:19:40AM +0530, Krishna chaitanya chundru wrote:
> > > > > > > > The Controller driver is the parent device of the PCIe host bridge,
> > > > > > > > PCI-PCI bridge and PCIe endpoint as shown below.
> > > > > > > > 
> > > > > > > >            PCIe controller(Top level parent & parent of host bridge)
> > > > > > > >                            |
> > > > > > > >                            v
> > > > > > > >            PCIe Host bridge(Parent of PCI-PCI bridge)
> > > > > > > >                            |
> > > > > > > >                            v
> > > > > > > >            PCI-PCI bridge(Parent of endpoint driver)
> > > > > > > >                            |
> > > > > > > >                            v
> > > > > > > >                    PCIe endpoint driver
> > > > > > > > 
> > > > > > > > Now, when the controller device goes to runtime suspend, PM framework
> > > > > > > > will check the runtime PM state of the child device (host bridge) and
> > > > > > > > will find it to be disabled.
> > > > > > > 
> > > > > > > I guess "will find it to be disabled"  means the child (host bridge)
> > > > > > > has runtime PM disabled, not that the child device is disabled, right?
> > > > > > > 
> > > > > > > > So it will allow the parent (controller
> > > > > > > > device) to go to runtime suspend. Only if the child device's state was
> > > > > > > > 'active' it will prevent the parent to get suspended.
> > > > > > > 
> > > > > > > Can we include a hint like the name of the function where the PM
> > > > > > > framework decides this?  Maybe this is rpm_check_suspend_allowed()?
> > > > > > > 
> > > > > > > rpm_check_suspend_allowed()  checks ".ignore_children", which sounds
> > > > > > > like it could be related, and AFAICS .ignore_children == false here,
> > > > > > > so .child_count should be relevant.
> > > > > > > 
> > > > > > > But I'm still confused about why we can runtime suspend a bridge that
> > > > > > > leads to devices that are not suspended.
> > > > > > 
> > > > > > That should only be possible if runtime PM is disabled for those devices.
> > > > > > 
> > > > > > > > Since runtime PM is disabled for host bridge, the state of the child
> > > > > > > > devices under the host bridge is not taken into account by PM framework
> > > > > > > > for the top level parent, PCIe controller. So PM framework, allows
> > > > > > > > the controller driver to enter runtime PM irrespective of the state
> > > > > > > > of the devices under the host bridge. And this causes the topology
> > > > > > > > breakage and also possible PM issues like controller driver goes to
> > > > > > > > runtime suspend while endpoint driver is doing some transfers.
> > > > > > 
> > > > > > Why is it a good idea to enable runtime PM for a PCIe controller?
> > > > > > 
> > > > > PCIe controller can do certain actions like keeping low power state,
> > > > > remove bandwidth votes etc as part of runtime suspend as when we know
> > > > > the client drivers already runtime suspended.
> > > > 
> > > > Surely they can, but enabling runtime PM for devices that have
> > > > children with runtime PM disabled and where those children have
> > > > children with runtime PM enabled is a bug.
> > > > 
> > > we are trying to enable the runtime PM of host bridge here, so that we
> > > can enable runtime PM of the controller.
> > 
> > So this is a preliminary step.  That was unclear to me.
> > 
> > > If this change got accepted the child here(host bridge) runtime pm will
> > > be enabled then i think there will no issue in enabling the runtime pm
> > > of the controller then.
> > > > > > > What does "topology breakage" mean?  Do you mean something other than
> > > > > > > the fact that an endpoint DMA might fail if the controller is
> > > > > > > suspended?
> > > > > > > 
> > > > > > > > So enable runtime PM for the host bridge, so that controller driver
> > > > > > > > goes to suspend only when all child devices goes to runtime suspend.
> > > > > > 
> > > > > > This by itself makes sense to me.
> > > > > > 
> > > > > > > IIUC, the one-sentence description here is that previously, the PCI
> > > > > > > host controller could be runtime suspended even while an endpoint was
> > > > > > > active, which caused DMA failures.  And this patch changes that so the
> > > > > > > host controller is only runtime suspended after the entire hierarchy
> > > > > > > below it is runtime suspended?  Is that right?
> > > > > > > 
> > > > > > > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > > > > > ---
> > > > > > > > Changes in v4:
> > > > > > > 
> > > > > > > (Note: v4 applies cleanly to v6.10-rc1 and to v6.11-rc1 with a small
> > > > > > > offset).
> > > > > > > 
> > > > > > > > - Changed pm_runtime_enable() to devm_pm_runtime_enable() (suggested by mayank)
> > > > > > > > - Link to v3: https://lore.kernel.org/lkml/20240609-runtime_pm-v3-1-3d0460b49d60@quicinc.com/
> > > > > > > > Changes in v3:
> > > > > > > > - Moved the runtime API call's from the dwc driver to PCI framework
> > > > > > > >      as it is applicable for all (suggested by mani)
> > > > > > > > - Updated the commit message.
> > > > > > > > - Link to v2: https://lore.kernel.org/all/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com
> > > > > > > > Changes in v2:
> > > > > > > > - Updated commit message as suggested by mani.
> > > > > > > > - Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com
> > > > > > > > ---
> > > > > > > > 
> > > > > > > > ---
> > > > > > > >     drivers/pci/probe.c | 4 ++++
> > > > > > > >     1 file changed, 4 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > > > > > > index 8e696e547565..fd49563a44d9 100644
> > > > > > > > --- a/drivers/pci/probe.c
> > > > > > > > +++ b/drivers/pci/probe.c
> > > > > > > > @@ -3096,6 +3096,10 @@ int pci_host_probe(struct pci_host_bridge *bridge)
> > > > > > > >          }
> > > > > > > > 
> > > > > > > >          pci_bus_add_devices(bus);
> > > > > > > > +
> > > > > > > > +     pm_runtime_set_active(&bridge->dev);
> > > > > > > > +     devm_pm_runtime_enable(&bridge->dev);
> > > > > > > > +
> > > > > > > >          return 0;
> > > > > > > >     }
> > > > > > > >     EXPORT_SYMBOL_GPL(pci_host_probe);
> > > > > > 
> > > > > > This will effectively prevent the host bridge from being
> > > > > > runtime-suspended at all IIUC, so the PCIe controller will never
> > > > > > suspend too after this change.
> > > > > > 
> > > > > No we are having a different observations here.
> > > > > Without this change the PCIe controller driver can go to runtime suspend
> > > > > without considering the state of the client drivers i.e even when the
> > > > > client drivers are active.
> > > > > After adding this change we see the pcie controller is getting runtime
> > > > > suspended only after the client drivers are runtime suspended which is
> > > > > the expected behaviour.
> > > > 
> > > > OK, but then when and how is it going to be resumed?
> > > 
> > > sorry I am not expert of the pm framework here, what we observed is when
> > > client drivers are trying to resume using runtime_get we see the
> > > controller driver is also getting resume properly with this change.
> > > let me dig in and see in code on how this is happening.
> > > 
> > > Bjorn has this view on this change in previous v2 version[1]
> > > "My expectation is that adding new functionality should only require
> > > changes in drivers that want to take advantage of it.  For example, if
> > > we add runtime PM support in the controller driver, the result should
> > > be functionally correct even if we don't update drivers for downstream
> > > devices.
> > > 
> > > If that's not the way it works, I suggest that would be a problem in
> > > the PM framework.
> > 
> > You can say so, but that's how it goes.
> > 
> > If there are any devices with runtime PM disabled in a dependency
> > chain, the runtime PM framework cannot follow that chain as a whole.
> > If enabling runtime PM for a device leads to this situation, it is not
> > correct.
> > 
> > > The host bridge might be a special case because we don't have a
> > > separate "host bridge" driver; that code is kind of integrated with
> > > the controller drivers.  So maybe it's OK to do controller + host
> > > bridge runtime PM support at the same time, as long as any time we add
> > > runtime PM to a controller, we sure it's also set up for the host
> > > bridge"
> > 
> > I think that you can enable runtime PM for host bridge devices in
> > general, as long as they don't need to be resumed without resuming any
> > of their children.
> > 
> > If that's the case, resuming one of its children will also cause the
> > host bridge to resume and all should be fine, although you also need
> > to ensure that system-wide suspend handling is in agreement with this.
> > 
> > I would suggest calling pm_runtime_no_callbacks() for the host bridge device.
> > 
> > > [1] https://lore.kernel.org/all/20240307215505.GA632869@bhelgaas/
> > 
> > And this is the information to put into your patch changelog:
> > 
> > 1. It is a property of the runtime PM framework that it can only
> > follow continuous dependency chains.  That is, if there is a device
> > with runtime PM disabled in a dependency chain, runtime PM cannot be
> > enabled for devices below it and above it in that chain both at the
> > same time.
> > 
> > 2. Because of the above, in order to enable runtime PM for a PCIe
> > controller device, one needs to ensure that runtime PM is enabled for
> > all devices in every dependency chain between it and any PCIe endpoint
> > (as runtime PM is enabled for PCIe endpoints).
> > 
> > 3. This means that runtime PM needs to be enabled for the host bridge
> > device, which is present in all of these dependency chains.
> > 
> > 4. After this change, the host bridge device will be runtime-suspended
> > by the runtime PM framework automatically after suspending its last
> > child and it will be runtime-resumed automatically before resuming its
> > first child which will allow the runtime PM framework to track
> > dependencies between the host bridge device and all of its
> > descendants.
> > 
> > Thanks!

-- 
மணிவண்ணன் சதாசிவம்

