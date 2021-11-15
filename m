Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A51450429
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 13:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhKOMOh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 07:14:37 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:35833 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbhKOMNn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 07:13:43 -0500
Received: by mail-pj1-f45.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso13033292pji.0;
        Mon, 15 Nov 2021 04:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=R7Bhw1s2l3Tgck2/bS++QRocplNsZLoymRa6wb+BhLs=;
        b=eQ6KhUfot/qwHA3u0pD5+KGsvgZeJsOLGYtKJavDlmrVBTBB+QMSpGXs+OxzT303vJ
         C2/6nBXZU09WVYyXB6kmWzobhx3bMWb+Aeqp87W3DeG/uOl3/1I2mg33H1XSBuxvWT7u
         JxKFVjQZD62cZ9bJPBiUWghoz3r7ZwqoJyk6GNXo2wv8rd1WUx0FWueolClcqI4EynZn
         lITNa/7wwgpLvGgZMtJz+qxdipPFQmvPkwcDqRSK8+MGpCKC7iHO2WM556O8nRA/hsXb
         Pi1hYD9VIpfwOU0V/mU2t9kiDAtvnBp0tnyvMGnlmP5s1TgAReeschXS0PN2eFCadO4S
         WUxg==
X-Gm-Message-State: AOAM530c3J9LSez6he4X8vPAuUS/bsS+aoPxQ6lNabXXl2G7E01ckINS
        UZ9LsHu++zMsMbiaBmPDfYY=
X-Google-Smtp-Source: ABdhPJxcO0UmpwWy+nbZGBqgX0oR/o0L1PCSBb2zS/fubjuGgM+v/V1Mm76TCxM/fjVQNcdYVP325g==
X-Received: by 2002:a17:90b:390f:: with SMTP id ob15mr46308630pjb.32.1636978247716;
        Mon, 15 Nov 2021 04:10:47 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id a11sm14907885pfh.108.2021.11.15.04.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 04:10:47 -0800 (PST)
Date:   Mon, 15 Nov 2021 13:10:39 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] PCI: probe: Use pci_find_vsec_capability() when
 looking for TBT devices
Message-ID: <YZJOP7kgh4XxNpqe@rocinante>
References: <20211109151604.17086-1-andriy.shevchenko@linux.intel.com>
 <YZCDHxOwogxPpuWy@rocinante>
 <YZI3dJ59DxE0GWWv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZI3dJ59DxE0GWWv@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

> > Nice find!  There might one more driver that leverages the vendor-specific
> > capabilities that seems to be also open coding pci_find_vsec_capability(),
> > as per:
> > ...
> > Do you think that it would be worthwhile to also update this other driver
> > to use pci_find_vsec_capability() at the same time?  I might be nice to rid
> > of the other open coded implementation too.
> 
> You mean https://lore.kernel.org/linux-fpga/20211109154127.18455-1-andriy.shevchenko@linux.intel.com/T/#u?

Ohh!  Thank you for doing it!  Sorry for mentioning it twice then, I wasn't
aware of the conversation there on the other mailing list.

> It seems a bit hard to explain HW people how the Linux kernel development
> process is working. (Yes, shame on me that I haven't compiled that one)

I see what you mean... (after reading the linked conversation).

> > > Currently the set_pcie_thunderbolt() opens code pci_find_vsec_capability().
> > 
> > I would write it as "open codes" in the above.
> 
> Hmm... Is anybody among us a native speaker (me — no)? :-)

Admittedly, neither am I, so hopefully Bjorn (or other native speaker) can
chime in.  Albeit, it's probably not worth spending a lot of time over.

> But if you think it's better like this I'll definitely change.
> (I admit I'm lost in a morphological analysis of the above two
>  words)

Sorry about that!  It was simple something I noticed while reading the
commit messaged - looked somewhat different than the usual to my unskilled
and untrained eyes.

	Krzysztof
