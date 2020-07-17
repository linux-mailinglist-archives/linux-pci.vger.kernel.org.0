Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F54223C04
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 15:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgGQNNI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgGQNNH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2020 09:13:07 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E1BC08C5CE
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2020 06:13:06 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id t9so6000145lfl.5
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2020 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IYqIiSc4U+64C+dG7+7slm/+2g/0OvHpgIOhb6Omtgc=;
        b=Yr2Iz1CP+EXc8VfkIDEksEY8LuFINVnWrfFXlpNEfmNponbzhEbML51zKfKEJKcimu
         x1SnWuwfMbqbICdyW0Fkyf8z2jRI0dj2VVtiK0vt9+Li6/mx02iD09DEAMmmnGMZDFsp
         v9qrVYb5fPT/ksWDS6HEEEhxB3mgGQSgpTl9jkHinDmTnMJRBY6ZwvroDmZNtB+/ycaN
         R4CUaCV18VNjMH0K/SPqYMeAlS38rwJ6tO1YuLpWlEl1iGbu4ouGnMmwUp4Qy1S3HxPh
         0hR2twN4iNh9G++ahDfjijCYizBZwgESgeK8xKSjPK2A2oh26Hivv91I99y1X0ci9dI5
         5TjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IYqIiSc4U+64C+dG7+7slm/+2g/0OvHpgIOhb6Omtgc=;
        b=QI7H6DbVSCHPbYVQb8pYYMAu/sN3EzBzdSPZ00M734pvV8muK3BzGk9tLb9AAf9LkC
         VOxsqUC7HQeTtB2GxGx+Q7PRG1x7Z7UlymuPkx4+2cRijOSVgHnZHwLKpZWKgCYZckCH
         jqlzFJHI07/EpvwiIyFx6DXQpJwfcgmgahOtssZfKHH3DbuN/xbWqeGpR7Kw9AYaYhT2
         CJOEi70iAEy8qTj+/yd0nKRmA3wkYa84LNroXtVIFHbMZMZ4DWybzPTTQs0v4ZeCJvHO
         rCKJr20Srj9a6guaPSRvB/3mcGrArkzZFkbDoAFC+nezDs0ZEWCUgHj2l2/o8nGAYP4l
         RGAA==
X-Gm-Message-State: AOAM532ejYucXRhonrY08tdY8LEMtdZBJm8T/jZPbo4kEoY9DgJwEE3L
        FccOV/TYUYModVDlBbhW8Pgrdw==
X-Google-Smtp-Source: ABdhPJyuAt5XLkeaHa2ADqc8yqRKoh6hwmeK7QXeggSiowkUr6/ybt/t04bLY7BvMRtrHmWBjAcMCQ==
X-Received: by 2002:a19:710:: with SMTP id 16mr3866800lfh.171.1594991585253;
        Fri, 17 Jul 2020 06:13:05 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id j4sm1862395lfb.94.2020.07.17.06.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:13:04 -0700 (PDT)
Date:   Fri, 17 Jul 2020 15:13:03 +0200
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
Subject: Re: [PATCH 16/20] dt-bindings: media: renesas,csi2: Add R8A774E1
 support
Message-ID: <20200717131303.GA175137@oden.dyn.berto.se>
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-17-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594919915-5225-17-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lad,

Thanks for your patch.

On 2020-07-16 18:18:31 +0100, Lad Prabhakar wrote:
> Add the compatible string for RZ/G2H (R8A774E1) to the list of supported
> SoCs.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Niklas S�derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  Documentation/devicetree/bindings/media/renesas,csi2.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/renesas,csi2.yaml b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> index c9e068231d4b..53b078622fd9 100644
> --- a/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> +++ b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> @@ -22,6 +22,7 @@ properties:
>          - renesas,r8a774a1-csi2 # RZ/G2M
>          - renesas,r8a774b1-csi2 # RZ/G2N
>          - renesas,r8a774c0-csi2 # RZ/G2E
> +        - renesas,r8a774e1-csi2 # RZ/G2H
>          - renesas,r8a7795-csi2  # R-Car H3
>          - renesas,r8a7796-csi2  # R-Car M3-W
>          - renesas,r8a77965-csi2 # R-Car M3-N
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas S�derlund
