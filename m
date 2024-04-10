Return-Path: <linux-pci+bounces-6075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5458A0093
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 21:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F8A286029
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 19:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0B0181313;
	Wed, 10 Apr 2024 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4KcJiaC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CC317F370;
	Wed, 10 Apr 2024 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712777323; cv=none; b=u/+CwLzWMaOYNdxa+aDhQwdFIMey22efMw64wRfbU1KJqXAoTw1FYM2LddlhzB1izQTqRTolo152MfVYM8Yfvn9Jtsq21I/zq8d3Pdv93D6GwIPtGl4L6xfh0eHOsnDseWpLJq4mJBVcXYbH7qzmJse345qMIR0S7E8Kv7xPooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712777323; c=relaxed/simple;
	bh=WOeeQkSWa4cC+JdRWhi+F3uBgT2A/qX4BlXL0RnkUCI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Rpg8Awrzuecq5aZxtisoWwVZZJ7G/NusLTPMZyWljALC43sMyoT4d/F3L4n7AqMvakeyjxvI+gjf2yzYSQ+U2q8S8onv2iChH8oGQyXd8ezHcgKU7OMqp6tee8F99AYliTBck3WvGQf9/xPwrtH13RFV04ypINydCe+c+Izhm4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4KcJiaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5928DC433F1;
	Wed, 10 Apr 2024 19:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712777322;
	bh=WOeeQkSWa4cC+JdRWhi+F3uBgT2A/qX4BlXL0RnkUCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=V4KcJiaCI8JlpuHxsNMA2kz2SSkPb8I65KHr01c0bKDpPWkjrrN9fJ2uS8aDjHR1d
	 npEtvjCySIDywAXfkqTrCw05tsQT7NvA1DrpALdePR392tb4lVeuk8u4c3879QTyCO
	 BiJpuEt1IfiHGy/dBiQQ/T0yyIUDSWLo1LI4o/QIB/wePkwZs+peO8FEj6rJa1P1cV
	 seUk5IOw7Xzt9xUoOmk+c15h4jYVYuQ0sjaGT2Da2fQ7KBzNqr97uoDgXec2wvB33/
	 oWNw3w/JrPhXPs6vWXZ6chIdKRXa19HVfg9mzOE0GHvFFPF6wchSzhAZA4CYXL8XL7
	 YcYPIZwuxh3JA==
Date: Wed, 10 Apr 2024 14:28:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: Re: [Query] ACS enablement in the DT based boot flow
Message-ID: <20240410192840.GA2147526@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR12MB667446D4A4CAD6E0A2F488B5B83F2@PH8PR12MB6674.namprd12.prod.outlook.com>

[+cc Will, Joerg]

On Mon, Apr 01, 2024 at 10:40:15AM +0000, Vidya Sagar wrote:
> Hi folks,
> ACS (Access Control Services) is configured for a PCI device through
> pci_enable_acs().  The first thing pci_enable_acs() checks for is
> whether the global flag 'pci_acs_enable' is set or not.  The global
> flag 'pci_acs_enable' is set by the function pci_request_acs().
> 
> pci_enable_acs() function is called whenever a new PCI device is
> added to the system
> 
>  pci_enable_acs+0x4c/0x2a4
>  pci_acs_init+0x38/0x60
>  pci_device_add+0x1a0/0x670
>  pci_scan_single_device+0xc4/0x100
>  pci_scan_slot+0x6c/0x1e0
>  pci_scan_child_bus_extend+0x48/0x2e0
>  pci_scan_root_bus_bridge+0x64/0xf0
>  pci_host_probe+0x18/0xd0
> 
> In the case of a system that boots using device-tree blob,
> pci_request_acs() is called when the device driver binds with the
> respective device
> 
> of_iommu_configure+0xf4/0x230
> of_dma_configure_id+0x110/0x340
> pci_dma_configure+0x54/0x120
> really_probe+0x80/0x3e0
> __driver_probe_device+0x88/0x1c0
> driver_probe_device+0x3c/0x140
> __device_attach_driver+0xe8/0x1e0
> bus_for_each_drv+0x78/0xf0
> __device_attach+0x104/0x1e0
> device_attach+0x14/0x30
> pci_bus_add_device+0x50/0xd0
> pci_bus_add_devices+0x38/0x90
> pci_host_probe+0x40/0xd0
> 
> Since the device addition always happens first followed by the
> driver binding, this flow effectively makes sure that ACS never gets
> enabled.
> 
> Ideally, I would expect the pci_request_acs() get called (probably
> by the OF framework itself) before calling pci_enable_acs().
> 
> This happens in the ACPI flow where pci_request_acs() is called
> during IORT node initialization (i.e. iort_init_platform_devices()
> function).
> 
> Is this understanding correct? If yes, would it make sense to call
> pci_request_acs() during OF initialization (similar to IORT
> initialization in ACPI flow)?

Your understanding looks correct to me.  My call graph notes, FWIW:

  mem_init
    pci_iommu_alloc                   # x86 only
      amd_iommu_detect                # init_state = IOMMU_START_STATE
        iommu_go_to_state(IOMMU_IVRS_DETECTED)
          state_next
            switch (init_state)
            case IOMMU_START_STATE:
              detect_ivrs
                pci_request_acs
                  pci_acs_enable = 1  # <--
      detect_intel_iommu
        pci_request_acs
          pci_acs_enable = 1          # <--

  pci_scan_single_device              # PCI enumeration
    ...
      pci_init_capabilities
        pci_acs_init
          pci_enable_acs
            if (pci_acs_enable)       # <--
              pci_std_enable_acs

  __driver_probe_device
    really_probe
      pci_dma_configure               # pci_bus_type.dma_configure
        if (OF)
          of_dma_configure
            of_dma_configure_id
              of_iommu_configure
                pci_request_acs       # <-- 6bf6c24720d3
                iommu_probe_device
        else if (ACPI)
          acpi_dma_configure
            acpi_dma_configure_id
              acpi_iommu_configure_id
                iommu_probe_device

The pci_request_acs() in of_iommu_configure(), which happens too late
to affect pci_enable_acs(), was added by 6bf6c24720d3 ("iommu/of:
Request ACS from the PCI core when configuring IOMMU linkage"), so I
cc'd Will and Joerg.  I don't know if that *used* to work and got
broken somehow, or if it never worked as intended.

Bjorn

