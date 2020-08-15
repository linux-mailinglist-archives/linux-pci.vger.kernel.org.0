Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA3F2452BF
	for <lists+linux-pci@lfdr.de>; Sat, 15 Aug 2020 23:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgHOVym (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Aug 2020 17:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbgHOVwc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Aug 2020 17:52:32 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E39EC03B3D2;
        Sat, 15 Aug 2020 01:45:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so12311364ljg.13;
        Sat, 15 Aug 2020 01:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jwsjl5Yl1LFkiTpIfV4FC2pCDY0RlfTGIWFy5618czY=;
        b=JscczZiBHiR/E30j1ODTRjEZ1J6tzdLICchjfKYD9oDq4hBTSw16cEKX38WSL3gIRR
         xrnOqDQrO6y6nSFgZXIXzbnTdDu/52bbdqMewnXiQwAXD4xwaQ5W/NwThRCamidnVbmi
         +OlUdBEBVMhTn2wgmOeXl6eQAS5m7c4rvBo0DLKI2UIO242DkP5o4nz2udq02GRUsqvU
         nz5Syvq8CziHecgVZN5uKOS2Z/hKrUDqLlYS/7A+CIhHbPQO7h7h90xHiEBwYg/VpZsi
         Hk/phvDKEAzoetTrUL85EGK3C692AW4EDjNNzVdsvul0ZuYBcZUwoFMdM1I+OhdgZN87
         3y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Jwsjl5Yl1LFkiTpIfV4FC2pCDY0RlfTGIWFy5618czY=;
        b=exEXvbWnvm/975OkswMu12dF470FkJxH/W2gACT96ituYQUvo4xznEJxaPEjqcp2hw
         e5tx9r0Tfq8goRDeO493KT4dPz77mRmVv94IAsH4kvrBUGjZggPyiyJTIx/SWt+hbZaW
         c2hCthKcuT1hjan4ZQpXgWal4Itk0wr238qLRrGLWt0+d/cgm933emLWn7bO58CPTH3U
         R668z6UeSHR0inuw5bc8NcwNq9YDRce618SjXSZsZggby0haXDipZzJIBwWY/JxFneUq
         pRhrIhtoD1ol6Z4w0Kk6Xkwb+xZfEVN3N7LLUmC3I5X9WENunrc0qCFjXREWT7g+Sffh
         a7rQ==
X-Gm-Message-State: AOAM530KkoUDm23CgyqT30bT/mFuRIe6+IQ03RnlBOPVAlKo/bcjcqH3
        Iqprgt57QfFq/eRVtyKcCZk=
X-Google-Smtp-Source: ABdhPJxfJPykrCx26X5MYrFKAvPWACW5EIexq2GfCBCd7z/Z++I/TIHakOXnD8XGsq3zFFne/FcS3Q==
X-Received: by 2002:a2e:808f:: with SMTP id i15mr3244164ljg.151.1597481138853;
        Sat, 15 Aug 2020 01:45:38 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:6e9:851e:a10b:7957:433d:a960? ([2a00:1fa0:6e9:851e:a10b:7957:433d:a960])
        by smtp.gmail.com with ESMTPSA id f3sm2331191ljo.81.2020.08.15.01.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2020 01:45:38 -0700 (PDT)
Subject: Re: [PATCH 3/5] arm64: dts: renesas: r8a774a1: Add PCIe EP nodes
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20200814173037.17822-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200814173037.17822-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <fcabccab-54fb-8b8a-7034-9b0da9d32339@gmail.com>
Date:   Sat, 15 Aug 2020 11:45:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200814173037.17822-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On 14.08.2020 20:30, Lad Prabhakar wrote:

> Add PCIe EP nodes to R8A774A1 (RZ/G2M) SoC dtsi.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>   arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 38 +++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> index a603d947970e..50e9ed16a36d 100644
> --- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> @@ -2369,6 +2369,44 @@
>   			status = "disabled";
>   		};
>   
> +		pciec0_ep: pcie_ep@fe000000 {

    Hyphens are preferred over underscores in the node/prop names.

[...]> +		pciec1_ep: pcie_ep@ee800000 {

    Ditto, should be "pci-ep@ee800000".

[...]

MBR, Sergei
