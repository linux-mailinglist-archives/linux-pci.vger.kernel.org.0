Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B573A54A0D1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 23:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbiFMVHK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 17:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243155AbiFMVGh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 17:06:37 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE6BA1AB;
        Mon, 13 Jun 2022 13:43:00 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id q11so7358758iod.8;
        Mon, 13 Jun 2022 13:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4cvLgjmvps0lHdHnD+Ttf/d2fQckJt1ozCbfYZlKNKk=;
        b=TntbIODHZc3jA/2f0PVO6cyHIqpGyu2aRUXLzfe4U5HDhBaBuh7TDkm5qGcBpz8Rq9
         e/dGqHOeDE68Y/DF1DKwlbyveCKJTbxTJTww50r4oGkYZ+/J+wkrj3YIeOiBe05yoBmB
         XNxc/ecvc9NmgGnrgZEYeeksrXoIV01S3ysS3v/DKZdH2NvlIvt1yZgieIaFP/LpOZjl
         zOGxu7pvGthsaLCxaDLydusASBDGsMouILhnMnKsPvwBx59d92yPgynBjL7mNLhU5Uud
         iG53mkQ5LAQwGsY34BTKWEyxA8sTzITydSPsj4uiMFqmL+fidMi8mnQ17tGpz42GFGJH
         KViw==
X-Gm-Message-State: AOAM530P4DE54jHo/0wz+OoE4jTvK8rGLHX++7tj8NCeNaBs1smii4Od
        Anrh/PNnv9dn6lM6duUMng==
X-Google-Smtp-Source: ABdhPJx1fRZ7lsDYRtdxX8f9/YvOuCpZt2tAdVjJRsfDZXT87HL0wBhgpY6DIMShWSijSHR9W6qgVA==
X-Received: by 2002:a05:6638:264b:b0:331:be44:9a9 with SMTP id n11-20020a056638264b00b00331be4409a9mr914848jat.194.1655152979909;
        Mon, 13 Jun 2022 13:42:59 -0700 (PDT)
Received: from robh.at.kernel.org ([69.39.28.171])
        by smtp.gmail.com with ESMTPSA id v10-20020a02384a000000b0033188e8cabesm3932556jae.74.2022.06.13.13.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:42:59 -0700 (PDT)
Received: (nullmailer pid 47751 invoked by uid 1000);
        Mon, 13 Jun 2022 20:42:58 -0000
Date:   Mon, 13 Jun 2022 14:42:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/18] PCI: dwc: Move io_cfg_atu_shared to the Root
 Port descriptor
Message-ID: <20220613204258.GC28636-robh@kernel.org>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-15-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610082535.12802-15-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:25:30AM +0300, Serge Semin wrote:
> That flag is set if there is an outbound iATU window used for both PCIe
> peripheral config-space accesses and IO ports transfers. Since the flag
> semantic is purely Root Port specific, it's unused in neither the DW PCIe
> common code nor the DW PCIe Endpoint driver we can freely move it to the
> DW PCIe Root Port descriptor. Thus the pcie_port structure will be more
> coherent.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v4:
> - This is a new patch created on the v4 lap of the series.
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
>  drivers/pci/controller/dwc/pcie-designware.h      | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

