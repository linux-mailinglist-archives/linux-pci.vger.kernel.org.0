Return-Path: <linux-pci+bounces-15811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FA09B981C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 20:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECAF51C215F5
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 19:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28F51CEE84;
	Fri,  1 Nov 2024 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU8hfjwF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967691714B9;
	Fri,  1 Nov 2024 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488297; cv=none; b=QrL/ji0Q9+w8I0h1w5x1NnJME5AcHiIuYozDlKZOtXmg9OFdoG04/QfivFf+fqbjMvnGWSkRYqgohpRbhYEwWzBMRXjN8Ahlp1psl4TUSyxq3pkN9EdquwyKzhDkPwNBOSoFTYBu61srAzo/D97nIvurKSUGlA2SQfz1RfspI8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488297; c=relaxed/simple;
	bh=TWZJyK0Ek2KvWFRrKuJFykXEux8Sb3PqWidP0jJDkpk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clww4RkvL6X9Nk0AKllbMeVH6U2hULTm7iAful2Je7ycpztjhXqZ3ev6dklxgVteSXiySucuLytMksfxO/jCU/aVW993Y7PkawpD/TO+n2klG9GnDZoLSVHKzba7bgpx8yofib4GNYvnNQolDEcfPDM259e9KorC7kHBYh8fnmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TU8hfjwF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7203c431f93so2016589b3a.1;
        Fri, 01 Nov 2024 12:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730488294; x=1731093094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tyksEX9VffcEy3DQu/M2+BkUSCcB/8+fwI1TdK4zwzc=;
        b=TU8hfjwFrnIG1PpeX4iEm6SmHfnAhgvy8/etxFCow59X35MSX0nPjn5kOE0XK6FltY
         QGWreSJhX7skJ5zpVhlKbwg72CeLTf31fieiUU4hUvJJHV9V9Tq5hOZI6LwjBi6HvmWn
         v9NZJ2K9ZJdffi1oM9cj1XXeLtK2ricGDn8lB1WZgFNvNQLIG53oCB/C2INudvVue+p7
         ZNwP7DJYzWrC+Yo2zmQj2G59ey5rNS/A8O4a+Tdfa+9fsAC6rNPMxVSCjg17v/1lhKrW
         +9jUzls3Eb0iiQ9U1Qsu6TCey+OyUMZgmO4pvstEzmVXEGjPFu5cLh/Xcz89BQbleokl
         ln1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730488294; x=1731093094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyksEX9VffcEy3DQu/M2+BkUSCcB/8+fwI1TdK4zwzc=;
        b=GBtf+Fh7lWHveq3Vay7KJEKV2zPcpsTp/tB6/W3C2uHbdjZwATBhX7R05PUlbUlm9H
         cYWdNW25ENQAnUAAZaneM2gNnF7PmqcZ4XiMhFvaJvqz8SJTmmQzwjwwKw79uc52ZClA
         +0colwvLYGJMKYOQZLXiojhNry+0BZhfDDVCbi35+pP7ITgn7CXUHkn+lBU+44PJWx9X
         QjEpAwc62aAtRYFP70+3EXxek/EyuItte+rEopoxt1wIujHN87K5/xwlR2+BwbWkGmVu
         ayLQgUzcLndIfjrlwe1H586gbWFg/c7tBDriZbGhnTXHGrM8av2sYr9J8ZLpOIbXABs0
         Iqtw==
X-Forwarded-Encrypted: i=1; AJvYcCU3Sv6l5rlox6+9zxwvenz1FgGAbuFI6GxxB+pwcOksxEcLTdstez2U0ULXI9qzyIjpQTdC2n6N0zzS@vger.kernel.org, AJvYcCVVlx3fSSAKh43F5m9asGj/PMJeBsa1tT2x9gYgAtGADbM99HbZivrsvqX6/6ag1x4wF5ZvBOj1qh/sS6Ch@vger.kernel.org, AJvYcCVi97odjA4g//7YT39nbBtXQNBK8/B797eKjusrvPvDmsIQcoW43wyXnOdM2VEjHZDOzB1ezgziP5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFcRZaOnnG/ZYlZm0D2iCIzEe3NBA1EhdKeuM/psGrVe8fkajj
	j3MW0ZoUM9+sp+TBr1xqJz2NVCm/X9IvLVRx55bO+SUlILQbAj0DkXFuWTYl
