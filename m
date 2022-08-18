Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E39597E5A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 08:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243488AbiHRGCj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 02:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241244AbiHRGCi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 02:02:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FE6844DB
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 23:02:36 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f65so501621pgc.12
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 23:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=zK72A8q5XD2E3NomsnJJ4xt124GNl/LXJjyyFVpPi3Q=;
        b=vDSQyxgLF0rPsGm3whfGWvdwuXaaggJm3hBiEY2XXtCdUbBAxBskXAwmyUgst2JRgh
         0+RpDuL0rmCPrMNVzxiAFW+s4D4T6kN/boLgbrVPavMoHdMdjN1qjyA7UBlRv4NrB0tb
         UElnczihsgdB6AyXrjodapbcspF13GOULens5dy15Q9P/Pu5fSXPeGA/MtKUJlA4qOKK
         v4Anr60vZYM+arsPw9kr8FN6TRaKylEE/YYCjthoJvysvh9bjoxiX8OisPgsih0ZhD2U
         oUy91KJDxhT6SWgkhXQgljljmB6vMtYNr/bY6i7F7nDTEdgaIuEVIPJQAo/aL2M223or
         Pf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=zK72A8q5XD2E3NomsnJJ4xt124GNl/LXJjyyFVpPi3Q=;
        b=BZ0D5DtYd0u6GM9nu8PSQs5YVc06TnaN/5Amf3a8vKBJeRI5U6L0knYLNnXOP+5scS
         1bb6AIwDeuj3xJka24mSM3VOLRv16usFHjByj5Zg8Mnnf94gik9gvtxslbLwY2parXM9
         oeZ8JhFtuxQGKrbUQoURKrdJIFVQFO4fMYe8M4o6nW8Yob3J/KviPN+FaHXfcQMW7YgJ
         KWS8CMXk9cOFWNV36iEHTmi5j2trTVi6H8FzEWUErjoJZj4DBKpDQGD1Ff5KbdTlXJ18
         hNHGnigB4hXXxhC/wG0WDol5iL1dZKOqWMrFeoruTgjQLv6kSJ9VY0CnLY6lKQyQcJoI
         H4Qg==
X-Gm-Message-State: ACgBeo2RhiWaL0F52tv1CktZDuQxAGTD6t/uEt9bzPw8+XQNTIcxtZP/
        lLVkBoJSc3ZvMFIPzCCX9etwYuW1d7Ua
X-Google-Smtp-Source: AA6agR5S8mPl/SarYfDESuLsWayOu8NNUQMOoFIcC5tZbb45kGSDfEw9qTui2H5mFYBnpeNL3hk41Q==
X-Received: by 2002:a05:6a00:4509:b0:52d:4943:90b4 with SMTP id cw9-20020a056a00450900b0052d494390b4mr1569547pfb.22.1660802555747;
        Wed, 17 Aug 2022 23:02:35 -0700 (PDT)
Received: from thinkpad ([117.202.186.191])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b0016d737bff00sm454658pli.220.2022.08.17.23.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 23:02:35 -0700 (PDT)
Date:   Thu, 18 Aug 2022 11:32:30 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jon Mason <jdmason@kudzu.us>
Cc:     ntb@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
        Frank.Li@nxp.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com
Subject: Re: [PATCH] MAINTAINERS: add PCI Endpoint NTB drivers to NTB files
Message-ID: <20220818060230.GA12008@thinkpad>
References: <20220812194205.388967-1-jdmason@kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220812194205.388967-1-jdmason@kudzu.us>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ Kishon (PCI EP Maintainer)

On Fri, Aug 12, 2022 at 03:42:05PM -0400, Jon Mason wrote:
> The PCI Endpoint NTB drivers are under the NTB umbrella.  Add an entry
> there to allow for notification of changes for it.
> 
> Signed-off-by: Jon Mason <jdmason@kudzu.us>

Hi Jason,

I know that this patch is already in Linus's tree but I think this PCI Endpoint
VNTB driver is not going in a correct path. First, Kishon is not convinced with
the way the PCI Endpoint VNTB function driver is written currently. He prefers
the VirtIO approach over the current one [1].

But while the conversation was still going on, the series got merged via NTB
tree without any ACKs from the PCI/PCI_EP maintainers. Also, note that there
was a patch touching the PCI Controller driver as well and that was also not
ACKed [2].

If this trend is going to continue in the coming days, then I'm afraid that NTB
might end up being a backdoor for PCI/PCI_EP patches :(

Thanks,
Mani

[1] https://lore.kernel.org/all/20220222162355.32369-4-Frank.Li@nxp.com
[2] https://lore.kernel.org/all/20220222162355.32369-2-Frank.Li@nxp.com

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 64379c699903..47e9f86bd712 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14254,6 +14254,7 @@ W:	https://github.com/jonmason/ntb/wiki
>  T:	git git://github.com/jonmason/ntb.git
>  F:	drivers/net/ntb_netdev.c
>  F:	drivers/ntb/
> +F:	drivers/pci/endpoint/functions/pci-epf-*ntb.c
>  F:	include/linux/ntb.h
>  F:	include/linux/ntb_transport.h
>  F:	tools/testing/selftests/ntb/
> -- 
> 2.30.2
> 

-- 
மணிவண்ணன் சதாசிவம்
