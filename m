Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F495911D4
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 16:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbiHLODA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 10:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbiHLOCy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 10:02:54 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBFDA2866
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 07:02:52 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id m10so664728qvu.4
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 07:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=Lmq1oz6ZC4m5awQCBsFC3VCq9hpAYJiCiT2XZrwkX+Q=;
        b=z6TOXBbOfd8v4yGLGKARzOV897DUwc1TWaAMeNGJ3+gp3LuG1/nfwIEP+Kh4LLM0Yk
         cCFh7r/zvTOuZHOkwdUu8aKP6pQVRaUq7q3856WuOb8WVtu8zAH/AujmLsq/BgpXYXZr
         U8eUql3Y5XlQ1uC91Wi3hFbc20EGkArw5ue3g3bSlykeQBKEEBHNsorxxgUkubyO0msG
         FnLZdslK/kWjoXMmpWanf3gery901iKMbDKMEsqZoN6LV4xUAFDLzP5QC/ZkrqbgEG5Q
         jirQFgFrt11qBFBw8Be1fS///51kSF0bOG0cTMIsC4GWnMbb4lgwOzGxvUXE7uufUvlu
         Unlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=Lmq1oz6ZC4m5awQCBsFC3VCq9hpAYJiCiT2XZrwkX+Q=;
        b=2mtygXSON9uH2EEKhnPblGdJCGtIE2GC/ZIjSVGW4ju8NthPvpxHlXa98hFgrlv8Cy
         J1aN0wuSBjT+hhdWwjcpYukQHgAqkbzr05Gc+1rvDx4iT3T04XjYczakwxAit5cipVEv
         nuO543Wj6RpvYSidBP8LOoxTedWH1FRi3VnIizTIXJwIfuogh9cfZ0gXzl5PK4UK4/Eh
         ZOlbPOK/RdoufSjXcqaK3d3fD4QLD9I9m762jYox/NDNMgUwgR/+ocelPfccUhoshsm6
         52IYcN58E6gsBinWLu9RTEGAFykw9huDYR7op/mgYxwldqnegUKv5o3X4WK49rGnXMB9
         FiYQ==
X-Gm-Message-State: ACgBeo3x1wRzUyjfePRwBcBbPHSYNfjfakEf0t4eDylznq4RKNF58oFD
        29IewGRLdERvcjg+rmU3x7VdlQ==
X-Google-Smtp-Source: AA6agR6LoB/1BRoidSD4eFh2loreq6urV5VtZ4Z/dzeelaL7aUmOmo9Et0vW3bR4Mbywz0UPztHB3w==
X-Received: by 2002:ad4:4eeb:0:b0:474:8435:1508 with SMTP id dv11-20020ad44eeb000000b0047484351508mr3601983qvb.5.1660312971999;
        Fri, 12 Aug 2022 07:02:51 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id d1-20020a05622a100100b0034305a91aaesm1856742qte.83.2022.08.12.07.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 07:02:51 -0700 (PDT)
Date:   Fri, 12 Aug 2022 10:02:49 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     helgaas@kernel.org, kishon@ti.com, lorenzo.pieralisi@arm.com,
        kw@linux.com, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lznuaa@gmail.com, hongxing.zhu@nxp.com, dave.jiang@intel.com,
        allenbh@gmail.com, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 0/4] NTB function for PCIe RC to EP connection
Message-ID: <YvZdiWoWb6njBvEA@kudzu.us>
References: <20220222162355.32369-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220222162355.32369-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 22, 2022 at 10:23:51AM -0600, Frank Li wrote:
> This implement NTB function for PCIe EP to RC connections.
> The existed ntb epf need two PCI EPs and two PCI Host.
> 
> This just need EP to RC connections.
> 
>     ┌────────────┐         ┌─────────────────────────────────────┐
>     │            │         │                                     │
>     ├────────────┤         │                      ┌──────────────┤
>     │ NTB        │         │                      │ NTB          │
>     │ NetDev     │         │                      │ NetDev       │
>     ├────────────┤         │                      ├──────────────┤
>     │ NTB        │         │                      │ NTB          │
>     │ Transfer   │         │                      │ Transfer     │
>     ├────────────┤         │                      ├──────────────┤
>     │            │         │                      │              │
>     │  PCI NTB   │         │                      │              │
>     │    EPF     │         │                      │              │
>     │   Driver   │         │                      │ PCI Virtual  │
>     │            │         ├───────────────┐      │ NTB Driver   │
>     │            │         │ PCI EP NTB    │◄────►│              │
>     │            │         │  FN Driver    │      │              │
>     ├────────────┤         ├───────────────┤      ├──────────────┤
>     │            │         │               │      │              │
>     │  PCI BUS   │ ◄─────► │  PCI EP BUS   │      │  Virtual PCI │
>     │            │  PCI    │               │      │     BUS      │
>     └────────────┘         └───────────────┴──────┴──────────────┘
>         PCI RC                        PCI EP
> 
> 
> 
> Frank Li (4):
>   PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address
>   NTB: epf: Allow more flexibility in the memory BAR map method
>   PCI: endpoint: Support NTB transfer between RC and EP
>   Documentation: PCI: Add specification for the PCI vNTB function device
> 
>  Documentation/PCI/endpoint/index.rst          |    2 +
>  .../PCI/endpoint/pci-vntb-function.rst        |  126 ++
>  Documentation/PCI/endpoint/pci-vntb-howto.rst |  167 ++
>  drivers/ntb/hw/epf/ntb_hw_epf.c               |   48 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   |   10 +-
>  drivers/pci/endpoint/functions/Kconfig        |   11 +
>  drivers/pci/endpoint/functions/Makefile       |    1 +
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 1424 +++++++++++++++++
>  8 files changed, 1775 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/PCI/endpoint/pci-vntb-function.rst
>  create mode 100644 Documentation/PCI/endpoint/pci-vntb-howto.rst
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vntb.c
> 
> -- 
> 2.24.0.rc1
> 

Sorry for the extremely long delay in response.  This series has been
in my ntb-next branch for some time and will be in my pull request for
v5.20 which should be going out later today.

Thanks,
Jon
