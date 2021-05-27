Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D08393805
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 23:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbhE0Vfn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 17:35:43 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:40764 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhE0Vfm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 17:35:42 -0400
Received: by mail-ej1-f45.google.com with SMTP id jt22so2288483ejb.7
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 14:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mpgakV4m2DjOjxZ42IA2Grlnogqg/U74DCIUAaWI7nE=;
        b=scOCl/GfdCWyKJG6TZvozdmRyVy7oQqoWvbFMHupyADCnmGuY95ki2175MWX8GjLKo
         ASbt6xS4nVJYG2KaJQiw9Tc970YirqL+Exdo9Xx7InuRfgE7O0tNvL10mKG+2e3oQ+yM
         HvUeUn1ygN39auQ8AqIy4s30SowDiDKygjjybPwjS4/nuw5sWVCPVKHqPg4j50Waim2N
         sXJQitgeIp42+0igq4SaNLBxFyB25ooJqF8fRKeM3hkFzPdEzbAb/j9IcjG+BNF8ALZn
         Yue0BWWfmNDJ34E4rpJiKsW5SIY2ptnnQsiT05GMkj4W/M8JTObY1v0bAdeGExHGknmh
         hVKA==
X-Gm-Message-State: AOAM5322dzUlsJi8cRHZcXaUU/cTrI8LyIjqwgX2EwOA6ir0E/m+qDbm
        D+9s4sR/qkt1p9ozcYMB6cI=
X-Google-Smtp-Source: ABdhPJyp3eGDzA4LRmhaGbVptDp22Y1oj4v+EUTt27d5+WBtE5/ZkbomHMlp7INhcPX2aD0x5Ln0wA==
X-Received: by 2002:a17:906:f84d:: with SMTP id ks13mr5960374ejb.103.1622151246681;
        Thu, 27 May 2021 14:34:06 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id k2sm1492332ejx.98.2021.05.27.14.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 14:34:06 -0700 (PDT)
Date:   Thu, 27 May 2021 23:34:04 +0200
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
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 2/5] PCI/sysfs: Use return value from
 dsm_label_utf16s_to_utf8s() directly
Message-ID: <20210527213404.GA37266@rocinante.localdomain>
References: <20210527201650.221944-1-kw@linux.com>
 <20210527201650.221944-2-kw@linux.com>
 <b6f3d949ca5c1723001494a371d1a74ef0ff72ed.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6f3d949ca5c1723001494a371d1a74ef0ff72ed.camel@perches.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Joe,

[...]
> > -static void dsm_label_utf16s_to_utf8s(union acpi_object *obj, char *buf)
> > +static int dsm_label_utf16s_to_utf8s(union acpi_object *obj, char *buf)
> >  {
> >  	int len;
> > +
> >  	len = utf16s_to_utf8s((const wchar_t *)obj->buffer.pointer,
> >  			      obj->buffer.length,
> >  			      UTF16_LITTLE_ENDIAN,
> >  			      buf, PAGE_SIZE);
> 
> This should be PAGE_SIZE - 1 no?
> 
> >  	buf[len] = '\n';
> > +
> > +	return len;
> 
> return len + 1 ?

Good catch!

I left the original code as-is, and this old latent bug would remain
there.  I am glad you had a moment to review this new version.  Thank
you!

I will send v6 later and include this as separate patch per Bjorn's
request.

	Krzysztof
