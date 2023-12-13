Return-Path: <linux-pci+bounces-873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5268110C8
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 13:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BD91F2126E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 12:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E64D2555E;
	Wed, 13 Dec 2023 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="l1M0w1Aw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E26CD
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 04:12:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-336356d9092so904635f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 04:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1702469530; x=1703074330; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1+N4toHCJ10eN7beh/9j8TkfnPseGcXj+HseAP1tdBY=;
        b=l1M0w1Aw5OhVxpzkfqCNOdZdayqytpT4jHHl44iOBHtj0sow0Jed5aGOhUYpSdoU1b
         mdbLND4MaPnkbcxMVhepl6AdmC9Q69gbaaHu2++VG8gtb6A8XB83cpNWPwvNPmjtUFKo
         6Y0fPC7UMLgkDsWXiJTX4ghVIvehEISGdm4+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702469530; x=1703074330;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+N4toHCJ10eN7beh/9j8TkfnPseGcXj+HseAP1tdBY=;
        b=qVfaUbPkEDaak2+fVxMS+tECFe8J516vorphii7xQLTC6aoXRSXHO8gZzIDvpX4f/r
         lsiTFThl+CzfVFLfBDfY+mkKZ+yAr7fNyt30qVreRm9L61UDt2mrK5OsfrVj+F+8cn8K
         IPaYRnapYVlArsRfaltemEywHAmI+VSRESNgeX2cItEXGnV+GYV/QJ3fdRsHORVbzi0z
         W24H+zyopPrfvZUdN0eEOPaB5TS4V8ld8nv41IUEzNzjprcBc5QTPftqQxla9zaWAxHD
         bjJsjaLAxd+O1uU9ZfKapwKYk7LntaLaOmjvw8D9u16qEC8la4zUE9t5H3Hcm3zQ8dO8
         1TmA==
X-Gm-Message-State: AOJu0Yyq4BYQNYrGDpkFNVjnTnZXNKcWpM8kMfZ2XyFd/9YSOESQQYrM
	Lz/m8LPGZTrcCXG6QM3SqTcvuQ==
X-Google-Smtp-Source: AGHT+IEXQImdxtidsySE8Dvo4Qp275qPuasc4MbJLcUoaLv3rryHkHfFfLlFqk21Zhh1xtU9nWcpFQ==
X-Received: by 2002:adf:fd08:0:b0:333:43a2:2caf with SMTP id e8-20020adffd08000000b0033343a22cafmr4973429wrr.14.1702469530209;
        Wed, 13 Dec 2023 04:12:10 -0800 (PST)
Received: from localhost ([213.195.127.70])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6282000000b003363432c0ffsm3429132wru.113.2023.12.13.04.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 04:12:09 -0800 (PST)
Date: Wed, 13 Dec 2023 13:12:09 +0100
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
Message-ID: <ZXmfmbb4S8Iuy7si@macbook>
References: <20231210161519.1550860-1-Jiqian.Chen@amd.com>
 <20231210161519.1550860-4-Jiqian.Chen@amd.com>
 <ZXdNf0HWs4nAVPeF@macbook>
 <BL1PR12MB584910C2E370BBCC8A312733E78EA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <ZXglU0EtBrRNiWVp@macbook>
 <BL1PR12MB584973D751EB57C3DE766AEEE78DA@BL1PR12MB5849.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PR12MB584973D751EB57C3DE766AEEE78DA@BL1PR12MB5849.namprd12.prod.outlook.com>

On Wed, Dec 13, 2023 at 03:31:21AM +0000, Chen, Jiqian wrote:
> On 2023/12/12 17:18, Roger Pau Monné wrote:
> > On Tue, Dec 12, 2023 at 06:34:27AM +0000, Chen, Jiqian wrote:
> >>
> >> On 2023/12/12 01:57, Roger Pau Monné wrote:
> >>> On Mon, Dec 11, 2023 at 12:15:19AM +0800, Jiqian Chen wrote:
> >>>> There is a need for some scenarios to use gsi sysfs.
> >>>> For example, when xen passthrough a device to dumU, it will
> >>>> use gsi to map pirq, but currently userspace can't get gsi
> >>>> number.
> >>>> So, add gsi sysfs for that and for other potential scenarios.
> >>>>
> >>>> Co-developed-by: Huang Rui <ray.huang@amd.com>
> >>>> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> >>>> ---
> >>>>  drivers/acpi/pci_irq.c  |  1 +
> >>>>  drivers/pci/pci-sysfs.c | 11 +++++++++++
> >>>>  include/linux/pci.h     |  2 ++
> >>>>  3 files changed, 14 insertions(+)
> >>>>
> >>>> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> >>>> index 630fe0a34bc6..739a58755df2 100644
> >>>> --- a/drivers/acpi/pci_irq.c
> >>>> +++ b/drivers/acpi/pci_irq.c
> >>>> @@ -449,6 +449,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
> >>>>  		kfree(entry);
> >>>>  		return 0;
> >>>>  	}
> >>>> +	dev->gsi = gsi;
> >>>
> >>> It would be better if the gsi if fetched without requiring calling
> >>> acpi_pci_irq_enable(), as the gsi doesn't require the interrupt to be
> >>> enabled.  The gsi is known at boot time and won't change for the
> >>> lifetime of the device.
> >> Do you have any suggest places to do this?
> > 
> > I'm not an expert on this, but drivers/pci/pci-sysfs.c would seem like
> > a better place, together with the rest of the resources.
> I'm not familiar with this too. But it seems pci-sysfs.c only creates sysfs node and supports the read/write method without initializing the values.
> If want to initialize the value of gsi here. An approach to initialize it is to call acpi_pci_irq_lookup to get gsi number when the first time it is read?

Hm, maybe, I don't really have much experience with sysfs, so don't
know how nodes are usually initialized.

> > 
> > Maybe my understanding is incorrect, but given the suggested placement
> > in acpi_pci_irq_enable() I think the device would need to bind the
> > interrupt in order for the gsi node to appear on sysfs?
> No, gsi sysfs has existed there, in acpi_pci_irq_enable is to initialize the value of gsi.
> 
> > 
> > Would the current approach work if the device is assigned to pciback
> > on the kernel command line, and thus never owned by any driver in
> > dom0?
> If assigned to pciback, I think pciback will enable the device, and then acpi_pci_irq_enable will be called, and then the gsi will be initialized. So, current can work.

This needs checking to be sure, I'm certainly not that familiar.  You
would need to at least test that it works properly when the device is
hidden using xen-pciback.hide=(SBDF) in the Linux kernel command line.

Thanks, Roger.

