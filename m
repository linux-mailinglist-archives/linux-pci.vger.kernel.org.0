Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AB838163E
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 08:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbhEOGC0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 02:02:26 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:44831 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbhEOGCZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 02:02:25 -0400
Received: by mail-wr1-f53.google.com with SMTP id i17so1140739wrq.11
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 23:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JkSeLIOi1XsqvtB3PIN4CWiYL7hLWk6kcS/roE9DJ7s=;
        b=EH9y+68UOuadJLy2AsDLrwjG9owvxQyBaAp05y6ftM6YAzh9BcDJfEFCSF6mlCHNlr
         OjM83Cvh3IMb9cHREkZ9c626e1HycagkV/H9oIwfGWLR+zBbqmcksFPhLmZoyC5bg4Pp
         SAuOHqUIKYyXQgOl0PZzz1HUHAggo+qDSfUUDA4hAz23XvbQyC3bLAGy99PqTq8Khsvu
         pSz3aCOP7d/j9L07DqczQIhtszRXOnDWLOa2m0IudypdlGkVcNCSO6rTV0W0lz9MmrxS
         3gvZPZI5hYw7DIuv0gSn7/MJrlRiS031lDcu9aOWo6fChfmSDPpsVmoGgGqPrX72C+P2
         qqZQ==
X-Gm-Message-State: AOAM531fzQIYri1Lw+8VIu7BZ2lZXmOh3bODLykfD1ZgLwyHnPbMiz2Y
        57ezHnUVaq94JNC4GGJZSAI=
X-Google-Smtp-Source: ABdhPJxHpUO8jCc/3XDGsSvDOb3m3mGWo5EJbgLdFGqxSSCd5zfY0gS/R12Oz3bbIYAWMo1NwHxbjA==
X-Received: by 2002:adf:e944:: with SMTP id m4mr20272312wrn.10.1621058472167;
        Fri, 14 May 2021 23:01:12 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d15sm5238372wrv.84.2021.05.14.23.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 23:01:11 -0700 (PDT)
Date:   Sat, 15 May 2021 08:01:10 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Joe Perches <joe@perches.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 04/14] PCI/MSI: Use sysfs_emit() and sysfs_emit_at()
 in "show" functions
Message-ID: <20210515060110.GB73551@rocinante.localdomain>
References: <20210515052434.1413236-1-kw@linux.com>
 <20210515052434.1413236-4-kw@linux.com>
 <d156a893bae41967e9fadddb3397cf47bcdde239.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d156a893bae41967e9fadddb3397cf47bcdde239.camel@perches.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Joe,

[...]
> >  	if (entry)
> > -		return sprintf(buf, "%s\n",
> > -				entry->msi_attrib.is_msix ? "msix" : "msi");
> > +		return sysfs_emit(buf, "%s\n",
> > +				  entry->msi_attrib.is_msix ? "msix" : "msi");
> >  
> > 
> >  	return -ENODEV;
> >  }
> 
> trivia: reversing the test would be more common style
> 
> 	if (!entry)
> 		return -ENODEV;
> 
> 	return sysfs_emit(...);
> }

Excellent point.  I will send v3 later that includes this style change.

Thank you!

Krzysztof
