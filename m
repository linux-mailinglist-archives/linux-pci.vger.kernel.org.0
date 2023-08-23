Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B12A78505F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 08:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjHWGJo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 02:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjHWGJo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 02:09:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBD8E5D
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 23:09:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a3f0a7092so2814774b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 23:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692770972; x=1693375772;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ATCAJFKLfXtFZZdNcoAUWUHorxMWbDxPKwz1+kw/lXs=;
        b=MkLvLUTXO6ji+Qy81/ecWrUNnY1eSV1MmWmdRR/VOmrpaaX5ZVB00vssu2ioH0B27u
         xDKW3lj4TVgqxS511cYVxqqFL4JcOn8WoCO86wtjzl6pqddMh9S7n6kzADk9aONZc7h8
         gSCQU3CgPDaktkuM4S8vwPXehbQ0OMnU/g3uwYceIl8osAghgVlT5tKJQ42CBQr2rr0R
         VNdAtwDjriYLSjN69wUYxw9k/RzDcQPrPY9U8yWJhwHr5HM87gpreiXzs8Afp42vpTPQ
         WL0q4qv6T0kvW5kcXffVbPfonD72MNg9IVyUb616azDK8k3mr1c9N5RU1TC73AURVwb3
         TbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692770972; x=1693375772;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATCAJFKLfXtFZZdNcoAUWUHorxMWbDxPKwz1+kw/lXs=;
        b=NwB1vJOC+GM8nd2iqpOQNLEn+NUUDpVJheJiVHCuY+/rWucVieBX83X2OQ2HGmvWkC
         rkmtDpnfIp/8aJIyUxHlmO9aX+Lp7GnjA6XpSCztghOC+hLP14Q+8FDPIC7Hrzdb0w3p
         11vbTTRyLUv9gVEcaRhePaptn2Lfp1EvZc072xkwZVfnmtsRwnPCVvcugFz1rRO6/Idp
         +3SJhKjmYJ6WyMJj46jIXzqYl6QStAwV0FFj9i4TswmLSVRTAQn5jaFJ2C8aCO2cW2lN
         ZiQioD+UQEpeEkNbvSiy4dV+X1Y+k/753ciRk5EecuDpBYjvR3G3p5yX5c/wtXNBCPb3
         Tuaw==
X-Gm-Message-State: AOJu0Yw9AjNHGj66k+senj2I/7Ilz09CTWHmRzAUjyMujCfyaHznl8cu
        3SlUr/PljRCz/KtV9QZMJmCI
X-Google-Smtp-Source: AGHT+IG5ljrBsC2BjV14MxK8/e1gQvN4DhIyk6RWM1LXLp9afKRPfKEpYyhvKdWXhWmi9bbecOklIA==
X-Received: by 2002:a05:6a00:15d4:b0:68b:e29c:b62 with SMTP id o20-20020a056a0015d400b0068be29c0b62mr73350pfu.28.1692770972051;
        Tue, 22 Aug 2023 23:09:32 -0700 (PDT)
Received: from thinkpad ([117.206.119.53])
        by smtp.gmail.com with ESMTPSA id v24-20020a62a518000000b0064d47cd116esm2785771pfm.161.2023.08.22.23.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 23:09:31 -0700 (PDT)
Date:   Wed, 23 Aug 2023 11:39:23 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        qemu-devel@nongnu.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
Message-ID: <20230823060923.GA3737@thinkpad>
References: <CANXvt5oKt=AKdqv24LT079e+6URnfqJcfTJh0ajGA17paJUEKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXvt5oKt=AKdqv24LT079e+6URnfqJcfTJh0ajGA17paJUEKw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 10:46:02PM +0900, Shunsuke Mie wrote:
> Hi all,
> 
> We are proposing to add a new test syste to Linux for PCIe Endpoint. That
> can be run on QEMU without real hardware. At present, partially we have
> confirmed that pci-epf-test is working, but it is not yet complete.
> However, we would appreciate your comments on the architecture design.
> 
> # Background
> The background is as follows.
> 
> PCI Endpoint function driver is implemented using the PCIe Endpoint
> framework, but it requires physical boards for testing, and it is difficult
> to test sufficiently. In order to find bugs and hardware-dependent
> implementations early, continuous testing is required. Since it is
> difficult to automate tests that require hardware, this RFC proposes a
> virtual environment for testing PCI endpoint function drivers.
> 

This sounds exciting to me and yes, it is going to be really helpful for
validating EP framework as a whole.

> # Architecture
> The overview of the architecture is as follows.
> 
>   Guest 1                        Guest 2
> +-------------------------+    +----------------------------+
> | Linux kernel            |    | Linux kernel               |
> |                         |    |                            |
> | PCI EP function driver  |    |                            |
> | (e.g. pci-epf-test)     |    |                            |
> |-------------------------|    | PCI Device Driver          |
> | (2) QEMU EPC Driver     |    | (e.g. pci_endpoint_test)   |
> +-------------------------+    +----------------------------+
> +-------------------------+    +----------------------------+
> | QEMU                    |    | QEMU                       |
> |-------------------------|    |----------------------------|
> | (1) QEMU PCI EPC Device *----* (3) QEMU EPF Bridge Device |
> +-------------------------+    +----------------------------+
> 
> At present, it is designed to work guests only on the same host, and
> communication is done through Unix domain sockets.
> 
> The three parts shown in the figure were introduced this time.
> 
> (1) QEMU PCI Endpoint Controller(EPC) Device
> PCI Endpoint Controller implemented as QEMU PCI device.
> (2) QEMU PCI Endpoint Controller(EPC) Driver
> Linux kernel driver that drives the device (1). It registers a epc device
> to linux kernel and handling each operations for the epc device.
> (3) QEMU PCI Endpoint function(EPF) Bridge Device
> QEMU PCI device that cooperates with (1) and performs accesses to pci
> configuration space, BAR and memory space to communicate each guests, and
> generates interruptions to the guest 1.
> 

I'm not very familiar with Qemu, but why can't the existing Qemu PCIe host
controller devices used for EP communication? I mean, what is the need for a
dedicated EPF bridge device (3) in host? (Guest 2 as per your diagram).

Is that because you use socket communication between EP and host?

- Mani

> Each projects are:
> (1), (3) https://github.com/ShunsukeMie/qemu/tree/epf-bridge/v1
> files: hw/misc/{qemu-epc.{c,h}, epf-bridge.c}
> (2) https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc
> files: drivers/pci/controller/pcie-qemu-ep.c
> 
> # Protocol
> 
> PCI, PCIe has a layer structure that includes Physical, Data Lane and
> Transaction. The communicates between the bridge(3) and controller (1)
> mimic the Transaction. Specifically, a protocol is implemented for
> exchanging fd for communication protocol version check and communication,
> in addition to the interaction equivalent to PCIe Transaction Layer Packet
> (Read and Write of I/O, Memory, Configuration space and Message). In my
> mind, we need to discuss the communication mor.
> 
> We also are planning to post the patch set after the code is organized and
> the protocol discussion is matured.
> 
> Best regards,
> Shunsuke

-- 
மணிவண்ணன் சதாசிவம்
