Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C35039B9CF
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 15:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhFDN1k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 09:27:40 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:44641 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhFDN1k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 09:27:40 -0400
Received: by mail-qk1-f180.google.com with SMTP id h20so9221305qko.11
        for <linux-pci@vger.kernel.org>; Fri, 04 Jun 2021 06:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TM6MYYXAmoUpOk7O2MEqMcpPIkfDqjl9B3LTGgoXlFo=;
        b=fDByYzJvsjUP0L3iIFBjGsWJYSrP5QZD+luM/xku2KSAaI5EOKeBjhssZv4f02psEY
         XTezEVvdvsURPU9P7Nw1yd3HlcJ0TeNfYmSNnbn91warkM9CyavAnO8Q7qasrLOyaDQ0
         C5vHSfKTqzOkok/j9Z1wwicvcSIq9T13i3X0VH/cZ1diu0gBVbtgSeDheC6eiDeYda4D
         5igkHzTf716M/0cINp7hcDwZGHc0vxQJtpZW8ARhxH0Iik4Xs4uupmflddzW2XbAq/PM
         2aqedevEyLkvMpfsNefPQAUgjEnb4+k1IYcxGTZ2TFfeNCZ8NZjYNI8k+WIzCwW42aCZ
         tKOg==
X-Gm-Message-State: AOAM53304eX6Oku9Wov5XH8NMNmCkaLNQF5JrI3AtiBPeEUfDf3Bp7Js
        31E4zdGC5ij0/QJrAhjgfd8=
X-Google-Smtp-Source: ABdhPJwcbzhqVpexLY75cLO5NoEgftiwhLP+pkqwI7EdcU7vCOjBL1CMmcsQiWo558XiUXVXG1BCdQ==
X-Received: by 2002:a37:c20b:: with SMTP id i11mr4497295qkm.222.1622813153474;
        Fri, 04 Jun 2021 06:25:53 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e24sm850827qtp.97.2021.06.04.06.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:25:52 -0700 (PDT)
Date:   Fri, 4 Jun 2021 15:25:49 +0200
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
Subject: Re: [PATCH v6 3/6] PCI/sysfs: Fix trailing newline handling of
 resource_alignment_param
Message-ID: <20210604132549.GA439786@rocinante.localdomain>
References: <20210603000112.703037-4-kw@linux.com>
 <20210603234052.GA2154870@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210603234052.GA2154870@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

[...]
> > +	old = resource_alignment_param;
> > +	if (strlen(param)) {
> > +		resource_alignment_param = param;
> > +	} else {
> > +		kfree(resource_alignment_param);
> 
> When "strlen(param) == 0", don't we kfree resource_alignment_param
> twice?  Once here,

Yes, we should be freeing the allocation made using kstrndup() here,
this is my bad, I completely missed that the wrong variable name was
used.

> > +		resource_alignment_param = NULL;
> > +	}
> >  	spin_unlock(&resource_alignment_lock);
> > +
> > +	kfree(old);
> 
> and again here?
> 
> >  	return count;
[...]

Yes, good catch!  I am going to send v7 shortly.  Apologies!

	Krzysztof
