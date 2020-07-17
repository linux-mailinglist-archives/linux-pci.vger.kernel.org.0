Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD77C223C0D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 15:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgGQNOB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 09:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgGQNOA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2020 09:14:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE72FC08C5DD
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2020 06:13:58 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q7so12614426ljm.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2020 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DO4ZbPSH0hXkKVVssfyLC5Q3aPidsdt5JRzYM7Uja0g=;
        b=vuWSYW2icHEBGemf7McZrx7iWHM+guaeu1UPLUXXx73W6ZVH+iPhYbLn9Lq6fq4Zxw
         qMFpQ4NjZtdZlD/IYmhEodqpPUXrpmJspDd9GqaYLWtx358LP7zpcSqDQUibrEZH8mYY
         oayZ9ZK5Li/pN1dxmo7Db0uyPlKzeukaTmhJiBaGMXgUawLGoNWiBM1QfS2OIxmRXwDd
         mlQJeun7BJ6uLEOmk42vWLm+YtSv7IeJn0GZnfDNFcFNPedk+oiNPipVMidOvX4uN5gS
         z3TVTe6/7nHuq45oTV83wT+inIx0hVKdB5fBssyDMyqsr7EyGFXh8uumGJYY6HDd4M5v
         zpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DO4ZbPSH0hXkKVVssfyLC5Q3aPidsdt5JRzYM7Uja0g=;
        b=qO4T+kvMNwLnol21ur5FS77jAPgSxObTOKWmVlqhw0nlu0Mb63UGO0QWqzg7QNXXmZ
         RCo/dTTIj3YOH1wR46lXETMZ3cjtME+cW6OvKHNNtHMVH7Dge8fd7yU0tPhgMQQBOhtI
         PMqi/rgMfG81T9zldmv8CX5ppvjLNO5fLAFwS/iPNL/slpCFlCmow26wjMNmqEp/u4P1
         mh8VxFs92PCGS7nSjvj02BzVbf3cYHWN40gT3T68YzNFwYYLi3KNF9dXz85zYoC93n4z
         XxWAdP9rC1SOc0uG/Sbq1Ypt1JcSPuPt0LZE4ycmjk6dIr8P9jkCUcSXRTDEasEo4RsA
         aEGw==
X-Gm-Message-State: AOAM530ml2hIFaPt31R+ZCyMxbMqD2YC0/gMpiS1SWgWFCdlRBIgYRHP
        aZBaJIjMLNIINwm4IsuVLpEejg==
X-Google-Smtp-Source: ABdhPJzbBwZ8JwXa+it+ymJXMzGpPd34h3pjIGXCdigNzRtx0+bluFlcT4iPLpMRHuhw2GWIxlaPHQ==
X-Received: by 2002:a05:651c:1106:: with SMTP id d6mr4362497ljo.214.1594991637061;
        Fri, 17 Jul 2020 06:13:57 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id h23sm1754210lfk.37.2020.07.17.06.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:13:56 -0700 (PDT)
Date:   Fri, 17 Jul 2020 15:13:56 +0200
From:   Niklas <niklas.soderlund@ragnatech.se>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 18/20] media: rcar-csi2: Enable support for R8A774E1
Message-ID: <20200717131356.GB175137@oden.dyn.berto.se>
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-19-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594919915-5225-19-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lad,

Thanks for your work.

On 2020-07-16 18:18:33 +0100, Lad Prabhakar wrote:
> Add the MIPI CSI-2 driver support for RZ/G2H (R8A774E1) SoC.
> The CSI-2 module of RZ/G2H is similar to R-Car H3.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Niklas S�derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/media/platform/rcar-vin/rcar-csi2.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
> index c6cc4f473a07..2325e3b103e4 100644
> --- a/drivers/media/platform/rcar-vin/rcar-csi2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
> @@ -1090,6 +1090,10 @@ static const struct of_device_id rcar_csi2_of_table[] = {
>  		.compatible = "renesas,r8a774c0-csi2",
>  		.data = &rcar_csi2_info_r8a77990,
>  	},
> +	{
> +		.compatible = "renesas,r8a774e1-csi2",
> +		.data = &rcar_csi2_info_r8a7795,
> +	},
>  	{
>  		.compatible = "renesas,r8a7795-csi2",
>  		.data = &rcar_csi2_info_r8a7795,
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas S�derlund
