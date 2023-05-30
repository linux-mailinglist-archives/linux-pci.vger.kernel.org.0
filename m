Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE4E716F48
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 22:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjE3U65 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 16:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjE3U6d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 16:58:33 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BB4137
        for <linux-pci@vger.kernel.org>; Tue, 30 May 2023 13:58:12 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-33baee0235cso14695ab.1
        for <linux-pci@vger.kernel.org>; Tue, 30 May 2023 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685480291; x=1688072291;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J32hpLDxxykdWTnyDzi8v/NVcoYynKojgQNgYOvsxfE=;
        b=UfeHWhIX70pyFHTviwn/Wcv1HBSuMPFzd6KK1cwQ7VEFi2PyOiqcvaEEew8MFVls0F
         jsjgoEC3lmEYNNZZABMBnTW6Yxn8iQbAOTB92mBS6qJ1ShIeCJ7vkJanTvyEtRXNBUhk
         LKL04yKceZm8ZFkxnZu/DBm91nG/vj10uz2IWNZCnSaC4n3zBZUInlndH1xdBxyznjEX
         S5NrfdV9jVrDSw7HD3g/i3CPvWHPwgdTqi/GCpOhQuDbLJGMiBCqGjvt8dhfOBbDGMN1
         8E0HdGqE6SE+ixzQu1Qa/0GYzb3rsl8UeZ/k9FFjVUXrua9qGL5D/2sU6CaRateMkQtQ
         zsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685480291; x=1688072291;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J32hpLDxxykdWTnyDzi8v/NVcoYynKojgQNgYOvsxfE=;
        b=ghq0APYRD01IhL5Ei/BGa6YHSy65C+Zq4EUh/OoA6aYw4X2bAU/fST3gw6AxA57JwO
         vSUW7Uojmj56CJpJspTcXwUZiSkZXcSeB1FUqeYbIby3AOI+I0Y8AtCu8Zj0Ko3e7H5e
         B1vNqui0e3K9iTMQvcCLzSUy4S1XwPRR4Ezjta3LqdjiwxCwS72MOZazFXj1pjboKRYZ
         S2BEW9aLXQAJBwyFERt0G+tAXJsvMheIR4PMKlOZNhQbaAlOz9gGEgivgzI2IvYU1DCn
         yOi3rRaOLFjstNGYGaT7AD6BjwrvtD0QO2lbca56TZqMW95GJc6sC2ZulJcw45XltWTv
         bR5Q==
X-Gm-Message-State: AC+VfDxVCm5OvOc6DwYD0e6lRVdcoC+oLJbYTUJyUf0GwQpdPxpyYoRG
        EptCNxd/GsSfyobIrQ5lL7qsqPO7vZCEssntDElgr4FyG/WsNMlEinmqCp0x
X-Google-Smtp-Source: ACHHUZ4IfodxpiYUdAGI9SyGESl15GNcgjSRs985JrSuWmG7p+tG+NqXepICP9yo0xnZbopfFrOXG5QItrchgq2JAcc=
X-Received: by 2002:a92:c545:0:b0:338:9f6a:d54d with SMTP id
 a5-20020a92c545000000b003389f6ad54dmr14089ilj.27.1685480291256; Tue, 30 May
 2023 13:58:11 -0700 (PDT)
MIME-Version: 1.0
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 30 May 2023 13:58:00 -0700
Message-ID: <CANgfPd9vsNnX-Pvqu2-1CUiwGSoqsWLbJKJny16smue0s_eAVA@mail.gmail.com>
Subject: Usage of sriov_drivers_autoprobe
To:     linux-pci@vger.kernel.org, Bodong Wang <bodong@mellanox.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Eli Cohen <eli@mellanox.com>,
        Gavin Shan <gwshan@linux.vnet.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bodong, PCI folk generally,

I've found an issue with sriov_drivers_autoprobe not working as I
would expect it to and I'd like to check if my expectations are
incorrect or if it's not working as intended.

Please consider the sequence below

/sys/bus/pci/devices/0000:12:34.1# echo 0 > sriov_numvfs
/sys/bus/pci/devices/0000:12:34.1# echo 0 > sriov_drivers_autoprobe
/sys/bus/pci/devices/0000:12:34.1# echo 1 > sriov_numvfs
(Let's say 0000:13:ab.0 is a VF of 0000:12:34.1)
/sys/bus/pci/devices/0000:12:34.1# echo 0000:13:ab.0 >
/sys/bus/pci/drivers/vfio-pci/bind
-bash: echo: write error: No such device
/sys/bus/pci/devices/0000:12:34.1# echo 1 > sriov_drivers_autoprobe
/sys/bus/pci/devices/0000:12:34.1# echo 0000:13:ab.0 >
/sys/bus/pci/drivers/vfio-pci/bind
/sys/bus/pci/devices/0000:12:34.1# echo 0000:13:ab.0 >
/sys/bus/pci/drivers/vfio-pci/unbind
/sys/bus/pci/devices/0000:12:34.1#

From the above, we can see that having sriov_drivers_autoprobe unset
prevents even manually binding a driver, after VF initialization. This
seems unintentional, but it can be worked around by unsetting
sriov_drivers_autoprobe.

If this is how it was intended to work please let me know. If it is,
then the documentation should be updated. It says: "Note that changing
this file does not affect already-enabled VFs." But that does not
appear to be true.

Thanks for your help, and I'm sorry I'm not offering a fix, but I'm
mostly a KVM engineer and don't know the PCI subsystem well, so I
don't know how best to fix the check on sriov.drivers_autoload.
Ben
