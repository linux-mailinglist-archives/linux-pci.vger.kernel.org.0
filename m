Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E897B214445
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jul 2020 08:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgGDGIv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Jul 2020 02:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgGDGIt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Jul 2020 02:08:49 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB45C061794;
        Fri,  3 Jul 2020 23:08:49 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id u133so4557813vsc.0;
        Fri, 03 Jul 2020 23:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Y/a/zbYT3mheg8JLw87yQei4Q/XEwYAs7jxL9Z5JTyA=;
        b=cKJb+1anPH5nx0QokPkWHc1eslRDIE7n2q60lYmUJZe1VQK3oYQhMrfx+BSxBinah9
         EkqH0pkjTZGeG/+jqTt7xVcuR22gO8kdN8uz4cyurD7XJHeZbvIpZem9aGVqfBgX9ju2
         f/Qz5CdmVy9m2YOcz21Sk31SKm2KC+0Oh3N8UPjBHz47iAXbwa09kmYfzzgGtcuA45Kw
         LCDX/ImEHUUPPcaUyorYRBTz986sb+bzkItcwKHjcqKwo3UpGfoVA0xkhWXJ2omjASpM
         cgy4zz4SxaNh4Pt2dnFF2TKPNuCU+Ox02PyROhOuzAAW1Z/ppBmO0S6tda8FA5ZbfGvV
         H1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Y/a/zbYT3mheg8JLw87yQei4Q/XEwYAs7jxL9Z5JTyA=;
        b=lfeBu7NmCOtl4ajUlxVEygPgC995Bgl67uvzPBCa7cjN7QEhHor7lnQw3ac6gSbgVj
         6d8+fHjDSkkDtoVgI7VospZUZg4scs8E0tkDoYelfGGExALdz9MLuA3cQ21tbxP+9rys
         kQ7Ipe04Z2/5i5+wKHyY7MfDdl/NAMT4Ra9eQtCT38U3tDqGcncQBTmCFhjd3QQb5PFb
         e0wNmfLRmk8b0avN26Rttw3QNua1a8DFR3tX/y92t3r0rCmO3uH2PeGeNdB8UMjBWpgi
         r29FchRoz/oetP2ujSkNVgULsKLLjMNXauguqjupDY54Phz+vmJHmECY05OPD5nYUqdd
         kUCQ==
X-Gm-Message-State: AOAM532tA6NGAZFqwITZMXlioyP+qYyY8QJnwGUk0KHOgJtv0+lzqzsm
        UFAQ5dRjBylAYQLLiHIXK0dtkmvAv4g5bDjpSRo=
X-Google-Smtp-Source: ABdhPJxmPJv+Coy9OsgrxrRmX/6vRF26FjAiHxnnt+EkjQKkjggARFe9Os8KR1MbhyAbMfgRBsxJclA/7NIzZx7L18g=
X-Received: by 2002:a05:6102:5e1:: with SMTP id w1mr21239002vsf.147.1593842928615;
 Fri, 03 Jul 2020 23:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200703212156.30453-1-rdunlap@infradead.org> <20200703212156.30453-4-rdunlap@infradead.org>
In-Reply-To: <20200703212156.30453-4-rdunlap@infradead.org>
Reply-To: linasvepstas@gmail.com
From:   Linas Vepstas <linasvepstas@gmail.com>
Date:   Sat, 4 Jul 2020 01:08:36 -0500
Message-ID: <CAHrUA35-ocneW=B+P+qjTTtBztS3ZtDcoESXOBz0sc5nSw1xew@mail.gmail.com>
Subject: Re: [PATCH 3/4] Documentation: PCI: pci-error-recovery: drop doubled words
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Acked-by: Linas Vepstas <linasvepstas@gmail.com>

for this and the other patches in the series.


On Fri, Jul 3, 2020 at 4:22 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Drop the doubled word "the".
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Linas Vepstas <linasvepstas@gmail.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  Documentation/PCI/pci-error-recovery.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20200701.orig/Documentation/PCI/pci-error-recovery.rst
> +++ linux-next-20200701/Documentation/PCI/pci-error-recovery.rst
> @@ -248,7 +248,7 @@ STEP 4: Slot Reset
>  ------------------
>
>  In response to a return value of PCI_ERS_RESULT_NEED_RESET, the
> -the platform will perform a slot reset on the requesting PCI device(s).
> +platform will perform a slot reset on the requesting PCI device(s).
>  The actual steps taken by a platform to perform a slot reset
>  will be platform-dependent. Upon completion of slot reset, the
>  platform will call the device slot_reset() callback.



-- 
Verbogeny is one of the pleasurettes of a creatific thinkerizer.
        --Peter da Silva
