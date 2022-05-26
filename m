Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EDE53557D
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 23:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbiEZVaf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 17:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiEZVab (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 17:30:31 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE55B8BFB;
        Thu, 26 May 2022 14:30:30 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id t144so3624082oie.7;
        Thu, 26 May 2022 14:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FSrXysD1qhZ9DkMbOPOXKUiaWeCHmsCvWDdWMOETp+M=;
        b=Ay7mrrkkodW/m260RBkUsip0DNbe1ei512Vd17XRbjn2FmjpVZJYXyFsFFjKuuhTw2
         H4m2w1sNzS6sRBz59G9Gvbo7MmmGse5oT5aMFar60DikaKtFVmPOEXKmt/WAYEtHazVS
         hBQqEgE+9EJmLrLAkrD6T4EeVna0LBm+vgCrBsMsl0wVBF/1hfWxPyoBTyAM0+qVevNp
         MT+3YmcJKZrguJl5cId2q0xAs2h60VTroNPLee8Dh74rVHdkRStqePPh+770We0gCctX
         TZ1mWYw8c8VXSFhmXKdHH9hq+dZzL2DtIHD5rAUMWs2UFdYuQbA1r/9wLd3AfdXrFr7+
         c+MA==
X-Gm-Message-State: AOAM530y3W1o+w4CQuJzcF8uMd6icjsrWOp68vSax6o37Qa6XQ0qnXbt
        JhK2gMh/vfS5XAb5UNfEYw==
X-Google-Smtp-Source: ABdhPJwRmXRpQB83zAYTOCb6pXsV+86ByTY4/ZIEig3a5BPfJviZDKWqLzkD34IDcwA+TShXKUGQmQ==
X-Received: by 2002:a05:6808:130a:b0:32b:6314:a5d6 with SMTP id y10-20020a056808130a00b0032b6314a5d6mr2276401oiv.94.1653600630026;
        Thu, 26 May 2022 14:30:30 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-37.sw.biz.rr.com. [192.154.179.37])
        by smtp.gmail.com with ESMTPSA id k3-20020a4ad103000000b0040e68c9dce6sm1070616oor.31.2022.05.26.14.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:30:29 -0700 (PDT)
Received: (nullmailer pid 295988 invoked by uid 1000);
        Thu, 26 May 2022 21:30:28 -0000
Date:   Thu, 26 May 2022 16:30:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/13] PCI: dwc: Stop link in the host init error and
 de-initialization
Message-ID: <20220526213028.GO54904-robh@kernel.org>
References: <20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru>
 <20220517125058.18488-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517125058.18488-2-Sergey.Semin@baikalelectronics.ru>
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

On Tue, May 17, 2022 at 03:50:46PM +0300, Serge Semin wrote:
> It's logically correct to undo everything what was done in case of an
> error is discovered or in the corresponding cleanup counterpart. Otherwise
> the host controller will be left in an undetermined state. Seeing the link
> is set up in the Host-initialization method it will be right to
> de-activate it there in the cleanup-on-error block and stop the link in
> the antagonistic routine - dw_pcie_host_deinit(). The link de-activation
> is a platform-specific thing and is supposed to be implemented in the
> framework of the dw_pcie_ops.stop_link() operation.
> 
> Fixes: 886a9c134755 ("PCI: dwc: Move link handling into common code")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
