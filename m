Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1655911E0
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 16:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbiHLOGh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 10:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiHLOGg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 10:06:36 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5BA74DE9
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 07:06:34 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l5so818577qtv.4
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ouy6vInqjOuz0vON38F/9ZVgEROJ+pAfxQ3Xfc7ddkg=;
        b=nN7o6VbUrD2euA5asES6oC0ESP8MD6MSuhee2Bv96GQwNScLi+uKVlW6t++DiGBXhp
         5FUcM8rIr4sFFJosr4UPORf4jkLCdGKbbJ2Cob24ZASB2m126YhMmHFoEyFPHR7oiJ4A
         h/bI1SDYCqaU/IG1nBRqkDQStl/BV6TsmHZG/QlVPk2sPC0JjIGeDWPceT34zEWwu+O/
         hTlQM1WfvNPOCcrbtzpJAd3LO9C5JBu1onKsn7ibBDq4weQl/27OiqBlyWoofA4Vtzg0
         48behcqeWzfUrrcs0T7ALc31JzS75u9+9DounHwXrpDcz/WM+HPPErdNi2ZbFvVdOo5t
         1E4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ouy6vInqjOuz0vON38F/9ZVgEROJ+pAfxQ3Xfc7ddkg=;
        b=I5fToGJXwPwkBIUHSwcA6sBHNdmmn7aaa4L1FdY4wMi/ns6dY+Vu2BYQihY0bsgVuC
         2ypIGHoGzyO0kb7jzkWGZggX04iqizlboN/LpGDW/6vJlVhimBsDsyoW3Wjx+rgs4ul+
         htXyTMTWZHTGnVYZIQ1SaGvSAnXaXb2UG0nncIS1nz8CB7mD/5GMzUHZLRp8IIKsFmdk
         baReVa377GUU9H7JEs9yD9jv3Gdoaxsy1OngieU6+ZLzNo4a7kIriL3aihzKdwvWX/19
         ustbS026vDxVvftE1cPaexXnPgDgnaPY5iH9e/gBplbLGiZ0Qhz1eFtPatLGRa06voUq
         dRGQ==
X-Gm-Message-State: ACgBeo1ZvM/0fV7nPNt9jXJbNI+2wtB+X6/gjkf3GTw9449GflvFT0qv
        LmXO/otel05hfLspp298uHJaTw==
X-Google-Smtp-Source: AA6agR5Wj9EamNRRPyGVGgGdafT7LxzQMoP311pXlxa6vuCJBrA4zpgoHglHkZhBeW+fXCtQRrnYbg==
X-Received: by 2002:a05:622a:214:b0:342:f97c:1706 with SMTP id b20-20020a05622a021400b00342f97c1706mr3577905qtx.291.1660313193066;
        Fri, 12 Aug 2022 07:06:33 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id i4-20020ac85c04000000b0034301298d30sm1851681qti.38.2022.08.12.07.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 07:06:32 -0700 (PDT)
Date:   Fri, 12 Aug 2022 10:06:30 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ren Zhijie <renzhijie2@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>, kishon@ti.com,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        Frank.Li@nxp.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: endpoint: Fix Kconfig dependency
Message-ID: <YvZeZu+xl1qDCljD@kudzu.us>
References: <cdaf434f-90d5-696f-2a60-5946ecefcf0b@huawei.com>
 <20220715212411.GA1192563@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715212411.GA1192563@bhelgaas>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 04:24:11PM -0500, Bjorn Helgaas wrote:
> On Sat, Jul 09, 2022 at 10:50:53AM +0800, Ren Zhijie wrote:
> > Hi, Bjorn and jon
> > 
> > Just a friendly ping ...
> > 
> > Is this patch be merged or squashed?
> 
> Jon has to take care of this because I don't have the VNTB patches in
> my tree.

Sorry for the extremely long delay in response.  This series is in my
ntb branch and will be in my pull request for v5.20 which should be
going out later today.

Thanks,
Jon

> 
> > > > > > >   drivers/pci/endpoint/functions/Kconfig | 1 +
> > > > > > >   1 file changed, 1 insertion(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> > > > > > > index 362555b024e8..9beee4f0f4ee 100644
> > > > > > > --- a/drivers/pci/endpoint/functions/Kconfig
> > > > > > > +++ b/drivers/pci/endpoint/functions/Kconfig
> > > > > > > @@ -29,6 +29,7 @@ config PCI_EPF_NTB
> > > > > > >   config PCI_EPF_VNTB
> > > > > > >           tristate "PCI Endpoint NTB driver"
> > > > > > >           depends on PCI_ENDPOINT
> > > > > > > +        depends on NTB
> > > > > > >           select CONFIGFS_FS
> > > > > > >           help
> > > > > > >             Select this configuration option to enable the Non-Transparent
