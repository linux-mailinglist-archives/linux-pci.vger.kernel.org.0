Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4AE50FB63
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 12:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349361AbiDZKvG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Apr 2022 06:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349474AbiDZKud (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2022 06:50:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E105676D;
        Tue, 26 Apr 2022 03:46:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dk23so11885930ejb.8;
        Tue, 26 Apr 2022 03:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LQ+dR0UOrMeVo1DrEEM2SpNUL4OliZmqjspXFMm8eVs=;
        b=Xwki4XJKl1bvhU2BAHy1VLInwFSPTDMezYEKLCJfgPuozbREABcQvWUPNqN1ECccUp
         eIcXgH5K/Rzr2OufjrthDHvzz35YGOLCdrPUB2FDgW5Y2ds4iOuYDHUqRp0H/7s1LobK
         Y2BjmHgFRaOk8/Y5nkCQLIJ8+flVdFRTEKiGWq8zq5F+1uf5GWotf2lblzhms7FTkQ84
         PNgiToN0K3ihafgU6clSyjgKbPeBaqtc7rnLDajN0edrBaj5rJ4p5j/VNy9GDTuXMwWI
         5bZcbmeBGYxOkTTvstU8FZeTQTwh5c9SeH86QTXFP5I7Nm+fr8gflhwXJStRsDpUPj62
         WtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LQ+dR0UOrMeVo1DrEEM2SpNUL4OliZmqjspXFMm8eVs=;
        b=0rMcPyyfWVyB6z5GqDipSzOvOtBgPT/ryyhJNjMd+dm92oWm1ZKPmjzVSB2TBf4Zl5
         naEA4erFIONvp1IoKl7YSkNLC1IABUmgNcUZEmQ0joJ4L4g1s9y97RH/0jEZv2V1Dbec
         49G/pZxG/1mLgy7poy3RCN4l/eY88bWwCU7i6Yc4A/6o1J/YVtchPhI4RTVYLB563zzU
         jQj8+CKZzNreRxHNG+QCRrnHirx0CfXeo/hgjDVrP1/wr4BOdQW1UycVpkRFRCqCWHah
         9dWT6FRvBpDT1c6h2/kQDgZArcrUf1G544a5dyT7AoQCFgfIFpA/oypr+BNOP7Lw6XP4
         GVhA==
X-Gm-Message-State: AOAM532evFLTwGYqxPcv5gpBChvQHoiGagCO7KQ2C178FZloARRbVPB8
        7h2jc4vwB0+NRxVliwIiShk=
X-Google-Smtp-Source: ABdhPJxdSqpjegF02exvsa0Whpl3LQ6ep+nqUMpsWopd9mkam8c4SiNfv8wV44oDB1ez54DB2XYB7Q==
X-Received: by 2002:a17:907:72d0:b0:6db:4788:66a9 with SMTP id du16-20020a17090772d000b006db478866a9mr21551609ejc.516.1650970018176;
        Tue, 26 Apr 2022 03:46:58 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709060f4700b006e8d0746969sm4635074ejj.222.2022.04.26.03.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 03:46:57 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        Peter Geis <pgwipeout@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v8 0/5] Enable rk356x PCIe controller
Date:   Tue, 26 Apr 2022 12:46:56 +0200
Message-ID: <2599368.pI0oiQkSSZ@archbook>
In-Reply-To: <20220423152403.1681222-1-pgwipeout@gmail.com>
References: <20220423152403.1681222-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Samstag, 23. April 2022 17:23:58 CEST Peter Geis wrote:
> This series enables the DesignWare based PCIe controller on the rk356x
> series of chips.
> We drop the fallback to the core driver due to compatibility issues.
> We reset the PCIe controller at driver probe to prevent issues in the
> future when firmware / kexec leaves the controller in an unknown state.
> We add support for legacy interrupts for cards that lack MSI support
> (which is partially broken currently).
> We then add the device tree nodes to enable PCIe on the Quartz64 Model
> A.

Tested-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

Tested on a PINE64 Quartz64 Model A. The series was applied to 5.18-rc4,
and two devices were tested:

Device #1: ASMedia Technology Inc. ASM1142 USB 3.1 Host Controller

A USB 3.1 flash drive was plugged into the PCIe USB controller card.
Then, the block device was read. Performance was nominal, no errors
showed up in dmesg.

Device #2: NEC Corporation uPD720200 USB 3.0 Host Controller (rev 03)
behind a PLX Technology, Inc. PEX 8608 8-lane, 8-Port PCI Express Gen 2
(5.0 GT/s) Switch (rev ba) PCIe switch.

(it's a weird card I grabbed off an auction site with both USB and SATA
behind a PCIe switch, it's best not to worry about the twisted mind
that came up with it.)

A USB 3.1 flash drive was plugged into the PCIe controller card's
USB 3.0 port. Then, the block device was read. Performance was nominal,
no errors appeared in dmesg.

512 megabytes of /dev/urandom were redirected into a file. The file was
SHA1 checksummed. The file was then copied onto the mounted USB 3.1 drive
which was connected to the PCIe card. The drive was unmounted, then
re-mounted, and then a sha1sum of the file on the drive was calculated.
The checksums matched.

Based on these tests it is my understanding that this patch series is
functional for the use cases I have covered.

Regards,
Nicolas Frattaroli


