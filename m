Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BC83B4EB1
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jun 2021 15:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFZNKG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Jun 2021 09:10:06 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:34716 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhFZNKD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Jun 2021 09:10:03 -0400
Received: by mail-ej1-f54.google.com with SMTP id hz1so19858708ejc.1
        for <linux-pci@vger.kernel.org>; Sat, 26 Jun 2021 06:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MFmzWPaICgQKfUE6DH530FJdeTKwHLM6NKQU0J+Lo/A=;
        b=GLwkzbFErLytFgLbISdggmv/p23bTGbkAu0L+nVNZP0CwjyAgC3ui3Mc8nBHtwnz76
         hNxGcIMOkZz4Ij0WHGQAht5V4JZLTo1AbVRTzvBP7kj34d/zT5dK10OLRtvkwXgk3NRd
         TjjhiNt+CMvJ9GeS5qTEcYp5ktbZpPnRrTpBifLoA8mhkl9AJLcNocVrCP9gdPJNdy0L
         KSeBKHp+NCVv2UDuYzKvYslOGyUotMdj6YsmjE8An4TxngZhJsWjq34cbojj4Ne+dEko
         WMR+o1nwtFnimxhgx1fUVz8W9JiP9OzimsWxWn1wPBFgRv5OWMo5f3k/SsTfjOsFa8UE
         YZ8A==
X-Gm-Message-State: AOAM532s0ZoIzn0W1tUNR5r2OXdRuBeU/Wi8wJ2P3xSNSHVqlBzYQp/d
        Z3nrEmP6xWYJKqQvzsYeSlo=
X-Google-Smtp-Source: ABdhPJxEaWv3LvXj7xiF0gsuXgEEbsKuAwjGTrVk7nRRr5Sas9qMwWhk7cUK7/jO+cR5hGgbtlBXwA==
X-Received: by 2002:a17:906:3884:: with SMTP id q4mr16208827ejd.66.1624712859683;
        Sat, 26 Jun 2021 06:07:39 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f18sm5830378edv.95.2021.06.26.06.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 06:07:39 -0700 (PDT)
Date:   Sat, 26 Jun 2021 15:07:37 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI/sysfs: Pass iomem_get_mapping() as a function
 pointer
Message-ID: <20210626130737.GA23671@rocinante>
References: <20210625233118.2814915-1-kw@linux.com>
 <20210625233118.2814915-3-kw@linux.com>
 <CAPcyv4i-2QkpXbX_Uh7=ArbLgs1PtUdk5+wQ6fQPYaOPdBiVDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcyv4i-2QkpXbX_Uh7=ArbLgs1PtUdk5+wQ6fQPYaOPdBiVDQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dan,

[...]
> Looks good. Since I did not write any of the below go ahead and change
> the "Co-authored-by"  to:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thank you!

> Thanks for picking this up and carrying it through.

Of course, any time!  Also, thank you for suggesting how to solve the
problem we've had and for sending the initial patch!

	Krzysztof
