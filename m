Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F48647578
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 19:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLHSWs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 13:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiLHSWa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 13:22:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187B182FAB
        for <linux-pci@vger.kernel.org>; Thu,  8 Dec 2022 10:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670523698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ychQHUwEwsEArxEp4qxZeFUVJ+hihdcX72oLlNVwYdg=;
        b=bAbHq2kSeT5NJE7qtio2s106J2JR+p890txDHCLC3dMvrYZkN86yQnVPrOEVaJWcq9muA0
        Ari3pyJr7frAw1jNS0pLLoG9yVewUqsepZ+MSevj4pNKnjUtM/7EKmpxdjp94Xz11rwWvW
        iW737icQshA1rGgQiHwTGFyuHXSCT4w=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-pwgHsCHVOnuArmPtPtEHSQ-1; Thu, 08 Dec 2022 13:21:36 -0500
X-MC-Unique: pwgHsCHVOnuArmPtPtEHSQ-1
Received: by mail-io1-f69.google.com with SMTP id z9-20020a6be009000000b006e0577c3686so730038iog.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Dec 2022 10:21:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ychQHUwEwsEArxEp4qxZeFUVJ+hihdcX72oLlNVwYdg=;
        b=k95vjQ7+Vt1O9zqHgc1fAxGXlHoZy8rbj2HG9Qm+crdli/+zs94boi/wQI45vS1zk4
         nClo1fFUFd0xHuYORqAivul3ltwmypPUVt/a+1dCkLX4ZJdpO7o3ZiusrE+6jBvKeZEO
         p7NSNMk0mjfwDfbOVVm6jdurramZSHm9JDx+CW8zYIRDcAx+VO2SXfuPz1QKwNZV6rkJ
         KA05/DQvCrjgtZqhizeOn0NRPcH9P6UJxH6pnHsL/1dzyY20Yxk++FxIPWPRwdY0LXnb
         24CFFcKFBfwMOE0SOBwk1DDO3B6itZeIzF458qIGJKMPrPVGejYQEHv5eozMCx5d73/F
         fhEg==
X-Gm-Message-State: ANoB5pkIN0RRc2dVmutjuD/7wEsnEd6tIHK1HBNA6UPDrUu65/1j0TsZ
        jedNoDSL7sislrx4foUfF2/aVJI1aIOMzvWpZKB91oyI6f1ToxPq7Al9Os0LyRcdMLaGkOlmQ9t
        puTfM2jxdI5ivL+/EP+sR
X-Received: by 2002:a05:6638:3a0e:b0:375:5a81:aaef with SMTP id cn14-20020a0566383a0e00b003755a81aaefmr37668272jab.115.1670523696179;
        Thu, 08 Dec 2022 10:21:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf41wQHgLQ8pcnwGPZufFGrpcYUTndCIpbE6EWCQffj06k94Asww9fcCHha2PMb29U7gvcL0zQ==
X-Received: by 2002:a05:6638:3a0e:b0:375:5a81:aaef with SMTP id cn14-20020a0566383a0e00b003755a81aaefmr37668268jab.115.1670523695974;
        Thu, 08 Dec 2022 10:21:35 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m16-20020a0566022e9000b006dfbfec899esm9268870iow.28.2022.12.08.10.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 10:21:35 -0800 (PST)
Date:   Thu, 8 Dec 2022 11:21:33 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Major Saheb <majosaheb@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: vfio-pci rejects binding to devices having same pcie vendor id
 and device id
Message-ID: <20221208112133.36efe5ff.alex.williamson@redhat.com>
In-Reply-To: <CANBBZXPBRr6On_3q0Ac0iQtrV5Bs84=GuHNvLz527T3ohHSuCw@mail.gmail.com>
References: <CANBBZXPWe56VYJtzXdimEnkFgF+A=G15TXrd8Z5kBcUOGgHeRw@mail.gmail.com>
        <20221208165008.GA1547952@bhelgaas>
        <20221208102527.33917ff9.alex.williamson@redhat.com>
        <CANBBZXPBRr6On_3q0Ac0iQtrV5Bs84=GuHNvLz527T3ohHSuCw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 8 Dec 2022 23:25:07 +0530
Major Saheb <majosaheb@gmail.com> wrote:

> Thanks Alex ,
> That works for me
> 
> ~$ sudo driverctl --nosave set-override 0000:00:05.0 vfio-pci
> ~$ sudo driverctl --nosave set-override 0000:00:06.0 vfio-pci
> ~$ sudo driverctl --nosave set-override 0000:00:07.0 vfio-pci
> admin@node-1:~$ sudo nvme list
> Node                  SN                   Model
>              Namespace Usage                      Format           FW
> Rev
> --------------------- --------------------
> ---------------------------------------- ---------
> -------------------------- ---------------- --------
> /dev/nvme10n1         akqvf2-0_10          QEMU NVMe Ctrl
>              1         274.88  GB / 274.88  GB    512   B +  0 B   1.0
> /dev/nvme11n1         akqvf2-0_11          QEMU NVMe Ctrl
>              1         274.88  GB / 274.88  GB    512   B +  0 B   1.0
> /dev/nvme5n1          akqvf2-0_5           QEMU NVMe Ctrl
>              1         274.88  GB / 274.88  GB    512   B +  0 B   1.0
> /dev/nvme6n1          akqvf2-0_6           QEMU NVMe Ctrl
>              1         274.88  GB / 274.88  GB    512   B +  0 B   1.0
> /dev/nvme7n1          akqvf2-0_7           QEMU NVMe Ctrl
>              1         274.88  GB / 274.88  GB    512   B +  0 B   1.0
> /dev/nvme8n1          akqvf2-0_8           QEMU NVMe Ctrl
>              1         274.88  GB / 274.88  GB    512   B +  0 B   1.0
> /dev/nvme9n1          akqvf2-0_9           QEMU NVMe Ctrl
>              1         274.88  GB / 274.88  GB    512   B +  0 B   1.0
> 
> I came across you blogspot after I fired the mail
> http://vfio.blogspot.com/2015/05/vfio-gpu-how-to-series-part-3-host.html
> Some should update https://docs.kernel.org/driver-api/vfio.html in
> public interest , If I knew how to do that I would do it,

Yes, that documentation is from before the driver_override method was
introduced.  There's some non vfio specific documentation of
driver_override here:

https://docs.kernel.org/admin-guide/abi-testing.html?highlight=driver_override#abi-sys-bus-pci-devices-driver-override

Otherwise, documentation updates gladly accepted.  This documentation
is part of the kernel source tree and follows the same process as
submitting code changes, outlined here:

https://docs.kernel.org/process/submitting-patches.html

The kvm@vger.kernel.org mailing list handles patches for vfio, but
please keep me in Cc if you submit something.  Thanks,

Alex

