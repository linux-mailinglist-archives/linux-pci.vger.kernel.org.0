Return-Path: <linux-pci+bounces-791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ED380E730
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 10:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AD21C2137F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 09:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AFA58135;
	Tue, 12 Dec 2023 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="h3nFpsto"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0CED5
	for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 01:18:13 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3332efd75c9so4878549f8f.2
        for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 01:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1702372692; x=1702977492; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9WELy4DAZTSrhx4zGGjgQkw3W/tbMhWv9d+cZpR74m0=;
        b=h3nFpstoqypwlitXuvf2NCctFsAFDjzPZDUy+RZZBGUaFh1vHxl1kBiexRPf7OaJvt
         m8hMrx6mSz5PV1gimgHJ7nbKviJa0r5VxC3gVNZUSvMB/MbUk61ug2cJzalI7jlipIVA
         BpMtkubWuyPIUyXFbBL7fBUTIYhsPpd0OBfUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702372692; x=1702977492;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WELy4DAZTSrhx4zGGjgQkw3W/tbMhWv9d+cZpR74m0=;
        b=SoKU6rtfCwcnZsBImR6l2/2AKnJVb2BOyjCiSXu789BYcRPfgsQ6mAuZmeSdCD1Zr/
         rXOT/fwqhzZjE8jnGhRSo25lvqel/I7s1NBh8Wl40VnAIiKWrW3QzlXqH+3IqdK3lTCP
         4Oa05CUEXknHdYjIZwXl4PSxUavJf2zHiBpm2eRFlAVEDBkzSWmRzXjT6FwC4O/A9Psd
         cjQs07VBpLOzheHe7GjtPrD7NrBYDGUhRrxSdUcVfHa8Di54hNq3uCizm0fOJ9qmHPoR
         mLigEifWMfx/rCjzW/rAI6NcNEWWG0GKmG97sGHmVxgw65HdgZVoTIIl+l6xfsqBoy8J
         A+LQ==
X-Gm-Message-State: AOJu0YyTF/z66acQgtugG07dVHmpYfnLdITuKFdbVnsoc2kF5UmXtziQ
	kXyd57i567nErlnnMQvx9oUvIg==
X-Google-Smtp-Source: AGHT+IFgKgRKA6Hj8FA4QbKIfcIE89wBNkiyNGzHcW1HguHNOiTJp2Iwm2e75u6BvwbtAJwHlC1s8w==
X-Received: by 2002:a05:600c:1c1f:b0:40b:4c54:3d6d with SMTP id j31-20020a05600c1c1f00b0040b4c543d6dmr1419794wms.8.1702372692352;
        Tue, 12 Dec 2023 01:18:12 -0800 (PST)
Received: from localhost ([213.195.113.99])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0040c490db950sm5631023wmq.47.2023.12.12.01.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:18:12 -0800 (PST)
Date: Tue, 12 Dec 2023 10:18:11 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>,
	"Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
	"Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>,
	"Zhang, Julia" <Julia.Zhang@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v3 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Message-ID: <ZXglU0EtBrRNiWVp@macbook>
References: <20231210161519.1550860-1-Jiqian.Chen@amd.com>
 <20231210161519.1550860-4-Jiqian.Chen@amd.com>
 <ZXdNf0HWs4nAVPeF@macbook>
 <BL1PR12MB584910C2E370BBCC8A312733E78EA@BL1PR12MB5849.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PR12MB584910C2E370BBCC8A312733E78EA@BL1PR12MB5849.namprd12.prod.outlook.com>

On Tue, Dec 12, 2023 at 06:34:27AM +0000, Chen, Jiqian wrote:
> 
> On 2023/12/12 01:57, Roger Pau Monné wrote:
> > On Mon, Dec 11, 2023 at 12:15:19AM +0800, Jiqian Chen wrote:
> >> There is a need for some scenarios to use gsi sysfs.
> >> For example, when xen passthrough a device to dumU, it will
> >> use gsi to map pirq, but currently userspace can't get gsi
> >> number.
> >> So, add gsi sysfs for that and for other potential scenarios.
> >>
> >> Co-developed-by: Huang Rui <ray.huang@amd.com>
> >> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> >> ---
> >>  drivers/acpi/pci_irq.c  |  1 +
> >>  drivers/pci/pci-sysfs.c | 11 +++++++++++
> >>  include/linux/pci.h     |  2 ++
> >>  3 files changed, 14 insertions(+)
> >>
> >> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> >> index 630fe0a34bc6..739a58755df2 100644
> >> --- a/drivers/acpi/pci_irq.c
> >> +++ b/drivers/acpi/pci_irq.c
> >> @@ -449,6 +449,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
> >>  		kfree(entry);
> >>  		return 0;
> >>  	}
> >> +	dev->gsi = gsi;
> > 
> > It would be better if the gsi if fetched without requiring calling
> > acpi_pci_irq_enable(), as the gsi doesn't require the interrupt to be
> > enabled.  The gsi is known at boot time and won't change for the
> > lifetime of the device.
> Do you have any suggest places to do this?

I'm not an expert on this, but drivers/pci/pci-sysfs.c would seem like
a better place, together with the rest of the resources.

Maybe my understanding is incorrect, but given the suggested placement
in acpi_pci_irq_enable() I think the device would need to bind the
interrupt in order for the gsi node to appear on sysfs?

Would the current approach work if the device is assigned to pciback
on the kernel command line, and thus never owned by any driver in
dom0?

> > 
> >>  
> >>  	rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
> >>  	if (rc < 0) {
> >> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> >> index 2321fdfefd7d..c51df88d079e 100644
> >> --- a/drivers/pci/pci-sysfs.c
> >> +++ b/drivers/pci/pci-sysfs.c
> >> @@ -71,6 +71,16 @@ static ssize_t irq_show(struct device *dev,
> >>  }
> >>  static DEVICE_ATTR_RO(irq);
> >>  
> >> +static ssize_t gsi_show(struct device *dev,
> >> +			struct device_attribute *attr,
> >> +			char *buf)
> >> +{
> >> +	struct pci_dev *pdev = to_pci_dev(dev);
> > 
> > const
> Do you mean "const struct pci_dev *pdev = to_pci_dev(dev);" ?

Yup.

Thanks, Roger.

