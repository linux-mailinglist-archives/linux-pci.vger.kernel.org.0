Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B71E430CBA
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 00:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344801AbhJQWT2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Oct 2021 18:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46966 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344806AbhJQWT1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Oct 2021 18:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634509036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VC0sWKuJ5MpDbY6DXl9zvz5o696+GJBNvO+SxKY2kO8=;
        b=G8AeDIZnevTk+99Y+WSEeg/b0eYg1+NVYjZCXSFYjObwSxI1NUpIIZuSExwGgH7Yjyo8w+
        /z7jgwteZmXKuuTbLaTnt1/7MbTRaeqj6FY9/bSMzkZpLpaN152/wl7pKyOyksDCU/N9/4
        nWAwiv3kPfDMtHWNnkU+3Y+LPv37N4g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-fLSdnKGuPjWFTVHjWEEpVQ-1; Sun, 17 Oct 2021 18:17:15 -0400
X-MC-Unique: fLSdnKGuPjWFTVHjWEEpVQ-1
Received: by mail-ed1-f72.google.com with SMTP id l22-20020aa7c316000000b003dbbced0731so12547629edq.6
        for <linux-pci@vger.kernel.org>; Sun, 17 Oct 2021 15:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VC0sWKuJ5MpDbY6DXl9zvz5o696+GJBNvO+SxKY2kO8=;
        b=stn77umNy8ykb+MFiyaGUZabLzuQ06DJTTGbcvDGuBKxr0dowWdL/fc3rDoK3VDj0i
         57eySugr1MFGgoZTx+hMvJm+ftY7uodPBzA+eIG1NVHDsPz5ZIDYSlFm9r79iN67S3MQ
         DneVCHnH9QWj4Azw8gJOsIpFKY8tw7LnEDZd8O3d/LTFwrH8w2ZU8CmGJgI3dIrYSbrT
         jQ+bkZcR1y03F/kq2nEy7J+19I3hUFE0zArGnmXSQrdPqRX9aL1DPymeunOEuXLpAVp0
         ofM8fyptcDKiNXtHtzJ3MYU5VLm+gsgIgNHVEmz0etVBSQ+5IzgkaK+X7Tu4KhcR3T8g
         Styg==
X-Gm-Message-State: AOAM533zK2nLvLAtSmcL6TCezARTfzX6Ncevkagh6jegWchX9wlseQXw
        fY7aKDJ/iNZKiAx6fbJvxTZszm99hCY2h90VxOVYUqRkf+qc2lu/bJ5GbAqkz+vV0Y0A11C/hPL
        33CkjkJmKHVPiPQuJQROA
X-Received: by 2002:a17:906:38db:: with SMTP id r27mr24705862ejd.338.1634509034117;
        Sun, 17 Oct 2021 15:17:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx51KnpBX8SOErBYIGNeXUSpnLaZGw8M8o8nNtAQZwgmzpfpG+8uY45Z6g2dYvFNl1kABYCEw==
X-Received: by 2002:a17:906:38db:: with SMTP id r27mr24705846ejd.338.1634509033862;
        Sun, 17 Oct 2021 15:17:13 -0700 (PDT)
Received: from redhat.com ([2.55.147.75])
        by smtp.gmail.com with ESMTPSA id kw5sm7937099ejc.110.2021.10.17.15.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 15:17:12 -0700 (PDT)
Date:   Sun, 17 Oct 2021 18:17:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter H Anvin <hpa@zytor.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Message-ID: <20211017180950-mutt-send-email-mst@kernel.org>
References: <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
 <DM8PR11MB57501C8F8F5C8B315726882EE7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20211012171016-mutt-send-email-mst@kernel.org>
 <DM8PR11MB5750A40FAA6AFF6A29CF70DAE7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20211014025514-mutt-send-email-mst@kernel.org>
 <DM8PR11MB57500B2D821E8AAF93EB66CEE7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20211014052605-mutt-send-email-mst@kernel.org>
 <DM8PR11MB57505AAA1E1209F7FCA69C11E7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB57505AAA1E1209F7FCA69C11E7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 14, 2021 at 12:33:49PM +0000, Reshetova, Elena wrote:
