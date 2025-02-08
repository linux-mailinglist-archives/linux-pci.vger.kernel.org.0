Return-Path: <linux-pci+bounces-21016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E39A2D597
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 11:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6764F3AADFA
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 10:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A291B3930;
	Sat,  8 Feb 2025 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVqKCau5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CFD1A8F71
	for <linux-pci@vger.kernel.org>; Sat,  8 Feb 2025 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739010987; cv=none; b=lFjL+07Gp6XBLVD86qn7pPTVuM5+n3/FTiq+eNB791nf+04S3auSPu5y3b8l3OxJAY7X23pzc/3nfoZF5kB8ngM2ExGRLVV9/M/Ad8lSxX1HOXUYYOzvkGHuWXV2iVpKTQ71iKK3vANfHvK6p30mDyJYNYZ6O+mtQOnDGs+Ix3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739010987; c=relaxed/simple;
	bh=SW5UhacMkzZWCSkVTvHO3TFBny3T2LZZG3994FQBevE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hj0X103PckhW+uMD4KU5o8k5x4JIteKSdTD8pfZjd15IzEraSvkzysYf4OARlrgDt8bVilVQcJbYCQIDnyonR2L/5k6Plu5QslcnGQtv/nEDz6BP/tO9hDSPQSfwoDZg5sAFmhozdX0ZfkGi+S+Fqgq8GUXC/FM0YS7E6qp/dN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nVqKCau5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f62cc4088so15876015ad.3
        for <linux-pci@vger.kernel.org>; Sat, 08 Feb 2025 02:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739010984; x=1739615784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BoaAnmRJfikjMJJ5mT1KSvwU4+ZQgSKozzj6VL4ELUQ=;
        b=nVqKCau5qY104+K3c/bjRqgBH78/pgL8bdTs3QOVFHbx5nZ2wFxDXK0KlA64lql/Ir
         0L22Cf0zKnjXQFAR8bD7dG28KBB2s+U2cQOa84NHXoOAXMtynnXP42wJPkgCMibyELhu
         kfbZCXkHFr305B8X3aQ0pRhf/BEOyDvuuAymGo0qCsSIyYYdB7LV0MBHZALe6GgkQNmw
         Z0Z2ZKttxibL4wyBx5kj0gj7rP7TwEwt3pzLSLXnP9XuhMoySvNLoIIHBKnR8BeXpYBC
         AOFWdgJUBMa1RoTaPkjNmkqZl1Dixii9XBta/aAJeHdHhLS5FhbpJY9/jqTS4QL+eDb0
         A7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739010984; x=1739615784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BoaAnmRJfikjMJJ5mT1KSvwU4+ZQgSKozzj6VL4ELUQ=;
        b=Rn+CZs0vaoElx0CGmTGoHjpcBADSHY1T6NNxlVDo9d9ppacNpsY/Tz58M1jBdLFgWI
         ErO0o+hIpA5RUqujyTRZ1EWI0QALkJcironJRGnhsXxBADcFcACHVpvmGZifiHoKh3sl
         lCn67bbLSzOKGG4TwqErH8okryT/xkKb+fyT0q2Jgz6sU8jXUzxIPjBy4+RnNXwjynbb
         +fwjS0F9fzzWRQsg4J6j2+AmAZh5sqFVqHXi90KO/IbPuXt17kqsrZlMTI65cShDx4JV
         Qx9gFBGtZXa0fe7GhSElvElvO+Y/EgBqQpQ++n13aPHZ3hPvYTsmWNb3lbvrnSqAfL2J
         BjPA==
X-Forwarded-Encrypted: i=1; AJvYcCXQxPztcclpom0v2o096nmCVP5YOFzmC87rnwNtm203otBvrazC/9yH8Qtg4ZOpNaRNhxDQLcuPXgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoJ+UYyVX0EiULK5UdEGgKdRmFpMHWA8FWeXschCmyV1o7QrpC
	1ziZov4LyiAa2x0/IMxBzsm9HKzb8twJHi3A0IPhfUubvkU1LTAO0B3A/ww3bA==
