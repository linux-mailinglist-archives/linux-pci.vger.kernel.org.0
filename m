Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5C1596707
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 03:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbiHQBvx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 21:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238321AbiHQBvw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 21:51:52 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C414985B1
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 18:51:51 -0700 (PDT)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 85E7B3F48A
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 01:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660701109;
        bh=ZShwu2OfZ7vLq31qVP5G8lVwUmcKsX3GNd6y6wO1Ssc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=LXKMbs7upu4EAQHoLpkWVoxtlBNz6nbQ9sHtYiQCRRE1DeeE0OQSHfgzabbS3wmGV
         iXomWItHqr/iMfU0vLsh2t42YhesFvvCrj68morupyzoLUyXlFSMDNRH1pSyZvoTBn
         T+DkN1uMEnV5IJOXo+zCk4iUpjNBVXI3idzZcaapBFkW10qfh8Lob4+vimY2sMIRZ8
         FQZ+wSC9z61OYYEDF7DDsmVyUwUj3of1c3iI3lipEptyIMyay/2C6N/BboGkwoVFnW
         YoAdxUun/93I6Hd4vAwM8oq5ohAsUUj9kubI72Dsb633lNt1VzdrHdDQZnCUi+mjan
         lJzpLQfWkbrcA==
Received: by mail-oi1-f200.google.com with SMTP id y126-20020acae184000000b00343644f7ddeso3220265oig.2
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 18:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZShwu2OfZ7vLq31qVP5G8lVwUmcKsX3GNd6y6wO1Ssc=;
        b=VaeDYOtlcabOilGFfOhRMhQN7UlFLqQQ8ettNex3g2IR11hxtTG70gtgMzxXyzF4jj
         eoD7FO1/4ZZRspDtGT1IKSOLsVDpOkhuIOggNDz3l+0s/DPEq7f8TLsZa26hNIsDfTGC
         JTi/4O8drpppi8edzy1nFgMYIuC0a7A0bc1BbBpFn9Z3sJO1V4Xxs23hgZjoPq17Xv2M
         ukp7e0N9nN/zB9HVqQNGNjTh/gQNI040JZUle5opRPmSSFRzVoqpWyUbmTQLchmXaMDI
         OOV7cS+u7aH2SFQaHwZG9hFqOHa2VRH+ow3rGKBqxyMZn8xUrBCa7JDfYiS9y4uOY+Vb
         cgWQ==
X-Gm-Message-State: ACgBeo0iLgQY7CzYAqKDyxOhpj79IqMJYmlRiuvrwP1d2kBQTwRF/5KY
        B9GiRB8htNYAXE/+jIyb9BHdDP0ZcLNQMLrcBgOe8N/zrQsootS0gxLE+yres7rvIMgjU7w9Qoq
        4JUWZWM55lK5iPSSywikkowffHPs75cKNWfq7Zh6iYAVXQuFeTq3Ivg==
X-Received: by 2002:a05:6808:130a:b0:344:e23f:811b with SMTP id y10-20020a056808130a00b00344e23f811bmr567137oiv.82.1660701107560;
        Tue, 16 Aug 2022 18:51:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR46D1cARS22B1E1k1etHQ3qfLnKNZWTA2TC7Vaa318gbJ+gT2mybCEEzcl7sE+mnyfA47Nfr6LKoHFrNhyEtQU=
X-Received: by 2002:a05:6808:130a:b0:344:e23f:811b with SMTP id
 y10-20020a056808130a00b00344e23f811bmr567130oiv.82.1660701107239; Tue, 16 Aug
 2022 18:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Wed, 17 Aug 2022 09:51:36 +0800
Message-ID: <CABTNMG0mFxqGMBmF+2L1etNzrX4G5UkBYu1A7gL3Lx3YfyRwnQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] PCI: Allow for future resource expansion on initial
 root bus scan
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 16, 2022 at 6:07 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> The series works around an issue found on some Dell systems where
> booting with Thunderbolt/USB4 devices connected the BIOS leaves some of
> the PCIe devices unconfigured. If the connected devices that are not
> configured have PCIe hotplug ports as well the initial root bus scan
> only reserves the minimum amount of resources to them making any
> expansion happening later impossible.
>
> We do already distribute the "spare" resources between hotplug ports on
> hot-add but we have not done that upon the initial scan. The first three
> patches make the initial root bus scan path to do the same.
>
> The additional three patches are just a small cleanups that can be
> applied separately too.
>
> The related bug: https://bugzilla.kernel.org/show_bug.cgi?id=216000.
>
> Mika Westerberg (6):
>   PCI: Fix used_buses calculation in pci_scan_child_bus_extend()
>   PCI: Pass available buses also when the bridge is already configured
>   PCI: Distribute available resources for root buses too
>   PCI: Remove two unnecessary empty lines in pci_scan_child_bus_extend()
>   PCI: Fix typo in pci_scan_child_bus_extend()
>   PCI: Fix indentation in pci_bridge_distribute_available_resources()
>
>  drivers/pci/probe.c     |  13 +-
>  drivers/pci/setup-bus.c | 290 ++++++++++++++++++++++++----------------
>  2 files changed, 181 insertions(+), 122 deletions(-)
>
> --
> 2.35.1
>

Tested-by: Chris Chiu <chris.chiu@canonical.com>
