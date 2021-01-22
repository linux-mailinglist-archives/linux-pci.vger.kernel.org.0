Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F343F3004CB
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 15:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbhAVODu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 09:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbhAVODW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jan 2021 09:03:22 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123BCC06174A;
        Fri, 22 Jan 2021 06:02:42 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id bx12so6647355edb.8;
        Fri, 22 Jan 2021 06:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rJTtOq8f3FlXKNS2xc6ac2je/Zvq93yXj8Whnd3Or3M=;
        b=X3g4hnUQFKT/NU/h5d8/fUqMKlC+/2uBgHiH2GmXlUtOrwHENTKO5h6e0oyvpL3Z0w
         g/HkwRCgYa6BNDwoSfTDzK41Kjouh1XUPZqh7uWnWverY+V6dyEynL/86jIgL3cefFJ6
         hgk9awlKyZ7+09UHDJHzVLKn5B23FCQhFNYyLhsphUqwLmgKXNfY+RPxSbQ6GNard1nV
         ddc7t2WPT9vo/7HO2SII0XEl7cjLl7FFN1UXBCAKCxOM7LDnDCgb9x3d/OCYayP/3Odw
         mBP7CN0KJ4SHjIYqPB05hUDof2976vr9DGtEAaxfo3RofWnbnCnXiTR3+IBa2Jwnts+R
         hr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rJTtOq8f3FlXKNS2xc6ac2je/Zvq93yXj8Whnd3Or3M=;
        b=gTPXko01bGJxYWc0VZlmZqJhMuU5/ZgOQtr+S6W8ZxYMPCCaR3WSBORYpE88AIWvco
         EFquetk2h6EWY6TwtcMOYazk4uDY6LDyGvqOaCic9b8uzf4Bfyg3mWVl7s21N1d/Eb8t
         QHOBcHc63tCAig8VJlpkPvXHdr7KEHpmq0m/E3BZN9cAjK1T6z0/Vr9VvZP4z7lKJcjz
         ObS9JJu8VgVioc/59cn1olY/gu9gtszSQLKKFy14efxU1Irge6Qb7pkG2wwnohhFj/i/
         AaWdtCq+cz/QWrYbQq+S0hnZTgPgO7eZ99jAKDwfVry2XLm18MXLmdILH42cFGvqlBHb
         TW2w==
X-Gm-Message-State: AOAM532xB/wam0aNYP4+8RFrg/7cyMlTNKOrwBKYzpVed5WmcTf8cuwW
        0pjCMrfxj0HV4iyYi/S5h8Q=
X-Google-Smtp-Source: ABdhPJys+MBeoVfqapSNF84elvf+M7qMEaeBOGGFAU/c93EVbQWEqFFcrrGZaVn999BHQajxg1OGWg==
X-Received: by 2002:a50:d6dc:: with SMTP id l28mr3383739edj.105.1611324160810;
        Fri, 22 Jan 2021 06:02:40 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g2sm4464232ejk.108.2021.01.22.06.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 06:02:40 -0800 (PST)
Subject: Re: [PATCH v2 1/2] dt-bindings: rockchip: Add DesignWare based PCIe
 controller
To:     xxm <xxm@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Heiko Stuebner <heiko@sntech.de>
References: <20210120101554.241029-1-xxm@rock-chips.com>
 <3af70037-c05d-1759-2bae-41db1e8e2768@gmail.com>
 <31b54a67-eb1e-fa57-fff7-a0c867f27cc6@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <9c560852-8ebf-61a6-906b-9cc8ced8bed0@gmail.com>
Date:   Fri, 22 Jan 2021 15:02:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <31b54a67-eb1e-fa57-fff7-a0c867f27cc6@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Simon,

A few comments, have a look if it is useful or that you disagree.

/////

The format of ranges in your pcie node in rk3568.dtsi and your example
is wrong!

  ranges:
    oneOf:
      - $ref: "/schemas/types.yaml#/definitions/flag"
      - minItems: 1
        maxItems: 32    # Should be enough
        items:
          minItems: 5
          maxItems: 7
          additionalItems: true
          items:
            - enum:
                - 0x01000000
                - 0x02000000
                - 0x03000000
                - 0x42000000
                - 0x43000000
                - 0x81000000
                - 0x82000000
                - 0x83000000
                - 0xc2000000
                - 0xc3000000

The array size is 3: ==> maxItems: 3
in a array a range of 5 to 7 u64 is expected.
They must start with one of the enums above!
yaml dt_check expects <> around every array member!

Old example:

ranges = <0x00000800 0x0 0x80000000 0x3 0x80000000 0x0 0x800000

0x00000800 is not in the list of above, please recheck!

          0x81000000 0x0 0x80800000 0x3 0x80800000 0x0 0x100000
          0x83000000 0x0 0x80900000 0x3 0x80900000 0x0 0x3f700000>;

New example:
FICTION example with correct first element, but maybe NOT good for
Rockchip pcie!

ranges = <0x81000000 0x0 0x80000000 0x3 0x80000000 0x0 0x800000>,
         <0x81000000 0x0 0x80800000 0x3 0x80800000 0x0 0x100000>,
         <0x83000000 0x0 0x80900000 0x3 0x80900000 0x0 0x3f700000>;
	
Change this also in rk3568.dtsi!

/////

rockchip_add_pcie_port()

For FTRACE filters it is needed that all functions start with the same
function prefix.

Maybe use:
rockchip_pcie_add_port()

/////

The function prefix of pcie-dw-rockchip.c is identical with functions in
pcie-rockchip-host.c
Is that OK for the maintainers?

/////

+static struct platform_driver rockchip_pcie_driver = {
+	.driver = {
+		.name	= "rk-pcie",

Maybe change to:

+		.name	= "rockchip-dw-pcie",

This name shows up in the kernel log.
Could you keep it in line with other Rockchip names, so we can filter
more easy?

dmesg | grep rockchip

rockchip-vop
rochchip-drm
etc.

+		.of_match_table = rockchip_pcie_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = rockchip_pcie_probe,
+};

/////
