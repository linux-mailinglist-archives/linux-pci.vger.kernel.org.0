Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EADC591205
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 16:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbiHLOOj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 10:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239149AbiHLOOZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 10:14:25 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFFB1F604
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 07:14:24 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id l18so668009qvt.13
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=l55CP5XbR8pOe/7SbfCSQOl6G/Q9bIK3WGKGQ3uUmWY=;
        b=keayM69VSpaFonBMifhHQ23YrbU1pwRFlRsRbeSaXRVqxwjEjXaPKebCKbwAqPc5Kt
         4S+BcG2wrM2X0X7Ki6PnJXDCuE3nfW1ALTjI3tMZIklW+zKI8c06ZVL+nuaHaw4cWei+
         am6C659TdJrqMqJ8A/tpTxZdbOYYg0voz1zKsB7GbpZ6huwO3e1uEUKHXAgTkmpczEs6
         E3+iIDxDf2IUOEWwiLT0yUFo1TRpx1NBba3ZMzPlHLQTPM1Z/xYV1skeaOcXb/0k2iRl
         K2fKgH7j4wTUen9/61kuGMSBbiZNEh4uRFyDC4TNum1SEXqSknPgQgbBszzcNE0leO4H
         F81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=l55CP5XbR8pOe/7SbfCSQOl6G/Q9bIK3WGKGQ3uUmWY=;
        b=nXiSojOHx3oUJ9YHsc8cmLM1Map7cDmebP0koIWRZbTx+gBes7WUOegTV3Y/koVXJ+
         +DnCYqdaAU4yxkXeCUdsDL9Rb0tg+54nh7T9ucYeiyiERZ01xtWru8IvwadRvo6e1G5M
         /zzq+nNhQMRkFibsa/MWW27i9deIrT7qnT/4cnjlfsWUpKuCfjPxpnaonoImVNJFCahr
         nysZD8rPjetXZbFNi5PNbgXYLayCf+uhmphaJmtuWUukGQ7eh6G4VXz3of8XJmo8A07K
         7ODyt5HNmxICJXPNUoVdzFnyknZ/311tPeOO2hUqOPwom1XMBukYEFi0rvXovhnM28i+
         wbjA==
X-Gm-Message-State: ACgBeo35dw7aodjTj9JmWsiR60vaQj+X76kbUFqPc6yBleUej4yMApeO
        82zUfYVjhyYmcXBILkSniHGMXA==
X-Google-Smtp-Source: AA6agR6SMZVoEA0CNMqRZY12kN/d631rbWF+Ag8y1oarDOYfCdXWSUbODLK8qbVC0GLT9FoAX2ot2Q==
X-Received: by 2002:a0c:da8e:0:b0:476:fa44:ea0f with SMTP id z14-20020a0cda8e000000b00476fa44ea0fmr3422977qvj.115.1660313663946;
        Fri, 12 Aug 2022 07:14:23 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id o13-20020a05620a2a0d00b006b9122642f5sm1838892qkp.75.2022.08.12.07.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 07:14:23 -0700 (PDT)
Date:   Fri, 12 Aug 2022 10:14:21 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>, kishon@ti.com,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        Frank.Li@nxp.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] NTB: EPF: Mark pci_read and pci_write as static
Message-ID: <YvZgPQGCFDDUPeTU@kudzu.us>
References: <20220708020035.8071-1-jrdr.linux@gmail.com>
 <20220712194936.GA790126@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712194936.GA790126@bhelgaas>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 12, 2022 at 02:49:36PM -0500, Bjorn Helgaas wrote:
> On Fri, Jul 08, 2022 at 07:30:35AM +0530, Souptick Joarder wrote:
> > From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
> > 
> > kernel test robot throws below warning ->
> > 
> > drivers/pci/endpoint/functions/pci-epf-vntb.c:975:5: warning:
> > no previous prototype for 'pci_read' [-Wmissing-prototypes]
> > drivers/pci/endpoint/functions/pci-epf-vntb.c:984:5: warning:
> > no previous prototype for 'pci_write' [-Wmissing-prototypes]
> > 
> > mark them as static.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
> 
> IIUC this series is going via Jon.  Let me know if I need to do
> anything.

Sorry for the extremely long delay in response.  This series is in my
ntb branch and will be in my pull request for v5.20 which should be
going out later today.

Thanks,
Jon

> 
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index ebf7e243eefa..111568089d45 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -972,7 +972,7 @@ uint32_t pci_space[] = {
> >  	0,		//Max Lat, Min Gnt, interrupt pin, interrupt line
> >  };
> >  
> > -int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
> > +static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
> >  {
> >  	if (devfn == 0) {
> >  		memcpy(val, ((uint8_t *)pci_space) + where, size);
> > @@ -981,7 +981,7 @@ int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *
> >  	return -1;
> >  }
> >  
> > -int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
> > +static int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
> >  {
> >  	return 0;
> >  }
> > -- 
> > 2.25.1
> > 
