Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70143572F1F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 09:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiGMHXZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 03:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiGMHXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 03:23:20 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2FDC04F6
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 00:23:19 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10bec750eedso13086732fac.8
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 00:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=nbDKe22HV+1/ThNKgjzz32+kRAfqCuW0p3UtEu4kFQo=;
        b=iICGvb/z6q0nqZbkCrDzOpxP6ze2kL/QNvP0sy5OoTxHvsBZyjjDLRTnkuLVm8cybo
         hWjliacqZAu6i8JlnF3yiC3q9s/w3hI4Z8EacjMR9AfQsc4nuhOULvBxbXu0YtLDZ9Mk
         YlRmXtZglIsI2DDNJ5GlBqllaviUv/a0ntGpJI3Co1SDssSPKoK38ulWypIYNOqa9Mwo
         NfOf5FJZt2mEoMRD03/zTckFm/R6PANTQZADboRYlTnuocW5sKzpkpNo6/mkjhnNs3pC
         qv7R+NwklWfjqnNfsjnx0A/AHrmrmPTcx4HY76QB0WRRVxqtgDfuO/3DmB0tV90rjT49
         edrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nbDKe22HV+1/ThNKgjzz32+kRAfqCuW0p3UtEu4kFQo=;
        b=emWsmt/2PI696A3nFHUcQZHig6jhLaowUF953M9DyPIrlDEN9j1f5wCoKucuZruZHK
         JE4+iF7SH7lav7vC1YoY+1dDRxe7pqMVT5muky5UtAbd62UGxTIVeKfFu3tYkdVtKRzQ
         QmosbyRiO9SPVg5TjzMnGi2xGOLJ90M2CxCJ+IVx0hpfUFTPIO3g/NGt2hinmtHEr+wS
         JmVD21yWO7RO08Z6rhUPcTfz9AiOl6/ugEaQL8FShFLxm9cqC/4JF7tvVFnUBEgnibbu
         rGAeKTprDFbOgpKTC6yl+i16D9H77juAkASDjar7YrP1XS1n5CmyQrRk9WoTtA+JydeV
         t9Uw==
X-Gm-Message-State: AJIora+iVJcDxwsUw5OY4Y4/TbTfwNgliDYWajokwmjBsunRLl0u6Fz/
        s7s+OwPIAilE+VWrHMA/I9AJkTyAZma7gmBCYx/l6Y+1tgFhdQ==
X-Google-Smtp-Source: AGRyM1vJj5kPbtXzuoS7SzXhu6gOObMFQCDHSmmpmGCAzjLC651c7rm0L1yZ/52jGzz3rc0RxDA9qUQ3BDYviLycqFA=
X-Received: by 2002:a05:6870:8186:b0:10c:2ed:44f9 with SMTP id
 k6-20020a056870818600b0010c02ed44f9mr3809442oae.35.1657696998296; Wed, 13 Jul
 2022 00:23:18 -0700 (PDT)
MIME-Version: 1.0
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Wed, 13 Jul 2022 12:53:06 +0530
Message-ID: <CAHP4M8VuX6NrqyKQU1KS3DdTzZRQTdPK+nF0-eXXeQqhHyOypw@mail.gmail.com>
Subject: No controller seen in /sys/kernel/config/pci_ep/controllers
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello everyone.

The kernel has been built with :

###################################
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
CONFIG_PCI_EPF_TEST=y
CONFIG_PCI_ENDPOINT_TEST=y
###################################


Thereafter, following are seen :

###################################
$ sudo mount none /sys/kernel/config/ -t configfs
mount: /sys/kernel/config: none already mounted or mount point busy.

$ ls -lrth /sys/class/pci_epc/
total 0

$ ls -lrth /sys/kernel/config
total 0
drwxr-xr-x 4 root root 0 Jul 13 10:58 pci_ep
drwxr-xr-x 2 root root 0 Jul 13 10:58 usb_gadget

$ ls -lrth /sys/kernel/config/pci_ep/functions
total 0
drwxr-xr-x 2 root root 0 Jul 13 10:58 pci_epf_test

$ ls -lrth /sys/kernel/config/pci_ep/controllers
total 0

$
###################################

What is being missed?

Side Queries : Is the controller that is expected to be listed, a
virtual-controller (like the one provided by CONFIG_USB_DUMMY_HCD in
case of USB)?

Or there must be a real additional controller for pci-endpoint purpose?
If yes, then :

              * I guess no listing is expected currently, as my machine has just
                one controller (as pci-host).

              * Is there a way to have an additional virtual pci-controller?


Thanks and Regards,
Ajay
