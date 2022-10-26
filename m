Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18AB60D9FB
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 05:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiJZDjf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 23:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJZDje (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 23:39:34 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09CEE086;
        Tue, 25 Oct 2022 20:39:31 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso1181582pjg.5;
        Tue, 25 Oct 2022 20:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ku9hoZtfdBsctQ4Md/7GEnpwStP3XYCF+F0ESbEHHpQ=;
        b=YV7HuM7vepCV1dfZgO2UCP2UXgwbmWmqcD61yyRPgojiqUEPGTRFCQOjXNlxIMVTFK
         lleIlOkZPqufAam3iGDUPvuMxZi/jGd2OFS2iXA645zMeYj640QI25E7rv3pteyzFXAO
         bfy+Jxl8bOxQ+Sz3M7ooy7Sd/H6dlDAq4LZKHtwJ3dEaZm3kuvvg+5xz5G6dVjDqklZZ
         6V++Y2o8wmEw4jL4EZlIpX+J6qAPJt99sa3Mm3/zEj/W4JIosDyMgDGI3oh7NmJvbuJt
         +w4iTEslkR2ZMw82TYXZaQexGUYdEb5Xjd5wX7s7a4chNKc99JM/pxI1gfO8JDYnA2Ty
         fBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ku9hoZtfdBsctQ4Md/7GEnpwStP3XYCF+F0ESbEHHpQ=;
        b=r21Xn7/LQtoGxCk01IY+nR60s+ZvHJI0Xr82uPed71VxwpdHUENFzw2GxKLBsvTRPI
         V8ekth+ewTr7tb0PKi/CZYyhSNSLzlsfPiTLE2UT1DpIfKi+X13cU6Xpio5xetC+aK+x
         eIXQ1lDirUhRZ9X8SQ6Wau8yI4kYSwHuhgsPArotIxf5OW48j57crNJQCE8dco1R7gmW
         BkkBNvZ86YGkq/H8s8uTqZHwnM6UhXICFhOX9b2dgPbgCCebOBoAznMDnA0ou4OnjZh+
         iaaMwKqo6c6rLqTPgDagzU58wmet+sC9jz1xhJIIb4llcBzNoeJHQPxIDZ3cqSR0BP8r
         NfGw==
X-Gm-Message-State: ACrzQf3WdA9uPjXMUw7Q9HMd513L5THigDFhI/86qnEURoNbtSGIhJNw
        j5PUbLIS0q4KJkkRo3F6PunPrIYpkLYs7La1
X-Google-Smtp-Source: AMsMyM5HHKfYhiN8FOz27mFGQX015ot7IgxBwn187OS5ipqGHpnNvWeWkzOn9ajA2JW50RAHxYIuaw==
X-Received: by 2002:a17:90b:4a03:b0:213:1b8b:dcfc with SMTP id kk3-20020a17090b4a0300b002131b8bdcfcmr1803532pjb.173.1666755571394;
        Tue, 25 Oct 2022 20:39:31 -0700 (PDT)
Received: from localhost ([36.152.119.226])
        by smtp.gmail.com with ESMTPSA id iw19-20020a170903045300b00170d34cf7f3sm1880172plb.257.2022.10.25.20.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 20:39:30 -0700 (PDT)
Date:   Wed, 26 Oct 2022 03:39:26 +0000
From:   Wei Gong <gongwei833x@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH RFC] pci: fix device presence detection for VFs
Message-ID: <20221026033926.GA344792@zander>
References: <20221009191835.4036-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009191835.4036-1-mst@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 10, 2022 at 01:12:20PM -0400, Michael S. Tsirkin wrote:
> virtio uses the same driver for VFs and PFs.  Accordingly,
> pci_device_is_present is used to detect device presence. This function
> isn't currently working properly for VFs since it attempts reading
> device and vendor ID. Result is device marked broken incorrectly.  As
> VFs are present if and only if PF is present, just return the value for
> that device.
> 
> Reported-by: gongwei <gongwei833x@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Tested-by: Wei Gong <gongwei833x@gmail.com>

> 
> ---
> 
> Warning - compile tested only. gongwei could you help test and report
> please?

Tested and working well. Any plans for next steps? 

> 
>  drivers/pci/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 95bc329e74c0..ba29b8e2f3c1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6462,6 +6462,9 @@ bool pci_device_is_present(struct pci_dev *pdev)
>  {
>  	u32 v;
>  
> +	if (pdev->is_virtfn)
> +		return pci_device_is_present(pdev->physfn);
> +
>  	if (pci_dev_is_disconnected(pdev))
>  		return false;
>  	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
> -- 
> MST
> 
