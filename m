Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3BE5E8470
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 22:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIWU6F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 16:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIWU5v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 16:57:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14036102515;
        Fri, 23 Sep 2022 13:57:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a26so3109634ejc.4;
        Fri, 23 Sep 2022 13:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wSW+iuhGBebwRHZNlzdV/Y3lzOXh7CiDYf7HI4b2wx0=;
        b=KIrdw0nCwEtDvUdQu5Gx8OLUHB+WDBlZ4c+WjvffT7w4BcqsL8rYxnAXKyPNwalxx1
         vEqeDhDI5AUWJ0cZILpI4zXi0THD4JHAZtkv0lW29ISdUe8UqLJNxdxDsyeGD8XJ+QeS
         3lqwwmrJtFuE9YDs2RB75LW4qpihPaj24bktgwzq6d3qfRuX2aYzOr59wfL3BapXyxg7
         Da53dioJ72fNKM9+/o4f33K0TFeSVkwzgmgs2fN9FoT0oWoO0jBHaYvA1g8aoWjlJMPj
         VuKbXKV5Pf0vMqVSoN6LqVzl9IPeU063j1nwhW8Eb5cdri13JoTg2gIuqjkv6N+wDm6r
         rk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wSW+iuhGBebwRHZNlzdV/Y3lzOXh7CiDYf7HI4b2wx0=;
        b=nHnoM5BKAfk0zNxlBHfvkgwQnjVTjusyvS/0iVJizIuaHK3xMrf5U61Kj69QH0gwvG
         VdmoWR6IhmYhMYp9tP/rjKzGvfFaM20wfHMU8Y4/x5goK6se3BR+3JrU2Qj15h2mbAxD
         ssZfdP2u92GnXS1RZp+8OxiT0SZD0UeZ5aw8NdOhs+SmW3PNcobLX2AQjkgXhTGIgzaN
         6iEMIAC73yQGDEhwz8qcDZTqM1fS94fZRjQSV5cG4dDPNItnl/8jtmu3D+uXxjyfe1WW
         SdqSvvOQNK+1WrKUSEVPcyhkmdX5YW9VFTB/hhubTLkuEM4uKeE4FYDRR1wuo3Rci7WL
         dkqQ==
X-Gm-Message-State: ACrzQf0US2V/2M8VegTYboAVh5wYN/e06apS/awG9YtGlBJQf87R/XRL
        oQMMW/qBiJnxr0u8+3qXbEYx9lGsHAlt+dLzT7g=
X-Google-Smtp-Source: AMsMyM5zcMRLzYF0an9CijyFPVQRKsZIMBKzPzXCGyAjCdLwRKp/jp76+ZpzXJ97i6DUAXu7Fip9sqGnPCSeFoaJWok=
X-Received: by 2002:a17:907:270b:b0:77b:17b3:f446 with SMTP id
 w11-20020a170907270b00b0077b17b3f446mr8548123ejk.415.1663966666536; Fri, 23
 Sep 2022 13:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220919143123.28250-1-vidyas@nvidia.com>
In-Reply-To: <20220919143123.28250-1-vidyas@nvidia.com>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Fri, 23 Sep 2022 13:57:34 -0700
Message-ID: <CAPOBaE42Rzq63d11i=9Ck1rjb3hdxOe81NWPc1QVQ7P0MWu1Vw@mail.gmail.com>
Subject: Re: [PATCH V1] PCI: dwc: Fixes N_FTS setup
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 19, 2022, Vidya Sagar <vidyas@nvidia.com> wrote:
>
> commit aeaa0bfe89654 ("PCI: dwc: Move N_FTS setup to common setup")
> unnecessarily uses pci->link_gen in deriving the index to the
> n_fts[] array also introducing the issue of accessing beyond the
> boundaries of array for greater than Gen-2 speeds. This change fixes
> that issue.
>
> Fixes: aeaa0bfe8965 ("PCI: dwc: Move N_FTS setup to common setup")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Please send a V2 patch that addresses Bjorn's feedback.
Thank you.

Best regards,
Jingoo Han

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c6725c519a47..9e4d96e5a3f5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -641,7 +641,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
>         if (pci->n_fts[1]) {
>                 val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>                 val &= ~PORT_LOGIC_N_FTS_MASK;
> -               val |= pci->n_fts[pci->link_gen - 1];
> +               val |= pci->n_fts[1];
>                 dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
>         }
>
> --
> 2.17.1
>
