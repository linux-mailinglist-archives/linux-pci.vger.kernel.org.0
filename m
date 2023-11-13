Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753DC7E9C0F
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 13:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjKMMW2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Nov 2023 07:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKMMW1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 07:22:27 -0500
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F05D47;
        Mon, 13 Nov 2023 04:22:24 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1cc0d0a0355so30859995ad.3;
        Mon, 13 Nov 2023 04:22:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699878144; x=1700482944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0mX4oPtfqlWX2A6en/xocL7l8R1twfrToxxD0o8VRE=;
        b=qlyXlBslRSJslTXC1EgO8bthqKBNJix4Zi6Pb84ppvbELLlegUjdm4cnATV5pWpTl/
         s1j2+kstV5ru2yJew1XM6I7SChAXzTacbJv+2crSKfHsqtF3SrblZVUNeAGOcYxegiGt
         knJ2pHz/XJxQpdqVldQ6K97xx+dQgx1+u2j75T8JDsCxIQg8w/2pMr5zEovtze4p5Iiu
         rjWe8RzcKEZUC0UmU9d31xjDOkHTgV/C/yQk7ehYrXMqqTOONfL2asYllKDtCPKbtv4S
         RaV123aTgwhOtI67rHIK9fpDwyj0GFdW/XNqmIFPXtO9MeTobUK6KLwvEm4h91wVB3LN
         zaJw==
X-Gm-Message-State: AOJu0YyY98q0tFsraMfmu7nD99oyqK3q0f9wMEbKAMs65q0bIbi3W5ty
        iYgkDedz9+novXFL/j04+no=
X-Google-Smtp-Source: AGHT+IGWpLrmgKRWjsbPw5HX8Nyq2WCnSKUO5gqjXwdKkNCnzubssqDt1Y3sWVjA5KfEsTOZRSmPHQ==
X-Received: by 2002:a17:902:dac9:b0:1cc:5dd4:7ce5 with SMTP id q9-20020a170902dac900b001cc5dd47ce5mr5939251plx.19.1699878143666;
        Mon, 13 Nov 2023 04:22:23 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090274c300b001cbf3824360sm3943376plt.95.2023.11.13.04.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 04:22:23 -0800 (PST)
Date:   Mon, 13 Nov 2023 21:22:21 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "minghuan.Lian@nxp.com" <minghuan.Lian@nxp.com>,
        "mingkai.hu@nxp.com" <mingkai.hu@nxp.com>,
        "roy.zang@nxp.com" <roy.zang@nxp.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 0/3] PCI: dwc: Improve code readability
Message-ID: <20231113122221.GA2418639@rocinante>
References: <20231113013300.2132152-1-yoshihiro.shimoda.uh@renesas.com>
 <20231113100914.GB1583963@rocinante>
 <CAMuHMdVLmmf12KPQch7fT2iGjfDV--M2Wd0zsxSw6wfqYxUggQ@mail.gmail.com>
 <TYBPR01MB53411530E01A90CB525DF814D8B3A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB53411530E01A90CB525DF814D8B3A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

[...]
> > > Now, while you are looking at things, can you also take care about the following:
> > >
> > >   drivers/pci/controller/dwc/pcie-rcar-gen4.c:439:15: warning: cast to smaller integer type 'enum dw_pcie_device_mode'
> > from 'const void *' [-Wvoid-pointer-to-enum-cast]
> 
> Thank you for the report!
> 
> > > This requires adding structs for each data member of the of_device_id type.
> > 
> > That sounds like overkill to me.
> > An intermediate cast to uintptr_t should fix the issue as well.
> 
> I confirmed that the uintptr_t fixed the issue.

We declined a similar fix in the past[1] ...

> I also think that adding a new struct with the mode is overkill.

... with the hopes that a driver could drop the switch statements in place
of using the other pattern.  Also, to be consistent with other drivers that
do this already.

> So, I would like to fix the issue by using the cast of uintptr_t.

Sure.  I appreciate that this would be more work.  When you send your
patch, can you include an update to the iproc driver (and credit the
original author from [1])?  I would appreciate it.

1. https://lore.kernel.org/linux-pci/20230814230008.GA196797@bhelgaas/

	Krzysztof