X-Gm-Gg: ASbGncv/9D5I1YGgSTfbc5bx3/WUf0U9mWElKyn+4hNg2A5OcWMDyexR/qvtmTHWilS
	IZU2TOXm9Zu7YaNeuuHdSQyxdx6TMqk5os0irUorZkU//vIqlPZf/A1uhxPgx5bgoRu9hKK67I0
	44yqRLoGnWdAfNHiGz5U2SjRX2BCm3cWlE3FRNUqRwgcoJ1QhEBZzXxopqrLCHRYXhKeXG5zih5
	iSvP1cNAmas1TVYJIw6xZWqlEcLOd1JxFI5r/h1Uxd6iMmTEfJhlvrnrQgUf3me6YX78oKZwrCZ
	S4UnveKl9fOMoVG/awSygLv5
X-Google-Smtp-Source: AGHT+IE9RgAXmno9t4rWIPgdel/xLwnILZhf5pQ1KhWjVCU87NJl/bhU5fdwOYmDPaXFBy/uv0e86Q==
X-Received: by 2002:a17:903:2309:b0:215:6b4c:89fa with SMTP id d9443c01a7336-21f4e1ced38mr93272025ad.8.1739010984539;
        Sat, 08 Feb 2025 02:36:24 -0800 (PST)
