Return-Path: <linux-pci+bounces-16004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7786D9BC04C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 22:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9EE1C21E8C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 21:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D3014B94F;
	Mon,  4 Nov 2024 21:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCwJD/gi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C80718EB1;
	Mon,  4 Nov 2024 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730756926; cv=none; b=Qz2tVaq4zamgg8w5BuStCbeP2KaM+S239NOBAmuUS5tWpMh0gnan5jeuzFGlj/azUxEW2UX3vTmfT3dsjk3ywt8vy638g8mYNvJQ/TqjKJsDdTs6PWS+cTM+gyaw9t47ClJdlxGt9Kg+FKF2XD81Jf4cpT0l0ro/bLuDLcsqfZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730756926; c=relaxed/simple;
	bh=+5/qQEyG8+vkBtKNB7IKOxlx47N98ltAycn9m8oKd3o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaUysRt/pF/8GQf7NGyXa9CSflR5uAAyVehBueLBTcvWhoJeei+Ig472K0fIOJVRqXApu/UiCpIIOmB0VzlrWpaAzfGMA2u44R46VTUKf5vLdFBI/JwqDsaxZQJr3o7XvyltG2WYGKz2RaTs5HU4L+wApR76DyvoqY506PyoLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCwJD/gi; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e3c3da5bcdso43678497b3.2;
        Mon, 04 Nov 2024 13:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730756923; x=1731361723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a7qLqFn5A9wDwTX3A2pduAe6E332LTqYCGawBlUF+jw=;
        b=aCwJD/giFtUcSEH57DLbno8SrmkaPqZJampCkIIzQeVlj+s9HP0vOGFmZ6tows2P6C
         h2WpW3RZ+bRz0sHrXPpSym9F3kIOn4VwmboCRQo94yjx0VRMJNhyQSDfT2ZGJod5OO0w
         rbwhCuQwXG/+5536fPGMCuIuOcwT+EUHR5jlTtWdLbhjT3jFmwXeHgFmL5I2+9XoSlLT
         tiWfiSt6ayy4G1+kflTtuZZV2BaW+g2PphjWI3pTTF1wCu7iOK8a85uDF//UfYiLgv5y
         KvXuso8CS1Zq5za2i0jM9wXMP07XTWCmoVnV36xh12GOHSAdzGExwX3UhnchBHojTRHx
         9e8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730756923; x=1731361723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7qLqFn5A9wDwTX3A2pduAe6E332LTqYCGawBlUF+jw=;
        b=GbOOjp90JOO63lheDfL1pIfqiWgof8GkoockrVHCsd4lhS6P8kZnQflkyHkPO4rd50
         794lXWWoPqsuQlQyxvQawveO+OARy8ozr/3zlJVK3zFK23yrtADdaTP7wIedAP8gvpZN
         Xz4eKci2VjWuNiM/wubNxnGMROjtnNu6uBJ4HUpALq+d+mzr90ckthtKDZVRGhDWXcNe
         Cp8CfFZnyuaTJVrklsleD4/FSNG3g2uBNlAsLqNCbUDid3P1nvLn7mN24oFs3n/SFD/Q
         zIxKFNdusrvgg0eGIUB5e4pkHkvbvmUin3vEX6CN2E4Rv7rtX3wdSveATJ33lULTe9R8
         tg/A==
X-Forwarded-Encrypted: i=1; AJvYcCXK7dkWXLlmyO58EYbEPmTc66CmvdFrc57rIVeJeLMVhEID9PB2kv2WZQa9oH9xSD2tY5OHU4rf0JRb@vger.kernel.org, AJvYcCXUXz3DFK3BQ/ZLJFsqDX86Hst1PWp5qNO/D0ufSE0R0Weh2Ygp+x3vkd6bfxJrgL86QYNfKwiFdCUbVY+Y@vger.kernel.org, AJvYcCXqJRAQ/9hl8XA8LYsmqiswinlSh9i1Acfv5fdCtXRGhsYJo4XoX+pNPO+zSnWLQVJHxy3fD+tfKjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvArpyZY0D3k/2SGP725FeXlr2+tQzhI41FIGNPEvKseK6LcwM
	+aYZKNvSvXeswG5kjI8MGxju2ocSuFBnJa0CoAfRiW3Q/q0IBLCV
