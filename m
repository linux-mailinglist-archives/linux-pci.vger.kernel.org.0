Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F77D38FF0E
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 12:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhEYKbV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 06:31:21 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42903 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhEYKbT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 06:31:19 -0400
Received: by mail-ed1-f50.google.com with SMTP id i13so35547986edb.9
        for <linux-pci@vger.kernel.org>; Tue, 25 May 2021 03:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+cT+cE7mrQwW/ZB+CrWTnPh9477jIEln6cycHPdrXqc=;
        b=VmEcYgTm0sv/hu4wiyoeEzs/7S+v66ZVm9WjCk6KCJRA/k5wMcZxLxY06vN6BKjAdA
         xKG06jcXc8gC899SmmvQ2ynse3AyOl9VN5VnKwj4kHeNedoom+wfWjAXs3hA8hYgCRQR
         pdBsUvG8iAKwW2ySt0WgeI32qkNji1HGZPmfv0XsGbMlT6uof/oDbg5DUBd74aWXrvP8
         +v6YQSSbEusOVFDk8aT4vmeN162Mf4+Pnj5WgFmAIKuSgEpVMgiAxQ4YKeRLYY3Q1+Tq
         /re2Zd6ZaNdy8ZnPEaln13Xgkb4HYVRI+yh57WRyzufHtKkbrZH1ozTyyAOFIxAQSQup
         Nldw==
X-Gm-Message-State: AOAM531NxSCEmX5Ioo7CB0tH0JQy1x1oHPWRMf9WW358dN3/Z2LOtdMz
        JAVPN6jNNnYaHd+DE3gBsis=
X-Google-Smtp-Source: ABdhPJxpoZRg3WbiQT/YNqV6PCbccmVDGTPbdyvy3glwX5Pt5iPBvlmXaukz/SIiJVy/XJweRM6ovw==
X-Received: by 2002:a05:6402:cb8:: with SMTP id cn24mr30545249edb.325.1621938588577;
        Tue, 25 May 2021 03:29:48 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id jt11sm8924483ejb.83.2021.05.25.03.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:29:48 -0700 (PDT)
Date:   Tue, 25 May 2021 12:29:46 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 12/14] PCI: Fix trailing newline handling of
 resource_alignment_param
Message-ID: <20210525102946.GA48588@rocinante.localdomain>
References: <20210518034109.158450-1-kw@linux.com>
 <20210518034109.158450-12-kw@linux.com>
 <20210521151443.GB39346@rocinante.localdomain>
 <YKfrnG/4O0mLu4Vj@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKfrnG/4O0mLu4Vj@kroah.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Greg,

[...]
> > This probably would be a candidate for a back-port to stable and
> > long-term releases.  But, since the move to sysfs_emit()/sysfs_emit_at()
> > would be then irrelevant, I can split this patch so that it fixes the
> > issue first, and then other patch will move it to sysfs_emit(), so that
> > it would be easier to apply when back-porting.
> 
> sysfs_emit() and sysfs_emit_at() are in all supported stable and
> long-term kernel trees at this time, so there's no need to shy away from
> using them.

Excellent!  With some changes requested by Bjorn this will then be
easier to apply to current stable and long-term kernels.

	Krzysztof