> > On Thu, Oct 14, 2021 at 07:27:42AM +0000, Reshetova, Elena wrote:
> > > > On Thu, Oct 14, 2021 at 06:32:32AM +0000, Reshetova, Elena wrote:
> > > > > > On Tue, Oct 12, 2021 at 06:36:16PM +0000, Reshetova, Elena wrote:
> > > > > > > > The 5.15 tree has something like ~2.4k IO accesses (including MMIO and
> > > > > > > > others) in init functions that also register drivers (thanks Elena for
> > > > > > > > the number)
> > > > > > >
> > > > > > > To provide more numbers on this. What I can see so far from a smatch-
> > based
> > > > > > > analysis, we have 409 __init style functions (.probe & builtin/module_
> > > > > > > _platform_driver_probe excluded) for 5.15 with allyesconfig.
> > > > > >
> > > > > > I don't think we care about allyesconfig at all though.
> > > > > > Just don't do that.
> > > > > > How about allmodconfig? This is closer to what distros actually do.
> > > > >
> > > > > It does not make any difference really for the content of the /drivers/*:
> > > > > gives 408 __init style functions doing IO (.probe & builtin/module_
> > > > > > > _platform_driver_probe excluded) for 5.15 with allmodconfig:
> > > > >
> > > > > ['doc200x_ident_chip',
> > > > > 'doc_probe', 'doc2001_init', 'mtd_speedtest_init',
> > > > > 'mtd_nandbiterrs_init', 'mtd_oobtest_init', 'mtd_pagetest_init',
> > > > > 'tort_init', 'mtd_subpagetest_init', 'fixup_pmc551',
> > > > > 'doc_set_driver_info', 'init_amd76xrom', 'init_l440gx',
> > > > > 'init_sc520cdp', 'init_ichxrom', 'init_ck804xrom', 'init_esb2rom',
> > > > > 'probe_acpi_namespace_devices', 'amd_iommu_init_pci', 'state_next',
> > > > > 'arm_v7s_do_selftests', 'arm_lpae_run_tests', 'init_iommu_one',
> > > >
> > > > Um. ARM? Which architecture is this build for?
> > >
> > > The list of smatch IO findings is built for x86, but the smatch cross function
> > > database covers all archs, so when queried for all potential function callers,
> > > it would show non x86 arch call chains also.
> > >
> > > Here is the original x86 finding and call chain for the 'arm_v7s_do_selftests':
> > >
> > >   Detected low-level IO from arm_v7s_do_selftests in fun
> > > __iommu_queue_command_sync
> > >
> > > drivers/iommu/amd/iommu.c:1025 __iommu_queue_command_sync() error:
> > > {15002074744551330002}
> > >     'check_host_input' read from the host using function 'readl' to a
> > > member of the structure 'iommu->cmd_buf_head';
> > >
> > > __iommu_queue_command_sync()
> > >   iommu_completion_wait()
> > >     amd_iommu_domain_flush_complete()
> > >       iommu_v1_map_page()
> > >         arm_v7s_do_selftests()
> > >
> > > So, the results can be further filtered if you want a specified arch.
> > 
> > So what is it just for x86? Could you tell?
> 
> I can probably figure out how to do additional filtering here, but does
> it really matter for the case that is being discussed here? Andi's point was
> that there quite many existing places in the kernel when low-level IO
> happens before the probe stage. So I brought these numbers here.
> What do you plan to do with the pure x86 results? 

If the list is short - just suggest securing that ;)


> And here are the full results for allyesconfig, if anyone is interested (just got permission to create
> the repository today):
> https://github.com/intel/ccc-linux-guest-hardening/tree/master/audit/sample_output/5.15-rc1
> We will be pushing to this repo all the scripts and fuzzing setups we use as part of
> our Linux guest hardening effort for confidential cloud computing, but it is going to take
> some time to get all the approvals collected.  
> 
> Best Regards,
> Elena.

