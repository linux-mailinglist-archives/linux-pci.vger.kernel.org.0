Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18C4422C31
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 17:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhJEPTc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 11:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhJEPTc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 11:19:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42CFC061749;
        Tue,  5 Oct 2021 08:17:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r18so211239edv.12;
        Tue, 05 Oct 2021 08:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9hjpAihAR6YOSiSaQW5lhvO8nzkCGkYP9LUxetB1V8Q=;
        b=nfdimCVqznTmDhQze5hARq+nK7zj3ZB5R0YKCwedKXrszipibl7pOr80QRwrwS2rsI
         irpjxtxHlySjjHZMTOwUL35v8IUAy2HOz/obqJq9aMJWKyeWI0LtXq2G5t89ZNTMWYzK
         AiMMB5bK8yw7ONk3xovxIGIKOM5x5GqzxwydlYdzx6zmTMTOKucWt3Tq+63QFDKgy7P6
         39ehN2wKXV9sEnlOWymM8bcqvXxUMKs/qGeZ2641MpHUNGlAHRthPPsXayJTo63QgjxJ
         XzB5X3tyL5AyP3GX1Z2gbeEf2POeu4sTVpbxa4K/xBbdE8jjzOh+vlGqpfyjA8DaWag6
         iMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hjpAihAR6YOSiSaQW5lhvO8nzkCGkYP9LUxetB1V8Q=;
        b=T0St1IuJN03ZX1V9tv8/z4enlY6kTli58SaQrGyU0lLrRWu6vu0sRMndqE/2pEvGFr
         OPuxHmaaE5ZI82b9gMpUEKjQqtxY6A0RNly7EqZELLBfAyhnKAV2rj4cBJrP5QtFWIin
         bc4PAhIW39fVyhH4ARla84+rYveaz/3xTFHZ8347o2gWaKpaMIz7wLasjXRnSFSZpVwR
         Nglfnllt0KIcqtarzSHkiK96diprvQt5Fht+PdBLa17XbCtYnilIGFrETIca+zIUl9L2
         T7T4AdMFIW1ixY69Oma/+ml3mu+LVC1bXEFW1m4b7TSNWdWH3KdHzKWktkppVQlLKtYN
         RtVw==
X-Gm-Message-State: AOAM531KnBmOtNYU9jppk1sKpjHdXaRZlQ3nu7sjr1JqagN/DLUDnfMD
        lqIIYNpqj6X0DnimucHbMXEEc1XG7w/vbRDPFu1oaueu7lg=
X-Google-Smtp-Source: ABdhPJxwT+fMV3gyNDVa4lAUwShZTN5isQxaxxx4ZWIdH3lf9FoCrbCpyqY/SJGkxs9ZONMxu7JtsKVESxBgrZH3byA=
X-Received: by 2002:a17:906:eb86:: with SMTP id mh6mr7584934ejb.141.1633447060019;
 Tue, 05 Oct 2021 08:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211005151445.89620-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211005151445.89620-1-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Oct 2021 18:17:03 +0300
Message-ID: <CAHp75VdR7Dn+621YewmePRXxb6wbxTGZK8GHcUVDiDbQxho+Rw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] watchdog: wdt_pci: Correct the PCI ID vendor name
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 5, 2021 at 6:15 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The proper name of Acces I/O is with a single 's'. Correct it respectively.
>
> While at it, convert to use PCI_DEVICE() macro, drop unneeded initializer
> and comma.

Scratch it. 8250_exar is using the wrong vendor ID as well.

-- 
With Best Regards,
Andy Shevchenko
