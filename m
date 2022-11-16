Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BEE62B1E9
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 04:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiKPDr1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 22:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKPDr0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 22:47:26 -0500
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D274C27DDA;
        Tue, 15 Nov 2022 19:47:25 -0800 (PST)
Received: by mail-pf1-f181.google.com with SMTP id g62so16278186pfb.10;
        Tue, 15 Nov 2022 19:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woM2iJQVuvVwlbfVHcxGfAeMYRl2d8ctBY6yZytfaZM=;
        b=N0SM8URRQh4ysMY+3nLL1QZwX0F3wqJKxvv7hhaIrlXrmd8yv28vOmW9mUMPk+7eOX
         wqYowl+7D649PWififBxpmtuhDuHIoMfJ40WWZJchnd7FkLzubfg9cxy4zpXw5DSTMcm
         zjHYZOo/D4kyKEd18OwMqUrVsXwT1Gil7G9QM4PB1P5t9NgLQilyGiJ+Jo7iBBNOGJIz
         U7zs8eYrutg7oWOiUyQHSeEwxTCabn+4o09RqLegcAV3O5JtVq+qRWKXDBrpjm2J9yQ5
         IwJqCTn3HAh1ODyVWSZu9bRaaCWKI/4hq89nxnMPqccFI8sF98GrUtq9TTWGvJQNt3oi
         Jf8Q==
X-Gm-Message-State: ANoB5pn7gyfQvrcg6U/oP3bQVTEIkUJ/vFSfjh3ShTE5Yx4VSsxlV6zx
        /u/qMxezmecUiABQtOZl1bM=
X-Google-Smtp-Source: AA0mqf4fu1hbhM61RDf3bZ9esvI/knreVFmQjrJ2fHa/rO2+yZIR/P1CyaHTGFuIE8dr3+nIF6BS3A==
X-Received: by 2002:a62:4e06:0:b0:56d:4d37:89dc with SMTP id c6-20020a624e06000000b0056d4d3789dcmr21554381pfb.81.1668570444935;
        Tue, 15 Nov 2022 19:47:24 -0800 (PST)
Received: from rocinante (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id n1-20020a654cc1000000b0046ae5cfc3d5sm8416770pgt.61.2022.11.15.19.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 19:47:23 -0800 (PST)
Date:   Wed, 16 Nov 2022 12:47:19 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] PCI: vmd: Clean up some inconsistent indenting
Message-ID: <Y3RdR+9QSVPWyae3@rocinante>
References: <20221115054847.77829-1-jiapeng.chong@linux.alibaba.com>
 <Y3NpjbXkcb3wfZcQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3NpjbXkcb3wfZcQ@infradead.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> > +	if (vmd->irq_domain)
> > +		vmd_set_msi_remapping(vmd, true);
> > +	else
> > +		vmd_set_msi_remapping(vmd, false);
> 
> Why not go one step further:
> 
> 	vmd_set_msi_remapping(vmd, !!vmd->irq_domain);

Jiapeng, if you want to get this patch merged, and it's a nice clean-up,
then apply suggestion from Christoph and send a v2, if possible.

	Krzysztof