X-Google-Smtp-Source: AGHT+IF2Jw8OxZ2zGOUwuHFV+DLMSyz9lFbOaUyC9chy21VF6WLQmVeue9ye39DlMb0K73a5C3cohA==
X-Received: by 2002:a05:6a21:478a:b0:1d9:792d:eda9 with SMTP id adf61e73a8af0-1db91e68229mr9682566637.37.1730488293671;
        Fri, 01 Nov 2024 12:11:33 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:eba7:38e1:4f3b:331c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452a809fsm2775124a12.26.2024.11.01.12.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 12:11:33 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 1 Nov 2024 12:11:19 -0700
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: Fan Ni <nifan.cxl@gmail.com>, ming4.li@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 0/14] Enable CXL PCIe port protocol error handling and
 logging
Message-ID: <ZyUn18bgi-QL0aCi@fan>
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <ZyUXLpQBBgTl733z@fan>
 <8a73bfa1-b916-4f0a-92be-0cb677e1e334@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a73bfa1-b916-4f0a-92be-0cb677e1e334@amd.com>

On Fri, Nov 01, 2024 at 01:28:12PM -0500, Bowman, Terry wrote:
> Hi Fan,
> 
> I added comments below.
> 
> On 11/1/2024 1:00 PM, Fan Ni wrote:
> > On Fri, Oct 25, 2024 at 04:02:51PM -0500, Terry Bowman wrote:
> >> This is a continuation of the CXL port error handling RFC from earlier.[1]
> >> The RFC resulted in the decision to add CXL PCIe port error handling to
> >> the existing RCH downstream port handling in the AER service driver. This
> >> patchset adds the CXL PCIe port protocol error handling and logging.
> >>
> >> The first 7 patches update the existing AER service driver to support CXL
> >> PCIe port protocol error handling and reporting. This includes AER service
> >> driver changes for adding correctable and uncorrectable error support, CXL
> >> specific recovery handling, and addition of CXL driver callback handlers.
> >>
> >> The following 7 patches address CXL driver support for CXL PCIe port
> >> protocol errors. This includes the following changes to the CXL drivers:
> >> mapping CXL port and downstream port RAS registers, interface updates for
> >> common restricted CXL host mode (RCH) and virtual hierarchy mode (VH),
> >> adding port specific error handlers, and protocol error logging.
> >>
> >> [1] - https://lore.kernel.org/linux-cxl/20240617200411.1426554-1-terry.bowman@amd.com/
> >>
> >> Testing:
> > Hi Terry,
> > I tried to test the patchset with aer_inject tool (with the patch you shared
> > in the last version), and hit some issues.
> > Could you help check and give some insights? Thanks.
> >
> > Below are some test setup info and results.
> >
> > I tested two topology,
> >   a. one memdev directly attaced to a HB with only one RP;
> >   b. a topology with cxl switch:
> >          HB
> >         /  \
> >       RP0   RP1
> >        |
> >      switch
> >        |
> >  ----------------
> >  |    |    |    |
> > mem0 mem1 mem2 mem3
> >
> > For both topologies, I cannot reproduce the system panic shown in your cover
> > letter.  
> >
> > btw, I tried both compile cxl as modules and in the kernel.
> >
> > Below, I will use the direct-attached topology (a) as an example to show what I
> > tried, hope can get some clarity about the test and what I missed or did wrong.
> >
> > -------------------------------------
> > pci device info on the test VM 
> > root@fan:~# lspci
> > 00:00.0 Host bridge: Intel Corporation 82G33/G31/P35/P31 Express DRAM Controller
> > 00:01.0 VGA compatible controller: Device 1234:1111 (rev 02)
> > 00:02.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 03)
> > 00:03.0 Unclassified device [0002]: Red Hat, Inc. Virtio filesystem
> > 00:04.0 Unclassified device [0002]: Red Hat, Inc. Virtio filesystem
> > 00:05.0 Host bridge: Red Hat, Inc. QEMU PCIe Expander bridge
> > 00:1f.0 ISA bridge: Intel Corporation 82801IB (ICH9) LPC Interface Controller (rev 02)
> > 00:1f.2 SATA controller: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 port SATA Controller [AHCI mode] (rev 02)
> > 00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 02)
> > 0c:00.0 PCI bridge: Intel Corporation Device 7075
> > 0d:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
> > root@fan:~# 
> > -------------------------------------
> >
> > The aer injection input file looks like below,
> >
> > -------------------------------------
> > fan:~/cxl/cxl-test-tool$ cat /tmp/internal 
> > AER
> > PCI_ID 0000:0c:00.0
> > UNCOR_STATUS INTERNAL
> > HEADER_LOG 0 1 2 3
> > ------------------------------------
> >
> > dmesg after aer injection 
> >
> > ssh root@localhost -p 2024 "dmesg"
> > [  613.195352] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
> > [  613.195830] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
> > [  613.196253] pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
> > [  613.198199] pcieport 0000:0c:00.0: AER: No uncorrectable error found. Continuing.
> > -----------------------------------
> 
> This is likely because the device's CXL RAS status is not set and as a result returns false and bypasses the panic.
> Unfortunately, the aer-inject only sets the AER status and triggers the interrupt. The CXL RAS is not set.
> 
> I attached 2 'test' patches. The first patch sets the device's RAS status to simulate the error reporting.
> This will have to be adjusted as the patch looks for a specific device's bus and this will likely be a different
> bus then the device's you test in your setup.
> 
> The 2nd patch enables UIE/CIE. I moved this out of the v2 patchset. I need to revisit this to see if it is
> needed in the patchset itself (not just a test patch).
> 
> Regards,
> Terry

