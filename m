Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63275FED33
	for <lists+linux-pci@lfdr.de>; Fri, 14 Oct 2022 13:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJNLbW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Oct 2022 07:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJNLbW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Oct 2022 07:31:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9B71A815;
        Fri, 14 Oct 2022 04:31:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l1so4434535pld.13;
        Fri, 14 Oct 2022 04:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kFzUljG9kZf2peq6k8637SCyAiDSOl2n6yBX9RWYrqk=;
        b=fFl0fnjv0UR1Nk2iF4C1v/K2C+C5iXPoML/EcgURko4CdCAooqPu1exqeKH5Vp5skw
         660vmrT8iA3vlIEKvxhefrjcbuylnghW0Gv5Ju7mTZe8tH5qmHJuRzJrRTlhageAPmOY
         KS85Rj02ykyY7S268H2/Y4wnLYTNBDDqYxHWYkfb/ErnKYakwP/RZ6cozIAUGb2cxCAZ
         OktOto1hNQROHzaank2+Dav2n2SoONJRtO5va5Qe79HCWzRBF+yHUeDimVKV/ikQpTbG
         XHJsEzrTrHCFwQvc2531IFe85afxQFtpaI/XFD9uPgltpLDLfH2kTt9Lzt51JWl33y15
         8lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFzUljG9kZf2peq6k8637SCyAiDSOl2n6yBX9RWYrqk=;
        b=D1kUVCYgoSsCCZmAQeRR2pioHiJnEwggiAGPeifeSBvfMGD7p3APqQJYqFWcucHXU6
         SQAqV38HY1nY2z/JBnP+yMIDv830YENJugGUhUksosEr2DH/aaYlmVn2WSoElCFa/8Z7
         aR1xr/RMGin3UOBOx50g5dvIXCXnFPaHgb7rJgoYFiqAfeGm+fopAgbGKihwYD2+aWuF
         PRxMWewj6P1MaYMCXmaFp/eOyqQj0ZrNIsUyP6hwo6WVErqKWjt5xWGNdN7cRwLLYJ4H
         TLeRHl2escNtyn64UaWob3p63f+J1WqywdRepDzJsWGGiW1SynlrOO/lW5G5UBaHS+ku
         AB3w==
X-Gm-Message-State: ACrzQf2s2WB6tjo+SK+d6YLoiRvFdtcCRNJkNdIpiQfsVv4QkfKkX5Ka
        ExLXoo3nS5/ROtEuYkmWRsQ=
X-Google-Smtp-Source: AMsMyM4dV1ss4GLlQC5pSVAbNLJ2JgotpmPe9Mv0LJOu/Agy7k2K/NIX4McRfBgFFhsrS/ewMdz+gA==
X-Received: by 2002:a17:902:f791:b0:17c:c1dd:a3b5 with SMTP id q17-20020a170902f79100b0017cc1dda3b5mr4584104pln.141.1665747080886;
        Fri, 14 Oct 2022 04:31:20 -0700 (PDT)
Received: from localhost ([36.152.119.226])
        by smtp.gmail.com with ESMTPSA id o15-20020a6548cf000000b0043c22e926f8sm1247133pgs.84.2022.10.14.04.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:31:20 -0700 (PDT)
Date:   Fri, 14 Oct 2022 11:31:16 +0000
From:   Wei Gong <gongwei833x@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH RFC] pci: fix device presence detection for VFs
Message-ID: <20221014113116.GA409811@zander>
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
I have done the test and it works well
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
