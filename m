Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5EE56521A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 12:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiGDKWC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 06:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiGDKVq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 06:21:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4ADDFE1
        for <linux-pci@vger.kernel.org>; Mon,  4 Jul 2022 03:20:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso3804479pjo.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Jul 2022 03:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ui6jM4ZYL95jFXsEJNqQO63PcH9wdj9Z4AxG9QKXlsk=;
        b=GvSzH22gCSolN+ML/4454VuP5xi7hCqYh3iBNj7BsSKVgA4TpvBHywhPCeoApnfRAJ
         0ECxw1MihfcLw8YnRZA2hPIX6zybx/LfAnow6UC98HULCRrJIRMUhuMoS5nlkRAun+FG
         bB1h36cBBBOr0fRSVpvhyJEgIeKP4HnUobKaQ2XrC1ooQTJ2/xziCatTAD4DXPFWc+6u
         GaaW5Hra03vyAhoYBG0C9oiTMZnow424UlLfLNBXqV7yRwF9m/s0ivRa5i2eSJUoAvEC
         ZJnrPg/8HP347f5WAyhrBBmymSsT2L/XCgFhSUNTahFG4GshJPafSwasZB8Ep60E1n1i
         ZbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ui6jM4ZYL95jFXsEJNqQO63PcH9wdj9Z4AxG9QKXlsk=;
        b=bNaqAv641HGp0AlxlmkR7AmEZeOKxG4HFqjsJ0FUTZVKhr5U3Vej+/u+wVrkEy8/Xz
         4mJCDWXxmGhkY3CafWO3RjPaTRlB8LTFscxBHqPVKou5pl1B9SczbIhdsVYlAwu/PFYM
         fQWez+cKf2QQ1uTGIt+feoNSmCgyXbuLiOKYeHoQ8hCYUkKk8Vp7BQjYqsK3Y1RIwcYQ
         hehsD+cYvByEa5edN5PP7yVJ4KPt2aZ0FYoshbJWWxhDzph/xUjl5dqwfFp2bAFsBTec
         s0IH+vF4NXvAH4MbAwZjhYIVGHwJuS3uAUtnyfoR5gpR2LMDz718wByPz2J1BcLjcR/i
         ourQ==
X-Gm-Message-State: AJIora84cYaltKHj2XmQJpahm8JgusIsF5Y36BqKSjKMHYc8Nfvi+BCN
        85NwoSHheUbxYYL/WYhACtTCdCBf+YwW
X-Google-Smtp-Source: AGRyM1sZ6xYXHsOd/xbmmI/Ti9HJnupEePcXxzVWeGr7WZfxD0YPmcXQaXXzh9r+ytRnh49OAdR35g==
X-Received: by 2002:a17:90b:4c0a:b0:1ec:e6b3:7690 with SMTP id na10-20020a17090b4c0a00b001ece6b37690mr35452668pjb.121.1656930003648;
        Mon, 04 Jul 2022 03:20:03 -0700 (PDT)
Received: from thinkpad ([220.158.158.244])
        by smtp.gmail.com with ESMTPSA id u14-20020a170903124e00b0015ee60ef65bsm20742341plh.260.2022.07.04.03.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 03:20:01 -0700 (PDT)
Date:   Mon, 4 Jul 2022 15:49:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Tom Rix <trix@redhat.com>
Cc:     kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, Frank.Li@nxp.com, jdmason@kudzu.us,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: reduce several globals to statics
Message-ID: <20220704101955.GD6560@thinkpad>
References: <20220630210517.1825677-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220630210517.1825677-1-trix@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 30, 2022 at 05:05:17PM -0400, Tom Rix wrote:
> sparse reports
> drivers/pci/endpoint/functions/pci-epf-vntb.c:956:10: warning: symbol 'pci_space' was not declared. Should it be static?
> drivers/pci/endpoint/functions/pci-epf-vntb.c:975:5: warning: symbol 'pci_read' was not declared. Should it be static?
> drivers/pci/endpoint/functions/pci-epf-vntb.c:984:5: warning: symbol 'pci_write' was not declared. Should it be static?
> drivers/pci/endpoint/functions/pci-epf-vntb.c:989:16: warning: symbol 'vpci_ops' was not declared. Should it be static?
> 
> These functions and variables are only used in pci-epf-vntb.c, so their storage
> class specifiers should be static.
> 
> Fixes: ff32fac00d97 ("NTB: EPF: support NTB transfer between PCI RC and EP connection")
> Signed-off-by: Tom Rix <trix@redhat.com>

Commit subject should include "pci-epf-vntb" prefix. Otherwise it is not
possible to guess which driver this patch touches (unless one reads commit
description).

With that fixed,

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> v2 : Change commit prefix
> 
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index ebf7e243eefa..6f0775b1fec3 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -953,7 +953,7 @@ static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
>  
>  #define VPCI_BUS_NUM 0x10
>  
> -uint32_t pci_space[] = {
> +static uint32_t pci_space[] = {
>  	(VNTB_VID | (VNTB_PID << 16)),	//DeviceID, Vendor ID
>  	0,		// status, Command
>  	0xffffffff,	// Class code, subclass, prog if, revision id
> @@ -972,7 +972,7 @@ uint32_t pci_space[] = {
>  	0,		//Max Lat, Min Gnt, interrupt pin, interrupt line
>  };
>  
> -int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
> +static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
>  {
>  	if (devfn == 0) {
>  		memcpy(val, ((uint8_t *)pci_space) + where, size);
> @@ -981,12 +981,12 @@ int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *
>  	return -1;
>  }
>  
> -int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
> +static int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
>  {
>  	return 0;
>  }
>  
> -struct pci_ops vpci_ops = {
> +static struct pci_ops vpci_ops = {
>  	.read = pci_read,
>  	.write = pci_write,
>  };
> -- 
> 2.27.0
> 

-- 
மணிவண்ணன் சதாசிவம்