Hi Terry,

Thanks for the quick reply. With the two patches applied, the system
panic as expected. 

Thanks,
Fan

> 
> >
> > The problem seems to be related to the cxl_error_handler not been assigned for
> > cxlmem device. 
> >
> > in
> > cxl_do_recover() {
> > ...
> >     327     cxl_walk_bridge(bridge, cxl_report_error_detected, &status);                         
> >     328     if (status)                                                                 
> >     329         panic("CXL cachemem error. Invoking panic");                   
> > ...
> > }
> > The status returned is false, so no panic().
> >
> > I tried to add some dev_dbg info to the code to debug.
> > Below are the debug info and kernel code changes for debugging. 
> > --------------------------------------
> > fan:~/cxl/cxl-test-tool$ cxl-tool.py --cmd dmesg | grep XXX
> > [    1.738909] cxl_mem:cxl_mem_probe:205: cxl_mem mem0: XXX: add endpoint
> > [    1.739188] cxl_mem:devm_cxl_add_endpoint:85: cxl_port port1: XXX: add endpoint
> > [    1.739509] cxl_mem:devm_cxl_add_endpoint:92: cxl_mem mem0: XXX: init ep port aer
> > [    1.739876] cxl_core:cxl_dport_init_ras_reporting:907: pcieport 0000:0c:00.0: XXX: assign port error handlers for dport 1
> > [    1.740338] cxl_core:cxl_dport_init_ras_reporting:913: pcieport 0000:0c:00.0: XXX: assign port error handlers for dport 2
> > [    1.740812] cxl_core:cxl_dport_init_ras_reporting:927: pcieport 0000:0c:00.0: XXX: assign port error handlers for dport 3
> > [    1.741273] cxl_core:cxl_assign_port_error_handlers:851: pcieport 0000:0c:00.0: XXX: cxl_err_handler: (____ptrval____)
> > [    1.741812] cxl_core:cxl_assign_port_error_handlers:855: pcieport 0000:0c:00.0: XXX: cxl_err_handler: (____ptrval____)
> > [    1.742263] cxl_core:cxl_assign_port_error_handlers:857: pcieport 0000:0c:00.0: XXX: cxl_err_handler: (____ptrval____) (____ptrval____)
> > fan:~/cxl/cxl-test-tool$ 
> > --------------------------------------
> >
> > dmesg after error injection:
> > --------------------------------------
> > ssh root@localhost -p 2024 "dmesg"
> > [  228.544439] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
> > [  228.544977] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
> > [  228.545381] pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
> > [  228.545879] pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/00000000
> > [  228.546360] pcieport 0000:0c:00.0:    [22] UncorrIntErr          
> > [  228.546698] pcieport 0000:0c:00.0: AER: XXX: call cxl_err_handler: 00000000a268bfcb 000000009e0da039
> > [  228.547103] cxl_pci 0000:0d:00.0: AER: XXX: call cxl_err_handler: 00000000b9f08b93 0000000000000000
> > [  228.547515] pcieport 0000:0c:00.0: AER: No uncorrectable error found. Continuing.
> > fan:~/cxl/cxl-test-tool$ 
> > --------------------------------------
> >
> >
> > Kernel changes:
> > --------------------------------------
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 5f7570c6173c..bcecd1283fc6 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -848,10 +848,13 @@ static void cxl_assign_port_error_handlers(struct pci_dev *pdev)
> >  {
> >  	struct pci_driver *pdrv = pdev->driver;
> >  
> > +    dev_dbg(&pdev->dev, "XXX: cxl_err_handler: %p\n enter", pdev);
> >  	if (!pdrv)
> >  		return;
> >  
> > +    dev_dbg(&pdev->dev, "XXX: cxl_err_handler: %p\n", pdrv);
> >  	pdrv->cxl_err_handler = &cxl_port_error_handlers;
> > +    dev_dbg(&pdev->dev, "XXX: cxl_err_handler: %p %p\n", pdrv, pdrv->cxl_err_handler);
> >  }
> >  
> >  static void cxl_clear_port_error_handlers(void *data)
> > @@ -869,12 +872,14 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
> >  {
> >  	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
> >  
> > +    dev_dbg(&port->dev, "XXX: assign port error handlers for uport 1\n");
> >  	/* uport may have more than 1 downstream EP. Check if already mapped. */
> >  	if (port->uport_regs.ras) {
> >  		dev_warn(&port->dev, "RAS is already mapped\n");
> >  		return;
> >  	}
> >  
> > +    dev_dbg(&port->dev, "XXX: assign port error handlers for uport 2\n");
> >  	port->reg_map.host = &port->dev;
> >  	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
> >  				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
> > @@ -882,6 +887,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
> >  		return;
> >  	}
> >  
> > +    dev_dbg(&port->dev, "XXX: assign port error handlers for uport 3\n");
> >  	cxl_assign_port_error_handlers(pdev);
> >  	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);
> >  }
> > @@ -898,11 +904,13 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
> >  	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
> >  	struct pci_dev *pdev = to_pci_dev(dport_dev);
> >  
> > +    dev_dbg(dport_dev, "XXX: assign port error handlers for dport 1\n");
> >  	if (dport->rch && host_bridge->native_aer) {
> >  		cxl_dport_map_rch_aer(dport);
> >  		cxl_disable_rch_root_ints(dport);
> >  	}
> >  
> > +    dev_dbg(dport_dev, "XXX: assign port error handlers for dport 2\n");
> >  	/* dport may have more than 1 downstream EP. Check if already mapped. */
> >  	if (dport->regs.ras) {
> >  		dev_warn(dport_dev, "RAS is already mapped\n");
> > @@ -916,6 +924,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
> >  		return;
> >  	}
> >  
> > +    dev_dbg(dport_dev, "XXX: assign port error handlers for dport 3\n");
> >  	cxl_assign_port_error_handlers(pdev);
> >  	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);
> >  }
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 067fd6389562..aa824584f8dd 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -82,13 +82,15 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
> >  	 * Now that the path to the root is established record all the
> >  	 * intervening ports in the chain.
> >  	 */
> > +    dev_dbg(host, "XXX: add endpoint\n");
> >  	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
> >  	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
> >  		struct cxl_ep *ep;
> >  
> >  		ep = cxl_ep_load(iter, cxlmd);
> >  		ep->next = down;
> > -		cxl_init_ep_ports_aer(ep);
> > +        dev_dbg(ep->ep, "XXX: init ep port aer\n");
> > +        cxl_init_ep_ports_aer(ep);
> >  	}
> >  
> >  	/* Note: endpoint port component registers are derived from @cxlds */
> > @@ -200,6 +202,7 @@ static int cxl_mem_probe(struct device *dev)
> >  			return -ENXIO;
> >  		}
> >  
> > +        dev_dbg(dev, "XXX: add endpoint\n");
> >  		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
> >  		if (rc)
> >  			return rc;
> > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > index 3785f4ca5103..8285f14994e8 100644
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -294,6 +294,11 @@ static int cxl_report_error_detected(struct pci_dev *dev, void *data)
> >  	bool *status = data;
> >  
> >  	device_lock(&dev->dev);
> > +    if (pdrv) {
> > +        dev_dbg(&dev->dev, "XXX: call cxl_err_handler: %p %p\n", pdrv, pdrv->cxl_err_handler);
> > +    } else {
> > +        dev_dbg(&dev->dev, "XXX: call cxl_err_handler: %p no handler\n", pdrv);
> > +    }
> >  	if (pdrv && pdrv->cxl_err_handler &&
> >  	    pdrv->cxl_err_handler->error_detected) {
> >  		const struct cxl_error_handlers *cxl_err_handler =
> > --------------------------------------
> >
> > Fan
> >> Below are test results for this patchset using Qemu with CXL root
> >> port(0c:00.0), CXL upstream switchport(0d:00.0), CXL downstream
> >> switchport(0e:00.0). A CXL endpoint(0f:00.0) CE and UCE logs are
> >> also added to show the existing PCIe endpoint handling is not changed.
> >>
> >> This was tested using aer-inject updated to support CE and UCE internal
> >> error injection. CXL RAS was set using a test patch (not upstreamed but can
> >> provide if needed).
> >>
> >>  - Root port UCE:
> >>  root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
> >>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
> >>  pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
> >>  pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
> >>  pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
> >>  pcieport 0000:0c:00.0:    [22] UncorrIntErr
> >>  aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
> >>  cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
> >>  Kernel panic - not syncing: CXL cachemem error. Invoking panic
> >>  CPU: 1 UID: 0 PID: 146 Comm: irq/24-aerdrv Tainted: G            E      6.12.0-rc2-cxl-port-err-g2beab06a67d1 #4414
> >>  Tainted: [E]=UNSIGNED_MODULE
> >>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> >>  Call Trace:
> >>   <TASK>
> >>   dump_stack_lvl+0x27/0x90
> >>   dump_stack+0x10/0x20
> >>   panic+0x33e/0x380
> >>   cxl_do_recovery+0x116/0x120
> >>   ? srso_return_thunk+0x5/0x5f
> >>   aer_isr+0x3e0/0x710
> >>   irq_thread_fn+0x28/0x70
> >>   irq_thread+0x179/0x240
> >>   ? srso_return_thunk+0x5/0x5f
> >>   ? __pfx_irq_thread_fn+0x10/0x10
> >>   ? __pfx_irq_thread_dtor+0x10/0x10
> >>   ? __pfx_irq_thread+0x10/0x10
> >>   kthread+0xf5/0x130
> >>   ? __pfx_kthread+0x10/0x10
> >>   ret_from_fork+0x3c/0x60
> >>   ? __pfx_kthread+0x10/0x10
> >>   ret_from_fork_asm+0x1a/0x30
> >>   </TASK>
> >>  Kernel Offset: 0x29000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> >>  ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---
> > ...



-- 
Fan Ni

