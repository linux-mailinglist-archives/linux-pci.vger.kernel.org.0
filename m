Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9901F59120A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 16:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbiHLOQP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 10:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbiHLOQN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 10:16:13 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1C46E885
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 07:16:12 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id u10so674984qvp.12
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=5iPqAfoRqp5oAaE2cpTx+pD0aqojCmJ/R3i8Xb9ioEc=;
        b=wwkN9qmtdWjmMLF7v96gLIMpOGhnj7vFp9ztCunVDnVsOo8/TPH3mTD3KbYPC6cOb3
         nvZLPjb0OSWWeUNFqhy+3uuuSZR/khP5KqiXHvUaoHwApTfEPeFkmsRPf/UJc2CYhrfs
         NITgPt39CV1+XA1XKsO8kWXoNdThNh1ZUB9iInnMAaJkUVJlcHaOVLniJ5lW2wvdWwTZ
         FjX8V82QGoNDiNjeoW+BTZf4bbEJBQUHMRACy2qEf21R7hdP2u+8joFk4i45x9n4VsJd
         yrQ+6PeIxRfhrVSvyYVdtcHknnuSD9Oc95aLnlmF59pLiIuFsFpsigI7Ph/YSO4RhJCp
         F/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=5iPqAfoRqp5oAaE2cpTx+pD0aqojCmJ/R3i8Xb9ioEc=;
        b=XZqCSkbTPzNEd1hyJAkEynUGXK6B7Q5dxh9iSA4GVHzl6x8VDfVeIBimbMv6jcmIdN
         XXaG0MAkBoRhndJv9A/yA65VM5hBhi4k8ZFDIFbPP9RB1iw7tQ0C8R+8VPtmpxZujiOr
         7UzPgZa9cxpUlka+zqqgbL+QU4mUvOoE4c6L5UItkDP5GOjF4/TJ6aiY8e2ucaropIpf
         6I3QY+JOvwCGE7jQvjU94my8tcCu/pBlSOsdZlJdi/NVaxWRsm+/CtVgB3T6e7gO+5Vk
         ppZNBg1tGffLei+1/qnjZEoyQBF46Rl6g1l3KewArMUERFona1KE55urEaoODIa45j+s
         DT+w==
X-Gm-Message-State: ACgBeo09gfgI1BWvChNi45mu6sX6pFhT+xkcRlCV2/53JDHuNNaJxuE9
        au/UFWBhFVLxPv2K+wJN+EQHDw==
X-Google-Smtp-Source: AA6agR6vWpHbleJHYiOGdDgKcmRxx5rMTEcA6ymOP/9PVk3R2MY2CU/Iddu3fNJxFYZiy2hKUYOweg==
X-Received: by 2002:a05:6214:1a07:b0:474:6e80:e1e5 with SMTP id fh7-20020a0562141a0700b004746e80e1e5mr3685538qvb.41.1660313771702;
        Fri, 12 Aug 2022 07:16:11 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id g16-20020ae9e110000000b006b9576cd060sm1740631qkm.21.2022.08.12.07.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 07:16:11 -0700 (PDT)
Date:   Fri, 12 Aug 2022 10:16:09 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Frank Li <Frank.Li@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] NTB: EPF: Fix error code in epf_ntb_bind()
Message-ID: <YvZgqRJtGdbzEXo3@kudzu.us>
References: <YuenvTPwQj022P13@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuenvTPwQj022P13@kili>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 01, 2022 at 01:15:25PM +0300, Dan Carpenter wrote:
> Return an error code if pci_register_driver() fails.  Don't return
> success.
> 
> Fixes: da51fd247424 ("NTB: EPF: support NTB transfer between PCI RC and EP connection")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 111568089d45..cf338f3cf348 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1312,7 +1312,8 @@ static int epf_ntb_bind(struct pci_epf *epf)
>  
>  	epf_set_drvdata(epf, ntb);
>  
> -	if (pci_register_driver(&vntb_pci_driver)) {
> +	ret = pci_register_driver(&vntb_pci_driver);
> +	if (ret) {
>  		dev_err(dev, "failure register vntb pci driver\n");
>  		goto err_bar_alloc;
>  	}
> -- 
> 2.35.1
> 

Sorry for the delay in response.  This series is in my
ntb branch and will be in my pull request for v5.20 which should be
going out later today.

Thanks,
Jon
