Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ED16C64B0
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 11:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjCWKUA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 06:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCWKT7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 06:19:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EAA1B2D4
        for <linux-pci@vger.kernel.org>; Thu, 23 Mar 2023 03:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679566758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=coqjmjk6xTYfq/k9FbHyeBz4n2qs9gX3DbZ21S5gxLM=;
        b=BmQHZ7+D50t162AmpzzS4W40bDYTmXLUsqPhYna+tFquu0IJ6VWvrMp0GWwlqgmJ3jo82g
        I1zMoE6qpbYwpz0TUAAeoAJOIZSfDU3QwhqPPNBXcDsp4vhIb+HBmK+8XQ43lMMUj+mzj6
        cafvJgNIUK1vFNPoPawOMT2N1zBuSV0=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-Qt1j6MlMPkeeo9NS61k5Wg-1; Thu, 23 Mar 2023 06:19:16 -0400
X-MC-Unique: Qt1j6MlMPkeeo9NS61k5Wg-1
Received: by mail-ua1-f72.google.com with SMTP id q72-20020a9f37ce000000b0074555fb6330so10689485uaq.15
        for <linux-pci@vger.kernel.org>; Thu, 23 Mar 2023 03:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679566756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=coqjmjk6xTYfq/k9FbHyeBz4n2qs9gX3DbZ21S5gxLM=;
        b=MnIL/Ey2DrAubjmrxPj2ilaKyJeoqnanqYnc+CEfmCxbxDKJZ11l7WkTnM8MZGS53t
         IkXS9/PI2d1KvQtvad/n/CuCxNPGX429ykHduAfxkO6/JPbzwItfVV3UV5cQuny4iuGf
         BDpzmJQthUrJtyFnWe4Yx8Ijdm4Z7wK+A3XDGsvLSCjtmZMhuNTpK+A+msZeiCG5PUHl
         VWPtoAQyXMdGeYFFbE95oUEDAcz+fEawSoOYOVYfLRyURXk09bpGYxyRBThSDpb6J+ik
         ioAShDTiF473ppspNlX5KaC/b6niqScIOXpmWphiHR3AsyiBzKTncCHd2WWwiEaLtmYZ
         9F/Q==
X-Gm-Message-State: AO0yUKXpPxmiOys8aQJE6GBdWwAh09vcTALrNxNtO13OTLT/LXI+0m/4
        DoecJ/KmkIy6PdjEngcapfDca8sVwDGhGvCtyAbuo+MsAOHUsI/L3d8OPmGFubFbblZAyXoZyMi
        KUL3+U082VI3lpcx/iNBhdlGee2KrEzl1JZdl
X-Received: by 2002:a67:c806:0:b0:421:eabb:cd6a with SMTP id u6-20020a67c806000000b00421eabbcd6amr1484068vsk.7.1679566756126;
        Thu, 23 Mar 2023 03:19:16 -0700 (PDT)
X-Google-Smtp-Source: AK7set9bO436jAIPrYPp1c17CTG8//r0fD/7JbusN2dBE31dz0Yy7ZQYwg0mGeQ3xuA+3IGEeGVsjShUmMO/0Fz63Is=
X-Received: by 2002:a67:c806:0:b0:421:eabb:cd6a with SMTP id
 u6-20020a67c806000000b00421eabbcd6amr1484057vsk.7.1679566755845; Thu, 23 Mar
 2023 03:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230307-apple_pcie_disabled_ports-v3-1-0dfb908f5976@jannau.net>
In-Reply-To: <20230307-apple_pcie_disabled_ports-v3-1-0dfb908f5976@jannau.net>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Thu, 23 Mar 2023 10:19:00 +0000
Message-ID: <CAOgh=Fy6XsRFquqKMvMkbaCpowJf6twmRwkqoo_Fm1_O02n7bQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: apple: Set only available ports up
To:     Janne Grunau <j@jannau.net>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sven Peter <sven@svenpeter.dev>, linux-pci@vger.kernel.org,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 23 Mar 2023 at 08:16, Janne Grunau <j@jannau.net> wrote:
>
> The Apple SoC devicetrees used to delete unused PCIe ports. Avoid to set
> up disabled PCIe ports to keep the previous behaviour. MacOS initialized
> also only ports with a known device.
>
> Use for_each_available_child_of_node instead of for_each_child_of_node
> which takes the "status" property into account.
>
> Link: https://lore.kernel.org/asahi/20230214-apple_dts_pcie_disable_unused-v1-0-5ea0d3ddcde3@jannau.net/
> Link: https://lore.kernel.org/asahi/1ea2107a-bb86-8c22-0bbc-82c453ab08ce@linaro.org/
> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Janne Grunau <j@jannau.net>

Tested this on Asahi Fedora Remix kernel-edge on Mac Mini M1.

Tested-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
> Changes in v3:
> - dropped Cc: stable
> - rewritten commit message since the warning is fixed by 6fffbc7ae137 ("PCI: Honor firmware's
> device disabled status")
> - Link to v2: https://lore.kernel.org/r/20230307-apple_pcie_disabled_ports-v2-1-c3bd1fd278a4@jannau.net
>
> Changes in v2:
> - rewritten commit message with more details and corrections
> - collected Marc's "Reviewed-by:"
> - Link to v1: https://lore.kernel.org/r/20230307-apple_pcie_disabled_ports-v1-1-b32ef91faf19@jannau.net
> ---
>  drivers/pci/controller/pcie-apple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 66f37e403a09..f8670a032f7a 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -783,7 +783,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
>         cfg->priv = pcie;
>         INIT_LIST_HEAD(&pcie->ports);
>
> -       for_each_child_of_node(dev->of_node, of_port) {
> +       for_each_available_child_of_node(dev->of_node, of_port) {
>                 ret = apple_pcie_setup_port(pcie, of_port);
>                 if (ret) {
>                         dev_err(pcie->dev, "Port %pOF setup fail: %d\n", of_port, ret);
>
> ---
> base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
> change-id: 20230307-apple_pcie_disabled_ports-0c17fb7a4738
>
> Best regards,
> --
> Janne Grunau <j@jannau.net>
>
>

