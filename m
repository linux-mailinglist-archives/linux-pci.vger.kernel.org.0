Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D459C71583B
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 10:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjE3IT5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 04:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjE3ITi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 04:19:38 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EC7CD;
        Tue, 30 May 2023 01:19:22 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-399dfeeb96aso2606392b6e.1;
        Tue, 30 May 2023 01:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685434761; x=1688026761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rUslCAqAUHYdcANPf4Fjrc2wg7fzvi8y+ZTvGo2i9IM=;
        b=i0wwwII1juT1nRrvNDcadTgBKYs+om94n4MzYfL1Pe1fadaeApJ3manBSFw08YEpG2
         ZjrxPaH+iB0SxavT1BoxNjDPqqBWsgix7IORhO5wNXY7hFiPuRf8yjemg4Px+VTKtLgi
         fgutNre26sLEpmf3MOrFQBN0ESE3iqKACYdo2wL49i1L7bbw4JmhcXY2zxGU+JzKw2g5
         SVedmOmUo2P+P0Y8KlX4BqUGn/QsOfF3Ai8yFc/tEbEQHKr08Wart+jxr6S7iQOy7ZQU
         sLBg4Yywp39/qRJOUStqG4+W+aqrhEhjrM4MK9/s3h3/DnPTCd6FArqx98efXA25ot9z
         Dn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685434761; x=1688026761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUslCAqAUHYdcANPf4Fjrc2wg7fzvi8y+ZTvGo2i9IM=;
        b=JMbIKyF6+sWF1rlTCsPkD9x/IqiNgF9nV9UY5EjcwK1OYxdRrbsVp59ex22OmBo2C7
         K0Kq2/tpdfPRNPRAv73VvhdeEwJ74Ol5BqEWn7PV1Qmsbf+Ai9TIanb9i8snFGwzp/S+
         oUqvytLW5KaBqn4J6SJO4Kj61rUoZ8tunvR045LXLe8NZtMZFQ8vq3BC5hBrFMpIe764
         j3aw81Ub5Htd/Ln0bh4YpAtZQSQnw9ZERkSNyIdXYLZihHvx/MFR9rIHpl1ZtEdyPnd6
         ZFOZ8b4RlTWtP/qQ39EfOUo83tG1oVrsiPKWFjIsd0y6GJu2QlsTWCgHWCxPg7JKdzbl
         zwWg==
X-Gm-Message-State: AC+VfDxKvFpfQIbYFxy+9wVx0LPcsepXNH/wE8YTDrKJmsJDcWVxCAON
        p4WuSZmCt2zaq8fJFKz415CIzUSoCQf17Xq6YH0=
X-Google-Smtp-Source: ACHHUZ6veEt6z3yNhFECh8TzuY5A12HJ4x5l41Bqb+FARxHgypoWsrFhYK43yJl+GLvmhW3ZYF0aiVapsZ0yfxyx3u4=
X-Received: by 2002:aca:bf86:0:b0:39a:4170:6840 with SMTP id
 p128-20020acabf86000000b0039a41706840mr83300oif.21.1685434761311; Tue, 30 May
 2023 01:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230427055032.85015-1-rath@ibv-augsburg.de> <20230427055032.85015-2-rath@ibv-augsburg.de>
In-Reply-To: <20230427055032.85015-2-rath@ibv-augsburg.de>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Tue, 30 May 2023 10:19:10 +0200
Message-ID: <CAH9NwWfcjKw_e1qjo7bOPwjipfzVVVNh=9JEbB5Z+XAr6edd9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: cadence-torrent: Add latency properties
To:     Dominic Rath <rath@ibv-augsburg.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tjoseph@cadence.com, bhelgaas@google.com, lpieralisi@kernel.org,
        nm@ti.com, vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bahle@ibv-augsburg.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>
> From: Alexander Bahle <bahle@ibv-augsburg.de>
>
> Add "tx-phy-latency-ps" and "rx-phy-latency-ps" DT bindings for
> setting the PCIe PHY latencies.
> The properties expect a list of uint32 PHY latencies in picoseconds for
> every supported speed starting at PCIe Gen1, e.g.:
>
>   tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
>   rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */
>
> Signed-off-by: Alexander Bahle <bahle@ibv-augsburg.de>
> Signed-off-by: Dominic Rath <rath@ibv-augsburg.de>

Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>

> ---
>  .../bindings/phy/phy-cadence-torrent.yaml     | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> index 2ad1faadda2a..93228a304395 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> @@ -126,6 +126,24 @@ patternProperties:
>          enum: [2160, 2430, 2700, 3240, 4320, 5400, 8100]
>          default: 8100
>
> +      tx-phy-latency-ps:
> +        description:
> +          The PHY latencies for the TX direction applied to PCIe PTM timestamps. Most
> +          PCIe PHYs have asynchronous latencies for their RX and TX paths. To obtain
> +          accurate PTM timestamps, the PCIe PTM specification requires that the time
> +          at which the first serial bit is present on the serial lines be taken.
> +          Should contain picosecond latency values for each supported speed,
> +          starting with Gen1 latency.
> +
> +      rx-phy-latency-ps:
> +        description:
> +          The PHY latencies for the RX direction applied to the PTM timestamps. Most
> +          PCIe PHYs have asynchronous latencies for their RX and TX paths. To obtain
> +          accurate PTM timestamps, the PCIe PTM specification requires that the time
> +          at which the first serial bit is present on the serial lines be taken.
> +          Should contain picosecond latency values for each supported speed,
> +          starting with Gen1 latency.
> +
>      required:
>        - reg
>        - resets
> @@ -203,6 +221,8 @@ examples:
>                  cdns,phy-type = <PHY_TYPE_PCIE>;
>                  cdns,num-lanes = <2>;
>                  cdns,ssc-mode = <CDNS_SERDES_NO_SSC>;
> +                tx-phy-latency-ps = <138800 69400>;
> +                rx-phy-latency-ps = <185200 92600>;
>              };
>
>              phy@2 {
> --
> 2.36.0
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
