Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE22341C8B2
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 17:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345385AbhI2Prr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 11:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245736AbhI2Prp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 11:47:45 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC45C06161C;
        Wed, 29 Sep 2021 08:46:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id dj4so10734587edb.5;
        Wed, 29 Sep 2021 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vSb1TNpNZzqVv8bS20GQ0eXTwvtkrrxT72wlhx2kJsk=;
        b=HPqnK0r7WgoPGzlJ4lz13MjJBztLXPj9CKhdgCPzIMoSodqahafgW2OulNd/Ah7PEu
         MnvOyiVSAvYaS2U/JO+Y/kAsf4ZrNzN+Idxl8+UMLyrqfgwYzw8zEOSy85mvgEaFQmuG
         eREHsU2rKtG1+L0FLbCXwaisy3eIKeX7Q3tRRDhiJzUQRnmSE4Xd9z3igd225jp91iN2
         EMsytxSOIf2oi3F1uN0YrX+7O5c1K8kt7Nub0VsCvMWqZzY39anwD3OBVLGV6OjS9Ewb
         XvpfThzSM59JnKEoaTQcCYvg6guJjXVQQixtxh2LgGm1qzsi/JRNrt05UGMipO1HzgQE
         G4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vSb1TNpNZzqVv8bS20GQ0eXTwvtkrrxT72wlhx2kJsk=;
        b=nlxskcTpwe4UFzw2Xv60pHRJ9FFhMWtNZeW2SsYETdVU3nAcbECkTuSfec6SkrwRgm
         ldSRsboB5349d3ETlYjkQVFFLuA0G3ZgJsXgD1sE9cgNcvq9K5GAF51oIfUcP7cgFUk7
         1zirXdJSIjiEjK5RihZMSr6MeSH+YNLcFVkDmSi4Z48H5gAidmLrxsJzNN0wNr3iF4ip
         yTfEIaNuxhJPs46EYCw0GXLx+sEvXj6si2zm5HB9gAqrtenmOnVw/rQmC3O6yEUVoq9o
         RhxH5ujAoCjtdIrlKFVoChOwG6TrDzEi2S+HR/Py8x2YX1W6TpoR7ixWo4VQAihssQKh
         W7ow==
X-Gm-Message-State: AOAM532zWsq83dXHiD9OddyvLVX0qSqx7/0hZnRNukAaVLRmGJSPSnK1
        CLgec1LUg8rXmEAf0/vPJ8JDQWat1sszgD46SN8=
X-Google-Smtp-Source: ABdhPJwog2XFbZkmx6aqnESTHTZwapBu+Pl0+rooI9Sd+aZgi/waJZeS9/S0RCwbBDE5MuNm3hEmxqmSNHg3QxPQrg4=
X-Received: by 2002:a50:e142:: with SMTP id i2mr651916edl.107.1632930306381;
 Wed, 29 Sep 2021 08:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210929133729.9427-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20210929133729.9427-1-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Sep 2021 18:44:29 +0300
Message-ID: <CAHp75VeShObZoLO_P5ZFYvR-4wr2Fpfpc9gojJB5a4LQne3pPg@mail.gmail.com>
Subject: Re: [PATCH 0/2] device property: Remove device_add_properties()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 5:18 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> There is one user left for the API, so converting that to use software
> node API instead, and removing the function.

All look good to me, thank you for removing the old API!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> thanks,
>
> Heikki Krogerus (2):
>   PCI: Use software node API with additional device properties
>   device property: Remove device_add_properties() API
>
>  drivers/base/core.c      |  1 -
>  drivers/base/property.c  | 48 ----------------------------------------
>  drivers/pci/quirks.c     |  2 +-
>  include/linux/property.h |  4 ----
>  4 files changed, 1 insertion(+), 54 deletions(-)

-- 
With Best Regards,
Andy Shevchenko
