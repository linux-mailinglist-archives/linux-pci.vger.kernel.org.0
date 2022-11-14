Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA24627D49
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 13:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbiKNMEs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 07:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236908AbiKNMEP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 07:04:15 -0500
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D730DCF4;
        Mon, 14 Nov 2022 04:03:26 -0800 (PST)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout1.routing.net (Postfix) with ESMTP id 8DCB14039D;
        Mon, 14 Nov 2022 12:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1668427404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+qsBs+Kv75dt/RxGUrrDRnA1t7VzT/aujJrE6bOKkhQ=;
        b=tywKneJ6RCUDygzOyvnhznh7nozSIPrqWDAkYH00M5/JOtjyaJmW6l312L3cHWckmBN2Cd
        jN5NC9KPLQAxA2Y6V3+Qx5wLNvvnU4/d7ZkOtFqSF2vFLpzyzblPq09z1t6VZIMBaDQIAb
        J0mKVrN0oI2R1yTFAqaqByqasUs/elc=
Received: from [127.0.0.1] (tmo-102-240.customers.d1-online.com [80.187.102.240])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 4DF361007BC;
        Mon, 14 Nov 2022 12:03:23 +0000 (UTC)
Date:   Mon, 14 Nov 2022 13:03:18 +0100
From:   Frank Wunderlich <linux@fw-web.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
CC:     devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 10/11] arm64: dts: mt7986: add Bananapi R3
User-Agent: K-9 Mail for Android
In-Reply-To: <ee410f80-1697-6146-9755-981f2d45e88f@collabora.com>
References: <20221112091518.7846-1-linux@fw-web.de> <20221112091518.7846-11-linux@fw-web.de> <ee410f80-1697-6146-9755-981f2d45e88f@collabora.com>
Message-ID: <A22EB676-EBD4-4E07-8E8F-BC200EDBCE1A@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: e2c3e121-26ca-46ae-84d2-91c323c378b0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 14=2E November 2022 12:50:40 MEZ schrieb AngeloGioacchino Del Regno <ang=
elogioacchino=2Edelregno@collabora=2Ecom>:
>Il 12/11/22 10:15, Frank Wunderlich ha scritto:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> +/ {
>> +	model =3D "Bananapi BPI-R3";
>> +	compatible =3D "bananapi,bpi-r3", "mediatek,mt7986a";
>
>You have to add the machine compatible to devicetree/bindings/arm/mediate=
k=2Eyaml
>or you get dtb check issues=2E

Have already:

https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/matthias=2Ebgg/linux=
=2Egit/commit/?h=3Dv6=2E1-next/dts64&id=3D8c80453864efea0a0ed5ca2b399fd97f2=
f55a5ae

>Regards,
>Angelo


regards Frank
