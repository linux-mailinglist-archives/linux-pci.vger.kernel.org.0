Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3853311B1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 16:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhCHPJv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 10:09:51 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44105 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhCHPJp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 10:09:45 -0500
Received: by mail-wr1-f51.google.com with SMTP id h98so11781700wrh.11
        for <linux-pci@vger.kernel.org>; Mon, 08 Mar 2021 07:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gMdLCoB4+yZQKOY1b5FN/ZG3ISzSW8Gw7aBhk98QEXo=;
        b=oYMayi6ij/8NcE4SxzBtacHZMoOdye5WAhMFmF+YSd84ck8c7VmKl83Kb586C9CeRD
         AqjDe049XpHWSc6lbaWE9JDp9FJkXiKSH80/HXb81ytzB0P63iTrtQhgv1gJltMN86eh
         iEaya5c+p5lj5YkB9c8U+2q4U5EnLITSuyYUEVFNoDExm5aHOdqkDt3Oco5QBsr6c896
         iqD8d0avsErWKZG/nXWTt1D9Ih8cSOlGUlsRHQYmjz/zJxR3//7laQ41NIQlMmacTITT
         ZGn1yKWLjQiwrzVjwC1PbqVrT+3gp7Wu1wpNWa/xM6niOuwHnyBDgoq0jIwOgEdXWEl9
         Y9Tg==
X-Gm-Message-State: AOAM532Za62pdPRq/wqGvUXcxRtefmklyPHzQZMclUIG1bnZvdBecYZQ
        XWs7qmtsERPdsmtxD9FuV7Q=
X-Google-Smtp-Source: ABdhPJxhlh+Tszj3dGqYMI5alMgUWHUqsDa3n52GNUsncpeBAkTaSlfcY3bkzoyd8QyUdzC36F4K9A==
X-Received: by 2002:a5d:55c4:: with SMTP id i4mr23509614wrw.84.1615216184451;
        Mon, 08 Mar 2021 07:09:44 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id w25sm19161204wmc.42.2021.03.08.07.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:09:43 -0800 (PST)
Date:   Mon, 8 Mar 2021 16:09:43 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     mj@ucw.cz, helgaas@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND] lspci: Decode VF 10-Bit Tag Requester
Message-ID: <YEY+NwBUbbeYtZlI@rocinante>
References: <1614770048-41209-1-git-send-email-liudongdong3@huawei.com>
 <YEQwTRKNmnNk1OY+@rocinante>
 <0a2925d2-5f2a-18e8-179c-f1bd6bb259ec@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a2925d2-5f2a-18e8-179c-f1bd6bb259ec@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[...]
> > Would you be able to move the "10BitTagReq" in the "IOVCtl" after the
> > "Migration" so that its placement is consistent with the "IOVCap"?  This
> > would be also along the lines of how the same files is already used in
> > the ls-caps.c file.
> 
> To be honest, I am not sure this is suitable.
> PCIe 5.0r1.0 spec section 9.3.3.2 SR-IOV Capabilities Register
> VF 10-Bit Tag Requester Supported defined in BIT[2].
> 
> 9.3.3.3 SR-IOV Control Register (Offset 08h)
> VF 10-Bit Tag Requester Enable defined in BIT[5] and this is after the
> BIT[4] ARI Capable Hierarchy.

That makes sense.  I have to admit, I didn't think of keeping the order
following which bits are set.  That's a nice idea.  I see that "DevCap2"
and "DevCtl2" also follow this approach.
 
> Howerver if we need to keep consistent with the "IOVCap". I can
> move the "10BitTagReq" in the "IOVCtl" after the "Migration".

No need.  You are right.  It's better to keep it as you originally
intended, make a lot more sense.

Also, thank you for the explanation!  Much appreciated.

[...]
> > Bjorn was also working on making a lot of the commas usage throughout to
> > follow the best practice, thus I believe that the commas there would not
> > be needed.  Having said that, it might be better to follow the current
> > style present there at the moment.
> > 
> > See 018f413 ("lspci: Use commas more consistently") for more details on
> > Bjorn's work to normalise the usage of commas.
> 
> Good suggestion, will fix.

Thank you!

> > Additionally, with the new fields, would you also have to update some of
> > the tests files?  For example:
> > 
> >   Index File                Line Content
> >       0 tests/cap-dvsec-cxl   81 Capabilities: [b80 v1] Single Root I/O Virtualization (SR-IOV)
> >       1 tests/cap-dvsec-cxl   82 IOVCap: Migration-, Interrupt Message Number: 000
> >       2 tests/cap-dvsec-cxl   83 IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy-
> >       3 tests/cap-dvsec-cxl   84 IOVSta: Migration-
> >       4 tests/cap-pcie-2      50 Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
> >       5 tests/cap-pcie-2      51 IOVCap:  Migration-, Interrupt Message Number: 000
> >       6 tests/cap-pcie-2      52 IOVCtl:  Enable+ Migration- Interrupt- MSE+ ARIHierarchy-
> >       7 tests/cap-pcie-2      53 IOVSta:  Migration-
> >       8 tests/cap-ea-1        59 Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
> >       9 tests/cap-ea-1        60 IOVCap:  Migration-, Interrupt Message Number: 000
> >      10 tests/cap-ea-1        61 IOVCtl:  Enable+ Migration- Interrupt- MSE+ ARIHierarchy+
> >      11 tests/cap-ea-1        62 IOVSta:  Migration-
> > 
> OK, will do.

Superb!  Thank you!

Krzysztof
