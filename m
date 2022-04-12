Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6684FE527
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 17:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245308AbiDLPxW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 11:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351060AbiDLPw3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 11:52:29 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7F35F4D2;
        Tue, 12 Apr 2022 08:50:11 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-d39f741ba0so21131981fac.13;
        Tue, 12 Apr 2022 08:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZNA3RtRbTOSzp1Zg/MKQMKPcySxQIZx2q6vIr3MdFp8=;
        b=HUzwR+BipbmqnR/Qh7F0lnutARb43uiWStV1tzQPVNEAgoUvv79BRuOf15KwJ566iL
         ITB4vlPYSI4QIn6TBZ6wFgpw+r18Up7nZJYDH1ZlNRv4BhXJGCH7OyopXsF0BCUx1hFZ
         jYGcmdUcipt8zYsTDWU8MEmmgQpUEHe9rT2ITu0YxlTiy1c+8MSVhn3VDf3Jqacy1qST
         nwjZA0y98ddba/tLCEn09OWWvi05Q/po99OpBKA8mVciN6rs1rLqaKI72obgUHXtbf6N
         gRanwzIo83LWEiAh0KVRpJ7ezjBT3A2wZmr++VicyfCNY0S0nDSgEw4MgxRc2B2cExfi
         8nPw==
X-Gm-Message-State: AOAM532j5BQgO2bMKqTh70WILGz64aEZ6QzxLyW5W1HIYh+ap+kPWdHP
        +72ARi89ByaKbuz0m+4k/w==
X-Google-Smtp-Source: ABdhPJyZgxE30bekwBpxlZpef6JiIY5gtFmQYO/TK0Q9XIlFTziESsSwi0XHzrcr6VvGhLCbnTzWeg==
X-Received: by 2002:a05:6870:3113:b0:d3:473b:3f1d with SMTP id v19-20020a056870311300b000d3473b3f1dmr2333741oaa.116.1649778611040;
        Tue, 12 Apr 2022 08:50:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s24-20020a056808209800b002da3b9bf8e0sm12333974oiw.32.2022.04.12.08.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 08:50:10 -0700 (PDT)
Received: (nullmailer pid 348051 invoked by uid 1000);
        Tue, 12 Apr 2022 15:50:10 -0000
Date:   Tue, 12 Apr 2022 10:50:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 1/6] PCI: rcar-gen2: Add support for clocks
Message-ID: <YlWfslEOdrf62KiP@robh.at.kernel.org>
References: <20220412094029.287562-1-herve.codina@bootlin.com>
 <20220412094029.287562-2-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412094029.287562-2-herve.codina@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 12, 2022 at 11:40:24AM +0200, Herve Codina wrote:
> The PCI rcar-gen2 does not call any clk_prepare_enable().
> This lead to an access failure when the driver tries to access
> the IP (at least on a RZ/N1D platform).
> 
> Prepare and enable clocks using the bulk version of
> clk_prepare_enable() in order to prepare and enable all clocks
> attached to this device.

The binding says there is only a single clock, so it needs an update if 
there are multiple clocks. (And ideally converted to DT schema format.)

Rob