Received: from thinkpad ([120.60.69.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d8ffsm44251845ad.150.2025.02.08.02.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 02:36:24 -0800 (PST)
Date: Sat, 8 Feb 2025 16:06:18 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Wilson Ding <dingwei@marvell.com>
Cc: "cassel@kernel.org" <cassel@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanghoon Lee <salee@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH 1/1] PCI: armada8k: Add link-down handle
Message-ID: <20250208103618.2binrjgry7ghoavc@thinkpad>
References: <20241112213255.GA1861331@bhelgaas>
 <AD287CCE-9FFE-49BC-B9CA-B5CED4F05AF1@linaro.org>
 <BY3PR18MB46737FB5FDBD75CF31B505B8A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <BY3PR18MB4673207A36B2CD7C3B75EBA0A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <20250207175759.jzmoox5mke3rachy@thinkpad>
 <BY3PR18MB46738F5857319F9637FA5050A7F12@BY3PR18MB4673.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY3PR18MB46738F5857319F9637FA5050A7F12@BY3PR18MB4673.namprd18.prod.outlook.com>

On Fri, Feb 07, 2025 at 06:46:22PM +0000, Wilson Ding wrote:
> 
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: Friday, February 7, 2025 9:58 AM
> > To: Wilson Ding <dingwei@marvell.com>; cassel@kernel.org
> > Cc: Bjorn Helgaas <helgaas@kernel.org>; lpieralisi@kernel.org;
> > thomas.petazzoni@bootlin.com; kw@linux.com; robh@kernel.org;
> > bhelgaas@google.com; linux-pci@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Sanghoon Lee
> > <salee@marvell.com>
> > Subject: [EXTERNAL] Re: [PATCH 1/1] PCI: armada8k: Add link-down handle
> > 
> > + Niklas (who was interested in link down handling) On Sat, Feb 01, 2025
> > + at 11: 05: 56PM +0000, Wilson Ding wrote: > > On November 13, 2024 3: 
> > + 02: 55 AM GMT+05: 30, Bjorn Helgaas > > <mailto: helgaas@ kernel. org>
> > + wrote: > >
> > 
> > + Niklas (who was interested in link down handling)
> > 
> > On Sat, Feb 01, 2025 at 11:05:56PM +0000, Wilson Ding wrote:
> > > > On November 13, 2024 3:02:55 AM GMT+05:30, Bjorn Helgaas
> > > > <mailto:helgaas@kernel.org> wrote:
> > > > >In subject:
> > > > >
> > > > >  PCI: armada8k: Add link-down handling
> > > > >
> > > > >On Mon, Nov 11, 2024 at 10:48:13PM -0800, Jenishkumar Maheshbhai
> > > > Patel wrote:
> > > > >> In PCIE ISR routine caused by RST_LINK_DOWN we schedule work to
> > > > >> handle the link-down procedure.
> > > > >> Link-down procedure will:
> > > > >> 1. Remove PCIe bus
> > > > >> 2. Reset the MAC
> > > > >> 3. Reconfigure link back up
> > > > >> 4. Rescan PCIe bus
> > > > >
> > > > >s/PCIE/PCIe/
> > > > >
> > > > >Rewrap to fill 75 columns.
> > > > >
> > > > >I assume this basically removes a Root Port (and the hierarchy
> > > > >below
> > > > >it) if the link goes down, and then resets the MAC and tries to
> > > > >bring up the link and enumerate the hierarchy again.
> > > > >
> > > > >No other drivers do this, so why does armada8k need it?  Is this to
> > > > >work around some unreliable link?
> > > >
> > > > Certainly Qcom IPs have this same feature and I was also looking to
> > > > implement it. But the link down should not be handled by this in the
> > controller driver.
> > > >
> > > > Instead, it should be tied to bus reset in the core and the reset
> > > > should be done through a callback implemented in the controller
> > > > drivers. This way, the reset cannot happen in the back of PCI core and client
> > drivers.
> > > >
> > > > That said, the Link down IRQ received by this driver should also be
> > > > propagated back to the PCI core and the core should then call the
> > > > callback to reset the bus that I mentioned above.
> > > >
> > >
> > > It's more than a work-around for the unreliable link. A few customers
> > > may have such application - independent power supply to the device
> > > with dedicated reset GPIO to #PRST. In this way, the power cycle and
> > > warm reset of RC and EP won't have impact on each other. However, it
> > > may lead into the PCI driver not aware of the link down when an unexpected
> > power down or reset occurs on the device.
> > > We cannot assume the link will be recovered soon. The worse thing is
> > > the driver may continue access to the device, which may hang the bus.
> > > Since the device is no longer present on the bus, it's better to
> > > remove it. Besides, in order to bring up the link, the only way is to
> > > reset the MAC, which starts over the state machine of LTSSM.
> > >
> > > Well, we also noticed that there is no other driver that did this. I
> > > agree it is not necessary if the power cycle or warm reset of the
> > > device is done gracefully. The user can remove the device prior to the
> > > power cycle/reset.  And do the rescan after the link is recovered. However,
> > the unexpected power down is still possible.
> > > Please enlighten me if there is any better approach to handle such
> > > unexpected link down.
> > >
> > 
> > There is no issue in retraining the link. My concern is that, the retrain should
> > not happen autonomously in the controller driver. PCI core should be made
> > informed of it. More below.
> > 
> 
> Do you mean 
> - pass the link down/up events to PCI core
> - remove the device or hierarchy by PCI core upon link down
> - initiate the link retraining in PCI core by calling the platform retrain callbacks 
> - rescan the bus once link is recovered
> 

Yeah. This is what I came up with quickly:

```
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b6536ed599c3..561eeb464220 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -706,6 +706,33 @@ void pci_free_host_bridge(struct pci_host_bridge *bridge)
 }
 EXPORT_SYMBOL(pci_free_host_bridge);
 
+void pci_host_bridge_handle_link_down(struct pci_host_bridge *bridge)
+{
+       struct pci_bus *bus = bridge->bus;
+       struct pci_dev *child, *tmp;
+       int ret;
+
+       pci_lock_rescan_remove();
+
+       /* Knock the devices off bus since we cannot access them */
+       list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
+               pci_stop_and_remove_bus_device(child);
+
+       /* Now retrain the link in a controller specific way to bring it back */
+       if (bus->ops->retrain_link) {
+               ret = bus->ops->retrain_link(bus);
+               if (ret) {
+                       dev_err(&bridge->dev, "Failed to retrain the link!\n");
+                       pci_unlock_rescan_remove();
+                       return;
+               }
+       }
+
+       pci_rescan_bus(bus);
+       pci_unlock_rescan_remove();
+}
+EXPORT_SYMBOL(pci_host_bridge_handle_link_down);
+
 /* Indexed by PCI_X_SSTATUS_FREQ (secondary bus mode and frequency) */
 static const unsigned char pcix_bus_speed[] = {
        PCI_SPEED_UNKNOWN,              /* 0 */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..1c6f18a51bdd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -637,6 +637,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv);
 struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
                                                   size_t priv);
 void pci_free_host_bridge(struct pci_host_bridge *bridge);
+void pci_host_bridge_handle_link_down(struct pci_host_bridge *bridge);
 struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
@@ -804,6 +805,7 @@ struct pci_ops {
        void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
        int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
        int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+       int (*retrain_link)(struct pci_bus *bus);
 };
 
 /*
```

Your controller driver has to call pci_host_bridge_handle_link_down() during the
link down event (make it threaded if not done already). Then you should also
populate the pci_ops::retrain_link() callback with the function that retrains
the broken link. Finally, the bus will be rescanned to enumerate the devices.

I do have plans to plug this retrain callback to one of the bus_reset()
functions in the future so that we can bring the link back while doing bus level
reset (uncorrectable AERs and such). But this will do the job for now.

I will send a series on Monday with Qcom driver as a reference.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

