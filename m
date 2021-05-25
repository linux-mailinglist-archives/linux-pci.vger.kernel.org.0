Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B6738FF52
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 12:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhEYKgO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 06:36:14 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:47086 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbhEYKea (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 06:34:30 -0400
Received: by mail-lf1-f49.google.com with SMTP id i9so45304926lfe.13
        for <linux-pci@vger.kernel.org>; Tue, 25 May 2021 03:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gpq0sTlIEeyuerZRXSFn/dk/TINYPNGZ2+f19AY1ln4=;
        b=DVozopij8Kbqurb+ym5+5hD+q0Ih0Zx4it0/zbWnw5sVe9VCCGfwEEwA4NaQaub6i/
         n6DjSCs7Sq16PXFN5KxkQsRIABbCGTDt3hkIkWaKFMWlbKc+8BKZl9Rn1o/iTUXn465k
         LOTOjNUGSJH7Jg3Ydu2XxpVDRKV8neBZ+n1HYuO64ulL/SGCJlk+DftVg9thhAH9TQ5b
         S8DN9jel1W6NFPHq5KQEM5ko3NlYBOONZ5S4yV7Jmt+0r77ECSE5/nxaacRGdUngOlTb
         R5xomXOgtmZOXOl5CF811pQXPKUTBbDDj8hLnvsj4PTm6XF62l6BHyT5hUWnrQ7FCTqU
         LAhg==
X-Gm-Message-State: AOAM532oM0dA80WMMpDsk04DC/gSwYZFT1VMQvpX/v60n7upqrQBNxVb
        selJ4nuWEcK9uI9lZ9M+i+w=
X-Google-Smtp-Source: ABdhPJzPtHr1o7fPdMge3lvm5gr61JziyQMArQhsiTaPX54/Di0iWgBWpLfI5hz0StKfk3+M1S9fVQ==
X-Received: by 2002:ac2:5dd6:: with SMTP id x22mr13330862lfq.373.1621938779308;
        Tue, 25 May 2021 03:32:59 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f16sm531787lfm.260.2021.05.25.03.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:32:58 -0700 (PDT)
Date:   Tue, 25 May 2021 12:32:57 +0200
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
Subject: Re: [PATCH v3 03/14] PCI: Use sysfs_emit() and sysfs_emit_at() in
 "show" functions
Message-ID: <20210525103257.GB48588@rocinante.localdomain>
References: <20210524211430.GA1123248@bjorn-Precision-5520>
 <20210524211934.GA1124194@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210524211934.GA1124194@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

[...]
> > I really like this, but I would like it even better if the
> > sysfs_emit() change were easier to review.
> > 
> > It seems pointless that the current code uses strlen() when
> > scnprintf() and dsm_label_utf16s_to_utf8s() both have that
> > information and we just throw it away.
> > 
> > I think it should be possible to split the len and
> > dsm_label_utf16s_to_utf8s() changes to a separate patch, which would
> > remove the need for the strlen, and then the conversion to
> > sysfs_emit() would be completely trivial like all the rest of them.
> > 
> > My goal is to make all the sysfs_emit() changes look almost
> > mechanical, with the non-trivial parts separated out.
> 
> And BTW, when all the sysfs_emit() changes are trivial like that, I
> would probably squash them all into one patch that converts all of
> drivers/pci/ at once.
> 
> That would still leave a few separate patches:
> 
>   - This dsm_label_utf16s_to_utf8s() change
>   - The resource_alignment newline change
>   - The devspec_show newline change
>   - The driver_override change

Got it!  I will send v4 updated as per the above suggestion.  Also, if
Logan does not mind, I will carry his "Reviewed-by" over as there will
be no changes to the actual code, just how the patch will be arranged.

	Krzysztof
