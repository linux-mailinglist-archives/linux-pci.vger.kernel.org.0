Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5370E7E9CF3
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 14:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjKMNSy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Nov 2023 08:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjKMNSx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 08:18:53 -0500
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72C8D6D;
        Mon, 13 Nov 2023 05:18:49 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5bd85b1939aso2521586a12.2;
        Mon, 13 Nov 2023 05:18:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699881529; x=1700486329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOlnxYdURNzc3S19TzZzd39YvfCLB1voUOe65YcS7qY=;
        b=qS2vXcZB4ybYy6qumT5fnRtu4P9QYHExB6fldzU4vuvnOSd0UdU7yzAsSzVuv2elhd
         vplx/ktfzKkzh5LU9ZNsp7syp1ZcY4xxH/yFzUSmBhTkIUSgg6Q4A0+cKE7fenD7R8Mg
         3Zd8sEOu+q+dV6WNUXWgSPgiTa0+e4tKCXBQx7M574WC9dtRlg55zurys4xw6DiJuM4U
         v2Be2L04tzgH/DAz6RtZYTt1RbWLt8S7Nmb3yxOsK3WSElsWm3vDfwIb7D7h5SMDeTah
         lDopMEDQBIVZ7W7oCRegn522Q2EnzySszcjm4DjQMSbaWrQYZ846ubtCwCMw16nKzxWE
         nWuA==
X-Gm-Message-State: AOJu0YwZC8qO4lbbjsUKlBdP6mOGkTqGxDI/EyV/PZLCRQy0Yf95JHTt
        Z9/G/tEgOkSjyTns+V3Mx40=
X-Google-Smtp-Source: AGHT+IHMCfixw5bNBz1Dj6MA0FhzNL3vrHsarIlhlyW3PX8qo5TRXyf05wKSf3No7EALGSIr80uDRw==
X-Received: by 2002:a05:6a20:1612:b0:16b:7602:15b1 with SMTP id l18-20020a056a20161200b0016b760215b1mr4472277pzj.12.1699881529157;
        Mon, 13 Nov 2023 05:18:49 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b001cc46240491sm4116669pln.136.2023.11.13.05.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 05:18:48 -0800 (PST)
Date:   Mon, 13 Nov 2023 22:18:47 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
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
Message-ID: <20231113131847.GA2770646@rocinante>
References: <20231113013300.2132152-1-yoshihiro.shimoda.uh@renesas.com>
 <20231113100914.GB1583963@rocinante>
 <CAMuHMdVLmmf12KPQch7fT2iGjfDV--M2Wd0zsxSw6wfqYxUggQ@mail.gmail.com>
 <TYBPR01MB53411530E01A90CB525DF814D8B3A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20231113122221.GA2418639@rocinante>
 <CAMuHMdX2D-Ui=6Xt_x_yDAYQYoooP51ZwZTmoASwcUeZTcME4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX2D-Ui=6Xt_x_yDAYQYoooP51ZwZTmoASwcUeZTcME4g@mail.gmail.com>
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
> > > I confirmed that the uintptr_t fixed the issue.
> >
> > We declined a similar fix in the past[1] ...
> >
> > > I also think that adding a new struct with the mode is overkill.
> >
> > ... with the hopes that a driver could drop the switch statements in place
> > of using the other pattern.  Also, to be consistent with other drivers that
> > do this already.
> 
> Note that the issue of casting is something we cannot fix easily:
> some *_device_id structs use "kernel_ulong_t" for the "data" member,
> others use "void *".
> 
> git grep -W "_device_id" -- include/linux/mod_devicetable.h | grep data
> 
> In addition, several drivers use multiple types of device IDs, so you
> cannot settle on one type to avoid casts.
> 
> Also, putting enum values in instances of that struct, as suggested,
> increases kernel size, for IMHO no additional gain.

All good points!  Thank you for taking the time to get back to me.  Appreciated. :)

> If there is more data to put in the struct, I agree it makes sense to use
> a struct.

Yeah.  Perhaps if there is such a need in the future, indeed.

	Krzysztof
