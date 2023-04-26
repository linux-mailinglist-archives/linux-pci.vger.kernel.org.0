Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0F56EFBD4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Apr 2023 22:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbjDZUom (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Apr 2023 16:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjDZUol (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Apr 2023 16:44:41 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503B410FC
        for <linux-pci@vger.kernel.org>; Wed, 26 Apr 2023 13:44:40 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b8f5276baa3so6153451276.3
        for <linux-pci@vger.kernel.org>; Wed, 26 Apr 2023 13:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682541879; x=1685133879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxo+GagR2E5RsONBsNVbiP1yowr7LdpGNwMG4261j9A=;
        b=faYBWlmYPyVvv7dCSVdlURDjZBV+jp5BEAL4MPplDhYFuE+X+/yt2ANHT/yKYSmHyY
         1bI3KzdDYZ/S+tlVPGuDbzvjDeHxPl8NmJmeGk5oBqZB5OpAU7FxnWmSFvy/24BS/pxF
         kzev6AMTpWTf/VpiABPkTvJxutYbuCVtPi7xZ+uZkPYRAe7vw3+UxDePsFNdlFm2Hg/3
         d4iRmoquc+59g7WqDlvtM8BNVIE7PWw5SBSz4QTorNiTx9ane0rsAi9nN20cJArQRlKh
         TyqOsCt2/dKAOSK2EPxJlCwA5xZQMIBeIbxyZJ7FjTdPAXmVkFb/fq2On3WYVKPY1qzf
         zlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682541879; x=1685133879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxo+GagR2E5RsONBsNVbiP1yowr7LdpGNwMG4261j9A=;
        b=T7Xm4av2GCGhlPiYtx6GjYbz+7MEezhWpyyy1BZJgim0f5YZjiCslCFlz6ZHobHhG2
         ZYZjOGayCqvLZqAZRrtxuWRJ2PlGyh36PdFd1JZnu3oA2QqopexdLgK8MzBPjytfQ+NE
         Vij9C2zvwKbS6Rge283Dv3ukvPeVAaglT7B5nD8FrY6tH56qhO+eLMiYk9e5vRyaIpSA
         f0tEkEsRofVtPaE4h6Kjegb46tW8WdoBV0zsc6sx8g+PAYNS4wI9FghopMbhDvmwfdxf
         FzuJnTYW3WaDE2KkfdrWB7odm6XLoOfmZd4rtC3OZ2+y2FWTcqPVRwPi7rsgcpPOvSUN
         Wgpw==
X-Gm-Message-State: AAQBX9cOnka0zpMRour90ZcutI3wwv3vjbpfP52M8qtxQbFmCFpvhDT9
        nJTLYg+X/RrYrzDIPXxJuubwhIOSLbiCzObRK5zEJA==
X-Google-Smtp-Source: AKy350a58TxEbfHOXh1V7tj6baxt2SbIMUuXCOzsDYOPHS6Ge8eiFsTVjov8kJk3UtA7diGdnLbhxtreSLxqSwB+Keg=
X-Received: by 2002:a0d:d908:0:b0:54e:dcf2:705b with SMTP id
 b8-20020a0dd908000000b0054edcf2705bmr13240850ywe.47.1682541879483; Wed, 26
 Apr 2023 13:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230423053208.2348-1-yejunyan@hust.edu.cn>
In-Reply-To: <20230423053208.2348-1-yejunyan@hust.edu.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Apr 2023 22:44:28 +0200
Message-ID: <CACRpkdbDfAJOWzkvEgOdoOCMQAQ24mauWAeWXWgvBmyU3mi0FQ@mail.gmail.com>
Subject: Re: [PATCH v2] pci: controller: pci-ftpci100: Release the clock resources
To:     Junyan Ye <yejunyan@hust.edu.cn>
Cc:     christophe.jaillet@wanadoo.fr,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 23, 2023 at 7:34=E2=80=AFAM Junyan Ye <yejunyan@hust.edu.cn> wr=
ote:

> Smatch reported:
> 1. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe()
> warn: 'clk' from clk_prepare_enable() not released on lines:
> 442,451,462,478,512,517.
> 2. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe()
> warn: 'p->bus_clk' from clk_prepare_enable() not released on lines:
> 451,462,478,512,517.
>
> The clock resource is obtained by the devm_clk_get function. The
> clk_prepare_enable function then makes the clock resource ready for use,
> notifying the system that the clock resource should be run. After that,
> the clock resource should be released when it is no longer needed. The
> corresponding function is clk_disable_unprepare. However, while doing
> some error handling in the faraday_pci_probe function, the
> clk_disable_unprepare function is not called to release the clk and
> p->bus_clk resources.
>
> Fix this warning by changing the devm_clk_get function to
> devm_clk_get_enabled, which is equivalent to
> devm_clk_get() + clk_prepare_enable(). And with the
> devm_clk_get_enabled function, the clock will automatically be
> disabled, unprepared and freed when the device is unbound from the bus.
>
> Fixes: b3c433efb8a3 ("PCI: faraday: Fix wrong pointer passed to PTR_ERR()=
")
> Fixes: 2eeb02b28579 ("PCI: faraday: Add clock handling")
> Fixes: 783a862563f7 ("PCI: faraday: Use pci_parse_request_of_pci_ranges()=
")
> Fixes: d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI H=
ost Bridge driver")
> Fixes: f1e8bd21e39e ("PCI: faraday: Convert IRQ masking to raw PCI config=
 accessors")
> Signed-off-by: Junyan Ye <yejunyan@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v1 -> v2: Switch from clk_disable_unprepare() to devm_clk_get_enabled() t=
o release the clock.
> This issue is found by static analyzer.

Neat fix, saves codelines!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
