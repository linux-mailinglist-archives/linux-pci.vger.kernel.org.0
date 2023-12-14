Return-Path: <linux-pci+bounces-977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7911F812AA0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 09:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1FCC2826B4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 08:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC4622F1C;
	Thu, 14 Dec 2023 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="RwJFtWCL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A4D10B
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 00:46:55 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-336445a2749so617820f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 00:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1702543614; x=1703148414; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VRbI5kjcIRPl4oUV94OH4S0caT5wjSRkLPGI8s4DA/k=;
        b=RwJFtWCLy6gKQ1XreFMJ1I3Ovx1KH6yNtx1r1pjcsEMbwfqbNJexuq4vW1ozGRym7H
         umAIlnkQgdA2st58ieNO/4Wznc3+zJZXYgHk3tDOcV43qrU27LOybN5gCzIs1Sfl0J9L
         btHXh70U2LPzrJ2R88fK3ZwbxR+wQ6rBuXuI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702543614; x=1703148414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VRbI5kjcIRPl4oUV94OH4S0caT5wjSRkLPGI8s4DA/k=;
        b=P2FANbITyoNXAQ5wh5vZxHq46e9a9IZpy7lI6qgoL1hiWUyoBwkmWBfUcXW0XukXBN
         3ZvBKn+aKJH71pGLa/ulG+5ABs1hz76S895u9gzXkH9NIkYnAXWuGMAijRSDFn3aL7W+
         5CVk/4rTLVyI+n4xHwuNBuS+d08ME0Ude0AYrRDOfeV+KZ9jtlHAUONH05a8/xtr+NyI
         uZZjWup67GgNXSsLyEhshspOy5nbDBH0VFyAReS/ofzAx8Tfn0uhepnXVgtURaCtXdYV
         CAU5BkzrofNCA3IhzF+A60JrizRBLmxD3yV9paWwjUpe3IXoWCEGO+yli8R7xSFok68j
         GQxA==
X-Gm-Message-State: AOJu0YwtCexvnpx46BcwC5ZVEtqfn/GED31TVKJXn+yaLzTXH9VXOiko
	PaypLvvMN6PXKgg3Z9gAqVwyYLCNmTtvoOIQlcM=
X-Google-Smtp-Source: AGHT+IFs1KY+zsQXwuAqC03LiFJwO3hRSTw+6+YdEzAfW15eHnWqW0A0/g+qvKOg7kFPUNaNrf5hAQ==
X-Received: by 2002:a5d:6aca:0:b0:336:9ec:d613 with SMTP id u10-20020a5d6aca000000b0033609ecd613mr6133406wrw.90.1702543613756;
        Thu, 14 Dec 2023 00:46:53 -0800 (PST)
Received: from localhost ([213.195.127.70])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d504c000000b003333521a1cesm3283381wrt.57.2023.12.14.00.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 00:46:53 -0800 (PST)
Date: Thu, 14 Dec 2023 09:46:52 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v3 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Message-ID: <ZXrA_OocbBkFAkM-@macbook>
References: <20231210161519.1550860-1-Jiqian.Chen@amd.com>
 <20231210161519.1550860-4-Jiqian.Chen@amd.com>
 <ZXdNf0HWs4nAVPeF@macbook>
 <BL1PR12MB584910C2E370BBCC8A312733E78EA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <ZXglU0EtBrRNiWVp@macbook>
 <BL1PR12MB584973D751EB57C3DE766AEEE78DA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <ZXmfmbb4S8Iuy7si@macbook>
 <BL1PR12MB584911B4DFF4D9ED65CF92F0E78CA@BL1PR12MB5849.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PR12MB584911B4DFF4D9ED65CF92F0E78CA@BL1PR12MB5849.namprd12.prod.outlook.com>

