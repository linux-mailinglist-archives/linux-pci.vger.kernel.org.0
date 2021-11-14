Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E8B44F654
	for <lists+linux-pci@lfdr.de>; Sun, 14 Nov 2021 04:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhKNDkN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Nov 2021 22:40:13 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:40769 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhKNDkM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Nov 2021 22:40:12 -0500
Received: by mail-lf1-f43.google.com with SMTP id l22so33224944lfg.7
        for <linux-pci@vger.kernel.org>; Sat, 13 Nov 2021 19:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fu4fzInvccWJH5qlQyFo9/55jqJ9+GftHv+kByBnqz0=;
        b=gZiwrI+qmLTFWY7zEtfeqNo+wkP01o4DV5OUbx1v5RGKDygq37Vc6D4+exnQQ24fQV
         ZF1ilgbHTeQxwQSKMBfxBxfKrY2agFgRRsB90BpiNxJ9zZ+nR94ToFzwLUPOKlP81cCw
         0XqXUTTNfWx5cnMtDsqgufjPyZPVLeQpA2fJ50VkB8jCvA2Fjl+6+n81yE5Ok0xNwO2/
         /nztuSRQeoCxxd12z3q2wEt04/37igB+UT/CCUxHQqGjm3aUOPTyF9gCjznRwTYj6+77
         PKuys4fKLr3QSFVtSl0b+asBBXKlymCBUL5ljZDDg+XsmA42+Of08BsS2QGEV1QF1mrf
         hgvA==
X-Gm-Message-State: AOAM532gcWNbTHhZuoKESJ731jIvKyq3UrlVl76zP1kDXvzYDiS6fePk
        cxOmTEj8zKBqpe0UUVfyMEM=
X-Google-Smtp-Source: ABdhPJyGmBlzHI2eOMbfte8P3J4h1aZZftqa0OIs0Pdx96y+IloCRpnCskVdQKfKoMJ0CKbPUSm/PQ==
X-Received: by 2002:ac2:4c81:: with SMTP id d1mr10898365lfl.588.1636861038674;
        Sat, 13 Nov 2021 19:37:18 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y32sm1025103lfa.171.2021.11.13.19.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 19:37:17 -0800 (PST)
Date:   Sun, 14 Nov 2021 04:37:16 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Fan Fei <ffclaire1224@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: Distinguish mediatek drivers
Message-ID: <YZCEbMP3Mw+hHDAw@rocinante>
References: <20211105202913.GA944432@bhelgaas>
 <98d237693bc618cba62e93495b7b3379c18ac6b5.camel@mediatek.com>
 <YYlHzMGAdO1eOQLn@rocinante>
 <0982a0743a2e6fd5678719db0ac6ee74b54f3ee3.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0982a0743a2e6fd5678719db0ac6ee74b54f3ee3.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> That's really a good idea, yes, we can combine both drivers into a
> single one. 
> 
> But the real problem is that the old driver has been used to a lot of
> platforms and it works stable for now. When we combine these drivers,
> we will have a very huge effort to adjust the driver style and test it
> in all platforms.

Some very good points, indeed.  The idea seems like a good idea, but in
reality it's not feasible, like you say.

Thank you!

	Krzysztof
