Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F7939ADD8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 00:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhFCWV6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 18:21:58 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:36379 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhFCWV5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jun 2021 18:21:57 -0400
Received: by mail-wr1-f51.google.com with SMTP id n4so7347761wrw.3
        for <linux-pci@vger.kernel.org>; Thu, 03 Jun 2021 15:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Gae9gt4g8VNNlPVaWwPGokam5/UEFDl+uRdvZfNLsk=;
        b=k4FlX9IfCVolrcW0yIpEWNpyYtAcd3HqHf98vLN/js/dkBEr4azQZZLx/FHGOds9RX
         E0bBfLsOR/mbo60xt5WYMZtEMHCmHCJWxfpd190zOfes6oxFPnbBr+Zv3/oIcsMfbcrN
         DhsPnZ50DfNOkIYNKjOb5tcvEz65iwefEzP5ntzw7CvlOu8U3SaHygSl5AfbcLUnPMdK
         ntUo808JlgulCrWM5deTmCP/lUO3fCqSk3TmSjTBaDKQwvHmTiTdQnegf1w7kTVCtliu
         EEwCTbvgBsz8c9/aT0FORkW1pvUVaz0z/nJSoz6vzcLO+JFtGTEhZIEQtUqpQ6HTI/ev
         cf9g==
X-Gm-Message-State: AOAM531R3GG+IxIFNqPPQTtDVmwi85BSySJTjtlVKh/798EEkwke0o2w
        w/iFU7AdFpEpZfPz7hCKJR8=
X-Google-Smtp-Source: ABdhPJwcgDllNQD0ospBtV4S2anlguOXe1fnFpPCiP5wwrRdaFAaAfIMOrvoRQKyrhfggyYuweaV2w==
X-Received: by 2002:adf:ed03:: with SMTP id a3mr628169wro.166.1622758798731;
        Thu, 03 Jun 2021 15:19:58 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id p10sm4461011wrr.58.2021.06.03.15.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 15:19:58 -0700 (PDT)
Date:   Fri, 4 Jun 2021 00:19:56 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 5/6] PCI/sysfs: Only show value when driver_override
 is not NULL
Message-ID: <20210603221956.GA393910@rocinante.localdomain>
References: <20210603000112.703037-6-kw@linux.com>
 <20210603211741.GA2141918@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210603211741.GA2141918@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thank you for the review!

[...]
> > Only expose the value of the "driver_override" variable through the
> > corresponding sysfs object when a value is actually set.
> 
> What's the reason for this change?  The above tells me what it *does*,
> but not *why* or whether it affects users.

Good point!  I am going to update the commit message with more details
about why this change in the next version.  Sorry about this!

> Is this to avoid trying to print a NULL pointer as %s?  Do we print
> "(null)" or something in that case now?  I assume sprintf() doesn't
> actually oops.  If we change what appears in sysfs, we should mention
> that here.  And maybe consider whether there's any chance of breaking
> user code that might know what to do with "(null)" but not with an
> empty string.

Yes, sprintf() deals with a NULL pointer and prints "(null)", and
I personally think that this is not very useful, especially in the case
of this particular sysfs object - I would also prefer not to expose the
notion of a NULL-value to the userspace this way, something we ought to
handle properly, see for example how the "resource_alignment" sysfs
object behaves when there is no value set, as per:

  # wc /sys/bus/pci/resource_alignment
     0    0    0 /sys/bus/pci/resource_alignment

> There are six other driver_override_show() methods.  Five don't check
> the ->driver_override pointer at all; one (spi.c) checks like this:
> 
>   len = snprintf(buf, PAGE_SIZE, "%s\n", spi->driver_override ? : "");

For an empty sysfs object, as per the sysfs recommendations, I believe
that having 0 bytes might be more appropriate to indicate lack of any
sensible value.  Using "" (empty string) like in the example above would
still warrant adding a trailing newline character, which would make it
empty (technically), but certainly not 0 bytes.  Having said that, some
drivers opt not to add a particular sysfs object at all should there be
no value for it.

> Do the others need similar fixes?  Most of them still use sprintf()
> also.
[...]

I would like to think that we should handle NULL-value in sysfs objects
sensibly everywhere, so the other cases you were able to find could be
updated.

	Krzysztof
