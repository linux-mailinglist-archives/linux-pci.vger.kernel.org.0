Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD79425F11D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 02:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgIGABe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Sep 2020 20:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgIGABc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Sep 2020 20:01:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9F7C061573;
        Sun,  6 Sep 2020 17:01:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so13909185wrn.6;
        Sun, 06 Sep 2020 17:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=hAl41FsgIGdMIsMLN84rHm54GtSprfu3eN3a43yq1ZY=;
        b=i2RBNAjrOck1Q0S+XDaSPGJ74pshaf6Vb4NW+8ELL6mGUu0TxsL6/qghWVOihfXzkE
         +9QdnBhtaWvE7DnZPP4pNZmg9v5IGDW8H4F/OfiJJU1rmKsiA9l+uuZ4rAxvZ6Upiphm
         k6l1N9QPmazbf8ajAIVhPLg4WdJxTtGg8ZGvKCReH797xAcW1dzwzP8E+eqloC6Wmg/g
         /lQ0XhfWgJz7rhJ9hXPQDe05enVVI5YHSDrdLDyDdaxxbYOsduSWG05FfXG5+551kj8f
         de+JYTyuE6w0NwRzp1gcbOo9eFp7GZ3k2TRTmoFD6oPHfvGvkPK7tLB8D8luxnhb7ISg
         GI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=hAl41FsgIGdMIsMLN84rHm54GtSprfu3eN3a43yq1ZY=;
        b=UHL1WfdX8oEzl+ne/JJDW+gCxHFS7mqJrX5clWb7E2ytxVPxpMnoL4iEr0PfhlXe2p
         wcDd0NUSUi248gBSnHNorYqdrwK51mh5JVLSatb5AXrR10YjSGDzWNgmy143T0LFPuXf
         xQGGepvKwr5An5yNYqeMZF/RpRU7vmfZSejhr5ZEoUvYBGWaQX+WpfzcIH25wsX8pgYn
         sT1Fw1II0QYFEujtSE5bqYSlR+UVu17zNa5P+Sho//+ywNBBdNmow8OhKeTeG72Wf+HP
         55KJDJzP+Qt6TxXNV7F3d0TTQws+T9O3EmtvmFwYwM4P1NC7qe++Ew25/u6eGIUjRM81
         JAAg==
X-Gm-Message-State: AOAM533NndXXJxq8IsPmtpUHSx3JT2o2WRNwaRQPzndQpFenuqlzNqPs
        GLdr1zX0I+F6PnEC89jqKFM=
X-Google-Smtp-Source: ABdhPJzCIyQVHle7F0WcEUJV2nJn8juAWy2VS76umjtOYZmgKDV72FojZtfVo0c1qd+YaIzEJbmqhw==
X-Received: by 2002:a5d:470f:: with SMTP id y15mr18317326wrq.420.1599436889735;
        Sun, 06 Sep 2020 17:01:29 -0700 (PDT)
Received: from AnsuelXPS (host-95-251-120-70.retail.telecomitalia.it. [95.251.120.70])
        by smtp.gmail.com with ESMTPSA id v204sm24461150wmg.20.2020.09.06.17.01.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Sep 2020 17:01:28 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Ilia Mirkin'" <imirkin@alum.mit.edu>
Cc:     <linux-arm-msm@vger.kernel.org>,
        "'Linux PCI'" <linux-pci@vger.kernel.org>
References: <CAKb7UvhqZMcL3UNbK-6ZG9LJddCmoL0paYsRx6+5bVKDQpAjmQ@mail.gmail.com>
In-Reply-To: <CAKb7UvhqZMcL3UNbK-6ZG9LJddCmoL0paYsRx6+5bVKDQpAjmQ@mail.gmail.com>
Subject: R: Regression with "PCI: qcom: Add support for tx term offset for rev 2.1.0"
Date:   Mon, 7 Sep 2020 02:01:26 +0200
Message-ID: <018101d684aa$088a33b0$199e9b10$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQKUbcbH1xa+lxeCrqP27Zr5uAIZFafgd8Bg
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Messaggio originale-----
> Da: Ilia Mirkin <imirkin@alum.mit.edu>
> Inviato: luned=C3=AC 7 settembre 2020 00:59
> A: Ansuel Smith <ansuelsmth@gmail.com>
> Cc: linux-arm-msm@vger.kernel.org; Linux PCI =
<linux-pci@vger.kernel.org>
> Oggetto: Regression with "PCI: qcom: Add support for tx term offset =
for rev
> 2.1.0"
>=20
> Hi Ansuel,
>=20
> I'm on an ifc6410 (APQ8064), and the latest v5.9-rc's hang during PCIe
> init. I just get:
>=20
> [    1.191861] qcom-pcie 1b500000.pci: host bridge /soc/pci@1b500000
> ranges:
> [    1.197756] qcom-pcie 1b500000.pci:       IO
> 0x000fe00000..0x000fefffff -> 0x0000000000
> [    1.205625] qcom-pcie 1b500000.pci:      MEM
> 0x0008000000..0x000fdfffff -> 0x0008000000
>=20
> and then it hangs forever. On a working kernel, the next message is =
e.g.
>=20
> [    6.737388] qcom-pcie 1b500000.pci: Link up
>=20
> A bisect led to
>=20
> $ git bisect good
> de3c4bf648975ea0b1d344d811e9b0748907b47c is the first bad commit
> commit de3c4bf648975ea0b1d344d811e9b0748907b47c
> Author: Ansuel Smith <ansuelsmth@gmail.com>
> Date:   Mon Jun 15 23:06:04 2020 +0200
>=20
>     PCI: qcom: Add support for tx term offset for rev 2.1.0
>=20
>     Add tx term offset support to pcie qcom driver need in some =
revision of
>     the ipq806x SoC. Ipq8064 needs tx term offset set to 7.
>=20
>     Link: https://lore.kernel.org/r/20200615210608.21469-9-
> ansuelsmth@gmail.com
>     Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller =
driver")
>     Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
>     Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>     Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>     Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
>     Cc: stable@vger.kernel.org # v4.5+
>=20
>  drivers/pci/controller/dwc/pcie-qcom.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> And indeed reverting this commit on top of v5.9-rc3 gets back to a
> working system. I have no idea what PHY_REFCLK_USE_PAD is, but it
> seems like clearing it is messing things up for me. (As everything
> else seems like it should be identical for me.)
>=20
> Let me know if you want me to test anything, or if the best path is to
> just revert for now.
>=20
> Cheers,
>=20

Thanks for the report. Can you confirm that by only removing=20
PHY_REFCLK_USE_PAD the problem is fixed? Wonder if it's better to
just make a patch to restrict the padding to only ipq806x and backport =
that.
(or revert and repush a better patch). What do you think?

> Ilia Mirkin
> imirkin@alum.mit.edu

