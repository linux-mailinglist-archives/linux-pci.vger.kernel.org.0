Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C983D854E
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 03:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhG1B1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 21:27:45 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:50805 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhG1B1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jul 2021 21:27:44 -0400
Received: by mail-wm1-f47.google.com with SMTP id m19so369340wms.0;
        Tue, 27 Jul 2021 18:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TR1rppIHdj7KAEDgaB+1dBTwk0tZy/zE8t1N5sNSVA4=;
        b=PFig9xd1Cuobt9n3owwdI7zZLjBMZodt5vEZrzulYaTBXZyvSS2qw763We1LixTtu2
         dSMm9ubaKrkcaoAeGqXfjMu7f6jHLh6QpZ8efLh10ThMjtH/L+NeJO3gvf5tXNka1N45
         bXFipNptSQKiZUwPD9RZJQ6VKuxjGxNwSVs+srvnB9i+ffDlgtvViph/Q6FbdlLSe5Lf
         /p/LAYCwLSM6hzBks7L7Phl7csSdaamre9QdbxWbL/XxFBVNeYYCOntba/CgdTizas0K
         BrqsGaPF3Oqqn3HbvTDDzZVHEaZ4VW6yaix7oNRoKekFNd6ivspXn8IDs4pPX7mu1R98
         o7bw==
X-Gm-Message-State: AOAM532h/q2wAP5ANDxU1RDLd6gcg9IYvBLWwKc/cces4CsolkB2PET6
        b/xt+5ReF3ufQ14lIgPhdnM=
X-Google-Smtp-Source: ABdhPJyIen03AinHntcQ7D7KFx2ZVlnOiv3D4hwFlTxoNmOEm8KuwbZy+Z+yhqUckmxDfFS1SeKdPg==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr24703894wmc.163.1627435662415;
        Tue, 27 Jul 2021 18:27:42 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id g16sm6067261wro.63.2021.07.27.18.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 18:27:41 -0700 (PDT)
Date:   Wed, 28 Jul 2021 03:27:40 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210728012740.GA90475@rocinante>
References: <20210709123813.8700-5-ameynarkhede03@gmail.com>
 <20210727232808.GA754831@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210727232808.GA754831@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

[...]
> > +	if (count >= (PAGE_SIZE - 1))
> > +		return -EINVAL;
> 
> I'm not the sysfs expert, but surely the sysfs infrastructure already
> guarantees this?

We don't need to store any value, since we are processing the input from
the userspace, thus ensuring that we have room for the newline is not
needed, especially since the show() function dynamically builds the
content to show, so indeed this check can be dropped.

To add, there aren't any guarantees other from sysfs than we get a up to
a PAGE_SIZE worth of data in the buffer.

[...]
> > +	options = kstrndup(buf, count, GFP_KERNEL);
> 
> I assume the kstrndup() is because strsep() writes into the buffer?

Yes, Amey added kstrndup() in v6 following my recommendation as per:

  https://lore.kernel.org/linux-pci/20210606125800.GA76573@rocinante.localdomain/

This was to avoid removing the const quantifier through a type cast
given that the signature of the function denotes that the buffer is
a pointer to immutable string, as per:

  https://elixir.bootlin.com/linux/v5.14-rc3/source/include/linux/device/driver.h#L137

Some other sysfs users do employ the cast when using strtok() and I am
not so such it's the right way to do it, as per:

  drivers/s390/net/qeth_l3_sys.c
  232:	tmp = strsep((char **)&buf, "\n");
  
  drivers/media/rc/rc-main.c
  1167:	while ((tmp = strsep((char **)&buf, " \n")) != NULL) {

> Aren't we allowed to write into the buffer we get from sysfs?  Does
> the user ever see the buffer contents again?  I would think sysfs
> would have already done a copy_from_user() or whatever.

I might be wrong about this, but I suppose this might be to stop people
from accidentally freeing the buffer as kernfs_fop_write_iter() would do
it after all the internal housekeeping is done, provided that someone
pays attention to compile time warnings.

	Krzysztof
