Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272BE55EE02
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 21:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiF1Tow (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 15:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiF1Toe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 15:44:34 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A206F3C71F;
        Tue, 28 Jun 2022 12:37:21 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id a7so3764855ilj.2;
        Tue, 28 Jun 2022 12:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cO3ERK4XtbJUrNznv3o2iz6iblK9YD2fF9VbD6eP290=;
        b=bRBf8yD3xU6YnLnP3cf5rKY9/QNBioiHm/blJBqW+hjTgO33PjDqsCGSHfnRyKNgOM
         cXwor9UjBBfc4HCkHj6Ah1T8c2I3yJcMSsQtUGdovNk8W+bg0AaevPV/QdUT6/cIt8M6
         fSq8p7qiPFv1Zm1J1lSoVxwLT46Tqbf9bodeEG1wbAyUp/mB5pnwTatUGJLkIRHacE85
         Gn/X2IUHmHM7ZMYLwWvMAswFzkS0ybnC53KvPTkxDvJkhhlnIZodANy7i3MJTd+Y/V1M
         +XMCIpLA17ZI1I61obPRLgFxVKe5IfkYPePNC+qVOKg9z62atPacuMqf+LFT+faUQxvW
         11aA==
X-Gm-Message-State: AJIora9SRQItduYXhc/D7LS4lfdFtM0UB4a3lP5d54ZZFW7BHgWnBrSl
        RcKEaZ6k/m+emNdUBjfDfA==
X-Google-Smtp-Source: AGRyM1tWmrYkETu7J79v1CMzaMfG8jQE/J3ICVZ7PYuE+lwFA6fFbPDw1GpXcmEA8PpxTOE+0bCtFQ==
X-Received: by 2002:a05:6e02:190c:b0:2d6:5c98:d0e5 with SMTP id w12-20020a056e02190c00b002d65c98d0e5mr11018037ilu.193.1656445040891;
        Tue, 28 Jun 2022 12:37:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v17-20020a056e020f9100b002d6d8398e88sm6166005ilo.70.2022.06.28.12.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 12:37:20 -0700 (PDT)
Received: (nullmailer pid 852286 invoked by uid 1000);
        Tue, 28 Jun 2022 19:37:19 -0000
Date:   Tue, 28 Jun 2022 13:37:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, michals@xilinx.com,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v5 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5
 Root Port
Message-ID: <20220628193719.GA852253-robh@kernel.org>
References: <20220621113653.2354462-1-bharat.kumar.gogada@xilinx.com>
 <20220621113653.2354462-2-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621113653.2354462-2-bharat.kumar.gogada@xilinx.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 21 Jun 2022 17:06:52 +0530, Bharat Kumar Gogada wrote:
> Xilinx Versal Premium series has CPM5 block which supports Root Port
> functionality at Gen5 speed.
> 
> Add support for YAML schemas documentation for Versal CPM5 Root Port driver.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  .../bindings/pci/xilinx-versal-cpm.yaml       | 38 ++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