X-Google-Smtp-Source: AGHT+IFpWCLsXHXLJwteQEPVNqkAsazLNXMpgLj2XYtXenCaYYxJR8i6RkB+QMPvOJ7yKffH5z/MPg==
X-Received: by 2002:a05:690c:1e:b0:6e7:e76e:5852 with SMTP id 00721157ae682-6ea3b96aaa6mr262752107b3.32.1730756923435;
        Mon, 04 Nov 2024 13:48:43 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55c48a52sm19316237b3.102.2024.11.04.13.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:48:43 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 4 Nov 2024 13:48:23 -0800
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
Message-ID: <ZylBJ8mASGFVyDch@fan>
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <ZyUXLpQBBgTl733z@fan>
 <8a73bfa1-b916-4f0a-92be-0cb677e1e334@amd.com>
 <ZyVSAzSW1HEd2_Mp@fan>
 <341e5c63-8f1c-4b53-a6f0-bdd7483f0c93@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <341e5c63-8f1c-4b53-a6f0-bdd7483f0c93@amd.com>

On Mon, Nov 04, 2024 at 03:25:38PM -0600, Bowman, Terry wrote:
> 
> 
> On 11/1/2024 5:11 PM, Fan Ni wrote:
> > On Fri, Nov 01, 2024 at 01:28:12PM -0500, Bowman, Terry wrote:
> >> Hi Fan,
> >>
> >> I added comments below.
> >>
> >> On 11/1/2024 1:00 PM, Fan Ni wrote:
> >>> On Fri, Oct 25, 2024 at 04:02:51PM -0500, Terry Bowman wrote:
> >>>> This is a continuation of the CXL port error handling RFC from earlier.[1]
> >>>> The RFC resulted in the decision to add CXL PCIe port error handling to
> >>>> the existing RCH downstream port handling in the AER service driver. This
> >>>> patchset adds the CXL PCIe port protocol error handling and logging.
> >>>>
> >>>> The first 7 patches update the existing AER service driver to support CXL
> >>>> PCIe port protocol error handling and reporting. This includes AER service
> >>>> driver changes for adding correctable and uncorrectable error support, CXL
> >>>> specific recovery handling, and addition of CXL driver callback handlers.
> >>>>
> >>>> The following 7 patches address CXL driver support for CXL PCIe port
> >>>> protocol errors. This includes the following changes to the CXL drivers:
> >>>> mapping CXL port and downstream port RAS registers, interface updates for
> >>>> common restricted CXL host mode (RCH) and virtual hierarchy mode (VH),
> >>>> adding port specific error handlers, and protocol error logging.
> >>>>
> >>>> [1] - https://lore.kernel.org/linux-cxl/20240617200411.1426554-1-terry.bowman@amd.com/
> >>>>
> >>>> Testing:
> >>> Hi Terry,
> >>> I tried to test the patchset with aer_inject tool (with the patch you shared
> >>> in the last version), and hit some issues.
> >>> Could you help check and give some insights? Thanks.
> >>>
> >>> Below are some test setup info and results.
> >>>
> >>> I tested two topology,
> >>>   a. one memdev directly attaced to a HB with only one RP;
> >>>   b. a topology with cxl switch:
> >>>          HB
> >>>         /  \
> >>>       RP0   RP1
> >>>        |
> >>>      switch
> >>>        |
> >>>  ----------------
> >>>  |    |    |    |
> >>> mem0 mem1 mem2 mem3
> >>>
> >>> For both topologies, I cannot reproduce the system panic shown in your cover
> >>> letter.  
> >>>
> >>> btw, I tried both compile cxl as modules and in the kernel.
> >>>
> >>> Below, I will use the direct-attached topology (a) as an example to show what I
> >>> tried, hope can get some clarity about the test and what I missed or did wrong.
> >>>
> >>> -------------------------------------
> >>> pci device info on the test VM 
> >>> root@fan:~# lspci
> >>> 00:00.0 Host bridge: Intel Corporation 82G33/G31/P35/P31 Express DRAM Controller
> >>> 00:01.0 VGA compatible controller: Device 1234:1111 (rev 02)
> >>> 00:02.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 03)
> >>> 00:03.0 Unclassified device [0002]: Red Hat, Inc. Virtio filesystem
> >>> 00:04.0 Unclassified device [0002]: Red Hat, Inc. Virtio filesystem
> >>> 00:05.0 Host bridge: Red Hat, Inc. QEMU PCIe Expander bridge
> >>> 00:1f.0 ISA bridge: Intel Corporation 82801IB (ICH9) LPC Interface Controller (rev 02)
> >>> 00:1f.2 SATA controller: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 port SATA Controller [AHCI mode] (rev 02)
> >>> 00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 02)
> >>> 0c:00.0 PCI bridge: Intel Corporation Device 7075
> >>> 0d:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
> >>> root@fan:~# 
> >>> -------------------------------------
> >>>
> >>> The aer injection input file looks like below,
> >>>
> >>> -------------------------------------
> >>> fan:~/cxl/cxl-test-tool$ cat /tmp/internal 
> >>> AER
> >>> PCI_ID 0000:0c:00.0
> >>> UNCOR_STATUS INTERNAL
> >>> HEADER_LOG 0 1 2 3
> >>> ------------------------------------
> >>>
> >>> dmesg after aer injection 
> >>>
> >>> ssh root@localhost -p 2024 "dmesg"
> >>> [  613.195352] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
> >>> [  613.195830] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
> >>> [  613.196253] pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
> >>> [  613.198199] pcieport 0000:0c:00.0: AER: No uncorrectable error found. Continuing.
> >>> -----------------------------------
> >> This is likely because the device's CXL RAS status is not set and as a result returns false and bypasses the panic.
> >> Unfortunately, the aer-inject only sets the AER status and triggers the interrupt. The CXL RAS is not set.
> >>
> >> I attached 2 'test' patches. The first patch sets the device's RAS status to simulate the error reporting.
> >> This will have to be adjusted as the patch looks for a specific device's bus and this will likely be a different
> >> bus then the device's you test in your setup.
> >>
> >> The 2nd patch enables UIE/CIE. I moved this out of the v2 patchset. I need to revisit this to see if it is
> >> needed in the patchset itself (not just a test patch).
> >>
> >> Regards,
> >> Terry
> >>
> > Hi Terry, 
> >
> > I checked the two patches you attached, do we really need the first
> > patch to umask internal error? I see it is already unmasked in
> > aer_enable_internal_errors() which is called in aer_probe().
> > I tried to only apply the other patch and test again, it seems the test
> > output is the same as applying two patches. The system panics as well.
> >
> > Fan
> Hi Fan,
> 
> Which device did you inject into? RP, DSP, or USP?
> 
> Yes, the RP UIE & CIE are enabled by the AER driver. RCEC too. But, this is not done for CXL DSP
> and USP. Below are details from the spec describing how an AER error masked at the source will not
> be propagated as notification to the root complex (RP or RCEC).
> 
> 'If an individual error is masked when it is detected, its error status bit is still affected,
> but no error reporting Message is sent to the Root Complex, and the error is not recorded in the
> Header Log, TLP Prefix Log, or First Error Pointer.'[1]
> 
> [1] PCIe Spec 6.2.3.2.2 Masking Individual Errors
> 
> Also, there can be platform BIOS settings that enable/disable UIE/CIE.
> 
> Regards,
> Terry
Oh, I see. I did inject into rp in my previous setup. And confirmed we
need extra unmask for downstream port case. 

Thanks for the info.

Fan
> 

-- 
Fan Ni