On Thu, Dec 14, 2023 at 07:08:32AM +0000, Chen, Jiqian wrote:
> On 2023/12/13 20:12, Roger Pau Monné wrote:
> > On Wed, Dec 13, 2023 at 03:31:21AM +0000, Chen, Jiqian wrote:
> >> On 2023/12/12 17:18, Roger Pau Monné wrote:
> >>> On Tue, Dec 12, 2023 at 06:34:27AM +0000, Chen, Jiqian wrote:
> >>>>
> >>>> On 2023/12/12 01:57, Roger Pau Monné wrote:
> >>>>> On Mon, Dec 11, 2023 at 12:15:19AM +0800, Jiqian Chen wrote:
> >>>>>> There is a need for some scenarios to use gsi sysfs.
> >>>>>> For example, when xen passthrough a device to dumU, it will
> >>>>>> use gsi to map pirq, but currently userspace can't get gsi
> >>>>>> number.
> >>>>>> So, add gsi sysfs for that and for other potential scenarios.
> >>>>>>
> >>>>>> Co-developed-by: Huang Rui <ray.huang@amd.com>
> >>>>>> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> >>>>>> ---
> >>>>>>  drivers/acpi/pci_irq.c  |  1 +
> >>>>>>  drivers/pci/pci-sysfs.c | 11 +++++++++++
> >>>>>>  include/linux/pci.h     |  2 ++
> >>>>>>  3 files changed, 14 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> >>>>>> index 630fe0a34bc6..739a58755df2 100644
> >>>>>> --- a/drivers/acpi/pci_irq.c
> >>>>>> +++ b/drivers/acpi/pci_irq.c
> >>>>>> @@ -449,6 +449,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
> >>>>>>  		kfree(entry);
> >>>>>>  		return 0;
> >>>>>>  	}
> >>>>>> +	dev->gsi = gsi;
> >>>>>
> >>>>> It would be better if the gsi if fetched without requiring calling
> >>>>> acpi_pci_irq_enable(), as the gsi doesn't require the interrupt to be
> >>>>> enabled.  The gsi is known at boot time and won't change for the
> >>>>> lifetime of the device.
> >>>> Do you have any suggest places to do this?
> >>>
> >>> I'm not an expert on this, but drivers/pci/pci-sysfs.c would seem like
> >>> a better place, together with the rest of the resources.
> >> I'm not familiar with this too. But it seems pci-sysfs.c only creates sysfs node and supports the read/write method without initializing the values.
> >> If want to initialize the value of gsi here. An approach to initialize it is to call acpi_pci_irq_lookup to get gsi number when the first time it is read?
> > 
> > Hm, maybe, I don't really have much experience with sysfs, so don't
> > know how nodes are usually initialized.
> Maybe the maintainers of sysfs can give some suggest places to initialize the value of gsi.
> 
> > 
> >>>
> >>> Maybe my understanding is incorrect, but given the suggested placement
> >>> in acpi_pci_irq_enable() I think the device would need to bind the
> >>> interrupt in order for the gsi node to appear on sysfs?
> >> No, gsi sysfs has existed there, in acpi_pci_irq_enable is to initialize the value of gsi.
> >>
> >>>
> >>> Would the current approach work if the device is assigned to pciback
> >>> on the kernel command line, and thus never owned by any driver in
> >>> dom0?
> >> If assigned to pciback, I think pciback will enable the device, and then acpi_pci_irq_enable will be called, and then the gsi will be initialized. So, current can work.
> > 
> > This needs checking to be sure, I'm certainly not that familiar.  You
> > would need to at least test that it works properly when the device is
> > hidden using xen-pciback.hide=(SBDF) in the Linux kernel command line.
> Sure, I have validated it on my side. Both the "Static assignment for built-in xen-pciback(xen-pciback.hide=(SBDF))" and the "Dynamic assignment with xl(sudo modprobe xen-pciback & sudo xl pci-assignable-add SBDF)" can work fine with current implementation.

Oh, OK, if that's the case I don't have much objection in doing the
initialization in acpi_pci_irq_enable(), that's an internal Linux
detail.  I mostly care about the GSI being exposed in sysfs in a
non-Xen specific way.

Thanks, Roger.

