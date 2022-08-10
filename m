Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB42558EDD1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Aug 2022 16:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiHJOED (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 10:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiHJODt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 10:03:49 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC9D6CD3B
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 07:03:47 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r22so12036627pgm.5
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=p8mtjx8JwOj09UK2SbqBNp9/cVRUkNodrG3vv7jXsbc=;
        b=r67rwasignVgPzllz4gI2jNUvcLyFJXgHkzyUSYHOq3j+Bm38y3AbJrg8u86pE3nTC
         0rwCLgLU42DNmUtDxIjz6pxzKKLctVrT9Mnfnh82ULGBWT5gjnW/YXW6csfzvNG4UvR3
         pZGslfBRq5nfwCfw4O+s3QcOJjOH1qIkXgiOIyY3pyjcoK2FQKfYxrXCI7QPtTWaLWzt
         eKwft6YPv+lj0SBcE9yefIqLjy6H+Rt8l1pH2RguvhU5Dt2nILS95fJxFVRjoVy8DlEH
         tSZCrVHxvnE8yGqrch4yOF3Sa+7ZNlSQiKI6cpL6mOAl3xSljzL4+aWAMRO2hEPOdFzg
         laIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=p8mtjx8JwOj09UK2SbqBNp9/cVRUkNodrG3vv7jXsbc=;
        b=5t06xXr58wLNJToUooGrQIAnzaLrsMxfaiM/dHWqCAlqBAEBRasJnx2udw2AGs76yC
         5pTRFXIGRYCay6Z7cKHNbB1quiILfxuPSygTbUleiGCdY5tJQyLbrYAdZZwmFMiu58Cu
         bcF/OQxxThnfBS3ddR1hG45AWQilZuKzQtg4vAMsFr89M3WJWXZ6inFka1CrBfczVHc2
         yBN2fsSgTHWMOlcNAVFjdLRzWyhjjdS0pBzGTlBddoNXRWDrQk91vS1m1Kv3lf99RZM7
         y2EfjCL4MfvBwjK65Z8/pw60Aff5tutohw9gXTL2NmVjnSou/7tiAPYxslEcAbX2zkPG
         GvKA==
X-Gm-Message-State: ACgBeo00UotZhIjUO4jwTGZTMGjuks2rOOObvAya0sK1aSuxxZ7VQ5Rc
        cHJaHMn9Rl17VLCnh12jb/YsA/VcFlScdA==
X-Google-Smtp-Source: AA6agR4OHVY8R26UHtWDV7yFoG5TWHXLzX/TJQITwX0M3Cbh5d9+pfZ4/9kCsPTDJpHQPSyN1vWMuQ==
X-Received: by 2002:a65:57c8:0:b0:41c:fa29:ae1d with SMTP id q8-20020a6557c8000000b0041cfa29ae1dmr22100855pgr.136.1660140227200;
        Wed, 10 Aug 2022 07:03:47 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090340cd00b0016dc6279ab8sm12772873pld.159.2022.08.10.07.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 07:03:46 -0700 (PDT)
Date:   Wed, 10 Aug 2022 07:03:44 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [REGRESSION] changes to driver_override parsing broke DPDK
 script
Message-ID: <20220810070344.1701f4a6@hermes.local>
In-Reply-To: <28388e27-e562-65cd-4663-977ea4ad51a0@linaro.org>
References: <20220809192102.GA1331186@bhelgaas>
        <af880c1a-cedd-181f-9b4d-2f1766312fc0@linaro.org>
        <28388e27-e562-65cd-4663-977ea4ad51a0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 10 Aug 2022 09:13:40 +0300
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 10/08/2022 08:54, Krzysztof Kozlowski wrote:
> > On 09/08/2022 22:21, Bjorn Helgaas wrote:  
> >> [+cc regressions list]
> >>
> >> 23d99baf9d72 appeared in v5.19-rc1.
> >>
> >> On Tue, Aug 09, 2022 at 11:29:43AM -0700, Stephen Hemminger wrote:  
> >>> This commit broke the driver override script in DPDK.
> >>> This is an API/ABI breakage, please revert or fix the commit.
> >>>
> >>> Report of problem:
> >>> http://mails.dpdk.org/archives/dev/2022-August/247794.html  
> > 
> > Thanks for the report. I'll take a look.
> >   
> 
> I could not find in the report (neither here) steps to reproduce it. Can
> you provide me some short description (what kernel options are required,
> what commands to run)?
> 
> I tried to run:
> $ usertools/dpdk-devbind.py --status
> $ usertools/dpdk-devbind.py --bind '0000:00:03.0'
> Error: No devices specified.
> 
> 
> Best regards,
> Krzysztof

To test, you need to be willing to have one network device disappear from
kernel. The bug is in the unbind step this is an example of it working
with 5.17 kernel.


~/DPDK/main $ ./usertools/dpdk-devbind.py --status

Network devices using kernel driver
===================================
0000:01:00.0 'Wi-Fi 6 AX200 2723' if=wlo1 drv=iwlwifi unused= 
0000:02:00.0 'RTL8125 2.5GbE Controller 8125' if=enp2s0 drv=r8169 unused= *Active*


~/DPDK/main $ sudo modprobe vfio-pci
~/DPDK/main $ sudo ./usertools/dpdk-devbind.py --bind=vfio-pci enp2s0
Warning: routing table indicates that interface 0000:02:00.0 is active. Not modifying
~/DPDK/main $ ip li set dev enp2s0 down
RTNETLINK answers: Operation not permitted
~/DPDK/main $ sudo ip li set dev enp2s0 down
~/DPDK/main $ sudo ./usertools/dpdk-devbind.py --bind=vfio-pci enp2s0
~/DPDK/main $ ./usertools/dpdk-devbind.py --status

Network devices using DPDK-compatible driver
============================================
0000:02:00.0 'RTL8125 2.5GbE Controller 8125' drv=vfio-pci unused=r8169

Network devices using kernel driver
===================================
0000:01:00.0 'Wi-Fi 6 AX200 2723' if=wlo1 drv=iwlwifi unused=vfio-pci 


~/DPDK/main $ sudo ./usertools/dpdk-devbind.py -u 0000:02:00.0
~/DPDK/main $ ./usertools/dpdk-devbind.py --status

Network devices using kernel driver
===================================
0000:01:00.0 'Wi-Fi 6 AX200 2723' if=wlo1 drv=iwlwifi unused=vfio-pci 

Other Network devices
=====================
0000:02:00.0 'RTL8125 2.5GbE Controller 8125' unused=r8169,vfio-pci

