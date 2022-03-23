Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2153B4E5705
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 18:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbiCWRCV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 13:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbiCWRCT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 13:02:19 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF16B76656;
        Wed, 23 Mar 2022 10:00:48 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id q129so2252401oif.4;
        Wed, 23 Mar 2022 10:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ew7vswwVoXEdNnowWuN4DkG7sFm35VaSCmtO03vk8qw=;
        b=T99VdsKHhHw4aA15XD4A23fyNnKBhs+gBO7zEkU82ddxJTMeLDfDIqiSZat1b01hqU
         eMCtwjX3YG3NraqQEDd7WZ3r0P7irCRRlDOpLpY/yB8B+tXzfhuwOrGl+qdoRpsveOvv
         vTTlDaVnIqJXliVcGOY9NmwpUA6fIbBOtJu7tQB+V/7qiifKu7cz4wXN6AOVzWXM0Ec+
         GlCZjfEsE90zipcn3LCs2F30Z3vmFB75OSJvx1ZQ90XdsiC6ZvSPP8aJJnFWYxLwLt32
         uzfXeXHN6xExdr6jlPZOwwhPtuUJm93oKe1FBUDjLOwWedW+SN6Px0hqHqTEHSZiHzbh
         9rPg==
X-Gm-Message-State: AOAM531WvsR9iuiZOFtNJIS3DtnBrlsZg84T1QOe47esFmuHXi6NtF3V
        lcS17//J4zrRcddohpVg9A==
X-Google-Smtp-Source: ABdhPJx/I+gdq1cGB/H0/rZ3fdDtVFCf8wI44SyQxfSfv4koCV0WUrouEhpbjXSAFfehugiX8HZCKQ==
X-Received: by 2002:a05:6808:152b:b0:2ec:f48f:8120 with SMTP id u43-20020a056808152b00b002ecf48f8120mr557500oiw.58.1648054848312;
        Wed, 23 Mar 2022 10:00:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u23-20020a056870d59700b000de821ba7cbsm204514oao.15.2022.03.23.10.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 10:00:47 -0700 (PDT)
Received: (nullmailer pid 80949 invoked by uid 1000);
        Wed, 23 Mar 2022 17:00:46 -0000
Date:   Wed, 23 Mar 2022 12:00:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pci: layerscape-pci: Add lx2160a rev2 PCIe
 RC compatible string
Message-ID: <YjtSPjXMFXZGEAv4@robh.at.kernel.org>
References: <20220311235106.8756-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311235106.8756-1-leoyang.li@nxp.com>
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

On Fri, Mar 11, 2022 at 05:51:06PM -0600, Li Yang wrote:
> lx2160a rev2 SoC uses a different pcie controller from rev1.  Add a new
> compatible string "fsl,lx2160ar2-pcie" which is also compatible with
> "fsl,ls2088a-pcie".
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
>  1 file changed, 1 insertion(+)

What's this based on? It doesn't apply and there's no pending changes.

Rob
