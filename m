Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8E340BCF2
	for <lists+linux-pci@lfdr.de>; Wed, 15 Sep 2021 03:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhIOBNZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 21:13:25 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:44663 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhIOBNZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 21:13:25 -0400
Received: by mail-lj1-f173.google.com with SMTP id s3so2028748ljp.11
        for <linux-pci@vger.kernel.org>; Tue, 14 Sep 2021 18:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WZ+/BGVOLTxH1lG3Gwo2OsUrzq+1DkThVouPppJAqAs=;
        b=MDW6hHYk7GkWJZdZkfh+uOjMFIGrBc6HZ7RxmrS0XLldTLIDALsyaN26UNT5+w7gi2
         QmfELNyZwicqyW509xkhaGEbaJcyYI6P6zGEHD5sKkUSVfakGAnL78Q0R7AoTyX2tuYo
         IUxWZ2Nv2aVviIBGqlt2QY16zaUiH1gSg3D4FNy/RmI6Ddz+IuzP+jqXIad7Z0UT8aP4
         M2VML7VIhXtTMApNc7EAcD0su6hSTF4weXC23BzsV4TtaHXHI/bfGIX9BeLCpHOKHx6p
         unJZB7iDG/rHPn4trIeBnq22mIkDoS8u54jkJPIeDmaLcgs59tlcP/lldxUco14IkJ6E
         xDig==
X-Gm-Message-State: AOAM532iFDN//DcJYQRa2rABmgoQ26QyiuURJdpj9L2+znnfugNTgFhD
        phFCFdEK4erRzzKIEwQ6i7Q=
X-Google-Smtp-Source: ABdhPJw73/H51GAScDr12MAHL4DlYYbvt8K9ckArZKz69vs4q35uwU4SsV1Sx3mD3+D+knHZO/6GIA==
X-Received: by 2002:a2e:b53a:: with SMTP id z26mr17150840ljm.95.1631668326406;
        Tue, 14 Sep 2021 18:12:06 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id i2sm508186lfo.146.2021.09.14.18.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 18:12:05 -0700 (PDT)
Date:   Wed, 15 Sep 2021 03:12:04 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI/sysfs: Move to kstrtobool() to handle user
 input
Message-ID: <20210915011204.GA1444093@rocinante>
References: <20210706010622.3058968-1-kw@linux.com>
 <20210914203829.GA1454594@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210914203829.GA1454594@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

[...]
> > A common use case for many PCI sysfs objects is to either enable some
> > functionality or trigger an action following a write to a given
> > attribute where the value is written would be simply either "1" or "0"
> > synonymous with either disabling or enabling something.
> > 
> > Parsing and validation of the input values are currently done using the
> > kstrtoul() function to convert anything in the string buffer into an
> > integer value - anything non-zero would be accepted as "enable" and zero
> > simply as "disable".
> > 
> > For a while now, the kernel offers another function called kstrtobool()
> > which was created to parse common user inputs into a boolean value, so
> > that a range of values such as "y", "n", "1", "0", "on" and "off"
> > handled in a case-insensitive manner would yield a boolean true or false
> > result accordingly after the input string has been parsed.
> > 
> > Thus, move to kstrtobool() over kstrtoul() as it's a better fit for
> > parsing user input, and it also implicitly offers a range check as only
> > a finite amount of possible input values will be considered as valid.
> 
> If I understand correctly, a user could enable things by writing "5"
> today, and if we switch to kstrbool(), that will no longer work.

Correct.  After this change only the range values kstrtobool() allows would
be permitted, thus the ability to enable something (or trigger an action)
simply through the virtue of sending a non-zero value to a particular sysfs
attribute would not longer work.

> I'm sure everything is *documented* such that one should write "1" or
> other sensible values.

We document handling on non-zero values for the "remove" sysfs attribute,
but the user might indeed make identical assumption for other attributes,
aside of assuming that using 1 and 0 would always work, which also has
become customary for /proc and /sys and is now part of the canon, so to
speak.

> But I'm not sure there's benefit in adding new restrictions.

I personally would welcome API update and adding consistency that
kstrtobool() offers, but we can keep existing behaviour so that there
aren't any surprises in the userspace.

I will drop this patch in the next version.

	Krzysztof
