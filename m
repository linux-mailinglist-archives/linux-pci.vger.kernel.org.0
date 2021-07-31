Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9993DC7E6
	for <lists+linux-pci@lfdr.de>; Sat, 31 Jul 2021 21:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhGaTPX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Jul 2021 15:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhGaTPW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Jul 2021 15:15:22 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C13C06175F;
        Sat, 31 Jul 2021 12:15:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k4-20020a17090a5144b02901731c776526so25673941pjm.4;
        Sat, 31 Jul 2021 12:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1y8EiRS4BQiqhepS4ejW6iSDklPXdZhmSNW0+oA9248=;
        b=nr89TCXcL6sWAXhNE7YvOQZl4cmge5e+UOBa4P62eFaRTNvAOF2CFqjFzyvZR/PboA
         rjnKNXg/rxTOKXnyMQWX2WWKwWOMrhJG6iiRWAB91s9L5qqacA8kNfesp/fEHGuanp3s
         lDOBVBHUc34sbmJNzWAF4IaEQcPbRCJzMyrivRdGNC/di+0UCqWni1Fcw1FiL+ZxS9CD
         rWl53OmaJh3gc/KXp4tOaIgGq781Hh2cv5a6Tzv/vUrRYN0xcnuD7FGR3bnj8YTT1lzD
         VKVrsvjQJdMW2ZE/G1/+7mY7G4bDayZS2kM74Ylm0DoE6HS0PS/K3dBmVRavhG8J+lJu
         m7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1y8EiRS4BQiqhepS4ejW6iSDklPXdZhmSNW0+oA9248=;
        b=gD1U1DjosnoLIIxA/K6bgHKdrgu36D8B28N5P0CIL1RSrNs0o4ozrBV51oiKF4RAxl
         xaZmTqGWbFYDoAu0XR+4q4hWZT/yKAAhOh/Ouq7sSqOV4DdeZtipwqeTL1x1SWvBfXss
         z+4UFePLHlNxuVx6e5Zwku8gTsnuPLU+/wLVDA4JsS/YhnBpczL114VAYAk3nvkM3fpY
         jGFxsxt6LRtlJfKCGn27dTgmOtEnpB592aTHON4qjcCowPw4iaKiw3ivdlww9rhylZPi
         3ZeAPY7JePWxuI1qAiw7PPS5E62HUUrd3OogjTXgrL8jk2GmOcAWDaRGuj50+T+PLfjX
         7UJw==
X-Gm-Message-State: AOAM532dzq5uKbLb8fRszY6V5z96GVqF+UUr25Ttzr2u1DveHIrAdKHs
        PdxfSsPlwSq8tijnU5bG5TE=
X-Google-Smtp-Source: ABdhPJw9TQy2fICS1EIykQj6R8QIQ5g2d/rYoYhQAm+j18lvDETEXzF/JSBi7tCm929GJO1JycqpyQ==
X-Received: by 2002:a05:6a00:178f:b029:32b:2092:c3f5 with SMTP id s15-20020a056a00178fb029032b2092c3f5mr8655310pfg.57.1627758915918;
        Sat, 31 Jul 2021 12:15:15 -0700 (PDT)
Received: from localhost ([139.5.31.186])
        by smtp.gmail.com with ESMTPSA id 135sm1464150pfv.20.2021.07.31.12.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 12:15:15 -0700 (PDT)
Date:   Sun, 1 Aug 2021 00:45:05 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210731191505.xzor5lpqv4ubmijf@archlinux>
References: <20210709123813.8700-5-ameynarkhede03@gmail.com>
 <20210727232808.GA754831@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727232808.GA754831@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/07/27 06:28PM, Bjorn Helgaas wrote:
> On Fri, Jul 09, 2021 at 06:08:09PM +0530, Amey Narkhede wrote:
> > Add reset_method sysfs attribute to enable user to query and set user
> > preferred device reset methods and their ordering.
> >
> > Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-pci |  19 +++++
> >  drivers/pci/pci-sysfs.c                 | 103 ++++++++++++++++++++++++
> >  2 files changed, 122 insertions(+)
> >
[...]

> > +		if (i == PCI_NUM_RESET_METHODS) {
> > +			kfree(options);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	if (!pci_reset_fn_methods[1].reset_fn(pdev, 1) && reset_methods[0] != 1)
> > +		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
>
> Hmmm.  I sort of see the point here, but I wish we didn't have the
> implicit dependency on pci_reset_fn_methods[1] being
> pci_dev_specific_reset().
>
> I know we've talked about this before.  I'm still not 100% sure either
> of these warnings is worthwhile, especially since we're not *using*
> the reset here.  It might be useful at the point where we try to *do*
> a reset.  I dunno.  Maybe this is the best place since this is where
> the user potentially screwed up.
>
I agree this is the best place for the warning as this where potentially
broken reset methods may get called/prioritized. We can move this check
to __pci_reset_function_locked() if you want.

> > +set_reset_methods:
> > +	memcpy(pdev->reset_methods, reset_methods, sizeof(reset_methods));
> > +	kfree(options);
> > +	return count;
> > +}
> > +static DEVICE_ATTR_RW(reset_method);
> > +
> > +static struct attribute *pci_dev_reset_method_attrs[] = {
> > +	&dev_attr_reset_method.attr,
> > +	NULL,
> > +};
> > +
> > +static umode_t pci_dev_reset_method_attr_is_visible(struct kobject *kobj,
> > +						    struct attribute *a, int n)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> > +
> > +	if (!pci_reset_supported(pdev))
> > +		return 0;
> > +
> > +	return a->mode;
> > +}
> > +
> > +static const struct attribute_group pci_dev_reset_method_attr_group = {
> > +	.attrs = pci_dev_reset_method_attrs,
> > +	.is_visible = pci_dev_reset_method_attr_is_visible,
> > +};
> > +
> >  static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
> >  			   const char *buf, size_t count)
> >  {
> > @@ -1491,6 +1593,7 @@ const struct attribute_group *pci_dev_groups[] = {
> >  	&pci_dev_config_attr_group,
> >  	&pci_dev_rom_attr_group,
> >  	&pci_dev_reset_attr_group,
> > +	&pci_dev_reset_method_attr_group,
> >  	&pci_dev_vpd_attr_group,
> >  #ifdef CONFIG_DMI
> >  	&pci_dev_smbios_attr_group,
> > --
> > 2.32.0
> >
