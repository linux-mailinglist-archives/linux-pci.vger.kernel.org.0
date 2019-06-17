Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D849177
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 22:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfFQUg5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 16:36:57 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42016 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFQUg5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 16:36:57 -0400
Received: by mail-oi1-f193.google.com with SMTP id s184so7711712oie.9
        for <linux-pci@vger.kernel.org>; Mon, 17 Jun 2019 13:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUuONrlgmwtIZdvsw0S0/4Mq9T1WyA1gy6J4VLXnacI=;
        b=iJnOfDSpsfcRrkO7Z3UmtsU/3SdEZ7eTfjySEwglR4kCk3eP1rlaXEv8n0WSdyQhgA
         KaWNKrnvNbK3Ivdrsdf3WrCRENxklnMUOfkYt77DH4iUmhsBJjRM+eotXHjLnTJ0fpft
         IRATZl7xjDYDdLodZoW7pDj5e/et1XUyWXubUfGW4vRD1RKoqQhNZy2/KBjKy8cusMgh
         2woSBHrnLGC1xQF+N5ZRLi9uSQi5GRNsM2OXCHe8Pv4k1LMuUVnyUieU8WnCi9CQp/zd
         XBqL0kuZ9/hoegyaGxXD87pJJNEmxb5JL0BejjNLkP1oeIbdjPfVsh40yBVMT2gDQuUx
         ng8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUuONrlgmwtIZdvsw0S0/4Mq9T1WyA1gy6J4VLXnacI=;
        b=IKhN1a+s4WsiaKIP0Us1QAnsui7Vc2bb3RkSAjUIu0w4DKDvVQ+dbACv4A2FZ1QmD1
         SxlCgGfKwRKPHu213DZgCrxH5uk1jJQgd+421YLg3tdsxgd0OkPBYt/Qx3s9gU9kju2F
         fHOMwrGnjYpoeqG8ghyhMlOV2XoLdOMNSuuM25IzrWBAHo+6C7MGrDk1VbwD1zQv7N4R
         JtW4RqSBi+GNDB0O8E92S5Ev2IoSktrwtbeTSycYfNhFiLoej8HmOrm5skjefyoZQMFj
         S4GQUk8vbKDFDFN38mN4V/Q+SoEYuEIODnC7c0ndE4fkcH79vxFrh4eksETfoKB8MvYK
         X2Cw==
X-Gm-Message-State: APjAAAVYwqqtOoSqhAlM0qZ3+cLCGLvy6CaooOsr1o1sUWvGA3uYxWeA
        6aZm1pDW4p1PcphrjIdwdPJyTI62q8fRDnwSOqkfug==
X-Google-Smtp-Source: APXvYqyP6F9zlBzZPah8lr14kIAj+Xnb/4HPIraAg3Phba4tJ1HESSkAprhGKci8EGOWV3IPPT/MSOptYr7l5lvozUE=
X-Received: by 2002:aca:3006:: with SMTP id w6mr9263oiw.5.1560803816566; Mon,
 17 Jun 2019 13:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122733.22432-1-hch@lst.de> <20190617122733.22432-8-hch@lst.de>
 <CAPcyv4hbGfOawfafqQ-L1CMr6OMFGmnDtdgLTXrgQuPxYNHA2w@mail.gmail.com> <20190617195404.GA20275@lst.de>
In-Reply-To: <20190617195404.GA20275@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 Jun 2019 13:36:44 -0700
Message-ID: <CAPcyv4jhhEbLDi82gVw7GLASEtqU=U7Ty67AGwTijmzMqw8X8Q@mail.gmail.com>
Subject: Re: [PATCH 07/25] memremap: validate the pagemap type passed to devm_memremap_pages
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 17, 2019 at 12:59 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 17, 2019 at 12:02:09PM -0700, Dan Williams wrote:
> > Need a lead in patch that introduces MEMORY_DEVICE_DEVDAX, otherwise:
>
> Or maybe a MEMORY_DEVICE_DEFAULT = 0 shared by fsdax and p2pdma?

I thought about that, but it seems is_pci_p2pdma_page() needs the
distinction between the 2 types.
