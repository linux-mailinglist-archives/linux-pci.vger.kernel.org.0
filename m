Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E296F745BDB
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jul 2023 14:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjGCMIa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jul 2023 08:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGCMI3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2023 08:08:29 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E302115;
        Mon,  3 Jul 2023 05:08:28 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b88e84bfb8so11663635ad.2;
        Mon, 03 Jul 2023 05:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688386108; x=1690978108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1RQZiBYkGXoDrkdvY5PoVYRfWP/etmDOBicF5bYDcc=;
        b=MhIYQc5gOS6fVi8ic32NhUXVhX8rsDFE0L5lk5r8pkkbDLSxSNbFY7NzeMR14Hypkl
         UpibvqmeL5D2OrVd6IZsNvGhW7IBJTk6vthtq2MBlUuMBL0E9niUpyyG1IGHyO78ntL/
         LOatxoqUCpL1j/e0dFAC96vVo1VzfJvhLhGVVBmUjN3wklk3YYELmVdS+ofni14Kyt+C
         qMoyt/1ZpjMoy93twAWGC2p6/eeJ35/5fpl0qCRzHAzhjHyculVOZ27f72RMfA0Lzyzx
         MLfKmOCWu6Rb7VqAHVnNEMKRL7KSPB4nXDuH1uhapYx18eUSV5/I87bI5PsLGZXajw/8
         JH7Q==
X-Gm-Message-State: ABy/qLZ4fxcl3MatMSIHJq8frUmDVaWG/aWL2vhdFffrRavGNs8Iix0z
        CrJj0ypM+Uf1ZoWUE+pESuI=
X-Google-Smtp-Source: APBJJlGOY8iLOJXpaCDww1+jpxC7Nbzk13GTYXUcfYjg94j+viCwrcy8jmCZaDeEU/OOaYir/vO6/g==
X-Received: by 2002:a17:902:d486:b0:1b2:fa8:d9c9 with SMTP id c6-20020a170902d48600b001b20fa8d9c9mr12966827plg.49.1688386107834;
        Mon, 03 Jul 2023 05:08:27 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902988c00b00198d7b52eefsm15161441plp.257.2023.07.03.05.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:08:27 -0700 (PDT)
Date:   Mon, 3 Jul 2023 21:08:25 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch, dlemoal@kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        stable@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI
 address
Message-ID: <20230703120825.GA2375438@rocinante>
References: <20230703085845.2052008-1-rick.wertenbroek@gmail.com>
 <997819c6-0798-e2f9-b94b-fedfbab7fdd8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <997819c6-0798-e2f9-b94b-fedfbab7fdd8@arm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> > A 32-bit mask was used on the 64-bit PCI address used for mapping MSIs.
> > This would result in the upper 32 bits being unintentionally zeroed and
> > MSIs getting mapped to incorrect PCI addresses if the address had any
> > of the upper bits set.
> > 
> > Replace 32-bit mask by appropriate 64-bit mask.

[...]
> > +#define PCIE_ADDR_MASK			GENMASK(63, MIN_AXI_ADDR_BITS_PASSED)
> 
> Nit: this probably wants to be GENMASK_ULL(), otherwise it might throw a
> warning if compile-tested for 32-bit.

I can change this to GENMASK_ULL() when I apply the patch.  Unless Rick
wants to send v3 - either way would be fine. :)

	Krzysztof
